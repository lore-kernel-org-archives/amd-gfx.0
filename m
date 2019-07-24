From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Remove dead code from gfx8/gfx9 trap
 handlers
Date: Wed, 24 Jul 2019 17:42:35 +0000
Message-ID: <BN6PR12MB1809F67AE6AC298C22F0C484F7C60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1563989255-29050-1-git-send-email-jay.cornwall@amd.com>,
 <1563989255-29050-2-git-send-email-jay.cornwall@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2106555206=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1563989255-29050-2-git-send-email-jay.cornwall-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "Cornwall, Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2106555206==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F67AE6AC298C22F0C484F7C60BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F67AE6AC298C22F0C484F7C60BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Cornwall=
, Jay <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, July 24, 2019 1:27 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Cornwall, Jay <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdkfd: Remove dead code from gfx8/gfx9 trap handl=
ers

Signed-off-by: Jay Cornwall <jay.cornwall-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  | 395 +----------------=
----
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  | 375 +----------------=
--
 2 files changed, 5 insertions(+), 765 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm b/driver=
s/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm
index a47f5b9..b195b7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm
@@ -24,78 +24,6 @@
  * PROJECT=3Dvi ./sp3 cwsr_trap_handler_gfx8.asm -hex tmp.hex
  */

-/* HW (VI) source code for CWSR trap handler */
-/* Version 18 + multiple trap handler */
-
-// this performance-optimal version was originally from Seven Xu at SRDC
-
-// Revison #18   --...
-/* Rev History
-** #1. Branch from gc dv.   //gfxip/gfx8/main/src/test/suites/block/cs/sr/=
cs_trap_handler.sp3#1,#50, #51, #52-53(Skip, Already Fixed by PV), #54-56(m=
erged),#57-58(mergerd, skiped-already fixed by PV)
-** #4. SR Memory Layout:
-**             1. VGPR-SGPR-HWREG-{LDS}
-**             2. tba_hi.bits.26 - reconfigured as the first wave in tg bi=
ts, for defer Save LDS for a threadgroup.. performance concern..
-** #5. Update: 1. Accurate g8sr_ts_save_d timestamp
-** #6. Update: 1. Fix s_barrier usage; 2. VGPR s/r using swizzle buffer?(N=
oNeed, already matched the swizzle pattern, more investigation)
-** #7. Update: 1. don't barrier if noLDS
-** #8. Branch: 1. Branch to ver#0, which is very similar to gc dv version
-**             2. Fix SQ issue by s_sleep 2
-** #9. Update: 1. Fix scc restore failed issue, restore wave_status at las=
t
-**             2. optimize s_buffer save by burst 16sgprs...
-** #10. Update 1. Optimize restore sgpr by busrt 16 sgprs.
-** #11. Update 1. Add 2 more timestamp for debug version
-** #12. Update 1. Add VGPR SR using DWx4, some case improve and some case =
drop performance
-** #13. Integ  1. Always use MUBUF for PV trap shader...
-** #14. Update 1. s_buffer_store soft clause...
-** #15. Update 1. PERF - sclar write with glc:0/mtype0 to allow L2 combine=
. perf improvement a lot.
-** #16. Update 1. PRRF - UNROLL LDS_DMA got 2500cycle save in IP tree
-** #17. Update 1. FUNC - LDS_DMA has issues while ATC, replace with ds_rea=
d/buffer_store for save part[TODO restore part]
-**             2. PERF - Save LDS before save VGPR to cover LDS save long =
latency...
-** #18. Update 1. FUNC - Implicitly estore STATUS.VCCZ, which is not writa=
ble by s_setreg_b32
-**             2. FUNC - Handle non-CWSR traps
-*/
-
-var G8SR_WDMEM_HWREG_OFFSET =3D 0
-var G8SR_WDMEM_SGPR_OFFSET  =3D 128  // in bytes
-
-// Keep definition same as the app shader, These 2 time stamps are part of=
 the app shader... Should before any Save and after restore.
-
-var G8SR_DEBUG_TIMESTAMP =3D 0
-var G8SR_DEBUG_TS_SAVE_D_OFFSET =3D 40*4  // ts_save_d timestamp offset re=
lative to SGPR_SR_memory_offset
-var s_g8sr_ts_save_s    =3D s[34:35]   // save start
-var s_g8sr_ts_sq_save_msg  =3D s[36:37]   // The save shader send SAVEWAVE=
 msg to spi
-var s_g8sr_ts_spi_wrexec   =3D s[38:39]   // the SPI write the sr address =
to SQ
-var s_g8sr_ts_save_d    =3D s[40:41]   // save end
-var s_g8sr_ts_restore_s =3D s[42:43]   // restore start
-var s_g8sr_ts_restore_d =3D s[44:45]   // restore end
-
-var G8SR_VGPR_SR_IN_DWX4 =3D 0
-var G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4 =3D 0x00100000    // DWx4 stride =
is 4*4Bytes
-var G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4  =3D G8SR_SAVE_BUF_RSRC_WORD1_=
STRIDE_DWx4
-
-
-/*************************************************************************=
/
-/*                  control on how to run the shader                     *=
/
-/*************************************************************************=
/
-//any hack that needs to be made to run this code in EMU (either because v=
arious EMU code are not ready or no compute save & restore in EMU run)
-var EMU_RUN_HACK                    =3D   0
-var EMU_RUN_HACK_RESTORE_NORMAL     =3D   0
-var EMU_RUN_HACK_SAVE_NORMAL_EXIT   =3D   0
-var EMU_RUN_HACK_SAVE_SINGLE_WAVE   =3D   0
-var EMU_RUN_HACK_SAVE_FIRST_TIME    =3D   0                   //for interr=
upted restore in which the first save is through EMU_RUN_HACK
-var EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_LO =3D   0                   //for in=
terrupted restore in which the first save is through EMU_RUN_HACK
-var EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_HI =3D   0                   //for in=
terrupted restore in which the first save is through EMU_RUN_HACK
-var SAVE_LDS                        =3D   1
-var WG_BASE_ADDR_LO                 =3D   0x9000a000
-var WG_BASE_ADDR_HI                 =3D   0x0
-var WAVE_SPACE                      =3D   0x5000              //memory siz=
e that each wave occupies in workgroup state mem
-var CTX_SAVE_CONTROL                =3D   0x0
-var CTX_RESTORE_CONTROL             =3D   CTX_SAVE_CONTROL
-var SIM_RUN_HACK                    =3D   0                   //any hack t=
hat needs to be made to run this code in SIM (either because various RTL co=
de are not ready or no compute save & restore in RTL run)
-var SGPR_SAVE_USE_SQC               =3D   1                   //use SQC D$=
 to do the write
-var USE_MTBUF_INSTEAD_OF_MUBUF      =3D   0                   //because TC=
 EMU currently asserts on 0 of // overload DFMT field to carry 4 more bits =
of stride for MUBUF opcodes
-var SWIZZLE_EN                      =3D   0                   //whether we=
 use swizzled buffer addressing
-
 /*************************************************************************=
*/
 /*                      variables                                         =
*/
 /*************************************************************************=
*/
@@ -226,16 +154,7 @@ shader main
   type(CS)


-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))                 =
  //hack to use trap_id for determining save/restore
-        //FIXME VCCZ un-init assertion s_getreg_b32     s_save_status, hwr=
eg(HW_REG_STATUS)         //save STATUS since we will change SCC
-        s_and_b32 s_save_tmp, s_save_pc_hi, 0xffff0000              //chan=
ge SCC
-        s_cmp_eq_u32 s_save_tmp, 0x007e0000                         //Save=
: trap_id =3D 0x7e. Restore: trap_id =3D 0x7f.
-        s_cbranch_scc0 L_JUMP_TO_RESTORE                            //do n=
ot need to recover STATUS here  since we are going to RESTORE
-        //FIXME  s_setreg_b32   hwreg(HW_REG_STATUS),   s_save_status     =
  //need to recover STATUS since we are going to SAVE
-        s_branch L_SKIP_RESTORE                                     //NOT =
restore, SAVE actually
-    else
         s_branch L_SKIP_RESTORE                                     //NOT =
restore. might be a regular trap or save
-    end

 L_JUMP_TO_RESTORE:
     s_branch L_RESTORE                                              //rest=
ore
@@ -249,7 +168,7 @@ L_SKIP_RESTORE:
     s_cbranch_scc1  L_SAVE                                      //this is =
the operation for save

     // *********    Handle non-CWSR traps       *******************
-if (!EMU_RUN_HACK)
+
     /* read tba and tma for next level trap handler, ttmp4 is used as s_sa=
ve_status */
     s_load_dwordx4  [ttmp8,ttmp9,ttmp10, ttmp11], [tma_lo,tma_hi], 0
     s_waitcnt lgkmcnt(0)
@@ -268,7 +187,7 @@ L_EXCP_CASE:
     s_and_b32   ttmp1, ttmp1, 0xFFFF
     set_status_without_spi_prio(s_save_status, ttmp2) //restore HW status(=
SCC)
     s_rfe_b64       [ttmp0, ttmp1]
-end
+
     // *********        End handling of non-CWSR traps   *****************=
**

 /*************************************************************************=
*/
@@ -276,12 +195,6 @@ end
 /*************************************************************************=
*/

 L_SAVE:
-
-if G8SR_DEBUG_TIMESTAMP
-        s_memrealtime   s_g8sr_ts_save_s
-        s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
-end
-
     s_mov_b32       s_save_tmp, 0                                         =
                  //clear saveCtx bit
     s_setreg_b32    hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_SAVECTX_SHIFT, 1=
), s_save_tmp     //clear saveCtx bit

@@ -303,16 +216,7 @@ end
     s_mov_b32       s_save_exec_hi, exec_hi
     s_mov_b64       exec,   0x0                                           =
                  //clear EXEC to get ready to receive

-if G8SR_DEBUG_TIMESTAMP
-        s_memrealtime  s_g8sr_ts_sq_save_msg
-        s_waitcnt lgkmcnt(0)
-end
-
-    if (EMU_RUN_HACK)
-
-    else
         s_sendmsg   sendmsg(MSG_SAVEWAVE)  //send SPI a message and wait f=
or SPI's write to EXEC
-    end

     // Set SPI_PRIO=3D2 to avoid starving instruction fetch in the waves w=
e're waiting for.
     s_or_b32 s_save_tmp, s_save_status, (2 << SQ_WAVE_STATUS_SPI_PRIO_SHIF=
T)
@@ -321,36 +225,9 @@ end
   L_SLEEP:
     s_sleep 0x2                // sleep 1 (64clk) is not enough for 8 wave=
s per SIMD, which will cause SQ hang, since the 7,8th wave could not get ar=
bit to exec inst, while other waves are stuck into the sleep-loop and waiti=
ng for wrexec!=3D0

-    if (EMU_RUN_HACK)
-
-    else
         s_cbranch_execz L_SLEEP
-    end
-
-if G8SR_DEBUG_TIMESTAMP
-        s_memrealtime  s_g8sr_ts_spi_wrexec
-        s_waitcnt lgkmcnt(0)
-end

     /*      setup Resource Contants    */
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_SAVE_SINGLE_WAVE))
-        //calculate wd_addr using absolute thread id
-        v_readlane_b32 s_save_tmp, v9, 0
-        s_lshr_b32 s_save_tmp, s_save_tmp, 6
-        s_mul_i32 s_save_tmp, s_save_tmp, WAVE_SPACE
-        s_add_i32 s_save_spi_init_lo, s_save_tmp, WG_BASE_ADDR_LO
-        s_mov_b32 s_save_spi_init_hi, WG_BASE_ADDR_HI
-        s_and_b32 s_save_spi_init_hi, s_save_spi_init_hi, CTX_SAVE_CONTROL
-    else
-    end
-    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_SAVE_SINGLE_WAVE))
-        s_add_i32 s_save_spi_init_lo, s_save_tmp, WG_BASE_ADDR_LO
-        s_mov_b32 s_save_spi_init_hi, WG_BASE_ADDR_HI
-        s_and_b32 s_save_spi_init_hi, s_save_spi_init_hi, CTX_SAVE_CONTROL
-    else
-    end
-
-
     s_mov_b32       s_save_buf_rsrc0,   s_save_spi_init_lo                =
                                      //base_addr_lo
     s_and_b32       s_save_buf_rsrc1,   s_save_spi_init_hi, 0x0000FFFF    =
                                      //base_addr_hi
     s_or_b32        s_save_buf_rsrc1,   s_save_buf_rsrc1,  S_SAVE_BUF_RSRC=
_WORD1_STRIDE
@@ -383,22 +260,10 @@ end


     s_mov_b32       s_save_buf_rsrc2, 0x4                               //=
NUM_RECORDS   in bytes
-    if (SWIZZLE_EN)
-        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0           =
          //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end


     write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)    =
              //M0
-
-    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_SAVE_FIRST_TIME))
-        s_add_u32 s_save_pc_lo, s_save_pc_lo, 4             //pc[31:0]+4
-        s_addc_u32 s_save_pc_hi, s_save_pc_hi, 0x0          //carry bit ov=
er
-        s_mov_b32   tba_lo, EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_LO
-        s_mov_b32   tba_hi, EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_HI
-    end
-
     write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0, s_save_mem_offset) =
                  //PC
     write_hwreg_to_mem(s_save_pc_hi, s_save_buf_rsrc0, s_save_mem_offset)
     write_hwreg_to_mem(s_save_exec_lo, s_save_buf_rsrc0, s_save_mem_offset=
)             //EXEC
@@ -440,18 +305,8 @@ end
     s_add_u32       s_save_alloc_size, s_save_alloc_size, 1
     s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 4               =
          //Number of SGPRs =3D (sgpr_size + 1) * 16   (non-zero value)

-    if (SGPR_SAVE_USE_SQC)
         s_lshl_b32      s_save_buf_rsrc2,   s_save_alloc_size, 2          =
          //NUM_RECORDS in bytes
-    else
-        s_lshl_b32      s_save_buf_rsrc2,   s_save_alloc_size, 8          =
          //NUM_RECORDS in bytes (64 threads)
-    end
-
-    if (SWIZZLE_EN)
-        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0           =
          //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end
-

     // backup s_save_buf_rsrc0,1 to s_save_pc_lo/hi, since write_16sgpr_to=
_mem function will change the rsrc0
     //s_mov_b64 s_save_pc_lo, s_save_buf_rsrc0
@@ -490,30 +345,14 @@ end
     s_mov_b32       exec_lo, 0xFFFFFFFF                                   =
          //need every thread from now on
     s_mov_b32       exec_hi, 0xFFFFFFFF

-    if (SWIZZLE_EN)
-        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0           =
          //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end
-

     // VGPR Allocated in 4-GPR granularity

-if G8SR_VGPR_SR_IN_DWX4
-        // the const stride for DWx4 is 4*4 bytes
-        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // rese=
t const stride to 0
-        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_W=
ORD1_STRIDE_DWx4  // const stride to 4*4 bytes
-
-        buffer_store_dwordx4 v0, v0, s_save_buf_rsrc0, s_save_mem_offset s=
lc:1 glc:1
-
-        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // rese=
t const stride to 0
-        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD=
1_STRIDE  // reset const stride to 4 bytes
-else
         buffer_store_dword v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1
         buffer_store_dword v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256
         buffer_store_dword v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*2
         buffer_store_dword v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*3
-end



@@ -549,64 +388,10 @@ end
     s_add_u32 s_save_mem_offset, s_save_mem_offset, get_hwreg_size_bytes()


-    if (SWIZZLE_EN)
-        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0       //FI=
XME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                  //NU=
M_RECORDS in bytes
-    end
-
     s_mov_b32       m0, 0x0                                               =
//lds_offset initial value =3D 0


-var LDS_DMA_ENABLE =3D 0
-var UNROLL =3D 0
-if UNROLL=3D=3D0 && LDS_DMA_ENABLE=3D=3D1
-        s_mov_b32  s3, 256*2
-        s_nop 0
-        s_nop 0
-        s_nop 0
-  L_SAVE_LDS_LOOP:
-        //TODO: looks the 2 buffer_store/load clause for s/r will hurt per=
formance.???
-    if (SAVE_LDS)     //SPI always alloc LDS space in 128DW granularity
-            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds=
:1            // first 64DW
-            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds=
:1 offset:256 // second 64DW
-    end
-
-    s_add_u32       m0, m0, s3                                          //=
every buffer_store_lds does 256 bytes
-    s_add_u32       s_save_mem_offset, s_save_mem_offset, s3              =
              //mem offset increased by 256 bytes
-    s_cmp_lt_u32    m0, s_save_alloc_size                                 =
              //scc=3D(m0 < s_save_alloc_size) ? 1 : 0
-    s_cbranch_scc1  L_SAVE_LDS_LOOP                                       =
              //LDS save is complete?
-
-elsif LDS_DMA_ENABLE=3D=3D1 && UNROLL=3D=3D1 // UNROOL  , has ichace miss
-      // store from higest LDS address to lowest
-      s_mov_b32  s3, 256*2
-      s_sub_u32  m0, s_save_alloc_size, s3
-      s_add_u32 s_save_mem_offset, s_save_mem_offset, m0
-      s_lshr_b32 s_save_alloc_size, s_save_alloc_size, 9   // how many 128=
 trunks...
