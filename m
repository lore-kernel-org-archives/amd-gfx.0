Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61250E8305D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 07:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0387710E308;
	Tue,  3 Feb 2026 07:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hmr1PGSW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DBE10E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 07:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqUc5/bu9VKas78alL+pSgA4WsVgmBC3DaIJkPEBP6aRxnfNFJv7SCF+Lt+9JX2xGsibOEnNSCvDvgod6igZgJOKuEKehQYmDtOT1Wi6BSLdNZkOdbLaruCekCBm/KLA1lqbIHqCQegX8WgAY1L2wESnQjDePWVswZliwGvxWFUVvLWpkwMohCwJCFk4nT3hnjPgTP+eRqc8FB0L57mL8nQr3uXRi+kvi8hUdx7IR2u0UfyherD0Go13l0rvfDninlGmXdxE4HCYDjm/GK5tBdmBBKn6EE7ZS1IYX3hovab5LeGKdPLepG5wAu/tloHC0WqAzTMqrmtrRWEKRYtYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlaSVNSjdK/z05O5JmTif/niCIgUCTCblbX/AQHAJWo=;
 b=uB5lxSCMasIr6UR6pBYY6behIAOzqhza6nXrXShVMC+tCDFtxyE+rIecKZdCZ1AAxjfIp52DTGwOkxLZrevdaHMqF5onhJGO9Q1ZB1OF7B92ff+d9mGHEFwmQMa3+DlcUHW/VaWsImJgpZgvUdC5f/vBJ1P2oiIHsgD8GOU+PNgzUQZ1B6zaX9P0xm0Q0gMkn9bLLrcWLKcv6HU8TLG5tVsp8Fs6SWrEMLYx/Qz/O6Zf6PIpocOvMh7EK6FdP5KpIQmSJDMN/NJOUqf31X/vOL4OY10CfH3vlEIvWWYfHkEy07hnop5DqsRVPhXkZIKROBs6EHTg2C7eTs9dvhZmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlaSVNSjdK/z05O5JmTif/niCIgUCTCblbX/AQHAJWo=;
 b=Hmr1PGSWyuSm5wM7svFL0UTSEC4fiU6tlemkXv5xgmyFNOUJCmbYdlwKsH7llaD/B3P3v8iVIFl1sVRyrMCVQahj1KYb/6rHtXJjD6Q73vYpUu2ArSE/uabcpr+TTeFnmFCsogtRV/HqCHw9sC3HnhbG7fLfFa6OSmB1PkWZt1M=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:55:30 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:55:30 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH V2 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Thread-Topic: [PATCH V2 01/14] drm/amd/pm: add pmfw eeprom messages into
 uniras interface
