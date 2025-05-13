Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639E0C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 05:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C7B10E0F3;
	Tue, 13 May 2025 05:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4J3TGybf";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B6010E0F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 05:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0+TkCcoVpYN++KWZ6nadqOp7lmgLAH7ricDMJMayjFpKLxm9G0b+HKwYJTy5rZY7dZMdYxIsbl1nQTeQB6w3Rb9raZim/Zkg6dqgiBBEFm/6MEYKqiHbJB0fzs1xKYmIko9x+fxus0ROEqz7wJVf1dKNNsb38+JTuSoxDGLJ3mrQA8BJiaTvRlwUxqnP+AbXMnWPL3czP1UbjsmW0zyyouDvqiMY3MbMJUe4rneo+ONwUh6bMJc58iZ9QblDOoAGpRRY9wbhclJiJfVz3IEvzFWgTmPQJGW5aWDjzm8sT/gaG5T2civ7prRhoYtLMzOfX20rk5Htlc7JVNq9E0pdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWHHiKp9q8Bgt0IkUBTXrtK0kFbOQDcB7VDJC2PD7dU=;
 b=K95X1bHZS9f5Telly915+HYHqlcr3l/FRUqMiTGJP8VQvrkXy0vEdLYN36l7hAycmsFk6Vm+2iL8lMUkwUSBk0IroeO+PXA1J7HEuUZhDnINEGV77J+cO1SP+F74jTHQfWda30eXYQgbZTtvlR6DA1XVunhFmKYIMb7NJ0PakArDzk5NndK8WnV7br8o7pq8494IA+OTeW1Sl/YEshLfMWEEsiqLoR0Gs/Rh5EOJP2GtHSVAq/chPVRJvCt+G1bT7/mzDtHpUdiTqVBZbKbowxbdjlSKPOP7lJWjspoKTpAgCbU/+3hZf7TruhjYQSlQ9XEpTi4NA4i9WPyjXQ+ZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWHHiKp9q8Bgt0IkUBTXrtK0kFbOQDcB7VDJC2PD7dU=;
 b=4J3TGybfIw8lnj3UmWDIg9Occ6Io4wj0XHq3fIVkjY0W5DkYC9+Qnu1hki6TTyh21R3UEc+k5mP0A/rYB0QWIhEIhVZYyTCt9MRzzPWIUO/82gBZMkRo6xbh3V6TcH6x+5dsWvp2Tr8cXfU8rRIaMZ+zPvOzScHwOug0MzT8JSY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 05:30:32 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 05:30:32 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix circular locking in userq creation
