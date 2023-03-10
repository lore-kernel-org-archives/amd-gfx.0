Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0B0C6FD19
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A4A10E998;
	Fri, 10 Mar 2023 09:33:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA9810E998
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIyLiIcGM1ZQ2+vwEC0Zh4uoaEggcO4jQ8KQGWwjB+VchTU1B9Lrrlt9vLl2MYZ9UMoeh2wZSl3RXHTKV3zMxurqilKI7j9QbWRgvPMgJLsQdeHa6b/O3bDcfsF7pm1W/9mTQuVFKxVSTulWDhHccyMBPtkv39Xfs+hUmtTsXmQTFYZwiBeGcEKOiXoyrXuxcR0hoTMELwx5ZrwdDOWGg9fuNGJOnjaF0g5g+M3QmzPtQYjYOhKG69w1b7jorzcJZ0JXFWNCbXJB1O+SezJv83THrzzDPCfjJcdcROrT3/AezeMTeA39qOHwRBLZ9sE1VyLqRaLxDIl1IWud7zmKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCxsf2S9K3f9ACbUcTdvq5pqgVBm2u3RoENON+0JCHs=;
 b=aPpeHNamt+pZBhhUdNa4ZMqY9I7iyMP1s5KXLNRkqbdXYipLsZU198K7n2pFb3AUAKfelDhZlXuDMgH9YItLBXYADQKlNrlgkciJ5ZGP4COKYyENZCzrdjaSY0hdcH2nyoO9pAzFqyVd8nNdMFOMbp8P2QHOmXcng2JIb7+QzXfVWUWX8Je4jw6DLyN52IG3HCi/+Yhi49+4ogON8pauPR1ISFzU9Mpx6XyrjVEMvLU17VMFo34WiuaBAdqHNAKpI0K7a3FEXViXVfJsQsbI3iL2J4fw1pNlJh5/JPdFy0skHc01CGT64EBUFmqdltytO8V7+SN6q1vG2D072NUudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCxsf2S9K3f9ACbUcTdvq5pqgVBm2u3RoENON+0JCHs=;
 b=S035Ywc0+N2H/AISpMea3+XoBtoDWxZVZBNqnIr7Laz4TJ06gItrLyhe3BRv9AquERuB6N3yO12ZGIdVEQKtLcs9BBi+MSgS0p7SvNa8+uJnwnaN3lhIOBnObT42QeBFOk5Lu6CzALI/CtKVIbFKtZLwrozf3F8hGIOCLm8d5AA=
Received: from BYAPR11CA0062.namprd11.prod.outlook.com (2603:10b6:a03:80::39)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:33:22 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::36) by BYAPR11CA0062.outlook.office365.com
 (2603:10b6:a03:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:33:21 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:33:16 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: fix assert condition
Date: Fri, 10 Mar 2023 04:31:15 -0500
Message-ID: <20230310093117.3030-18-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec2941c-b30b-47f2-c9b9-08db214a7d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aB8XduyGkD2mWn/0PNE/2Ie5UZC4s+d0SEgxZwR8ZGKFcc2hsaAOGl6wHH6PeqNt6ni3IzIzSEHBOAUPWbyY176K/nJ3dbKWmo8LUAEV9Xq35PCrEPKvoOlQUflIqUz5LS3ugD31sfi9T0gNyoFdbHJJAaFKVWTSOIxCB3f1OVRbLa6kgZtDyv5GuqafScgJjLLKWLNYs6KKBanp0y1pvZjvWRPGo8Zr9sDaR9Sjfz7XVh8F8Ce3szw3FzgXIjLzW9EHfaWUizuXoxLBsc1Sf80ZZihp5q1Isim3oe8VeYr1RX64TUUnTNlIoiMd/SAsAcbFGQECizlrtHdhrjYGE9SGcKoC417lLJt1q2880MePSjgkQns+Wt4+VdnVZzcMnAftqrTjGJFKww9Fb3gTj/1RTn11E+gD3j+owWsT9XpbrHDSL5bQ5kLf4JwxzMSlS0WF8rj1avv0+PokvU5J9MDEaS0EegbfSgY7qEkyrm9Z5hLUYhnSNwIrY6fEG3arRRiokrxjaAJRMHqeHURzalqkTR8HlJLgbi/qcBzGY73ZAuFdlRX6+NlYkNm0Ngpu9SN+I/NHV0Zr+BvajjdoaMD9FQ5bSZUEzDF9jE+rIU414waWtV71PO11IArAU7+LtQ3eoVlmDudgv57Q5CrgrkxjZANNQOSSXlLeNAQBjURKHHLgp/1DiXA0icyJ3m2qvgom92szcvBIy2lhNAcTJtefpPrbErnuESUiS0FnHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(54906003)(316002)(478600001)(8936002)(5660300002)(2906002)(44832011)(70586007)(70206006)(6916009)(4326008)(8676002)(41300700001)(82740400003)(26005)(36860700001)(81166007)(356005)(40480700001)(86362001)(186003)(16526019)(1076003)(83380400001)(2616005)(82310400005)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:33:21.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec2941c-b30b-47f2-c9b9-08db214a7d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
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
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Reversed assert condition when checking that phy_pix_clk[] is not 0

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index adaf330716c2..47fa51c1d3f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -322,7 +322,7 @@ void dcn32_determine_det_override(struct dc *dc,
 
 	/* Check for special case with two displays, one with much higher pixel rate */
 	if (stream_count == 2) {
-		ASSERT(!phy_pix_clk[0] || !phy_pix_clk[1]);
+		ASSERT((phy_pix_clk[0] > 0) && (phy_pix_clk[1] > 0));
 		if (phy_pix_clk[0] < phy_pix_clk[1]) {
 			lower_mode_stream_index = 0;
 			phy_pix_clk_mult = phy_pix_clk[1] / phy_pix_clk[0];
-- 
2.34.1

