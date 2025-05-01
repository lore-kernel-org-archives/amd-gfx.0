Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F42EC369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 18:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1B810E263;
	Thu,  1 May 2025 18:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJhOQtae";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B14910E263
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 18:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUmhLNRzM5ITwf8QSZOuo1C9UD+8IT0wfw6IcHw3ig8Ev13DTXC33tQwuwAYKvc/GHF9pOim/3Osp1K156u1q/g6YpoOTcNAB/vgPdmi8dktPQchhWqV1pUgm28IM8fa0ks59l24sz3pOdb/tEgldDQTNWiDLtM0YlOd5aDHUvoBeqgKpOkY8oqoghMMI6KBSS/qPhSDn1T3Y1ug9vLADDJwTe6iaAykQKgzhsVzwP/EolL9Islpm6kxRvURBcX0d+Wkrse+AFgzqF6bLpmTFSfo37KDSAcbt2NLVTAjDTcpopGJcl+VumhO5AqiIulmas4g7Xh6SUCdRuMoloVhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWcfVsITUyPRZXfJ6ZL+ogZfhpJlolzdhBu69b5Rjyc=;
 b=d4l7ZIqQBnIOa4OzzdoPH833pbyHF+IDRlTXs75iZVMUAMzPLpElZosfFOHwP/v5Lzgnyqf5MyWj2iYzieIsXa2RtNdp4W6bM/wZ2yXffnM3Z3E1gWw1ZYrejiXQwUOlYkkm1I64L5UUN6w+wMjChb2fZzV+nCVxvH0ceHK3BH+syQigKZNjzLTKW8uUWMVm7kY57plzC2pInBATrcvIfMdU3GlQhdMADXKYnzuStqZwMMlNp//PHZ9uEPVnijTBouvCOcUjBTXgAEI9ooXhG3H87hz3gwXr9Ucb7g6Kqq4K1GXFqdd13VeoVsyesoxxHU3hHaNXf6itDoviQjWW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWcfVsITUyPRZXfJ6ZL+ogZfhpJlolzdhBu69b5Rjyc=;
 b=UJhOQtaejbOZDIR4tMv8a3SxoYoIvTCcRdHhm6uolTUVshNcJOstjgclnI8zkodch9YgG0YZYIgY23EFB/8hHJWbwEwj58wjQRltjarzvKMpHJFXfLugmJ4gyUkKrCvDA8LBMsStmTZTCb/Mi4B3TdP67qfwIcstd8zxvTMNBlI=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.38; Thu, 1 May
 2025 18:35:11 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::1d) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 18:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 18:35:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 13:35:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/3] Revert "drm/amd: Stop evicting resources on APUs in
 suspend"
