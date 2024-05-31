Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F42C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 05:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51EC914A687;
	Fri, 31 May 2024 05:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRW26wzI";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AA414A687
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 05:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI6Pd/RfaRdGuoLb8ZXOPl1JnYgtJ+k0gaNVBjognyLHv5DP8DYwMuUMgnEm0WZXkt+e7Sr7KSVOiuy3VkLRzIhtBadCnyo4OviLsKm1o9wyw2vG4RMGfXPo8Ok5J21MF5su+lGxQ+RwpiOi5GOVVJKsKVuHOmO6+UIVPEeRVJAYtmODW3VC/LkBaSZ3Epmpzi+9GUf8h4k3BWaKOCgS5uuSexMMuibu4XjkiqoIT/wgESUO3oSnvw6DHyOLQO6HnIKayh3fdgUi8gM7ccs5DU0weVH7hLAFMz3Vg5wkyMo1KLbURw1+RcKW1R+nW5OfPA6JHD1Bni8ccJZHsoKl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VW/7h89E5NUUvHrOEcRDFgMvLf6G/+DM4c050kf+4k=;
 b=OY8TvnhXOCIKv4zMY5L1owvW0WAhTGS5unyNMrUBxT0WPZo36rfE5kJ7hEq1mWpS7edGbmAOSRnwylLSZ36/X8JxQz9dB77noE03+VtrztWN+xy4TRQzlLvjsveTfXImgcG08r2arvjy06kmUGIahndVqxgJxUNF5lCrUBjA+Y7Cpp+BiOLY2J906LyLVSHSEIzSZlHSvizLrwEEXBgzb2WwxxzcaM6Cxo0znCGGoAvYyQyMCmSPlly81xnVBhVKV1XsgRynxu1sjYwj8kwvfUOmUhKg4dGSnc94NHjD69s7ECuloNfxvKIO/LBNysdH7E/b+Npx9q22D1YLhMPuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VW/7h89E5NUUvHrOEcRDFgMvLf6G/+DM4c050kf+4k=;
 b=PRW26wzI5C5iExZXat86QDzPjVdmO295O46X0HmZ52tC2K8OW7auQUMSpWCUyM7omEJxMZtz9jcSvyVDM3OxSMI+3smLeiow/Lj/QDpCvC89/LBjSSUq46xgZcVz/SxxciLQL00XjG07HizwpkvB1aDQncGTS1YGghzVui+e1zc=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 05:14:55 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 05:14:55 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Topic: [PATCH] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Index: AQHasaJn1FvKyOjmE0qPEZfgoALbVrGwzB+Q
