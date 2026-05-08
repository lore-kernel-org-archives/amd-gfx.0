Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A43CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 04:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40B210F328;
	Fri,  8 May 2026 04:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixFDe9xo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9857710F328
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 04:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqV0i3dcipEXJRItvXvXx7dV+YYbNYIilO/oyAc1t3Oc8EvC+L5ce6VO+aVd3bBfBkhUPIem9heZ522MCGQL8BtZ2L6aetFW+jedGNKNog4yyXC2+7NZLEjgWeG2tmO8X/YHBxulmGbIooohyansb4I9gpv9umioqdGx1rqA5kcc5eRd9vKuuJO+n4HWUBhCuyJep7kGY8kUSh7b+/3+DsMQM6uiLVxLJypiS86q7SN36w3FW1FBMSSNc2/CGl6s/RZxSvC2k+moLDoYs1F1WBMji+PdEbAUpZhiLdfQXjDXkDhmu+hkP4KXZ5m3Zkh2FzxE8KOQFP18wnMF/zMvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/sM3g2hl+oK1zOfGuMyZEx1PJJSG46/eZzudrlUQAA=;
 b=BnV74TqMZcc7W9CkDbSUiJRSrz4X9Q+izZH3Oo4jFd59Yznt3XlnjEzKhOrMyHSnZZaaWlj8iKkPUng0llk47lAYsXfNFaA7a5dLuh9LbocYGBdKBEqdAJiVeKn30O/0aAPSupCZFpqRafS0rM4VBih1JMRMqpKuNbrf6xCG+LWKN4xt1fWG8QGd/6OuEwMqT2+XaSGPTzwQgfo2fjs0oT70Dilu8kF9U1DZlWdFgko09nVb2HKd6o0PHQQyLGyDZ54p/5HoiMMpEkzIE5/gTGxjayjoyJ/Ssd09UFvZDFsqb/3H3KSNwZ2GsPflXy4IWr9+A6mrjHpVDf0pxSzQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/sM3g2hl+oK1zOfGuMyZEx1PJJSG46/eZzudrlUQAA=;
 b=ixFDe9xoO1gjlYKpw1a6J1tZZc/zDD7sDO6D3WgJLURkStEL+kdWDJ9Jg+3udogCFaxoP3Zv7bs1lhimrZyQqMwSOkBJGiKIkk0AlDKTw7KcbrKEqrCLieDCvFJXKcCy020ULh8mJpRFJdC8EQ5BF/dEAzCHqN1R8mODFLj4Unk=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 04:06:11 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::a136:cb8b:515d:4fa4]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::a136:cb8b:515d:4fa4%4]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 04:06:11 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Xiang(Dean)"
 <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Fix CPER ring debugfs read overflow
