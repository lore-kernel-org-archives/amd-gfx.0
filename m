Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFDBC3DA63
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 03:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE24510E0E4;
	Fri, 26 Jul 2024 03:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eqkCvdmN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2903B10E0E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 03:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGZhUjd5g96eU4mZqdfIFXb8jU3XxbaaoWPSVfzrNbF+bWY7uU2N7eKkzq1HYVyxw4Dz8Yj18+HdU3Xqii1bZfT6/YjVxYLqLi0mT0BRxhd2bxPnQzEbJRi6j3/SpKTOQJ/ETdT8hsupDyYs0agk+7yDFFSRWbg7VGOvwcxqPI9disIMkOrsrJZql72L6L4PpOsn1yruvXa/QiiVoXOqrhq3q3IIgz+bJJn6euUrkozeYQUF4SEkPOOnUt1P+mF3/qdtC1p+OmfPY1UF3XeSN64i7QAu5t7GhEaOCL/jUAlVc5fF5zQVg7KPlxIcrxsImdEOrVxCv3cPGPxtwD5mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXO7tb3P4RRlxwXh0WObTVUlpi4M2F3/jV56eLzmQfM=;
 b=nggPeTnmryhEpAAa9yX96FRAZKZoLMg8wh+iGx2hl19DZyEmDltC7iucXIluAudHG0xGpXz2dHRY+5BTfEUJnKuCG4JS43tgqlPTLKwg6JUDAS/JKpZlC/FGMDn/P0MWD7gyo/W90kuQb7zOxNSBiL9nPmyWJKPQ0ExaF8libmOPPCIn5sWzscsKhHZU2Y3goWsiWhHQgtgoFhhx8IRkRYQfD3XPJZXg15Zt+Mhi5UJiO0at5Uw34JFUrwQbNsdlerESW5+yXO2/WKB9tMJTXcRMqXgVrzKR8GwikxypDyz0rjRAlxBSJlR4G+jpYg+R3r69rev3RlPk40rHoYxwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXO7tb3P4RRlxwXh0WObTVUlpi4M2F3/jV56eLzmQfM=;
 b=eqkCvdmNAHb8k2FVUoTXhg99gaen7PCblM1J5FVViYA3IBzH7Dtqi8NbhFBKn8wW+M6aYlKm0WDElRIGoX8tLFnJ9icrr4rB1rjzfvJXGluZFM6c7WEvVYBOCsmDklWUscPV/2BWE1Sw0UjEqk/WEtt2653GJz4qkDZYo9p401M=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 03:50:49 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 03:50:48 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix APU handling in
 amdgpu_pm_load_smu_firmware()
Thread-Topic: [PATCH] drm/amdgpu: Fix APU handling in
 amdgpu_pm_load_smu_firmware()
