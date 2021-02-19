Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8CAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C933B60C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C933B60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5B86E0CE;
	Fri, 19 Feb 2021 22:16:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DC46E0CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb5wYkmISBtem/ed6sE0SR/Byu9uJ1AdOcPxUfHiwCHxGvj2GE4AB8ynu18DwOOrLhOldodQJdtqhB5+77SIhS5Il41RNdoQUpyx4NoNomncmGDRYOsri8tctOqAivvE+cRXfEu/u7iz+f18UN1TwzDuxrtvIzT9cgBxkg8mxjk5WYkdol9ejFk2wgvoqIKO12PfBn7Nu/oBWog0Lln7D0Sma9Li6sTnD4SPEQnuOgTBcklkpCy8j4dU30TlnhKGUbDnFD67Epqc6Oecl9Mr+fb0N1iSEAM9NWLMcM8FULvjY2robikzOE5uN03Zx2fjQK5XnOV/VuMeQ3qRV5ke9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48txlWeJMdnYuEEI22GqkNPyphdIBBz4mOm4zQIlcKU=;
 b=OVO8+LnFdITDTsO7Y6I26h7zj9m5fwpKt/WZvjAfVYKYbriCGeRRbsr7/bPsMD5wT+6xraFr2ayFTtl3Km9bGyZJv1+cxFfcqIh499UufV4vexGMSuHviB193Xn4k/ZnK0F8/9BkDHR0UMh2QZqF9uqyW1Tc1agMTS3lHcEvWY+WmK53cYpL8J2UCLgkpijKyxaHNOnvTbRxwboxPlFrMQwDk8x4lVdtii6Ij6TnqhJAAiH/EpCzCNw7dJE+eHljOx+NxA1TCHZ/bUr2+i6u71KVSEmss4vqdMon3A2EchnpTvwawc1LVZ+5kuEKtMiw6gYuG2wIukW5Q8npmLkf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48txlWeJMdnYuEEI22GqkNPyphdIBBz4mOm4zQIlcKU=;
 b=5d85M81pcoP2+4mgoG7yWemBwQAhPCC/zIpqJ3yotJSNIa6eU7Wql8hl5HEHYcNl+ebsj5V5bt00nxUBI3pLrcIvgKMthPro7NXqQWtc6z3qrRK9iD53qIrhKjRzP74hDPVhdBFOVpCcwFSdOv2U6EunEXZf6DpHZY72WVhHCp0=
Received: from BN9PR03CA0857.namprd03.prod.outlook.com (2603:10b6:408:13d::22)
 by BN6PR12MB1874.namprd12.prod.outlook.com (2603:10b6:404:fd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 19 Feb
 2021 22:16:39 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::11) by BN9PR03CA0857.outlook.office365.com
 (2603:10b6:408:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:37 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:37 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:36 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: Remove Assert from
 dcn10_get_dig_frontend
Date: Fri, 19 Feb 2021 17:16:00 -0500
Message-ID: <20210219221612.1713328-2-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d0e3c35-ac9f-43ee-6721-08d8d52406c0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1874:
X-Microsoft-Antispam-PRVS: <BN6PR12MB187436930E27E466EB76D875F5849@BN6PR12MB1874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VL6Ugm0ULUNsIKV06Aub3V4TNcoEQCYOTp2P6agU5qlLhg6EHQWGePq2HzFAEEbL6+ykApdrMZZYwsC1A8J/Vqct1OExKaLHnJ+O2Bh8+jmWAI3LlrQdHiqS82Y1CP9AJvxgIwWY+2YYVBOWDz/59lk+6QBtAuTq1Hi2rafWKWNasn9yEsgr6gn+jEn6yQuUwMw25uaFi8lapHy6bEkIW+2TmmTGBG72jTOoWYIs8nq8iNijfdSpZ8Vn9+SRRxS2xmaNXBuYA7h5XB0KfxcNiz1B3NvMxFHoZ8/gS9wYkIKLj7GB187ZA8pakmLq6klbHc/iEz+KZAxxRZZgfMLxiylQ6oJQDS2oT3Wzir3zoFzNzVgW+eqqzo9t3SvkEK/kHm67Fkp3Xp8wz2ctWsWEX4+KtNszFBdHN4BJYQD5BIedl0Sqq3Wa3NQ3U3uCFT1App86Pd00cqUmjvp4E3ujkhl5ATVNwh06juLKyPQOp3knFBdkrI8g9VgH36nPOZR6sQYpv/uJsDfbChuXNCglj+FNwXUPSbv0MBUmIcehTG98+KLWDRGrljSl19huQxmfvqqzeoNyQUnleMDVz6ysNDM7osVflicjpksn4b5l5B8QDfXCyTMTmBRk6WS+4HpVkbSm8Dn8jD2NR/fasJsKfMuCS6MnixwRz+eM+PsvDZUoOi3lh32JFlNhxd7B2uRh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(81166007)(8936002)(6666004)(356005)(186003)(8676002)(6916009)(83380400001)(86362001)(36756003)(2906002)(70206006)(70586007)(4326008)(7696005)(478600001)(5660300002)(82740400003)(426003)(2616005)(82310400003)(1076003)(54906003)(36860700001)(47076005)(26005)(336012)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:38.1296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0e3c35-ac9f-43ee-6721-08d8d52406c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1874
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
 Aurabindo.Pillai@amd.com, Eric Bernstein <eric.bernstein@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
In some cases, this function is called when DIG BE is not
connected to DIG FE, in which case a value of zero isn't
invalid and assert should not be hit.

[How]
Remove assert and handle ENGINE_ID_UNKNOWN result in calling
function.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 1 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c        | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 59024653430c..e4701825b5a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -480,7 +480,6 @@ unsigned int dcn10_get_dig_frontend(struct link_encoder *enc)
 		break;
 	default:
 		// invalid source select DIG
-		ASSERT(false);
 		result = ENGINE_ID_UNKNOWN;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ab93da667d51..aaeefe7eca3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -539,6 +539,8 @@ void dcn30_init_hw(struct dc *dc)
 
 					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
 										dc->links[i]->link_enc);
+					if (fe == ENGINE_ID_UNKNOWN)
+						continue;
 
 					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
 						if (fe == dc->res_pool->stream_enc[j]->id) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
