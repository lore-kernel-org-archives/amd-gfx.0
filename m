Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76038CCF9F9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3D310E813;
	Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rxN2dmvN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FB310E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbweQ/M0HY7Lj96S0ehZ9eBcrjX2cO8Uc7UZ52TgA9usa0cmAAkblfVR2qVw7z7fGumbq1NiKIVcCy4RzoBcnzQIW5wHRLrSfPJDyRhj4tzp812dlt6EoqI4/6aRIdOaNIv7SimLxjiU7ywPa48iRHWEGUOhr/uUvDKOXEPzsSXEfAG5MxeNR3+Y/EHTYqN9pSgoD9pOSMRaT2zrsJpN7YG8mfW6HERHT1QE8tOrbxPyY4nCZZGKfo+7/OjNidKV9neRHQbWHpdu3jcnoWxGLz514+Twy6NFPnQKaJ4mWXArplpyeo9NafEOb5s8HL6NihWv5e/6HJL9qJz+DOgkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/2w1MVHL3yt4CyuxYuIlkEzAReStzDNy0ZfK2zqU7Y=;
 b=IGp2w5cXgEb1WXwwpfnvrj5Q1Eu7Rhhh68kJyEnLEy/8HbdZRPGSYU0kpe7mGs6+ExdyWtDE6xzct1HLKo8spwZ9aKo978IvQc6vVm8lkzlcRQ46nQ2I54Uc7Kwbx1usweQkb2MNDSiJgbmcUrhsWuJopM0jeETEoR8mT2C6vLOU3QlvX8gHnpfAtv2rXcbi+irIlNlde1lSIsUdbrd6YtsXUMdgxwLEOx1Fv0GnbBaZ3XvhzguB+Jhgm12fugmRrOZaFviCLYNgtXw7ttzCkoJAnzqkRzGTA3lYILoMzUjPQ4lNvFSIJsaBl/VJg/oEV2Y2rVGQjYIZj2TvBybDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/2w1MVHL3yt4CyuxYuIlkEzAReStzDNy0ZfK2zqU7Y=;
 b=rxN2dmvN35XWXEUdieabaOMePoPal+ufKUGdzBAGVb1J64SkPnhl+v7bpi1eCPBYkx4DOhPt+vzsH/l9xWqnbWgrVbkyMGkt0/IiRN9pvEKAJ12IZZp3fBgJUv56tYRsCXBAbQcmH6AC5pLy5jCDEbzFUSh9UGaJa13BAXIZgZs=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 29 Oct
 2025 17:52:06 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::c3) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:52:06 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:52:00 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update VRAM types
