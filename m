Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A67C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 12:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB3910E4C7;
	Mon, 28 Apr 2025 12:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmbI26qe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B177310E4C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 12:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upCAKGkqpNcLOCzstEm7iumiI/HJ1FohQCR7/A/mraLteQzyp727BFH/nhhIuHx32M4jgl/hsjZ3yMmTYSTK8hR6KxFD7gZIG8ViMsSy3ONN4/phoC+7cBFaVSXJiXZgc/Y8Su5O36BCqrWz+SRoFW9J8AtuHoUZdeSFj4qncOrBpHJYcqGaPt+ZMkcC6k4NLVfnObU8z2M2kAZ+FJy7PJxk4pAJCxM0V9GC9gjoGZ5xG4GdZGmutjetqxiys3RhPUcpIP4uf2rwL0ZVy+UQRniphCkVXnVj4AHnQh9X6iBEe7m8QBBDYI43JHVAYraFPqoDGReUhsv7Lkb4iPclVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4hEtqt6dVY5VWhh9Mj6s57dWFtTLiIdvfLcnCLFTzQ=;
 b=FqrjUcVaIllHDtB6a2ulhSi0lXG3WK33mj0OhJ9cK0qgYIQD1nGaVxpphLKt4Uf/PpUtPcR+InuogKrxurLTWu82XVlBpS9EjXbxNFPfXfhqfr3LRZc+GnxmAS8+TBljeNXYThk3qRm5mdU6dujyz2PMdoYVNpdOz+0ftCDa2WD+YS3kWfSRml3kEwp644kYKWR5PGyaeudokYfVqYh9ITNtKEfXr5PuMi64ckjR4/FpKN1orPoF/QOxvUBfhTcly0UKKV5jVrYShp4Q7SvfWrrosvT1L9ejgF4z2PWv7fHwYOeGNu1Aelblwb6acZZtDp6crJHEWsK+4DLNTdvzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4hEtqt6dVY5VWhh9Mj6s57dWFtTLiIdvfLcnCLFTzQ=;
 b=XmbI26qeZjS7wX+JPDy6HwYBwVdgQfJ9OfQVm2vAobIsy/XeJsNjmW7UnXvLoLzRBNg2JGRG78n7qdm09ru1KU470/lCXOqzo5mPiRmyYeSkRMxOzOQv8CZn0daHfve+rtb8hfN2BQOBcmkJYZ4GowdNLbrVKOHWK7O+xIcVs5o=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 12:58:05 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:58:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Topic: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Index: AQHbthG2PRxrB0f08UWDYNwrBQkKC7O5DWMA
Date: Mon, 28 Apr 2025 12:58:04 +0000
Message-ID: <DS7PR12MB60058897B3E639DCBF78D199FB812@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
 <20250425184125.166270-5-alexander.deucher@amd.com>
