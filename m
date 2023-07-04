Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8F4EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 16:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3C910E2F6;
	Tue,  4 Jul 2023 16:09:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D7F10E2E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 16:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0He3afU8VWKs1I54tvWGe3YzE9GyctVkfHkUP0U1pIUp6HONJ8DCbkTfLOmNESRLJzR3s/mONOmmU7PgRjyINSROaHj3UduOpn/tYLif0JAUJ4x11ak3IpGntQxP1O0rGhJS8OqKHZqfCub3AmOphJKDaoVKAxCtsGoHJmM3pvxVyB7I5jQb0ZM1RtKGvyOgydOywqpXyjcXFqTeBQcdRwjdwV6JSKGq93K1TycTyTQ7LmWPHDnwBI5KkSiUjHEltMFJIeEf9yoR6TuKz8vGfFpk6F3pwO5C8FbibOhAPyYBbU0tQFKSrDrnXILAqDy24R/c+PhMSlpRvbsqGOWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGvgsQsV6o2u0VTKLMTNrKPRs77fsZvrJ9BwRUwfIJ0=;
 b=ApGXQrD8Rq8Ti77x45DyINpLrOHaV58mSZ3qDuL0K1gGq57j1uv5ic/NlWZxsqBya92Ais4BZdsneePFHyfJcukgvTElScaMs1HbMyIGpxXKGI4G/WckThJkBzSsSmuEEnYuq2cnSGWVWcQ7bL6bYzzEW8JgZ9bby6X9nJUe+XSgQyl/87hZ/hmnIAiJfK865auj24Oj5O0OIx3Ff4umBly5OwIP2Xt/rv3iGUK6s0CQao4HnfTZEgp6y4EquOMKe6Ym5vQGQtUNaQdfoy/ubca2utOHvPRzUHrZnMRyLBApDws5YyFUfkURMxSNvzfr+3jLSevmfipdUuFUZbf28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGvgsQsV6o2u0VTKLMTNrKPRs77fsZvrJ9BwRUwfIJ0=;
 b=heRQmeXhL4wbfAvIFArZdO8lB4SshLaxcnpLrlAhsUonsfxnHNtL/PGQJJmPn+956p4euqePULpg334vGGQta4w54P83i8EZoW9cQ17JBzkVpnlq3/Y3UnobZOUsHZEqSCIT6vmlikOWzHCWaZ3wb2PMtPs6sPJBW+SeHDbGVTM=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 16:09:41 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 16:09:41 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdkfd: add xcc instance for debugger APIs
Thread-Topic: [PATCH 4/5] drm/amdkfd: add xcc instance for debugger APIs
Thread-Index: AQHZqgbduHgNgGHUJkGGkQ1q22+2f6+pzLAw
Date: Tue, 4 Jul 2023 16:09:41 +0000
Message-ID: <CY8PR12MB7435B3A5D66B5E00A79D1A73852EA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
 <20230628212323.248650-5-jinhuieric.huang@amd.com>
