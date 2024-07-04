Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2B7C3065C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 06:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688BC10E130;
	Thu,  4 Jul 2024 06:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAThqk3a";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150AB10E959
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 06:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0vk7sRJ2eP+YJiA0v2p0wKKSpuYK5WnGrSV2IUPA24n4uLNQQZn0aN8VlbkwMcwJGbTtQuMRXhs+djfUBza4FcZBkxxxy7JhyeXLGpJ2DPlxaDAmwdxq0QDQOMF58kEr1rFq2QYWqyl/GrXnD7GdpPljwwnYoROOoMJIapj0YgvfOww4rgGq4fmoxAYj/z21QuPm5NYw2FA4+XTd+POZG7sac3l2mvaoEUkq9gdw4/5HOw3zE9hd6d9qa32SQzrDp6DoOmmSYOG1P114eYHYgz3onzXf4xFj0TPy/2c4pJqvlth0P9pmIKSL3q3B9iL7BDmPLeltqvz5cSSJC5xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsjLP9cRVmXVZDtSMv0FAZ6bxH0WvPW+o4mabbBWi0o=;
 b=SY9J1SXjeH7mxtrkcvamn9VeD3/X+F0VhSM4jj/CgxTLlodjZT1hhGOzHQzOCOBNtQD3pKO6eNpS0LPYaOgPhvwBnMDzBzipX20vAv3m9+oXwSfqOK8tEraOE0Zmw4KY7+W1tXXq7QQ6OHY9ibhB/9SsdZ/1yMEhPSFquBnC4A28hbDDZv/Ml4dY/q3fX8OnLYkMplbfsKYJt+UA1/Jv+HTiSwVAirjAta+It1gega/oY6k/G9SXja92c2EDsDICrEKZuzjlEsvLEHe0e7IdXfOxQm9wdqQus0a97seP4K6CbFS9uU3u6zBUStdPpCnUh2LDYAgpQ46S7YrhAxWDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsjLP9cRVmXVZDtSMv0FAZ6bxH0WvPW+o4mabbBWi0o=;
 b=AAThqk3aFgR2Ml1OfKx1zJOXnMqT/LtRg29aPs8Vh4+NJlbtxwDk48QjJk8aG0nY0NqFkOFFk5N/tWi8G+5HASrT0v5DHg3EkaIJzXIYRt5NdihlPKYdA6mxK2TzHdbmvMGegBEsqdWvBcomQflvYI0+rapRl+AkPj4D9W69CIk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 06:50:40 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 06:50:39 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: add ras event state device attribute
 support
Thread-Topic: [PATCH 4/4] drm/amdgpu: add ras event state device attribute
 support
Thread-Index: AQHazSfgZe6nT1XH10evbGbTFMcJDbHmIpZg
Date: Thu, 4 Jul 2024 06:50:39 +0000
Message-ID: <PH7PR12MB879681A654D5544A17220F82B0DE2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240703090313.1659512-1-kevinyang.wang@amd.com>
 <20240703090313.1659512-3-kevinyang.wang@amd.com>