Thread-Topic: [PATCH] drm/amd/ras: Fix CPER ring debugfs read overflow
Thread-Index: AQHc3iomgFl/Xqv5lU+Pzf35lTQklLYDgzBA
Date: Fri, 8 May 2026 04:06:11 +0000
Message-ID: <SJ2PR12MB8807EE0C58A292810DA19A17B03D2@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20260507140004.244348-1-xiang.liu@amd.com>
In-Reply-To: <20260507140004.244348-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-08T04:04:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|SA3PR12MB9226:EE_
x-ms-office365-filtering-correlation-id: 306807aa-8fd8-4362-9072-08deacb723f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: bYU+siQgFXtQtyu2B4jhIM/cmTQNWhOhtHpXKMXZvf+msoZQ89ulFDcVCAWdcTh8niS6DnT0sM/H7W3qvwaDad9VZQBGqWctZ+DE7N3UEFK98iEGlgh7/eFkf5VDEKah9Iabb0c2KlQS9M8aBdfMdUPewm2tLM6VemQ7rom6JUPbFtV+EhFLXaw/dLZM21Vn9Og7V7Zq5o8qdaw2FUY/VLfJJB6R+bIC/+y5Yc+jGbbVnTQm0t4FwCF25gN/oTqBNxIPSAciFZMZsMBlhmTGKTofMbldfgPSairwT9Mu/oOvJF9x8f4rfczJmeY9kLdFF/AyiHPBFot/MXpxnpK55Z7dwP+orFEJNL35lyy3+IyfXOOBAd3UtXx64MICPTQxF+e1eQBcB1qZ7T6piw4XZUgHTTv2j2/dzRVMUBO3ICOPm9B+jTd6i3bK+jOc1HE4OSWCsY9TcpR22nvuoX+7I6NBgo5eA9Vq4F2405x/hvKPuf3irG6acdItTHoQ8YpboeM66XzB16movbfLaXoITMiQXvXeFkyU1jSN6B9IzPrU45mm/Lwv5oT+5AJk5gB7NoVlmP5yagv+edI5oUFoHqCDouGGPGw9BErlKMYJqBfI2Mb3Rwke5fUcN6WRELXQ4Yb2nVlcHuXgUglAu47je1oYrY1cvajasEvIYOCR0bLCadW1/IeYG97u3xCEpIZMPwc9hhZT132DzFKLkg3p355ii64RL77rYRuskv8InO2UF+cVaz88QeNymNQEKpvE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GO4/NKDqNCi5aYvIujO+SS8SqHI2RYSmCVJpHFosbZDsEo7+hhoKJxRL7w+C?=
 =?us-ascii?Q?TQ1dbo1OesObu7lKMh311TCqPEZ8QwTA+wgcHJdJe7avB1tYAQSOCWhGlWTB?=
 =?us-ascii?Q?zfx5zmz9NC487leb47svSh4YKOU3L12nUudGnqYFSzurbIQAl+dyzYEZ4iOA?=
 =?us-ascii?Q?waG+o9v1rjAtGivtkx3Zw8lmRX/Z6vr8LB2vFJ7K8RU9Z636oBOrhH/aYQh9?=
 =?us-ascii?Q?pj6dSNtzQru3KNCxoscFklmex/HpyuOAI9Gcs1Bb1qV+WpseBZIGfAtZP2aO?=
 =?us-ascii?Q?47RWyYjyyoYxvpODokWodvCa5H1Yq8Dh1H0yWKg8c09RTPddnWq3ev7k/mYW?=
 =?us-ascii?Q?3HgNa5wRnmLA/EtA+i4XJ4BePDVQS1GTV+K6MNKNo4cTgUb2PXvzB93a4Ty3?=
 =?us-ascii?Q?XFkZDS7Mw/+Lu1taOQYSFV78xLYpeiqw9vnz4YFD0cU4PhSRR9JfawzSecLz?=
 =?us-ascii?Q?fUFb7DHTV/V6yeoOMtRsZkcQHEi81NWRnwnJnL1rnuKXjF89KrpMNWTsUaPF?=
 =?us-ascii?Q?lO4SBKJGEAKVWbRZMuEw4qh6fuyneJmvvzO9Me2aqYqwwW3srf8yzVthgjiD?=
 =?us-ascii?Q?p1yuy6rXmPLXsBZ3uo32KlFu0uo48Urjx3GBlViEccK4pLq3aQTSkGWKh3ur?=
 =?us-ascii?Q?DMNDPv0D+3Vv9TFzojLcHZkD5sCb6iFlwFs+U9bCMBE2ToWQtKl9waLmim1T?=
 =?us-ascii?Q?S3IbGkT1d5VHQ0ILaWuBDBTeXTz9ceKVQu4HTIiqeedtwsBpToFx0cMxe/nY?=
 =?us-ascii?Q?nMmhkUIse3xLKRLRR4jfE4xsIvjednYEyziHrsBsZDAzY+M56iOgq1Cb2LFT?=
 =?us-ascii?Q?3MHU0tRIkeeQwl6ZLHoI2glDmWNvifNjj/1RxiZOlodeqTFiMydWfXa4WiSy?=
 =?us-ascii?Q?HGLu9jKmpfU4Z2urtvZCZlohTnEmK85Dh89sMsfvuKG7+f0K25xfiF+ke1MM?=
 =?us-ascii?Q?JM4icHQ5VjueCUEnZt2VBCHiGDili+xw8H6LtkZPM4cAWP2ob/iQMC4ic2/x?=
 =?us-ascii?Q?pXrlpXlUGbClVZvPWXKwsdtFc5Z8ucyRlaqM/StzBrEVdNDPRSMDMZQU9nvK?=
 =?us-ascii?Q?JIEipbTO1tMgqWJ5JN/cUREC4m1MDrTJ45SWDbPHcO63MM7hVe+hycriL2bY?=
 =?us-ascii?Q?6SYormT6UaJCXOZCS9E+zmepFoM2yrYuUgb0OwqnIF9OrnkigI4Voi289dBG?=
 =?us-ascii?Q?OS+xGKMp0BDBmq7tPmRMAD7ZzPs1OPFmWjje1E/Rf9r0FQ8EfHDGzzn53sAJ?=
 =?us-ascii?Q?UhC/hB1I1jUve/AaThopARAWEy44rCmAp3LWfO7jB2msGGh+YmXOvJ5t6W7N?=
 =?us-ascii?Q?Q4qzAmF3D2nbSivxhqAP0NMBQUrxFf6jCfLpaiSOJwegqGQ9+6sTlGT4eCiQ?=
 =?us-ascii?Q?I5wbluNjy0aXNMQBgHnweEo0500MFA1xPO2LU5bTjlfuQJ7uAm/ERQkWcH+J?=
 =?us-ascii?Q?FRQb8POagbY9uymPO7YDdIvc6IlfVg+k5gIFE9dV9dd3juUWyMk4vy+2bYxW?=
 =?us-ascii?Q?3XgPW9UKHt08pSfqzY6QCPU9Pkf3KK/jOttUK3GMjdRBuRDThtspUQQKZRj/?=
 =?us-ascii?Q?iWAcCjzIjp5S/Qurrx+mN18sfXHADj4Tv9Fq5Ty1xH6wNCf9qqOLr+m+SYQ4?=
 =?us-ascii?Q?jEZjU/QOSrNx88+FS43DmoPXbzm7+FEo/kLiMmyKIRgOgOyZFyS5S0k7fqIW?=
 =?us-ascii?Q?+JOgWQgW2SEt3QpVltBxzt9a01HFUL6aeadWtZkl3w1f449w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306807aa-8fd8-4362-9072-08deacb723f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 04:06:11.5173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXVuQAqLYWrtAQL1uwENBwvSYbYVQD2baWJHJ7hyxZhko2cHsrcU2hy6lexTUcpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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

