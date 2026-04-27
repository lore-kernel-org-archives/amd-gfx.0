Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DF2FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D4810E8B4;
	Mon, 27 Apr 2026 18:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="REnRuyhz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B83C10E8B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKWCa50PNqk/yUgDvgCKx+tjlHjGujc0gIjthjcKT2P3MHsjzo/X7hM2flN5Ull2NChInkVAqvBsYQFJX4Y5wxUt5BVVAUtpxh98cpcraD6aPIqzttyYZCpmiOU9ZLhJjrUbTBwYlthHoc6l3lrbcAWP+GdUTgzLmmvizkNeGrRG5qHy2/1M5IzfxrjtoZZKN/7j4O9pXMS2ESGWMDNbmOFHhJsjajsplCizzDvv4rPFLM6vlMSTYK+6p3twxshAYKk1ayFLa8uqh81f1xJ7oNQJCVNXtGwTAlhEqfle8RY8bqIP2LwY/tmu5aqRHbqIpG7Lk9n5aQre5d+hqGm3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOiN8uOaZOMtcR+tjz8lpEjfKtwvgVHV2HwLEeF/yqk=;
 b=XzV53rantUp5cbLf/M4SfwhYD2Hu3RMeER+0jINqpJt6XgNgGnYN0lwQ/DJ5E3m977rWqBgQ2N7dKA//Q/6W/Y5Q4iFwXDdXkFj7KPAPQEvsoluMi9C5ZwtqPtuR2gpXb7VEiUDfsphB8qZnaWECsymWabQyQNDBPCofmkgT36G5IX7GYweoQs60xWu789upgMTpEv/XVR/RPz9YspOO2V7/W/GiZoPgyDWwNNOY6NO2vSGceBhpOnvVAJmcyCQLwBOSDOGRs534DAO99cVVXDoHQFa93ZQCDwStzbK9uEFElEryNdIpOKn74pOH/UQg+ZQFNUxOe4cU5HxWGPJHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOiN8uOaZOMtcR+tjz8lpEjfKtwvgVHV2HwLEeF/yqk=;
 b=REnRuyhzTxL041MYNYXQYl/Mb98Tkqr9IWY/HfaOJX1rqzfS5STWYi4UG5UewEU0UsCj56JYDAmyRzeDFt33cM514mXpYV2bLYkyfFfuRsNZ4yrRnoy0SRt/lS/hSyf1yajpkQgMCi7YXdZYBbwhQQsrQuQwrx2yWg4gvVlB+OI=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:22:28 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:22:27 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/radeon: add missing revision check for CI
Thread-Topic: [PATCH 2/2] drm/radeon: add missing revision check for CI
Thread-Index: AQHc1mu59BNsMubgikmOnh223xECobXzOG6A
Date: Mon, 27 Apr 2026 18:22:27 +0000
Message-ID: <BL1PR12MB5898C7318BA869022163968E85362@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260427173103.1020723-1-alexander.deucher@amd.com>
 <20260427173103.1020723-2-alexander.deucher@amd.com>
