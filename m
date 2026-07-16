Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DADC44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 01:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A898A89F31;
	Thu, 16 Jul 2026 01:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLrNl0qa";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89F789F31
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 01:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrJj1aAPMBoIjJRwkD2Cnmm+zPnmPhTn5RYsVYJYw7g8OSl7OAdnL/0i/tQWyvs8s0ubSgNT9syXLqINrG8x/2xbceKtKX/Tl+dsfXfdJnJKxyhtI/AxFJehfrMc/SpxjLaT3Uxh3PktGq8q5PtQamoDkfNe8fmUlQUuuEYXOzyDCyrB1HmiseU+n9qBIinfLRcBeIMG/3Q6Vrl5O/rLZdRBW+xdVjLVcMvBvJkIbM8dsyeTP3r+GeSMiy8x+AIV4hRS1w9lArXk6ksGLt0GKSihhOnZq5vPOoNTzBfDaJqUFYqwgyr7H641nc+9JKv6faAcGIW8DKq0FV0GNzaDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPiaol2/NHy0qOzYub+D0g2a/THl8odBXo8d1Rd6F4w=;
 b=F1PINhzvd8VIzWn0K3cDRHog1aoagUa9KtTZpo9VS+7pamyLB2fil5b9/pIAN1BL1/UXHH2YqrJU9OjOiZ1GagT6iZ6pVg6UOVhR2CmlPCHjXHN9Qssh/KHZ/4szO0Yl/p+07Y2FFi8KjgBr1G4I4kCfnvVB8rCu6q1dD5/GsvpH1b9EXL2rxwOjLVf5M6ocWTs5HSxKTPq2ZQg9QQ466EXVsZM/QwhPO5iY31evBSt8cJ0sYSiu97HLLZwzfKwRZBKFl5O8WinBX2HSSA+3IRgxqIrpZRO00aIt5/0Gl8slptPBakc0N+A4zLZMHnrKCRlQaXrcEXq+kaMl6/67sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPiaol2/NHy0qOzYub+D0g2a/THl8odBXo8d1Rd6F4w=;
 b=VLrNl0qa3mvYKj8tbzsr1GFYp5dUZn60UZSSxHbJ0c/zPtKXktrMoeehWHARAJMWnQy3pIzt2qj2S/5UjfhCWIIyigPhMreuibl0tTT67YmWf8t/Fxsb3WaeJwaCNGDjsQb7Z1twJcpYi/4j/SoS9dKdA0+7QWnv2T9S1DIvC3E=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 16 Jul
 2026 01:40:57 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 01:40:56 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
Thread-Topic: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
Thread-Index: AQHdFC5DMpca9Jlxu0CxiTxCrljdR7ZuUFgAgAABtACAAQu1wA==
Date: Thu, 16 Jul 2026 01:40:56 +0000
Message-ID: <BN9PR12MB530619F56C12D005A3A1776FFCC72@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-4-tao.zhou1@amd.com>
 <BN9PR12MB525757867B3C2EB0FED0CE73FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH0PR12MB512339D00AF5EA7400D2D45EB0F82@CH0PR12MB5123.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB512339D00AF5EA7400D2D45EB0F82@CH0PR12MB5123.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T09:22:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|PH8PR12MB7159:EE_
