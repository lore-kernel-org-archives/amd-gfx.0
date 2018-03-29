From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] Add srbm selection to both umr and kernel
Date: Thu, 29 Mar 2018 14:17:12 -0400
Message-ID: <a626c1cf-b48a-b317-e1e8-78ba5cff18f3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------6FD26B71B265C1735B53856A"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------6FD26B71B265C1735B53856A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

A bit unconventional since these two patches are for two different trees 
but they're related so it's nice to review them as a pair.

They add the ability to select srbm banks via debugfs and the 
corresponding support in umr.  The umr patch also adds some bug fixes 
related to how options were filtering down into the library.

Cheers,
Tom

--------------6FD26B71B265C1735B53856A
Content-Type: text/x-patch;
 name="0001-Add-support-for-SRBM-selection-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-support-for-SRBM-selection-v3.patch"

>From 236e1b84a6a8a3a91cf487a73fe4dd48aa245b3b Mon Sep 17 00:00:00 2001
From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 29 Mar 2018 08:41:28 -0400
Subject: [PATCH umr] Add support for SRBM selection (v3)

Also clean up grbm debugfs addressing by hoisting the inlined
copies of the logic into a new function that is also used by
srbm selection.

(v2) Drop 'x' support for SRBM and swap order of me/pipe/queue
     to match what Andrey had already written for the kernel.

(v3) Fix various places which didn't use asic->options to get
     at options.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 doc/umr.1                        |  6 ++++--
 src/app/main.c                   | 30 ++++++++++++++++++++++------
 src/app/scan.c                   | 23 ++++++++++------------
 src/app/scan_log.c               |  4 ++--
 src/app/set_bit.c                | 19 ++++++++----------
 src/app/set_reg.c                | 14 +++++---------
 src/app/top.c                    |  4 ++--
 src/lib/CMakeLists.txt           |  1 +
 src/lib/umr_apply_bank_address.c | 42 ++++++++++++++++++++++++++++++++++++++++
 src/umr.h                        | 23 ++++++++++++++++++----
 10 files changed, 117 insertions(+), 49 deletions(-)
 create mode 100644 src/lib/umr_apply_bank_address.c

diff --git a/doc/umr.1 b/doc/umr.1
index 880547c0021f..ec4db7b9a12d 100644
--- a/doc/umr.1
+++ b/doc/umr.1
@@ -12,8 +12,10 @@ Pick a device instance to work with.  Defaults to the 0'th device.  The instance
 refers to a directory under
 .B /sys/kernel/debug/dri/
 where 0 is the first card probed.
-.IP "--bank, -b <se_bank> <sh_bank> <instance>"
-Select a GFX INSTANCE/SH/SE bank in decimal.  Can use 'x' to denote a broadcast selection.
+.IP "--bank, -b <se> <sh> <instance>"
+Select a GRBM se/sh/instance bank in decimal.  Can use 'x' to denote a broadcast selection.
+.IP "--sbank, -sb <me> <pipe> <queue>"
+Select a SRBM me/pipe/queue bank in decimal.
 .IP "--force -f <number>"
 Force a PCIE Device ID in hex or by asic name.  This is used in case the amdgpu driver
 is not yet loaded or a display is not yet attached.  A '@' prefix will specify a path to