In-Reply-To: <20240703090313.1659512-3-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1cc8ba7e-85dc-454c-849f-b585054451ee;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-04T06:50:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: 0661b951-6e9b-419b-6033-08dc9bf59de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ETMRj/mkZ8dxPh7kjH6wGy3kuZSrz6iqjcmTI1kW2BiDlwPBljrw2xyq3PQ6?=
 =?us-ascii?Q?kjaiYprqagXZWdaCfAzPtI0liCjbI+hWsyv3RRt6Y3vXqM6kKUEgf24ahg0Z?=
 =?us-ascii?Q?zDbRcSZnmZMVYipWFbx+ECn5j38bwuLHPzaUK9ms8EssfH96sj7K62YqdDrr?=
 =?us-ascii?Q?o+qwfnYgWxgPbw6FPljGvWRkRNqC3aBBShwtOgL0lbozc6sX/ZsoB7s9u39l?=
 =?us-ascii?Q?PvvqzycKQdSXO7nsLtGDoCYYsC96JGifg77bpJrZEwyW7FZ6CMVVF6FgiW8F?=
 =?us-ascii?Q?89Mi2OwtfA/A71aMKgGyi45h1+5ANG1IAcLd2dL2y17/fCxjQ7goFwh//U0C?=
 =?us-ascii?Q?qy4S8tHFm8rYZfF9TCwrvLELCtTrmVZg6wocXmdRZco6zW88HnKKjQWqHt7/?=
 =?us-ascii?Q?Tldy+QZoWE+ZI4U5v0t2OnrUVY4CxwQkq1NkWaNUgUc28UEcti98XuZQwPFs?=
 =?us-ascii?Q?PkONP6lBy06S/A9JwM+Ys35MKuhoafzXaLuwjjwrLQ4Pf61V9PEXlm32tISg?=
 =?us-ascii?Q?KPfy4ffPhYqZuc+PGDQcprWlq+cNXdStO9q6koyE5W+Wcecoh7XSzJmM/M9g?=
 =?us-ascii?Q?nldP4POqZ0tVbvfqB70FpffLdSvVy1dRLYjA0H/zgjOeT+LNzddPvFulY+Mu?=
 =?us-ascii?Q?2eGOkfqDWzF4MCbiQXy5HNe9mEAj5sVyDbHqHGoAjN4FqVmv5c3SAyrGNeTB?=
 =?us-ascii?Q?7OfGnPlGPL5jC8yrnaHNK7n5flYhbg33mHPSiRBMaflmcFN+s4A8+GSga0Jm?=
 =?us-ascii?Q?Xe7HwkUGto1PKdGaSBIJgp+0T2h94Y9WwhNUvG4iERlcr+nCCR9s4IlLBpDG?=
 =?us-ascii?Q?z+izcYweqCVfXrPtRybjTEv4kpkQx/tCnWmBC0lJbwf4rs4tdCEC+xx/XGPR?=
 =?us-ascii?Q?HEQN0pskK/Eatn/2Fm9Z0lluI9iWvuS+hrhSgu/wSC3lxEQM78qPEWXvPOZT?=
 =?us-ascii?Q?B1nb9Fd2TkNogMvsSnzvnT5DxnoNN4gneHuu9QbU8mHW4+fxQwVO2w02jyiQ?=
 =?us-ascii?Q?GgP1gO7e/PoTZMD89rdriUxJw4j7MMjTaUaFQvpgyYO+INPfUklqHzt3v0VE?=
 =?us-ascii?Q?JbZHl0mWEVfNVExyEU41ACJbq5So7xwFHDX6wi2HQ5XP6pfWqyUeZxXQwxHl?=
 =?us-ascii?Q?+aFC9Kw2AMBM1L1iRdNAP43xnuQCZ+Rw8FVcRxniork8NBm+F3+esyqIqpE6?=
 =?us-ascii?Q?cCltY3wxaBPTjODOsOWhaD20Ho5TgLsX7TcK0TT0CEkCJf1r4FFaQPgYBgWa?=
 =?us-ascii?Q?KF889mnajdEBJwobHru1MyqYNp247mkweL/jsT5J2jXHVmRqe2NckgEYE+yI?=
 =?us-ascii?Q?lKkQyBVCkH1g1IjlJxzzw1Lmp124OxOj59SeoCajQjeLp1lw2g+4Fg+0YYPs?=
 =?us-ascii?Q?Nh4/sZkmlLjmwylG0FqL4USxyMeZj7JgFkopxMqVD/DpE+3IOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h45216JV/aqpqTMyCnuuNv6sSeEhB+6NrsajMZMvl651fF5somjqvO3GrgTG?=
 =?us-ascii?Q?3uQu0RUi/Zqz9MhFvjexyTi5++5fXutCUQSJg/vS3m7dINkgZTsabL+avIaT?=
 =?us-ascii?Q?vfQf3Y2xTZMusd2lXjOgL9Hwbgr1cg4R2YTGIG/5mQrStoGvg7Epugwq+IBe?=
 =?us-ascii?Q?gUs+wn41eOnQF4gr6Ei4Qg8lGylg8TV5DxW7VnMYz18sCih3cvzlhZpNT8ol?=
 =?us-ascii?Q?vVrHR5/cvKD/XWX6C5n3NP0jDAj9SLl6YepByhrDA8xhKOw8GtxRTBbTwUD1?=
 =?us-ascii?Q?5a/Tq6fmNeDD0ObjWxp45dWsCY+j4I2/rP32OtBGSxaymHjUq85oc61Xr/5u?=
 =?us-ascii?Q?fidRV9SW3kF41l6qkgOtKsZw3kigcJN6dsf5EA8b2ACYogXgYUNUtoxvtoue?=
 =?us-ascii?Q?813M2dlYEHaJjoIPSjvQYmgyrxS4Haw4geKu6Pk7G6BYMZC3Jul08HZIzWtQ?=
 =?us-ascii?Q?es8MgvDdozJQPRYgWwaZCOGEOnddHtVygAI2CnXQYd9wL2+AiIXgKY1TeNBk?=
 =?us-ascii?Q?xY02zNq4ACJWZcnroQmAgvnxIBL0HWCjS2kQMseSgSvOIDGf5MJ0bDTNF1jq?=
 =?us-ascii?Q?208vJEo2vz7nmpQ1kyZYORRChwcvg6oYgmjxphSKzU1tKCvV1x4ZPIzhfrf4?=
 =?us-ascii?Q?fzL3xi1GnKUIIHAVaBhS4lPKz7xsEuruEl709Vp8RZGjYq6rmz7z8XxnEdZc?=
 =?us-ascii?Q?16sm39OzkwBh8PA/Qc8EI+nmbGGl+1JDV21vxRSyEJ2PltOuLOOQfDyZfZXM?=
 =?us-ascii?Q?XgtF3ZQy8XNpQKSl5JA/T/4iyshy5jCbKXrh9jObaWdwA2O6tVc4IaEDlgiM?=
 =?us-ascii?Q?AK2BFA0W5qWhtu3ohxV3kjmj2mKytGN1XRiL+I71NFjtSpWbixxCOX8z/5I1?=
 =?us-ascii?Q?Y5U7rRleuaMDX0sa9jbzRJHYuDnLTvXyT5kb8fHsofVZwMZ9U4ac1Anbx76k?=
 =?us-ascii?Q?WMF8s1ZJc0ef4w5Og2S2nErrsMgrZkhW3v7bHnCo1eIJP0iCUVdmDDRVM6/9?=
 =?us-ascii?Q?4Edp+ZlN7Lc9uhxTmeDW6CWLY2nHcYozJv2WCHPhowBGFiXWGS+43vQ+ZZ5P?=
 =?us-ascii?Q?YPV4nD+mZ8R+h78kgKQysQ/fL1lsxN4JtP6ldyiVWE+ofqbpU6tC3JThOi05?=
 =?us-ascii?Q?/hrETnhTBpjPG5+JJBqvDf6KjvIwhWsFQ3yH2jFS+O0pkxYfGSM0Flfsiper?=
 =?us-ascii?Q?bhqMw8zZkaglhqjhW2gILZDirA9RiEYX/4K88gxx+Z3Z8qT6oZxUyasWbk/5?=
 =?us-ascii?Q?A958i3DLEqlCN2WEg3eVIcBcAsum8clX9EsIUw1OV/dwNmJfXT7cazKQrLmR?=
 =?us-ascii?Q?vHjV2YpbRjPPLb6Bg3U0TjnVRKainfyUydfSC8ZWqWn1bAysTICE9WRfcvoh?=
 =?us-ascii?Q?Ruf9y2ZLqz/H0fCUJwZujN5l3WL1oXGaQ4ea0uVLe/XqhpnFdpeX4oK6/+qP?=
 =?us-ascii?Q?vovIIy62tpQgZw7s7CdOJ4VjSD1FbNLRcZJTVanvWfPlEYmHFCGfg6p/9p8j?=
 =?us-ascii?Q?AW81ly/erC1zaC1V3r2AOokljLbymqJwZZsSwtXW+I5TUZlYjSZrJsvT7WV3?=
 =?us-ascii?Q?c22/B7STY9mr+WH3Lj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0661b951-6e9b-419b-6033-08dc9bf59de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 06:50:39.7358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGjAi4MUyrySjgMOzPcm3AsF+w4T5PLOUiweB8m6ELQXmC1OpXxIvKIj9YJ1iOYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, July 3, 2024 5:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: add ras event state device attribute sup=
