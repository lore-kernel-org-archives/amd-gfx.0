Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C9C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 08:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CDF10E777;
	Thu, 26 Oct 2023 08:37:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9B810E777
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 08:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi+RLeOs0vXwTA8SsLyi2pE2XicaZ7d0C5nYUddO/FGNAwGGfsrsgCldvqrpXBoa/koNB+rzyV524PblEh9Fb6exWOBIELNBpBjey6/c/vCYArF6I/zRvYU4VeR8x0FuRH/rnIU1o3IOXTmnqkVgjWUfRMbJbRJmgsZaKE8ZrBKakSzCwq2oxO9FUgfMGi6QOd2BMQfbqq0IpAPlt7tAoG4npXM/tAp+R3v6JfLzwvb8cQHgTOJ7HJU/lQMctNeXJg1zOPBT7AJ1x29o7TFTasrCPM3dmNKHzgPn3g/Cm1FUCNRUXIBztQBeygKrlqrEs5BMNt+31Ihev7PaDF8h6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2ZEaLcDC80TyRLRCxaA1nSdIYa2GpV02YX4YkFaN9A=;
 b=GRrBgPCwgVKt13qKHjQEDrmEqs9Qv+nKEhE8n7QcmiAnlOf5sm3+kbmajYYrZcgXJmfc15uEmarYETcdi8N5Zem9k7JTIg2h6A4NJDBslUpas2jUr+hHhGhP2nwIrjEWWXtVP9SB85m6iVaRc1Sjvkj9qDh9qbTrIuzF3JknDnzkbCkNTFdbcZeJrJq2lXdh0TOcWOqoUsQRGo+cNhYGEmyhqv9OAa+BCyysfRWddb337AhzEBEjcWedXUWfyltug0VOdluicxPImoK+7BHYy5zxuXFmiYUKMWZjMJjAZz+H0VJ0qK/jwEUI3u4h5dIljZ6ATl0PM06LczZx8LOIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ZEaLcDC80TyRLRCxaA1nSdIYa2GpV02YX4YkFaN9A=;
 b=g4pH0YIqio4tGAuQI7z+3mOJL01b+PdiuBlGQkjrK7N21ExWNYswMWM9o4e5Y+8Jj6Jd2mFJ/JuECLrBTWDodA1204iWoy+MHkoGpvsbTF6uo/OomgfNZ3T6iEL9byh/5NrwbKwjNcsnjts8Jww5tUSE7RU2lAtVhkLFII1ihkI=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:37:29 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::2f3f:cf6e:c3a5:90db%2]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:37:29 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when system
 resumes from S3
Thread-Topic: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when
 system resumes from S3
