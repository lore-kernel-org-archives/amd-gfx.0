Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF2C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 17:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2066164D9A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 17:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2066164D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BD88932B;
	Mon, 15 Mar 2021 17:03:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F44B8932B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 17:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5oQVHSdbqjBtRLObG9tqVGdvBr9eO9BZdgORG4yDQdXNqaXBuG5gvRZrTeAbzQI3M9zk991eVBQhBz9mp4Q1qycVAOlRjsuM3Ts/WGkqxfrdhpy9VNCSSeUtW28AVBXwCRSHNFvCd04oLh39b7z/k2HLJ1Xay4NiQZySEQspGxfBQug9DgAxSAs/1/tUs8dH3DIWMDRLDXB35tzpXyRR7Q8xja2cAf2p4JX6fGtMW0/AWbixCDNLmlxKi7UVjdrkYDjxP0tWkD5KnW9uUgrpwvKsmoGanJo5ZuoTj2Rz16oD4SwvhbnnSWFVV/N3x3XOeSK0RYq27c7RE9lxDByAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCZUvaRw2DvucJuSoUKnNAiDkSvpM6SQjDdUflGSdPM=;
 b=j1kJ3+xroecLZePPhRH2rRH/JlUOucjurrg3JvKxpSmvvtKp6996Kmyp2U8j4P4AqirJBes+lTzSjBtafQsetrMtX7KCE2OflCwILxkFBe7YVCMNBjW5p4jtrdJGKx/zgzQTKvbYSxUaUy3jOZ5UYjNIyzRf2h63SDl3GtkibX5Sfq6jbYENAUyqNQVZHl5BHqrNoY+iGV7UdFlvQy8RBGu5GUMT9CzLQ3EJ7yfRUyPNePZwxDb+J93aeVHA4y6t0MrhjLSu+dsBwdzLzKQE3gL1MNfenuGrGExtWuYLEM2+Gk9clvEvFgeZyOPdC3D+xNEaPYKH8UQZVn2HtkpdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCZUvaRw2DvucJuSoUKnNAiDkSvpM6SQjDdUflGSdPM=;
 b=I2xDJseBdh5ivAwyz7/vK6wicUJ59jIgeJ8NTB/EmhdHePN688VU8oTkxGJAEIUnS68SkGKgc+YBT6nsLvyZZWRw3I+YO7zKPikXcgMi4vJ5bofuls8ykzvahqiVuqr6CmKItn34slRA6ek5QkJ0tqoth3B24E4CkytkcCM7Arw=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3723.namprd12.prod.outlook.com (2603:10b6:5:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 17:03:10 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::b94c:2415:ad7e:6cab]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::b94c:2415:ad7e:6cab%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 17:03:09 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Das, Nirmoy"
 <Nirmoy.Das@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: make BO type check less restrictive
Thread-Topic: [PATCH 1/1] drm/amdgpu: make BO type check less restrictive
Thread-Index: AQHXGa3l5QVp+r1qKEuexJ98GDKbI6qFKpKAgAAcKrA=
Date: Mon, 15 Mar 2021 17:03:09 +0000
Message-ID: <DM6PR12MB3547C951418584074487211EF76C9@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210315151414.50491-1-nirmoy.das@amd.com>,
 <bfd582a4-34f3-4e34-5e2d-f740ba2295c0@amd.com>
