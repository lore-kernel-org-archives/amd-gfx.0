Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBEDC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907F110E6F6;
	Wed, 30 Apr 2025 08:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Chy1UMr6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14B210E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHwHR9Z/LxlOIlpxN8Y4T7WVffwUpnOnH3LX9m05j+1XTW3cP2BNNG9GWDXUOtieUF2A8eN0AW6iOOytGfZndMnrx+3b2vcq9voY9H3iqCR0FOQ3NG6nNreKL2gdDv8bNuN1UAfQZ8KKk+3iA/wNeE6tv3UwtgLL9Zk6svN/ke7irNTvD1f+AAfrz/AQG3HG5EFP9DEpqJAHCf+GCbgEbhFPvJCOyxexw9p11CT39xQTbmPt4oHueRio5aNdQphmw5g8zQNUHE4qQNPVgInO7gyLOhDKPoGNuugbcHT72aiDm5x3fdCtpMG+VyI/3WHOrR/VkS2oVUew0182qDqLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOFMvETUmFhnkoNaBq05O7Yk4MEaUyVYUdJCAGce/Gw=;
 b=rNh7DYA67jafyE22+AbD1OSNVmL8Vt+P9G5U5quj5A78HiXxmGLe4HeheshyNI3Cqvt+n+pLsiPNL/As7PDdH0Dboygu22M02CCZzf6wiqsQAhEXqJmHH+Y6YaRprA8FTmCpyr50hQBCXDbkHrlKFQDQjmJ1oCGnIFYWEcFnaq0Vq5StFlrvu/kprGhprtPMuDK7A+dC76ssSYCHmk29ItTESTQpuOj839TOqevr5qxl/j/Ql8VQ+BUwpi2kkd8airVtahpP8DpNrOlynmEXm/7/AzoBLS+9IVOFbwYxg87kVpQeJnVrte6qj+vc557uNz5NChoDKkglGWqFXA5Orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOFMvETUmFhnkoNaBq05O7Yk4MEaUyVYUdJCAGce/Gw=;
 b=Chy1UMr6ZxAzSZlIBXaSEFX/hjCs0jM8vy8Dm1rUi2iMVIiOGI5lV8xtVd13d6Ye5qqIuAXM7NFFL2XJMNfNAsDvulQpRMTNFYHVv9QIgCDuq1NoKpu0HGqJy80l1lZyVjZlrp0cqfHCNDlhWgSXePeIdpRRn0MSc/g1LiNqmQk=
Received: from SN7PR04CA0218.namprd04.prod.outlook.com (2603:10b6:806:127::13)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 08:26:02 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::36) by SN7PR04CA0218.outlook.office365.com
 (2603:10b6:806:127::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Wed,
 30 Apr 2025 08:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:26:01 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:25:59 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 1/7] drm/amd: add definition for new memory type
