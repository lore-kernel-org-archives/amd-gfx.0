Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B85BC2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 07:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3905892C8;
	Tue,  9 Jul 2024 07:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H46qmZ4g";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84819892C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 07:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k43apt4oIf4ptPU4dLSEhp8dhVD03G8RnnF38oBZUKV+ElXISyW9UYBhULyBA6OEykFovAmhpJd+fNjhTNBQb5Emd7DBOsa4TNgMGx1/NzGbuV+fUYpcweutDxOxWNFkBqR39sZVC5r5Ggw1sycc6Uab1KKXzpHTms1cmDUJ6UxPcr/GpBS/r88NfYPMMjP+DDdYHikLZDeRdfo5ALo88/CrH3odkxdenJ6vUq/79WPUjGmCi/HvqbjYJRnoEvTsvjErmtnfGn+J9AE/q+/XLS2m6nx9vVBG2wxKw2xcxzXC3WZBfi2eVlQ62/RRBKP2TjzadhlqrQCHHCms1aATYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6aDOWq8sJCJ+GR443p0Ki9nkHBQrylV+YSOAuebEyo=;
 b=P+H2cmViUIKO9EsmdNmuWWBRize/tXJ3R7gBnjEm946rGfzI/jt4pvQ7opTElDfESf5m9EtnbCDkcx7dWdyChtow0gtnUfGdmufAX1GjoBirTY/+k56PXeKc/yUyTszErCrVkjhCJGkDgT748kzW2t9hFGpasZf9NgqpIBan8kkHt95Bx54K4h2ZOAvvl/k5aexgGA9W6OMwhkIZBTzXAcCFEckqq9J2Is9RDnT9/+aDKHlvDKTecSP0nsfLNqvsTLz7Rf+pGNAYRgL7lW39jevHC7zWdv1xCzp8xB2vC1Ib+m81glbmV5vVDC88LmGpEYSbROlBtYLOJxWq9wSWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6aDOWq8sJCJ+GR443p0Ki9nkHBQrylV+YSOAuebEyo=;
 b=H46qmZ4gZ1SazCZgtEc5nJ5PrNeBM4L/ImRlR+goneHF4nu8z8W4wSy2vMhw2Z+8H5GXxiSSCitAEetsK9HJmLA8TXXZpZSZpXJMrB8mayM4vNB2JrNXz/PXSumCUxB+YdB3SrBRa2zDA1hxCWXLatcv23ahpz3tWlhm1Bzaewg=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 07:27:50 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:27:50 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Topic: [PATCH] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Index: AQHa0c0fIQiHNIBpDUGfMq9lcABumrHt/mtg