-      s_sub_u32 s_save_alloc_size, 128, s_save_alloc_size   // store from =
higheset addr to lowest
-      s_mul_i32 s_save_alloc_size, s_save_alloc_size, 6*4   // PC offset i=
ncrement,  each LDS save block cost 6*4 Bytes instruction
-      s_add_u32 s_save_alloc_size, s_save_alloc_size, 3*4   //2is the belo=
w 2 inst...//s_addc and s_setpc
-      s_nop 0
-      s_nop 0
-      s_nop 0   //pad 3 dw to let LDS_DMA align with 64Bytes
-      s_getpc_b64 s[0:1]                              // reuse s[0:1], sin=
ce s[0:1] already saved
-      s_add_u32   s0, s0,s_save_alloc_size
-      s_addc_u32  s1, s1, 0
-      s_setpc_b64 s[0:1]
-
-
-       for var i =3D0; i< 128; i++
-            // be careful to make here a 64Byte aligned address, which cou=
ld improve performance...
-            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds=
:1 offset:0           // first 64DW
-            buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds=
:1 offset:256           // second 64DW
-
-        if i!=3D127
-        s_sub_u32  m0, m0, s3      // use a sgpr to shrink 2DW-inst to 1DW=
 inst to improve performance , i.e.  pack more LDS_DMA inst to one Cachelin=
e
-            s_sub_u32  s_save_mem_offset, s_save_mem_offset,  s3
-            end
-       end
-
-else   // BUFFER_STORE
       v_mbcnt_lo_u32_b32 v2, 0xffffffff, 0x0
       v_mbcnt_hi_u32_b32 v3, 0xffffffff, v2     // tid
       v_mul_i32_i24 v2, v3, 8   // tid*8
@@ -628,8 +413,6 @@ L_SAVE_LDS_LOOP_VECTOR:
       // restore rsrc3
       s_mov_b32 s_save_buf_rsrc3, s0

-end
-
 L_SAVE_LDS_DONE:


@@ -647,44 +430,8 @@ L_SAVE_LDS_DONE:
     s_add_u32       s_save_alloc_size, s_save_alloc_size, 1
     s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 2               =
          //Number of VGPRs =3D (vgpr_size + 1) * 4    (non-zero value)   /=
/FIXME for GFX, zero is possible
     s_lshl_b32      s_save_buf_rsrc2,  s_save_alloc_size, 8               =
          //NUM_RECORDS in bytes (64 threads*4)
-    if (SWIZZLE_EN)
-        s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0           =
          //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end
-
-
-    // VGPR Allocated in 4-GPR granularity
-
-if G8SR_VGPR_SR_IN_DWX4
-        // the const stride for DWx4 is 4*4 bytes
-        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // rese=
t const stride to 0
-        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_W=
ORD1_STRIDE_DWx4  // const stride to 4*4 bytes
-
-        s_mov_b32         m0, 4     // skip first 4 VGPRs
-        s_cmp_lt_u32      m0, s_save_alloc_size
-        s_cbranch_scc0    L_SAVE_VGPR_LOOP_END      // no more vgprs

-        s_set_gpr_idx_on  m0, 0x1   // This will change M0
-        s_add_u32         s_save_alloc_size, s_save_alloc_size, 0x1000  //=
 because above inst change m0
-L_SAVE_VGPR_LOOP:
-        v_mov_b32         v0, v0   // v0 =3D v[0+m0]
-        v_mov_b32         v1, v1
-        v_mov_b32         v2, v2
-        v_mov_b32         v3, v3
-
-
-        buffer_store_dwordx4 v0, v0, s_save_buf_rsrc0, s_save_mem_offset s=
lc:1 glc:1
-        s_add_u32         m0, m0, 4
-        s_add_u32         s_save_mem_offset, s_save_mem_offset, 256*4
-        s_cmp_lt_u32      m0, s_save_alloc_size
-    s_cbranch_scc1  L_SAVE_VGPR_LOOP                                      =
          //VGPR save is complete?
-    s_set_gpr_idx_off
-L_SAVE_VGPR_LOOP_END:
-
-        s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // rese=
t const stride to 0
-        s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD=
1_STRIDE  // reset const stride to 4 bytes
-else
     // VGPR store using dw burst
     s_mov_b32         m0, 0x4   //VGPR initial index value =3D0
     s_cmp_lt_u32      m0, s_save_alloc_size
@@ -700,52 +447,18 @@ else
     v_mov_b32       v2, v2              //v0 =3D v[0+m0]
     v_mov_b32       v3, v3              //v0 =3D v[0+m0]

-    if(USE_MTBUF_INSTEAD_OF_MUBUF)
-        tbuffer_store_format_x v0, v0, s_save_buf_rsrc0, s_save_mem_offset=
 format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:1
-    else
         buffer_store_dword v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1
         buffer_store_dword v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256
         buffer_store_dword v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*2
         buffer_store_dword v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*3
-    end

     s_add_u32       m0, m0, 4                                             =
          //next vgpr index
     s_add_u32       s_save_mem_offset, s_save_mem_offset, 256*4           =
          //every buffer_store_dword does 256 bytes
     s_cmp_lt_u32    m0, s_save_alloc_size                                 =
          //scc =3D (m0 < s_save_alloc_size) ? 1 : 0
     s_cbranch_scc1  L_SAVE_VGPR_LOOP                                      =
          //VGPR save is complete?
     s_set_gpr_idx_off
-end

 L_SAVE_VGPR_END:
-
-
-
-
-
-
-    /*     S_PGM_END_SAVED  */                              //FIXME  graph=
ics ONLY
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_SAVE_NORMAL_EXIT))
-        s_and_b32 s_save_pc_hi, s_save_pc_hi, 0x0000ffff    //pc[47:32]
-        s_add_u32 s_save_pc_lo, s_save_pc_lo, 4             //pc[31:0]+4
-        s_addc_u32 s_save_pc_hi, s_save_pc_hi, 0x0          //carry bit ov=
er
-        s_rfe_b64 s_save_pc_lo                              //Return to th=
e main shader program
-    else
-    end
-
-// Save Done timestamp
-if G8SR_DEBUG_TIMESTAMP
-        s_memrealtime   s_g8sr_ts_save_d
-        // SGPR SR memory offset : size(VGPR)
-        get_vgpr_size_bytes(s_save_mem_offset)
-        s_add_u32 s_save_mem_offset, s_save_mem_offset, G8SR_DEBUG_TS_SAVE=
_D_OFFSET
-        s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
-        // Need reset rsrc2??
-        s_mov_b32 m0, s_save_mem_offset
-        s_mov_b32 s_save_buf_rsrc2,  0x1000000                            =
      //NUM_RECORDS in bytes
-        s_buffer_store_dwordx2 s_g8sr_ts_save_d, s_save_buf_rsrc0, m0     =
  glc:1
-end
-
-
     s_branch    L_END_PGM


@@ -756,27 +469,6 @@ end

 L_RESTORE:
     /*      Setup Resource Contants    */
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))
-        //calculate wd_addr using absolute thread id
-        v_readlane_b32 s_restore_tmp, v9, 0
-        s_lshr_b32 s_restore_tmp, s_restore_tmp, 6
-        s_mul_i32 s_restore_tmp, s_restore_tmp, WAVE_SPACE
-        s_add_i32 s_restore_spi_init_lo, s_restore_tmp, WG_BASE_ADDR_LO
-        s_mov_b32 s_restore_spi_init_hi, WG_BASE_ADDR_HI
-        s_and_b32 s_restore_spi_init_hi, s_restore_spi_init_hi, CTX_RESTOR=
E_CONTROL
-    else
-    end
-
-if G8SR_DEBUG_TIMESTAMP
-        s_memrealtime   s_g8sr_ts_restore_s
-        s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
-        // tma_lo/hi are sgpr 110, 111, which will not used for 112 SGPR a=
llocated case...
-        s_mov_b32 s_restore_pc_lo, s_g8sr_ts_restore_s[0]
-        s_mov_b32 s_restore_pc_hi, s_g8sr_ts_restore_s[1]   //backup ts to=
 ttmp0/1, sicne exec will be finally restored..
-end
-
-
-
     s_mov_b32       s_restore_buf_rsrc0,    s_restore_spi_init_lo         =
                                                  //base_addr_lo
     s_and_b32       s_restore_buf_rsrc1,    s_restore_spi_init_hi, 0x0000F=
FFF                                               //base_addr_hi
     s_or_b32        s_restore_buf_rsrc1,    s_restore_buf_rsrc1,  S_RESTOR=
E_BUF_RSRC_WORD1_STRIDE
@@ -818,18 +510,12 @@ end
     s_add_u32  s_restore_mem_offset, s_restore_mem_offset, get_hwreg_size_=
bytes()            //FIXME, Check if offset overflow???


-    if (SWIZZLE_EN)
-        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0     =
                  //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end
     s_mov_b32       m0, 0x0                                               =
                  //lds_offset initial value =3D 0

   L_RESTORE_LDS_LOOP:
-    if (SAVE_LDS)
         buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_off=
set lds:1                    // first 64DW
         buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_off=
set lds:1 offset:256         // second 64DW
-    end
     s_add_u32       m0, m0, 256*2                                         =
      // 128 DW
     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256*2     =
      //mem offset increased by 128DW
     s_cmp_lt_u32    m0, s_restore_alloc_size                              =
      //scc=3D(m0 < s_restore_alloc_size) ? 1 : 0
@@ -848,40 +534,8 @@ end
     s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 1
     s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 2         =
                  //Number of VGPRs =3D (vgpr_size + 1) * 4    (non-zero va=
lue)
     s_lshl_b32      s_restore_buf_rsrc2,  s_restore_alloc_size, 8         =
                  //NUM_RECORDS in bytes (64 threads*4)
-    if (SWIZZLE_EN)
-        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0     =
                  //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end
-
-if G8SR_VGPR_SR_IN_DWX4
-     get_vgpr_size_bytes(s_restore_mem_offset)
-     s_sub_u32         s_restore_mem_offset, s_restore_mem_offset, 256*4
-
-     // the const stride for DWx4 is 4*4 bytes
-     s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc1, 0x0000FFFF   // r=
eset const stride to 0
-     s_or_b32  s_restore_buf_rsrc1, s_restore_buf_rsrc1, G8SR_RESTORE_BUF_=
RSRC_WORD1_STRIDE_DWx4  // const stride to 4*4 bytes
-
-     s_mov_b32         m0, s_restore_alloc_size
-     s_set_gpr_idx_on  m0, 0x8    // Note.. This will change m0
-
-L_RESTORE_VGPR_LOOP:
-     buffer_load_dwordx4 v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset=
 slc:1 glc:1
-     s_waitcnt vmcnt(0)
-     s_sub_u32         m0, m0, 4
-     v_mov_b32         v0, v0   // v[0+m0] =3D v0
-     v_mov_b32         v1, v1
-     v_mov_b32         v2, v2
-     v_mov_b32         v3, v3
-     s_sub_u32         s_restore_mem_offset, s_restore_mem_offset, 256*4
-     s_cmp_eq_u32      m0, 0x8000
-     s_cbranch_scc0    L_RESTORE_VGPR_LOOP
-     s_set_gpr_idx_off
-
-     s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc1, 0x0000FFFF   // r=
eset const stride to 0
-     s_or_b32  s_restore_buf_rsrc1, s_restore_buf_rsrc1, S_RESTORE_BUF_RSR=
C_WORD1_STRIDE  // const stride to 4*4 bytes
-
-else
+
     // VGPR load using dw burst
     s_mov_b32       s_restore_mem_offset_save, s_restore_mem_offset     //=
 restore start with v1, v0 will be the last
     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256*4
@@ -890,14 +544,10 @@ else
     s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 0x8000    =
                  //add 0x8000 since we compare m0 against it later

   L_RESTORE_VGPR_LOOP:
-    if(USE_MTBUF_INSTEAD_OF_MUBUF)
-        tbuffer_load_format_x v0, v0, s_restore_buf_rsrc0, s_restore_mem_o=
ffset format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:1
-    else
         buffer_load_dword v0, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t slc:1 glc:1
         buffer_load_dword v1, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t slc:1 glc:1 offset:256
         buffer_load_dword v2, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t slc:1 glc:1 offset:256*2
         buffer_load_dword v3, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t slc:1 glc:1 offset:256*3
-    end
     s_waitcnt       vmcnt(0)                                              =
                  //ensure data ready
     v_mov_b32       v0, v0                                                =
                  //v[0+m0] =3D v0
     v_mov_b32       v1, v1
@@ -909,16 +559,10 @@ else
     s_cbranch_scc1  L_RESTORE_VGPR_LOOP                                   =
                  //VGPR restore (except v0) is complete?
     s_set_gpr_idx_off
                                                                           =
                  /* VGPR restore on v0 */
-    if(USE_MTBUF_INSTEAD_OF_MUBUF)
-        tbuffer_load_format_x v0, v0, s_restore_buf_rsrc0, s_restore_mem_o=
ffset_save format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc=
:1
-    else
         buffer_load_dword v0, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1
         buffer_load_dword v1, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1 offset:256
         buffer_load_dword v2, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1 offset:256*2
         buffer_load_dword v3, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1 offset:256*3
-    end
-
-end

     /*          restore SGPRs       */
     //////////////////////////////
@@ -934,16 +578,8 @@ end
     s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 1
     s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 4         =
                  //Number of SGPRs =3D (sgpr_size + 1) * 16   (non-zero va=
lue)

-    if (SGPR_SAVE_USE_SQC)
         s_lshl_b32      s_restore_buf_rsrc2,    s_restore_alloc_size, 2   =
                  //NUM_RECORDS in bytes
-    else
-        s_lshl_b32      s_restore_buf_rsrc2,    s_restore_alloc_size, 8   =
                  //NUM_RECORDS in bytes (64 threads)
-    end
-    if (SWIZZLE_EN)
-        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0     =
                  //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end

     /* If 112 SGPRs ar allocated, 4 sgprs are not used TBA(108,109),TMA(11=
0,111),
        However, we are safe to restore these 4 SGPRs anyway, since TBA,TMA=
 will later be restored by HWREG
@@ -972,12 +608,6 @@ end
     //////////////////////////////
   L_RESTORE_HWREG:

-
-if G8SR_DEBUG_TIMESTAMP
-      s_mov_b32 s_g8sr_ts_restore_s[0], s_restore_pc_lo
-      s_mov_b32 s_g8sr_ts_restore_s[1], s_restore_pc_hi
-end
-
     // HWREG SR memory offset : size(VGPR)+size(SGPR)
     get_vgpr_size_bytes(s_restore_mem_offset)
     get_sgpr_size_bytes(s_restore_tmp)
@@ -985,11 +615,7 @@ end


     s_mov_b32       s_restore_buf_rsrc2, 0x4                              =
                  //NUM_RECORDS   in bytes
-    if (SWIZZLE_EN)
-        s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0     =
                  //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end

     read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0, s_restore_mem_o=
ffset)                    //M0
     read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0, s_restore_me=
m_offset)             //PC
@@ -1006,16 +632,6 @@ end

     s_waitcnt       lgkmcnt(0)                                            =
                                          //from now on, it is safe to rest=
ore STATUS and IB_STS

-    //for normal save & restore, the saved PC points to the next inst to e=
xecute, no adjustment needs to be made, otherwise:
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))
-        s_add_u32 s_restore_pc_lo, s_restore_pc_lo, 8            //pc[31:0=
]+8     //two back-to-back s_trap are used (first for save and second for r=
estore)
-        s_addc_u32  s_restore_pc_hi, s_restore_pc_hi, 0x0        //carry b=
it over
-    end
-    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_RESTORE_NORMAL))
-        s_add_u32 s_restore_pc_lo, s_restore_pc_lo, 4            //pc[31:0=
]+4     // save is hack through s_trap but restore is normal
-        s_addc_u32  s_restore_pc_hi, s_restore_pc_hi, 0x0        //carry b=
it over
-    end
-
     s_mov_b32       m0,         s_restore_m0
     s_mov_b32       exec_lo,    s_restore_exec_lo
     s_mov_b32       exec_hi,    s_restore_exec_hi
@@ -1048,11 +664,6 @@ end

     s_barrier                                                   //barrier =
to ensure the readiness of LDS before access attempts from any other wave i=
n the same TG //FIXME not performance-optimal at this time

-if G8SR_DEBUG_TIMESTAMP
-    s_memrealtime s_g8sr_ts_restore_d
-    s_waitcnt lgkmcnt(0)
-end
-
 //  s_rfe_b64 s_restore_pc_lo                                   //Return t=
o the main shader program and resume execution
     s_rfe_restore_b64  s_restore_pc_lo, s_restore_m0            // s_resto=
re_m0[0] is used to set STATUS.inst_atc

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/driver=
s/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index cee4cfd..75f29d1 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -24,75 +24,6 @@
  * PROJECT=3Dgreenland ./sp3 cwsr_trap_handler_gfx9.asm -hex tmp.hex
  */

