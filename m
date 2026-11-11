Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A78606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V+4r8qln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F2710F8A4;
	Wed, 11 Nov 2026 01:40:38 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904AB10F8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFpD8IgoEEM41+Jeqk0AmSyxwwqDnbOdoERNPUhY6dkDP7C17indXXCCYLTs2hwns6hRgVxF9gY98TAA3lskjWMrMBrMtZRtrRz8MNAb9Zjmk8g/sKDKzsubnHDCVgWuLdweqNpsmRG4U/OyzB1qSbY9Ft2Ls5Amv3GnO/uJ9+KZTMkzZrDomjE8N/5cFpfJaIsKBdo0UaNkDQO8XKV6/dZK0h5cbSZeJggflnMWxrzUSx1TCUhpxRfd1Ly1Ynt/vzNQamXaAOtL0rGiAUNtKAIYMr18SRmUkrncAUHw3PwH0Y76+D6g3afy95h2HME4ZWwVwybPLlsR2Mc0jgf29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbAkvnyIK6lHDxQyHOP0nQ7XJTJWQtVpHQ4fdjX5030=;
 b=sJHlfccTx+NqDYI9D92OyygOrkNjhWp5L2FEZTiaV8gvbOyx+oQdSerI9eF74gTcw/GUuzQeifSpIXzCwdTp7kK6yvEQBOjYIlviT6YkIDtr3EWMMISJ8P/9iEeYxpBW4tYLR2wVgCGpeqwJ2CltC0uRofuhxGfWohrMiq4wOUBJH5z6Cn9X1uEjPiLV7+JJZiLZDD+0GsfZs5Odfiof+izkVW1MHNExYeeQCCwHLOhP/ypiZb4GnkWIatQLhEU2PsnrCjlwdot9tIRvqxVgL0mcFS6ey1FAvG9INPUFwAwVwLXJOArx9a7yOBpqZG/irJrWQxgnamR3LSMaoxmsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbAkvnyIK6lHDxQyHOP0nQ7XJTJWQtVpHQ4fdjX5030=;
 b=V+4r8qlnEoNiD0kz/an1GQKB2DJjeke44xvs67kfJLRPdLIa1kRAN1zIJheZeUad07ETQNQ1zJuPNWjNDM+MSeneOo28OGtmvcZk9VzWcBiDXqJFF8q46Hlqvf5/ufG9fBO8g2cL8tm76EfLTjGd4QMQHEMDEHOTzsOZMc6HVJE=
Received: from BN9PR03CA0855.namprd03.prod.outlook.com (2603:10b6:408:13d::20)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:40:27 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::9d) by BN9PR03CA0855.outlook.office365.com
 (2603:10b6:408:13d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:40:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:25 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:25 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:22 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 02/74] drm/amd/display: Correct the forced YCbCr420 comment
