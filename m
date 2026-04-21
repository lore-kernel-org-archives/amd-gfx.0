Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95499F94CA1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3F210E55B;
	Tue, 21 Apr 2026 18:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5VL2i2DL";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D912910E903
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoO/Vmsv6icHqWzysydY5ZTJ4/lRw+8fzSntjbsz4CXgRbwvfujntDCz0zuRd74gHSjgtP5swuw38Op4CWfNke+osEEDtxfq5Qp1mYg01Eax1FZhzXMGewObmnVTyIiNbZpwf6VKCRt4rE5XEdO7VCcyizwPpcQOA+7F9mk1QpFwEqDZk2tBl1axtvMIWEciVStSOrYBX1bhLaLJ++/P9JDjYiAu/LgsbXop/guG+NO8ffdOnB/DGx1hZqa3ehWvyDsIgjeqWTgZnV5tRoGU/rnqL5VNYs3bA5uyFBpVTOH6hd4Dc0HKenqER9A/SXqaJ+7bopfo3X1a3+fSYNA05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pubxbmYJiBU5ZKVXK3hn+2OmaJ0i87lYB2aTq2XyX3s=;
 b=L0Ph+uLFYHkYFbycV0uvNqtjxjKWhztt/lTgSX0b/ah5xfjJK8IgmunkEVTJvAxCvT8Dfcekz6APPp7iE0Pwhsh6fuf8GMOwrHROHTC/s/lrfwzuMdiFLOUZ9BSPrwUMzv65O/I3tqbsH615xWksJmxF4p1nxoo+PNDgezi2Sav2G9YgGr7oJpJIBkrFm3o8IE4DM7Fr8EaxgKGPFMWGwheRuP+vEf09LhHSzshvjsUyOYyUOAeuHGcpUAFjbSMtZ2GYS2pBFUhpOw+hZCTEw9xe4PCfFYQiWnOAfk2ca5bp9AuHa3Ssx5PfdvSzAod80KC87VTDbdG6a349KUQj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pubxbmYJiBU5ZKVXK3hn+2OmaJ0i87lYB2aTq2XyX3s=;
 b=5VL2i2DLx2Sty8XWNtOv+dGPlSiUK9Lq8u+JFAWdWYyeaQfv+n6ygK66xH10PKQXyhqMp7JNTdu1Wlt/CWe/nAC1OXQeRJBROIql1yO4IiGAab9keDUYdE4SQDbJeQ7aKVDKw0uMTe4RB79zoE0FoheR/QQhqRCo8//ZWqXGEO4=
Received: from BLAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:32d::7)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:05:30 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::93) by BLAPR03CA0032.outlook.office365.com
 (2603:10b6:208:32d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:05:29 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 13:05:28 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <amir.shetaia@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH v2] drm/amdkfd: validate SVM ioctl nattr against buffer size
