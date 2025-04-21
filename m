Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1D9C369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 12:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FFF10E08B;
	Mon, 21 Apr 2025 12:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kswWMYP+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD37410E08B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 12:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPYRpcDRvppN0sIpr43CIcaLw+0vkufRo/85xCzvQiWhMYed+3gLNQAZ07738ZpK/XnoNNp3JK+Mo+rXeFxuq2+1XXGkuUkAMPQWuv0MQmCCTAeEkQOAaRAuWQ4gPY/+knpKQouovLdrKSKdLQFebCSqe631koNwmNeHYHSvVCv+RTDzLZXTgE2FSaiV6thL6RXBZkbAvOjI/Tb+TdmPyDxWId8JcWHRLoAvysS7OOcKGUD1wBZygEfK8KruzklMdcbCmpJ2mArOQnu8y9hAAFG8JhVacS/GgbyMBK6ezfhAMJA8FWjsTA6dLkusxIDEkndonLZYoSZDpjocj/mTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY22iNSbzvSZjA5vhNNRqYCJpiMg3IJU6xxhK+YFgBk=;
 b=xTw3Sgdv3sTI8wDu4xhyJOCkeCV36yhoO7adPUfjID3xvyTnv4CdfmkrgQmZxXJOdMfcTh0ESrZNLkm6iGJkXotKVmNoVtuMaPz26+hZzvmdLYugkVNAcndB39xGpazFo2ztCrpajbk4gGrxnDict3tbmbohMHHKLNUrC8RmvZ/s2A8flLWRE6Z+dIp1CD8Bk8gOeu2K7qilo9CZNxo7wO7pnE/BXc4McUqcOOvdB9srXxRxx72Wk6A6xYwu2QJhVPw8JmlQx4HYRW/lvlE52R/WMAhvKDBUXtx13IIIqExDC7M5EftQ4F4JFzgeE/tccHVzl04fZsZhvhLFiZb2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY22iNSbzvSZjA5vhNNRqYCJpiMg3IJU6xxhK+YFgBk=;
 b=kswWMYP+Cvqh6OISS9fq5xih+FxF0aiWesFYbr3QygHjkWUjEjwaEmnmSafJJY6EaXIvuGCftvKuAc2oDV6nL/qigthQdmKGbfDoJiMhsgij8USqxeZkc85PXTZJ0e0epVeC9rct4GhHOI87t2F2NlMsrKK8P6FMz25JO/nIzUw=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 12:02:10 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::fd) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 12:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 12:02:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 07:02:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Reset SMU v13.0.x custom settings
Date: Mon, 21 Apr 2025 17:31:49 +0530
Message-ID: <20250421120149.889243-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: bf75b4c9-40c5-450c-00b6-08dd80cc5896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xuauiYbx6FhUl+NVLWGMbU7V/K3oWH00EiDSmRIWUsyDNHTR16V8bz588LcD?=
 =?us-ascii?Q?FRIDh7uZpYqta+urQGEaCPj1r4Tc+hoXN+QWfRhgPfkCkNCa3234wNx4AJ/v?=
 =?us-ascii?Q?viJ5kLVHDDlWXJzsOGlxDBBZjohMmJ/47vdbpBhBUiXNTzo1ctMX2RazE/yi?=
 =?us-ascii?Q?UzSYLQSjecxGq9m+uSWiccHCmBJ1tfYNjM/y6xaM3v/tsgfKFsreIGlchyuo?=
 =?us-ascii?Q?LtratU7cKOOUFPb6zb2Kn1jL5GhDQp21A83u/gjhYvY8DRdvo/hRlOBCs86F?=
 =?us-ascii?Q?MnKaluOKjSYSy5kiTvTjavMVcie74Cnk6b/SIh52ps0u/7MR6YDl/hHLrq/B?=
 =?us-ascii?Q?v4rGQwbkE9ykA2mpHGA/EB9ym58Q8Lw7WMVLyRV/o6x/Pmp4DIW9mcuU/oOX?=
 =?us-ascii?Q?zBJTALjwp9MHJnfseO4++4WxDMBDnGBswrBPYHitLEIHIPowWNxa/M743NVk?=
 =?us-ascii?Q?MR+Hy6VBkrrHcnK8u6QBh3fCNK29N/qFsNcoJSY81rB5PKWN/T2+2DamsnMq?=
 =?us-ascii?Q?M58jqRvm1xaBGcXM4Kj8FL0QxR2c6CQB8wzd203K2XCMTjVOqZ20lHpPqHkk?=
 =?us-ascii?Q?umHe4GKuQtCE2vMWGw/+aP7jqdtN7lsOe/gTuDJ5CagdravuteOG3wI3lRoS?=
 =?us-ascii?Q?IfYygE/P/ZtE7dPOSZMi4GNBkAUgmKuZcKsNTeu5xaaTIg9zqcOhe02dp3Cl?=
 =?us-ascii?Q?QIASOlQEIUsMgi0j+lzmyRsQ2yZsXCpePHKZcJatSreGvpXQbaAynjIwq/g1?=
 =?us-ascii?Q?hsTjqoYpqpUYzDhxChDiwdcowiXt28TLRoccvDTVF3FEQ4ncAGHQNhr0i0a2?=
 =?us-ascii?Q?H0D1WDRakQ4x41HypJZ/KYRV+1A8XdsxVqFCC27npoCwO0/V0i6KCTe4bHgH?=
 =?us-ascii?Q?Ho36ZlsQLIxNGGs/EteZhAMZ1OdVBqRrKhNJV5yGj5FFjyyAlWkYJnLnHTm5?=
 =?us-ascii?Q?pVaduR1q/upwcqmowZT2ZsrQ2FzJD5E3yioB6Raj6aL9DP+DVU3HgXc1zL4C?=
 =?us-ascii?Q?R28+0l8Y/xb+mLLTC4jN9T2fmg+V+91HOIgU40YUFhV2Yqro5dB0xiLNTgAJ?=
 =?us-ascii?Q?z3g4U26T3GQ4Rs1kBDPhHUECub38C20Nm+a2KJ2QacgdE6Ig7tPCSllPiyza?=
 =?us-ascii?Q?Ps5tpXv7uWQePjjfgKS979NqTU2bi5mRwmGK8eG9UHREipIYQM/q/bp8sQnE?=
 =?us-ascii?Q?bmxHRdQFhGilgGmsG0r0xA+FYTbKRHR13ZnJxpf0lHQsOUSSO4PWbCIiZ3le?=
 =?us-ascii?Q?nfbxytRXOY1OP3R9eXG5ZCam+4ZAX+HHsGqNX8ICttQ0uglwG+8SGW5Yfhx2?=
 =?us-ascii?Q?lRAxPPFaEIZTtbandbqeaI3oQ/IKgZe94vNcE+sXTrJ/HJ5r4RwEioHezPL3?=
 =?us-ascii?Q?2PcFEVHz4QqhQy7GhsfETEXT/eGpHwIl/dVr7QNQrkeg768tOz/HDVpcb4Uj?=
 =?us-ascii?Q?r+FGDHji5HB2sMJD6brl3zQHWQTtNpYwNXv0NnmkHU8y5mB3B31Iv8ae4nMJ?=
 =?us-ascii?Q?n4KX5JHiRtGSXyRKnFesuKDjyrBtHIUGIKOb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 12:02:10.2821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf75b4c9-40c5-450c-00b6-08dd80cc5896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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

