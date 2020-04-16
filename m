Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7219C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9908F21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sPTvejnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9908F21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BC16E366;
	Thu, 16 Apr 2020 23:41:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DA06E365
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag1vd+eN/hY/kSSqlHhKV2DGDd5eGjkb9VsBRfbvcZYSsS3zmK9/owGXKc66P5FkZUii8vWBAwiE8D3XTBV/wPKHDwrp+BBj4AtFWZDFHXLqEfppbJqCKAK5cbmOex1oz7AnnqerfS9/UH50fapbhE1J5VGBscuzJ9R5dmEHZy7eDiPHQGEBouBgUcjk2f7hpkxsaP4VB8EsZtep4JEbARx7qJjGhBxDtoORf5EnWqWzAmCID7pSqjfF5PRkrj91sMHEL9Ir8YCfnxYJqKknldsGSAkrUsw2ynUgLccrP2v6mG6AYHv4xBvHjRSQbZ81z8TJTeOcUK0+StEFfpGPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9Tdjwk5hmG8+01G9lVXYYRfMbj43RaUzYp5N9Wyp6s=;
 b=Q0JXW8RFjzwpHGXuy9HMCFrWBYwOw62iZ+32R/31vbG7ThAPqh9vwpESE+PxQ4wgA5qQu/zYxLZNvvHQgBLT09uiJAKrgsikLgDAyEnW93DIggQm1jO8JyUuXKghZV2+l8uH0lnGl7nRoa7yKWVEFVP7Uo9F5wP/T9/oQhRfV96zRLeZgETewN/YrZfUMBS+rjRy95ez7Kqgmi0FFncQw8GRRrEIbWNR+As6PCW0WwNV2Z8EcuqrtH/t9YuEutAU0fdXxJPTti8GfaQEVs4Eo9I9WnTPiOBEgyu/lppbr1o9CnM6nlKcoB5AJlInhxIlvPn9m3D7hFtm3cLV8eYMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9Tdjwk5hmG8+01G9lVXYYRfMbj43RaUzYp5N9Wyp6s=;
 b=sPTvejnAht5T7Owf4mXDF/xkM/v5clFW80k6C3Tyk5UqDTtFbYjyVN2OLh+ML1LEt6IbTNtukLFmm9DMCVpXlFU63O2MrymsR3RQROsoYMNKEbdQW7fg31Y1kWLWwcVG+bjAhHUmU8G+KPZ3UOr1X5A6dffVMF8d+MYhkGkiSo4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/35] drm/amd/display: DispalyPort: Write OUI only if panel
 supports it
Date: Thu, 16 Apr 2020 19:40:40 -0400
Message-Id: <20200416234044.2082886-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:52 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8c7c2af-b066-416a-794a-08d7e25fbde7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24593CF205D7B651AF52735098D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pi2WhKhU8k4wEgj+eBmpy8G4ssmS8+Ta3/ELfqm/IfvmOsaJJc3Aft4eNANmVjBe5+i7fsx/pyyPpIVWKXEfSJdr5fDcof4BXi5TwIqB4+37yUNNChNwnFVL0M4zF1icnqGPiP3os0QR9LLpif6GOpO5sGeo18EwFmdJfkYOeCCPO93yW2ZNFtekC+huST7/9ZTDVNbAuDwNKJaeS7+96qhJ9SMD+stiBooYg9jS73qNnsDGL513jb29C997RueZhyHqQ9DaO/MSHCSBbeSMlT54pLhbNJHJkLdaQHXALSUKF01/0dh3MmTsXFrw+a6eP3xGt4u4TyUDP1qKjK8hQ1pJUPDrYr7h9RRydPgAekKaYP/nLXRvoAEuc2bw0W0d1QRSLpjPGOSHoiW8lekSvlc01avGtUxM6KdFEYsMf+KRBZNCG0htrsxTIQsS2m1M
X-MS-Exchange-AntiSpam-MessageData: EyqqsTfOgSrzgUSH0/PsW/OvuDysHeeh/IveRRbOA/NGBZhxZi18hpQcV9z0enrdtJCR9fswQIDjnwRhN1sZ/OKDKtVY7aD85I/isfUmGWxDoH477tgQ3cGqDb1dRVAHLB2oMyt57JSlc6K0L9I19XE3QEE+d7m1xHWOR9eprS8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c7c2af-b066-416a-794a-08d7e25fbde7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:53.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdgLCCyLRfxNPBWazQm5yo8tIXgyWHNnWkWBNB8EIAtwQcc/ATq/YMt31zP+M8Dby1Jvg6P7pldsjBLw2KepPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[why]
Organizational Unit Identifier register is optional, and its
presence is published via Down Stream Port Count register.
Writing this register when not available will result in errors

[how]
Read this register and continue writing OUI only if the panel
has the support advertised.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3408c36ace48..5d2ae2fb7e45 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4218,6 +4218,21 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	const uint32_t post_oui_delay = 30; // 30ms
+	uint8_t dspc = 0;
+	enum dc_status ret = DC_ERROR_UNEXPECTED;
+
+	ret = core_link_read_dpcd(link, DP_DOWN_STREAM_PORT_COUNT, &dspc,
+				  sizeof(dspc));
+
+	if (ret != DC_OK) {
+		DC_LOG_ERROR("Error in DP aux read transaction,"
+			     " not writing source specific data\n");
+		return;
+	}
+
+	/* Return if OUI unsupported */
+	if (!(dspc & DP_OUI_SUPPORT))
+		return;
 
 	if (!link->dc->vendor_signature.is_valid) {
 		struct dpcd_amd_signature amd_signature;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
