Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3576C10DC1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 08:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F1F10E2D4;
	Mon,  4 Dec 2023 08:51:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1491010E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 08:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlBjmirkGT6IsxPgs3aGnDF2TuEUssNKxPAZpXwnwO9BHzh3fqvSjV0NzGBeqzjE6j9+NG/l/FRkNIFnI0hs68aXkV5d2UMjSpOWnVAFiCLWKxiqWm5Qx4Eqku3v7gA6SZH5lz5ua9PPMN29gYmxuDIgpBHGpqCCX+nbFqO+G40Qu+MaLpM7EM/RoXms6SP7eJcXRq+cQM7X4y+2Jw7JBGoHE4B6Fdc5ORVa206eOS+FHgD0NRybLzjmdYTlepkcwE/uHIsku8sraaKOTgTuaNjk/4OccRnSS/VAJIO974rhCJx9tVye2RXJ6nQJmiJq6MZJSrmVkStJ6Zbk3u8Jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpDEVTbhm98ubxAZKWiwP/IHJiX3vqokmlC7Z7EjIWI=;
 b=O1j/GJipFYH1KbzZM9ExhkO7N7eu7EAvoCxrwttMfaB4ZnrSaDutAmwMz6dCcRamcCXuymLqPFA7dxqXHCwrtj85VDgIwnECvMuxczCAG9n5Hv9WqSKEQk7OGftw7QwrqhtOD1nSRUtGkEvm8oKxBxfvqxMDRY7O1D9wpzgoHPkQqk2QGrjupzb+LVAhqUUR3SL1A4doKzg/hzmh1FDP0T5uLv4nsHIFmRZBdARQ1z37irva7OUD94xn4fIuTnTY1eOXgR4zESmG3U/3ErU3yAvnll0M3kjYbYSsR8A6sm8aLTajiTHB+yI8L6PJu9m43r/9EDq63fxi652tCgPazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpDEVTbhm98ubxAZKWiwP/IHJiX3vqokmlC7Z7EjIWI=;
 b=BmalbTG+Wa3/U/GZxdGRASfR5qaQ1vpgJ7dP9f+IW4ziUFk/CaYp0MqkX6yqw/yJe9uDrf74Rl7++h7qUFYv1Bd4W0zmbZAiV8W9vLb0yuYMx7WgBQhiac/h7lsp2z4kKimQvksSptgO/MFiQptX6XyI25C+a9MT781QOLhAg5w=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 4 Dec
 2023 08:51:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 08:51:41 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Topic: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Thread-Index: AQHaHfTMiqz7lkxqPUiYee+D/LfLPrCOqdoAgAonkyA=
