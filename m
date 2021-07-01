Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44140C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 09:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CC26146B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 09:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CC26146B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B950F6E9CA;
	Thu,  1 Jul 2021 09:18:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3846E9CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 09:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEBqjVWIUJ18a/FZ0brBhb8ni1jtKu4e3fapqhPDFyAcXgl8Ydvjv8jYpUWiOOskftPkpqajHWmnERY7umqb2U1Y7WIPGHxntdrWIeN4HVTmxM+nc+YL7gCYa2tEdEvLGnn845EEcqgzlh9s17v5oN7GxQexUYFsoRIwV9cMCBzUcsUi8XX/dzUa0ms2HOSrTzBNWpClv3ZEk4KJsnycoY3TsFmOKfX2SRWDOLLy+pMeT7d7aqjU9dv8iVgRoJexOvZY47k2JUNxKtNlHoUznt1CWXHYDqn+buHOOjN1S8qCmAlyt/e8cNHrk5JpbNHjNga7daOxWezUsNVvGP7agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JReMVLKBcNTnZdEpYNfSKhgh3O1HmIQeTwm1qEalsWM=;
 b=Arr2cXqvZkLonG2XveYs+YopqZZRSgGtz8PCQzauGMPECuR67l9j9VRpxUfLro0yq7n3XgR7/t6wmeiQuiGoTYgk5QPsAhWktJN/iZtny/VZs5KpXLlclS/XazwNLtJyng/951ytawzqA4aGFeaMCo4EKxVGXIvMxrIMOi0FT+TiqGN1gqKBhEMuMPvjcU6gl5ufbsaUaGSiveEEcZucVrhfv4soooEh+O3+YKFYU7MPYFes8B1t7GFTmh/LHfOlVNnHp/bqbhE8DWQ+3zb1tGnpahTW9D+WGFXQme72e9s8A2G5I5PLY+e4IF2i2oZFqSW2a/zRsQwiN5tVuWJKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JReMVLKBcNTnZdEpYNfSKhgh3O1HmIQeTwm1qEalsWM=;
 b=BiLSRTk2/fYzINx3kDicouC7ydF4XsUquLTlWTNsPq7kZnAqH+kZUkiEr63ybXKff5v9cNM+2H1/jZdDcSTRV3XbdwFUp3Hz+yPp+RMa1w3CwewkfJkxcDHfGYXrDNyG2zmb+QgLpY3oGJau+b9tS3h5ofuY0zZfvtaz+7xiwOc=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 1 Jul
 2021 09:18:22 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12%5]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 09:18:21 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Topic: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Index: AQHXbjLZ5C13fgJBlEWCatsv5QtXwqst15rQ
