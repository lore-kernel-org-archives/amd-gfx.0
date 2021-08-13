Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEDC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F8B60F57
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6F8B60F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B45F6E4C9;
	Fri, 13 Aug 2021 06:16:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F006E4C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcFOX44nRCG+uw7jcQHPwJtDden5N8gmDJjiTPGZNd/a7HcmXXtq9Kvv1PQAtqWo9VkBFxjk8YJGEwSYsrXfLyNxUNE6F6UC6zfrtwR/ZsZbI5R14VvteNAIdTyI+jocHrf1yWsyrnUWSu4G2HFfAYGrX+rB6P0czOLz2yXuVCLzeSL7zMG8EOto64djVACN+b8sQ6bLm/mYkEmuUhYMw1TsIQaKDcjypxfbekTsDJIEEClMd2n5oV4dbJxa6s/iieg7HBD94gEppmQtBjleU5cA8gdd0GW4C7zYyLwKUk6GpjBJkYsBb4ed5GE45F0QbH+I3GZ3EUmbe0+X/aoQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygo6P3mh2mEI7syFe2kpvoJyLUXN/PNCa+uY/aaKmPI=;
 b=WX0aYlu1rfmL0slTxfQkXIoAh/Yf3Y2xtIMvSG9gqUGMnHxdFThJWtYDz1MOpqllGmUsVBI1mz5S23IIKSvyfd16xPje5CdrW1K/UKLW/ebAf868P3HgQBGATru2SN7QBXK8sKY+qtNJoiCyx4cnD7aLBqABWFcHkMXcAGSn0Mh4NPbHkUVnL5pVmfHISMrpi5Lpn3kfFsOxRIOPIwnJQdTOp1hvWvHq+JiQuNqfFgAydReGhCmf5zr+U4XKRgu2f9AA8QO3mitEYRCEPZnOnwYtHmj8iSDXHNW7DQMWtw8Df1WRSYZbCW18hPHf03YqPgvUXWKHTNx/elRCxa40rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygo6P3mh2mEI7syFe2kpvoJyLUXN/PNCa+uY/aaKmPI=;
 b=JaioZJjcdU+exfpu4bNGYnqbyeh+kUUXYRofWGbjcIAlIoHq1IUxK8lFJb+6CcRE2ZRq/AgNOVvNCVKI15pmYLqk3/VLoJiJ1ABz2mHpke3lsaiHfjaXMd60AXKrEeNBcwEd6StnFz6L5dIDM8wiGZ7hdfXF5QY8OPcAV1C8tJ8=
Received: from BN9PR03CA0635.namprd03.prod.outlook.com (2603:10b6:408:13b::10)
 by BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 06:16:07 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::4e) by BN9PR03CA0635.outlook.office365.com
 (2603:10b6:408:13b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Fri, 13 Aug 2021 06:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 06:16:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:16:05 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:15:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH 1/7] drm/amd/display: Create dc_sink when EDID fail
Date: Fri, 13 Aug 2021 14:15:44 +0800
Message-ID: <20210813061550.3104690-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813061550.3104690-1-Wayne.Lin@amd.com>
References: <20210813061550.3104690-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f94ba62e-8455-48fe-a1c3-08d95e21d619
X-MS-TrafficTypeDiagnostic: BN6PR12MB1459:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1459ED53D6A6197375976B7AFCFA9@BN6PR12MB1459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtnY0OAOFRTFb6NK6hmjqwWs60zqivCYsbbyG0H8qAf/2wQbDKno9JvBwmpZLPQIyw3d8mqH/d0+Dyc9diwLxQIPxpQzCucdL3R1uAIrd1N/61fGA0hyM2UYSF3ynqBFICTk/sEJ09u7VdCtnOeGnlUYgEjpmh0STOSMdHmDPZru4S5mkD5/oG4HarcQdPrQnGz/Y1CH9sKMtzFa9Hjks/WIJNL18OLE4jb0axwsTbLOzYrnEBnqoeIybssaEPHORUfy3KbPCeTZyOYhAk+s/Ee6q7yLI8Y7Zwx/ayqg3GxRDQ1wG/Ggk7s98uqeYD41y+hXL3JJbJXRAuRI/LQrOYrd47C7DKIZxJJ4448dNDBDT0QeoF5xYf/BzuThxETbUtG2yKXPnEgeeW3qu+cmAx2/fqUUXIWfhwL9UawADG7+CTPphHCF54mAUxKLD9UA7nWYVZagD3MIO8Uu0xp1b8sowZNcJxKGABXpeCdfB4HZEalg4qvQYH6tuLnPnzG8TZySolJzTXxAKvidb5T1f+fDBJs61NniPgEvFuupppx9LBGF23V9FrAp2THGX85YwENId2jIQogNtzdo2O/Oz4X26Ct/frFSg0vdHVf0BKB4b20NdiK5o942jYVVJlQYkObxq/pzc0CXA8kp+fAhALtkQXQikYB6X0LTl/OJCHFlPi7rFbv4lHsF3xS3KhE34FaAj/YxR3StC7ywEJFHm0L6kGB9ZVuR/JrCy/MyKV8JcwjEEkrvbzvysgh8cMqm0K3nbkT2IqTOxz91kjXSDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(2906002)(70206006)(82310400003)(6916009)(34020700004)(54906003)(81166007)(6666004)(26005)(36756003)(70586007)(1076003)(5660300002)(4326008)(356005)(478600001)(83380400001)(82740400003)(7696005)(2616005)(36860700001)(426003)(8676002)(336012)(186003)(47076005)(86362001)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:16:06.8151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94ba62e-8455-48fe-a1c3-08d95e21d619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1459
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
While reading remote EDID via Startech 1-to-4 hub, occasionally we
won't get response in time and won't light up corresponding monitor.

Ideally, we can still add generic modes for userspace to choose to try
to light up the monitor and which is done in
drm_helper_probe_single_connector_modes(). So the main problem here is
that we fail .mode_valid since we don't create remote dc_sink for this
case.

[How]
Also add default dc_sink if we can't get the EDID.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5568d4e518e6..1bcba6943fd7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -213,6 +213,29 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			drm_connector_update_edid_property(
 				&aconnector->base,
 				NULL);
+
+			DRM_DEBUG_KMS("Can't get EDID of %s. Add default remote sink.", connector->name);
+			if (!aconnector->dc_sink) {
+				struct dc_sink *dc_sink;
+				struct dc_sink_init_data init_params = {
+					.link = aconnector->dc_link,
+					.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
+
+				dc_sink = dc_link_add_remote_sink(
+					aconnector->dc_link,
+					NULL,
+					0,
+					&init_params);
+
+				if (!dc_sink) {
+					DRM_ERROR("Unable to add a remote sink\n");
+					return 0;
+				}
+
+				dc_sink->priv = aconnector;
+				aconnector->dc_sink = dc_sink;
+			}
+
 			return ret;
 		}
 
-- 
2.25.1

