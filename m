Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D9AC54E90
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2AEC10E7E2;
	Wed, 21 May 2025 20:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vrf6Db2A";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AF910E724
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJYV2dlCWtEimGBBQQg6ffxQxfGGjdq4di1Ayrp8cUj/tZ2Lq3laW5tquYuUTBZ4C603Woqjk0LMG2Ac0vrb58foUmKq+xDr3ELm05PJ1J1IgXCLHH+0sqMsG3LXinCWhyjk9RKXrEld/EYSflP6s8ga53Rld9PJZagoRR3JILtZmSHO8GkH7rYXMMPYLE+hKPtnJzgc88EqyuRz3BueI6rbW6ErzJQ3z3xFXBR/nOPF6O4+v3AwZtfa/LR6Q1Bt0UG7AaCtUBDV6yko8K0Z+rxX0ivB3c9Y46MMVDClhbJBVHdVdHHRdLgFpuudGmEIKpDfSgvXsQbxYF6WfneO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCEeUAuvbIM8Hjo+yG3A+5AkwWrzxH9fYUf2qX14oYM=;
 b=rSeBFk/QXFZWSPMAq2qQjqrYHcJzNTA4c3iFiZRYHe7068iDA6c6qS4B3Vj9YcyNvDGFIqInKksqaEbCx3mePn/PWx+O2C/wnCphAJlNG6U1LA8oK1pehJYylBiENXiSJgWIBJGOCL7LkKom4y0HmidRWyZqcCI0Y1sGyBjcOO1GCXSsIh0lb8hzesZll6CXE3+iqoym3GACHkYQf8TR8QAX6voAYX6Utj/hhd+LheQXuLhUX9pJB2+WgNi/0t+C50AHoCwtECAanVH6gWD3HGcWNCkZe8grcsYxj9840VIXEUJERJFak30cQ/X3qePyH6+VBnkjZgto8gO62RZNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCEeUAuvbIM8Hjo+yG3A+5AkwWrzxH9fYUf2qX14oYM=;
 b=Vrf6Db2AtT3JbKG8MGlfN2SchK6zm7nWg9jg9PnMvT3hGcHzlFPFdSFObHX4+beqql3m1qX+F4ELJKiq1Ht6SnCZnzdvgN59la9Itpd9sN6gfQnFJHHzXvj8MyHD7TgORN7NFamh4cwtJWX1NS7esKb57h5DiA6gY2lF9cVevMM=
