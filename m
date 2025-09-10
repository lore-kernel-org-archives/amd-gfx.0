Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FFFCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 12:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA2710E909;
	Wed, 10 Sep 2025 12:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p2s0WCTJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EA210E909
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 12:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8g77nGjjuVCHq4hcVfbvYOARcIpimcq3I+Ht5LyasaF3AXc59E+SkAmhSTjh8BllINSCed3b5Ef9bLlAMFT/i4Umew4FBdKlTPaNGEYzLJ5CAe9Iy95Pog/RnPRIalbT7DTR0A6eTb6s2sP+cDO5HvkGXZ+leOvnaRwr05sWNRlhQMX2+CQTH26dyA1/2n5bKJxyU+WldwOEE6aANn8t1LVvE5pag2tgIN8Z777PlSt68gNc+98fgah4vCrY2ua32DpA6Bgp3r5iwvOR84Qx6UKaF9BwOzz2nZ80jRYHKur093Pl+GkBegZEaQRbCGRDz0LFyn1hopL3O75tnj1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+89YUgmj45WS12pSGl0Cqmb9EoIG6YyBmlv3UmgPI6k=;
 b=cOka4bDSwRnz14uUJVHMGnJk3bsRlggj+KGdswrKhaM1UsGYTEdrHkBV1GPfW6kQJw2hlq3yovoCn4hYsKZ9ydHulKUoCeqLyBEyqUH+hl/hIg/p0t86okBo2/DffkMFflic+zPXw++fY2+AMvhIBDcx4OLG4YFEBJ9J2Kn71JUU+Tb5S3QBydDjlhy+gjcQVeF/mDmTc/yE5WRkRrKJ7V/TLDLQtxQ/aV89QBIK2rKyrKgiye2ndKvSLgPqMx1wpmxOv+yzvAeFZWZmnKKGTKTyH44kIHJZ5qfee0k7PqfSr8bB9qvenIo9qy/O5Za8ddzBU+vHLdrtgnGmXtL+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+89YUgmj45WS12pSGl0Cqmb9EoIG6YyBmlv3UmgPI6k=;
 b=p2s0WCTJHr+JUo7awMLWU8JnI3/YMqv4mnBCk8fZD4oI/47WPxh/ST+piWhdyx9seErfEuE3CxnC9x3ycjOhn08j6H6Wewex4nGDEQNvrhWEoV8RpIoprIiJ+KVOgaqFsRfCvKl8PelysOqU723NDX5zBdEdu919c7fzPxUhg3w=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 12:08:59 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:08:58 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/9] drm/amdgpu/userq: implement support for query status
Thread-Topic: [PATCH 2/9] drm/amdgpu/userq: implement support for query status
Thread-Index: AQHcIkdUtuPwfVGKK0e9QvFGSXwBo7SMUiFA
Date: Wed, 10 Sep 2025 12:08:58 +0000
Message-ID: <DS7PR12MB60058033CB9F5D710F6F9F89FB0EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
 <20250910113731.2688320-2-Prike.Liang@amd.com>