-/* HW (GFX9) source code for CWSR trap handler */
-/* Version 18 + multiple trap handler */
-
-// this performance-optimal version was originally from Seven Xu at SRDC
-
-// Revison #18  --...
-/* Rev History
-** #1. Branch from gc dv.   //gfxip/gfx9/main/src/test/suites/block/cs/sr/=
cs_trap_handler.sp3#1,#50, #51, #52-53(Skip, Already Fixed by PV), #54-56(m=
erged),#57-58(mergerd, skiped-already fixed by PV)
-** #4. SR Memory Layout:
-**                      1. VGPR-SGPR-HWREG-{LDS}
-**                      2. tba_hi.bits.26 - reconfigured as the first wave=
 in tg bits, for defer Save LDS for a threadgroup.. performance concern..
-** #5. Update: 1. Accurate g8sr_ts_save_d timestamp
-** #6. Update: 1. Fix s_barrier usage; 2. VGPR s/r using swizzle buffer?(N=
oNeed, already matched the swizzle pattern, more investigation)
-** #7. Update: 1. don't barrier if noLDS
-** #8. Branch: 1. Branch to ver#0, which is very similar to gc dv version
-**            2. Fix SQ issue by s_sleep 2
-** #9. Update: 1. Fix scc restore failed issue, restore wave_status at las=
t
-**            2. optimize s_buffer save by burst 16sgprs...
-** #10. Update 1. Optimize restore sgpr by busrt 16 sgprs.
-** #11. Update 1. Add 2 more timestamp for debug version
-** #12. Update 1. Add VGPR SR using DWx4, some case improve and some case =
drop performance
-** #13. Integ  1. Always use MUBUF for PV trap shader...
-** #14. Update 1. s_buffer_store soft clause...
-** #15. Update 1. PERF - sclar write with glc:0/mtype0 to allow L2 combine=
. perf improvement a lot.
-** #16. Update 1. PRRF - UNROLL LDS_DMA got 2500cycle save in IP tree
-** #17. Update 1. FUNC - LDS_DMA has issues while ATC, replace with ds_rea=
d/buffer_store for save part[TODO restore part]
-**            2. PERF - Save LDS before save VGPR to cover LDS save long l=
atency...
-** #18. Update 1. FUNC - Implicitly estore STATUS.VCCZ, which is not writa=
ble by s_setreg_b32
-**            2. FUNC - Handle non-CWSR traps
-*/
-
-var G8SR_WDMEM_HWREG_OFFSET =3D 0
-var G8SR_WDMEM_SGPR_OFFSET  =3D 128  // in bytes
-
-// Keep definition same as the app shader, These 2 time stamps are part of=
 the app shader... Should before any Save and after restore.
-
-var G8SR_DEBUG_TIMESTAMP =3D 0
-var G8SR_DEBUG_TS_SAVE_D_OFFSET =3D 40*4 // ts_save_d timestamp offset rel=
ative to SGPR_SR_memory_offset
-var s_g8sr_ts_save_s   =3D s[34:35]   // save start
-var s_g8sr_ts_sq_save_msg  =3D s[36:37]  // The save shader send SAVEWAVE =
msg to spi
-var s_g8sr_ts_spi_wrexec   =3D s[38:39]  // the SPI write the sr address t=
o SQ
-var s_g8sr_ts_save_d   =3D s[40:41]   // save end
-var s_g8sr_ts_restore_s =3D s[42:43]   // restore start
-var s_g8sr_ts_restore_d =3D s[44:45]   // restore end
-
-var G8SR_VGPR_SR_IN_DWX4 =3D 0
-var G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4 =3D 0x00100000   // DWx4 stride i=
s 4*4Bytes
-var G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4  =3D G8SR_SAVE_BUF_RSRC_WORD1_=
STRIDE_DWx4
-
-
-/*************************************************************************=
/
-/*                 control on how to run the shader                      *=
/
-/*************************************************************************=
/
-//any hack that needs to be made to run this code in EMU (either because v=
arious EMU code are not ready or no compute save & restore in EMU run)
-var EMU_RUN_HACK                   =3D    0
-var EMU_RUN_HACK_RESTORE_NORMAL            =3D    0
-var EMU_RUN_HACK_SAVE_NORMAL_EXIT   =3D  0
-var EMU_RUN_HACK_SAVE_SINGLE_WAVE   =3D  0
-var EMU_RUN_HACK_SAVE_FIRST_TIME    =3D  0                   //for interru=
pted restore in which the first save is through EMU_RUN_HACK
-var SAVE_LDS                       =3D    1
-var WG_BASE_ADDR_LO                =3D    0x9000a000
-var WG_BASE_ADDR_HI                =3D    0x0
-var WAVE_SPACE                     =3D    0x5000              //memory siz=
e that each wave occupies in workgroup state mem
-var CTX_SAVE_CONTROL               =3D    0x0
-var CTX_RESTORE_CONTROL                    =3D    CTX_SAVE_CONTROL
-var SIM_RUN_HACK                   =3D    0                   //any hack t=
hat needs to be made to run this code in SIM (either because various RTL co=
de are not ready or no compute save & restore in RTL run)
-var SGPR_SAVE_USE_SQC              =3D    1                   //use SQC D$=
 to do the write
-var USE_MTBUF_INSTEAD_OF_MUBUF     =3D    0                   //because TC=
 EMU currently asserts on 0 of // overload DFMT field to carry 4 more bits =
of stride for MUBUF opcodes
-var SWIZZLE_EN                     =3D    0                   //whether we=
 use swizzled buffer addressing
 var ACK_SQC_STORE                   =3D    1                   //workaroun=
d for suspected SQC store bug causing incorrect stores under concurrency
 var SAVE_AFTER_XNACK_ERROR          =3D    1                   //workaroun=
d for TCP store failure after XNACK error when ALLOW_REPLAY=3D0, for debugg=
er
 var SINGLE_STEP_MISSED_WORKAROUND   =3D   1                   //workaround=
 for lost MODE.DEBUG_EN exception when SAVECTX raised
@@ -238,16 +169,7 @@ shader main
   type(CS)


-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))                 =
 //hack to use trap_id for determining save/restore
-       //FIXME VCCZ un-init assertion s_getreg_b32     s_save_status, hwre=
g(HW_REG_STATUS)         //save STATUS since we will change SCC
-       s_and_b32 s_save_tmp, s_save_pc_hi, 0xffff0000              //chang=
e SCC
-       s_cmp_eq_u32 s_save_tmp, 0x007e0000                         //Save:=
 trap_id =3D 0x7e. Restore: trap_id =3D 0x7f.
-       s_cbranch_scc0 L_JUMP_TO_RESTORE                            //do no=
t need to recover STATUS here  since we are going to RESTORE
-       //FIXME  s_setreg_b32    hwreg(HW_REG_STATUS),   s_save_status     =
  //need to recover STATUS since we are going to SAVE
-       s_branch L_SKIP_RESTORE                                     //NOT r=
estore, SAVE actually
-    else
         s_branch L_SKIP_RESTORE                                     //NOT =
restore. might be a regular trap or save
-    end

 L_JUMP_TO_RESTORE:
     s_branch L_RESTORE                                             //resto=
re
@@ -278,7 +200,7 @@ end
     s_cbranch_scc1  L_SAVE                                     //this is t=
he operation for save

     // *********    Handle non-CWSR traps      *******************
-if (!EMU_RUN_HACK)
+
     // Illegal instruction is a non-maskable exception which blocks contex=
t save.
     // Halt the wavefront and return from the trap.
     s_and_b32       ttmp2, s_save_trapsts, SQ_WAVE_TRAPSTS_ILLEGAL_INST_MA=
SK
@@ -355,7 +277,7 @@ L_EXCP_CASE:
     set_status_without_spi_prio(s_save_status, ttmp2)

     s_rfe_b64       [ttmp0, ttmp1]
-end
+
     // *********       End handling of non-CWSR traps   ******************=
*

 /*************************************************************************=
*/
@@ -363,12 +285,6 @@ end
 /*************************************************************************=
*/

 L_SAVE:
-
-if G8SR_DEBUG_TIMESTAMP
-       s_memrealtime   s_g8sr_ts_save_s
-       s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
-end
-
     s_and_b32      s_save_pc_hi, s_save_pc_hi, 0x0000ffff    //pc[47:32]

     s_mov_b32      s_save_tmp, 0                                          =
                  //clear saveCtx bit
@@ -390,16 +306,7 @@ end
     s_mov_b32      s_save_exec_hi, exec_hi
     s_mov_b64      exec,   0x0                                            =
                  //clear EXEC to get ready to receive

-if G8SR_DEBUG_TIMESTAMP
-       s_memrealtime  s_g8sr_ts_sq_save_msg
-       s_waitcnt lgkmcnt(0)
-end
-
-    if (EMU_RUN_HACK)
-
-    else
         s_sendmsg   sendmsg(MSG_SAVEWAVE)  //send SPI a message and wait f=
or SPI's write to EXEC
-    end

     // Set SPI_PRIO=3D2 to avoid starving instruction fetch in the waves w=
e're waiting for.
     s_or_b32 s_save_tmp, s_save_status, (2 << SQ_WAVE_STATUS_SPI_PRIO_SHIF=
T)
@@ -408,33 +315,7 @@ end
   L_SLEEP:
     s_sleep 0x2                       // sleep 1 (64clk) is not enough for=
 8 waves per SIMD, which will cause SQ hang, since the 7,8th wave could not=
 get arbit to exec inst, while other waves are stuck into the sleep-loop an=
d waiting for wrexec!=3D0

-    if (EMU_RUN_HACK)
-
-    else
         s_cbranch_execz L_SLEEP
-    end
-
-if G8SR_DEBUG_TIMESTAMP
-       s_memrealtime  s_g8sr_ts_spi_wrexec
-       s_waitcnt lgkmcnt(0)
-end
-
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_SAVE_SINGLE_WAVE))
-       //calculate wd_addr using absolute thread id
-       v_readlane_b32 s_save_tmp, v9, 0
-       s_lshr_b32 s_save_tmp, s_save_tmp, 6
-       s_mul_i32 s_save_tmp, s_save_tmp, WAVE_SPACE
-       s_add_i32 s_save_spi_init_lo, s_save_tmp, WG_BASE_ADDR_LO
-       s_mov_b32 s_save_spi_init_hi, WG_BASE_ADDR_HI
-       s_and_b32 s_save_spi_init_hi, s_save_spi_init_hi, CTX_SAVE_CONTROL
-    else
-    end
-    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_SAVE_SINGLE_WAVE))
-       s_add_i32 s_save_spi_init_lo, s_save_tmp, WG_BASE_ADDR_LO
-       s_mov_b32 s_save_spi_init_hi, WG_BASE_ADDR_HI
-       s_and_b32 s_save_spi_init_hi, s_save_spi_init_hi, CTX_SAVE_CONTROL
-    else
-    end

     // Save trap temporaries 4-11, 13 initialized by SPI debug dispatch lo=
gic
     // ttmp SR memory offset : size(VGPR)+size(SGPR)+0x40
@@ -484,20 +365,10 @@ end


     s_mov_b32      s_save_buf_rsrc2, 0x4                                //=
NUM_RECORDS   in bytes
-    if (SWIZZLE_EN)
-       s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0            =
         //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end


     write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)    =
             //M0
-
-    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_SAVE_FIRST_TIME))
-       s_add_u32 s_save_pc_lo, s_save_pc_lo, 4             //pc[31:0]+4
-       s_addc_u32 s_save_pc_hi, s_save_pc_hi, 0x0          //carry bit ove=
r
-    end
-
     write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0, s_save_mem_offset) =
                 //PC
     write_hwreg_to_mem(s_save_pc_hi, s_save_buf_rsrc0, s_save_mem_offset)
     write_hwreg_to_mem(s_save_exec_lo, s_save_buf_rsrc0, s_save_mem_offset=
)            //EXEC
@@ -535,17 +406,9 @@ end
     s_add_u32      s_save_alloc_size, s_save_alloc_size, 1
     s_lshl_b32     s_save_alloc_size, s_save_alloc_size, 4                =
          //Number of SGPRs =3D (sgpr_size + 1) * 16   (non-zero value)

-    if (SGPR_SAVE_USE_SQC)
         s_lshl_b32      s_save_buf_rsrc2,   s_save_alloc_size, 2          =
          //NUM_RECORDS in bytes
-    else
-       s_lshl_b32      s_save_buf_rsrc2,   s_save_alloc_size, 8           =
         //NUM_RECORDS in bytes (64 threads)
-    end

-    if (SWIZZLE_EN)
-       s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0            =
         //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end


     // backup s_save_buf_rsrc0,1 to s_save_pc_lo/hi, since write_16sgpr_to=
_mem function will change the rsrc0
@@ -588,25 +451,11 @@ end
     s_mov_b32      xnack_mask_lo, 0x0
     s_mov_b32      xnack_mask_hi, 0x0

-    if (SWIZZLE_EN)
-       s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0            =
         //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end


     // VGPR Allocated in 4-GPR granularity

-if G8SR_VGPR_SR_IN_DWX4
-       // the const stride for DWx4 is 4*4 bytes
-       s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset=
 const stride to 0
-       s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WO=
RD1_STRIDE_DWx4  // const stride to 4*4 bytes
-
-       buffer_store_dwordx4 v0, v0, s_save_buf_rsrc0, s_save_mem_offset sl=
c:1 glc:1
-
-       s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset=
 const stride to 0
-       s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1=
_STRIDE  // reset const stride to 4 bytes
-else
 if SAVE_AFTER_XNACK_ERROR
         check_if_tcp_store_ok()
         s_cbranch_scc1 L_SAVE_FIRST_VGPRS_WITH_TCP
@@ -621,7 +470,6 @@ end
         buffer_store_dword v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256
         buffer_store_dword v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*2
         buffer_store_dword v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*3
-end



@@ -656,64 +504,11 @@ end
     s_add_u32 s_save_mem_offset, s_save_mem_offset, get_hwreg_size_bytes()


-    if (SWIZZLE_EN)
-       s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0       //FIX=
ME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                  //NU=
M_RECORDS in bytes
-    end

     s_mov_b32      m0, 0x0                                                =
//lds_offset initial value =3D 0


-var LDS_DMA_ENABLE =3D 0
-var UNROLL =3D 0
-if UNROLL=3D=3D0 && LDS_DMA_ENABLE=3D=3D1
-       s_mov_b32  s3, 256*2
-       s_nop 0
-       s_nop 0
-       s_nop 0
-  L_SAVE_LDS_LOOP:
-       //TODO: looks the 2 buffer_store/load clause for s/r will hurt perf=
ormance.???
-    if (SAVE_LDS)     //SPI always alloc LDS space in 128DW granularity
-           buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:=
1             // first 64DW
-           buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:=
1 offset:256 // second 64DW
-    end
-
-    s_add_u32      m0, m0, s3                                           //=
every buffer_store_lds does 256 bytes
-    s_add_u32      s_save_mem_offset, s_save_mem_offset, s3               =
              //mem offset increased by 256 bytes
-    s_cmp_lt_u32    m0, s_save_alloc_size                                 =
             //scc=3D(m0 < s_save_alloc_size) ? 1 : 0
-    s_cbranch_scc1  L_SAVE_LDS_LOOP                                       =
             //LDS save is complete?
-
-elsif LDS_DMA_ENABLE=3D=3D1 && UNROLL=3D=3D1 // UNROOL , has ichace miss
-      // store from higest LDS address to lowest
-      s_mov_b32         s3, 256*2
-      s_sub_u32         m0, s_save_alloc_size, s3
-      s_add_u32 s_save_mem_offset, s_save_mem_offset, m0
-      s_lshr_b32 s_save_alloc_size, s_save_alloc_size, 9   // how many 128=
 trunks...
-      s_sub_u32 s_save_alloc_size, 128, s_save_alloc_size   // store from =
higheset addr to lowest
-      s_mul_i32 s_save_alloc_size, s_save_alloc_size, 6*4   // PC offset i=
ncrement,  each LDS save block cost 6*4 Bytes instruction
-      s_add_u32 s_save_alloc_size, s_save_alloc_size, 3*4   //2is the belo=
w 2 inst...//s_addc and s_setpc
-      s_nop 0
-      s_nop 0
-      s_nop 0  //pad 3 dw to let LDS_DMA align with 64Bytes
-      s_getpc_b64 s[0:1]                             // reuse s[0:1], sinc=
e s[0:1] already saved
-      s_add_u32          s0, s0,s_save_alloc_size
-      s_addc_u32  s1, s1, 0
-      s_setpc_b64 s[0:1]
-
-
-       for var i =3D0; i< 128; i++
-           // be careful to make here a 64Byte aligned address, which coul=
d improve performance...
-           buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:=
1 offset:0            // first 64DW
-           buffer_store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:=
1 offset:256            // second 64DW
-
-       if i!=3D127
-       s_sub_u32  m0, m0, s3      // use a sgpr to shrink 2DW-inst to 1DW =
inst to improve performance , i.e.  pack more LDS_DMA inst to one Cacheline
-           s_sub_u32  s_save_mem_offset, s_save_mem_offset,  s3
-           end
-       end
-
-else   // BUFFER_STORE
       v_mbcnt_lo_u32_b32 v2, 0xffffffff, 0x0
       v_mbcnt_hi_u32_b32 v3, 0xffffffff, v2    // tid

