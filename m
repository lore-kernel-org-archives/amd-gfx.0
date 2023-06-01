Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47D9C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 07:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3371F10E521;
	Thu,  1 Jun 2023 07:42:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB4210E521
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 07:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBHWOrLQo0cH9b/tbGLZEqbRqKPUFIGK75mVSVpiyQMPBeNrjN3ymjQ5ljgl7UI6FkYRvL/1NDW68krStGs3aQNiYRfDYC1MJViIVBFP7JSh15u1loMn8vtVBNwTtOK7e7aTdpNQqY8duZnCvhYj/XoNuRGT+Ru56Rs8bEWN3J/rJhIUpbHb1Pbr3TU4xBv4ImqAyumDIuZj3eT01i9vimiGFYSU7hoEbMV2HU4F5JRyvRF/rHGG6dsM7lXYnlsQAmllOYSTehTfit9uU8arBU0C+NMqlsP/CFrE2Yotc+zELnmBHGsMaDCpTtfhQnmpVbW7JYHDYNsWZ9yDnN5hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9imm2n0Wp9HNUop3/oIAZw9gm+5I8JorFWFkmUMge8=;
 b=Ln1/72Csksj81rqEmTbdAqsHSllQ2WGYH2m3TA+UsSb+o45n9ZAYQtBkRTJu+IhSWqYAxxX/tndnmTssYoLm58q4tfkYSBDLu65K1MJcnWBwFpKSa+E44WWCdFKl5DG3B+wgHsZ38FUM2YhFMMexwoTdE6rqn+9lV7oqlE7ILOMZsAffjmAhrnKSHN9bzN3kTFb+Joy+K8CkPKyFOqI6k9QuYHA96gEdWrCrIuvmHVjEWAtOXnJ9RzSftnkQhlRfXLSMzwhhJiapI7TcdGcQvDOq3Rlx/J6KZ5UnUUuzpKrD4xcGoT2HxvtRFC0F/9QlYldaHqt3gjyQ2aSVFJ2Fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9imm2n0Wp9HNUop3/oIAZw9gm+5I8JorFWFkmUMge8=;
 b=4kGohgkbKcBXAS3lQ8QAKSxSbgb+3BuA8iuuVu7CZNPwyBxTGBspUEgPGAYtDspNSr5krDv8f5WIs7zhf5xm3GkUZYVFAZ38efAGcW0qy8nWtz77i/4jvaAtswzKnBcqFSoRosBhnLlsn+MonCLUYiARPwtK5Esafwv7neWJf1U=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 07:42:26 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4900:dd2:61b1:1941]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4900:dd2:61b1:1941%3]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 07:42:26 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amd/pm: Fix SMUv13.0.6 throttle status report
Thread-Topic: [PATCH 3/3] drm/amd/pm: Fix SMUv13.0.6 throttle status report
Thread-Index: AQHZlFqpyWZML9+FDEyNdWtxvYjHXa91kEnQ
Date: Thu, 1 Jun 2023 07:42:26 +0000
Message-ID: <PH0PR12MB54040F0836793DCC6D9EF290F6499@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230601072803.1321429-1-asad.kamal@amd.com>
 <20230601072803.1321429-3-asad.kamal@amd.com>