In-Reply-To: <20260427173103.1020723-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T18:21:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|CY8PR12MB7514:EE_
x-ms-office365-filtering-correlation-id: b85080fb-0743-41fe-8788-08dea489efb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: pSx0X8UvizTtomwIf50hb3r0i0OwYrneKg+g5aFemCYJ0dHkudAD6VUdVZx995dr8mH0FK2Zmfw14wfUFsbJm763ywrSTtpuXawFDnI4h7q5BHrbr4xqTcDGv0+HtRBm2ggl7lRE9T1X472rRgPLwdyixOr0KK283aYDfLBYuheBiSY3bztVxBjI52ec3grvBSBvnhSFPEmEw9kPXaV5NhOCaJsKK1cC2cM1KGAsAMyMNuj/FIzs/9tSfb4tf7le56tFxQX16fXgR7fO+fuIZq/w1kbEVjjjJXUwyD630Yi77pWNAL9t8j6WMxB8kwLJOYuTgbI9RixcYOV5EW4SzNYGSpmp9mf3DXZXR4ACXQBWCzxUS8k1pyT254E0y4z+CoQMiZ2J2tufk+nVeJqk7P3fhWXPRp1HL+U1Os6ke6oF/JtZ/HkevzkoslX7wOW/cLrnnmyRLa/Kzgt94D68FjeagF7jyQc9ndbiJWude+vFaY/uWJYr/dqVrsWwDuIj3gwO3t2qVlVKfqrjoqTrZVKZVbqbJRFnJKQYUNoAZatFVG5AVwo6Z+zCytaqR7TG5k37V6+IGhLPjor6/zg9k255nLlPQoj2tD5xpiNs2kEV5pbJdZlVOdpG+zQSLbjyybncsPaX7bXNk5qDYdumlussj4LZeygDmX8k2V63sYIvF8/QuHDiQ1vN5VqPlb45Uxc+dld6BSq5MM+zZIzDKmIO+A59cXMRK5OprCbuvcRlv+mM4i2Ilq2oOFUIxhJCTlp2k0saMnRXaOG+tx/pLLwfxkVHzxqTnOA8ynHhz6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SFyruhqIlcxl9sjBsBnWFOdFqfg5s2klxvIWbVQOsegy9S0o2A3o/2xCdcgP?=
 =?us-ascii?Q?JXdJbkec+7BDoxTO+nyhJx/kROLqZQUCGOxakg582M3cJ3we6lu0oi95M/s3?=
 =?us-ascii?Q?Uzkfcd0C6yuBGPBGSr6JNUvF2EA2dXj7pI7cUhkaCAhIpHq3cBkOmGrE2dbo?=
 =?us-ascii?Q?zPaaRxWukSzbCLGCSfF+2YE/uuHuCNr69clFzzB8F8Rio2sii1lCNrhU6bRX?=
 =?us-ascii?Q?H6b25xVKVm8YLe9nq6QW8E/2VZl/PU4jxwHlhkRWjoRj9hO5d7S0LNUCG6lJ?=
 =?us-ascii?Q?QLDWzf4+H5bcmlbQwZEK6gWm4KCxlL3gYMMIMa3GvP5Y/i4joblFVImviN4o?=
 =?us-ascii?Q?DUk8FOggNmbOTrWht0mbLL+0vBq9rPXOQjUkFdvfaVcWfu9s8n8m1+ApUkJC?=
 =?us-ascii?Q?NmsoOehWrDmHzXH293tSWuOCusAtmZpLTd4JnbdKB4+IGiOqSg73gYl2hjd8?=
 =?us-ascii?Q?rxyNwHON4JloOtswIBNSZ52h9fkW5rSWDObw5uzrFa25MgwGOHSX+Snl3ew+?=
 =?us-ascii?Q?Aaa3HVHWxA8JoLUZLnOdmhv3OrINppNMbdQfpCEKKcYaAx4vK+gHghfdns4f?=
 =?us-ascii?Q?Kw3KAErYx6MgKTsfQ8ziDxlmv/5bxKVCqKW4TxU5k9kusqv2dbh9BPXBoBW0?=
 =?us-ascii?Q?fbzo7CHTaPJToUY3iYqfe+P6vT3FA2gy4CLPh5HJ4s9ZDXCdHkNqeKInqiEe?=
 =?us-ascii?Q?gmSiX0bc5VDr+n6i/MUgzjo6d+jEqsywTmTxbIwaY698ola+vmJtLKRQJAyT?=
 =?us-ascii?Q?Itv6ypVIFGkvap9Q1nJdmL03KScOC7y4GdchfU6WnDX+WE6ZP3ju8stXkiE7?=
 =?us-ascii?Q?lT9pJI1SubupauWDnZft11Oyoc4+32w8/SyoPDOeQKH06EncVWy19DQPe6xM?=
 =?us-ascii?Q?RTE63zEo8h8KxeS/L4D3i2DYsjubk1oUf89Z0T8w3eUjgcjltV6S/PQhuIOU?=
 =?us-ascii?Q?/Ly+SLibVdI0JYZ4Khi4qDfxFxlOnl0DJx2hS8/gPlO88m+0ea8ozdt+hJnS?=
 =?us-ascii?Q?Ez/lNhmwWklVIsCwTWcd46uTP3jq7jJEWnE9qx+v1xH/ikDjd1GoERvhRTax?=
 =?us-ascii?Q?r4ppDlaH9+8gV4bdQo5uchGsqig5GjRWrG55IdhyXIo9CA2PbzAwGDkEQFAj?=
 =?us-ascii?Q?MiSLDKIgRETkkvxZsR2UYhD4qDVabDRel+aryk70wanDFexD0WHrGgv/asUP?=
 =?us-ascii?Q?LxLOUISPbwr2EgXrz/12Mhssn5xoJFW936QOcep/gaDghYA/HIAjrXgkdOHK?=
 =?us-ascii?Q?l0kWPJVXskV+03Kjh+gD7+z6QBp6Tg7uVe3nbSP/YkUnnmNiRDIY9x5US/uC?=
 =?us-ascii?Q?VyUtdafPw2ywAYVnAORWtpUij8FPFcQE3HDygMKeaDENlUB6tzSFj8Ve7QgT?=
 =?us-ascii?Q?Jzlos9r06nzrqqm+VpjcfUrIGgKRrnqIrLW5jP72N9Hfj138mdK4A4nC6HfN?=
 =?us-ascii?Q?Whfkl0ghaZzLjpGRRoQ6wU3W/WcBFZJclaJ3/U/4XRrwS9aR5tJcyxhWQopp?=
 =?us-ascii?Q?Ep749Y6Ug56CyK5kjFUJY2EUnuZLpSQMOMbc5NTQCTNHQmgpwYZ+XeztC8II?=
 =?us-ascii?Q?oSv92O5i2Nqu7ImbLeGqcePttXiDEZJ3cErM65Tln1rzdYW4Kaj2KKoE5xp4?=
 =?us-ascii?Q?q2AN72T03QKlg1lq7sjQFvsaaliGTeYMo150QrR9rNWz34SUqBJJW+nHWTne?=
 =?us-ascii?Q?bf98dQdnlQuXwk/oqLy+k2ACVXpHWTrveZPLjOrCFCBo5drx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85080fb-0743-41fe-8788-08dea489efb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 18:22:27.1759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWsjzUoY08OXVUozaa/tg/sLKAt4FIx6IsaSvzLpp1jr7g8FwkJviUHA9dfib1sMjdnFZI/iV7MSffPkLh1mrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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