Date: Thu, 1 May 2025 14:34:55 -0400
Message-ID: <20250501183457.4123584-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: d441a204-c764-4113-e227-08dd88dee7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p7x+Y+MM6jrpjoQnbKOLRv2tDAEDb3eCIDvGm9Ry7q7V9BKjXH8YZPJTwokM?=
 =?us-ascii?Q?MTpSlW9T484USQUMY1JC6+YVLBMsU8fHh/6nEAK3oLaoMnXP6hq2Xu7WIw2h?=
 =?us-ascii?Q?tlOYeQrJUULFlm1Eb6O4256oPko+z/a703dRMiM45pm9cOJU3VBtUS63g0Nw?=
 =?us-ascii?Q?l3c9PUgHH7no+2XF/GjrbouIQ65SJgAOVzban11eYeF6MzoZy2wJPpFEF3LL?=
 =?us-ascii?Q?aBYHEJsnBlJnJJmbGBctZbhU2lNfxBV1nXNyag1pJIVYORlfKx8SJkLfJ5cJ?=
 =?us-ascii?Q?dN+HH4CZlpQueFOnvuqBs/r66zSQ0rvqA6cbtniDDmKwptj9fSurEUgdGk/n?=
 =?us-ascii?Q?ege8qzl9jly3mnqmIeyH9Zugq+Gc2bxxZEN5a8HzWW5tKMTdoWQiE7GBlZxg?=
 =?us-ascii?Q?tnURF2hjhBR/oHhDXTtolUUY8CFDZT+FNaEbRxdUNM9tyeUZFSpBmruILLK0?=
 =?us-ascii?Q?Ubch3IKnk+6zD4z4QkiQWVYHSaUbImUYR/inP4Zb5guYQ0DNJ1aNjBu9T2QR?=
 =?us-ascii?Q?+9PuY08A+rRo14qioRxg5SbeV/6hsLHu5fF1QEZ6r6mfPTyYpQfwiqE59Mkd?=
 =?us-ascii?Q?PL/wQzVf/Kknh/zVjRPyTmbsvfRLgTGB7EvV96oaq9w9H9kb3HtZZQNL6RwO?=
 =?us-ascii?Q?XB7gfn47wQjSoANZxjT1NlfiawGlzZtG/oaNuRJdR3hKwTrC1C7DUOoM3v0g?=
 =?us-ascii?Q?l5wnFkJRuvUhgoQUH0Am26Rtb1hBbNSfRQzsOYCdGaek36mwgnMxp4HyARe/?=
 =?us-ascii?Q?dBq6kvik7X2clmCFzTTWynWekUXCaCTMiPvGuZNfz3C9jqsVA0XIzSJzXRvf?=
 =?us-ascii?Q?0ObQs2kkAZycV4QI3SwmIUw5GZBrZPcL/XfLc5w3EWnhsBdV0+Yb1LPfM2wh?=
 =?us-ascii?Q?xbbSe685hbvxIH00LTIgOkh3NbSLlML8e+d3R5MQk7Ela/rn9C5zIayuKwIo?=
 =?us-ascii?Q?dJ2QjNlxKK/+ceUVaexW5mviWrzo/CKOHmT9PyzabomfyoRXirlh1CZn00VX?=
 =?us-ascii?Q?kr/kpqAR8xjkUYJEXYuNEqhZP6gwaiCgTI9bSxG5BMzM26E0oqvHYoYdab10?=
 =?us-ascii?Q?+HDRfQw9h+oL7AHqLOg1T42PbBuHhntUL3Z6y7h4ez3cbg4Yl/u7oVX0MgYq?=
 =?us-ascii?Q?FvBfMmKGqE3FrTPWWpmMTL6YUmHniUiJ8z9N1TWE8bmFznZiiAdry74cT4uC?=
 =?us-ascii?Q?IZzlRstgTv0wyXqHfiTMkFWSBfeWnsX+3qyWd5vLRIMTAiHGfP0LpST4ZS39?=
 =?us-ascii?Q?WeNv81pulfpQ4r/oaIGwfuFlM9iLMUMLdMPSA31EhLEYa8sl3t/9Kzj3UrfY?=
 =?us-ascii?Q?VvAMpW5UfAordREyNgu8TAX+nd6A3uQf/kzLeYqFQc1v49gZzWrpPBl4sJep?=
 =?us-ascii?Q?v4RDH05bh71UCKTdhsXUANTg8djgHQNut8fHRg6CNVzSYt3WLVDbmbxolZxi?=
 =?us-ascii?Q?Gb/IMML9mEILzPnDE4SOpPAXU2lkyDL4J0L2RBa4857wDO8uubZ34A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:35:10.6457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d441a204-c764-4113-e227-08dd88dee7a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

This reverts commit 3a9626c816db901def438dc2513622e281186d39.

This breaks S4 because we end up setting the s3/s0ix flags
even when we are entering s4 since prepare is used by both
flows.  The causes both the S3/s0ix and s4 flags to be set
which breaks several checks in the driver which assume they
are mutually exclusive.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3634
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ef6e78224fdfa..c3641331d4de7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1614,11 +1614,9 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
-static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b7f8f2ff143dd..707e131f89d23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1533,22 +1533,4 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 #endif /* CONFIG_AMD_PMC */
 }
 
-/**
- * amdgpu_choose_low_power_state
- *
- * @adev: amdgpu_device_pointer
- *
- * Choose the target low power state for the GPU
- */
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
-{
-	if (adev->in_runpm)
-		return;
-
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
-}
-
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f354cd532dc1..5ac7bd5942d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4949,15 +4949,13 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int i, r;
 
-	amdgpu_choose_low_power_state(adev);
-
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
 	/* Evict the majority of BOs before starting suspend sequence */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		goto unprepare;
+		return r;
 
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
@@ -4968,15 +4966,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->prepare_suspend(&adev->ip_blocks[i]);
 		if (r)
-			goto unprepare;
+			return r;
 	}
 
 	return 0;
-
-unprepare:
-	adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
-
-	return r;
 }
 
 /**
-- 
2.49.0