@@ -757,8 +552,6 @@ L_SAVE_LDS_LOOP_VECTOR:
       // restore rsrc3
       s_mov_b32 s_save_buf_rsrc3, s0

-end
-
 L_SAVE_LDS_DONE:


@@ -776,44 +569,9 @@ L_SAVE_LDS_DONE:
     s_add_u32      s_save_alloc_size, s_save_alloc_size, 1
     s_lshl_b32     s_save_alloc_size, s_save_alloc_size, 2                =
          //Number of VGPRs =3D (vgpr_size + 1) * 4    (non-zero value)    =
//FIXME for GFX, zero is possible
     s_lshl_b32     s_save_buf_rsrc2,  s_save_alloc_size, 8                =
          //NUM_RECORDS in bytes (64 threads*4)
-    if (SWIZZLE_EN)
-       s_add_u32       s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0            =
         //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_save_buf_rsrc2,  0x1000000                      =
          //NUM_RECORDS in bytes
-    end


-    // VGPR Allocated in 4-GPR granularity
-
-if G8SR_VGPR_SR_IN_DWX4
-       // the const stride for DWx4 is 4*4 bytes
-       s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset=
 const stride to 0
-       s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WO=
RD1_STRIDE_DWx4  // const stride to 4*4 bytes
-
-       s_mov_b32         m0, 4      // skip first 4 VGPRs
-       s_cmp_lt_u32      m0, s_save_alloc_size
-       s_cbranch_scc0    L_SAVE_VGPR_LOOP_END       // no more vgprs
-
-       s_set_gpr_idx_on  m0, 0x1   // This will change M0
-       s_add_u32         s_save_alloc_size, s_save_alloc_size, 0x1000   //=
 because above inst change m0
-L_SAVE_VGPR_LOOP:
-       v_mov_b32         v0, v0   // v0 =3D v[0+m0]
-       v_mov_b32         v1, v1
-       v_mov_b32         v2, v2
-       v_mov_b32         v3, v3
-
-
-       buffer_store_dwordx4 v0, v0, s_save_buf_rsrc0, s_save_mem_offset sl=
c:1 glc:1
-       s_add_u32         m0, m0, 4
-       s_add_u32         s_save_mem_offset, s_save_mem_offset, 256*4
-       s_cmp_lt_u32      m0, s_save_alloc_size
-    s_cbranch_scc1  L_SAVE_VGPR_LOOP                                      =
         //VGPR save is complete?
-    s_set_gpr_idx_off
-L_SAVE_VGPR_LOOP_END:
-
-       s_and_b32 s_save_buf_rsrc1, s_save_buf_rsrc1, 0x0000FFFF   // reset=
 const stride to 0
-       s_or_b32  s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1=
_STRIDE  // reset const stride to 4 bytes
-else
     // VGPR store using dw burst
     s_mov_b32        m0, 0x4    //VGPR initial index value =3D0
     s_cmp_lt_u32      m0, s_save_alloc_size
@@ -844,21 +602,16 @@ end
     v_mov_b32      v2, v2               //v0 =3D v[0+m0]
     v_mov_b32      v3, v3               //v0 =3D v[0+m0]

-    if(USE_MTBUF_INSTEAD_OF_MUBUF)
-       tbuffer_store_format_x v0, v0, s_save_buf_rsrc0, s_save_mem_offset =
format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:1
-    else
         buffer_store_dword v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1
         buffer_store_dword v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256
         buffer_store_dword v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*2
         buffer_store_dword v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc=
:1 glc:1  offset:256*3
-    end

     s_add_u32      m0, m0, 4                                              =
          //next vgpr index
     s_add_u32      s_save_mem_offset, s_save_mem_offset, 256*4            =
          //every buffer_store_dword does 256 bytes
     s_cmp_lt_u32    m0, s_save_alloc_size                                 =
         //scc =3D (m0 < s_save_alloc_size) ? 1 : 0
     s_cbranch_scc1  L_SAVE_VGPR_LOOP                                      =
         //VGPR save is complete?
     s_set_gpr_idx_off
-end

 L_SAVE_VGPR_END:

@@ -905,29 +658,6 @@ L_SAVE_ACCVGPR_LOOP:
 L_SAVE_ACCVGPR_END:
 end

-    /*    S_PGM_END_SAVED  */                               //FIXME  graph=
ics ONLY
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_SAVE_NORMAL_EXIT))
-       s_and_b32 s_save_pc_hi, s_save_pc_hi, 0x0000ffff    //pc[47:32]
-       s_add_u32 s_save_pc_lo, s_save_pc_lo, 4             //pc[31:0]+4
-       s_addc_u32 s_save_pc_hi, s_save_pc_hi, 0x0          //carry bit ove=
r
-       s_rfe_b64 s_save_pc_lo                              //Return to the=
 main shader program
-    else
-    end
-
-// Save Done timestamp
-if G8SR_DEBUG_TIMESTAMP
-       s_memrealtime   s_g8sr_ts_save_d
-       // SGPR SR memory offset : size(VGPR)
-       get_vgpr_size_bytes(s_save_mem_offset)
-       s_add_u32 s_save_mem_offset, s_save_mem_offset, G8SR_DEBUG_TS_SAVE_=
D_OFFSET
-       s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
-       // Need reset rsrc2??
-       s_mov_b32 m0, s_save_mem_offset
-       s_mov_b32 s_save_buf_rsrc2,  0x1000000                             =
     //NUM_RECORDS in bytes
-       s_buffer_store_dwordx2 s_g8sr_ts_save_d, s_save_buf_rsrc0, m0      =
 glc:1
-end
-
-
     s_branch   L_END_PGM


@@ -938,27 +668,6 @@ end

 L_RESTORE:
     /*     Setup Resource Contants    */
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))
-       //calculate wd_addr using absolute thread id
-       v_readlane_b32 s_restore_tmp, v9, 0
-       s_lshr_b32 s_restore_tmp, s_restore_tmp, 6
-       s_mul_i32 s_restore_tmp, s_restore_tmp, WAVE_SPACE
-       s_add_i32 s_restore_spi_init_lo, s_restore_tmp, WG_BASE_ADDR_LO
-       s_mov_b32 s_restore_spi_init_hi, WG_BASE_ADDR_HI
-       s_and_b32 s_restore_spi_init_hi, s_restore_spi_init_hi, CTX_RESTORE=
_CONTROL
-    else
-    end
-
-if G8SR_DEBUG_TIMESTAMP
-       s_memrealtime   s_g8sr_ts_restore_s
-       s_waitcnt lgkmcnt(0)         //FIXME, will cause xnack??
-       // tma_lo/hi are sgpr 110, 111, which will not used for 112 SGPR al=
located case...
-       s_mov_b32 s_restore_pc_lo, s_g8sr_ts_restore_s[0]
-       s_mov_b32 s_restore_pc_hi, s_g8sr_ts_restore_s[1]   //backup ts to =
ttmp0/1, sicne exec will be finally restored..
-end
-
-
-
     s_mov_b32      s_restore_buf_rsrc0,    s_restore_spi_init_lo          =
                                                  //base_addr_lo
     s_and_b32      s_restore_buf_rsrc1,    s_restore_spi_init_hi, 0x0000FF=
FF                                                //base_addr_hi
     s_or_b32       s_restore_buf_rsrc1,    s_restore_buf_rsrc1,  S_RESTORE=
_BUF_RSRC_WORD1_STRIDE
@@ -1000,18 +709,12 @@ end
     s_add_u32  s_restore_mem_offset, s_restore_mem_offset, get_hwreg_size_=
bytes()           //FIXME, Check if offset overflow???


-    if (SWIZZLE_EN)
-       s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0      =
                 //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end
     s_mov_b32      m0, 0x0                                                =
                  //lds_offset initial value =3D 0

   L_RESTORE_LDS_LOOP:
-    if (SAVE_LDS)
         buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_off=
set lds:1                    // first 64DW
         buffer_load_dword   v0, v0, s_restore_buf_rsrc0, s_restore_mem_off=
set lds:1 offset:256         // second 64DW
-    end
     s_add_u32      m0, m0, 256*2                                          =
      // 128 DW
     s_add_u32      s_restore_mem_offset, s_restore_mem_offset, 256*2      =
      //mem offset increased by 128DW
     s_cmp_lt_u32    m0, s_restore_alloc_size                              =
     //scc=3D(m0 < s_restore_alloc_size) ? 1 : 0
@@ -1035,40 +738,8 @@ if ASIC_TARGET_ARCTURUS
     s_mov_b32      s_restore_accvgpr_offset, s_restore_buf_rsrc2          =
                 //ACC VGPRs at end of VGPRs
 end

-    if (SWIZZLE_EN)
-       s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0      =
                 //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end

-if G8SR_VGPR_SR_IN_DWX4
-     get_vgpr_size_bytes(s_restore_mem_offset)
-     s_sub_u32        s_restore_mem_offset, s_restore_mem_offset, 256*4
-
-     // the const stride for DWx4 is 4*4 bytes
-     s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc1, 0x0000FFFF   // r=
eset const stride to 0
-     s_or_b32  s_restore_buf_rsrc1, s_restore_buf_rsrc1, G8SR_RESTORE_BUF_=
RSRC_WORD1_STRIDE_DWx4  // const stride to 4*4 bytes
-
-     s_mov_b32        m0, s_restore_alloc_size
-     s_set_gpr_idx_on  m0, 0x8   // Note.. This will change m0
-
-L_RESTORE_VGPR_LOOP:
-     buffer_load_dwordx4 v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset=
 slc:1 glc:1
-     s_waitcnt vmcnt(0)
-     s_sub_u32        m0, m0, 4
-     v_mov_b32        v0, v0    // v[0+m0] =3D v0
-     v_mov_b32        v1, v1
-     v_mov_b32        v2, v2
-     v_mov_b32        v3, v3
-     s_sub_u32        s_restore_mem_offset, s_restore_mem_offset, 256*4
-     s_cmp_eq_u32      m0, 0x8000
-     s_cbranch_scc0    L_RESTORE_VGPR_LOOP
-     s_set_gpr_idx_off
-
-     s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc1, 0x0000FFFF   // r=
eset const stride to 0
-     s_or_b32  s_restore_buf_rsrc1, s_restore_buf_rsrc1, S_RESTORE_BUF_RSR=
C_WORD1_STRIDE  // const stride to 4*4 bytes
-
-else
     // VGPR load using dw burst
     s_mov_b32      s_restore_mem_offset_save, s_restore_mem_offset      //=
 restore start with v1, v0 will be the last
     s_add_u32      s_restore_mem_offset, s_restore_mem_offset, 256*4
@@ -1081,9 +752,6 @@ end
     s_add_u32      s_restore_alloc_size, s_restore_alloc_size, 0x8000     =
                  //add 0x8000 since we compare m0 against it later

   L_RESTORE_VGPR_LOOP:
-    if(USE_MTBUF_INSTEAD_OF_MUBUF)
-       tbuffer_load_format_x v0, v0, s_restore_buf_rsrc0, s_restore_mem_of=
fset format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:1
-    else

 if ASIC_TARGET_ARCTURUS
         buffer_load_dword v0, v0, s_restore_buf_rsrc0, s_restore_accvgpr_o=
ffset slc:1 glc:1
@@ -1102,7 +770,6 @@ end
         buffer_load_dword v1, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t slc:1 glc:1 offset:256
         buffer_load_dword v2, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t slc:1 glc:1 offset:256*2
         buffer_load_dword v3, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t slc:1 glc:1 offset:256*3
-    end
     s_waitcnt      vmcnt(0)                                               =
                  //ensure data ready
     v_mov_b32      v0, v0                                                 =
                  //v[0+m0] =3D v0
     v_mov_b32      v1, v1
@@ -1126,16 +793,10 @@ if ASIC_TARGET_ARCTURUS
         end
 end

-    if(USE_MTBUF_INSTEAD_OF_MUBUF)
-       tbuffer_load_format_x v0, v0, s_restore_buf_rsrc0, s_restore_mem_of=
fset_save format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_FORMAT_32 slc:1 glc:=
1
-    else
         buffer_load_dword v0, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1
         buffer_load_dword v1, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1 offset:256
         buffer_load_dword v2, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1 offset:256*2
         buffer_load_dword v3, v0, s_restore_buf_rsrc0, s_restore_mem_offse=
t_save    slc:1 glc:1 offset:256*3
-    end
-
-end

     /*         restore SGPRs       */
     //////////////////////////////
@@ -1151,16 +812,8 @@ end
     s_add_u32      s_restore_alloc_size, s_restore_alloc_size, 1
     s_lshl_b32     s_restore_alloc_size, s_restore_alloc_size, 4          =
                  //Number of SGPRs =3D (sgpr_size + 1) * 16   (non-zero va=
lue)

-    if (SGPR_SAVE_USE_SQC)
         s_lshl_b32      s_restore_buf_rsrc2,    s_restore_alloc_size, 2   =
                  //NUM_RECORDS in bytes
-    else
-       s_lshl_b32      s_restore_buf_rsrc2,    s_restore_alloc_size, 8    =
                 //NUM_RECORDS in bytes (64 threads)
-    end
-    if (SWIZZLE_EN)
-       s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0      =
                 //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end

     s_mov_b32 m0, s_restore_alloc_size

@@ -1188,11 +841,6 @@ end
   L_RESTORE_HWREG:


-if G8SR_DEBUG_TIMESTAMP
-      s_mov_b32 s_g8sr_ts_restore_s[0], s_restore_pc_lo
-      s_mov_b32 s_g8sr_ts_restore_s[1], s_restore_pc_hi
-end
-
     // HWREG SR memory offset : size(VGPR)+size(SGPR)
     get_vgpr_size_bytes(s_restore_mem_offset)
     get_sgpr_size_bytes(s_restore_tmp)
@@ -1200,11 +848,7 @@ end


     s_mov_b32      s_restore_buf_rsrc2, 0x4                               =
                  //NUM_RECORDS   in bytes
-    if (SWIZZLE_EN)
-       s_add_u32       s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0      =
                 //FIXME need to use swizzle to enable bounds checking?
-    else
         s_mov_b32       s_restore_buf_rsrc2,  0x1000000                   =
                  //NUM_RECORDS in bytes
-    end

     read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0, s_restore_mem_o=
ffset)                   //M0
     read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0, s_restore_me=
m_offset)            //PC
@@ -1219,16 +863,6 @@ end

     s_waitcnt      lgkmcnt(0)                                             =
                                          //from now on, it is safe to rest=
ore STATUS and IB_STS

-    //for normal save & restore, the saved PC points to the next inst to e=
xecute, no adjustment needs to be made, otherwise:
-    if ((EMU_RUN_HACK) && (!EMU_RUN_HACK_RESTORE_NORMAL))
-       s_add_u32 s_restore_pc_lo, s_restore_pc_lo, 8            //pc[31:0]=
+8      //two back-to-back s_trap are used (first for save and second for r=
estore)
-       s_addc_u32  s_restore_pc_hi, s_restore_pc_hi, 0x0        //carry bi=
t over
-    end
-    if ((EMU_RUN_HACK) && (EMU_RUN_HACK_RESTORE_NORMAL))
-       s_add_u32 s_restore_pc_lo, s_restore_pc_lo, 4            //pc[31:0]=
+4      // save is hack through s_trap but restore is normal
-       s_addc_u32  s_restore_pc_hi, s_restore_pc_hi, 0x0        //carry bi=
t over
-    end
-
     s_mov_b32      m0,          s_restore_m0
     s_mov_b32      exec_lo,     s_restore_exec_lo
     s_mov_b32      exec_hi,     s_restore_exec_hi
@@ -1275,11 +909,6 @@ end

     s_barrier                                                  //barrier t=
o ensure the readiness of LDS before access attempts from any other wave in=
 the same TG //FIXME not performance-optimal at this time

-if G8SR_DEBUG_TIMESTAMP
-    s_memrealtime s_g8sr_ts_restore_d
-    s_waitcnt lgkmcnt(0)
-end
-
 //  s_rfe_b64 s_restore_pc_lo                                   //Return t=
o the main shader program and resume execution
     s_rfe_restore_b64  s_restore_pc_lo, s_restore_m0           // s_restor=
