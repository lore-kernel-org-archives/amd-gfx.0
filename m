Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D4D2592C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 03:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1608310E124;
	Tue, 27 Jan 2026 03:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="teeb9VFd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 203BB10E124
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 03:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnQGS0Tfgvsod4u5jqBAEq6Rc0RQCLaqDL9JlgF8az0c6rKJKsxuOusI8meFq2byRc9Z/uYDAQYydLY52l/yIqrQXYdLwU3DbSXn3XeOTKQ0deeRvYfhJRtBzVcMQen9oSLFAZB3Jc2xwGOCfh+jimQQkGyBrpKT49jKVW5JUWBHY6zjbtNFrKWExnLEx2tzy4VXq8lFn9DI0TCdx077t1pYd29g1bpJA7JUm7AzZ6QclnER1vMF8CaRvU3I0j/P9rT1ARb0i0FgIA2YJ+iZUaOi3E47Y09f8FlqsxNKhmRycr/kDPGPUVrUjk+qW+iIU2MW7C93zhx8QE3NEu1KWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uRQffoQUUV9D+/yE/wGPdK+DPER3hilRqnvoHFwGzw=;
 b=vcSJkSW5XE1MQS4IcwwgHMJIaK/pgk2fDLW41fCCNFke9OQyAmrFzi58XN+yNvnAS/UyUmn3ugxgWaGE5paqeDqApoPRXs7BipRyiHtJtRNeYv3KY3YVDaEksOKAsG2A1yLLChWlf29+a+IS7YbZ4WIDzEX40U9gDuKSwx8pU1Dwmetd/q5zfoV1exAHn3kZKWtgtmnVKxTK2LioZCLxQPHOuRFI19aJ4aOXYSiVnuSlwghOQmY8MYcS2AUhp4/yyraa83GS5MfInjDhVrGlXD90HhzYGHQBoeSHORtAihrbZ38FRK4QD3rEOw+MT7ehOCRVKUhMOD+XqvyTIQJPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uRQffoQUUV9D+/yE/wGPdK+DPER3hilRqnvoHFwGzw=;
 b=teeb9VFdwRVSKQ6+viaofCrQDAUAOqZMZU46m5jHYFZK/suO78tmEovqL7pT9Guknp+N9OP3lkt9La9+gSLHlgKFDCGypI69BCIFfx8WFTq31XZO099gp4ht2zdDItAcaS5fydig4Sa38fOJUcN996VLlMcnBvYLm1e8vf0Dmdo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:53:32 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:54:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