In-Reply-To: <bfd582a4-34f3-4e34-5e2d-f740ba2295c0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-15T17:03:09.346Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:f2c0:e4c0:b2::7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9de872b-1f8a-4b94-59e7-08d8e7d43616
x-ms-traffictypediagnostic: DM6PR12MB3723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37235489F7231F9CE1DC2F0DF76C9@DM6PR12MB3723.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OLCGHnwZEBJwAUVLsKf9cwE9yGpKBw2bVb9XLCzmK9rv4kcMgvoqX5E4EpxgPHMy4uXPGVlLbDk2RsWUPaQvmyxVesC4n6RpTmvR/qdb3kW8RtSFrf6Y/Q8g/D4P59V3jc4DYm7jNSZ4kLKMfwYT1J18mrNZtKVAqNxw5b7I1949mbuC4hL05pZJho4Gfo6+xY0HezVjghKcWnWAavgqSmPv8//LsYE+qBEhGAYIrASJnkmcwfooVTOkyCGPeKuEPYPKejMkROhNBjGf63+th/Z5BuLn3+LYFCXRGqDekFtJOkSQKgCMt1b0Eiz7AD+By8eVHp3wJtCTnac0TGSwiqmkcH4MnpMfV4AGm4I7UIw0sDoGGP6i9YHZFyo0d7dIAn+nY8pXqZYuXirrGIyxq8Eg7XtBTWrraVfw1bOJ2ztQZ5dKW/X6BID/aV8GKs5UtqetFcnWa8BZlf+eyspQAm7hs9uw5Y4DIj6f6ea7SAQ3aAqDULgADUOv4GQ1KdJmcrhbP5dCZc3Ya6wzXaUf9qFS9cwzlxe9VuGaZglITD0Xmrdnok3mUyrHcqXxRv8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(4326008)(186003)(6636002)(52536014)(478600001)(9686003)(83380400001)(5660300002)(316002)(55016002)(33656002)(53546011)(71200400001)(66446008)(8936002)(6506007)(66946007)(110136005)(76116006)(7696005)(8676002)(66556008)(66476007)(2906002)(64756008)(86362001)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?DLrk/eIKUHL8iiSkffRitzw27h7ej2dr1n0VkG89H5RertQspFHuh/ZGNw?=
 =?iso-8859-1?Q?QAJcI6826zQcq5GTLO4PjsGUlEDuSjlO951iyfCdlJdUvMH3ZQpyNdwWOj?=
 =?iso-8859-1?Q?4YMzbqNpyW9FsD2lBiUwUVsTGV3lAoMQTK0dosQ11q43jDtr0rqwZci3ab?=
 =?iso-8859-1?Q?N2xXj0jdTaygGV2Krde7hqNXkJGYAvI+T6wL8nYONxqoG/yCn/fVdzpd65?=
 =?iso-8859-1?Q?ZHNMg21Wbb6jcpkUVFpx7L9Q7YlwY/21rxX5lgnYhbVzScKPgSlOStwfC1?=
 =?iso-8859-1?Q?SdIdGZkvjnnErMK4E6OUfoS59ttxXcRfcL/748bYaaVywSjosy6LI6yaqn?=
 =?iso-8859-1?Q?NSaJ3OJPf4t+xqfVaNQ7gZYxEXd9Hq9hDTyyOV9RNaVzMFQjMFVzRew3Qr?=
 =?iso-8859-1?Q?eXF/8R37LLNXPTH/+TkcGaYghJi3KaIYXSIu7si9UcOFJBlhQWXaE16icQ?=
 =?iso-8859-1?Q?Xi5nWuyOgFa4R8N1qZdstyiUpfTPMLBQJixLqFWexIYyRx7+905zedPt0W?=
 =?iso-8859-1?Q?d7jczirqTGKVJcro+acjgQWf7tt8Q/1hWYjAnOpJrBxL5Ye6Qn0pXgj2ME?=
 =?iso-8859-1?Q?jyxbmjBXg7mbwjSSwlL4nIyaoirVf3IetxQjWoW9icwp7A/4270dAxr0Wh?=
 =?iso-8859-1?Q?4zhp/O19QUprXhUTCuuEbUT0yUpkuAUQP792pBQyOwsx43wYxIIcF/dPW5?=
 =?iso-8859-1?Q?grd7NkBUhP0ihyRHnVNASDrLyXKskUlQLjCb+eaI4grqq6TeWe7I2CzcjR?=
 =?iso-8859-1?Q?OkEFo+qAV5um3+qCfOVemUxM5TZrk0otxXf94prv05W04TCg7hEC0s0YUG?=
 =?iso-8859-1?Q?lrOL7nHZj3whMGY3UGQIO/cUxru0PvH61YveYH3ahfjp97If8fhLspRsPl?=
 =?iso-8859-1?Q?okINfN8aXc+OCmE2zuCKcs0gQZJ5hbNCOblpn4SyM8HQ8m+QmLKEoP0G/5?=
 =?iso-8859-1?Q?iTP7cHHuFU3YrpaiQXpRFZbteXYH7Ftyh6lr6h1u9LDtgEAUkUtWLOQEPl?=
 =?iso-8859-1?Q?B73ynHDCMXFzoFy0WMdBrofU0gNVug0xli8+Kyu9dBVuXh3eKpCRPUZDmU?=
 =?iso-8859-1?Q?SmiHPBjYf9Ils3xACTYRe8nFiLQNJp7+lGFoWBxuwH0xQCatqPAFU3AVEc?=
 =?iso-8859-1?Q?6Lr6lKdC5G5SVuZ1pO5P3z4adxoJGgOM00kW9hMFnG+EPfZgr2cykcOt+E?=
 =?iso-8859-1?Q?08FW6uSXgph6VYxwllWeouLPzszsqa5HCIAOyUCUUVouWSf6WCa5QBumur?=
 =?iso-8859-1?Q?ySNVcCL0FHo/dXrZALOhDijPnq4V6Tq+AsEbdNVpDayAiA1Xt1tOkrgKuY?=
 =?iso-8859-1?Q?K8zh1jmtt+P6jTLrmhBOp6Fht4TNtiIKLLXkdED41NVLt9Ebm0Eq6iNB/b?=
 =?iso-8859-1?Q?ldyiROM6AY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9de872b-1f8a-4b94-59e7-08d8e7d43616
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 17:03:09.8932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpEEgBODFRobTpTONDmWiKj9+dhHZ4qjsofXc8Bn6UiL7THLMG2xlVAtjjMIuw1bb4isbscaOvtSa06ATqzOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