Date: Tue, 21 Apr 2026 14:05:21 -0400
Message-ID: <20260421180521.24426-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9212aa-c12f-4d36-55c9-08de9fd0927c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gWaeb0MJFU4CuU3wsIGEPdZUoQloFjSvfcHMBh4HIdzynvKndo9Q+OXnKY/NrYm8sRtvB1ZBpSaUzs9KOpExI84fMy1agQUk3xy/rylCFpSbL3xK2YY1k1TLqFakRNCooyYnAeIi5X6FUPo9oyTIU6p+AelTdg/WVuJfvXK7W/nNKX3/IZg4U3nvY26i5pwG2jgx53Z3fvY0yvN/Ivsl5kR5/nVhEgSBIaZOtyiFMvT3svdgdXypd3sR9/22m7G9ASfoUdyCQotOr4JPLs1MN2VPL7/o1jqZaF3+v5b8Xu4fl0VWaVtGbEEm2Esb3ETLUyCnnvD5Ayx8cGzbcyzGSlVEO5Hd2a7hT/zNvVnXAK3UlAdddKL562CPR828Y3+If/SBXYodapysB9rZUR1zUyXUs8i6b/vIMSGxEwo+rrKzeRINNsdjmjfJLXPL8u+JgoymEcV7ejtHQ1OWYRDzt1lV/W+DJZC6y66qqxPPoNSZ/pON9gG15my82/VR6g1w05abM8wXPEBGNLQ4opJj0GTWhAgo5N87C85O8bLnkBMLi5KD5AlizrPh+NtLIUReW28vuOni0E2Jwhtxjqh8kc6sHA3cq70PJyOKLWi6wiZU//MHQsbt3BvOz7OeEgx98dsn9H6fNdg0o6GYwZkFTM/4gRbhh9jEoYEzhcUT1mJCwrbh+4+dJPYDp2sC9Xjt25nelNeXTGXGqpSBsxADxFN5KG0ZljtfBg4506NSKNvcdX7VMRQurjR2ofvgL5Kyk7NoAdaOTMZlH4ioS2Eziw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: juyHk2cYsSWaBrrXz1QocbctL0FX9DPXenEVR7ZO0F7Q9WJnkoONDfIG52LAjGHh9VvlV7APxTwe7Tqrnss2BfdM5HKKcBHe5w1sJpV1tjYhtOy93yabEG3X+LgljLV3x1vsZSY5Eo4Ju608XA59aDNgz1fWl9sPKqKUWAH6ax0Pp610eGrfR4HwaJumMgERMeuHQBkaoT22LN5gcj04es8cITsSOEJE+UbwrKzj1sa0VEUYmrPxgMOL3Lc+wG99NZbvfVLK2pJZgXkcNDcVA5SLr3R4dlXG70lfq672ggwmg0Vr3HNbD0CJAXe+M6iaTdtpbVpjdOkiuJDS7A8ZIrLhj1g3Y+wXARXlJ8OTtLSH64zxnEdZLEw5sMKUwVWwyroiZE8TSBoyr23ymUX9zNttOgKnag6KCrwnXwueJ9qyfQRUg/g3s2Duew/KM69l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:05:29.2411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9212aa-c12f-4d36-55c9-08de9fd0927c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Validate nattr field against the buffer size, preventing
out-of-bounds buffer access via user-controlled attribute count.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 16fb39259911..57c5490a1b0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -1729,6 +1730,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 	return r;
 }
 
+static int kfd_ioctl_svm_validate(void *kdata, unsigned int usize)
+{
+	struct kfd_ioctl_svm_args *args = kdata;
+	size_t expected = struct_size(args, attrs, args->nattr);
+
+	if (expected == SIZE_MAX || usize < expected)
+		return -EINVAL;
+	return 0;
+}
+
 static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_svm_args *args = data;
@@ -3411,7 +3422,11 @@ static int kfd_ioctl_profiler(struct file *filep, struct kfd_process *p, void *d
 
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
-			    .cmd_drv = 0, .name = #ioctl}
+			    .validate = NULL, .cmd_drv = 0, .name = #ioctl}
+
+#define AMDKFD_IOCTL_DEF_V(ioctl, _func, _validate, _flags) \
+	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
+			    .validate = _validate, .cmd_drv = 0, .name = #ioctl}
 
 /** Ioctl table */
 static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
@@ -3508,7 +3523,8 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
 			kfd_ioctl_smi_events, 0),
 
-	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SVM, kfd_ioctl_svm, 0),
+	AMDKFD_IOCTL_DEF_V(AMDKFD_IOC_SVM, kfd_ioctl_svm,
+			   kfd_ioctl_svm_validate, 0),
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_XNACK_MODE,
 			kfd_ioctl_set_xnack_mode, 0),
@@ -3636,6 +3652,12 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		memset(kdata, 0, usize);
 	}
 
+	if (ioctl->validate) {
+		retcode = ioctl->validate(kdata, usize);
+		if (retcode)
+			goto err_i1;
+	}
+
 	retcode = func(filep, process, kdata);
 
 	if (cmd & IOC_OUT)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 53c26b1a25ca..ae327611f20c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1056,10 +1056,13 @@ extern struct srcu_struct kfd_processes_srcu;
 typedef int amdkfd_ioctl_t(struct file *filep, struct kfd_process *p,
 				void *data);
 
+typedef int amdkfd_ioctl_validate_t(void *kdata, unsigned int usize);
+
 struct amdkfd_ioctl_desc {
 	unsigned int cmd;
 	int flags;
 	amdkfd_ioctl_t *func;
+	amdkfd_ioctl_validate_t *validate;
 	unsigned int cmd_drv;
 	const char *name;
 };
-- 
2.34.1

