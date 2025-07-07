Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE7FC83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 10:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B772D10E31F;
	Mon,  7 Jul 2025 10:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1gM1GLe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1F110E31F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 10:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hld8XxR6Cq7baC4osCtJRlBFS4u51x50ewadvskDoSpTCTcHAZcEvK/dqtMOft16Be5vswUBJGELrJEvGij0N4BFuSb2n6xNK5L1FSZcpQYcvdDmtUPHSF6/hAEAF0vycegh/UCPIt2RLATBDTqlsYoJHGvkS0tzyXhtXj1+qsX2o8LJ1vMWcKu3IG9t8VPc61TNlohUjAxm3CwyFd1thO4pzzXsRPKn2mPe74nx0kp4pmFLhNnyO1MKuPdOrcw9JfYQwSYu4CVY0xRlhxm12A2nsKG3wM2Wrypi5cc8V+3qxKoU5Q4xls1uAqrfeUt67BrFRYvwP325Y4PeJH6QFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3PhQqk4khpAmqXbmyim5PuZAoAnopJ2a74meUpdVJg=;
 b=i6+2A6Y1aNLS3HUVRPTRsQD3mL4HLiZofOtibAsj4/7JPm0w8gc+eD/vt2PLsbn6jZqylfysddr1d1F0cfJel/gD38/SN9YN1MnC3GsgeABW5aOI8lkQUoYYwC5UiiOsWeCTVgAn5ByhPFILHawktvJZ2mpE7wh5EfjDCL4WfgGVVwWaLk8c1dJNVsI/ktHz2ry6fWaWDCGYedorgSEdwjho4cUMSVm1J17QtFiCjr9UlQBBdoA4UqRD5xLFuLcMohGSAN1em3djgvlRvhuFS3tGeFZZZv/iDP1lMXdPoKRMOIMG+Is3YO0dQgU1AcBAKT5ffgedhnJjBoHJv9RPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3PhQqk4khpAmqXbmyim5PuZAoAnopJ2a74meUpdVJg=;
 b=g1gM1GLe+3NxJdNDKHxy/5dpolM5XUaMye2z+C5lqAgRgItLHv5NAN8wvOTk8OJ+6DpJOhnUSGWc5NZp8/aS98QKgNcUaKohdDMLCDlW4JyQ/qmbUkWiDUESJH0RkgzybeccUcHkzBX55yYYocZdThlwPjsuEMgfgyF1D0Rdpws=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 7 Jul
 2025 10:35:30 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 10:35:30 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same
 nps mode
Thread-Topic: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same
 nps mode
Thread-Index: AQHb7w46nrfWd7MqYkutVU7KziODdLQmd2TA
Date: Mon, 7 Jul 2025 10:35:29 +0000
Message-ID: <PH7PR12MB8796CABD7749CF5B8E1BCFDDB04FA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250707070939.6852-1-ganglxie@amd.com>
 <20250707070939.6852-2-ganglxie@amd.com>
