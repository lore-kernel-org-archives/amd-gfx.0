Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49200C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 01:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAD410E318;
	Thu, 30 Jun 2022 01:50:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EF610E318
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 01:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmV6YT37vSG0/bPX75kKwZ5eX84HBQbyRBJwuiVdCDtCXtEm324RY2zPCnE7MReY0Q/9j4gL1peGFypES41DSgIhEj7jrp80mpoiggVBLTFrEDhxVPaQiOSbJZhrvHomO0ElB6Vipdb63LjlphiJmmbv4/415nB/EujLj5lt72qQHJV5Ni4I3Bb4e7m4sjnYI3FsY1OFHXKC4BY61UV7BGOPE3CyJNR750GVjEXB0SdLUHC5ZQDtA/ZzMA29FuE2GS3oWgMj6Ov/3CTtS+hZD7OXIPJFu0D1BTWNCbEeeBUgGt4CUfgyJGedkunxbihsU8IpeCruV+OYNZ1YUzR/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE0ARV+yN9ZEKzoP8D2SYbfz5nnMazMtcaExcsr/2gk=;
 b=Pe4wwvjQcSaga0wxh8Gx4zl8/TYn05DY5EldtTeTjhUvR3zsbX/epW+8Ut3hxHrAfwGusk5BkI6w+89kXDPGmQCYQdRdF5+4efjBQ+Har5Khiduf1QPDAs2TH0w23xmJAv1RslNaeA4dt1rB6vgh0VoESc/Ko93um26ZHX2HxG7fZFU3TJWgM2itucd0Y/2exMGf56U69HWqU6bXji+lOY5Y+siYiu0v0PJzfKm0ZqnSfuPDaS6tjVUzUjdIGhoCwBhrGty47Pi+kfH719u1jrG4dr6dFs5PZytMSvuMjx3nOq3WoqZzaVu7ks52SdXXC7xkICYG+IHQQfBrNgADZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE0ARV+yN9ZEKzoP8D2SYbfz5nnMazMtcaExcsr/2gk=;
 b=uDS4CZyv2GEog6ADBma54I6owefG6Y1BsGmkrABFnHwPeQV0zotl9ksbjUUh78kkt5EsmoJnWjPkVshCjS4Mg1tyxJWaKc/7x7qqHBkI9JT9+mbH/GTGjXpgvLeteavChP3bNVgCbNWhqX1lCJMfmP3Z1xJA0FrPZ9o7ZBP4ntU=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by BYAPR12MB3528.namprd12.prod.outlook.com (2603:10b6:a03:138::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 01:50:11 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::5cc1:31e9:80ac:7e7c%9]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 01:50:10 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH 6/7] drm/amdgpu/mes: add mes ring test
Thread-Topic: [PATCH 6/7] drm/amdgpu/mes: add mes ring test
Thread-Index: AQHYi2dXA9EsNVlr2E+6Z2+QjqsMcK1mD6uAgAEgoRw=
Date: Thu, 30 Jun 2022 01:50:10 +0000
Message-ID: <MW3PR12MB44581035169F1B604F205A50EFBA9@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20220629032034.2994328-1-Jack.Xiao@amd.com>
 <20220629032034.2994328-6-Jack.Xiao@amd.com> <YrwO53lyAaF27xR1@lang-desktop>