Series is
Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Monday, April 27, 2026 1:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/radeon: add missing revision check for CI
>
> The memory level workarounds only apply to revision 0 SKUs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_=
dpm.c
> index ba8db1d07c070..b47b91272b244 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -2461,7 +2461,8 @@ static void ci_register_patching_mc_arb(struct
> radeon_device *rdev,
>
>       if (patch &&
>           ((rdev->pdev->device =3D=3D 0x67B0) ||
> -          (rdev->pdev->device =3D=3D 0x67B1))) {
> +          (rdev->pdev->device =3D=3D 0x67B1)) &&
> +         (rdev->pdev->revision =3D=3D 0)) {
>               if ((memory_clock > 100000) && (memory_clock <=3D 125000)) =
{
>                       tmp2 =3D (((0x31 * engine_clock) / 125000) - 1) & 0=
xff;
>                       *dram_timimg2 &=3D ~0x00ff0000;
> @@ -3304,7 +3305,8 @@ static int ci_populate_all_memory_levels(struct
> radeon_device *rdev)
>       pi->smc_state_table.MemoryLevel[0].EnabledForActivity =3D 1;
>
>       if ((dpm_table->mclk_table.count >=3D 2) &&
> -         ((rdev->pdev->device =3D=3D 0x67B0) || (rdev->pdev->device =3D=
=3D 0x67B1))) {
> +         ((rdev->pdev->device =3D=3D 0x67B0) || (rdev->pdev->device =3D=
=3D 0x67B1)) &&
> +         (rdev->pdev->revision =3D=3D 0)) {
>               pi->smc_state_table.MemoryLevel[1].MinVddc =3D
>                       pi->smc_state_table.MemoryLevel[0].MinVddc;
>               pi->smc_state_table.MemoryLevel[1].MinVddcPhases =3D
> @@ -4493,7 +4495,8 @@ static int ci_register_patching_mc_seq(struct
> radeon_device *rdev,
>
>       if (patch &&
>           ((rdev->pdev->device =3D=3D 0x67B0) ||
> -          (rdev->pdev->device =3D=3D 0x67B1))) {
> +          (rdev->pdev->device =3D=3D 0x67B1)) &&
> +         (rdev->pdev->revision =3D=3D 0)) {
>               for (i =3D 0; i < table->last; i++) {
>                       if (table->last >=3D
> SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
>                               return -EINVAL;
> --
> 2.53.0