Thread-Topic: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
Thread-Index: AQHcjnetI8YRDo25U02PS6LLd68AsbVlY/Fg
Date: Tue, 27 Jan 2026 03:54:04 +0000
Message-ID: <PH7PR12MB8796F858979F601C30DE07D7B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-5-ganglxie@amd.com>
In-Reply-To: <20260126035527.1108488-5-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T03:53:04.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB7601:EE_
x-ms-office365-filtering-correlation-id: d0246f6c-74d2-4091-093d-08de5d57b6aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KJZk4ElIWEmmHZxn3kZY3kuh7w0xBhAHmooOx6n0xH6ZwJuvW+3kDcg4jwhN?=
 =?us-ascii?Q?VB0+Ol3AplV1fq5MPK0GTHIaqV2tO2AmyuBDiEe863k15BLC7Gii5HU+rMs2?=
 =?us-ascii?Q?h1ASm4ilw5l9dd2xrYgC0wbdorIsIMck+zRyE4omTDMO6zxGZcF9Y+/mMVRy?=
 =?us-ascii?Q?b3ssJBgeAGGrFVZHYBuAtosWdgOl9zS8kVjHCEvieOzCEhViIGGRkQ9+RFvC?=
 =?us-ascii?Q?v0v4XY/zN0WB4Me16u/4IZjR6yhOzvq7zbiHv2f2TiABgnphMPmYVCiIaRda?=
 =?us-ascii?Q?3XB+43tuc4In5hso55w1t0AAtO+ryb59q4NKePjt+XFowD9Lex5R8r6EYp/M?=
 =?us-ascii?Q?iMaMwXxOC5K1SGjm+wrM41K3e8COmdRokgj5BKefVBMElS9yrweew0jddE3R?=
 =?us-ascii?Q?zhzupx4mu3pJcjW0h44jPIWbrqpCmWpMaqrn+sfXOjk7lk3RupNFlNrKcYIh?=
 =?us-ascii?Q?Au+/Z5RHn7rYagQTwgFupTIjQbE1Id+YRY3KX5+XZ1e8GBGAN2JYKIFmMRDH?=
 =?us-ascii?Q?BSdATqxhrOzkfxwQBXM/fnw4xG7CpsTrZiKSBdIhsaryeXKYcH4UTZvSQ+sM?=
 =?us-ascii?Q?etFv7F8YqA2kOqM6Zq0x424qSpEYVUbdkXbHWqhhHFqFFPyP9dv8TTVFeR8k?=
 =?us-ascii?Q?7IPJRo2QuEK+d+NnzTBDyx44+9WrMq0zzePpuHXD9QGtsOqROtNyewK/8CKs?=
 =?us-ascii?Q?5yzbsNvL1Sqdxqyryo7/jdThog7E3GRiICGoeNoLbw1rA845wTvw9j3A1NzT?=
 =?us-ascii?Q?OYGejbXzOMgUBTQtWiJFrXe82nArfjet8Wnv1Bg6KBfvkR8n0imD5olCvMnU?=
 =?us-ascii?Q?0D01g4geUweOzrYix6TUE65AYmPM8v9of3ZTndnksrefaJWRvYRqKUg+95Sw?=
 =?us-ascii?Q?mIP0PRGwkVds7ZqJuAi9VpQ4XRj607M/5M/0kofBRHZhdoR2fITGvvuHID67?=
 =?us-ascii?Q?IlKoZ3zs/QnSH/YZr4x9DTvU6kgQeX+IlY1EhkyqxgN2Lfuy9ByjGJceC2r6?=
 =?us-ascii?Q?VAXymzOZn4iJunHkRKc6R3PUkmOL7QMWepN11CC28lxDYOMaQ3cKNTLv/6nw?=
 =?us-ascii?Q?Zrp3pxcMjQT9wo3rGuNRF6H/xptKnZ9DwJOh48FBEcHRr7WUyAby3YUchJmA?=
 =?us-ascii?Q?Aynb58bpjE18zE9ZmU5SaCunuMSgbGNzRfgvqeLJxfhTFcV3BxvCBsXbbRjB?=
 =?us-ascii?Q?7zHI1yeOnuk79xK77JIElIsFpmKXB+zeIu4GYYPfjSxMk2Bl/Y9QQXHu6/Lt?=
 =?us-ascii?Q?561Le1uLctT81cbk0aBzb8qwCxGHYOKdhCe3rck6oo28hzyUHqukeLz5cV+j?=
 =?us-ascii?Q?gf+dQlLx75t0ebMJB/PqO0mcsq/LMGlAaxZaisSmGsBJogKyExqv1gxYj2ph?=
 =?us-ascii?Q?MU0CeK5wEmifJpmOQ+gatMNxzLgUBwBJdzAT2mv145RgHrurIG/IiUFUSY0d?=
 =?us-ascii?Q?fhpOyWdcR4kdyBw64eqGPsaFA3cqvwnBmPXsy79lmancb186JgIgkSBWAy4X?=
 =?us-ascii?Q?7jrNfJs8LmDiyY+HIQLCj/USJh07/k56S2YYhx+ENWmpgpWT/2xALEtYlwls?=
 =?us-ascii?Q?o685aKRGvs6IKWV2eL8GNOd6arUGyWfY0wUvrRtdMf3SArESieIP2gcHLyU0?=
 =?us-ascii?Q?p6fs/z+Gr7EDT2ekyVrCa1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40PJmxuePH76MJc0XNxuEeD/nzuhO5TVMD5sceOi9M7MYxWmqdD5f+KRLdCx?=
 =?us-ascii?Q?XOTxUnP79b+vamPzFWWqh9O0803uFmjLf7hNh3cospaf3barZ/18oXVRuhtT?=
 =?us-ascii?Q?KAZ80dmTRurabLJeXpkc+56HIY1LgNWw6Hdj5YD04AfjxxOc6TGM/hcxn+Nm?=
 =?us-ascii?Q?CWgPk6fTCPQMuv11IVEhakDmRbWwwmDA7IFv4Xh3OroOzDl08GtigLmoX/4h?=
 =?us-ascii?Q?ZBMtf8/PsH88ZWKKkKfiBG8/CTDE15u5BdVvebN3zJyxSIG6sPl+Kut2tyXx?=
 =?us-ascii?Q?tDFQiHyh+VF++1xiNTGDMWUE+ayVaUNkX9cMr+GZa6W/4Uiva0jMKUlnbnzO?=
 =?us-ascii?Q?JNiqxpnIWAdHKyUcd3xbk3pG5DTtTk0SmFDEfe2+xigkl2vWyDSfVwwt6seI?=
 =?us-ascii?Q?idsFWSUYRZ9MEcf6+PjTkmfvGl3fgE2r0JnZwSaOYlaqKo/0+HWTzgdw0nJ4?=
 =?us-ascii?Q?9unvorQQnlVOAzgNoFbwffKkmgjp7T0DCGH2bS4lmFbcaiJUhlj84TzXrtaC?=
 =?us-ascii?Q?FAnOc/4FLH4mHNwgowSePnDqp3sCiJBqJvwg3z7igxVbJk808vUgUYOMYkSd?=
 =?us-ascii?Q?3aO02h2/B5dNfLOC3HeWWPTK/Y/MxuX2/ERURaBQ3quQB8ZJ/KfC/ywywJas?=
 =?us-ascii?Q?4Yoj4cz/HeK1N588C0zT5FiOcQfZZu5tyNB9fBEgZ0zjZc9V401FEzyrwEAA?=
 =?us-ascii?Q?e/HlYtygmx6taSnVcyGhZciHLrMni/U8/tv60+4KvVNRLxraRr3GchBd6isN?=
 =?us-ascii?Q?QtmD++fk/eSlU0BHslk7rcuDJ1kwsUgJ4dsM6nE3ujWcssyDcAwj0dWZkPwK?=
 =?us-ascii?Q?jV2vqQzbZ5+EMrGiZeXWRuOlmpwCMzRWukBIGXfUFND4LXhPbXr1YMSdSVZx?=
 =?us-ascii?Q?3ZR/1mv8TihA+bhbkZoUQqky8bnIbqiPV/3R8ikw6rrh4tAoSLhrb9P+5Wtg?=
 =?us-ascii?Q?2yD6cJc/wf3HwoDVf0o6ADNkftzZ1holttkt+RHVGcjvdbj6gWyAjL3UzjhJ?=
 =?us-ascii?Q?q2812r7Qhwiw8OLF4FQJv1tR8nZFhr7H1ftTQjC/cOp2SPNjmlTRNSBX3Cw/?=
 =?us-ascii?Q?qD+GgDZvCZrvbunDi3e6IALI8TNcND5z5yMwo+C8RH/mAj7J6CpETHtl6Um5?=
 =?us-ascii?Q?2sRA8UHtF9mQpf0xLYZyFsRl1tW3Ryzi3p2N9PCSYv5dxuMPSlvfRld/EIA9?=
 =?us-ascii?Q?66k0oq9I5skqsD5j0DD2rZJbipnTJtYsbrQleS0f3eIpMgiozNuJ8YGd1nCB?=
 =?us-ascii?Q?GODoXaTQ6ShP41X5OPOblYutUPBSBbZk3+VQWF++K5/rSmOUw/uH+n0MJG1m?=
 =?us-ascii?Q?x5f7AfKGOTTkQpynIYvZAQHy6IOJDWeefjhdzR6ZKSpI7pJwnxHKpHKNYWJy?=
 =?us-ascii?Q?VpNtIcQYTCEa8Iv+H02W1VvSkgZylUtj/tFSOcq0tUZgjcqfKu2hhSI664ND?=
 =?us-ascii?Q?BvbjOThjiGXWdqDyFtRzzWK+iWVSQ/YapQ6XHykoHFXmirM8pUPfHnTBygWH?=
 =?us-ascii?Q?18em7Q1QmXZN0zoRxwGXG4irpfMQ2yLGhBjzPK4CYiGmRBP6YlPJh2j9d4q9?=
 =?us-ascii?Q?jRTLCNo3974PFzarCf+19lUkXbLhny50YQlL8cZF8r6C+zmHrUPbBW7VWb5Y?=
 =?us-ascii?Q?ylbsTIBfOA6kEQ9kTqpvg0pMRbTS/nvjJe6NrTBw7b2E+GvZzkWnbjn10Fr5?=
 =?us-ascii?Q?hWLPRIOck8rm9GLa8Xt2FwbmLiuqgIjcGIm1fmOsDGrBLxEn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0246f6c-74d2-4091-093d-08de5d57b6aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 03:54:04.1302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ux3RqEBDaMGALqSDcLBJMJUHkXOT4fb7C/YobvfJCEDUvMsL20g6OLRLxRvoPZ+d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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
