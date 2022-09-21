Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B17C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3E510E9A7;
	Wed, 21 Sep 2022 23:18:10 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E3B210E3A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KejqIdG1HT28xqVeg3sNVElqIQ/vOo+VppwJsbKZWXcVjS96Wfm452wW0rUREKNOkyBir359l62rm3IodrGIYBjFhLGKYXLXvjMCkb75aOOjpwj+ZF1AdP1AI6BmIwNyqb7aIs8QfzM3BG38FX5gdCblkxZKM/BRaHugjqxT5Y2HG8OvzI9mDIry0UFmVahKJa2mU1lI930dXgum+IqBoWS6zIWJiind9edc9tjpR2Ya46wg6cTi4dWxzkCv+sx6lfX2k7SH22qOFkkDKnn7v2XtySXVtsYyuZTm4ZV30wKhaM3DT+VkBgZ3IPmZgTEJpAqrD+ORp0/oK5sZ0jFPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uqMzCrxicM8h9paSaZ1Y5UPhxzfZZ2cSRZEGXYzYOk=;
 b=PI17mVbmP3AusQ41ScZTTSvGD1lTJzA2easdweqwlIqJZheBkM7Lks3EVgOlv8JxpG3YclEHWvo2Mm6gJTEWkWEcbnq/zTtuUfXVxhIrqoNbTP4n0jKWoYQ9oaypXXCLvD5tL4PA/34PwPcjTNTZKyYnbHxskFoLC1nCuj6KG3bvDFGX6IG326f4zNa9gCXwzfgH1uFPgk4USXfeeEAgrGeTuMqxjeNjzzlsrrzLRFNEBth7VRsUHMzrE1rypmCOdtKJAQayBT+L3Eff07NoDYPpCXcPO29TlL41VBF54WZ4DVyDlxgxLxLq+adpz+nB88/TwWZKpD3AbvIvnNoApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uqMzCrxicM8h9paSaZ1Y5UPhxzfZZ2cSRZEGXYzYOk=;
 b=I9aIBuplsJZgETKoxFSzC1JQPSGi+rmAlzltTr7MuvahsEzvBJyZM75Er0hIFoq4U+BuJm+p+A3Z9SHMfUnsgstZxp3iwlXmdgcskfWC1xv6PNBQrmdzEQ/6HTypjrYhV8hCLJVYo9aqb6XcB+4ZoVFaPUa2QfnCzODdEHHk9nY=
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 23:17:41 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::d) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:41 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:38 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/31] drm/amd/display: Wrap OTG disable workaround with FIFO
 control
Date: Wed, 21 Sep 2022 19:16:49 -0400
Message-ID: <20220921231714.303727-7-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dd1d6e-edab-4b34-cffc-08da9c277b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMorvWBn65GzOEBWsJRriIox3VGc4/pjOemUjIcsECd6fQMoiFedm/m0LU9xO3CTMyoCRtzWij5ssfOSsYnMrLno/A1XP96i2FnHVtctS7Sogj7PkGLj3Ntct/TKSHaqhtC/4F6dAUhxn+tMCqgCLwASMkFMhnGl+mJEPKS+jSs2eoZcxihnQU8KZ0iDPBa/dJWumvsRaLy3ocmZCUmlMWaXaXm79QBGWfTsA9fLwdk0iijp6cJAAHgWxwtrcB3iuqzLDflkXT5VIeS+0jjeIO/O1wV2qJuXz7KDP5kNmnCEsEQlWJXc7Glr2nRLGR6+Sn1pRhCC4nxoDaZrEvpOyoAy3u2xKQ41T01U145o81tjtZWTM3yvWB6qqmUi91SYxQQfxIhfKw5v2sSCIH6FMAEn9OmQ74SnQT7/pqkULEqPsA2IrlhVFtXFXKYEjtctKG4FdGt2ld8XlevU64fsmNzrBlme21AYN/mVmGXq2q7YTtW2J0lvoqkxSvNfBNBLZ0Ciux+UF1PjJeO2MsizpM3kOZmx20QAJ9tfcU1K3I6Bf6aCzXvOtWfjxsRImLRisYSOWuOZW7AJvS8V736baOYmT6v8KuvziVnHh3vlDSFPQluDQKEHAMbYHR7qZwQ+HKyjs5eCWua/Ujliq9Z9JbPAxUZMJf5RK/GdlaqcH9LXRCpVFu0w3xzLqgkIvBO32l4jGdrOPF/kXp5vPXdgVUDZxaSrnsyVtgiW0rtft4xzJhiIcQNsg0nfTOK1THT+t5YquHs4tJ+qxcFkqZMsGvxUH/5Nl7TiQ7TuaHb3SNmXXHUTkHi5JXssKq+7/HT9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(40480700001)(36860700001)(41300700001)(8676002)(316002)(6916009)(54906003)(83380400001)(478600001)(2906002)(36756003)(2616005)(26005)(82740400003)(1076003)(426003)(47076005)(81166007)(5660300002)(40460700003)(336012)(82310400005)(186003)(4326008)(8936002)(6666004)(356005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:41.4889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dd1d6e-edab-4b34-cffc-08da9c277b8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Syed Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The DIO FIFO will underflow if we turn off the OTG before we turn
off the FIFO.

Since this happens as part of the OTG workaround and we don't reset
the FIFO afterwards we see the error persist.

[How]
Add disable FIFO before the disable CRTC and enable FIFO after enabling
the CRTC.

Reviewed-by: Syed Hassan <Syed.Hassan@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c    | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 193a0f3de18d..1131c6d73f6c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -137,11 +137,20 @@ static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+			struct stream_encoder *stream_enc = pipe->stream_res.stream_enc;
+
 			if (disable) {
+				if (stream_enc && stream_enc->funcs->disable_fifo)
+					pipe->stream_res.stream_enc->funcs->disable_fifo(stream_enc);
+
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 				reset_sync_context_for_pipe(dc, context, i);
-			} else
+			} else {
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+
+				if (stream_enc && stream_enc->funcs->enable_fifo)
+					pipe->stream_res.stream_enc->funcs->enable_fifo(stream_enc);
+			}
 		}
 	}
 }
-- 
2.25.1

