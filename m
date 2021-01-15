Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2882C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 10:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BFF2371F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 10:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BFF2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E821589948;
	Fri, 15 Jan 2021 10:49:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E1B89948
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 10:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTfhOTpJqlJPNVku3gsz/UugjV9U4bCfzvggr6bxv/LIKuX8Jo5MDvDS5qyxtkosCAssX93Rp60iemjVCXDNW/cBDHFUiQ/OsyZSR/EwKZUm2uYbKmg00iVbjrOI4zJ2snuokL3YJ4B0ItpnuVBlI0tWFqvhZZHzloEUp/m0soRSqLWW0j0mfyv5A+SAc7Pjg55F6dx4qbOhNBkLais46zoSqrDLdnKvd60kYZRIvYc80LLx7zyw1QtKZixNbGEgHtAaHOItDSdx5/U1ll9m5ULaJjvOvgrZrambKEIZld61HYIBOwv4SulbJQsVXMNb3QvmTs3UBbuBlsHgNAyvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vbUyp7GHY0SxPwpD3qRg1VwSw9FyGwrsifiCf6ZjVw=;
 b=X3QRO8X9gN0y8IqgUTDMYYtbni4OBIGC0I3eR1ZUy5prgdg5nYB2XG9oTz99YGubrFBZcUPdX8pMokn72bXPyA52WKOPU/fC3xW8/XCqjSzU2EhalaB5URyADpDqPX9L4x6vlk/qHQWnS7yuN8uC3JzrAMy6PP3phbEKXRb3F2TGHx3sjoDgyPAHQZ9Q1eEmedXQOu1XFuIR38L8COxJWHH4cACnENLRoI9A1JyBfStR57UaOV/TyuWtZXzpBwZ8jo7csVi2o4U/OTFxR7isw/WZuSn1h1tr/QXqEjz8BsLnM7ViNd/n+YQsW5fOBDjMItl5bipzKDu/kJ/kpzc5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vbUyp7GHY0SxPwpD3qRg1VwSw9FyGwrsifiCf6ZjVw=;
 b=20wHqc/0sadlacovppNd0qj+BPmena1OCTz0IkYBiLHhRMqZQlsKqDjwCu8Rd6T8zwwCbHTUdi1VYUfSkh1N4Jqs6h5+MF8sW6H/3tBkwX1pVyoBVICRcBbW/mgd45YR/y6X/9GWAWn2niGgYA5w/o9ts/mQB4dphOS6yk5G8tU=
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Fri, 15 Jan 2021 10:49:17 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 10:49:17 +0000
From: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix the system memory page fault because
 of copy overflow
Thread-Topic: [PATCH] drm/amd/display: fix the system memory page fault
 because of copy overflow
