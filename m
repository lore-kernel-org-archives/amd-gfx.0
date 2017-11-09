From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] drm/amdkfd: CWSR and trap handler support
Date: Wed,  8 Nov 2017 21:29:01 -0500
Message-ID: <1510194541-4919-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1781479148=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, "Shaoyun . liu" <shaoyun.liu-5C7GfCeVMHo@public.gmane.org>

--===============1781479148==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: shaoyunl <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

CWSR = compute wave save restore

This hardware feature allows the GPU to preempt shader execution in
the middle of a compute wave, save the state and restore it later
to resume execution.

This feature requires help from a trap handler, which is like an
interrupt handler running on the compute unit. The trap handler is
written mostly by the hardware team. It's provided as pre-compiled
shader code with the SP3 assembly source code as reference.

Memory for saving the state is allocated per queue in user mode and
the address and size passed to the create_queue ioctl. The size
depends on the number of waves that can be in flight simultaneously
on a given ASIC.

A second-level user mode trap handler can be installed. The CWSR trap
handler jumps to the secondary trap handler conditionally for any
conditions not handled by it. This can be used e.g. for debugging or
catching math exceptions.

Signed-off-by: Shaoyun.liu <shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  | 1384 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   44 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   24 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   28 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    5 +
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    4 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   27 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   31 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   89 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    4 +-
 include/uapi/linux/kfd_ioctl.h                     |   15 +-
 11 files changed, 1644 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm
