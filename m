Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA116C3DA64
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3A810E398;
	Tue,  6 Aug 2024 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LxUmIkth";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F52610E393
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 14:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpo/J9chGAIqIsweQeZyJPBb8wmFmji6LfrE2sk4PTGxl1HYQvFr03i1BaPdcskr2ffBCw3bhLVkcZq4gMpKk8PhSUZhCk6R45l175lAjNoD/Ax9AeTlvtbvKtyHllV5+7ejRzgVgSa2YkwoJpaDwA1JDzzKs8Bscb9zZoELotVihhhbqrvbVDY9T4frlb382vqx7lHhadABOtLWgQ+aTS6KNQjkt4DCmdXtXdK/VeRCBVz9L4Wo+YvPtZPCZLKmIlQUxamB96RveeYv/YHn3vMrUf21XrRwOJHlbtlfN8wETelq6XVZ/X7/O0fwPYcxGW5j2dt/m3yChFUxc0L/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72NdjHOje1eKIIwpXSzlHbfK3M+g9i5t+t+tFd4WGv8=;
 b=W1zJWYonIu4cAi7Ab5LNXea6aP2TKEJrhMc8A6ucgda2sn5xicF75myZDzPaUwX/f66KjsIT3ovgNLWMuOO7ZcsCxviwTtzS9mnQscqfrJa4ZG9hQYGTMXej6YJxoBX8JjBPtWqGvYQNmDuROimoWEt9x5KHAXJExW2WjyquRdSZllFX1uN9MQVuC1azkpvTCNVbivJDrP8K0D2Cwpk4xp2BNvA/KQWYiQFvIVmpvtwU175p+B0nRriJvS0wb0wQmmgw+/nPdH1L0tDrIEt053iYpPHRQiVaX18bZbouKGdOmPqUVCFxMhGkABA70TL/0nz3IZkoavl6bdJXEXrTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72NdjHOje1eKIIwpXSzlHbfK3M+g9i5t+t+tFd4WGv8=;
 b=LxUmIkthmqHcRCklCgMu+UP+unCotzytyYvYBhw1IzAC1jQ+xjEdAZi2iI1fVc6/Rmb+H/jqs844PH+h9ELAoBg8061zz3R+SNf89leJybXHq50i3EWmsl1XM4LjHvnnMlhGeGsVaFho2qf5fEyDMLeynFRXQB94JLvLKFTsRJQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:34:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:34:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "ckoenig.leichtzumerken@gmail.com"
 <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