e_m0[0] is used to set STATUS.inst_atc

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809F67AE6AC298C22F0C484F7C60BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Cornwall, Jay &lt;Jay.Cornwal=
l@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 24, 2019 1:27 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Cornwall, Jay &lt;Jay.Cornwall-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: Remove dead code from gfx8/gfx9 tra=
p handlers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Jay Cornwall &lt;jay.cornwall@amd.c=
om&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm&nbsp; | 395 &#43;--=
------------------<br>
&nbsp;.../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm&nbsp; | 375 &#43;--=
----------------<br>
&nbsp;2 files changed, 5 insertions(&#43;), 765 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm b/driver=
s/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm<br>
index a47f5b9..b195b7c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm<br>
@@ -24,78 &#43;24,6 @@<br>
&nbsp; * PROJECT=3Dvi ./sp3 cwsr_trap_handler_gfx8.asm -hex tmp.hex<br>
&nbsp; */<br>
&nbsp;<br>
-/* HW (VI) source code for CWSR trap handler */<br>
-/* Version 18 &#43; multiple trap handler */<br>
-<br>
-// this performance-optimal version was originally from Seven Xu at SRDC<b=
r>
-<br>
-// Revison #18&nbsp;&nbsp; --...<br>
-/* Rev History<br>
-** #1. Branch from gc dv.&nbsp;&nbsp; //gfxip/gfx8/main/src/test/suites/bl=
ock/cs/sr/cs_trap_handler.sp3#1,#50, #51, #52-53(Skip, Already Fixed by PV)=
, #54-56(merged),#57-58(mergerd, skiped-already fixed by PV)<br>
-** #4. SR Memory Layout:<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 1. VGPR-SGPR-HWREG-{LDS}<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 2. tba_hi.bits.26 - reconfigured as the first wave in tg bits, for defer S=
ave LDS for a threadgroup.. performance concern..<br>
-** #5. Update: 1. Accurate g8sr_ts_save_d timestamp<br>
-** #6. Update: 1. Fix s_barrier usage; 2. VGPR s/r using swizzle buffer?(N=
oNeed, already matched the swizzle pattern, more investigation)<br>
-** #7. Update: 1. don't barrier if noLDS<br>
-** #8. Branch: 1. Branch to ver#0, which is very similar to gc dv version<=
br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 2. Fix SQ issue by s_sleep 2<br>
-** #9. Update: 1. Fix scc restore failed issue, restore wave_status at las=
t<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 2. optimize s_buffer save by burst 16sgprs...<br>
-** #10. Update 1. Optimize restore sgpr by busrt 16 sgprs.<br>
-** #11. Update 1. Add 2 more timestamp for debug version<br>
-** #12. Update 1. Add VGPR SR using DWx4, some case improve and some case =
drop performance<br>
-** #13. Integ&nbsp; 1. Always use MUBUF for PV trap shader...<br>
-** #14. Update 1. s_buffer_store soft clause...<br>
-** #15. Update 1. PERF - sclar write with glc:0/mtype0 to allow L2 combine=
. perf improvement a lot.<br>
-** #16. Update 1. PRRF - UNROLL LDS_DMA got 2500cycle save in IP tree<br>
-** #17. Update 1. FUNC - LDS_DMA has issues while ATC, replace with ds_rea=
d/buffer_store for save part[TODO restore part]<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 2. PERF - Save LDS before save VGPR to cover LDS save long latency...<br>
-** #18. Update 1. FUNC - Implicitly estore STATUS.VCCZ, which is not writa=
ble by s_setreg_b32<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 2. FUNC - Handle non-CWSR traps<br>
-*/<br>
-<br>
-var G8SR_WDMEM_HWREG_OFFSET =3D 0<br>
-var G8SR_WDMEM_SGPR_OFFSET&nbsp; =3D 128&nbsp; // in bytes<br>
-<br>
-// Keep definition same as the app shader, These 2 time stamps are part of=
 the app shader... Should before any Save and after restore.<br>
-<br>
-var G8SR_DEBUG_TIMESTAMP =3D 0<br>
-var G8SR_DEBUG_TS_SAVE_D_OFFSET =3D 40*4&nbsp; // ts_save_d timestamp offs=
et relative to SGPR_SR_memory_offset<br>
-var s_g8sr_ts_save_s&nbsp;&nbsp;&nbsp; =3D s[34:35]&nbsp;&nbsp; // save st=
art<br>
-var s_g8sr_ts_sq_save_msg&nbsp; =3D s[36:37]&nbsp;&nbsp; // The save shade=
r send SAVEWAVE msg to spi<br>
-var s_g8sr_ts_spi_wrexec&nbsp;&nbsp; =3D s[38:39]&nbsp;&nbsp; // the SPI w=
rite the sr address to SQ<br>
-var s_g8sr_ts_save_d&nbsp;&nbsp;&nbsp; =3D s[40:41]&nbsp;&nbsp; // save en=
d<br>
-var s_g8sr_ts_restore_s =3D s[42:43]&nbsp;&nbsp; // restore start<br>
-var s_g8sr_ts_restore_d =3D s[44:45]&nbsp;&nbsp; // restore end<br>
-<br>
-var G8SR_VGPR_SR_IN_DWX4 =3D 0<br>
-var G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4 =3D 0x00100000&nbsp;&nbsp;&nbsp; =
// DWx4 stride is 4*4Bytes<br>
-var G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; =3D G8SR_SAVE_BUF_RSRC_W=
ORD1_STRIDE_DWx4<br>
-<br>
-<br>
-/*************************************************************************=
/<br>
-/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control on how to run the shader&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-/*************************************************************************=
/<br>
-//any hack that needs to be made to run this code in EMU (either because v=
arious EMU code are not ready or no compute save &amp; restore in EMU run)<=
br>
-var EMU_RUN_HACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 0<=
br>
-var EMU_RUN_HACK_RESTORE_NORMAL&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 0<=
br>
-var EMU_RUN_HACK_SAVE_NORMAL_EXIT&nbsp;&nbsp; =3D&nbsp;&nbsp; 0<br>
-var EMU_RUN_HACK_SAVE_SINGLE_WAVE&nbsp;&nbsp; =3D&nbsp;&nbsp; 0<br>
-var EMU_RUN_HACK_SAVE_FIRST_TIME&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 0&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; //for interrupted restore in which the first sa=
ve is through EMU_RUN_HACK<br>
-var EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_LO =3D&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; //for interrupted restore in which the first save is throu=
gh EMU_RUN_HACK<br>
-var EMU_RUN_HACK_SAVE_FIRST_TIME_TBA_HI =3D&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; //for interrupted restore in which the first save is throu=
gh EMU_RUN_HACK<br>
-var SAVE_LDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; =3D&nbsp;&nbsp; 1<br>
-var WG_BASE_ADDR_LO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 0x9000a000<br>
-var WG_BASE_ADDR_HI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 0x0<br>
-var WAVE_SPACE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp=
;&nbsp; 0x5000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; //memory size that each wave occupies in workgroup state =
mem<br>
-var CTX_SAVE_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 0x0<br>
-var CTX_RESTORE_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; CTX_SAVE_CONTROL<br>
-var SIM_RUN_HACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 0&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //any hack that needs to be made to run th=
is code in SIM (either because various RTL code are not ready or no compute=
 save &amp; restore in RTL run)<br>
-var SGPR_SAVE_USE_SQC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; //use SQC D$ to do the write<br>
-var USE_MTBUF_INSTEAD_OF_MUBUF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbs=
p; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //because TC EMU currently asserts on=
 0 of // overload DFMT field to carry 4 more bits of stride for MUBUF opcod=
es<br>
-var SWIZZLE_EN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //whether we use swizzled buffer=
 addressing<br>
-<br>
&nbsp;/********************************************************************=
******/<br>
&nbsp;/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; variables&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&nbsp;/********************************************************************=
******/<br>
@@ -226,16 &#43;154,7 @@ shader main<br>
&nbsp;&nbsp; type(CS)<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_RESTORE_NO=
RMAL))&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //hack to use trap_id for determini=
ng save/restore<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME VCCZ un-init assertion =
s_getreg_b32&nbsp;&nbsp;&nbsp;&nbsp; s_save_status, hwreg(HW_REG_STATUS)&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //save STATUS since we will c=
hange SCC<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_tmp, s_save_pc=
_hi, 0xffff0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //change SCC<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32 s_save_tmp, 0x007e=
0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
/Save: trap_id =3D 0x7e. Restore: trap_id =3D 0x7f.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0 L_JUMP_TO_RESTOR=
E&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; //do not need to recover STATUS here&nbsp; since we are going=
 to RESTORE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME&nbsp; s_setreg_b32&nbsp=
;&nbsp; hwreg(HW_REG_STATUS),&nbsp;&nbsp; s_save_status&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; //need to recover STATUS since we are going to SAVE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch L_SKIP_RESTORE&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NOT restore, S=
AVE actually<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch L_SKIP_RESTORE&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NOT resto=
re. might be a regular trap or save<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;L_JUMP_TO_RESTORE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_branch L_RESTORE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; //restore<br>
@@ -249,7 &#43;168,7 @@ L_SKIP_RESTORE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //this is the operation f=
or save<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // *********&nbsp;&nbsp;&nbsp; Handle non-CWSR tra=
ps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *******************<br>
-if (!EMU_RUN_HACK)<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* read tba and tma for next level trap handler, t=
tmp4 is used as s_save_status */<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_load_dwordx4&nbsp; [ttmp8,ttmp9,ttmp10, ttmp11],=
 [tma_lo,tma_hi], 0<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)<br>
@@ -268,7 &#43;187,7 @@ L_EXCP_CASE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp; ttmp1, ttmp1, 0xFFFF<br>
&nbsp;&nbsp;&nbsp;&nbsp; set_status_without_spi_prio(s_save_status, ttmp2) =
//restore HW status(SCC)<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_rfe_b64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ttm=
p0, ttmp1]<br>
-end<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // *********&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; End handling of non-CWSR traps&nbsp;&nbsp; *******************<br>
&nbsp;<br>
&nbsp;/********************************************************************=
******/<br>
@@ -276,12 &#43;195,6 @@ end<br>
&nbsp;/********************************************************************=
******/<br>
&nbsp;<br>
&nbsp;L_SAVE:<br>
-<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp;&nbsp; s_g8s=
r_ts_save_s<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME, will cause xnack??<br>
-end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_tmp, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //clear saveCtx b=
it<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_setreg_b32&nbsp;&nbsp;&nbsp; hwreg(HW_REG_TRAPST=
S, SQ_WAVE_TRAPSTS_SAVECTX_SHIFT, 1), s_save_tmp&nbsp;&nbsp;&nbsp;&nbsp; //=
clear saveCtx bit<br>
&nbsp;<br>
@@ -303,16 &#43;216,7 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_exec_hi, exec_hi<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec=
,&nbsp;&nbsp; 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; //clear EXEC to get ready to receive<br>
&nbsp;<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp; s_g8sr_ts_s=
q_save_msg<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)<br>
-end<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (EMU_RUN_HACK)<br>
-<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sendmsg&nbsp;&nbsp; send=
msg(MSG_SAVEWAVE)&nbsp; //send SPI a message and wait for SPI's write to EX=
EC<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // Set SPI_PRIO=3D2 to avoid starving instruction =
fetch in the waves we're waiting for.<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32 s_save_tmp, s_save_status, (2 &lt;&lt; SQ=
_WAVE_STATUS_SPI_PRIO_SHIFT)<br>
@@ -321,36 &#43;225,9 @@ end<br>
&nbsp;&nbsp; L_SLEEP:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_sleep 0x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // sleep 1 (64clk) is n=
ot enough for 8 waves per SIMD, which will cause SQ hang, since the 7,8th w=
ave could not get arbit to exec inst, while other waves are stuck into the =
sleep-loop and waiting for wrexec!=3D0<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (EMU_RUN_HACK)<br>
-<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_execz L_SLEEP<br=
>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp; s_g8sr_ts_s=
pi_wrexec<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)<br>
-end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup Resource Co=
ntants&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_SAVE_SINGL=
E_WAVE))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //calculate wd_addr using absol=
ute thread id<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_readlane_b32 s_save_tmp, v9, =
0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32 s_save_tmp, s_save_t=
mp, 6<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mul_i32 s_save_tmp, s_save_tm=
p, WAVE_SPACE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_i32 s_save_spi_init_lo, s=
_save_tmp, WG_BASE_ADDR_LO<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_spi_init_hi, W=
G_BASE_ADDR_HI<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_spi_init_hi, s=
_save_spi_init_hi, CTX_SAVE_CONTROL<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (EMU_RUN_HACK_SAVE_SINGLE=
_WAVE))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_i32 s_save_spi_init_lo, s=
_save_tmp, WG_BASE_ADDR_LO<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_spi_init_hi, W=
G_BASE_ADDR_HI<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_spi_init_hi, s=
_save_spi_init_hi, CTX_SAVE_CONTROL<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_buf_rsrc0,&nbsp;&nbsp; s_save_spi_init_lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //base_addr_=
lo<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_buf_rsrc1,&nbsp;&nbsp; s_save_spi_init_hi, 0x0000FFFF&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; //base_addr_hi<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 s_save_buf_rsrc1,&nbsp;&nbsp; s_save_buf_rsrc1,&nbsp; S_SAVE_BUF_RSRC_WORD=
1_STRIDE<br>
@@ -383,22 &#43;260,10 @@ end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_buf_rsrc2, 0x4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS&nbsp;&nbsp; i=
n bytes<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds check=
ing?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_=
save_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //M0<br>
-<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (EMU_RUN_HACK_SAVE_FIRST_=
TIME))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_pc_lo, s_save_=
pc_lo, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //pc[31:0]&#43;4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32 s_save_pc_hi, s_save=
_pc_hi, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry b=
it over<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp; tba_lo, E=
MU_RUN_HACK_SAVE_FIRST_TIME_TBA_LO<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp; tba_hi, E=
MU_RUN_HACK_SAVE_FIRST_TIME_TBA_HI<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0,=
 s_save_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //PC<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_pc_hi, s_save_buf_rsrc0,=
 s_save_mem_offset)<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_exec_lo, s_save_buf_rsrc=
0, s_save_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //EXEC<br>
@@ -440,18 &#43;305,8 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_alloc_size, s_save_alloc_size, 1<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_al=
loc_size, s_save_alloc_size, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //Number of SGPRs =3D (sgpr_size &#43; 1) * 16&nbs=
p;&nbsp; (non-zero value)<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SGPR_SAVE_USE_SQC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp;&nbsp; s_save_alloc_size, 2&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; s_save_buf_rsrc2,&nbsp;&nbsp; s_save_alloc_size, 8&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes (64 threads)<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds check=
ing?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // backup s_save_buf_rsrc0,1 to s_save_pc_lo/hi, s=
ince write_16sgpr_to_mem function will change the rsrc0<br>
&nbsp;&nbsp;&nbsp;&nbsp; //s_mov_b64 s_save_pc_lo, s_save_buf_rsrc0<br>
@@ -490,30 &#43;345,14 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec=
_lo, 0xFFFFFFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //need every thread =
from now on<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec=
_hi, 0xFFFFFFFF<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds check=
ing?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // VGPR Allocated in 4-GPR granularity<br>
&nbsp;<br>
-if G8SR_VGPR_SR_IN_DWX4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // the const stride for DWx4 is=
 4*4 bytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_s=
ave_buf_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1=
, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; // const str=
ide to 4*4 bytes<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dwordx4 v0, v0, s_=
save_buf_rsrc0, s_save_mem_offset slc:1 glc:1<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_s=
ave_buf_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1=
, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE&nbsp; // reset const strid=
e to 4 bytes<br>
-else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v0, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v1, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v2, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v3, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*3<br>
-end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;<br>
@@ -549,64 &#43;388,10 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_mem_offset, s_save_mem_offset, ge=
t_hwreg_size_bytes()<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, =
0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //lds_offset initial=
 value =3D 0<br>
&nbsp;<br>
&nbsp;<br>
-var LDS_DMA_ENABLE =3D 0<br>
-var UNROLL =3D 0<br>
-if UNROLL=3D=3D0 &amp;&amp; LDS_DMA_ENABLE=3D=3D1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp; s3, 256*2<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp; L_SAVE_LDS_LOOP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //TODO: looks the 2 buffer_stor=
e/load clause for s/r will hurt performance.???<br>
-&nbsp;&nbsp;&nbsp; if (SAVE_LDS)&nbsp;&nbsp;&nbsp;&nbsp; //SPI always allo=
c LDS space in 128DW granularity<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_=
store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // first 64DW<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_=
store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:256 // sec=
ond 64DW<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, m0, s=
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; //every buffer_store_lds does 256 bytes<br>
-&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_me=
m_offset, s_save_mem_offset, s3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //mem offset increased by 256 b=
ytes<br>
-&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_save_alloc_size&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //scc=3D(m0 &lt; s_save_al=
loc_size) ? 1 : 0<br>
-&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_LDS_LOOP&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //LDS =
save is complete?<br>
-<br>
-elsif LDS_DMA_ENABLE=3D=3D1 &amp;&amp; UNROLL=3D=3D1 // UNROOL&nbsp; , has=
 ichace miss<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // store from higest LDS address to lowest<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp; s3, 256*2<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp; m0, s_save_alloc_size, s3<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_mem_offset, s_save_mem_off=