new file mode 100644
index 0000000..751cc2e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm
@@ -0,0 +1,1384 @@
+/*
+ * Copyright 2015-2017 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#if 0
+HW (VI) source code for CWSR trap handler
+#Version 18 + multiple trap handler
+
+// this performance-optimal version was originally from Seven Xu at SRDC
+
+// Revison #18   --...
+/* Rev History
+** #1. Branch from gc dv.   //gfxip/gfx8/main/src/test/suites/block/cs/sr/cs_trap_handler.sp3#1,#50, #51, #52-53(Skip, Already Fixed by PV), #54-56(merged),#57-58(mergerd, skiped-already fixed by PV)
+** #4. SR Memory Layout:
+**             1. VGPR-SGPR-HWREG-{LDS}
+**             2. tba_hi.bits.26 - reconfigured as the first wave in tg bits, for defer Save LDS for a threadgroup.. performance concern..
+** #5. Update: 1. Accurate g8sr_ts_save_d timestamp
+** #6. Update: 1. Fix s_barrier usage; 2. VGPR s/r using swizzle buffer?(NoNeed, already matched the swizzle pattern, more investigation)
+** #7. Update: 1. don't barrier if noLDS
+** #8. Branch: 1. Branch to ver#0, which is very similar to gc dv version
+**             2. Fix SQ issue by s_sleep 2
+** #9. Update: 1. Fix scc restore failed issue, restore wave_status at last
+**             2. optimize s_buffer save by burst 16sgprs...
+** #10. Update 1. Optimize restore sgpr by busrt 16 sgprs.
+** #11. Update 1. Add 2 more timestamp for debug version
+** #12. Update 1. Add VGPR SR using DWx4, some case improve and some case drop performance
+** #13. Integ  1. Always use MUBUF for PV trap shader...
+** #14. Update 1. s_buffer_store soft clause...
+** #15. Update 1. PERF - sclar write with glc:0/mtype0 to allow L2 combine. perf improvement a lot.
+** #16. Update 1. PRRF - UNROLL LDS_DMA got 2500cycle save in IP tree
+** #17. Update 1. FUNC - LDS_DMA has issues while ATC, replace with ds_read/buffer_store for save part[TODO restore part]
+**             2. PERF - Save LDS before save VGPR to cover LDS save long latency...
+** #18. Update 1. FUNC - Implicitly estore STATUS.VCCZ, which is not writable by s_setreg_b32
+**             2. FUNC - Handle non-CWSR traps
+*/
+
+var G8SR_WDMEM_HWREG_OFFSET = 0
+var G8SR_WDMEM_SGPR_OFFSET  = 128  // in bytes
+
+// Keep definition same as the app shader, These 2 time stamps are part of the app shader... Should before any Save and after restore.
+
+var G8SR_DEBUG_TIMESTAMP = 0
+var G8SR_DEBUG_TS_SAVE_D_OFFSET = 40*4  // ts_save_d timestamp offset relative to SGPR_SR_memory_offset
+var s_g8sr_ts_save_s    = s[34:35]   // save start
+var s_g8sr_ts_sq_save_msg  = s[36:37]   // The save shader send SAVEWAVE msg to spi
+var s_g8sr_ts_spi_wrexec   = s[38:39]   // the SPI write the sr address to SQ
+var s_g8sr_ts_save_d    = s[40:41]   // save end
+var s_g8sr_ts_restore_s = s[42:43]   // restore start
+var s_g8sr_ts_restore_d = s[44:45]   // restore end
+
+var G8SR_VGPR_SR_IN_DWX4 = 0
+var G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4 = 0x00100000    // DWx4 stride is 4*4Bytes
+var G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4  = G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4
+
+
+/*************************************************************************/
+/*                  control on how to run the shader                     */
+/*************************************************************************/
+//any hack that needs to be made to run this code in EMU (either becasue various EMU code are not ready or no compute save & restore in EMU run)
+var EMU_RUN_HACK                    =   0
+var EMU_RUN_HACK_RESTORE_NORMAL     =   0
+var EMU_RUN_HACK_SAVE_NORMAL_EXIT   =   0
+var EMU_RUN_HACK_SAVE_SINGLE_WAVE   =   0
+var EMU_RUN_HACK_SAVE_FIRST_TIME    =   0                   //for interrupted restore in which the first save is through EMU_RUN_HACK
+var EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_LO =   0                   //for interrupted restore in which the first save is through EMU_RUN_HACK
+var EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_HI =   0                   //for interrupted restore in which the first save is through EMU_RUN_HACK
+var SAVE_LDS                        =   1
+var WG_BASE_ADDR_LO                 =   0x9000a000
+var WG_BASE_ADDR_HI                 =   0x0
+var WAVE_SPACE                      =   0x5000              //memory size that each wave occupies in workgroup state mem
+var CTX_SAVE_CONTROL                =   0x0
+var CTX_RESTORE_CONTROL             =   CTX_SAVE_CONTROL
+var SIM_RUN_HACK                    =   0                   //any hack that needs to be made to run this code in SIM (either becasue various RTL code are not ready or no compute save & restore in RTL run)
+var SGPR_SAVE_USE_SQC               =   1                   //use SQC D$ to do the write
+var USE_MTBUF_INSTEAD_OF_MUBUF      =   0                   //becasue TC EMU curently asserts on 0 of // overload DFMT field to carry 4 more bits of stride for MUBUF opcodes
+var SWIZZLE_EN                      =   0                   //whether we use swizzled buffer addressing
+
+/**************************************************************************/
+/*                      variables                                         */
+/**************************************************************************/
+var SQ_WAVE_STATUS_INST_ATC_SHIFT  = 23
+var SQ_WAVE_STATUS_INST_ATC_MASK   = 0x00800000
+var SQ_WAVE_STATUS_SPI_PRIO_MASK   = 0x00000006
+
+var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT    = 12
+var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE     = 9
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT   = 8
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE    = 6
+var SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SHIFT   = 24
+var SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SIZE    = 3                     //FIXME  sq.blk still has 4 bits at this time while SQ programming guide has 3 bits
+
+var SQ_WAVE_TRAPSTS_SAVECTX_MASK    =   0x400
+var SQ_WAVE_TRAPSTS_EXCE_MASK       =   0x1FF                   // Exception mask
+var SQ_WAVE_TRAPSTS_SAVECTX_SHIFT   =   10
+var SQ_WAVE_TRAPSTS_MEM_VIOL_MASK   =   0x100
+var SQ_WAVE_TRAPSTS_MEM_VIOL_SHIFT  =   8
+var SQ_WAVE_TRAPSTS_PRE_SAVECTX_MASK    =   0x3FF
+var SQ_WAVE_TRAPSTS_PRE_SAVECTX_SHIFT   =   0x0
+var SQ_WAVE_TRAPSTS_PRE_SAVECTX_SIZE    =   10
+var SQ_WAVE_TRAPSTS_POST_SAVECTX_MASK   =   0xFFFFF800
+var SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT  =   11
+var SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE   =   21
+
+var SQ_WAVE_IB_STS_RCNT_SHIFT           =   16                  //FIXME
+var SQ_WAVE_IB_STS_RCNT_SIZE            =   4                   //FIXME
+var SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT   =   15                  //FIXME
+var SQ_WAVE_IB_STS_FIRST_REPLAY_SIZE    =   1                   //FIXME
+var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG   = 0x00007FFF    //FIXME
+
+var SQ_BUF_RSRC_WORD1_ATC_SHIFT     =   24
+var SQ_BUF_RSRC_WORD3_MTYPE_SHIFT   =   27
+
+
+/*      Save        */
+var S_SAVE_BUF_RSRC_WORD1_STRIDE        =   0x00040000          //stride is 4 bytes
+var S_SAVE_BUF_RSRC_WORD3_MISC          =   0x00807FAC          //SQ_SEL_X/Y/Z/W, BUF_NUM_FORMAT_FLOAT, (0 for MUBUF stride[17:14] when ADD_TID_ENABLE and BUF_DATA_FORMAT_32 for MTBUF), ADD_TID_ENABLE
+
+var S_SAVE_SPI_INIT_ATC_MASK            =   0x08000000          //bit[27]: ATC bit
+var S_SAVE_SPI_INIT_ATC_SHIFT           =   27
+var S_SAVE_SPI_INIT_MTYPE_MASK          =   0x70000000          //bit[30:28]: Mtype
+var S_SAVE_SPI_INIT_MTYPE_SHIFT         =   28
+var S_SAVE_SPI_INIT_FIRST_WAVE_MASK     =   0x04000000          //bit[26]: FirstWaveInTG
+var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT    =   26
+
+var S_SAVE_PC_HI_RCNT_SHIFT             =   28                  //FIXME  check with Brian to ensure all fields other than PC[47:0] can be used
+var S_SAVE_PC_HI_RCNT_MASK              =   0xF0000000          //FIXME
+var S_SAVE_PC_HI_FIRST_REPLAY_SHIFT     =   27                  //FIXME
+var S_SAVE_PC_HI_FIRST_REPLAY_MASK      =   0x08000000          //FIXME
+
+var s_save_spi_init_lo              =   exec_lo
+var s_save_spi_init_hi              =   exec_hi
+
+                                                //tba_lo and tba_hi need to be saved/restored
+var s_save_pc_lo            =   ttmp0           //{TTMP1, TTMP0} = {3¡¯h0,pc_rewind[3:0], HT[0],trapID[7:0], PC[47:0]}
+var s_save_pc_hi            =   ttmp1
+var s_save_exec_lo          =   ttmp2
+var s_save_exec_hi          =   ttmp3
+var s_save_status           =   ttmp4
+var s_save_trapsts          =   ttmp5           //not really used until the end of the SAVE routine
+var s_save_xnack_mask_lo    =   ttmp6
+var s_save_xnack_mask_hi    =   ttmp7
+var s_save_buf_rsrc0        =   ttmp8
+var s_save_buf_rsrc1        =   ttmp9
+var s_save_buf_rsrc2        =   ttmp10
+var s_save_buf_rsrc3        =   ttmp11
+
+var s_save_mem_offset       =   tma_lo
+var s_save_alloc_size       =   s_save_trapsts          //conflict
+var s_save_tmp              =   s_save_buf_rsrc2        //shared with s_save_buf_rsrc2  (conflict: should not use mem access with s_save_tmp at the same time)
+var s_save_m0               =   tma_hi
+
+/*      Restore     */
+var S_RESTORE_BUF_RSRC_WORD1_STRIDE         =   S_SAVE_BUF_RSRC_WORD1_STRIDE
+var S_RESTORE_BUF_RSRC_WORD3_MISC           =   S_SAVE_BUF_RSRC_WORD3_MISC
+
+var S_RESTORE_SPI_INIT_ATC_MASK             =   0x08000000          //bit[27]: ATC bit
+var S_RESTORE_SPI_INIT_ATC_SHIFT            =   27
+var S_RESTORE_SPI_INIT_MTYPE_MASK           =   0x70000000          //bit[30:28]: Mtype
+var S_RESTORE_SPI_INIT_MTYPE_SHIFT          =   28
+var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK      =   0x04000000          //bit[26]: FirstWaveInTG
+var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT     =   26
+
+var S_RESTORE_PC_HI_RCNT_SHIFT              =   S_SAVE_PC_HI_RCNT_SHIFT
+var S_RESTORE_PC_HI_RCNT_MASK               =   S_SAVE_PC_HI_RCNT_MASK
+var S_RESTORE_PC_HI_FIRST_REPLAY_SHIFT      =   S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
+var S_RESTORE_PC_HI_FIRST_REPLAY_MASK       =   S_SAVE_PC_HI_FIRST_REPLAY_MASK
+
+var s_restore_spi_init_lo                   =   exec_lo
+var s_restore_spi_init_hi                   =   exec_hi
+
+var s_restore_mem_offset        =   ttmp2
+var s_restore_alloc_size        =   ttmp3
+var s_restore_tmp               =   ttmp6               //tba_lo/hi need to be restored
+var s_restore_mem_offset_save   =   s_restore_tmp       //no conflict
+
+var s_restore_m0            =   s_restore_alloc_size    //no conflict
+
+var s_restore_mode          =   ttmp7
+
+var s_restore_pc_lo         =   ttmp0
+var s_restore_pc_hi         =   ttmp1
+var s_restore_exec_lo       =   tma_lo                  //no conflict
+var s_restore_exec_hi       =   tma_hi                  //no conflict
+var s_restore_status        =   ttmp4
+var s_restore_trapsts       =   ttmp5
+var s_restore_xnack_mask_lo =   xnack_mask_lo
+var s_restore_xnack_mask_hi =   xnack_mask_hi
+var s_restore_buf_rsrc0     =   ttmp8
+var s_restore_buf_rsrc1     =   ttmp9
+var s_restore_buf_rsrc2     =   ttmp10
+var s_restore_buf_rsrc3     =   ttmp11
+
+/**************************************************************************/
+/*                      trap handler entry points                         */
+/**************************************************************************/
+/* Shader Main*/
+
+shader main
+  asic(VI)
+  type(CS)
+
+
+    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))                   //hack to use trap_id for determining save/restore
+        //FIXME VCCZ un-init assertion s_getreg_b32     s_save_status, hwreg(HW_REG_STATUS)         //save STATUS since we will change SCC
+        s_and_b32 s_save_tmp, s_save_pc_hi, 0xffff0000              //change SCC
+        s_cmp_eq_u32 s_save_tmp, 0x007e0000                         //Save: trap_id = 0x7e. Restore: trap_id = 0x7f.
+        s_cbranch_scc0 L_JUMP_TO_RESTORE                            //do not need to recover STATUS here  since we are going to RESTORE
+        //FIXME  s_setreg_b32   hwreg(HW_REG_STATUS),   s_save_status       //need to recover STATUS since we are going to SAVE
+        s_branch L_SKIP_RESTORE                                     //NOT restore, SAVE actually
+    else
+        s_branch L_SKIP_RESTORE                                     //NOT restore. might be a regular trap or save
+    end
+
+L_JUMP_TO_RESTORE:
+    s_branch L_RESTORE                                              //restore
+
+L_SKIP_RESTORE:
+
+    s_getreg_b32    s_save_status, hwreg(HW_REG_STATUS)                             //save STATUS since we will change SCC
+    s_andn2_b32     s_save_status, s_save_status, SQ_WAVE_STATUS_SPI_PRIO_MASK      //check whether this is for save
+    s_getreg_b32    s_save_trapsts, hwreg(HW_REG_TRAPSTS)
+    s_and_b32       s_save_trapsts, s_save_trapsts, SQ_WAVE_TRAPSTS_SAVECTX_MASK    //check whether this is for save
+    s_cbranch_scc1  L_SAVE                                      //this is the operation for save
+
+    // *********    Handle non-CWSR traps       *******************
+if (!EMU_RUN_HACK)
+    /* read tba and tma for next level trap handler, ttmp4 is used as s_save_status */
+    s_load_dwordx4  [ttmp8,ttmp9,ttmp10, ttmp11], [tma_lo,tma_hi], 0
+    s_waitcnt lgkmcnt(0)
+    s_or_b32        ttmp7, ttmp8, ttmp9
+    s_cbranch_scc0  L_NO_NEXT_TRAP //next level trap handler not been set
+    s_setreg_b32    hwreg(HW_REG_STATUS), s_save_status //restore HW status(SCC)
+    s_setpc_b64     [ttmp8,ttmp9] //jump to next level trap handler
+
+L_NO_NEXT_TRAP:
+    s_getreg_b32    s_save_trapsts, hwreg(HW_REG_TRAPSTS)
+    s_and_b32       s_save_trapsts, s_save_trapsts, SQ_WAVE_TRAPSTS_EXCE_MASK // Check whether it is an exception
+    s_cbranch_scc1  L_EXCP_CASE   // Exception, jump back to the shader program directly.
+    s_add_u32       ttmp0, ttmp0, 4   // S_TRAP case, add 4 to ttmp0
+    s_addc_u32  ttmp1, ttmp1, 0
+L_EXCP_CASE:
+    s_and_b32   ttmp1, ttmp1, 0xFFFF
+    s_setreg_b32    hwreg(HW_REG_STATUS), s_save_status //restore HW status(SCC)
+    s_rfe_b64       [ttmp0, ttmp1]
+end
+    // *********        End handling of non-CWSR traps   *******************
+
+/**************************************************************************/
+/*                      save routine                                      */
+/**************************************************************************/
+
+L_SAVE:
+
+if G8SR_DEBUG_TIMESTAMP
+        s_memrealtime   s_g8sr_ts_save_s
+        s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
+end
+
+    //check whether there is mem_viol
+    s_getreg_b32    s_save_trapsts, hwreg(HW_REG_TRAPSTS)
+    s_and_b32   s_save_trapsts, s_save_trapsts, SQ_WAVE_TRAPSTS_MEM_VIOL_MASK
+    s_cbranch_scc0  L_NO_PC_REWIND
+
+    //if so, need rewind PC assuming GDS operation gets NACKed
+    s_mov_b32       s_save_tmp, 0                                                           //clear mem_viol bit
+    s_setreg_b32    hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_MEM_VIOL_SHIFT, 1), s_save_tmp    //clear mem_viol bit
+    s_and_b32       s_save_pc_hi, s_save_pc_hi, 0x0000ffff    //pc[47:32]
+    s_sub_u32       s_save_pc_lo, s_save_pc_lo, 8             //pc[31:0]-8
+    s_subb_u32      s_save_pc_hi, s_save_pc_hi, 0x0           // -scc
+
+L_NO_PC_REWIND:
+    s_mov_b32       s_save_tmp, 0                                                           //clear saveCtx bit
+    s_setreg_b32    hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_SAVECTX_SHIFT, 1), s_save_tmp     //clear saveCtx bit
+
+    s_mov_b32       s_save_xnack_mask_lo,   xnack_mask_lo                                   //save XNACK_MASK
+    s_mov_b32       s_save_xnack_mask_hi,   xnack_mask_hi    //save XNACK must before any memory operation
+    s_getreg_b32    s_save_tmp, hwreg(HW_REG_IB_STS, SQ_WAVE_IB_STS_RCNT_SHIFT, SQ_WAVE_IB_STS_RCNT_SIZE)                   //save RCNT
+    s_lshl_b32      s_save_tmp, s_save_tmp, S_SAVE_PC_HI_RCNT_SHIFT
+    s_or_b32        s_save_pc_hi, s_save_pc_hi, s_save_tmp
+    s_getreg_b32    s_save_tmp, hwreg(HW_REG_IB_STS, SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT, SQ_WAVE_IB_STS_FIRST_REPLAY_SIZE)   //save FIRST_REPLAY
+    s_lshl_b32      s_save_tmp, s_save_tmp, S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
+    s_or_b32        s_save_pc_hi, s_save_pc_hi, s_save_tmp
+    s_getreg_b32    s_save_tmp, hwreg(HW_REG_IB_STS)                                        //clear RCNT and FIRST_REPLAY in IB_STS
+    s_and_b32       s_save_tmp, s_save_tmp, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG
+
+    s_setreg_b32    hwreg(HW_REG_IB_STS), s_save_tmp
+
+    /*      inform SPI the readiness and wait for SPI's go signal */
+    s_mov_b32       s_save_exec_lo, exec_lo                                                 //save EXEC and use EXEC for the go signal from SPI
+    s_mov_b32       s_save_exec_hi, exec_hi
+    s_mov_b64       exec,   0x0                                                             //clear EXEC to get ready to receive
+
+if G8SR_DEBUG_TIMESTAMP
+        s_memrealtime  s_g8sr_ts_sq_save_msg
+        s_waitcnt lgkmcnt(0)
+end
+
+    if (EMU_RUN_HACK)
+
+    else
+        s_sendmsg   sendmsg(MSG_SAVEWAVE)  //send SPI a message and wait for SPI's write to EXEC
+    end
+
+  L_SLEEP:
+    s_sleep 0x2                // sleep 1 (64clk) is not enough for 8 waves per SIMD, which will cause SQ hang, since the 7,8th wave could not get arbit to exec inst, while other waves are stuck into the sleep-loop and waiting for wrexec!=0
+
+    if (EMU_RUN_HACK)
+
+    else
+        s_cbranch_execz L_SLEEP
+    end
+
+if G8SR_DEBUG_TIMESTAMP
+        s_memrealtime  s_g8sr_ts_spi_wrexec
+        s_waitcnt lgkmcnt(0)
+end
+
+    /*      setup Resource Contants    */
+    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_SAVE_SINGLE_WAVE))
+        //calculate wd_addr using absolute thread id
+        v_readlane_b32 s_save_tmp, v9, 0
+        s_lshr_b32 s_save_tmp, s_save_tmp, 6
+        s_mul_i32 s_save_tmp, s_save_tmp, WAVE_SPACE
+        s_add_i32 s_save_spi_init_lo, s_save_tmp, WG_BASE_ADDR_LO
+        s_mov_b32 s_save_spi_init_hi, WG_BASE_ADDR_HI
+        s_and_b32 s_save_spi_init_hi, s_save_spi_init_hi, CTX_SAVE_CONTROL
+    else
+    end
+    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_SAVE_SINGLE_WAVE))
+        s_add_i32 s_save_spi_init_lo, s_save_tmp, WG_BASE_ADDR_LO
+        s_mov_b32 s_save_spi_init_hi, WG_BASE_ADDR_HI
+        s_and_b32 s_save_spi_init_hi, s_save_spi_init_hi, CTX_SAVE_CONTROL
+    else
+    end
+
+
+    s_mov_b32       s_save_buf_rsrc0,   s_save_spi_init_lo                                                      //base_addr_lo
+    s_and_b32       s_save_buf_rsrc1,   s_save_spi_init_hi, 0x0000FFFF                                          //base_addr_hi
+    s_or_b32        s_save_buf_rsrc1,   s_save_buf_rsrc1,  S_SAVE_BUF_RSRC_WORD1_STRIDE
+    s_mov_b32       s_save_buf_rsrc2,   0                                                                       //NUM_RECORDS initial value = 0 (in bytes) although not neccessarily inited
+    s_mov_b32       s_save_buf_rsrc3,   S_SAVE_BUF_RSRC_WORD3_MISC
+    s_and_b32       s_save_tmp,         s_save_spi_init_hi, S_SAVE_SPI_INIT_ATC_MASK
+    s_lshr_b32      s_save_tmp,         s_save_tmp, (S_SAVE_SPI_INIT_ATC_SHIFT-SQ_BUF_RSRC_WORD1_ATC_SHIFT)         //get ATC bit into position
+    s_or_b32        s_save_buf_rsrc3,   s_save_buf_rsrc3,  s_save_tmp                                           //or ATC
+    s_and_b32       s_save_tmp,         s_save_spi_init_hi, S_SAVE_SPI_INIT_MTYPE_MASK
+    s_lshr_b32      s_save_tmp,         s_save_tmp, (S_SAVE_SPI_INIT_MTYPE_SHIFT-SQ_BUF_RSRC_WORD3_MTYPE_SHIFT)     //get MTYPE bits into position
+    s_or_b32        s_save_buf_rsrc3,   s_save_buf_rsrc3,  s_save_tmp                                           //or MTYPE
+
+    //FIXME  right now s_save_m0/s_save_mem_offset use tma_lo/tma_hi  (might need to save them before using them?)
+    s_mov_b32       s_save_m0,          m0                                                                  //save M0
+
+    /*      global mem offset           */
+    s_mov_b32       s_save_mem_offset,  0x0                                                                     //mem offset initial value = 0
+
+
+
+
+    /*      save HW registers   */
+    //////////////////////////////
+
+  L_SAVE_HWREG:
+        // HWREG SR memory offset : size(VGPR)+size(SGPR)
+       get_vgpr_size_bytes(s_save_mem_offset)
+       get_sgpr_size_bytes(s_save_tmp)
+       s_add_u32 s_save_mem_offset, s_save_mem_offset, s_save_tmp
+
+
+    s_mov_b32       s_save_buf_rsrc2, 0x4                               //NUM_RECORDS   in bytes
+    if (SWIZZLE_EN)
+        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0                     //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_save_buf_rsrc2,  0x1000000                                //NUM_RECORDS in bytes
+    end
+
+
+    write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)                  //M0
+
+    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_SAVE_FIRST_TIME))
+        s_add_u32 s_save_pc_lo, s_save_pc_lo, 4             //pc[31:0]+4
+        s_addc_u32 s_save_pc_hi, s_save_pc_hi, 0x0          //carry bit over
+        s_mov_b32   tba_lo, EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_LO
+        s_mov_b32   tba_hi, EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_HI
+    end
+
+    write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0, s_save_mem_offset)                   //PC
+    write_hwreg_to_mem(s_save_pc_hi, s_save_buf_rsrc0, s_save_mem_offset)
+    write_hwreg_to_mem(s_save_exec_lo, s_save_buf_rsrc0, s_save_mem_offset)             //EXEC
+    write_hwreg_to_mem(s_save_exec_hi, s_save_buf_rsrc0, s_save_mem_offset)
+    write_hwreg_to_mem(s_save_status, s_save_buf_rsrc0, s_save_mem_offset)              //STATUS
+
+    //s_save_trapsts conflicts with s_save_alloc_size
+    s_getreg_b32    s_save_trapsts, hwreg(HW_REG_TRAPSTS)
+    write_hwreg_to_mem(s_save_trapsts, s_save_buf_rsrc0, s_save_mem_offset)             //TRAPSTS
+
+    write_hwreg_to_mem(s_save_xnack_mask_lo, s_save_buf_rsrc0, s_save_mem_offset)           //XNACK_MASK_LO
+    write_hwreg_to_mem(s_save_xnack_mask_hi, s_save_buf_rsrc0, s_save_mem_offset)           //XNACK_MASK_HI
+
+    //use s_save_tmp would introduce conflict here between s_save_tmp and s_save_buf_rsrc2
+    s_getreg_b32    s_save_m0, hwreg(HW_REG_MODE)                                                   //MODE
+    write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
+    write_hwreg_to_mem(tba_lo, s_save_buf_rsrc0, s_save_mem_offset)                     //TBA_LO
+    write_hwreg_to_mem(tba_hi, s_save_buf_rsrc0, s_save_mem_offset)                     //TBA_HI
+
+
+
+    /*      the first wave in the threadgroup    */
+        // save fist_wave bits in tba_hi unused bit.26
+    s_and_b32       s_save_tmp, s_save_spi_init_hi, S_SAVE_SPI_INIT_FIRST_WAVE_MASK     // extract fisrt wave bit
+    //s_or_b32        tba_hi, s_save_tmp, tba_hi                                        // save first wave bit to tba_hi.bits[26]
+    s_mov_b32        s_save_exec_hi, 0x0
+    s_or_b32         s_save_exec_hi, s_save_tmp, s_save_exec_hi                          // save first wave bit to s_save_exec_hi.bits[26]
+
+
+    /*          save SGPRs      */
+        // Save SGPR before LDS save, then the s0 to s4 can be used during LDS save...
+    //////////////////////////////
+
+    // SGPR SR memory offset : size(VGPR)
+    get_vgpr_size_bytes(s_save_mem_offset)
+    // TODO, change RSRC word to rearrange memory layout for SGPRS
+
+    s_getreg_b32    s_save_alloc_size, hwreg(HW_REG_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SIZE)               //spgr_size
+    s_add_u32       s_save_alloc_size, s_save_alloc_size, 1
+    s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 4                         //Number of SGPRs = (sgpr_size + 1) * 16   (non-zero value)
+
+    if (SGPR_SAVE_USE_SQC)
+        s_lshl_b32      s_save_buf_rsrc2,   s_save_alloc_size, 2                    //NUM_RECORDS in bytes
+    else
+        s_lshl_b32      s_save_buf_rsrc2,   s_save_alloc_size, 8                    //NUM_RECORDS in bytes (64 threads)
+    end
+
+    if (SWIZZLE_EN)
+        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0                     //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_save_buf_rsrc2,  0x1000000                                //NUM_RECORDS in bytes
+    end
+
+
+    // backup s_save_buf_rsrc0,1 to s_save_pc_lo/hi, since write_16sgpr_to_mem function will change the rsrc0
+    //s_mov_b64 s_save_pc_lo, s_save_buf_rsrc0
+    s_mov_b64 s_save_xnack_mask_lo, s_save_buf_rsrc0
+    s_add_u32 s_save_buf_rsrc0, s_save_buf_rsrc0, s_save_mem_offset
+    s_addc_u32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0
+
+    s_mov_b32       m0, 0x0                         //SGPR initial index value =0
+  L_SAVE_SGPR_LOOP:
+    // SGPR is allocated in 16 SGPR granularity
+    s_movrels_b64   s0, s0     //s0 = s[0+m0], s1 = s[1+m0]
+    s_movrels_b64   s2, s2     //s2 = s[2+m0], s3 = s[3+m0]
+    s_movrels_b64   s4, s4     //s4 = s[4+m0], s5 = s[5+m0]
+    s_movrels_b64   s6, s6     //s6 = s[6+m0], s7 = s[7+m0]
+    s_movrels_b64   s8, s8     //s8 = s[8+m0], s9 = s[9+m0]
+    s_movrels_b64   s10, s10   //s10 = s[10+m0], s11 = s[11+m0]
+    s_movrels_b64   s12, s12   //s12 = s[12+m0], s13 = s[13+m0]
+    s_movrels_b64   s14, s14   //s14 = s[14+m0], s15 = s[15+m0]
+
+    write_16sgpr_to_mem(s0, s_save_buf_rsrc0, s_save_mem_offset) //PV: the best performance should be using s_buffer_store_dwordx4
+    s_add_u32       m0, m0, 16                                                      //next sgpr index
+    s_cmp_lt_u32    m0, s_save_alloc_size                                           //scc = (m0 < s_save_alloc_size) ? 1 : 0
+    s_cbranch_scc1  L_SAVE_SGPR_LOOP                                    //SGPR save is complete?
+    // restore s_save_buf_rsrc0,1
+    //s_mov_b64 s_save_buf_rsrc0, s_save_pc_lo
+    s_mov_b64 s_save_buf_rsrc0, s_save_xnack_mask_lo
+
+
+
+
+    /*          save first 4 VGPR, then LDS save could use   */
+        // each wave will alloc 4 vgprs at least...
+    /////////////////////////////////////////////////////////////////////////////////////
+
+    s_mov_b32       s_save_mem_offset, 0
+    s_mov_b32       exec_lo, 0xFFFFFFFF                                             //need every thread from now on
+    s_mov_b32       exec_hi, 0xFFFFFFFF
+
+    if (SWIZZLE_EN)
+        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0                     //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_save_buf_rsrc2,  0x1000000                                //NUM_RECORDS in bytes
+    end
+
+
+    // VGPR Allocated in 4-GPR granularity
+
+if G8SR_VGPR_SR_IN_DWX4
+        // the const stride for DWx4 is 4*4 bytes
+        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset const stride to 0
+        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4  // const stride to 4*4 bytes
+
+        buffer_store_dwordx4 v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+
+        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset const stride to 0
+        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE  // reset const stride to 4 bytes
+else
+        buffer_store_dword v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+        buffer_store_dword v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1  offset:256
+        buffer_store_dword v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1  offset:256*2
+        buffer_store_dword v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1  offset:256*3
+end
+
+
+
+    /*          save LDS        */
+    //////////////////////////////
+
+  L_SAVE_LDS:
+
+        // Change EXEC to all threads...
+    s_mov_b32       exec_lo, 0xFFFFFFFF   //need every thread from now on
+    s_mov_b32       exec_hi, 0xFFFFFFFF
+
+    s_getreg_b32    s_save_alloc_size, hwreg(HW_REG_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)             //lds_size
+    s_and_b32       s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF                //lds_size is zero?
+    s_cbranch_scc0  L_SAVE_LDS_DONE                                                                            //no lds used? jump to L_SAVE_DONE
+
+    s_barrier               //LDS is used? wait for other waves in the same TG
+    //s_and_b32     s_save_tmp, tba_hi, S_SAVE_SPI_INIT_FIRST_WAVE_MASK                //exec is still used here
+    s_and_b32       s_save_tmp, s_save_exec_hi, S_SAVE_SPI_INIT_FIRST_WAVE_MASK                //exec is still used here
+    s_cbranch_scc0  L_SAVE_LDS_DONE
+
+        // first wave do LDS save;
+
+    s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 6                         //LDS size in dwords = lds_size * 64dw
+    s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 2                         //LDS size in bytes
+    s_mov_b32       s_save_buf_rsrc2,  s_save_alloc_size                            //NUM_RECORDS in bytes
+
+    // LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
+    //
+    get_vgpr_size_bytes(s_save_mem_offset)
+    get_sgpr_size_bytes(s_save_tmp)
+    s_add_u32  s_save_mem_offset, s_save_mem_offset, s_save_tmp
+    s_add_u32 s_save_mem_offset, s_save_mem_offset, get_hwreg_size_bytes()
+
+
+    if (SWIZZLE_EN)
+        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0       //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_save_buf_rsrc2,  0x1000000                  //NUM_RECORDS in bytes
+    end
+
+    s_mov_b32       m0, 0x0                                               //lds_offset initial value = 0
+
+
+var LDS_DMA_ENABLE = 0
+var UNROLL = 0
+if UNROLL==0 && LDS_DMA_ENABLE==1
+        s_mov_b32  s3, 256*2
+        s_nop 0
+        s_nop 0
+        s_nop 0
+  L_SAVE_LDS_LOOP:
+        //TODO: looks the 2 buffer_store/load clause for s/r will hurt performance.???
+    if (SAVE_LDS)     //SPI always alloc LDS space in 128DW granularity
+            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1            // first 64DW
+            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:256 // second 64DW
+    end
+
+    s_add_u32       m0, m0, s3                                          //every buffer_store_lds does 256 bytes
+    s_add_u32       s_save_mem_offset, s_save_mem_offset, s3                            //mem offset increased by 256 bytes
+    s_cmp_lt_u32    m0, s_save_alloc_size                                               //scc=(m0 < s_save_alloc_size) ? 1 : 0
+    s_cbranch_scc1  L_SAVE_LDS_LOOP                                                     //LDS save is complete?
+
+elsif LDS_DMA_ENABLE==1 && UNROLL==1 // UNROOL  , has ichace miss
+      // store from higest LDS address to lowest
+      s_mov_b32  s3, 256*2
+      s_sub_u32  m0, s_save_alloc_size, s3
+      s_add_u32 s_save_mem_offset, s_save_mem_offset, m0
+      s_lshr_b32 s_save_alloc_size, s_save_alloc_size, 9   // how many 128 trunks...
+      s_sub_u32 s_save_alloc_size, 128, s_save_alloc_size   // store from higheset addr to lowest
+      s_mul_i32 s_save_alloc_size, s_save_alloc_size, 6*4   // PC offset increment,  each LDS save block cost 6*4 Bytes instruction
+      s_add_u32 s_save_alloc_size, s_save_alloc_size, 3*4   //2is the below 2 inst...//s_addc and s_setpc
+      s_nop 0
+      s_nop 0
+      s_nop 0   //pad 3 dw to let LDS_DMA align with 64Bytes
+      s_getpc_b64 s[0:1]                              // reuse s[0:1], since s[0:1] already saved
+      s_add_u32   s0, s0,s_save_alloc_size
+      s_addc_u32  s1, s1, 0
+      s_setpc_b64 s[0:1]
+
+
+       for var i =0; i< 128; i++
+            // be careful to make here a 64Byte aligned address, which could improve performance...
+            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:0           // first 64DW
+            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:256           // second 64DW
+
+        if i!=127
+        s_sub_u32  m0, m0, s3      // use a sgpr to shrink 2DW-inst to 1DW inst to improve performance , i.e.  pack more LDS_DMA inst to one Cacheline
+            s_sub_u32  s_save_mem_offset, s_save_mem_offset,  s3
+            end
+       end
+
+else   // BUFFER_STORE
+      v_mbcnt_lo_u32_b32 v2, 0xffffffff, 0x0
+      v_mbcnt_hi_u32_b32 v3, 0xffffffff, v2     // tid
+      v_mul_i32_i24 v2, v3, 8   // tid*8
+      v_mov_b32 v3, 256*2
+      s_mov_b32 m0, 0x10000
+      s_mov_b32 s0, s_save_buf_rsrc3
+      s_and_b32 s_save_buf_rsrc3, s_save_buf_rsrc3, 0xFF7FFFFF    // disable add_tid
+      s_or_b32 s_save_buf_rsrc3, s_save_buf_rsrc3, 0x58000   //DFMT
+
+L_SAVE_LDS_LOOP_VECTOR:
+      ds_read_b64 v[0:1], v2    //x =LDS[a], byte address
+      s_waitcnt lgkmcnt(0)
+      buffer_store_dwordx2  v[0:1], v2, s_save_buf_rsrc0, s_save_mem_offset offen:1  glc:1  slc:1
+//      s_waitcnt vmcnt(0)
+      v_add_u32 v2, vcc[0:1], v2, v3
+      v_cmp_lt_u32 vcc[0:1], v2, s_save_alloc_size
+      s_cbranch_vccnz L_SAVE_LDS_LOOP_VECTOR
+
+      // restore rsrc3
+      s_mov_b32 s_save_buf_rsrc3, s0
+
+end
+
+L_SAVE_LDS_DONE:
+
+
+    /*          save VGPRs  - set the Rest VGPRs        */
+    //////////////////////////////////////////////////////////////////////////////////////
+  L_SAVE_VGPR:
+    // VGPR SR memory offset: 0
+    // TODO rearrange the RSRC words to use swizzle for VGPR save...
+
+    s_mov_b32       s_save_mem_offset, (0+256*4)                                    // for the rest VGPRs
+    s_mov_b32       exec_lo, 0xFFFFFFFF                                             //need every thread from now on
+    s_mov_b32       exec_hi, 0xFFFFFFFF
+
+    s_getreg_b32    s_save_alloc_size, hwreg(HW_REG_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)                   //vpgr_size
+    s_add_u32       s_save_alloc_size, s_save_alloc_size, 1
+    s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 2                         //Number of VGPRs = (vgpr_size + 1) * 4    (non-zero value)   //FIXME for GFX, zero is possible
+    s_lshl_b32      s_save_buf_rsrc2,  s_save_alloc_size, 8                         //NUM_RECORDS in bytes (64 threads*4)
+    if (SWIZZLE_EN)
+        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0                     //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_save_buf_rsrc2,  0x1000000                                //NUM_RECORDS in bytes
+    end
+
+
+    // VGPR Allocated in 4-GPR granularity
+
+if G8SR_VGPR_SR_IN_DWX4
+        // the const stride for DWx4 is 4*4 bytes
+        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset const stride to 0
+        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4  // const stride to 4*4 bytes
+
+        s_mov_b32         m0, 4     // skip first 4 VGPRs
+        s_cmp_lt_u32      m0, s_save_alloc_size
+        s_cbranch_scc0    L_SAVE_VGPR_LOOP_END      // no more vgprs
+
+        s_set_gpr_idx_on  m0, 0x1   // This will change M0
+        s_add_u32         s_save_alloc_size, s_save_alloc_size, 0x1000  // because above inst change m0
+L_SAVE_VGPR_LOOP:
+        v_mov_b32         v0, v0   // v0 = v[0+m0]
+        v_mov_b32         v1, v1
+        v_mov_b32         v2, v2
+        v_mov_b32         v3, v3
+
+
+        buffer_store_dwordx4 v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+        s_add_u32         m0, m0, 4
+        s_add_u32         s_save_mem_offset, s_save_mem_offset, 256*4
+        s_cmp_lt_u32      m0, s_save_alloc_size
+    s_cbranch_scc1  L_SAVE_VGPR_LOOP                                                //VGPR save is complete?
+    s_set_gpr_idx_off
+L_SAVE_VGPR_LOOP_END:
+
+        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset const stride to 0
+        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE  // reset const stride to 4 bytes
+else
+    // VGPR store using dw burst
+    s_mov_b32         m0, 0x4   //VGPR initial index value =0
+    s_cmp_lt_u32      m0, s_save_alloc_size
+    s_cbranch_scc0    L_SAVE_VGPR_END
+
+
+    s_set_gpr_idx_on    m0, 0x1 //M0[7:0] = M0[7:0] and M0[15:12] = 0x1
+    s_add_u32       s_save_alloc_size, s_save_alloc_size, 0x1000                    //add 0x1000 since we compare m0 against it later
+
+  L_SAVE_VGPR_LOOP:
+    v_mov_b32       v0, v0              //v0 = v[0+m0]
+    v_mov_b32       v1, v1              //v0 = v[0+m0]
+    v_mov_b32       v2, v2              //v0 = v[0+m0]
+    v_mov_b32       v3, v3              //v0 = v[0+m0]
+
+    if(USE_MTBUF_INSTEAD_OF_MUBUF)
+        tbuffer_store_format_x v0, v0, s_save_buf_rsrc0, s_save_mem_offset format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:1
+    else
+        buffer_store_dword v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+        buffer_store_dword v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1  offset:256
+        buffer_store_dword v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1  offset:256*2
+        buffer_store_dword v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1  offset:256*3
+    end
+
+    s_add_u32       m0, m0, 4                                                       //next vgpr index
+    s_add_u32       s_save_mem_offset, s_save_mem_offset, 256*4                     //every buffer_store_dword does 256 bytes
+    s_cmp_lt_u32    m0, s_save_alloc_size                                           //scc = (m0 < s_save_alloc_size) ? 1 : 0
+    s_cbranch_scc1  L_SAVE_VGPR_LOOP                                                //VGPR save is complete?
+    s_set_gpr_idx_off
+end
+
+L_SAVE_VGPR_END:
+
+
+
+
+
+
+    /*     S_PGM_END_SAVED  */                              //FIXME  graphics ONLY
+    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_SAVE_NORMAL_EXIT))
+        s_and_b32 s_save_pc_hi, s_save_pc_hi, 0x0000ffff    //pc[47:32]
+        s_add_u32 s_save_pc_lo, s_save_pc_lo, 4             //pc[31:0]+4
+        s_addc_u32 s_save_pc_hi, s_save_pc_hi, 0x0          //carry bit over
+        s_rfe_b64 s_save_pc_lo                              //Return to the main shader program
+    else
+    end
+
+// Save Done timestamp
+if G8SR_DEBUG_TIMESTAMP
+        s_memrealtime   s_g8sr_ts_save_d
+        // SGPR SR memory offset : size(VGPR)
+        get_vgpr_size_bytes(s_save_mem_offset)
+        s_add_u32 s_save_mem_offset, s_save_mem_offset, G8SR_DEBUG_TS_SAVE_D_OFFSET
+        s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
+        // Need reset rsrc2??
+        s_mov_b32 m0, s_save_mem_offset
+        s_mov_b32 s_save_buf_rsrc2,  0x1000000                                  //NUM_RECORDS in bytes
+        s_buffer_store_dwordx2 s_g8sr_ts_save_d, s_save_buf_rsrc0, m0       glc:1
+end
+
+
+    s_branch    L_END_PGM
+
+
+
+/**************************************************************************/
+/*                      restore routine                                   */
+/**************************************************************************/
+
+L_RESTORE:
+    /*      Setup Resource Contants    */
+    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))
+        //calculate wd_addr using absolute thread id
+        v_readlane_b32 s_restore_tmp, v9, 0
+        s_lshr_b32 s_restore_tmp, s_restore_tmp, 6
+        s_mul_i32 s_restore_tmp, s_restore_tmp, WAVE_SPACE
+        s_add_i32 s_restore_spi_init_lo, s_restore_tmp, WG_BASE_ADDR_LO
+        s_mov_b32 s_restore_spi_init_hi, WG_BASE_ADDR_HI
+        s_and_b32 s_restore_spi_init_hi, s_restore_spi_init_hi, CTX_RESTORE_CONTROL
+    else
+    end
+
+if G8SR_DEBUG_TIMESTAMP
+        s_memrealtime   s_g8sr_ts_restore_s
+        s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
+        // tma_lo/hi are sgpr 110, 111, which will not used for 112 SGPR allocated case...
+        s_mov_b32 s_restore_pc_lo, s_g8sr_ts_restore_s[0]
+        s_mov_b32 s_restore_pc_hi, s_g8sr_ts_restore_s[1]   //backup ts to ttmp0/1, sicne exec will be finally restored..
+end
+
+
+
+    s_mov_b32       s_restore_buf_rsrc0,    s_restore_spi_init_lo                                                           //base_addr_lo
+    s_and_b32       s_restore_buf_rsrc1,    s_restore_spi_init_hi, 0x0000FFFF                                               //base_addr_hi
+    s_or_b32        s_restore_buf_rsrc1,    s_restore_buf_rsrc1,  S_RESTORE_BUF_RSRC_WORD1_STRIDE
+    s_mov_b32       s_restore_buf_rsrc2,    0                                                                               //NUM_RECORDS initial value = 0 (in bytes)
+    s_mov_b32       s_restore_buf_rsrc3,    S_RESTORE_BUF_RSRC_WORD3_MISC
+    s_and_b32       s_restore_tmp,          s_restore_spi_init_hi, S_RESTORE_SPI_INIT_ATC_MASK
+    s_lshr_b32      s_restore_tmp,          s_restore_tmp, (S_RESTORE_SPI_INIT_ATC_SHIFT-SQ_BUF_RSRC_WORD1_ATC_SHIFT)       //get ATC bit into position
+    s_or_b32        s_restore_buf_rsrc3,    s_restore_buf_rsrc3,  s_restore_tmp                                             //or ATC
+    s_and_b32       s_restore_tmp,          s_restore_spi_init_hi, S_RESTORE_SPI_INIT_MTYPE_MASK
+    s_lshr_b32      s_restore_tmp,          s_restore_tmp, (S_RESTORE_SPI_INIT_MTYPE_SHIFT-SQ_BUF_RSRC_WORD3_MTYPE_SHIFT)   //get MTYPE bits into position
+    s_or_b32        s_restore_buf_rsrc3,    s_restore_buf_rsrc3,  s_restore_tmp                                             //or MTYPE
+
+    /*      global mem offset           */
+//  s_mov_b32       s_restore_mem_offset, 0x0                               //mem offset initial value = 0
+
+    /*      the first wave in the threadgroup    */
+    s_and_b32       s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
+    s_cbranch_scc0  L_RESTORE_VGPR
+
+    /*          restore LDS     */
+    //////////////////////////////
+  L_RESTORE_LDS:
+
+    s_mov_b32       exec_lo, 0xFFFFFFFF                                                     //need every thread from now on   //be consistent with SAVE although can be moved ahead
+    s_mov_b32       exec_hi, 0xFFFFFFFF
+
+    s_getreg_b32    s_restore_alloc_size, hwreg(HW_REG_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)              //lds_size
+    s_and_b32       s_restore_alloc_size, s_restore_alloc_size, 0xFFFFFFFF                  //lds_size is zero?
+    s_cbranch_scc0  L_RESTORE_VGPR                                                          //no lds used? jump to L_RESTORE_VGPR
+    s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 6                           //LDS size in dwords = lds_size * 64dw
+    s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 2                           //LDS size in bytes
+    s_mov_b32       s_restore_buf_rsrc2,    s_restore_alloc_size                            //NUM_RECORDS in bytes
+
+    // LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
+    //
+    get_vgpr_size_bytes(s_restore_mem_offset)
+    get_sgpr_size_bytes(s_restore_tmp)
+    s_add_u32  s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
+    s_add_u32  s_restore_mem_offset, s_restore_mem_offset, get_hwreg_size_bytes()            //FIXME, Check if offset overflow???
+
+
+    if (SWIZZLE_EN)
+        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0                       //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_restore_buf_rsrc2,  0x1000000                                     //NUM_RECORDS in bytes
+    end
+    s_mov_b32       m0, 0x0                                                                 //lds_offset initial value = 0
+
+  L_RESTORE_LDS_LOOP:
+    if (SAVE_LDS)
+        buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1                    // first 64DW
+        buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1 offset:256         // second 64DW
+    end
+    s_add_u32       m0, m0, 256*2                                               // 128 DW
+    s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256*2           //mem offset increased by 128DW
+    s_cmp_lt_u32    m0, s_restore_alloc_size                                    //scc=(m0 < s_restore_alloc_size) ? 1 : 0
+    s_cbranch_scc1  L_RESTORE_LDS_LOOP                                                      //LDS restore is complete?
+
+
+    /*          restore VGPRs       */
+    //////////////////////////////
+  L_RESTORE_VGPR:
+        // VGPR SR memory offset : 0
+    s_mov_b32       s_restore_mem_offset, 0x0
+    s_mov_b32       exec_lo, 0xFFFFFFFF                                                     //need every thread from now on   //be consistent with SAVE although can be moved ahead
+    s_mov_b32       exec_hi, 0xFFFFFFFF
+
+    s_getreg_b32    s_restore_alloc_size, hwreg(HW_REG_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)    //vpgr_size
+    s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 1
+    s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 2                           //Number of VGPRs = (vgpr_size + 1) * 4    (non-zero value)
+    s_lshl_b32      s_restore_buf_rsrc2,  s_restore_alloc_size, 8                           //NUM_RECORDS in bytes (64 threads*4)
+    if (SWIZZLE_EN)
+        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0                       //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_restore_buf_rsrc2,  0x1000000                                     //NUM_RECORDS in bytes
+    end
+
+if G8SR_VGPR_SR_IN_DWX4
+     get_vgpr_size_bytes(s_restore_mem_offset)
+     s_sub_u32         s_restore_mem_offset, s_restore_mem_offset, 256*4
+
+     // the const stride for DWx4 is 4*4 bytes
+     s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc1, 0x0000FFFF   // reset const stride to 0
+     s_or_b32  s_restore_buf_rsrc1, s_restore_buf_rsrc1, G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4  // const stride to 4*4 bytes
+
+     s_mov_b32         m0, s_restore_alloc_size
+     s_set_gpr_idx_on  m0, 0x8    // Note.. This will change m0
+
+L_RESTORE_VGPR_LOOP:
+     buffer_load_dwordx4 v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1
+     s_waitcnt vmcnt(0)
+     s_sub_u32         m0, m0, 4
+     v_mov_b32         v0, v0   // v[0+m0] = v0
+     v_mov_b32         v1, v1
+     v_mov_b32         v2, v2
+     v_mov_b32         v3, v3
+     s_sub_u32         s_restore_mem_offset, s_restore_mem_offset, 256*4
+     s_cmp_eq_u32      m0, 0x8000
+     s_cbranch_scc0    L_RESTORE_VGPR_LOOP
+     s_set_gpr_idx_off
+
+     s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc1, 0x0000FFFF   // reset const stride to 0
+     s_or_b32  s_restore_buf_rsrc1, s_restore_buf_rsrc1, S_RESTORE_BUF_RSRC_WORD1_STRIDE  // const stride to 4*4 bytes
+
+else
+    // VGPR load using dw burst
+    s_mov_b32       s_restore_mem_offset_save, s_restore_mem_offset     // restore start with v1, v0 will be the last
+    s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256*4
+    s_mov_b32       m0, 4                               //VGPR initial index value = 1
+    s_set_gpr_idx_on  m0, 0x8                       //M0[7:0] = M0[7:0] and M0[15:12] = 0x8
+    s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 0x8000                      //add 0x8000 since we compare m0 against it later
+
+  L_RESTORE_VGPR_LOOP:
+    if(USE_MTBUF_INSTEAD_OF_MUBUF)
+        tbuffer_load_format_x v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:1
+    else
+        buffer_load_dword v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1
+        buffer_load_dword v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256
+        buffer_load_dword v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*2
+        buffer_load_dword v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*3
+    end
+    s_waitcnt       vmcnt(0)                                                                //ensure data ready
+    v_mov_b32       v0, v0                                                                  //v[0+m0] = v0
+    v_mov_b32       v1, v1
+    v_mov_b32       v2, v2
+    v_mov_b32       v3, v3
+    s_add_u32       m0, m0, 4                                                               //next vgpr index
+    s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256*4                           //every buffer_load_dword does 256 bytes
+    s_cmp_lt_u32    m0, s_restore_alloc_size                                                //scc = (m0 < s_restore_alloc_size) ? 1 : 0
+    s_cbranch_scc1  L_RESTORE_VGPR_LOOP                                                     //VGPR restore (except v0) is complete?
+    s_set_gpr_idx_off
+                                                                                            /* VGPR restore on v0 */
+    if(USE_MTBUF_INSTEAD_OF_MUBUF)
+        tbuffer_load_format_x v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:1
+    else
+        buffer_load_dword v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save    slc:1 glc:1
+        buffer_load_dword v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save    slc:1 glc:1 offset:256
+        buffer_load_dword v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save    slc:1 glc:1 offset:256*2
+        buffer_load_dword v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save    slc:1 glc:1 offset:256*3
+    end
+
+end
+
+    /*          restore SGPRs       */
+    //////////////////////////////
+
+    // SGPR SR memory offset : size(VGPR)
+    get_vgpr_size_bytes(s_restore_mem_offset)
+    get_sgpr_size_bytes(s_restore_tmp)
+    s_add_u32 s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
+    s_sub_u32 s_restore_mem_offset, s_restore_mem_offset, 16*4     // restore SGPR from S[n] to S[0], by 16 sgprs group
+    // TODO, change RSRC word to rearrange memory layout for SGPRS
+
+    s_getreg_b32    s_restore_alloc_size, hwreg(HW_REG_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SIZE)                //spgr_size
+    s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 1
+    s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 4                           //Number of SGPRs = (sgpr_size + 1) * 16   (non-zero value)
+
+    if (SGPR_SAVE_USE_SQC)
+        s_lshl_b32      s_restore_buf_rsrc2,    s_restore_alloc_size, 2                     //NUM_RECORDS in bytes
+    else
+        s_lshl_b32      s_restore_buf_rsrc2,    s_restore_alloc_size, 8                     //NUM_RECORDS in bytes (64 threads)
+    end
+    if (SWIZZLE_EN)
+        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0                       //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_restore_buf_rsrc2,  0x1000000                                     //NUM_RECORDS in bytes
+    end
+
+    /* If 112 SGPRs ar allocated, 4 sgprs are not used TBA(108,109),TMA(110,111),
+       However, we are safe to restore these 4 SGPRs anyway, since TBA,TMA will later be restored by HWREG
+    */
+    s_mov_b32 m0, s_restore_alloc_size
+
+ L_RESTORE_SGPR_LOOP:
+    read_16sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)  //PV: further performance improvement can be made
+    s_waitcnt       lgkmcnt(0)                                                              //ensure data ready
+
+    s_sub_u32 m0, m0, 16    // Restore from S[n] to S[0]
+
+    s_movreld_b64   s0, s0      //s[0+m0] = s0
+    s_movreld_b64   s2, s2
+    s_movreld_b64   s4, s4
+    s_movreld_b64   s6, s6
+    s_movreld_b64   s8, s8
+    s_movreld_b64   s10, s10
+    s_movreld_b64   s12, s12
+    s_movreld_b64   s14, s14
+
+    s_cmp_eq_u32    m0, 0               //scc = (m0 < s_restore_alloc_size) ? 1 : 0
+    s_cbranch_scc0  L_RESTORE_SGPR_LOOP             //SGPR restore (except s0) is complete?
+
+    /*      restore HW registers    */
+    //////////////////////////////
+  L_RESTORE_HWREG:
+
+
+if G8SR_DEBUG_TIMESTAMP
+      s_mov_b32 s_g8sr_ts_restore_s[0], s_restore_pc_lo
+      s_mov_b32 s_g8sr_ts_restore_s[1], s_restore_pc_hi
+end
+
+    // HWREG SR memory offset : size(VGPR)+size(SGPR)
+    get_vgpr_size_bytes(s_restore_mem_offset)
+    get_sgpr_size_bytes(s_restore_tmp)
+    s_add_u32 s_restore_mem_offset, s_restore_mem_offset, s_restore_tmp
+
+
+    s_mov_b32       s_restore_buf_rsrc2, 0x4                                                //NUM_RECORDS   in bytes
+    if (SWIZZLE_EN)
+        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0                       //FIXME need to use swizzle to enable bounds checking?
+    else
+        s_mov_b32       s_restore_buf_rsrc2,  0x1000000                                     //NUM_RECORDS in bytes
+    end
+
+    read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0, s_restore_mem_offset)                    //M0
+    read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0, s_restore_mem_offset)             //PC
+    read_hwreg_from_mem(s_restore_pc_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
+    read_hwreg_from_mem(s_restore_exec_lo, s_restore_buf_rsrc0, s_restore_mem_offset)               //EXEC
+    read_hwreg_from_mem(s_restore_exec_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
+    read_hwreg_from_mem(s_restore_status, s_restore_buf_rsrc0, s_restore_mem_offset)                //STATUS
+    read_hwreg_from_mem(s_restore_trapsts, s_restore_buf_rsrc0, s_restore_mem_offset)               //TRAPSTS
+    read_hwreg_from_mem(xnack_mask_lo, s_restore_buf_rsrc0, s_restore_mem_offset)                   //XNACK_MASK_LO
+    read_hwreg_from_mem(xnack_mask_hi, s_restore_buf_rsrc0, s_restore_mem_offset)                   //XNACK_MASK_HI
+    read_hwreg_from_mem(s_restore_mode, s_restore_buf_rsrc0, s_restore_mem_offset)              //MODE
+    read_hwreg_from_mem(tba_lo, s_restore_buf_rsrc0, s_restore_mem_offset)                      //TBA_LO
+    read_hwreg_from_mem(tba_hi, s_restore_buf_rsrc0, s_restore_mem_offset)                      //TBA_HI
+
+    s_waitcnt       lgkmcnt(0)                                                                                      //from now on, it is safe to restore STATUS and IB_STS
+
+    s_and_b32 s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff      //pc[47:32]        //Do it here in order not to affect STATUS
+
+    //for normal save & restore, the saved PC points to the next inst to execute, no adjustment needs to be made, otherwise:
+    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))
+        s_add_u32 s_restore_pc_lo, s_restore_pc_lo, 8            //pc[31:0]+8     //two back-to-back s_trap are used (first for save and second for restore)
+        s_addc_u32  s_restore_pc_hi, s_restore_pc_hi, 0x0        //carry bit over
+    end
+    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_RESTORE_NORMAL))
+        s_add_u32 s_restore_pc_lo, s_restore_pc_lo, 4            //pc[31:0]+4     // save is hack through s_trap but restore is normal
+        s_addc_u32  s_restore_pc_hi, s_restore_pc_hi, 0x0        //carry bit over
+    end
+
+    s_mov_b32       m0,         s_restore_m0
+    s_mov_b32       exec_lo,    s_restore_exec_lo
+    s_mov_b32       exec_hi,    s_restore_exec_hi
+
+    s_and_b32       s_restore_m0, SQ_WAVE_TRAPSTS_PRE_SAVECTX_MASK, s_restore_trapsts
+    s_setreg_b32    hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_PRE_SAVECTX_SHIFT, SQ_WAVE_TRAPSTS_PRE_SAVECTX_SIZE), s_restore_m0
+    s_and_b32       s_restore_m0, SQ_WAVE_TRAPSTS_POST_SAVECTX_MASK, s_restore_trapsts
+    s_lshr_b32      s_restore_m0, s_restore_m0, SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT
+    s_setreg_b32    hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT, SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE), s_restore_m0
+    //s_setreg_b32  hwreg(HW_REG_TRAPSTS),  s_restore_trapsts      //don't overwrite SAVECTX bit as it may be set through external SAVECTX during restore
+    s_setreg_b32    hwreg(HW_REG_MODE),     s_restore_mode
+    //reuse s_restore_m0 as a temp register
+    s_and_b32       s_restore_m0, s_restore_pc_hi, S_SAVE_PC_HI_RCNT_MASK
+    s_lshr_b32      s_restore_m0, s_restore_m0, S_SAVE_PC_HI_RCNT_SHIFT
+    s_lshl_b32      s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_RCNT_SHIFT
+    s_mov_b32       s_restore_tmp, 0x0                                                                              //IB_STS is zero
+    s_or_b32        s_restore_tmp, s_restore_tmp, s_restore_m0
+    s_and_b32       s_restore_m0, s_restore_pc_hi, S_SAVE_PC_HI_FIRST_REPLAY_MASK
+    s_lshr_b32      s_restore_m0, s_restore_m0, S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
+    s_lshl_b32      s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT
+    s_or_b32        s_restore_tmp, s_restore_tmp, s_restore_m0
+    s_and_b32       s_restore_m0, s_restore_status, SQ_WAVE_STATUS_INST_ATC_MASK
+    s_lshr_b32      s_restore_m0, s_restore_m0, SQ_WAVE_STATUS_INST_ATC_SHIFT
+    s_setreg_b32    hwreg(HW_REG_IB_STS),   s_restore_tmp
+
+    s_and_b64    exec, exec, exec  // Restore STATUS.EXECZ, not writable by s_setreg_b32
+    s_and_b64    vcc, vcc, vcc  // Restore STATUS.VCCZ, not writable by s_setreg_b32
+    s_setreg_b32    hwreg(HW_REG_STATUS),   s_restore_status     // SCC is included, which is changed by previous salu
+
+    s_barrier                                                   //barrier to ensure the readiness of LDS before access attemps from any other wave in the same TG //FIXME not performance-optimal at this time
+
+if G8SR_DEBUG_TIMESTAMP
+    s_memrealtime s_g8sr_ts_restore_d
+    s_waitcnt lgkmcnt(0)
+end
+
+//  s_rfe_b64 s_restore_pc_lo                                   //Return to the main shader program and resume execution
+    s_rfe_restore_b64  s_restore_pc_lo, s_restore_m0            // s_restore_m0[0] is used to set STATUS.inst_atc
+
+
+/**************************************************************************/
+/*                      the END                                           */
+/**************************************************************************/
+L_END_PGM:
+    s_endpgm
+
+end
+
+
+/**************************************************************************/
+/*                      the helper functions                              */
+/**************************************************************************/
+
+//Only for save hwreg to mem
+function write_hwreg_to_mem(s, s_rsrc, s_mem_offset)
+        s_mov_b32 exec_lo, m0                   //assuming exec_lo is not needed anymore from this point on
+        s_mov_b32 m0, s_mem_offset
+        s_buffer_store_dword s, s_rsrc, m0      glc:1
+        s_add_u32       s_mem_offset, s_mem_offset, 4
+        s_mov_b32   m0, exec_lo
+end
+
+
+// HWREG are saved before SGPRs, so all HWREG could be use.
+function write_16sgpr_to_mem(s, s_rsrc, s_mem_offset)
+
+        s_buffer_store_dwordx4 s[0], s_rsrc, 0  glc:1
+        s_buffer_store_dwordx4 s[4], s_rsrc, 16  glc:1
+        s_buffer_store_dwordx4 s[8], s_rsrc, 32  glc:1
+        s_buffer_store_dwordx4 s[12], s_rsrc, 48 glc:1
+        s_add_u32       s_rsrc[0], s_rsrc[0], 4*16
+        s_addc_u32      s_rsrc[1], s_rsrc[1], 0x0             // +scc
+end
+
+
+function read_hwreg_from_mem(s, s_rsrc, s_mem_offset)
+    s_buffer_load_dword s, s_rsrc, s_mem_offset     glc:1
+    s_add_u32       s_mem_offset, s_mem_offset, 4
+end
+
+function read_16sgpr_from_mem(s, s_rsrc, s_mem_offset)
+    s_buffer_load_dwordx16 s, s_rsrc, s_mem_offset      glc:1
+    s_sub_u32       s_mem_offset, s_mem_offset, 4*16
+end
+
+
+
+function get_lds_size_bytes(s_lds_size_byte)
+    // SQ LDS granularity is 64DW, while PGM_RSRC2.lds_size is in granularity 128DW
+    s_getreg_b32   s_lds_size_byte, hwreg(HW_REG_LDS_ALLOC, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)          // lds_size
+    s_lshl_b32     s_lds_size_byte, s_lds_size_byte, 8                      //LDS size in dwords = lds_size * 64 *4Bytes    // granularity 64DW
+end
+
+function get_vgpr_size_bytes(s_vgpr_size_byte)
+    s_getreg_b32   s_vgpr_size_byte, hwreg(HW_REG_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)  //vpgr_size
+    s_add_u32      s_vgpr_size_byte, s_vgpr_size_byte, 1
+    s_lshl_b32     s_vgpr_size_byte, s_vgpr_size_byte, (2+8) //Number of VGPRs = (vgpr_size + 1) * 4 * 64 * 4   (non-zero value)   //FIXME for GFX, zero is possible
+end
+
+function get_sgpr_size_bytes(s_sgpr_size_byte)
+    s_getreg_b32   s_sgpr_size_byte, hwreg(HW_REG_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_SGPR_SIZE_SIZE)  //spgr_size
+    s_add_u32      s_sgpr_size_byte, s_sgpr_size_byte, 1
+    s_lshl_b32     s_sgpr_size_byte, s_sgpr_size_byte, 6 //Number of SGPRs = (sgpr_size + 1) * 16 *4   (non-zero value)
+end
+
+function get_hwreg_size_bytes
+    return 128 //HWREG size 128 bytes
+end
+
+
+#endif
+
+static const uint32_t cwsr_trap_gfx8_hex[] = {
+	0xbf820001, 0xbf820123,
+	0xb8f4f802, 0x89748674,
+	0xb8f5f803, 0x8675ff75,
+	0x00000400, 0xbf850011,
+	0xc00a1e37, 0x00000000,
+	0xbf8c007f, 0x87777978,
+	0xbf840002, 0xb974f802,
+	0xbe801d78, 0xb8f5f803,
+	0x8675ff75, 0x000001ff,
+	0xbf850002, 0x80708470,
+	0x82718071, 0x8671ff71,
+	0x0000ffff, 0xb974f802,
+	0xbe801f70, 0xb8f5f803,
+	0x8675ff75, 0x00000100,
+	0xbf840006, 0xbefa0080,
+	0xb97a0203, 0x8671ff71,
+	0x0000ffff, 0x80f08870,
+	0x82f18071, 0xbefa0080,
+	0xb97a0283, 0xbef60068,
+	0xbef70069, 0xb8fa1c07,
+	0x8e7a9c7a, 0x87717a71,
+	0xb8fa03c7, 0x8e7a9b7a,
+	0x87717a71, 0xb8faf807,
+	0x867aff7a, 0x00007fff,
+	0xb97af807, 0xbef2007e,
+	0xbef3007f, 0xbefe0180,
+	0xbf900004, 0xbf8e0002,
+	0xbf88fffe, 0xbef8007e,
+	0x8679ff7f, 0x0000ffff,
+	0x8779ff79, 0x00040000,
+	0xbefa0080, 0xbefb00ff,
+	0x00807fac, 0x867aff7f,
+	0x08000000, 0x8f7a837a,
+	0x877b7a7b, 0x867aff7f,
+	0x70000000, 0x8f7a817a,
+	0x877b7a7b, 0xbeef007c,
+	0xbeee0080, 0xb8ee2a05,
+	0x806e816e, 0x8e6e8a6e,
+	0xb8fa1605, 0x807a817a,
+	0x8e7a867a, 0x806e7a6e,
+	0xbefa0084, 0xbefa00ff,
+	0x01000000, 0xbefe007c,
+	0xbefc006e, 0xc0611bfc,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xbefe007c,
+	0xbefc006e, 0xc0611c3c,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xbefe007c,
+	0xbefc006e, 0xc0611c7c,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xbefe007c,
+	0xbefc006e, 0xc0611cbc,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xbefe007c,
+	0xbefc006e, 0xc0611cfc,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xbefe007c,
+	0xbefc006e, 0xc0611d3c,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xb8f5f803,
+	0xbefe007c, 0xbefc006e,
+	0xc0611d7c, 0x0000007c,
+	0x806e846e, 0xbefc007e,
+	0xbefe007c, 0xbefc006e,
+	0xc0611dbc, 0x0000007c,
+	0x806e846e, 0xbefc007e,
+	0xbefe007c, 0xbefc006e,
+	0xc0611dfc, 0x0000007c,
+	0x806e846e, 0xbefc007e,
+	0xb8eff801, 0xbefe007c,
+	0xbefc006e, 0xc0611bfc,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xbefe007c,
+	0xbefc006e, 0xc0611b3c,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0xbefe007c,
+	0xbefc006e, 0xc0611b7c,
+	0x0000007c, 0x806e846e,
+	0xbefc007e, 0x867aff7f,
+	0x04000000, 0xbef30080,
+	0x8773737a, 0xb8ee2a05,
+	0x806e816e, 0x8e6e8a6e,
+	0xb8f51605, 0x80758175,
+	0x8e758475, 0x8e7a8275,
+	0xbefa00ff, 0x01000000,
+	0xbef60178, 0x80786e78,
+	0x82798079, 0xbefc0080,
+	0xbe802b00, 0xbe822b02,
+	0xbe842b04, 0xbe862b06,
+	0xbe882b08, 0xbe8a2b0a,
+	0xbe8c2b0c, 0xbe8e2b0e,
+	0xc06b003c, 0x00000000,
+	0xc06b013c, 0x00000010,
+	0xc06b023c, 0x00000020,
+	0xc06b033c, 0x00000030,
+	0x8078c078, 0x82798079,
+	0x807c907c, 0xbf0a757c,
+	0xbf85ffeb, 0xbef80176,
+	0xbeee0080, 0xbefe00c1,
+	0xbeff00c1, 0xbefa00ff,
+	0x01000000, 0xe0724000,
+	0x6e1e0000, 0xe0724100,
+	0x6e1e0100, 0xe0724200,
+	0x6e1e0200, 0xe0724300,
+	0x6e1e0300, 0xbefe00c1,
+	0xbeff00c1, 0xb8f54306,
+	0x8675c175, 0xbf84002c,
+	0xbf8a0000, 0x867aff73,
+	0x04000000, 0xbf840028,
+	0x8e758675, 0x8e758275,
+	0xbefa0075, 0xb8ee2a05,
+	0x806e816e, 0x8e6e8a6e,
+	0xb8fa1605, 0x807a817a,
+	0x8e7a867a, 0x806e7a6e,
+	0x806eff6e, 0x00000080,
+	0xbefa00ff, 0x01000000,
+	0xbefc0080, 0xd28c0002,
+	0x000100c1, 0xd28d0003,
+	0x000204c1, 0xd1060002,
+	0x00011103, 0x7e0602ff,
+	0x00000200, 0xbefc00ff,
+	0x00010000, 0xbe80007b,
+	0x867bff7b, 0xff7fffff,
+	0x877bff7b, 0x00058000,
+	0xd8ec0000, 0x00000002,
+	0xbf8c007f, 0xe0765000,
+	0x6e1e0002, 0x32040702,
+	0xd0c9006a, 0x0000eb02,
+	0xbf87fff7, 0xbefb0000,
+	0xbeee00ff, 0x00000400,
+	0xbefe00c1, 0xbeff00c1,
+	0xb8f52a05, 0x80758175,
+	0x8e758275, 0x8e7a8875,
+	0xbefa00ff, 0x01000000,
+	0xbefc0084, 0xbf0a757c,
+	0xbf840015, 0xbf11017c,
+	0x8075ff75, 0x00001000,
+	0x7e000300, 0x7e020301,
+	0x7e040302, 0x7e060303,
+	0xe0724000, 0x6e1e0000,
+	0xe0724100, 0x6e1e0100,
+	0xe0724200, 0x6e1e0200,
+	0xe0724300, 0x6e1e0300,
+	0x807c847c, 0x806eff6e,
+	0x00000400, 0xbf0a757c,
+	0xbf85ffef, 0xbf9c0000,
+	0xbf8200ca, 0xbef8007e,
+	0x8679ff7f, 0x0000ffff,
+	0x8779ff79, 0x00040000,
+	0xbefa0080, 0xbefb00ff,
+	0x00807fac, 0x8676ff7f,
+	0x08000000, 0x8f768376,
+	0x877b767b, 0x8676ff7f,
+	0x70000000, 0x8f768176,
+	0x877b767b, 0x8676ff7f,
+	0x04000000, 0xbf84001e,
+	0xbefe00c1, 0xbeff00c1,
+	0xb8f34306, 0x8673c173,
+	0xbf840019, 0x8e738673,
+	0x8e738273, 0xbefa0073,
+	0xb8f22a05, 0x80728172,
+	0x8e728a72, 0xb8f61605,
+	0x80768176, 0x8e768676,
+	0x80727672, 0x8072ff72,
+	0x00000080, 0xbefa00ff,
+	0x01000000, 0xbefc0080,
+	0xe0510000, 0x721e0000,
+	0xe0510100, 0x721e0000,
+	0x807cff7c, 0x00000200,
+	0x8072ff72, 0x00000200,
+	0xbf0a737c, 0xbf85fff6,
+	0xbef20080, 0xbefe00c1,
+	0xbeff00c1, 0xb8f32a05,
+	0x80738173, 0x8e738273,
+	0x8e7a8873, 0xbefa00ff,
+	0x01000000, 0xbef60072,
+	0x8072ff72, 0x00000400,
+	0xbefc0084, 0xbf11087c,
+	0x8073ff73, 0x00008000,
+	0xe0524000, 0x721e0000,
+	0xe0524100, 0x721e0100,
+	0xe0524200, 0x721e0200,
+	0xe0524300, 0x721e0300,
+	0xbf8c0f70, 0x7e000300,
+	0x7e020301, 0x7e040302,
+	0x7e060303, 0x807c847c,
+	0x8072ff72, 0x00000400,
+	0xbf0a737c, 0xbf85ffee,
+	0xbf9c0000, 0xe0524000,
+	0x761e0000, 0xe0524100,
+	0x761e0100, 0xe0524200,
+	0x761e0200, 0xe0524300,
+	0x761e0300, 0xb8f22a05,
+	0x80728172, 0x8e728a72,
+	0xb8f61605, 0x80768176,
+	0x8e768676, 0x80727672,
+	0x80f2c072, 0xb8f31605,
+	0x80738173, 0x8e738473,
+	0x8e7a8273, 0xbefa00ff,
+	0x01000000, 0xbefc0073,
+	0xc031003c, 0x00000072,
+	0x80f2c072, 0xbf8c007f,
+	0x80fc907c, 0xbe802d00,
+	0xbe822d02, 0xbe842d04,
+	0xbe862d06, 0xbe882d08,
+	0xbe8a2d0a, 0xbe8c2d0c,
+	0xbe8e2d0e, 0xbf06807c,
+	0xbf84fff1, 0xb8f22a05,
+	0x80728172, 0x8e728a72,
+	0xb8f61605, 0x80768176,
+	0x8e768676, 0x80727672,
+	0xbefa0084, 0xbefa00ff,
+	0x01000000, 0xc0211cfc,
+	0x00000072, 0x80728472,
+	0xc0211c3c, 0x00000072,
+	0x80728472, 0xc0211c7c,
+	0x00000072, 0x80728472,
+	0xc0211bbc, 0x00000072,
+	0x80728472, 0xc0211bfc,
+	0x00000072, 0x80728472,
+	0xc0211d3c, 0x00000072,
+	0x80728472, 0xc0211d7c,
+	0x00000072, 0x80728472,
+	0xc0211a3c, 0x00000072,
+	0x80728472, 0xc0211a7c,
+	0x00000072, 0x80728472,
+	0xc0211dfc, 0x00000072,
+	0x80728472, 0xc0211b3c,
+	0x00000072, 0x80728472,
+	0xc0211b7c, 0x00000072,
+	0x80728472, 0xbf8c007f,
+	0x8671ff71, 0x0000ffff,
+	0xbefc0073, 0xbefe006e,
+	0xbeff006f, 0x867375ff,
+	0x000003ff, 0xb9734803,
+	0x867375ff, 0xfffff800,
+	0x8f738b73, 0xb973a2c3,
+	0xb977f801, 0x8673ff71,
+	0xf0000000, 0x8f739c73,
+	0x8e739073, 0xbef60080,
+	0x87767376, 0x8673ff71,
+	0x08000000, 0x8f739b73,
+	0x8e738f73, 0x87767376,
+	0x8673ff74, 0x00800000,
+	0x8f739773, 0xb976f807,
+	0x86fe7e7e, 0x86ea6a6a,
+	0xb974f802, 0xbf8a0000,
+	0x95807370, 0xbf810000,
+};
+
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 505d391..cc61ec2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -117,7 +117,7 @@ static int kfd_open(struct inode *inode, struct file *filep)
 		return -EPERM;
 	}
 
