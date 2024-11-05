Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07DDD1266E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 08:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9495510E2BC;
	Tue,  5 Nov 2024 08:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i7jMKOm8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC17210E2BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 08:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCJU/poepU0ppfFI3Kq1hF80Zd4LHAW7jiphlGK/YRrlRlw3pcFZ3oMfCt/0IGh39bewqu67wy7CIviO/gdHtgqIUHAxhzZCY9BuyKCSYnDHSTcg7x1jxBmDA9rs5t939hYgg2wYXnb7HgoEfKA0MtUu7wEqU8qy9abvaZqmg0igMHhXaf1QMN5zOmR5XkfhB6ppmg34hFoROt+/w/Q/FazSJKWgecLDDSf/S24UdVQpOwpQy3hw/pfKo2Nj610F/ytgrvJU+bI63ZaRPcahhpJVDKFqaAjDeJOL2OsIZfkHNtLMwvwFkvxmYiBvMIlmjyrtMY3lHcCLVBDh2I9SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yU+Go9gxyV2j1Y/2eChaR496AH9bm4QRLLgFPQ36XA=;
 b=qRlH8BaMDIHAGoPLIzHwkfWiUq+cCb3JOvNzHPUNaiGLLWCOe41xZOc5tUuB6pvb80LCLFKjDsE9B0lgtspDWhgBzWu18fMVtUqzTbODTNSQ7h5MCYbD05Y9D+zE1cR5GPQbq/rR7/lM7hLfioFnDF83GaCrLvLHSCSOhbRQ6h6ozKKejRTQ+s4lkMFzWBo7h6RclDQY9Hq1PM7WznFfv7GPvjMdXMkFp3LW/u4bwmrgXkz4V2+iwnQ7ihD2gFEinkGjCp2bV8cXLGnkL6degQH1cYptYmkXQbau3EPxwuxQvZZpUYIsQd54EWF2sIhXZ3arCO816CH+AzXQGAavTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yU+Go9gxyV2j1Y/2eChaR496AH9bm4QRLLgFPQ36XA=;
 b=i7jMKOm801kyaxk1vm31Bv/Ac6LS+A6OMwCwWux3CBkfGjdhdFQKQwtDaEVnSbW/3YZnqpldaCWl+do2u13HvHe0DXR8l9f5UOwj9Xxkt0c5gxpLFQK6Ew3i2PGKBP/OBth6bo28FRBTiTDnLLfJYvNIGU+l4l55sVeHa6pu86o=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 08:52:40 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 08:52:39 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Avoid kcq disable during reset
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Avoid kcq disable during reset
Thread-Index: AQHbL1GRyyKrJf76ikO0AHg3coxpX7KoYDOQ
Date: Tue, 5 Nov 2024 08:52:39 +0000
Message-ID: <PH0PR12MB5404D1456F7172C7A68E0679F6522@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20241105070829.3243486-1-lijo.lazar@amd.com>
 <20241105070829.3243486-2-lijo.lazar@amd.com>
