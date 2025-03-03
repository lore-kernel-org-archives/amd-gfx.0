Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66399C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 17:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C41E10E4B2;
	Mon,  3 Mar 2025 17:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RCwdsykY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6014410E4B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 17:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNXvaf/a+qCp5PnxZshnFOif0qvThN2s1elEUIMIB/i5hkwckwF4/snxTw+BcdZYv8lzBLyEiEiBoZkjgQscgd/UimjCssXL1feXttH9IlckCIlYESaFwz7ziwEX0Bdq4zjbFs9R7rmPse3ZBqAOEhxzyATAia6PrxTsGYkHF2Kmv9IhdWC8PrRzBTI3ZtuQlFZITGYdPTDy+5WMjlUkV5CJ6MG3jeAJOPb1d461Agnn6/gxZD6su/KcYj2wdahqbLwkWR3yisKnJ2W7jhMn6xr6mGWFWlY09JmRtBC3YFD/iaPZ6VVF6qXbeFhfw6x125Md/vEnWHy6WwdX3ofjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA0yggp6J229JlZ7V0+H7jALXIy1vHf1a5dsbtf7+70=;
 b=ZP6T82jBMBR4I2WAnKXBhHiVBjmYIqY9VAlh0UsA+B37Bm1+IOe/rtE5CD8TErR2snw+xMU5Upx5PsDbAqUsas58jkdhKPNUrfxEp/de1GRk0tN1bUXWFAubOcP43Jp6/0q0ijTM1S9AOKN7Yg2ihyzv5cO7zAvNh3IvTtX7nZJIHCNOTZTVOdgWPm0BfsZocJfG0B12xQNKlBK0PtOQMhalSKCSWkcX7SzjroCseykvTmwjZ20YKw8M4fo5w4h8hI2QtK8gfuVAoisjs1c6lvQssE8S8jMmJWHlaAX6pKtCjd2rjmTSxTU+bGndUSQO+nUsYlm6MDzv7aHleoLP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA0yggp6J229JlZ7V0+H7jALXIy1vHf1a5dsbtf7+70=;
 b=RCwdsykYKU9i9HdtmuUbX4w+Idpm+LqHkmWYnRG1R+OIY4d6tda0Kd4EL3M3jLCY101ZyTG1zz9v/J7eEuMYHjcdo6Cz6/yZSKdk93vwYj4pTifPJ/ptGsZ1J8pFHj5PZfYKlScnVnuks9lMNG1cH9j14gm7+e0tw8+oHNfF0AI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:15:56 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:15:56 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9
 family