-	process = kfd_create_process(current);
+	process = kfd_create_process(filep);
 	if (IS_ERR(process))
 		return PTR_ERR(process);
 
@@ -206,6 +206,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 	q_properties->ctx_save_restore_area_address =
 			args->ctx_save_restore_address;
 	q_properties->ctx_save_restore_area_size = args->ctx_save_restore_size;
+	q_properties->ctl_stack_size = args->ctl_stack_size;
 	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE ||
 		args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
 		q_properties->type = KFD_QUEUE_TYPE_COMPUTE;
@@ -431,6 +432,38 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 	return err;
 }
 
+static int kfd_ioctl_set_trap_handler(struct file *filep,
+					struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_set_trap_handler_args *args = data;
+	struct kfd_dev *dev;
+	int err = 0;
+	struct kfd_process_device *pdd;
+
+	dev = kfd_device_by_id(args->gpu_id);
+	if (dev == NULL)
+		return -EINVAL;
+
+	mutex_lock(&p->mutex);
+
+	pdd = kfd_bind_process_to_device(dev, p);
+	if (IS_ERR(pdd)) {
+		err = -ESRCH;
+		goto out;
+	}
+
+	if (dev->dqm->ops.set_trap_handler(dev->dqm,
+					&pdd->qpd,
+					args->tba_addr,
+					args->tma_addr))
+		err = -EINVAL;
+
+out:
+	mutex_unlock(&p->mutex);
+
+	return err;
+}
+
 static int kfd_ioctl_dbg_register(struct file *filep,
 				struct kfd_process *p, void *data)
 {
@@ -979,7 +1012,10 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 			kfd_ioctl_set_scratch_backing_va, 0),
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_GET_TILE_CONFIG,
-			kfd_ioctl_get_tile_config, 0)
+			kfd_ioctl_get_tile_config, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_TRAP_HANDLER,
+			kfd_ioctl_set_trap_handler, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
@@ -1088,6 +1124,10 @@ static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
 			KFD_MMAP_EVENTS_MASK) {
 		vma->vm_pgoff = vma->vm_pgoff ^ KFD_MMAP_EVENTS_MASK;
 		return kfd_event_mmap(process, vma);
+	} else if ((vma->vm_pgoff & KFD_MMAP_RESERVED_MEM_MASK) ==
+			KFD_MMAP_RESERVED_MEM_MASK) {
+		vma->vm_pgoff = vma->vm_pgoff ^ KFD_MMAP_RESERVED_MEM_MASK;
+		return kfd_reserved_mem_mmap(process, vma);
 	}
 
 	return -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 621a3b5..c7e12c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -24,9 +24,11 @@
 #include <linux/bsearch.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_pm4_headers_vi.h"