In-Reply-To: <YrwO53lyAaF27xR1@lang-desktop>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-30T01:50:10.408Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
suggested_attachment_session_id: 9a54b25f-47b6-52e4-da4c-9d45532a93f5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 189ebe43-4910-4a2a-a197-08da5a3ade2a
x-ms-traffictypediagnostic: BYAPR12MB3528:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWsyoq8V8J9fwSdN1mTgigfFOHYjrNN0iKVytAkA6HcJ+vEgZ+jObTOD+nz4TOtLY4JeGcjTSWPbV3ELmA9S6iqTSPTmbCpbsBMYMLlKxH1skpXsBj+toXoppbBjg1gefB7LMKEBcBR7GtfnmJiF0yE5LdLkpnXwQhyooL2VIkxuUYSO3HrBdf2lR66DTrTbUdq7a/JGfmmvi9Mame9tUOVGrL4K3oaKr+N07iFgX1E6e2RAb9xvNVxsKTXd3UQZ89/XAeygnhbg+/fG35xVQE1Dpd+mnbi+EQwfAnDGhpVVYMGp8/CvNXEDA8qn55ZWYDdq86O6ji2TugWaT8/MyEI3IfbABYDiywo4q8Foz8h1mmArzr0sQQ6462uw9ws75GMki2SNuSdCsQV7MLpV1/QscZm2rW9uoFPclQqJhDlrF0XB/R9rbL4LfHPR9GiMTZEq5bqTf8vPOk0o8t/gq4KPvqozGqwY+1+ey1+oLwIhwZx/SOrH8fTd13GoC2W7yf0TOOMCBgPLklGElOkss0GbjpX28e53x765Q6UqHUc8kYA+kXBiVohQon4AjQx+EROCwunoE/DDhlQ89SEv8rz11hUYtxBF7Io1gRPCVtsnup/kfhIK0hRyxJTWzlZSQZROFZfDCNUP01vjtUX/ZzA30sxyX4nZKQspYVrQwEDrD1WsMaEbLx0KxiGWA2dI3brCqlCfieKqCbInSE9lRG6sQ7A8bUBifsVtGeLnVjUom2IywuOiyRla1UOKowGQuBcNdJSfY/KT6OSdT6CP1y8x0vhW6Jx+4nTSb0JdCu8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(4326008)(64756008)(66476007)(8676002)(5660300002)(55016003)(52536014)(66556008)(6862004)(9686003)(91956017)(83380400001)(66446008)(66946007)(71200400001)(26005)(76116006)(186003)(122000001)(38100700002)(19627405001)(478600001)(7696005)(2906002)(6506007)(316002)(38070700005)(6636002)(41300700001)(33656002)(53546011)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mqvmCr6DqHLBXY+U0FwzVTs1ky5Fxts+bQbmk7HVUl07IqDQjZs2/8rMqQZr?=
 =?us-ascii?Q?+gMgca79H6rVhT7WlYYpslQWe/QaLKptRQA6eXN3JBR4EVGA7UOglBt2vEzi?=
 =?us-ascii?Q?81uJ4+/ABW3UQVPEQ/prMRpJDod14vrArrjYAwy9bMcu9KZlA8B66FuDCO12?=
 =?us-ascii?Q?BWvFyncqRInRdOaNoi5b6CCKmmAp0NM9yu50oeOZkBKwFilDtE13XgvsneYK?=
 =?us-ascii?Q?xEq/LXBLB3uDvna8Vbshtfv8odU6PuvKCPaxtdGeZQL0/Ocs/J0Ic9iFtDbJ?=
 =?us-ascii?Q?w4AHRHuBHa2L31CJiERlKK3vG1Dv7eJ0WEfoQvTpmnmVGqIREQZ90C4Z91GO?=
 =?us-ascii?Q?8hBakpFd3bahiKb5fatw3wOcSbVRwzqfjZLENqcASBscyau1tXaL20pOPi2w?=
 =?us-ascii?Q?8OK8R0HA+ANSsZMO3H+JZ21gg2aqYBysr3qCJDYJthxlJEWKhcQx1L7x25rD?=
 =?us-ascii?Q?6tDvoMTu1VQMgCJdihxQt+66r4X4OQJ1pHupl5ZZUJo/CbCpjqPfmdSeL4Hy?=
 =?us-ascii?Q?x3yyEwevzcOmbBworrAheWmYaEp9L9twhLW/SnTFWaCO79wtFApLBqQcwImn?=
 =?us-ascii?Q?1KzWiVTQcl0ww9BG6JoPVZWemBR9HVN886cLc9BwbqpA+MyxSUSdc4Xs0KHm?=
 =?us-ascii?Q?AEFNpdYLyZvm3Fk3vOYHF0xcmc++PMkNGTXIW7VmNBwMZjcba11qohJ53BTp?=
 =?us-ascii?Q?m+BLPS01NQ9M6im/Oha8oUUIFxE2mrfa1jJH62DM1DaerUKbsplrN1CeyQDv?=
 =?us-ascii?Q?jSuuDR2WDFXDTKIwOkMnGg/6xQjLdevFU7ZR/4VInKfFwrPAO/UFiaL6LFta?=
 =?us-ascii?Q?hrWVXLN4aSMKFg3uNIshA9dBVgzLnbaaceOBl7ieXfmwhMDm+aLs1giy8esq?=
 =?us-ascii?Q?A6TzfKGR5wh1IZ4Tp9s39wN4WhwhxHWJIwd6o67uYmY6p6lMgd6ge3+5HOYE?=
 =?us-ascii?Q?jDaue7ZrfLaByqdZ7icA+UeEISBBU1a5XfihdV+MOSvt4AH7rP3LTN85RsTe?=
 =?us-ascii?Q?LSDz3Nns3xhaftPcX37fhMUEhkfim62WDT1vvmTybSuBuQf4RzbvdvTvwIiG?=
 =?us-ascii?Q?jBaZ9kqxMT2l6/je9sR8t4KQ+ty4wm4zK1/RIaY1Mx50m5znWh1VC0C4XjaG?=
 =?us-ascii?Q?tJJj5uCiMfvH+2AJZFIJ3Bw8EU/lS2gVhsj/pBZaWc0mu2E24p9D3yS44vz0?=
 =?us-ascii?Q?CfCD6QhUd//7OKlDKRJ6IkALiH3vl8D8tlHP2WqPw1LcFJNXFQIddT6zH3P9?=
 =?us-ascii?Q?DZkcH5kq8X0PkLbzR+eIO227pfkDI/KjHwCliKvtB2dCfohWE8YUohFjPP7t?=
 =?us-ascii?Q?HeI0zqntva4qOsscuMs9Sl7Lvg0djWJ8KmFyJMu2IP19f8dvtYX1sEW5EF2K?=
 =?us-ascii?Q?QOwnAIcZqArJiDB6KDsH1SDvxYkewiq0KOXnijEHFODbSP7o2HZ0dtpW6ppw?=
 =?us-ascii?Q?k5STstK1X3rO/Un1/LN6bIJPGIHC9HTtz6cZVEmNGoS+Dez0y4Hcgj4Xo1FM?=
 =?us-ascii?Q?etEKN4U/VtR+MP1ySJ5CyT4IqNzl7iFlJZg8KQBArZ2X30Iej9k2B4vnv9KS?=
 =?us-ascii?Q?+9+KqE/RVaG3LC55wsw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB44581035169F1B604F205A50EFBA9MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189ebe43-4910-4a2a-a197-08da5a3ade2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 01:50:10.7817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cy7zvyRewHpNqzeMfkN3tSho0ete/kT3ks/5Q8M+vWS5qnJ96mpSHbPh7++967y4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3528
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB44581035169F1B604F205A50EFBA9MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