set, m0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32 s_save_alloc_size, s_save_alloc_=
size, 9&nbsp;&nbsp; // how many 128 trunks...<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32 s_save_alloc_size, 128, s_save_al=
loc_size&nbsp;&nbsp; // store from higheset addr to lowest<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mul_i32 s_save_alloc_size, s_save_alloc_s=
ize, 6*4&nbsp;&nbsp; // PC offset increment,&nbsp; each LDS save block cost=
 6*4 Bytes instruction<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_alloc_size, s_save_alloc_s=
ize, 3*4&nbsp;&nbsp; //2is the below 2 inst...//s_addc and s_setpc<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0&nbsp;&nbsp; //pad 3 dw to let LDS_D=
MA align with 64Bytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_getpc_b64 s[0:1]&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
// reuse s[0:1], since s[0:1] already saved<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp; s0, s0,s_save_alloc_s=
ize<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32&nbsp; s1, s1, 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_setpc_b64 s[0:1]<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for var i =3D0; i&lt; 128; i&#43;&#43=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // be c=
areful to make here a 64Byte aligned address, which could improve performan=
ce...<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_=
store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:0&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // first 64DW<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_=
store_lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:256&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // second 64DW<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if i!=3D127<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp; m0, m0, s3&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; // use a sgpr to shrink 2DW-inst to 1DW inst to i=
mprove performance , i.e.&nbsp; pack more LDS_DMA inst to one Cacheline<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u=
32&nbsp; s_save_mem_offset, s_save_mem_offset,&nbsp; s3<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end<br>
-<br>
-else&nbsp;&nbsp; // BUFFER_STORE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mbcnt_lo_u32_b32 v2, 0xffffffff, 0x0=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mbcnt_hi_u32_b32 v3, 0xffffffff, v2&=
nbsp;&nbsp;&nbsp;&nbsp; // tid<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mul_i32_i24 v2, v3, 8&nbsp;&nbsp; //=
 tid*8<br>
@@ -628,8 &#43;413,6 @@ L_SAVE_LDS_LOOP_VECTOR:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // restore rsrc3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_buf_rsrc3, s0<br>
&nbsp;<br>
-end<br>
-<br>
&nbsp;L_SAVE_LDS_DONE:<br>
&nbsp;<br>
&nbsp;<br>
@@ -647,44 &#43;430,8 @@ L_SAVE_LDS_DONE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_alloc_size, s_save_alloc_size, 1<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_al=
loc_size, s_save_alloc_size, 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //Number of VGPRs =3D (vgpr_size &#43; 1) * 4&nbsp=
;&nbsp;&nbsp; (non-zero value)&nbsp;&nbsp; //FIXME for GFX, zero is possibl=
e<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_bu=
f_rsrc2,&nbsp; s_save_alloc_size, 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes (64 threads*4)<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds check=
ing?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp; // VGPR Allocated in 4-GPR granularity<br>
-<br>
-if G8SR_VGPR_SR_IN_DWX4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // the const stride for DWx4 is=
 4*4 bytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_s=
ave_buf_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1=
, s_save_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; // const str=
ide to 4*4 bytes<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; m0, 4&nbsp;&nbsp;&nbsp;&nbsp; // skip first 4 VG=
PRs<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; m0, s_save_alloc_size<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp;&nbsp;&nbsp=
; L_SAVE_VGPR_LOOP_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // no more vgprs<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_on&nbsp; m0, 0x1&=
nbsp;&nbsp; // This will change M0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; s_save_alloc_size, s_save_alloc_size, 0x1000&nbs=
p; // because above inst change m0<br>
-L_SAVE_VGPR_LOOP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; v0, v0&nbsp;&nbsp; // v0 =3D v[0&#43;m0]<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; v1, v1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; v2, v2<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; v3, v3<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dwordx4 v0, v0, s_=
save_buf_rsrc0, s_save_mem_offset slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; m0, m0, 4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; s_save_mem_offset, s_save_mem_offset, 256*4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; m0, s_save_alloc_size<br>
-&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_VGPR_LOOP&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //VGPR save is complete?<br>
-&nbsp;&nbsp;&nbsp; s_set_gpr_idx_off<br>
-L_SAVE_VGPR_LOOP_END:<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_s=
ave_buf_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1=
, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE&nbsp; // reset const strid=
e to 4 bytes<br>
-else<br>
&nbsp;&nbsp;&nbsp;&nbsp; // VGPR store using dw burst<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; m0, 0x4&nbsp;&nbsp; //VGPR initial index value =3D0<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, s_s=
ave_alloc_size<br>
@@ -700,52 &#43;447,18 @@ else<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v2, =
v2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //v0 =3D v[0&#43;m0]<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v3, =
v3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //v0 =3D v[0&#43;m0]<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if(USE_MTBUF_INSTEAD_OF_MUBUF)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbuffer_store_format_x v0, v0, =
s_save_buf_rsrc0, s_save_mem_offset format:BUF_NUM_FORMAT_FLOAT format: BUF=
_DATA_FORMAT_32 slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v0, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v1, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v2, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v3, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*3<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, =
m0, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //next vgpr index<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sa=
ve_mem_offset, s_save_mem_offset, 256*4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; //every buffer_store_dword does 256 bytes<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_save_alloc_si=
ze&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //scc =3D (m0 &lt; s_save_alloc_size) ? 1 : 0=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_VGPR_LOOP&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //VGPR save is complete?<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_off<br>
-end<br>
&nbsp;<br>
&nbsp;L_SAVE_VGPR_END:<br>
-<br>
-<br>
-<br>
-<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp; S_PGM_END_SAVED&nbsp; */&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; //FIXME&nbsp; graphics ONLY<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_SAVE_NORMA=
L_EXIT))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_pc_hi, s_save_=
pc_hi, 0x0000ffff&nbsp;&nbsp;&nbsp; //pc[47:32]<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_pc_lo, s_save_=
pc_lo, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //pc[31:0]&#43;4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32 s_save_pc_hi, s_save=
_pc_hi, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry b=
it over<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_rfe_b64 s_save_pc_lo&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; //Return to the main shader program<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-// Save Done timestamp<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp;&nbsp; s_g8s=
r_ts_save_d<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // SGPR SR memory offset : size=
(VGPR)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_vgpr_size_bytes(s_save_mem_=
offset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_mem_offset, s_=
save_mem_offset, G8SR_DEBUG_TS_SAVE_D_OFFSET<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME, will cause xnack??<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Need reset rsrc2??<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 m0, s_save_mem_offset=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_buf_rsrc2,&nbs=
p; 0x1000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS =
in bytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_buffer_store_dwordx2 s_g8sr_t=
s_save_d, s_save_buf_rsrc0, m0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; glc:1<br=
>
-end<br>
-<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp;&nbsp; L_END_PGM<br>
&nbsp;<br>
&nbsp;<br>
@@ -756,27 &#43;469,6 @@ end<br>
&nbsp;<br>
&nbsp;L_RESTORE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Setup Resource Co=
ntants&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_RESTORE_NO=
RMAL))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //calculate wd_addr using absol=
ute thread id<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_readlane_b32 s_restore_tmp, v=
9, 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32 s_restore_tmp, s_res=
tore_tmp, 6<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mul_i32 s_restore_tmp, s_rest=
ore_tmp, WAVE_SPACE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_i32 s_restore_spi_init_lo=
, s_restore_tmp, WG_BASE_ADDR_LO<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_restore_spi_init_hi=
, WG_BASE_ADDR_HI<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_restore_spi_init_hi=
, s_restore_spi_init_hi, CTX_RESTORE_CONTROL<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp;&nbsp; s_g8s=
r_ts_restore_s<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME, will cause xnack??<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // tma_lo/hi are sgpr 110, 111,=
 which will not used for 112 SGPR allocated case...<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_restore_pc_lo, s_g8=