+#include "cwsr_trap_handler_gfx8.asm"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -38,7 +40,8 @@ static const struct kfd_device_info kaveri_device_info = {
 	.ih_ring_entry_size = 4 * sizeof(uint32_t),
 	.event_interrupt_class = &event_interrupt_class_cik,
 	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = false,
 };
 
 static const struct kfd_device_info carrizo_device_info = {
@@ -49,7 +52,8 @@ static const struct kfd_device_info carrizo_device_info = {
 	.ih_ring_entry_size = 4 * sizeof(uint32_t),
 	.event_interrupt_class = &event_interrupt_class_cik,
 	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.supports_cwsr = true,
 };
 
 struct kfd_deviceid {
@@ -212,6 +216,19 @@ static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
 	return AMD_IOMMU_INV_PRI_RSP_INVALID;
 }
 
+static int kfd_cwsr_init(struct kfd_dev *kfd)
+{
+	if (cwsr_enable && kfd->device_info->supports_cwsr) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
+
+		kfd->cwsr_isa = cwsr_trap_gfx8_hex;
+		kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
+		kfd->cwsr_enabled = true;
+	}
+
+	return 0;
+}
+
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
 {
@@ -286,6 +303,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto device_iommu_pasid_error;
 	}
 
+	if (kfd_cwsr_init(kfd))
+		goto device_iommu_pasid_error;
+
 	if (kfd_resume(kfd))
 		goto kfd_resume_error;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e202921..8447810 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -173,6 +173,9 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	*allocated_vmid = qpd->vmid;
 	q->properties.vmid = qpd->vmid;
 
