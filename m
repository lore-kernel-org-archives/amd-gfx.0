Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D015BD609DE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479B110E243;
	Tue, 16 Dec 2025 19:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQOXd1YQ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FF510E243
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 19:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbuGHwdGq+oAgBz/de/4slKunZ4Y8dQ93c0K9RV5E8xqi3DkQ7Fg/2EE4JGlKarE0X03DcmOeaaazOvVJeeAFoE+YZw3iWiENTKvzPJPTxv4Y92eZl44QW1naiIGilXGPSnEw7wt/vxUo7jlTq9Ns8dQgn2gKYUl1Bq0bq0jdtuFlL68Oo5azJSexNnZ+WOQOAb/oQ63Gqk3R8VYSkUKuxhSLSJcEdRR4HLfwofUb7jbzAFcDyp6QtnrE1S8OW1iH3eSeZ5nqpomQ/U4c86pplFO5sMDxfCOn6b7M7PzaXTnN3PQFmt3lbnwX7oHtAczT76jUugxUPJXybPjizQVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG3C6E1SH+5TQhQD3wmPotoKGdiLItZX9SxzwOOSses=;
 b=gJdROZkUJ0Xj24C3geZj7xfDXZdmWlXXc7NnFV5fKSNFoF6yG6GLevah0BPEd2rNvYNCiQnV1F4NRB4FP3Mly2kIJpsmu8u2v1xLo0kzxYLqVo/x1WgWSPc4BTgCtg788rZsYtwW8WKUbTmlqHtx+wYvYH8GipuFurKNlRnLpIscVqlvGHoeefWj2X7fYbiXa6lVx8aTdsPxgb4jKGKNXwHYKmE0nQMSbIvsBa8RNBikRWMWDQkMt0T/cDV7TST70GMVjIJVEVDH0U7DihYyYrRPzFffGqDTIVTG8V+wmDAtlZ7Pn9S88qkeJL9Qob0f1PTyE8z/RXtkxB9sgOJL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG3C6E1SH+5TQhQD3wmPotoKGdiLItZX9SxzwOOSses=;
 b=mQOXd1YQ1IDTPTXtVkw5x5wBMu3s3nrPrGuQ0Y3Z00DcZtb9e+dllHurQgL5MB6CX/83E0vfRHkoHRLKwiknTFaWPZz6Tl85tPWTpkJIQ+shJGAnimgSGm5SxvtKf0KgQc9iucWqOHP+5LNnHKdFjHZAKEEhhBjIlgk3mb20HzI=