Date: Mon, 4 Dec 2023 08:51:41 +0000
Message-ID: <SJ1PR12MB60753D131385D5AEC27EF024FA86A@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20231123100645.235821-1-li.ma@amd.com>
 <BL1PR12MB5144909C7C9B11362D4F23BEF7BDA@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144909C7C9B11362D4F23BEF7BDA@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d3fb3ec6-baf2-4429-87b2-0d260c7442c1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-27T20:42:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: a88037ce-3606-4ff9-825a-08dbf4a63c03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QChBwKM3R6V7UVlZqkZTQQUxL9EqoBsB/Hm12ZSm+Qhm194AA6ZDLP2bGqooJk9jsmBGmvVOxOybC2DqCpIqgHzB4oFMgpl6liquG5jl71nkdgiJ7mWcy3Kz3UsgWPMSzANhnkw+6acmN2agr1YgQwKVQdqZ5BnMqYdHrJE5HD2PIxlHSpQ2Ox9HQSjxhBjmvrU/rx3JqtW+P1QjzYVXV/3CQ856mkskIH/1nU17daZR8KfyHTQ37HY4+8uK9Vb6Xi6mckGGH4nrIRbZpP7ej4iI1hLc7VczO5bax9F/VdyNa9hTlKFf+ueDHCvyf5ggeIJZZExwLblA/1g1YrMhV/1rbndzqDXsiiWcLKZQbxF+/g4gUagjOwTwvrklTX/gUXw7NwU0IvZpgVp5pBuVj8aGdiNs9SAjhS6tEzLH4LycO7mobEgGBD8lE8jyKnKuwN89GiwXQ6mAP3gUtIw3F8EA+U5DASquN33ZWLwPsd6r5163eD/swe5iDTzE784Zhm0EGPeKMDQeO7xEEcafNXFpJmBIvbqByod5qLVe+Zj/xU90KEAfHVjaH7pWTfqSmq+EutfEGPpTLvrYAezHJQRuCCY19L6T9aY/ddoiMcut3/OCZ39bqAWYSjdejVmG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(478600001)(15650500001)(26005)(8676002)(5660300002)(41300700001)(30864003)(2906002)(4326008)(76116006)(52536014)(55016003)(7696005)(110136005)(71200400001)(53546011)(316002)(6506007)(9686003)(66946007)(66446008)(66556008)(8936002)(66476007)(64756008)(83380400001)(38100700002)(86362001)(54906003)(33656002)(122000001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WDlDt5ymlXkgttIsnxoETNmP8e2EhltelQ77LCV9RbmOICQgCI94juFkUSRT?=
 =?us-ascii?Q?UZmFAI6NzZN3xNb2GjY3RRPnWkPEDWFxLbJ3S186q5LTNYvCIgs+b5X9J1Y+?=
 =?us-ascii?Q?tMs84gFRW14UzZ6TNYUX9Zf3zig9eMj3BPDXhmf5PgvBlGgapD4nnSoMqy2f?=
 =?us-ascii?Q?hhoD/WxZgMNBoyGTIyuQAJhmY+BRKt3VUP0Z4hb/p8mr+JvPxeL2HDcjNUCe?=
 =?us-ascii?Q?XKq1pEUNzg1hwWJGvjv9oNfcyvyTnwWrp0gdP+EWXPHWGq0JfjZG9dqhGzjQ?=
 =?us-ascii?Q?EhUrEUeKlBHXgv59+MXTPF9FeHWEwy3RCnXB8bFjkGe+dNO50tU3JY3tXAKz?=
 =?us-ascii?Q?a7qOpX5sVk19i64fbGCgdtkRxdJDChFEpkmSLvR7xqpk3cwpgpnyZoWlxvvN?=
 =?us-ascii?Q?U9Q8Exy5e8CbWwufX3AVTMEQVTRGkpMgEkc/xsn4CTNkUDKoJYQZT1RYaOqM?=
 =?us-ascii?Q?fVBRnEHe/iypFE0gze36RuuYhrcJHOblZcyzM4cIKtZBGttPfxXYRSkvcBWn?=
 =?us-ascii?Q?2NlOZ9pE4odSQUipuq00Leop+vfm2xCI/QHao5mTAzNCNtBSNZRaxQ8ESjO2?=
 =?us-ascii?Q?dsGxDDmsMhRR+6ObDuHSRU0GBIE9CjxAvxla3yEGIcXhnLN63+8uXwD2sg+T?=
 =?us-ascii?Q?fC77/F6Pj8DVqwgOFkBCemOK4uQuPvMBUNTVkvBV7DQ27j+xkvpMt72T7P+j?=
 =?us-ascii?Q?/Ved+KHLyFCoz4kfZ1je4Y4eKrQC0ldq7bny3ZVhUdEdITzpuesGv9VDwKFa?=
 =?us-ascii?Q?1ug/TxuqiAa+2TKSHJZaakhWDn7eF3IDlT1UBiIYJp3Vaoikkzi2W7LpzMOy?=
 =?us-ascii?Q?ph4mwj6+/ZcdX4tZ7GP01AWABDNGgRITnAsXzMw2mOvDn/ZNmMjZxS7cuUNG?=
 =?us-ascii?Q?1tvPloRJspp0KQhRisfjCdpy0gaGZSrev1JXWH4+4DGa3+1M+Ro6CqclsOBd?=
 =?us-ascii?Q?nCuDCt1J+lBMdcc/GJkYulaAi+kBRFkH2fzzZLlUeSAXjMVAnx+9RFxTmxAN?=
 =?us-ascii?Q?Y+JLAOnCAVVgxMPTs+g4tF9ipn+J6iqNFUK68jH97KrHIHKFC9e3UY45q8Vs?=
 =?us-ascii?Q?oF5ISya7/ExZTCaetlxLOlpofn9lMyqn18z/punDMcpbyTJgMEXw/gkJf3+t?=
 =?us-ascii?Q?qo8lmwBmRbOLh8FpRGdiX1CsxkVzsoqFkRHtzmLX14IB2TFczNvjEwPn3IHm?=
 =?us-ascii?Q?uexucBRXfc4L7ChflybFvYR5e2iC67D/sW8FhwHWP0PjfDS26TYzALap8Ao1?=
 =?us-ascii?Q?fLTcypdQmdDTXTZGgKA0tlR7bgpRO2aRGzKwIaFu6FMsQ5aUkFxyv2BM6ukt?=
 =?us-ascii?Q?gyiSf4r00Rx3cx+7fC77m19LJ6f4cBDggCnSELAJNACDx/yYWxaIEthSHB4F?=
 =?us-ascii?Q?iUkgm+IZg9qjEnYotkI+F58aXXzEpdejHGcDzmUhaIZExx6JvnxlU4aBrPEH?=
 =?us-ascii?Q?M04xTPM+Nk93TVsH4Cin4T36/tyPQJBRfvF/IRDRQMpxrbyTa8pY5D52Doc9?=
 =?us-ascii?Q?qYdaqyVKxUcGgb4jubClrHX7SMgdNG2gwNPn08MlsHZ3oTZfDzSa1nxR9dOl?=
 =?us-ascii?Q?R9xfSEZYa/UQxinmN/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88037ce-3606-4ff9-825a-08dbf4a63c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 08:51:41.1053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/B6l7YH0IoO+Y3ykK4ByrpKdqJ1xdeZZ/oSd8snxEgn1r0Ynk8zfJJpv37xWM63Es+R8HSFPgWXPV5kj2RVZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Alex,

Sorry for the late reply. Only smu14 used this gpu_metrics_v3_0 struct. And=
 the patch has upstream. As far as l know, umr used gpu_metrics_v3_0 and I =
will submit a patch to umr.
Does this struct need to be back compatible currently? If yes, I will rever=
t this patch and add a new gpu_metrics_v3_1.

Best Regards,
Li

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, November 28, 2023 4:47 AM
To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhan=
g@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version an=
d metrics table

[Public]

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Thursday, November 23, 2023 5:07 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu,
> Lang <Lang.Yu@amd.com>; Ma, Li <Li.Ma@amd.com>
> Subject: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version
> and metrics table
>
> Increment the driver if version and add new mems to the mertics table.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    | 17 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 +++
>  .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 77 +++++++++++--------
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++-
>  4 files changed, 115 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 8ebba87f4289..eaea1c65e526 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -1086,6 +1086,10 @@ struct gpu_metrics_v3_0 {
>       uint16_t                        average_dram_reads;
>       /* time filtered DRAM write bandwidth [MB/sec] */
>       uint16_t                        average_dram_writes;
> +     /* time filtered IPU read bandwidth [MB/sec] */
> +     uint16_t                        average_ipu_reads;
> +     /* time filtered IPU write bandwidth [MB/sec] */
> +     uint16_t                        average_ipu_writes;
>
>       /* Driver attached timestamp (in ns) */
>       uint64_t                        system_clock_counter;
> @@ -1105,6 +1109,8 @@ struct gpu_metrics_v3_0 {
>       uint32_t                        average_all_core_power;
>       /* calculated core power [mW] */
>       uint16_t                        average_core_power[16];
> +     /* time filtered total system power [mW] */
> +     uint16_t                        average_sys_power;
>       /* maximum IRM defined STAPM power limit [mW] */
>       uint16_t                        stapm_power_limit;
>       /* time filtered STAPM power limit [mW] */ @@ -1117,6 +1123,8 @@
> struct gpu_metrics_v3_0 {
>       uint16_t                        average_ipuclk_frequency;
>       uint16_t                        average_fclk_frequency;
>       uint16_t                        average_vclk_frequency;
> +     uint16_t                        average_uclk_frequency;
> +     uint16_t                        average_mpipu_frequency;
>
>       /* Current clocks */
>       /* target core frequency [MHz] */ @@ -1126,6 +1134,15 @@ struct
> gpu_metrics_v3_0 {
>       /* GFXCLK frequency limit enforced on GFX [MHz] */
>       uint16_t                        current_gfx_maxfreq;
>
> +     /* Throttle Residency (ASIC dependent) */
> +     uint32_t throttle_residency_prochot;
> +     uint32_t throttle_residency_spl;
> +     uint32_t throttle_residency_fppt;
> +     uint32_t throttle_residency_sppt;
> +     uint32_t throttle_residency_thm_core;
> +     uint32_t throttle_residency_thm_gfx;
> +     uint32_t throttle_residency_thm_soc;
> +
>       /* Metrics table alpha filter time constant [us] */
>       uint32_t                        time_filter_alphavalue;
>  };

Is anything else besides smu14 using v3 of this struct?  If so, we can't ch=
ange the layout otherwise it will break existing tools.  If so, bump the ve=
rsion minor and append the new items to the end.

Alex


> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index c125253df20b..c2265e027ca8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1418,6 +1418,16 @@ typedef enum {
>       METRICS_PCIE_WIDTH,
>       METRICS_CURR_FANPWM,
>       METRICS_CURR_SOCKETPOWER,
> +     METRICS_AVERAGE_VPECLK,
> +     METRICS_AVERAGE_IPUCLK,
> +     METRICS_AVERAGE_MPIPUCLK,
> +     METRICS_THROTTLER_RESIDENCY_PROCHOT,
> +     METRICS_THROTTLER_RESIDENCY_SPL,
> +     METRICS_THROTTLER_RESIDENCY_FPPT,
> +     METRICS_THROTTLER_RESIDENCY_SPPT,
> +     METRICS_THROTTLER_RESIDENCY_THM_CORE,
> +     METRICS_THROTTLER_RESIDENCY_THM_GFX,
> +     METRICS_THROTTLER_RESIDENCY_THM_SOC,
>  } MetricsMember_t;
>
>  enum smu_cmn2asic_mapping_type {
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> index 22f88842a7fd..8f42771e1f0a 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0
> .h
> @@ -27,7 +27,7 @@
>  // *** IMPORTANT ***
>  // SMU TEAM: Always increment the interface version if  // any
> structure is changed in this file -#define PMFW_DRIVER_IF_VERSION 6
> +#define PMFW_DRIVER_IF_VERSION 7
>
>  typedef struct {
>    int32_t value;
> @@ -150,37 +150,50 @@ typedef struct {  } DpmClocks_t;
>
>  typedef struct {
> -  uint16_t CoreFrequency[16];        //Target core frequency [MHz]
> -  uint16_t CorePower[16];            //CAC calculated core power [mW]
> -  uint16_t CoreTemperature[16];      //TSEN measured core temperature
> [centi-C]
> -  uint16_t GfxTemperature;           //TSEN measured GFX temperature [ce=
nti-C]
> -  uint16_t SocTemperature;           //TSEN measured SOC temperature [ce=
nti-C]
> -  uint16_t StapmOpnLimit;            //Maximum IRM defined STAPM power l=
imit
> [mW]
> -  uint16_t StapmCurrentLimit;        //Time filtered STAPM power limit [=
mW]
> -  uint16_t InfrastructureCpuMaxFreq; //CCLK frequency limit enforced
> on classic cores [MHz]
> -  uint16_t InfrastructureGfxMaxFreq; //GFXCLK frequency limit
> enforced on GFX [MHz]
> -  uint16_t SkinTemp;                 //Maximum skin temperature reported=
 by APU
> and HS2 chassis sensors [centi-C]
> -  uint16_t GfxclkFrequency;          //Time filtered target GFXCLK frequ=
ency
> [MHz]
> -  uint16_t FclkFrequency;            //Time filtered target FCLK frequen=
cy [MHz]
> -  uint16_t GfxActivity;              //Time filtered GFX busy % [0-100]
> -  uint16_t SocclkFrequency;          //Time filtered target SOCCLK frequ=
ency
> [MHz]
> -  uint16_t VclkFrequency;            //Time filtered target VCLK frequen=
cy [MHz]
> -  uint16_t VcnActivity;              //Time filtered VCN busy % [0-100]
> -  uint16_t VpeclkFrequency;          //Time filtered target VPECLK frequ=
ency
> [MHz]
> -  uint16_t IpuclkFrequency;          //Time filtered target IPUCLK frequ=
ency
> [MHz]
> -  uint16_t IpuBusy[8];               //Time filtered IPU per-column busy=
 % [0-100]
> -  uint16_t DRAMReads;                //Time filtered DRAM read bandwidth
> [MB/sec]
> -  uint16_t DRAMWrites;               //Time filtered DRAM write bandwidt=
h
> [MB/sec]
> -  uint16_t CoreC0Residency[16];      //Time filtered per-core C0 residen=
cy %
> [0-100]
> -  uint16_t IpuPower;                 //Time filtered IPU power [mW]
> -  uint32_t ApuPower;                 //Time filtered APU power [mW]
> -  uint32_t GfxPower;                 //Time filtered GFX power [mW]
> -  uint32_t dGpuPower;                //Time filtered dGPU power [mW]
> -  uint32_t SocketPower;              //Time filtered power used for PPT/=
STAPM
> [APU+dGPU] [mW]
> -  uint32_t AllCorePower;             //Time filtered sum of core power a=
cross all
> cores in the socket [mW]
> -  uint32_t FilterAlphaValue;         //Metrics table alpha filter time c=
onstant [us]
> -  uint32_t MetricsCounter;           //Counter that is incremented on ev=
ery
> metrics table update [PM_TIMER cycles]
> -  uint32_t spare[16];
> +  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
> +  uint16_t CorePower[16];              //CAC calculated core power [mW]
> +  uint16_t CoreTemperature[16];        //TSEN measured core temperature
> [centi-C]
> +  uint16_t GfxTemperature;             //TSEN measured GFX temperature [=
centi-
> C]
> +  uint16_t SocTemperature;             //TSEN measured SOC temperature [=
centi-
> C]
> +  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM power
> limit [mW]
> +  uint16_t StapmCurrentLimit;          //Time filtered STAPM power limit=
 [mW]
> +  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced o=
n
> classic cores [MHz]
> +  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforced=
 on
> GFX [MHz]
> +  uint16_t SkinTemp;                   //Maximum skin temperature report=
ed by APU
> and HS2 chassis sensors [centi-C]
> +  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK fre=
quency
> [MHz]
> +  uint16_t FclkFrequency;              //Time filtered target FCLK frequ=
ency [MHz]
> +  uint16_t GfxActivity;                //Time filtered GFX busy % [0-100=
]
> +  uint16_t SocclkFrequency;            //Time filtered target SOCCLK fre=
quency
> [MHz]
> +  uint16_t VclkFrequency;              //Time filtered target VCLK frequ=
ency [MHz]
> +  uint16_t VcnActivity;                //Time filtered VCN busy % [0-100=
]
> +  uint16_t VpeclkFrequency;            //Time filtered target VPECLK fre=
quency
> [MHz]
> +  uint16_t IpuclkFrequency;            //Time filtered target IPUCLK fre=
quency
> [MHz]
> +  uint16_t IpuBusy[8];                 //Time filtered IPU per-column bu=
sy % [0-
> 100]
> +  uint16_t DRAMReads;                  //Time filtered DRAM read bandwid=
th
> [MB/sec]
> +  uint16_t DRAMWrites;                 //Time filtered DRAM write bandwi=
dth
> [MB/sec]
> +  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 resid=
ency %
> [0-100]
> +  uint16_t IpuPower;                   //Time filtered IPU power [mW]
> +  uint32_t ApuPower;                   //Time filtered APU power [mW]
> +  uint32_t GfxPower;                   //Time filtered GFX power [mW]
> +  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
> +  uint32_t SocketPower;                //Time filtered power used for PP=
T/STAPM
> [APU+dGPU] [mW]
> +  uint32_t AllCorePower;               //Time filtered sum of core power=
 across all
