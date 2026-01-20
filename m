Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692BED2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0747210E56C;
	Tue, 20 Jan 2026 07:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="45RNHAh/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F0210E13E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdpQwzvQvKNizjMu3bVtReRC66d0ukrz9jX+BVM9U8Da5QjU0vqUFVGHmqRSADD6WndI2GzPM54+439EnAY7UhcMzMrD40j2Lsi3CEJil0QAQq+sX1c+oVEJ1VLxoL66QRJKBIa79nML6hAZmhiX1BLAO/rd9xk65Vca9c8YhnE2qtZM1aZs0lB/24M5w0vDN6k9TsTD8lAbjkWcaAHbjHgZeBEgQdS4rTWpJGwZw2VtfSgE+M/3tVPVnkwfR2uakl7L+yUrowjsOnCKK1rEdL+7umq4gqRzcqs1H1jg2Qg8jGkX9iPHlZyN99EnnKTKp9o+O2Qq1L/I6VHh31uS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA+4slP7wiTqQjdwsW4zF2GeKkiOIYm7UywUi7aImL4=;
 b=OY76wWDfWRCyZO/LgC/cYLWcG/dslV28CDNdqAsbllcxazPm0TLXPYcjsCjH5jo/o8d2+noDHJIsvv9VihrIGlThIRoO91JREQyxzJ24Kb8CewQ+gYqyt9z4w0jPJmta6/SrooHkEIJ2g6FXtaXY8yJtmmt/D/P2vXeSOSQoHSrhjKdTMR/n/929CoWZn4TN1SdqtlsA6oIfHnqPYRNRXl1/WRmwuKGAnjscMowHM1mTLyr4weQc35rTXaq5c+pKrfgeTVlrIx9dbMKSLBfqgi6kaIg6oG93MTjOij7tHetI7LxIAsEJcXvDkOwIn1rNUdnPHt0PNTjwL+o0MN86KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA+4slP7wiTqQjdwsW4zF2GeKkiOIYm7UywUi7aImL4=;
 b=45RNHAh/i6And5FwCsnDLd5mScRY27wB7RcFAYb9rWaHYuywndoNQ2wBKFfPvC4w6WJP3ydCBJSn+OKbUygVXcejw+yZadWy40X5Lllq3EJIOUc/ulCMkCsh58miN58ex1xcgV18GXZoZ9LqiRsGt4CuZRA0L/BwTUeRUm/pxm8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:26:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 07:26:20 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 08/10] drm/amdgpu: simplify VCN reset helper
Thread-Topic: [PATCH 08/10] drm/amdgpu: simplify VCN reset helper
Thread-Index: AQHciazz+rgUqMHrE0SblIgxQKs5XrVaqMVA
Date: Tue, 20 Jan 2026 07:26:20 +0000
Message-ID: <BL1PR12MB5144B649D8E3BD2D85D4568FE389A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
 <20260120013411.15659-9-alexander.deucher@amd.com>
