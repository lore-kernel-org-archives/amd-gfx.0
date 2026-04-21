Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE9FF8FA78
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DD810E8DD;
	Tue, 21 Apr 2026 14:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICFImuJt";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E0610E8CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 14:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcSEx348Mvpf7UftT/bwhKq92VmCeIcyP/IFTP38oC6JutxeCaEXWeB2cIVIm/Qm5QImTe3i31DYKBrYRBylW1hQm1OdQRZp5ScCsSzKZFBUEhyM2qrjgB1f/dc//cYREpQBa4w5KGuqYQzPbdmggkG1kCaiEP7Bp8iGvZZqaVVxSs1gy50WoZOmKVYRTrYmycdX3sMCvsWCWdpGr2Kt1vCn78yq1qzHMtP6wtG9Yn5yw65VOq1Rvomu7kO0WQ7uuWy/Rpn7SHV2uYVg/QLzC3Iz2Yen1nUPZzyiPgqo2y2AWJDXiDgnfKAc5AUwP8KSZfyTxRguyHt9S3Ne92XEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27kYo/6grnNzj01Sh6mkcqEiefnu5MSvoLCi4DvvxHk=;
 b=rjDKVmo0AZYOj99UCP9GaFDtX6SORYsTLOMWJeu+/BHcCpDKKIy9Ph2K9BoL+K1pdPhlW87rQJq7pSeliHCWK7R5tDiYOaemuoIJO8eBzyE78X2bDJr1SsLUtA4gEmZwK/pE7L+UaIqW/UiSaS0Y0xP3QGFSWNLk/TlzSOx4mfRlJUNMiWtg/qiRhvsj7geXhQFjeUanCooEkDZI2tz0Doi5BY69X1ErrfEK5sWY4GbJP0PTV6PrIkafnTqF+b2KfGam35w+r8LRVS5F57W9a7y7qgpPZncDAJwA2SkPJVDKklpF0/in58z2SojLu0tLt4VzRnH3KJ0cL6WYgXd3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27kYo/6grnNzj01Sh6mkcqEiefnu5MSvoLCi4DvvxHk=;
 b=ICFImuJtcIk2NKAX7c3SYLbdXV3Eky/Hpji15/60Wg99r81aY6lhWliG2lsoOjvoijo2LEcN8oHqrZdhsMdQR4pICcReU+Sg7VGyE2tg+jI02n7GkdRBGiCK/8E3iBfWxgdHbnYiuaB0qqlMe7XqXEVyN0Taw8wIwfTXJkc0JV4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 14:51:34 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:51:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove trailing semicolon from
 AMDGPU_PM_POLICY_ATTR macro
Thread-Topic: [PATCH] drm/amd/pm: remove trailing semicolon from
 AMDGPU_PM_POLICY_ATTR macro