Thread-Index: AQHclMNWgCFi+P85w0KkwKimWNeRmbVwm0Pw
Date: Tue, 3 Feb 2026 07:55:30 +0000
Message-ID: <PH7PR12MB8796219E7C278A984EA74D02B09BA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-03T07:54:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB8842:EE_
x-ms-office365-filtering-correlation-id: 8c08b416-862e-41c6-160d-08de62f999f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qsI2Zw6hdHC2kdfehvOtzIcNsNIaL99mnoMcw0lprk8Yon8Fuq+Hqm7IjYHZ?=
 =?us-ascii?Q?Z4+Ew/NRt+W7MFQuskItMID3ImIBUmWy2wElztQL6edeG5zs8r9FI6XcHEZn?=
 =?us-ascii?Q?37CSx1KdW9/PlFyyHPRCGIhMYXfcbtUJEMAerT8gkUZJ5Rz4iEYU4bERhUQz?=
 =?us-ascii?Q?QygC1J4szW0Dq/tR+QYgqkqi840nPSUyRrm7MkpChezHmdtmbDPm6BxVbiQc?=
 =?us-ascii?Q?JZcCNEcSW+WYa/gA7Yj/SM9WVf4tbGN+DpcaKtJdyCQ42SgvFDFGw+XWNLNe?=
 =?us-ascii?Q?g+hp7bcJSRTOZqTr3lxZgUzVQRVvBZqqTOQgF3t5Ahe0RLCMa/0Qwuyjx4zc?=
 =?us-ascii?Q?NIva2yQXxjWVh1OXqtj2Dnbr09OYPfV5ix23nqjF8SnR+K3pI81fYm3f7Hod?=
 =?us-ascii?Q?e9nTgq5Ln7FtQyjxakdzlpqirDapUH5Vzh2Lzw79Xu4yoojh8A81Dcnjun1v?=
 =?us-ascii?Q?YQnUlx5TE79RKXQV+6aCnkJqFcNoALssxuGqBJ+s1V2HVYQ+aVQ6nHuvZR7z?=
 =?us-ascii?Q?d2Z8iQMUpugOVpjX/dRKQWHWUofL2nbAKpYnH2fP+YCYzbMvm5CDNrM0sU7H?=
 =?us-ascii?Q?c1LRAs8rKxBn3BfmVGymgmx/EOxQXp5FM1CfEXY9TYyaVcRlIuiI01kSxoJv?=
 =?us-ascii?Q?VPxgKyRQKIWfnt65z/3imhdNcbDMs32/lb/QAceL0sQIJSWiTI1bwtt8xJpy?=
 =?us-ascii?Q?GKLB+5WdpM8K7AHVsU/sEKP29ZcuxqIDnKtZlhVNr8m5O2mP3z1Fm2YdmI3A?=
 =?us-ascii?Q?pGImHXCqPhX/pSzNvu2itgFm+bdanHIpLx3YBApRQd6RPMGuooYFi02VGEno?=
 =?us-ascii?Q?tL2tPtH7CPG4VsoOeGUar+DIHYXIPQH5jFY4v+tABv1/ULytyJ1v7M68uqA8?=
 =?us-ascii?Q?sNBTgmQgOOBBF9+OpsGRm3eTfj3rFpQQMMRTexYzKhd/Zsa8NrpdP3cHKtQ7?=
 =?us-ascii?Q?NQM9qJXd8wwihbJ6yyokIsPEdqK1JdA4UlEsiTw+TWcn3zYX7XImShBnZM7i?=
 =?us-ascii?Q?5Ssu2MKeTMSYtJ10KGVVUpoTLyNTw9ZX0k83Q3dBS2HKOVj1XSQHxBFd4Y5Z?=
 =?us-ascii?Q?QmuI14xre3AFVSaRlv25X/ltR9cME8x+L2Q7ahDuQc9Oxp7QPAnfEwIcg7b2?=
 =?us-ascii?Q?erK0ZSix/H3DW1FdaU5lld5TKAnghUJVQygQOUAWGLLJfoI7v/+Xgxz3A4Ho?=
 =?us-ascii?Q?Q5d/umhn8hnUoVlDvHpon/m3sPkaqEJaZXIETLJMYEB3Twq54Jc7Xezu9EJu?=
 =?us-ascii?Q?zahSESvSQ/5K/lli8G1RU47Mr23h9ymApljPdPXG/4mEbf9JLYAvoxYtGgDP?=
 =?us-ascii?Q?9PEvTwPr3jvgXplZJdO3+EcZ2DIX0R9fkyDD7aGUql84QrkQQ9mu9oKvru+j?=
 =?us-ascii?Q?vBX5hXZIND3H9DDiruHuVzEGfp0Lfy3FG6B6XO4jev/9AJfFkLyi09ZqYo3a?=
 =?us-ascii?Q?vCQMU23CDL8NxjhT5aTaxGoasgGf1t6NvFZER1+03eBr+xdubnWB8+X3XEyI?=
 =?us-ascii?Q?5Jyx/n/SQbuOOzy2yLGQmGFX+Vflu72Xp2/o1S4tlGw2XN/c2B9BCvOkoXQ/?=
 =?us-ascii?Q?oXocJUuB5vCzaH0spw1bkWJHYb0n1GZIJHe0NAbAtap2pasqU9UUGjPhHLUt?=
 =?us-ascii?Q?tT1YO+XD90MavxUB4W31z68=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZZnHmCnrp5ycksV98JsvWmDZcaPEj1MvyZcCMRa+jJxNuKbv5As1LV/3Zehm?=
 =?us-ascii?Q?itHqGByF7/QXPXMpifxNmEc9U8/Ojp3OHUkPW9vW4+1zKQxwBiAkxkkO4dMW?=
 =?us-ascii?Q?tqmenD1u1aYaPrjyvbkb+b7bs/T0/DA78M4ybjRAImaqRvfmLNvJ+UQ3/o8M?=
 =?us-ascii?Q?V1xrW+wcTnuga3LgNe3wzvxZcWARrPN+4IP94qIbx0zvhgwBruKKWWpV5Oxy?=
 =?us-ascii?Q?vxBfpvaDZ3pkwFjcqzavJfvUpgY8tawJQlm85dNktiN+saGeWhSCqQzF/J8j?=
 =?us-ascii?Q?1DHjUeS79XgLS8tnPjQBkY90b7KnV2TAoR2v7izY96Qiqf2TjLMUs5eKzuWr?=
 =?us-ascii?Q?MhGWEliJNlKvTdUp4UPPFTQgdqUxTdQ08w3Nn0AaQNpiccPV5ozn4TDc0Bwr?=
 =?us-ascii?Q?b8vBw7ZBxJrVdk6SXHitUAghoNfrp8xD4Hq+rTTiPYEkSWxcs0OsIiUl4PVO?=
 =?us-ascii?Q?cBNFpvBeoccWnvkXZAyheBnu2eGOBNwcm18eHlWvrHMG9w7YzmgPXCYHf4MB?=
 =?us-ascii?Q?lIDrNVDr5wdp7k8OSuMrtdGuYdeIsiIJLam+5bcjNLP6y1RBel62hATTYJjq?=
 =?us-ascii?Q?RnJTcmXmHKf2t7LwrxDvkhzn4e6a/4WT3v9imsDfK04kEn1+yhRcwZFuFVYM?=
 =?us-ascii?Q?5RQNvxnRVf4Mml7zsQvw9DUVaMPPHieXsaBXzCBmzSXDwtVtarZoH6pjF5Mr?=
 =?us-ascii?Q?IHi9eb72N74HxtA7a/MEfdAZ2cQjzBViS+ms01uAHsQgRmdDuQP4HY30/Exm?=
 =?us-ascii?Q?gE8jd8rfLrvtRStppx3J9ky++HpAPWVZBjVJ3qF5GORnmodaXrMhzwUG0uHc?=
 =?us-ascii?Q?JG2XI0tIy4umfij1GGTo6PP9IeqTyFD124bkdGdXprG5grtDsHNIwRx/Yx3x?=
 =?us-ascii?Q?GJ5bfPSYBW7+onI64vkyfZFak8ae0DtHtzGx7K6rerJz0oEhlfona7tgkZBD?=
 =?us-ascii?Q?gMa4HwhgAOc7xATB3acFK7UhdiyT9bHJVOVaOHun6j+fFDhO/z8nL0Jirvpv?=
 =?us-ascii?Q?W7taHPPxXtqw0BNVFVifeGPzkhU2GkNbnWsRfEsrqdyb4ItGUcp33yyn8l40?=
 =?us-ascii?Q?o6VoxreqtGEjHforP+CMiBlW74uEiR3FYfTfl9auOejuW0k4WPH97BuaRR2Z?=
 =?us-ascii?Q?UgVJr/+skIi5PhgWVtRsG5vzF+6D1rzFJD+PG0FxUwhsNyeKExquACVzmo96?=
 =?us-ascii?Q?+mn5f3rlmmtIsU0n/Vh7sIJExFpU591mf7wenUbjQ3CyXi3I2c1YjdJ3zH4t?=
 =?us-ascii?Q?u9b7aCRvKtX1CzDKYzg0P32zyKDFJuncYyhlHHYpI41jVXPO4+kOTTQfY2Wo?=
 =?us-ascii?Q?wBzHEhgU83z8m9oruVfai19po05/x8+iyoBsQgIIvqow4HuEtGyRzr7WQQwb?=
 =?us-ascii?Q?hxD7vycVBlC8hkxJGcTgvGWiYfmXidLz0MYdBWRcYYLlpi9xzQ2zZG6Tcb2+?=
 =?us-ascii?Q?pbmkmnm0kUWCoVLeoVMIl/A7t8Gbwf/4p5254FnGghUYoDbkEA2jm6cnCXXd?=
 =?us-ascii?Q?NlH2fKlzll2A5frCGBDm+SVLAziUJNCgEQSdD7DErN70WdK2PQIOVydK0M+3?=
 =?us-ascii?Q?aAwqtQk+z2mB5xjjCwWEF3oG+xRa4mCBoWIM9w+6LaOTD+ocuMbhVT0hjre4?=
 =?us-ascii?Q?u9x+Jbn0ALykgHnvenVGp80nN3wCV+Ci8kNWrWeE1xNfFML2hcLAmx24Znna?=
 =?us-ascii?Q?SUI2nPvHboZNVdgeSIf1eyr8RRUmyqATSpW6SoPT8KGTTOCu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c08b416-862e-41c6-160d-08de62f999f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 07:55:30.2154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qohTNIrj3qreERBeGne5ILt98/sA9iKlPtwAsEk5i1iYgHCARTGszRF8pPljA8GR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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

