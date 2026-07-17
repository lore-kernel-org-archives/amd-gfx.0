Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0957FC44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 07:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F0310F489;
	Fri, 17 Jul 2026 07:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTC8mkM9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC79F10F489
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 07:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTtIuLwltdVSQjz5Hx1znm2AFae5iJLZEY3bx/Sl6X67mtZWxpmBBezbNS1x6vgKUHyYuNioebELoFLvG1nwq4okRMYl5Gk8jNNv0Y9MnzNybFIXOrpBWT+KbfpoirKPQoFZlCs3mjfWH1H85sI+FN6mMup8phpXjuaLRUGZbISGNRGMXYF8WmySiKdocnAeDah5GVD9b7HWQujP81Ml0tMB6opyAgIkk4R+Bte1zlXla/AJHGAfbVYkvGx1chx5OuugwbjtlEBVnswFP+/BV/3k9ZIGPHJ+WaHAOwvMT7+JYkHguDr2FL1ZRqzUIJnppU+/O2Mz3stTtRsHyo7Fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLOdARAPD2nvPec8O7LWxixDIWKMuf2tHGdQ5gBExCI=;
 b=wFIChotzr7vXLR+zMmMU5KuyC3RBksVplkXZBBf1h6j0pL9Q/v2CuK4zXl6ImH2jC2bARQ4P9bQ63cqstEoVElD3DfaXWdpEljNmOGomLr/YIWptbhGFVjWsZkQC/n6ebm/woj6BDKwyKNDMTvtBe37MRvmKqfEo2Mo7SP/HqcVxTQCZAthkfBEqPCE8/7Mo3ZMF18/FMoXo7osE2dQAgAnhHmAYvPjl4nc6F46FDtYDml+xDhjckBHwzwiWvPil2Lft4eTnkfBk99I+0V3t0PsVtLXqJh+Ftnu9l+Yyc/H6u6OK6T8FQwWaAa78hCCTSeq/AMiiFRnLUfbhX8PoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLOdARAPD2nvPec8O7LWxixDIWKMuf2tHGdQ5gBExCI=;
 b=DTC8mkM9V0TWau8AcuvduVcmUtsJ/oN6v/O+j5IbF7JDk6LSxjG83AJLd8c8JSua+mAbLUCyojimXdIl9WIj/wBDqT3IuS63HyLTyzvnP0JxUIJies8qsaPwoFOXVvSQkzge7b+GQAbcuOuVgoe4A6YZPkgAPc+YQTZQ1bujACo=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 07:54:19 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%6]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 07:54:19 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V4] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Topic: [PATCH V4] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Index: AQHdFQVL/sqAaffvG0maD5sKOeaQjrZxWMnw