Thread-Index: AQHc0Ws3S977dGzRG0uQkrs5KPmHyrXpmbPQ
Date: Tue, 21 Apr 2026 14:51:33 +0000
Message-ID: <BL1PR12MB5144E6FE290513A99E2B5CB2F72C2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260421084516.614258-1-kevinyang.wang@amd.com>
In-Reply-To: <20260421084516.614258-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-21T14:51:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4372:EE_
x-ms-office365-filtering-correlation-id: 2cf4498a-fe43-4bce-b406-08de9fb57b3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: ttYg6wpO1AhCfFu46sf7+Jf+aSpPKGqYL4SAaSi0I2iAHGj+w7CYlYH+4/vWWZhQAXzd/77UBKBKMWsaWTB8P7WYgNaV5piH6XfSDf7/U0jdMlAKk0wLySfB/7KjOS9iRPXXTHBa/IYGSOMK3TtNksp6pdmP/+pNrNzyAuPygb35Yyr0Ohjg/5VnV6H3Aj3JZmKpWf/BuiE7oegJodJ1RNwOTOcyCEkB2tGSkR6jAmoypj0UHv4JCOOZb2bdSMCldC1irWyp99ZB26p8Ymb78Mjeq34Fa120VLLXRB+bzPcTwQF+QqpckOpnIZSi3r4Vsm+2Ldpd61P5l2sfWAZIM8KTD6Kk3zRLqwALdpLRkFc6BWbQ+UmG14UgBBiywQk3apRKhpXyBhirHiN1O4+uNz0z8eF9wm7/VfSXGPgi0ZkHYbGiSYy249q0oGgAt8So/59eyq99ZWzdaAH7RR5dvHzL96SfWQ040KlRpO3R9KoU4RkhjWwbFT7hWkEHgWPNe/s1mRdZYgjnY7L8mFYHuCnA5XzvNXQy81A0VU4SNikPLPA0iOvgBU/PMNUWk1duJ960J6rqUoovlWafb26brhh5M/EApyPgwmuFpqktlYLAjJdV3aD60StoCyNyXxV5MowYGQn6qtfi+1fhP0M6CthUGpMjBfaLOw/7ncE3o7DYH7/8R2HYWtd/QcvOgWUD3Ow1R60VDVxDchHHA0YVOywN2TO/UsGUJcXx2meK5DEE0EQW7WZ8iGxyLYxMLsA2Kc3h4ZSfvDFHregTznD0Y3VTtahLzOjgGTw+b3vLSks=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iDy6exlPlmZGIp/ux0usLiqxqOjTDrhsWWjHjM2bvEmv/Hn4VNzN8QRGEFdX?=
 =?us-ascii?Q?wJ19avk8gjXmA0SbNKPEk3a7I2kmKq1xvjaK7pXqZrkG5tsekUEt/oyJAxZQ?=
 =?us-ascii?Q?PLujiaQXQGi6aI1SZF9hX7yl6zLu3TW1rRQJf+DXy36BJdKYvNXt+deoAS/l?=
 =?us-ascii?Q?F66CJiXFhIP25gcJK3ubc23rpewu2UHu0yEbon4J+rqe/yTKEYkQxM3Sg7di?=
 =?us-ascii?Q?cvlGlHqi403jAhA3+yTWze8yImcmsJz00oVc9h7DTfrOanBlkbxOiIzXGdOv?=
 =?us-ascii?Q?9x1HrNHNrLHNU+qJsFKivEuFZ+NbXu+AgBHn9MD+yZJf7PuuA0j/ulV96PRY?=
 =?us-ascii?Q?un1EHuwgB7wulTtlmZDXrNjGSzqViCiuYGsIl8owIrLHKu/Bsh/+JRMd+DjH?=
 =?us-ascii?Q?WWxtnUWLPN1LZvP7gVaLww1jxvZC+zR/33RvN/yaaFBdwXKGl/6gMyeEk+bA?=
 =?us-ascii?Q?Sot6D88ejUh9RmstD6AeIDhMqmSo0ol03/kL106i+vIK/MVyk3oaH/YwOjRH?=
 =?us-ascii?Q?fwDARNpqLHasgcYTN0tk6aWuixufVU9Jd2k20KzPm1RmWj7ffTVW3HFU9Tfn?=
 =?us-ascii?Q?DJbcIwtZNheDFCYhI1HHIEK8QCh8NcqwJa51BZSJ/bxqe10Rm3ODGyk/To5b?=
 =?us-ascii?Q?E8jgLPhJxGfB0NRCbccY0sKB9hobfGqaCuvS1FnNkB385je9F4Oma5+hUW0T?=
 =?us-ascii?Q?lJUZl35hWHrkOKSTTsk5HLiH3UgbRSzPr1ewV16U8aRdDbZRvvsuMRI9wd9+?=
 =?us-ascii?Q?WCou+DNyvXxXdGKAVu/4yjCgd4BFUehplX87HF4nnZ808KKEzWkxGPBFpx3s?=
 =?us-ascii?Q?gCxlcIx7bTEbgC2/D6CiVx0tXCTNs4GdxH8F7iWbIYKtuA8iCNyznq0L5VXz?=
 =?us-ascii?Q?jWPmoP29kaKcvobCIAGXxI5GjQeJ708sFx3vuCI/XNd6mGPISf3BGLBReN4u?=
 =?us-ascii?Q?f0Fj7eGia0K3NqPcgrpGmSdMOlOEn92ZjqXv6Fw/GlKUfHHPnG4oVZj+M66z?=
 =?us-ascii?Q?NxJH4Iw2Ch6cfrw6VFVsgP8rG912ZOnHrse1aRfyXKpcWHOM15nhw0u1AY2h?=
 =?us-ascii?Q?6hMgG+JOhXJS4hRyanYSK5VVniexPc1rLn3nE1UZ7QZ9es8VBe8dTYkPBSPP?=
 =?us-ascii?Q?DQnMSqOmOfpQZHUfLKQAoecvpcuJxh43h+SqYOsypFvoSQg2J1mnfgYFIEvx?=
 =?us-ascii?Q?/eYvXJLcozKKtOMpifv1H6g3SeVKHHzB0qyg+zgt6Av6JTZka0QravckatCO?=
 =?us-ascii?Q?KkDBFbXfwSOvh6NB1yhSzVCcSEarR28+yJxhZmA5UK2SpFx6WgEXVK2ubj1J?=
 =?us-ascii?Q?5Vi37PbtIDhzlLJnlN8FtncTFiPaMseFd9JoOSF46pc2ZAsOizHJ4jznx+ZZ?=
 =?us-ascii?Q?qGU3gtAT8JTJNSI6Upn2PW6U+FmUuA+Q3PwXTMzUJfrczypqDfaOuvsGvo0e?=
 =?us-ascii?Q?ozSIHRLZZIQbbaqPtlZn3Wc7RiKU3fOzT5Xi0hnv2/yF8Jd6EFY3ZsESRwJc?=
 =?us-ascii?Q?hZsAjBpSCCm2nNeGSn8487Y2PVLjqVr5paBuzHv7GVKu4uNsf0nEqP49ZIOS?=
 =?us-ascii?Q?7CihXBdCnhPEa7nonvj3C5IlDdOzrNYaalOd0KbYrZvcInKKZFwiiAaInjFE?=
 =?us-ascii?Q?xNl6X/F4w67aUIEP0iMZuN1LAJByb3VOiuvfdmNX5cMYbhBhiWBv50/mDast?=
 =?us-ascii?Q?DKM8m61qnLTLrCbgaxnr84nztzPo0V3JcgAvDr03JS35UNzd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf4498a-fe43-4bce-b406-08de9fb57b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 14:51:33.8457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pprKiW61C0AguH7+IOw/Fel6Nz4P+iOUnnh3UcB08mL1qYisfsqY+sXfyDVmF572b1VrrEJbqns7zRLkCDcMMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, April 21, 2026 4:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/pm: remove trailing semicolon from