Thread-Topic: [PATCH 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9
 family
Thread-Index: AQHbiIPyfsWJKJekJkGAYA/MfbdGaLNhpUXw
Date: Mon, 3 Mar 2025 17:15:56 +0000
Message-ID: <CY8PR12MB74359846EBED8B74603898D885C92@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250226192303.48552-1-Harish.Kasiviswanathan@amd.com>
 <20250226192303.48552-2-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250226192303.48552-2-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=06f0d8b4-592c-47c9-9138-7f0587791056;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-03T17:05:17Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CYYPR12MB8853:EE_
x-ms-office365-filtering-correlation-id: 0f94cd01-cd59-4515-52ba-08dd5a770f4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iGc7VVEsunsyi0EaK0mRzeoQUtQ+tjvZwNNYukI/0KFjewgLlvsv2mOJZg2T?=
 =?us-ascii?Q?YVikP9ndzxwt45gGhJixfLrhBteo+uiWqRESwnNf+nmtqAY7ZsQi9qiZjxy3?=
 =?us-ascii?Q?spyETu96vkTspu+/QMQM5X845Wg6PvM+OQwqEjvc2A/iTlHQILrXzdF+eser?=
 =?us-ascii?Q?XGa34Aik3QW0Mu+NnuzcE5MyI2hD+aVcTBy7vqhTNNtSnHRPVASMmzqoLXCK?=
 =?us-ascii?Q?Ol+RKs7Lw7aobLES1EHo/5iYSJK6bZxsX8LBT6focR7YgzHVWy6SnXLKEi4n?=
 =?us-ascii?Q?wcKOT/Wxd+smaBvTIj/K4HUfxXrpQTDe0YXhsnhTpdvDKYeUlwd2eiNfsKHv?=
 =?us-ascii?Q?e3fvUaj7nIXyggLHHFV61bc5VslG2PcCqA92BRCU6R1wVadKD5zxC2niL8Cj?=
 =?us-ascii?Q?BdO+ZF3giKOWDJdhGalyqm6JoGi7rUhP2JCyRAtAojBCmXy2q1re9HYPivUl?=
 =?us-ascii?Q?/sZk82/qOE1MYs5Rf0Whcz63pPR/78xPq2ribWne/66P/Z5hbPTQWPCQ6lCv?=
 =?us-ascii?Q?xxixPw+tK/YwTYqQW2xBD8HC7RJHL5kMC516clV9GXKtQHgFw4LDF7crxXra?=
 =?us-ascii?Q?4EtUohXmvT2ncQZkTIPDebX58lspfgWTaRnrWGaR/N8ZXsJiAnbVVWkfdOLu?=
 =?us-ascii?Q?jbB9BVWDmpvrlM2bdqH3tEq6cBrEeuizPGy5GFsnGumpMo+PhGUdzbyL1tDz?=
 =?us-ascii?Q?ISgP18nHVKb/jVpOUzsnwS2yJ01xSpcrR9jMoNXE9YUHzQvRCOTlbfvA+vTz?=
 =?us-ascii?Q?f1H2aLu2RK03HaIXWuTS4EU1MxZCRoNr0zNqZmmHzZGIVPmEFauFZAldrPQz?=
 =?us-ascii?Q?1PgPbeqnIaFkwuvjAoPQ2ZycZOl9BHV/p7mka+9FYxtMQYs2GsG1NZfN6VJP?=
 =?us-ascii?Q?OL2SyV6DZbTsLtmNrpxHHdhPXZfMtmiumfZdHaXhJMRLM/E4fRnKJ6Yxvow0?=
 =?us-ascii?Q?ztOECbcQnTCdwugej087lMHes1Sa050lIuRYelb0pdCQS9h9hDpMVSNL236F?=
 =?us-ascii?Q?w0cleHcIF6GbUsLKhldMF8r1eHsog8PNZgxG35YTnutUqvybXphJjaBLzgNS?=
 =?us-ascii?Q?CPQCRsIOtug+/osik/2TWP7SDbvaIBYTyhT3mdyWGUDjZPmjuIdHUS5X63S7?=
 =?us-ascii?Q?nVaHxBRcNWz3yJ7N9PTuWHf+L5xmdl4HwTyZtfWBur3IUzxMzgCxnNORVrag?=
 =?us-ascii?Q?zWy54m9I7X9uSXYOmGrRlDSNKv0EFyBbw93bb3vQDmHFhA9gupw2db1p9n7n?=
 =?us-ascii?Q?P1/RFEWMuOp/fo/etU+09Gxw4MKmjjZz94zEtuSw1bvPj6RZAAAYo8JyhpEg?=
 =?us-ascii?Q?RZ7TV3pcn/NdU2TIZPdl7Lyv3QVXcVcMoTDYCRJj/rF+ySx2AIcqVqpKWnEq?=
 =?us-ascii?Q?sEbUp3IY4n5BdEdRdal/yln6NKCRGGa809LdenXjDAr4/zbnltqH3+XkZcR9?=
 =?us-ascii?Q?LTZ7sYyj7QwkteRG1npo74dtzRlqyutG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GRSfHPh3rXuzg+n8FLtdsLbnMyvHIqnPp1yHZ2ALjZDDT1xOarShlwRfyJ/C?=
 =?us-ascii?Q?o2apxovKUEd52/otLeNiO3NzC496bYhD5Y7PlLMkfmTjjFPBdLuHi3YIgflV?=
 =?us-ascii?Q?EtX65DY46P4oMff4kBTlo74w9YzSwrTko6hagQ27OB9p8/ybajQQMG6O9a1F?=
 =?us-ascii?Q?i8x1RXiESo1eYbj2hAqBu3NJuI/3p4Ef6CHKOajhC3sqtocsGJxm0WU+xDsm?=
 =?us-ascii?Q?zkKcRLQ1I+e8PAexrULHHGxLrA8kBqh6bxDD4H+iN9SRKEPZYpUp+73Wg6DW?=
 =?us-ascii?Q?N9BMIkF/lnXHjWB0kWZ503ubwdxXmnXX7rVyskkjvoFLhtZfxHuAy7PJ0D26?=
 =?us-ascii?Q?uZFRLnHonr5KeayRXWjKF0oXMawmQ8UPV5Oi+bKEz1QSvOzeWN6yb80r0gIC?=
 =?us-ascii?Q?th+D6cD2zO6BxntU1dIIvmpqf6N1/TcL+K9xCecEQVETJ6CRn1EUyXH16Yef?=
 =?us-ascii?Q?AvDlxAUoHCsDpBuTqGrkHqQyCPL0C9otI/9qcl6tyE3lNLbSxW95yqZlJkaB?=
 =?us-ascii?Q?+IAstJSkJzxyHDnYIdo1zcpGp0GHdHmpaaVrMmxv/tyV9XHVYItN+JxMvVX3?=
 =?us-ascii?Q?mdqtbLzdNBKnwogm2wV1xPcCP69wLAuE3QfmlIgvaFDeIVa6ZY02wLtPCzUE?=
 =?us-ascii?Q?f5njJd4fZOQMTL7MUJdwMCExLklInJRfmF4VfiwoEnrAbs1rpZ1HF2+2Fui+?=
 =?us-ascii?Q?lObxSh5d277Rmbp0B1umgfNSMRFEkIebkysKXGp1RzPphKqA0zt46OuNYnT5?=
 =?us-ascii?Q?PAtgTtzqH8G3+V75thCQCgvj1JqFhA5qD7cTUMSOOxJfaARvYoj0402tCAOJ?=
 =?us-ascii?Q?LlDniu0NNX95z9umWfwLQ95uQbFcztI/0VDsUjYAr1LZnkJ8lcujxq9pALAl?=
 =?us-ascii?Q?VwPJ4oOMaeCNZ/tojHauQHAAJSH1ehk+qdWKTC2VvryP8Ukvb5BEVS1bYBWi?=
 =?us-ascii?Q?7E36pQZhv4SYG3FQo4X1kCYuHxXtHDpc1eUBqfo6Ud+FjVkJYHFteVL7wMvY?=
 =?us-ascii?Q?0i/gvmF478QgCR6qBNk2i8kyQobBb8OD83VH+48tO5dR5GOaSMPXfNWe3IZK?=
 =?us-ascii?Q?EQrDA1sdyyJsBYkYOPMT2/G4UyI+r67EZQEe/Xj51uP25RPv2BQWlLcE7hNs?=
 =?us-ascii?Q?5Kjh/FbyonIIOtwqToPX8SXknkiZZOvgRIW9H2KOT6ozgJiFMRp1dNv9e1kK?=
 =?us-ascii?Q?g+DbGM1LLYZTe9cP/l4yFgxnNmWbsIvHuv/z5yTrRKSecG4HMtlRfiGb7Ij/?=
 =?us-ascii?Q?FEyJQK6R9Uthk8gITdlH5gKBC87TFAgT4H2HgEy2/K4m4CUfGOL7L6dCoiIB?=
 =?us-ascii?Q?oIrp/zI3So3ips2OIZnJjDqC36beSnXRGM2jgA0PlY1aVNXC9Mjl7OpuhVIC?=
 =?us-ascii?Q?DDNNP4XQTM198P7ZlDU+pyCsuvH5J3M63KazsSp0P/pfgHSjJvC3WdRsCb4T?=
 =?us-ascii?Q?oGaKOi//k88EUMpuDJw3eb4C1I5fsloqK/gJQTILc74YHQhEzYZhEtDkK+Kz?=
 =?us-ascii?Q?cs41uHyCPcKjirtmvo20ZiXAJHKDFtam6h6O0s1+R4tdtxtzNOENp181mIUX?=
 =?us-ascii?Q?jCHfyJXhG6XiJn95vog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f94cd01-cd59-4515-52ba-08dd5a770f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 17:15:56.0705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuugdBXDpZjc17tL8reDpwJbJ6GycxS4DfpoGVXAwLMGU5i8ePaBcQXpGHDGLqFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Wednesday, February 26, 2025 2:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9 fa=
mily
>
> Dequeue retry timeout controls the interval between checks for unmet
> conditions. On MI series, reduce this from 0x40 to 0x1 (~ 1 uS). The
> cost of additional bandwidth consumed by CP when polling memory
> shouldn't be substantial.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  2 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  4 +--
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 28 ++++++++---------
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  5 +--
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 28 ++++++++---------
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 +--
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 31 ++++++++++++++-----
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  5 +--
>  10 files changed, 65 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 8dfdb18197c4..53f5f1885870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -189,7 +189,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_aldebaran_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v9_hqd_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 9abf29b58ac7..6fd41aece7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -415,7 +415,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v9_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index e2ae714a700f..95f249896275 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -530,8 +530,8 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
>                               kgd_gfx_v9_program_trap_handler_settings,
> -     .build_grace_period_packet_info =3D
> -                             kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> +                             kgd_gfx_v9_build_dequeue_wait_counts_packet=
_info,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
>       .enable_debug_trap =3D kgd_aldebaran_enable_debug_trap,
>       .disable_debug_trap =3D kgd_gfx_v9_4_3_disable_debug_trap,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 62176d607bef..0b03f2e9a858 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1021,25 +1021,25 @@ void kgd_gfx_v10_get_iq_wait_times(struct
> amdgpu_device *adev,
>       *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmCP_IQ_WAIT_TIME2));
>  }
>
> -void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
> +void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_dev=
ice
> *adev,
>                                               uint32_t wait_times,
> -                                             uint32_t grace_period,
> +                                             uint32_t sch_wave,
> +                                             uint32_t que_sleep,
>                                               uint32_t *reg_offset,
>                                               uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannont handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> +     if (sch_wave)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             sch_wave);
> +     if (que_sleep)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
>
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
> @@ -1109,7 +1109,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v10_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v10_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v10_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
>       .program_trap_handler_settings =3D program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v10_hqd_get_pq_addr,
>       .hqd_reset =3D kgd_gfx_v10_hqd_reset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 9efd2dd4fdd7..89ae07288b10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -51,9 +51,10 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct
> amdgpu_device *adev,
>  void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
>                               uint32_t *wait_times,
>                               uint32_t inst);
> -void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
> +void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_dev=
ice
> *adev,
>                                              uint32_t wait_times,
> -                                            uint32_t grace_period,
> +                                            uint32_t sch_wave,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index c718bedda0ca..2c5f22838fe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -673,7 +673,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
>       .set_vm_context_page_table_base =3D
> set_vm_context_page_table_base_v10_3,
>       .program_trap_handler_settings =3D program_trap_handler_settings_v1=
0_3,
>       .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v10_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
>       .enable_debug_trap =3D kgd_gfx_v10_enable_debug_trap,
>       .disable_debug_trap =3D kgd_gfx_v10_disable_debug_trap,
>       .validate_trap_override_request =3D
> kgd_gfx_v10_validate_trap_override_request,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 441568163e20..d2bbe9973c93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1077,25 +1077,25 @@ void kgd_gfx_v9_get_cu_occupancy(struct
> amdgpu_device *adev,
>                               adev->gfx.cu_info.max_waves_per_simd;
>  }
>
> -void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
> +void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_devi=
ce
> *adev,
>               uint32_t wait_times,
> -             uint32_t grace_period,
> +             uint32_t sch_wave,
> +             uint32_t que_sleep,
>               uint32_t *reg_offset,
>               uint32_t *reg_data)
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannot handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> +     if (sch_wave)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             sch_wave);
> +     if (que_sleep)
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
>
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
> @@ -1254,7 +1254,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>       .set_address_watch =3D kgd_gfx_v9_set_address_watch,
>       .clear_address_watch =3D kgd_gfx_v9_clear_address_watch,
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> -     .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
> +     .build_dequeue_wait_counts_packet_info =3D
> kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
>       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
>       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index b6a91a552aa4..54ee8992be5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -97,9 +97,10 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct
> amdgpu_device *adev,
>  void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
>                               uint32_t *wait_times,
>                               uint32_t inst);
> -void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
> +void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_devi=
ce
> *adev,
>                                              uint32_t wait_times,
> -                                            uint32_t grace_period,
> +                                            uint32_t sch_wave,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 9cb21af1d0af..f9c302732773 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -298,13 +298,14 @@ static int pm_map_queues_v9(struct packet_manager
> *pm, uint32_t *buffer,
>  }
>
>  static inline void pm_build_dequeue_wait_counts_packet_info(struct
> packet_manager *pm,
> -                     uint32_t sch_value, uint32_t *reg_offset,
> +                     uint32_t sch_value, uint32_t que_sleep, uint32_t *r=
eg_offset,
>                       uint32_t *reg_data)
>  {
> -     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> +     pm->dqm->dev->kfd2kgd->build_dequeue_wait_counts_packet_info(
>               pm->dqm->dev->adev,
>               pm->dqm->wait_times,
>               sch_value,
> +             que_sleep,
>               reg_offset,
>               reg_data);
>  }
> @@ -320,26 +321,40 @@ static int pm_config_dequeue_wait_counts_v9(struct
> packet_manager *pm,
>
>       switch (cmd) {
>       case KFD_DEQUEUE_WAIT_INIT:
> +             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> +             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +              * On a 1GHz machine this is roughly 1 microsecond, which i=
s
> +              * about how long it takes to load data out of memory durin=
g
> +              * queue connect
> +              * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              */
> +             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &=
&
> +                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0))
> +                     que_sleep =3D 1;
> +
>               /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
>               if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
>                  (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)=
))
> -                     pm_build_dequeue_wait_counts_packet_info(pm, 1,
> &reg_offset, &reg_data);
> -             else
> -                     return 0;
> +                     sch_wave =3D 1;
> +