x-ms-office365-filtering-correlation-id: c239740e-4813-46c1-dd76-08dee2db481d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: YjRx/MJNeuvBzbuJKBbws2v/ilS3DxfUI4FYJq3y6tGzFlY9tDreNf1VqSjOiUGjec+MwEAk379UnPCxv08v/+iFEdb4s9lvbbYtPX/gfKykaktujlJbRxx2vmUSTKtFIhbIktTU3C7fN2VnMfGkQtqjPGqBE0KKG+TMenKMidybYQpXHMQX8ObpWO0AbWg5aX24U4xpU/GfQyy8P9Z9zD145ZqLYQbioWGSnmqB4pA6fr9+ZzZCtsVU3cRONnknqa/N/xG7igKeaAEpARSTQH14IWPfUBINkE1KVE7EmTzlVDPD399ur+IdE4YELYYgCe0Yvxd8XqbPsEO7aPXCso7WX8DDHVxHzBwSpYZbUgQgUyl8zx2SlF7DRQVmYh2OU2FZQYtsEk7UbUPWZMBM++QqvwzYNoACHUJSKUvX5Z6+NETVuZcGJTYQkPrygda2pp4mOd8ABf2FXTdZvxuf75CcckwcIW0JdMUQxx/F2dAYW0mwOvRjJsHExvnqnwaGuri9REnH85wX8L8mok0ZoGjrq+fzohwQ/+m5aSKWXZ19u7qQ5ptoZLoN2/bku6IXvrcp/bJaFC4Ub73UzQyppvNXy/mRoUjkqzC2qN7hTfjrHoQB06puGIJLWeEzsZgMswCVQx4LBpTvxqOZ7qoa3mS+BSfBFKH2Wdv9LF8GZEYqLmzh19TIL9gc+xu5cvXu8eZu720au8TprHpNGG4sLCijtWMOx9xd/tgSnwb3r5Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xGleM4H0n5TEV016Vv1RN2/c8/M8rdflPZFQtfOaDpmA5gYyVuT/NXBI46Tt?=
 =?us-ascii?Q?HVaKB7WinI/z1peiGILMQmXegzPGLFoAocXp3nap6Iu3W42LFn+O3oW1yOY6?=
 =?us-ascii?Q?6HFtgkeehoEFnJPhPYK0PAHXnZOJ2zxRI+Bc+2EXjtm0NOfPzpG4zDu+bG9+?=
 =?us-ascii?Q?nnN88aL6ulLNJNf7tgTeY8xpidzhKf+mMIULIQZRa62JaQAv6Pj3wE2KZ+q4?=
 =?us-ascii?Q?+siE3StuYREYb0RW+33qXC29ik9wwsZJG32dEXM/iykHBm975WQznVcuohBn?=
 =?us-ascii?Q?xgVQJwJyZhgJjdSiBHAd/caglaF4Yf9oyIWQzhwB0Yt1OLa/ghotvgLMwYLR?=
 =?us-ascii?Q?vOCqrdws9ZyhQtDT5kwGdQ6GQehsJRD/GKcv66+PMHHEpzuYV9Zb+QzX3hne?=
 =?us-ascii?Q?gTPusv9lYhfcVCm8wnLnqI14eRaKQb39cJFsBggS9qnhHwExh+Ac7w6wY+HS?=
 =?us-ascii?Q?9C8y1lmklHQDMYiUdCRyX01/GPSR9SfIw00FN3NzXRMytBbDXgwypZrsfseL?=
 =?us-ascii?Q?JM6wT4iTgtMKBAb6SgFx3Yw5+IjJzCLVE3q+c3vGCfTC+TE2OX4UelErTmjV?=
 =?us-ascii?Q?1JSe7n5fV+1SKrNgq+kORqwYKwsVh03McXvxfLVkStpj2fJrgChiGq1XFcQ+?=
 =?us-ascii?Q?LVzSMbIDbwsVsEppoow7yKwZ6duvynLopbI9MIqeGCpsdnp8Fz9xxXSAZDto?=
 =?us-ascii?Q?JWpk2+NU8G/e54Zl71Q1CinC9kirzBgSdkG0+jDNCFvA6zCt05IW6BpaMB5w?=
 =?us-ascii?Q?LR2tf+PbMAzXIxdqwOR0a2UrkgkW6gGEaZisbhOWgIaVNFo2W+nPxNFhxbRV?=
 =?us-ascii?Q?fcq75WTQGwQIQoVM+EC+UWetpEGfcf6x1UH1LlCbxPCyCQyy7fYyf9F7wsdB?=
 =?us-ascii?Q?czl2A3FZHlxI0t2cNpmjBPAcYNxzcsmIe+Lt7IwUorbPq3zwXjMXrepUcP9v?=
 =?us-ascii?Q?LOodwl7DvOiJiJlwaQ/crXuNeThDaexX+dKOQRPFZZFjlTk0lcM0F2Y0dL0+?=
 =?us-ascii?Q?zhDUsxVK9ULlbzo7C6iQAbryX4XdoTBdK5D/+xg//OhylYwHz02UFE5992jy?=
 =?us-ascii?Q?9BCQfEIjQBUlBHjoJSm9ALNuIDeaZLYszSNFXpNibTBD+mM9DN5246znaqht?=
 =?us-ascii?Q?eBxN7wyURsO2qn+uIY2yN7uErkHpC/rkaetqOhJbQUyBBlcX3kVGlBLpEogt?=
 =?us-ascii?Q?dUhq3O0EEf6L0Avzd+TDZm26Suh3fJInS/oAzjkzZCfRnPHAf1vRLhV3W8CC?=
 =?us-ascii?Q?FEOAIlbsg9bMiIi12uIOAgmpCpt9KgfabPCWmPLILgv2IsMeCMOlFNUhMrqQ?=
 =?us-ascii?Q?JbdaExVNe2NZef4UEQ4OAeS3KkFwJa2qHdR0muBTU2X6jlRnP5HFEzuK5MF8?=
 =?us-ascii?Q?D8YPAOa7NMzYTujWUpisyiDwQ+aJmPHNmHZSzosVTwvdOvKYQtr8oOnHAtQ4?=
 =?us-ascii?Q?RtXWPfVctVtggA5mQ+KMvUeg55guusNTtn6m1hPTGV9Ro8OFdo5plVRp20xS?=
 =?us-ascii?Q?jGN/RjPvNels2SDK7ViDT4Qm/GI7L1EJDdy5yP0QRs3P527zbpwHji3uifX4?=
 =?us-ascii?Q?L0VKaXV2MKfwH6+SFWE1ctZxusNwD/9YYvKjB/o2W3b5ocRy8tDShydUSSRY?=
 =?us-ascii?Q?bZXO10dJwdAF8MHyAPPbXSFcio8YTXMuh9I7sqFH20kYVybaowQSsqD5Rl+R?=
 =?us-ascii?Q?AtGpJh++61W31H2fa3VT4CFhZLwGyvc5AsNJw98QfExm1qMg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c239740e-4813-46c1-dd76-08dee2db481d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 01:40:56.8334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiT/NciYSMpBlGAd90hmzGf5FocWUAhcFK0rJGeD+uAQcYigztmzEGLR5A5oc3VpXCHArqsCBhSOdMuUVEbsNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

