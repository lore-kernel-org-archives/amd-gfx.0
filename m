Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20081CCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 06:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B533710EA2B;
	Fri,  7 Nov 2025 06:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3O6CBgk";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA19310EA2B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 06:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXQoKhUBr/xWBdhxkCvJG73aH+ossd59VETwxxVpNOukDxLrbye+k7viRN3g59H5JMmKyuOcH50s4AsCltOQ/FgmGPAvTh8TtDh7Y5c4Vybhy4MQ1P0I+5CAQIZCyXsvSEMPfj5x+ggBFuyUbbCjbfs3Nh1L1Knz4p5/G/zh8xklRoKfrf+x3S927m2x6W5GTEMu4NttQVKT6+Z6JzmqzcoUeSuSuAY7kh8N3l/n64dWPmth296sa4slx2S+C8lssqIkVMXmJNJHO0jmisDXpFuoPK3LQYQJNHcCipPirtDAfuK1APntTsWMvt5B9XERo1q3yA2jdeBC6iBHZQHmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrxF2N6naBekeQZEghAzfZJ8AvgskVpfdqe0ELvpdd4=;
 b=eW7iFMigCEpotwiYsqdu3UJzOxNl5Zi6DMUgw0fAzpZxiVsjbEv2P64jjLmn/wNPFjfryCI96QmLx1BvvD8G9kbkBepWp9zzH9ap0mY1fQ4iH2T/UO/N8hWtDI4rvHsWNDslnaib+eNVjh+9q2WpFh1F+skeL+r849dcRBOEZs5oi0yrSCw3h8g6AStFqjD6C8IldXZEA/J64FYU7TjeVIB8D73Ijtso3dBQg9P8XKroTvjcyMDrF9hQ2xOoY8xrTEVTkn9WdEvrV5YSWPvxRNIQrhubb1pnHmgtsC3qSclMlZpDSkttCit95tOz+iGgwHmXLR52er7QD3clmZmNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrxF2N6naBekeQZEghAzfZJ8AvgskVpfdqe0ELvpdd4=;
 b=d3O6CBgkRMbqXM9K/uH4GHzpdyzlKOZgle6xfrN5JF776pKTXUa133PPvUMMo4LDsgC3TWBSj8b3OYbdPCXePIuz+VkFU1iVva+Bbi00QRoBTsbpHOgIB25k1NqjtLnFE6pbTwoY5gMeb1G4JXjopXBmg1iVAc17wh/p90dvCpM=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 06:57:54 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::9b) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Fri, 7
 Nov 2025 06:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 06:57:53 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 22:57:51 -0800
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Date: Fri, 7 Nov 2025 14:57:15 +0800
Message-ID: <20251107065715.1663175-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: d693d9ee-cfaa-425c-1ed2-08de1dcaf94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NbEenzmH6n29Hq2eVBPGvKncKb/W2DsFVgkDDdPa59VTPi9QNoSWspgfeqiI?=
 =?us-ascii?Q?N82H64V8rE4sSjmL7rTELpZhdmAdr95nyz4eHCVn2JE/IeTOIiP+vHQuwoxL?=
 =?us-ascii?Q?RFQPY4eaG+0ya/ivHa+Wy0MZkLK1KBr9a8XuGBJuiDAAZXaF+9RY8yTbE77y?=
 =?us-ascii?Q?i2EoRtyz+J/TfiU01zg7Xgdn0ccLlfV9qCXhX2rjAE8coe03BdZFCtAk6wXf?=
 =?us-ascii?Q?TWQOZwH8TTMJFkt3OCNj2jAGkcT8FSf5e3gXvJstaHVlZvDHJbJWm/bNhttT?=
 =?us-ascii?Q?1gh7frDGFFgClgTzMcnfYU7UrxEgWh/HnHewrW5LDnGPDH2qwjUWYqRwe4jP?=
 =?us-ascii?Q?+BrOuguLvVdhpYtnceiSUNCem7u+n08DLHnQs0+CWJRZazrhOPodme0eowuU?=
 =?us-ascii?Q?w+okCvK8DVEKcws3Nlo+vabOc9NZP/tzqhyMZrW8bLNUxJo95dN9wdybIgn6?=
 =?us-ascii?Q?kC71yVVd92mlfKobrBSB/dZP/u7M1YoQwNQMcp+cA8fxKbRG5IHlbGPMYCUs?=
 =?us-ascii?Q?40fHtLczzqEhF3ayean1lAXIvLD+Z2D8HU0n0ZAUQPX+Yy2D+brl+HtwyCAm?=
 =?us-ascii?Q?ui58mOfaSyi8T5M731EXtKIWLrkriwe1wZm3NQaRNeuDedWfMXRpAUNpxHsB?=
 =?us-ascii?Q?aikqwhswndRnbzQHNT4sfGEL9hfbrs2U8s8aGGc4pcEbkCTcetve7b+Ufih8?=
 =?us-ascii?Q?LJME6FR074nr+qzba1cGE9mWcXmW6XSMKm1TC9GeBg0A60F9rTyq8GIq48zq?=
 =?us-ascii?Q?ANha8DxThxQwkeg1MItSxsP0tiNm6OkrkqkKMJrSS+rOCeKuF0JfAhJbGyTV?=
 =?us-ascii?Q?xDX4bhVlZJaV8Hn9RLgylgIyeFAy4+ALcCBVz4S+VhlOCRSnz0c6SwXzahNd?=
 =?us-ascii?Q?myo4qid/VW0Tq/GhFO4SkJsn+0Y97chkjUqwUBmy2ykeGCuhxnSvzZ9zH5ai?=
 =?us-ascii?Q?HR8c6maYDn0LAw8mk1djRraL36p3nxINUDShMMu/6itsFcKhZ4PjMzLWmaqH?=
 =?us-ascii?Q?2ZT7aakqPm8PPZebISAckPiyfblYp9dnBJEMjYdy+dw/eMEGhkNjswhRg7ek?=
 =?us-ascii?Q?/3g508I91PKr6vHxcME7VMgyUiUnO23/nTOw49e60h2oYI4x7D1vnfEFcxvK?=
 =?us-ascii?Q?uiwWUN0nGvDUE80vzl3WFW/6F8u+xcAfM0vlHfq1iY/lVD/OKkmA92HzCPHI?=
 =?us-ascii?Q?BGELJHm1Qw7vlm4CXpLAJszA/RyhTDhJjKYLNVulVWrvUvlqdK/RIjOEc86a?=
 =?us-ascii?Q?Kwkb/bpGotS2Ox6j4XlGgArSFX7yvwm+gKKUOUVRteGoVR/mLNDyxSyS41VB?=
 =?us-ascii?Q?oLfP5HUUBcGeUJeU/BAjkL02xxi/KfEfuZc6idDH5CmkEUJnQMu+eUAFqJaJ?=
 =?us-ascii?Q?jvmKndACYg3qmvAVmdqHZcXyD6yy4dOa+Cn4OmLmyGrke/5PnlwHozSsTlnS?=
 =?us-ascii?Q?jETpSg2ogH4pvbMA0PvlYCejTqKKsBky7RfwfaE4BifRaKBpq+9SyL/i8Z8b?=
 =?us-ascii?Q?PsIcOCW5WvNRqtUcEPkO+soGTXoyNqO8bkVvQUnrrbsfhBUzzvQaT9B1ciUf?=
 =?us-ascii?Q?R9K6PgtVetaJJ4toW2o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 06:57:53.4904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d693d9ee-cfaa-425c-1ed2-08de1dcaf94b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

[Why]
function "devm_memremap_pages" in function "kgd2kfd_init_zone_device",
sometimes cost too much time.

[How]
move the function "kgd2kfd_init_zone_device" after release full gpu access(amdgpu_virt_release_full_gpu).

Signed-off-by: chong li <chongli2@amd.com>
Change-Id: I3eebd7272b8f0c85d08fec80acee67a2c9e59e52
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e8725abcded..9aacf8fdb38a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3314,7 +3314,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-		kgd2kfd_init_zone_device(adev);
 		amdgpu_amdkfd_device_init(adev);
 	}
 
@@ -4929,6 +4928,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		amdgpu_xgmi_reset_on_init(adev);
+
+    /* Don't init kfd if whole hive need to be reset during init */
+    if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
+		kgd2kfd_init_zone_device(adev);
+
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
-- 
2.48.1

