Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C82C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7240112D1C;
	Mon, 29 Apr 2024 15:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1SlpJbIt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8089112D1A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCXqJG83hMqf43zni6IkvaiZdJk0h8YYe313EvH+JJ9gPeX37XXu6HeeMNhyDGMUejNyIn/evugPsDuEPMpetLMxbyCuIk74c/JUQBr5PtSxfviT47q9wUiRzADPJdTmugAtOXOMVmFWhUEGx438zxSng5tuWwPkmf+UpdCUAl6BhrzsSAa434FcLU2n3oQ/qnhJGTGM1979ECd4obimtnTJ4WkPTWNAXn7QqKTcKFp2pN0rtedOo6HOjj0o/Nu+Aqqb5hslCSKQr+oGF0Zaf/CikaSEteZ0ZQdE5/6VBNQkrgByX4o3CN29WrPIN4+6DlID3Pel25uTVzOPgWue6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALbt+JTFL4IhSVzEAy9ia2J0ao1jmZwQGFfxD0HqLF4=;
 b=Y3j6soRKkAKr6y4Y7Q3Lf7xVX7pPjRSaWCVcjExw/LSEDtbcHC5NvO9wiVVUmTvEdBUeTF07JscctmejslqknnHqCFucx7DB55EArZK7uh6f/duntuK4ovEi7kRaHWtio6QOqPSjEQIunW4uW4zKheCI7Q2LiZC5srLRMuEWxpEa3lIC+H4JKK/2av9aiktmDALlBfJ5k8lakG0n8JdtT2qpQ+UAxwY2++tAwf3/XVthngW8CUADK6DdVUnB4zjz+CmRQ7FvTzdwAYJjzhEOlh8W68k5re0l0UWWvkHpNY6v5m2aFJ+I0nE59NysiLRGB2pliHdOpv2zSVHBUnXZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALbt+JTFL4IhSVzEAy9ia2J0ao1jmZwQGFfxD0HqLF4=;
 b=1SlpJbItdLBw3wwAhSdE3SEVOsEkVy9Qd4xDE2Yxraxlg7uq0JRtpR+gCL+lmIjRNuH0dv8fMCrfE21EiD9Bizrhv6hU6XAUxgs+4GtOLzDiLQYBMbxrvci/HDiXjZDRhiYaPEniNXa4Sh+mHe49Cs9Ds7s+t3GTswGATXBvucw=
