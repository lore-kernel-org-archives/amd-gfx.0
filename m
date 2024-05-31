Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D6BC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 07:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23BF112D38;
	Fri, 31 May 2024 07:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3dJF8cOX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB2B10F84E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 07:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEroo67zom2keI+0fMQahcZQlf5nbdLXizbg7oYPzamzMt6p/I7AFaasDZ51OzMgnlx3fDkLShFXYBCUxbTdsP85JpaDdsXK0vsJxK8IZ0FOr6J48RrNrU0+bnhOPzyK8cGvLdsNZdpGPpsbRUQzxSOzY1VTRCm1KrW+Nv/7hXH1Xp57NWWw2zDKiawOzWhdMHoCd+bKZZKFoxzhFH9RVLs7foM6Ixkf8JJsrnFEvxIwlVQoVJayOQJgL2h89ZiDdObXI91U4GHTCIno4Olq5GW4rxyPweFpSLKBe3ksY6XraP/2ohBU4NJELw6KXv9m5LuUOy+WW3NEIYnRyYEiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcGDr7sgPVMMEDo/mA/25pux7L1Mtd4FQEcpwq+4gQ4=;
 b=I6GyaNgtXmZkjBrgrgtEc3KFBQ+qOjjBvpSdBaN0GPXEw79dQ8EL1k2uhkAlGq67GP6JRwd9mvEohwxiYWv9YD2BO6nQZwPYhlBVteMcVcwn7QsVdkTb7AME2LS176J5VDIbD3E9G2iqmqDfHiKp2ahnXG00UkVj0ZZcmXYa0/7QYrlZ4basUaRnrnQEaoupH7INe8v6yQ8RmCb/I836oNx+VGT3studAZiXHbaFwZ7rH798o9A5Tbe/xs/eAQ1SLaQKwe38MdpgR61aGOnvaR5ozi9P7lD786Xgjji70Y9+AXSUsWUd54HmEtgpXJWylwL6zxTfkdiG6Y1oJoV1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcGDr7sgPVMMEDo/mA/25pux7L1Mtd4FQEcpwq+4gQ4=;
 b=3dJF8cOXYbjwOr8QjgfFGA/EZRvz/048+7uV8D6Nfi+CajBWjwlJgFCJezy6GguZxWL+0r7fU8NrDskx7DadZ9erOf7aDgweA74gOcJCudSWDyMVrclqAs5w2YriS9aFAFAwxkeO2Ui71vR5Cm36rt//7r1pMTNvs5NmrjFFucM=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Fri, 31 May
 2024 07:05:02 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 07:05:02 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH v3] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Topic: [PATCH v3] drm/amd/pm: Fix the null pointer dereference for
 vega10_hwmgr
