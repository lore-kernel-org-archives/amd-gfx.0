Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E64C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 04:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9C461279
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 04:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9C461279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792006E4B0;
	Thu, 15 Jul 2021 04:13:51 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE54D6E4B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 04:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFKRuQ9okQLC3NQJOWrQ+kViiGNZ+xwqHAAznnh6roIGh52AG4Mj8MUDvmMzBMmTPS01TdyJ9SqQoqW8s6rTT75PU1yN8OlNbbas80J7dPmc8Vw6UFPehX+QDO4stCUs/cepUwQNdfijUCFqEfML4yVjU+trZ/aQjECf5t4choJtW5Z6hpBn6XhwH4R0NHPcJofqpkSBE28P7au32S+ORBclToxGIzZIwbns1m3O3EQ1hKwda11J2DdNgzAL2KRgypk5rdrfDYkmkSRBLIahVc2nHafE1pMpPunfOlTVu7DRk42R7MVo51Ttf8YtSS7rVX5YyoIGqogfx4fHm9QKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjmWgF6pEy2bEPXGuGOZS7jn2utW/ihvAgF8S+hB72Q=;
 b=OvUsnIACg2gBJgVc75dIatNjjcX+tmrOM6d3HE42RJReKU5qrP+0co5/dvgVcgL+MLFMxXeRvVV/SZ7v/xfxNcdhXk9ODpGIdChevSct+Y6RlE3T7BEkh8JqK0tJkYi6/EPznbbmn6P9lHT7StS0nNTBTyXEy2txLS9kGxP50n+dYmd963fNB03Vp24x46f1wezMuHeUeFJIsqhB4dkr7xuxkj6Syn1/kBl3e5RMY2UtB5d5Pdm8A6VAO8+k2jQLyDGWv+TuhK2d+K/bRnWzZTwGWNmpNTfRFKp/rfOlK94w0AtQ4YXpdnJy56DgRvwbwGvg44Q2udo2eKrWj/zBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjmWgF6pEy2bEPXGuGOZS7jn2utW/ihvAgF8S+hB72Q=;
 b=tVlQzjgpmCNr4xjqodARJXxesZjTSh7pQBLdAqHMtyKmbawgFuz4po5jFRgkjRdqL4TcACchdKDZf5aa48NgHBKWOAtxo1JuMWlk3vuJk92xL2b/FrpFxUxE6AgyG6i8xtn1KhzrCUy/cqlgMueN5F5+fRl/NgoxRkTIbcQay0U=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 04:13:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 04:13:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Topic: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Index: AQHXeS+MwEFfYUXPyEKf+rJu50oNA6tDbSnQ
