Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AFEC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7A710E06B;
	Fri, 10 May 2024 02:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WkKwmnde";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14BFC10E06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt99tvYOX4PUoNPVUJ9ocH8VQ+RrexqFHWs9xOfITumKUQl990RHC510UBvhnkVBkieLJLPZ5ecKlxjv59Yiv1aPGc4Z6JxFMiCNi7zT0SWpSx+zcGEpdCQAQahW/dDTok2FPq9W9mRx6wSEqmDlhpHxqzMySme18IRhrxJ86cK0bShedTJ2o1xcYKCl1+00aMiD9arbSg16VfG3eePt/7d0LSRSFXews7VUA7nuZBehr6RwOkH1bbQuNL0L57DvxOkHFwLgKVVKA7KHvjPmwXKGwf9nM3Ofe+UNiC7rt7bVBckuRSQLqHkrJa+8O/opk8qHNBD7gLZ1Dz+ST3QIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxtfflRQIzrrbHtknT1BuAe1uVEdQdwd2nmAK/VoMc4=;
 b=PRuP/ZySuj/DTrXGT2Ch5IZW9rPMDpuJZkT1d4shxu6nkxynzy+O5X8GbnJpkF+6iQxHLoHhObXglm7DV4+fToMGYYU3SnvPq6zzghApxFHeLc/MEHeHvu/vGvtvRBcDVhTLx7YIA/gvL9rSlWGt8BeMpNtekqWrFccxvmnfbEB5Hoj/0PnmO5nNZmIaSsYpvtx54L28zN52tmLQBUiy3CipMI8NZhTZPfJOYhAekjbrEhpwp6823jK0m5vUKi6LCBqeWWUBvWkou+XyK7Gi5+upSAKXjKt3nieq8AbXyLAli9dS4VDTou5ooczxp2fhnI8auryRkH78sY0eDazMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxtfflRQIzrrbHtknT1BuAe1uVEdQdwd2nmAK/VoMc4=;
 b=WkKwmndeHD8721cd8tcI310ohvM/C8U5oE6FgyJGOAzZJ/KF2pFVBRLgLI3YD9bjAQFVS+FPtQKfQWEoFfg0yVU/ql4D2EIDwHvJ6zbnndaVYhsryEupZc4J2SOaNeZNHVixs9YzCZaZLULIEnLpWgH4cR6OXSReDZ9YONY1CSA=
Received: from MN2PR14CA0011.namprd14.prod.outlook.com (2603:10b6:208:23e::16)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 02:52:07 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::95) by MN2PR14CA0011.outlook.office365.com
 (2603:10b6:208:23e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Fri, 10 May 2024 02:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:52:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:51:12 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:51:05 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 03/22] drm/amdgpu: fix the waring dereferencing hive
Date: Fri, 10 May 2024 10:50:19 +0800
Message-ID: <20240510025038.3488381-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: e9232604-26f8-4a9d-db20-08dc709c2de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S/UgjN3/z4Zb25YCCUtUy+vnToOuozYLeS674McsHaJkxal1fauTlruvX0rx?=
 =?us-ascii?Q?dHFf1MnJ6+q4h6cT8Vp3jhTSQuRSjhH8c4kF+XvUP32cfoGvKibtOHP7vUIq?=
 =?us-ascii?Q?P3b1EtFX0HB2bplE6TKW61pmsSOc3qzI6e+FVnIiOp8MYbVJ7fF5E6B4TRQB?=
 =?us-ascii?Q?aW/OINzaVVPV6jXU635lOQ6Vepl8OwFM02WR6lYZFGo89/Ps3xvmyp5GPi3D?=
 =?us-ascii?Q?4gBGs0I9jeOaBO9218IRMhN+9+bIYYKAagNgX2k7YV+txlk0X2Itzeii0CL+?=
 =?us-ascii?Q?QBFktN+oFlxIs/5NlQWNlkocCE5SnA6aTlKT6O7TnIpy0wd1nONRW9YMHlOQ?=
 =?us-ascii?Q?JO8Fu77F011EpGsWGv2AoRnHjttdgirNq6+/XRuXtoaZ2whI5cbCEtIy5ruw?=
 =?us-ascii?Q?sBOCy7ALFJy9W9f1f2yviliiAWxorcoqzPENLLT7fwx6c5Ra9NSAXUco4+1n?=
 =?us-ascii?Q?cACw8pS6D5YimvnqDXtXajVIbpqNZB70evsk1GjhNROKF5OSRN9vsDWaOJun?=
 =?us-ascii?Q?1FTBupDR4hX7mR0C2yzSq30KcrAGbPKceDPq2VofG9Fl0NTNMMeybeersIzw?=
 =?us-ascii?Q?s+bl+gkc2/w3gQ5uerm3M9YYjIbip2MXKen7WUjFjwesZMtmoAhoQENwv8hx?=
 =?us-ascii?Q?v/DY+5hT3G+q0NUpmmofcl1VXp5uir1HaCtYnNZY/c4vrnzpWpJbOpGwWx07?=
 =?us-ascii?Q?izkcXXIZ2CabxQ4O4BjzEkhIvgJOloQv/W5VWo+DDekxd9UzeTmGftcCl/AF?=
 =?us-ascii?Q?KUgKU8V9lOY/YNk5Snmph6bgTmfXg/LTK6g7XtITjLGJcAbW/T/5lSJURVuM?=
 =?us-ascii?Q?IKnt3yJEwNTUUM1BKgH/U1RFVokyAfAXf1dSL6TulAaZCgQr7dvLJxA2myuA?=
 =?us-ascii?Q?HCRsBlaXIvbuAdH4dqM/Na12/39zKjdGeb+Hzqk1kKoGMBubu/Zn004gKEDI?=
 =?us-ascii?Q?qDjuexJ01PFft/j95h3lmrrPm/8w52p+l536wEiLak7wrpNeZHUzOUAkamnu?=
 =?us-ascii?Q?lhOhvlCBfdnoRBJO2oSCc/lGVfOUl4m1r5mYaDZPOY5ZBVOtu4/FZjZGjvF9?=
 =?us-ascii?Q?7ANpsaVUoMPpTRn7xZ84UOBnQbaSdoYoAmGHZYa9b2lkyTtrI/VtYbUKvRj0?=
 =?us-ascii?Q?1i17iKBHlA4k4Lbb2oE9EzkCz2KKPfIBMV2qKNvavcX+dFex6om8vKn52/AX?=
 =?us-ascii?Q?kxVhdZ+QVec2/DJu2vq+iC0kSrhou1FDjg/Twi2jtCljH9rJX+4u3RcIrtNy?=
 =?us-ascii?Q?MRYavJqXEdeoCRDtNFcwN/wNV1V6EEJ7STj2f8dSRMYsi7ptoJMl9lvwrQ5/?=
 =?us-ascii?Q?Ld18tCGXHQxSMp8VRTK22nuDivuO4jNDDUJSr3ykwxdQR/eZ0oTIQ8hOZb/U?=
 =?us-ascii?Q?8bknDvGpD7V5os+T3kXmGKXH9Etw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:52:06.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9232604-26f8-4a9d-db20-08dc709c2de9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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

Check the amdgpu_hive_info *hive that maybe is NULL.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 37820dd03cab..5a648a657dc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1362,6 +1362,9 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 	uint8_t dst_num_links = node_info.num_links;
 
 	hive = amdgpu_get_xgmi_hive(psp->adev);
+	if (WARN_ON(!hive))
+		return;
+
 	list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head) {
 		struct psp_xgmi_topology_info *mirror_top_info;
 		int j;
-- 
2.25.1

