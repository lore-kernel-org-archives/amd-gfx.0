Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C309BC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 04:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4FF61107
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 04:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4FF61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CBF6E9EE;
	Thu,  8 Apr 2021 04:18:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A25D895B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 04:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/OBdsNDodoDs4aRdfKOj6wKB0jVuSuVdj63TfeXoefPzkJJPQ18scmN2JCQxdjcNXLEuy6LpsIrjXgXpJCIpFVQtKHmyqjuRss3EBdvmiidbt4mFQeVl3V79o+q35yBw/J/+l/P1C3LUQdfzdHqWEwjtrB4FXtS7abDf+5W/5T8YSjcjqmLUwigB68k/db047VFD/kjpk05AlYZiVhODCMp5GPim6wwuACBZ+nif8VmOVrvU2OOdR7Rdputz8rr3DvORXfqU7tvmBMOSuGdHsjnS2aHJOfjTcYih51cK3t1P3esN+WvLjWrUAXNuJ6P02nBd5RE9Jcm6R5n2u62ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C7UHodm9t7Oo/GDmB1rzPI8u6chZZpmHY7SDKamsqI=;
 b=SzYzlZ+hXcNavXKGsrOtLEOcgiZvXFXDarsjvGoVE1U99DnalOyED8iKHDvAVzXUME46Hh27rf6H/hQuQQcz/2PzbHrK8bPcS5b0u6cqFAoZcOGhw2YE2Q4QrdfPUXl/JRLOEYYVyPERZtXstS8s5JSA7luzDH/4YU8iZV1R4mksmYN0f6rN3GnRNNEfr9sVdXCE1YcOBxAbTJlAPWRxITwAxFf5v2WbcUyhOL8BQ2IA+3QPDkTxxq2hyAQ/UK63uJsN10F09eZtWNhlj/TCotB9/Z3Uj0psXo93BMhMhjwjDrNGEWwE9Pp9bncCxwTZfpiiijq347IPZICaNy2jcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C7UHodm9t7Oo/GDmB1rzPI8u6chZZpmHY7SDKamsqI=;
 b=T10vMIf+WgnJaVCUO3cyj7uN1/uqlXsS52LnDeK0UoQgy4pZZRVyWv0PJvIRfofP5oETEOLggxWvar0hj+3Oz0PYir6TvnF3zBxDs+q/nHk8mXFTfsmDzDDIHYfCIhbR/PbQjYXkK8G5DpaEGc4oZphgejQWOrXxayiKAamqiLc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Thu, 8 Apr 2021 04:18:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 04:18:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu7: fix CAC setting on TOPAZ
