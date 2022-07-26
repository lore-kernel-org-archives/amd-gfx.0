Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51733C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 06:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C197510F9DD;
	Tue, 26 Jul 2022 06:41:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9BA112916
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 06:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7uN4M8y3WZZRgrkAdkG5jyq4P3TIfkHTsMaqrCpGQpI0vf87uvA60n/AV2NUid1bGaxBgeYYnQiryDJAd+RJJb6S/x6KSPhQt2ppvFNuk/V7uaiAyusGuxqQ7Oe//GrgvBpHjb/4tNsjSQic94MIpHAvnhfAfIA5NhIyL85M7DZcOLCycXQ0vCZqg0ZeuTW5xMCBes9i44LN8U3qvb+7P+iWrfsTdPn9z40JHRf80aixImpMV9rQjM3G5+XGQCRz2xlXyz4W4ud+m2d/VdEeUCtnMjHYNEvwE+vWhSHAUiuTdc7whZ8QHkBG3TpB0XgBG9R/kD3KY5vB8ODqR5U2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OstMpBuGkwqv0EthPBkmfiZc94zQClvyXfntJxd1wYs=;
 b=jfAW3VcFJOYJ2UIdN14MWTZSIU8Agrjjxrc9+P0tgrlsOo8oBzTMTJQPGCoeQ48M7j3YZXs5HfHPeYXq7TgYfSQ+TtxSx3SXdK10GhAEKhZDuqutDJXYt3gwDOvzX9YkRUQ/CCFqlVBGTv7myWj60+b/ZWQSrlhZjzli8cr4fQ2D4nabZH6RvPB3xD/OBADqge8SFOyl0EpJuMyf+v5CMUVyUJJuyRkHV77+3HHBvhAz9A7O3tX9GjoE/8gowy2Fs+NJBYKozu0nI7dIoaFp0iwtr5Un2bNGM3BTr1RIAFEq5buu+cDYZf6E2zGklkw8OEOZZQ5CRm3NSM5KMJl+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OstMpBuGkwqv0EthPBkmfiZc94zQClvyXfntJxd1wYs=;
 b=CH3RUdh1A3VkPqVGdN3evoTiyEeiUrw3jEM6yXzM4SefvDlyKSSGNd5J48Q0eFBV2KJFJ2KH0sN5EaFZMuQW42YgnMt2oTt4fCvDFdzpnHDFr+U5EjFyPdCJuVaFmCePB1/Z4BLDCeyiuX7yiIpFFwv6MPwkPepvbbbwku12xxI=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by DM5PR12MB1610.namprd12.prod.outlook.com (2603:10b6:4:3::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Tue, 26 Jul 2022 06:41:26 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::ccfc:c945:4212:711]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::ccfc:c945:4212:711%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 06:41:23 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for
 yellow carp
Thread-Topic: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for
 yellow carp