Date: Fri, 17 Jul 2026 07:54:19 +0000
Message-ID: <BL1PR12MB51277A020AC5942546487495B0C62@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260716092656.1057364-1-cesun102@amd.com>
In-Reply-To: <20260716092656.1057364-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-17T07:53:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|SA1PR12MB7296:EE_
x-ms-office365-filtering-correlation-id: 97f12a73-b299-4db9-70c2-08dee3d89b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: hcg0nTt9YMEV07Xcm34AZDG1GPoWMzsIh+1lrxHanYurLGcTMKyHO13cIxl1t/JwBvxVdTZ8vkqXOUwUoAWcdSYrcp1HReDtGd4tUjxMkgLgyUMsSwHQ1LZOKjWL+nUH10mYmuRnvYz+YJ87Npgl0vOfiDFfLM16UsNH4EOZ42MhAXKMPFE/itWjcek7fj4BmFAS39V5NcncXpH/ay1l16i5MbFdj3CIzbtc/W0ntVMPNLorTfATn3sWzZkmR1myAQo5r6Kk7nuJ0kwL5or6jo67Y80z4d1oyMKyBtmpLGHw4m39cX8cqIPoKlb299RJNXA+lHMIl81rFfWTbkyJKavjhd0+SS4h1Jxq7rqZlp18DFgJmJ6KMAY/GEeLJiW4mQLS3hEvtgdP/Sj/x69KliT0OW89MMsHHA0BIJ2cQ2VILW0BbA/QKlkWIb5YPgVJlqmq8SP9xwj5URRv/hAi2RQ3k4QksUDYjHldJB5jX7gUq5xQpxvoMZNYEB5ck4yhXj/hlYrAM+xEtq05b3WaaNV3qZasgF40BnOFvOeIvFOvBaF/dvmmvt8tha3BO25A9+edIt/VdQqILOytHAvipLEJL062LasHCEAPzWS/WvZn3PokGyrTbRUiHDFLrduQ9w7VREydcPO9vSLSbqH7+yMJmmIIHQPET+aBzDskmvvo/svwroJ/kpIeMb/j1ZLulLUEokp9JMLaKYDGdVUPICMY9Op00FISitso/VK20qM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wn1fp9PJvvCgJk+BX1VmAH9tZnAvqROmtXW624ryFPKiD84R1fWO9Dumn/4m?=
 =?us-ascii?Q?+1Q9VKo0Z9ofcITebYVEW9dc+IWdt2K0JUyIeQLjeF7Vf212C+PbZ9KFDJv9?=
 =?us-ascii?Q?tEdqfHFOtF1x6iN+8UOaSUWFGdUgXE91RkkBGSMGGbb0srrC+zA94Jye678s?=
 =?us-ascii?Q?gWCP+Z02HCSAv7pEysCLB2x2YXlP7AuHc4PqGEMEQd37B51s5clFHPcJs/S6?=
 =?us-ascii?Q?uIq8ymseLdetfpWGWeYyWNK7w/GafiEMeXokbO7YhMXxCfyDgunDUcZJx0H2?=
 =?us-ascii?Q?v2o0yqFDuPxGYIDnHL46Jh2kC3BxXm6KEq+4xlYQxc1YcpNilSgk04PbF+S9?=
 =?us-ascii?Q?UBaPYSYWRiLu5ex7boH57MGASvQCBTHz3yiNsXwE/PQwRexu2ijtclkIsKfI?=
 =?us-ascii?Q?Qi3RyoCIsuPuoSkWEg1JG1Wydwyk5kI9z6MHS4NBRTX9QjnhgzpFzQf3ilVw?=
 =?us-ascii?Q?04QKhfw6GR0vA9Vdf5jajX/ILgBfKX1XxqNCtaprhqfTiix0FVFqMuwNXNEs?=
 =?us-ascii?Q?YHtpxWbWbCneltK5ixBGIuQyf0DsJm+6iOZKZH2PH94e0Y5paTHLyIWZM6qC?=
 =?us-ascii?Q?/D2lXGUKZ3C+0B6XUYG/YjcWyAr/s4Y9Dhr9M9/Q29ffgsZdig5FPemBRfR7?=
 =?us-ascii?Q?XdNAJvvIKFW/FpOQC3VN+CRzDnioNStx3lTZaVRZa3zbzST+pCpQenqOnpBk?=
 =?us-ascii?Q?EdhOdaodBbhl+CUkaDjI6k/mRs4ddhfys/Nz5V2As8bFEocEp+ObuC20XKUG?=
 =?us-ascii?Q?h+1dB4gC6BMzXJiEGjmE/0cE0NKOqOsD8CbzAkd/yngpSYuSp4pWGasMI11v?=
 =?us-ascii?Q?bD872xSNIrMWkT+uG8AFb0bkSZUFMDK7zzq6jmxrr2raT9TYBOQbpNbCS4N5?=
 =?us-ascii?Q?EGtvFyd05qPZ12PWgjRfkymQEJkkYqBTNfwR9+9gPmelUlJr4JjdPQ5/l5o2?=
 =?us-ascii?Q?a4KtUmuRQY5xH/1XmlYUU1Cq+21KoP0U+7/73F4ypJV80ZhYDoZ4rVXvvvMn?=
 =?us-ascii?Q?GSnmG0S+mt7/K1DrQn9Zm7GsYXHvzdzWjGwzjanS5pcgWiWzIqCxgOU4BnGA?=
 =?us-ascii?Q?vshpf0PyltgpLy1I4zCQjA36w/zAW3ZGBqBkuS33eNGgG/tbD9VFTDL854FB?=
 =?us-ascii?Q?oMlOXOBKONwXnOP24h3RjfOSB4wKzprfnIXbhlK+j7G/v8j4xiCO4z47RMzu?=
 =?us-ascii?Q?8ChjLJ5LUkjCIMT/HEGuRkfY6Iltto5LSMAEsJPRbTd90WLKedvsR2VkXRCB?=
 =?us-ascii?Q?vGzd9trlji26H1xPDfuGucghawSahyGdIxRiMU5bJTduLd0mZaflmYQSJudd?=
 =?us-ascii?Q?8XWmZcG6suPVOoS1oQ/7/wgRg/oDFfXjjkhuy5fe506UcLtWdglWZZ3gLC+q?=
 =?us-ascii?Q?IaiCY/MjmtxT/8DwD2Mi/Xurq2th4/QpKgqbo3iDv1gmOTYzA0vRgDLrGjsv?=
 =?us-ascii?Q?Zs+yxWToRMCH4knl//MkMzY42jsS+UO6aVfw5wh0ygmlVQVUeSKUYw4OzMXz?=
 =?us-ascii?Q?rIyEKCy68vnHNlgd3+LDiKoTcFk83MsgqsysKm0qhwJvm9y9esM3F6+heAN8?=
 =?us-ascii?Q?K+dOY/0UaPzTmKsZqsDGBTdIFJQfmI7VMj5aU2mxuuKu2xQqJozLZAVSWISM?=
 =?us-ascii?Q?QPwI1/bS+DEriApWBOIvwgA4fVDWFfbXx3spj5yUJMsjoV/FBjuHvOi7ATzb?=
 =?us-ascii?Q?1PjAsi3LcdbOM+mwBiwabpGN6P3owhyi5LAjTHJK2GP0J8kZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f12a73-b299-4db9-70c2-08dee3d89b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 07:54:19.3269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/1TV4GlTfWakM3qdLLaG6j0UvOH8sg5+Q6fJPe2+2g4TLocOvKcuLp5WhYw7oHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Thursday, July 16, 2026 5:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH V4] drm/amdgpu/ras: Add debug mask to disable CE logs for=
 uniras
