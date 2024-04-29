Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9376AC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 08:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044F410FDD3;
	Mon, 29 Apr 2024 08:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f29lMR+B";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8A710FDD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 08:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbIDAHmr/sCF4XFyFhwRZsuiOEHMoxB+nqSZzDIpy+DbtQN+LySPpffg/1IrCIYPse8OHC/vEtvmMzMqRJFbUFtizjdTdHRWa5Rg47HDIrO5drsmB+dprA4q3+SF6jtONIKffjK7161Ufxl2owkTidreACNVffLjVGILdYs8dC9wPVDCM0/+rT10l13vnNxpBAAx4BfkGEaMmXPvOVkI+hS3MJnHWMgU7SOp3iajjUKq+9GX1Aft7k+rBk+W4okFqOCzMzBUOtSboftNGIeolIIj1Re3sYUUES1A7fX3t5zLwP2t4biKWRPCamaEGDQxnvnGK5qTmYYX1Q8J9fDXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wibufb3ewNlDEI7U5Px6PzmYy09K/bhwa3ZxJVTLfHQ=;
 b=kTinBS63LdQdWZvSBi+zshkstGla+HymfhqzD4eTrvt50nr79y+38loewjUR7jaKUNurOrqfPP5dqcOnpgHtKwtunTBudjFuCcm6Z5ZfuFzkSh4/Y/I9hMW0gpOQHf2GQeO+kw4t9TLbAx4Ww4xuO9c66cklFDlXVkokUKnbmn+luXlyUug8rEOJSsg+/HJU8gQOQFJEkUb8cL84MHpjoHkB7rtc80MjGrYHD8AVy4juFHBRTzMMStABLoxbSWiaOgwq7Zvjqm3tKaALAUC8sM5Sbwszhn0+mEhsq49++/O+gj+yvX1DBsJSbBLdAFT22hH/qjYsVfEli5VdgNiktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wibufb3ewNlDEI7U5Px6PzmYy09K/bhwa3ZxJVTLfHQ=;
 b=f29lMR+BESK8nb952xsfV4Mvg3H6MxYJS0UgwwM/1wKCc6I1GGgMB68eTyjKlexn6vtPx+jzv6PrngRjTP4RUYuF291kI84q9WDlv7ubcAzX/Shkt7wcan0N0pOyIH+rzpiqx8+31e3Drs3OeD+R0IAT9nuU+yJ5tLvAE+mQQ/c=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:20:59 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:20:59 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 3/3 V2] drm/amd/pm: fix the uninitialized scalar variable
 warning
Thread-Topic: [PATCH 3/3 V2] drm/amd/pm: fix the uninitialized scalar variable
 warning