In-Reply-To: <20230601072803.1321429-3-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fade9f38-2499-41c0-b1bb-81edb4f8ff29;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-01T07:41:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|SA1PR12MB8966:EE_
x-ms-office365-filtering-correlation-id: 94b09b18-53c0-4229-b903-08db6273bee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+iizT/BEUzFzkD6tMzAX6AOJP9VYRAHos02DNyXHKVPaeGeaLc5Q2Qezie08gfl40pX8Ck78zOv9Ha155SgBtzbwxFR6NMcVMvoCK5HRGsjYbB/TkmVn6hI3i1xXd2hWJhIodKhSMBGyEhEDxn+qXUSwfn2TqJoiCSVHgOnt9I4KjRH4XQiwtqLXhYFmRhK2zoFs/3/b01fjRUWn/+UGO494RgM6i9ezpF+B2n4aC6nSruGBgC/P/qa8QNdIyn3Uq3m6kgEvlFzbGqZt7nhK7iwKUeZb0XF1hVhmkY6V7nF/I5zHqfN2sNOFwCCOSKPZ58OOgHB+SSLzKFeG41k3CvEHTBRSqu9vkIDk1QBw3095hUPw7S6nM5fDsHcTy9nwBtAfYFUwf0ogIJfhk4naebvAHvF5SpQyRi1vmMpQ4UKGrGlqWrCqJVJO84t9raI5zU+azHKC+BRUsYIRdEfBoErXgOa9+JZBpJdHNHejh7i9/zqQ5AH1kCNTJLuDsAuNwn5WZY8x1Or3bDd4CRVYIzfjsl2BcJ6rK3YkvEAnMy7ao95e/TjhNYRwYvK9OkdMR5E8ILedXBrOeQMSVX5uPwcKjVyaskw65rAaUow2BQ0PxS5xGPh9inRPi5/Lrr7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(83380400001)(7696005)(316002)(41300700001)(38070700005)(33656002)(186003)(9686003)(6506007)(26005)(53546011)(55016003)(8936002)(2906002)(5660300002)(52536014)(8676002)(86362001)(122000001)(38100700002)(54906003)(110136005)(478600001)(4326008)(71200400001)(76116006)(66446008)(64756008)(66476007)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m5mNgyrF8QVeBRJ8hSVfd8Cipe9bShiJtZLCRKraEclz/QsReS9ZlasdZG4N?=
 =?us-ascii?Q?XCx9vyjpzF8dUH/Y1W+LOjKPmu7D/J0NzAW0t/PwSBToWZ7VBFtcU51W+CIi?=
 =?us-ascii?Q?eEkoWXO5liuX6SMz1naugzopo1xal5oj5DB8C8Lx3IIvHtNeCsSaAeVD36Uz?=
 =?us-ascii?Q?26JqDiSHd1a1LTI6Em0lpluhEpOnyIFUGDFFv3LrI1kBCCluS3BqTQE1q1G3?=
 =?us-ascii?Q?XlevpG+quUHQV1uwn6lqtdRLaY45MQK9cd+JEz30vJPXnDMMTdAk0G+Z2JSX?=
 =?us-ascii?Q?f3EvfjisdjrkRxQdDMWgPi5q9Zst9cZ+kv8e1bR5OqODn8njT9wreCqhMWnT?=
 =?us-ascii?Q?RDTlUD9bh0hStCbOhcjsezPV+8gKjPABWvd10Qu9/IBLfQLg0XRpPLCL0Zzg?=
 =?us-ascii?Q?Drzy1XAvAU66wIUdU5K0rZQMB0piC5ipwx1cfRZaoKkBOgUW1AjuBdySZ1Vh?=
 =?us-ascii?Q?/O+QQKHwkMpTmqlFyXDymYZ6gaMJT/XSvadvy3txd1ckkwSSnSnl2E0hRUI0?=
 =?us-ascii?Q?Jyn59W9NalRAWm65VbSXBkE8sMYPBJZ8C2YPG+pfCddxwOQ2MFY32SHz4Aqx?=
 =?us-ascii?Q?boIQ9PFnq/VAOCYp/od98yNCNcBp06kcZNxQzBjBGNqFsJbEemgzeu2kGkDp?=
 =?us-ascii?Q?im4wU7NSyS5eihAm7WvtU8binl5L85uyI9E8S22+ybbwMJQ/fMlPpGONpO/A?=
 =?us-ascii?Q?0BgeNDWio4P9l0ih28taltBkG+1C+RNSksEI0fne81K7qBt6jfXxMOWYJgJq?=
 =?us-ascii?Q?Y9YeG60CFafl3Bg881AbHOqaA5g0/0+pOE5Wvp0KrSpfjWm7R8XJl6TftDU/?=
 =?us-ascii?Q?ogpbSBYXm4uoyvrsfPVWFhRtr/hUdp4XzwC8uRmO2HhZ82jJl4D5yoWx8ALC?=
 =?us-ascii?Q?UDcJMs3BkxodASZyW9By+I2tcuFG0JItcF0FT8aJVf+KOplT520Avf5d1+VM?=
 =?us-ascii?Q?NegshnBD/7yOtjOElYIQysixLUH4KbzCsFofPQyUZvkUjj5rDzkTJLyppZXC?=
 =?us-ascii?Q?Ek8ttwTW2P7buVPXJE4cdX7zgrGE4tYpNXjmelCHCxSG2kq5qG2qcAA3lYRe?=
 =?us-ascii?Q?U5yi2hhZgojCKMmrWMqZRHtZG/BD72ApFWcuYvUpZgtEtDLyaHnkCanP7NIq?=
 =?us-ascii?Q?mMbssK/UbWvnoFn1ihl/Z7GOoki4mrHROWetGVFp1s5HQsID/OuS/CfgM7gC?=
 =?us-ascii?Q?lfY2LDtCQqSy1IHln2DxrtLgxiiZre+sXSV44ml+7nkaOklgKeih2U2JCvyw?=
 =?us-ascii?Q?S4M4mYXmnVaKScQ0EKnIFK+toZlZRdynt30LQ/K4EUWl4YhvgHTvBPE6m3sY?=
 =?us-ascii?Q?nvzpgimMUt3WNqKjRzFI+qPRk79sH/LOglPosSsl6HPx3GIGbbhJ8qNJrb9r?=
 =?us-ascii?Q?d1V0zg/un7htRPuNCe58Gsj8RXcOz2ASiWeePbdcaZiGg8UHN2Z1OJgqSMDA?=
 =?us-ascii?Q?qG06rQVo/jkfyUzfDKBVOQ/MwGGwZwlXZdy4SzdDFl1Y4Nm4eCSKymiafCGQ?=
 =?us-ascii?Q?+PhrOu3I0JKeow7IikuP/AX8PI+kl6bvbM2liJ5t039WksSBObeLRDhwjetp?=
 =?us-ascii?Q?9caC89SD4SQ5SE3EJ4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b09b18-53c0-4229-b903-08db6273bee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 07:42:26.6041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Haaqp7nEiDexAw/6FHtD8sPu3MocXnuT0tjNajqmGDM16EmZsJcjkf6AsW1dROsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Thursday, June 1, 2023 3:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amd/pm: Fix SMUv13.0.6 throttle status report
