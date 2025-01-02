Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E7E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 08:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B9F10E1BA;
	Thu,  2 Jan 2025 08:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wqsg81Sq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F1C10E1BA
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 08:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgdMQWuN+S7MAY4iPy3Pn5phsk49cdTnGtEl5n5ZCjBPMjXUGpTMtU4w3RIsYUKgxXsSRzSHsLU8vVQpLegUwzQSQc0OLC08pvSURksdYLLWVzo4v7lpsXjOuIItxZhqJGM5cPP3SM/REWdVFK01lAhGhunagAdQ31qdGpasBC1vNDKPtfBOav2LHhNDlsYP8w1antBrn83Hso94Ijq9wel7gGEeScp6Z2nUFvoYCrqx5FCmU9jAVfCKRFkHOrJ/0UVIRN2cPcYS9AxiDEkPGGhVSfC655d80/H1fZkRYvre0FnXlJqug5lEWLUFL46ZbLWz9VskfaatixKPvrHURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1yfeWRoKTFDuk6rjKQ3vqADmMGylCUJv0VWuuaepwc=;
 b=lyYVui2sBLXycNhGWsFSYIN+KVtyL2kJkccm3QonXSfIBvWZExwXYdfOFoZ6T4RtIbGSOxSdpaFI+mrXs3ZpZvRQEGppsuw7nmpYwBzWdJS123qRKcKPc1YtV1Cabmi/H8urFlXYlrpp+XiCrl4xugUnO/TBofDM0D1jUo3OVBpSbzmDOXxRxFekRNBPQ1WrRlQc4oYsEfXS6QFnRaLj5NTeal3m7r3BNAJBK/wnm2tMjsO+vY8ZzKxZWvTZBpsqYzkVbwH6720x+1vwSugHwPGmTRsqk9wsea8pZf98BWfntGzcI43kbHBCJrR34S4/2xGdXV6OgLfse8J5+RDFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1yfeWRoKTFDuk6rjKQ3vqADmMGylCUJv0VWuuaepwc=;
 b=Wqsg81SqPxO0Kea+m2Si8jqOiEpajlTJDkY1OnwbTWesSk5ZxAnCiXkIuYz53TrCNgZk8AVx7GqjS6msXW0rwmdA0DIHsb/Bb5vgbxF5iW4kLCZFTjjISvo6gJ0SnNp7XuEUPhJxeWE0f6R3Za8tXOmpsQVEnsPGzwgXCvbOssQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.19; Thu, 2 Jan 2025 08:45:02 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 08:45:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reduce RLC safe mode request for gfx clock
 gating
Thread-Topic: [PATCH] drm/amdgpu: reduce RLC safe mode request for gfx clock
 gating