Thread-Topic: [PATCH] drm/amdgpu/smu7: fix CAC setting on TOPAZ
Thread-Index: AQHXK7N48v95hg/N8kGbTEEiv3BsVaqqBNkA
Date: Thu, 8 Apr 2021 04:18:03 +0000
Message-ID: <DM6PR12MB26192269914A56708CA6FE59E4749@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210407133920.314018-1-alexander.deucher@amd.com>
In-Reply-To: <20210407133920.314018-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-08T04:18:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0b6f445a-446e-4d2a-8d0c-bfc87fd8cae4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6dd2518-b65e-4090-b55c-08d8fa454d8b
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2988D7ED4BDF06FBA0B1F308E4749@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pL/F7KnJEI3DB7FSaLtBINXZSJfjdY0wVkFN3oVEwUvUO3DY7uNKGzYJfI4sjHQ+HaeFeVY4VyV1h7EdL4QOpbzJy3gtQW3L/t5sh/WpKmLp+xUIItSDqY4tMD5CyEa6ytZwqwzWM0aXCNwxlJIYyRxY1FBBPX4cC956/angrI1cxTR85XwgXrmM/TyH7S5ipPNP6XiGGtU7igY7S056aHgtwGGKVH8W3wkK36bgOsDjkI0O7u8JbMe+U8ti6F7UvwHR+8nWVKfpEO5DULbdTNDyZqYbrW7/zSjk6AmT8QFiVYaVXpIDoPUEDkd3OkEYpENLNifoSo6lwCiNCimfPzK1HLCu7TVZJE4t3c4UYynCLgSCifVGbqO6HjZYvtIyu0xAOstmulli90f/1BcOxO3Wti2Ekzn+Sv1xX81VV0EDbwSPqYqZXY9H5sqzZF4kjsP6Ue40W5m0BEXIA/m7pOs85SYkrvMgIg8mlK5EgJq1a1XFafkwRoHvB16trzaR0r94Of+KGctZTnX9cGDgsQNfZS0+2/cmLNlWgObkGbUKzsAfBROTvGRZP2iYZvl0+zxty50d9w42OQmEv+xRNPcRIPt6/agrdeLSh+ACboWGXKwlloOjesZg0qNau4Jb0yF5I07eZBQV7vVMoI4K2jlW0UYIzzTuxw1kLeCtCa9J3Gk5qKUzmlB8H7nbFylnoDOgQbPcdkl2YzUkygDAXjIPPGX+EAbAd7HzXroHVdQEHczq3czXWvjLE1UJLd97
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(71200400001)(186003)(83380400001)(7696005)(64756008)(478600001)(45080400002)(38100700001)(52536014)(33656002)(316002)(2906002)(110136005)(5660300002)(4326008)(9686003)(66476007)(26005)(66946007)(66556008)(76116006)(966005)(66446008)(8676002)(8936002)(6506007)(53546011)(55016002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xDPKhB1w+I5AI6V4DAHa+x64umTawZuXlo6BM91wNNGB4qxrizsG9P+Wl1ip?=
 =?us-ascii?Q?J6Oyfd5+IcT+hWB3V5kBFLmxzVwnByN/PN2CrEtuDmEl77lDziT5tMs2nJ7J?=
 =?us-ascii?Q?gt/P6XcxlCdjzdkpYfsAicRcB+bqvpVQDrQ1b1rrHWyH//YRXVw5IG9SV0Tb?=
 =?us-ascii?Q?sbjSdlTfqWvaQ+IareJ4UWKg1t9qOZCcJ5eJBJwuJcZCAEpL5a1FmlZgVSwP?=
 =?us-ascii?Q?EKeRnqkFZ7kuY52dxQY3u6oCPDJKQDhg6w4NplpYXa+SuYOrn49jURLcBUkh?=
 =?us-ascii?Q?m0BdNBzqJK7i6yb9nYGvSwQVK5PFJjQWMpq6anEx7Ye/B2JVbiHlLjwI2yGt?=
 =?us-ascii?Q?dHr3QllAelERV0tVT8GszsiIHILujqEWOWAmtnh11vC77rIpAflwJOKrFyi7?=
 =?us-ascii?Q?xpDVijWcKlE9NTWTwkaMS0+s2G5cIAoWi5yHTmoDu9UmbPa6M+HAv2EcPnIO?=
 =?us-ascii?Q?niOj3KBraQ6PDLd8B0C9FRVexbmoiKs5QMQ47qa3WMYn/B4xMA2L9LicgDAk?=
 =?us-ascii?Q?uBDclpETMORHCBp16xn3GmGKmXiSwmepzdW9abJ5r4lwaqf9n3dUe8C7UG7E?=
 =?us-ascii?Q?JDa+IlC48nPQPUK36dxkdsu/0nHbdbWFU0zyIVc21bd9gmgtjXFM4LWORXk8?=
 =?us-ascii?Q?M2W18ZlBS5cpp8pGXfhAW857GLOEM3216avBYTTzNxF2t7AceENGShpUn+/2?=
 =?us-ascii?Q?NE7hEsFcQ2E8ipI7cS2fQeSHUsdxjTKO210s1csyBckuyJf/0CB2tVYSmUbq?=
 =?us-ascii?Q?hmdjL4DqDV1bmf+yqDn4/RkQ535VxcPMCU8MrwpqSNlEqH49EFLRJvtFrwwB?=
 =?us-ascii?Q?cmKfzMPSRTSv3UcUQ1JGiU3rEX9UywFzYS2dLZyP7N2REKABGsRTji7c3dDp?=
 =?us-ascii?Q?7aCz5vIoJ2ktnQX2qmN+D8bI47OF5Kc6qktwtG+rJ9+6vse/EXRwSjxLCzqA?=
 =?us-ascii?Q?7Bl4quYm84DIZHn7zn8A9ETM5AoMWeNJgEcbvR2LxzLHwsJ0JjbHFeQr+CYf?=
 =?us-ascii?Q?usz1sE42HBuhI+9Mtp9zc0A8ibRsUYObFTz7cYx8TOj80SS5XzoD3NgLxAM2?=
 =?us-ascii?Q?/a/0mHUNJbm6iYEOeXaAxt73i7o+ehJujfdhsLYZh8a510hwPhR52z30Kd6R?=
 =?us-ascii?Q?E7sNpTjdrjkTpi0NcCzB45p0JGsVwazl+0tiHmT23Yg+1N4nr0rBTQoGyCF1?=
 =?us-ascii?Q?cPp1AV8JnJ4x9QprplAz4exkIPUszb7bsNwj6l6s/WO79v9Rvzvd63VlflLf?=
 =?us-ascii?Q?Zdcht0gYqwnspZrfzuQQI69hx79YK5ObJrWylJAdWsooMjaCU40ClubCRStH?=
 =?us-ascii?Q?j96GWzRRvEnFKW29vfiFChVT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dd2518-b65e-4090-b55c-08d8fa454d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 04:18:03.1825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y97OfDREW6wGIm8egivIpCJA8NLumaqb0uhDtdihRzpS96NAPllJNZx3x1La5pNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, April 7, 2021 9:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/smu7: fix CAC setting on TOPAZ
> 
> We need to enable MC CAC for mclk switching to work.
> 
> Fixes: d765129a719f ("drm/amd/pm: correct sclk/mclk dpm enablement")
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1561&amp;data=04%7C01%7Cevan.quan%40amd.com%7C00a
> 251035e6f4c16d63608d8f9ca9928%7C3dd8961fe4884e608e11a82d994e183d%
> 7C0%7C0%7C637533995857826102%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=gMvcwYRiSFSyYhzXm5OGBxdRGIiPC4%2BkVBmN17dJR8w%3D
> &amp;reserved=0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 301b6769f007..0541bfc81c1b 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1224,7 +1224,8 @@ static int smu7_enable_sclk_mclk_dpm(struct
> pp_hwmgr *hwmgr)
>  		    (hwmgr->chip_id == CHIP_POLARIS10) ||
>  		    (hwmgr->chip_id == CHIP_POLARIS11) ||
>  		    (hwmgr->chip_id == CHIP_POLARIS12) ||
> -		    (hwmgr->chip_id == CHIP_TONGA))
> +		    (hwmgr->chip_id == CHIP_TONGA) ||
> +		    (hwmgr->chip_id == CHIP_TOPAZ))
>  			PHM_WRITE_FIELD(hwmgr->device,
> MC_SEQ_CNTL_3, CAC_EN, 0x1);
> 
> 
> --
> 2.30.2
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C00a251035e6f4c16d
> 63608d8f9ca9928%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7533995857826102%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> AJFxsTzMjqU8IW7%2FL%2BtsPIWFmJb95dyr5pZ7EXnk20g%3D&amp;reserve
> d=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