Received: from DS7PR03CA0260.namprd03.prod.outlook.com (2603:10b6:5:3b3::25)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Tue, 16 Dec
 2025 19:46:06 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::4f) by DS7PR03CA0260.outlook.office365.com
 (2603:10b6:5:3b3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 19:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 19:46:04 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 13:46:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <tim.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for GC IP version 11.5.4
Date: Tue, 16 Dec 2025 14:45:37 -0500
Message-ID: <20251216194537.1872842-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f66dc4-8e5f-46e9-b984-08de3cdbbf87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sG0DqR1KruUTIffn6BYrEB49Rk26J7+D7gxplepu0j9btH//uCQgztzl2PKa?=
 =?us-ascii?Q?xaRdXG1K5V/mvwR17HXQibp+MAsFIyQf9vabnF2zUfH1mkBCdZnbE1fZ80vo?=
 =?us-ascii?Q?MRvVnsSDmnjl9zQZoW5GDVRm7/opF3ZSwHBMcYmseiXLMfosAaeCoiam3/hM?=
 =?us-ascii?Q?jMEJSo88I3IdTj4VxqEbqOD6mBTrIAlnnY6mr4bk24V7DJL4Fa9K00Y+9+ZZ?=
 =?us-ascii?Q?7cOd4CoTR6fhKJlZjZmHJEpPWgctMM9wjqKXlvBycT2jso6ofJI8Dezafn8+?=
 =?us-ascii?Q?KQNsdndOV7T8F+ZGxBdwRArxBt20NVfpyutbXsQhA0PcNQUBqMqAGRz/u2cs?=
 =?us-ascii?Q?8ecADtHNdU/7kgn4K5jWJ4hNjbfu9LUVbYA9j411lVL2RPHaR5VjoPw+fBhX?=
 =?us-ascii?Q?TPtxPnadKYqKfczgkYZsNX+SzuKZZw4cmcBSqdbZ1NIaAg8BcRd1ZiRm33VD?=
 =?us-ascii?Q?g6cK3W644IVefeZe6/YLDkIQcw65Iicp+iv28rVSdlbhQ67B4sJgiMXISkBr?=
 =?us-ascii?Q?BGprzagPAe1iV+T9JlJOEdnm/fECl9IFlNAX3Aay3tMi3tuEzzIMjK1pgqNL?=
 =?us-ascii?Q?fSnVAXLRtNaZWOgkeyJ8Z7Jj3mXmGfK8wZJvcu/nAHbVyGTyuV5EA+dPaF2b?=
 =?us-ascii?Q?YTs0S68hkCSI4+vB/iJdE08yzT07ss+OXgGKCoGZDXnU/puRVlV09lMcpJc4?=
 =?us-ascii?Q?2WAMlhaPxs0um2Vbc4+O+OySbYuCdHKifhrW/tyHB7rlk6DrNaJ6xH2b4ayo?=
 =?us-ascii?Q?U4BfmPFXO+Ewlvq7sneSydlEJT+CLv92ROgf5KCwkgg+14KKCEAlSefJ/yIf?=
 =?us-ascii?Q?VESODnwF+ScXZ0Un7e7etwzDWwCHa1ysZWfvF/eJa5pqyEXz/KAP5x8CRfP8?=
 =?us-ascii?Q?gHKo9lSOM+QpIWiQS8fEcfqj14489Zcj29KmWNP5iR5vCQkw4Cf1O+N4i4Vc?=
 =?us-ascii?Q?Gy2hFSvyqSPPAkZkL7efra3rNYxmk+fd/uIfFbo2azNCpOVdFYX5mPLnTpEo?=
 =?us-ascii?Q?5Xi7CAWyLfPpEK40LepCgHaC7FjFVrDFuVgMEivNR38le01A6RgtHVFPEiiS?=
 =?us-ascii?Q?xYXXoZfvLz4hpC3mM9bAXaseL853cv1QesFdq6tEHMRndK3vQLhxgQLsVu1m?=
 =?us-ascii?Q?yjP8RzzTcZAhNAozL32hLjDj0QWZFe7IL9YSH0DhOwzW8GMP4hNQfaPefARK?=
 =?us-ascii?Q?1cHQzS9AWHFot6iywRRh8aK2TNVo6VIw5JEyE7LOqzDr8MTY0gWAP5YiSBu1?=
 =?us-ascii?Q?Psrg7blDRiD4Id+5F75bzPa8BQLeFsQg7sWYBGDbxBnYh8PWXESWH2LJyHZc?=
 =?us-ascii?Q?g+u959ndc+GQaJiwkR8M/ItsF57ZWOichOUtt2oDcLdCRmVeoTkQZXSfeCFu?=
 =?us-ascii?Q?q+1QSBfVMShGKGQWFCWoKTvAiiv4MjPQAr+/ISCLT3w2tPnhq9kOgkF82RaW?=
 =?us-ascii?Q?oC4hsPf61fOh3fPLBknWEvlc5wwezknA59pGp2WajymtJk9ukk8Z/teTVJp2?=
 =?us-ascii?Q?K+waL0gQVtFwvos7nzDhS8JpDNP2Bpro55e0576BXl7u0M+hLifNLCdFKmBN?=
 =?us-ascii?Q?6BbPtSu2qj4ZuHLoPTY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 19:46:04.1540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f66dc4-8e5f-46e9-b984-08de3cdbbf87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
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

From: Tim Huang <tim.huang@amd.com>

This initializes GC IP version 11.5.4.

v2: squash in RLC offset fix

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++++
 9 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 20d05a3e4516e..116cb437c81bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1988,6 +1988,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2047,6 +2048,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2358,6 +2360,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2559,6 +2562,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
@@ -2961,6 +2965,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2988,6 +2993,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index cd4acc6adc9e1..48605e41cfb94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -949,6 +949,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 79a6977d56b0e..0e5b255eeda40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -120,6 +120,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_4_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_4_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_4_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_4_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
@@ -1113,6 +1117,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1595,6 +1600,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
@@ -3052,7 +3058,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 0) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5640,6 +5647,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(11, 5, 1):
 		case IP_VERSION(11, 5, 2):
 		case IP_VERSION(11, 5, 3):
+	        case IP_VERSION(11, 5, 4):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5678,6 +5686,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5712,6 +5721,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7a1f0742754a6..ad5e512e3fb8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -602,6 +602,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
 		break;
 	default:
@@ -778,6 +779,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index cc626036ed9c3..46d25d55ebbeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -41,6 +41,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5159f4a9787ca..f8678a7bec93c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 55c3781fc7304..99c4db3b2a232 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -799,6 +799,11 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
+	case IP_VERSION(11, 5, 4):
+               adev->cg_flags = 0;
+               adev->pg_flags = 0;
+               adev->external_rev_id = adev->rev_id + 0x1;
+               break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 5f2dd378936ed..36ffc3c785367 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1705,6 +1705,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 5, 1):
 		case IP_VERSION(11, 5, 2):
 		case IP_VERSION(11, 5, 3):
+		case IP_VERSION(11, 5, 4):
 			/* Cacheline size not available in IP discovery for gc11.
 			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
 			 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b91843b2af6a6..01e5b3416716f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -164,6 +164,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
+	case IP_VERSION(11, 5, 4):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -441,6 +442,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110503;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 5, 4):
+                        gfx_target_version = 110504;
+                        f2g = &gfx_v11_kfd2kgd;
+                        break;
 		case IP_VERSION(12, 0, 0):
 			gfx_target_version = 120000;
 			f2g = &gfx_v12_kfd2kgd;
-- 
2.52.0