In-Reply-To: <20230628212323.248650-5-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3e25dc56-a39f-4270-a352-7c784503a8fd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-04T16:05:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM4PR12MB6011:EE_
x-ms-office365-filtering-correlation-id: 68a0cabf-29bd-427c-a90d-08db7ca912ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqNtn9rqb4xqxpV2hqcEHDlOBAFRRDA14hLb36nSXuN1F7BWDCk36LhBCf4CTlcW0vE1aK3K3OsSSYwVbtNxkKjIHe4Dfk8xMioYbBQMGDMJFWq1k/O7YtPNg1JdzXkF02c2Wx1VUQHNdEFT+1/WC89AwUDT79ArzICCdJobNKJZEzPHK9jQlwZ2dHtTDLcwt8lHAThwsq0rtdRB9fzruB0wtkUvciPBv38lixpvYKQQaFAXzbCbf6k1nIjtnBf3FJYepWYaXEBvH3L7nenKkqA9LvNPgy9vsZJFVTmPkmfvMuckNtRUxlnf8fFvwjica4jiyKEhCVHVdA3XNCdr03bwuxSgUlXI7Nc0i+MZ/7OR+l/AUAn3Brd5Dkm+jQrgfeo35WBejxSliB5fU0Dv+A4Wa1j/BdzAsgDUzjgUAl+jcKAVWImL24VGLeOJuWfOV0rCZYuahXnOtUEN/VeCIMkbPszUX/4WgJeQW/tRgOby+oqf6Yrp6OWlRx9JAAsvZixVNzww97OGwc7z6a0zk9jKTJVNqgaLhm7m8PUCMZivDE2RAoRLJ9XH2/TUu/uE3FJHduYblUcbfsyVu2fKnKB1/N8fUId2QoUMEieYmcVw7xkq2SkXkNMAqwXlnG/V
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(76116006)(66446008)(66556008)(66946007)(316002)(2906002)(478600001)(66476007)(33656002)(8936002)(64756008)(8676002)(52536014)(5660300002)(86362001)(41300700001)(55016003)(9686003)(110136005)(38070700005)(38100700002)(7696005)(6506007)(53546011)(186003)(71200400001)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yHb8nTzLbgcKU8vFFQ9AadSPFfqpzwJpH2aVpVoaLLiI0GsMt6cm7t1cbU7M?=
 =?us-ascii?Q?gIEYITwubGCgZoeiSNccYhcmBfIjj+iX1FbMXOuv0eIrhpnqW6codrEsTI/W?=
 =?us-ascii?Q?6x/AzHRnVs5aUXJRQ4UE0UL/+tIHz2SiSUHhFfOOKLacYKgE48pedfp4UKeY?=
 =?us-ascii?Q?1Yx8fFKOzDe/gZ9UWZI1/UL/Xo1HhJMyMUFmtqQlEKaO7MPux4mBTN1xe2O5?=
 =?us-ascii?Q?1N49nvOYKIdSIeToLDdgBkX/Q1SaQWdx1aep5F1fwiuuQSrm5vIaOp4JHs+M?=
 =?us-ascii?Q?BC9u60auA53Acx3wqQR3bA8ziwzyJAgYo7Q1KEErwPvIbsG64IvFoI9izX1h?=
 =?us-ascii?Q?E6Fy9v5aso6OU1ULfOApiDQYB2KfH4vOaLsBn+EkhsAD3ORjoKdWKQDmdYJX?=
 =?us-ascii?Q?ltMWuq/HX+6fNGIBXdiHtTBWgE/zboiRhWMVkmOR7JyBpDF/GR5OaBgZnzEB?=
 =?us-ascii?Q?tKmw25QP8xORyYZ2jj1qHNoXeWuGSFABtg+bTv6CIxwVD0OtUEk4YPe6xg0j?=
 =?us-ascii?Q?QbOW6j1ZDpJ0TyoMxlCxrURGb2zEfuxNrH1R8n6I83/EKjuzoLIlAJ5W5ftI?=
 =?us-ascii?Q?eQQa/HLISKPyNIEdBFMXRd6RZW94jRxTNL6upGU9Fx8qE3lDzePO3c0pt2dF?=
 =?us-ascii?Q?fJtFzaadtwwz8Vg9ygSIIfIbIB4iIWIishlwy9F/8HHHQJQesYJ/ufQ3nqYp?=
 =?us-ascii?Q?69/y8IVleu+kwh/mSE/SdKvxb1qJ8Tpn3NdgmUAMmys4MSoaqQNus3c7VLRO?=
 =?us-ascii?Q?hle0dsnZ3PMz7Z1U+7B3v+SPAo5N8uuos/3OQyp+N0JfNjpKzbUTPtTPCW0h?=
 =?us-ascii?Q?FwDbYwdO4giFHyi+xlQGzME4LuuPFoMQ/KWM2uk06KSxeUOo/8j0fPuWfLR7?=
 =?us-ascii?Q?4a7VJzCAJi5UZZIMlKMTrOEpLqbNi07JzeapajStAp4GkAMKsWd06Jei8ZPn?=
 =?us-ascii?Q?KX/rs2PwezabvkPXqDmDBp5K7YYSwWXM5BvnS7jMo14Zr7K5c0vSr9rfKuPS?=
 =?us-ascii?Q?Uiwz3nR1DQoZH7aWwOfXk2XgJW80Bmaqrzye/nmVmP+8S/72lpi09zXWQGPb?=
 =?us-ascii?Q?eUdBUV3fUepQqrxctn4AN9kIMqHSnYSQC+EPvPYA5mUvON6p5zZChvL2XGdI?=
 =?us-ascii?Q?lCG81YDEM2kJOFWdkpbkhAqmzmwOz9HA+n4gNnVedeeE3A8kq28e944AFArS?=
 =?us-ascii?Q?qO6WBl9zcjG+UNVcZo1yRAstuASE3eO1uv0wZrWcT0oIDPDlkrC32oYmTSoY?=
 =?us-ascii?Q?VZYCC1RefQ8ElMRvzHni1PMfCS1rvz/38KFMOt67dkbEXbwbOKw3rdecRJpU?=
 =?us-ascii?Q?H1Q/Xr0JhzMsYrYqasa2lwaRuzT1ArolZf5H1EV2TPpXH6+cBXyFsObh33tB?=
 =?us-ascii?Q?AsK3iMD0YFiSDsaZDUMQ8wiJHq8f0H+lZfPpX9xbURJg2MWePVyJEPuefN/U?=
 =?us-ascii?Q?o/pzme4vtPKh0+yTUTPDxRALQB7HcDTgzH+TJd9cGiU/OP8JiSYcAvvSipxu?=
 =?us-ascii?Q?KugPXBCuc8X1dhznTvUMtFsTguPVhOlkWdvP3mmhwe/EUuspbAeaN6l0JyLE?=
 =?us-ascii?Q?2NIhNtXgaKW8TjQTUwwIzCbsWFBUUWhge9aM87SRbeMeNbo66X5oIBphQESX?=
 =?us-ascii?Q?BYfiMQ/6hTViXC/6XkTtV2E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0cabf-29bd-427c-a90d-08db7ca912ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 16:09:41.2507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsVou8dmaDGeu7jg7LRB0oRZdrWZsTCKec/EIQjoen0Q2k6ouwdPxE7lenHp30Ix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Wednesday, June 28, 2023 5:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 4/5] drm/amdkfd: add xcc instance for debugger APIs
