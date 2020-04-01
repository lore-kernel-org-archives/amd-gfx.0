Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A85C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 08:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049F2206F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 08:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xE7e7Sbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049F2206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845B26E22B;
	Wed,  1 Apr 2020 08:32:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C526E22B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 08:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+ExJgq1NijhEcsMHLyJS3dkz6RPWPlB7YlBHT5AwFNO5BGuLVwKkBGVBC5K4LWR0ZPP+7Lbox/aHgBVBa5a5XeXoNpfS0w3VMvI3n3ZruyW3pN0Q+9v0b7TMzkQnWYUph+VgjtQNHdfbrYTNTGutxiLswKuTystD2eUe18F65KJf2NcsSvNe4jo/sXtkcmFiMLvFsKqlHc9Ef2Dmq5qRFF7Mkepzjdc97NfscfBtsERCOwZyMXOQMxpODFdju1+YDXvRVjO9fwHhFBEqr+KYQ+pFVLzF9kh0FDIKY09/pZ6ekw8MtRd67oq3ki/G40OdzWeB0Pu62bsBa7m3/RLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Qd8/TKA5j33Cj51f2xFfFvOlfibc7tbdPWZRsn48Q=;
 b=HdFVlW5GHgU7U8p6IJLOYQhK7bSlOMtzmcS/1pHRy5wTGz8jNJl8hGYwQe/0yCTi3pO/q8bqyyhzIKSSZyEregDnpgmrW1F860VlV8BfvqY/+qRTEmtVn3AnX/KpOKmUOT8bs7dfk89DIR29IDbKO24QQvBX5k9C3Zj7mCgqCzyjmRSeIxZL+78kLk6FfN6+YQwEys/fCwTtaDNzZaCxl7GifIcska1Fle4I7udhpPOvDLp+nD2F/Hd/LnEeolz5/giKTwgAVkxMLhLBufSWjzR6OKaEGutIlTTd81G0GWu9nYsJy2dxDA8v+nyi6G/4sZnq/EqVVv6tJ83FdbXADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Qd8/TKA5j33Cj51f2xFfFvOlfibc7tbdPWZRsn48Q=;
 b=xE7e7SbvVIPw4AU+JUw1eoYhPZ/uBCOW9OpHpL9KsBHLmjSX2OX0TDVXHy9d5v9e6qV86X/hWhO4F0RumuLzHKzsg+wWJiNqvYg0EvmjxGH8LVuzGpSwPKMdqiDKZHUhSNdPISuQvb02yFdAqtYxsDHn9pzbEnjohSjYlhwFpsE=
Received: from MWHPR04CA0070.namprd04.prod.outlook.com (2603:10b6:300:6c::32)
 by BYAPR12MB3367.namprd12.prod.outlook.com (2603:10b6:a03:d7::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 08:32:00 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::a7) by MWHPR04CA0070.outlook.office365.com
 (2603:10b6:300:6c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Wed, 1 Apr 2020 08:32:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 08:31:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 03:31:57 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 03:31:57 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 03:31:56 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
Date: Wed, 1 Apr 2020 16:31:53 +0800
Message-ID: <20200401083153.16668-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(428003)(46966005)(7696005)(82740400003)(26005)(8676002)(36756003)(356004)(86362001)(47076004)(70206006)(478600001)(6666004)(336012)(1076003)(2616005)(70586007)(5660300002)(54906003)(81166006)(426003)(186003)(6916009)(81156014)(8936002)(316002)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35866800-61bd-472a-527b-08d7d61725a6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3367:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3367D7FAB6A8B4F94D057B438DC90@BYAPR12MB3367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFsl/DibB7GWjNrCjtThqrW51cADUq8cLvtqS4BDGDI4J0Rzk2/5bYNtHvd3GGnvmf4D1FxxyCmqKel6HxEaBs5VsDhl/3U9qYSA3zxR8fBMQefT8qhbodVy41sM6oTRS+hV4G9iuQhcfQr/e+jOPFaUrUZk7hxMD+GR9vvWsBiZGRjAUj1R7j7Pym7VHbftJpdzKeJFXFZzFG9qgAqOazB4slOquNApBpfhousGjmx5gdqM4fDPJsuO9Iws2cNeEB0VonyOVo0YNYALPy4DWxNzfvtJsdZFB6xYlpO/w1l4d1PuRtfNSWiUCRB0wyqIqR4YRRXeqb5r0x1HP5afB+LeI0nR7oOiCRkyAOOMbtTZfJEwbWM6bPhJl4ZWe9g0eqnEwZv9ldhxlJ2JfoUO6vnDPFp6ZbFSKTsCW8INz9Xi4mZl+Of22SdRndLWr8mi2SrLbxQbk+R6Yp08JzjJMxyi9wPWBoktH32zucaYifoqJTg+ayOOcSWBr+hoMOtE+kBwxZONuWusHD8c2jig+g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 08:31:59.8734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35866800-61bd-472a-527b-08d7d61725a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
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
Cc: "yuxiadai@amd.com" <yuxiadai@amd.com>, Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "yuxiadai@amd.com" <yuxiadai@amd.com>

1,Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2,we should show the current working clock freqency from clock table metric

Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 ++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7bf52ecba01d..5adc25c8f6f4 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
+	bool cur_value_match_level = false;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
@@ -297,7 +298,12 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
+		if (cur_value == value) 
+			cur_value_match_level = true;
 	}
+	
+	if (!cur_value_match_level)
+		size += sprintf(buf + size, "   %uMhz *\n",cur_value);
 
 	return size;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
index 2a390ddd37dd..89cd6da118a3 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
 			freq = table->SocClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_MCLK:						\
-			freq = table->MemClocks[dpm_level].Freq;	\
+			freq = table->FClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_DCEFCLK:					\
 			freq = table->DcfClocks[dpm_level].Freq;	\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
