Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D29C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 06:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3369A10E6F9;
	Sun, 28 Apr 2024 06:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JoUL7ASL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E076610E6F9
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 06:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDM1BO6DblD2NcGOCLSzNCaXUxop03tI9KSq85BWySLN9ak98B0E068VJLj38fDnJsTkGh2xpmwwTrpyQNHAyyierxuTYkKzftc9t5CULHIuCORXRZIGdrxR3WYxDbmIdeQcA51P61J8ewZsEc7dhVerlnhbUpmVdXwuZAK9zG4Zf+oxCDtCOlJ1dHC2xYa9KUY90OOEK3PPtMJG+uJY+S1/aW3JFwReA1mkK1dP0lIiDJHoqJiAbNgKaP1BLQFtxsPiSxEMOqNniWM+GQ0pK2P74nYAMYgEdeBnZ9I93R+sG65dCdMsDoZJJd4uEEi+qyUb3gL6Ukzxoq5goLWuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hQehA8+fo2zgachIY1H2uSeC4jgChmj81cCiewk4uc=;
 b=ja5u5r3qt/ByrnxomKaPlR/u8ORXvKU6rYvFfyFI4UW4trjLWWEcmRqHT/cqH1Ey+C6D7f9Tfd+iHxuv9YpSJV/lo7vv3DvT7NrRKqGV6xOp2tmdI2O3EDrKvnlX2r2RyDirn5lRMz0KqcsohKlAgREPKPHJQ/JNXHPp5/xm3SypFQF5icYdEO3One/ELTDeT2tzyotyHx+wQFJgge/z22DyM9X4UNF5P3ZEzP68kotWy4gO3cceiOenEDd8/LCQ9MwiKvSEHSVSCAGQnLJ/Jp3xOHjBKsZ0Iu8dYxCc8fE/9EByBPPUkrGtSwc9FJj/am5NvyiYpuPQy9vebtVQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hQehA8+fo2zgachIY1H2uSeC4jgChmj81cCiewk4uc=;
 b=JoUL7ASLdQsz5HYKPx8ZwXo6L7/vmpHZDw4pOdRS4O4syKw6aGUfy2sOQebVTFwMKkLCe1Pdp+cbO1ZdYeJxw+MVDIfBZDbt9CbYJaK4g3HlPHTRCV8P489qZTJf1s4qBdx/QKhxacWdm8nR2CfBxydZwW82qFX2+62PaFTNePM=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 06:23:31 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 06:23:31 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/2 V2] drm/amd/pm: fix uninitialized variable warning
