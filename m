Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5977C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79C761A2D
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79C761A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557666F4B7;
	Fri, 26 Mar 2021 22:06:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3035C6F4B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6j5nLjpGEDxAa6TVw+j+Ujv0U7LU3xz2USPsi8tns/TLIkpQfduyYnuY0MhoZsl93zeZpgbmBWfbuNmz9PtQyYpbqwQ+kw7HAstUg+oQxWnLA4v5azMN0MRBi3qAo5/NDwJ4dq4egwNZWyNqApZbtyLH4qER3ctOWO3lJ/ZKNShsOpQDhSP8sOsD1If6ShQr9FHPixnNP43lt0rIh05CFzFUGO2N2jjv6EtjQKJKfmlg2nwVLsceWLIbffdOMggrtaxducKI+WSAYFqqqtOg7/5bxm/pJX8c5VZdrZC3b0ENfD5KI+StlgLomrn8iUPbMY5PLKbQuTHAvLUqNT2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn+TmxyiXFeXonmvuMJM6ymTXDdb0D5txqDCoT0KT0s=;
 b=e0ELUdwg5+lczYumJUoZMoBB/eTZcWd2YjetJcnUiEfogH80BiJ7ZzkqsZJJqCQK/wEw0AKwLFfFd1MDlvNfuJDYtIP/k6t/0F3MpW7g7sSeqKNSlp/3VAN+3XWD7GPZLwyF7YL1pl+JTKSIo541pVuEIeFgHB5X7+Jd87SD/CZQYHH6E34vV6fbL0kjbWAV+5lyH/EIpohCYplNzabgYMnshInZyI63/eCBxnw/+VRy+2RYqtmVek+/uuUrTFoNihvu82OBrTQx1KX7ywh0YBxWu+dj1mS86N8KZzjPKYI2W38IMksHDeQ45yEM9m6G8x/fiOKpblg+JQtWcdbZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn+TmxyiXFeXonmvuMJM6ymTXDdb0D5txqDCoT0KT0s=;
 b=bNohLk5B6HUcP53lnKh31/CRiHOqAIpW4+RhQ4I42qQJjkKnKeUomw+wJO6xoJcn/XDkQEN4WjyockA8kBAB8/WNfaHg4HBu/bJ+Ot14dRMuL9LnVr3nasmS9cqMJnrTyvdm2GhsbwoeuvsMrP+dCLzunmfAhGoFshRgqZtfyhM=
Received: from DM5PR04CA0059.namprd04.prod.outlook.com (2603:10b6:3:ef::21) by
 DM6PR12MB3772.namprd12.prod.outlook.com (2603:10b6:5:1c3::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Fri, 26 Mar 2021 22:06:01 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::c) by DM5PR04CA0059.outlook.office365.com
 (2603:10b6:3:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:00 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:54 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/21] drm/amd/display: Fix typo for variable name
Date: Fri, 26 Mar 2021 18:05:21 -0400
Message-ID: <20210326220534.918023-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4269a22-9ca1-4721-2473-08d8f0a35781
X-MS-TrafficTypeDiagnostic: DM6PR12MB3772:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37724D18D56EF085247A1F5EEB619@DM6PR12MB3772.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FOQmcp8CwY4NXRsl2m9LVtyD2i8ZOFZJ3LfAGPIm8XrNCqXn1FwNCUSwTXFkkSvpwHHdL2Y7AfwVe4xXdq5j0Jm8Qdq7dwi9hoMDI+yyL27tKZQHvaxrxD8rLU+BwGR+CjxWnW6xpZJRa3vUs/K+0mQ/Xn7kbZeff3p9K934yfDC5EJtGWx2bozpVYsF3LBKYAcbabF2fsRHQGCuwUfupaBn0hD9OqQPB0NQt3Cgmly+HWJzrVdfqOysRqav4YsFyEk4ax5Z9HgGgA3fxF07GgPdbUud43/HcorNXxzNR4nbj8xBvW4t9+kMjDKp1hs0YaoSArQA+4WtCVN/pUK7YYbXYLiXoMmfxEEePkf++Q5WdldFFXRnwDNty7GhUt4/mXFVcdq64sahJm9u5CU3mBYXP7T4uEcwbRXT4lArmQ5idL7x0ENwGSnT1jX1FFxUlTtj0Jv8FO+2KeEP2UYQLe/2Ffp+R5IBLbJ2JaEct+z/QTgTQkHYrOhExIFtH55rTXvvkMpZriHbX+CAplvO/soP2c0IHIWjxb6Ok1HiE1LmEU5miDQEnKYsccrnqCO6HLJJXAC4dxEff0pkbukgAFNaekOAvaItW4+mbyR/KKs7iM83kP+1pmy6WRjddtfKDZeHcTxrE6qn4XIHDNXwGv3uIwYIyNq4HdIASaeKDKRKuZPPLfvbHp4iztf6Px7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(8676002)(426003)(8936002)(4326008)(83380400001)(1076003)(2906002)(2616005)(356005)(36860700001)(82310400003)(5660300002)(47076005)(36756003)(186003)(81166007)(82740400003)(70206006)(336012)(26005)(6666004)(478600001)(316002)(6916009)(7696005)(86362001)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:01.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4269a22-9ca1-4721-2473-08d8f0a35781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3772
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
Cc: Vladimir Stempen <vladimir.stempen@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Alexander Deucher <alexander.deucher@amd.com>, Bhawanpreet.Lakha@amd.com,
 Bindu R <Bindu.R@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[why]
Word "remainder" was misspelled as "reminder" in
reduceSizeAndFraction method variable.

[how]
Fix the spelling.

Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
Reviewed-by: Alexander Deucher <alexander.deucher@amd.com>
Reviewed-by: Bindu R <Bindu.R@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index e0aa88a7766b..e1f33f908b5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1893,7 +1893,7 @@ uint64_t reduceSizeAndFraction(
 	num = *numerator;
 	denom = *denominator;
 	for (i = 0; i < count; i++) {
-		uint32_t num_reminder, denom_reminder;
+		uint32_t num_remainder, denom_remainder;
 		uint64_t num_result, denom_result;
 		if (checkUint32Bounary &&
 			num <= max_int32 && denom <= max_int32) {
@@ -1901,13 +1901,13 @@ uint64_t reduceSizeAndFraction(
 			break;
 		}
 		do {
-			num_result = div_u64_rem(num, prime_numbers[i], &num_reminder);
-			denom_result = div_u64_rem(denom, prime_numbers[i], &denom_reminder);
-			if (num_reminder == 0 && denom_reminder == 0) {
+			num_result = div_u64_rem(num, prime_numbers[i], &num_remainder);
+			denom_result = div_u64_rem(denom, prime_numbers[i], &denom_remainder);
+			if (num_remainder == 0 && denom_remainder == 0) {
 				num = num_result;
 				denom = denom_result;
 			}
-		} while (num_reminder == 0 && denom_reminder == 0);
+		} while (num_remainder == 0 && denom_remainder == 0);
 	}
 	*numerator = num;
 	*denominator = denom;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