>
> Since GFX9 GPU has multiple xcc instances, this is to
> implement this change in KFD for debugger APIs.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c  | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c   | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h   | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c    | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h    | 6 ++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c               | 6 ++++--
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h      | 6 ++++--
>  9 files changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index f3f7e0437447..c7f88bfa1976 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -126,7 +126,8 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst )
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -163,7 +164,8 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>  }
>
>  static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
> amdgpu_device *adev,
> -                                                   uint32_t watch_id)
> +                                                   uint32_t watch_id,
> +                                                   uint32_t inst)
>  {
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 7aab8dcf46e1..17fe4e90f203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -454,7 +454,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
>                               uint32_t watch_address_mask,
>                               uint32_t watch_id,
>                               uint32_t watch_mode,
> -                             uint32_t debug_vmid)
> +                             uint32_t debug_vmid,
> +                             uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -491,7 +492,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
>  }
>
>  static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device
> *adev,
> -                             uint32_t watch_id)
> +                             uint32_t watch_id,
> +                             uint32_t inst)
>  {
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8ad7a7779e14..225b8929a878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -942,7 +943,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>  }
>
>  uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id)
> +                                     uint32_t watch_id,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_cntl;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index e6b70196071a..c904a08b022b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -44,9 +44,11 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>  uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id);
> +                                     uint32_t watch_id,
> +                                     uint32_t inst);
>  void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t
> *wait_times);

We should instance the iq_wait_times as well to be consistent in what insta=
nce we're pulling grace period info from to reset the node's default grace =
period.

Thanks,

Jon

>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device
> *adev,
>                                              uint32_t wait_times,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 91c3574ebed3..d5d0ca6a14d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -780,7 +781,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct
> amdgpu_device *adev,
>  }
>
>  static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device
> *adev,
> -                                             uint32_t watch_id)
> +                                             uint32_t watch_id,
> +                                             uint32_t inst)
>  {
>       return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51d93fb13ea3..7aabe6722726 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -878,7 +879,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>  }
>
>  uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id)
> +                                     uint32_t watch_id,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_cntl;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 5f54bff0db49..519f05b86a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -89,9 +89,11 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>  uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
> -                                     uint32_t watch_id);
> +                                     uint32_t watch_id,
> +                                     uint32_t inst);
>  void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t
> *wait_times);
>  void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device
> *adev,
>                                              uint32_t wait_times,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index fff3ccc04fa9..dcc49183364b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -427,7 +427,8 @@ int kfd_dbg_trap_clear_dev_address_watch(struct
> kfd_process_device *pdd,
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>       pdd->watch_points[watch_id] =3D pdd->dev->kfd2kgd-
> >clear_address_watch(
>                                                       pdd->dev->adev,
> -                                                     watch_id);
> +                                                     watch_id,
> +                                                     0);
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
> @@ -466,7 +467,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>                               watch_address_mask,
>                               *watch_id,
>                               watch_mode,
> -                             pdd->dev->vm_info.last_vmid_kfd);
> +                             pdd->dev->vm_info.last_vmid_kfd,
> +                             0);
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d0df3381539f..3749d193238a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -315,9 +315,11 @@ struct kfd2kgd_calls {
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>       uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
> -                     uint32_t watch_id);
> +                     uint32_t watch_id,
> +                     uint32_t inst);
>       void (*get_iq_wait_times)(struct amdgpu_device *adev,
>                       uint32_t *wait_times);
>       void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
> --
> 2.34.1

