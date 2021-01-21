Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72170C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 14:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EDC239EE
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 14:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EDC239EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F25389FA6;
	Thu, 21 Jan 2021 14:30:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A405189FA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 14:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu6YCkRtlLdkX44Xi+bH3eZSQzJVgC83f5xtiwt7F0HRXyJ481GYIkYBCk5OU2S1PT8+UzBzp5lWICGqtCOKXAoeTKHfzT5jZZdGlR6Q3S6e9H5NPkA2+JqcCLUAXKPjqHILmGTGt7ASNs2741K26O7nqyHco/KKjd7zaTLdHlaLN0NuvVo67qwcIvBZ6+rRam2FqBcIQBfFQCUGYOgMBPhz379di0Jk5Hqd2WiD6zaGuwOAIZ+V64kzvz15PvtVDB/IROX1hndR879VgGcou7nH3gQlkr+cLYLF4kyMXdSItIlpvC9EB0esaYT2/ENNCwKWFfdhGhtU7pG9nuzojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zder7Nm+OWdwIqrl3bw8w4LSgw8ihFrgMEPEFFJusGQ=;
 b=Z22DW78d6MpbO9sosk+2f8shmUuvgH3z2b3A1gLrPYQv3DcbCMmX1clq19t2kWfNBeXXEP69En4qorvBLaHF0Z7r3mIyR7KyMR9A7cEAhNU+EXJt1H1ZDo0ZFpaMpHz+smn0WxfekpH7imOd5SZsuNnUM1mV0KR6tK03Xa+gucFsRrHEzmbWCTTMh9srPjjjsEIpfPMoAwSZ0X8MVGdEBFXibjK/elIkFZrsCZwtTBcMYmL/1lBaq6uyFG8lr4VR18866jeQAEgKfoB9mpirhhTQDf7rpdiQ3AaeGUVy6RgUBHgMV27Sln5AalyObgJpKQDsAiZbwOx1SaK/agInJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zder7Nm+OWdwIqrl3bw8w4LSgw8ihFrgMEPEFFJusGQ=;
 b=lFSy1EUxWr2+RqsHb0oLRq5HIzUutGJ4g9+yfkEi1G08Ee9o1IsQcw9ccVieg1z+JAOGvJ2AXZCkbWuKlWSHPi5ACRNBz6MknDwx3V943NTynH3VtDTe0ysitrI6m5nmSiy/Xop4o0LLtazpDRgyxc8dOrr7+WBvgCLdA2iOqks=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 21 Jan
 2021 14:30:08 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::b803:7e6e:40ec:4a0d]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::b803:7e6e:40ec:4a0d%8]) with mapi id 15.20.3784.015; Thu, 21 Jan 2021
 14:30:08 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] Revert "drm/amd/display: Tune min clk values for MPO
 for RV"
Thread-Topic: [PATCH v2] Revert "drm/amd/display: Tune min clk values for MPO
 for RV"