Received: from BL1PR13CA0198.namprd13.prod.outlook.com (2603:10b6:208:2be::23)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:42 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::30) by BL1PR13CA0198.outlook.office365.com
 (2603:10b6:208:2be::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu: add module parameter 'amdgpu_uni_mes'
Date: Mon, 29 Apr 2024 11:12:16 -0400
Message-ID: <20240429151219.3466531-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 217e8d83-27c7-4287-27f5-08dc685ed113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rewaoq90IU75pf7WdYyNalqOJj7ElAw5ziTxQk7agPlVplQHAz+L3M1QPGJj?=
 =?us-ascii?Q?BNlIsheAWJZzUkxnShVMP9ET7M5PicNM/WikXZpjcv3XRAH9AwjSR3QC8xxa?=
 =?us-ascii?Q?ylEp3qs12drajR9tvrGSGJ9wXXkId/PVUX2lnbEJc7LIwoI621iZ/P4XPFVm?=
 =?us-ascii?Q?OO26EHhy96jiOmwaXIOB60ZK5fZB5vHqyBCsEjaBpS65kUnloO+EMTuMJ6Xg?=
 =?us-ascii?Q?7ChefN+VmTSPMXbpBDqUb13YWeWNJIttsW4+rKLnTlzV2xmR8gb+7s+zxq2y?=
 =?us-ascii?Q?gPm/VSziUjxAa8wJHoszBK9mhOw5xLoTDnRtBoEHw6/RiZB7SYaye6BkB/B3?=
 =?us-ascii?Q?9N/A4V5GnDnHWilf4Jylda3yDLPK3YpPQsa8aJFgEU+yZoa5W3ENTcRTnJ/z?=
 =?us-ascii?Q?s9vNF1L/dN1+UQJGKeq3kZaJsDZ89OdrjtZaEZPAjFsCZcJ1KVVxGTE6qAjG?=
 =?us-ascii?Q?5TsFhLGtePoDKmiktZy03squ/UWf1RYg3hFOQGGDvRwvcp7aZvDAEQnt1fI5?=
 =?us-ascii?Q?HUeAXOwBY6c8snHBGvm7hMzXS46d+DxBBEsGsWfeT/d4kt3JxrBMhKHpCk3B?=
 =?us-ascii?Q?fpafjzhCgVCvspZnhYLf2SDXawmKf6kf2QE91kAlHr5QDuOcXkLa6OCJicNR?=
 =?us-ascii?Q?duI1UvBfoyFepwJvyoH3L8u06dz2eIEpzbfEl7WBt0q0Pqc81v6WuIkeXg/1?=
 =?us-ascii?Q?vaRYlvXJiJGTTEMEioY/ePMG0OnRxBtLbE/2xbww8jrMvoIy36HIY+mIo6Qq?=
 =?us-ascii?Q?C1V5HR/MX8Knsd+y62GOYtZp0xMBYKlHIOdEe/JfN4AZToixgL75JtYmqEeJ?=
 =?us-ascii?Q?5gyfCo6tuuxut83yqYcD4ZG2oLmnrh9Tzs7L+XotuLAIQFylhyeKkg62/bOA?=
 =?us-ascii?Q?d/1RMMAUfeGdSj1/WKeDL9dviibWDc0dc2EFKgkzmvDzxYsv09VtBN4NLDYp?=
 =?us-ascii?Q?4KWHla16iD82Im17E4axWnYoy8ZlzXSQW0yEJRpPBXVh1GvVnBaz/G3Fj4sh?=
 =?us-ascii?Q?jUsL9l7pDfOy/CgNrl7sUHx7WjbujeQwn7HrpeRc0Wv48eeY13l3ZENTwgK+?=
 =?us-ascii?Q?dxSLia1Fo3Gn74eGrpCu5AHu6rZZ37G+emwAZ4arLh2H5aa0J8pb0S8xpoRm?=
 =?us-ascii?Q?rHluidBcYDI1TEQJWUZ8TYl2n5cf+9Fb0iG7YF/nG28RKN58k4g79kQSN2Hk?=
 =?us-ascii?Q?Mvn4hQ/VTU+9L8/loc25PVsykDFpOIbn4DOIUoacDeEM7kaAugLqQtSKweC0?=
 =?us-ascii?Q?HmZS2sUpc78oWq0s6IhFmZCjy49jj63gYqOFsAwXElZKUsQxzl8bewKI3QpZ?=
 =?us-ascii?Q?4N/vRaJRR+KTeLDyHOc41YcVoem1FkwTt002B2jdtZKaJCq81s87W5TxahF9?=
 =?us-ascii?Q?avoTB+Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:42.2894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 217e8d83-27c7-4287-27f5-08dc685ed113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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

From: Jack Xiao <Jack.Xiao@amd.com>

Add module parameter 'amdgpu_uni_mes' to enable/disable unified
mes fw support.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 10 ++++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c4355d72df02e..8bb8b414d5113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -220,6 +220,7 @@ extern int amdgpu_discovery;
 extern int amdgpu_mes;
 extern int amdgpu_mes_log_enable;
 extern int amdgpu_mes_kiq;
+extern int amdgpu_uni_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7187968226a81..6b240f6e98b7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2223,6 +2223,8 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
+		if (amdgpu_uni_mes)
+			adev->enable_uni_mes = true;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea14f1c8f4304..447fa858c6541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -197,6 +197,7 @@ int amdgpu_discovery = -1;
 int amdgpu_mes;
 int amdgpu_mes_log_enable = 0;
 int amdgpu_mes_kiq;
+int amdgpu_uni_mes;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = -1; /* auto */
@@ -686,6 +687,15 @@ MODULE_PARM_DESC(mes_kiq,
 	"Enable Micro Engine Scheduler KIQ (0 = disabled (default), 1 = enabled)");
 module_param_named(mes_kiq, amdgpu_mes_kiq, int, 0444);
 
+/**
+ * DOC: uni_mes (int)
+ * Enable Unified Micro Engine Scheduler. This is a new engine pipe for unified scheduler.
+ * (0 = disabled (default), 1 = enabled)
+ */
+MODULE_PARM_DESC(uni_mes,
+	"Enable Unified Micro Engine Scheduler (0 = disabled (default), 1 = enabled)");
+module_param_named(uni_mes, amdgpu_uni_mes, int, 0444);
+
 /**
  * DOC: noretry (int)
  * Disable XNACK retry in the SQ by default on GFXv9 hardware. On ASICs that
-- 
2.44.0

