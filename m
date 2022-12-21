Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E105C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Dec 2022 18:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D870689D39;
	Wed, 21 Dec 2022 18:44:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230C589D39
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 18:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPoMDlUl2S+nPMe5HdYruTjsxIJbs+geUw+J58upWYUzOiJ7Tl2IKbXxs24vqUgl1NkKncdwEyvIzGVgfIvpTKHOR6+tYHiTt9VY3iTzixaDHvbP9EYUQejNzYq93o3ZKFbpjvcH8DTTKtQTDQHXi/ZrYRUCwFqCTsMqjdClcXniFKlWa/P6ieYP/APmPegFlaMc8PEtcfevizxwunOU3qtsSkk9gu7f0/ZcWe6hxwPzchKFT9Uf9eOQmff1Z22jjwTJdYk9d3ZBek/SeE+WE9MB5vtoGKuR+t+CDhMEzGu78/pVH2/4OHYa0hQeujky1xNglNcB19WNolZZXVOZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r33cVV5VEdXLB/NkUK75WmCdWXj+VKxPY/Eply56e0=;
 b=iyFW/U5MFIsKttS4vfWcq0Z5UOUJ9LuPRkT/+5sOjiWhUKHgEtdpe/+E58hjOacr2jtARLEiNKHQADHzVSYb1ENSd1XCRxNLqKnSmZauGTJlIoRc0faeNam9hZpZq6d7IMCNK+INBC/sZ/dJJCWYM7vBjH47+5dQ3WQasMEEsRZA/+edXebWmC2Z/D6w6ADqRX4DqhNXxF1vwlbmYMUI+SRRstajq7bNLNfIHkSidBwjIpTy2doPU8ULSJU69ppgERJkoZB0uOrMdz3716WpF5nMBnR8tK5S+J3R/ax/cCnsvMQF0Rat765fMOJQls5Zp4wzo2vmxcdxikYNYGBOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r33cVV5VEdXLB/NkUK75WmCdWXj+VKxPY/Eply56e0=;
 b=p6CCXljt6/BxU/ePyhUquGtvF47wJIk/4o5HzSFgesk+T+eRhzjLKW4SLnli/9F2gz093R1/C6d9b+dq8Ilhj+At7CkJtRYeIH7MrkFFiEKYPUiNWJ7KqhS+e5+4dw1Q1wECVN+WbLVVif8o+ERAAiU6cWC/W1Kj2Zjuc7lTgCo=
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 18:44:03 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::8b) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 18:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 18:44:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 12:44:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 12:44:02 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 21 Dec 2022 12:44:02 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <praful.swarnakar@amd.com>, <hersenxs.wu@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix dsc mismatch of acquire and validationn
 of dsc engine
Date: Wed, 21 Dec 2022 13:43:59 -0500
Message-ID: <20221221184359.546013-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 81aa0fde-dff5-4a5f-0e20-08dae38354e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6V9M60+U1XE2OdizEPOfdFu58S/YEZJmGThj2R267u99Ldg2MOPXmn7T7WwsiP7hBltrM+jOrdovyjlUT/QtdKWNQDAmE9+RJG8GwRbU6nUzn6To6T9xmnP4pERGi/24W5Qx799/eo3d4lk7Gw6tVp1CzS5I3xLeecx5FbDv8r75km+SSFSLe8DMHx+sP80fL4DH+Wu6l2xAN9dSuLKtBLYj+0uHogscwnEhlHLEpQYaD6Zrg55rFqmgZfAgfOxD116oXiDhXKPnwMGDFOGlvbX9qxWQJbc/zaMho2FUE5ypJ2ylU4vTJduoMZ44oqTdhUUdQ4mrtpwq/7OXGbaurE0iCi/qm+8pJzCEbTybFhLknq4l6g9bnaTWUoqPbi0i69FnUPqNRS5CYyiOpxrg+d90bneFk0FU+d11vtshMWqJhLhrnc0BZlwgUosmkGYptOPZfuKW529jQl0D9XvV5Wn+4QH7k9HvuXz3FWeDmmURFHb4tIRiTl4jGLuHRkNgrnEBXoZ/Qu2rN8N2TjfyqiKUpdNGSSLSRV5ZKbMhdVBVEVxz87id/RhqeHOViFm/UveyDR82TnBvYQxK+GiARcoQIs7GpH4Sri9ccd1339eElxO+w5sj1q2mWcyI27qoRTWqPJLP7wEIZgyw3AthoaqBVTHCHOcKOTXozy7Xu+HgzDZ/x/vUUU192+c+ZXHvqf/tT13mhv1W99GcCoX73s6CzbRfR7EboHzztEUPVS8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(336012)(1076003)(8936002)(82740400003)(2616005)(82310400005)(83380400001)(6666004)(36860700001)(26005)(40460700003)(186003)(36756003)(478600001)(47076005)(426003)(4326008)(40480700001)(5660300002)(8676002)(41300700001)(356005)(86362001)(316002)(110136005)(54906003)(81166007)(2906002)(70586007)(6636002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 18:44:03.0134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aa0fde-dff5-4a5f-0e20-08dae38354e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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
Cc: Wenjing Liu <Wenjing.Liu@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
We skip dsc_validation on pipes that are underlays, but in the
acquire_dsc code we don't have this check.

In certain conditions (when underlay pipe index is lower) we will assign
the dsc resource to the underlay pipe and skip the base pipe.

Now during dsc_validation we will skip the underlay pipe (this has the
dsc resource) but try to validate the base pipe(this doesn't have a dsc
resource) due to this mismatch we hit a NULLPTR

[How]
In the acquire_dsc add a check for underlay pipe so we
don't acquire a dsc resource for this pipe. This will match the
acquire/validation conditions.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d0199ec045cb..f97d8ff16e71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1382,6 +1382,9 @@ enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc,
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &dc_ctx->res_ctx.pipe_ctx[i];
 
+		if (pipe_ctx->top_pipe)
+			continue;
+
 		if (pipe_ctx->stream != dc_stream)
 			continue;
 
-- 
2.25.1

