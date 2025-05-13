Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B16C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 04:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DD910E4EB;
	Tue, 13 May 2025 04:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txdBika5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7D810E4EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 04:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNzyBPUy36EQs7QQI3H9zU6CDcpw1k+B5S1y4Q6/otbUvv5WwSUir5RHj6w8akqcDtADNxXxz/4QrovVcJN/BYt8107Yz337do6gf3r189O0HKR9RqhXIMqW9G2F138hValqswBiHcK5b7kjZr8ILqDkvFJfcSZeYzrqPOzQYRgSS7BMMQMz4jp7K0Qw9hXG4LMxoAIF1mM9TbyBijTYLx2lJeUytkbxD48hAQ6sLG7xFcD8+rsjMsiPEwPN/gHtc4+yOXY1EKtOGmz//8l5rrrAX+V0Wx1sl9S310mvIIPqyg4Ey3r1AvO6h9NLvk/27KZXPLzbyqkJM0cNKNI/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcF78wVnKIOwaMPz7MqA3YHECIb4SRyULAeLNzFEIhE=;
 b=yKliCC1/HpspdZREnrWRvQ5J5dPIwj1SlZTIkwlv4LG5w1jEKUz/Orj/Am+J+2yjot8XfwJopnD6x4oNIhDI3a+1CS2R2vNNC9j3tzLELz5ixBL2N4ZMexZ0j1KT05qLTFa9EE5s3IXtpCf/28LC0gtgHvwd7ctQRUt1bULfR7EqbAWIqnk8Gty1gJAduYliSD2cBvSOCJBmb3Wfg6JGJtyc6O8heFpNDtFcJtVDZLcAY1o4aEpzvR0M3/IDX+l64jzL32VApjjKyQI6p1mUR9USz6aBT5ZFR6VqHE4ZpYhIyV4ZPNbpBb1HIHX28/r0rtWM/rmJUnTlee/FWNB2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcF78wVnKIOwaMPz7MqA3YHECIb4SRyULAeLNzFEIhE=;
 b=txdBika5XEREeoTR1T8mbl9CT6nSHaFP/D9KLQqWnUpV6lYbw+q8eqPzRk1MRHpfg6LFcmq3BbSxIEzYH9NkiwOlcnLxkJJosB7L/qvktDfN0fqhRiiRTLM/zCZJj2/Ky6WxwN06ZqB+dbss64tc92GbJ+Te42JNoCN1m/Gkiuo=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 04:49:18 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 04:49:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix circular locking in userq creation