Date: Fri, 31 May 2024 05:14:55 +0000
Message-ID: <CH3PR12MB8074310272C4361ADDFB1274F6FC2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240529082956.94945-1-bob.zhou@amd.com>
In-Reply-To: <20240529082956.94945-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cb34c43a-d93b-4906-af8e-d061b4c52478;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-31T05:11:27Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: 6d056771-6c98-4dd4-62cb-08dc81309bdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?GKOFtSeIoL9/A0jzeGqW6GMmcYj3l5SmkqulvvJ+zWOGyVkL7fJjAjJYzSL4?=
 =?us-ascii?Q?IAMR18Qs38di4uFC8ZAd5PNl5J2hv2DDcZ1B/obwwN+jmAcOjY2KEkTqipYO?=
 =?us-ascii?Q?+J8GqWEo3QuUA1+o3F3IO/K7iNShujVUkYnVRWsKhLn824175VHVqSI3NuVA?=
 =?us-ascii?Q?aH7oGPCQT0Keqb7NpYabyhzWbbhdNglAsxGbO5ubtb/jvUY1GjUZgfJrUS3O?=
 =?us-ascii?Q?8h4wBmkeLVije1jNWgod0KAus8Q/AnhgJYR0ZZkU5Cd13yRvzUKHFtobuXn/?=
 =?us-ascii?Q?sA+CpKEIfCIzyBq3yJ4Hl7QMLjGIW6s/57VY4bUbMrUjkyaWW7WznZv4O/U9?=
 =?us-ascii?Q?bnGeaxuNATz/wvMbqLq+2LV8WUNOxsxpQyfhItBatbULlka69rDUrQl/KP4G?=
 =?us-ascii?Q?gsGrISEEz4AtteZXBWcyQ180Q7+vpkqsh6GzKD7LdfqB73SW4cb9RxahiD2M?=
 =?us-ascii?Q?PhM8PzYXoTthdn+1QiabwaYdjgc/b+7qX69Re7K/b6RicNeRJtp4fMnoAkqp?=
 =?us-ascii?Q?141SHpNwCvkMn02BdqeG1TY0WiqwHcnlYDbo3goiIzJDgrl7zPb/kmzwL9VF?=
 =?us-ascii?Q?OkKjqtCPEj50dzaMLrvfz7w9ka47HJjysE5zdGVCD/jIH8rFDiHyQXZ5ssCq?=
 =?us-ascii?Q?nH0R+12KwFmLRwjxihqD9P+vsyGngMkwfq3Ox90UL/QKv3v+iGRTR2Eu3RGo?=
 =?us-ascii?Q?duVbegJFkCzFDb6e38AubL5pOvknvcsRjRU5n2WamdUb61uMuJhnz4ax5nQs?=
 =?us-ascii?Q?Te3rZQhrlCKGeCdY/N3HQaX2YUie/sTYL1fWZXr5DqhstrGLjfCu2O70YQar?=
 =?us-ascii?Q?ygu2hyY5R5YYRfBL+XvBf4tnC7D9rqu9nsgTkiTFFUVydy5RWHHHM4+yBNPc?=
 =?us-ascii?Q?kXC757axAg3IHD9yq1xS/0dFHFxPXKUsRKyU8wCGqVgOeQVCd4PUUqGWmMOx?=
 =?us-ascii?Q?9iidHp+sTJNP2vSU3PHta9X/DeMNrwmItDJU2OKJ+TjRi1Gy1wPAIAX9L3MQ?=
 =?us-ascii?Q?LQ7dISTytn6mPOkehJf+EcOr0P/gsE0CyW6/pEkuD16/XRTFZ/D7vn4FWxbB?=
 =?us-ascii?Q?GwGIcHBo7cnwDj7Qm7Z67+afSt37xF0yREMreFFZH0lYGTSwnoaVPironX/O?=
 =?us-ascii?Q?UoW+0NuLj2/4fEhc70xTI/Aim6NeYuAxgHbz57coSPkA8B1gj0tlrMDRYBB0?=
 =?us-ascii?Q?i5yWoEtz1SjtOaydyibFmwRu2l00q1U5TLvhbp55Gd7ZuCAbG09p564vRyCb?=
 =?us-ascii?Q?djq6ISI0pYNWXBfWxFgSSWYS4dfxSmHUqkI4Smend5F12F+BFRlIAok5c517?=
 =?us-ascii?Q?CZCLrp3r/W2YqJNK8msRRvErS6F6qRQJvufMuI+USMwRDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQX8U1EVh4k6UHJhmtEEMHcGVJfka1WXDllCuo5cNXwGHLu/x49Bs96XMH/D?=
 =?us-ascii?Q?gmTzs+zBm1z9Un/o2DLku01JVspxUeqJWLaNAa82nPXV6B1IBiBr3rn7HAnc?=
 =?us-ascii?Q?vxCa2UVkwjNZX9OJEn4rwHdCDisCwiJy99I0mO1ugWzcumE6tLWzuMWZvHoQ?=
 =?us-ascii?Q?yipzx/GZUBnWbanJ3LUiSlm+XokOWBh0vvry8BVh1tESyVnYYpek41YtQZ97?=
 =?us-ascii?Q?4cKZXp2hvSppgGXxIdWQKwPdj2T+ihXhKVz4d6squst4NUddvOJs1xVauFFq?=
 =?us-ascii?Q?uadpEXyaud+1H0GUd9x6wkHIXzLild+K1/fQ6t9ofkInKOkHehqHUQqy9MU5?=
 =?us-ascii?Q?bX4lvTqcRb0V57AhR+e741JEtDtUfXwr4LKmFoYFANbGS7u1JYkwVA4d7PZR?=
 =?us-ascii?Q?2ew5SGBSeEUZHW8kfLnRo4YxUZZl+DPLQ63IbhKGJQkbz9urp8rYRghmnQtu?=
 =?us-ascii?Q?+XF9VT3qDabms7VmRXplJeqhpArgg5+bJUaR2sNR7BTGg2tCdUxyDfCXtjeb?=
 =?us-ascii?Q?oBS035xGPW6WR2GTKx+jPZoxEdOE9pR0dHe3bouJx34Kf0kx5qeKMyrp45/C?=
 =?us-ascii?Q?GNChTldl5EjoWpekJucTTERaFl3IB2KwCNilorqMDxs0s0XZn5sxERd1z8u/?=
 =?us-ascii?Q?iZz1oDyr+K+As3ZRHQvacsJmLlVmCisP2I30RmSeSGhTz0pF/vhln7PiK4ra?=
 =?us-ascii?Q?2D30pzY575OKn2UGgeTvcRAv6t1ofYNR9jj5G/A7Ua8U8p069f6zG4DFwkMh?=
 =?us-ascii?Q?JZhF8N2BzGuRUb6nIZ8daPyDaCNrwaCQWIK4ElOa3bGnSpVGvI8BuXAiBLMT?=
 =?us-ascii?Q?Z1kB8HD4UF7AVeWjtTcpi7I+F8Xdhe6JuE/T29R8ETSI+HR8nmh5w/7tDeFi?=
 =?us-ascii?Q?o7wgZU43Ue5+bfRC+bjjmIFo326GH0xdbtAQV7sfiRYSwDnlZO16qRyI+SsV?=
 =?us-ascii?Q?6ztVZ2YzLqFaKSadDFqt/gJAtIr0lIn3Xjl0tRe66UrqQo4IITCDlDZfkpKn?=
 =?us-ascii?Q?rj+UDf8zNJMaF8xOkosnhUwmbem7BICV0AWCwi+6zcdJiAZQttUahKHtIUTf?=
 =?us-ascii?Q?d3y8xXlwucJpFwLPFMYo0hKQHaoskqKImdcIVg1PaCyqDCG5JP8uYJl6tjnf?=
 =?us-ascii?Q?YjyuUWrWSFhIUg5baarXQGRV+7WAu7cJLezLhn1Q1kqL7aau3yBrLkdGb8gG?=
 =?us-ascii?Q?jLfUoAi9Kcj9MRAmLG1rUcTX5ZsuN5ZFVXun0gySiRsnTw/4B6JBaSALYGIb?=
 =?us-ascii?Q?FmKBAwiaG/SNBYpEWjey/o5natfG/UXJfP5h7CuuutI776AuW1lHhUykrJp3?=
 =?us-ascii?Q?tejeEAxJCjsrMwts/lynAp49GuIxdCBZ3R0bnxN3tJF09TtUKlkXbhsfuVUG?=
 =?us-ascii?Q?kcd/tcsT9GnAWMVqgEf9lXJ6rg2MjCD0Q+ZjBljM82Jv4JbZGPVM4N8UQ1AX?=
 =?us-ascii?Q?MOzoaBIxvUR6czojQ+Mi1DeDAwLbFUNpvMSBK56JVjru+AYNqnfkB7w/u+mN?=
 =?us-ascii?Q?iyMY8ZBLnuAgYn3WR8M9mB1goDJYJpQ3Qvph2G8Uu5vlvIlZ9BhYht8k/cah?=
 =?us-ascii?Q?0RXatrUFjyAAyAGcmWY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d056771-6c98-4dd4-62cb-08dc81309bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 05:14:55.3034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaNHs6YCCFHe38dKopcRk3I61688yDPdwR+40CfZ2rJJflF1bb0I4tBj8jmT1LRTtgJsxIh7JC/idZtFVbqZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
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