+	q->properties.tba_addr = qpd->tba_addr;
+	q->properties.tma_addr = qpd->tma_addr;
+
 	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		retval = create_compute_queue_nocpsch(dqm, q, qpd);
 	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
@@ -846,6 +849,9 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	}
 
 	dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
+
+	q->properties.tba_addr = qpd->tba_addr;
+	q->properties.tma_addr = qpd->tma_addr;
 	retval = mqd->init_mqd(mqd, &q->mqd, &q->mqd_mem_obj,
 				&q->gart_mqd_addr, &q->properties);
 	if (retval)
@@ -1110,6 +1116,26 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 	return retval;
 }
 
+static int set_trap_handler(struct device_queue_manager *dqm,
+				struct qcm_process_device *qpd,
+				uint64_t tba_addr,
+				uint64_t tma_addr)
+{
+	uint64_t *tma;
+
+	if (dqm->dev->cwsr_enabled) {
+		/* Jump from CWSR trap handler to user trap */
+		tma = (uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		tma[0] = tba_addr;
+		tma[1] = tma_addr;
+	} else {
+		qpd->tba_addr = tba_addr;
+		qpd->tma_addr = tma_addr;
+	}
+
+	return 0;
+}
+
 static int process_termination_nocpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
@@ -1241,6 +1267,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.create_kernel_queue = create_kernel_queue_cpsch;
 		dqm->ops.destroy_kernel_queue = destroy_kernel_queue_cpsch;
 		dqm->ops.set_cache_memory_policy = set_cache_memory_policy;
+		dqm->ops.set_trap_handler = set_trap_handler;
 		dqm->ops.process_termination = process_termination_cpsch;
 		break;
 	case KFD_SCHED_POLICY_NO_HWS:
@@ -1256,6 +1283,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.initialize = initialize_nocpsch;
 		dqm->ops.uninitialize = uninitialize;
 		dqm->ops.set_cache_memory_policy = set_cache_memory_policy;
+		dqm->ops.set_trap_handler = set_trap_handler;
 		dqm->ops.process_termination = process_termination_nocpsch;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 5b77cb6..8752edf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -123,6 +123,11 @@ struct device_queue_manager_ops {
 					   void __user *alternate_aperture_base,
 					   uint64_t alternate_aperture_size);
 
+	int	(*set_trap_handler)(struct device_queue_manager *dqm,
+				    struct qcm_process_device *qpd,
+				    uint64_t tba_addr,
+				    uint64_t tma_addr);
+
 	int (*process_termination)(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd);
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 6c5a9ca..4b2423b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -49,6 +49,10 @@ module_param(sched_policy, int, 0444);
 MODULE_PARM_DESC(sched_policy,
 	"Scheduling policy (0 = HWS (Default), 1 = HWS without over-subscription, 2 = Non-HWS (Used for debugging only)");
 
+int cwsr_enable = 1;
+module_param(cwsr_enable, int, 0444);
+MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off, 1 = On (Default))");
+
 int max_num_of_queues_per_device = KFD_MAX_NUM_OF_QUEUES_PER_DEVICE_DEFAULT;
 module_param(max_num_of_queues_per_device, int, 0444);
 MODULE_PARM_DESC(max_num_of_queues_per_device,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 2ba7cea..00e1f1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -89,6 +89,28 @@ static int init_mqd(struct mqd_manager *mm, void **mqd,
 	if (q->format == KFD_QUEUE_FORMAT_AQL)
 		m->cp_hqd_iq_rptr = 1;
 
+	if (q->tba_addr) {
+		m->compute_tba_lo = lower_32_bits(q->tba_addr >> 8);
+		m->compute_tba_hi = upper_32_bits(q->tba_addr >> 8);
+		m->compute_tma_lo = lower_32_bits(q->tma_addr >> 8);
+		m->compute_tma_hi = upper_32_bits(q->tma_addr >> 8);
+		m->compute_pgm_rsrc2 |=
+			(1 << COMPUTE_PGM_RSRC2__TRAP_PRESENT__SHIFT);
+	}
+
+	if (mm->dev->cwsr_enabled && q->ctx_save_restore_area_address) {
+		m->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		m->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(q->ctx_save_restore_area_address);
+		m->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(q->ctx_save_restore_area_address);
+		m->cp_hqd_ctx_save_size = q->ctx_save_restore_area_size;
+		m->cp_hqd_cntl_stack_size = q->ctl_stack_size;
+		m->cp_hqd_cntl_stack_offset = q->ctl_stack_size;
+		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
+	}
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
@@ -167,6 +189,11 @@ static int __update_mqd(struct mqd_manager *mm, void *mqd,
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT;
 	}
 
+	if (mm->dev->cwsr_enabled && q->ctx_save_restore_area_address)
+		m->cp_hqd_ctx_save_control =
+			atc_bit << CP_HQD_CTX_SAVE_CONTROL__ATC__SHIFT |
+			mtype << CP_HQD_CTX_SAVE_CONTROL__MTYPE__SHIFT;
+
 	q->is_active = (q->queue_size > 0 &&
 			q->queue_address != 0 &&
 			q->queue_percent > 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4750473..a668764 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -41,6 +41,7 @@
 
 #define KFD_MMAP_DOORBELL_MASK 0x8000000000000
 #define KFD_MMAP_EVENTS_MASK 0x4000000000000
+#define KFD_MMAP_RESERVED_MEM_MASK 0x2000000000000
 
 /*
  * When working with cp scheduler we should assign the HIQ manually or via
@@ -63,6 +64,15 @@
 #define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 
 /*
+ * Size of the per-process TBA+TMA buffer: 2 pages
+ *
+ * The first page is the TBA used for the CWSR ISA code. The second
+ * page is used as TMA for daisy changing a user-mode trap handler.
+ */
+#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
+#define KFD_CWSR_TMA_OFFSET PAGE_SIZE
+
+/*
  * Kernel module parameter to specify maximum number of supported queues per
  * device
  */
@@ -78,6 +88,8 @@ extern int max_num_of_queues_per_device;
 /* Kernel module parameter to specify the scheduling policy */
 extern int sched_policy;
 
+extern int cwsr_enable;
+
 /*
  * Kernel module parameter to specify whether to send sigterm to HSA process on
  * unhandled exception
@@ -131,6 +143,7 @@ struct kfd_device_info {
 	size_t ih_ring_entry_size;
 	uint8_t num_of_watch_points;
 	uint16_t mqd_size_aligned;
+	bool supports_cwsr;
 };
 
 struct kfd_mem_obj {
@@ -200,6 +213,11 @@ struct kfd_dev {
 
 	/* Debug manager */
 	struct kfd_dbgmgr           *dbgmgr;
+
+	/* CWSR */
+	bool cwsr_enabled;
+	const void *cwsr_isa;
+	unsigned int cwsr_isa_size;
 };
 
 /* KGD2KFD callbacks */
@@ -332,6 +350,9 @@ struct queue_properties {
 	uint32_t eop_ring_buffer_size;
 	uint64_t ctx_save_restore_area_address;
 	uint32_t ctx_save_restore_area_size;
+	uint32_t ctl_stack_size;
+	uint64_t tba_addr;
+	uint64_t tma_addr;
 };
 
 /**
@@ -439,6 +460,11 @@ struct qcm_process_device {
 	uint32_t num_gws;
 	uint32_t num_oac;
 	uint32_t sh_hidden_private_base;
+
+	/* CWSR memory */
+	void *cwsr_kaddr;
+	uint64_t tba_addr;
+	uint64_t tma_addr;
 };
 
 
@@ -563,7 +589,7 @@ struct amdkfd_ioctl_desc {
 
 void kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
-struct kfd_process *kfd_create_process(const struct task_struct *);
+struct kfd_process *kfd_create_process(struct file *filep);
 struct kfd_process *kfd_get_process(const struct task_struct *);
 struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid);
 
@@ -577,6 +603,9 @@ struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
 struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 							struct kfd_process *p);
 