will drop this single patch, and send out another independent patch for thi=
s.

Thanks,
Jack
________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Wednesday, 29 June 2022 16:35
To: Xiao, Jack <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 6/7] drm/amdgpu/mes: add mes ring test

On 06/29/ , Jack Xiao wrote:
> Use read/write register to test mes ring.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 36 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  6 +++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index b6c2a5058b64..c18ea0bc00eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -926,6 +926,42 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, =
uint32_t reg,
>        return r;
>  }
>
> +int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev)
> +{
> +     uint32_t scratch;
> +     uint32_t tmp =3D 0;
> +     unsigned i;
> +     int r =3D 0;
> +
> +     r =3D amdgpu_gfx_scratch_get(adev, &scratch);

amdgpu_gfx_scratch_get/free() have been removed in latest amd-staging-drm-n=
ext.
See e9b8129d8ca5 (drm/amdgpu: nuke dynamic gfx scratch reg allocation).

Regards,
Lang

> +     if (r) {
> +             DRM_ERROR("amdgpu: mes failed to get scratch reg (%d).\n", =
r);
> +             return r;
> +     }
> +
> +     WREG32(scratch, 0xCAFEDEAD);
> +
> +     tmp =3D amdgpu_mes_rreg(adev, scratch);
> +     if (tmp !=3D 0xCAFEDEAD) {
> +             DRM_ERROR("mes failed to read register\n");
> +             goto error;
> +     }
> +
> +     r =3D amdgpu_mes_wreg(adev, scratch, 0xDEADBEEF);
> +     if (r)
> +             goto error;
> +
> +     tmp =3D RREG32(scratch);
> +     if (tmp !=3D 0xDEADBEEF) {
> +             DRM_ERROR("mes failed to write register\n");
> +             r =3D -EIO;
> +     }
> +
> +error:
> +     amdgpu_gfx_scratch_free(adev, scratch);
> +     return r;
> +}
> +
>  static void
>  amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
>                               struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 93b2ba817916..81610e3f3059 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -341,6 +341,7 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, u=
int32_t reg,
>  int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>                                  uint32_t reg0, uint32_t reg1,
>                                  uint32_t ref, uint32_t mask);
> +int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev);
>
>  int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>                        int queue_type, int idx,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 2a6c7a680c62..c4d085429d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1194,6 +1194,12 @@ static int mes_v11_0_hw_init(void *handle)
>                goto failure;
>        }
>
> +     r =3D amdgpu_mes_ring_test_ring(adev);
> +     if (r) {
> +             DRM_ERROR("MES ring test failed\n");
> +             goto failure;
> +     }
> +
>        /*
>         * Disable KIQ ring usage from the driver once MES is enabled.
>         * MES uses KIQ ring exclusively so driver cannot access KIQ ring
> --
> 2.35.1
>

--_000_MW3PR12MB44581035169F1B604F205A50EFBA9MW3PR12MB4458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
will drop this single patch, and send out another independent patch for thi=
s.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jack</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, 29 June 2022 16:35<br>
<b>To:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH 6/7] drm/amdgpu/mes: add mes ring test</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 06/29/ , Jack Xiao wrote:<br>
&gt; Use read/write register to test mes ring.<br>
&gt; <br>
&gt; Signed-off-by: Jack Xiao &lt;Jack.Xiao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 36 +++++++++++++++++++=
++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; |&nbsp; 6 +++++<br>
&gt;&nbsp; 3 files changed, 43 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_mes.c<br>
&gt; index b6c2a5058b64..c18ea0bc00eb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
&gt; @@ -926,6 +926,42 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *ade=
v, uint32_t reg,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t scratch;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_scratch_get(adev, &amp;scra=
tch);<br>
<br>
amdgpu_gfx_scratch_get/free() have been removed in latest amd-staging-drm-n=
ext.<br>
See e9b8129d8ca5 (drm/amdgpu: nuke dynamic gfx scratch reg allocation).<br>
<br>
Regards,<br>
Lang<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_ERROR(&quot;amdgpu: mes failed to get scratch reg (%d).\n&quot;, r)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WREG32(scratch, 0xCAFEDEAD);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D amdgpu_mes_rreg(adev, scratch);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (tmp !=3D 0xCAFEDEAD) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_ERROR(&quot;mes failed to read register\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes_wreg(adev, scratch, 0xDEADB=
EEF);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(scratch);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (tmp !=3D 0xDEADBEEF) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_ERROR(&quot;mes failed to write register\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -EIO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +error:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_scratch_free(adev, scratch);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static void<br>
&gt;&nbsp; amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_mes.h<br>
&gt; index 93b2ba817916..81610e3f3059 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
&gt; @@ -341,6 +341,7 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev=
, uint32_t reg,<br>
&gt;&nbsp; int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg0, uint32_=
t reg1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ref, uint32_t=
 mask);<br>
&gt; +int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp; int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int que=
ue_type, int idx,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/mes_v11_0.c<br>
&gt; index 2a6c7a680c62..c4d085429d26 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
&gt; @@ -1194,6 +1194,12 @@ static int mes_v11_0_hw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto failure;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes_ring_test_ring(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_ERROR(&quot;MES ring test failed\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto failure;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable KIQ ring usa=
ge from the driver once MES is enabled.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MES uses KIQ ring ex=
clusively so driver cannot access KIQ ring<br>
&gt; -- <br>
&gt; 2.35.1<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB44581035169F1B604F205A50EFBA9MW3PR12MB4458namp_--
