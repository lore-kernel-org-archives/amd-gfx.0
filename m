Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B656C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAE06008E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAE06008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97246EB75;
	Tue, 18 May 2021 13:25:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840F66EB75
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 13:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0FKSWUc169F3y8Ike6/6VlnP5d2cSXlHI08k+uke1WXly4z9SrilhEfqtKKv1/8rbNK5r6zTGhB/h7wE24rGPQ1hc0LjLC9m76F7wttFzYO4QmqcELNtMg3IXcQGZEFlecCsAEzZPhe32b0cbgIJWqTmKALNOwmd2jOj4i59OWzDnlqOCkgVqkrAftOwRWXlvV5fVixYzJHHF9EHPeHSgU3ak2VWXYHYO+4NSqd489Z/bfT6fC1EeQZk7ZRQQfQPA2dSCNDok94L4ovePvs+FUF+Nb0kENOlCLqPsKhXyrpjx2C2Bj4nM1CuBHmnHtZziM9tlfpgQ/oiF3W6GODCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdsatqgU7tjyBgcQe8wJcKzFMo6K7Gm75nNuApR2epM=;
 b=D0Q8DwWu6VczF005lRtV7Vu2L6achiKHUgejzunk+zZ1wbg7Sx8WzKJCPy8wHgWoA9qhNwEW/+dBgKvdFip9j7q/IOrQpDpvd+SCB9KEkv9qZ417beo6gxF0IMdZhd39/KuBZ7vg1nDIwc97v0Da49Yj0PlcxGCTnqugNWSbgUyay/W5t1Cvrhhs/I8glus3F02APps5ZHBOBRudKuUZ1T9sB7QAhkSYbFeX60DCuKwXbfzRkHoVIg+eWIgUjDya/VtAcwvgRpIhZJksokP/4egimIKNXGRyeMHiumaZcgqnoPkZKAyY4xdaNiMBHD/DxE/5UIdcAcln5Iw9WH0d0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdsatqgU7tjyBgcQe8wJcKzFMo6K7Gm75nNuApR2epM=;
 b=vx/vrgAJzTdcuGsh7g8OUeTRrxuU/xr2BWghHk29DC7YQ2DT8s+zDnTEHAnNHiFfBwFebVGR+JiRrpTQ3Gk1KxGuEN/JZQ4poJTah/hzWovfeyqTV0bSf3cjoF55Ui4vBjsFbLgRbR7NcuhZlgeRQutrUSA3ZGsUoqYhntTjeog=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 13:25:54 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::6c1d:e14b:dc15:7e56%2]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 13:25:54 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Gu, JiaWei (Will)"
 <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Nieto, David M" <David.Nieto@amd.com>,
 "maraeo@gmail.com" <maraeo@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXS+ggLqeaNToDD0+Q6GOxv4p+/6rpOqCq
Date: Tue, 18 May 2021 13:25:54 +0000
Message-ID: <DM6PR12MB3547CE479C026EF6D7F8A26CF72C9@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210518121628.9811-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51560CD55134762EF8FE19E0F82C9@CH0PR12MB5156.namprd12.prod.outlook.com>,
 <1ec97d1f-aaa3-46c1-b702-378879e67cc5@amd.com>
