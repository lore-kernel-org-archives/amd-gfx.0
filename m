Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9784CD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 10:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7146710E77C;
	Mon,  1 Jun 2026 10:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tDrLuWUX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06C810E77C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 10:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3T9Fm7IufmEXzHw2oYgP7fKEfv7j7N2d0lcEt+PECzDSML6Y0NftHXNUJd9DaMKL/QTS857/XyFeZ8HbEuQImHBcs3ZhJzNazOIE3V8dtNbFLiNrflzppk3RlLIxI4ScGv+Bmvi+ZONHAX99+z/A0vVAzHVlGUf0FjbbhsBdAq9VpD2Tur+G5llfzU/3DhYq0LuxJ240DKjW/sY3PBA0j1r6oCbxaGqWOXUl531qmd58DCcZBTDhLIBXZNBIWjAPK9T8m9NmBR3baVZF6urCJxYql1jwZOYdVgsCJsYn6i34msYvL510iQ6uZGYZdKnexePPAWrnWjafu07X30M3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzpzloiH0ZkNtHhb5BuGkL0E1Hx+DnpfcbzJomOfwkM=;
 b=deHk19BOv3VlQIMiqtJFIGMkDg/p34ITlDWtvfxawCNtsP9j4+VfTeMV/1+qlxWBmp/Tuyc2E2jOLEQkdLqnRjJSfYdLfznN7hq9+qtOvn2sqVuY6bSRqlkZANgyCGLVf5D/bFiA5+8+6Sw8RZjFQhrCyHMhK91VQ00cuz3FYoKhiabFR0LxwdXu7fGhi195uEfaUmNS85e0FhA5bEXm5CkYIJdX4ar7Rat3yq197TY0ygvDLQpgyIAJnbAPU2Ce8wUMbso0H9gVmhniCrOS95Y0sK8xXpesNyp4pZEGWZLvNHwryDwRLlNdL/zT+74dSGjdx9UwOmERxyWfpzUPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzpzloiH0ZkNtHhb5BuGkL0E1Hx+DnpfcbzJomOfwkM=;
 b=tDrLuWUXYwLlVYuKIz7YuSJASlTAzel0GbyBt3MtyiLroHWRtM//j18mOX/xFJl5PVIu2cpT/PRKcisgE1S4aOv+0dRoDPShLJl7BEcl9IRtm+Qry5PnqmsNARG9iiRzPMKPbP5QZINIv9BxpYG6/pclvInKct4MAlwtkc0IiFE=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 10:26:24 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:26:23 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: zero unused SMU argument registers
Thread-Topic: [PATCH] drm/amd/pm: zero unused SMU argument registers
Thread-Index: AQHc8ZwpwgYPyxZFCEm8Vi7Eo4TnQrYpZtuAgAAYAyA=
Date: Mon, 1 Jun 2026 10:26:23 +0000
Message-ID: <DM6PR12MB2972ED3E432B5FB4E07D0BED82152@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260601075632.1557596-1-kevinyang.wang@amd.com>
 <DM4PR12MB5038ED546A1736A4DFB4172F8E152@DM4PR12MB5038.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5038ED546A1736A4DFB4172F8E152@DM4PR12MB5038.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T08:46:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|CY3PR12MB9701:EE_