Date: Thu, 1 Jul 2021 09:18:21 +0000
Message-ID: <PH0PR12MB54175493FA2801261FDBD0358F009@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210701043743.10663-1-Emily.Deng@amd.com>
In-Reply-To: <20210701043743.10663-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6cff6988-0560-4542-a109-1bb87f5b6f0f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-01T09:18:06Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d54800de-e4e1-4669-a612-08d93c712c2b
x-ms-traffictypediagnostic: PH0PR12MB5468:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB546870BA7173C28C3BF579808F009@PH0PR12MB5468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdCmaIJdkLTbJ1e3KZRH7DE+UoBG38jYkNmzssoCwozCehJ1z6Q1pij2Eo3Ba3xl1O9111oJtoYQmsMzQnlnI1atyZL7m54Wb+42xMeoeg/DhqfD/T1qwIFnt359wumisSw6E/0zSK+AgKRE/VAL/Gj//cMyDAfEkDEncKd0g++GuCkZ03FweaTD0lz1yZRdNG9cHWvrSwjbh0nVLPNNTnr0EfM3Uk0KBaGFAbgxaZr+8hPDUW9zeh+/oEyJFisNsWYYSyrz6g4zGviZPwHKiXt/Yv19ZI1bD9Rg1gq+KKB+NHqWvb6c9Cq/f/SvEt+sfPtmX08e4UM3B4xiRJU5rzxcqTBUBr9uxybodFPev2a/UoyG2n6x3VmiD/07v6S9VmNktC94Xw9E2B7v26IAVAtVI4+e3J+ZpohD8bB5mCbJCmXuMJWAZWhpCsPOigV4wSHLvmTHqNrai9NHXQ5nYd+fjepPKYc7wEHuadEg/avSXcne6sxuIWXDlVxuzdARycyW170SEe3IycOgYqcuKirdYvXo1uJXhq2pjX4jzptgeBT/rTjdd8RSQWv2lbR+UluDok/gteqhuVkwQWvRs09dxb0kjBTirCept1/McHN3J8aOCxgTBnh8TMTyw6SPz235BQvE4r8hzEI5V8sFQw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(186003)(8676002)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(26005)(83380400001)(71200400001)(33656002)(478600001)(76116006)(6506007)(4744005)(38100700002)(7696005)(2906002)(9686003)(55016002)(5660300002)(110136005)(122000001)(316002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pTpMnIh6urQ1UONT3yc47LZrLdYRkjjB2HuIGWF3ybajshGMriG1wXbqh7of?=
 =?us-ascii?Q?tiZT8rRHb9Vk7y6phiJXb9zo1J8Ly/HSePAuoed89gDrTO8VANavKXxUWNJB?=
 =?us-ascii?Q?fq9HlkmLlW0Ng4ZKKQynj34Rhf+XCbXVpOp1GWrX6qwY+uF0MT7FGosa5SrP?=
 =?us-ascii?Q?wEZC4vO6cBSWXUWcNeD0vz/1gvxI03h40GZXpP3KD8g8KoBxslJmLCu/c4GJ?=
 =?us-ascii?Q?x7C/Yg7/M62LwosPBxRgQd47IHPVqeKmvjYTIx/kvM7yOCHuixYloeFmLlXU?=
 =?us-ascii?Q?DRBypLSP3/WEa8dYYm0aGKfnVfV+AU9sNaoZq1fKuhMP7yWdLiiSYVSUjl9U?=
 =?us-ascii?Q?KF7re8ovCggzUbpSweHLbek5knXkEK3ZAYc2dWd6buaECWDdd4B9J42ViHjA?=
 =?us-ascii?Q?LPd775GHVXPPJ7Bm4p0yk4rN0+0bTaIrzvkrilI+xNWBZocLa4QSSe92nKMQ?=
 =?us-ascii?Q?QgaSCBgZ/O6mSkK82FqzXNl1T4RPaYzTA27FQ5bX9uDHCSh7Nn2uXQXjBqH8?=
 =?us-ascii?Q?UD6Fla+OwzRiYCU09VFuHiBTdCSmbA7mya3C7aHn3Pek0a0SXZx9vwvQ0c5e?=
 =?us-ascii?Q?vn0jy2r4spFE4H6cwt4YDdLsVlBLInU2j3/qgs7N1vF+JEX0aM0CFS0uctyd?=
 =?us-ascii?Q?2S4Dj0rTdIyey5WPEDQ/7zwyMq9IACZQERQ38ODJqju+bFrYJBqugzdYUKXy?=
 =?us-ascii?Q?qdQ1i4d/j8c2GY2Jt8xdmuYwi1Ttgn5Ugyf/VxbiEUFkaS/RwJz5vn/pjl2F?=
 =?us-ascii?Q?4GYyl0VBV2PG5JLrvfwoYA3F3T/teHxClJo3rnnwnk9lOJu57u9LVcva6vJ9?=
 =?us-ascii?Q?T6KCgeCaKbJvQwWwB2Y30szL+SCXrxj9JHTDg3A+bHDipyS7pZnoWRCB4XdM?=
 =?us-ascii?Q?FUoeisGuKN9hdNV32N3Ro/F65AtlReUpDgC+Dm4HgrpRU6BP11zzBXRn0ShQ?=
 =?us-ascii?Q?EpZS6XDts0OyJ9k67w22/DO84gxvNS7nIlI7ujz5vpzgL1thWIR2CzzkZyx7?=
 =?us-ascii?Q?qaGYrO25wduMh6SfgPqxM9tUWHyPL/ELjA7QcF0jQQH4k1XVs9lpMrugR7I+?=
 =?us-ascii?Q?t0sDysQP5/m1+FqLMb7U9ppkd/thL7vnRdxlBjKr93GzNBxMLRDUG5HJ0N1D?=
 =?us-ascii?Q?ZYs6NmQtq7QZdMnu4P9+eAThzLtVLTQQk3BLxoIQV8BH0+XVlf4VvpxLazPi?=
 =?us-ascii?Q?RinGn1MibbFeg/r4ZA1xvydvxZDmkZ6sASrdUj+NR1ipyNsPNYrtjbsGm01o?=
 =?us-ascii?Q?pZEFa+78YgoHeg7ankrkWoQuN0d2HH5IwPll0i1JHQaCWN9eOsAGWc3UUvzf?=
 =?us-ascii?Q?WqqdgY1Y4l3dyiqkg2PyScBT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54800de-e4e1-4669-a612-08d93c712c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 09:18:21.8161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWXMBp67ze4+Vv9rjs15JNQSlyGw2o14omngz83CUDNUOpiaYUCf60yd2kRem2gk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
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

[AMD Official Use Only]

Ping......

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Thursday, July 1, 2021 12:38 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>Signed-off-by: Victor <Victor.Zhao@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index 33324427b555..7e0d8c092c7e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs
>dce_virtual_crtc_irq_funcs = {
>
> static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)  {
>-      adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
>+      adev->crtc_irq.num_types = adev->mode_info.num_crtc;
>       adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;  }
>
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