Thread-Topic: [PATCH 2/2 V2] drm/amd/pm: fix uninitialized variable warning
Thread-Index: AQHamTGR3aVStgUJ9UmWRZNY5/Sqv7F9NnXQ
Date: Sun, 28 Apr 2024 06:23:31 +0000
Message-ID: <CH3PR12MB807466F39231C3A260F84863F6142@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240428060141.1575697-1-jesse.zhang@amd.com>
In-Reply-To: <20240428060141.1575697-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=53caf7d5-1262-4734-ab90-7d03c3a9b5c6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-28T06:22:25Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SJ1PR12MB6145:EE_
x-ms-office365-filtering-correlation-id: 033bf35e-e094-4cb6-7a87-08dc674bb9c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?PsmbjldH6Wwdp334RP2DCmv+OB/A9ctHi1psqG1PWrqIm63PLt7/dsMHY4kF?=
 =?us-ascii?Q?6rNJloIBPm90tbYJL1veJoSYkFfts3sS61RPIgLtjblt7xViAT0bPLqOt/qk?=
 =?us-ascii?Q?mb152+zT+QH3Eh4ICa1sXGJlEt0Y6k6xkNFn1tes2cPoiauUGr+z586B2CJl?=
 =?us-ascii?Q?UEjBFN4KeUMiaOmdexxlT3O9E2PLgQv+pgFbG5ehzZZ4QGDiQL99NPj4XfoB?=
 =?us-ascii?Q?Chrj2K2TLwYmBGnJ7mUhM1fwy2qG04sDqtA4u6i2bVlVgqjEBQjzI56v9QxH?=
 =?us-ascii?Q?yToBpy1O2igVVOmQ/pUq2Pqwa0co6BW/8wr0V5SY/FWfWRJQuM5wkZPvpiiW?=
 =?us-ascii?Q?jpvZ04xO6uqBa6xwv9BUk7oFgEikdwNeDjOHUXy5DT6KvE1ucW2fj/3BEbDE?=
 =?us-ascii?Q?amefWZy41dvDkgqV5G7IlkQCc32OQ6INJq1xmNlSmy15NkhPZP+iloMllceK?=
 =?us-ascii?Q?9tvkYUKhJBjpifRcyIlk3VWJz1Lh+mvWqt7yuMyMDjd1uim1bftYfQ5/6KPQ?=
 =?us-ascii?Q?mhtIieFnnTD+DU/w/gEL+my389yAnxyZUQxu355Z7PlI/8np3DqV4qMRBbbd?=
 =?us-ascii?Q?MUTPKUMr5nLpCJT7qriLaHR5SEVYJQIbuHUkbwoC9d0jbbXRh1bvPLf3ZcH5?=
 =?us-ascii?Q?V0jcsmQPE9GbF0qOen25436bAxRFFDBQBGZEAZ7e4X3qbzR+pR44mdW4tGI1?=
 =?us-ascii?Q?OVm/pVdx+FkJ9uZycRlFCdsh6PxJo0xqumlZbT7v8SK+nWuPS8AU1Emq89B8?=
 =?us-ascii?Q?HmATklW69MsLeJIz6L2kRpEK8eb0WnHHozK1FG+GMwIcJKKbJvKsPW888i5G?=
 =?us-ascii?Q?PE+FUEgg1sWVsXI4Yqg8KOn+aENy0h7oA4gVlAqIZY2IyantJ/ss+CNT+Dlt?=
 =?us-ascii?Q?w9WV9qXyrksvZqxLiOWgU9MmxYrrZOEHLfKIDCFesYswYj+K0pudxjNX93oa?=
 =?us-ascii?Q?J0V82sQxZMnfEyY5fpa/ceiCWjpVO/SHb9dMtONoJDH7txWdGArw/fs3cmip?=
 =?us-ascii?Q?lS8/HW5GvWZBl+sim6KG2zwWIoJHsEdOu/hp7sJjilQYlvYlYkOI7Z9MGVce?=
 =?us-ascii?Q?QrIjtHP9OOmhjfoXNnBu6RtuXoPvlQfNqGv5FtvO2hXFwckyRtXC0yYUDNu/?=
 =?us-ascii?Q?byfVatU96nFB/jS3v3TbhwYCUtVRvVdjDYMGV1xuFhYvmLq953p4l9/OjIV1?=
 =?us-ascii?Q?n4dMtpM2+tYo9qaBbsa3SK1ULkG6mbPJUKxCKtJlY5ZcS+T06bB22dQriJbm?=
 =?us-ascii?Q?DXeL+zKuxP7gGxHdik2ICXZVFdblpOAoZG6sbIksTLbJV2qefDCohMPpG8P1?=
 =?us-ascii?Q?nBisMtFkj5ali5qLIGvN5HABRRwOvsSFaJ5/97B3tXZxjA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eImCkkKgeGbMJlDbG+/EB5mr3bjTKtxQJE0WS30GZzmbTd3xgD5/rP4YyHjg?=
 =?us-ascii?Q?IpcPR9jS6Y0rfbjO39xR9IShQect3/WqU4CpOxJP7RAMaAdPv56XCMdbwUmc?=
 =?us-ascii?Q?5pWPUbNOzF3bKeDfvboVrBe+kk//wh60fWRTxSFweLPSv1zcOBjVVYBoSz3j?=
 =?us-ascii?Q?UOkSeqNQiymK7z8BJID7MZadIg84ZvWsu3RZDMFUOAGbjGOrssaX62O+KgP/?=
 =?us-ascii?Q?MZwA+CqX0j0LDsjBllhMGSdvbwZtuEH13y/4TTvK5aKntkyLssG9gK78Hu9X?=
 =?us-ascii?Q?HF/2dVY0L6m4cXDvsd5Q078rc7N+nW9k/bKFd7/1IBNsZrNVlWZAB3M7/A9H?=
 =?us-ascii?Q?2uRgKoEl16MERQF3o//v5f0xBC5TWeoxFARarSuE4fnK3KOD5geZ0y2HKOJe?=
 =?us-ascii?Q?W0fqyvRiSOTNQUi6mluJSAh7FSm3PENjdtK19qjjlMBBENbUvh7Wtxqxcl7m?=
 =?us-ascii?Q?PxNFImTPFqI4nT2h6gzl1XMdmO2BC64n9THROgygoCD7iOkXGyvBWX/3/Zfp?=
 =?us-ascii?Q?rzYUl8zWjmOCf62l+usY8hLLULTNVZdo/p63U8vjtKgJkAmAyqS+cTMDkuxY?=
 =?us-ascii?Q?yhH9yHVN8AgAVmSJMwsM6HopkXgg311uB4m4nKByLZF9FJku3NhkLwx4yQzV?=
 =?us-ascii?Q?pxJDstM99medSGPmn3bLIrg1kJtjYlfa3DZ95s/PRLeBFfNnKyPMO1JehtNG?=
 =?us-ascii?Q?p45rdRrgcRZWa+lIoKEFp8KMAzVSnzMrysevpLotB1I9OvnTSrIFxU0J3xcN?=
 =?us-ascii?Q?SawVTkrgzaaUrBD2pfzDU02Q+1AY26Wp1S9AOIn+qRez+c9Jv0HBlT4pVYVE?=
 =?us-ascii?Q?El8suDrol3/tYa7XImfbwCgdJuLpP1/faYUChJFqyjzFRzRghARqO0pNCVYr?=
 =?us-ascii?Q?FvCMAWd3hVyrZAxh14JBQbdYdzh18Lkngd9yu89mY9M2MGG9lLLLV7qwr2go?=
 =?us-ascii?Q?x8cT+ZJW3NJ5ErZ4SRFdL2Yx3aI0LIPe8fg+KpPLhV0SQ3kWytskls3Gq1Dd?=
 =?us-ascii?Q?gFsz6EOy2BwK6ld+kfGCrVndAm16z67agbcrJphev9Y+lPnuDV8uZH5/Xn9H?=
 =?us-ascii?Q?YtfpX5NFyCMlFZavcbkwywRQakubQR463QuB3aAuaH4g+DKd3p57U0iC9tiH?=
 =?us-ascii?Q?Jc6tz5kv1ize9Z93+swiPVNHy40/5Odj0Xxygqjn2wgWsdn2W8ZNanl1SoYP?=
 =?us-ascii?Q?Rb9OYIkFJI023h2ZbqMGG5WchP5N1JFXaEnNoxq2RdmyTGZCSvIHsL1HnKBk?=
 =?us-ascii?Q?mYEFBaV3lkN/hWiUC1shlC8zXQn8NvHHJUK4Fe8d5kX+hsEwA2mZus7b/y5n?=
 =?us-ascii?Q?YGy/y08v46DHMMHIvW8oYQrLP0NZEnKhMbZDDnlLYGmhgs/XhdcIBK/e+TmQ?=
 =?us-ascii?Q?AogLneL5QVo+3xlFZ0TRBGWygG/H7ciT9wym0qh5B5NN9DKag5oX1x4s2o+S?=
 =?us-ascii?Q?g3zEL7wEKWG13Fap4bUnelhfOx/+QfXbKgZNR2fRy4dOwic83YGoFlCd/KGr?=
 =?us-ascii?Q?nnkNytOgH0gFjUeLP1okDB57PTO8PxoquGx0FAGwCUZjAS/KLsgrrRatWSdz?=
 =?us-ascii?Q?ubqBDGYOeZ9FK4R3TUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033bf35e-e094-4cb6-7a87-08dc674bb9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 06:23:31.6416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1K93Qch7XZmrWC8qHvFNpDsVsSS854FQFhD0asbJpBQ39zqnE6thodAByZAueP1qUBHKRMaszjuWADaqLTQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