Date: Thu, 15 Jul 2021 04:13:47 +0000
Message-ID: <BN9PR12MB5257236A2B67A4D75DCD458EFC129@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210715041104.1110022-1-likun.gao@amd.com>
In-Reply-To: <20210715041104.1110022-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-15T04:13:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4d582615-c326-41be-896b-a54f63fe1f39;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f55b552-b490-44cf-4dba-08d94746f1d6
x-ms-traffictypediagnostic: BN9PR12MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB50504863D51BE228741DC516FC129@BN9PR12MB5050.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXhspElixvNlofLVBb3CtqwXoneL4I+AU911KiCmeqt+Nr3O5zfTTcyv1fh/ApAszcaLmSneyRrjGAeWjieWA2PkdyE0/nmGR/F6VhOp8FOWAFB4YmSMFJnp/7HhdxuBvGb70yOBvLC9kh6v3U6aMVp1GPx6qQeHvu215xxIVFfl5B1AoQfsHyekZBREsyoMms0M5Nijs7p30w255Iq7GuIWqlu9L1xLwg5b130xgrKWqs31P2hKSlg8znwdkEj16HjUC8uHAQEdbWiYkPuOqHxYhbj5gzKr+J5TOBM8znAQMhiThvlxmHyHuxuPWvL1aDIbtHfo2iDPgmerI50hmXEQ8C7pWsK0alh8L4C9+yaIKUMX0EFJEyST4ZfgFt3clPMWH15Cdzzpn4drCEa6XVbMQvXaHhFoLtizId8oxE+7qHkQdDIDMdnN3cBEEASUD6BvJKoUgnekjky0035eHccm2JwiQy4c6WVmNYrh74lgMauNhJ4T1NIdjgdhBKJoi1vv4qbBvgBHq17BfsWXCx3YPBoKKEZefdYsZ6WKKbcSRJuH3GOvkucy1s1KdZTU2LolEYYJb+dy0yQMaDZCgSYA9UUYTkI4aI/v55anOCsfitV5jaauwkhaV9JcW3zZWcoIc/cGgyy5LyuFH6u0YQ9QLrYHi1BuG0ti2iD8o4SMwobzJjEVoRYnPiMaADPHM+9YZWBm37N3uS+2SKJrNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(66946007)(7696005)(76116006)(6506007)(53546011)(52536014)(66476007)(64756008)(66556008)(9686003)(86362001)(66446008)(186003)(26005)(5660300002)(8936002)(33656002)(55016002)(83380400001)(15650500001)(38100700002)(8676002)(122000001)(478600001)(110136005)(2906002)(316002)(4326008)(71200400001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WgeBV3GGIKuiORQv4MyRs2PPp24iDUh+5fuD9Vd6Ti70JmCOXn88QE6MEjuY?=
 =?us-ascii?Q?sB2WCskAm620KVPIwIgyp37J7MJyceR64SlDseKNbYEgAuT+GFtBXyOmIvG6?=
 =?us-ascii?Q?kS4kIMNikz+8/W6DKuZTkQCy4BUlJi2ANNrtwiBQKXgTz2/eMro0nfM18Whm?=
 =?us-ascii?Q?8e00eEmWMhaK8h88in35+DSU8rP11UvrVmFwOW5FhidNtslJy2WDr2HdsNJv?=
 =?us-ascii?Q?v1E/iS/qJnA/TeqCQU5q65ENLsGB04Ih22O1MKmoN5M3iBMY1FFn8A+RyjWb?=
 =?us-ascii?Q?/tK/qmUDCxjubVrIi5Q09Ml+A/pyNhnsV6TRy+EEdItXk+Pdrm9vQPJM8RdC?=
 =?us-ascii?Q?ENJosH81xm92tA4oGXHFrVrBFhaHOVhoGxcIWqqeA2euuaCn977Luc5vKFUZ?=
 =?us-ascii?Q?SIHmEL+65IhfKlS5MS+4Q8bxA/oTWGwr7uzhpmspuduFKTjwSkx9bbRxrwei?=
 =?us-ascii?Q?jNP8nJff4D3a60/+OzVvtcB7MK89IkdLqN88l39PWtQC77EprxEWl2kKjdn6?=
 =?us-ascii?Q?pFT4twa7Pc8bvuuOC3zUclclu10EA0KnSJWJKc/AB8VCXPTdrvrWmdptJ3rK?=
 =?us-ascii?Q?ISjQGM3FDg9MUw6LM342/LbhsPrN8hDfyD61sSlRWXrlq8YUhxBBLJn3cCqR?=
 =?us-ascii?Q?qbLnOfwX9Bv/G/umoVCblwlHhdd6zrdRXeG6x8u8YFABO+KNaQtSo21AlRIW?=
 =?us-ascii?Q?rQ+hP5ls7i+5V0rkO1jwTZxoLieiwk82eqSmQKlN1uhc1mTngjYSJgN3jcf9?=
 =?us-ascii?Q?2TEiQpvU5/rXqFZXy85bEncC47Vwjn6nfPgnC8dn6T7WW6uZ36Dx7G9TjaVj?=
 =?us-ascii?Q?58kRFZWSOFhsqkqiPlhJKg44QANrJgqFUh5pdKjdvGvJpS1bZHXYws1iSICK?=
 =?us-ascii?Q?dOZUDa7pXA5KlduH/O9wDUNHxm5hmoUYlAW8W81x7W797W4xKMGP97vS0qhX?=
 =?us-ascii?Q?id62/h0bvNzMU/q4lU0ROrIOLWUjpymAGnFwPxfwsfF9zmHIureCSNbGkT/R?=
 =?us-ascii?Q?+X0LmGFF+cbhTVytXD5uIeuMtFrr3sE26itp/5IF2C9p+USdR5k63cFLVZOd?=
 =?us-ascii?Q?6j6gtAYP/oRq543Q17D5IM1MYKgEVYMPaZFjhvQM8v+0WKdYiD3XJrd8B/66?=
 =?us-ascii?Q?WbLLrPhq66QfKCHeLSossK6/478LK6RPBEsAB7TU0AUpXMB68NOi1oLDwCwq?=
 =?us-ascii?Q?+E0g1LXgL8gzEjd7r7AcQnq6N4gCKgjb2jTBRbTRYga+20erSIhlZ/kvHCtR?=
 =?us-ascii?Q?JYYylinxHByeHvtU8kYyMa6jIpnAVbj2Erbn0I/P2rlMMOLlVSOFWKcbYxb8?=
 =?us-ascii?Q?TbrursGtL3SFSGJ0UL59RMmX?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f55b552-b490-44cf-4dba-08d94746f1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 04:13:47.9107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LVw8g+1vbd0ef4mQpF8x3QvIJJOIUUtWI75NpSLff+fLHUIBMheA+NjmGY4bpcAXmAAdcis4sqXS6V5r5fw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Thursday, July 15, 2021 12:11
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update GFX golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index cd8dcec7fdbb..7c08818fc142 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3308,6 +3308,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)  };
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
