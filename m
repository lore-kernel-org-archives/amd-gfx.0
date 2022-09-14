Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D17ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC36610E817;
	Wed, 14 Sep 2022 03:56:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C86810E819
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5QEZ2q6pjt4d4209HKk+ZhYiyO6MTbhhHD90thGOzBV5PHpKgF4y9q32KOm5VSUbyfyiGBlVH3CmJZ5aCQghrPHNbS1GVWXcTeV5MwsQFwklTG/6h29PINrsxbiROwLnEiaivo37x+2zMyExZ6yyREe0sPshXlZEJhcRCW2OP8nsCTaB4zdty4Jk6mrwAHS08wRmnXX6WGTaXsVGLSRlDCE49+u839NxFzVCH9v2wHF/WedeWeEfA77X5NxwHfg8gyXa2VtvbrHgWlyzK8WgG+P512cv/voeqL2ngZOqLk5io7bIPrT3M9YDOx9kLYgh0XjXoQcp2LLctyItMknDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3px1o/qd/jSggcROAmCB6bz1G/ZyUj55Z9GEafaMvgY=;
 b=VNb9lihHOhU1FkyYNDVJyNxHuDJcW+SdwZ+wPFBgk/5aEBSkN4M7Rf71E/8XpmFj4cY6msuFP9iLDM0L6a/h/4t/pg4ZhOFQ+7jic9+yigHhnMZt/aXgwXfPsY8XIm/JYGx6zPTH0GG+RTdtFet9fMp39EUL2jaVrO+7nYJc0D/Ui4bHdXTL/MFz5PfzGWoIBNxpEk6h6lpys4hCfK03GFkboX+ZWWPz9h+13zyd/dC61ZfnfiUstVhsSgs38OeHUdEkhad+y8TZT4t2YWSFIiAQYmiVNf2R1+gQhsv6mm4mkChIBY/zoslb5mqnkDBlG6VUJfs9aXCCSLQqmjmvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3px1o/qd/jSggcROAmCB6bz1G/ZyUj55Z9GEafaMvgY=;
 b=bDPOKKr1Vw+43uBcGZr2YgnYnIGc2R7ScpO89r9ca+qENGBghKK6Thic1xLgHlRcyGZyO50i2StWoJ8FXEqPnM+/+VinN/jIu49dUiGIqArhgQs59JpcBqPWhj5K1RehuPMGFhAOzomOxDlAaMshUY+Jsfd22SdOfbnlPa/9TqA=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 03:56:04 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::5f) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:55:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:55:26 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:55:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 31/47] drm/amd/display: Don't allocate DET for phantom pipes
Date: Wed, 14 Sep 2022 11:47:52 +0800
Message-ID: <20220914034808.1093521-32-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fb20a5-63f8-4466-06dc-08da96050ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0tkl9hnnyXd0zHzrmWtLCFOrcbHfOs+II0kn06YCny0lRGS+zF3kXRzYiSBHfnd5CW3t8tdxjWY2R8S7cUrEBaNmoQLg0xCISgh7UlDEBXNFDxjR7VJvz8vaQa9Kld1gWA3Z3r4lTdtuiT2genmYT48KNIXv1JAAt/nWB4fFiKkahBwlRmt9UUbHiy3fjnOUjtSChE/YGuV1sF9bM5zajqcUpVfZid2V43afEUY4KBnNXRWW7sWGnb15ABZ6fJSAviVlTJUXqfyCMVkr9RlWXamoj4dNqXGm0ayQa70fkR3JQOq2jz1iCebd3CLfOeVam8cW6iErcrgyQu9b7BkCfDIgqV13EuB4uqImJuKjyzCX346xvVBQZpqMkwLmDSj7IfAT4sqRIhNVtj7QhDs+gpTNzCFwVXJShSCMhopaGoCvEzYd9NL9aFRW4B8KEEbUtQDyPM2q6FpCPo8zlqqLQqz+u9f+Ex6Tevg2daRedOBlmGQxKBhTgekGtX0WR8MUmJDuY0LUsk8N3Z7E7Ay9Nskas5SZe2uEHYiHBGJPDFB8iNivRokYLEM07TP5lLFabxrVwIAAgJeZWZLJNjSAScUhgNlsW3FW2PkgUOTameQN9XBLG6mshag+gThyG2FROl1ox7mlZBxNe/urOWoIOXJft6drqqoSH5JQRi8ENxVe3B+W96muEHqeFzwdl/qtvr1usxGx3s6kIofnEdTu4/9FLNWf5IcNDSg8SzqslZqbRPIma1G+3me59LQZKu93a9fC3cvLKcQ8p4C/8JDHoMZOZmgJZOlJ+8+/GkDORMuUCCEpuv/WRLO9v70x2KT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(70586007)(336012)(4326008)(7696005)(8936002)(316002)(70206006)(2906002)(26005)(41300700001)(83380400001)(478600001)(40460700003)(8676002)(1076003)(40480700001)(86362001)(36860700001)(6916009)(6666004)(356005)(54906003)(186003)(5660300002)(81166007)(47076005)(426003)(82740400003)(2616005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:03.9826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fb20a5-63f8-4466-06dc-08da96050ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
We should not allocate any DET for the phantom pipes.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 14787e0f0b6e..5490b3705b41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -271,10 +271,20 @@ void dcn32_determine_det_override(struct dc *dc,
 	struct dc_plane_state *current_plane = NULL;
 	struct pipe_ctx *next_odm_pipe = NULL;
 	struct pipe_ctx *bottom_pipe = NULL;
+	uint8_t stream_count = 0;
+
+	for (i = 0; i < context->stream_count; i++) {
+		/* Don't count SubVP streams for DET allocation */
+		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM) {
+			stream_count++;
+		}
+	}
 
 	if (context->stream_count > 0) {
-		stream_segments = 18 / context->stream_count;
+		stream_segments = 18 / stream_count;
 		for (i = 0; i < context->stream_count; i++) {
+			if (context->streams[i]->mall_stream_config.type == SUBVP_PHANTOM)
+				continue;
 			if (context->stream_status[i].plane_count > 0)
 				plane_segments = stream_segments / context->stream_status[i].plane_count;
 			else
-- 
2.37.3