In-Reply-To: <1ec97d1f-aaa3-46c1-b702-378879e67cc5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-18T13:25:54.216Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:f2c0:e4c0:b2:d3fb:b908:583b:772c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee6130e1-37d7-482d-692d-08d91a0076fa
x-ms-traffictypediagnostic: DM6PR12MB4895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4895E17B8047A228C5BE4AD0F72C9@DM6PR12MB4895.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5IfW8FPyl8cbpuWR0epXUpeBz4UFcwic2u1j+ukq8TzBD5nI68p5FQ32Q7Hn7eu8feJVAZ6SDS0j93fLM1oUjDATZoRO+hrWtCBMZ38Stnx4xIY/kvVgaP4fNCjCZyNshFkPTdXM+JHciEbM5mDE07PxmWZ/uup0ptWOLQOkw6yHRSaoxtlxuUfUNHcddz5Wa/wZ1skO9F6s3atE4E9ftmVS53DvqF5zuifMqoZi82EE7TTQFm8rWdMwQiF2IyT5O9A6uKhgf+/O+Su4Rg6MNvd0jpYrafNXQkwY4hwvR9wqh0qH6k4H/ju9D7kP3CG7+E64T5R9g2pNNK4yTkauUh9tuOcn5Ha7wqaHUHAxBPcnXXP6iKGF3O+BTQdNVqyWsc4qdlWs50ri1XFh+UxqBSKxvdCAU6Ttca+2RNcxy0A+h8EqHhzOZ7lplqfZLIW0WeMIhaH/S+CPytb2soh3YliN48nK07OAf4uI0vo7VmZFUObPdYmIshAtAaHESRYe2wtRfC+cBNljgINtc7XJrgW3hXPdDQjmMTNe9iw3gPJRt86XwOmN6TC8+T+6un9ETqxKCPksw6U157P6be0NZZtMchFvd9ouwUYIlH1GYOohnJbQ+GlOtvzGYiYQQBs3EGhxgvlSKrY0P4bUvVEoU9eSgY7lVQErNps1dDfroCIPulwppeuVchdAXUOKDuj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(9686003)(64756008)(66556008)(66476007)(4326008)(55016002)(66446008)(921005)(83380400001)(30864003)(7696005)(122000001)(8936002)(38100700002)(33656002)(66574015)(5660300002)(53546011)(6506007)(45080400002)(86362001)(316002)(71200400001)(2906002)(186003)(966005)(8676002)(66946007)(6636002)(52536014)(110136005)(478600001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9WAf4ZxjTiTLLofwXgty5AJhsz0w6jDf+X4bnWdAmIVQ6YgCPmIgAiw89z?=
 =?iso-8859-1?Q?zoQQXm5sCw8fKU93H1DrT6VhuJGoS8qLztMDHocMHW4TN5ZGS19zdvBW9s?=
 =?iso-8859-1?Q?iIlkCHayEsylrO3vh8Q/EpbeTnphNc6Mm5NZxcQlko2Amhir6vcituydod?=
 =?iso-8859-1?Q?AnMUC94161VoB7Y4o88/ZxDpH9SKjRcGtC6cHVqZkSo5znk4vAF0pMYOoO?=
 =?iso-8859-1?Q?830Yh0UXDiueAcPCvMm5h6dqQw89IXkzh+9qzp2OI2UVtoVRyv7riiA3+X?=
 =?iso-8859-1?Q?qUeymwjeQbfDog+dUIyD17PNnxbpdP90DZ+3xcmsh+KPVOYv2Fn2gWJsOY?=
 =?iso-8859-1?Q?gyAPuCwYqvBMns+3JFY19Kw4muVRawUYYVQRus1dIcA5yfDxTDZU1k6y3Z?=
 =?iso-8859-1?Q?Q6zewV+jXN0ik8wKockz6MlIiB9Tkz31JbXoJrumwH0dqC1LJq/Q8IPg0a?=
 =?iso-8859-1?Q?6PrtT+mp8TW8hjplH7HzXFNPpB5XCqPjYQf1VSySvuHaOAUg4yDxHsxlRW?=
 =?iso-8859-1?Q?PQgj4/2JLTPWdXwLnahSp1laDGFHENVnB9gZMX3/q/2MvPGgd1ruGaOj4g?=
 =?iso-8859-1?Q?X7CvJA1OJeXf9qwARJPfwTEycDd2qONS3yRv2nTh9BBqRy2ss6Uew2Seb0?=
 =?iso-8859-1?Q?lleC9/8LVWYRtpO85kw9jOHq0hWrHH1xGYh32DGnbKZAqsYBZlFhBKB7MU?=
 =?iso-8859-1?Q?u6ge+8VegbGyXd0/ZS6vEAHBrnj0PTJAubl+e/PZTXBJ8VMtWM30cH9ueg?=
 =?iso-8859-1?Q?3pwH/1q6O5UF/Ogr/rk6pxO7Oea8K5xsM2rT2a/xn4yqlY5FKMluHvVo17?=
 =?iso-8859-1?Q?60m+nddYKKn04iWBf3nXbkscNoorvmQvU6I/AsQvrM/LYk1cMPGsGwUpRC?=
 =?iso-8859-1?Q?qJa2RF9UqkwBSSP6aTdW2Q5ov6Sd401cBBgWwREu8P/fL6I/p6le+cjFMl?=
 =?iso-8859-1?Q?r4zqTnRPX/h3C6gx8Sb06k3PrlLxMBjTJwyLexmLBP0yA08LR3Sk2qwpC/?=
 =?iso-8859-1?Q?NUt2CajnpcGtnAD0NqWFNORpz2VVirSmOM1OHpbs7kUKeKrTxUrsOBIoOj?=
 =?iso-8859-1?Q?4qexrUbl8GEAP+iS7tgmzudsG2HQ7iohmbGf6ASCWXQb661R8oEuAToRXf?=
 =?iso-8859-1?Q?T9kbILboBudeqyOYJejql156agHP6RcnURrUoai1SK/6mxV6UicNSWTKua?=
 =?iso-8859-1?Q?DNfCqGKQEwNJoO1Gs/4Ftt1YW0M/gbLSt1V1FYsr++ypGvQ3ys329BMaf8?=
 =?iso-8859-1?Q?kOC5FEWuFPqpMQ718FCBQ6pFcG5QYcE7vyD8wZtrJFuf+KYs8s4fZB3xpF?=
 =?iso-8859-1?Q?9K2HE6e1tfhxwdNGvAz45SPovfHw9V72Fl7G7Pxp4Hx8TuXLSQ6EBe9qks?=
 =?iso-8859-1?Q?EmcrrAzzzJ6BSOjq0ZsywuXuach/SiAozJTymh4s2i83SUH23Ykj8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6130e1-37d7-482d-692d-08d91a0076fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 13:25:54.6561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoUPy583t8IUvhP+Ip0NOdqvfCDYef+BZprUgR6zIgryEQNAZwBKF3IsOGy0HV9fAD6Ph3gE09BNPYYSkGRCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

If changing the ioctl is an issue why not just use sysfs?  umr already make=
s uses of all three for it's purposes so it's fine by me for either.

Tom

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <christian.koenig@amd.com>
Sent: Tuesday, May 18, 2021 09:17
To: Gu, JiaWei (Will); amd-gfx@lists.freedesktop.org; Nieto, David M; marae=
o@gmail.com; Deucher, Alexander
Cc: Deng, Emily
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

Well not an expert on that stuff, but looks like that should work for me.

Question is can you provide a patch to use that information in Mesa as
well? Umr might be sufficient as well as justification for upstreaming,
but I want to be better save than sorry.

Unless Marek has a better idea maybe add the vbios version to the string
returned by GLX_MESA_query_renderer or something like that.

Thanks,
Christian.

Am 18.05.21 um 14:19 schrieb Gu, JiaWei (Will):
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi all,
>
> Please help confirm that we're all fine with this new struct in uapi in t=
his V3 patch:
>
> +struct drm_amdgpu_info_vbios {
> +     __u8 name[64];
> +     __u8 vbios_pn[64];
> +     __u32 version;
> +     __u8 vbios_ver_str[32];
> +     __u8 date[32];
> +};
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Tuesday, May 18, 2021 8:16 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@am=
d.com>; Nieto, David M <David.Nieto@amd.com>; maraeo@gmail.com; Deucher, Al=
exander <Alexander.Deucher@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.co=
m>
> Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
>
> Provides a way for the user application to get the VBIOS information with=
out having to parse the binary.
> It is useful for the user to be able to display in a simple way the VBIOS=
 version in their system if they happen to encounter an issue.
>
> V2:
> Use numeric serial.
> Parse and expose vbios version string.
>
> V3:
> Remove redundant data in drm_amdgpu_info_vbios struct.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
>   drivers/gpu/drm/amd/amdgpu/atom.c          | 172 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
>   drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
>   include/uapi/drm/amdgpu_drm.h              |  10 ++
>   5 files changed, 212 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 8d12e474745a..524e4fe5efe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>                                           min((size_t)size, (size_t)(bios=
_size - bios_offset)))
>                                       ? -EFAULT : 0;
>               }
> +             case AMDGPU_INFO_VBIOS_INFO: {
> +                     struct drm_amdgpu_info_vbios vbios_info =3D {};
> +                     struct atom_context *atom_context;
> +
> +                     atom_context =3D adev->mode_info.atom_context;
> +                     memcpy(vbios_info.name, atom_context->name, sizeof(=
atom_context->name));
> +                     memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,=
 sizeof(atom_context->vbios_pn));