AMD General

Thanks for the fix, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang
> Liu
> Sent: Thursday, May 7, 2026 10:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amd/ras: Fix CPER ring debugfs read overflow
>
> The legacy CPER debugfs reader can reach the payload path without a valid
> pointer snapshot. The remaining user byte count is also treated as the ri=
ng
> occupancy in dwords, so reads past the header can copy more than
> requested.
>
> Take the CPER lock before sampling pointers. Resample rptr/wptr for paylo=
ad
> reads, bound the payload copy by available dwords and the remaining user
> size, and advance the file position for each dword copied.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 29 +++++++++++++++++-----
> --
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 5de786551aaa..e47a155f4bb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -552,8 +552,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *=
f,
> char __user *buf,
>                                       size_t size, loff_t *pos)
>  {
>       struct amdgpu_ring *ring =3D file_inode(f)->i_private;
> -     uint32_t value, result, early[3];
> +     u32 value, result, early[3] =3D { 0 };
>       uint64_t p;
> +     u32 avail_dw, start_dw, read_dw;
>       loff_t i;
>       int r;
>
> @@ -565,10 +566,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file
> *f, char __user *buf,
>
>       result =3D 0;
>
> -     if (*pos < 12) {
> -             if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_CPER)
> -                     mutex_lock(&ring->adev->cper.ring_lock);
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_CPER)
> +             mutex_lock(&ring->adev->cper.ring_lock);
>
> +     if (*pos < 12) {
>               early[0] =3D amdgpu_ring_get_rptr(ring) & ring->buf_mask;
>               early[1] =3D amdgpu_ring_get_wptr(ring) & ring->buf_mask;
>               early[2] =3D ring->wptr & ring->buf_mask; @@ -600,13 +601,2=
4
> @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *b=
uf,
>                       *pos +=3D 4;
>               }
>       } else {
> +             early[0] =3D amdgpu_ring_get_rptr(ring) & ring->buf_mask;
> +             early[1] =3D amdgpu_ring_get_wptr(ring) & ring->buf_mask;
> +
>               p =3D early[0];
>               if (early[0] <=3D early[1])
> -                     size =3D (early[1] - early[0]);
> +                     avail_dw =3D early[1] - early[0];
>               else
> -                     size =3D ring->ring_size - (early[0] - early[1]);
> +                     avail_dw =3D ring->buf_mask + 1 - (early[0] - early=
[1]);
>
> -             while (size) {
> +             start_dw =3D (*pos > 12) ? ((*pos - 12) >> 2) : 0;
> +             if (start_dw >=3D avail_dw)
> +                     goto out;
> +
> +             p =3D (p + start_dw) & ring->ptr_mask;
> +             avail_dw -=3D start_dw;
> +             read_dw =3D min_t(u32, avail_dw, size >> 2);
> +
> +             while (read_dw) {
>                       if (p =3D=3D early[1])
>                               goto out;
>
> @@ -619,9 +631,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file
> *f, char __user *buf,
>
>                       buf +=3D 4;
>                       result +=3D 4;
> -                     size--;
> +                     read_dw--;
>                       p++;
>                       p &=3D ring->ptr_mask;
> +                     *pos +=3D 4;
>               }
>       }
>
> --
> 2.54.0