Thread-Index: AQHa3tql9SK6UUSeOkGW59CSRzHVgbIIX+Qg
Date: Fri, 26 Jul 2024 03:50:48 +0000
Message-ID: <CH3PR12MB8074C43A36332A29A14C48AEF6B42@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240725213544.2988415-1-alexander.deucher@amd.com>
In-Reply-To: <20240725213544.2988415-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=7b515954-d33a-4ff6-9d21-a8387dd37be1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-26T03:49:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA1PR12MB6188:EE_
x-ms-office365-filtering-correlation-id: aacbed59-8c5c-4187-ba62-08dcad2622e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rUsp4YoiDQwUADOZFrPomQyUSqe0E1fVMgE4yWMNLADnNqamp0XL35TY2q?=
 =?iso-8859-1?Q?1UeNe0XTfZKPuV8RjYv6k75Y581YlpeRe5ERTXbTmddFWa0jN5mfnFsYW+?=
 =?iso-8859-1?Q?6k+uUXljPTd9tTHpf/SJQ9sfuflZzP6BsZGvGDTOHhSwwXo9dv/A3hBiJD?=
 =?iso-8859-1?Q?YqLaEMJQZAvi7GdQhqU5dEuz3LDHL1VKVGMvkECtRfR6zG6iFJD26lNl41?=
 =?iso-8859-1?Q?g9CjlLMApKd+Rp8eksfDIN27AcLbQ3maPKx2fJcDBJrpr+gZLHFvV3F4xL?=
 =?iso-8859-1?Q?53rkOY6Zzrh2SGS0YIMFmBsE2wrcc6QEpzeqQUOf4KnqoSzrZQ2SHh6KCK?=
 =?iso-8859-1?Q?EaocVmLFpkBayAlc/gr6mF0u9Wi8fssvn37qbOhaPjtKu9eWtbEQ3afMm1?=
 =?iso-8859-1?Q?06rN0t+xbiW8P5B3wGOUV/DKDF+JvCetHctEuIIChyeH0w7qTBh45U6+oB?=
 =?iso-8859-1?Q?5dhamVlH0U7nrVPeQPT2chi/0kEqMIPlv17EaoxlWHgXbBKZ+NrALQRls8?=
 =?iso-8859-1?Q?qR9nhvr3ik5Oz7ImIRCL1kQlzWXWyS9R8sBHS35IQ3ligHDhq48e4IsgL9?=
 =?iso-8859-1?Q?UPyIHSMqUmhgtiOhEp+Dqrsvhd09diTQy/ENmGu3T5pexY8Kw7UQpVZjox?=
 =?iso-8859-1?Q?koaKDBVkL7+8TilAHjjrIy0dspnte02psNak87wPa0cM0IWthNxPGwIBNU?=
 =?iso-8859-1?Q?8tycyn7+XVATXDqEk7q4rAmAYTVixT2u3SJhiscsCL7zDmmOIeHklddP3F?=
 =?iso-8859-1?Q?k7WTK13lJj46wg2E8uY9zHBedwN2bDaFewbWiy2roO9rnqsQrewMQrgSgG?=
 =?iso-8859-1?Q?2QvDXbMb4yg8uFo2FwCo6Amofn9UMoC9i0w9u52cxWOurzFT5FoxpONpdU?=
 =?iso-8859-1?Q?q/bkeqxVNGN2ExG1oBDccDfTiIHx3cMcLfZDerZmZ/WHFp/ZqdI5sh7S0O?=
 =?iso-8859-1?Q?qNAztAnzDaF4TEZDod8QfwQB6bsul2LwsUjeBtgUkJpRha3xFU/Mc+7bxb?=
 =?iso-8859-1?Q?OqyLMG1Dd7e4aeo83Qi+VnlJ9sun7XNQtC01zW9NuyrcTPKMdTKPaeP5Fk?=
 =?iso-8859-1?Q?J66ObR8HHrgmhX6v8yEtkax4UudnOzBwGgDQ9SV+HrUH/BYPdFV+ioFDQM?=
 =?iso-8859-1?Q?2nr8h+vPKDf1oTQifgqMoAKJD9gbdwKtvfEzXRy/Xfmqvonj4pzLPIdbfn?=
 =?iso-8859-1?Q?rT21pY7r8ik5JOxfWDvwBM30yajH+POPQdDCzTH17oP4Z+h7cNFR4TzVsd?=
 =?iso-8859-1?Q?WZ16S6uzbhUYo4nIzfSys6p8aaA2tvw7myOe/5wKinrRybFVwyY+lecr0s?=
 =?iso-8859-1?Q?x8bNHv2GKE2BON1WqGhg6/iLil/u0fgH3DQF9fBiBocAgoEGNIEH3JfrLq?=
 =?iso-8859-1?Q?VOPr0VrysiYysr9NUzHwSiwPo/JX4FhTSgIMRew0fhFNq12p/PgD4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aZWLI2pyYVv8cmYkTrQwehcvisBNxu60hmAc6/dkVJtFPpnHsHciyoGNIT?=
 =?iso-8859-1?Q?iXFSsHadjQFusdTDG3YOcYrZ0SNyyQaxASkF56G+FsVu1e+E91HNPkpOH5?=
 =?iso-8859-1?Q?nNOBnOX1nF36YytkKUvJdMSNz8xpFhXYhiqHdvxcWGBSDFlJOvsQqWbBUr?=
 =?iso-8859-1?Q?qAujD0YfKZ0v+wxsnG9FPjaLQ27Rd0P2O2EP67IJ9jl9sE3upjxRPzMINs?=
 =?iso-8859-1?Q?Qjv8hRbH6R5eaNApMzpAyunE6QTQ/uXmoYqW2YePIBwMTBz7FyUTDtOI3a?=
 =?iso-8859-1?Q?EqUAcE2OnGVOlanEY5AmldNiZNp6EweTON3mZr3gJT5OSBhC8waNFSO0He?=
 =?iso-8859-1?Q?h6+M2/4TTwJfuNPE7WHZovQXOTUeG7Nk6XHB/nn1WvOhP64MQ5puDYq3qd?=
 =?iso-8859-1?Q?2xwMuZgUfRrGKBG+pukiIGNXLAq2fcJLzHGUt864CA4hVevCNG8qVQIS9a?=
 =?iso-8859-1?Q?/pSv2o7EtAYwLtWJL+kepM/rdVhEVQ7EgJT6ZtN3h/cqZWIn+1ri0pR9tV?=
 =?iso-8859-1?Q?pY4+gJjTk9HzYVKs4wvkjsTzoZVT3d23z6N9I3UXaSUBtf1Ah2u2wOYcUa?=
 =?iso-8859-1?Q?TgfOmUuEgGqpMdqGlFFMK9dt6AAP02d4ls5cKQRtTHWnnhJ6alcnLA7M3e?=
 =?iso-8859-1?Q?mxiGOOFObHj/y3tPPQ8Mb/hbq77v63RfT+VPXAGEWgieEHDzCNWqEEf95u?=
 =?iso-8859-1?Q?BLKP1uf3o2T7WXcb1ovYZAUpj7vvxNg/eACF3hHsL+DI5vdosKhyoidt9T?=
 =?iso-8859-1?Q?O1W7+tPwJ0+7fqSzSEN1ZfV+QbuyJxpEWPopiHFzbDJvLR/AQDv5DKW5a6?=
 =?iso-8859-1?Q?5GBzA4E5xXy3kLVHR16++UiON8kbGi7/rt5GT29fLDjIdOesI7iTktYRl0?=
 =?iso-8859-1?Q?IHgRcrS43RPeCbcM5hERqUSvRYIyoAWIU+FjLoFdSR6BuRyEexU7CdUuAL?=
 =?iso-8859-1?Q?wPSPZg2uHmNNQPDw43qMtDKQoDRv8rcl/O26cHoh8W5YxEqaruQSxHBcwW?=
 =?iso-8859-1?Q?U51KCUjksdXZJBgNZzmAk/5YCivzDFGgcv7sS4QZZBZ6CKnWTjgYFwMtO6?=
 =?iso-8859-1?Q?NmlHfSBuHYiFrxW+Up8hRIxwY1ILjAoP/ZMs+GayfT4bj/5pYTENlbgUWY?=
 =?iso-8859-1?Q?8ve0mMhNv4IORruL6ResOnQsKpIQHDrPT98WSUX6QxuwpnuYO6QCjg1lk7?=
 =?iso-8859-1?Q?JgrGOqer3J4dj18vGGDcvJrgENPD5XbQ+AoEEiiclRwO2Ds7vi8eUE89Ve?=
 =?iso-8859-1?Q?kGahpCPXHGXZdcjhAaAV5OJ5tJMztdorMbVQSKRJqPiIpKmtRlb925oaxC?=
 =?iso-8859-1?Q?yAzXZqTJLTL9Bn0j8ki1fXX5ak5TQQ1trFvjcRWrxgaE/FVJI2eZijIQW5?=
 =?iso-8859-1?Q?9cFJl3Byqc+rTS8FJJwaN6xp6g97NLvuaujgUtgN9jBaT/+uY/GKfzuwpS?=
 =?iso-8859-1?Q?D/oHlHLQP+O4VJ0PTr8s8P7Cw6O4T86U1E/gAVH/OK1rnEF85r4KIDPnCC?=
 =?iso-8859-1?Q?COQ3pOApP8X8efeL5S/ShhbN0PfeJsEvscYiXlf1leqDn0ep5hp78i+/q9?=
 =?iso-8859-1?Q?zIU/EIXZg+7THToyJSnJ/jb2CxgJN879YKTIqiI3D/AbVlmqBP/sYkNoST?=
 =?iso-8859-1?Q?gUXtV/tgp2Fbc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacbed59-8c5c-4187-ba62-08dcad2622e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 03:50:48.5425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hOoOU6a3PWj4yiwGsCcHH9uaOMzynRnj6vlIIa1shCeK1ERE12yLWioEcW/itiELGqsCyCiU60samsvu6hivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
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

Reviewed-by: Tim Huang <tim.huang@amd.com>



> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Friday, July 26, 2024 5:36 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix APU handling in
> amdgpu_pm_load_smu_firmware()
>
> We only need to skip this on modern APUs.  It's required on older APUs as=
 it's
> where start_smu gets called from.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3502
> Fixes: 064d92436b69 ("drm/amd/pm: avoid to load smu firmware for APUs")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f78b4f013ed4..62df787d7b28 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -631,7 +631,8 @@ int amdgpu_pm_load_smu_firmware(struct
> amdgpu_device *adev, uint32_t *smu_versio
>       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>       int r =3D 0;
>
> -     if (!pp_funcs || !pp_funcs->load_firmware || adev->flags & AMD_IS_A=
PU)
> +     if (!pp_funcs || !pp_funcs->load_firmware ||
> +         (is_support_sw_smu(adev) && (adev->flags & AMD_IS_APU)))
>               return 0;
>
>       mutex_lock(&adev->pm.mutex);
> --
> 2.45.2