Date: Wed, 29 Oct 2025 13:51:36 -0400
Message-ID: <20251029175137.2861556-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e57b6a-cc5a-442f-fc03-08de1713e00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RBcWTkyPn6bA3TZAjgzKb9SYGxm6/7qG2RW/i0OFxlFH9xgMY+WqUzeJVmpF?=
 =?us-ascii?Q?h2NpVW5RsVxBCuHb3FA9Bvp18dhTCMqus/Gp7IRgZLFSm7vpTId16oANMXRF?=
 =?us-ascii?Q?dnYV0qvkZOwQ4VCGjTwj0zgtxS9frqt6Dmc/1RjzwnR4j8UKf9GAxDmuFFvL?=
 =?us-ascii?Q?Pw6otf9MqnlegXBSuix82GnaZgYv3jp23r1Lo1B0PZcZnNoxvFmGBGpqyTbr?=
 =?us-ascii?Q?k41yTRbdapxRqp5QEjCdGwHa03+XYGNcgwMsu2c8fPxzb7EXPKK4Zd588mMY?=
 =?us-ascii?Q?vWKKmbQx8IP9+kmi/B6TR6s4fC4BlbXTpQEBOrSeunXXp9U2z7VR6ZJOXNs1?=
 =?us-ascii?Q?Orl/qFyz4DhDv/85fUoxC4DT3LtYbzmocg6AzEZCRRqEXUtBjGuK/uNbPFUI?=
 =?us-ascii?Q?g3JY74ZX9M4730FrJoFoIgOZDp9b54TKQ3mH6UXdr2G3IQ+uJ2VUIUwXlCLw?=
 =?us-ascii?Q?AVh/mr+FnzV4KheDjATsIJmJ4QsM5Ia0u8TQYWLrsakqvu4IX0iX1LMieSkF?=
 =?us-ascii?Q?/IjfjNaWkukpr1ZtFZ5GemDUZL9lnypyogsZkljDne50g/bXfNzUJFjl0ATj?=
 =?us-ascii?Q?oad+3jveMMzzcadEahTafAwfmLENAekbXTh/Y9ekecF+kYs1rB0UdmNgPe51?=
 =?us-ascii?Q?uTslAvUzHTJGOMCJ+5y3Kjx2yk7d1sTkmSlUGWJwJh9NgRDyy7Rl6VwVEevo?=
 =?us-ascii?Q?+/dXdPH7YHxDFgs6k0GgFPn4KU4qs8eTwbpqM0yhuVi5gtuPz29j0Ka6lGlW?=
 =?us-ascii?Q?ttI04mk0zFcSYoe1eI3ChOBTBYHp//6dDPrnBZ+EpJNkx8wOIZEI9bkRIqzn?=
 =?us-ascii?Q?OyjX7qEMeZHHFVRQeD/4eTL0tGfEuxq1DZNCelXn5mjVA6Set5Kn76c0JOfW?=
 =?us-ascii?Q?IzmaQOFc8xZE1eoxCqWKHeChTwHPQyae2V9sJOjIPUZCXR/+DP+i46NbPzPI?=
 =?us-ascii?Q?G9u4IXrHKCehuC20K7qQKP0EF1cfA79caU0hLTaG673PI7KTwxdUbsDUiv3M?=
 =?us-ascii?Q?MxA/ZrtZHcfstwBlqIPGsR30aRFlhv6PXgKuiqhVheg/IH+2sgG9jkivg8cm?=
 =?us-ascii?Q?CGocCfqMfS26oJaCAQCA0zViLYp1D1ir40DZ1FnWu/AnLVmLrZlahrJFrOaB?=
 =?us-ascii?Q?E3iwqozBCSfXBfO0Qv9AhQ6ZSkow7ZkGzfMJNednxX8biyg/2d/9Tjcs8mxz?=
 =?us-ascii?Q?WXok3Urk7ZslRXC1iLm+MNy8YjvhRK4QOg8dm6gkAS5RpWQ00ZM/tdXCu3jS?=
 =?us-ascii?Q?jYna3WHTAq+IcMTMvswiIe0Txf0ht/Ovr4Hi1SyuEsmhrEm0LjSzjEuSqwz/?=
 =?us-ascii?Q?A56sLVRQT3/Jns0e9Tv+OYWfpwaaBAizERlNJUNqEkauofQeL+a8JdRGU1I3?=
 =?us-ascii?Q?K79yr6ZCl27979r9oz/JVdSfd/D8Mlcnt9X7VjZlhLoOSiY7Hvka2ZgkitmK?=
 =?us-ascii?Q?403Lu56NAxCyZ5ahnoa5ohMbpfXZiMB0WBz2ocTGjlI6o9mIG4cj7H/la51X?=
 =?us-ascii?Q?23M9kUiBp22shWMz3/vbj/68R8QIMRvlzvMdC7hctcKzjK3L9Nzt3cNpFX/5?=
 =?us-ascii?Q?MTBFWBRSnghGWVKzX2s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:52:06.3521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e57b6a-cc5a-442f-fc03-08de1713e00c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Update VRAM types.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 include/uapi/drm/amdgpu_drm.h              | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fe486988a7384..24ebba43a4695 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1050,7 +1050,8 @@ static const char * const amdgpu_vram_names[] = {
 	"DDR5",
 	"LPDDR4",
 	"LPDDR5",
-	"HBM3E"
+	"HBM3E",
+	"HBM4"
 };
 
 /**
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 406a42be429b2..d1c50d29171fd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1427,6 +1427,7 @@ struct drm_amdgpu_info_vbios {
 #define AMDGPU_VRAM_TYPE_LPDDR4 11
 #define AMDGPU_VRAM_TYPE_LPDDR5 12
 #define AMDGPU_VRAM_TYPE_HBM3E 13
+#define AMDGPU_VRAM_TYPE_HBM4 14
 
 struct drm_amdgpu_info_device {
 	/** PCI Device ID */
-- 
2.51.0