Thread-Index: AQHaBolcTIN/ef8sjEK2yh7Z2ALO0bBbr7wAgAAJawA=
Date: Thu, 26 Oct 2023 08:37:28 +0000
Message-ID: <CYYPR12MB86552E8E3E4FA80F08FFDA759CDDA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
 <3e270efa46affe3c52614099575368726eb32793.1698158958.git.perry.yuan@amd.com>
 <CY5PR12MB63690CB8961261A2B0E64620C1DDA@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63690CB8961261A2B0E64620C1DDA@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a1a0ff45-6a71-40e6-ab4f-f00b7db4d757;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-26T07:31:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: a4d87b9e-c497-4e0b-09d8-08dbd5fec9c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GavTKdu/XGTKcWNeQdsQZIzPxgdcXpxtKlPivuwWLBDyl4U40mqFZF9TMUPfGkkB6tDhLqPRrzMtxqeybV1PencxbZKNiOlJaW90Wegvr7r8xlTlxHTlyz7T0E796lXUIWurqL7OmdD0nIJihd0gnE5zo4UMnnagb7PSoB8HUI6ttC81E3JjcVZoXnrkIOeU8remwAxAFmft7QvXMhlJ098rRWmZ1z2xNIaDZEW80fmg8oxq2gzDfWi0tfD+xlfDrcAiqLw3apT0sUMAUqY0RitjNpnHarWPanRnExIQ69Yv8G8L9MqfwsXFxphCiiuAusaqMs1l+IOLwXulfyMq+82LO5T+70N/0RzgQXJ1S0AH76nnErFkBODB/JnkedUVMh+0RTVm6wzVivsROeqXufSBuv2K1lCVztPSQsLG/x36uVukL60HVXqD+bQ0MdaV8wK+mqScROidW1R6qQRjAkvLHckklRwGiXe6rcKVb/zXb98pM1Bzu94AuekSmcCNKrKtH/iwaUdPuwQeACrB2JQ6dOFeie7do9nJQStD6pkVdlWEGHyeW/9w+H63otP7UistUi8+G35JraQhFzWbt5WL+3jgz9UZ5CAWuH32/TYgA3dv8x+CITiaPaO9EewO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8655.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(55016003)(2906002)(38100700002)(66446008)(41300700001)(122000001)(54906003)(478600001)(66556008)(316002)(76116006)(66946007)(66476007)(71200400001)(110136005)(6636002)(7696005)(6506007)(53546011)(83380400001)(64756008)(9686003)(4326008)(52536014)(5660300002)(33656002)(8676002)(8936002)(26005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1BAoMWD4AhRKlx8APZnXePCldRvSOL9yqNytSTM7YWjOQdcCAGqbYwXIPL0?=
 =?us-ascii?Q?HFWw8Fz9ZtTdyQKRUUKe9zIa/WxeK2GsSx+RI/2dAmV3hQoRMiaMuT5nyeHS?=
 =?us-ascii?Q?5GAG40OEtIt6wsdjgrF7L0+GrJCVJgd2ShuN0UsrlhwwKKk8hnix6BIYtbTB?=
 =?us-ascii?Q?bUZ9I3HVqh0NvoIfHpk2A03KYHre+WQwjJ2nMLRMwbSAKyCC70AYPBdFncys?=
 =?us-ascii?Q?DnI3mEAZeFK1Tm3bQZHPVgDlAhe2ONMmx2mdvs2gHH8gt8X0cl/RITCPK9uI?=
 =?us-ascii?Q?BHg0NbTHiHqnVfqCbxoewfeNE9zwJNQmAo9ISLeiNr8wsuCJ0S6gfkWaeJ73?=
 =?us-ascii?Q?ZBcmky21/wnAhjbKNk3gsykza2Da/Ch+7gE0a6vnU5MFscVrq2aE8J4B4ih8?=
 =?us-ascii?Q?ixVJyV2rRXYfgnuV71qdeunaZJYB///wxYdAXHHrDuA5zD3CyVby3TPLwl+c?=
 =?us-ascii?Q?8DhLpZYl4zdHtWNF4uu90AArnQ5HY8p6B15rVaL9dSKN6Ha9vRbmzt1kj/DM?=
 =?us-ascii?Q?UXuOo3Cg5LQvs/PS5i530yR5z/3S4HCSVLkpWT3m4EVolrgRbvCJHZuVfUaN?=
 =?us-ascii?Q?tUsh9TxRoCK8n8kFI4z7X98DazoLWsvZgcZpviotTuziQnHknNbaDwMQedKi?=
 =?us-ascii?Q?MGmR6A2sq63+Usp3pZG1nwjkf8//0c228fzZb2HpDax+2rxpaWQvo8+x3uiW?=
 =?us-ascii?Q?Zj9CDnBekAVzl+QpjCk6NBQc2FRo7w/3efDvm6gBKubwYyPoYragE6YdR+bm?=
 =?us-ascii?Q?z9uELue3kS/Inh60PRx2gW24Ui/8o2gTJjkfUkj9yh/hSiDVGqRqWZIw/bcb?=
 =?us-ascii?Q?BOfzWd/kNEH7DcqxXktnMBy48e9+hvC9y1GcNK03bug4bCYKCEXZktQIqbbM?=
 =?us-ascii?Q?bXfSak1tkv36KZi89+nBfrAHEYl1AvNN4Yl/7rhaZf9XQJrdwNYvX0L4KLIC?=
 =?us-ascii?Q?+VVgGP54b/piDpQyL4nAcq0sQ6XNHC4NLRTAa9EyP7g7t/jM29SMEnv1anuW?=
 =?us-ascii?Q?yS/+FwZgog5LE87HMr5Gmyc6TRuL6daldhEeoqEInd3vBt6p5E6RkxOJDkXH?=
 =?us-ascii?Q?P01LzuoIc6fhY8LsSRZWTRRgOWtmo/p8ZzKY3lvItUVFl2L37RRsX7+BxIJW?=
 =?us-ascii?Q?mXacjyhkW6VihksoNF92xQCFDkar6P6tHvczMrTaJSMH+5Kk5lLfgr9gr0CC?=
 =?us-ascii?Q?HK5OdVsse3g2SFp7GSK/HelIuEWOKQT2GngVwzkv9dk9jBlciMQjNOm/uZkQ?=
 =?us-ascii?Q?Ho7iUhtUv2AYy0o3bJw6r3mH5t+Wx1b6BKhekF8gm8vC0TOW62zZn8bnrMWG?=
 =?us-ascii?Q?xf0JdMh4o03TIiIhYYOobGFlMy+1Hp3TSGzFV8sAwyVVYL39ep76HhAPP06U?=
 =?us-ascii?Q?b30nDJYC1UZMGJpVuRkrZOWMJQoPB8xASPMzK+C5lkEvQq+BBS1dyi0KvQhr?=
 =?us-ascii?Q?1rXQ9W4x9rRfqjHZcaDsfmT4+cqtyT++XHH+qJSn8Au1XcDnoTlriUYZ5SlV?=
 =?us-ascii?Q?fgxEVQUjIyQ/tu8PQyq21uNcp70h/+pA3UM902oBqW8yieF1WooOXK5Bq3LO?=
 =?us-ascii?Q?5FKZnGbtrvT5mCBx7xk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d87b9e-c497-4e0b-09d8-08dbd5fec9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:37:28.6240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 178G4UL6T/5w+bjpLIrxNShTlfCVMYikCiqyAPAJrs777TzMN0jlS8nYWshATY4jBanv2Y7wV0NGGHJTMlV8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks a lot for the review!

Regards.
Perry

> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, October 26, 2023 3:31 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when
> system resumes from S3
>
> [AMD Official Use Only - General]
>
> This patch is:
>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
>
> Best Regards,
> Yifan
>
> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Tuesday, October 24, 2023 10:50 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH v2 2/3] drm/amdgpu: avoid sending csib command when
> system resumes from S3
>
> Previously the CSIB command pocket was sent to GFX block while amdgpu
> driver loading or S3 resuming time all the time.
> As the CP protocol required, the CSIB is not needed to send again while G=
C is
> not powered down while resuming from aborted S3 suspend sequence.
>
> PREAMBLE_CNTL packet coming in the ring after PG event where the RLC
> already sent its copy of CSIB, send another CSIB pocket will cause Gfx IB=
 testing
