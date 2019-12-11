Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A2FC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC4B20836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PuGCKhMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC4B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE336E10D;
	Wed, 11 Dec 2019 20:07:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690086.outbound.protection.outlook.com [40.107.69.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C759C6E10D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjCHURSI0R472gAwK6QQWCbn5NkljjVsCyZ3ndsac1joXC/Dz59x+oeuW/kIc8hFn0dN+Iid1vXbno+IlSgvtqeIgwjAJC1VvNDtQVi4RXiGcDz87Sp+IUfDvpKz7nOcrDG3h+bQOmttJh6uRRCIh7Hnik6RUd+nCN3ka7vU9VsvXDSyXbbrBY5NePtjYjfvWZuiU+hcK4xfZbtH7vN2XLWAPRqHJ6vcveMUb+v8xLNScxBVrawQfdI55yQFdYMSCUrLthWPk17FVig1+ZgHO4lrTGfr8wqSPY21HOQwQMpDjmwqbnJVnJBKK2CkHA065YPW+dB4kbON2hRJNgC2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRR05pclpFlF2SM9H//7+VXS0dvCVF9T6VaEBCk6vP4=;
 b=hILm3p8k8C29/ltEyaq6DoDo1v+93PYASIJjTKRmLCyjBOFZsic5UDTLFk4+0S0xohz/lFDK9xCI0wYNitdyL3WE+pLe6PRMpKW7eB4y7LNxZD6uWgLRbnRNPxgnnrpfj9VTZ2CC+9hF21iiL0ywx0oNlJfmnRpI0eRwfqWVrL84pLLnONy0nKujCb7Ml3/YcL8TfhxWIFlENg+UKL3f16lmnfxXECk0svfSSBcnPZB6m+AWsD792GmKPT/WnFhMRlBCmgQYHm+kvokXYedDMi4WuVLdgtsFtWGZU7Q2I93bpIwKLLxioG3qHS1bsRRBgj6m6gHEN6BIbrVrQOGyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRR05pclpFlF2SM9H//7+VXS0dvCVF9T6VaEBCk6vP4=;
 b=PuGCKhMIbLi215eYQhMvhucvHHxuWs9iNIXzFp7OpUhuaM7o7mzjC3gbfAqkvGoZuLoi4xHtCQek+NjKRAJqyev+4s57Ju+rQDSjCL+/DS9eElxqQ73d2ITGnCGPbpIVa/UK+KifUK25ud0uE4IDfgzNFsye7iF/VW6XLme4JNc=
Received: from BN6PR12CA0040.namprd12.prod.outlook.com (2603:10b6:405:70::26)
 by BN8PR12MB3601.namprd12.prod.outlook.com (2603:10b6:408:46::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Wed, 11 Dec
 2019 20:07:20 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by BN6PR12CA0040.outlook.office365.com
 (2603:10b6:405:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 20:07:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 20:07:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:18 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:18 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 14:07:17 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm: Add Reusable task barrier.
Date: Wed, 11 Dec 2019 15:07:06 -0500
Message-ID: <1576094829-2245-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(428003)(189003)(199004)(26005)(81166006)(81156014)(356004)(966005)(5660300002)(7696005)(426003)(6666004)(86362001)(8936002)(336012)(186003)(2616005)(478600001)(70206006)(2906002)(8676002)(44832011)(6916009)(316002)(54906003)(4326008)(36756003)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3601; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40bb47c-e9e3-4103-d0ff-08d77e75ba3f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3601:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3601140CEE8CE5860B68D7EDEA5A0@BN8PR12MB3601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdhEsgJP0GeN8UxSaPQIZ4YQPbgqXxej55iDYUB3iD/FMa6gIdzEZAVtH7teIzw9SwSW7nx2Zi28AG462Tk6AvBxgMhcd9w5iGI6XcsIiyLCiNkX2zXBP8am9AIbIRzazgeqFvSAsLVCcxUJpYvBYgvBWGCLk0s6YIeXj1J/74kayaggJdaHneqF+O/IKGC1CTQjLVxtJ6YDPgYJB6V1AUi2DRuS0QNvyhkHTMbvrL0o6k4Wbv+TZK6yGpOzoduHMUWRbA4bNY3SANdG3BeOzd2+hrNsTJRe5488Ed4wUnfaN2LZlYrbl09F04gmskx/rYtdj2aTEfEmiM6p4WWfh/rgGffGSu2GRlkwCUQK3Rc5kfMzccUnAbRBWzvQhiMIir5M9AncHzOxLRk960U+77W2hER1yqJc3pflQ/7Ir8mMNE/nCbjHRMQy7s8ySaGT/3Y9y+V8RJQXEAzkw20uYy3YJciOhIuEmUQwC1f5Fv4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 20:07:19.5657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40bb47c-e9e3-4103-d0ff-08d77e75ba3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3601
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Evan.Quan@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is used to synchronize N threads at a rendevouz point before execution
of critical code that has to be started by all the threads at approximatly
the same time.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 include/drm/task_barrier.h | 106 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 include/drm/task_barrier.h

diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
new file mode 100644
index 0000000..81fb0f7
--- /dev/null
+++ b/include/drm/task_barrier.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+ */
+#include <linux/semaphore.h>
+#include <linux/atomic.h>
+
+/*
+ * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
+ * Based on the Little book of sempahores - https://greenteapress.com/wp/semaphores/
+ */
+
+
+
+#ifndef DRM_TASK_BARRIER_H_
+#define DRM_TASK_BARRIER_H_
+
+/*
+ * Represents an instance of a task barrier.
+ */
+struct task_barrier {
+	unsigned int n;
+	atomic_t count;
+	struct semaphore enter_turnstile;
+	struct semaphore exit_turnstile;
+};
+
+static inline void task_barrier_signal_turnstile(struct semaphore *turnstile,
+						 unsigned int n)
+{
+	int i;
+
+	for (i = 0 ; i < n; i++)
+		up(turnstile);
+}
+
+static inline void task_barrier_init(struct task_barrier *tb)
+{
+	tb->n = 0;
+	atomic_set(&tb->count, 0);
+	sema_init(&tb->enter_turnstile, 0);
+	sema_init(&tb->exit_turnstile, 0);
+}
+
+static inline void task_barrier_add_task(struct task_barrier *tb)
+{
+	tb->n++;
+}
+
+static inline void task_barrier_rem_task(struct task_barrier *tb)
+{
+	tb->n--;
+}
+
+/*
+ * Lines up all the threads BEFORE the critical point.
+ *
+ * When all thread passed this code the entry barrier is back to locked state.
+ */
+static inline void task_barrier_enter(struct task_barrier *tb)
+{
+	if (atomic_inc_return(&tb->count) == tb->n)
+		task_barrier_signal_turnstile(&tb->enter_turnstile, tb->n);
+
+	down(&tb->enter_turnstile);
+}
+
+/*
+ * Lines up all the threads AFTER the critical point.
+ *
+ * This function is used to avoid any one thread running ahead of the reset if
+ * the barrier is used in a loop (repeatedly) .
+ */
+static inline void task_barrier_exit(struct task_barrier *tb)
+{
+	if (atomic_dec_return(&tb->count) == 0)
+		task_barrier_signal_turnstile(&tb->exit_turnstile, tb->n);
+
+	down(&tb->exit_turnstile);
+}
+
+static inline void task_barrier_full(struct task_barrier *tb)
+{
+	task_barrier_enter(tb);
+	task_barrier_exit(tb);
+}
+
+#endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