>
> Add debug mask to disable kernel logs of RAS correctable errors, includin=
g both ACA
> and CE error counter kernel messages.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h             |  1 +
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c    |  1 +
>  drivers/gpu/drm/amd/ras/rascore/ras.h           |  2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca.c       | 17 ++++++++++-------
>  drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c  |  2 +-
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c      |  9 +++++++++
>  6 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a3dafdca7eb3..bc6b7da3914f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -226,6 +226,7 @@ extern int amdgpu_use_xgmi_p2p;  extern bool pcie_p2p=
;
> extern int amdgpu_mtype_local;  extern int amdgpu_enforce_isolation;
> +extern uint amdgpu_debug_mask;
>  #ifdef CONFIG_HSA_AMD
>  extern int sched_policy;
>  extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index ea95e0f93d1c..0db755ba7037 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -309,6 +309,7 @@ static struct ras_core_context
> *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
>               amdgpu_ras_mgr_eeprom_is_supported(adev);
>       init_config.poison_supported =3D
>               amdgpu_ras_is_poison_mode_supported(adev);
> +     init_config.ras_debug_mask =3D amdgpu_debug_mask;
>
>       amdgpu_ras_mgr_init_aca_config(adev, &init_config);
>       amdgpu_ras_mgr_init_eeprom_config(adev, &init_config); diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore=
/ras.h
> index 878dfdfcb18a..88b0bac158af 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -301,6 +301,7 @@ struct ras_core_config {
>
>       bool poison_supported;
>       bool ras_eeprom_supported;
> +     uint ras_debug_mask;
>       const struct ras_sys_func *sys_fn;
>
>       struct ras_aca_config aca_cfg;
> @@ -403,4 +404,5 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct
> ras_core_context *ras_core,  int ras_core_check_address_sanity(struct
> ras_core_context *ras_core, uint64_t addr);
>
>  int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enab=
le);
> +bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core);
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> index 67a35409ff0e..a1fb9a5f72cf 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> @@ -83,22 +83,20 @@ static void aca_report_ecc_info(struct ras_core_conte=
xt
> *ras_core,
>                       seq_no, skt, aid, ecc_count.total_ue_count, blk_nam=
e(blk));
>       }
>
> -     if (ecc_count.new_de_count) {
> +     if (ecc_count.new_de_count && blk =3D=3D RAS_BLOCK_ID__UMC) {
>               RAS_DEV_INFO(ras_core->dev,
> -             "{%llu} socket: %d, die: %d, %u new %s detected in %s block=
\n",
> +             "{%llu} socket: %d, die: %d, %u new deferred hardware error=
s
> detected
> +in %s block\n",
>                       seq_no, skt, aid, ecc_count.new_de_count,
> -                     (blk =3D=3D RAS_BLOCK_ID__UMC) ?
> -                             "deferred hardware errors" : "poison consum=
ption",
>                       blk_name(blk));
>               RAS_DEV_INFO(ras_core->dev,
> -             "{%llu} socket: %d, die: %d, %u %s detected in total in %s =
block\n",
> +             "{%llu} socket: %d, die: %d, %u deferred hardware errors de=
tected in
> +total in %s block\n",
>                       seq_no, skt, aid, ecc_count.total_de_count,
> -                     (blk =3D=3D RAS_BLOCK_ID__UMC) ?
> -                             "deferred hardware errors" : "poison consum=
ption",
>                       blk_name(blk));
>       }
>
>       if (ecc_count.new_ce_count) {
> +             if (ras_core_is_ce_log_disabled(ras_core))
> +                     return;
>               RAS_DEV_INFO(ras_core->dev,
>               "{%llu} socket: %d, die: %d, %u new correctable hardware er=
rors
> detected in %s block\n",
>                       seq_no, skt, aid, ecc_count.new_ce_count, blk_name(=
blk));
> @@ -114,6 +112,11 @@ static void aca_bank_log(struct ras_core_context
> *ras_core,  {
>       int i;
>
> +     if(ras_core_is_ce_log_disabled(ras_core) &&
> +        bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
> +        !bank_ecc->de_count)
> +             return;
> +
>       RAS_DEV_INFO(ras_core->dev,
>               "{%llu}" RAS_HW_ERR "Accelerator Check Architecture events
> logged\n",
>               bank->seq_no);
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> index 840610538c1f..288fad0862a2 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
> @@ -265,7 +265,7 @@ static int aca_parse_bank_default(struct ras_core_con=
text
> *ras_core,
>       ecc->bank_info.addr =3D bank->regs[ACA_REG_IDX__ADDR];
>
>       if (aca_check_bank_is_de(ras_core, status)) {
> -             ecc->de_count =3D 0;
> +             ecc->de_count =3D 1;
>       } else {
>               if (bank->ecc_type =3D=3D RAS_ERR_TYPE__UE)
>                       ecc->ue_count =3D 1;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 08e17a83ad5b..c90db914aa5f 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -28,6 +28,10 @@
>
>  #define IS_LEAP_YEAR(x) ((x % 4 =3D=3D 0 && x % 100 !=3D 0) || x % 400 =
=3D=3D 0)
>
> +enum RAS_DEBUG_MASK {
> +     RAS_DEBUG_DISABLE_RAS_CE_LOG =3D 9,
> +};
> +
>  static const char * const ras_block_name[] =3D {
>       "umc",
>       "sdma",
> @@ -545,6 +549,11 @@ bool ras_core_is_enabled(struct ras_core_context
> *ras_core)
>       return ras_core->ras_core_enabled;
>  }
>
> +bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core) {
> +     return !!(ras_core->config->ras_debug_mask &
> +BIT(RAS_DEBUG_DISABLE_RAS_CE_LOG));
> +}
> +
>  uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_=
core)  {
>       if (!ras_core)
> --
> 2.34.1

