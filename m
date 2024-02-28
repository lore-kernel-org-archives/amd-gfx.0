Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E9BC54E41
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 21:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F324C10E241;
	Wed, 28 Feb 2024 21:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4oU8/5e";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35C110E241
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 21:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhqO5azDO3BQ1OXOveJdNZE61rCmyz/6rBSrKP8ZhuoS7vmyyJhp0aHN8e7sCZ55/PBj4UQ2/fAC9Og3USaNyZOH+OQ6OXWnHaKm13owI/KcA9SuaZRX5jOnlv69EfLfwuV1+vJJ6z3nDOGNY/XDwbU2IKgrpukClul7IiVZdmd+YkQI5ZWPd3FG7OLpVGiz3hPHT7WflRXSeM1foSfDCD/24ly3n1CCRKDpwi9gO3npuQ2zD5vLd974OCmbiNQqKwZ+V8M+caXq/0LTqidwewRfR1/YbOvfCZX5015ZzDp386nl/rc9VHgh/A53dySxYu2wEqgJtx+V2HS5hawYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm9KvowP4Md0gDWF8BIu67scOvPpkCcs71iK019xsXo=;
 b=GHcBx3bmXhd2eA77PucOGTxHV/se1Z24LA06yiEOqODLNlIB+kMNuZ0Pp1BBwP8h2GI67uYTPT6wKv5aKY1ZbZ4NNQko9ftvObRoFsUrl4VAy8wuyxRjRqyVdzKNN9KtN4FBZ9WBW/5f90xT2jQqbBroCp1tIF2gucAlWkGUS8z9rfTJ2brDbXo+kHN2fHu2aSKfyV4jSIUgl1Se9MCBXe0T9xSqELC+z3krB4JFJfOuXWZUiFsbb8QLN1pjdNVDwNqj9M6WbrDEReznj+eD1Sq9jRLMbvqCfDKjk6eIGz9VOEzp1b+Mwt5DVJ7jxVSIAzGivwiypSUCjw8uOtNCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm9KvowP4Md0gDWF8BIu67scOvPpkCcs71iK019xsXo=;
 b=O4oU8/5eB2wL1IFNkC1T4w96Pe85HJBSeryOwo8R3LtBAveev/dUYtTrBH3gUZktqNwbxEzlBrOGYPqoq2l6yLrL2XJZ4waj8JykgmZCpCXegaqyz5yKlrQ+SpvAW8+mD20zZ8Vyfj9Wj9wRDIccV3zr87mpdIS2Om1hj6KFezo=
Received: from SA9PR13CA0147.namprd13.prod.outlook.com (2603:10b6:806:27::32)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 21:12:12 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::99) by SA9PR13CA0147.outlook.office365.com
 (2603:10b6:806:27::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12 via Frontend
 Transport; Wed, 28 Feb 2024 21:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 21:12:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 15:12:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: handle range offsets in VRR ranges
Date: Wed, 28 Feb 2024 16:11:54 -0500
Message-ID: <20240228211154.3498505-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 126d4e9a-21af-4015-daf4-08dc38a1ee97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCsGDOeVsCdQ3OdjgvImHv/v+mlBMXtpBtUUqvkBl7pA1gu77++RrcvJvthrce/3nsVBDvUy1yMM24IJ5RFvfvayV8//1qhDRNBbDKD+70pObrG0fMIt42POrXK0Za8O1J87nRWjf2g5lSULudhXSxbw97KN2Axv85gmaAx7z9jCA3dQp2+a/Zd01kE598LiXBMwuWV+5lUDSxDtv3QKJ0LJHqfwTtOjfpBjKdNfy5m6hoJ9Zfl9iMRkkQzNxCmNuhcK0xfmFELygGMPke9b5BmJZNxd57bfkkOimYVc+nsYMWcE+QGYHdi8vlePI6RXLF3LeYnpV4eYwsrJVAf2m+igmfX5H/qauiSYMYZQ/gmN415cpPH4WXta8lPvwii1XGW4SiGigQS0UcJWt3bYA3zeaKal5WfQUhsrZJZrheXstjdo4fatLNzYn8ZKK+Xeuh5Uv5HEaJGlcR2ceSfGUqht2MvoaPIZN8ZCk1qLiLffaRBd8H2n/grup2Kr/pLWjciP+vi4pdH+UKkdP1aUhJn7Qj/VGu/FDMm8xM3gn2GVCmsvgp4CSjeKpVxSsbrsgWVqbiOAfNy2UaAEDeR8fEzYcwvdmra4f2/CYs9Y316bKsx9RqrGVoHfSFr6SSxadwEuzuKof4Od448otwJ14Rs7Hrc3xLKnJmT60qYODj1l02PfAVdGXTNyPGUDboUv0x6PQrpaYCZ7VI6DtmiAGvJzE4bdV5T7cXdTEi5kfmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:12:12.2962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126d4e9a-21af-4015-daf4-08dc38a1ee97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
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

Need to check the offset bits for values greater than 255.

v2: also update amdgpu_dm_connector values.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3203
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 32efce81a5a74..4e4cbf2e33dd2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11292,14 +11292,23 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				if (range->flags != 1)
 					continue;
 
-				amdgpu_dm_connector->min_vfreq = range->min_vfreq;
-				amdgpu_dm_connector->max_vfreq = range->max_vfreq;
-				amdgpu_dm_connector->pixel_clock_mhz =
-					range->pixel_clock_mhz * 10;
-
 				connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
 				connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
 
+				if (edid->revision >= 4) {
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MIN_VFREQ)
+						connector->display_info.monitor_range.min_vfreq += 255;
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MAX_VFREQ)
+						connector->display_info.monitor_range.max_vfreq += 255;
+				}
+
+				amdgpu_dm_connector->min_vfreq =
+					connector->display_info.monitor_range.min_vfreq;
+				amdgpu_dm_connector->max_vfreq =
+					connector->display_info.monitor_range.max_vfreq;
+				amdgpu_dm_connector->pixel_clock_mhz =
+					range->pixel_clock_mhz * 10;
+
 				break;
 			}
 
-- 
2.44.0

