Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 01:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0348D20771
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 01:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0348D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0680E6E5A9;
	Wed,  1 Jul 2020 01:05:19 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8FC6E045
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 23:45:20 +0000 (UTC)
IronPort-SDR: g5bQyz7LyB+TIUWKN/3HysfstDHpLqjpOYsZHVtNap3JGl0MssgQqiEUYljUgAwLgz7KMwNNwN
 Zwo9JtcW7UVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="147962833"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="147962833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 16:45:19 -0700
IronPort-SDR: AN7qYKkRVk/ouTSW9BJbG0hGRsv0xDPT8Ua5LCWaSHlTuNihdk6tL0AkzFY/482mgX+r5FCAwf
 wTJMklFeWAmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="386842579"
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
Subject: [PATCH v5 11/12] sched: Define and initialize a flag to identify
 valid PASID in the task
Date: Tue, 30 Jun 2020 16:44:41 -0700
Message-Id: <1593560682-40814-12-git-send-email-fenghua.yu@intel.com>
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

From: Peter Zijlstra <peterz@infradead.org>

The flag is defined for the task to identify if the task has a valid
PASID. Its initial value is 0 when the task is forked/cloned. It will
be used shortly.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v2:
- Add this patch to define the flag to identify valid PASID MSR (PeterZ)

 include/linux/sched.h | 3 +++
 kernel/fork.c         | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..042d6f5cde6a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -800,6 +800,9 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
+#ifdef CONFIG_IOMMU_SUPPORT
+	unsigned			has_valid_pasid:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 43b5f112604d..0a962bebdf88 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -955,6 +955,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->use_memdelay = 0;
 #endif
 
+#ifdef CONFIG_IOMMU_SUPPORT
+	tsk->has_valid_pasid = 0;
+#endif
+
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
-- 
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