sr_ts_restore_s[0]<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_restore_pc_hi, s_g8=
sr_ts_restore_s[1]&nbsp;&nbsp; //backup ts to ttmp0/1, sicne exec will be f=
inally restored..<br>
-end<br>
-<br>
-<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_buf_rsrc0,&nbsp;&nbsp;&nbsp; s_restore_spi_init_lo&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //base_addr_lo<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_buf_rsrc1,&nbsp;&nbsp;&nbsp; s_restore_spi_init_hi, 0x0000FFFF&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //base_addr_hi<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 s_restore_buf_rsrc1,&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc1,&nbsp; S_RESTOR=
E_BUF_RSRC_WORD1_STRIDE<br>
@@ -818,18 &#43;510,12 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp; s_restore_mem_offset, s_restore_me=
m_offset, get_hwreg_size_bytes()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //FIXME, Check if offset overflow???<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to e=
nable bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, =
0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; //lds_offset initial value =3D 0<br>
&nbsp;<br>
&nbsp;&nbsp; L_RESTORE_LDS_LOOP:<br>
-&nbsp;&nbsp;&nbsp; if (SAVE_LDS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword&nbsp;&nb=
sp; v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; // first 64DW<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword&nbsp;&nb=
sp; v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1 offset:256&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // second 64DW<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, =
m0, 256*2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 128 DW<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_mem_offset, s_restore_mem_offset, 256*2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //mem offset increased by 128DW<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_restore_alloc=
_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //scc=3D(=
m0 &lt; s_restore_alloc_size) ? 1 : 0<br>
@@ -848,40 &#43;534,8 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_alloc_size, s_restore_alloc_size, 1<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore=
_alloc_size, s_restore_alloc_size, 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Number of VGPRs =3D (vgpr_size=
 &#43; 1) * 4&nbsp;&nbsp;&nbsp; (non-zero value)<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore=
_buf_rsrc2,&nbsp; s_restore_alloc_size, 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes (64 =
threads*4)<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to e=
nable bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-if G8SR_VGPR_SR_IN_DWX4<br>
-&nbsp;&nbsp;&nbsp;&nbsp; get_vgpr_size_bytes(s_restore_mem_offset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_restore_mem_offset, s_restore_mem_offset, 256*4<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp; // the const stride for DWx4 is 4*4 bytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc=
1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_restore_buf_rsrc1, s_restore_buf=
_rsrc1, G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; // const stride to 4*=
4 bytes<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; m0, s_restore_alloc_size<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_on&nbsp; m0, 0x8&nbsp;&nbsp;&nbsp; =
// Note.. This will change m0<br>
-<br>
-L_RESTORE_VGPR_LOOP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dwordx4 v0, v0, s_restore_buf_rsrc0, =
s_restore_mem_offset slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt vmcnt(0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; m0, m0, 4<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; v0, v0&nbsp;&nbsp; // v[0&#43;m0] =3D v0<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; v1, v1<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; v2, v2<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; v3, v3<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_restore_mem_offset, s_restore_mem_offset, 256*4<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x=
8000<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp;&nbsp;&nbsp; L_RESTORE_VGPR_L=
OOP<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_off<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc=
1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_restore_buf_rsrc1, s_restore_buf=
_rsrc1, S_RESTORE_BUF_RSRC_WORD1_STRIDE&nbsp; // const stride to 4*4 bytes<=
br>
-<br>
-else<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // VGPR load using dw burst<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_mem_offset_save, s_restore_mem_offset&nbsp;&nbsp;&nbsp;&nbsp; // rest=
ore start with v1, v0 will be the last<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_mem_offset, s_restore_mem_offset, 256*4<br>
@@ -890,14 &#43;544,10 @@ else<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_alloc_size, s_restore_alloc_size, 0x8000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; //add 0x8000 since we compare m0 against it later<br=
>
&nbsp;<br>
&nbsp;&nbsp; L_RESTORE_VGPR_LOOP:<br>
-&nbsp;&nbsp;&nbsp; if(USE_MTBUF_INSTEAD_OF_MUBUF)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbuffer_load_format_x v0, v0, s=
_restore_buf_rsrc0, s_restore_mem_offset format:BUF_NUM_FORMAT_FLOAT format=
: BUF_DATA_FORMAT_32 slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v0, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v1, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v2, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v3, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*3<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmcn=
t(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; //ensure data ready<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v0, =
v0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; //v[0&#43;m0] =3D v0<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v1, =
v1<br>
@@ -909,16 &#43;559,10 @@ else<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_RESTORE_VGPR_LOOP&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; //VGPR restore (except v0) is complete?<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_off<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* VGPR restore on v0 */<br>
-&nbsp;&nbsp;&nbsp; if(USE_MTBUF_INSTEAD_OF_MUBUF)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbuffer_load_format_x v0, v0, s=
_restore_buf_rsrc0, s_restore_mem_offset_save format:BUF_NUM_FORMAT_FLOAT f=
ormat: BUF_DATA_FORMAT_32 slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v0, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v1, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1 offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v2, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1 offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v3, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1 offset:256*3<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; restore SGPRs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp; //////////////////////////////<br>
@@ -934,16 &#43;578,8 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_alloc_size, s_restore_alloc_size, 1<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore=
_alloc_size, s_restore_alloc_size, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Number of SGPRs =3D (sgpr_size=
 &#43; 1) * 16&nbsp;&nbsp; (non-zero value)<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SGPR_SAVE_USE_SQC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp;&nbsp;&nbsp; s_restore_alloc_size,=
 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; s_restore_buf_rsrc2,&nbsp;&nbsp;&nbsp; s_restore_alloc_size, 8&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes (64 threa=
ds)<br>
-&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to e=
nable bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* If 112 SGPRs ar allocated, 4 sgprs are not used=
 TBA(108,109),TMA(110,111),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; However, we are safe to restore =
these 4 SGPRs anyway, since TBA,TMA will later be restored by HWREG<br>
@@ -972,12 &#43;608,6 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; //////////////////////////////<br>
&nbsp;&nbsp; L_RESTORE_HWREG:<br>
&nbsp;<br>
-<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_g8sr_ts_restore_s[0], s_restore=
_pc_lo<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_g8sr_ts_restore_s[1], s_restore=
_pc_hi<br>
-end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; // HWREG SR memory offset : size(VGPR)&#43;size(SG=
PR)<br>
&nbsp;&nbsp;&nbsp;&nbsp; get_vgpr_size_bytes(s_restore_mem_offset)<br>
&nbsp;&nbsp;&nbsp;&nbsp; get_sgpr_size_bytes(s_restore_tmp)<br>
@@ -985,11 &#43;615,7 @@ end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_re=
store_buf_rsrc2, 0x4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; //NUM_RECORDS&nbsp;&nbsp; in bytes<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to e=
nable bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; read_hwreg_from_mem(s_restore_m0, s_restore_buf_rs=
rc0, s_restore_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //M0<br>
&nbsp;&nbsp;&nbsp;&nbsp; read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf=
_rsrc0, s_restore_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; //PC<br>
@@ -1006,16 &#43;632,6 @@ end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lgkm=
cnt(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //from n=
ow on, it is safe to restore STATUS and IB_STS<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; //for normal save &amp; restore, the saved PC points to=
 the next inst to execute, no adjustment needs to be made, otherwise:<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_RESTORE_NO=
RMAL))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_restore_pc_lo, s_re=
store_pc_lo, 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //pc[31:0]&#43;8&nbsp;&nbsp;&nbsp;&nbsp; //two back-to-back s_trap ar=
e used (first for save and second for restore)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32&nbsp; s_restore_pc_h=
i, s_restore_pc_hi, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry b=
it over<br>
-&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (EMU_RUN_HACK_RESTORE_NOR=
MAL))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_restore_pc_lo, s_re=
store_pc_lo, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //pc[31:0]&#43;4&nbsp;&nbsp;&nbsp;&nbsp; // save is hack through s_tr=
ap but restore is normal<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32&nbsp; s_restore_pc_h=
i, s_restore_pc_hi, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry b=
it over<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_m0<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec=
_lo,&nbsp;&nbsp;&nbsp; s_restore_exec_lo<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec=
_hi,&nbsp;&nbsp;&nbsp; s_restore_exec_hi<br>
@@ -1048,11 &#43;664,6 @@ end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_barrier&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //barrier to ensure the readiness of LDS=
 before access attempts from any other wave in the same TG //FIXME not perf=
ormance-optimal at this time<br>
&nbsp;<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp; s_memrealtime s_g8sr_ts_restore_d<br>
-&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)<br>
-end<br>
-<br>
&nbsp;//&nbsp; s_rfe_b64 s_restore_pc_lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; //Return to the main shader program and resume executio=
n<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_rfe_restore_b64&nbsp; s_restore_pc_lo, s_restore=
_m0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // s_=
restore_m0[0] is used to set STATUS.inst_atc<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/driver=
s/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm<br>
index cee4cfd..75f29d1 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm<br>
@@ -24,75 &#43;24,6 @@<br>
&nbsp; * PROJECT=3Dgreenland ./sp3 cwsr_trap_handler_gfx9.asm -hex tmp.hex<=
br>
&nbsp; */<br>
&nbsp;<br>
-/* HW (GFX9) source code for CWSR trap handler */<br>
-/* Version 18 &#43; multiple trap handler */<br>
-<br>
-// this performance-optimal version was originally from Seven Xu at SRDC<b=
r>
-<br>
-// Revison #18&nbsp; --...<br>
-/* Rev History<br>
-** #1. Branch from gc dv.&nbsp;&nbsp; //gfxip/gfx9/main/src/test/suites/bl=
ock/cs/sr/cs_trap_handler.sp3#1,#50, #51, #52-53(Skip, Already Fixed by PV)=
, #54-56(merged),#57-58(mergerd, skiped-already fixed by PV)<br>
-** #4. SR Memory Layout:<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. VGPR-SGPR-HWREG-{=
LDS}<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. tba_hi.bits.26 - =
reconfigured as the first wave in tg bits, for defer Save LDS for a threadg=
roup.. performance concern..<br>
-** #5. Update: 1. Accurate g8sr_ts_save_d timestamp<br>
-** #6. Update: 1. Fix s_barrier usage; 2. VGPR s/r using swizzle buffer?(N=
oNeed, already matched the swizzle pattern, more investigation)<br>
-** #7. Update: 1. don't barrier if noLDS<br>
-** #8. Branch: 1. Branch to ver#0, which is very similar to gc dv version<=
br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Fi=
x SQ issue by s_sleep 2<br>
-** #9. Update: 1. Fix scc restore failed issue, restore wave_status at las=
t<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. op=
timize s_buffer save by burst 16sgprs...<br>
-** #10. Update 1. Optimize restore sgpr by busrt 16 sgprs.<br>
-** #11. Update 1. Add 2 more timestamp for debug version<br>
-** #12. Update 1. Add VGPR SR using DWx4, some case improve and some case =
drop performance<br>
-** #13. Integ&nbsp; 1. Always use MUBUF for PV trap shader...<br>
-** #14. Update 1. s_buffer_store soft clause...<br>
-** #15. Update 1. PERF - sclar write with glc:0/mtype0 to allow L2 combine=
. perf improvement a lot.<br>
-** #16. Update 1. PRRF - UNROLL LDS_DMA got 2500cycle save in IP tree<br>
-** #17. Update 1. FUNC - LDS_DMA has issues while ATC, replace with ds_rea=
d/buffer_store for save part[TODO restore part]<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. PE=
RF - Save LDS before save VGPR to cover LDS save long latency...<br>
-** #18. Update 1. FUNC - Implicitly estore STATUS.VCCZ, which is not writa=
ble by s_setreg_b32<br>
-**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. FU=
NC - Handle non-CWSR traps<br>
-*/<br>
-<br>
-var G8SR_WDMEM_HWREG_OFFSET =3D 0<br>
-var G8SR_WDMEM_SGPR_OFFSET&nbsp; =3D 128&nbsp; // in bytes<br>
-<br>
-// Keep definition same as the app shader, These 2 time stamps are part of=
 the app shader... Should before any Save and after restore.<br>
-<br>
-var G8SR_DEBUG_TIMESTAMP =3D 0<br>
-var G8SR_DEBUG_TS_SAVE_D_OFFSET =3D 40*4 // ts_save_d timestamp offset rel=
ative to SGPR_SR_memory_offset<br>
-var s_g8sr_ts_save_s&nbsp;&nbsp; =3D s[34:35]&nbsp;&nbsp; // save start<br=
>
-var s_g8sr_ts_sq_save_msg&nbsp; =3D s[36:37]&nbsp; // The save shader send=
 SAVEWAVE msg to spi<br>
-var s_g8sr_ts_spi_wrexec&nbsp;&nbsp; =3D s[38:39]&nbsp; // the SPI write t=
he sr address to SQ<br>
-var s_g8sr_ts_save_d&nbsp;&nbsp; =3D s[40:41]&nbsp;&nbsp; // save end<br>
-var s_g8sr_ts_restore_s =3D s[42:43]&nbsp;&nbsp; // restore start<br>
-var s_g8sr_ts_restore_d =3D s[44:45]&nbsp;&nbsp; // restore end<br>
-<br>
-var G8SR_VGPR_SR_IN_DWX4 =3D 0<br>
-var G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4 =3D 0x00100000&nbsp;&nbsp; // DWx=
4 stride is 4*4Bytes<br>
-var G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; =3D G8SR_SAVE_BUF_RSRC_W=
ORD1_STRIDE_DWx4<br>
-<br>
-<br>
-/*************************************************************************=
/<br>
-/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; control on how to run the shader&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-/*************************************************************************=
/<br>
-//any hack that needs to be made to run this code in EMU (either because v=
arious EMU code are not ready or no compute save &amp; restore in EMU run)<=
br>
-var EMU_RUN_HACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 0<=
br>
-var EMU_RUN_HACK_RESTORE_NORMAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 0<br>
-var EMU_RUN_HACK_SAVE_NORMAL_EXIT&nbsp;&nbsp; =3D&nbsp; 0<br>
-var EMU_RUN_HACK_SAVE_SINGLE_WAVE&nbsp;&nbsp; =3D&nbsp; 0<br>
-var EMU_RUN_HACK_SAVE_FIRST_TIME&nbsp;&nbsp;&nbsp; =3D&nbsp; 0&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; //for interrupted restore in which the first save is =
through EMU_RUN_HACK<br>
-var SAVE_LDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&=
nbsp;&nbsp;&nbsp; 1<br>
-var WG_BASE_ADDR_LO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 0x9000a000<br>
-var WG_BASE_ADDR_HI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 0x0<br>
-var WAVE_SPACE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp=
;&nbsp; 0x5000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; //memory size that each wave occupies in workgroup state =
mem<br>
-var CTX_SAVE_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 0x0<br>
-var CTX_RESTORE_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&n=
bsp;&nbsp; CTX_SAVE_CONTROL<br>
-var SIM_RUN_HACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 0&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //any hack that needs to be made to run th=
is code in SIM (either because various RTL code are not ready or no compute=
 save &amp; restore in RTL run)<br>
-var SGPR_SAVE_USE_SQC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; //use SQC D$ to do the write<br>
-var USE_MTBUF_INSTEAD_OF_MUBUF&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbs=
p; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //because TC EMU currently asserts on=
 0 of // overload DFMT field to carry 4 more bits of stride for MUBUF opcod=
es<br>
-var SWIZZLE_EN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //whether we use swizzled buffer=
 addressing<br>
&nbsp;var ACK_SQC_STORE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nb=
sp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //workaround for suspected SQC store=
 bug causing incorrect stores under concurrency<br>
&nbsp;var SAVE_AFTER_XNACK_ERROR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //work=
around for TCP store failure after XNACK error when ALLOW_REPLAY=3D0, for d=
ebugger<br>
&nbsp;var SINGLE_STEP_MISSED_WORKAROUND&nbsp;&nbsp; =3D&nbsp;&nbsp; 1&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; //workaround for lost MODE.DEBUG_EN exception w=
hen SAVECTX raised<br>
@@ -238,16 &#43;169,7 @@ shader main<br>
&nbsp;&nbsp; type(CS)<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_RESTORE_NO=
RMAL))&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //hack to use trap_id for determining sav=
e/restore<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME VCCZ un-init assertion s_getr=
eg_b32&nbsp;&nbsp;&nbsp;&nbsp; s_save_status, hwreg(HW_REG_STATUS)&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //save STATUS since we will change =
SCC<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_tmp, s_save_pc_hi, 0=
xffff0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; //change SCC<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32 s_save_tmp, 0x007e0000&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Save:=
 trap_id =3D 0x7e. Restore: trap_id =3D 0x7f.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0 L_JUMP_TO_RESTORE&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; //do not need to recover STATUS here&nbsp; since we are going to RE=
STORE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME&nbsp; s_setreg_b32&nbsp;&nbsp=
;&nbsp; hwreg(HW_REG_STATUS),&nbsp;&nbsp; s_save_status&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; //need to recover STATUS since we are going to SAVE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch L_SKIP_RESTORE&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NOT restore, SAVE ac=
tually<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_branch L_SKIP_RESTORE&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NOT resto=
re. might be a regular trap or save<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;L_JUMP_TO_RESTORE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_branch L_RESTORE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; //restore<br>
@@ -278,7 &#43;200,7 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //this is the operation for sav=
e<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // *********&nbsp;&nbsp;&nbsp; Handle non-CWSR tra=
ps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *******************<br>
-if (!EMU_RUN_HACK)<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // Illegal instruction is a non-maskable exception=
 which blocks context save.<br>
&nbsp;&nbsp;&nbsp;&nbsp; // Halt the wavefront and return from the trap.<br=
>
&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttmp=
2, s_save_trapsts, SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK<br>
@@ -355,7 &#43;277,7 @@ L_EXCP_CASE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; set_status_without_spi_prio(s_save_status, ttmp2)<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_rfe_b64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ttm=
p0, ttmp1]<br>
-end<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // *********&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E=
nd handling of non-CWSR traps&nbsp;&nbsp; *******************<br>
&nbsp;<br>
&nbsp;/********************************************************************=
******/<br>
@@ -363,12 &#43;285,6 @@ end<br>
&nbsp;/********************************************************************=
******/<br>
&nbsp;<br>
&nbsp;L_SAVE:<br>
-<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp;&nbsp; s_g8sr_ts_s=
ave_s<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME, will cause xnack??<br>
-end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_pc_=
hi, s_save_pc_hi, 0x0000ffff&nbsp;&nbsp;&nbsp; //pc[47:32]<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_tmp=
, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //clear saveCtx b=
it<br>
@@ -390,16 &#43;306,7 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_exe=
c_hi, exec_hi<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec,&nbsp=
;&nbsp; 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; //clear EXEC to get ready to receive<br>
&nbsp;<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp; s_g8sr_ts_sq_save=
_msg<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)<br>
-end<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (EMU_RUN_HACK)<br>
-<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sendmsg&nbsp;&nbsp; send=
msg(MSG_SAVEWAVE)&nbsp; //send SPI a message and wait for SPI's write to EX=
EC<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // Set SPI_PRIO=3D2 to avoid starving instruction =
fetch in the waves we're waiting for.<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32 s_save_tmp, s_save_status, (2 &lt;&lt; SQ=
_WAVE_STATUS_SPI_PRIO_SHIFT)<br>
@@ -408,33 &#43;315,7 @@ end<br>
&nbsp;&nbsp; L_SLEEP:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_sleep 0x2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; // sleep 1 (64clk) is not enough for 8 waves per SIMD, w=
hich will cause SQ hang, since the 7,8th wave could not get arbit to exec i=
nst, while other waves are stuck into the sleep-loop and waiting for wrexec=
!=3D0<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (EMU_RUN_HACK)<br>
-<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_execz L_SLEEP<br=
>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp; s_g8sr_ts_spi_wre=
xec<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)<br>
-end<br>
-<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_SAVE_SINGL=
E_WAVE))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //calculate wd_addr using absolute th=
read id<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_readlane_b32 s_save_tmp, v9, 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32 s_save_tmp, s_save_tmp, 6<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mul_i32 s_save_tmp, s_save_tmp, WAV=
E_SPACE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_i32 s_save_spi_init_lo, s_save_=
tmp, WG_BASE_ADDR_LO<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_spi_init_hi, WG_BASE=
_ADDR_HI<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_spi_init_hi, s_save_=
spi_init_hi, CTX_SAVE_CONTROL<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (EMU_RUN_HACK_SAVE_SINGLE=
_WAVE))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_i32 s_save_spi_init_lo, s_save_=
tmp, WG_BASE_ADDR_LO<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_spi_init_hi, WG_BASE=
_ADDR_HI<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_spi_init_hi, s_save_=
spi_init_hi, CTX_SAVE_CONTROL<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // Save trap temporaries 4-11, 13 initialized by S=
PI debug dispatch logic<br>
&nbsp;&nbsp;&nbsp;&nbsp; // ttmp SR memory offset : size(VGPR)&#43;size(SGP=
R)&#43;0x40<br>
@@ -484,20 &#43;365,10 @@ end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_buf=
_rsrc2, 0x4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS&nbsp;&nbsp; i=
n bytes<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds checking?<b=
r>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_=
save_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //M0<br>
-<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (EMU_RUN_HACK_SAVE_FIRST_=
TIME))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_pc_lo, s_save_pc_lo,=
 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//pc[31:0]&#43;4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32 s_save_pc_hi, s_save_pc_hi=
, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry bit ove=
r<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0,=
 s_save_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //PC<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_pc_hi, s_save_buf_rsrc0,=
 s_save_mem_offset)<br>
&nbsp;&nbsp;&nbsp;&nbsp; write_hwreg_to_mem(s_save_exec_lo, s_save_buf_rsrc=
0, s_save_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; //EXEC<br>
@@ -535,17 &#43;406,9 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_all=
oc_size, s_save_alloc_size, 1<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp; s_save_alloc_si=
ze, s_save_alloc_size, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //Number of SGPRs =3D (sgpr_size &#43; 1) * 16&nbs=
p;&nbsp; (non-zero value)<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SGPR_SAVE_USE_SQC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp;&nbsp; s_save_alloc_size, 2&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; s_save_buf_rsrc2,&nbsp;&nbsp; s_save_alloc_size, 8&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes (64 threads)<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds checking?<b=
r>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // backup s_save_buf_rsrc0,1 to s_save_pc_lo/hi, s=
ince write_16sgpr_to_mem function will change the rsrc0<br>
@@ -588,25 &#43;451,11 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnack_mask=
_lo, 0x0<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnack_mask=
_hi, 0x0<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds checking?<b=
r>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; // VGPR Allocated in 4-GPR granularity<br>
&nbsp;<br>
-if G8SR_VGPR_SR_IN_DWX4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // the const stride for DWx4 is 4*4 b=
ytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_save_bu=
f_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1, s_sa=
ve_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; // const stride to=
 4*4 bytes<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dwordx4 v0, v0, s_save_b=
uf_rsrc0, s_save_mem_offset slc:1 glc:1<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_save_bu=
f_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1, s_sa=
ve_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE&nbsp; // reset const stride to 4=
 bytes<br>
-else<br>
&nbsp;if SAVE_AFTER_XNACK_ERROR<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check_if_tcp_store_ok()<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1 L_SAVE_FIRS=
T_VGPRS_WITH_TCP<br>
@@ -621,7 &#43;470,6 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v1, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v2, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v3, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*3<br>
-end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;<br>
@@ -656,64 &#43;504,11 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_mem_offset, s_save_mem_offset, ge=
t_hwreg_size_bytes()<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; //FIXME need to use swizzle to enable bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //lds_offset initial=
 value =3D 0<br>
&nbsp;<br>
&nbsp;<br>
-var LDS_DMA_ENABLE =3D 0<br>
-var UNROLL =3D 0<br>
-if UNROLL=3D=3D0 &amp;&amp; LDS_DMA_ENABLE=3D=3D1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp; s3, 256*2<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp; L_SAVE_LDS_LOOP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //TODO: looks the 2 buffer_store/load=
 clause for s/r will hurt performance.???<br>
-&nbsp;&nbsp;&nbsp; if (SAVE_LDS)&nbsp;&nbsp;&nbsp;&nbsp; //SPI always allo=
c LDS space in 128DW granularity<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_=
lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // first 64DW<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_=
lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:256 // second 64=
DW<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, m0, s3&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; //every buffer_store_lds does 256 bytes<br>
-&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_mem_offs=
et, s_save_mem_offset, s3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //mem offset increased by 256 b=
ytes<br>
-&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_save_alloc_size&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //scc=3D(m0 &lt; s_save_alloc_si=
ze) ? 1 : 0<br>
-&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_LDS_LOOP&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //LDS save i=
s complete?<br>
-<br>
-elsif LDS_DMA_ENABLE=3D=3D1 &amp;&amp; UNROLL=3D=3D1 // UNROOL , has ichac=
e miss<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // store from higest LDS address to lowest<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s3, 256*2<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; m0, s_save_alloc_size, s3<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_mem_offset, s_save_mem_off=
set, m0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32 s_save_alloc_size, s_save_alloc_=
size, 9&nbsp;&nbsp; // how many 128 trunks...<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32 s_save_alloc_size, 128, s_save_al=
loc_size&nbsp;&nbsp; // store from higheset addr to lowest<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mul_i32 s_save_alloc_size, s_save_alloc_s=
ize, 6*4&nbsp;&nbsp; // PC offset increment,&nbsp; each LDS save block cost=
 6*4 Bytes instruction<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_alloc_size, s_save_alloc_s=
ize, 3*4&nbsp;&nbsp; //2is the below 2 inst...//s_addc and s_setpc<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_nop 0&nbsp; //pad 3 dw to let LDS_DMA ali=
gn with 64Bytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_getpc_b64 s[0:1]&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // reu=
se s[0:1], since s[0:1] already saved<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; s0, s0,s_save_alloc_size<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32&nbsp; s1, s1, 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_setpc_b64 s[0:1]<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for var i =3D0; i&lt; 128; i&#43;&#43=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // be careful=
 to make here a 64Byte aligned address, which could improve performance...<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_=
lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:0&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // first 64DW<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_=
lds_dword s_save_buf_rsrc0, s_save_mem_offset lds:1 offset:256&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // second 64DW<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if i!=3D127<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp; m0, m0, s3&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; // use a sgpr to shrink 2DW-inst to 1DW inst to improve=
 performance , i.e.&nbsp; pack more LDS_DMA inst to one Cacheline<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbs=