Date: Wed, 11 Nov 2026 09:28:08 +0800
Message-ID: <20261111014100.3596072-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: a54fe101-49ae-497c-4a93-08df3f94c28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|261026121527099003|5023799004|11063799006|261021121427099003|56012099006|261022105027099003|261026140227099003|261028144727099003|261009223027099003|261021123027099003|261022075727099003|261102123227099003|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: oGV6yDVjUh+6f44y6v1B/AM6UERXqVy3ANPciQEMFOL6n1QyFpzu7BElfFsLr81SIRZDd4RTtdgLTxmRuhDp6FY5R4t2WtSHgBoxJnlKNWjlFNNCnampDRcgZ/dCi5bRwzgIVz2x4oZmm4rpWC3EmVrp8qRZd8a4Z3bezCoufEJR3It8F9Dm/QYBiIR3OPnBTb+VLfp4D7ZuG92IttCWKwgAilIyOhHUVCzQGLGeRsP/VNWCvphbQm7AbSwAC2h6eEPm2+Fty/bL17c+2Q5QfUm3wuo4IriVXAoiOmWtcPcWeQ9EtsdI6ABx4Hg2E0sbV7lOBEhV2/VZW2+Y9fkRAWwX+gTmzcJL/j/zaBLC9HD9s++tFDrqS26Uq+qHElrmIUrCsU2LQ3zFBiVY4UnmE032FXi/dUQsCFk5ewPKZNwdOlBtxhKVBX2H6r6kc155/hFPhaJJj9ObBSMjuXLJ1qn9b4SOl7lf4EJkBaeWwoNP9McddjzouHP5ZmtXpy6aLjQh5I5RYGd/qFAXHaS2xbSjzrfQsJ1l818twq/k3XnzefeINqtvmdbdsrea+5K2LXYA3oJVrpl0YnJUr/0NlZV2D5nknXO0kKuIbv9rmrB/BGiXRJQJADZT0ZvDy1KdqZxLwhf08dbW5wOD2miMzhPXqVWSCcTi3cJ+/GdgjDrJcLPs14jzEFWk6ga7IAl8lFG1s6SuniriYs+y7RhJnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(261026121527099003)(5023799004)(11063799006)(261021121427099003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261022075727099003)(261102123227099003)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /YCWLYxOMqeOA7CpLuYKxlnSCCdYdsOd6ozZLkCkB3q/hA3/c0bZPERC+Wre6rbIs4UKpYbSo7WZj8vvK5FkpbXKUL8DxFAAr87hOUatyHwDzjO6HgoVU6i50xYQKS08sPVIfYEunnGpD9HJJtgiDHjEuYLVkM+x9U5TYBZgHIlRWDjRrrso62A5DDlxdUrKT1kgOovLBuXR8AYjW6o/ZBmzT3b3CVNCrysx/yK37EjQJJSw2tfWP8dCSEint7E7CIgiWOXgej32nlVnLtSL0+++aRj3AqoBGa1kg+RFttEM1LQzNzB3IheVtxnMTa/WxspbSxPsrkjL/LV1oqsNSAnTLlbqcXXt/JX7ubTFXN+mgUprmteNJCftwutck3dJnD2ppBNs6ezwPuAAGsPwYylShdYIBSr43cHTpSGevKwjTNBEpqwdwQOucyXUhlDm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:26.1311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a54fe101-49ae-497c-4a93-08df3f94c28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why]
The comment said an explicit YCbCr420 force is honoured on modes that
only advertise RGB or 4:4:4. The check below does not do that. A forced
YCbCr420 is admitted only when the mode is 4:2:0-only or 4:2:0-also.
HDMI 2.0/CTA-861 do not permit 4:2:0 on any other VIC (HF1-31, HF1-32,
HF1-51).

[How]
Correct the YCbCr420 sentences in the comment so they match that
check. Encoding selection is unchanged. The RGB-force sentence is
left as it was.

Cc: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index e8f050feb6e3..430b2667bcb5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2426,14 +2426,14 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 	 *  - A 420-only mode collapses the mask to YCbCr420 alone.
 	 *  - The debugfs force_yuv_pixel_format override pins the encoding to a
 	 *    single dc_pixel_encoding when set (PIXEL_ENCODING_UNDEFINED means
-	 *    "no override"). An explicit YCbCr420 force is honoured even on
-	 *    modes the sink only lists as RGB/4:4:4 capable
-	 *    (drm_mode_is_420_also() clear), as required for HDMI compliance
-	 *    testing; dc_validate_stream() still rejects anything the link
-	 *    genuinely cannot carry. The YCbCr422/YCbCr444 forces stay gated on
-	 *    the sink's advertised caps. An RGB force pins to RGB alone and is
-	 *    always honoured, since RGB is the mandatory baseline every sink
-	 *    (DP or HDMI) supports.
+	 *    "no override"). A YCbCr420 force is gated on the mode actually
+	 *    advertising 4:2:0 (drm_mode_is_420_only()/drm_mode_is_420_also());
+	 *    HDMI 2.0/CTA-861 only permit 4:2:0 on those VICs, so forcing it on
+	 *    an RGB/4:4:4-only mode would violate the "Y420 Not Allowed"
+	 *    compliance requirement (HF1-31/HF1-32). The YCbCr422/YCbCr444
+	 *    forces stay gated on the sink's advertised caps. An RGB force pins
+	 *    to RGB alone and is always honoured, since RGB is the mandatory
+	 *    baseline every sink (DP or HDMI) supports.
 	 */
 	want_420 = (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420) ||
 		(drm_state && drm_state->color_format == DRM_CONNECTOR_COLOR_FORMAT_YCBCR420);
-- 
2.43.0