Hi Bob,

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Wednesday, May 29, 2024 4:30 PM
> To: amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
> Subject: [PATCH] drm/amd/pm: Fix the null pointer dereference for
> vega10_hwmgr
>
> Check return value and conduct null pointer handling to avoid null pointe=
r
> dereference.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 38
> +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 6524d99e5cab..0f94564b4adf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3436,16 +3436,20 @@ static int
> vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
>       struct vega10_hwmgr *data =3D hwmgr->backend;
>       const struct phm_set_power_state_input *states =3D
>                       (const struct phm_set_power_state_input *)input;
> -     const struct vega10_power_state *vega10_ps =3D
> -                     cast_const_phw_vega10_power_state(states->pnew_stat=
e);
> +     const struct vega10_power_state *vega10_ps;

Not revert xmas tree notation if change this.

>       struct vega10_single_dpm_table *sclk_table =3D
> &(data->dpm_table.gfx_table);
> -     uint32_t sclk =3D vega10_ps->performance_levels
> -                     [vega10_ps->performance_level_count - 1].gfx_clock;
>       struct vega10_single_dpm_table *mclk_table =3D
> &(data->dpm_table.mem_table);
> -     uint32_t mclk =3D vega10_ps->performance_levels
> -                     [vega10_ps->performance_level_count - 1].mem_clock;
> +     uint32_t sclk, mclk;
>       uint32_t i;
>
> +     vega10_ps =3D cast_const_phw_vega10_power_state(states->pnew_state)=
;