In-Reply-To: <20250707070939.6852-2-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-07T10:34:43.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY5PR12MB6227:EE_
x-ms-office365-filtering-correlation-id: b4ccadf9-091c-46bd-28e8-08ddbd41feb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dISo45173ad2IzjL4Hgii2g40A0ubcSe0VzMYBzYXLa9YfPIxLyN1y+thEOB?=
 =?us-ascii?Q?ULmGODnD8YOLKkJs46skDfVIOVF9Ak9CKS2Zy2IU2nj1c9hzHIJTbg8QZLb4?=
 =?us-ascii?Q?22InuDI0p/mSrCxu0V9RWMSuoZHbjxcxUucjZCtKSVU6v4qYhvrWz1mcsRyB?=
 =?us-ascii?Q?Z7rEKXvwnpmTnUldaDfXW2Dtgd0df2el10nxSKM/+21eV1N0zi3v3Pioiv71?=
 =?us-ascii?Q?Yd8InpZVEoL7mU/SxJW/8i6v3rq1sex3RXrpRxWpj+MC74msMUB3MvQGSI/9?=
 =?us-ascii?Q?MrjrMhvqPj7/wiZUcHjs9FqpFNYeDcFnYPc+zWbVzax/v3W8hD0ogCoXHyng?=
 =?us-ascii?Q?lcKcOA44E9B2uaY+3shI0nQaAETmgaUqzfWrzvEeVgMHFm/qgjBZyqodjCfa?=
 =?us-ascii?Q?dj3qSkBp0LHhzMjNaxv8eCl9TnHrSv2Owo/jY7JKikhBwhFwId08ivEXU209?=
 =?us-ascii?Q?2abin8Z9FB7K+ccwTY+yEa1djWJpPX983Gh1X3igbpzuEwA9Jte5QB3VAJb2?=
 =?us-ascii?Q?VcgFqJk/YSp0vqtnamny30LKaqPKCpG7GJFi5uxoPuO603ik5wLaPEqkmvA8?=
 =?us-ascii?Q?0fCrWO0usbMFfKYcZEsoGqzuyzAnGGKBlg83gUWQxIx4sQzLQAJ9lavUoSCZ?=
 =?us-ascii?Q?FRzblxSMhjt90GEk1i4nISwDhI9MK5LDxLvg8AJzHkDKVUGttdBWemIMXeUl?=
 =?us-ascii?Q?0o2dhFWDlqs7rhwNTHTYvh8LwVXFsR3ojzc3XmNr32BI5HvGk2hRF9DudEsj?=
 =?us-ascii?Q?ZlZIlfVwRohS6J/pj/wK6evZILTyLObC17rkxTqBUok2ahi5YbasydHcT6po?=
 =?us-ascii?Q?HicmipDGtBfT2W1ohveqKzPYWx/JbK8gEBZUBF2IO27rUHkQmDQoOw5IX//A?=
 =?us-ascii?Q?lJtVVf6DGmfiv7M5hZ+kUbAUP4VfejihBT8R4rBV3NJAoVjZH99avtbJsBYv?=
 =?us-ascii?Q?JKAiKQ5zN7QjC01upzNIMGItdNY8wEgTFlDozB+tkzSzu+bNLn4OuOTFmtil?=
 =?us-ascii?Q?7UnTwVU0aj5Li19h5ZQK/5Z3EX2vM44xryqnfwE+XYNgIV7sm7CWnCGaWwgJ?=
 =?us-ascii?Q?qVjwzArrFyY44rKpUoRn4wZWz729dzKa6JlkpGBfellHA76VC12VDYpG08gv?=
 =?us-ascii?Q?9DBzP0zIPSJVvIQRdxXwa9ApKKBXUqhjIliYFurm8VGsE2v6x3U8ySNxFCk1?=
 =?us-ascii?Q?y1NMpw1LpPfhhZEX0dlPRHPBAop10v4SzsozF9FI0GfIR5+Kn40q1sLiXsFy?=
 =?us-ascii?Q?8PlSkFd+AkrAUFThhfzDK2md2zHKv0jrk75sbWHDEIP+NJL33s1WlCldrKwD?=
 =?us-ascii?Q?/xDxi9OXQbhp17OTGZceCFpQBGN5nwj9g0kWY7PnEJQYLRuE+HlK8zgHeKre?=
 =?us-ascii?Q?Q4MLBN1dZu6I3nomnkXiPZyeuJKVmYcah0UwDx58NIiI5TpU74UDYTjvGS+A?=
 =?us-ascii?Q?oWGFz+6Hzg5OWNO/VJK1JbhWlgun7Zw2CP5n5CYuGEmOhIWUBhSHRQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jYFjUiH9XHjzs3DMgp7rzhtqFl8HXFW9K0oVkyFWoiYL3/kALJlENOKv0ggz?=
 =?us-ascii?Q?TDQ9CmdEcC9njeRbLj8IXE7Njb2QMzayZFjybbr/VMZF/2pjhI4yC7BBOu4c?=
 =?us-ascii?Q?ptFPAaxiu27jlbmkPSiL0ikgw5v/Q2imXpMwgTZF23iQ1KckPyS+PRIFwOy0?=
 =?us-ascii?Q?7HAsxKnwb9wCGo31G1ScBzUf6bkUzok3o51lNKtnpWC501p8KJb8TkmUQUlH?=
 =?us-ascii?Q?UDrtbJSk7gtbshyvnuD/AS90h2S55T05Beh31fIDv/Y3Xv53/m6Ru9oeINhx?=
 =?us-ascii?Q?863MMBvdModl5KlBBcBe873kR2iqtb9kFUMX8rc49fousEPz77xgRzwQUtWm?=
 =?us-ascii?Q?Pz9xcGpvgDTuNQu9H/lAw4Nkj8cQ1t3JmyqEJ1GgDdtKGUMhJiwRPgp4ON1H?=
 =?us-ascii?Q?URPbjCPbvl6YLGoU9DEVnQ/omRJ5i6oc2SsKMcHUIXfo3lJ+yVihrsPzBTQI?=
 =?us-ascii?Q?QYY1IuRoFj2e44P7lyNzGUNko57B1nIphJVK32OIptQSA5N+7+HC/EJpVxjO?=
 =?us-ascii?Q?0ewmoZVFsSZkBp29G8XVA8IUL0xsQi1OTdhCceWcLVhQBHgz56jCXhIl4QV8?=
 =?us-ascii?Q?1aUXGfJozXIjrNvoVYjP473zedggHhxqGEE/5jzR9eEuNag9N19pb7o7bYrc?=
 =?us-ascii?Q?K83o8qX9NmNrOHk/Lchs4tJ7ZuMFfX5qgyS8N+qXeOi54oYemTcXGzR8LrZD?=
 =?us-ascii?Q?7Cha/cVf0WHiHRFMFyv5S+rG8Y0RFXf9/xvZ0EhPmcuFZsKHk+ENjXIPPq1/?=
 =?us-ascii?Q?0xWHgRL7QegPiznoB9KffC4/lhaLDXcD0Pyv5YQgny1//3awpFjiC2oynflR?=
 =?us-ascii?Q?EZBrOK2TEkYnO6oYnk8c3PUlVOpMRtUETdXZcNLAiEIftujKbC4JDGdpjH6A?=
 =?us-ascii?Q?b+coUahA1f+VBIE4d16VMUjWIvCYzOKhHndWt8DL4TpTJ5es/OuLpoG6kWQo?=
 =?us-ascii?Q?SRZiTteGzoyfb+SBM0m6Qep4Pdh+5YMNi0/l0H7Y8jhlBRgF0pRlsUxCesKu?=
 =?us-ascii?Q?RkfCOfZs1F9Y4T02bij4R3AMXFBAfub7fFEgZcOyytOarinRZqSiYLeII76F?=
 =?us-ascii?Q?gtxICPHtS6jjsxTHXkdsQL+LFoGe2H63ctmEqQXGo3gcONv1cIEIeGmJZf0e?=
 =?us-ascii?Q?cvNJw3paOMYUJiaU5huM4htfzXI3vllFiLId5/+hg4crEPI4GbVEC9ItkcQF?=
 =?us-ascii?Q?nV5x5hjGUEnvnorb44NiK+Vy15tQjxHX1rGs2l4zD55lC42Wxg7HOd4KUTXM?=
 =?us-ascii?Q?9gzKaQIhoZZy/Hb+o9ExOANzeS9cqOX10FbKRejTrvwXsfWebpYJwKuutOe5?=
 =?us-ascii?Q?5d5hyV68Nat4afB2v4w91EOYooOdINgfc5oUSCkaNUETd5xobNgLE50SqwKE?=
 =?us-ascii?Q?JMytorJnFulgycW/AXPtsLIt7vXAtAc8DJNF5i+0Sw2ThfxQ+gY3gFQhDn0E?=
 =?us-ascii?Q?q7sOPxcRz9/v+n0+Prv6agsVkUtIhZwuxG0bR+5HI6Ah/US6g8u2FDnZrrM2?=
 =?us-ascii?Q?e7/GhUl6I3AG90yMXP0ncj+P0abmm7YLHkfaNpJmpOoD8s6ZEfxShpVmGEon?=
 =?us-ascii?Q?M977f4az9ignF1cadkU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ccadf9-091c-46bd-28e8-08ddbd41feb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 10:35:30.0187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +glZl41oDM9IpVcRR+uXVt+M3NcP/X5ca6sBVgXM7iX4fWp1scbg6az5cP5zKVkV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, July 7, 2025 3:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: refine bad page loading when in the same=
 nps