Thread-Index: AQHbVcta70bFdUe2skKzau/xhVuD7LMDOYiQ
Date: Thu, 2 Jan 2025 08:45:02 +0000
Message-ID: <DS7PR12MB6005C15F623618AD3CEE2559FB142@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241224061609.1207220-1-Prike.Liang@amd.com>
In-Reply-To: <20241224061609.1207220-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=84815143-a1e5-400d-a29e-61ed3038ba19;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-02T08:44:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6527:EE_
x-ms-office365-filtering-correlation-id: bf7427e1-2720-4a3b-cb9b-08dd2b09bfa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3bWwePOiAjD6Q5LKvGt7bpH4YGt6DFTWRjeGl2gKP5IuvrlOL34SQfMWQ/Uw?=
 =?us-ascii?Q?PQ0IHRL3Q6TbRbKVhH+umoMEghrDo4JD6hoObKYDWNuIMBwmkYX5sxKKK28U?=
 =?us-ascii?Q?Rp3RpO8LTKgkEYT8WEDlV5OrWbUIrABYhglTlRYoOhdmsusiZvqDf8Y6C3vh?=
 =?us-ascii?Q?zB5DiUUeWLSlBHjTA2wn+T5ERW7Xbs3VIIlAMRqmyaciFwPb77hXt0bYRSPK?=
 =?us-ascii?Q?i/HpW7f7xXFtK0FN8EY1fgHTJi1RKTnJoQEWPROupOnc/tHEpjhAyM5+2B6x?=
 =?us-ascii?Q?/r2f6yv7TUcs50dBR0k9NzemlouUzeC/Vq57e8dq+BPg+l7BXZLgZt4nDysp?=
 =?us-ascii?Q?aWSZ8hR06qpxGt2I61b8C1TFYC9z/vTx4neV6qiz0AGOaBdPFEKda3Wemu0y?=
 =?us-ascii?Q?EHcw+G5AiF9TlXVj2FPzuuoRhEweyfiHc8o2Mwjl4UB9wpLCQFykTS6JZXEk?=
 =?us-ascii?Q?83wmXM4cF9jOti8s9naVfVQinD0N/kxBcfGSEls0E/X/m7ARgGsnoUDKqkdF?=
 =?us-ascii?Q?HfQoZ0vArkFUdhFnCmceKW3phT2YU9ImOheG97O2gHY5EhpDepHRkBlTf91p?=
 =?us-ascii?Q?BASYpzJL3k+Br5jRiF8pO+//VPeEjAicAnW6K/0f5AbrcJqKOBYbZZUEKOLb?=
 =?us-ascii?Q?hEiAPSGzZh90KiXezt9HkBGfHcQcVhUTmmYfyYqKjDSXwXE9DZBho4dyZ0rX?=
 =?us-ascii?Q?MbSOyAX3l/xbGLBw0Ogd06vfuTUj+jI8pQH/c0GRKF6eDhpvBtYDVwkxdlbr?=
 =?us-ascii?Q?Hwxqbuq+3yGvE36+X68tQ2PXlLvJn75bRbiDul2940zrAlhbHPyB0t324Jl0?=
 =?us-ascii?Q?+1+2vTjOn8c3rv2vww5UUdoNsbhkCj2eTLwim5Ci6yyiY7Yv9zdHTmacOcFu?=
 =?us-ascii?Q?nJWp81Io/RDUnsxrxRA+B0WS09qXNg6VkcoN1BIyRAfzmRv2/OOXt5xPG22P?=
 =?us-ascii?Q?vJYYI+R4YlkC3OTfeOhvtaAyVE+YUBhcekzgM0F4V4Gf1o1bnFhegRXceipf?=
 =?us-ascii?Q?0fMnLjWQGDYLfB+VHMoj+A5lhu8BiYzi4HGd6qK3rua+vtaS9OgGBSQsnAsa?=
 =?us-ascii?Q?IoRdTR0dE1adGIfFRviVih1ns7E/k9saLE8uWBRa5CD2TfvFMEWmQWtt9A+6?=
 =?us-ascii?Q?cw/rTcMV9q4rT4x8/c9T1sO3lFMTli5lefGTO5aZPnTm0WAl/piaNw8nRFUs?=
 =?us-ascii?Q?Ek5O5ICjIxkNJOTgAm71+WNblLg4uY3psrgIMEVnxJHkHTIAnPFmNn0jMBEA?=
 =?us-ascii?Q?cLjUn7okttmG71ftuqyMvUpfgOt11ZnF4zlQ6v4GvnIf+jq7oCAQdDTKh4Pu?=
 =?us-ascii?Q?gJclq4NCnahWfQqi6JE+q7EitX1s8M81y3DAaa79wizWFa3eGAK4amJcbwbN?=
 =?us-ascii?Q?gGYJYstDR9RdnVIHJQRbmRFPuIn3zP4N4WjXPRuKuymkPHo/92VwAEQztWqV?=
 =?us-ascii?Q?QdByvmNFKj7I5QN8S2trlxZna1M1Yndm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZrBhd+R/paVDIbMgtugallQDaDZCEDHXJbnP7pOYGBnH9KupJTUKWA+G4xW8?=
 =?us-ascii?Q?8PDegO5OgKAu59VsckzVuBptVgNoeNxkFJmlSShPBAJzgErmpOAQBItAanJc?=
 =?us-ascii?Q?HpLdQsSGE2N/qIacTKQM0CId23aYsSvDrjdZkctqUyg+5jtemqdiIkDPkBkD?=
 =?us-ascii?Q?FWZzErY2ZFKKUbUSbx4JBaiAJ2mghGsn2KTpbXYBy+1Gxuw6Y981NVnIhZU9?=
 =?us-ascii?Q?snwNw9GN1llcnawb5b5kZgW9k5duQP+Owcaqn+0gCmhgmE9XpXbwbCly0iFZ?=
 =?us-ascii?Q?X+dEcJEcph0VumPqvKLXpjQTWLBjhELpZZ2DSLxM3pZRcH7+Q1A0QpzVGYVX?=
 =?us-ascii?Q?r3TFc4ZtduJa/R1Za/XHZljLpDHxB0TppN19m6gmaEddiCzJYG1QGdwQyzau?=
 =?us-ascii?Q?8bXDn2oyEPoj9RS8ZVCf1IHv9HbmPCXhNCw8/l7adhxP9u0kQqxhcPi6SAzp?=
 =?us-ascii?Q?eF9L3/LPO8e/IPrN1pLCf2ajLHeCk/on3HxQ2ZTOGz4vhNFwdHzEaphW9gLO?=
 =?us-ascii?Q?7jlG+r9banlLdUdIAOYhAHNcs938XZjO1hL39z8AwGG+H4lH7W8vh9W5ao1d?=
 =?us-ascii?Q?BTRSkQLZW+sPCdmFbrwqV++3zH11xRjdV25wXW79Fxk98NRkm8Io2GJ/jafi?=
 =?us-ascii?Q?cc/vl45pgcUGrC4d6RmcHPb5uskNCbV3jwRrhzmgLozbSaaPmz2WjsnXFOfx?=
 =?us-ascii?Q?EeXqkzkpsSE3ZaHo4OOfFMhfC7J0jrMCe6+EzWc+NuX4R2V6A86iQBXz1eQj?=
 =?us-ascii?Q?g+5bX3LtLpspLxjot6Th3g1FLctskt+wtJLe0h1gasHr/AbW8tow5Ll5eUc5?=
 =?us-ascii?Q?WTDmrxSe2fUtV+DlPr4lbW0RD6SPO6Y2S8QB0XSUHkcFBRqvJFO2Ykc7/6f7?=
 =?us-ascii?Q?09rzowKk0b7djfIoWXOycoNGX9XTZQa06L2Znf5cOMkDgIr2EtKR6XOkossj?=
 =?us-ascii?Q?ZYafvRfdq6dWFRIzTJicAZx5tGj2cCaZu5+yK8Z1mZb8md1/S2CXg+utzBnR?=
 =?us-ascii?Q?T+lA70ER7oTGqb4kFNFTKgEZPd8SAJ4QYUWcJIHqHQh/1T/5FiHzOQDF7o10?=
 =?us-ascii?Q?j8tcdzb5X80m7RQjAkp4LsAzRtAmaPri1CxCBKYJxxNW/kCwZTmcYgkysgNA?=
 =?us-ascii?Q?1NlEMbGiUZpDNEzEADiTrRSGCl9bQwjrQyWyNRAgxXj3FWt7r/GQb/ov5aGD?=
 =?us-ascii?Q?0RBvUZT8cDMfeunY+I8o1KPabdqHV5yAFkpeEnKxn3vKPv4nAJIuHtdfU1fu?=
 =?us-ascii?Q?D+k8gwqVzi6kTSkszwUDZlTzUgw3juY6X/TM+nNOW+QAREwieGfY1Wq6gsRh?=
 =?us-ascii?Q?vVpZgjf2db1xMCw1XVoGz7G1O5LtX8p+CFCvNhhlHFkBrfChx0fBWHGV5Q5f?=
 =?us-ascii?Q?eZOkIx5VTVmJQCpxdJ8Ru6/eCR2MgQ5Yw2WJdEr6ho+vaV5fOKds9crd7lzv?=
 =?us-ascii?Q?AVKlSn9/8EvcC7oelL0cgXSDdG3fMCSBrdvkrpn9y8V0bLLeO2+IeP8rVRF5?=
 =?us-ascii?Q?sOzPWIhbWcmkz9gqeO/dKXSnVJj/xD0XhZXspskAlHNGXyv/dTh4FP3LWJWH?=
 =?us-ascii?Q?Wb+cPt18ZXKs2TGV3TU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7427e1-2720-4a3b-cb9b-08dd2b09bfa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 08:45:02.6032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP9EA5sPOC9G6ddp5cpd/b8Qsz2uHGC1PmC8+oSglA9WS+bAoRKSxq6CnGudOrSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping...

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, December 24, 2024 2:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: reduce RLC safe mode request for gfx clock g=
ating
>
> The driver can only request one time for the power safe mode instead of p=
olling and
> disabling the power feature each time prior to program the GFX clock gati=
ng control
> registers. This update will reduce the latency on the GFX clock gating en=
try.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 ++++--------
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 ++------------
>  2 files changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index af73f85527b7..6a025438f9d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5639,8 +5639,6 @@ static void
> gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev  {
>       uint32_t temp, data;
>
> -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>       /* It is disabled by HW by default */
>       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) { @@ -
> 5734,8 +5732,6 @@ static void
> gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>               /* 7- wait for RLC_SERDES_CU_MASTER &
> RLC_SERDES_NONCU_MASTER idle */
>               gfx_v8_0_wait_for_rlc_serdes(adev);
>       }
> -
> -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>
>  static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_devi=
ce
> *adev, @@ -5745,8 +5741,6 @@ static void
> gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>
>       temp =3D data =3D RREG32(mmRLC_CGCG_CGLS_CTRL);
>
> -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
>               temp1 =3D data1 =3D
>       RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
>               data1 &=3D ~RLC_CGTT_MGCG_OVERRIDE__CGCG_MASK;
> @@ -5827,12 +5821,12 @@ static void
> gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>       }
>
>       gfx_v8_0_wait_for_rlc_serdes(adev);
> -
> -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  static int gfx_v8_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>                                           bool enable)
>  {
> +     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +
>       if (enable) {
>               /* CGCG/CGLS should be enabled after MGCG/MGLS/TS(CG/LS)
>                * =3D=3D=3D  MGCG + MGLS + TS(CG/LS) =3D=3D=3D
> @@ -5846,6 +5840,8 @@ static int gfx_v8_0_update_gfx_clock_gating(struct
> amdgpu_device *adev,
>               gfx_v8_0_update_coarse_grain_clock_gating(adev, enable);
>               gfx_v8_0_update_medium_grain_clock_gating(adev, enable);
>       }
> +
> +     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 4b5006dc3d34..fa572b40989e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4964,8 +4964,6 @@ static void
> gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev  {
>       uint32_t data, def;
>
> -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>       /* It is disabled by HW by default */
>       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>               /* 1 - RLC_CGTT_MGCG_OVERRIDE */
> @@ -5030,8 +5028,6 @@ static void
> gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>                       WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
>               }
>       }
> -
> -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>
>  static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev, =
@@ -
> 5042,8 +5038,6 @@ static void gfx_v9_0_update_3d_clock_gating(struct
> amdgpu_device *adev,
>       if (!adev->gfx.num_gfx_rings)
>               return;
>
> -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>       /* Enable 3D CGCG/CGLS */
>       if (enable) {
>               /* write cmd to clear cgcg/cgls ov */ @@ -5085,8 +5079,6 @@=
 static
> void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
>               if (def !=3D data)
>                       WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D,
> data);
>       }
> -
> -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>
>  static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_devi=
ce
> *adev, @@ -5094,8 +5086,6 @@ static void
> gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev  {
>       uint32_t def, data;
>
> -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
>               def =3D data =3D RREG32_SOC15(GC, 0,
> mmRLC_CGTT_MGCG_OVERRIDE);
>               /* unset CGCG override */
> @@ -5137,13 +5127,12 @@ static void
> gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>               if (def !=3D data)
>                       WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL,
> data);
>       }
> -
> -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>
>  static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>                                           bool enable)
>  {
> +     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>       if (enable) {
>               /* CGCG/CGLS should be enabled after MGCG/MGLS
>                * =3D=3D=3D  MGCG + MGLS =3D=3D=3D
> @@ -5163,6 +5152,7 @@ static int gfx_v9_0_update_gfx_clock_gating(struct
> amdgpu_device *adev,
>               /* =3D=3D=3D  MGCG + MGLS =3D=3D=3D */
>               gfx_v9_0_update_medium_grain_clock_gating(adev, enable);
>       }
> +     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>       return 0;
>  }
>
> --
> 2.34.1