In-Reply-To: <20250910113731.2688320-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-10T12:06:43.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB9058:EE_
x-ms-office365-filtering-correlation-id: bb29226d-d8c5-408c-826a-08ddf062d2ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CiFPFtlgKgYLttH4SvjKYc7ZgCwj5+TZHZ+muI6b48UqZECM9ZQnefWfWEjD?=
 =?us-ascii?Q?OZ68WaOxUBYFyAu3/Ud//lbnTh40qyfXgWrNuC2eyPgHLUV3m1r5eUyqnErX?=
 =?us-ascii?Q?AgTZ/77lcUUFmVADI0OI8VHbANngfXPsAtgaH/x36+EM1wxIvdnEw4dzyT3y?=
 =?us-ascii?Q?em2S9lYxV+APhcOoOjpTio00Z16c5FUsxv6iTieUzt/aOg+//1vKsl1ZsURP?=
 =?us-ascii?Q?Q5cTUbHoxsT7XxcPKqOM6Sz4LghxqszEcMIkk6K5zVP5jxoYoEKWk30GRDCM?=
 =?us-ascii?Q?gsHKEOd/+hY2/gAKwa/LeqAzw77SM22Z3dP9tVEiHg0qJ+2U5i4Ss52iSZ7h?=
 =?us-ascii?Q?F55VeJkyNusVSHneIuyXIxFGiX7vR638CrGlamar48yoHHOC0X8AkXt10Pml?=
 =?us-ascii?Q?/iH1rB3LZNu+z2InbhVXePENl4n3ZROmo8Bxbde823ubjNM/pEgqyjrGKHif?=
 =?us-ascii?Q?Bq8qlziK5O1nKsVUX3pU+DaUX0mIq17SfnzM4evhaftLsbuNjEwNcX9+WgjS?=
 =?us-ascii?Q?rWuqcSQyImmfZUvZ8pDYHiE+AD5wRdjNqCwlqu0hjIcg5d7neIUqgcW+0152?=
 =?us-ascii?Q?6iYZin+HUeszHwEICV+za8+DymcbmdGbSGJRR3c7xAFx3NMqMuk0zkdmwVPM?=
 =?us-ascii?Q?mhSdQ3mOcOz0z4kgK1Nr8IhcF9daHwHwjIxlVPh2510t1hwKAJVn/tqTPz9s?=
 =?us-ascii?Q?iYFQc5m/nUr5uSLlK1pYq2inMXtbVEJdnEwsGhEjC6/EZeC+wvedm+hJMzvU?=
 =?us-ascii?Q?WthV2Hc5jom909cLiMqUdhUyv0AnuMGXW0aNlxlMCiFL1+WY/fIN6fP+FryY?=
 =?us-ascii?Q?R3uFrIJRuf6AIuSNXGeLQuq8Vl9eHe/0fH99nTGE5/5BgHIp2I9DngMAPsDM?=
 =?us-ascii?Q?2ZCZsmfZrar3eVY14tfvRzR2NvHTzCtUPFM1GVe0KtaUdpcTV2OQyrvFAkXW?=
 =?us-ascii?Q?WrnZZ4Neh95GdMWK2lAG3e28XpRTbCHqJTJGL62tG/2z/ulBNJpEYtnfReJK?=
 =?us-ascii?Q?74FTcjT5f4X3BH2EHeDD5Vy0CA+2RW8dNPgzLdDt4McjUrSue98H6herkgZJ?=
 =?us-ascii?Q?IOnBAA7aCi4UERQbVREeaZv+cTnwdho+fQs2lf5/AkoTAtiIqwzElUIhRI05?=
 =?us-ascii?Q?s46dZZXuzHeCJg3A3Si66MGVr5SI9qUjCRCerpI7yj26J8BansPfaZvuHdh1?=
 =?us-ascii?Q?Fg5BSK7aUW+6aI4p7X+X9h9IDZ4ftvEWNR9lmYGUPmVWLR6NW/j2LQW9jZNm?=
 =?us-ascii?Q?Y97olJK3PuG72jM12HPnA1ZqBKxGQ8F+0KKEE4iGvZ0/G96zXtd57dHXZGM/?=
 =?us-ascii?Q?/u7Hvk9rm0rljU9iui2kDc7mUcYqQq6Dhg1HGhFXETcQGOnen5HIabI9Xr9a?=
 =?us-ascii?Q?YRDuLYWJZfbIITwf1sEII23t7DoSXaK8Fz8PKPJKsEOyqIJCT0dMo9YISnze?=
 =?us-ascii?Q?2GGsf7Rg+MPRepTmW1LdG6i9n6EPlIxRlHKHUajoDsfnMbbubLAyMfe74sq2?=
 =?us-ascii?Q?joUjqX0ULlJJf8Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KgyjtOm9W1EkRXvPtaO5o4O9dSvmq/s0gsCWq1Cz1JWg2EK4lJnx16sSx6UO?=
 =?us-ascii?Q?Bu9lg7x4t00+NfYQJ4BiPOWVndMj9u+VucX9s4x6G3yPQNzk5JmA2dmISG4U?=
 =?us-ascii?Q?vHxLffoft6koN2tppmY9MJF8ptfOM7GJ5yiEYgPCsyz9RfIRLMAix+Jj3Nmu?=
 =?us-ascii?Q?Gzmk9QN4m1qsFhwrKSIZ3EQv9pgtOU7Dx3kH+EaVZiORx2AWW623bwxtR+Zz?=
 =?us-ascii?Q?j57qSJb15WHdPzvxJJtps66r0qWueR+WJwMp3SLuxKe7b/6ZQjj8Z0ylJsOi?=
 =?us-ascii?Q?/qW5vBCBVhBfyQ+hc7dxSHuG4kK60IWChcJTb0dxjOQ4dZSmnwzUFjf5Tzju?=
 =?us-ascii?Q?QRHxOQEzLCAzACL2ScN+1foEfWxOtpQgG0twhWSrqdcJI35KmY85iQCnTJc3?=
 =?us-ascii?Q?Cri91pS3m9D4Nu4i5DeOMm/7eBaejrtjWl1wh7fq3q7aMi5uxnBPW9qSBZ3t?=
 =?us-ascii?Q?7z7chlgiV3krpPsKqzoMNTFy5EjtlQTCyFnCZOqTLq6Z0tvgVKLDyul1qYiB?=
 =?us-ascii?Q?NPuVDnxvmelK4hM47uDWvN1DYQX7kOSq7x5v7Lb5lBwYDF4eX0I6/yloBZwL?=
 =?us-ascii?Q?sRrLaN+e8PzwULRSFW8bSQesPDGLo4HW4DTzvCtKOZQPx3N6iohfB52Zcxgr?=
 =?us-ascii?Q?DwfxK2EYcfTEYvf2mVAiTxddLxXs5TAi8obKhZS+q+dZbkRk6XNF1lD6n7GY?=
 =?us-ascii?Q?Y8H6Uu6re/ccQ+aHKJTaLIwpLrPiwfb+X3w6FRNldDt9ljrqmrb+hy2i8rB4?=
 =?us-ascii?Q?bnbLzmC4DJI9GoRJbmVqublBtDU68t1Z8RtgV390KNV+OylEGBtmgxiZOXvK?=
 =?us-ascii?Q?Ffa7ltanw/0CPSoumr1xmZoF38RqR5sdPz230d/ZfAXUQmXYpvQzkpU3A/Jh?=
 =?us-ascii?Q?gtXqJiqVFcVaAWPX2OxyAGYhP1O6wLAmDTqRIjkNM7Io/H7SuIMomOAgGSNr?=
 =?us-ascii?Q?ctfCp99i1KXan1WE27WPgYaMQHd2VuavTEhkDZpAG8+RIzocyMpXeoVEFPDK?=
 =?us-ascii?Q?AKTi5Zz2iEG067jdLsaxjqbOS38EtPAft4nMpoTTFyAYTQdJ8JO652QK+q33?=
 =?us-ascii?Q?XuPp5hG4rDOjgFiHTr/kEIN1RQZkAyV0hClGD/5zfNY2BiKz7+Gmqug/qXnZ?=
 =?us-ascii?Q?L1AgbIUg/2PGB0pCXJhU94T8CwNN8nTYW4m3vPjujo7yrQ8VFxk7FIqNZq58?=
 =?us-ascii?Q?6Pyy6jdsLvRgLQQmRwC1PRy5+4azKi57GbUwfwRRDKzkuedD6w54GiFwWaFe?=
 =?us-ascii?Q?XimvmFLZVL3AqRl3salUCmyCoUAkSVCuQqHi/pcXLbQ6NqipeIl0x1fPBBJm?=
 =?us-ascii?Q?u7dqXtmVhDgn+EROsifX2uqpFh3CPTrr4SCgtW4XWQayR55P902m7G5R0W76?=
 =?us-ascii?Q?2/QSg9yvvj/l37u9MphZCxgFOF0aXE0t+PIgE1PKOLohtEWJ+OdOgn9nyDLA?=
 =?us-ascii?Q?s3OvUeDRTX4IZh0e6efas2i+eMK5RibL7xgb4p9qoz9M6o24SRBzIQma2tOC?=
 =?us-ascii?Q?YBztKKTNxQfjgh6AudVZJVrUZaAFqjjuk9byIPevGEdr6H+5DFjwT66z9CP3?=
 =?us-ascii?Q?V9vK+FyZDQFQXZ2Jdvk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb29226d-d8c5-408c-826a-08ddf062d2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 12:08:58.8433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xVo1V1aAhMVtDCEXtVw4UtzVj8bXwQZ/31NNRmtZ+rZaXcZ6a2k0kp8JVi4O72W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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