> Sent: Monday, January 26, 2026 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
>
> add wrapper funcs for pmfw eeprom interface to make them easier to be cal=
led
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 125 ++++++++++++++++++
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  16 +++
>  2 files changed, 141 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index 4a65351569e8..5231dfe8c518 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -36,3 +36,128 @@ void ras_fw_init_feature_flags(struct ras_core_contex=
t
> *ras_core)
>       if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
>               ras_core->ras_fw_features =3D flags;
>  }
> +
> +bool ras_fw_eeprom_supported(struct ras_core_context *ras_core) {
> +     return !!(ras_core->ras_fw_features &
> +RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM);
> +}
> +
> +int ras_fw_get_table_version(struct ras_core_context *ras_core,
> +                                  uint32_t *table_version)
> +{
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +
> +     return sys_func->mp1_send_eeprom_msg(ras_core,
> +                             RAS_SMU_GetRASTableVersion, 0, table_versio=
n); }

[Tao] do we need null check for mp1->sys_func and sys_func->mp1_send_eeprom=
_msg?

> +
> +int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
> +                                  uint32_t *count, uint32_t timeout) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint64_t end, now;
> +     int ret =3D 0;
> +
> +     now =3D (uint64_t)ktime_to_ms(ktime_get());
> +     end =3D now + timeout;
> +
> +     do {
> +             ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageCount, 0, count);
> +             /* eeprom is not ready */
> +             if (ret !=3D -EBUSY)
> +                     return ret;
> +
> +             mdelay(10);
> +             now =3D (uint64_t)ktime_to_ms(ktime_get());
> +     } while (now < end);
> +
> +     RAS_DEV_ERR(ras_core->dev,
> +                     "smu get bad page count timeout!\n");
> +     return ret;
> +}
> +
> +int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
> +                                     uint16_t index, uint64_t *mca_addr)=
 {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint32_t temp_arg, temp_addr_lo, temp_addr_high;
> +     int ret;
> +
> +     temp_arg =3D index | (1 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageMcaAddr, temp_arg,
> &temp_addr_lo);
> +     if (ret)
> +             return ret;
> +
> +     temp_arg =3D index | (2 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageMcaAddr, temp_arg,
> &temp_addr_high);
> +
> +     if (!ret)
> +             *mca_addr =3D (uint64_t)temp_addr_high << 32 | temp_addr_lo=
;
> +
> +     return ret;
> +}
> +
> +int ras_fw_set_timestamp(struct ras_core_context *ras_core,
> +                              uint64_t timestamp)
> +{
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +
> +     return sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_SetTimestamp, (uint32_t)timestamp, 0); }
> +
> +int ras_fw_get_timestamp(struct ras_core_context *ras_core,
> +                              uint16_t index, uint64_t *timestamp) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint32_t temp =3D 0;
> +     int ret;
> +
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetTimestamp, 0, &temp);
> +     if (!ret)
> +             *timestamp =3D temp;
> +
> +     return ret;
> +}
> +
> +int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
> +                                 uint16_t index, uint64_t *ipid) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
> +     int ret;
> +
> +     temp_arg =3D index | (1 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_lo);
> +     if (ret)
> +             return ret;
> +
> +     temp_arg =3D index | (2 << 16);
> +     ret =3D sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_high);
> +     if (!ret)
> +             *ipid =3D (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
> +
> +     return ret;
> +}
> +
> +int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
> +                                uint32_t *result)
> +{
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +
> +     return sys_func->mp1_send_eeprom_msg(ras_core,
> +                     RAS_SMU_EraseRasTable, 0, result);
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index 58472e459470..ad98077d532e 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -24,6 +24,22 @@
>  #ifndef __RAS_EEPROM_FW_H__
>  #define __RAS_EEPROM_FW_H__
>
> +
>  void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
> +bool ras_fw_eeprom_supported(struct ras_core_context *ras_core); int
> +ras_fw_get_table_version(struct ras_core_context *ras_core,
> +                                  uint32_t *table_version);
> +int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
> +                                  uint32_t *count, uint32_t timeout); in=
t
> +ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
> +                                     uint16_t index, uint64_t *mca_addr)=
; int
> +ras_fw_set_timestamp(struct ras_core_context *ras_core,
> +                              uint64_t timestamp);
> +int ras_fw_get_timestamp(struct ras_core_context *ras_core,
> +                              uint16_t index, uint64_t *timestamp); int
> +ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
> +                                 uint16_t index, uint64_t *ipid); int
> +ras_fw_erase_ras_table(struct ras_core_context *ras_core,
> +                                uint32_t *result);
>
>  #endif
> --
> 2.34.1

