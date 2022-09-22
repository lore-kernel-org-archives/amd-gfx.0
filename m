Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BBBC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED9610E9F3;
	Thu, 22 Sep 2022 00:18:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0EE10E9EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Teh7/y3xLvASXIHlW9Q+ckUUoxHOtBVw4TKhx/jUiiqVv3z4odTZO14QILClsWTuH2aLmwifzV/DNJoDX3rnpXFYvCQGz0Cxcz4r6OMRaqWCFyiDVt5VE3OpMbX1Do9Yap8qcMC8DiMy/72BxecAfNlmPHcBJ5qMtPbxHhyc/nFVKJq6SS1fLMsYYvjmL6FZvZp1IjSpnUW8xyMvOVtFaZF2NNAfS+ZRhmnxs2k/3lkrtLcrAajhrZN7o37sPUermIWAncNIC3k3FqFmHBM80VQpv3jxOZXngZL9GMTR0XzPxcCoOmBzo3BVfoSWD5qJeAvvudTdobDiSLrRChO+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uqMzCrxicM8h9paSaZ1Y5UPhxzfZZ2cSRZEGXYzYOk=;
 b=RX+5Oa6IuLr0mxxZ3JSQGDjucbsmEfxCrbN/XMK1X8pfGykGI3KC6cQVjGz2O2/q9MGiqYqbYmIuHnJMYZtH0Di1YGo+VMPjSf6RQcnhCwrxeZlGZvxh41MzcaqCBBhaAGyHeV3FiXt2SdnA0YiHgrd82Xxt6OBxpt5WZcJoXz3IKr+QtF0/mUSHKB7JN8Q5AAyMDetWHrYYqJDONCFY03y9Weew3PE7FwEfeDHKD33vYz+xRS4gOtBaDcgjadD7mugrNTWQQYe/h60piZRJl234z6xhn1aNBj43KexQ3e9Lmmu+SatAQcbHLf0LWEcQoY4hV1pnzp67F8XMIwd+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uqMzCrxicM8h9paSaZ1Y5UPhxzfZZ2cSRZEGXYzYOk=;
 b=dXgfNMhaZ2qRCd2jE2PsxMmYCYHCb0OV9RS+qguoEEj1f+bVYuYSxVIq9obpZRBS41wAyS/NlIsHwOXiffem9Zh4IM3tBeRCBuOlJivT93jGGClliGT0uN7ZaMcdu9zwWUMGNdFiL0K9k9OdczTOcfqz0O1fIylXds2NnA8eyWA=
Received: from BN9PR03CA0062.namprd03.prod.outlook.com (2603:10b6:408:fc::7)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:18:51 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::9f) by BN9PR03CA0062.outlook.office365.com
 (2603:10b6:408:fc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:50 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:49 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/31] drm/amd/display: Wrap OTG disable workaround with FIFO
 control
Date: Wed, 21 Sep 2022 20:17:56 -0400
Message-ID: <20220922001821.320255-7-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f23a9a6-be18-4d94-5a29-08da9c3006aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMnxfOkT7Awyntdd0CUT67lp7fLzqh6HQIkuwS+fE1o7KMcu4RiJoxru6zZHzeB2b5zeF4SoOacVzA6GKkthK4AAt86L+6/DSWm65qWexDItq1Ym9Kx2zL7WHpeA3Ha5UQwbizM/IPkyr+jIyiXpWjRYQh01Tz05M5Ag7eq9utIrC5a4BmkDcj8iWjEfeICCgjKt+w1f9P9y+165cp7125/rv43KHMomezE/tv8oCV5fhjsQlsHx4UdH2GyXT2sqLj2jq1fUXlWCszIFxemWWSXkJPhZUvBlJiX+UFJgwyh4YpfAODSrBu6J53JMc2EIgkmoR2hniayizUZr9m3t6X/Sa6g9dVDryEufoxyqz/dL/q3cNBLqKGn0DowqZOKZ19jBCXQ9bqc1Ippikho514lIOQbyqIeKIhenBKx3l19tWk993PM/AF/fdclPdLkM74IQZ6AnDaBXb0180w8CwYOJeC3CbUuU2PSjlbjLfKZWJCTXA/O9ReXAndSdo9iaY/GpfIUBsLhpGFGZjIhhPv+t6BR8RQeF+LT5rCyn/E25wwQTgGhlJm8A9TffIR7MAXLRKC+eoQYfPCAjQFrWq7E9AloqBJvEfVtyGyFZJxVpBoW4UpGxbFsnUa1QOSHEoJ0S8ZKqvl47K2M6bXG0tZ3TMa/dE279qwfTiTzclhTVwu7YX3qozF7aJhOc/SV+UeiTlY/CRrjj0DttwxLM5Wmhyi8fKpvcESQBdRPwtLuKhADtCPupsVDO3LG15shO7WqvopyNm3F6t0C77vj+St+PJkXbL1sk30Gv1yN9nS9W6J39B8uCePcw1oYfnqyg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(6666004)(26005)(36756003)(356005)(40460700003)(81166007)(6916009)(82310400005)(4326008)(54906003)(70206006)(8676002)(41300700001)(70586007)(40480700001)(36860700001)(82740400003)(316002)(426003)(83380400001)(47076005)(2616005)(1076003)(478600001)(2906002)(186003)(5660300002)(336012)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:50.9912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f23a9a6-be18-4d94-5a29-08da9c3006aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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