I'd still early return 0 on !(que_sleep || sch_wave) here as sending a defa=
ult packet wait times packet on WAIT_INIT to the HWS for GC_VERSION < 9.4.1=
 or GFX10 seems unnecessary.

> +             pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> que_sleep,
> +                     &reg_offset, &reg_data);

You can probably just put this in one line if you're not exceeding the 100 =
char limit.

> +
>               break;
>       case KFD_DEQUEUE_WAIT_RESET:
>               /* function called only to get reg_offset */
> -             pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset=
,
> &reg_data);
> +             pm_build_dequeue_wait_counts_packet_info(pm, 0, 0, &reg_off=
set,
> &reg_data);
>               reg_data =3D pm->dqm->wait_times;

Is the assignment of reg_data necessary here (not sure if it was necessary =
in patch 1 either)?  I could be wrong, but from the kgd calls, it looks lik=
e you'd initialize dqm->wait_times anyways for reg_data and reg_data remain=
s unaltered with your changes that conditionally set the wait fields on non=
-null value (which is what's currently happening in your proposed WAIT_INIT=
 for que_sleep =3D=3D 0 & sch_wave =3D=3D 0 condition).

With nit-picks addressed, this patch is:
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

>               break;
>
>       case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
>               /* The CP cannot handle value 0 and it will result in
> -              * an infinite grace period being set so set to 1 to preven=
t this.
> +              * an infinite grace period being set so set to 1 to preven=
t this. Also
> +              * avoid debugger API breakage as it sets 0 and expects a l=
ow value.
>                */
>               if (!value)
>                       value =3D 1;
> -             pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_of=
fset,
> &reg_data);
> +             pm_build_dequeue_wait_counts_packet_info(pm, value, 0,
> &reg_offset, &reg_data);
>               break;
>       }
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index e3e635a31b8a..4f79e707bc80 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -313,9 +313,10 @@ struct kfd2kgd_calls {
>       void (*get_iq_wait_times)(struct amdgpu_device *adev,
>                       uint32_t *wait_times,
>                       uint32_t inst);
> -     void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
> +     void (*build_dequeue_wait_counts_packet_info)(struct amdgpu_device
> *adev,
>                       uint32_t wait_times,
> -                     uint32_t grace_period,
> +                     uint32_t sch_wave,
> +                     uint32_t que_sleep,
>                       uint32_t *reg_offset,
>                       uint32_t *reg_data);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev,
> --
> 2.34.1