Thread-Topic: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
Thread-Index: AQHa3NpFcTUhVyqj/U2XlpqH6uP8/7IaYY3Q
Date: Tue, 6 Aug 2024 14:34:08 +0000
Message-ID: <BL1PR12MB514460C71C2B804E7E24DF3DF7BF2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240723082737.2359410-1-Jack.Xiao@amd.com>
In-Reply-To: <20240723082737.2359410-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c3fe5217-115b-4623-9105-85f588fa8e02;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-06T14:33:46Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB7548:EE_
x-ms-office365-filtering-correlation-id: 3ad6b26d-8578-4349-71ed-08dcb624d528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NVgiu5UVppBX2qWvvqeNY+CwmyUf4FQJgBpPqWn5yymvj8R090NydWuNdNLW?=
 =?us-ascii?Q?r24j55lJJg+7WjpOt1tpt32aSfYozl6vgVIoX+hWBjI/DunagGHDULNdq44h?=
 =?us-ascii?Q?fw2MwA+Kc2erEaRMZ3Z9297N8xEOjo3HRr38QFKWAP9UISX501RNyMZGwNKi?=
 =?us-ascii?Q?Pphdl2aqBTYAzM4dwhNYIQuac6rmxtukI+uArk4hvxtNzyapVC+sFCn0wgHa?=
 =?us-ascii?Q?mA2srOutFgNZ+2a2UggC9YqR/K6WraPQaX5DWXzG0GvHu5QaIRS1BRXhaNGT?=
 =?us-ascii?Q?yrpv+WwCPvf1+I4OOv3xhVfAZy4HNj86JfgPQ5i+n7rzYOBdfHw5AVQdjslK?=
 =?us-ascii?Q?T5bI+ZkRPJoJBIeTXtOfJsOtOfLlS+6My5stBQ5xKrPvL3wuaOysOuRrrggj?=
 =?us-ascii?Q?po3TLq9XoVhMhJ7m2OYDX/V0wKa6DxjPXku3M7TuXOACHQL2lnVeIkmlZEkh?=
 =?us-ascii?Q?CGaL8zp1CHJ15EFnuBp/gewxuq6ghlnwX2etCtY3Mdck4etCYceBIsXy5ajL?=
 =?us-ascii?Q?Wi5IDTTJIrM1OeCpBSnpcZEH5XXsGvaSHqpyiINPcThAgtjBcqUSjVJwC6DO?=
 =?us-ascii?Q?/g+cVxQJQ8nw7f5OHlp9aCKBrf+C87EiiaN/6RhTS3PX1NxWg3CxVIhT0cdP?=
 =?us-ascii?Q?Ht58lMknDF0ViZdKvD72Qan+cR2aA/aP76Cuj5YgtZKiql0H+hF7fnP2Wjy8?=
 =?us-ascii?Q?NFttdle99f10BdGHwzIY0kfZI2Z0Y39kqQkAunRg6Jxte5Bf+CDMLa4fyoXo?=
 =?us-ascii?Q?ckgA0VW9Z1LGL0yBAprDliXGhMU6SFLjoRwlHGrqM3qNVbQg3qLMCeKo6XTX?=
 =?us-ascii?Q?/ozgialuDA+lCwW0SRP1xVoFifqzMV64yAeDUsNvpWy4T2C0uu8fzw3XFezP?=
 =?us-ascii?Q?wGVrXT/gpUuA+9fFklr1tfAukrGttY1qBdkUnvSXwoDMRYM88tNBTYEivd9S?=
 =?us-ascii?Q?zNpiVeQD6RPDMSsXMz7f4V1kWcbPGjiZg6PUdjoH829420LvX2LwOgnmrB5d?=
 =?us-ascii?Q?Dc4mXGsb69mRAhG5r/9MSPcZ8497ay6/XcYRoXGWS0rtw7yNHunbIXK89sqr?=
 =?us-ascii?Q?R9Kwr09J+EHpmCLKYEdQaWTqhHdHmkbbV16UxloFQczas/pio+QhdYcUuMyQ?=
 =?us-ascii?Q?YCp5cLCh+1YEKXgmRWhmPdq6MiK0JS/GIkIC3+2yf+imj4MIPU7jBRhLrE7c?=
 =?us-ascii?Q?GZD0OmTYK1ruBANjQvyEM6HaP4eBqyCYdrZifeY3XHRqZUbZ+rSafKVzQqH3?=
 =?us-ascii?Q?INut4lYlHVTazFxJVcLtdTZJZGHV2ePpXSqTPT9NhwhYt6E4z5zKzMI3v+cu?=
 =?us-ascii?Q?PnzZpifXZrj52NbAxHnyW+Ob1F3zPM/8acvz39l5vretdUKqKtE3AhcCOB0F?=
 =?us-ascii?Q?EOs8tEW65IcK1DbIu8lfDsJJDM9iYe/wA4z8EWxXKgEpBuaqxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3OJpHr7uZLAFrXQ01ws4f2mHnZGfJMqtgpIT8dRkHh4S9oKgdKd+LnDEu+KF?=
 =?us-ascii?Q?kV9ZgCr9o7nDEc2poosjmPFgTBPvHFSZyEKrd6FskCXFva9r92c8nh4SW1R/?=
 =?us-ascii?Q?XfDpopiaEPuVPomzOETjlhRlC4IgVu8YvWzncd6VzMAehJeFHINrE2NClTLP?=
 =?us-ascii?Q?3DHTAcriPBImd6wmfW8D+bLMc7dLxXqYKzSaV9GEWTL/Xxi3sleEBsp5BGid?=
 =?us-ascii?Q?Wjj2pJEAVkHblxurq2v/oNOPXzCztXAfI+YMk7U5eHkXVJqKrQMlmJW4dnzR?=
 =?us-ascii?Q?csFziAu2IkWHYtOvc4WAIu5YdRA7fGthvmmox6nhpMWV6VpCex9cv9TzVmTE?=
 =?us-ascii?Q?YfLB1gcI/6EBurrjGmGptHWKlACoCOxwN7LY036c7gq4v6z0648rrSe62eUT?=
 =?us-ascii?Q?HrCSw2z/ZpFSyOWtJpUQFZuZqHYapdl6VWZRBgBaR7RbLhFpjKYoR/qK4C1V?=
 =?us-ascii?Q?v+6aBJiJnimlwFs5rq2hqVafdLsyt5dAlokRB4sIwSzUemCCz0EF8y8/N4Rc?=
 =?us-ascii?Q?POyN5neUaMKcKQM0Bze0AMTsEhttdxR0jDFWF2fdk/NJJMc0mgThZ9HvX0C+?=
 =?us-ascii?Q?kv6Vyx3dEg7BZ67tXZRjDsOlMszannX93L0cucrRkofJfKSXmnxMWE70mFFY?=
 =?us-ascii?Q?zCg9W2kzxUJkrbH0iwZodAlIATe33/BcjWr81FM1y7ce/loG8ggqELEdlc1E?=
 =?us-ascii?Q?ez5c2aq3+Zi+COeoDTzo3q2L/cnJbz683H9Zwy4y5JZTDISJYWcgS3i5CxBr?=
 =?us-ascii?Q?F93xRngc86TRHo8hH5R0aT1y5aXi7uMqeo65fMKdCcR6qv7flb5MI2QRnJlv?=
 =?us-ascii?Q?qLlgoEoTpkCzx4hm1O94/EK4KD26WKRBRIGkVTIsp7n1cv6zt1iDjWQ6Q+z2?=
 =?us-ascii?Q?wTx5/hccrpEav+ocigpEImTt1g625rVw5R0rMwXwoKAAY0vrUq7OxZQrmdeW?=
 =?us-ascii?Q?QHIt6ZT/MFiIOePDunSHsT89Bs0THoSgDCwPxkLILhwmq2zo8CEIMqB1raA2?=
 =?us-ascii?Q?mejRnYm2YBfHFcREkSkEkC6V8YMrfIgY2Cn/Gd9NTt+QTX9or6QBMgJLoVPx?=
 =?us-ascii?Q?elsb0VR3N/mYES8lDAesmm35gPy96eMfvzujwcG5E69SyE+Jb4tqNZeJRqiT?=
 =?us-ascii?Q?1NRExciOYiQ1cfL533Vo2EDzvjt5dQIrYc1h6CS09HWzMHpes8xmSTMjyEgS?=
 =?us-ascii?Q?3xZgRlQ9yQsTccTlyRwvsCnIF7y32aBNbgoyL/lkTkZpZSMv+wLsgB6wiQVX?=
 =?us-ascii?Q?uVMo/Z6M+ZmbW5KUSFehFtNfmkOQEOlyJPTabI85CWAM4K+Ci2M1Q/nrrZ7P?=
 =?us-ascii?Q?ABvSfaBV+rNV7DoKJNKeVVi8LnouU6oEBKCzLQP0LSW3QuzOX4ZGxquZ4vbF?=
 =?us-ascii?Q?OKwSAFY+5eQcaabGYLruK+LYuBtY+HH361Lf6mO1jXP1GJPGk6oZq1sbk+Ib?=
 =?us-ascii?Q?RwPekFhwXHb3faB6aP+WwBnC3kAFSvYATzfX3ZTyFHZQHnhPy1P9lkmaCOJ7?=
 =?us-ascii?Q?95JUwSFZi4bxYkoGnuQyRehg9Bf9K/7LqCpyBRJBHy4fz9Qe1WNaSYWkagVV?=
 =?us-ascii?Q?00wAADt4d+e3O/moCAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad6b26d-8578-4349-71ed-08dcb624d528
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 14:34:09.0691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wia9ZcVmlNoBqjdEulFtbCMNOU1u6ZmKBIeFXk6KJ5Gj6VqXqtezUQoQQ+96sWaOx6dbFcQQanUIeX9dFJqwDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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
> From: Xiao, Jack <Jack.Xiao@amd.com>
> Sent: Tuesday, July 23, 2024 4:28 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; ckoenig.leichtzumerken@gmail.com
> Cc: Xiao, Jack <Jack.Xiao@amd.com>
> Subject: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
>
> Only allow API_NUMBER_OF_COMMAND_MAX packet in mes ring buffer,
> refine the code for maximum packet execution.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Any updates on this patch?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ad49cecb20b8..dfe487521a4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev,
> struct amdgpu_ring *ring,
>        */
>       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
>               sched_hw_submission =3D max(sched_hw_submission, 256);
> +     else if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_MES)
> +             sched_hw_submission =3D 32;
>       else if (ring =3D=3D &adev->sdma.instance[0].page)
>               sched_hw_submission =3D 256;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 68c74adf79f1..951f13e01ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -198,7 +198,7 @@ static int
> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>
>       seq =3D ++ring->fence_drv.sync_seq;
>       r =3D amdgpu_fence_wait_polling(ring,
> -                                   seq - ring->fence_drv.num_fences_mask=
,
> +                                   seq -
> (API_NUMBER_OF_COMMAND_MAX/2 - 1),
>                                     timeout);
>       if (r < 1)
>               goto error_undo;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 48e01206bcc4..dc65f28d1795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -184,7 +184,7 @@ static int
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>
>       seq =3D ++ring->fence_drv.sync_seq;
>       r =3D amdgpu_fence_wait_polling(ring,
> -                                   seq - ring->fence_drv.num_fences_mask=
,
> +                                   seq -
> (API_NUMBER_OF_COMMAND_MAX/2 - 1),
>                                     timeout);
>       if (r < 1)
>               goto error_undo;
> --
> 2.41.0

