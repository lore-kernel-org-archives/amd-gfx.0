Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF1C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 03:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD8612A831;
	Fri,  8 Jul 2022 03:38:25 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD4E12B049
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 03:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOCui/c7CwgRXNPtz5tzgmdGbnAVxF167FPUUDSE6LRa9HRiPXqCgLLONBH50GmM5k2LjbW4ulp8x1iKCEyYd9eVDnLtbnpa8tuYinj/lzJTX7oPg4pJlHvkvRfmxY8wuhSvD8X0Qi148OOAeKppf0c1OHOA6XbutKt1Qy2Z1wsCxzFFqVoSsNTxPcyEqyeuwCHGB+gFUH6at7Cd9rbVZeM4vsUJheeE/i0oMgbVtQ+PHImwMzWim+GmM8WnVoDCSVltViZ8lmYy6UKryUcXmVeN47Oafiugx7y/ZdUaPPgkr9SGcB8Z9A3tmh6P8E8M8pzR5FxRR9fmYjLdVjn8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnuVpvDTGA1fJFlb1GEqAaTjwFJObY0liprGk4iAvQU=;
 b=DfygEML8HMMA3DIAoYP6gKoLzlQDeMRF7xychvfH3c/HTujscXI6jsqLiyJKBmgTV/ulYNYynK6YOTzcD4viC/m6t8/Cy0D47G6TIe3EHJ3snUsD+Uvqvk7D9XPXbNaJmhrgT+NpEF652dkeYLbEDzYpf53W5PtSlm89R24g6FJ/PkknRB6uWAAE1mPLaGFYkVMscoli6p0ZfdnN3B7wF0GCDlLZWuVkMr1FHCq77ho8rFTwqbrYCaC5kFfoHUdr/qpqRFVfL8BiemMMa+TxkLE0o31aIfOY5iJMFD4E3uls+2wTqvBkvRR3OLEDiC3pUuLA6RNbu26tlKHo9FG41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnuVpvDTGA1fJFlb1GEqAaTjwFJObY0liprGk4iAvQU=;
 b=IoZ43COwHFEJ+5ZYJxoZOsBrugkz/BUvAutKgdk2MobCU337YYYNgWHMMQoDSZqPZ5+0w3r8GPMn6EQrtpb8XDi+GiLjc8VTo6xgiB7xy0jG1RwLJd9Str9slsjIOteQj3wpNHdrb2rdf/I3OpC2KsaFNDlnvH6MUE2rUdS30Kg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.20; Fri, 8 Jul 2022 03:38:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 03:38:17 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: ac/dc change for smu_v13_0