> +                     vbios_info.version =3D atom_context->version;
> +                     memcpy(vbios_info.vbios_ver_str, atom_context->vbio=
s_ver_str,
> +                                             sizeof(atom_context->vbios_=
ver_str));
> +                     memcpy(vbios_info.date, atom_context->date,
> +sizeof(atom_context->date));
> +
> +                     return copy_to_user(out, &vbios_info,
> +                                             min((size_t)size, sizeof(vb=
ios_info))) ? -EFAULT : 0;
> +             }
>               default:
>                       DRM_DEBUG_KMS("Invalid request %d\n",
>                                       info->vbios_info.type);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 3dcb8b32f48b..6fa2229b7229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -31,6 +31,7 @@
>
>   #define ATOM_DEBUG
>
> +#include "atomfirmware.h"
>   #include "atom.h"
>   #include "atom-names.h"
>   #include "atom-bits.h"
> @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context *=
ctx, int base)
>       }
>   }
>
> +static void atom_get_vbios_name(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned char str_num;
> +     unsigned short off_to_vbios_str;
> +     unsigned char *c_ptr;
> +     int name_size;
> +     int i;
> +
> +     const char *na =3D "--N/A--";
> +     char *back;
> +
> +     p_rom =3D ctx->bios;
> +
> +     str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
> +     if (str_num !=3D 0) {
> +             off_to_vbios_str =3D
> +                     *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_=
STRING_START);
> +
> +             c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);
> +     } else {
> +             /* do not know where to find name */
> +             memcpy(ctx->name, na, 7);
> +             ctx->name[7] =3D 0;
> +             return;
> +     }
> +
> +     /*
> +      * skip the atombios strings, usually 4
> +      * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
> +      */
> +     for (i =3D 0; i < str_num; i++) {
> +             while (*c_ptr !=3D 0)
> +                     c_ptr++;
> +             c_ptr++;
> +     }
> +
> +     /* skip the following 2 chars: 0x0D 0x0A */
> +     c_ptr +=3D 2;
> +
> +     name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);
> +     memcpy(ctx->name, c_ptr, name_size);
> +     back =3D ctx->name + name_size;
> +     while ((*--back) =3D=3D ' ')
> +             ;
> +     *(back + 1) =3D '\0';
> +}
> +
> +static void atom_get_vbios_date(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned char *date_in_rom;
> +
> +     p_rom =3D ctx->bios;
> +
> +     date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;
> +
> +     ctx->date[0] =3D '2';
> +     ctx->date[1] =3D '0';
> +     ctx->date[2] =3D date_in_rom[6];
> +     ctx->date[3] =3D date_in_rom[7];
> +     ctx->date[4] =3D '/';
> +     ctx->date[5] =3D date_in_rom[0];
> +     ctx->date[6] =3D date_in_rom[1];
> +     ctx->date[7] =3D '/';
> +     ctx->date[8] =3D date_in_rom[3];
> +     ctx->date[9] =3D date_in_rom[4];
> +     ctx->date[10] =3D ' ';
> +     ctx->date[11] =3D date_in_rom[9];
> +     ctx->date[12] =3D date_in_rom[10];
> +     ctx->date[13] =3D date_in_rom[11];
> +     ctx->date[14] =3D date_in_rom[12];
> +     ctx->date[15] =3D date_in_rom[13];
> +     ctx->date[16] =3D '\0';
> +}
> +
> +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, cha=
r *str, int start,
> +                                        int end, int maxlen)
> +{
> +     unsigned long str_off;
> +     unsigned char *p_rom;
> +     unsigned short str_len;
> +
> +     str_off =3D 0;
> +     str_len =3D strnlen(str, maxlen);
> +     p_rom =3D ctx->bios;
> +
> +     for (; start <=3D end; ++start) {
> +             for (str_off =3D 0; str_off < str_len; ++str_off) {
> +                     if (str[str_off] !=3D *(p_rom + start + str_off))
> +                             break;
> +             }
> +
> +             if (str_off =3D=3D str_len || str[str_off] =3D=3D 0)
> +                     return p_rom + start;
> +     }
> +     return NULL;
> +}
> +
> +static void atom_get_vbios_pn(struct atom_context *ctx) {
> +     unsigned char *p_rom;
> +     unsigned short off_to_vbios_str;
> +     unsigned char *vbios_str;
> +     int count;
> +
> +     off_to_vbios_str =3D 0;
> +     p_rom =3D ctx->bios;
> +
> +     if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) !=3D 0) {
> +             off_to_vbios_str =3D
> +                     *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_=
STRING_START);
> +
> +             vbios_str =3D (unsigned char *)(p_rom + off_to_vbios_str);
> +     } else {
> +             vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
> +     }
> +
> +     if (*vbios_str =3D=3D 0) {
> +             vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3=
, 1024, 64);
> +             if (vbios_str =3D=3D NULL)
> +                     vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
> +     }
> +     if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
> +             vbios_str++;
> +
> +     if (vbios_str !=3D NULL) {
> +             count =3D 0;
> +             while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >=
=3D ' ' &&
> +                    vbios_str[count] <=3D 'z') {
> +                     ctx->vbios_pn[count] =3D vbios_str[count];
> +                     count++;
> +             }
> +
> +             ctx->vbios_pn[count] =3D 0;
> +     }
> +}
> +
> +static void atom_get_vbios_version(struct atom_context *ctx) {
> +     unsigned char *vbios_ver;
> +
> +     /* find anchor ATOMBIOSBK-AMD */
> +     vbios_ver =3D atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 102=
4, 64);
> +     if (vbios_ver !=3D NULL) {
> +             /* skip ATOMBIOSBK-AMD VER */
> +             vbios_ver +=3D 18;
> +             memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> +     } else {
> +             ctx->vbios_ver_str[0] =3D '\0';
> +     }
> +}
> +
>   struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bi=
os)  {
>       int base;
>       struct atom_context *ctx =3D
>           kzalloc(sizeof(struct atom_context), GFP_KERNEL);
>       char *str;
> +     struct _ATOM_ROM_HEADER *atom_rom_header;
> +     struct _ATOM_MASTER_DATA_TABLE *master_table;
> +     struct _ATOM_FIRMWARE_INFO *atom_fw_info;
>       u16 idx;
>
>       if (!ctx)
> @@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct card=
_info *card, void *bios)
>               strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version)=
);
>       }
>
> +     atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CSTR(base);
> +     if (atom_rom_header->usMasterDataTableOffset !=3D 0) {
> +             master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)
> +                             CSTR(atom_rom_header->usMasterDataTableOffs=
et);
> +             if (master_table->ListOfDataTables.FirmwareInfo !=3D 0) {
> +                     atom_fw_info =3D (struct _ATOM_FIRMWARE_INFO *)
> +                                     CSTR(master_table->ListOfDataTables=
.FirmwareInfo);
> +                     ctx->version =3D atom_fw_info->ulFirmwareRevision;
> +             }
> +     }
> +
> +     atom_get_vbios_name(ctx);
> +     atom_get_vbios_pn(ctx);
> +     atom_get_vbios_date(ctx);
> +     atom_get_vbios_version(ctx);
>
>       return ctx;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdg=
pu/atom.h
> index d279759cab47..0c1839824520 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -112,6 +112,10 @@ struct drm_device;
>   #define ATOM_IO_SYSIO               2
>   #define ATOM_IO_IIO         0x80
>
> +#define STRLEN_NORMAL                32
> +#define STRLEN_LONG          64
> +#define STRLEN_VERYLONG              254
> +
>   struct card_info {
>       struct drm_device *dev;
>       void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  f=
illed by driver */
> @@ -140,6 +144,12 @@ struct atom_context {
>       uint32_t *scratch;
>       int scratch_size_bytes;
>       char vbios_version[20];
> +
> +     uint8_t name[STRLEN_LONG];
> +     uint8_t vbios_pn[STRLEN_LONG];
> +     uint32_t version;
> +     uint8_t vbios_ver_str[STRLEN_NORMAL];
> +     uint8_t date[STRLEN_NORMAL];
>   };
>
>   extern int amdgpu_atom_debug;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index 275468e4be60..28deecc2f990 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
>     DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,
>   };
>
> +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> +#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
> +#define BIOS_STRING_LENGTH 43
>
>   /*
>   enum atom_string_def{
> @@ -215,6 +218,8 @@ enum atombios_image_offset{
>     MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D 20,  /*including the t=
erminator 0x0!*/
>     OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D 0x2f,
>     OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D 0x6e,
> +  OFFSET_TO_VBIOS_PART_NUMBER                =3D 0x80,
> +  OFFSET_TO_VBIOS_DATE                       =3D 0x50,
>   };
>
>   /**********************************************************************=
******
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index 9169df7fadee..155fd9918b4d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
>       #define AMDGPU_INFO_VBIOS_SIZE          0x1
>       /* Subquery id: Query vbios image */
>       #define AMDGPU_INFO_VBIOS_IMAGE         0x2
> +     /* Subquery id: Query vbios info */
> +     #define AMDGPU_INFO_VBIOS_INFO          0x3
>   /* Query UVD handles */
>   #define AMDGPU_INFO_NUM_HANDLES                     0x1C
>   /* Query sensor related information */
> @@ -949,6 +951,14 @@ struct drm_amdgpu_info_firmware {
>       __u32 feature;
>   };
>
> +struct drm_amdgpu_info_vbios {
> +     __u8 name[64];
> +     __u8 vbios_pn[64];
> +     __u32 version;
> +     __u8 vbios_ver_str[32];
> +     __u8 date[32];
> +};
> +
>   #define AMDGPU_VRAM_TYPE_UNKNOWN 0
>   #define AMDGPU_VRAM_TYPE_GDDR1 1
>   #define AMDGPU_VRAM_TYPE_DDR2  2
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Ctom.stde=
nis%40amd.com%7C332524597a5e42ad491908d919ff414f%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637569406377960645%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DZF=
BUbqu1VjvQkpnQ4Wy6Q4XE9CB2IcFltOq3Iv12F7U%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
