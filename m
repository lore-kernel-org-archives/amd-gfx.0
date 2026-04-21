Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA093F94CA7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 19:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A54710ED8E;
	Tue, 21 Apr 2026 19:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LN5e5eMS";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6649610E214
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 19:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZAe/Q7De17UDVWCHAnfaR6et2UeizF+Wtc12HMfVJV9Zv1iiGAGrVqKMcZhevjMza+8qRyuN7xI3RdnwGGF3bOixb8AmvkqmwPiT+pZ4WsSYz47qQAw2sUqgcvoO3/NwlUq8PKCCqomzooCb40/MLA6rUqDEbkbNlHffm/NwdjiYey0VDT5F74KLePbGu033IHjcHSpzeTD6/rxVkAdTSO8gqux30P9KFbF6v2151NJD3ukW9DeHY1ruEHG59c8byptsF41a4PBbXxUX1/0gTugK26QxvJzC03ksQoZhnK9jg+ySAWWXTsfUKObrOBQJsz/ecObLNtbkbm+Qz7+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9TFOwIFBu9V7ANSeeCzJZle3EbLGuUySLkRz3RoK/0=;
 b=Ni+XH84UifHee0rH9+Mdsl8DTjmqA0YzmA4Ati8hESV2rxmOYR82ObPnl3JQWIFBCGHPBIr3hx5nAmEBrR4/VnK+u9dsfhIv6P39JGV7n2KhheT4zDUpjnnftRUojNjiiAesNM4h1fr3P9M/Hciz2pCBA2NyID/jBKR89fMPUE1Oam4lA1PyNVX2Uf8dSnWYN/iNiMk5Y43l01+tOBiEzLDtbYA/3fYgBafnXpSze8SaBSynKmgbW62ooR5E1o3+pDIkru3A0WiBucGLyAYd+blKbhULzucCug0I0ITEpOscpZhW21iyP3ULnmGzwBJLQT3bCFx+RZCe1RsLXuU/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9TFOwIFBu9V7ANSeeCzJZle3EbLGuUySLkRz3RoK/0=;
 b=LN5e5eMSOC+IEFpCW9DNQdfxSNwEVuiyFvrQenNTAqausnDPj3ZCbqKZ/IstgGhtO59qh0xZ3CHRdwyMSNr0kU7iIT4IhBMZvoqwIVY6V+p/On4vS9F12ZW3BI35purJ/L50Z5Qoz2HkyJ5TwGz4vnnjr6eeLZaU7xsxDp93nN8=
Received: from PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::7)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 19:24:14 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::48) by PH5P220CA0006.outlook.office365.com
 (2603:10b6:510:34a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 19:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 19:24:14 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 14:24:13 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <amir.shetaia@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH v3] drm/amdkfd: validate SVM ioctl nattr against buffer size
Date: Tue, 21 Apr 2026 15:24:06 -0400
Message-ID: <20260421192406.25128-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8f8356-cea6-4580-134e-08de9fdb92b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VSjdYxmdELSASe9QZuaVqhlad0zuAAf9j4GJPyXoiFb11Sd20B5ffdi5EFaSQgygRu8UeRq+eifjBJGMh0syU5k3L+BbqSLpmvIn6wZgoPvB3eNZEM9ElqBn6uWVGs53NYXcHRaI4jvIn0C0eepjEQ/uKnwx7KIgl6aNI7AIms+zXnxoWRfaJiIpVvUbkKycloM142NpcQZ9/t3mht0p5fq+GZYu91qT+Hi8FPplDIbc0Cbf3pmuvVVePC1KevRRKFDZhclK8DsfWDmxGTwsjmy+mGWQxGq1GYpLne5cGmNigyXA00rOVuxYZzcZ2OfztdsGvTuwEQWNk4wNdsF8mmDDtt5R+yXcXbFNsf9amgfdNuFYHAZ8vd+SmaGMVaD8f4edyYqPR4rhClghNudzQf3bkroTljtb7DJdcKNYQZnAExb4jtYXGeRsBLj3sRGo5htP1sVb85v+Z0TU6FIWX3I/65Qn1O8q5M4rsPfeQTrD2++7tVH9+8Pewr808m34u3ib4CjBU2fi2XDgbRuaRjJV9cK12F0HUT2roTKBJ0WOakXDH9sHr7aQDGhHE5Lz0cBTixz4oF1wYJA6ff8q5bu4M1IwKFh0yRyKR7NPLewwnpY8MvzifjC6vAarUzaHXuT9T5a8El05mqU3RZwRJaQk3kai5aZE2yKcdnDTZCae8AtIG5CkAWC27yVrKJwshuX5/F3qfH3MCO2mOD/tWXmzYHbkbXnbsIBzxIPkdetJwzhq0Xwr3hUXiOU9G9FtnlSOJy5pthoqHyJeRTSukA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: etMvhmYDppRn05e6/EUg58o5NOkd7bLWVF9LB5g0GvT0PDJc9RFkGCtCs6Mg2AnuVLiQN2/y84jzuNgMdkN6wBrCwRPJ+BvIiQhPtizLP7RAhZikFfC9t4x/v/EzKtLalvaSkkHjk8LvZhPmaxRk1zo3+HmU/l3YYKllhDgWfFhm1oUaB3xzQtgPF/O8re/Kx/nSWU56385doP/PEGaS9Rb0kYzFfmWgd4qtkzcGPVTTTncxYppd5IbdtJwEFKO3xy9NhL0QuF0Q7Ea6o4zw/tjtWV+mGTjiV/c7qvcUAMdY6LByIxNHx7Mo6DWggBLfAD9N6jEaSqUhBd1dqY/bHmtFxam3epKCG19r7kAlonzvAii2gdeQ6BLxabVK9IyNXe0Le7zKUABgxtMT9dVi3oUolRXUljY3BCp26iDRPPhAGaA7oXrt93bRvlvp8Ida
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 19:24:14.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8f8356-cea6-4580-134e-08de9fdb92b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
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
index 16fb39259911..7cb39a8d40c6 100644
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
@@ -1694,6 +1695,16 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
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
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 
 static int kfd_ioctl_set_xnack_mode(struct file *filep,
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

