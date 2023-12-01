Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5CCC10F05
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA7810E873;
	Fri,  1 Dec 2023 13:28:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4949D10E874
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTZhViT9PJnov5cF2ZM+EDPRYONdtSYAnKs/CMFyMzWWrGTCKBk6hBI/s2uBjnqwrIVnGiscKTCrFQoyAUoU7vVXPid+98hHep0r33RrmHWF8cC2M0sR/XKLSRoI3aC8lmNRsrknGRw6iTzuZLA0p60AHJVa+emYujE4p7J/3gJp6MIBUL+OzbWXjLGOdFLX1I3eaX3W9tpF8yI3IauDzWKLeQektAP0MgvZuUUAyPv+5LqUWURP9Lqw+00BYqIRnPi5eBxeiGtHRYcKpz08tKKGhE9BR3QlShu1BqzM43zjB2OEvvRyzesc6070BU+2QEyxi/ZLAu+gyDJjwdyBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+exF3VYkfu8y9z2Rb7+aM1HPUBKUB1UFF6Eoy7D+nI=;
 b=dwZfvim2WaCirU6IeWk7krWPVe7W6mOoZs1J6kCX7Dh8V+9FrKXOzgMwtALxh2AeJIGSHQEDrOjeZVKRrXGUa0H9KS63PxhooTv7f/Fiz5H/AWDWY6mZuywtDwWvzeRDrziH68lr15s4J2aCCH4rWjFRwbPsGHTesltVlqQsAG2RM2MmyT9tVvy/qfbYfDW92CkjOC0T3Z2T0287Mlm1U5DS6R2dxh7asKs0PMbtt34DJOghHjAn/G9zs+STsC57RqDaICKNIstnKxnlVpIbDgAtLUzvdKf4CFqJ2IciPTDvighcYapD2GbsMEUEuDIKPY6qErvKRnHGjOMJcaMdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+exF3VYkfu8y9z2Rb7+aM1HPUBKUB1UFF6Eoy7D+nI=;
 b=hhilfmhA5nqGiX4vsdO8XGM46zgwl0+i+85Kc9g7lXvjbgEM0WxE13c2RFHqaX2FQ4TIsMJQpf3yYGsSfTsYY4Y9mD8qzcKYQRdQT6XnOC6a9CNFq2UoNpLxs+hhysgK46i3ttHRxmy56StvTNrHSaPO6322uNNwJC9wsGomaLY=
Received: from CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14) by
 MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:28:03 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::bf) by CH2PR05CA0001.outlook.office365.com
 (2603:10b6:610::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:02 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:00 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/47] drm/amd/display: Only enumerate top local sink as DP2
 output
Date: Fri, 1 Dec 2023 06:25:00 -0700
Message-ID: <20231201132731.2354141-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f585c47-77af-4ca2-a154-08dbf2715859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uoo+lPZrnMuCYDwV8W0bbST9ZkYPuHSWk0u4xPExFCsRVDnC9BNRkEdxZM07WeWaD/75syHwHdlfeNPcxQNa4UmMYEfFHKnEELCmFDCIYEmN5d8K33smU+xYRR3w+2Rzg8gRizu1Ef6Wr+oJ/HtC0X9mZpVILCaUvJ31KlXt45lcdvhOEIdx1l0lgEGzU1CA8uoUdCVLezoW4uV0m17RgrGxbf9NvwuxTqKJoclW5HLgfK6IQfhpoFPKjPc43fnin+OhIxuLLu12U3strSgeYXRY6HiGj1XcdvArgJZYPVx3YglN9D5sEGo/HbkuY7xqA+CHjkmzZp+3VqZZ3moa292QNnGiPwBIUKMjkxDxp/vYtRVHJkI+yofqef+q1lAIlpQnvTo88/QQL31Lh8JM9Ne/q6LxtbAixr3fNJnzZMpjy3khGafknn4Ziaa317pkOhE8wsledvgmTlPvqOiXmJfLfkKP34DhHQE0ljb5+tDo5dktVQdZ+zUUR/CXWmoNpjRc8QCHUagMWCCTy1jHXWQNpnEdETqOOp1ymNdOrZFLoER1SE6JXmeQdL0e2q9Lh2/6wnTR8yB8O28dbpW8mYBiUDR21VnpFGT5kgjm+c6KCywzVzC2SeL+lRsykKYiRnFjjlO3n6HflLp4BD3MYul9o8PtXIktySgRbPFy8eClnFiEhzzbRaRJ5YRIbXQKVP6qV1l+oOsnh998GB8zk8equPqzg4b5IH8ggOZyet62x+T9jT6Ftzk8HemUaY5Jprzc5YlDqU/T/ZFUnh+pag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(40460700003)(70586007)(6916009)(81166007)(70206006)(356005)(82740400003)(36756003)(54906003)(47076005)(36860700001)(426003)(1076003)(26005)(2616005)(16526019)(2906002)(316002)(4326008)(5660300002)(336012)(8936002)(8676002)(478600001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:02.9771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f585c47-77af-4ca2-a154-08dbf2715859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Many DCN generations only have two HPO link encoders and therefore only
support driving a max of two DP2 PHYs. DP2 MST hubs currently can not
pass 3x display validation as each downstream sink is enumerated as
separate DP2 output.

[HOW]
Count MST hubs once by treating only 1st remote sink in topology as an
encoder.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 33eab80e89a8..6ba393e5b8ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -157,6 +157,15 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 {
 	/* If this assert is hit then we have a link encoder dynamic management issue */
 	ASSERT(pipe_ctx->stream_res.hpo_dp_stream_enc ? pipe_ctx->link_res.hpo_dp_link_enc != NULL : true);
+
+	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
+	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0]) {
+			return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
+				pipe_ctx->link_res.hpo_dp_link_enc &&
+				dc_is_dp_signal(pipe_ctx->stream->signal) &&
+				(pipe_ctx->stream->link->remote_sinks[0] == pipe_ctx->stream->sink));
+	}
+
 	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
 		pipe_ctx->link_res.hpo_dp_link_enc &&
 		dc_is_dp_signal(pipe_ctx->stream->signal));
-- 
2.42.0