Maybe we need a PTE schedule check in the amdgpu_vm_generation() for the us=
erq only case.
This could be a sperate patch for handling that, for this patch is

Reviewed-by: Prike Liang <Prike.Liang@amd.com>


Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, September 10, 2025 7:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Khatri, S=
unil
> <Sunil.Khatri@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/9] drm/amdgpu/userq: implement support for query status
>
> Query the status of the user queue, currently whether the queue is hung a=
nd whether
> or not VRAM is lost.
>
> v2: Misc cleanups
>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 9608fe3b5a9e..83f0ecdaa0b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -472,6 +472,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       queue->queue_type =3D args->in.ip_type;
>       queue->vm =3D &fpriv->vm;
>       queue->priority =3D priority;
> +     queue->generation =3D amdgpu_vm_generation(adev, &fpriv->vm);
>
>       db_info.queue_type =3D queue->queue_type;
>       db_info.doorbell_handle =3D queue->doorbell_handle; @@ -553,6 +554,=
34
> @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *arg=
s)
>       return r;
>  }
>
> +static int
> +amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq
> +*args) {
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     struct amdgpu_usermode_queue *queue;
> +     int queue_id =3D args->in.queue_id;
> +
> +     mutex_lock(&uq_mgr->userq_mutex);
> +
> +     queue =3D amdgpu_userq_find(uq_mgr, queue_id);
> +     if (!queue) {
> +             dev_dbg(adev->dev, "Invalid queue id to query\n");
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return -EINVAL;
> +     }
> +     args->out_qs.flags =3D 0;
> +     if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> +             args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
> +     if (queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm))
> +             args->out_qs.flags |=3D
> AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
> +
> +     mutex_unlock(&uq_mgr->userq_mutex);
> +
> +     return 0;
> +}
> +
>  static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>                                       union drm_amdgpu_userq *args,
>                                       struct drm_file *filp)
> @@ -633,7 +662,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,
>               if (r)
>                       drm_file_err(filp, "Failed to destroy usermode queu=
e\n");
>               break;
> -
> +     case AMDGPU_USERQ_OP_QUERY_STATUS:
> +             r =3D amdgpu_userq_query_status(filp, args);
> +             if (r)
> +                     drm_file_err(filp, "Failed to query usermode queue =
status\n");
> +             break;
>       default:
>               drm_dbg_driver(dev, "Invalid user queue op specified: %d\n"=
, args-
> >in.op);
>               return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index c027dd916672..2260b1fb8a22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -66,6 +66,7 @@ struct amdgpu_usermode_queue {
>       u32                     xcp_id;
>       int                     priority;
>       struct dentry           *debugfs_queue;
> +     uint64_t                generation;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.34.1