diff --git a/src/app/main.c b/src/app/main.c
index e5ca9acabdd6..222f9de208d7 100644
--- a/src/app/main.c
+++ b/src/app/main.c
@@ -150,20 +150,35 @@ int main(int argc, char **argv)
 			if (!asic)
 				asic = get_asic();
 			if (i + 3 < argc) {
-				options.se_bank = argv[i+1][0] == 'x' ? 0x3FF : atoi(argv[i+1]);
-				options.sh_bank = argv[i+2][0] == 'x' ? 0x3FF : atoi(argv[i+2]);
-				options.instance_bank = argv[i+3][0] == 'x' ? 0x3FF : atoi(argv[i+3]);
-				if ((options.se_bank != 0x3FF && options.se_bank >= asic->config.gfx.max_shader_engines) ||
-				    (options.sh_bank != 0x3FF && options.sh_bank >= asic->config.gfx.max_sh_per_se)) {
+				options.bank.grbm.se = argv[i+1][0] == 'x' ? 0x3FF : atoi(argv[i+1]);
+				options.bank.grbm.sh = argv[i+2][0] == 'x' ? 0x3FF : atoi(argv[i+2]);
+				options.bank.grbm.instance = argv[i+3][0] == 'x' ? 0x3FF : atoi(argv[i+3]);
+				if ((options.bank.grbm.se != 0x3FF && options.bank.grbm.se >= asic->config.gfx.max_shader_engines) ||
+				    (options.bank.grbm.sh != 0x3FF && options.bank.grbm.sh >= asic->config.gfx.max_sh_per_se)) {
 					printf("Invalid bank selection for specific ASIC\n");
 					return EXIT_FAILURE;
 				}
 				options.use_bank = 1;
 				i += 3;
+				asic->options = options;
 			} else {
 				printf("--bank requires three parameters\n");
 				return EXIT_FAILURE;
 			}
+		} else if (!strcmp(argv[i], "--sbank") || !strcmp(argv[i], "-sb")) {
+			if (!asic)
+				asic = get_asic();
+			if (i + 3 < argc) {
+				options.bank.srbm.me = atoi(argv[i+1]);
+				options.bank.srbm.pipe = atoi(argv[i+2]);
+				options.bank.srbm.queue = atoi(argv[i+3]);
+				options.use_bank = 2;
+				i += 3;
+				asic->options = options;
+			} else {
+				printf("--sbank requires three parameters\n");
+				return EXIT_FAILURE;
+			}
 		} else if (!strcmp(argv[i], "--force") || !strcmp(argv[i], "-f")) {
 			if (i + 1 < argc) {
 				if (sscanf(argv[i+1], "0x%lx", &options.forcedid) == 0) {
@@ -458,6 +473,8 @@ int main(int argc, char **argv)
 				printf("--option requires one parameter\n");
 				return EXIT_FAILURE;
 			}
+			if (asic)
+					asic->options = options;
 		} else if (!strcmp(argv[i], "--update") || !strcmp(argv[i], "-u")) {
 			if (!asic)
 				asic = get_asic();
@@ -473,7 +490,8 @@ int main(int argc, char **argv)
 "\n\t--instance, -i <number>\n\t\tSelect a device instance to investigate. (default: 0)"
 	"\n\t\tThe instance is the directory name under /sys/kernel/debug/dri/"
 	"\n\t\tof the card you want to work with.\n"
-"\n\t--bank, -b <se_bank> <sh_bank> <instance>\n\t\tSelect a GFX INSTANCE/SH/SE bank in decimal. Can use 'x' to denote broadcast.\n"
+"\n\t--bank, -b <se> <sh> <instance>\n\t\tSelect a GRBM se/sh/instance bank in decimal. Can use 'x' to denote broadcast.\n"
+"\n\t--sbank, -sb <me> <pipe> <queue>\n\t\tSelect a SRBM me/pipe/queue bank in decimal.\n"
 "\n\t--force, -f <number>\n\t\tForce a PCIE DID number in hex or asic name.  Useful if amdgpu is"
 	"\n\t\tnot loaded or a display is not attached.\n"
 "\n\t--pci <device>"
diff --git a/src/app/scan.c b/src/app/scan.c
index 4acc331cfc26..684417704126 100644
--- a/src/app/scan.c
+++ b/src/app/scan.c
@@ -38,7 +38,7 @@ int umr_scan_asic(struct umr_asic *asic, char *asicname, char *ipname, char *reg
 				first = 1;
 				for (j = 0; j < asic->blocks[i]->no_regs; j++) {
 					if (!regname[0] || !strcmp(regname, "*") || !strcmp(regname, asic->blocks[i]->regs[j].regname) ||
-					(options.many && strstr(asic->blocks[i]->regs[j].regname, regname))) {
+					(asic->options.many && strstr(asic->blocks[i]->regs[j].regname, regname))) {
 						// only grant if any regspec matches otherwise it's a waste
 						if (first && asic->blocks[i]->grant) {
 							first = 0;
@@ -56,7 +56,7 @@ int umr_scan_asic(struct umr_asic *asic, char *asicname, char *ipname, char *reg
 							case REG_DIDT: fd = asic->fd.didt; scale = 1; break;
 							case REG_PCIE: fd = asic->fd.pcie; scale = 1; break;
 							case REG_SMC:
-								if (options.read_smc) {
+								if (asic->options.read_smc) {
 									fd = asic->fd.smc; scale = 1;
 								} else {
 									continue;
@@ -65,12 +65,8 @@ int umr_scan_asic(struct umr_asic *asic, char *asicname, char *ipname, char *reg
 							default: return -1;
 							}
 
-							if (options.use_bank && asic->blocks[i]->regs[j].type == REG_MMIO)
-								addr =
-									(1ULL << 62) |
-									(((uint64_t)options.se_bank) << 24) |
-									(((uint64_t)options.sh_bank) << 34) |
-									(((uint64_t)options.instance_bank) << 44);
+							if (asic->blocks[i]->regs[j].type == REG_MMIO)
+								addr = umr_apply_bank_selection_address(asic);
 							else
 								addr = 0;
 
@@ -87,17 +83,18 @@ int umr_scan_asic(struct umr_asic *asic, char *asicname, char *ipname, char *reg
 								goto error;
 							}
 						} else if (asic->blocks[i]->regs[j].type == REG_MMIO || asic->blocks[i]->regs[j].type == REG_SMC) {
-							if (options.use_bank)
-								umr_grbm_select_index(asic, options.se_bank, options.sh_bank, options.instance_bank);
+							// TODO: Add nokernel version of srbm select
+							if (asic->options.use_bank == 1)
+								umr_grbm_select_index(asic, asic->options.bank.grbm.se, asic->options.bank.grbm.sh, asic->options.bank.grbm.instance);
 							asic->blocks[i]->regs[j].value = umr_read_reg(asic, asic->blocks[i]->regs[j].addr * (asic->blocks[i]->regs[j].type == REG_MMIO ? 4 : 1), asic->blocks[i]->regs[j].type);
-							if (options.use_bank)
+							if (asic->options.use_bank == 1)
 								umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
 						}
 						if (regname[0]) {
-							if (options.named)
+							if (asic->options.named)
 								printf("%s%s.%s%s => ", CYAN, asic->blocks[i]->ipname,  asic->blocks[i]->regs[j].regname, RST);
 							printf("%s0x%08lx%s\n", YELLOW, (unsigned long)asic->blocks[i]->regs[j].value, RST);
-							if (options.bitfields)
+							if (asic->options.bitfields)
 								for (k = 0; k < asic->blocks[i]->regs[j].no_bits; k++) {
 									uint32_t v;
 									v = (1UL << (asic->blocks[i]->regs[j].bits[k].stop + 1 - asic->blocks[i]->regs[j].bits[k].start)) - 1;
diff --git a/src/app/scan_log.c b/src/app/scan_log.c
index 22fd7f42ad06..7a00770b1e6e 100644
--- a/src/app/scan_log.c
+++ b/src/app/scan_log.c
@@ -109,7 +109,7 @@ void umr_scan_log(struct umr_asic *asic)
 								asic->asicname, iplist[regno]->ipname, reglist[regno]->regname,
 								(unsigned long)delta,
 								(unsigned long)value);
-						if (options.bitfields)
+						if (asic->options.bitfields)
 							for (k = 0; k < reglist[regno]->no_bits; k++) {
 								uint32_t v;
 								v = (1UL << (reglist[regno]->bits[k].stop + 1 - reglist[regno]->bits[k].start)) - 1;
@@ -127,7 +127,7 @@ out:
 		}
 	}
 	fclose(f);
-	if (options.empty_log) {
+	if (asic->options.empty_log) {
 		f = fopen("/sys/kernel/debug/tracing/trace", "w");
 		if (f) {
 			fprintf(f, "foo\n");
diff --git a/src/app/set_bit.c b/src/app/set_bit.c
index 0cab26c0926c..e1090692705b 100644
--- a/src/app/set_bit.c
+++ b/src/app/set_bit.c
@@ -68,12 +68,8 @@ int umr_set_register_bit(struct umr_asic *asic, char *regpath, char *regvalue)
 										}
 									}
 
-									if (options.use_bank && asic->blocks[i]->regs[j].type == REG_MMIO)
-										addr =
-											(1ULL << 62) |
-											(((uint64_t)options.se_bank) << 24) |
-											(((uint64_t)options.sh_bank) << 34) |
-											(((uint64_t)options.instance_bank) << 44);
+									if (asic->blocks[i]->regs[j].type == REG_MMIO)
+										addr = umr_apply_bank_selection_address(asic);
 									else
 										addr = 0;
 
@@ -87,7 +83,7 @@ int umr_set_register_bit(struct umr_asic *asic, char *regpath, char *regvalue)
 
 									lseek(fd, addr | (asic->blocks[i]->regs[j].addr<<2), SEEK_SET);
 									write(fd, &copy, 4);
-									if (!options.quiet) printf("%s <= 0x%08lx\n", regpath, (unsigned long)copy);
+									if (!asic->options.quiet) printf("%s <= 0x%08lx\n", regpath, (unsigned long)copy);
 
 									if (asic->blocks[i]->release) {
 										if (asic->blocks[i]->release(asic)) {
@@ -95,14 +91,15 @@ int umr_set_register_bit(struct umr_asic *asic, char *regpath, char *regvalue)
 										}
 									}
 								} else if (asic->blocks[i]->regs[j].type == REG_MMIO) {
-									if (options.use_bank && options.no_kernel)
-										umr_grbm_select_index(asic, options.se_bank, options.sh_bank, options.instance_bank);
+									// TODO: Add nokernel version of srbm_select
+									if (asic->options.use_bank == 1 && asic->options.no_kernel)
+										umr_grbm_select_index(asic, asic->options.bank.grbm.se, asic->options.bank.grbm.sh, asic->options.bank.grbm.instance);
 									copy = asic->pci.mem[asic->blocks[i]->regs[j].addr] & ~mask;
 									copy |= (value << asic->blocks[i]->regs[j].bits[k].start) & mask;
 									asic->pci.mem[asic->blocks[i]->regs[j].addr] = copy;
-									if (options.use_bank && options.no_kernel)
+									if (asic->options.use_bank && asic->options.no_kernel)
 										umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
-									if (!options.quiet) printf("%s <= 0x%08lx\n", regpath, (unsigned long)copy);
+									if (!asic->options.quiet) printf("%s <= 0x%08lx\n", regpath, (unsigned long)copy);
 								}
 								return 0;
 							}
diff --git a/src/app/set_reg.c b/src/app/set_reg.c
index 15137aa510a3..1df68f102e1b 100644
--- a/src/app/set_reg.c
+++ b/src/app/set_reg.c
@@ -65,12 +65,8 @@ int umr_set_register(struct umr_asic *asic, char *regpath, char *regvalue)
 								}
 							}
 
-							if (options.use_bank && asic->blocks[i]->regs[j].type == REG_MMIO)
-								addr =
-									(1ULL << 62) |
-									(((uint64_t)options.se_bank) << 24) |
-									(((uint64_t)options.sh_bank) << 34) |
-									(((uint64_t)options.instance_bank) << 44);
+							if (asic->blocks[i]->regs[j].type == REG_MMIO)
+								addr = umr_apply_bank_selection_address(asic);
 							else
 								addr = 0;
 
@@ -83,10 +79,10 @@ int umr_set_register(struct umr_asic *asic, char *regpath, char *regvalue)
 								}
 							}
 						} else if (asic->blocks[i]->regs[j].type == REG_MMIO) {
-							if (options.use_bank)
-								umr_grbm_select_index(asic, options.se_bank, options.sh_bank, options.instance_bank);
+							if (asic->options.use_bank)
+								umr_grbm_select_index(asic, asic->options.bank.grbm.se, asic->options.bank.grbm.sh, asic->options.bank.grbm.instance);
 							asic->pci.mem[asic->blocks[i]->regs[j].addr] = value;
-							if (options.use_bank)
+							if (asic->options.use_bank)
 								umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
 						}
 						return 0;
diff --git a/src/app/top.c b/src/app/top.c
index af010154b835..a22f4dd6f7cc 100644
--- a/src/app/top.c
+++ b/src/app/top.c
@@ -1043,8 +1043,8 @@ static void top_build_vi_program(struct umr_asic *asic)
 
 	// which SE to read ...
 	regname = calloc(1, 64);
-	if (options.use_bank)
-		snprintf(regname, 63, "mmGRBM_STATUS_SE%d", options.se_bank);
+	if (options.use_bank == 1)
+		snprintf(regname, 63, "mmGRBM_STATUS_SE%d", options.bank.grbm.se);
 	else
 		snprintf(regname, 63, "mmGRBM_STATUS");
 
diff --git a/src/lib/CMakeLists.txt b/src/lib/CMakeLists.txt
index 515dced3c869..2f4f2689594f 100644
--- a/src/lib/CMakeLists.txt
+++ b/src/lib/CMakeLists.txt
@@ -24,6 +24,7 @@ add_library(umrcore STATIC
   sq_cmd_halt_waves.c
   transfer_soc15.c
   wave_status.c
+  umr_apply_bank_address.c
   update.c
   version.c
   $<TARGET_OBJECTS:asic> $<TARGET_OBJECTS:ip>
diff --git a/src/lib/umr_apply_bank_address.c b/src/lib/umr_apply_bank_address.c
new file mode 100644
index 000000000000..906acdab22ea
--- /dev/null
+++ b/src/lib/umr_apply_bank_address.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
+ *
+ * Authors: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
+ *
+ */
+#include "umr.h"
+
+uint64_t umr_apply_bank_selection_address(struct umr_asic *asic)
+{
+	if (asic->options.use_bank == 1) {
+		return 	(1ULL << 62) |
+				(((uint64_t)asic->options.bank.grbm.se) << 24) |
+				(((uint64_t)asic->options.bank.grbm.sh) << 34) |
+				(((uint64_t)asic->options.bank.grbm.instance) << 44);
+	} else if (asic->options.use_bank == 2) {
+		return 	(1ULL << 61) |
+				(((uint64_t)asic->options.bank.srbm.me) << 24) |
+				(((uint64_t)asic->options.bank.srbm.pipe) << 34) |
+				(((uint64_t)asic->options.bank.srbm.queue) << 44);
+	} else {
+		return 0;
+	}
+}
diff --git a/src/umr.h b/src/umr.h
index 4abd2c11f5f0..7a214bfb565e 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -192,10 +192,22 @@ struct umr_options {
 	    verbose,
 	    halt_waves,
 	    no_kernel;
-	unsigned
-	    instance_bank,
-	    se_bank,
-	    sh_bank;
+
+	union {
+		struct {
+			unsigned
+				instance,
+				se,
+				sh;
+		} grbm;
+		struct {
+			unsigned
+				me,
+				queue,
+				pipe;
+		} srbm;
+	} bank;
+
 	long forcedid;
 	char
 		*scanblock,
@@ -561,6 +573,9 @@ uint32_t umr_bitslice_compose_value(struct umr_asic *asic, struct umr_reg *reg,
 uint32_t umr_bitslice_compose_value_by_name(struct umr_asic *asic, char *reg, char *bitname, uint32_t regvalue);
 uint32_t umr_bitslice_compose_value_by_name_by_ip(struct umr_asic *asic, char *ip, char *regname, char *bitname, uint32_t regvalue);
 
+// bank switching
+uint64_t umr_apply_bank_selection_address(struct umr_asic *asic);
+
 // select a GRBM_GFX_IDX
 int umr_grbm_select_index(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t instance);
 
-- 
2.14.3


--------------6FD26B71B265C1735B53856A
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-Add-support-for-SRBM-selection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-Add-support-for-SRBM-selection.patch"

>From 38cb2961c04c1fb0737b3118a2c54a4051fb8c31 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 29 Mar 2018 09:09:39 -0400
Subject: drm/amdgpu: Add support for SRBM selection

Also remove code duplication in write and read regs functions.
This also fixes potential missing unlock in amdgpu_debugfs_regs_write
in case get_user would fail.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 117 ++++++++++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |   7 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |   7 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       |   7 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |   7 ++
 6 files changed, 70 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4e83928..548a407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -890,6 +890,7 @@ struct amdgpu_gfx_funcs {
 	void (*read_wave_data)(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields);
 	void (*read_wave_vgprs)(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t thread, uint32_t start, uint32_t size, uint32_t *dst);
 	void (*read_wave_sgprs)(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t start, uint32_t size, uint32_t *dst);
+	void (*select_me_pipe_q)(struct amdgpu_device *adev, u32 me, u32 pipe, u32 queue);
 };
 
 struct amdgpu_ngg_buf {
@@ -1815,6 +1816,7 @@ amdgpu_get_sdma_instance(struct amdgpu_ring *ring)
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
 #define amdgpu_gds_switch(adev, r, v, d, w, a) (adev)->gds.funcs->patch_gds_switch((r), (v), (d), (w), (a))
 #define amdgpu_psp_check_fw_loading_status(adev, i) (adev)->firmware.funcs->check_fw_loading_status((adev), (i))
+#define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q))
 
 /* Common functions */
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index baa64e2..c98e597 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -64,16 +64,21 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
 
 #if defined(CONFIG_DEBUG_FS)
 
-static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
-					size_t size, loff_t *pos)
+
+static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
+		char __user *buf, size_t size, loff_t *pos)
 {
 	struct amdgpu_device *adev = file_inode(f)->i_private;
 	ssize_t result = 0;
 	int r;
-	bool pm_pg_lock, use_bank;
-	unsigned instance_bank, sh_bank, se_bank;
+	bool pm_pg_lock, use_bank, use_ring;
+	unsigned instance_bank, sh_bank, se_bank, me, pipe, queue;
 
-	if (size & 0x3 || *pos & 0x3)
+	pm_pg_lock = use_bank = use_ring = false;
+	instance_bank = sh_bank = se_bank = me = pipe = queue = 0;
+
+	if (size & 0x3 || *pos & 0x3 ||
+			((*pos & (1ULL << 62)) && (*pos & (1ULL << 61))))
 		return -EINVAL;
 
 	/* are we reading registers for which a PG lock is necessary? */
@@ -91,8 +96,15 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 		if (instance_bank == 0x3FF)
 			instance_bank = 0xFFFFFFFF;
 		use_bank = 1;
+	} else if (*pos & (1ULL << 61)) {
+
+		me = (*pos & GENMASK_ULL(33, 24)) >> 24;
+		pipe = (*pos & GENMASK_ULL(43, 34)) >> 34;
+		queue = (*pos & GENMASK_ULL(53, 44)) >> 44;
+
+		use_ring = 1;
 	} else {
-		use_bank = 0;
+		use_bank = use_ring = 0;
 	}
 
 	*pos &= (1UL << 22) - 1;
@@ -104,6 +116,9 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 		mutex_lock(&adev->grbm_idx_mutex);
 		amdgpu_gfx_select_se_sh(adev, se_bank,
 					sh_bank, instance_bank);
+	} else if (use_ring) {
+		mutex_lock(&adev->srbm_mutex);
+		amdgpu_gfx_select_me_pipe_q(adev, me, pipe, queue);
 	}
 
 	if (pm_pg_lock)
@@ -115,8 +130,14 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 		if (*pos > adev->rmmio_size)
 			goto end;
 
-		value = RREG32(*pos >> 2);
-		r = put_user(value, (uint32_t *)buf);
+		if (read) {
+			value = RREG32(*pos >> 2);
+			r = put_user(value, (uint32_t *)buf);
+		} else {
+			r = get_user(value, (uint32_t *)buf);
+			if (!r)
+				WREG32(*pos >> 2, value);
+		}
 		if (r) {
 			result = r;
 			goto end;
@@ -132,6 +153,9 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 	if (use_bank) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 		mutex_unlock(&adev->grbm_idx_mutex);
+	} else if (use_ring) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
 	}
 
 	if (pm_pg_lock)
@@ -140,78 +164,17 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 	return result;
 }
 
+
+static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
+					size_t size, loff_t *pos)
+{
+	return amdgpu_debugfs_process_reg_op(true, f, buf, size, pos);
+}
+
 static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
 					 size_t size, loff_t *pos)
 {
-	struct amdgpu_device *adev = file_inode(f)->i_private;
-	ssize_t result = 0;
-	int r;
-	bool pm_pg_lock, use_bank;
-	unsigned instance_bank, sh_bank, se_bank;
-
-	if (size & 0x3 || *pos & 0x3)
-		return -EINVAL;
-
-	/* are we reading registers for which a PG lock is necessary? */
-	pm_pg_lock = (*pos >> 23) & 1;
-
-	if (*pos & (1ULL << 62)) {
-		se_bank = (*pos & GENMASK_ULL(33, 24)) >> 24;
-		sh_bank = (*pos & GENMASK_ULL(43, 34)) >> 34;
-		instance_bank = (*pos & GENMASK_ULL(53, 44)) >> 44;
-
-		if (se_bank == 0x3FF)
-			se_bank = 0xFFFFFFFF;
-		if (sh_bank == 0x3FF)
-			sh_bank = 0xFFFFFFFF;
-		if (instance_bank == 0x3FF)
-			instance_bank = 0xFFFFFFFF;
-		use_bank = 1;
-	} else {
-		use_bank = 0;
-	}
-
-	*pos &= (1UL << 22) - 1;
-
-	if (use_bank) {
-		if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) ||
-		    (se_bank != 0xFFFFFFFF && se_bank >= adev->gfx.config.max_shader_engines))
-			return -EINVAL;
-		mutex_lock(&adev->grbm_idx_mutex);
-		amdgpu_gfx_select_se_sh(adev, se_bank,
-					sh_bank, instance_bank);
-	}
-
-	if (pm_pg_lock)
-		mutex_lock(&adev->pm.mutex);
-
-	while (size) {
-		uint32_t value;
-
-		if (*pos > adev->rmmio_size)
-			return result;
-
-		r = get_user(value, (uint32_t *)buf);
-		if (r)
-			return r;
-
-		WREG32(*pos >> 2, value);
-
-		result += 4;
-		buf += 4;
-		*pos += 4;
-		size -= 4;
-	}
-
-	if (use_bank) {
-		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-		mutex_unlock(&adev->grbm_idx_mutex);
-	}
-
-	if (pm_pg_lock)
-		mutex_unlock(&adev->pm.mutex);
-
-	return result;
+	return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
 }
 
 static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 0fff5b8..cd6bf29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3061,11 +3061,18 @@ static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
 }
 