> AMDGPU_PM_POLICY_ATTR macro
>
> macros should not include a trailing semicolon as per kernel coding style
> (checkpatch.pl warning).
>
> move the semicolon from the macro definition to the invocation sites inst=
ead.
>
> checkpatch.pl logs:
> WARNING: macros should not use a trailing semicolon
> +#define AMDGPU_PM_POLICY_ATTR(_name, _id)                               =
   \
> +       static struct amdgpu_pm_policy_attr pm_policy_attr_##_name =3D { =
    \
> +               .dev_attr =3D __ATTR(_name, 0644, amdgpu_get_pm_policy_at=
tr, \
> +                                  amdgpu_set_pm_policy_attr),           =
  \
> +               .id =3D PP_PM_POLICY_##_id,                              =
    \
> +       };
>
> Fixes: 4d154b1ca580 ("drm/amd/pm: Add support for DPM policies")
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index ce9a326346e8..fd2e63530e8c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2505,12 +2505,12 @@ static ssize_t
> amdgpu_set_pm_policy_attr(struct device *dev,
>               .dev_attr =3D __ATTR(_name, 0644,
> amdgpu_get_pm_policy_attr, \
>                                  amdgpu_set_pm_policy_attr),             =
\
>               .id =3D PP_PM_POLICY_##_id,                                =
  \
> -     };
> +     }
>
>  #define AMDGPU_PM_POLICY_ATTR_VAR(_name)
> pm_policy_attr_##_name.dev_attr.attr
>
> -AMDGPU_PM_POLICY_ATTR(soc_pstate, SOC_PSTATE) -
> AMDGPU_PM_POLICY_ATTR(xgmi_plpd, XGMI_PLPD)
> +AMDGPU_PM_POLICY_ATTR(soc_pstate, SOC_PSTATE);
> +AMDGPU_PM_POLICY_ATTR(xgmi_plpd, XGMI_PLPD);
>
>  static struct attribute *pm_policy_attrs[] =3D {
>       &AMDGPU_PM_POLICY_ATTR_VAR(soc_pstate),
> --
> 2.47.3

