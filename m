Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A926C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 08:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D4D10E21C;
	Mon, 19 May 2025 08:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/yTXsTG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D5F10E21C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 08:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMT4rijULgMSM0TQcfezXlNKpNAZS6szzenc+i4nT3tTT4hPSxm8p5sCwlL4+O1/eiYiNip1LZB0ayt6Mv6n5gHUxpZcx7jrRTiASgA9wLex0eH9vUXcEZWHtvxLub9NAxDSreEzLG3D5ntPK6eYUS0iHe6ey2w1b7Z17EIAQxxIsqiCOsM499oo9AZ0ORKQE+8GHdAlcqQk/ZOfEQqXpIdh4rPt7rb/cVYyIMl1uw8k9NfEzobvxmivjduL4rW5jlGcB1r1f0RcpaHeLzwBQZ8ggCn/Nf8hLXmZglOuZKS468dMNr8g5+PuUSIsq3MrBp8n4EiXIfIqKLLUE+94Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN6RS+SXryrRXzWkWK4ay4UZgsnd+633fg7l+TUAvXU=;
 b=fxsQlrjHDzSeQl4GK94MAbW5zYsoKsgZjKgti8iC/9H7W0Q9RAJRKlFZragHxVymh1a50g6iT4y9aAuwcCS+4OBAt4ykhVTvMUEuhM7hmfXV3Jfhnr2nlzFQAmYptPMCXhnmE/6SuTc1qyRZuIWl0SqsPiy7RF8aV21003nuoP26Ru/Wr/aIs7JvCWmZnwUNWpHHAqHyUEYsvhUFP/gmuyi/YXdbkcV3bwSVPVbyHMF5QbLZgNwB6MxFS4SfqIhOos30exSQC0VO1skzBAWNNsCpgkpsEiIvM9PHZdh40415bGNiRDAV03aHZUVUM+N4707XWMttInk+bpsJtSG/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN6RS+SXryrRXzWkWK4ay4UZgsnd+633fg7l+TUAvXU=;
 b=U/yTXsTGAcKrgGd9cJ6cu0pMaDGqoRyAGH3papCtd/G0sZY4SYmRCz/VGFdGwPLtWumln0/WORDo9K4um5nAUpxLHuVlPhFCudicDIe6MnM6E7Lz+8xGSktXXRtinrjCRPWh6oSEZysKhGvhTqwa038qDGtv5YC1Ixy3QGYfZvY=
Received: from SJ0PR13CA0184.namprd13.prod.outlook.com (2603:10b6:a03:2c3::9)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 08:22:28 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::5d) by SJ0PR13CA0184.outlook.office365.com
 (2603:10b6:a03:2c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.14 via Frontend Transport; Mon,
 19 May 2025 08:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 08:22:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 03:22:25 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 19 May 2025 03:22:23 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH v6 4/4] drm/amdgpu: fix fence fallback timer expired error