Thread-Topic: [PATCH] drm/amdgpu: Fix circular locking in userq creation
Thread-Index: AQHbw65ceQsbRDXXV0G442p4/2rzx7PP/AgQ
Date: Tue, 13 May 2025 04:49:18 +0000
Message-ID: <DS7PR12MB60058D6446185C2E73C71659FB96A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250513022542.97292-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250513022542.97292-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d5a54b7b-425f-4d9c-a6d3-5d75f195ef3b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-13T04:44:46Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB5615:EE_
x-ms-office365-filtering-correlation-id: 27be040c-a9c3-401a-1959-08dd91d98512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Rm0c9yPuDthUGdo5sXeWYTWhY8M9TA1W3RJbcQlUYsHFlbz98ke0q3t5p4gg?=
 =?us-ascii?Q?psQn9zL31Klqigi8UZeDTxhIPJCCUHIdmKmSfKTroVaVLauBwyaa7eDga35A?=
 =?us-ascii?Q?VpgoFlQUEC4wcaDQIM+zFeV+l2OX7WWHU72J2CO+Hh4WE3HA2YgCbznMx5hD?=
 =?us-ascii?Q?qaBnXgFVM8e2x7W4Hisg6sam7cDINVrQjhWwMlSB0jDE12eE/z8OAVRKaYWG?=
 =?us-ascii?Q?0n4gCAbvGu0BQ1FC5pYjs5EPVOeksZLOvEV4K9buwdpryKXIltvY3Da7bMHM?=
 =?us-ascii?Q?IdGQDM5WR0CrIAN7JkTLdfrwwoHrf8S4rx7JLfTF5q07Xflo5ea/bR9M1uR/?=
 =?us-ascii?Q?BNUzaz8B3Pecn0Gs7JhyYqhFSaunJCTVqXYtMbIztUDctYPaZsw05yl7kw6L?=
 =?us-ascii?Q?1UTIaokKyf+rDQ+1z5QZe/+rEjI+MrMbIhZeVFQRgI/KG36xZ1dBwu1vGaJk?=
 =?us-ascii?Q?rBihvEL2fiDDSmJ49woLh/GqglmqKAAVyzDgFb0opmRpPE2nwoiZvacKIiwp?=
 =?us-ascii?Q?czEB1vREE91GoyidLYQmaE0keuwhBshTnAzdn9A+G7OE/vnMd/p8S5e/UT4i?=
 =?us-ascii?Q?8+p41eSVCFcNVkewetjaxRoLWUBHdkngZ7942eNggzf51pzUFFcMPAYN2sCn?=
 =?us-ascii?Q?bQoiRnXgeGBR2iwQTGSoaNyPESDOzb/6YnFsWABk70pqj92MzG7mJ26Hcx2C?=
 =?us-ascii?Q?zXRB8Mx2K1IoJHxCKUVogDf+TXwXKYYo7B1j/m7VJue5iZxPTxdG8fCd6YNc?=
 =?us-ascii?Q?fv3CAm37svBG+nM6txp/h8UkQvr824tCAPnxu4JwnQ6VZs5rT486ku1UsXjv?=
 =?us-ascii?Q?giiAY6ZW9WzWR6bkkfiZYF6qjb2oK9eXYNmAZw4lJTM/wR9XIITe6KG5AtyG?=
 =?us-ascii?Q?xlLq2OXXY261e95Cj/Lj2cFn4ccErJEtV5JF05DPPnPZb3KuNEcBZ9ovmiKi?=
 =?us-ascii?Q?UFqAaR9fwCSCE2ZnM/bl0/Ts8iQQZCQ/03sLxAyDyKR7Ns5gyFICACZDocIx?=
 =?us-ascii?Q?AJzQSoG5uRIDVPnFJqsXSmD3iLl5Z7T/CdzplA8lSNkx3dfTVe1zPeRk7TF8?=
 =?us-ascii?Q?iVI68o0CGhiO5cQub1qQ24QmfvaIMyCQnxOKBa9ZhqGEa3Q68z5PN+L6b05W?=
 =?us-ascii?Q?lzblLf3aeag52NpZdMh4CVAY60C83Y2Bx/L1s7Z9Nhd7QJ9cBX4v3+6TD8K8?=
 =?us-ascii?Q?c8vR798gm9zNjcdkOcWwUnIZZ7M/ZCrNvvGvZ1+/Pbh2rMCEuPCRrT1GisH/?=
 =?us-ascii?Q?WxIgOHzG+GOcn87LP/eNQO5qNwzjbDUxyJ5zACJioNm8wqlKr0nQ6HR6xA7h?=
 =?us-ascii?Q?CtQKVa8PuU2z2Pl6DTJIXKx5+i7seZIgXqcVbQCgcDtYyKmrhFbkvU4hMmIR?=
 =?us-ascii?Q?BUMcvtoT1JW83K67kfdMUwf8zP1rJii5CXGvROr5K5mQURGwPGggCMV8OSDa?=
 =?us-ascii?Q?zGmAEHmBQDIP8ii89asNfS060B8R+E5wvhpvS/bA6WcGosPHEvm6Q/m5SSug?=
 =?us-ascii?Q?pFuxfVPIUgdECTc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mMySrvmy9XTVtoBh/uPvyRCe+63Sgj4FY7dmmX0GUOPjy4obqUxY3C5OSvmQ?=
 =?us-ascii?Q?4cvJosiQZuOog7i0ybftheh5BwCSM9+0MBNq4Bp3PSN/DQpd5q/Q0BPa+Twa?=
 =?us-ascii?Q?RMYI6Vm+uV59fjM929PnIxc0PDM5ZFGqj29AADnk10msqb/WvsMoPqKIDIv0?=
 =?us-ascii?Q?SrBac0wXtOqCzLY565L+xCnl7Hvf3Udy4qdOHEVYu92+SQ2L+MJ85NTMD2yz?=
 =?us-ascii?Q?fLOmdS5GItWo4WsTs9BT2/QFBb6lMf8HurFI1E7JNBfh30eklqYd4aqxmRoG?=
 =?us-ascii?Q?shrwnvIbw7jc21RREsFmcPtDg1xwC2TAtmrloZh9S68eXBHrYAQqEoHb2stv?=
 =?us-ascii?Q?1JwnHdzLR1Kfe+tsea0JwMLgKcwY8Le/Pa6zbPkvU/kSWY+dVL/YHIcmYZqT?=
 =?us-ascii?Q?YCx8Gg8bv+549S7LVuvLrUJIlR0HxqNuMntiXwjv7UKiSfXLQ2Agdg7SzIeM?=
 =?us-ascii?Q?/sMI7ZupvJzgWv/8K268BEZZNKrDGOLLsLOLoufD/EcegU/FyzwWP3oAgpw7?=
 =?us-ascii?Q?7zWt9xVHi5QUpsbxDY5XOghUQ9ULrPaT4yA7RkDbER/2aDXMlwIEAnVPZeOL?=
 =?us-ascii?Q?dtU30RtI0UXLG0NlXUBNZwOC7qur5QXRuSnLv1mYuPnMtekWfXQeMJARK+MA?=
 =?us-ascii?Q?F7wwqQfEJUaEj3/cNogBPlkaC4CN1sIkfjFQbSqNVvPfQ63ikn6hazkiQsuB?=
 =?us-ascii?Q?jwbWcNVOgMq9GavTCrDMqDSyN9xXGSuURuaBKGG5iW11iL8h2Fbs7ba7ka5M?=
 =?us-ascii?Q?mYnnPRh8OBFNcwUwYyDasybbBcZdvKLFOCAb5XpVuqQoRK4/sKDmn/ZPSNLM?=
 =?us-ascii?Q?fRTHuwbTHtF5Uo/csEzx7NciAj492P5EX9xZU/S5MEInu6Dm/oAxD4ZyoVkt?=
 =?us-ascii?Q?oqgd0XnTLncljUGblqT9lmIFX6A6zXFNh9kRW/5PvnBm+Djhwm110yXNnTpu?=
 =?us-ascii?Q?dCtLM5ExUFIijRwuz5+Oj1wawU5Bum4ufwnNjlC6GfT5bVv4kZGyJvqDHaaI?=
 =?us-ascii?Q?JpQTw0FLO+3IuXn/JuTSgk4Z/ac4TcKjxCrKeUuLXb/xpM7n/MhdG39CE8JI?=
 =?us-ascii?Q?KGHChG2TD4hSsGNifvHfB/L9bRdSfCHrIN254ogX6vr3ZynTUX985brGrmXZ?=
 =?us-ascii?Q?AIbJbmisQQYvSz8Fq8D9+OG0klbHu7nqpdBzJs1gM4wkRoJh2em9kTYDbRDp?=
 =?us-ascii?Q?Yu40KRro6l3MOs6N02GA71M0YEnswQbolWSalgnZ0evSyBcAIDAozCSO1F2q?=
 =?us-ascii?Q?dP7dL1sxUekFdZqJF5mfiIB07zpHIxsnWnthybKU0tYlNF/AbkKyRcn1tFid?=
 =?us-ascii?Q?83amaGBvT0tNXVgJp5o8Vsr68PisSyaxM8M72lOcHlu4DcYLJUM/pxVou6F6?=
 =?us-ascii?Q?E59NDRiumjIhhEuCGsT9RI7fO+FlFJnuWQPk5urSanWKAcrYoFzVFVMSKrSH?=
 =?us-ascii?Q?5jq1IecrcdwgioSE5gkMbTMSc4cUWYahhHxY/ih1lirCJrSdJauI7ogTi6sf?=
 =?us-ascii?Q?ekW1LXEeKvtWiyA6QhXVIsfPjIXcQh9P+beQEV/+lc912ezSVx4DgVnVCWQl?=
 =?us-ascii?Q?v3+2NoZ/fCXktxcWHyg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27be040c-a9c3-401a-1959-08dd91d98512
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 04:49:18.2699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4T9WN3WRMUhP5ebAZtz5vRWZ4pSREBbaIJG1Us98zNfK90reph691ANn9E9OVAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.Zhang
> Sent: Tuesday, May 13, 2025 10:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix circular locking in userq creation
>
> A circular locking dependency was detected between the global `adev-
> >userq_mutex` and per-file `userq_mgr->userq_mutex` when creating user
> queues. The issue occurs because:
>
> 1. `amdgpu_userq_suspend()`and `amdgpu_userq_resume` take `adev-
> >userq_mutex` first, then
>    `userq_mgr->userq_mutex`
> 2. While `amdgpu_userq_create()` takes them in reverse order
>
> This patch resolves the issue by:
> 1. Moving the `adev->userq_mutex` lock earlier in `amdgpu_userq_create()`
>    to cover the `amdgpu_userq_ensure_ev_fence()` call 2. Releasing it aft=
er we're
> done with queue creation 3. Maintaining consistent lock ordering (adev-
> >userq_mutex always before
>    userq_mgr->userq_mutex) in all code paths
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 697dd3cbd114..6ba3c0b14279 100644
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
>            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE))) @@ -613,13
> +613,13 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>                       goto unlock;
>               }
>       }

In the following userq map error handler also needs to remove unlocking use=
rq_mutex as well.

if (!skip_map_queue) {
->>>>>>>->>>>>>>r =3D amdgpu_userq_map_helper(uq_mgr, queue);
->>>>>>>->>>>>>>if (r) {
->>>>>>>->>>>>>>->>>>>>>mutex_unlock(&adev->userq_mutex);
->>>>>>>->>>>>>>->>>>>>>drm_file_err(uq_mgr->file, "Failed to map Queue\n")=
;
->>>>>>>->>>>>>>->>>>>>>idr_remove(&uq_mgr->userq_idr, qid);
->>>>>>>->>>>>>>->>>>>>>amdgpu_userq_fence_driver_free(queue);
->>>>>>>->>>>>>>->>>>>>>uq_funcs->mqd_destroy(uq_mgr, queue);
->>>>>>>->>>>>>>->>>>>>>kfree(queue);
->>>>>>>->>>>>>>->>>>>>>goto unlock;
->>>>>>>->>>>>>>}

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

