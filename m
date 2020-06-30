Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A46C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 01:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5599F20771
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 01:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5599F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405CB6E5AB;
	Wed,  1 Jul 2020 01:05:18 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3346E2BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 23:45:19 +0000 (UTC)
IronPort-SDR: dWvZU4+eTjuPH2IpPIceRNszeb3HFWYNRJuBF4gPxDPT7QLGKTykz9mVX1JI0zSCM3OsOPY4DW
 PwbYU7nhX3AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="145486446"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="145486446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 16:45:18 -0700
IronPort-SDR: 8+CjBQPdePimqf+TzioEfl44SiSRDWe8XSCvL5eLQHFJqFthBCwHH+h9qfUWXq3YMiAvZkCMzz
 J27V+ZaRokTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="386842571"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2020 16:44:53 -0700
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
Subject: [PATCH v5 08/12] fork: Clear PASID for new mm
Date: Tue, 30 Jun 2020 16:44:38 -0700
Message-Id: <1593560682-40814-9-git-send-email-fenghua.yu@intel.com>
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

When a new mm is created, its PASID should be cleared, i.e. the PASID is
initialized to its init state 0 on both ARM and X86.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Add this patch to initialize PASID value for a new mm.

 include/linux/mm_types.h | 2 ++
 kernel/fork.c            | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d61285cfe027..d60d2ec10881 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -22,6 +22,8 @@
 #endif
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
+/* Initial PASID value is 0. */
+#define INIT_PASID	0
 
 struct address_space;
 struct mem_cgroup;
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..43b5f112604d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1007,6 +1007,13 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 #endif
 }
 
+static void mm_init_pasid(struct mm_struct *mm)
+{
+#ifdef CONFIG_IOMMU_SUPPORT
+	mm->pasid = INIT_PASID;
+#endif
+}
+
 static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
@@ -1035,6 +1042,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
+	mm_init_pasid(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-- 
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
