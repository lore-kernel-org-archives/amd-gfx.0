Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33096FA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9128A10E2F1;
	Mon, 31 Oct 2022 16:25:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C2310E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cToKcrki3BU7vrTELvnM18Dscw8kBIPQ60R81uuYmI2OQyCyPx6FywY91ulmcYDLpIGZeT1NwyDD8bJnbhU1p91BDKhs2t2BM7MNT6+E3tU5RwOEwDxWir9c4li3atJwyKI57qnmnuOwJnXNtvkVmxbldyjO38ZSyxZ/Okzzn7eTCm5W71vyvDS/wyF+ayZ/5//dVCHMGapJiGXSd3saJMBeyA7nO5U/qZZQH0AI1+Cmm1KPyGP0Zr+JWF3oko5A75dN5wezN5Ck1MuTIsiIlsjW6v8aJeoO8x2rffPBjy1TjQaVPk3nsovYxVHDpHvcvNz38rj3dmxQbHWvOvfrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlpeQ5TFQ9G7OwQ9P1YA9R3MlfFq+r10vDW45F60cXo=;
 b=Opa3m5tSvvvHLfqGUOpA2m2sbDpFrAlg5Xtg5aR/6t1CnoR9fcvNfQ4FQpZjR0kpL1R35dKPsMUUqVVO+jTSzo4V2GIemvlUIVmnvN5q026iTrI7T42ucwhCHr7ZlbZ/kRrhMzQOFgl3UMXX31kVMJ55JH51K1NMRqQQOJn6MPBqJAoSn1oyDeirjUzCtIAc5cJ7MPMVQ+OIhp3CKhWCIperwZc42vdFCCRoJPUHIoC3Yqhyw1lNHWyxE+IcZ8jZ+PVTH6Vqiox2IoOVMw7/LW+mub83gfi4YrXfxTQc4UEK0Dqh4X/ZhR3dv+n4EG8fAxSz4NDZhEj+TKbWhsmQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlpeQ5TFQ9G7OwQ9P1YA9R3MlfFq+r10vDW45F60cXo=;
 b=D/kTVEdbuhXH/4gli6UBEXdHvFGc2HchThOwwBU289NeznQmFru7MXyF5KhjtSXm+pOaEwBEy3WpUcm66cGLOsGNeKi9xlpATDAeqQREdRGF4s89CJUXQDFNm9+XprTXplVly34fHyISaov0sqFNnF8XYYcgbwW3TWvLMwS3i0E=
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Mon, 31 Oct
 2022 16:24:33 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::43) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:33 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:29 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/29] drm/amdkfd: add debug set flags operation