Thread-Index: AQHasyheg3VvRb7xlkuoKVIKOzqdmLGw6sww
Date: Fri, 31 May 2024 07:05:02 +0000
Message-ID: <CH3PR12MB8074C5E12A9F9AD95C14233CF6FC2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240531070122.18431-1-bob.zhou@amd.com>
In-Reply-To: <20240531070122.18431-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=605796c3-1910-4827-bd72-0bffd49234d7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-31T07:03:21Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA0PR12MB4479:EE_
x-ms-office365-filtering-correlation-id: 255b9f24-a69b-4ebd-61ac-08dc813ffe22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MMbrCcrATB7D+tq+Rt+vVG6prrAxQepbKmxYLixFn87cbEuPnZlguoK73y?=
 =?iso-8859-1?Q?Tm7vdlyvuQEDTZ3Lepmh3I3VXTW4ME17V82YjF9YH5DIMbY/P2whXG+2Ad?=
 =?iso-8859-1?Q?Ymvh0W8+AY0t0LPMdX0HqJewOkzOK9qXdJup1zyPjHqtY1auT/DSgTaSPy?=
 =?iso-8859-1?Q?DXHhyVVaIQOC+7H3cpsaO1PsbPrFrdQWtQ1uDboTnOeF+u97cBG/WiQts6?=
 =?iso-8859-1?Q?uXdozBL5o2WKJ11PUFb0GB+edr+2Dzjwt+tlvqKQ+viFlpD6+fSfjk68BR?=
 =?iso-8859-1?Q?/mDYsiCvs04b5zYy5N5QcMa8Yl8jH2B6A0PsxTZWQFQ7WKEvh9NnE1pI25?=
 =?iso-8859-1?Q?KmY544JMR5CphFMF6WPpq6ZoEfB+Ks+YRZST4tivAaCdXze4HLwKfQZVpL?=
 =?iso-8859-1?Q?I7WFipHIqYesc/7KnUWkSw6xCEblP4zjh8LJYWYJuJcLfVB1S2LscxRDvQ?=
 =?iso-8859-1?Q?T5wEGIVXD5hNUMc1AgjY4ZLNyoYrHlfns5lpmEFz/I5JEfzEsctvykILck?=
 =?iso-8859-1?Q?0TZQiNDpZQ4ofxtyHxogwEBFLbNVCtYg17JnntJvcuU7kTS36uafTpyISr?=
 =?iso-8859-1?Q?OV0NtzrwT259+9kSEBy8z1scJ+QhA1QJXzR0crtqDHhEEVLmJlLKtfDAzh?=
 =?iso-8859-1?Q?t8pamtPivKbjzKOhNQKAc42RzJM+xPvelc/klcqdY3DWTaWE/4kN/x9+FG?=
 =?iso-8859-1?Q?D9PmKNRqsC0s/bX8kuWDMglL+6sVjJjS7wFFd9O146XVLPe7eJzXmTNRwp?=
 =?iso-8859-1?Q?OzHHD+T9RAte6TuCgWGterC5wc4TIondvX0DiTq0T7bjjVY9P6CPB5oyfn?=
 =?iso-8859-1?Q?TjUXGK2Rf/9cr0R5AcXVyBK9qYVF7NYN7nSPJ0afXy/d8quZ5qLD6NyaPS?=
 =?iso-8859-1?Q?CtSSd1wa1F5O3gYGsxYiDCFxNaFE73uMv9xPEd4JF27nJa9+BQV/b7KYsP?=
 =?iso-8859-1?Q?jLDxouWVN1YjYghlZAZe+zd8fCjn2nJo0bmY43jZAgJhwozmVJE5j2oeeG?=
 =?iso-8859-1?Q?74LGao1vvtptdHIR9UR1qeONwd/cU7mn4/thirtyxMZqkPc82qFPcXr+TP?=
 =?iso-8859-1?Q?ucvZoPLg4Y6xEtSnrONap+OCjrAz9WMDNrY7xXcayIqu451IAw1GYmHIkG?=
 =?iso-8859-1?Q?WJc6NQFYdWfWV+sUGFXiZQ1hoUhqM1PYNKxurFEpMagBa8kVyEL6hl76T3?=
 =?iso-8859-1?Q?KgbCun1NxRR9cl0Tep9wCMjeMDC+Zh2UmBvXA+lpzo86SGqNdzkcPjN0ST?=
 =?iso-8859-1?Q?isR1UvzEpr6iULkT1pVPgaAjRkEsWmeJgkRyW6hCBT1C6oZsZD8jwPMAMB?=
 =?iso-8859-1?Q?o1k9U46a07dws/KTjAMbRhq9+tqbszDkFwDl94cOscpaeoI+Wt2JyCFIyG?=
 =?iso-8859-1?Q?LJGvl8p6Egs4KXKfjSmtQe5458+iWDvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aZ0MiLugBGu4wyJ/wjQYXCqSaEphQzXFKcc/h0Ez+wEuV/mttcsLSKnTB9?=
 =?iso-8859-1?Q?vNLCrRMPnbjzw2eABasFnE5TdBugna3QNXDOEvsVNin+y3LNkdgYqGrIPa?=
 =?iso-8859-1?Q?XHa/fkIU6USKBXuRE+MmqVdusJYdsBW2ISh4crmOMV2lBvu5aroFpHkPL4?=
 =?iso-8859-1?Q?99gAKjvMPKdAAJComCAs4nHNK6mlE/LCNwqUWS2J7LMSmMqVE94s4JhWK2?=
 =?iso-8859-1?Q?MCP9iY6Mx2WTpxNgJn7WzJM/pnsWbSbiN7GP7DAKJM0XqJUIT0rkd/AwXy?=
 =?iso-8859-1?Q?B5BamFKinDuQxMuWY5spuErygxtvdh6GioAFLLccm+aAHlzboVQpXXA64X?=
 =?iso-8859-1?Q?JFIRgb9GeDc5fW7Gs6HWNcq7SgPG73P0aFL+6o7Om1uKGFbzWbrsInxgiK?=
 =?iso-8859-1?Q?SpYyHX9OalH7iOrOSH12wBXUKy4csuvdTp1KpQkkyOHI3mIwdyUabVNtTL?=
 =?iso-8859-1?Q?rp/7JkzDvXyZ2EhBSgAoT4Y5Mc4H6plVPT/Ns8o8OGhboCHu7pNvItboX6?=
 =?iso-8859-1?Q?dPmQ1MKDgBzMvQKQhQF2hG5mM2xmV+ocYpq8ULS6uTyZd6NO+OIqEU02Di?=
 =?iso-8859-1?Q?YpQh2xAr5ftrHXCuMdDjUE3iZszuTIRhWqC+woCIzuWe9Tu6jSuOXRdR/V?=
 =?iso-8859-1?Q?rZ165W77YJyYNwnRcArczyCn6u8LDERfDwcfmz8w4QuKsSAFim1fplLmwh?=
 =?iso-8859-1?Q?RIJuFXvkJXgWlnrLAx80ZoKAtfvTI3ZE89Hrp7rdbi7EO23tKg+QZIjlC2?=
 =?iso-8859-1?Q?TpJV13Ncvvoo8I3NKce0FMgP628lFdYfiXUjEIyGTSPpbkqOSColC8uHRZ?=
 =?iso-8859-1?Q?szxpqHkY3pKtjbEv3PbZU80DMJCcOSlqiixGaxp+IpKiHdBHzuL5hvZLrT?=
 =?iso-8859-1?Q?NkcuVf5DkNt1FvJmwfe+b/XKOUDdftazCZGzmF4FkPtAZnU/tsfusHEk5L?=
 =?iso-8859-1?Q?3AG/5nfCV21o3NA/qqGgwkv0P34CdjCopK3bEnKRjoP06wSpi+VaS9xiom?=
 =?iso-8859-1?Q?oS3aebIqVkGSJ3S+iGtCI1X96WkNzI+PsrsulCL0rRDpRpMJgzOvTb9NNS?=
 =?iso-8859-1?Q?lrwPsmVMyJKqdUkmYyYus2KpLoCz90FRdnKZ8UiUYFpwvqjBOHA93bDwJA?=
 =?iso-8859-1?Q?Ui2hps/krwfsKlJHxFu5I9eqKFu3Gu3r4aRD3yUohJI3/RUb43otmgXhek?=
 =?iso-8859-1?Q?FSrK+pk5n9rDLwjIW6i6LO4wxLgFngQXoCjWQ5D1qt/sPBMoiNJBBzOGs7?=
 =?iso-8859-1?Q?UYJT5QMWWKxZW/uAmADkdS4e/9dDmv7DX5uhCtknbtljyWFy1yfyKxRCS0?=
 =?iso-8859-1?Q?U6PqJdXXGIK0iZEj5wck59939hJ7LbRW2g6B5wxQTYnxiJFosTOfTuQhdA?=
 =?iso-8859-1?Q?BWUczYjp9s8KZjIDmvQfSj6UE1k4OGrlnGuoA5z+HKdYOxnI2xxFBZCfOT?=
 =?iso-8859-1?Q?2vU3ScuoDwx9U59vFYTKDD0YMdXD7q7lgmC5aaQf2u3vMf01NrXt3Xc7Ll?=
 =?iso-8859-1?Q?JqQcOfOHRY6g6tYeN+aSmSVsjEOdJV68JzHl+9OsLA8NgjHLJdMv3BoKkS?=
 =?iso-8859-1?Q?k0yf7qIRc2rfuZOEZLDCVHqfJ1UiP9x4NPJI6ole4DVLC/i+/y0irZo3Tp?=
 =?iso-8859-1?Q?RRFbH2YnqZkPg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b9f24-a69b-4ebd-61ac-08dc813ffe22
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 07:05:02.5911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/iRrpx/olEOCKds1SxfRrgb15fU4gj5913GHXlUtsYJ3I50U5B3onv9lCgxdQz8JnhqA+ZnmFQ7l7lGjTtNuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Friday, May 31, 2024 3:01 PM
> To: amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
> Subject: [PATCH v3] drm/amd/pm: Fix the null pointer dereference for
> vega10_hwmgr
>
> Check return value and conduct null pointer handling to avoid null pointe=
r
> dereference.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 29
> ++++++++++++++++---
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 6524d99e5cab..6e717ddbb029 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3439,13 +3439,17 @@ static int
> vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, co
>       const struct vega10_power_state *vega10_ps =3D
>                       cast_const_phw_vega10_power_state(states->pnew_stat=
e);
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
> @@ -3752,6 +3756,9 @@ static int vega10_generate_dpm_level_enable_mask(
>                       cast_const_phw_vega10_power_state(states->pnew_stat=
e);
>       int i;
>
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
> +
>       PP_ASSERT_WITH_CODE(!vega10_trim_dpm_states(hwmgr, vega10_ps),
>                       "Attempt to Trim DPM States Failed!",
>                       return -1);
> @@ -5035,6 +5042,8 @@ static int vega10_check_states_equal(struct
> pp_hwmgr *hwmgr,
>
>       vega10_psa =3D cast_const_phw_vega10_power_state(pstate1);
>       vega10_psb =3D cast_const_phw_vega10_power_state(pstate2);
> +     if (vega10_psa =3D=3D NULL || vega10_psb =3D=3D NULL)
> +             return -EINVAL;
>
>       /* If the two states don't even have the same number of performance=
 levels
>        * they cannot be the same state.
> @@ -5168,6 +5177,8 @@ static int vega10_set_sclk_od(struct pp_hwmgr
> *hwmgr, uint32_t value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].gfx_clock =3D @@ -5219,6
> +5230,8 @@ static int vega10_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t
> value)
>               return -EINVAL;
>
>       vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +     if (vega10_ps =3D=3D NULL)
> +             return -EINVAL;
>
>       vega10_ps->performance_levels
>       [vega10_ps->performance_level_count - 1].mem_clock =3D @@ -5460,6
> +5473,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
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
> +5498,9 @@ static void vega10_odn_update_power_state(struct pp_hwmgr
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
> +5691,8 @@ static int vega10_get_performance_level(struct pp_hwmgr
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