Why need to change the definition of vega10_ps to two parts? It may be enou=
gh to only add below check and change the sclk and mclk.
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
> +     sclk =3D vega10_ps->performance_levels
> +                     [vega10_ps->performance_level_count - 1].gfx_clock;
> +     mclk =3D vega10_ps->performance_levels
> +                     [vega10_ps->performance_level_count - 1].mem_clock;
> +
>       for (i =3D 0; i < sclk_table->count; i++) {
>               if (sclk =3D=3D sclk_table->dpm_levels[i].value)
>                       break;
> @@ -3748,10 +3752,13 @@ static int
> vega10_generate_dpm_level_enable_mask(
>       struct vega10_hwmgr *data =3D hwmgr->backend;
>       const struct phm_set_power_state_input *states =3D
>                       (const struct phm_set_power_state_input *)input;
> -     const struct vega10_power_state *vega10_ps =3D
> -                     cast_const_phw_vega10_power_state(states->pnew_stat=
e);
> +     const struct vega10_power_state *vega10_ps;
>       int i;
>
> +     vega10_ps =3D cast_const_phw_vega10_power_state(states->pnew_state)=
;

Same question as above, maybe it is enough to only add below check.


Tim Huang

> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
> +
>       PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
>                       "Attempt to Trim DPM States Failed!",
>                       return -1);
> @@ -5036,6 +5043,9 @@ static int vega10_check_states_equal(struct
> pp_hwmgr *hwmgr,
>       vega10_psa =3D cast_const_phw_vega10_power_state(pstate1);
>       vega10_psb =3D cast_const_phw_vega10_power_state(pstate2);
>
> +     if (vega10_psa =3D=3D NULL || vega10_psb =3D=3D NULL)
> +             return -EINVAL;
> +
>       /* If the two states don't even have the same number of performance=
 levels
>        * they cannot be the same state.
>        */
> @@ -5168,6 +5178,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr
> *hwmgr, uint32_t value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].gfx_clock =3D @@ -5219,6
> +5231,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t
> value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].mem_clock =3D @@ -5460,6
> +5474,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
> *hwmgr)
>               return;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return;
> +
>       max_level =3D vega10_ps->performance_level_count - 1;
>
>       if (vega10_ps->performance_levels[max_level].gfx_clock !=3D @@ -548=
2,6
> +5499,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
> *hwmgr)
>
>       ps =3D (struct pp_power_state *)((unsigned long)(hwmgr->ps) +
> hwmgr->ps_size * (hwmgr->num_ps - 1));
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return;
> +
>       max_level =3D vega10_ps->performance_level_count - 1;
>
>       if (vega10_ps->performance_levels[max_level].gfx_clock !=3D @@ -567=
2,6
> +5692,8 @@ static int vega10_get_performance_level(struct pp_hwmgr
> *hwmgr, const struct pp_
>               return -EINVAL;
>
>       vega10_ps =3D cast_const_phw_vega10_power_state(state);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       i =3D index > vega10_ps->performance_level_count - 1 ?
>                       vega10_ps->performance_level_count - 1 : index;
> --
> 2.34.1