> cores in the socket [mW]
> +  uint32_t FilterAlphaValue;           //Metrics table alpha filter time=
 constant
> [us]
> +  uint32_t MetricsCounter;             //Counter that is incremented on =
every
> metrics table update [PM_TIMER cycles]
> +  uint16_t MemclkFrequency;            //Time filtered target MEMCLK fre=
quency
> [MHz]
> +  uint16_t MpipuclkFrequency;          //Time filtered target MPIPUCLK
> frequency [MHz]
> +  uint16_t IpuReads;                   //Time filtered IPU read bandwidt=
h [MB/sec]
> +  uint16_t IpuWrites;                  //Time filtered IPU write bandwid=
th [MB/sec]
> +  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented
> + on
> every metrics table update when PROCHOT was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_SPL;      //Counter that is incremented on =
every
> metrics table update when SPL was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented on =
every
> metrics table update when fast PPT was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented on =
every
> metrics table update when slow PPT was engaged [PM_TIMER cycles]
> +  uint32_t ThrottleResidency_THM_CORE; //Counter that is incremented
> + on every metrics table update when CORE thermal throttling was
> + engaged [PM_TIMER cycles]  uint32_t ThrottleResidency_THM_GFX;
> + //Counter that
> is incremented on every metrics table update when GFX thermal
> throttling was engaged [PM_TIMER cycles]  uint32_t
> ThrottleResidency_THM_SOC; //Counter that is incremented on every
> metrics table update when SOC thermal throttling was engaged [PM_TIMER
> cycles]
> +  uint16_t Psys;                       //Time filtered Psys power [mW]
> +  uint16_t spare1;
> +  uint32_t spare[6];
>  } SmuMetrics_t;
>
>  //ISP tile definitions
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 03b38c3a9968..94ccdbfd7090 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -246,11 +246,20 @@ static int
> smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>               *value =3D 0;
>               break;
>       case METRICS_AVERAGE_UCLK:
> -             *value =3D 0;
> +             *value =3D metrics->MemclkFrequency;
>               break;
>       case METRICS_AVERAGE_FCLK:
>               *value =3D metrics->FclkFrequency;
>               break;
> +     case METRICS_AVERAGE_VPECLK:
> +             *value =3D metrics->VpeclkFrequency;
> +             break;
> +     case METRICS_AVERAGE_IPUCLK:
> +             *value =3D metrics->IpuclkFrequency;
> +             break;
> +     case METRICS_AVERAGE_MPIPUCLK:
> +             *value =3D metrics->MpipuclkFrequency;
> +             break;
>       case METRICS_AVERAGE_GFXACTIVITY:
>               *value =3D metrics->GfxActivity / 100;
>               break;
> @@ -270,8 +279,26 @@ static int
> smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>               *value =3D metrics->SocTemperature / 100 *
>               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>               break;
> -     case METRICS_THROTTLER_STATUS:
> -             *value =3D 0;
> +     case METRICS_THROTTLER_RESIDENCY_PROCHOT:
> +             *value =3D metrics->ThrottleResidency_PROCHOT;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_SPL:
> +             *value =3D metrics->ThrottleResidency_SPL;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_FPPT:
> +             *value =3D metrics->ThrottleResidency_FPPT;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_SPPT:
> +             *value =3D metrics->ThrottleResidency_SPPT;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_THM_CORE:
> +             *value =3D metrics->ThrottleResidency_THM_CORE;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_THM_GFX:
> +             *value =3D metrics->ThrottleResidency_THM_GFX;
> +             break;
> +     case METRICS_THROTTLER_RESIDENCY_THM_SOC:
> +             *value =3D metrics->ThrottleResidency_THM_SOC;
>               break;
>       case METRICS_VOLTAGE_VDDGFX:
>               *value =3D 0;
> @@ -498,6 +525,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> smu_context *smu,
>               sizeof(uint16_t) * 16);
>       gpu_metrics->average_dram_reads =3D metrics.DRAMReads;
>       gpu_metrics->average_dram_writes =3D metrics.DRAMWrites;
> +     gpu_metrics->average_ipu_reads =3D metrics.IpuReads;
> +     gpu_metrics->average_ipu_writes =3D metrics.IpuWrites;
>
>       gpu_metrics->average_socket_power =3D metrics.SocketPower;
>       gpu_metrics->average_ipu_power =3D metrics.IpuPower; @@ -505,6
> +534,7 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> +smu_context
> *smu,
>       gpu_metrics->average_gfx_power =3D metrics.GfxPower;
>       gpu_metrics->average_dgpu_power =3D metrics.dGpuPower;
>       gpu_metrics->average_all_core_power =3D metrics.AllCorePower;
> +     gpu_metrics->average_sys_power =3D metrics.Psys;
>       memcpy(&gpu_metrics->average_core_power[0],
>               &metrics.CorePower[0],
>               sizeof(uint16_t) * 16);
> @@ -515,6 +545,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct
> smu_context *smu,
>       gpu_metrics->average_fclk_frequency =3D metrics.FclkFrequency;
>       gpu_metrics->average_vclk_frequency =3D metrics.VclkFrequency;
>       gpu_metrics->average_ipuclk_frequency =3D metrics.IpuclkFrequency;
> +     gpu_metrics->average_uclk_frequency =3D metrics.MemclkFrequency;
> +     gpu_metrics->average_mpipu_frequency =3D
> metrics.MpipuclkFrequency;
>
>       memcpy(&gpu_metrics->current_coreclk[0],
>               &metrics.CoreFrequency[0], @@ -522,6 +554,14 @@ static
> ssize_t smu_v14_0_0_get_gpu_metrics(struct
> smu_context *smu,
>       gpu_metrics->current_core_maxfreq =3D
> metrics.InfrastructureCpuMaxFreq;
>       gpu_metrics->current_gfx_maxfreq =3D
> metrics.InfrastructureGfxMaxFreq;
>
> +     gpu_metrics->throttle_residency_prochot =3D
> metrics.ThrottleResidency_PROCHOT;
> +     gpu_metrics->throttle_residency_spl =3D metrics.ThrottleResidency_S=
PL;
> +     gpu_metrics->throttle_residency_fppt =3D
> metrics.ThrottleResidency_FPPT;
> +     gpu_metrics->throttle_residency_sppt =3D
> metrics.ThrottleResidency_SPPT;
> +     gpu_metrics->throttle_residency_thm_core =3D
> metrics.ThrottleResidency_THM_CORE;
> +     gpu_metrics->throttle_residency_thm_gfx =3D
> metrics.ThrottleResidency_THM_GFX;
> +     gpu_metrics->throttle_residency_thm_soc =3D
> +metrics.ThrottleResidency_THM_SOC;
> +
>       gpu_metrics->time_filter_alphavalue =3D metrics.FilterAlphaValue;
>       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
>
> --
> 2.25.1


