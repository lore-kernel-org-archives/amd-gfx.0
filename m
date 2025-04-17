Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E07C369CA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 08:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FD010E16E;
	Thu, 17 Apr 2025 08:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASNiohLw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B406D10E16E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 08:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCAEzVFmDrTf9LRZj8YJRozUXead7i4SntcurGg9qP4mk81BhGSOi4aVtSCd6lTXl5qAbgZeBsBCycCDrwD6bTle5/w7lX9c7QY5N1wADVRZFEnO+okFsUardeVUB/8jmGlRFzAEXsYZQjOnQfExjqECw4RpOutZ35YumlX79X1VwfcNs9iSpFctqK+2PLEB2PaAlx77gUIULw8SnDssHYHECGSwX2jc6AYVBXm3Q+A/1JQiP7Vb4VeIB9vLOyK2o5w0Ugtwwt9jtVDyGvHkNyGNdnTKKMqyA5/21JoAp+mvK5mvRIeVvEiedZbIsCY9cU6y24jgd7HIiMZCQ6PwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl2wvwsx9HmnwLS7+6GP4k1PgGKDGbk9yn9gHp7n6sc=;
 b=HXuep0GwRrSq7aln/Dxi5j0RAlwZh0EA2m5JYsGxciiMrSoSMVXP2tKb30uwCyPkR48JTUywjOuMyUIuzdB7WuDNOzXlLByh7zDUVFcmCxukBvvpGAcMmPS6iTcaXGQwj4cLReuVnA11ARz6Aa0hIcJnyIBD2d6g7Fe+JcGAS6XRafhEeDtsu0ZKIOEDTislW70v/FBYssPCKuDCJtmp2nDArk/nr+PHmeFQoD5HA4VveG3ZopwTgUt1nUoPVOBdTuEoAhlaqAdEWuz0zrhV2LGF9WQ8yNUFHa3QSTQN6pAYGSVUSbkpxEf8DosVWDINxAA0LIijjI4VY3wzKCqxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl2wvwsx9HmnwLS7+6GP4k1PgGKDGbk9yn9gHp7n6sc=;
 b=ASNiohLwJiKs+5fjW2hOIJjs66foPT6xBJk4jaEZuTa+dxtL/B2Wdm5VgpD00YsSVjY3pO4fxqNNLoc+zI5Jwfl33vEtfRk/G2sOwYg0RO+SGQa8CsZet2Uw34LvyvfapuxS8IfdioFhCf7IYPgQEMuboVCgc29/KdyYleYxWzQ=
Received: from CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::16)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 08:58:44 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::26) by CH5P223CA0014.outlook.office365.com
 (2603:10b6:610:1f3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 08:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 08:58:42 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 03:58:41 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/6] drm/amd: add definitions for new memory type
