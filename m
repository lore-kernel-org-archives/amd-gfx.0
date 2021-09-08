Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6193CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F68060724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F68060724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C1A6E1D7;
	Wed,  8 Sep 2021 14:55:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876A96E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1mmxdUo0y5gbLQIjIEz4xWl4+WPQY+5/W1ucMltYUOiuAwSHOV+1ruBt2X4knk0eq0UmcFIrGLljSYJRWXhH3chePXWwWs54kTWM9DWhfTZYHecVNtR/1h5T82pTM6cAOUxx6Yc0AhXccSFZbB/EnNYfB9ttLdhNvIBcFd+w6c9pIfhgFz2cYF+5Byqz3GvtdbdIdeyhwh5yoo+bDgf7SLolQ3J7tCktYwRNh/2qRNxLYdoVnEgUQn1LjMbniVIQkDIF2F6gttlkcZnVTDU+ZphjuyLIY3idmkvxMuB0i10Atu2uvNviqHdU+YX3cDN+qvQfhP/tnQF8VYKOy7dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SfuR0Ijuhxa+LNFJklXJGG8C09zWMYv2efW4i6kk0lo=;
 b=BZNBi2Ou9GyJsgBN0JB8iDbZMDYvVhxc8MkhOTpT/cCmQTKgmoYVDRGiqxxrFB+NfhAtxhn0R5ik5JD4SUvBkvk6qEz0ci8HZ5TYtd8UlHn6NnlIgwThh4xZl1NU89aOIakPINlkGdmdryF8c+up0z9JLczZCo0GNSxvHlrhmHjuL0jd+jkoknqg0cSfUzXt7i0WblI4dHMb8SUcqPYb/GfJy3yvOyECQ1YH7vVWA1r+yGyvYj5n9MzH4+EEG2ZZilaaBeRtx8aD+Ujuv8a5/jsBo+jx5Qn/vg4wIEyxTeyVBM9hADi9KFC4BusFF1j/Rs3u2rwMSG1SzhoIE2njjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfuR0Ijuhxa+LNFJklXJGG8C09zWMYv2efW4i6kk0lo=;
 b=Rqa7eBh6TddjXdltrIg5+JLPeuRXfS04oPMpdbJR7G+j2qFd9I8RDZk/dfip7lCY9qqO2PoY1g9WvrY4QxFW267txONqGZi2+t0RRamWrM/Se67mDzLKArs9XB1nVql1EdLI+JjvT3GyquR1COasY4EEzE70aQQy/6jnRbq7pYA=
Received: from DM6PR13CA0060.namprd13.prod.outlook.com (2603:10b6:5:134::37)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 14:54:56 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::3e) by DM6PR13CA0060.outlook.office365.com
 (2603:10b6:5:134::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:56 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:50 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>
Subject: [PATCH 13/33] drm/amd/display: Revert "dc: w/a for hard hang on HPD
 on native DP"
Date: Wed, 8 Sep 2021 10:54:04 -0400
Message-ID: <20210908145424.3311-14-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57994c88-e408-4323-3b51-08d972d89f8e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2708:
X-Microsoft-Antispam-PRVS: <BN7PR12MB270857436B7DAEB7875A121EE4D49@BN7PR12MB2708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oB5ugG8RUYbmEvQEXQDgXKr5hO8N8wciTIL5lCnx34PccqYZQ9JISeUuYJogPSuLhA59f0KNnH6K2VbQmHjJyoGhguNEFMGZ3p0dWutXt4iiLvx2G381h+QPqBsRM0nMJ2rWAQ2PYOTByC+y5Zpv9Y2kbzQ5jpY4+noW5vLTcOuzePPLNqK1e7mhCchyH/canmDFgQBnGDj5s9wE2JZv38Z1Nxo8QLFL5e2gIq+fUncdVJrRtcvx2znOXUVsSeu2uvspdHQYSMlZPdK32QcP2J6jflLuJpTUDK5EwiZsSgUQyRSSaBtygV602dG4r8yvIX6HzyfnRFs/SzIeB8cwpy0XpF627V3GuBvsCGMjCyRxt81i80UpnYkLrKHEWajmBs/pX66AfMHN072pPUqgP/iJX65CDAw5oBGRiDCJyP40LT29FrQYzvziS6cg24DvXUx1S8RRDfvsZAWoPD6R9Q6tliKSyN7GnkCMlVqwA1uSVAAfE3aE72TbisRjeo1umgnwEZn1lwEZ477xp2ROYhgsGWU9Odp1+9H11UZI5F1wR7aBpZrdXNUBcWev+Gap26EZa/aUyE2rZpYWGh3N7/+peJ8+0Vk6dt/sjl5trRxTIvXgFxTM3Yl3bVHVslfIHm6XBvLRglS3XaLItLNw+Rit6k6B91Z8S2BOzw4uV1251TSg2iQ54R5iJN/6i02RVC7RDIyHkdFUbmJo4mm9U4quO/6jicJ+lXm7f8TqUE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(6666004)(47076005)(1076003)(336012)(54906003)(2906002)(36756003)(8676002)(426003)(70586007)(70206006)(44832011)(2616005)(86362001)(6916009)(83380400001)(4326008)(82310400003)(8936002)(16526019)(186003)(82740400003)(316002)(478600001)(36860700001)(81166007)(5660300002)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:56.3987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57994c88-e408-4323-3b51-08d972d89f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

This reverts commit "drm/amd/display: w/a for hard hang on HPD on native DP".

[How & Why]
Revert change as it does not fix the hard hang
in all cases. An alternative w/a will be submitted
separately.

Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 6185f9475fa2..c6f494f0dcea 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -66,11 +66,9 @@ int rn_get_active_display_cnt_wa(
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_stream_state *stream = context->streams[i];
 
-		/* Extend the WA to DP for Linux*/
 		if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
-				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK ||
-				stream->signal == SIGNAL_TYPE_DISPLAY_PORT)
+				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
 	}
 
-- 
2.25.1