On SMU v13.0.2 and SMU v13.0.6 variants user may choose custom min/max
clocks in manual perf mode. Those custom min/max values need to be
reset once user switches to auto or restores default settings.
Otherwise, they may get used inadvertently during the next operation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c  | 13 +++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c      | 10 ++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    |  4 ++--
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index cd03caffe317..21589c4583e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -310,6 +310,7 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
 				     uint32_t *value);
 
 void smu_v13_0_interrupt_work(struct smu_context *smu);
+void smu_v13_0_reset_custom_level(struct smu_context *smu);
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
 int smu_v13_0_12_get_max_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 83163d7c7f00..5cb3b9bb6089 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1270,6 +1270,7 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 	struct smu_13_0_dpm_table *gfx_table =
 		&dpm_context->dpm_tables.gfx_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+	int r;
 
 	/* Disable determinism if switching to another mode */
 	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
@@ -1282,7 +1283,11 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 
 	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
 		return 0;
-
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		r = smu_v13_0_set_performance_level(smu, level);
+		if (!r)
+			smu_v13_0_reset_custom_level(smu);
+		return r;
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 	case AMD_DPM_FORCED_LEVEL_LOW:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
@@ -1423,7 +1428,11 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 			min_clk = dpm_context->dpm_tables.gfx_table.min;
 			max_clk = dpm_context->dpm_tables.gfx_table.max;
 
-			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk, false);
+			ret = aldebaran_set_soft_freq_limited_range(
+				smu, SMU_GFXCLK, min_clk, max_clk, false);
+			if (ret)
+				return ret;
+			smu_v13_0_reset_custom_level(smu);
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ba5a9012dbd5..075f381ad311 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2595,3 +2595,13 @@ int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
 
 	return ret;
 }
+
+void smu_v13_0_reset_custom_level(struct smu_context *smu)
+{
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+
+	pstate_table->uclk_pstate.custom.min = 0;
+	pstate_table->uclk_pstate.custom.max = 0;
+	pstate_table->gfxclk_pstate.custom.min = 0;
+	pstate_table->gfxclk_pstate.custom.max = 0;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 05969b98e9f0..39a7fdf67d6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1938,7 +1938,7 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 				return ret;
 			pstate_table->uclk_pstate.curr.max = uclk_table->max;
 		}
-		pstate_table->uclk_pstate.custom.max = 0;
+		smu_v13_0_reset_custom_level(smu);
 
 		return 0;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
@@ -2151,7 +2151,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 				smu, SMU_UCLK, min_clk, max_clk, false);
 			if (ret)
 				return ret;
-			pstate_table->uclk_pstate.custom.max = 0;
+			smu_v13_0_reset_custom_level(smu);
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
-- 
2.25.1