Thread-Index: AQHW6yvbBXte33q4SUCdVUEBa4clyaoogY3g
Date: Fri, 15 Jan 2021 10:49:16 +0000
Message-ID: <DM6PR12MB281290E2D00AD8A47E80C47690A70@DM6PR12MB2812.namprd12.prod.outlook.com>
References: <20210115184658.513045-1-ray.huang@amd.com>
In-Reply-To: <20210115184658.513045-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-15T10:49:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=49542fbb-eada-44e2-8e5b-0000c176f6a3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-15T10:49:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 10e6b64b-25cf-4948-a490-000084b69394
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 755a69d3-17c0-4031-99c4-08d8b94334a8
x-ms-traffictypediagnostic: DM6PR12MB2810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB281025E774D138D31B0E17DB90A70@DM6PR12MB2810.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RdsR+Uj/UwFuYLnf6QPEIJoB4CzunysWl7DzBqnLu6DNHYYqFZXkC7DuhG/DnqO/41p43KnBCnlY61+mJx9MXjPo3T8jnERN4ljzUAF9+OXXwmq1H7i1d29C4fb+pqNUYolmDfXRoo3wQweio056rfbAOebdJeq134nCyKW8DI646yy5y7ypDxbQYX84M0Lz1MmRMIt7MfTVFtXG+bmqU33qI4jV0e6lQV79uRUzFUJtzZmIJPy2Xj7VcKntwMqJO2SJ7+mkY+SKai5YlEoSAkL6+hJucsnSTOMp3R/1TV3eqaghH9x0Ah8zkdRamIDpPf/aRbLDNkD8ilTbt2m0UeiknlnQapWBLNA1Q19rAE0h2syHNEjwd436dqrosSETx/QCfLK3zu48QaWv0Nx02OB7Azwd2zqDd+6ttzpCOUYP1grqkzpqyWQnTMcoy9omz6UVdSjZi/NfJvvvpbj8Qv4RybFMLAs+BPgKBRRFgWzl7nA58AbO6uAJt12tOUIccQGfBwXeOUD+KsijZDogAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(52536014)(478600001)(55016002)(66446008)(71200400001)(66946007)(76116006)(66476007)(54906003)(7696005)(86362001)(64756008)(66556008)(186003)(83380400001)(26005)(9686003)(6506007)(2906002)(5660300002)(33656002)(110136005)(316002)(4326008)(8676002)(8936002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bFOIDA7ItcKBxaA1JB/zNPMCd3DxS7zAw5qVbvbBmLkhE2Hl2nveVRJ2gotr?=
 =?us-ascii?Q?+QCLfvaviPcLQ/VB2D9o3YFYn/ZlG3Qud4Mv2l99LrooUnjrQrW5+31FyRm2?=
 =?us-ascii?Q?xfsOSVHGXGhyxLecaQH8P5/mKVJ2gLm5o6SN+MTJoJh4koyt3XFGm20jUHNe?=
 =?us-ascii?Q?eC6vHgmtebmmU8HNQoVssE7YFqc0j+Wf97bIFnnL5rfpHVXC4hi0tf/oYyNz?=
 =?us-ascii?Q?djWCP/HE5pCsq371XIovEvOqFaOcyy+1KqlJHFeMuCBa6M4YB7xDbTRRd+xV?=
 =?us-ascii?Q?/VKriXR9wWOv3p9F2nCVLUPSRd4LlfZKBiFVEu9dRo2/rKgX7+N1X9fbAFrA?=
 =?us-ascii?Q?xvcybyDKsaYTAs6QtKF2SyPHwUkvD8m/jrjC03JGqlFmTCguzxndGbZSlTEn?=
 =?us-ascii?Q?zpzx8j4kB+Seat5SSpOM0vJ67rFg5qk9G98O44S+uEgyzbh13gjU/BP6xbvN?=
 =?us-ascii?Q?zxdI+O6HWcaGKR/sDWC8ytcF5dAz/Hfr6fSOPX8Tm5wViLeymaWEYOXSQ5ge?=
 =?us-ascii?Q?Yin5cQ7e5dbpPJo2x+hVuScX61ma+7i/DEHmnqx27OIkKTA2A5s5r8hkujja?=
 =?us-ascii?Q?Ki+L6LMzrb+ih/1dyP+53Jnq8+fTwaofc8vOyhL3FsXWn4Mst1X7uAeYYnAl?=
 =?us-ascii?Q?8jU7lxTRkECANbog5bmLMpC9iyMiEXWS0+OtY2L9x5tL/zH0iEUutKYnJ/d0?=
 =?us-ascii?Q?PWgN/NIkAFRyHvucWhSk/WNDIuWy2TNdpQ7k4N8aum5h8g030ztfEhLYfQfD?=
 =?us-ascii?Q?OfK29dl7GFNvwgtjSEY6TJxciOwCCZAF4BxZtN1diV5d6d7WGAQCCSNXw/Jp?=
 =?us-ascii?Q?USk6AWyzynjQCrzbwt8Z2ssaIGMuAFXF0wzI0std5uqvqUrZtvDO7oWLthUo?=
 =?us-ascii?Q?Wy+MaW5x46Mc4csREsQYGhwFV+XzkRvCOhsD1zTBFPR4RI9AvBsKj9/JJoHc?=
 =?us-ascii?Q?zQfNnpnOKXJI5tAx3rL5yOnBeZOnOiTPz0dqSWDJqDA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755a69d3-17c0-4031-99c4-08d8b94334a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 10:49:16.9044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1r7cxMRLAPMoigbjd7P3SGtYD+4bgmBW0k0hlgYCa9/hFjSWILUdtrPDhNtXjjv3kXFHygy3ugMCl+a2HTPfDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Lee Jones <lee.jones@linaro.org>, "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jinzhou.Su <Jinzhou.Su@amd.com>

Regards,
Joe

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com> 
Sent: Saturday, January 16, 2021 2:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] drm/amd/display: fix the system memory page fault because of copy overflow

The buffer is allocated with the size of pointer and copy with the size of data structure. Then trigger the system memory page fault. Use the orignal data structure to get the object size.

Fixes: a8e30005b drm/amd/display/dc/core/dc_link: Move some local data from the stack to the heap

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 69573d67056d..73178978ae74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1380,7 +1380,7 @@ static bool dc_link_construct(struct dc_link *link,
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
-	info = kzalloc(sizeof(info), GFP_KERNEL);
+	info = kzalloc(sizeof(struct integrated_info), GFP_KERNEL);
 	if (!info)
 		goto create_fail;
 
@@ -1545,7 +1545,7 @@ static bool dc_link_construct(struct dc_link *link,
 	}
 
 	if (bios->integrated_info)
-		memcpy(info, bios->integrated_info, sizeof(*info));
+		memcpy(info, bios->integrated_info, sizeof(struct integrated_info));
 
 	/* Look for channel mapping corresponding to connector and device tag */
 	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