port
>
> add amdgpu ras 'event_state' sysfs device attribute support
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 56 +++++++++++++++++++++++-
> -  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  7 +++-
>  2 files changed, 58 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 11f8c37a97ef..d84e4f841ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1731,6 +1731,39 @@ static ssize_t
> amdgpu_ras_sysfs_schema_show(struct device *dev,
>       return sysfs_emit(buf, "schema: 0x%x\n", con->schema);  }
>
> +static struct {
> +     enum ras_event_type type;
> +     const char *name;
> +} dump_event[] =3D {
> +     {RAS_EVENT_TYPE_ISR, "Fault Error"},
> +     {RAS_EVENT_TYPE_POISON_CREATION, "Poison Creation"},
> +     {RAS_EVENT_TYPE_POISON_CONSUMPTION, "Poison Consumption"}, };
> +
> +static ssize_t amdgpu_ras_sysfs_event_state_show(struct device *dev,
> +                                              struct device_attribute *a=
ttr,
> char *buf) {
> +     struct amdgpu_ras *con =3D
> +             container_of(attr, struct amdgpu_ras, event_state_attr);
> +     struct ras_event_manager *event_mgr =3D con->event_mgr;
> +     struct ras_event_state *event_state;
> +     int i, size =3D 0;
> +
> +     if (!event_mgr)
> +             return -EINVAL;
> +
> +     size +=3D sysfs_emit_at(buf, size, "current seqno: %llu\n",
> atomic64_read(&event_mgr->seqno));
> +     for (i =3D 0; i <  ARRAY_SIZE(dump_event); i++) {
> +             event_state =3D &event_mgr->event_state[dump_event[i].type]=
;
> +             size +=3D sysfs_emit_at(buf, size, "%s : count:%llu,
> last_seqno:%llu\n",
> +                                   dump_event[i].name,
> +                                   atomic64_read(&event_state->count),
> +                                   event_state->last_seqno);
> +     }
> +
> +     return (ssize_t)size;
> +}
> +
>  static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device
> *adev)  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -1748,6
> +1781,7 @@ static int amdgpu_ras_sysfs_remove_dev_attr_node(struct
> amdgpu_device *adev)
>               &con->features_attr.attr,
>               &con->version_attr.attr,
>               &con->schema_attr.attr,
> +             &con->event_state_attr.attr,
>               NULL
>       };
>       struct attribute_group group =3D {
> @@ -1980,6 +2014,8 @@ static DEVICE_ATTR(version, 0444,
>               amdgpu_ras_sysfs_version_show, NULL);  static
> DEVICE_ATTR(schema, 0444,
>               amdgpu_ras_sysfs_schema_show, NULL);
> +static DEVICE_ATTR(event_state, 0444,
> +                amdgpu_ras_sysfs_event_state_show, NULL);
>  static int amdgpu_ras_fs_init(struct amdgpu_device *adev)  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -1990,6
> +2026,7 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
>               &con->features_attr.attr,
>               &con->version_attr.attr,
>               &con->schema_attr.attr,
> +             &con->event_state_attr.attr,
>               NULL
>       };
>       struct bin_attribute *bin_attrs[] =3D {
> @@ -2012,6 +2049,10 @@ static int amdgpu_ras_fs_init(struct amdgpu_device
> *adev)
>       con->schema_attr =3D dev_attr_schema;
>       sysfs_attr_init(attrs[2]);
>
> +     /* add event_state entry */
> +     con->event_state_attr =3D dev_attr_event_state;
> +     sysfs_attr_init(attrs[3]);
> +
>       if (amdgpu_bad_page_threshold !=3D 0) {
>               /* add bad_page_features entry */
>               bin_attr_gpu_vram_bad_pages.private =3D NULL; @@ -3440,13
> +3481,17 @@ static int amdgpu_get_ras_schema(struct amdgpu_device *adev)
>
>  static void ras_event_mgr_init(struct ras_event_manager *mgr)  {
> +     struct ras_event_state *event_state;
>       int i;
>
>       memset(mgr, 0, sizeof(*mgr));
>       atomic64_set(&mgr->seqno, 0);
>
> -     for (i =3D 0; i < ARRAY_SIZE(mgr->last_seqno); i++)
> -             mgr->last_seqno[i] =3D RAS_EVENT_INVALID_ID;
> +     for (i =3D 0; i < ARRAY_SIZE(mgr->event_state); i++) {
> +             event_state =3D &mgr->event_state[i];
> +             event_state->last_seqno =3D RAS_EVENT_INVALID_ID;
> +             atomic64_set(&event_state->count, 0);
> +     }
>  }
>
>  static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev) @@ -
> 3960,6 +4005,7 @@ static struct ras_event_manager*
> __get_ras_event_mgr(struct amdgpu_device *adev)  int
> amdgpu_ras_mark_ras_event(struct amdgpu_device *adev, enum
> ras_event_type type)  {
>       struct ras_event_manager *event_mgr;
> +     struct ras_event_state *event_state;
>
>       if (type >=3D RAS_EVENT_TYPE_COUNT)
>               return -EINVAL;
> @@ -3968,7 +4014,9 @@ int amdgpu_ras_mark_ras_event(struct
> amdgpu_device *adev, enum ras_event_type ty
>       if (!event_mgr)
>               return -EINVAL;
>
> -     event_mgr->last_seqno[type] =3D atomic64_inc_return(&event_mgr-
> >seqno);
> +     event_state =3D &event_mgr->event_state[type];
> +     event_state->last_seqno =3D atomic64_inc_return(&event_mgr->seqno);
> +     atomic64_inc(&event_state->count);
>
>       return 0;
>  }
> @@ -3989,7 +4037,7 @@ u64 amdgpu_ras_acquire_event_id(struct
> amdgpu_device *adev, enum ras_event_type
>               if (!event_mgr)
>                       return RAS_EVENT_INVALID_ID;
>
> -             id =3D event_mgr->last_seqno[type];
> +             id =3D event_mgr->event_state[type].last_seqno;
>               break;
>       case RAS_EVENT_TYPE_INVALID:
>       default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 6086da67fa4e..189e2bf53a44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -436,10 +436,14 @@ enum ras_event_type {
>       RAS_EVENT_TYPE_POISON_CONSUMPTION,
>       RAS_EVENT_TYPE_COUNT,
>  };
> +struct ras_event_state {
> +     u64 last_seqno;
> +     atomic64_t count;
> +};
>
>  struct ras_event_manager {
>       atomic64_t seqno;
> -     u64 last_seqno[RAS_EVENT_TYPE_COUNT];
> +     struct ras_event_state event_state[RAS_EVENT_TYPE_COUNT];
>  };
>
>  struct ras_event_id {
> @@ -493,6 +497,7 @@ struct amdgpu_ras {
>       struct device_attribute features_attr;
>       struct device_attribute version_attr;
>       struct device_attribute schema_attr;
> +     struct device_attribute event_state_attr;
>       struct bin_attribute badpages_attr;
>       struct dentry *de_ras_eeprom_table;
>       /* block array */
> --
> 2.34.1