FWIW the patch seems to fix the issue I was seeing :-)

Tom

________________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, March 15, 2021 11:22
To: Das, Nirmoy
Cc: amd-gfx@lists.freedesktop.org; StDenis, Tom
Subject: Re: [PATCH 1/1] drm/amdgpu: make BO type check less restrictive

Am 15.03.21 um 16:14 schrieb Nirmoy Das:
> BO with ttm_bo_type_sg type can also have tiling_flag and metadata.
> So so BO type check for only ttm_bo_type_kernel.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> Reported-by: Tom StDenis <Tom.StDenis@amd.com>

At some point we should probably add a amdgpu_bo_is_user() helper
function, but for now that should work.

Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index ac0e1cd83858..fdf23e439b42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1167,7 +1167,7 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo=
, u64 tiling_flags)
>       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>       struct amdgpu_bo_user *ubo;
>
> -     BUG_ON(bo->tbo.type !=3D ttm_bo_type_device);
> +     BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>       if (adev->family <=3D AMDGPU_FAMILY_CZ &&
>           AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
>               return -EINVAL;
> @@ -1189,7 +1189,7 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *b=
o, u64 *tiling_flags)
>   {
>       struct amdgpu_bo_user *ubo;
>
> -     BUG_ON(bo->tbo.type !=3D ttm_bo_type_device);
> +     BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>       dma_resv_assert_held(bo->tbo.base.resv);
>       ubo =3D to_amdgpu_bo_user(bo);
>
> @@ -1216,7 +1216,7 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, v=
oid *metadata,
>       struct amdgpu_bo_user *ubo;
>       void *buffer;
>
> -     BUG_ON(bo->tbo.type !=3D ttm_bo_type_device);
> +     BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>       ubo =3D to_amdgpu_bo_user(bo);
>       if (!metadata_size) {
>               if (ubo->metadata_size) {
> @@ -1266,7 +1266,7 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, vo=
id *buffer,
>       if (!buffer && !metadata_size)
>               return -EINVAL;
>
> -     BUG_ON(bo->tbo.type !=3D ttm_bo_type_device);
> +     BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>       ubo =3D to_amdgpu_bo_user(bo);
>       if (buffer) {
>               if (buffer_size < ubo->metadata_size)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
