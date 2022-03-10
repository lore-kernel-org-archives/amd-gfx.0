Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66917C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20B410E336;
	Thu, 10 Mar 2022 22:21:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6692B10E336
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRSxtgi3vwOKQ3moPmKMmgsr0XrGRgPr0fY7Zthn0IYvQwhQIREwzE0tEVEFsaiQkmsfwqp5liGZrb1aradR9OaEkJGAShuhvxbVpl9VtVS5RLPIIq6/Isg+YuLf6ZuuprgpS/5KsgQHZYVRM8WmDTVlJ280rPINP8Rvnuoxxzsn1Hel9haLjb7fnHy6PIA/pIa9NLSrZyF/Eu92Vtm1RAlpElcKvsoFN7w9VVXLohgjdbOvBi1OO9y4il5IFjO5rr6BgYmF8eRYCbWibKCL7h+tFteKGOJQ/gkjYiBtDoC68ltxs5Ltn+5t19pEwLJ88w3XlFUNZcFZgAFyC8peRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+auqC0iprtCftE+oFdWCr2LswP12kjzJQCy4cMXXys=;
 b=jTCpNNsh6o6lGZiDP1fOzjrq/rXB3YTY3XDZ60xg1QQzSJ7p9RHpyS1b/F6R+YQ4Rwbiby6RE+BFipK2T4+Yku7bTRf4FR+jirIVtYcuvjdvKK/wkOHCU4zTpegMhlkXIq9ypq9/8kPlxhK9KHlM5LqC0z9Nl0fbHygJtVnqIgrYf/VTU80o7pKE2zXZTXKbxWACP61f5xyXG9xlNjAzp7wEOe5InvMDU9+i4JbxLz5NfkLlcIvKReqojgGIVFlPZsFx+XWafStvy9wlNEN3FfkTTaPVJzpDqJnKfd7fohKwlC1pp5ecfuTEnA3n5HiA++KfolrPVrGpZvySz3krcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+auqC0iprtCftE+oFdWCr2LswP12kjzJQCy4cMXXys=;
 b=ZaPCX/ovRWSRXfbhgUWzowF97mMVoEtEMleZqMi5MmkyHyT4nVjqvVVCwMugRXdPVGJu70q8l+QGnc/JcAOi6yUysK6/m1bQCCGuFxgBytq+OZKu4RN1wi+Q2E5XfRFJzfJJ4fjSxGlrsfqGdSVmh8CyjRnar+7kSV6N3rgfDqA=
Received: from BN9PR03CA0871.namprd03.prod.outlook.com (2603:10b6:408:13c::6)
 by DM6PR12MB4604.namprd12.prod.outlook.com (2603:10b6:5:169::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 22:21:21 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f5) by BN9PR03CA0871.outlook.office365.com
 (2603:10b6:408:13c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:21 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:17 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: Add function to get the pipe from the
 stream context
Date: Thu, 10 Mar 2022 17:20:35 -0500
Message-ID: <20220310222045.664867-3-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c430cbc-c991-4604-4949-08da02e44e30
X-MS-TrafficTypeDiagnostic: DM6PR12MB4604:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB46045813598CAE6AE456E03BF50B9@DM6PR12MB4604.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMXtZwAkUHZkVzijZyaAJQ1PzsLESddK9qd8SBW/poQxVQvhkGvEVrKl4DsSPD1Xwgw72y8KXxYAkpGqbzo/oAnhwjBRhffwGZOVYpq8c3gs9WBDhd7sFyBioog6avBWE2wbBVo5/fqSGl+4ixAqGgDz8F8xRJo53KV8nb7+SGLc6IPDeJm1IuG7HHUHVJ1QE+gdkeUT8ymElSrsbU4/NqJWb7LsBVn6RZkhzEfKeh4S+QZVZrWuXk23coe86aP5HGL90uW+brk5kozd14B7Dl8E5ecyk9I4ORqhUjXuI5WIYpAsD08mhdTcFPstV3Q7MHObjDU2tK1qaR/SuzKsJIImMHJyUD2cXO8kxUWqM3jNle08fzo7mtOqXqT9vTf78V5/BzyexfQ/3Ayq5l+ep2lVaE6IlxfFdCQWhqvRt5z/+ex+QGLSSXQIWlgbXVcGiRrlVJthW1X0igv9WtX9bIF86rdh3GsEZgImDKjAgaKcoSwVKVNuxI8ReWxQe6ke/hRd2Zk88moKITr5h8RDXEoRGsZ0cM0+SJnVhA2EWb+bY9aXq3OGpvZtHIwmbrwBQPFWEKSvPCmGr494DtxzuksODLPi3Ggtp7AJAkRO0yOFRLwDSK50y6POfuSMEMnj8jZuSpIUUUYoZS0OFeCSeGvu5vzvPvdP/9uP9TRYpIv2mohpCv17v2t1SUuVu1BiNH9MwiU2vY+uItV84vsMxU70rdNydyATuUI3pcJdMVI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(70206006)(316002)(81166007)(6916009)(6666004)(54906003)(356005)(4326008)(40460700003)(5660300002)(44832011)(36860700001)(8676002)(336012)(26005)(7696005)(86362001)(1076003)(2616005)(186003)(426003)(8936002)(36756003)(508600001)(2906002)(82310400004)(47076005)(16526019)(15583001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:21.1745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c430cbc-c991-4604-4949-08da02e44e30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4604
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
We need a helper function in dc to grab the pipe from the stream
context.

[How]
Add it.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h      |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index dc5fd27b031a..c4e871f358ab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -718,6 +718,20 @@ enum dc_status dc_stream_add_dsc_to_resource(struct dc *dc,
 	}
 }
 
+struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream)
+{
+	int i = 0;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe = &stream->ctx->dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream == stream)
+			return pipe;
+	}
+
+	return NULL;
+}
+
 void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 {
 	DC_LOG_DC(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index f631b61abedd..99a750f561f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -524,4 +524,6 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 				 unsigned int *v_pos,
 				 unsigned int *nom_v_pos);
 
+struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
+
 #endif /* DC_STREAM_H_ */
-- 
2.35.1