Date: Wed, 30 Apr 2025 16:25:44 +0800
Message-ID: <20250430082550.60109-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0c4782-b885-4374-8d49-08dd87c0a473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jAW1Nk2tK5lbcN82X/AlRpn/WvTZHNI+buow7c/hwNDWBbDUxjduafGQFgze?=
 =?us-ascii?Q?6hOIZBhT6tnePaPaeWw9C9Blu2FsxhFuJ2IiaQDqBT/XU0DwBD+e4nNcKc4n?=
 =?us-ascii?Q?0JODFSn+fR4uiSIFihosCi6ftKxsKht5M1znht0Oqqc4QMJQKwZ115Ib/y0B?=
 =?us-ascii?Q?GVY/kLClqPvzI2whjH3jotFnAOqjgHo4AzlEXNDtkI+ZPZdzC7dAJrBVReMi?=
 =?us-ascii?Q?NyubBcz8hvXPU6s1PAIbfLCb8QS4eurCCK4FmMit6+rHAlZeUOrn/YRLtjlD?=
 =?us-ascii?Q?Nj9bL5w5shx6dG5Uq9mRomvqwWi0Or3Y0UvS/eR3f/l4v3cVxhFfjoZa0TLW?=
 =?us-ascii?Q?LlEznjP6qlHheesFModsqhARDNGcSU4tRd/BV9iVz7mT/UTt1KOkRMXbxCYT?=
 =?us-ascii?Q?/dCxW33qCZxReK/wJMdcuNtBeWfXG2wDCMGbbUqbfB36xe2hhgSytFORc38Y?=
 =?us-ascii?Q?0EhkFOQ0S9xjJ2qDuedWR6FlioRTOGzKGUxEISSsA5eyzvn9jGXk0k9Fcmau?=
 =?us-ascii?Q?UAKkDVnzV5ARbW4SssBwT6Owb8+oua1oVZeRNcNJNMbHahW7RW4QQ9kSMwxH?=
 =?us-ascii?Q?ufwk2NKWSaTy+NEW+jA3RmqnqD1D4wN+hIeV67+x/toHPy2dlB0/JW7PfYva?=
 =?us-ascii?Q?/PlCC9oLDyB/J7sbN9T6mInv7T8zijndMQg4C+PlmfWG5QuBEe81tWCCXfEs?=
 =?us-ascii?Q?iSGOVtqGSAtv2l61nsYBKEV+YH3f7Kfg7viCcDFJgiGCJvkMXBUZdCU0GybW?=
 =?us-ascii?Q?B+H93YrG29Kuuc3c2TYsoiQbKip1xKMF1BqUFDUSH6trCA1EVhSXn4BKz3k9?=
 =?us-ascii?Q?uZGAw0OA9o/tSnsGd9q0hZrHOxfTR3MCW5C56o1BxiGyPuLUpWIf7CScYpf7?=
 =?us-ascii?Q?C1NBi2GBPv/lu7lULiDvsaDVYoEu83O1pUuK9+J3Qdm81soGEla3AOnk/39d?=
 =?us-ascii?Q?oSTykF4QmwoMMcEODV61pLajXqqAR44NmzRYWLfB5+I2SOmF8DXteBhueEEa?=
 =?us-ascii?Q?l/SWMbySYdISJ8IhHmjEcF6bScIcq5sZ8mu2LoSCiJc5Y3ETHMECC/8Y6WXH?=
 =?us-ascii?Q?CLoVbrsJfHixaHWaTueWiVjleD9k6XAFctx8WwQWikgN2zkxvcQ/nfST10RT?=
 =?us-ascii?Q?ewAwUFqPUZmzNIBlbpF9ozSChyqCAVJNJMEBc3nDyGEq5285P4CgDFlI0UnS?=
 =?us-ascii?Q?z+xv62CoKk6JHkcEFUtGcAIzCKFk7FirO7/TAJ/7+lSoiTHLK8fImYfPK/rk?=
 =?us-ascii?Q?xgTgdgWTuJFpLKj0L9PoJm2NBQWZbY3pdKrLaMqxvv8Di6/9cUR0RcZj7RZ9?=
 =?us-ascii?Q?h9cmH90QOeNy5jOTofvac877BMbyK4gGd0kGrM0//asZdJe/PXDZwcR+EGqg?=
 =?us-ascii?Q?tjDXx1YF+UylIoVpv+paCl7DYPsKKcaMu2TCK0e9CADpgZZ5SDFXGYIzcSRG?=
 =?us-ascii?Q?Kh1UJpk9N6Czl5lo9ES6riE7o9XY+a5tdawwH/Evt4ebc5DokmrZsyuBekQU?=
 =?us-ascii?Q?wMJbGIljEsEzXNG6iQhmcLIA2ZuAIiKAJBfU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:26:01.8309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c4782-b885-4374-8d49-08dd87c0a473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938
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

Support new version of HBM.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 3 ++-
 drivers/gpu/drm/amd/include/atomfirmware.h       | 1 +
 include/uapi/drm/amdgpu_drm.h                    | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index eb015bdda8a7..c7d32fb216e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -281,6 +281,9 @@ static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
 		case ATOM_DGPU_VRAM_TYPE_GDDR6:
 			vram_type = AMDGPU_VRAM_TYPE_GDDR6;
 			break;
+		case ATOM_DGPU_VRAM_TYPE_HBM3E:
+			vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+			break;
 		default:
 			vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index bd6005cc06c0..4b8c492348b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1080,7 +1080,8 @@ static const char * const amdgpu_vram_names[] = {
 	"GDDR6",
 	"DDR5",
 	"LPDDR4",
-	"LPDDR5"
+	"LPDDR5",
+	"HBM3E"
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 0160d65f3f5e..5c293017b541 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -183,6 +183,7 @@ enum atom_dgpu_vram_type {
   ATOM_DGPU_VRAM_TYPE_HBM2E = 0x61,
   ATOM_DGPU_VRAM_TYPE_GDDR6 = 0x70,
   ATOM_DGPU_VRAM_TYPE_HBM3 = 0x80,
+  ATOM_DGPU_VRAM_TYPE_HBM3E = 0x81,
 };
 
 enum atom_dp_vs_preemph_def{
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index adb811ed4c34..f3223c05f71c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1443,6 +1443,7 @@ struct drm_amdgpu_info_vbios {
 #define AMDGPU_VRAM_TYPE_DDR5  10
 #define AMDGPU_VRAM_TYPE_LPDDR4 11
 #define AMDGPU_VRAM_TYPE_LPDDR5 12
+#define AMDGPU_VRAM_TYPE_HBM3E 13
 
 #define AMDGPU_VRAM_TYPE_HBM_WIDTH 4096
 
-- 
2.34.1