Date: Mon, 19 May 2025 16:20:38 +0800
Message-ID: <20250519082038.21459-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250519082038.21459-1-guoqing.zhang@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 5146367f-6411-4909-fde9-08dd96ae4a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AHTKzEJjwbfyVkhkCl5lZxYwS6nCLMCAcwI7Jd8NKzyMshR9PUmCzDwXa1lt?=
 =?us-ascii?Q?yMrzDz3fH14TqiEld7i1ps818TjmcKYLsOfLx9cASxnm3HEUTJjzLvY1dal4?=
 =?us-ascii?Q?D+M0cPT6roV7cTh84tdpSPa5hb1g6ma8VEZ7NktsoQFPkWb5/4hpsPwtnall?=
 =?us-ascii?Q?CZO5QKozBWnizHSLa1xubZG7PGjgr3ucQfomBf74chDMTo4kKSHq4w709nOF?=
 =?us-ascii?Q?7QIBlUdfayKmnTJOY2xKaTohHBYiPNpQvStA4F5jrm2DJnSdQ5P/AhC8Bw9k?=
 =?us-ascii?Q?CqVAhmBRhJcraFuPxRapnxTlqg5MstEExreldT5Psefy/rO0uEmhEZB5x5cY?=
 =?us-ascii?Q?H28ROdz4RC9pRSni4mqhA6ciGl94VibYtXpeE3kiVLdLmsf78UWibPziezMb?=
 =?us-ascii?Q?2hbbYqbmBfF8iACUTpKIgSRW3dCAn9ydAi/xGkVV4XaNEz6VH/x+WooH53RS?=
 =?us-ascii?Q?6zyfBth9RnWKkypXeJSr+tzKEGzqRcziACy8MFVgAaAhVfJ0HOFx77FBzIor?=
 =?us-ascii?Q?7lZF7TOIC/SfWmIlzvslZQ2/CG0MsjlSJzwX4QQrcvE1gnHh2VS1iX6xOFqD?=
 =?us-ascii?Q?ryJ/JSoQNXqG54JY7sivm24aYwpYgxf2ZUPmc/GJvSd+Krw2YV17C5pbWd1r?=
 =?us-ascii?Q?TuTjJAcNyrc5jdpF1KPpJ9YklKw8aOay+BNxle9rJpkcAVW3An3TNAPZh5C0?=
 =?us-ascii?Q?4uiaIqTQqpu51kqrcUqXA+aq6Q0T5g2PRTMpEx3HQi17t7P3HUixhrbSB2dF?=
 =?us-ascii?Q?srbLi2/TkuskxoKx/NMJtKcCX1lL8+MbUNAUD5AD22lPDd+FWtNMzGd6IsA9?=
 =?us-ascii?Q?FYLXqEGOMhoGD7KssCRE/i5wT5gXa5/0OWbembfd+WNCuv0M6IlnuqPzsvLX?=
 =?us-ascii?Q?mTc5yuRf90aXjBMOiMNwUOFYZnKENGW49CAoHdv1o5n+XGw0fQKlaTSjaOca?=
 =?us-ascii?Q?tun/CVYgbZi70L6++kTJ5NOGfvH8gXqPCTHPL4lRz8FK09INegWYL5AkBILB?=
 =?us-ascii?Q?iT2/kRfMf7AbhY6tS2mo5fTVzH+HwejwIh0lnNWc8IhfsFYVmXf6il2mbUt6?=
 =?us-ascii?Q?vwgYshrmFpCgBReNUNgdC6sTxM2SskXRqMeAnmZbttwN70I75ck+US/6ih0B?=
 =?us-ascii?Q?ztOoaiP/JvPmXws+NMiqLOhtYLjfDHzZqKScHixNCOxuDWDU2RPy3aJICwXG?=
 =?us-ascii?Q?siAkZysz7fQTDJyXaZizsHFHShBpiyC7oVNn4WOJ7Xa941mzkWszkSezihOI?=
 =?us-ascii?Q?k59AemzkxFIVWxwDq3zlbPnGpf23DP0mgUR6FLx4esTJ/ziOVZDYFbFOaIY7?=
 =?us-ascii?Q?6YXwlfkvDalf1zJYpiVEi/p8G3xm+FvkPmre/k0D8mAvbSPfxSw3C4wxKBtA?=
 =?us-ascii?Q?gV3YQ7NfOuV3WO1lbpeU0q77OfXowgwyKQbQnZ69iL/SAbUc3RKPv0+QeyZw?=
 =?us-ascii?Q?AxhHu8eMjuUlLzuRn7nlkyjhVEHzbfes2mEb7jrNrI/YULcrBcmCZLEU7xki?=
 =?us-ascii?Q?yGaCdpmRI2OuTYfUb5mrZJTGSYF/yBL6NNg9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:22:27.1523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5146367f-6411-4909-fde9-08dd96ae4a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531
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

IH is not working after switching a new gpu index for the first time.

The msix table in virtual machine is faked. The real msix table will be
programmed by QEMU when guest enable/disable msix interrupt. But QEMU
accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
by nBIF protection if the VF isn't in exclusive access at that time.

call amdgpu_restore_msix on resume to restore msix table.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e5bb46effb6c..91066c6a5861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5051,6 +5051,9 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 	int r;
 	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_restore_msix(adev);
+
 	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0e890f2785b1..f080354efec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
-static void amdgpu_restore_msix(struct amdgpu_device *adev)
+void amdgpu_restore_msix(struct amdgpu_device *adev)
 {
 	u16 ctrl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index aef5c216b191..f52bd7e6d988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
 int amdgpu_irq_add_domain(struct amdgpu_device *adev);
 void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
 unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
+void amdgpu_restore_msix(struct amdgpu_device *adev);
 
 #endif
-- 
2.43.5