Date: Mon, 31 Oct 2022 12:23:54 -0400
Message-ID: <20221031162359.445805-24-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f89ede0-448d-4186-a215-08dabb5c6535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDWl54N0vpS9U2trbP+zXgz2eMVhdpNBduxjNKdrK3Jx2tu6AyUlA+syVeU1DsSxHkQVCTpFzItWHsvoDTmk9TNuIlVHgk/1c3GGBUh46czbd/oWxR1O+HVvqNGM6R4mCW8kHhsE3xH9fimmw6hNQLPGsXrSHi2gtWTLlEfXo58TZiTG4D/06CKuUnnVMw43NmDUiDcyBiTxtsmV0Zp2MVDGUeVDFiqJBFkKjZfG7RIDXANvIRyELS194Ais57gxfZb3Z+SIw9nOHNzaWtjoArc9qgZ1xSjtZspXhV8x0mTVmeiUHlV/VivSihcZYOTjAS4rAm0d/JGXHh+ZdyyjLN5Dl+zOSfPMHuv8oOkX2bti0RAz+mwl4jkzTj5U6TXSVw1AhpLGkPif5K7z+d6nmZJUearmphdISWMdkuqZQp1IvGKZBxv44SZosYZG7JtbWe4suSLSvmF+7hZ+6NfDouc8yejThxtR+Jn4RBLR6womCjNUXcUrVcVvLsO6hNhSP2BD2c3j2KAqDZzJucqN66NXYvQgpUG5sPf6S6d3zAv2QGTXyOz9pRRo34oIwsMzN+0YHWAg4k8KunB8zt7J0eYN0IFJHsFgEdNQAfKZGB8yMyeyzytrhPtSfDeIZbCjSDy+iOJEhUrhwkGKWNtNW1vJRmr/EHRb8FOJ0DcLDIVdK8QZqYebAFPjpqM3EXoeYVNJtzd7NF0XVpcpePKqCaWRQbXYb2QhbOSm6G1dKGplmmwY8pESXl0MuNmttQl5GC7GJSzpXc8Z+Ysh0kkhb4Oj8tJOFLozLmmzhSTDut0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(316002)(6666004)(83380400001)(8936002)(2616005)(36860700001)(6916009)(186003)(44832011)(1076003)(36756003)(2906002)(336012)(40480700001)(47076005)(70586007)(70206006)(8676002)(26005)(41300700001)(4326008)(5660300002)(426003)(16526019)(82310400005)(40460700003)(7696005)(82740400003)(478600001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:33.4183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f89ede0-448d-4186-a215-08dabb5c6535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow the debugger to set single memory and single ALU operations.

Some exceptions are imprecise (memory violations, address watch) in the
sense that a trap occurs only when the exception interrupt occurs and
not at the non-halting faulty instruction.  Trap temporaries 0 & 1 save
the program counter address, which means that these values will not point
to the faulty instruction address but to whenever the interrupt was
raised.

Setting the Single Memory Operations flag will inject an automatic wait
on every memory operation instruction forcing imprecise memory exceptions
to become precise at the cost of performance.  This setting is not
permitted on debug devices that support only a global setting of this
option.

Likewise, Single ALU Operations will force in-order ALU operations.
Although this is available on current hardware, it's not required so it
will be treated as a NOP.

Return the previous set flags to the debugger as well.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9b2ea6e9e078..200e11f02382 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2943,6 +2943,8 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				args->clear_node_address_watch.id);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_FLAGS:
+		r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
+		break;
 	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
 	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
 	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 68bc1d5bfd05..1f4d3fa0278e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -23,6 +23,7 @@
 #include "kfd_debug.h"
 #include "kfd_device_queue_manager.h"
 #include <linux/file.h>
+#include <uapi/linux/kfd_ioctl.h>
 
 /*
  * The spinlock protects the per device dev->alloc_watch_ids for multi-process access.
@@ -355,6 +356,37 @@ static void kfd_dbg_clear_process_address_watch(struct kfd_process *target)
 			kfd_dbg_trap_clear_dev_address_watch(target->pdds[i], j);
 }
 
+int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
+{
+	uint32_t prev_flags = target->dbg_flags;
+	int i, r = 0;
+
+	for (i = 0; i < target->n_pdds; i++) {
+		if (!kfd_dbg_is_per_vmid_supported(target->pdds[i]->dev) &&
+			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
+			*flags = prev_flags;
+			return -EACCES;
+		}
+	}
+
+	target->dbg_flags = *flags;
+	*flags = prev_flags;
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
+			continue;
+
+		r = debug_refresh_runlist(target->pdds[i]->dev->dqm);
+		if (r) {
+			target->dbg_flags = prev_flags;
+			break;
+		}
+	}
+
+	return r;
+}
+
 
 /* kfd_dbg_trap_deactivate:
  *	target: target process
@@ -369,9 +401,12 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 	int i, count = 0;
 
 	if (!unwind) {
+		uint32_t flags = 0;
 		cancel_work_sync(&target->debug_event_workarea);
 		kfd_dbg_clear_process_address_watch(target);
 		kfd_dbg_trap_set_wave_launch_mode(target, 0);
+
+		kfd_dbg_trap_set_flags(target, &flags);
 	}
 
 	for (i = 0; i < target->n_pdds; i++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index ad677e67e7eb..12b80b6c96d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -57,6 +57,7 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t watch_address_mask,
 					uint32_t *watch_id,
 					uint32_t watch_mode);
+int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
 int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 					unsigned int dev_id,
 					unsigned int queue_id,
-- 
2.25.1

