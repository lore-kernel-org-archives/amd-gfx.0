Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04837C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 01:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0F910E20F;
	Mon,  4 Aug 2025 01:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IlQ4Q9kQ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78A310E20F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 01:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCBaWQWOT5uxan+NXnMHT9DR1DyW24eJUeHbZT5jQPbaQG9gjCC+N3adaWcilSJLdTPcpNMDLpNsqoPes9AfQFcU6TjmUPLmAS1cazVNkr54sQVJiAdF7BqPBJ0JJnuL9GrWqC2eht/xncV9uuqMJih9uJOmjFXAKtea+8apJyk5mYe2G0Gkl57+rv4lzi216qI07/mtht/OphwUxHwEAtZ7PjZueFmLA2926OaK1Hx6DXxa7phVJPCQATDKZhHWBJ+Pnub5vyA5IwKBnT8OrPyzYmcSmiXtV9BfxSsTO5CMagWm9LGEdEMDvpCZcfUleWjCVZ8usaWNRCFPCjYJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idt4nHE95GHxc16G43fwI5x1ixPnODFXnTD645nalz0=;
 b=v3owLGSN2m66hXXML9aGl8d5qwb2sVl9kmsyJ8S2KPEygIQxe7pdRY6p2RbKVmh8RkgV/GBSavEEXViKibLFvDtCNbjCe/U9O4tTHLaM+QLPfUYdu/li6wtLYsnihVU09VNxA/vJ/KpSBMDrqGbGWoTFOYlwX1bZjN54tpbn7A+MtatAeN0RXAvJxUE3tTrJOxfoD8jQBXu7xF9BBqRPHxcA8tY2z2WOsyqJTAVcFzU5gd8o5s+IV/+6geNAMRMmUrpli+Lo/QhsacCpZER1/qCtHROzdoFmP9ryLHz8nxSU/S2e3Q9TJonQq55OTjlPbYDtdVNyvt9PB+YoRumh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idt4nHE95GHxc16G43fwI5x1ixPnODFXnTD645nalz0=;
 b=IlQ4Q9kQB1N/H9IsNLWOUbasQvSH01oNHelaI9RxdImTOtGNhzWs5jLHwdcCEg52MnHL85WvO5v5iXeE6UG0i9u8vWiGarhHDu8S2rYvHBxkQfSuCur1+s1MHhCp0gXiG6DLyDRZ73Xpoy6l9JRKKPGybWCwuvs9QrokgaDUZCA=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by CY3PR12MB9579.namprd12.prod.outlook.com (2603:10b6:930:10a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:56:27 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:56:26 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Fix vcn v4.0.3 poison irq call trace on
 sriov guest
Thread-Topic: [PATCH 2/2] drm/amdgpu: Fix vcn v4.0.3 poison irq call trace on
 sriov guest
Thread-Index: AQHcAetlGZHUapeVsUy5D5ikJYHG67RRwfIw
Date: Mon, 4 Aug 2025 01:56:26 +0000
Message-ID: <PH7PR12MB7988AE6C18FD01D6775A09549A23A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20250731071837.77141-1-xiang.liu@amd.com>
 <20250731071837.77141-2-xiang.liu@amd.com>
In-Reply-To: <20250731071837.77141-2-xiang.liu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-04T01:55:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|CY3PR12MB9579:EE_
x-ms-office365-filtering-correlation-id: 4ae14f47-0dcd-42cd-ffae-08ddd2fa1f4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?e0JCxV479qzTryH0INojnDXd8X5A/csaVa+8+5sKWcXr1zx/Gc7GoVRTpdwl?=
 =?us-ascii?Q?876iOw84vjyH9YrXV3OOFJz9eA2DHjByGFi9YFTYb4IUXuc3kZ80AWN5vpFb?=
 =?us-ascii?Q?xrVpffcMURLt94ToLmWQlTpgZUJRAHVWpn/YoLuQF7tbGzLBUjpt8ZUPZ5f0?=
 =?us-ascii?Q?T75WyqElV9CqQHFPSiSww8sPa1Kj9r71/HkrsTpIV2ujpsQlzSA/C/PMzhHs?=
 =?us-ascii?Q?SbYkAZwsvntHeyx2SNmI8BEbhK50keCDfmvabv7FAKYwfurZykyPDytTNvGZ?=
 =?us-ascii?Q?sBjmVyXIiv2YLqqSJAAA9GNPMcXuSJF3tdEC+tBS7Z67LbPnT5Ys7AXhvicY?=
 =?us-ascii?Q?oYPHFKoxeNsh3tIyo6x+aN2JCvaufUMczYiwUMEVwnc64aV1/Jz0d/EgVADE?=
 =?us-ascii?Q?5WXOGBSCQpLJx+P97Ku3WFx8AB1yiXLQX87MAPhLxaZOLoID1QfXjpq3QqoZ?=
 =?us-ascii?Q?KOPzN7giUuPkGpSqS3ts8/NJMz9mfpBorxGaJMqq4wwY/b5EijOjBB39kMwC?=
 =?us-ascii?Q?nFECxjGJeWq2Wr6uR9DCi1qWV1ix/ol70NVcpPD7SCirFa6NLdP2YzgORQtM?=
 =?us-ascii?Q?f6vuLNn4P8MPL8jl3CB8j8F6Zee2lIIb7TmEA3fR85rZIrpZ3ZneUitbxAv+?=
 =?us-ascii?Q?2g+Fck+h4yAtmWPCcg8ABUy1kRqPn9eqJtMzobjMrru5OqfZuhVKBtW/7m9a?=
 =?us-ascii?Q?B3cuTjMr21APeeaNSr/FbRkdEaR2YoWxL0JKE/vgvHe0468ToNF4Gj3M4zeR?=
 =?us-ascii?Q?z0xa72dpA8GpFfau7qtDjJLriYlihZGKoveq9X7rFlBJbs1XeIgLwAxD9f58?=
 =?us-ascii?Q?53o0DkOXWODoDgpUDYfyYNPd3drliKXLCKsnz2rWDKOel2uZooaY4ZdUBoBo?=
 =?us-ascii?Q?O2MkkSMYT0av6UQllNF97hIpb8AYiPtd2dkOaYZzd47tld3+CPud7vQwdYjX?=
 =?us-ascii?Q?A3JNbjyjEiojOC9d+3SKrIFH9yZSEgTSkVNQ1uKE013DhhcojUB4hiaqMCh9?=
 =?us-ascii?Q?FxAxWiiECOiu6dDM/8uEGefRf0Md9JooGq/zi3OHfb+CEVBuQ9hA8BjMWwyX?=
 =?us-ascii?Q?VVmMNJypLC+ZOy+DSnjwVmLfSu5uA3Ru+Drqv2P98sex5nVJaCgmGXAe+cXl?=
 =?us-ascii?Q?8wEITx6PDvHuLCMkg+QkHufuE9IAj/Hklx/yHyrCgTpiWC9UrF5NgEU9444O?=
 =?us-ascii?Q?1Q8vzrvjCQfxSJ1wcGse3WN0yMtnsvhSFBgdVjZg3sPXNtjVVUIVhXKnYimq?=
 =?us-ascii?Q?OFYoKLpyksD3mXRPbIz8jiEgMqY2U2MI0WqW3mzT4pKDwNJ9l6DUhm5wCfuC?=
 =?us-ascii?Q?J5gG/Fk4DzORn+Qmbax0zH1EztjLhzgPMHcLex583Az64j8+t8q4BIzZTfb1?=
 =?us-ascii?Q?pzHjdByTWu1un7uBhxJQCN0wSaHv74sDn3SkXWmRVuAt568fTMxdXD9NZ7Q9?=
 =?us-ascii?Q?QI1/xJIc7DZX8B9nuhiHVU6C44evmf6gh/uiXAFgxxzvzABoDnfH4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YvvvgMEFl1cMvEp9clBsJHSJ3k7ZhHfsg1SGMEcKQobOfRiXAVb7422mkWLI?=
 =?us-ascii?Q?gcvjpYV/3L0NxT+KcJyDWwNLSfKiOq6bLFIj0RxAIsIsRIpxgTZWx5Hw5C1G?=
 =?us-ascii?Q?WFx0t1h6ZSRgGtpD2LIJwj7aEj9zZcLhyiQ9ao9QNCYbM8ykvUzeo4OknAc6?=
 =?us-ascii?Q?Gnurl6OQ8uBDPXIsO9OGewOxBhrmOd2l7Z4oKy2Q9fSv7Igmn/d4JmayI3Hz?=
 =?us-ascii?Q?6f/wvIhm/GUOUOI78iResHib/bkxBpwYfV3swR8OW64Dq1apSVRClAZ93amP?=
 =?us-ascii?Q?BOIhFgORDc89JdPo1JOumGlmz56JqCm6AwzNu32XUOafI4NoQON2EEGmIngv?=
 =?us-ascii?Q?iMpPMMZKkmiz4igE73LWGZrik3U0MUEhOPAVQ0cPTIOrm3/Uk28dsUrX4+rg?=
 =?us-ascii?Q?8PEIkjenVuUKdb9Jd6lR9Mp/DMg2IR8nO9D+4lWAtbdtx0aPKX0D5+tOH82P?=
 =?us-ascii?Q?8WgZuNYJ+ec+Iw27G+HbUsDiIyPU0JKTSgzfqPsVUJlmkfKQuw6SNXivymI9?=
 =?us-ascii?Q?0TuAzZc8kjx4qvSmplPcMdu14ASA6g0AntiAdzOkYDaAjPaFITkeMZtGI80U?=
 =?us-ascii?Q?ELP1aoBkNurr5AXkjEqnYi+2wFs/U9uvyUb76RFFnCfcuNt4Fr2ssOdcvLQi?=
 =?us-ascii?Q?ca8dwsF3HO24yxIG+3OUGW4Szc5RG3GM2zJVJuYRWAzrEbaQmDVoHUTK4ZK6?=
 =?us-ascii?Q?fXtjjvLgc9fmPzqM2PJ7Kb309eBcfykuTiHzwJ6Vhiz5Evyh0Zv6r+lnw0lj?=
 =?us-ascii?Q?Ryu6MXDwRcYp/nj9bv+jT1wvJwDTKSr/8hsgdRBKCtlcz2r4+/H5+EcQtAqe?=
 =?us-ascii?Q?PDl9v6A81Q9hNQSqRseEpwN7ThdYYeq/39QFkc1gqxEbPAxlcFjmPvNhY/yU?=
 =?us-ascii?Q?OKDtvuI4tqYX3seL3tYu00AF2PjeR1vEMWtKVf57IUnvzgn5afpW0in7Yo44?=
 =?us-ascii?Q?uRyOsBST4AKoJrqkK9cM9ecE2bsusQOefVYV6fT3s9grcCRKbycG+JL7Z3Df?=
 =?us-ascii?Q?UIN6CDh5eZLJYe/TDIJnsMLsUq/7v+jRaEOnN6Um0RNEiyGSR7Wsyk2gpp0R?=
 =?us-ascii?Q?pmZhwquI0qg35VsEI9FX7uWjlG470NUxo3lb1FGE7vU1tori5mw5RL3PIsEW?=
 =?us-ascii?Q?2uabSspEHLtXoi5QpVNQZAH8MA6Jq3V70o3j3xj7TT7GTBeBuZGnRTYlX11G?=
 =?us-ascii?Q?KlzgnpcXGzymt3cHEdkxTaEOm2DimeAE9PnSoVQLYW0SITEBOPBKeBmc1n6t?=
 =?us-ascii?Q?lQx6Hjjm1aECN3YVoJsUvxTFnSrCnS6a3zLHKkAggeJ2tWimf/AVU7w5TxmU?=
 =?us-ascii?Q?UKLmPmN37HA8gAVhdgCm7sqMxLKDMaS5ZGlAw2ad0YKd94U1rnf5D2Vj2Fmu?=
 =?us-ascii?Q?FM8uHqeCddyAUSRVxv162WK52QigCyZiktBo2B45cK0PCkV4DObZ6A8L3ym7?=
 =?us-ascii?Q?c44zo5Pol/uc+vQewLpyFE9cTT8WcnBHs20f02W7Db3X7haHHAzy9rIKxgkJ?=
 =?us-ascii?Q?0j21+02lgz6yGWIF3xNiMP1r4AoizRhrtGxJAE1cv9vkPrGbe+KoJNDjd4hL?=
 =?us-ascii?Q?nwyK54JYDhTk6uWfjfg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae14f47-0dcd-42cd-ffae-08ddd2fa1f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 01:56:26.4848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHVRd/oSCdOe8DLIpWfFZXuPttbgktl5VNgVt80eG5+E8p/8EYTDDJEp66vk3nztCS6K7axz0KdWs9TS+cCmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9579
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

The series is Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Thursday, July 31, 2025 3:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Fix vcn v4.0.3 poison irq call trace on =
sriov
> guest
>
> Sriov guest side doesn't init ras feature hence the poison irq shouldn't =
be put
> during hw fini.
>
> Fixes: d260e486d34d ("drm/amdgpu: Register aqua vanjaram vcn poison
> irq")
>
> [25209.468816] Call Trace:
> [25209.468817]  <TASK>
> [25209.468818]  ? srso_alias_return_thunk+0x5/0x7f [25209.468820]  ?
> show_trace_log_lvl+0x28e/0x2ea [25209.468822]  ?
> show_trace_log_lvl+0x28e/0x2ea [25209.468825]  ?
> vcn_v4_0_3_hw_fini+0xaf/0xe0 [amdgpu] [25209.468936]  ?
> show_regs.part.0+0x23/0x29 [25209.468939]  ? show_regs.cold+0x8/0xd
> [25209.468940]  ? amdgpu_irq_put+0x9e/0xc0 [amdgpu] [25209.469038]  ?
> __warn+0x8c/0x100 [25209.469040]  ? amdgpu_irq_put+0x9e/0xc0
> [amdgpu] [25209.469135]  ? report_bug+0xa4/0xd0 [25209.469138]  ?
> handle_bug+0x39/0x90 [25209.469140]  ? exc_invalid_op+0x19/0x70
> [25209.469142]  ? asm_exc_invalid_op+0x1b/0x20 [25209.469146]  ?
> amdgpu_irq_put+0x9e/0xc0 [amdgpu] [25209.469241]
> vcn_v4_0_3_hw_fini+0xaf/0xe0 [amdgpu] [25209.469343]
> amdgpu_ip_block_hw_fini+0x34/0x61 [amdgpu] [25209.469511]
> amdgpu_device_fini_hw+0x3b3/0x467 [amdgpu]
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index c51dc401226a..c6450ed65c12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -384,7 +384,7 @@ static int vcn_v4_0_3_hw_fini(struct
> amdgpu_ip_block *ip_block)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>       }
>
> -     if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> +     if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN) &&
> +!amdgpu_sriov_vf(adev))
>               amdgpu_irq_put(adev, &adev->vcn.inst->ras_poison_irq, 0);
>
>       return 0;
> --
> 2.34.1