> mode
>
> when loading bad page in the same nps mode, need to set the other fields =
in eeprom
> records manually besides retired_page
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e03550be45b4..e02af20e6204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2861,6 +2861,13 @@ static int
> __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
>                       if (amdgpu_umc_pages_in_a_row(adev, err_data,
>                                       bps[0].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
>                               return -EINVAL;
> +                     for ( i =3D 0; i < adev->umc.retire_unit; i++) {
> +                             err_data->err_addr[i].address =3D bps[0].ad=
dress;
> +                             err_data->err_addr[i].mem_channel =3D
> bps[0].mem_channel;
> +                             err_data->err_addr[i].bank =3D bps[0].bank;
> +                             err_data->err_addr[i].err_type =3D bps[0].e=
rr_type;
> +                             err_data->err_addr[i].mcumc_id =3D bps[0].m=
cumc_id;
> +                     }

[Tao] can we use amdgpu_umc_fill_error_record?

>               } else {
>                       if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_dat=
a))
>                               return -EINVAL;
> @@ -2893,6 +2900,7 @@ static int __amdgpu_ras_convert_rec_from_rom(struct
> amdgpu_device *adev,
>                               enum amdgpu_memory_partition nps)
>  {
>       enum amdgpu_memory_partition save_nps;
> +     int i =3D 0;
>
>       save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
>       bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT); @@ -
> 2901,6 +2909,13 @@ static int __amdgpu_ras_convert_rec_from_rom(struct
> amdgpu_device *adev,
>               if (amdgpu_umc_pages_in_a_row(adev, err_data,
>                               bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
>                       return -EINVAL;
> +             for ( i =3D 0; i < adev->umc.retire_unit; i++) {
> +                     err_data->err_addr[i].address =3D bps->address;
> +                     err_data->err_addr[i].mem_channel =3D bps->mem_chan=
nel;
> +                     err_data->err_addr[i].bank =3D bps->bank;
> +                     err_data->err_addr[i].err_type =3D bps->err_type;
> +                     err_data->err_addr[i].mcumc_id =3D bps->mcumc_id;
> +             }
>       } else {
>               if (bps->address) {
>                       if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
> --
> 2.34.1