AMD General

Best Regards,
Thomas
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou1, T=
ao
Sent: Wednesday, July 15, 2026 5:35 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 4/5] drm/amd/ras: add real ras deferred error count

AMD General

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, July 15, 2026 5:29 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 4/5] drm/amd/ras: add real ras deferred error
> count
>
> AMD General
>
> Can we just use ACA_REG__MISC0__ERRCNT instead? Was trying to
> understand the use of real_de_count
>
> Regards,
> Hawking

>[Tao] as you can see in aca_parse_bank_default:

>         if (aca_check_bank_is_de(ras_core, status)) {
 >                ecc->de_count =3D 0;
 >...

>for non-umc blocks, the ecc->de_count is 0 even aca_check_bank_is_de is tr=
ue, so I introduce real_de_count to represent the status of aca_check_bank_=
is_de.

[Thomas] Can we add disable ce log check to here? If ce log is disabled the=
n set ecc->de_count =3D 1,  so that not need to introduce a new variable?

BRs,
Tao

>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Wednesday, July 15, 2026 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
>
> It only depends on the status of ras bank register, and can be used in
> common aca layer.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_aca.h      |  2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 18
> +++++++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> index f61b02a5f0fc..0bde803f7472 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
> @@ -83,6 +83,8 @@ struct aca_bank_ecc {
>         u32 ce_count;
>         u32 ue_count;
>         u32 de_count;
> +       /* only depends on bank reg status */
> +       u32 real_de_count;
>  };
>
>  struct aca_ecc_count {
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> index 840610538c1f..41df331587a0 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> @@ -207,6 +207,13 @@ static bool aca_check_umc_ce(struct
> ras_core_context *ras_core, uint64_t mc_umc_
>                      !(aca_check_umc_ue(ras_core, mc_umc_status)))));
> }
>
> +static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
> +                               uint64_t status) {
> +       return (ACA_REG_STATUS_POISON(status) ||
> +                               ACA_REG_STATUS_DEFERRED(status)); }
> +
>  static int aca_parse_umc_bank(struct ras_core_context *ras_core,
>                         struct aca_block *ras_blk, void *data, void
> *buf)  { @@ -230,6 +237,9 @@ static int aca_parse_umc_bank(struct ras_cor=
e_context *ras_core,
>         ext_error_code =3D ACA_REG_STATUS_ERRORCODEEXT(status0);
>         misc0_errcnt =3D ACA_REG_MISC0_ERRCNT(bank-
> >regs[ACA_REG_IDX__MISC0]);
>
> +       if (aca_check_bank_is_de(ras_core, status0))
> +               ecc->real_de_count =3D misc0_errcnt ? misc0_errcnt : 1;
> +
>         if (aca_check_umc_de(ras_core, status0))
>                 ecc->de_count =3D misc0_errcnt ? misc0_errcnt : 1;
>         else if (aca_check_umc_ue(ras_core, status0)) @@ -240,13
> +250,6 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core=
,
>         return 0;
>  }
>
> -static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
> -                               uint64_t status)
> -{
> -       return (ACA_REG_STATUS_POISON(status) ||
> -                               ACA_REG_STATUS_DEFERRED(status));
> -}
> -
>  static int aca_parse_bank_default(struct ras_core_context *ras_core,
>                                   struct aca_block *ras_blk,
>                                   void *data, void *buf) @@ -266,6
> +269,7 @@ static int aca_parse_bank_default(struct ras_core_context
> *ras_core,
>
>         if (aca_check_bank_is_de(ras_core, status)) {
>                 ecc->de_count =3D 0;
> +               ecc->real_de_count =3D 1;
>         } else {
>                 if (bank->ecc_type =3D=3D RAS_ERR_TYPE__UE)
>                         ecc->ue_count =3D 1;
> --
> 2.34.1
>

