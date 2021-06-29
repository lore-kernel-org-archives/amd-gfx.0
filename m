Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D74C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F9061D74
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F9061D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFCF89F61;
	Tue, 29 Jun 2021 15:54:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1B089F5B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jklzwy+SWCWBYOYnrJszJD+H9+vcuEdbEX/NkUbUDurb6zkvg1Fd1F31ADHeozgOwNn2rgr+NjMhWbwV2cOlMaiz8WWnJK3/FduSq6gyThObNgSUMQQC24L1FRFBXRRA12oDiJp4dd3L57gdCNCFlFe2HotYZFbTjLnE8udmG9be/BgjQwd2licpllJAubW5kjGw0Z5X5Tw0T6QQ5VEJ3Upix0z241Gf+/L+BGxqGzrfAtKhjCIhNVdhHJ09EEaKpwk8QMPeLzs89kHyxTUGMGuptZLZbQd8TWCHYCreRKeR66QrLbs8ZM320BeDr2RbhCoki9xvpYkHgd4L7+KA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2+sadOr0UKKetun4SMUOukweBQc0dPC+hNJJ5jHRkw=;
 b=gle1v1/cKMfQsvvsXZNNqht9E6po8yAUETZ/AppYGJb2skv/eAUkMmN8gWNBXTVwICgs9aXa0fxVPAkf/OZVt6V8R+cRmPIRJaInkBRCC0mmenrXfM25mcUWeBPAUOqknIKXmRKXt7SuSYjHz2apPNlCmABfVsC/d7+cvYF5/pbWwrvhTu8O29RVRzupCW3/j4LqAphI1ql5yBTYlCq60RoS++/nXVAA7CtL2Fiz8HEntn2QHBYwD3+GUcCkZ8P4uDsNQ9uPfQR7nlgxopnSuX19fjPxiuakGf8SvflkYTC80MxTqjHEpEe0QGeki1M6BwdkKQHBiXK1/JXSaTX/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2+sadOr0UKKetun4SMUOukweBQc0dPC+hNJJ5jHRkw=;
 b=g2iWE4QIVM7GpWfzoX+5JGS4Gw6LTkFPMW68vsb5Tvu4hWnicbFsFEks2MNWBqQ4QwwFFNX0aUZtqmFKGNbgIP6T7ZFsjPsrQOiWCjb42HWLZBexELW62EkCokAECOA/NoVSXippWbPrcDWaVZNXboGPvu0lMZNiyhIwQFsEe7E=
Received: from DM5PR15CA0025.namprd15.prod.outlook.com (2603:10b6:4:4b::11) by
 BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 15:54:55 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::3a) by DM5PR15CA0025.outlook.office365.com
 (2603:10b6:4:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:55 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: Fix updating infoframe for DCN3.1 eDP
Date: Tue, 29 Jun 2021 11:54:15 -0400
Message-ID: <20210629155422.26118-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aedcf8a-b1d0-4bc6-e4ad-08d93b163d76
X-MS-TrafficTypeDiagnostic: BY5PR12MB5509:
X-Microsoft-Antispam-PRVS: <BY5PR12MB55094E3BBEB968869D9F152998029@BY5PR12MB5509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 170JLiWS5YnmCB32HncGJXH7Lu++FuRhbrSqAkzB3fn/cOynqqjS/E8u5Vt7zFRQmJKFcq3UBxsJgpwxk4tNBTUNqITdlIHEmUjRw8S8OKBzzx90aeB2R+lnKe4e22oWqnN8XrmLo936Oa24pwPQ1lwPPg1nHuJzbkoj+mKvXvMCWRPT22DNQPDsH3O9Mf2viPZJ1ufLx6StkoOIlQlNTuZxagBcyINfNyzeJyt9MSa5n5EVzA/8r2OWbXV3ViZD4q6E7ll0CUw5raJC8/Unl2w2GsfLWmt5MwC0g6eq+2zpTSpZC7nCnHYeqcG2KcwerSds6fjbn+IlAMuRlCcD9eKx/Xz7tvX/RERHs/3ZknofQw8r/XEqS4Y1QbgMC4IuIGhRnNryWpEbZRhwBooB2h6SolQslD33sIZb7/+Ve1UYzBEtcU9EcyugUqDh+R5YdGGQst7GKe70exyE/iz3buQ4IDn6AYSboAjkfeVVnYPx2dgJamYaE8IJhdaB6vy59cy+98O91Q6iOO7AiRTPf3TZAzIU8glqU7wOFsPDnxINzG7rmJOQjaueTguuIS1fof8XjaVfcl8nxohe7kxKZ9fB2rvwY1oNsnlCx/R+UlsSJVMQZaCofBLIeXi84jH+Er4o4SIUNj5pkN2Au56evwA5fuFbtRt64E5aydsSeOf3HZvviAlT9J+oGyO/1xIZRKLivx1zzmwf84TAKQh509vby17TmLsN/n2QEQv5xDU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(46966006)(26005)(4326008)(186003)(82740400003)(16526019)(478600001)(70206006)(5660300002)(86362001)(47076005)(82310400003)(81166007)(356005)(70586007)(6916009)(83380400001)(316002)(1076003)(336012)(36756003)(8936002)(8676002)(36860700001)(6666004)(54906003)(2906002)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:55.4997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aedcf8a-b1d0-4bc6-e4ad-08d93b163d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
Cc: Eric Yang <eric.yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We're only treating TMDS as a valid target for infoframe updates which
results in PSR being unable to transition from state 4 to state 5.

[How]
Also allow infoframe updates for DCN3.1 - following how we handle
this path for earlier ASIC as well.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index fc1fc1a4bf8b..836864a5a5dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -390,7 +390,7 @@ void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
 	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
 	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
 
-	if (!is_hdmi_tmds)
+	if (!is_hdmi_tmds && !is_dp)
 		return;
 
 	if (is_hdmi_tmds)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
