Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA48C55179
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 17:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6331220E65
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OX63yIrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6331220E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAE06E30D;
	Fri, 23 Oct 2020 17:09:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4218B6E30D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 17:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3mLZexDBQnNiiMr19cKOnMKri4jqxwzJhhgtW5TWWptiBRATL9y/UU+b7e+Py8uwlDOBud17DqKR2zYa2v+pKnUHX86u60W+MYEMqLFonpmYn5pFVcZEjuyvoDGtgSF/KeBy398K/ZTGCjMzMi2QYT1BxputblJQsxIUkhZH0aASSP0BbkGVjHKhG79KO7WBrN2HO5wA3Ryp2Y1m1ou+EVm/lNxa62P5CjBaK0rrXz5EYqydNK8iuZMwxvJNcIshx8TdHQ7k+IpsV/nirXBuJeTd2B+KxAWrtagJCCZj5TVXVwXAKeWPxinAcYMUN/Zl69DWj3uqWDKKsGNB/YpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUKeiAI1yPZ6BFZn+sdd2ZIld5lyudw6TtgDzUTD9qM=;
 b=KYGvoohp2KqtXxNqRehN9OirRl6TOtk2j0+Oggftwg7f7AzZUQtbuC5SCRs5VA/LbIh5zC6Ig4QS6Uhi8ePEp0Ne9gQO7Ym30kakRuJc/YzgcA9E3I1n/v3SSwhJfGs3zyUxvk5dWiDMZ6wYxVNbILrqGxOdN9vamOdf4cobmvzg0+1SE2cuD2yUludpGK5Vw0xBA4js7kzaQNba70EiC6LmcqX2sJpQvUiZYrfkYBCAiawmwTLhU7Y27NCObtgUabEZLE9hI2XJ2jAAdpTUmETJawCirVJA3yo49fNoEw823RwJ/9PfQW68Ao+7CBbRDnQBV71Y9+WyR97ogNNmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUKeiAI1yPZ6BFZn+sdd2ZIld5lyudw6TtgDzUTD9qM=;
 b=OX63yIrBU+2Djjj3FzoUxJybEICeR3mAzR24EqNVAcJ5wZZmVsk1uQkBUmm2WHN/BJtETaQ2OoF9MZuXtTikuSVQr5PAwBt6g5vduMGiV2ebik9i0LqtU1xxEGkQ9AJcZ2RXgvKZfdl+TMeiI1RH7uypIm6oIPWvau/g8u9GbYg=
Received: from BN6PR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:404:b4::23) by DM6PR12MB2873.namprd12.prod.outlook.com
 (2603:10b6:5:18a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 17:09:07 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::85) by BN6PR2001CA0013.outlook.office365.com
 (2603:10b6:404:b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 23 Oct 2020 17:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 17:09:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 23 Oct
 2020 12:09:07 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 23 Oct
 2020 12:09:06 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 23 Oct 2020 12:09:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fixed panic during seamless boot.
Date: Fri, 23 Oct 2020 13:09:06 -0400
Message-ID: <20201023170906.32112-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acdb423c-8006-49c4-8c90-08d877765a22
X-MS-TrafficTypeDiagnostic: DM6PR12MB2873:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2873AD6B14D79E326A0274158B1A0@DM6PR12MB2873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQYgVebM/wsskcN0s4mPDH4JSyiS+MQUMbexEQKAS6Ke6yQJqRy6BOmme/I0HTvAjVPoDAjmlJbJj0fCapZz45c/N90Scv3FoPkp4xxAwcrITmjPFU3qIlnXwfXNwnDohRnlEjAk4vv16J+mWPQ6laVsxsyZqzKUGwNg5ypOIzdod4UZushMXpZV2jRznkNuYzpxDnyqW3t3uZ+0uLbcT8NEJlATZJbM5tXeRJYCWLtGsOws/4lnkGuXphhlng99Wx3d5xQhonVVk6nvfjXMoJe2hSWfpiFj/mJ23zbNMq25ecLqTs5LQugl8urOsARzKFQluzcVb8KyB4WSldfiAiaO3i8sHro48zuT+f1sRP5S8he0VdfmxdeXhlKqMs5xL0PFT0YiKj+WjlPGScCCSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(26005)(6916009)(82310400003)(81166007)(2616005)(4326008)(47076004)(36756003)(2906002)(8676002)(83380400001)(44832011)(70206006)(186003)(336012)(426003)(478600001)(356005)(70586007)(1076003)(82740400003)(5660300002)(8936002)(316002)(86362001)(54906003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 17:09:07.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdb423c-8006-49c4-8c90-08d877765a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2873
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
Cc: David Galiffi <David.Galiffi@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[why]
get_pixel_clk_frequency_100hz is undefined in clock_source_funcs.

[how]
set function pointer: ".get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz"

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 512b26b3e3fd..589c7fb71480 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1149,7 +1149,8 @@ static uint32_t dcn3_get_pix_clk_dividers(
 static const struct clock_source_funcs dcn3_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dcn3_program_pix_clk,
-	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers
+	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers,
+	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
 };
 #endif
 /*****************************************/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
