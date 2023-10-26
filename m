Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDC4C25B72
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBE310E81A;
	Thu, 26 Oct 2023 14:20:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3473A10E818
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKaakCnlz6j5jjrfTjCYx3sVAkx9APPs2YFx0vvhl8Az1WuIYkDeOF3rt6iu9BKSgOqn4lguWPi4NbmBVfOo3fKQ4fzqCgrALROI9AWiMx7QVTaoTLSiW7r8U+lMRGV6s0NxMrmFt0ThmjIKq/LNEHB/2r1k0tJgr7E9wsyCGI/BZHbN/dxl0Qt+xXSLvj+aLpPvk6cULPj+c8FDgXHWo9eO4lN4wSKplnjW5dCc6RMyapbHG8PCTV4ftCTTS/+Vkv/qkeM5WHuMf3Kv2KIic+/+GQ9P8+0od4cyk2woYAosYCUeYaq77ohGcRtF9+nKtl979bkenL4YA3YzJQF08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ALAq+V/0u8ODHGw4qZDPfFUZOKQqNIc71/Zm+XgPno=;
 b=dmcA6J9fyE0aA9v1s91nSTiVi1fDfMEcqJuFTQQUhM44p/vUyw1E7K1WH/3o3+0VSd3FaAZoy/gIauqKgHGVDs6cXlidNssWwUNxfRjtIEh+m1LZUba6r66Nn/S9S97rcJXg5d9EebdZVsoV1d0r7mfp5x3SjSgeyj2z5IxI6vTmLHqK35cY4txyecBiropM9DdW31Rn/XSQgFNVNKGVJuSgxqJENfRBKa5RSVUGqsoZHLHS6MC6bbFSNhQlLOOnFUAzp8eY8q/6u0VbM76CYLBC6jL4mWWGit3KtEqdcfMLB+9nQBiLpCujSxrySU1wzpAwWgICsX1zCp2OrVQYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ALAq+V/0u8ODHGw4qZDPfFUZOKQqNIc71/Zm+XgPno=;
 b=IissL+qIF6A+oiqf9lzeOQ16Jhl+FCv42zl9Xc56MGTBXmQ+Ofl3h7NJahuUW2vMYTlI8bxP+PPQ+7ISy1rN6Z0w/XUCkggO2jY8bnO9k0Z4TGzcAduYrU7/E4Ct0LiD6tbD/UR3YYsR0x+4+xXJOXYl4rknZywalMFXUn+Fknk=
Received: from CH0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:610:cc::11)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:20:45 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::c1) by CH0PR03CA0066.outlook.office365.com
 (2603:10b6:610:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 07:20:40 -0700
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:39 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/25] drm/amd/display: Fix missing blendTF programming
Date: Thu, 26 Oct 2023 10:20:06 -0400
Message-ID: <20231026142020.67861-12-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae5cc83-a3c2-41f2-2cee-08dbd62ebe01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYkU72ECwTCy5jMKmiMPVGuDjuyKs2UhKkOr2AMoU9cVq2KXT4x8wJhzyMxFLXQhfM83J0Exwr4/NR1iQWMLV5vQk09quiqjIhln+WM7mmEhpBi5zkSaL7SawIq5H5bg/s920rjdIy0Qg67Ct1CMr1drG/EdQn77eoNzQ/7zGCjsBoWOlTy36VyJNA5eO5q009V3vf4i6+9NREGOpvaUJ0c9l4sXCtpFGRStG8gSBYUqU34lK9B3gfikOtA/7KAiGSmcKGuu5L20a0HJzrGvspLrM0OL5YJ8WMyXlCDvYWFKCNxKNlctBcCyttISnkRt3PNVHxn0sEhqzcjUUmmsF0VN84hH5/rWrpyoKaISIW+zHBvAfvxgjryWGAu7kkI9C5CJTiLz6i9qkhxQhhZz7mtKcccFlf+0Y8esFrQ+UMSNcg/ATEBYEZ4rJD//oTGFIhDMC+bsL0tOEVaTLOwIoKOdWsm/SPdCj/N3V4EiBIdopknE2MkU0dSL7mKFU2lOj2dKPvTY2099ABVN6y4pP3WzwktlKO/R67zvr2ujZ+McDKhxOe7Pv7gBENZJyCjBHaxRjm4IZOHSvxoIuV8yXxUMm7rgNCEQ3mLQSunCeEUaQ30T7G++9vpFOazzZq97kXki+Fc7TvC6mgXiDH51EAJ73MRCjZLPqTTQqQvobVFZqs6HZ2XQnTn/5qh3NkOOFgCODLybc45bLBvgoKAnRPSNCYsO7R7NhdOC6WgbVTlu5XOt2uh7DopITn4OP/1XBPPBAvJjftVp6Dxwcr7OGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(478600001)(6666004)(2616005)(70206006)(70586007)(1076003)(316002)(54906003)(36756003)(6916009)(86362001)(47076005)(426003)(36860700001)(336012)(26005)(82740400003)(356005)(83380400001)(81166007)(41300700001)(8676002)(8936002)(4326008)(5660300002)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:44.5457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae5cc83-a3c2-41f2-2cee-08dbd62ebe01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
When MPO surface pixel format is not ARGB8888, fast update can miss
programming blendTF.

[How]
Set the gamma_change update flag on blend_tf change.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4360a696f10a..940ceaca8545 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2582,6 +2582,9 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	if (u->gamut_remap_matrix)
 		update_flags->bits.gamut_remap_change = 1;
 
+	if (u->blend_tf)
+		update_flags->bits.gamma_change = 1;
+
 	if (u->gamma) {
 		enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_BEGIN;
 
-- 
2.25.1