Received: from SA9PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:20::19)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 20:24:32 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::50) by SA9PR03CA0014.outlook.office365.com
 (2603:10b6:806:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 21 May 2025 20:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:32 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:29 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 7/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:12 -0400
Message-ID: <20250521202414.18251-7-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521202414.18251-1-David.Wu3@amd.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: d56571c4-862e-443a-cfa5-08dd98a57f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rb8Yre4FXXS0JIMNWT/VZMsQIUvIbCFXRXSCy3RCqPM8CCor+Or6+DFCx4GT?=
 =?us-ascii?Q?skCO6BXYsZa8zA9Vp8S+Oagu86iz1x7qsgT4faksuOL36a40ixp7Rwzo0Kh0?=
 =?us-ascii?Q?AgmLlGEcnwyqxAZy0uZjnu9/a00D515Ypx/Wi2BeyRS/z7qsylsdbN0BPgb3?=
 =?us-ascii?Q?6wEjfhpVrN/Zis5OtdWUATmLWx4di/LTXFnyd+7/fLAG94FqmG2hFPjIKTXv?=
 =?us-ascii?Q?3jTWMgFXg3eJCU0PBWjE2mZYkSEeqyE0aEBUltYYAweYU2J89Z4g52+3RWV8?=
 =?us-ascii?Q?GfOYdzTPcIpwcimP3BPEJFAGzRp7kfot7y/2ixhFJxBBGNMrdLRGBanie6X9?=
 =?us-ascii?Q?E2ppU9STwjVQdisst4lN0RPh/HCrKuLE8v96vNKZmfEGj9BcOCobbtoBySR5?=
 =?us-ascii?Q?+8lvJT1OXIflsMkY7QRaklapwYk3s8H+uk3yvxNXwulSorEM/9naM6Sc2SNN?=
 =?us-ascii?Q?kUOZ29I3IPbGBjdFsEzfvbgN2OGr61ZdHwRFH3/2W4Sh0FRJ6JVBV2MW6dZS?=
 =?us-ascii?Q?QtwYU1Wtu6ZF+WrVX6K0/VZpg2KNsWXeX0QdreUZWIAJiuS2jzYBpDz7+aI3?=
 =?us-ascii?Q?sSC2ZrLpakXNYQf+a7V38B72Gs82OimNhIsaXlmvpDv6eHIdotUQ6QUr5BtS?=
 =?us-ascii?Q?mX60HqpG2ls2WO0WtCLrLMnPFVyyOW2h1iaJK8FHpQ2mcETi0v3+cjhCjNcD?=
 =?us-ascii?Q?WDuhyHtzTJmDaryr8zz1vvNFCbMyqZeySaEDofFOlCt0Fv1CMoPWIuuBVZBv?=
 =?us-ascii?Q?ROx47ZisLMAExDDFzh8UKiLx/C5UERC1uSOflid+YT0SrsZdTxBOvop5dLuZ?=
 =?us-ascii?Q?D5bCO3iv/KXojFKOSfXQRFN8ovlrIVRrTTy0FC6xFyobidsdQ64IN9J3yENr?=
 =?us-ascii?Q?whGkWvPIRoJC+cM9uHeURpYNgy7aLOoN7lcFvAMnB63cAgZaY5Ceajp5NFpX?=
 =?us-ascii?Q?r7LNIW6EWI4AqbLNj7ynJ+DRXg2yDM13wkKvAHvCVgCC7ONe55GB17ScKUVD?=
 =?us-ascii?Q?NvXJj/pOD65IFHyvnsIxmj+QXP7b87AMI3w/2zbOLhPS+sxRcW7d9T6GbSpR?=
 =?us-ascii?Q?W/P2ghARnNBEgZ7ySSJPTu2lzHE/NwtY30gFp5cQaoXZ/SBnsEluW7SyaRMr?=
 =?us-ascii?Q?4s2FBXty51HqgJRonmp3o92T5gnKX55UYGPKex3fTgEnXjJsY3aiJHDDKrxF?=
 =?us-ascii?Q?iQyOjp5ixbEeTLAFYt5CLm394ZFONd/mQ6mfvNwjRuKXzadTYWtnTkGYfWMd?=
 =?us-ascii?Q?tjQ/X/IL4CRNGwkXxlwmnDFok9GVqUeDx2AZZ4OpxXh2jH9HJuGhDs0mo/XL?=
 =?us-ascii?Q?aS7H+rllPC+zfgGqc/5HuR1KP2d2XGgYr+uXdfNr7dWRYkPA4HavpQIdPLed?=
 =?us-ascii?Q?ZCW0adNWRCX+sLqzFbFTk+6gHeDuLQrek9d7c5XH0rR9Xd0cajrrsWYsiL9i?=
 =?us-ascii?Q?jA4v140uOOjpcR5GXSAtp9q/tzB6N6pHizvMpdKehwn/MRPlts8RJv8BQWos?=
 =?us-ascii?Q?2pTzRf1YstR1p5yxPTiL7JmxAc1Kk3avTKfa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:32.5109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56571c4-862e-443a-cfa5-08dd98a57f18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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

The addition of register read-back in VCN v4.0.5 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a09f9a2dd4716..16ade84facc78 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1254,6 +1254,11 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
 }
 
 /**
@@ -1337,6 +1342,11 @@ static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v4_0_5_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.34.1