+int kfd_reserved_mem_mmap(struct kfd_process *process,
+			  struct vm_area_struct *vma);
+
 /* Process device data iterator */
 struct kfd_process_device *kfd_get_first_process_device_data(
 							struct kfd_process *p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1f5ccd28..75063ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -28,6 +28,8 @@
 #include <linux/amd-iommu.h>
 #include <linux/notifier.h>
 #include <linux/compat.h>
+#include <linux/mman.h>
+#include <linux/highmem.h>
 
 struct mm_struct;
 
@@ -53,6 +55,8 @@ struct kfd_process_release_work {
 
 static struct kfd_process *find_process(const struct task_struct *thread);
 static struct kfd_process *create_process(const struct task_struct *thread);
+static int kfd_process_init_cwsr(struct kfd_process *p, struct file *filep);
+
 
 void kfd_process_create_wq(void)
 {
@@ -68,9 +72,10 @@ void kfd_process_destroy_wq(void)
 	}
 }
 
-struct kfd_process *kfd_create_process(const struct task_struct *thread)
+struct kfd_process *kfd_create_process(struct file *filep)
 {
 	struct kfd_process *process;
+	struct task_struct *thread = current;
 
 	if (!thread->mm)
 		return ERR_PTR(-EINVAL);
@@ -101,6 +106,8 @@ struct kfd_process *kfd_create_process(const struct task_struct *thread)
 
 	up_write(&thread->mm->mmap_sem);
 
+	kfd_process_init_cwsr(process, filep);
+
 	return process;
 }
 
@@ -168,6 +175,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 			amd_iommu_unbind_pasid(pdd->dev->pdev, p->pasid);
 
 		list_del(&pdd->per_device_list);
+
+		if (pdd->qpd.cwsr_kaddr)
+			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
+				get_order(KFD_CWSR_TBA_TMA_SIZE));
+
 		kfree(pdd);
 	}
 