Thread-Index: AQHYoLkUAQVUJbIkv0qhNTfSi25l962QM+vA
Date: Tue, 26 Jul 2022 06:41:22 +0000
Message-ID: <BL1PR12MB5237DCB7032C6338E1605FDCF0949@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220726062905.3323207-1-shikai.guo@amd.com>
In-Reply-To: <20220726062905.3323207-1-shikai.guo@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-26T06:41:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5efdd8ed-82f1-41f3-a68a-3b35b6901521;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-26T06:41:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3ba7bb11-b6b3-418e-856f-5d8655cd40c1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fafc1ea-bc48-47d2-cb7f-08da6ed1db4e
x-ms-traffictypediagnostic: DM5PR12MB1610:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: milA0r1ypWoLbhLbGoLpeFYVy1rzzdZaq69SHXwi2NE5k8ynVVGIIZR/RmCOhfRz7DcumkgV0Se/VkAtPhk0MNAql2T7uxR1OzcHfRhBRgxuBu3HuLeBF4j0Tb63+jJDf9q8VP/uqpchrYxPFiHA6GZmahTfL28Ixlp+keGDAtRxKJBkyUnaugw3A16tT0jNpxmqk1jwqP7JhI5VQYXxmAJR8ZCjJuTtupNwGE0KRCJUzMPt+hOXhnlqkKOQ7mQXyokPTzD5FsM5F0OMejbmqvOs/AAYRsb41MK4wGhb0WBIJhoXtH7xP3sEQFGT/qZ/eSzy6U5CRSOM2ajqNnbyCAavqC6ckvBpswfErcIquh10KJlKI1wRaihSi09WBDsFAtqcHdi9cjIYS0x+Cbxm+hucUFOZrQziTCyHCECxD3Qj6m7sBIMu3MNCewAlaejLIrsX8EDQuIod+3+V+0vSc1jukaMARHmyxLXGVjv9rM9u9OanbvlJpX0qiEH0aiPKsDWmzhTNVKP7mxCgn+LQjpfEIAnfwLrMaxqFdA/WYBYWeMZv0QYyMFZ7LtMLCV3TCtqrjGOcEUyuCxjZ4qWDYFH+GtFHWYyaB1ox7oaMJxLE6WkDwWUTEsKi8DLXMqcuDNOt7UQxywMgfyRoBkK6Aixsg+Pq7YBQ4EEzEM06diTed5zCUiiNgNM6P7yf2DbV0SPWCIVJ3V0OvH2gbP1QnGfxSDwi6g2Sbr7fFpI4qDZKZQFzDToF65ShzRcjTkxgPuciQd6TPWm+4ci6NNr2z1A1pM9eKI1oeYU9rV3r0OgoMcflNVIiYR26G3aARe6X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(122000001)(110136005)(54906003)(55016003)(38070700005)(83380400001)(316002)(38100700002)(26005)(9686003)(8936002)(52536014)(4326008)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(33656002)(71200400001)(5660300002)(186003)(41300700001)(8676002)(478600001)(7696005)(6506007)(2906002)(86362001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c9ULLkWdzW/JbdSB081DC5bJZos/fCmdKAkUpjpcfYRLLQhfk8oZBdOHR8Z7?=
 =?us-ascii?Q?prDzWCFNfsUG9LSgDjM3WY9R5TzwlU0GsRtDxvIPVRVLbsbWWtbyIg/Yzz0O?=
 =?us-ascii?Q?ZKFySYQkP/3tHiCQgM/yC1anoL1otaqOjCgE+8+aiNpIs2Y6q8PY+ytsUD1Q?=
 =?us-ascii?Q?PElQPL1W2vR6XHBnMK+5/TqxWEseDOcKppFfQVf8olrXNpy5kLxEZ47EZiBG?=
 =?us-ascii?Q?5pqZHQFpOkbMj0sAk1tA94WGDJEMSvR0wH26ftgl7VFP3jYORE/zcyhbUAOz?=
 =?us-ascii?Q?cp28WtXPl6k+E9H8umLZeY8eSkNMMOhLhaCH/PfosjXzG0IYuUQBeBFenvVG?=
 =?us-ascii?Q?t38ZyBwvVwh6Irb9bKkZm7pU1CBladN+mgCcl5CE85oF24tmSK1blts3Uuvo?=
 =?us-ascii?Q?W3h8oy79GnI8KSARDf8UMMQRX3LI4BEcyMTo5uxP5pyDsXScyefxRniSB3E6?=
 =?us-ascii?Q?5eBt8NyOlFYuCc6eS4Cgvfn3erjgnKhit7K4hUuwJqPcM1Ujey513z+HhPzf?=
 =?us-ascii?Q?4BSXXbxh7EVi/rWHPYgkn/mWAnLPFJDFd8aJ1GrneIezZXdKtlabYb9K76nz?=
 =?us-ascii?Q?AQvOLHSuwiQOmnFbHgSLQhZI4FMWs7/uD3oERK0D27XGMaxaW+nDqm2n041x?=
 =?us-ascii?Q?w9KMa0Et3bfLO6UY0+yZ5cpKvkdYF3huctuT2iPNjoSpwc3yS37BozEi76Cl?=
 =?us-ascii?Q?/pgGTTHbt+tJ8obEwdX5d/gTiayJXuCL44TOruuQzfHlohrtzB/Iex5U8D8Q?=
 =?us-ascii?Q?81Nlt/sTtfqJI/OsQau7qGRJ/Qbhvc9P9hXBosAzy+JGmgzfbFviWs1c3Nx8?=
 =?us-ascii?Q?ph555I1CX6aIRWAblp2bclz7R5QTQBwl/6gQFy+jgrPk9+aPzMenC4dL1x6f?=
 =?us-ascii?Q?x96YMmbri6BrOR69kzBcg/My76EK7jNqFdqb0ClrIijW8wFNw+XmXLHXpWTM?=
 =?us-ascii?Q?xE7IqHffsqobmz9MN6MbYEMwuGFU3/obIhnFXP7cBqg/ZxXcnBy2PG5A2KMl?=
 =?us-ascii?Q?fSEjKhRLHymdIReS6eIbCI8HcSw8AksEWuqdI2URQLIozh41TF3BUa6Z6mIT?=
 =?us-ascii?Q?repIQaFz+xipQ5J4BYaImvkL2SPhRaQuRJ3YtidXU8W49C4LSyT7YxdorU6w?=
 =?us-ascii?Q?0+CvaYIbBR8Vw0EE9/xL+DLozlXuYhMcUuwHsYa4Dk64gZj1xvwRxDYZif1N?=
 =?us-ascii?Q?N14UkAnLGFUDbS5GFCo/hODsCpExflVfmzDoP7oI8LitL7qQGpy9/yb2mnfG?=
 =?us-ascii?Q?jHyIhm/Vgasn0J2gqUEeGgTBm2MEndUic0A8mQWMwkx/Vnz9GqxG8UivYuc4?=
 =?us-ascii?Q?9ruiLs9FawJN4DbO3S5m0B14n5/HviLyhABVOL8WDZp+KRh1tCIAvyd+HEVt?=
 =?us-ascii?Q?FKOdx7efvkg8o0CtsGnrX//D8W8c38xyEuzWV5o03cw9A8ePsKC9Oi+xUOT/?=
 =?us-ascii?Q?P+zcrufRAYqRXq6kYUXvIVZia7ickF3Hlqv6u22m87m58oebSOX2qd6nhiXF?=
 =?us-ascii?Q?00CGlqPk9MI3dPSdikbX09OyifXG8Pu6LYvlT1yU1rpPc3fVnCIgFtKwcqkd?=
 =?us-ascii?Q?S/diEOFtVIQcXoWPE+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fafc1ea-bc48-47d2-cb7f-08da6ed1db4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 06:41:23.2784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtOHr/BeQSTbXM/JmBBkCFkjY9s9MrjQl76SeiIH2XEpETZ1tZMoBANz/Fsz0DSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> shikai.guo@amd.com
> Sent: Tuesday, July 26, 2022 2:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>
> Subject: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for
> yellow carp
>=20
> From: Shikai Guo <Shikai.Guo@amd.com>
>=20
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
>=20
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 31
> +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 70cbc46341a3..04e56b0b3033 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -42,6 +42,11 @@
>  #undef pr_info
>  #undef pr_debug
>=20
> +#define regSMUIO_GFX_MISC_CNTL
> 	0x00c5
> +#define regSMUIO_GFX_MISC_CNTL_BASE_IDX
> 		0
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK
> 	0x00000006L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT          0x1L
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> SMC_DPM_FEATURE ( \
>  	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -587,6 +592,31
> @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>  	return sizeof(struct gpu_metrics_v2_1);  }
>=20
> +/**
> + * yellow_carp_get_gfxoff_status - get gfxoff status
> + *
> + * @smu: smu_context pointer
> + *
> + * This function will be used to get gfxoff status
> + *
> + * Returns 0=3DGFXOFF(default).
> + * Returns 1=3DTransition out of GFX State.
> + * Returns 2=3DNot in GFXOFF.
> + * Returns 3=3DTransition into GFXOFF.
> + */
> +static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
> +{
> +	uint32_t reg;
> +	uint32_t gfxoff_status =3D 0;
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	reg =3D RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
> +	gfxoff_status =3D (reg &
> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
> +		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
> +
> +	return gfxoff_status;
> +}
> +
>  static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)  =
{
>  	struct smu_table_context *smu_table =3D &smu->smu_table; @@ -
> 1186,6 +1216,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs
> =3D {
>  	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
>  	.set_driver_table_location =3D smu_v13_0_set_driver_table_location,
>  	.gfx_off_control =3D smu_v13_0_gfx_off_control,
> +	.get_gfx_off_status =3D yellow_carp_get_gfxoff_status,
>  	.post_init =3D yellow_carp_post_smu_init,
>  	.mode2_reset =3D yellow_carp_mode2_reset,
>  	.get_dpm_ultimate_freq =3D yellow_carp_get_dpm_ultimate_freq,
> --
> 2.25.1