In-Reply-To: <20250425184125.166270-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a4fcb48f-f18d-4bbc-82a3-7f368a2dbc97;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-28T12:55:16Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW4PR12MB7437:EE_
x-ms-office365-filtering-correlation-id: ab64f0e1-6935-46f9-0414-08dd865450df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5DSvyZOA6mSwDkpWs9HYSJLVQly57Wm3fVmM4/3pX03zEIymyJ3fLu19gect?=
 =?us-ascii?Q?pz5tFw2fQgKBf1HeiuqhiYUjCHmlxbxkHf1EGVCvvb3eCWJDdkcMUN9nIayl?=
 =?us-ascii?Q?QchtVrSx5ZU65PiSGnocSb23nkINCkwIJKrCbxIlDpwYjK//6pdqqiXZCsu3?=
 =?us-ascii?Q?V/8ZQEto5RA62rxsll7A41mBe0ZF8+Oe7LeauGpiPUGcVNJQX4taGs2cGkip?=
 =?us-ascii?Q?zCY/42SSaO/5zYCSPtEje1dxNYRBrOrEfbciWxmDXJf5dtjp2kRLy9EhNLXi?=
 =?us-ascii?Q?+R9N6Q25oYr1zYcdjwV9V6TzwMrzvEofafZwgGWccms9L3AmeK3Qqdo7gosN?=
 =?us-ascii?Q?+huS8kRSrP+t+9bn/ABqw6UAgZUOzVWMsGbBnYsIXa9zhev3nUCWTPVRXRPv?=
 =?us-ascii?Q?/hQDmB347B1PpP62AYZYXkRasKCI6n8qxZVs+oEKMP90NlkjhJFSip9YxGh2?=
 =?us-ascii?Q?i5mCPq9uRz8ATMYltdbUzJsLttS1X8xQc9GYgYCLNOlqB0+r8c9ZNl3asQXb?=
 =?us-ascii?Q?tItHpeFmVsb6btAwnEkZxdntY40EvvxBEIvlYBQmenuXWZgIm+AVf8eYj4TW?=
 =?us-ascii?Q?eKrzay3AGZpLPP0nnf36K1PoLWXMms9dO+sAOQh6Z+coejj/pHuexzPy0Ml/?=
 =?us-ascii?Q?8YqQZsR9zKGSGCZ+WEXzBIGKrAxAERZePTKxbbIJ3y+SRnAyONvApJR3RgZD?=
 =?us-ascii?Q?javEYdGm16gHXdYGyrNdtAAGS/xKsiAWijLT9OnNdJ0BTph0btwkbkMYd6YN?=
 =?us-ascii?Q?Igqfe556LI4ZihrlrFqYlINF/BcHbL3PQY/V3gJAa18a2OAwVnFVXlANg+t3?=
 =?us-ascii?Q?X934PeknO7jTNAjtIxXOlnemCg1x/n3eI56HjnzeZ/Fgk4p0Bn0DntEW597N?=
 =?us-ascii?Q?lIQb7AYh8d6tIsmZVfHt7qgnrYEpKuIGaOwYmWFxKYGbG4SliWQ61GE4X/Is?=
 =?us-ascii?Q?NHjyCPN1M56T7Md5+KPBaIAGZWjFc8eQQqic9QJ97j3mziGm63DSjkj6Ykem?=
 =?us-ascii?Q?7OOB8xredLr0atURpBdRE6ItkcArrbCMcXCoXPpYv30pQPv/d5/c2M6PgCDv?=
 =?us-ascii?Q?9QMLkN2DIqoZ5mowXl1gOsqqyf1AMu+I/KEIhUwp6PqZwLyCSMxOKPL0rHoo?=
 =?us-ascii?Q?hOEAETwuF98n0CPvVuK/fyOcBTKvmE+F171goD765lKcso6XuChigetbXMK7?=
 =?us-ascii?Q?5G7dM9Dzb9yYmFruaAXPT48rhYHA3UvXmooNvwHVV509U2/h2sp8ddZkxWPC?=
 =?us-ascii?Q?1APMSa2K8ekLmlI7fc7RcJ5jorE1DgxzAb14al1o+Md3TTllNzaNpmO/p8tj?=
 =?us-ascii?Q?1iIzqmjLgsX0CMM9jECLysAQlnan98y0rxBb4+0EAqATa+bieaysww+qTSrG?=
 =?us-ascii?Q?L+wqKSAgRv+zJJzyuszzGm9PPiNXBjjPfRp/NnOo+vpPXgTQ+AJrXqWU+/zu?=
 =?us-ascii?Q?SHhJHjDzP5NnLoNWbsCN4nc7kxuc8JkXev5MLigMK2b+mQNM2Vg6+dCofPrq?=
 =?us-ascii?Q?bExyh7xMCAs2Ugg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gCEX792Uoya0JdUjnn9F5Lsv93ZudSiwjXgXrfVm6zYgf9Fw+azmiMZLIUVU?=
 =?us-ascii?Q?cNm2xHlYb8EMhBX/uJ2QnlyPUnv8bPDxdXyD4s4MB9sPQq8gaOoxZKY8XnTz?=
 =?us-ascii?Q?mirktygdGU77cNtGiWS1OKOcstU8ttdvYAbtoOotfWci5xVasFfobqC6yJeC?=
 =?us-ascii?Q?pasoTgHhE8yyaEVaHw8e4Pyysw+vU7Jw5wu3LtvYrEuljKWWbC+AFrFajAtM?=
 =?us-ascii?Q?3IJghzKIPm90+MRbIr5NFKz+gDEdT3ZUnfzYjWGrFA6hKqPnGGngH7hSnB/E?=
 =?us-ascii?Q?YS88noXkkE9xBtk1HZqNIoNEgcyj3gU5YWbERJQxeDErOgRRmAwoeznPFyRg?=
 =?us-ascii?Q?QKnro1UFdFfycp8wzNZfd9oUvAJ3cczKMb86XAGTKHkduFxa9bvw+J4cTANW?=
 =?us-ascii?Q?qUGMYFS7gcJKW7K51L4ze/EHud3kADvVaOxJ4ILUBrAR4IKT5VS3ZK1BwNPx?=
 =?us-ascii?Q?/PzimOdRCEhAvLw0oPk/9xBNyMUoDJ7FMmyNQQQUBSuCoualwViyMMYt82Z0?=
 =?us-ascii?Q?u+WpvHRiafxEms5tOnf9UguKv/0uGJhqczHSIFu3jpw1Azkw3O+JJOmsX6qp?=
 =?us-ascii?Q?RqclNq1FcPO5mbMFM1FDcPwNaPV+kaGiZl7nGNOj6852aJcvaN+1sNcSDq6s?=
 =?us-ascii?Q?svd0oYfsDmxHWcMbSsS+hUeGwS0bRyJe5hdMI8zc6SdfUiVlaOKeVloN30se?=
 =?us-ascii?Q?9vR8upayRLljfhEKx5C1oUwS9atX06oVileeS2PTh0NR5UKJPEbEH3xCnjEl?=
 =?us-ascii?Q?NVmMD0lTWYDN47TW3GjjH654EW/jaN4OI8fW/frd1GX5I1pGUZI93Pk3AYHj?=
 =?us-ascii?Q?/fU9BZz1aaNXMvPKPK2LuIc32MIYNFE7OP9//ZzheCjFSqk3jpnwDG+rcLNe?=
 =?us-ascii?Q?iL96h4pBLuAW2aBp7PGh4+9Ii8DzJ7ggJu4B9pJ9TzRphzYifpZ03LUB1nDl?=
 =?us-ascii?Q?1QjWph56XhkV/0ehBI1AVnjACyLmQIy97MqAGhDZwphWynYwKsdlvdY0BQAT?=
 =?us-ascii?Q?HN3IATbvolZwminDvWoG02nFGTp6ES34+WEf1j29zKdd0vLsCE8Z8uz+WhQs?=
 =?us-ascii?Q?/LOyeq0XvRTFfvtcS2eDq6/SPg2UhG76qZHOjN0ysytdlRnYaGncpfjAu2Zr?=
 =?us-ascii?Q?AZ3x5jjpSOh7kYORKkzJRSPQMRVbcvROTHpY4r42RBktAT3KhGxtyJZAl2Hn?=
 =?us-ascii?Q?BZnLPvQH/xFscYl/dOeIYv9v5Xd90rHLncKiyyafN6y1uPZMZRFHnbgmfMdx?=
 =?us-ascii?Q?/FzR4Z9m5Xv5P5bHM4s1U6pRUqYQhytMFU0qzed6wubv5dDClad9t7dx0nis?=
 =?us-ascii?Q?GvGs6vHH2u79+/bNdPFmKr2qlH8Buh4G48DoFLGpcn4mJphigL3zs4oEJhpQ?=
 =?us-ascii?Q?WyureHo+NJsHbWbfbEbfymHki4ECe8l7gelu1ckJiH24gPTTEwHxMGbtzzZv?=
 =?us-ascii?Q?W6RliBrVEr0zvrNHBLYpmqkgOkl7ntqolK0MeQcOLAHakrWpKLKB0UaG6+5g?=
 =?us-ascii?Q?CvZ18SNffAwWSMS44mCz8fP78cj7wkdDJq8R2C7K/68ungfJPZTi434rBZrt?=
 =?us-ascii?Q?d1OrR2c54+xMSFgO0Kg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab64f0e1-6935-46f9-0414-08dd865450df
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 12:58:04.8473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PKgsEYwbUk6sZoMiaAEEj9bPegkaastsHdmDcA+20RMwpniYUucHsc3kZAbGR3X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, April 26, 2025 2:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submi=
t
>
> Enable a primary and secondary queue that schedule together.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28
> ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index f9f2fbc0a7166..e5eb4b923f24e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct
> amdgpu_mes *mes,
>                       offsetof(union MESAPI__RESET, api_status));  }
>
> +static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
> +                                  struct mes_set_gang_submit_input *inpu=
t) {
> +     union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
> +     int pipe;
> +
> +     memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
> +
> +     mes_gang_submit_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +     mes_gang_submit_pkt.header.opcode =3D
> MES_SCH_API_SET_GANG_SUBMIT;
> +     mes_gang_submit_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +     mes_gang_submit_pkt.set_gang_submit.gang_context_addr =3D
> +             input->primary_gang_context_addr;
> +     mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =3D
> +             input->secondary_gang_context_addr;
> +
> +     if (mes->adev->enable_uni_mes)
> +             pipe =3D AMDGPU_MES_KIQ_PIPE;
> +     else
> +             pipe =3D AMDGPU_MES_SCHED_PIPE;
> +
> +     return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> +                     &mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
> +                     offsetof(union MESAPI__RESET, api_status)); }
> +
This also requires using the MESAPI__SET_GANG_SUBMIT type to get the API st=
atus offset.

With this update, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.co=
m>

>  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
>       .add_hw_queue =3D mes_v12_0_add_hw_queue,
>       .remove_hw_queue =3D mes_v12_0_remove_hw_queue, @@ -888,6 +915,7
> @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
>       .resume_gang =3D mes_v12_0_resume_gang,
>       .misc_op =3D mes_v12_0_misc_op,
>       .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> +     .set_gang_submit =3D mes_v12_0_set_gang_submit,
>  };
>
>  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> --
> 2.49.0