@@ -260,6 +272,46 @@ static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.release = kfd_process_notifier_release,
 };
 
+static int kfd_process_init_cwsr(struct kfd_process *p, struct file *filep)
+{
+	int err = 0;
+	unsigned long  offset;
+	struct kfd_process_device *temp, *pdd = NULL;
+	struct kfd_dev *dev = NULL;
+	struct qcm_process_device *qpd = NULL;
+
+	mutex_lock(&p->mutex);
+	list_for_each_entry_safe(pdd, temp, &p->per_device_data,
+				per_device_list) {
+		dev = pdd->dev;
+		qpd = &pdd->qpd;
+		if (!dev->cwsr_enabled || qpd->cwsr_kaddr)
+			continue;
+		offset = (dev->id | KFD_MMAP_RESERVED_MEM_MASK) << PAGE_SHIFT;
+		qpd->tba_addr = (int64_t)vm_mmap(filep, 0,
+			KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
+			MAP_SHARED, offset);
+
+		if (IS_ERR_VALUE(qpd->tba_addr)) {
+			pr_err("Failure to set tba address. error -%d.\n",
+				(int)qpd->tba_addr);
+			err = qpd->tba_addr;
+			qpd->tba_addr = 0;
+			qpd->cwsr_kaddr = NULL;
+			goto out;
+		}
+
+		memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
+
+		qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
+		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
+			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
+	}
+out:
+	mutex_unlock(&p->mutex);
+	return err;
+}
+
 static struct kfd_process *create_process(const struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -348,6 +400,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 		INIT_LIST_HEAD(&pdd->qpd.queues_list);
 		INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
 		pdd->qpd.dqm = dev->dqm;
+		pdd->qpd.pqm = &p->pqm;
 		pdd->process = p;
 		pdd->bound = PDD_UNBOUND;
 		pdd->already_dequeued = false;
@@ -534,3 +587,37 @@ struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid)
 
 	return p;
 }
