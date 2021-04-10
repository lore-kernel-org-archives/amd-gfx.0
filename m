Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FFDC43460
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A55610CB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A55610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5791D6EC74;
	Sat, 10 Apr 2021 02:04:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F97D6EC71
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSK9w97dwEDSezjYSKYjbAeckllZOb7k0dE7h6AeLoc1XzWi71AEzEA9fzJ0k+ks16J7M03siDWh1KO146Lzd5Kgr6sxoUZjnDAEx68Amg4AxwvibDiB8L6aRdif55nQDc7VhTwvAmbJVhqWaZhYBljiVRVZ4x0hSMTf/YuHDJ3u0KMDJXpQ8PRfSFgVKwMfgV60FHoWE9B17CtiTFKHgs39qutrZ1GUi7C8rNw+Wyw2QsF/b1Fpo3zifjIG7F/jyBZ8nfMU17Llp8Jf0IhUrhwjIqdEOQmSQ/RpzTyONChqyGlbBPG2EsoRXnzJ7L5e2jQXJr3PS3Xyi1F4tiPfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpsrYPvoD2ubIIEpJFjxJr3HOZTd/WhhkEzzV9k6uI0=;
 b=ERumeha4x7btHrLLKIQJ5OLHYIA7vyNAEVqzbPRK7o6Bvbulcj5Ba2iXWYsr2mAmIZ9apmIVu7zZCHKoo1kcz+QazJO/kqgXWADJ6noBrzVKiVp/wRjbKsHlKBnJKWD2yRJOJFoeLDINI35S/MVXxowPMKL08lT5FKHEwwNArRB7VaHD1d6P0rn+RxgCJP0REQivqlCWGsLiRag1cFDP6CrBRSxXPWUqRDmDspZa/8CPQnbuc4kraT68H27eVbThx1dTXMK7QV2f2jNSovf+APT4Gz9mQdUB6+wlC2IgafUbwoXQqB/dH9yJKRNGGopH38Ow37y7I5v5rC/Krh5PGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpsrYPvoD2ubIIEpJFjxJr3HOZTd/WhhkEzzV9k6uI0=;
 b=CHR2JRE73VVJ5Vfhz+K9hUz9KDBN3ahNqP+Zdyb7AHjm6NqeaWgNmEXJ5agjuuPykvIalE5dGla/DtEL5WAriWZsOKsVCP0oNAjbUFfmOu3Hc/WLRnB01DVA7axdjjyYteBdBQ8XvxsR30CBzG0zkZ4AlCAsTb+wZ5OG+wc2X0M=
Received: from DM5PR18CA0050.namprd18.prod.outlook.com (2603:10b6:3:22::12) by
 CH2PR12MB4645.namprd12.prod.outlook.com (2603:10b6:610:e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Sat, 10 Apr 2021 02:04:47 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::2a) by DM5PR18CA0050.outlook.office365.com
 (2603:10b6:3:22::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:46 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:46 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Fix DML validation of simple vs native
 422 modes
Date: Fri, 9 Apr 2021 22:03:50 -0400
Message-ID: <20210410020401.1100228-6-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84fe380c-3502-42cd-87c3-08d8fbc504a0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4645:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4645DCA132F706A7E27719AFF5729@CH2PR12MB4645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kl3rmtmtrj4GtDcBapkxTO7ZqMh1ybNUcMOB6RYZOMDY/CdaS+iW4aEtoyu1Yfmdk1wBYBiYax9uUKq0oxBG/Bcm/NztUdIwK3d6bICzzg6RZeRGvz1W8s9ueeu7diS28PQ0F2hOMFynJ25xgwrc8ZkcxkLHOZBm8wc2dWMGZfmnBJdAdTiQXuw5cA/OMXY/IrnxghQsXM4FjUj7ClFuK2nnw8odCPbIGifDfmceeIemmR7XwUZEK7WApR2AMQ15EonxjagXrmxuGEPtfRCMNanocEtyAfzpNiOQ2Gfav8I/eFAgUDmSnWt2JAASZDKPOER5m4cmC2V12sOxGs+Bf+QvEesB0aQ3ZcBduCe/4mKgAQWBULlq5HAtRx4vEJ8yMQLKGWYW7M579Xq++bAy7oFJMifBrDwmgTFgzVQZpm2MVJrOC7fBKjQ9DINMm0jhHbZCQphT/M+a1dchYabNMrH0/q18U/Z4qIZFUw7K+9J5tPU96djiIpFflSomkZ1VpqD539R/ypue0+1Opt92flI50vaZaU50ZRVixUKMR6qq09/5/HmVag1E0vhhqmC/UBZ7KP1zuP/lZ8INA6PWsZmc4P/6HLTLYULLco0etB6WnYtjSaf8Z9F/HCVTXW0jB+pC46Hm/oQk2WhLClWfMluwYo+Nl4oPc3/SrHg+Fd5HnmBMwyldPf0btRp5Da/7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(7696005)(82310400003)(2906002)(1076003)(82740400003)(83380400001)(81166007)(478600001)(356005)(36756003)(8676002)(36860700001)(8936002)(86362001)(47076005)(54906003)(336012)(426003)(5660300002)(70206006)(26005)(4326008)(316002)(70586007)(6666004)(186003)(2616005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:47.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fe380c-3502-42cd-87c3-08d8fbc504a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4645
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bindu Ramamurthy <bindur12@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We're always validating DML with simple 422 DSC even if native 422 DSC
is in use.

[How]
Use the mode configuration from the timing.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index f65a6904d09c..527e56c353cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2201,10 +2201,11 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].dout.output_bpp = (output_bpc * 3.0) / 2;
 			break;
 		case PIXEL_ENCODING_YCBCR422:
-			if (true) /* todo */
-				pipes[pipe_cnt].dout.output_format = dm_s422;
-			else
+			if (res_ctx->pipe_ctx[i].stream->timing.flags.DSC &&
+			    !res_ctx->pipe_ctx[i].stream->timing.dsc_cfg.ycbcr422_simple)
 				pipes[pipe_cnt].dout.output_format = dm_n422;
+			else
+				pipes[pipe_cnt].dout.output_format = dm_s422;
 			pipes[pipe_cnt].dout.output_bpp = output_bpc * 2;
 			break;
 		default:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