+static void gfx_v6_0_select_me_pipe_q(struct amdgpu_device *adev,
+				  u32 me, u32 pipe, u32 q)
+{
+	DRM_INFO("Not implemented\n");
+}
+
 static const struct amdgpu_gfx_funcs gfx_v6_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v6_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v6_0_select_se_sh,
 	.read_wave_data = &gfx_v6_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v6_0_read_wave_sgprs,
+	.select_me_pipe_q = &gfx_v6_0_select_me_pipe_q
 };
 
 static int gfx_v6_0_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index e13d9d8..42b6144 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4270,11 +4270,18 @@ static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
 		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
 }
 
+static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
+				  u32 me, u32 pipe, u32 q)
+{
+	cik_srbm_select(adev, me, pipe, q, 0);
+}
+
 static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v7_0_select_se_sh,
 	.read_wave_data = &gfx_v7_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
+	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
 };
 
 static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 27943e5..b0e591e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3475,6 +3475,12 @@ static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
 	WREG32(mmGRBM_GFX_INDEX, data);
 }
 
+static void gfx_v8_0_select_me_pipe_q(struct amdgpu_device *adev,
+				  u32 me, u32 pipe, u32 q)
+{
+	vi_srbm_select(adev, me, pipe, q, 0);
+}
+
 static u32 gfx_v8_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 {
 	u32 data, mask;
@@ -5442,6 +5448,7 @@ static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
 	.select_se_sh = &gfx_v8_0_select_se_sh,
 	.read_wave_data = &gfx_v8_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
+	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
 };
 
 static int gfx_v8_0_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ae90c95..059c17f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -998,12 +998,19 @@ static void gfx_v9_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 		start + SQIND_WAVE_VGPRS_OFFSET, size, dst);
 }
 
+static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
+				  u32 me, u32 pipe, u32 q)
+{
+	soc15_grbm_select(adev, me, pipe, q, 0);
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v9_0_select_se_sh,
 	.read_wave_data = &gfx_v9_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
 	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
+	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q
 };
 
 static void gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.7.4


--------------6FD26B71B265C1735B53856A
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------6FD26B71B265C1735B53856A--
