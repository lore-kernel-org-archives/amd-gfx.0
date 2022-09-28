Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2489C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11AE10E9CD;
	Wed, 28 Sep 2022 19:41:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEDF10E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW390qDFSIJXldSBo/NZi51YEFl1yLFyVhN2BRGSKMYueiS5TsYSvog4UtEL6VLQLgh0WeyF2W7KJCQD+UssRrXK+wsFG2fBEUQKwuXHRVkM0pHVDMxBurSMsySQPr/uAXJbZWDlppwKh5n03UxlG4ysJ1IaRafwRs83kVXCR3ub0i2/lp4q1kyQiE5tKq75ZvMnDmhqbABMzXIFHx9dDN7T7GzBz6D9+ByKP1vrvNQVDoT0xCOiWe1LGZKrTQ1/2Ax7rqwm16wHWYpMI3qHVEkhVDNBCA6YqbfxNJ9wkyt06WeNu3pAOgjM0Y4QAviiIH0+g7Slekhr8ka0g2kprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCh1tVElD2ZEyUrxGwLAuOeRZ3phq+hzbfyqzWCi9+I=;
 b=VUrs8fi1lpMD5w94DITzax5a7G22XLhRVPfyynynJp2XvSuaX/OlWSOpozZK352hneMS49gEtLFl72f3xsQ4Trhl5oBN34fhio5eTbLHTECjxDnTvYlSJMix1KUk3UV8T4AeeXxkmsCi0J2aM16UBaQc5UGhocyuxlsHkqLNoo+ngz9iyVYjjOph2ADJJHL6SdDPeceW/LGzbK88WKBwXW8girkJyh1gtF1xPWi1yu34cgtUJLmgSUCVIgA8Ey4sPtAyjWnnXzTZ5juPSXQG0ZsGGqtcFxPJRDsW7AWPkYCpCROSuNw/gctgjKdOLIPGaj4rzNX7DBHrF2gROrO+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCh1tVElD2ZEyUrxGwLAuOeRZ3phq+hzbfyqzWCi9+I=;
 b=GnNwudg/mOu/IIjWX+pHg3N4D4m6km45a+bTnHEhmYyyvZltP1CNFgGr/hF6ByHPlqXpK7astNjYw8pdIrnmqe0PiWg/Q7cLZ0bI7RQkz4XvUAT34wrMQ/kp+eIoiNitShbHHPp1rDSwRksUc54BG9CmuB3eJ5xN7+hCVIE13gU=
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:41:42 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::1e) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.29 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:42 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:40 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/36] drm/amd/display: unblock mcm_luts
Date: Wed, 28 Sep 2022 15:40:24 -0400
Message-ID: <20220928194028.144879-33-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b6a66c-4776-43f4-35d1-08daa1897828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIAmMe5tg8J2OqLzrVVYBtF23B8xPMYh/UUI7R8Tj7/mA9Ug9Me1/Ns9ToIwCauXXe1/9BoV2zWx5uaF9yAvRtmr7ISuVNwblbzOJO5yR4r7aE/DkjsIsxSlQcEwyY85GVQdlbf/MvvB03vEWJ21FbSDdBPsardxJS59bZfLQnlvINIpHSsYBqVvwLlhOY63CIliiDWB3lqFK+VGwGJ3MEgynaK0OLndc+tlFcsGNT+wQWNJ+ksUauxPmYWhhehJCDjy83hd0j53NTZ67y5n7bmZ2vfDad9a6aCrZng3yPEtkbspSh6gjhLBlyhIsGTr7v6Jd6a9zlrpEKi73x2A72/mAyzFDNiK5xwuvt3pHK8WnOr8sQ4OP52WvDAGlGHU3c3YsW+8FEh8g+exxi4ICs66yfs7G6v+XpqxgXWONCl2w+kAi8egT79VjjXd4bgm0ZkpirOKYsdYggDwiGumuOJH6qh9h/1G2/fdSEjGE2Dk/iIl484Z7k0iSrBY8Q7wbWCr1Minfrj2AZK7UHGyarfcxoIXMtOHX24e4NjhrTltFFWPvd+m7ieWzhFngnOSOzKfcZwMd6pjcutceJizpRl/Gw5CT+u5P3CjhPmud46GH+dKpFyiGyhGitMgX+zHjAyEAnDrm5G9IAxZ7glOLGyhkXbdG6g4LizQ01TwqvuKb804hQoKsBfgQcZI1ck0lC48VnmEFjrTljhijaK3GC35UFS41AOiEKucBruk0f+RyNZzJ3G2nzaG0iz1sfEk+M0j1RZ8RTgytKUa0RMNNFSulrxgocGORANrn7lOjlv7x6gc8vT6mUUsehPCZCuzjjYYk4uchB27JxzvsvOqxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(8676002)(4326008)(70586007)(40460700003)(70206006)(54906003)(6916009)(81166007)(356005)(36860700001)(82740400003)(82310400005)(336012)(478600001)(47076005)(16526019)(26005)(6666004)(7696005)(426003)(83380400001)(41300700001)(316002)(8936002)(5660300002)(2906002)(44832011)(1076003)(2616005)(186003)(40480700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:42.4214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b6a66c-4776-43f4-35d1-08daa1897828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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
 qingqing.zhuo@amd.com, "Leung, Martin" <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leung, Martin" <Martin.Leung@amd.com>

why and how:
needed to fix bad assumption for enable mcm_luts

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 8012a48859b5..5213f4443531 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -630,10 +630,9 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 			params = &dpp_base->degamma_params;
 	}
 
-	result = dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
+	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
 
-	if (result &&
-			pipe_ctx->stream_res.opp &&
+	if (pipe_ctx->stream_res.opp &&
 			pipe_ctx->stream_res.opp->ctx &&
 			hws->funcs.set_mcm_luts)
 		result = hws->funcs.set_mcm_luts(pipe_ctx, plane_state);
-- 
2.37.2

