Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA062C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 01:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CA720771
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 01:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CA720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9436E5A1;
	Wed,  1 Jul 2020 01:05:12 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C28D6E2BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 23:45:20 +0000 (UTC)
IronPort-SDR: IkkH/fIyxwPgPV8itrXz6vLHnUPmHiMbXw5otxcrAZc7o+KzWYeHwtytRJqmJFCm5HUlxe8QzA
 huB/iLtj6/jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="133879145"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="133879145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 16:45:19 -0700
IronPort-SDR: ZNUaPrHGUHJJWvL/OYqoTtuNpj6CLxAtZSWDnSeS6/opAbQBTV8IkcPZCVH3CPfSl1G03gJKxL
 TfS8f84BGtdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="386842577"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2020 16:44:54 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Joerg Roedel" <joro@8bytes.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Felix Kuehling" <Felix.Kuehling@amd.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradead.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v5 12/12] x86/traps: Fix up invalid PASID
Date: Tue, 30 Jun 2020 16:44:42 -0700
Message-Id: <1593560682-40814-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
References: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
X-Mailman-Approved-At: Wed, 01 Jul 2020 01:05:10 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A #GP fault is generated when ENQCMD instruction is executed without
a valid PASID value programmed in the current thread's PASID MSR. The
#GP fault handler will initialize the MSR if a PASID has been allocated
for this process.

Decoding the user instruction is ugly and sets a bad architecture
precedent. It may not function if the faulting instruction is modified
after #GP.

Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
without a valid PASID value programmed. #GP error codes are 16 bits and all
16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
when loading from the source operand, so its not fully comprehending all
the reasons. Rather than special case the ENQCMD, in future Intel may
choose a different fault mechanism for such cases if recovery is needed on
#GP.

The following heuristic is used to avoid decoding the user instructions
to determine the precise reason for the #GP fault:
1) If the mm for the process has not been allocated a PASID, this #GP
   cannot be fixed.
2) If the PASID MSR is already initialized, then the #GP was for some
   other reason
3) Try initializing the PASID MSR and returning. If the #GP was from
   an ENQCMD this will fix it. If not, the #GP fault will be repeated
   and will hit case "2".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
v5:
- Use cpu_feature_enabled() and remove redundant CONFIG_INTEL_IOMMU_SVM
  check which is included in cpu_feature_enabled() in
  fixup_pasid_exception() (PeterZ and Dave Hansen)
- Reviewed by Lu Baolu

v4:
- Change PASID type to u32 (Christoph)

v3:
- Check and set current->has_valid_pasid in fixup() (PeterZ)
- Add fpu__pasid_write() to update the MSR (PeterZ)
- Add ioasid_find() sanity check in fixup()

v2:
- Update the first paragraph of the commit message (Thomas)
- Add reasons why don't decode the user instruction and don't use
  #GP error code (Thomas)
- Change get_task_mm() to current->mm (Thomas)
- Add comments on why IRQ is disabled during PASID fixup (Thomas)
- Add comment in fixup() that the function is called when #GP is from
  user (so mm is not NULL) (Dave Hansen)

 arch/x86/include/asm/iommu.h |  1 +
 arch/x86/kernel/traps.c      | 12 ++++++
 drivers/iommu/intel/svm.c    | 78 ++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index ed41259fe7ac..e9365a5d6f7d 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -27,5 +27,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 }
 
 void __free_pasid(struct mm_struct *mm);
+bool __fixup_pasid_exception(void);
 
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f58679e487f6..fe0f7d00523b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -59,6 +59,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/iommu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -518,6 +519,14 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	return GP_CANONICAL;
 }
 
+static bool fixup_pasid_exception(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return false;
+
+	return __fixup_pasid_exception();
+}
+
 #define GPFSTR "general protection fault"
 
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
@@ -530,6 +539,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	cond_local_irq_enable(regs);
 
+	if (user_mode(regs) && fixup_pasid_exception())
+		goto exit;
+
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
 			goto exit;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4c788880b037..4a84c82a4f8c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1105,3 +1105,81 @@ void __free_pasid(struct mm_struct *mm)
 	 */
 	ioasid_free(pasid);
 }
+
+/*
+ * Write the current task's PASID MSR/state. This is called only when PASID
+ * is enabled.
+ */
+static void fpu__pasid_write(u32 pasid)
+{
+	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
+
+	fpregs_lock();
+
+	/*
+	 * If the MSR is active and owned by the current task's FPU, it can
+	 * be directly written.
+	 *
+	 * Otherwise, write the fpstate.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		wrmsrl(MSR_IA32_PASID, msr_val);
+	} else {
+		struct ia32_pasid_state *ppasid_state;
+
+		ppasid_state = get_xsave_addr(&current->thread.fpu.state.xsave,
+					      XFEATURE_PASID);
+		/*
+		 * ppasid_state shouldn't be NULL because XFEATURE_PASID
+		 * is enabled.
+		 */
+		WARN_ON_ONCE(!ppasid_state);
+		ppasid_state->pasid = msr_val;
+	}
+	fpregs_unlock();
+}
+
+/*
+ * Apply some heuristics to see if the #GP fault was caused by a thread
+ * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
+ * is the problem, try initializing the IA32_PASID MSR. If the heuristic
+ * guesses incorrectly, take one more #GP fault.
+ */
+bool __fixup_pasid_exception(void)
+{
+	struct intel_svm *svm;
+	struct mm_struct *mm;
+	u32 pasid;
+
+	/*
+	 * If the current task already has a valid PASID in the MSR,
+	 * the #GP must be for some other reason.
+	 */
+	if (current->has_valid_pasid)
+		return false;
+
+	/*
+	 * This function is called only when this #GP was triggered from user
+	 * space. So the mm cannot be NULL.
+	 */
+	mm = current->mm;
+	pasid = mm->pasid;
+
+	/*
+	 * If the PASID isn't found, cannot help.
+	 *
+	 * Don't care if the PASID is bound to the mm here. #PF will handle the
+	 * case that the MSR is fixed up by an unbound PASID.
+	 */
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (IS_ERR_OR_NULL(svm))
+		return false;
+
+	/* Fix up the MSR by the PASID in the mm. */
+	fpu__pasid_write(pasid);
+
+	/* Now the current task has a valid PASID in the MSR. */
+	current->has_valid_pasid = 1;
+
+	return true;
+}
-- 
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