Thread-Topic: [PATCH] drm/amd/pm: ac/dc change for smu_v13_0
Thread-Index: AQHYkg21UVaryGonYkqVFSFmMWji561z00kg
Date: Fri, 8 Jul 2022 03:38:17 +0000
Message-ID: <DM6PR12MB2619A1FEE4D83F39D869198FE4829@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220707142727.3250944-1-kenneth.feng@amd.com>
In-Reply-To: <20220707142727.3250944-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-08T03:38:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7d674d86-c9f1-40d1-bd69-ddfd63f53925;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f192aef6-8a18-42ed-c278-08da60934bbc
x-ms-traffictypediagnostic: DS7PR12MB5957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HM4ga4oYNg55EjifX4/HroSUPF3LF1ABQNgLc1h0Ob5kru6ZItsScYHcWovjdGS7LbkKXfT181GpZr/CFtBkffl6HZWrV6LOVfVlsTn+TAIq4vvwyFJXWeeQnGTwqt6hH1p+/aDJo7cV0cDqS6v/vMOGg7s/AoabaEiUFnBVZK0aP5quoaLyuNRtEjWvMleW9xsy2EtJ1KK59C8S7u571KedgND/Pmh9/4YKgTl0d+CDOv38x3E1IFzh1DZWvECO5H1U8qqC4t9sPaTdMTCozd35G9nWRcPdP8JCGmpVrTNCUeCDQ2N5tjYrNXIY1kFNf/VnT6Z6g8EdPokY3xfRY3JIAXROV4CCnFqi5WyJm4xqr6dJeXWp0i4edgPYyx0pml4n1hL+8tLmvCewD4EbsH30B/SnoSLA+YT3+2sLqcTdGJBaoBMiJbpCA0um6OtZAMzmagcRz3QJxP902m+uo/dUyqGNPh+hohQm91q7XKzhNcw1NPznBLWgnhU1qqVQJP5DpBELRhKgLgc+7W+NdOmu+xXAi3WxOjz20FPnHUnreI6Qa1M73RGwG8Ht8I4UFQg365uXjjUUUN8HUU7UHCnvc35KZhlbMNIyZ30oWvVKk8j5zr6FLF28svgkRK+6efXutZQ2EVpk2nBKSs4PPDzm5JizGFBKqmLLw2oqRA4wseCnjBq3nBeU/K+REVw0NljzAhJl/pJVh0aBXDWP+lFeg3Vuluk1YS/fWVx7TVUQvU40kLcWGkGTphBORZEvc0/i8kRKwIzVQnxAkVhKVke52dZWwwQl/otYf3r82DQlFZIJCBquiH2hmiTuuH7p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(9686003)(52536014)(2906002)(41300700001)(8936002)(478600001)(38070700005)(5660300002)(83380400001)(7696005)(6506007)(186003)(53546011)(26005)(8676002)(38100700002)(71200400001)(64756008)(66946007)(66476007)(76116006)(33656002)(55016003)(66556008)(86362001)(66446008)(110136005)(316002)(4326008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dA2zPr4vepyTg+zEMf1SHrcpENxrcGjawymwV7yT37s5UYLlqwIfviFM2ME?=
 =?us-ascii?Q?Be3ntZbzpMfWK2SJZW6nifN/IV5NYkVQJOy5E10YQTJZxtFwSg0C6RIUyAEJ?=
 =?us-ascii?Q?9LjqH73LT40mQykCQYBFby4alBATVx4VEbZlyFpdzPmAk//u2pAzqxZtPjpV?=
 =?us-ascii?Q?dKeaazf05RvF9p7IoPulsVed5dy/rVt4qkWx9U2+Z0opHPk4N5/ighk+7YkX?=
 =?us-ascii?Q?vSfx6Dq0SmyQC45tnOPqqf7QS3pvUjEHQe516tutP2CmOvAFEXlQh9ArCljv?=
 =?us-ascii?Q?EJ4TdWYVz4OadNwTj48igZSPwnOU/Tt5en/a6hOXlWn6ko1Oy8QVWdvKfyzu?=
 =?us-ascii?Q?bQS2rmjXvd4N2onpEVSRXPrFPMIEtijIxllwMmhwDHCvkDFEBkTBL+5aAt0B?=
 =?us-ascii?Q?e3MiuK+R2xheWtCFY0yDRPrd9IAmYJmahV/lyByZJzUlrp/OCpTjfZyseq8J?=
 =?us-ascii?Q?gY6+9dNmB4gd7onaFutv2+bmIaoD0s5DGuD1XdkOFysKbyWhnBpdocNpPWjz?=
 =?us-ascii?Q?OBtWSHw+4Fc4gEavoCl7jwKTRhTPjdfX1VMedbyR/MXIuEFYAToK0nIS7z+T?=
 =?us-ascii?Q?L/gqHbH0+hmZR56w2JDYYsPMqz9YfeoTAzMKH7jEW6WiUi9akdKYhpqNPpRf?=
 =?us-ascii?Q?p2ptzVGtgHbnqcf9BMODCV+P4SsVXprebRebVJSrPh1qeY8d8l7eQq/IrMCz?=
 =?us-ascii?Q?m8JL8uctwzCcqw3VANxTv5s+DwoPsONotJJw/X0T4PdDps6E68bntGGdSETm?=
 =?us-ascii?Q?eNLOSyDwb5mijPqJB1qc2dQH6YI/phu3V66sibM9pfZzo3iZ6F5wu2MhbsX+?=
 =?us-ascii?Q?QPMGP1BROoGlqIQJEPIUyArxfuUVlHBJv++6ViKOziSfm5FnOJ1diROFalxu?=
 =?us-ascii?Q?W1q9moX05yLlTOCX2Aq33/Th6/mclSEnozUVp+PrPYaKHvmEACLvjS8YafQe?=
 =?us-ascii?Q?hW6cSgsVJxsd+o8YEbHAYeyzrdm8GFGkjAcUZHsrWslwcqe7tBpdrpgcXPqy?=
 =?us-ascii?Q?8Ca4WwKt562iXJ4prMIFSQHnRP9/mEn9T422n4mZdiZqeCnvb+QoHhfqjUIy?=
 =?us-ascii?Q?WfAJeZHe47MORchhJpLcQrpvqieAJIHREloxAALFujB+Ewj7+DvXOje+73QK?=
 =?us-ascii?Q?ULwUne01V9an5ehXWmt0MjobzhwB8+NV/AewG+2bfbKjn9vw6uwJlagP6tIS?=
 =?us-ascii?Q?EFwIb9pmAo7TbuETxCrnQzHBUrH4TdSFpqOeut3jaLQ4npyKlLIquMqItkys?=
 =?us-ascii?Q?YxuNRC/dhK10Jtf/Mp5npZEP7hmGquLDZsOu2N5JElIxJ2rcf7YSoihLclYD?=
 =?us-ascii?Q?y6h6gslF+Jmte2SOGq9CSZeXzvRvtfIXWj5bh5V4K0Mg5DYoMX7r0FG99fgp?=
 =?us-ascii?Q?QGiFhQS3LHcwvYv4BRQjnFg2fV/1i36r/GfhU7CN1dMBmM2ggEpTMzpUijlu?=
 =?us-ascii?Q?zTIc25RAY3/fb5gTPdrjAAKmfalpq6c96uiXlFrzYw/P4rBjYEoF5vjgPOju?=
 =?us-ascii?Q?EpaYima/lt7VobF/xOQTyMJ5dcrUhsv/LAXP59Z0ZTCBuOMHWf5cgW+nE2ma?=
 =?us-ascii?Q?7Y1xWE+tkALciCKLMqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f192aef6-8a18-42ed-c278-08da60934bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 03:38:17.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cGtj1uGxSFVcLoSGLed8ijptmEfPzeS4NELA8x9YV6cmez1DaDPPh4R2Cn8Hzhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Kenneth Feng
> Sent: Thursday, July 7, 2022 10:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: ac/dc change for smu_v13_0
>=20
> fixed the issue: gpu runs in dc mode but it is expected to be in ac mode.
> this causes the lower performance on smu_v13_0
>=20
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |  9 ++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 28
> ++++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 ++
>  4 files changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
> index 3f2d0a9e4745..6aaefca9b595 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
> @@ -128,7 +128,12 @@
>  #define PPSMC_MSG_EnableAudioStutterWA           0x44
>  #define PPSMC_MSG_PowerUpUmsch                   0x45
>  #define PPSMC_MSG_PowerDownUmsch                 0x46
> -#define PPSMC_Message_Count                      0x4C
> -
> +#define PPSMC_MSG_SetDcsArch                     0x47
> +#define PPSMC_MSG_TriggerVFFLR                   0x48
> +#define PPSMC_MSG_SetNumBadMemoryPagesRetired    0x49
> +#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
> +#define PPSMC_MSG_SetPriorityDeltaGain           0x4B
> +#define PPSMC_MSG_AllowIHHostInterrupt           0x4C
> +#define PPSMC_Message_Count                      0x4D
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index a1cb8e73e171..19084a4fcb2b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -74,6 +74,7 @@
>         __SMU_DUMMY_MAP(OverDriveSetPercentage),       \
>         __SMU_DUMMY_MAP(SetMinDeepSleepDcefclk),       \
>         __SMU_DUMMY_MAP(ReenableAcDcInterrupt),        \
> +       __SMU_DUMMY_MAP(AllowIHHostInterrupt),        \
>         __SMU_DUMMY_MAP(NotifyPowerSource),            \
>         __SMU_DUMMY_MAP(SetUclkFastSwitch),            \
>         __SMU_DUMMY_MAP(SetUclkDownHyst),              \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 0e59ab2192bf..0328bc12ca21 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1084,9 +1084,35 @@ int smu_v13_0_set_power_limit(struct
> smu_context *smu,
>  	return 0;
>  }
>=20
> +static int smu_v13_0_allow_ih_interrupt(struct smu_context *smu)
> +{
> +	return smu_cmn_send_smc_msg(smu,
> +				    SMU_MSG_AllowIHHostInterrupt,
> +				    NULL);
> +}
> +
> +static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)
> +{
> +	int ret =3D 0;
> +
> +	if (smu->dc_controlled_by_gpio &&
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
> +		ret =3D smu_v13_0_allow_ih_interrupt(smu);
> +
> +	return ret;
> +}
> +
>  int smu_v13_0_enable_thermal_alert(struct smu_context *smu)
>  {
> -	return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
> +	int ret =3D 0;
> +
> +	if (smu->smu_table.thermal_controller_type) {
> +		ret =3D amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
> +		if (ret)
> +			return ret;
> +	}
[Quan, Evan] Please drop the thermal_controller_type check here. It was dro=
pped intentionally by the commit below
184586693002 drm/amd/pm: drop unneeded thermal_controller_type check

Other than that, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>
> +
> +	return smu_v13_0_process_pending_interrupt(smu);
>  }
>=20
>  int smu_v13_0_disable_thermal_alert(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 193222fdd1c4..6259a85bc818 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -111,6 +111,8 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =3D
>  	MSG_MAP(PowerDownJpeg,
> 	PPSMC_MSG_PowerDownJpeg,               0),
>  	MSG_MAP(GetDcModeMaxDpmFreq,
> 	PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
>  	MSG_MAP(OverridePcieParameters,
> 	PPSMC_MSG_OverridePcieParameters,      0),
> +	MSG_MAP(ReenableAcDcInterrupt,
> 	PPSMC_MSG_ReenableAcDcInterrupt,       0),
> +	MSG_MAP(AllowIHHostInterrupt,
> 	PPSMC_MSG_AllowIHHostInterrupt,       0),
>  	MSG_MAP(DramLogSetDramAddrHigh,
> 	PPSMC_MSG_DramLogSetDramAddrHigh,      0),
>  	MSG_MAP(DramLogSetDramAddrLow,
> 	PPSMC_MSG_DramLogSetDramAddrLow,       0),
>  	MSG_MAP(DramLogSetDramSize,
> 	PPSMC_MSG_DramLogSetDramSize,          0),
> --
> 2.25.1