In-Reply-To: <20260120013411.15659-9-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T07:26:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB5737:EE_
x-ms-office365-filtering-correlation-id: 9e589e54-8a30-41d5-9ef7-08de57f53535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nrfv4QU1F5rhY3ymXYLLlnUQk5QG9i9c3qSgWJQDWX/n67HGbKWO0DD3RMfp?=
 =?us-ascii?Q?LN1njVA4ryjZ2Lsg+iAOIBSEwA+VAewsP1HSkbiz5Zy6U3DtQJTA0E94Gpvi?=
 =?us-ascii?Q?vx6XAvx+LAgNq5WjVG/VONtQ/Ix3+FapXN56DtahKTHSMfNOQyaLGSjMfnRq?=
 =?us-ascii?Q?2hElfxY8b1ANqHMwi2pRxVIxWsHggRpbhzNAuRrSjF5zoOUERH3Fb6LZi+V1?=
 =?us-ascii?Q?VhlDJwU5AGWZ7s3/BE7EJV3/Q0TYtLaV4lCZ88LnT/t1xLHV5zkVoipYxQ7y?=
 =?us-ascii?Q?13uVfMp84/AgGA02crALniWxJ0/Qz2FFf4rOVxOFWIOZ9LJA02sx68GpkTbq?=
 =?us-ascii?Q?m0eemzpS50NlglNDWKdky0s6EmkSwt9IAPk2RQnohTa+bpd0yzDzGsgXAB2H?=
 =?us-ascii?Q?kOqWNAHVLyZ7QFQBHkRN8X9CPZQB1x+4qe+TkhkzNSUgfwY6LEVKKI/nrrLF?=
 =?us-ascii?Q?buj/Z64rfigy6QGjtTZQkjMyeCfqKpET03ogsq773f/poHTGKIv9/7ARZjEE?=
 =?us-ascii?Q?JudivTnzUWh8M+N4SQ9sKPE54eGpGjuxej81vTXxaCSCyGom3QAaSr5I7wDJ?=
 =?us-ascii?Q?ZZjkbD//sz8qa2k7R/mRMe8/a3m85F5RsiRUA0DSaynA71OVN4U4u2GxQrHq?=
 =?us-ascii?Q?raljcyy1Ps+T3uR2t0PXEZm9ZqXKXRzgAo+5d8qjGbEQ4hnH5K760UsUzAjr?=
 =?us-ascii?Q?4K1zEblZx+Aq4qbj7ZRHg2JNupaOJgYHOXWeUqQ5jptf8zLKMaSE7LgPXJ+S?=
 =?us-ascii?Q?yLj8itqOfagfsWyQ9CHFP9/kNzjP+VmCGU7lZC0lGis2uuv1koqgIBpq4sWD?=
 =?us-ascii?Q?AJDNfT9EY4y2cZAF/jRWbAH5z0oaf3YbZhtml6y1KFNaCB2rE4REGUZvvLcY?=
 =?us-ascii?Q?tBYHFLsowjIbl4JtRJjbW70rYooPTwOVX6mO5rfZW7SLzPSw5Wgtnzdqj1du?=
 =?us-ascii?Q?nIZOiWYORd85WfmCgp/CGwnZKqJt2ZEGHbRX35p3rWMEv3Lcz3C0tpOY/taT?=
 =?us-ascii?Q?pcoq7PpleuP0PqTA7A5dG03RAf7+V9UCuK+WXDbbP8FNA8SzeyJqO1nafudV?=
 =?us-ascii?Q?Vbo1DqpzuIKhf6EpQUL9pYM1WrSm1MjxvD+Mq42mf27Q4RCPb355VmZ9S7BO?=
 =?us-ascii?Q?q1IZgloc4LADm+nAz6d24LHkk0otDB7e35WNey1pdof+ME6AzjgfnWX+u4fW?=
 =?us-ascii?Q?kvTA2LRTNj7gS/r9bf6Lh9P+0c9JmtFzU6hmvDtJwKn7DBjWAwQxxnoP2DYN?=
 =?us-ascii?Q?admGZ28ORH1dlanKhc075qsUMFJM8NrI7ct54WHt5YQq47411mqV7/ZSVR1u?=
 =?us-ascii?Q?b9flCflr78WTeBiAmun3yj6TVTSs5seNglSX3tmsP63rk+epIAi6iiOzu1si?=
 =?us-ascii?Q?tCYCyHjGA2dVqL7HSnw3lG+/sN9aWLHg0RFU3D5kuUG+IrAuoMjQw3m8Ho6z?=
 =?us-ascii?Q?kJEwJ7BTLcFROkrCFtgrR53ayUapeZs9UrtwgAqjOSEJq7EVLZLIjn52IC/p?=
 =?us-ascii?Q?3+GDma7iHRyW+kyVxuikHtFVo+BdfKfDsOm5StwUSOyFDO8bL92YUq8Uo9DA?=
 =?us-ascii?Q?Y6No+v6o7WIz0ExmdUo6/9ivRdbXsc6CbYepqLo7xk5l2raBQ2T4UVq/N90X?=
 =?us-ascii?Q?lg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FXOqkS+d+L5thXZ1d95Ls/7Kk0J4VMOYjiuU8Ukhn8SmpZyVHRscs361ftey?=
 =?us-ascii?Q?/rMR1I1dcqmyWAGJAj1R58LfXhXWN7/z4EJi6gNtcyJv60u1NieV/h4R2zDf?=
 =?us-ascii?Q?rhZjOZLIVC4UWhpJJcibVzjlSDJqDCW/CvDoPWHiZLrac5eNMXggg21kuNaC?=
 =?us-ascii?Q?TE1P1ra5SkKI86Mz22IPuCOpGeVk104o5DpYHhbvQ59XvqrnM3IJKp4TME0o?=
 =?us-ascii?Q?NcSU1hx9zggsTqlt+kr/pvrh0/BBP2DI21BhZ5bH8QB3f2E11yYEqKqYMwrE?=
 =?us-ascii?Q?GIVAbWPhpmSTKkFHDSgW0Ccynfukh2Z87FN71eksDfbU1Bkouk6UBp8W3xYB?=
 =?us-ascii?Q?g8rrwlQeQxpflPXC4KRNx7rOUZCNszaOdvSuGrYFrAeLhyJEXX+A5wfOhlPf?=
 =?us-ascii?Q?P/2TJVE12J7A0juIyGNvLv9RoYVrhZL1NcqCuFOwAA3faMPLIDAHaWnKdCyX?=
 =?us-ascii?Q?seFSV3lPFUugjM3+4cRdO7yRLi8BEgDwLmP0gDyHUdkFsS5biC+1iPq63k6K?=
 =?us-ascii?Q?gNfFG+Dcu+pe0EuGUlSenhzuxhepWH7XWSidj8EheC6bKBPUtmTYxUgXvZtX?=
 =?us-ascii?Q?hoCDEjVmAswokd0jKHMGf48f1dho4Q+EoqCIrlO84u4S1yh01/rV1aiJgZqq?=
 =?us-ascii?Q?IUs/5dQckvTbXN7nIciSdoZPTjwuVak49hYn7qdAFy7tNq5tUyFIWOo6nUgx?=
 =?us-ascii?Q?sF0zwkEQ/HYx1MVJpHLdfHz5u9v3ifixYvFC6KW25vrgzqp8SgNvkJTzPZdC?=
 =?us-ascii?Q?ocLLMhhGo/6QBJmVjpAejNAEX5ub5qpp91YNc+FQeLP1qlPCjZ/gMuuMZsyp?=
 =?us-ascii?Q?xk3+/eyXovi3VpOdZ6y8xRH4JjcrPjRyHBQcXA/g1iUuGEjSlUWeDHmP9mQx?=
 =?us-ascii?Q?yo10QcLicgX6I2UM5TfioyRka7NM13bPZzIUjLD27zSu2iJACvarPXEt4C3S?=
 =?us-ascii?Q?khRwAc9tgh6IAZZXxpwcVD8tm4RlgdIshysot0JpSyZM7P7yp+o9dRlt95gy?=
 =?us-ascii?Q?LkOjrjHEega5X6/XPxe7mtgC8kofVNbHf9jNaIJCLB9SrU4I5ggHPj4nVrey?=
 =?us-ascii?Q?4Bh0cA8iW/z9S6TzEtEqYGWv6c21fpWeQ8tewP+OhHDyl7qlGvrfXoe99bkP?=
 =?us-ascii?Q?a429Li05ojjyzkwaF+UTM6UFHuEMrZnr/Qu6udLLKF32SF80XJuOEvE/u1kf?=
 =?us-ascii?Q?Dyq+Z6FE6cNMbwl2oFwjysPqja+3iNj32AFuUbMtfhPXgIiNrhHmYAcGely7?=
 =?us-ascii?Q?EAbSsuU9yutFifYVAiYHOV2+pNrG4qxUmvBzETvfagPWYq0XdpoE8oaDeWyl?=
 =?us-ascii?Q?GyeG3oyJdNFZFG5prmVXkdWdlKXJgqlyoPQDda28bLN3DUscMpyGezAxRu43?=
 =?us-ascii?Q?t561fcBl81ina4gtn9tN/QNr4gTIJDpoVufO9AfgX1MPAPxVwwFVUTeCoj5X?=
 =?us-ascii?Q?OMycURQTieBykFhjeMOdDztpWkZbGo7ZYWdTkwSnIJAV53M1wbHJzvQKLwlA?=
 =?us-ascii?Q?fodKa476Vo7ep34ycOd8jPrufwC7oNOoAKxKdAc5sg2+GbpIlWfxxc0sc1rG?=
 =?us-ascii?Q?BXrsJ1Rpv0JYVnUfh+4JRNG5Fu14e+FLou7RqIvIQ0xeCBqrebaLPZ4yao7Y?=
 =?us-ascii?Q?F//8I+wtHA3ycsDz56l7KvSPfxsE1VlgAOe6Q5pI4gAkOA3ktTEBpj4rof5t?=
 =?us-ascii?Q?vAUnoi+z7KktKJo0CNSIXIuIwaUf+aM0WKah2qkoyD2NzK7F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e589e54-8a30-41d5-9ef7-08de57f53535
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 07:26:20.4234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4urFlvVjoLljHmXWCLk03gC4m0q2CFeci7Ms81qtUdJFIkefOzneRehy6p9CSHx+rISBV0LhY0pzYpKVOAW3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, January 20, 2026 9:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 08/10] drm/amdgpu: simplify VCN reset helper
>
> Remove the wrapper function.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 41 ++++++++-----------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index d22c8980fa42b..4de5c8b9a4cc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1481,19 +1481,27 @@ int vcn_set_powergating_state(struct
> amdgpu_ip_block *ip_block,  }
>
>  /**
> - * amdgpu_vcn_reset_engine - Reset a specific VCN engine
> - * @ring: Pointer to the VCN ring
> - * @timedout_fence: fence that timed out
> + * amdgpu_vcn_ring_reset - Reset a VCN ring
> + * @ring: ring to reset
> + * @vmid: vmid of guilty job
> + * @timedout_fence: fence of timed out job
>   *
> + * This helper is for VCN blocks without unified queues because
> + * resetting the engine resets all queues in that case.  With
> + * unified queues we have one queue per engine.
>   * Returns: 0 on success, or a negative error code on failure.
>   */
> -static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
> -                                struct amdgpu_fence *timedout_fence)
> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
> +                       unsigned int vmid,
> +                       struct amdgpu_fence *timedout_fence)
>  {
>       struct amdgpu_device *adev =3D ring->adev;
>       struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
>       int r, i;
>
> +     if (adev->vcn.inst[ring->me].using_unified_queue)
> +             return -EINVAL;
> +
>       mutex_lock(&vinst->engine_reset_mutex);
>       /* Stop the scheduler's work queue for the dec and enc rings if the=
y are
> running.
>        * This ensures that no new tasks are submitted to the queues while=
 @@ -
> 1537,29 +1545,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring
> *ring,
>       return r;
>  }
>
> -/**
> - * amdgpu_vcn_ring_reset - Reset a VCN ring
> - * @ring: ring to reset
> - * @vmid: vmid of guilty job
> - * @timedout_fence: fence of timed out job
> - *
> - * This helper is for VCN blocks without unified queues because
> - * resetting the engine resets all queues in that case.  With
> - * unified queues we have one queue per engine.
> - * Returns: 0 on success, or a negative error code on failure.
> - */
> -int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
> -                       unsigned int vmid,
> -                       struct amdgpu_fence *timedout_fence)
> -{
> -     struct amdgpu_device *adev =3D ring->adev;
> -
> -     if (adev->vcn.inst[ring->me].using_unified_queue)
> -             return -EINVAL;
> -
> -     return amdgpu_vcn_reset_engine(ring, timedout_fence);
> -}
> -
>  int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
>                            const struct amdgpu_hwip_reg_entry *reg, u32 c=
ount)  {
> --
> 2.52.0