> timeout when system resume from S3.
>
> Add flag `csib_initialized` to make sure normal S3 suspend/resume will in=
itialize
> csib normally, when system abort to S3 suspend and resume immediately
> because of some failed suspend callback, GPU is not power down at that ti=
me,
> so csib command is not needed to send again.
>
> Error dmesg log:
> amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB
> test failed on gfx_0.0.0 (-110).
> [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring
> test failed (-110).
> PM: resume of devices complete after 2373.995 msecs
> PM: Finishing wakeup.
>
> v1-v2:
>  * align csib_initialized with other failed with space[Kevin]
>  * check return value check for gfx_v10_0_wait_for_idle()[Kevin]
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 ++++
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 32 ++++++++++++++++++----
> ---
>  3 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 44df1a5bce7f..7d570f53e66b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1114,6 +1114,7 @@ struct amdgpu_device {
>         bool                            debug_vm;
>         bool                            debug_largebar;
>         bool                            debug_disable_soft_recovery;
> +       bool                            csib_initialized;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 420196a17e22..a47c9f840754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2468,6 +2468,11 @@ static int amdgpu_pmops_suspend_noirq(struct
> device *dev)
>         if (amdgpu_acpi_should_gpu_reset(adev))
>                 return amdgpu_asic_reset(adev);
>
> +       /* update flag to make sure csib will be sent when system
> +        * resume from normal S3
> +        */
> +       adev->csib_initialized =3D false;
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 6399bc71c56d..138340e1fa95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3481,6 +3481,7 @@ static uint64_t
> gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev);  static void
> gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
>                                    u32 sh_num, u32 instance, int xcc_id);=
  static u32
> gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
> +static int gfx_v10_0_wait_for_idle(void *handle);
>
>  static int gfx_v10_0_rlc_backdoor_autoload_buffer_init(struct
> amdgpu_device *adev);  static void
> gfx_v10_0_rlc_backdoor_autoload_buffer_fini(struct amdgpu_device *adev);
> @@ -5958,7 +5959,7 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct
> amdgpu_device *adev)
>         return 0;
>  }
>
> -static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
> +static int gfx_v10_csib_submit(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ring *ring;
>         const struct cs_section_def *sect =3D NULL; @@ -5966,13 +5967,6 @=
@
> static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
>         int r, i;
>         int ctx_reg_offset;
>
> -       /* init the CP */
> -       WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
> -                    adev->gfx.config.max_hw_contexts - 1);
> -       WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
> -
> -       gfx_v10_0_cp_gfx_enable(adev, true);
> -
>         ring =3D &adev->gfx.gfx_ring[0];
>         r =3D amdgpu_ring_alloc(ring, gfx_v10_0_get_csb_size(adev) + 4);
>         if (r) {
> @@ -6035,6 +6029,28 @@ static int gfx_v10_0_cp_gfx_start(struct
> amdgpu_device *adev)
>
>                 amdgpu_ring_commit(ring);
>         }
> +
> +       r =3D gfx_v10_0_wait_for_idle(adev);
> +       if (r)
> +               return r;
> +
> +       adev->csib_initialized =3D true;
> +
> +       return 0;
> +};
> +
> +static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev) {
> +       /* init the CP */
> +       WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
> +                    adev->gfx.config.max_hw_contexts - 1);
> +       WREG32_SOC15(GC, 0, mmCP_DEVICE_ID, 1);
> +
> +       gfx_v10_0_cp_gfx_enable(adev, true);
> +
> +       if (!adev->csib_initialized)
> +               gfx_v10_csib_submit(adev);
> +
>         return 0;
>  }
>
> --
> 2.34.1
>