Date: Tue, 9 Jul 2024 07:27:50 +0000
Message-ID: <SA1PR12MB74429297CDE337A8B1F33EFEFEDB2@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240709065547.1639176-1-jiadong.zhu@amd.com>
In-Reply-To: <20240709065547.1639176-1-jiadong.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d4c519d5-a31a-45f0-962f-19010d55f621;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T07:24:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|CH3PR12MB8403:EE_
x-ms-office365-filtering-correlation-id: 72fd3095-18d4-4c29-0f7d-08dc9fe8a357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GvH0YK4fbUp2USC+4Jpe90ctNyHSYgA5IRcAKFA4zUIYw42C+oolGzyoTCn1?=
 =?us-ascii?Q?v7JkgJqwWWaafjV7G5G+ycqM1j/KOBOiEk3PZ6j1mfsGTc6Jh4dzilfipMNm?=
 =?us-ascii?Q?fpPYAJsUYEMWQaoCK1vvytskws6672loIgiyWvXetUmtrG/C36cNj5XgcNhd?=
 =?us-ascii?Q?C3+4v3nF3M8zswpDwZT949S5HCi4G28BCwnVHKAroYyWXIpQ2cr9SgB5bPg3?=
 =?us-ascii?Q?VCHRkuDJgOV3xZMyrUtwU9tPcsnlW2CWDffFZPtmWcDs7zhfjS2Czk4uOjsK?=
 =?us-ascii?Q?c8+eh39wc0OseI2KakMmtGCq0bWmxDBkSQcmdhaJIaPZEvrzhwBmU5PXJB9G?=
 =?us-ascii?Q?RKGt1E26LBOv1gxPVWMUUA0373fkE32oRlhXEkYOoHb0FUiAs57DZLiKCUxp?=
 =?us-ascii?Q?2f9F9w81XbTvmaZZu66HvLF9E8xsiqvvtEBSXA+Z893XysL18FCl8RjICwSH?=
 =?us-ascii?Q?qd/BHlkXlGBJeoEUbSMIGML5NrS1G98JFOwtPmT5kzRJFkfU0SDKs4PnVuqC?=
 =?us-ascii?Q?BzZMsjlILYICxOPwQ4YRZFG7tZrDGcTaGZ4u+G7rejcrmuNMWCpShhzLXacc?=
 =?us-ascii?Q?+2quvX6fhAfsRkOO3Rkz4+s8yK6EDaPJhZDW0Yn0yh7yn6lW+ak/vFXZ4cWA?=
 =?us-ascii?Q?HWfIdlA7/A2Lt7eSHQZ2P6XaaGEj5T7pMJ8OV41Ot3C4dsUA/t7b8uExRhoL?=
 =?us-ascii?Q?7fKbr8Y/z1sLAZn8+PvGr4zhXxz7EfLdbVxbFSs5rLOrcbqGGRE2DTgBcAVh?=
 =?us-ascii?Q?vRIDf2QM6Sr6EwzDlkpE+/kNJuOZfDokEvpOyuTEOLKZj6VwWLMJXhnZO25U?=
 =?us-ascii?Q?3lfCvkoUWTyx60ULn0BWUxlE0MS16kGpYojW+bUevoTRSnterfK1GSDWzWkm?=
 =?us-ascii?Q?0w/aGEqfBxV7qFRPuj0MpWKSWovK8gpG6jp2U82M2GrnY3+drdle1a7PsOSm?=
 =?us-ascii?Q?wT4pauwNUCV9BvnNCdY6S+NmY8/DHIVRzkT0XK4YwVpqilneKWzSgoavHPUL?=
 =?us-ascii?Q?q2Tyo1XASyfyBqjRQCsjOVvghN72vjWWcfmN+M1f13T7UaVbxGiDobZpZWvt?=
 =?us-ascii?Q?Csn7UTvot4n1V2ieSUsOP8B94gYNwae50+n2Dz9Y3uc7CyACq5xvjm7fO/SJ?=
 =?us-ascii?Q?HJTJeyi/XdfZ2VwAU56VXY1thaILpm1lZrQ1gEGcTbBjKztvClBPS0JyQQwa?=
 =?us-ascii?Q?oX2zrbRqwaFyN6M2crx6mr/5k3shfScz1xLnqXVtbKbTMCzx6vEcCWa8JXAh?=
 =?us-ascii?Q?ltdgP3JRnfoBJzvNMFDuti4hzXSy+ZxAhkpvukais0N05ANUaUZYaoW5u8uq?=
 =?us-ascii?Q?lEN7lbyCuyevKIpM2QINsMJscKuDLb/R44iuEejs/VjI0a7o6ltNkMqSBfvu?=
 =?us-ascii?Q?qd1pB8faXDd7FKXTjBVrqC6GiX9z7gOjN02EEJqW946scQnDiw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HW+PbSeV5YVTsT2y6UqzZJtY3M7YWpiNX4RLdXawpJ6+YxHm7wLgCW/+ONTm?=
 =?us-ascii?Q?PjE1Le/vpSfUGaCF+iBctvBDNz7vOtee2IUZTIbgE0/IWOYs7IBmy7pXJuu3?=
 =?us-ascii?Q?leQjkTXQbm7e/h2lGu6EeMsaluuPp5j1WdlK5uF+maaUQMpkx0c8lSGe5fek?=
 =?us-ascii?Q?G8ArCKy+bJ7WlOjFuca4/s4fqTnkmdXJADG1x1LNg02PW7nuxgcrgR9q5FKH?=
 =?us-ascii?Q?gTG2y9q2NxjCYD/3TR7xT4F5TlKtYZDN4HXCW+Qo40xJXX2OgbljTpMDyWJo?=
 =?us-ascii?Q?mDr79cNfepz1pMY0bBu3uAETkyrmSZnV5YLz2iPuQFgFPjtHRTV7NlMK8Zfr?=
 =?us-ascii?Q?ak2bWFU3KuAC5GvpZxGZAL8NbHoCDksrM56RhiCY/gWcbYt8i5ni4o3uZOmO?=
 =?us-ascii?Q?LRyv1zQxs7GSfcdDw3Bb3JYVPupIj8Aqx9BVAkQksGPoJH+/ooWFZobSGD21?=
 =?us-ascii?Q?2/z6kd815zWj3coJYhLDmCOW34XjTI0ttk9wmomDdDKgwyEDlMHGHY1fSAxb?=
 =?us-ascii?Q?8P/V4k7r84z7LZSBBaL0F4oZNML+HYKyNywd5Y7lq7IMwrt2JbV+QKCURwz1?=
 =?us-ascii?Q?qC6rObvSOO2vC5S44HmrPpEWl87ihMBbhndceVTOVt97Q0oO3loXkNyRR9Ob?=
 =?us-ascii?Q?Z4YB3ZL/TV51FgxlKrlNJBlyvkDinwIVAAyHX86Qu4L55FyURLKspOkS4StE?=
 =?us-ascii?Q?6/KCUOJj95nXIstTHG2vEZh0VeH5zoPoWIDk31j+ZINemjU0RUzabbBLJ3M4?=
 =?us-ascii?Q?01M+zGviOpwnq7tuy2mza1A6lLl68Mqv0i4KjfgnmRnzMWa5PqTLOC70eEPR?=
 =?us-ascii?Q?vPXbkWAnt1BFjddkwUp4c7X6WtWKPpl8f0adMCCzuORyJ0XkpExxA6ars0yM?=
 =?us-ascii?Q?H2WLhxL+XlwKSBrL2Qo2irYi4hnsk4IMKN35YAQeMXuuHMKJRtvWDBIXXenA?=
 =?us-ascii?Q?Vh8jI8TJwE2hl9bzZZlCWcvhzHDVyFlM7cGTKrfXUs5u4QctyfpLWOcD6PlQ?=
 =?us-ascii?Q?2g0xgNW/H1L4libDZdytu5NLTHlCy+idcayVZMLS+b47su4slvfaMkIvKdJS?=
 =?us-ascii?Q?7jF8UalsA/88hK/XAjsBT+vNjZuQfDqbXTKcGlMGVLdwWE9S1oiEQ1uqKxun?=
 =?us-ascii?Q?TRlUWIgX2EyqRdGv3sfKKA3hb/uK+nYqIXDC/GwC5O05Qw9vPUKvxOb3Dngp?=
 =?us-ascii?Q?JK4y5s4gYjGrwyzhWjoV7xQfXPBH7Q17YLMTLD3MEXzR4Q2oWKDNutJ7mHI4?=
 =?us-ascii?Q?XR0if4c3iAvv8uXDenjrZrWPDu3LjJUAMfrIc4t4uBhOQlKvdxOIzfkuk6Hp?=
 =?us-ascii?Q?R8m6cbFaYmsvlJjMiIda+/cxlnzBUxpAAIbsL9usmLjr48lYJhmheyMp/E1f?=
 =?us-ascii?Q?u5v93RXs31AOIOlrKR1cd9vrsy3+6W8YnS5D9gck5JPDWeumyyBNgKii6Wvg?=
 =?us-ascii?Q?Xx6ZQdjxILA6nG2Tprvuf0fuJUJQ2FZf3Xrfy7Ydd+24hkeFkz87X8CxskMQ?=
 =?us-ascii?Q?XZ+bP6N0jIT09aXOaHXyxJANEyoV6iE7xTqv7+njLoHrkzGXyBfjys7IIhQC?=
 =?us-ascii?Q?vicjC4WT1EkItI4QOCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd3095-18d4-4c29-0f7d-08dc9fe8a357
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 07:27:50.1112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoszLEwokYlJhWznFLaYVrUUUSnYgzCsu+CXThM3cug0MZgT0oQN1RrW8S5EmR/zvISXHAh2q8iVBwe0s10Nlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> jiadong.zhu@amd.com
> Sent: Tuesday, July 9, 2024 2:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Subject: [PATCH] drm/amdgpu: set start timestamp of fence in the right pl=
ace
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> The job's embedded fence is dma_fence which shall not be conversed to
> amdgpu_fence. The start timestamp shall be saved on job for hw_fence.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33
> ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  4 +++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf..60c14d2e1c39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -88,6 +88,33 @@ static inline struct amdgpu_fence
> *to_amdgpu_fence(struct dma_fence *f)
>         return NULL;
>  }
>
> +static inline void set_fence_start_time(struct dma_fence *f, ktime_t
> +start_timestamp) {
> +       if (f->ops =3D=3D &amdgpu_fence_ops) {
> +               struct amdgpu_fence *__f =3D container_of(f, struct
> +amdgpu_fence, base);
> +
> +               __f->start_timestamp =3D start_timestamp;
> +       } else if (f->ops =3D=3D &amdgpu_job_fence_ops) {
> +               struct amdgpu_job *job =3D container_of(f, struct
> + amdgpu_job, hw_fence);
> +
> +               job->start_timestamp =3D start_timestamp;
> +       }
> +}
> +
> +static inline ktime_t get_fence_start_time(struct dma_fence *f) {
> +       if (f->ops =3D=3D &amdgpu_fence_ops) {
> +               struct amdgpu_fence *__f =3D container_of(f, struct
> +amdgpu_fence, base);
> +
> +               return __f->start_timestamp;
> +       } else if (f->ops =3D=3D &amdgpu_job_fence_ops) {
> +               struct amdgpu_job *job =3D container_of(f, struct
> + amdgpu_job, hw_fence);
> +
> +               return job->start_timestamp;
> +       }
> +       return ktime_get();

Here the invocation of ktime_get() should be unnecessary as start_timestamp=
 in both amdgpu_fence_ops and amdgpu_job_fence_ops styles are already set b=
y set_fence_start_time();

Regards,
Trigger

> +}
> +
>  /**
>   * amdgpu_fence_write - write a fence value
>   *
> @@ -197,7 +224,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,
> struct dma_fence **f, struct amd
>                 }
>         }
>
> -       to_amdgpu_fence(fence)->start_timestamp =3D ktime_get();
> +       set_fence_start_time(fence, ktime_get());
>
>         /* This function can't be called concurrently anyway, otherwise
>          * emitting the fence would mess up the hardware ring buffer.
> @@ -428,7 +455,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct
> amdgpu_ring *ring)
>                 return 0;
>
>         return ktime_us_delta(ktime_get(),
> -               to_amdgpu_fence(fence)->start_timestamp);
> +               get_fence_start_time(fence));
>  }
>
>  /**
> @@ -451,7 +478,7 @@ void amdgpu_fence_update_start_timestamp(struct
> amdgpu_ring *ring, uint32_t seq,
>         if (!fence)
>                 return;
>
> -       to_amdgpu_fence(fence)->start_timestamp =3D timestamp;
> +       set_fence_start_time(fence, timestamp);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index a963a25ddd62..68a80e31ba0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -73,11 +73,15 @@ struct amdgpu_job {
>         uint64_t                gds_va;
>         bool                    init_shadow;
>
> +       /* start timestamp for hw_fence*/
> +       ktime_t                 start_timestamp;
> +
>         /* job_run_counter >=3D 1 means a resubmit job */
>         uint32_t                job_run_counter;
>
>         uint32_t                num_ibs;
>         struct amdgpu_ib        ibs[];
> +
>  };
>
>  static inline struct amdgpu_ring *amdgpu_job_ring(struct amdgpu_job *job=
)
> --
> 2.25.1