Thread-Index: AQHW77E0UqaLOj1nYEytV0wIi05QU6oyJC5g
Date: Thu, 21 Jan 2021 14:30:08 +0000
Message-ID: <DM6PR12MB41563FC656A75EEAECD65ADEFDA19@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20210121045155.6099-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20210121045155.6099-1-Pratik.Vishwakarma@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-21T14:30:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e5b371d7-13ea-4db5-9578-4896b7cbdb9a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.228.174.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f7ff915-899d-4f94-ab44-08d8be190dac
x-ms-traffictypediagnostic: DM6PR12MB4105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41059E658EC692B8487C1DBDFDA19@DM6PR12MB4105.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUMQI/6u0e1M5RwZnXFQr8ShT2GzN5VKluOtU9YKaTxlAIT9OCo568z7cBktSw7g53V4VLfRWwKMTZeC/yaprRIjhnCocE/L3xqDCfANG3bermo0/OIKWOl/tx9A1sZ9wZbzmNC2rYN5ccnQ9SJY47HV0NSC4131JED0j227C9ojyY095YN8hiHP2H34oUXzx3Mk+QaEXLZH2e8dJ5H8mywFCryzF3ZK+ueJsL/7dJcFEE1kgqShk/U7FikFqKI7CTuBIJgTIw6UvHXmDevD/CWR+MDb0E0yV+rfTBzP4EVxJn2bJLj/1G/HpLgYlD8EBQ2lsRgj4VrqBmQT/CQC5ATf/w65aEFKoyHbKNQjZMmziTD2fSYZNBb7behv8Dx73jJZiqFzFPqMnfGhqMFb/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(7696005)(83380400001)(9686003)(8936002)(66556008)(53546011)(6506007)(86362001)(55016002)(2906002)(478600001)(26005)(186003)(33656002)(8676002)(110136005)(316002)(5660300002)(52536014)(66946007)(76116006)(66476007)(64756008)(71200400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YijrQeCmc12t9e+AjvLHdHMIKr2PR+vyEGVfWeYWlNFfI9gC1Zd7bCczjhBp?=
 =?us-ascii?Q?8BNvfmuyrukTkTm+Df2YGPKu758OxtCcvOQt3PYB26bLjBOXQPhuhuIyCbB4?=
 =?us-ascii?Q?zW1G/pGRPdMR1Lt902Uld5rs5tKJeyzaKxq4hNygaEItGGz8MUsa8fDamRfo?=
 =?us-ascii?Q?BVqOyrwGw2Qw0Aw7xBt8vlJaNKjOxEmf6qo6t4a3mmh++4uPphUyEPcVXP+l?=
 =?us-ascii?Q?lHmMGRS8IdB1zN6UmSxybR4uvgsJ4zwER3NVo2DKGmAt2tvt5iTCfEF0eVzy?=
 =?us-ascii?Q?TxL1NJreZshjz6cKAzFnSw4rthk65ohtNlK8+O0L0qgLnZOGGd4+j4++FTsl?=
 =?us-ascii?Q?309YtfSoACiL1tBN6QJ1Okt6m+3CXMGeiyRjeJN3nCczDkQJIeEmmCh6ATBi?=
 =?us-ascii?Q?1VgCvf2HJgyyGHiS/0yI63lh/OGqeWpW2oT/Ngng1K2Iw9KZDTymeFN2xE81?=
 =?us-ascii?Q?Y3Y/KSazGCl1IvjSOyMeO5pTRMgjBnDb44sDeRE0GeYd3fW0Lz/a1EnylTI7?=
 =?us-ascii?Q?V2l0SLBuHWAVy9ENOPcCeQU8x5C8qyIiwWrhZwsuL+RnxKmm8g6BA8AQBAP3?=
 =?us-ascii?Q?nRCrGEFD/HXpTFNFobkxUSZZsWY1PGzoLzL0pNB1VHRV106qUqlWVl3qYj3B?=
 =?us-ascii?Q?CILorD+ZvvST7JFm+mqYCRIdbCr10FAEzJrvuB5OEThi4T+lvo8tB2E5ghB+?=
 =?us-ascii?Q?KpvP0CK+YnQxhf7kTGWHwerk5bYZ9xTJH/66Bj4SbuVX2rpFu13DT9Mnu+KJ?=
 =?us-ascii?Q?ISLGpOUXNUpb1Cn+IHA/L9axqXiNaypV7V4GzDJ1c1O1k/09i1MF8rpTuAyK?=
 =?us-ascii?Q?Igh8utP7ab1tW6gDEDm2WUwvhaGO0c0ZRaQU3TpGTLuDNybVxuw960yY29a4?=
 =?us-ascii?Q?xDjIzmSBapF2pBhKlxPyrQ27T/dRxgFSvbU+bb0m4U8KUwkNR8/6wTVBfz8Z?=
 =?us-ascii?Q?7UZ9NbG0BX+XzJpOa7SsYMHmq+6KSF9fR++/aac18KlWg/Xn7ucuYjsQ/pZh?=
 =?us-ascii?Q?SkgQ2dbCtvkpn8PZekiMLKD43B4M3LLfaLugl/3yYRNWdVZt4y6cAUuB2D9n?=
 =?us-ascii?Q?h8srQied?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7ff915-899d-4f94-ab44-08d8be190dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 14:30:08.4371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4WPV0ZQhpXDf3wWLHfqSMBrM1vFRGQaeupIRM5LmKw5CXJWMQnByI9T1DGIpvZVsGQUEbvFCtyiEovRCdj5sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>


-----Original Message-----
From: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com> 
Sent: Wednesday, January 20, 2021 11:52 PM
To: Wu, Hersen <hersenxs.wu@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2] Revert "drm/amd/display: Tune min clk values for MPO for RV"

This reverts commit 6f3fca64cfb91fedf9b34ea27b2581e88d48c9b2.
Original issue of flash line when MPO enabled on idle screen was fixed by raising clocks. This had negative effect of extra power being drained. With the upstream commit 9d03bb102028
("drm/amd/display: disable dcn10 pipe split by default") flash line issue was fixed and had positive effect for battery life. Hence this patch is no more required.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 75b8240ed059..e133edc587d3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -187,17 +187,6 @@ static void ramp_up_dispclk_with_dpp(
 	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
 }
 
-static bool is_mpo_enabled(struct dc_state *context) -{
-	int i;
-
-	for (i = 0; i < context->stream_count; i++) {
-		if (context->stream_status[i].plane_count > 1)
-			return true;
-	}
-	return false;
-}
-
 static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -295,22 +284,9 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			// Only increase clocks when display is active and MPO is enabled
-			if (display_count && is_mpo_enabled(context)) {
-				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						((new_clocks->fclk_khz / 1000) *  101) / 100);
-				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
-						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
-				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
-						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
-			} else {
-				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->fclk_khz / 1000);
-				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->dcfclk_khz / 1000);
-				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
-						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
-			}
+			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
+			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
+			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, 
+(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
 		}
 	}
 }
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