The series is:  Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, February 3, 2026 12:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Xie, Patrick
> <Gangliang.Xie@amd.com>
> Subject: [PATCH V2 01/14] drm/amd/pm: add pmfw eeprom messages into unira=
s
> interface
>
> add pmfw eeprom related messages into smu_v13_0_6_ras_send_msg
>
> v2: add sriov check before sending smu commands
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 57f4069bc827..ec29906b82b5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -3497,14 +3497,25 @@ static int smu_v13_0_6_reset_vcn(struct smu_conte=
xt
> *smu, uint32_t inst_mask)
>
>  static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum
> smu_message_type msg, uint32_t param, uint32_t *read_arg)  {
> +     struct amdgpu_device *adev =3D smu->adev;
>       int ret;
>
> +     if (amdgpu_sriov_vf(adev))
> +             return -EOPNOTSUPP;
> +
>       switch (msg) {
>       case SMU_MSG_QueryValidMcaCount:
>       case SMU_MSG_QueryValidMcaCeCount:
>       case SMU_MSG_McaBankDumpDW:
>       case SMU_MSG_McaBankCeDumpDW:
>       case SMU_MSG_ClearMcaOnRead:
> +     case SMU_MSG_GetRASTableVersion:
> +     case SMU_MSG_GetBadPageCount:
> +     case SMU_MSG_GetBadPageMcaAddr:
> +     case SMU_MSG_SetTimestamp:
> +     case SMU_MSG_GetTimestamp:
> +     case SMU_MSG_GetBadPageIpid:
> +     case SMU_MSG_EraseRasTable:
>               ret =3D smu_cmn_send_smc_msg_with_param(smu, msg, param,
> read_arg);
>               break;
>       default:
> --
> 2.34.1