p; s_save_mem_offset, s_save_mem_offset,&nbsp; s3<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end<br>
-<br>
-else&nbsp;&nbsp; // BUFFER_STORE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mbcnt_lo_u32_b32 v2, 0xffffffff, 0x0=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mbcnt_hi_u32_b32 v3, 0xffffffff, v2&=
nbsp;&nbsp;&nbsp; // tid<br>
&nbsp;<br>
@@ -757,8 &#43;552,6 @@ L_SAVE_LDS_LOOP_VECTOR:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // restore rsrc3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_buf_rsrc3, s0<br>
&nbsp;<br>
-end<br>
-<br>
&nbsp;L_SAVE_LDS_DONE:<br>
&nbsp;<br>
&nbsp;<br>
@@ -776,44 &#43;569,9 @@ L_SAVE_LDS_DONE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_all=
oc_size, s_save_alloc_size, 1<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp; s_save_alloc_si=
ze, s_save_alloc_size, 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; //Number of VGPRs =3D (vgpr_size &#43; 1) * 4&nbsp=
;&nbsp;&nbsp; (non-zero value)&nbsp;&nbsp;&nbsp; //FIXME for GFX, zero is p=
ossible<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc=
2,&nbsp; s_save_alloc_size, 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes (64 threads*4)<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_save_buf_rsrc2, s_save_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable bounds checking?<b=
r>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_save_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; // VGPR Allocated in 4-GPR granularity<br>
-<br>
-if G8SR_VGPR_SR_IN_DWX4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // the const stride for DWx4 is 4*4 b=
ytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_save_bu=
f_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1, s_sa=
ve_buf_rsrc1, G8SR_SAVE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; // const stride to=
 4*4 bytes<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; m0, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // skip first 4 VG=
PRs<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; m0, s_save_alloc_size<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp;&nbsp;&nbsp; L_SA=
VE_VGPR_LOOP_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // no more vgprs<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_on&nbsp; m0, 0x1&nbsp;&=
nbsp; // This will change M0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; s_save_alloc_size, s_save_alloc_size, 0x1000&nbsp;&nbs=
p; // because above inst change m0<br>
-L_SAVE_VGPR_LOOP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; v0, v0&nbsp;&nbsp; // v0 =3D v[0&#43;m0]<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; v1, v1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; v2, v2<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; v3, v3<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dwordx4 v0, v0, s_save_b=
uf_rsrc0, s_save_mem_offset slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; m0, m0, 4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; s_save_mem_offset, s_save_mem_offset, 256*4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; m0, s_save_alloc_size<br>
-&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_VGPR_LOOP&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //VGPR save is complete?<br>
-&nbsp;&nbsp;&nbsp; s_set_gpr_idx_off<br>
-L_SAVE_VGPR_LOOP_END:<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_buf_rsrc1, s_save_bu=
f_rsrc1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_save_buf_rsrc1, s_sa=
ve_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE&nbsp; // reset const stride to 4=
 bytes<br>
-else<br>
&nbsp;&nbsp;&nbsp;&nbsp; // VGPR store using dw burst<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; m0, 0x4&nbsp;&nbsp;&nbsp; //VGPR initial index value =3D0<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, s_s=
ave_alloc_size<br>
@@ -844,21 &#43;602,16 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v2, v2&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //v0 =3D v[0&#43;m0]<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v3, v3&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; //v0 =3D v[0&#43;m0]<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if(USE_MTBUF_INSTEAD_OF_MUBUF)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbuffer_store_format_x v0, v0, s_save=
_buf_rsrc0, s_save_mem_offset format:BUF_NUM_FORMAT_FLOAT format: BUF_DATA_=
FORMAT_32 slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v0, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v1, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v2, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_store_dword v3, v0,=
 s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1&nbsp; offset:256*3<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, m0, 4&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //next vgpr index<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_save_mem=
_offset, s_save_mem_offset, 256*4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; //every buffer_store_dword does 256 bytes<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_save_alloc_si=
ze&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //scc =3D (m0 &lt; s_save_alloc_size) ? 1 : 0<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc1&nbsp; L_SAVE_VGPR_LOOP&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //VGPR save is complete?<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_off<br>
-end<br>
&nbsp;<br>
&nbsp;L_SAVE_VGPR_END:<br>
&nbsp;<br>
@@ -905,29 &#43;658,6 @@ L_SAVE_ACCVGPR_LOOP:<br>
&nbsp;L_SAVE_ACCVGPR_END:<br>
&nbsp;end<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp; S_PGM_END_SAVED&nbsp; */&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; //FIXME&nbsp; graphics ONLY<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_SAVE_NORMA=
L_EXIT))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_save_pc_hi, s_save_pc_hi,=
 0x0000ffff&nbsp;&nbsp;&nbsp; //pc[47:32]<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_pc_lo, s_save_pc_lo,=
 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//pc[31:0]&#43;4<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32 s_save_pc_hi, s_save_pc_hi=
, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry bit ove=
r<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_rfe_b64 s_save_pc_lo&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; //Return to the main shader program<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-// Save Done timestamp<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp;&nbsp; s_g8sr_ts_s=
ave_d<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // SGPR SR memory offset : size(VGPR)=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_vgpr_size_bytes(s_save_mem_offset=
)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_save_mem_offset, s_save_m=
em_offset, G8SR_DEBUG_TS_SAVE_D_OFFSET<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME, will cause xnack??<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Need reset rsrc2??<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 m0, s_save_mem_offset<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_save_buf_rsrc2,&nbsp; 0x1=
000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in byt=
es<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_buffer_store_dwordx2 s_g8sr_ts_save=
_d, s_save_buf_rsrc0, m0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; glc:1<br>
-end<br>
-<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_branch&nbsp;&nbsp; L_END_PGM<br>
&nbsp;<br>
&nbsp;<br>
@@ -938,27 &#43;668,6 @@ end<br>
&nbsp;<br>
&nbsp;L_RESTORE:<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp; Setup Resource Contants=
&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_RESTORE_NO=
RMAL))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //calculate wd_addr using absolute th=
read id<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v_readlane_b32 s_restore_tmp, v9, 0<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshr_b32 s_restore_tmp, s_restore_t=
mp, 6<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mul_i32 s_restore_tmp, s_restore_tm=
p, WAVE_SPACE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_i32 s_restore_spi_init_lo, s_re=
store_tmp, WG_BASE_ADDR_LO<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_restore_spi_init_hi, WG_B=
ASE_ADDR_HI<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_restore_spi_init_hi, s_re=
store_spi_init_hi, CTX_RESTORE_CONTROL<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_memrealtime&nbsp;&nbsp; s_g8sr_ts_r=
estore_s<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME, will cause xnack??<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // tma_lo/hi are sgpr 110, 111, which=
 will not used for 112 SGPR allocated case...<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_restore_pc_lo, s_g8sr_ts_=
restore_s[0]<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_restore_pc_hi, s_g8sr_ts_=
restore_s[1]&nbsp;&nbsp; //backup ts to ttmp0/1, sicne exec will be finally=
 restored..<br>
-end<br>
-<br>
-<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
buf_rsrc0,&nbsp;&nbsp;&nbsp; s_restore_spi_init_lo&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //base_addr_lo<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
buf_rsrc1,&nbsp;&nbsp;&nbsp; s_restore_spi_init_hi, 0x0000FFFF&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //base_addr_hi<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_res=
tore_buf_rsrc1,&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc1,&nbsp; S_RESTORE_BUF_=
RSRC_WORD1_STRIDE<br>
@@ -1000,18 &#43;709,12 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp; s_restore_mem_offset, s_restore_me=
m_offset, get_hwreg_size_bytes()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; //FIXME, Check if offset overflow???<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable =
bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; //lds_offset initial value =3D 0<br>
&nbsp;<br>
&nbsp;&nbsp; L_RESTORE_LDS_LOOP:<br>
-&nbsp;&nbsp;&nbsp; if (SAVE_LDS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword&nbsp;&nb=
sp; v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; // first 64DW<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword&nbsp;&nb=
sp; v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1 offset:256&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // second 64DW<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, m0, 25=
6*2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 128 DW<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
mem_offset, s_restore_mem_offset, 256*2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //mem offset increased by 128DW<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_lt_u32&nbsp;&nbsp;&nbsp; m0, s_restore_alloc=
_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //scc=3D(m0 &lt=
; s_restore_alloc_size) ? 1 : 0<br>
@@ -1035,40 &#43;738,8 @@ if ASIC_TARGET_ARCTURUS<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
accvgpr_offset, s_restore_buf_rsrc2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //ACC VGPRs at end of VGPRs<br>
&nbsp;end<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable =
bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
-if G8SR_VGPR_SR_IN_DWX4<br>
-&nbsp;&nbsp;&nbsp;&nbsp; get_vgpr_size_bytes(s_restore_mem_offset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; s_restore_mem_offset, s_restore_mem_offset, 256*4<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp; // the const stride for DWx4 is 4*4 bytes<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc=
1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_restore_buf_rsrc1, s_restore_buf=
_rsrc1, G8SR_RESTORE_BUF_RSRC_WORD1_STRIDE_DWx4&nbsp; // const stride to 4*=
4 bytes<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; m0, s_restore_alloc_size<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_on&nbsp; m0, 0x8&nbsp;&nbsp; // Not=
e.. This will change m0<br>
-<br>
-L_RESTORE_VGPR_LOOP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dwordx4 v0, v0, s_restore_buf_rsrc0, =
s_restore_mem_offset slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt vmcnt(0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; m0, m0, 4<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; v0, v0&nbsp;&nbsp;&nbsp; // v[0&#43;m0] =3D v0<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; v1, v1<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; v2, v2<br>
-&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; v3, v3<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; s_restore_mem_offset, s_restore_mem_offset, 256*4<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_cmp_eq_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x=
8000<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_cbranch_scc0&nbsp;&nbsp;&nbsp; L_RESTORE_VGPR_L=
OOP<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_set_gpr_idx_off<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_and_b32 s_restore_buf_rsrc1, s_restore_buf_rsrc=
1, 0x0000FFFF&nbsp;&nbsp; // reset const stride to 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp; s_or_b32&nbsp; s_restore_buf_rsrc1, s_restore_buf=
_rsrc1, S_RESTORE_BUF_RSRC_WORD1_STRIDE&nbsp; // const stride to 4*4 bytes<=
br>
-<br>
-else<br>
&nbsp;&nbsp;&nbsp;&nbsp; // VGPR load using dw burst<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
mem_offset_save, s_restore_mem_offset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // rest=
ore start with v1, v0 will be the last<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
mem_offset, s_restore_mem_offset, 256*4<br>
@@ -1081,9 &#43;752,6 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
alloc_size, s_restore_alloc_size, 0x8000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; //add 0x8000 since we compare m0 against it later<br=
>
&nbsp;<br>
&nbsp;&nbsp; L_RESTORE_VGPR_LOOP:<br>
-&nbsp;&nbsp;&nbsp; if(USE_MTBUF_INSTEAD_OF_MUBUF)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbuffer_load_format_x v0, v0, s_resto=
re_buf_rsrc0, s_restore_mem_offset format:BUF_NUM_FORMAT_FLOAT format: BUF_=
DATA_FORMAT_32 slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;<br>
&nbsp;if ASIC_TARGET_ARCTURUS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v0, v0, =
s_restore_buf_rsrc0, s_restore_accvgpr_offset slc:1 glc:1<br>
@@ -1102,7 &#43;770,6 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v1, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v2, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v3, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset slc:1 glc:1 offset:256*3<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmcnt(0)&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; //ensure data ready<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v0, v0&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; //v[0&#43;m0] =3D v0<br>
&nbsp;&nbsp;&nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v1, v1<br>
@@ -1126,16 &#43;793,10 @@ if ASIC_TARGET_ARCTURUS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end<br>
&nbsp;end<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if(USE_MTBUF_INSTEAD_OF_MUBUF)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbuffer_load_format_x v0, v0, s_resto=
re_buf_rsrc0, s_restore_mem_offset_save format:BUF_NUM_FORMAT_FLOAT format:=
 BUF_DATA_FORMAT_32 slc:1 glc:1<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v0, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v1, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1 offset:256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v2, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1 offset:256*2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_load_dword v3, v0, =
s_restore_buf_rsrc0, s_restore_mem_offset_save&nbsp;&nbsp;&nbsp; slc:1 glc:=
1 offset:256*3<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
-end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 restore SGPRs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp; //////////////////////////////<br>
@@ -1151,16 &#43;812,8 @@ end<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
alloc_size, s_restore_alloc_size, 1<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp; s_restore_alloc=
_size, s_restore_alloc_size, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Number of SGPRs =3D (sgpr_size=
 &#43; 1) * 16&nbsp;&nbsp; (non-zero value)<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (SGPR_SAVE_USE_SQC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp;&nbsp;&nbsp; s_restore_alloc_size,=
 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_lshl_b32&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; s_restore_buf_rsrc2,&nbsp;&nbsp;&nbsp; s_restore_alloc_size, 8&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes (64 threads)<br=
>
-&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable =
bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 m0, s_restore_alloc_size<br>
&nbsp;<br>
@@ -1188,11 &#43;841,6 @@ end<br>
&nbsp;&nbsp; L_RESTORE_HWREG:<br>
&nbsp;<br>
&nbsp;<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_g8sr_ts_restore_s[0], s_restore=
_pc_lo<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32 s_g8sr_ts_restore_s[1], s_restore=
_pc_hi<br>
-end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; // HWREG SR memory offset : size(VGPR)&#43;size(SG=
PR)<br>
&nbsp;&nbsp;&nbsp;&nbsp; get_vgpr_size_bytes(s_restore_mem_offset)<br>
&nbsp;&nbsp;&nbsp;&nbsp; get_sgpr_size_bytes(s_restore_tmp)<br>
@@ -1200,11 &#43;848,7 @@ end<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_=
buf_rsrc2, 0x4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; //NUM_RECORDS&nbsp;&nbsp; in bytes<br>
-&nbsp;&nbsp;&nbsp; if (SWIZZLE_EN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; s_restore_buf_rsrc2, s_restore_buf_rsrc2, 0x0&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //FIXME need to use swizzle to enable =
bounds checking?<br>
-&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; s_restore_buf_rsrc2,&nbsp; 0x1000000&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //NUM_RECORDS in bytes<br>
-&nbsp;&nbsp;&nbsp; end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; read_hwreg_from_mem(s_restore_m0, s_restore_buf_rs=
rc0, s_restore_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //M0<br>
&nbsp;&nbsp;&nbsp;&nbsp; read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf=
_rsrc0, s_restore_mem_offset)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; //PC<br>
@@ -1219,16 &#43;863,6 @@ end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_waitcnt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lgkmcnt(0)=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //from n=
ow on, it is safe to restore STATUS and IB_STS<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; //for normal save &amp; restore, the saved PC points to=
 the next inst to execute, no adjustment needs to be made, otherwise:<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (!EMU_RUN_HACK_RESTORE_NO=
RMAL))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_restore_pc_lo, s_restore_=
pc_lo, 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//pc[31:0]&#43;8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //two back-to-back s_trap ar=
e used (first for save and second for restore)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32&nbsp; s_restore_pc_hi, s_r=
estore_pc_hi, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry bit ove=
r<br>
-&nbsp;&nbsp;&nbsp; end<br>
-&nbsp;&nbsp;&nbsp; if ((EMU_RUN_HACK) &amp;&amp; (EMU_RUN_HACK_RESTORE_NOR=
MAL))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_add_u32 s_restore_pc_lo, s_restore_=
pc_lo, 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//pc[31:0]&#43;4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // save is hack through s_tr=
ap but restore is normal<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_addc_u32&nbsp; s_restore_pc_hi, s_r=
estore_pc_hi, 0x0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //carry bit ove=
r<br>
-&nbsp;&nbsp;&nbsp; end<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_restore_m0<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec_lo,&n=
bsp;&nbsp;&nbsp;&nbsp; s_restore_exec_lo<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec_hi,&n=
bsp;&nbsp;&nbsp;&nbsp; s_restore_exec_hi<br>
@@ -1275,11 &#43;909,6 @@ end<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_barrier&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; //barrier to ensure the readiness of LDS befor=
e access attempts from any other wave in the same TG //FIXME not performanc=
e-optimal at this time<br>
&nbsp;<br>
-if G8SR_DEBUG_TIMESTAMP<br>
-&nbsp;&nbsp;&nbsp; s_memrealtime s_g8sr_ts_restore_d<br>
-&nbsp;&nbsp;&nbsp; s_waitcnt lgkmcnt(0)<br>
-end<br>
-<br>
&nbsp;//&nbsp; s_rfe_b64 s_restore_pc_lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; //Return to the main shader program and resume executio=
n<br>
&nbsp;&nbsp;&nbsp;&nbsp; s_rfe_restore_b64&nbsp; s_restore_pc_lo, s_restore=
_m0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // s_restor=
e_m0[0] is used to set STATUS.inst_atc<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F67AE6AC298C22F0C484F7C60BN6PR12MB1809namp_--

--===============2106555206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2106555206==--
