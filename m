Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA565C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7813B61D7E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7813B61D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2923389ED6;
	Tue, 29 Jun 2021 15:54:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD10889ED6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBfp0cWqO1mdMOdqwWKHaAbGY0iojAVdufEdylLdiU1NbCRtNXWi5HIXj9DtYrpbWzZcGNnJwzo1N4fhOZ/5n4cikuMPWzrrYsP4DOMxB1f+ab1IQC/4PdmoEAdJin5RPU5P7hYpjnS4Z2s95hFEKRbYTZyeK8jBfjomVg+NI1WYkxz0JBtLHWHiotVEnAQLmJLOKCJ8Cn/IY3TxUKdcJtFBQpxV0q2Zd9NRhV83yIKtNiA9h1io+iMqZkeJMJL4XgK/UttkBzqmEPqIdiRW1s0dFXKzdkVKA11BSENYq+kwQEYDNLgpgPTVwIQiXR/6XJIctgSYy+37tfwKVNWBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZKeArwZlR+mPR2YeLlvpLWtsE8E97Nafdql7mOs4w0=;
 b=OrONQvjkibo6AqQK3FLwAc2tsVKvFj+4IqemmZrk/AIXFxzLRz1S/MgCmyBdIIFmH/05kFR2mgqeZ/S/Qlk52E7ZdIOrdi2outl6ljpvLZsSu4aFjkftMbad0Vntlqr2sv6Og7vsC3xEJU6AlZMO6Y9wjnzU1NpjP08/1yP50YQ8e+IEWuyTrWhxSCfEQY11MuJwAJ93Jce40+fieW2gED2T+W4SUUrXO0FysSWNxuj/sGGWv2zqkd8O/JodoX5IGSJA/ajM9i1HIgOCtCWBtrBDRxp55eS0uxUu7gEM51qkXIOzDMjgFK3Xr+F2hrE7NzVSB8+HMLD31BvBiuD7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZKeArwZlR+mPR2YeLlvpLWtsE8E97Nafdql7mOs4w0=;
 b=PABLQP3ufmlyktXJ37QgS0rE+gxpX/JEvPsBXDueVlQrmjcHpgNxDufmWMjJzE77wijOkDBOfuSQc2HCxC20tARXj6LtmdMuhhPozZdJSG2+CT9L8OVMRNfb8EcrdMdEOINcVnXx0VKHdrSLLTyAeT41X2kEI4LuIPgxed5c0zM=
Received: from DM5PR15CA0029.namprd15.prod.outlook.com (2603:10b6:4:4b::15) by
 DM5PR12MB2374.namprd12.prod.outlook.com (2603:10b6:4:b4::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Tue, 29 Jun 2021 15:54:54 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::43) by DM5PR15CA0029.outlook.office365.com
 (2603:10b6:4:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:54 +0000
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
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:54 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Add null checks
Date: Tue, 29 Jun 2021 11:54:13 -0400
Message-ID: <20210629155422.26118-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ce3115-1e50-4d41-49cf-08d93b163c9b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2374008F0635DEC601E8EEA698029@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxuyEhOaD29quXKRDeQKxVi7AyHiLz2k2POrjO9d8NeqxKukkQbijveK/4Yu4Ughjn8OmXQBCg5m/ID3lIy91ngVdo5NIoLwhqOop27LLlQemF5BtjXkDHxLSIN/rJ9bYEVSukLFFi9ymLKeFcMeAuFHsCPg0D7xm2JsVugpvBOql3qRLL4TxEMHLB7lMPnav3l03xFsImlxQdAhX2raMx3eFUr7HCe3r1Y6GN3ezobUuLCHEGOwCnXmw2ogkjOsGIAZ3zLcBggIXhgyqUtAMhG0TXYTd9UMCsGgqN7U2vhCLNQEpH8PeVqT639neSqj48xrE1UtUwtqajUdAzl1cKoIXct/dGEL6vQxFk+FFy/zZJf26z4is1vvUScCX2R3S9Qdk3k9z5zHG1aGLtNSyy2Xx9R0+9VgTBpd945zQ7WeqLoO6+We73mYCbnqdqlnFzgeavlqBAnPzEq/2Irg5YMnxgU1aLBk+dt/EzJpdmwZWQ9Tj0M1adl+BGEnn8UI93l0073ZfQGI/gvZW/PC7bGdcNl59JoYLRq+jsm9PlmhiIvpZ7t03G/eeKE09jQnFg6hbl4LjDtjrWPRh6Brm9fWg6PmU0zux3/YkDWv36iMFVo06qiogc1bJzkxDFFNlvlpvMaZM/rKBkbA5ijhPS2grWItlPmjSSuudXVU1ck8Q41W60dbmfACG4xCoAwdXnZ3dValuVjyCMetfwkZJi3dLiIPTDHHil9IkgJdG8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(136003)(396003)(46966006)(36840700001)(426003)(336012)(8676002)(54906003)(82310400003)(4326008)(2906002)(2616005)(478600001)(316002)(4744005)(5660300002)(86362001)(1076003)(26005)(356005)(47076005)(81166007)(6916009)(70586007)(70206006)(16526019)(6666004)(36756003)(8936002)(82740400003)(186003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:54.0625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ce3115-1e50-4d41-49cf-08d93b163c9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
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
Cc: Wang <anguwang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wang <anguwang@amd.com>

Added NULL checks before two problematic statements

Signed-off-by: Wang <anguwang@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 45931ee14a6e..327fd1909c51 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -221,6 +221,9 @@ struct dc_stream_status *dc_stream_get_status_from_state(
 {
 	uint8_t i;
 
+	if (state == NULL)
+		return NULL;
+
 	for (i = 0; i < state->stream_count; i++) {
 		if (stream == state->streams[i])
 			return &state->stream_status[i];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