+
+int kfd_reserved_mem_mmap(struct kfd_process *process,
+			  struct vm_area_struct *vma)
+{
+	struct kfd_dev *dev = kfd_device_by_id(vma->vm_pgoff);
+	struct kfd_process_device *pdd;
+	struct qcm_process_device *qpd;
+
+	if (!dev)
+		return -EINVAL;
+	if ((vma->vm_end - vma->vm_start) != KFD_CWSR_TBA_TMA_SIZE) {
+		pr_err("Incorrect CWSR mapping size.\n");
+		return -EINVAL;
+	}
+
+	pdd = kfd_get_process_device_data(dev, process);
+	if (!pdd)
+		return -EINVAL;
+	qpd = &pdd->qpd;
+
+	qpd->cwsr_kaddr = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					get_order(KFD_CWSR_TBA_TMA_SIZE));
+	if (!qpd->cwsr_kaddr) {
+		pr_err("Error allocating per process CWSR buffer.\n");
+		return -ENOMEM;
+	}
+
+	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND
+		| VM_NORESERVE | VM_DONTDUMP | VM_PFNMAP;
+	/* Mapping pages to user process */
+	return remap_pfn_range(vma, vma->vm_start,
+			       PFN_DOWN(__pa(qpd->cwsr_kaddr)),
+			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a3f1e62..eeb7726 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -178,10 +178,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		return retval;
 
 	if (list_empty(&pdd->qpd.queues_list) &&
-	    list_empty(&pdd->qpd.priv_queue_list)) {
-		pdd->qpd.pqm = pqm;
+	    list_empty(&pdd->qpd.priv_queue_list))
 		dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);
-	}
 
 	pqn = kzalloc(sizeof(*pqn), GFP_KERNEL);
 	if (!pqn) {
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 731d0df..4c58795 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -58,7 +58,8 @@ struct kfd_ioctl_create_queue_args {
 	__u64 eop_buffer_address;	/* to KFD */
 	__u64 eop_buffer_size;	/* to KFD */
 	__u64 ctx_save_restore_address; /* to KFD */
-	__u64 ctx_save_restore_size;	/* to KFD */
+	__u32 ctx_save_restore_size;	/* to KFD */
+	__u32 ctl_stack_size;		/* to KFD */
 };
 
 struct kfd_ioctl_destroy_queue_args {
@@ -261,6 +262,13 @@ struct kfd_ioctl_get_tile_config_args {
 	 */
 };
 
+struct kfd_ioctl_set_trap_handler_args {
+	uint64_t tba_addr;		/* to KFD */
+	uint64_t tma_addr;		/* to KFD */
+	uint32_t gpu_id;		/* to KFD */
+	uint32_t pad;
+};
+
 #define AMDKFD_IOCTL_BASE 'K'
 #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
 #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
@@ -321,7 +329,10 @@ struct kfd_ioctl_get_tile_config_args {
 #define AMDKFD_IOC_GET_TILE_CONFIG                                      \
 		AMDKFD_IOWR(0x12, struct kfd_ioctl_get_tile_config_args)
 
+#define AMDKFD_IOC_SET_TRAP_HANDLER		\
+		AMDKFD_IOW(0x13, struct kfd_ioctl_set_trap_handler_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x13
+#define AMDKFD_COMMAND_END		0x14
 
 #endif
-- 
2.7.4


--===============1781479148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1781479148==--
