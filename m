Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD41C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662D561183
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 662D561183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061A26EB30;
	Fri, 20 Aug 2021 23:30:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730896EB30
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePj+zT5Av6ZIDKdDCp/jN9m862ifelE59ntxscj/MMTQqx9NZS/4ngqf8MCbwGi4w8tC7WziXl7PQxtxvj2Yqz7pIQVz32pKj+KFTteYreiynE7uSmyHGFz1jD/PqZfkGXxAcWalIDUzDZmE9jA45cYloibpxXHJmph8N0n2jM8UeSp24CTnKXJ5mA0z1rG89xi+d9BoYJJwrn5SDwtf34HZCSoBk32hx9DIIYGmuxCimTc3my14/6NGBNkillggaqe51ewfmsboEPB0jAopWCUjHqJSBrnlNRj1NBy3j4jpc+qcKVpL61/QYdv8Mv6fkR63/Eh9psINVWrs5LuXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cubz+Dz5K9NwzDjQxxxo6dLCyVOTc79aJz9YE+EI+fI=;
 b=OFOTchlVoJgErTgU+LiMrKNiRYCvs91sR/aN9xAxLMLrIG986iPlTtiy3u8X42xw1+s/TJP1BT1TZzTfIQ+9rRCqNeuBSBOWkNi/tmWoijTK8TtHr595Qzc0fFT1K4k/mwC0x3rEYlTXbFBV0ziRlSN5qS2vyts8Df4vckkpCD3xhDR76VQJ4E0NZR0looz9Gn0Jtz8iaCe212kQ/Um1wKTIYN5JmuDbOVrJ5wZcuw4fv1OLcYXNBXqPu0HPQUxX5oiYP5EG6jz6bcN9pYQPDDP4Fht9jJZpkrna7yvVp1aEhw6cnz12UGwrSf6bAw+g2aW026vmfd/99MJpIpjvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cubz+Dz5K9NwzDjQxxxo6dLCyVOTc79aJz9YE+EI+fI=;
 b=XGCIn9p/QiqKnyI0n5adOUdqn57Iv3qADXvRPsFajakRElVkIpQ83Lm1RMQb7L6zZlPfXmICjgnPVq6MY8M1uqjIEd3I+uhs7FBlwOf4GZjB0hCnYq+yDtQh02vD3Zn3JKQtvkGgj1eMG17OIHDM5S4nTGZk7n4qLN65r5N+DKc=
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 23:15:39 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::cc) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:37 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 04/10] drm/amd/display: Use max target bpp override option
Date: Fri, 20 Aug 2021 19:15:14 -0400
Message-ID: <20210820231520.1243509-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
References: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbce4f37-7aac-4a78-49ce-08d964306c78
X-MS-TrafficTypeDiagnostic: MN2PR12MB3854:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3854A4938A6F52F5FDE81C55FBC19@MN2PR12MB3854.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMPVXfIod1yvmhAxFOFU+6XGHPHeY/4sXHeTDM5gV0laAKHUxULWYv9jayL25duTwkpL+8wfMFdUJPJ9dieEh5L3GrhKHiKsh67EmAwIIYDO2v1aRTUfsZ1ddYgiU9/sAA3CIJ3/hPA+0DqYokshgTtD/sbRVJWrsJ6kP+7NSqk4/msZhC1Er3rqRbi4rmaubMIb7HkN4qAWx9ixF2aJO4P/Mi77HgZu1oG8+VL79IYBii1+77I+yuXzVhx5Xwa5X574HLbmgsi2+Ul3mAQhjR0FU0A8tQ9h+JUjNp8wDLG9LYbx/x/cjrtNxm7Q+xUE+aDA/icvHQVOz1IomY4MbbTdj6XCfdso8rgeboAaN6WzU5xZs20ZOgUU4Smuebiw+ktUCutb/IZSXtYTQn1FO/TSQiwPcM6o4pRAFUE8V/4vfl+89wVGpEH/QJ4cAWkW37fli+7Xi9RXiQfJM/znf7li5PQ/TAn0SklgUM04SlDnLJAUJzCnua2cyLMfCa4v9a3EFrCMslfDInnzWvfjhL1x228IK6zGsYDp52pevGxvzjfvgljRl5dby+vh1e1Wf0NyXB4V7Qs3jeLCrGcUHQc7PTD2enmRLvve5XOGDKd1u7XJKVvAGAKzW9zq3eC1FiM4EhqGp16EbvQpbM4D+tyq2NKFNCpk+8dcgljWemWqpuRZVfYGnYE8MsXuKr4WbtYxT53Mh9Wzp3iOSeMEqfbmCC4pTs9m3ZFqy8xDx42+xuh9dO9zY24nj3RyMJwGGJ6dCia70CgtwTOAkHONGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(4326008)(82310400003)(36756003)(6916009)(1076003)(356005)(83380400001)(186003)(8936002)(336012)(81166007)(36860700001)(82740400003)(34020700004)(26005)(5660300002)(2616005)(478600001)(70586007)(70206006)(44832011)(316002)(426003)(47076005)(6666004)(86362001)(16526019)(8676002)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:39.0236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbce4f37-7aac-4a78-49ce-08d964306c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Max target bpp override is an option for working around
DSC issues. It is supported on DC level, but was not
used in DM.

[How]
Use actual option value instead of 0.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 8 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 162a8208f74f..e5ff59e2fc7c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5753,9 +5753,15 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 {
 	struct drm_connector *drm_connector = &aconnector->base;
 	uint32_t link_bandwidth_kbps;
+	uint32_t max_dsc_target_bpp_limit_override = 0;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
+
+	if (stream->link && stream->link->local_sink)
+		max_dsc_target_bpp_limit_override =
+			stream->link->local_sink->edid_caps.panel_patch.max_dsc_target_bpp_limit;
+	
 	/* Set DSC policy according to dsc_clock_en */
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
@@ -5765,7 +5771,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 		if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						dsc_caps,
 						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
-						0,
+						max_dsc_target_bpp_limit_override,
 						link_bandwidth_kbps,
 						&stream->timing,
 						&stream->timing.dsc_cfg)) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1bcba6943fd7..705f2e67edb5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -547,7 +547,7 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 					params[i].sink->ctx->dc->res_pool->dscs[0],
 					&params[i].sink->dsc_caps.dsc_dec_caps,
 					params[i].sink->ctx->dc->debug.dsc_min_slice_height_override,
-					0,
+					params[i].sink->edid_caps.panel_patch.max_dsc_target_bpp_limit,
 					0,
 					params[i].timing,
 					&params[i].timing->dsc_cfg)) {
@@ -579,7 +579,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
 			param.sink->ctx->dc->debug.dsc_min_slice_height_override,
-			0,
+			param.sink->edid_caps.panel_patch.max_dsc_target_bpp_limit,
 			(int) kbps, param.timing, &dsc_config);
 
 	return dsc_config.bits_per_pixel;
-- 
2.25.1