>
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> Instead of accumulated counters, PMFW will pass the throttle reason along
> with throttle interrupt. Use that context information to report the exact
> reason for throttling.
>
> v2: Removed Dummy definition
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 95 +++++++++--------
> --
>  1 file changed, 45 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 27fd71afc73f..b9f32e0364db 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -82,8 +82,6 @@
>
>  #define smnPCIE_ESM_CTRL 0x111003D0
>
> -#define THROTTLER_TEMP_HBM_BIT 2
> -
>  static const struct cmn2asic_msg_mapping
> smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(TestMessage,
> PPSMC_MSG_TestMessage,                        0),
>       MSG_MAP(GetSmuVersion,
> PPSMC_MSG_GetSmuVersion,                      1),
> @@ -174,17 +172,12 @@ static const struct cmn2asic_mapping
> smu_v13_0_6_table_map[SMU_TABLE_COUNT] =3D {
>       TAB_MAP(I2C_COMMANDS),
>  };
>
> -#define THROTTLER_PROCHOT_GFX_BIT  0
> -#define THROTTLER_PPT_BIT 1
> -#define THROTTLER_TEMP_SOC_BIT 2
> -#define THROTTLER_TEMP_VR_GFX_BIT 3
> -
>  static const uint8_t smu_v13_0_6_throttler_map[] =3D {
>       [THROTTLER_PPT_BIT]             =3D (SMU_THROTTLER_PPT0_BIT),
> -     [THROTTLER_TEMP_SOC_BIT]        =3D (SMU_THROTTLER_TEMP_GPU_BIT),
> -     [THROTTLER_TEMP_HBM_BIT]        =3D
> (SMU_THROTTLER_TEMP_MEM_BIT),
> -     [THROTTLER_TEMP_VR_GFX_BIT]     =3D
> (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> -     [THROTTLER_PROCHOT_GFX_BIT]     =3D
> (SMU_THROTTLER_PROCHOT_GFX_BIT),
> +     [THROTTLER_THERMAL_SOCKET_BIT]  =3D
> (SMU_THROTTLER_TEMP_GPU_BIT),
> +     [THROTTLER_THERMAL_HBM_BIT]     =3D
> (SMU_THROTTLER_TEMP_MEM_BIT),
> +     [THROTTLER_THERMAL_VR_BIT]      =3D
> (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +     [THROTTLER_PROCHOT_BIT]         =3D
> (SMU_THROTTLER_PROCHOT_GFX_BIT),
>  };
>
>  struct PPTable_t {
> @@ -642,16 +635,14 @@ static int
> smu_v13_0_6_freqs_in_same_level(int32_t frequency1,
>       return (abs(frequency1 - frequency2) <=3D EPSILON);  }
>
> -static uint32_t smu_v13_0_6_get_throttler_status(struct smu_context *smu=
,
> -                                              MetricsTable_t *metrics)
> +static uint32_t smu_v13_0_6_get_throttler_status(struct smu_context
> +*smu)
>  {
> +     struct smu_power_context *smu_power =3D &smu->smu_power;
> +     struct smu_13_0_power_context *power_context =3D
> +smu_power->power_context;
>       uint32_t  throttler_status =3D 0;
>
> -     throttler_status |=3D metrics->ProchotResidencyAcc > 0 ? 1U <<
> THROTTLER_PROCHOT_GFX_BIT : 0;
> -     throttler_status |=3D metrics->PptResidencyAcc > 0 ? 1U <<
> THROTTLER_PPT_BIT : 0;
> -     throttler_status |=3D metrics->SocketThmResidencyAcc > 0 ?  1U <<
> THROTTLER_TEMP_SOC_BIT : 0;
> -     throttler_status |=3D metrics->VrThmResidencyAcc > 0 ? 1U <<
> THROTTLER_TEMP_VR_GFX_BIT : 0;
> -     throttler_status |=3D metrics->HbmThmResidencyAcc > 0 ? 1U <<
> THROTTLER_TEMP_HBM_BIT : 0;
> +     throttler_status =3D atomic_read(&power_context->throttle_status);
> +     dev_dbg(smu->adev->dev, "SMU Throttler status: %u",
> throttler_status);
>
>       return throttler_status;
>  }
> @@ -721,9 +712,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct
> smu_context *smu,
>       case METRICS_TEMPERATURE_VRSOC:
>               *value =3D SMUQ10_TO_UINT(metrics->MaxVrTemperature);
>               break;
> -     case METRICS_THROTTLER_STATUS:
> -             *value =3D smu_v13_0_6_get_throttler_status(smu, metrics);
> -             break;
>       default:
>               *value =3D UINT_MAX;
>               break;
> @@ -1290,13 +1278,11 @@ static int smu_v13_0_6_irq_process(struct
> amdgpu_device *adev,
>                                  struct amdgpu_iv_entry *entry)
>  {
>       struct smu_context *smu =3D adev->powerplay.pp_handle;
> +     struct smu_power_context *smu_power =3D &smu->smu_power;
> +     struct smu_13_0_power_context *power_context =3D
> +smu_power->power_context;
>       uint32_t client_id =3D entry->client_id;
> -     uint32_t src_id =3D entry->src_id;
> -     /*
> -      * ctxid is used to distinguish different
> -      * events for SMCToHost interrupt
> -      */
>       uint32_t ctxid =3D entry->src_data[0];
> +     uint32_t src_id =3D entry->src_id;
>       uint32_t data;
>
>       if (client_id =3D=3D SOC15_IH_CLIENTID_MP1) { @@ -1305,7 +1291,10
> @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
>                       data =3D RREG32_SOC15(MP1, 0,
> regMP1_SMN_IH_SW_INT_CTRL);
>                       data =3D REG_SET_FIELD(data,
> MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>                       WREG32_SOC15(MP1, 0,
> regMP1_SMN_IH_SW_INT_CTRL, data);
> -
> +                     /*
> +                      * ctxid is used to distinguish different events fo=
r
> SMCToHost
> +                      * interrupt.
> +                      */
>                       switch (ctxid) {
>                       case
> IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>                               /*
> @@ -1316,8 +1305,17 @@ static int smu_v13_0_6_irq_process(struct
> amdgpu_device *adev,
>                               if (!atomic_read(&adev-
> >throttling_logging_enabled))
>                                       return 0;
>
> -                             if (__ratelimit(&adev->throttling_logging_r=
s))
> +                             /* This uses the new method which fixes the
> +                              * incorrect throttling status reporting
> +                              * through metrics table. For older FWs,
> +                              * it will be ignored.
> +                              */
> +                             if (__ratelimit(&adev->throttling_logging_r=
s))
> {
> +                                     atomic_set(
> +                                             &power_context-
> >throttle_status,
> +                                                     entry->src_data[1])=
;
>                                       schedule_work(&smu-
> >throttling_logging_work);
> +                             }
>
>                               break;
>                       }
> @@ -1895,37 +1893,35 @@ static int
> smu_v13_0_6_allow_xgmi_power_down(struct smu_context *smu, bool en)
>                                              en ? 0 : 1, NULL);
>  }
>
> -static const struct throttling_logging_label {
> -     uint32_t feature_mask;
> -     const char *label;
> -} logging_label[] =3D {
> -     { (1U << THROTTLER_TEMP_HBM_BIT), "HBM" },
> -     { (1U << THROTTLER_TEMP_SOC_BIT), "SOC" },
> -     { (1U << THROTTLER_TEMP_VR_GFX_BIT), "VR limit" },
> +static const char *const throttling_logging_label[] =3D {
> +     [THROTTLER_PROCHOT_BIT] =3D "Prochot",
> +     [THROTTLER_PPT_BIT] =3D "PPT",
> +     [THROTTLER_THERMAL_SOCKET_BIT] =3D "SOC",
> +     [THROTTLER_THERMAL_VR_BIT] =3D "VR",
> +     [THROTTLER_THERMAL_HBM_BIT] =3D "HBM"
>  };
> +
>  static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context
> *smu)  {
> -     int ret;
>       int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t throttler_status;
>       char log_buf[256];
>
> -     ret =3D smu_v13_0_6_get_smu_metrics_data(smu,
> METRICS_THROTTLER_STATUS,
> -                                           &throttler_status);
> -     if (ret)
> +     throttler_status =3D smu_v13_0_6_get_throttler_status(smu);
> +     if (!throttler_status)
>               return;
>
>       memset(log_buf, 0, sizeof(log_buf));
> -     for (throttler_idx =3D 0; throttler_idx < ARRAY_SIZE(logging_label)=
;
> +     for (throttler_idx =3D 0;
> +          throttler_idx < ARRAY_SIZE(throttling_logging_label);
>            throttler_idx++) {
> -             if (throttler_status &
> -                 logging_label[throttler_idx].feature_mask) {
> +             if (throttler_status & (1U << throttler_idx)) {
>                       throtting_events++;
> -                     buf_idx +=3D snprintf(log_buf + buf_idx,
> -                                         sizeof(log_buf) - buf_idx, "%s%=
s",
> -                                         throtting_events > 1 ? " and " =
: "",
> -                                         logging_label[throttler_idx].la=
bel);
> +                     buf_idx +=3D snprintf(
> +                             log_buf + buf_idx, sizeof(log_buf) - buf_id=
x,
> +                             "%s%s", throtting_events > 1 ? " and " : ""=
,
> +                             throttling_logging_label[throttler_idx]);
>                       if (buf_idx >=3D sizeof(log_buf)) {
>                               dev_err(adev->dev, "buffer overflow!\n");
>                               log_buf[sizeof(log_buf) - 1] =3D '\0'; @@ -
> 1934,10 +1930,9 @@ static void
> smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
>               }
>       }
>
> -     dev_warn(
> -             adev->dev,
> -             "WARN: GPU thermal throttling temperature reached, expect
> performance decrease. %s.\n",
> -             log_buf);
> +     dev_warn(adev->dev,
> +              "WARN: GPU is throttled, expect performance
> decrease. %s.\n",
> +              log_buf);
>       kgd2kfd_smi_event_throttle(
>               smu->adev->kfd.dev,
>               smu_cmn_get_indep_throttler_status(throttler_status,
> --
> 2.34.1

