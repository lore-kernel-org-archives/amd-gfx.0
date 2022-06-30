Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA699C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C32B711A19A;
	Thu, 30 Jun 2022 19:13:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3797210EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCYvhph5YTRKde00fn7Ahyza5VCYMT/hj5cA6s2e8b8qmJbKyoOyZSlLqlOkuRtf6kOA9mB4sQ+44qDdc7oa2inK6lPAtiFRvgxCO8BBXWa4o2/1Dsk9xxDBoOgqECaP0rbHVQyC8SrKip+iHZnLSP1LZcQrjri5W5IclXPR6c2FEIVygB5OFPw009vKMdaGtixqx2G8Wduc7MxXSoF7BVH1Agbht7QK5+twGKQxlE3ZlaURJKZ00OVpTFdDs77e9tAXCkORLzT29S0DnE0F97gVXOiDQA18GMD8Dkovzw4ZHE5uYPjMhWgLnF/b9AVgas9uBca41lNnNILVQ/XKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1OXl1cuC3kMl4bo+m0PMsaZliYYjR1KCPHlyrOdTi0=;
 b=fihWEv/OKOWSlPRixgD3Ny5aBslerURnwxCVQKM51Dl8jPiFPO/fegPfigNN1U5YNu71EU9lWiASJ3JChtttDn3/nIubLbGQLbGl7Fl3pO6TO8RQQsVFkXMLB9kDKxRMZCfBEMuSV8MzgPsJ+W7cZOC0sQuaF5DVw4pNxRucok18wQGEa3JlZkkbK86+0FByGX+ebi7ZFhIlcZQsFjxYrpV3ncLsy5xbsKfYiPr3L8q/eNHtazMqjdaeMxIU0V479kg7YoFdlR9sJVpRESZIjHutVtnSVKMQ48Y3W7eRaqUpeqxy8/a2zCNgVhewNZR+8XNh3J6W4Z7sCpdHHlZgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1OXl1cuC3kMl4bo+m0PMsaZliYYjR1KCPHlyrOdTi0=;
 b=yyU5ZAXkf9SFHAE7qZ9t25OuXdpaprylw+EuJDNqvQqXONVhep8iIrDjxns4fca7fjqE8vyBAUF/Izzi1QJ/Zav7D3vDAfqIKXMT3PMmAeW9QYUcXuU4dLIldhFpuZg1R0x+QEWDx4x8ByvIGHVBL1oufueTtOx/eaqT/eTyHL0=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:13:55 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::30) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:55 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/40] drm/amd/display: Use two pixel per container for k1/k2
 div
Date: Thu, 30 Jun 2022 15:12:48 -0400
Message-ID: <20220630191322.909650-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03cb8f7c-9fb0-4d36-1998-08da5accad76
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBpIWK57R5j53eHsE+JhMvvKf53M2wXmCm5c575oZIYbf0ticYAV0M/QJr/lGF91vFY4tqZNYb476YZbXXzWnktA5YfROneqis4BKEGhhib/erKwrCe8EE92tFkF/YocuqB0oDZkk7dL2qMlTtV0f5rL+5Kzm4OhVulB05H81RIHncZXYsN6x57jbOUFIHLRXRMrwcAY1Y0oqyfQTcINZ056Ey7b7F5FPZbEmKZ8OhC9rK4OqeYsekYa3qlcriQAXfA0WupUl3ju1wbSWU623kvoT87PpThHcZWhZ1R30Tv1rYxXlDn2B3IKmFQ+gnuTRrt0sdVA5EEGKh9pjjppv37rqfIbMSYa0ZeDIH1As3CDD4phECWcIsSlm0bbJ+hYPr692JZ9r+rCmO3FW99Z+yYHK1WArsH/7EdhnnVKrIN2g14+Y7ZIXjkNNXM/veIw00NuDO5LTPvC8omrlBM8Yvnem8NmXdb4SXucwzdlkzqy+CJeboq+/xIdZxt5ckEx1MDRgkj+18jUCDYcdVD2ekhZm5jFdjT7evMf+bYEgE8wf4utxtXW9F0YeB2WoDqL1VO0OVWONv+nZWaQdyXqfObZVvq8yKSd0MBtBlhaYAeVQeraHoZaxMIM397hcqx5+o9ZLnzTVVpIdaa3Ah17It3/LS7EiURbr3eXXxv18RzgrgAQqHyd0xkGS8GYhamwkk8Io/rZoR0OD6NKG5g5tA9vAaLKAC5EULaT8KB5N7FFZQRoLz5Z0gYRRRTBqK9yh3OObZQjAH0UYsBQKk6BYI45z7ANZsGfcq8hp1znLn2YBfrMLg7PUlUgHVcgVqwzQ/lahURkIccC1P+e5BajZROGBIlnGtbptj7cotpZRrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(316002)(40480700001)(54906003)(186003)(16526019)(83380400001)(2616005)(81166007)(82310400005)(426003)(336012)(47076005)(1076003)(26005)(8936002)(40460700003)(8676002)(4326008)(2906002)(5660300002)(478600001)(70206006)(70586007)(7696005)(356005)(6916009)(41300700001)(6666004)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:55.5747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cb8f7c-9fb0-4d36-1998-08da5accad76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, we check if pixel_encoding is equal to
PIXEL_ENCODING_YCBCR422 to get the k1/k2 div parameters. This commit
changes this logic slightly by checking if two pixels per container are
used.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 7da994d8cde3..51958573a2f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1082,6 +1082,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int odm_combine_factor = 0;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	bool two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
@@ -1094,13 +1095,12 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
 	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
-		} else if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422) {
-			*k1_div = PIXEL_RATE_DIV_BY_2;
-			*k2_div = PIXEL_RATE_DIV_BY_2;
 		} else {
+			*k1_div = PIXEL_RATE_DIV_BY_1;
+			*k2_div = PIXEL_RATE_DIV_BY_4;
 			if ((odm_combine_factor == 2) || dc->debug.enable_dp_dig_pixel_rate_div_policy)
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
-- 
2.25.1