Thread-Index: AQHamdpsD9xeHqlkl0+Nnu6N4zyHeLF+5SNg
Date: Mon, 29 Apr 2024 08:20:59 +0000
Message-ID: <CH3PR12MB8074831AE74B6E3374FCCEB2F61B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240429021026.2059764-1-jesse.zhang@amd.com>
In-Reply-To: <20240429021026.2059764-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=18f4bfd3-feff-495c-af9f-a7f956debe9a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T08:08:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DM4PR12MB5841:EE_
x-ms-office365-filtering-correlation-id: 34726a32-b274-4085-b1e2-08dc68254d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?MjYJhEXIGM5uOQI6HfKCYiH1jaJUc+lGW0BK38Bj1mSWCIyDsOaPeouYUJ4S?=
 =?us-ascii?Q?rmGaHSXPG9W6qTGsGPB/K+VQchEdOQWPMd7D6SNlMAHRsKh/NYt21sU4NQs2?=
 =?us-ascii?Q?I98YI/sGCJdcm5ygKFg4oNkOS5BofMYaE45YqOQQ/Xx3xKCkLlZr97gvW2Lh?=
 =?us-ascii?Q?+SKBoDvdNPnrm8tNZbGmdKoDj81sYVbhWZgmcWcIXOI9nKCbs0Tot5r8xkzM?=
 =?us-ascii?Q?9aL28IhVJO4rvfdNfE7SEkmfa4kneDLPxOj/Xn43an/7XYZK2PluNOgOvfYG?=
 =?us-ascii?Q?eegWITesw3z1U+p7/yjGwRAPH8t99s9eOUeBcjc9KIaLSrR9WVuFGbOq3hJe?=
 =?us-ascii?Q?2Ny9YRHHXWNqxH8bCSOWYG6upF7OIQj1gvF1NpAAIOvCsdtW0WE8mKXLYWTp?=
 =?us-ascii?Q?Bpx0Ta0ZoWsD37qjPL97m4F+hVyTL3mvRv6gQpthtqFe7gFoSAclu/t59ztq?=
 =?us-ascii?Q?+sciLh5CY0LzpVWVvU78psRMqr8y4QSG1g4MkCboYch0Uuf61RY/doALQslo?=
 =?us-ascii?Q?YDsutNUEmPDCn6AxGLuys+fG7D7sR6Q2NAePRqywTz1afYCr5ZSEfig1TwIM?=
 =?us-ascii?Q?LPiLnGaRH/NVTnHCCFeVXAEWlA2hR02UXLoreHps/gm88GFNK3ckJ1LwKByE?=
 =?us-ascii?Q?v3B8a+NaUvYdglOhooeiOSv8Ioo29zbc5eGYQDYq3rfU6gz/iJhFQJYS1PAs?=
 =?us-ascii?Q?0AHpb9lFopzhAf2l15decSOJB/AJYO4u6Y8O4a5u+23sTasTQaF3JxqHZX2w?=
 =?us-ascii?Q?5OPhNH09pSdiGSnamzk+vziW7662qTbHFoYl+cjb9sLUq4WYIdyW9vMMegaw?=
 =?us-ascii?Q?1Hm4Jbv8qg+93r0O56EUEnwdiaxd94nO7+P0ACSvv1aJ3Wzw26raY9lEb1ys?=
 =?us-ascii?Q?DRX4B2WA2ttmTH0xBil+tuLdELN/WqKQy7iLXR3kEi93c0+0auslf9xWUXiy?=
 =?us-ascii?Q?P/UAk4qQlQIwa9RksNq2jFrr9jDlXampZfOz/40PydHs4fNn/NQ6ZSilGmvU?=
 =?us-ascii?Q?JZPqZJIcKgk+i1LRXLXiGtChqEqjUGfJHnSddKzKfi2XRO0//kBtbCBjSegk?=
 =?us-ascii?Q?2V5kNebPKDrNb0mKCI0dosglv+0uRe0nXfcp41t1OeIMdKVxBuUyiuVu6cSa?=
 =?us-ascii?Q?MFEb7sTDMuqt2LuODqDAKXLxwe1eTDs9mHMchONTlHFnhV8ri8Lztc7Xp6ng?=
 =?us-ascii?Q?2TG2JS6BkdzA4K0UA9MyAj9tUMJnISq/Qp/btcnA4R5xaPApRwJQ/VLvpjp+?=
 =?us-ascii?Q?R/ecjJfARUk+QXp85VFF+eWpUWEBYwzPSc0I55CC0Jd2wa5StKAzIhADqzrQ?=
 =?us-ascii?Q?mpi1DGnNM8QxiSWjXGSsFk1pIx2h290drjGSrmP9t+FMrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zgbbq9gtydVn/hBbGaUgL2wefzaEMOiehAp/QEgmphrLgs/pZ76wKvOx/Os8?=
 =?us-ascii?Q?8lC0IzPlmaqjycyl05czNqnwBMJegoXhwnF8a+L0C+U+S3DOeyuLykywhEIa?=
 =?us-ascii?Q?CnIwHY1TfF2X+PgpWw8AK5dUYm1/V+NxpAPSx07oZWTx1GDshlH6UxnP6lSL?=
 =?us-ascii?Q?fmb95b2uymvS3GwgOvWOAB5bkuGyWpS4Tr+fO3KQ2Fk6iba6mm+VTsFV3MIO?=
 =?us-ascii?Q?0UmU/H432oQVTcfN7hEPZqF31rEnXVQH5eobFA1fWsdm70y8H0811cTeNOrV?=
 =?us-ascii?Q?68eJxdZMdtKNqinDyxW04eubn3qussk0bWBda0UAFe+e+empKiKHMkvhIO8Z?=
 =?us-ascii?Q?+6tKEPjL7DwIrKVsLp8gEE5YoUrvPmxtjllIKKKaUTrvrtYaRWlurJefKHXk?=
 =?us-ascii?Q?xsarQ2DKSnxF+BRvQQ+7nvsdxM0VCigkIrO+UfJ60YyOFpJXx0MqD674b/8I?=
 =?us-ascii?Q?TbYQEwBG9tcl6/HpBUqom1eLn6sm2qdPcjH+58tjO2FwYIQ67dFmLspOguRO?=
 =?us-ascii?Q?qsd/Vj5Ns8A7qIdt5jg2+QaHI350C6FXDRviF9v6dxQUq6O/YAEthqpyuMxS?=
 =?us-ascii?Q?5YFIQaqGQ34GplYRAqhPwc8PEUhxL+2tEaVTADQolYMVsYeLDrCkmN8AXUgE?=
 =?us-ascii?Q?rxjrd5KpuTpEDw2On1Gdct2NAPZj5FGOCjRAfGVqI8uKqCxY/Kp5xTNKMz3E?=
 =?us-ascii?Q?D0sSXpCtHf6vXkSXI6oiCjyyIc+V2/0HQiVwQoov2JK+7CmGUZQDuOTL2Lhi?=
 =?us-ascii?Q?laL8mrm+sQNpMLxVZOCxBuH8sMws+gEbd2RyvZDxD8D5fabYdRYSrUNs2k52?=
 =?us-ascii?Q?hq48G/42XSE3+2CudULyEtRpqJO+EKwlMN4crCp/oWep0RxqFn05F8hOuJwd?=
 =?us-ascii?Q?qdmoZE8gFivBLoj9BDbIUK54h5QOWyrh/Blx9LhhwGSiDPKWQ7fsgL1TN8xx?=
 =?us-ascii?Q?crOmmdKDCA8PP3pROuDhE5Bm3TlRD0MeDguA7VOzalA47HUZ5gwXrHPjdMDR?=
 =?us-ascii?Q?wnjjvK88TFxLypUS/SyQFiTmMl/jx0lx5ubxFqU4MtpluQ+h6YTpn/upFQjR?=
 =?us-ascii?Q?RZy9CzzL9qklAwX/KIoPqeq3upoLXv3Gdp3f9/NX7A/XqMZ3H8o5J5nknNL4?=
 =?us-ascii?Q?DGS0iC2KrZwcQCL0rHwKkwdq0492ps2M2d9ENcgXLF4YwhCTbR4qAOKbADZ9?=
 =?us-ascii?Q?8xirNdhboQUhnYhoYaf+NIO7eaPaO1pthE1t4P99igQJka33VsqyY9pby7Vk?=
 =?us-ascii?Q?8ewi7kVC2T3R+H9F/b1OvcOfcDPdm69hDMbmvibsLy5ofkrERMUf2DL0KhQq?=
 =?us-ascii?Q?y0N91n+g/ADgfMU+JwtyRDQyqNbFuBFR1rJpawLQ/brC7OkRTLlthsJ0sHv2?=
 =?us-ascii?Q?JLZxD5wNTeKogWSbTlv4FnRABe2c0uwugw6KDleas8psRXuUbcXYW0fP6ZJR?=
 =?us-ascii?Q?pkKqVYDaDOJoz7kW5bYI5ieGdIcNorVhyYhkMbCZUCQgtGTcnyHaDBamu0yo?=
 =?us-ascii?Q?6QDMydfh7fKr1kdLfueRpci0JZfwqeA5ICFeRiC/yw/+xaoZyhi44bYwN+Pb?=
 =?us-ascii?Q?39VAWVMB3akxh9np8RE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34726a32-b274-4085-b1e2-08dc68254d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 08:20:59.5424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOO3o5MiEK2UABzKjqK5pT2tzaRL1xmd2SB2v9UIBoylwjeL483BPDwBgoClUZXQTXR7uIRZqTpsSiM8mo+OTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, April 29, 2024 10:10 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 3/3 V2] drm/amd/pm: fix the uninitialized scalar variable
> warning
>
> Fix warning for using uninitialized values sclk_mask, mck_mask and soc_ma=
sk.
>  v2: Init the variables in the renoir_get_profiling_clk_mask(Tim Huang)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 8908bbb3ff1f..546a2268823a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -253,6 +253,10 @@ static int renoir_get_profiling_clk_mask(struct
> smu_context *smu,
>                                        uint32_t *mclk_mask,
>                                        uint32_t *soc_mask)
>  {
> +     *sclk_mask =3D 0;
> +     /* mclk levels are in reverse order */
> +     *mclk_maks =3D NUM_MEMCLK_DPM_LEVELS - 1;
> +     *sock_mask =3D 0;
>
This is risky because the function may be called with an empty parameter po=
inter, like in the renoir_get_dpm_ultimate_freq.
Besides, for some profile mode, like the AMD_DPM_FORCED_LEVEL_PROFILE_MIN_M=
CLK, the default mask for sclk_mask and soc_mask maybe not 0.
IIRC, the smu13 use the default UMD_PSTATE frequency. Not sure whether Reno=
ir apply this as well.

>       if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
>               if (sclk_mask)
> --
> 2.25.1