In-Reply-To: <20241105070829.3243486-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3f9e9683-e592-419a-87ca-094c930eb46f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-05T08:48:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|MW6PR12MB8836:EE_
x-ms-office365-filtering-correlation-id: a7ac9924-c106-45fd-a7c9-08dcfd773433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zBT7MdCXKf5L7//gP1zCSnQx8zmoFieRUxblH0ve9FUJSd3MNGwyVR4NWUwB?=
 =?us-ascii?Q?igOmgzwqfzLNx5sef2aYuwNmCBaja5pDq537t2VnnRQAPruHiOtyf/rL1y3E?=
 =?us-ascii?Q?uLfyYukAuq/zDMPo5E26z/YEuaqpIF/4LjPWXCbiNW8KKjPNisdhvE7byNzW?=
 =?us-ascii?Q?MW6VF5YcOBTdZdtx9zj5deFn7RUfqx+PjuUEFp4mccm6+ZaMxX7V35WrHHoa?=
 =?us-ascii?Q?UveFHhcxoyFMpq8sHP9TUfRK6SWw4vf6+FRLuJq34axRMNO7v82xpmx+O1kY?=
 =?us-ascii?Q?qWpTj4F92V/sZZOod/3xxaswpIB5KUx//s6euGWYhtH3K6L5UOzX28b+wZL6?=
 =?us-ascii?Q?VI4Nea8wua5XiwlTs5ls2uRtJ+6s6WD7BSLoRPoK/LNGDxG7y4CLoUWwpoav?=
 =?us-ascii?Q?qqRcPCEP+4hIkgyuHlXQCugxInb7piXg3aqbka4D+uzvnX44IJrGPeBFzSw0?=
 =?us-ascii?Q?QI0/ATcUkTfgEyXuedvxHSDZCrX9YrgKV0Oy1o0cjZi2O6QBap155erZdXAB?=
 =?us-ascii?Q?WaBLeOedsKtQRtBK9den+gMYj1vk9E/gnW3fZq9pio27JjrW2Nnw3mFnl/ct?=
 =?us-ascii?Q?udxS7SttoC3+xFsZD/SwwiA83/x0pJ6n3ACnjDW7+ILU6TzsRGp/mQfD1IVq?=
 =?us-ascii?Q?cpJSDt2phRHi4gu0IkET84wNDPmsxwpJ2otxPWhFUHSuoAZjSlQBzQmsZu06?=
 =?us-ascii?Q?xvqf9rCZKRjcizwgVvqaLLW9M4GsZGaRngoE98xFIYoJqSxLw+UNUymlXhgK?=
 =?us-ascii?Q?ihf8Bb0LGmJeqq99fK6K5SuXuvbCb/2EWc+H5FEdi8NcCf1zfnYVtgaPsaCG?=
 =?us-ascii?Q?ma5CcN0veNOMBT8c4yIN3aizEK/2fPxf2tVTm0E1d2Q2enkBiRcKDtoY6LTF?=
 =?us-ascii?Q?09e4stXAyOj8wyWD16A9Z0HSi0AusPDEh52Vq6Mnf+AvJ4QjcbfIW6MkNTiV?=
 =?us-ascii?Q?HPFkPT4mzaTU5VUKW1/JT8DmuzaXGt9K9RlU8wUzBjHxTid3tDZ1KZeXqB0a?=
 =?us-ascii?Q?JVlqIVqXJ1DCzx/CdMbAY9EEyxUrJJfRFBQEKa/GaOWp8V0CHQv6Y5BnZ6Md?=
 =?us-ascii?Q?+yub2nQuM5u//cdcKgO0ExC+PmTQZ9wwUumUOIV+GSAMTBRem0ya5QzhzoCG?=
 =?us-ascii?Q?Gr8rK/F5+SCz193DzXpOIfemzT7mJCLQzr0HZ/6iMGc/E1P7WI/mzhEJ3/TU?=
 =?us-ascii?Q?VvszXeI52A4yelxawJ6Kdj6YpT6Rk4epXizxFtZyHC4cV/7JtSlkP2da8XG2?=
 =?us-ascii?Q?PwBMuLup+2NmBxCk899fJeXz3GQaLXyBo8K6rR0jNkK47nGbysJ4TLFA8REh?=
 =?us-ascii?Q?2ScR9WgzbOKEQq4krJaqhstIAL21+XrYDucbVIb4hcfMXUf3Yd2c3aYtTVCN?=
 =?us-ascii?Q?alEQw8g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iaMSv/uzG0TidM4tG94U1yIZgGlb88pHVafTJjeohh3C8uhoR5v2OUmrY/B+?=
 =?us-ascii?Q?loEQlqDos4g5VlJh3ExxfNiDEYvy5DQ2vsq9K6cEkPmTONvkbKAXMKgnsX9w?=
 =?us-ascii?Q?2U2cmnYY65alkRG884pZWl0KVkHM3edauUBQnPkc58csX1wWDvaXOMhWHwOy?=
 =?us-ascii?Q?bh3UpVEUoCS5zgUnddQaLFwFAccZQVQTxbPNf1I89k8hAGK+3mDpbx9H0GmC?=
 =?us-ascii?Q?qb27Yf4iuJsk3zeNReM7ai1559Ws5P0Jg8BfYmdTWeWm0zwLLxhHtDIBmRD3?=
 =?us-ascii?Q?7HkwgUrdzXQEiRyZp4eOVFYJEQTTHfRxTOYJi7aANInEcMZCVLdU7XE2tn7O?=
 =?us-ascii?Q?tJ5Vur7Wjs5ywcocwxupPoROUgZoexg9M3Nz6wdTNmDWxvOebvsk19kEzBSt?=
 =?us-ascii?Q?8b5/MhkQFGRDzkvTfPwxzeyjmqYj8yoSZsuZE79mIog3SPe48ci7mn0eG1cK?=
 =?us-ascii?Q?04FnfVO6C0CqFpl/+ST1NDbQZ+Ve6AVo1b0gkCqRkYFbAPm2QvloCUph+8FY?=
 =?us-ascii?Q?wRukatfVRqQ3VWxgu5SlN1GsR/Dz4dKjqzCz+tezNM69ZhAY5VHoga7yGlU0?=
 =?us-ascii?Q?if6beqBwvLGbqavN3NlXtNEHOcWdTv7q7gwQwYZ64KMy5l6kDFoyRG35bsbx?=
 =?us-ascii?Q?VvDUlI6ZydOk9VwchK++kHHMaMjqjjtO1BLRCtCXZXqhmdxOhom8JJxDCwHy?=
 =?us-ascii?Q?6ZAd/OkTguZ9kn+h8Ots8XlYUGtHvROx1s/dYdXAnjKO2CgrrYbqSSSo5QcQ?=
 =?us-ascii?Q?XHukrE39UgMC7tlLM64dWG0vuBmdJLNh+0Jm9aOmFR/FoQrjzWWrRuuaRAM2?=
 =?us-ascii?Q?zoTGaGF36hRaGLVUXommfvNuzGuoaO9Izwmf1voFPA8KcW4iyIIjiAsTu8wJ?=
 =?us-ascii?Q?6/u0GbGVeSZdI9URwrDo1a05T/mSu0vU1ZbLIVkxDbJ0dvVU9bzstw+n1VAd?=
 =?us-ascii?Q?DurqRd7Cso+9t6+SNRnZCXHMltE5MaeG3jmn5vVuXyxrqAP2ptaOrx+DZoRx?=
 =?us-ascii?Q?OQSSV+cQfbLIpxc8NWQ9LhEqXIhVQ2v9OjpLsbVs0pPyT5mr3Ld/STSn1ip6?=
 =?us-ascii?Q?l23dwfr8O5ph/i5RbPCoSr33EJg5/HML3vFfcNH1zE2qLScTadzooSRHrNcX?=
 =?us-ascii?Q?1LIbiTM93uQi/rXyQRRDg8x+8Kk/+KXz3lbbtIL6PV0XQS+RInasIEBz5kCP?=
 =?us-ascii?Q?NSFPqqybzPv26Xhr52RhUJ0oCEPXcjGJM7ZAbpS03FkoTJN+xqn/1hzmpWxF?=
 =?us-ascii?Q?22GCYYQSFVt6UWCikj7tu59UTx1LmJpAiI7BPu4tEyIHxqKHjOvbIp01vw2x?=
 =?us-ascii?Q?uTRYnKK54fJ9jIzaF1oUrubbdTPgvUD6Yr3clXJUeKxS6x+kSQOr5ohCFvAg?=
 =?us-ascii?Q?sWWCF3IEW0vtd2vyqLlNMfM/MxRwrVTuk7xl6aG630WXRhDWpNmSVnF4RS84?=
 =?us-ascii?Q?MV6yneGjXe4yVH0Q46yxS0mHqR2ZA2UH6d6F+pE0K/RSAXwsLPjZgspVUTuB?=
 =?us-ascii?Q?s76VMmuaScEJTOcCEg8QbelAE5Oz9emdMafUwG5i8eQ7b5zzfzBqa2MJim/H?=
 =?us-ascii?Q?AbgE/eGLcNcEOkI7Y68=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ac9924-c106-45fd-a7c9-08dcfd773433
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 08:52:39.8469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAMd4yPUoIgrjX6V0pOGpdGEzrZVfodABUTmWdBcttKpwS+VHL7VaNXIzu0Pikbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, November 5, 2024 3:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>=
;
> Ma, Le <Le.Ma@amd.com>
> Subject: [PATCH v2 2/2] drm/amdgpu: Avoid kcq disable during reset
>
> Reset sequence indicates that hardware already ran into a bad state.
> Avoid sending unmap queue request to reset KCQ. This will also cover RAS =
error
> scenarios which need a reset to recover, hence remove the check.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 445220e9773e..d995a1801d2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -515,15 +515,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *ade=
v,
> int xcc_id)
>       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>               return -EINVAL;
>
> -     if (!kiq_ring->sched.ready || adev->job_hang)
> -             return 0;
> -     /**
> -      * This is workaround: only skip kiq_ring test
> -      * during ras recovery in suspend stage for gfx9.4.3
> -      */
> -     if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
> -          amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4)=
) &&
> -         amdgpu_ras_in_recovery(adev))
> +     if (!kiq_ring->sched.ready || adev->job_hang || amdgpu_in_reset(ade=
v))
>               return 0;
>
>       spin_lock(&kiq->ring_lock);
> --
> 2.25.1

