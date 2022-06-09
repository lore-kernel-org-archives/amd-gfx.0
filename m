Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88747C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 14:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007F512A926;
	Thu,  9 Jun 2022 14:27:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05FF112A928
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 14:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6OCwvRHqpvLpQ4Y2opeSAUSMPbUSABrq/kfKvjS1qGaTZA/k3k2whj4Dvt3mYFkv0VYHJEJnFkI9NBdU8Rm5lVDd75DZQAuNFJNgLgW9Pv+49fvkJv6Sqv/pjho8aB+LV2qdj4xzU6u9eM4bxntUc3TEGV5oYLkuvbe+yzWyZ62AHg0P0YF+5gaDxEgjW7/r5S16AVgnaMYk2oF+d549RFZjtVgU0OonXRkHgF3faloXy/UzUI+NeAQCNWijvKw7HBmJr6pX5PQzJIfuGpIFVREGRjbCJg7Ma4N5Ri0wL1puKY0GXsy0B1LYadrXcRHZR5A9eJ9hAGd+dfOWU8JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uphLzzzDNjauh8aPUeT78WgobVUd4nVUczVRPUwaRbY=;
 b=cKaI0PAcnaCb/loxwyAG5KToRJhwuz9GydwCKQ2GcT8DWBowATkVZ9oJ9SVf/8bdZcRKTvyqnJyy8n3LV3FIkW6J2JxRgE2XZO/YAPlEboNneQeKW1iSCS5TH2V+s1GEJXotQ3PSd6vr1q/NeF13MLNkqykoOqlF9D/vUcZ0K2xSjPPHbFVvboQzQNFRYO/0q0NhJpqldxzC8ypY9YtNSngsZDfNZ/kDbkwqdLlyA0mJ7y0WICN78Hn4IhMfyhoezRDMQ0UDB4By1kbHtYR7t9QwLmEIAXwYN5kirU0RGl78nzVglpt6BnUxHVccQV2RnKJwjWCQOKf5u9POa6F4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uphLzzzDNjauh8aPUeT78WgobVUd4nVUczVRPUwaRbY=;
 b=3ajEzwsDFhL1c3dMx5e/2MzCu0Zhqze+KBa4AHYeWTQV/zb2L7PrYbUtF/8fHWVASvbNvI9k6u75QYtaFosB+XMqd42kHZCLQksvHXqHO/0SCx9LDP12aSJQN6Rs5q0LFzfyZkweYvgQZW1wn5xQULQe9b1h9UmmlPWwjHVm6Hk=
Received: from BN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:408:ee::8)
 by BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Thu, 9 Jun
 2022 14:27:27 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::68) by BN0PR04CA0003.outlook.office365.com
 (2603:10b6:408:ee::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Thu, 9 Jun 2022 14:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 14:27:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 09:27:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 09:27:26 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 9 Jun 2022 09:27:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <marek.olsak@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: ignore modifiers when checking for format
 support
Date: Thu, 9 Jun 2022 10:27:25 -0400
Message-ID: <20220609142725.28973-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67af4412-7e71-42b4-e661-08da4a242dbc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3336:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3336FB5FF7CEF99E09AAF2D58BA79@BYAPR12MB3336.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/Exogn8oJUP2O9p0tpWPNfVx9GU7cVGNWdZU4KnwajsKaGzxw7m7Tg30ViX4XCl7m8taQA9U4+tLvbAE5ie3ELMVff1Pzd2qrlDge4y880MboG+/mNnlyog1+9xsLqrrsS8pGAzt73bTRE+lNtNyD1Pga3DJVc/U4LbuAYgNA4spJ0ZlLbu7f3YSOO7eJSkzQnrphNgrXiXNhDo7hdYlKMLRmmy52gvf2feg4ZtT0eDO1DyMpOmY/a19tamOWRXY7uPiupAVg5qYKSymf5H/3UvQbRqFk7ha6iS0kfUb1v/HrxAjWqv0oi5JyKPCI3eYR3tRcQ0ZRY5+8eh8KwjhUoRosy0Kv2Dwg/V3W3vyIIoFZMCBtba/ZMpbRcTUCdsrlKRhcrNRASJc4tmZ/1KZpqC2LhFwyGuIdCcAfe0iFjA8hphITTHZX4V2H8X1KXV6v4fWqTrhCIAcd+MpqpQsc9avUAsp4Z4O25f7vPamonO2m8QlunP7riL/rTpSAyXVBvvYl2M1xyxvNc/dQUUz03esJumuH5kIn9zukklBTljM9DgFWUcJ/AoeYeVboNOyb5ezwRoNfxBVwwvitQs4HBrZRfveWnSy/jaAbBvhxJVbT5VZnPoFu8VmN89jRiBWPXmdChBcF7aEWSr9AeHq6e+uRMgtxR4RWlrKcnoPnC8xoEoAMBDv1aW3zW0tIzS8Jhvkw3gSTKU1NGpB5N5Vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(7696005)(54906003)(110136005)(316002)(36860700001)(82310400005)(8676002)(4326008)(2906002)(70586007)(70206006)(86362001)(186003)(40460700003)(36756003)(81166007)(83380400001)(336012)(26005)(2616005)(5660300002)(44832011)(426003)(1076003)(47076005)(356005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:27:27.2354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67af4412-7e71-42b4-e661-08da4a242dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3336
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, roman.li@amd.com,
 ken.qiao@amd.com, aurabindo.pillai@amd.com, alexander.deucher@amd.com,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
There are cases where swizzle modes are set but modifiers arent. For
such a userspace, we need not check modifiers while checking
compatibilty in the drm hook for checking plane format.

Ignore checking modifiers but check the DCN generation for the
supported swizzle mode.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2023baf41b7e..1322df491736 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
+	struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
 	int i;
 
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
@@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		return true;
 	}
 
-	/* Check that the modifier is on the list of the plane's supported modifiers. */
-	for (i = 0; i < plane->modifier_count; i++) {
-		if (modifier == plane->modifiers[i])
+	/* check if swizzle mode is supported by this version of DCN */
+	switch (asic_id.chip_family) {
+		case FAMILY_SI:
+		case FAMILY_CI:
+		case FAMILY_KV:
+		case FAMILY_CZ:
+		case FAMILY_VI:
+			/* AI and earlier asics does not have modifier support */
+			return false;
+			break;
+		case FAMILY_AI:
+		case FAMILY_RV:
+		case FAMILY_NV:
+		case FAMILY_VGH:
+		case FAMILY_YELLOW_CARP:
+		case AMDGPU_FAMILY_GC_10_3_6:
+		case AMDGPU_FAMILY_GC_10_3_7:
+			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
+				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D:
+					return true;
+					break;
+				default:
+					return false;
+					break;
+			}
+			break;
+		case AMDGPU_FAMILY_GC_11_0_0:
+			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
+				case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
+				case AMD_FMT_MOD_TILE_GFX9_64K_D:
+					return true;
+					break;
+				default:
+					return false;
+					break;
+			}
+			break;
+		default:
+			ASSERT(0); /* Unknown asic */
 			break;
 	}
-	if (i == plane->modifier_count)
-		return false;
 
 	/*
 	 * For D swizzle the canonical modifier depends on the bpp, so check
-- 
2.36.1