x-ms-office365-filtering-correlation-id: dc5dd39f-1b1f-4755-6bd7-08debfc83afb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: dA8D983s9uNiE5Lv4eVdxhH4QSuHcBbX4HwtW/YhTy7JwT0XHeUQRpOXkmEm/Uv9r/qEuQJSIQuaQjZ1bdlsbYCFopT1EFstHWvkQuhNXlqrCealxJm7AqXIBai9GbKXQT/UZv9vMbsIJlgmxoZW1tR4sZDdiA5dAnp+cl++N3S70SnkV3PeA1GubFwzhNCKJV9sO2R6TRp32uURoIMxZqu5Cf1e87hJrxkDqPmPjzuYJM30yPRHPIT7cs/PnENfJQyLKYDLKLSTZzZeWtTSWpooeh14aLUpd23zOKm7Uk5gkbonoNyv7+RJbPnJffm88z7kjC+gsVXW9TriZZ9ZEjLrWazg6PIdJq7SlK8wfwGW4fQ+yVXTrL0wWFvCmDeXgeBWLaqEBkx8UYCIQFB920M/KdK6F9ydZIiQjiEGEU5/gd5wGNQSEkb8cmVuMaW7qh3vTSX+E8ojoAH0UCydn0ZchahZqJlbFI6D9EEgrT+l8jPEs0NGl6cEEIyOBbMxZJ9l1A0Uo/ej1IAVDLUUcSqbj1eAJje+spglmQsTzenFzSVTAbE1VrwcwFy5O5hTa8dGsMSwg+wd4cX6NBXqamWqbs06YpwU4KN1i94hSYHVtJy9Njt9metO62c48JVj2pjxHUt+1MwT1pVqVpwv6br5oo0lyjOr7feEkCybQBn4ptpRS6xI1zEW300JXYpOH2MgEDZEVxgFlJqAzzsZ4vwjtoKdp73gDxlQDeCWK1PUnLX1enubb0JVfh89T29T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MHMyUkmjjQjpRA+sVqDzSWNBdo7B4MK31CeosOWTthPWfV3ylrlER3CglwyP?=
 =?us-ascii?Q?b9zSIdFbnE4Fls+kBWSJOIOZ7+ssyDvRrM+TiAbS3SKMh+SpBAJgXsi0iiv5?=
 =?us-ascii?Q?fPwYFFAS3KVXB/ny6IrTq+5ht+tKuv1D0RUcfSG9wNBxY8hs6eu1O+ggkksj?=
 =?us-ascii?Q?D52IqNWGbqpatUxgybX+UqUw/u0aGc5leuVbtWyGr6ktEEYS5bP89ero5swj?=
 =?us-ascii?Q?mUSGU6e95OcJFZ7o2OW+i0eNRJ0ronsvp3v3APswBh0ELt+i4d8dcOgu/4SI?=
 =?us-ascii?Q?gZb+Pq4f1YUT6fEI1lMOl6XQDpMDTd5WBEnrUT1KLTrS+bu9dcr7GD4t2YeX?=
 =?us-ascii?Q?1fiJaV7vjwPA9OcS00oYMrQ4r4R6dRTXVLsyjfgmvcwrbrA+cQ40cPtw5qgN?=
 =?us-ascii?Q?beCrtWUN01L6In+Ydbmo832FHWC8gAw+FJ9udaOQFWOSrB/ojFIY8MJDD5u3?=
 =?us-ascii?Q?8kqIKjt+3WYDfxLvooV4qx/y7TA0eF3lXqFawQUcuH9auT+ISSRCY9UOiwzi?=
 =?us-ascii?Q?raDBTAqIJFo8OGt1xO75PJ7VYPp8HK38TKUHdOosOJs5RIMed9aU8Wi+n0mV?=
 =?us-ascii?Q?EVOEpT2CQCZ6cmq+r4TsmPJmtS2ha1tr4x8t4KgDV3ZVY0yeJLsTidpeSvYd?=
 =?us-ascii?Q?kgqBOZAZO+qW5603mELdORWOqqfmbvxg0Si7SwKf+ulUgbmrN138fhZzQ0Gn?=
 =?us-ascii?Q?Gv0Oh9FHeaT9uCkC1RVsnUK1sMHpuZPk6jWKpO4WETWtPM+sZhXTjOYV868D?=
 =?us-ascii?Q?bJKnPiyIkAOdDzP9TdqXXh6yiPiG45yDkdqiuDE+L2yAml05sgRxeEfEK7Xe?=
 =?us-ascii?Q?CbwdVgZXAOk9mwXs/3knJhYdyrUU+gOmA4BBvpswtjFXLDCyAjGcsQRFEEzY?=
 =?us-ascii?Q?VDOIAAOnO5mRau9qo9GsnIX64YvkuZQjqpdYesFQyt1WqHmzzFwLPlkI018t?=
 =?us-ascii?Q?pc33qWQhnWqQZdjFC6J6kck3A8Uvmu0Sdbj1wTBhffk3QSzLAtAw6pBw6PuS?=
 =?us-ascii?Q?W/5JoXuRad/JYR7UeKOubWFAiOCQVJ4l5/b6o1lGvvZkiAfxlj+etpQ9Rqmj?=
 =?us-ascii?Q?6Dbx4iE4GvPxKWmJ1p14L+wshWO+tP7COyoigbTIaTD5keoYPa204JJIbin1?=
 =?us-ascii?Q?Lu3ZN2mRxrrz+LICG9NFplCr4EtWp0RBZ0A38sUB8or6QupJmcaqrf2mL17L?=
 =?us-ascii?Q?XqMzWu8PyC4H5AvnVbrmAbe+QYXTg6R47Nh36ZXw8/oIMQeuGTyc378hqQFV?=
 =?us-ascii?Q?V+0bt4qQJy+PD1YR7o/sg+RNg+xgffmvpZT0BcIhR+qABn63kV8l8ge/+0xC?=
 =?us-ascii?Q?2xmjykqgQt8Qtkof2FLzA9jtAldCOhm6Z8ZrWiwYhGdTUc987kt8jDKKM7h9?=
 =?us-ascii?Q?qqETWkM+KwjKZWUms2xTTcNmjsymEeMAm4zrp03P5pHlVvalwpz56d/4CgfZ?=
 =?us-ascii?Q?QQqo5JYAuo+RG1h253cvVBwJO9WbdxGg0vDo2dZjJn5xBa12Wcowumi5TaU+?=
 =?us-ascii?Q?zdrsahvmOZhR/ENfpEOJzmYWA8eboSPtRtgRUi8Rf7UlF3TksL8e6P4W/grx?=
 =?us-ascii?Q?63W2rjriYOxWbIByCblEjgvScGajTIa4xKqdogWZMcPVSnty8uCv6U6L/So9?=
 =?us-ascii?Q?7HmOAnJzWJZz0RMjOhz6p/HTFebhCPkq24VNzVZH1GD9YxaURn+MC2Tqz6IX?=
 =?us-ascii?Q?5G12/e3WS47WG7Wz59IkElV1Nbw9OhTUA2rdE9bF01gNExWX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5dd39f-1b1f-4755-6bd7-08debfc83afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 10:26:23.6804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bZQepi5ksZY4NzoRkk7Co73uXHrUPuepjHXjbLoReKi52dFfShrRlhd02ZUO6KT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9701
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

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Monday, June 1, 2026 5:00 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: zero unused SMU argument registers
>
> AMD General
>
> With minor nit below
>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>
>
> Thanks & Regards
> Asad
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Monday, June 1, 2026 1:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> Kamal, Asad <Asad.Kamal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: [PATCH] drm/amd/pm: zero unused SMU argument registers
>
> SMU messages may use fewer arguments than the available argument
> registers, the previous code only wrote used registers and left the rest
> unchanged, so stale values from a prior message could persist.
>
> Write all argument registers for each message and zero the unused tail to
> keep command arguments deterministic and avoid unintended carry-over.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 546e64e3ba9c..85e7a8b347f7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -313,11 +313,15 @@ static void __smu_msg_v1_send(struct
> smu_msg_ctl *ctl, u16 index,  {
>         struct amdgpu_device *adev =3D ctl->smu->adev;
>         struct smu_msg_config *cfg =3D &ctl->config;
> +       u32 arg;
>         int i;
>
>         WREG32(cfg->resp_reg, 0);
> -       for (i =3D 0; i < args->num_args; i++)
> -               WREG32(cfg->arg_regs[i], args->args[i]);
> +       for (i =3D 0; i < ctl->config.num_arg_regs; i++) {
> AK: Can directly use cfg as already defined as local variable
Ok, this make sense.

Best Regards,
Kevin
> +               /* NOTE: Clear unused argument registers to avoid stale v=
alues. */
> +               arg =3D i < args->num_args ? args->args[i] : 0;
> +               WREG32(cfg->arg_regs[i], arg);
> +       }
>         WREG32(cfg->msg_reg, index);
>  }
>
> --
> 2.47.3
>