Best Regards,
Tim Huang

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Sunday, April 28, 2024 2:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/2 V2] drm/amd/pm: fix uninitialized variable warning
>
> Check the return of function smum_send_msg_to_smc as it may fail to
> initialize the variable.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  8 +++++--
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 21 ++++++++++++-----
> --
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 19 +++++++++++------
>  .../amd/pm/powerplay/smumgr/smu10_smumgr.c    |  5 ++++-
>  4 files changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 02ba68d7c654..f9f016cb60ce 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1310,13 +1310,17 @@ static int smu10_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetGfxclkFrequency, &sclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetGfxclkFrequency, &sclk);
> +             if (ret)
> +                     break;
>                       /* in units of 10KHZ */
>               *((uint32_t *)value) =3D sclk * 100;
>               *size =3D 4;
>               break;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetFclkFrequency, &mclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetFclkFrequency, &mclk);
> +             if (ret)
> +                     break;
>                       /* in units of 10KHZ */
>               *((uint32_t *)value) =3D mclk * 100;
>               *size =3D 4;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 1fcd4451001f..5c95eda6cbd2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -4000,6 +4000,7 @@ static int smu7_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>       uint32_t offset, val_vid;
>       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr-
> >backend);
>       struct amdgpu_device *adev =3D hwmgr->adev;
> +     int ret =3D 0;
>
>       /* size must be at least 4 bytes for all sensors */
>       if (*size < 4)
> @@ -4007,12 +4008,16 @@ static int smu7_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &sclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &sclk);
> +             if (ret)
> +                     return ret;
>               *((uint32_t *)value) =3D sclk;
>               *size =3D 4;
>               return 0;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &mclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &mclk);
> +             if (ret)
> +                     return ret;
>               *((uint32_t *)value) =3D mclk;
>               *size =3D 4;
>               return 0;
> @@ -4965,13 +4970,14 @@ static int smu7_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>       struct smu7_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
>       struct phm_odn_clock_levels *odn_sclk_table =3D &(odn_table-
> >odn_core_clock_dpm_levels);
>       struct phm_odn_clock_levels *odn_mclk_table =3D &(odn_table-
> >odn_memory_clock_dpm_levels);
> -     int size =3D 0;
> +     int size =3D 0, ret =3D 0;
>       uint32_t i, now, clock, pcie_speed;
>
>       switch (type) {
>       case PP_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &clock);
> -
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &clock);
> +             if (ret)
> +                     return ret;
>               for (i =3D 0; i < sclk_table->count; i++) {
>                       if (clock > sclk_table->dpm_levels[i].value)
>                               continue;
> @@ -4985,8 +4991,9 @@ static int smu7_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>                                       (i =3D=3D now) ? "*" : "");
>               break;
>       case PP_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &clock);
> -
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &clock);
> +             if (ret)
> +                     return ret;
>               for (i =3D 0; i < mclk_table->count; i++) {
>                       if (clock > mclk_table->dpm_levels[i].value)
>                               continue;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 9f5bd998c6bf..b47e1ab12430 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2481,10 +2481,12 @@ static int
> vega10_populate_and_upload_avfs_fuse_override(struct pp_hwmgr
> *hwmgr)
>       struct vega10_hwmgr *data =3D hwmgr->backend;
>       AvfsFuseOverride_t *avfs_fuse_table =3D &(data-
> >smc_state_table.avfs_fuse_override_table);
>
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> -
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> -
> +     result =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> +     if (result)
> +             return result;
> +     result =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> +     if (result)
> +             return result;
>       serial_number =3D ((uint64_t)bottom32 << 32) | top32;
>
>       if (pp_override_get_default_fuse_value(serial_number, &fuse) =3D=3D=
 0)
> { @@ -3924,11 +3926,16 @@ static int vega10_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
> +             if (ret)
> +                     break;
> +
>               *((uint32_t *)value) =3D sclk_mhz * 100;
>               break;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
> +             if (ret)
> +                     break;
>               if (mclk_idx < dpm_table->mem_table.count) {
>                       *((uint32_t *)value) =3D dpm_table-
> >mem_table.dpm_levels[mclk_idx].value;
>                       *size =3D 4;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> index 7eeab84d421a..ac9ec8257f82 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> @@ -185,10 +185,13 @@ static int smu10_copy_table_to_smc(struct
> pp_hwmgr *hwmgr,  static int smu10_verify_smc_interface(struct pp_hwmgr
> *hwmgr)  {
>       uint32_t smc_driver_if_version;
> +     int ret =3D 0;
>
> -     smum_send_msg_to_smc(hwmgr,
> +     ret =3D smum_send_msg_to_smc(hwmgr,
>                       PPSMC_MSG_GetDriverIfVersion,
>                       &smc_driver_if_version);
> +     if (ret)
> +             return ret;
>
>       if ((smc_driver_if_version !=3D SMU10_DRIVER_IF_VERSION) &&
>           (smc_driver_if_version !=3D SMU10_DRIVER_IF_VERSION + 1)) {
> --
> 2.25.1