Thread-Topic: [PATCH V2] drm/amdgpu: Fix circular locking in userq creation
Thread-Index: AQHbw8V/TjZCkO8yWUK3utr/s9sNpLPQCHDw
Date: Tue, 13 May 2025 05:30:32 +0000
Message-ID: <DS7PR12MB6005126A29659692367C6DC6FB96A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250513051118.112575-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250513051118.112575-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=819d2346-7113-4259-806f-67af90259678;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-13T05:29:39Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB8825:EE_
x-ms-office365-filtering-correlation-id: c2275355-9c69-47a1-b816-08dd91df4793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PGU1RQWpPmyacVYyiD6Y+mzsh0sl1BChg9/tdYbtITNngIoBH2Tq0xo4XeE2?=
 =?us-ascii?Q?F8t49hDSif4icjG06Na3jkVWcj1sLMiffc8Tkx/jBP0ZiGf3zsj++lW8AAPj?=
 =?us-ascii?Q?ruL4fEX4scpzs1S28o3OdnBmHpEYzBcZkgSQ8ivd0Cs33ilpgzSfaZYPS2cS?=
 =?us-ascii?Q?KHoCJKrhtmcX1RWNHIn56UeFCtladPzelO3m6TWbm+BuioMfOFLi3se/VQ9M?=
 =?us-ascii?Q?17O8v2XinL/Q0v7UE5kTUEsfuPkb1VUnD8405giqoU1jxh7cHn752IRoHOqD?=
 =?us-ascii?Q?hwbS8ctV5PrkCjKyp7Rl6CUsQXiBuIoqVrx3sueT7C1RcNNgTNTKb/QoCIHl?=
 =?us-ascii?Q?9lSdjOv7reuV7syGhzHqp/lSppjMSOEobePCR1PMifC1J3T54AHfes+WsLQs?=
 =?us-ascii?Q?5/Qc0rUMuuK08Xrc2LQ64NPTcgiJSfi3g6HH53VWckyEarpwy9YxdHs8bqm0?=
 =?us-ascii?Q?RtivSDFlPYS8zjkioX6lWCiOEYG/Y/g363xc6doqpHFBL38DoYdOXcP2VETE?=
 =?us-ascii?Q?gniAYXyhM4U4I9RrEa9nq5X733LrS7l6G6K2EGKKDDUKvH/Hrko/lduGmNoa?=
 =?us-ascii?Q?7qQaBf2SobdzvCihrBwDReKhxu6NrSr1YvYy5pfUcac6zCvHHrJKFzWPfLqr?=
 =?us-ascii?Q?R9Tyhz9ItYvXI1S20BI/0FsdG9/gdiNWj9YjNqCqYoCbV/Veh/NGp5tfzD8X?=
 =?us-ascii?Q?mg4KoDaY3HlQqui5noHVBnjHouQ23dUbYoZHDp/4C2SB2bKM7hKqDya2kio/?=
 =?us-ascii?Q?NfGYTf+ID8hE8vZhH0RCtAE3cUkEWoIhCYlzwfacClj1OUHKGUpoNG2McdlL?=
 =?us-ascii?Q?jv5Jf0w/g/7kh7OwnipFOVV1kcqcOoVEeMKZ7HbVVE1V94UNM3vS9M4fNV5E?=
 =?us-ascii?Q?wS0ROt+F0IEDaHNhT/fls5ft9T2rBwsrvceh0A6i+wv6lDN3TdoWDDvbUfnH?=
 =?us-ascii?Q?Fat3QVJiGxC0IrVvHDPAfLNLjTEpPNUvuUrKNLHLeLAGdhWv3GLhK0Hp7/Dp?=
 =?us-ascii?Q?bMX0cj/0CPsfQWzci19ZUWQ6gDFLyl3UAOukA52vKO0rKwbiuDXMNeWGl35p?=
 =?us-ascii?Q?BqopaRvUq74WQ/Eag/HJxk9iLsETU2aFay5xREoSrGyioq0OcwmGW5uZMbUR?=
 =?us-ascii?Q?hgdvm8gaAevQHGEwuYYGlklDsmi1hOmfM2xd9EssOqclsPeO75y2Uzr4LIor?=
 =?us-ascii?Q?sTH2neZdgmyrcV0UccD3KL/Gfqug9Bqqa/aHTfscyYpcCvKT6LL5MrkJeSss?=
 =?us-ascii?Q?QYs1MBR2jK54q0qIlRaf3fzx8C/dyu0w86R3b/5kkgPQvjJjTrOJmtn8fRgE?=
 =?us-ascii?Q?2dEuFMov6FLJW4P4OtGUaFcIOu+orXYL9+hQzPr/pmjm85Fwg4vUAigxdq54?=
 =?us-ascii?Q?ncyj+gvDODvxHvL464LozKllaRwu++KPXK9UEftJoeoY9sQQnjOx/kx+4/yN?=
 =?us-ascii?Q?FvG4dWEGjbiOCuEVfPH73YiTcJMHa2wHU4IVEpJeF4/v4OR/2QFUHCz42Z4I?=
 =?us-ascii?Q?g+ULlHnKHM+pYz4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QHPdAXiPk6zHSNuh6fDVVUbAcl7qW4qZDJxygGifUmyqgcozIa3EHkxVdgEG?=
 =?us-ascii?Q?mwlnBHY6qIxu7vVxhRkh3dM9hYCp3BoPca1nq15/jhg3YhfUxHjBj1MDzmpx?=
 =?us-ascii?Q?heVbcsTgm6Tj/m1Pnwm7e+2IEMGKQUogSW90UzIl+TsnnJojcgoCCytwRyXP?=
 =?us-ascii?Q?iIvLI5CC1SpxY4H670FcIVpsGoetbtOy0fp8NzOSZx7Q2Bd3eY3KdvzUGYGH?=
 =?us-ascii?Q?zezNXdiuMXXQTitXSFzsbx88l3dbm5J2NyCSUJmXvE3XdtrGanuSRRIrVL3O?=
 =?us-ascii?Q?dOMqxuo900dqxmtEcupisH4acYo/TyZjtsC9YmZ4sItcGmA13aV2FNlG3q8d?=
 =?us-ascii?Q?rqmz4Y4cUIlueXc77zmQmUDMFhjNYmEzh2WdaZJiZ8nxGHym3rNYt1EnlkMj?=
 =?us-ascii?Q?PtlSc8reSQG9u4Zpi2RpernE0GbCi6kgld3J9DB26NKsN6shKD77JNoefOyT?=
 =?us-ascii?Q?8qPEhWfk2QNOHfXV1HxCEpLJ6hYXt9YpbcjNoE9TU3Hp2SjN4q3Np+KPU5nJ?=
 =?us-ascii?Q?bV+WPu0QF1P6MgkiQ0toy0unk+0cGDsZNqcneRuVxtMfJO8b4P4uxLPETqH0?=
 =?us-ascii?Q?FCtxQr8KrQ10nZL6N9b3GPYWuwThYFE/gnpm485YX74Rmx3pmWJ+9P9sYTs/?=
 =?us-ascii?Q?xcSHZ/n1bj6qT0Bq5HsxWXCACIdz/r0FfgML3yhCDYQ8ElK1nIbjmRLb4c8Z?=
 =?us-ascii?Q?qsurZhygmIOb0h7XvxpBeWVk7Sp+rlIFRuu1rXNTtKsJC/SZ458pSfzF7d+4?=
 =?us-ascii?Q?fzM8GO3SlF18QtrVLgaKfjyXCvC3bdIxGKvc0vYYHbjhYoLEtKPzNX+VJ9Kc?=
 =?us-ascii?Q?QTfVvaOdEnmTeTVeko9OXKvnBJOuoZpnJVUzr7ElDbRY5BJ1BfV54HSR+tob?=
 =?us-ascii?Q?872XvXjcTHNSiGRFAOs2X5WhpylEf7DjV0Rb667XdwRElk8hHNKxZ6kYVS7/?=
 =?us-ascii?Q?rUj160Ya/oISGI6TOSGXbcZvFbdoFfGuHPiag4HTiRMmPc67eIC5X9f86D33?=
 =?us-ascii?Q?H0/UVUhla8vOLoiDR9yG/tsa0W89iBexRNtCehz7htGmRK5Vauv7QL6btun6?=
 =?us-ascii?Q?ILQe89gjC1Irfwt595twhbKt40gVjUiklwrJQwIueeoTw0QVq9cJ/3zHiPt1?=
 =?us-ascii?Q?133Qx+nGoSc19xgW/J4GXu0VVHWqw3tXIewrronV2YsSH7iAvU8Cjbn2qieG?=
 =?us-ascii?Q?qmNQIGUjwu7NSH/9py1ZPU+zTwEZG3vxLAX+IS+FPdwh+W+J3j0ZSeZ0lA9h?=
 =?us-ascii?Q?yM/MvHfqzXnClXwK+h67votNdo/Ff/+LTl/wFXuIqJ3OlTVwQ///e1nht0XB?=
 =?us-ascii?Q?K5JXw2oBEKNfhlSrZJKCUdx+xTluXZBIno5kHw4Iy8QwXzZtNTHBIWRFLwWO?=
 =?us-ascii?Q?CjmMWhTHRo+1tLh3ecLBlcBmmT02z4kyIc64tDRxtfpvEDGLhZZSiR2F0+sE?=
 =?us-ascii?Q?GkMEV0sv76xhMQ+cdLER/XAPqXtsDJFsMp7FA/pvydr8PKxixhtFWTSHk4k3?=
 =?us-ascii?Q?glPZ0YKIfBx8bn3BQ2ihQofadBsYBV47EIa7sdit1r6P2p/+Yq88+vqRVr2h?=
 =?us-ascii?Q?iBAEGs9Gmhg8Xu9OCa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2275355-9c69-47a1-b816-08dd91df4793
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 05:30:32.0458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8WVS+vRTyGHtwMDFnGWcfN3ifbcp4ZCVBaq1/Po9cPcwAIMNQS5dXVzDsRj7Ezi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.Zhang
> Sent: Tuesday, May 13, 2025 1:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V2] drm/amdgpu: Fix circular locking in userq creation
>
> A circular locking dependency was detected between the global `adev-
> >userq_mutex` and per-file `userq_mgr->userq_mutex` when creating user
> queues. The issue occurs because:
>
> 1. `amdgpu_userq_suspend()` and `amdgpu_userq_resume` take `adev-
> >userq_mutex` first, then
>    `userq_mgr->userq_mutex`
> 2. While `amdgpu_userq_create()` takes them in reverse order
>
> This patch resolves the issue by:
> 1. Moving the `adev->userq_mutex` lock earlier in `amdgpu_userq_create()`
>    to cover the `amdgpu_userq_ensure_ev_fence()` call 2. Releasing it aft=
er we're
> done with both queue creation and the
>    scheduling halt check
>
> v2: remove unused adev->userq_mutex lock (Prike)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 697dd3cbd114..2ee63b33724d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -531,6 +531,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>        *
>        * This will also make sure we have a valid eviction fence ready to=
 be used.
>        */
> +     mutex_lock(&adev->userq_mutex);
>       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>
>       uq_funcs =3D adev->userq_funcs[args->in.ip_type];
> @@ -594,7 +595,6 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       }
>
>       /* don't map the queue if scheduling is halted */
> -     mutex_lock(&adev->userq_mutex);
>       if (adev->userq_halt_for_enforce_isolation &&
>           ((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE))) @@ -604,7
> +604,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_use=
rq
> *args)
>       if (!skip_map_queue) {
>               r =3D amdgpu_userq_map_helper(uq_mgr, queue);
>               if (r) {
> -                     mutex_unlock(&adev->userq_mutex);
>                       drm_file_err(uq_mgr->file, "Failed to map Queue\n")=
;
>                       idr_remove(&uq_mgr->userq_idr, qid);
>                       amdgpu_userq_fence_driver_free(queue);
> @@ -613,13 +612,13 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>                       goto unlock;
>               }
>       }
> -     mutex_unlock(&adev->userq_mutex);
>
>
>       args->out.queue_id =3D qid;
>
>  unlock:
>       mutex_unlock(&uq_mgr->userq_mutex);
> +     mutex_unlock(&adev->userq_mutex);
>
>       return r;
>  }
> --
> 2.49.0