Date: Thu, 17 Apr 2025 16:58:27 +0800
Message-ID: <20250417085832.36455-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e75e42-4fc7-499a-afb7-08dd7d8e0dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yw1it7zPP36W6Tb3QfmRyXgb6x0eqCwqPeTlozukcPidOgbmlStTjN6B4+WQ?=
 =?us-ascii?Q?vqVftBn1VCNMEjE7dw5JD20vYdRW6e2mBBMSdi4vSg4b/zE7mYy8NJs4utqH?=
 =?us-ascii?Q?NAGEOKJHPbB1rjPke7XX63+atTcmjJ7FE88G1bOliNiYL90xh7bad4CBaXhC?=
 =?us-ascii?Q?zXTwuCvzq5SrkO7GdjTNa7km9wuRzrho3OV4eAFPgVKv8Lg+7SHLuAsUNwWd?=
 =?us-ascii?Q?zXXGlsmZHVUtHTLmpChUtvQ16R2FJbmd4dLMxO1nxq1vmHGU9MsRCHxquW6x?=
 =?us-ascii?Q?k7QmBUe6hSIMD9OeJ4NNlSoGK+6cQ12crBSj05T/pEKV+zWNNFoP0EtmR/sg?=
 =?us-ascii?Q?lei3EoVKMfFvHOQaWGw1qHPjwSRQVqp4sNdmd6SKxlW6R2iEpWyBI0dNiuxu?=
 =?us-ascii?Q?UesRudW+OkPtVXZc3uQol2GPUThbN037R6ZPoenlmT6PJddSygWEJ86NdQ4+?=
 =?us-ascii?Q?mwpDkkTW/3ascXeG3atks21e2Q9UNYYLgOJypgcMfkEtGBI8+5FzIcosj2j2?=
 =?us-ascii?Q?UzG5X8MwqHvK9xOm14/+xwfaU2GolPqO88A//oahv7ke0rn2VGHQ8VYLKOqR?=
 =?us-ascii?Q?cUHcpIQX+GT8w7SilPrpXZH4nNQs5qx/J5lU6NFxtVFM53V/J3+FoW4pM+3a?=
 =?us-ascii?Q?e/6bfLMFmIeMoWW9wihrwrIMxO8oVyCACoeYSFmyDhZ7enZtzlGfJvr3x13T?=
 =?us-ascii?Q?itKUTEBwtZhcmUIQBIBKTAwdmzlRyxU5vqC24OM29wSIMoQQG6eMYUPi2Uvw?=
 =?us-ascii?Q?FZKqcR1bD4Rgl85YX2Y5q8FqY9Ca4xScqDIPu/lcTRoSR9OrBn/wMyJy7DJr?=
 =?us-ascii?Q?ZC8bduPP369z75B6V35Qy1i5oMqHHrd+eLAdjKT9yduj5iCcJyj8LqnvflhU?=
 =?us-ascii?Q?NFr0QAtuRgd5ORmpplo+J2TE9b7ppDkOMl8beJFwkaqSPuid14JkDNedO2td?=
 =?us-ascii?Q?Nxly7QNEmFmYPh8Mm7JWQZWWqVnTkKkDzv42XlB2pdP/M5PMo6Inr+3F6I51?=
 =?us-ascii?Q?yqwFoHRRba0ZBx96KRU2QsXVFxlua6k0qFPsYoQn7HG+THGq4u/DH/bHQvkN?=
 =?us-ascii?Q?AB6Fm+7A+Fn8jvZ9u1A5L43UC7Tgi839rZoxSCCsJX8f32xzxGDo+5c4/SsM?=
 =?us-ascii?Q?Ye68ZUyUwrDWQuu1jwwm9vXzar0JJZE+Avc8RlyI4VfEmIji14VFW2IQNdMN?=
 =?us-ascii?Q?6DMBxm5Q6aTDXcJvfI3CimidbXCa0XGukbsg/h95qpiOIz9CpakBFEKgXhxL?=
 =?us-ascii?Q?ENJXfbU7oF8lWC7dedz4PG6H7FjXtJwPskOCkgsKmUN3FMCETSEIVm6JRZry?=
 =?us-ascii?Q?1KRk5wRIUPI5eqhJdwIUL5neOcPSdJwp9d1oGO3fwmxV/MdhGxmtsgKHpgLw?=
 =?us-ascii?Q?EC6+3P8Voi7PbL4L/x1bqw1l8PY5IAROnwXhvTr8HaIdtKrZKJo3hkt3pbV4?=
 =?us-ascii?Q?YFyFOwCCO2Cl4cL5le0VU5dWFi5Ht120Lbmj3sthEu3jrXqSonFfVwVnDIYr?=
 =?us-ascii?Q?6jujIjJIbdmVCdzNkP7Ti4THMXQwd57Q+FXS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:58:42.9007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e75e42-4fc7-499a-afb7-08dd7d8e0dfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

Support new versions of HBM and GDDR.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 12 ++++++++++++
 drivers/gpu/drm/amd/include/atomfirmware.h       |  4 ++++
 include/uapi/drm/amdgpu_drm.h                    |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index eb015bdda8a7..32fb264849bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -281,6 +281,18 @@ static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
 		case ATOM_DGPU_VRAM_TYPE_GDDR6:
 			vram_type = AMDGPU_VRAM_TYPE_GDDR6;
 			break;
+		case ATOM_DGPU_VRAM_TYPE_HBM3E:
+			vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+			break;
+		case ATOM_DGPU_VRAM_TYPE_HBM4:
+			vram_type = AMDGPU_VRAM_TYPE_HBM4;
+			break;
+		case ATOM_DGPU_VRAM_TYPE_HBM4E:
+			vram_type = AMDGPU_VRAM_TYPE_HBM4E;
+			break;
+		case ATOM_DGPU_VRAM_TYPE_GDDR7:
+			vram_type = AMDGPU_VRAM_TYPE_GDDR7;
+			break;
 		default:
 			vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
 			break;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 0160d65f3f5e..8eb8dafb3ac9 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -183,6 +183,10 @@ enum atom_dgpu_vram_type {
   ATOM_DGPU_VRAM_TYPE_HBM2E = 0x61,
   ATOM_DGPU_VRAM_TYPE_GDDR6 = 0x70,
   ATOM_DGPU_VRAM_TYPE_HBM3 = 0x80,
+  ATOM_DGPU_VRAM_TYPE_HBM3E = 0x81,
+  ATOM_DGPU_VRAM_TYPE_HBM4 = 0x82,
+  ATOM_DGPU_VRAM_TYPE_HBM4E = 0x83,
+  ATOM_DGPU_VRAM_TYPE_GDDR7 = 0x90,
 };
 
 enum atom_dp_vs_preemph_def{
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index a1c8eded0744..d8b5e1d33cd1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1423,6 +1423,10 @@ struct drm_amdgpu_info_vbios {
 #define AMDGPU_VRAM_TYPE_DDR5  10
 #define AMDGPU_VRAM_TYPE_LPDDR4 11
 #define AMDGPU_VRAM_TYPE_LPDDR5 12
+#define AMDGPU_VRAM_TYPE_HBM3E 13
+#define AMDGPU_VRAM_TYPE_HBM4 14
+#define AMDGPU_VRAM_TYPE_HBM4E 15
+#define AMDGPU_VRAM_TYPE_GDDR7 16
 
 #define AMDGPU_VRAM_TYPE_HBM_WIDTH 4096
 
-- 
2.34.1

