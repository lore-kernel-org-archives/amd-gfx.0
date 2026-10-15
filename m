Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9625FCC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 10:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117A410E75B;
	Thu, 15 Oct 2026 10:25:34 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CC210E75B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 10:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEtRLxJh5eI7ZKwqR2yi4+zyn6LxK7GY9xNc3cJPQ5ZdNf0xUDQRqU5dZpSLg3kdKRlhChLKOjDIp7y/BOrZGVCL3piWKHD4hmSBS7+OfEWMWl1cxsdtTtYMEgrT7+uSkngZHp8DP5DkXAYDR8QmochuAnhfvXi0eZzNBASWBYJKQNDqBzIBYC41ZsHLZRfJefWo0GdfWpHYMUhu0EoAwKsT10yMBqKdw+MB7nrNgNT9L9BFubHs74JHxMdYljfGy/rjl4Cgrr+zntQHMuUjdln2OcQZ3ZPxWWW4IF3WvdTHUXvz/7m9vhIbUF1qOpiz5UAfLY2erLson4BvpkHs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc0qcrFM5MlBAYDQ4FSf4ANpQncuv8CydkotPDlHy+M=;
 b=v0RtYbAyS/jFE/mpMJmNCa/eZoHP5QdZ0o0yugzz4U6AyGbduT8+nsnrHgH/aY9Rs5DDp+w3Fl+uOXC9S3leiEbvaR67YorPwuMmETXJYhVCXCIvOhlErOBHmYhAdi252v6VubqYPCTQHyNZcGzhtt1+fokuovp9M4wWlbR4dVDOh3BaHCYIkisBpMNh319Rb0gADb0PKJ6i0GmcVqiRQ5LTwXV5WcJvl9AnusPqcd4BiwZeErTD4/V53BUukDfG57CE9cOtuQAXmzSW65puWyAzKjJwTEQC/EnZ7D7jIMteOMYLoxjduc/wtWGj7L7uq5NoCFTCG8zvT1qcNDDBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc0qcrFM5MlBAYDQ4FSf4ANpQncuv8CydkotPDlHy+M=;
 b=PEnKYri1me4ktMmIhJ1sdVIWwLyOMOboh/2X2BVhEwZkPnasnK8SHJV3mDTntcMnwxL1DIYWecSxkIeEmw+2AtHm4FqqVR7aI/R058xzI8Y4yNdHUnUwK+LtjuYwQar8R/pM2eP0gZwK+oDefwG1imN9TIe9AhCWbmjIVGT/T84=
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::12) by IA4PR12MB144179.namprd12.prod.outlook.com
 (2603:10b6:207:12d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 10:25:24 +0000
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926]) by PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 10:25:24 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Hosur, Priya" <Priya.Hosur@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, "Hosur, Priya"
 <Priya.Hosur@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Topic: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Index: AQHdVxF7k9X/e06ML0WBD0E+tO2w/7b+ZjCAgAAKDnA=
Date: Thu, 15 Oct 2026 10:25:24 +0000
Message-ID: <PHXPR12MB99925592BB90114CEA6F2A6071939C2@PHXPR12MB999255.namprd12.prod.outlook.com>
References: <20261008104026.4102222-1-Priya.Hosur@amd.com>
 <20261008104026.4102222-2-Priya.Hosur@amd.com>
 <IA0PR12MB8895E6CA7AF1D2988800EDBBF39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB8895E6CA7AF1D2988800EDBBF39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T09:37:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999255:EE_|IA4PR12MB144179:EE_
x-ms-office365-filtering-correlation-id: 4ad8865e-e19d-4e71-a453-08df2aa69fa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|10067099003|22082099003|3023799007|261009223027099003|11063799006|4143699003|921020|38070700021|56012099006;
x-microsoft-antispam-message-info: v4u9A1mPwSd4+o/mHZIzbX++1IMnhwUBo/i8DsYMCMq2HGtWxLy0rlGbWSfCJOscL6Q5uMsFiW7Ww+BFJnmTCUhMbzAcBPhP9M6z7mQSjuV3HT4hB9dQXu6lXp8Zq/TujuOFh+O/LAoeL2UPzFr7wo90TVShnnlKZ6WF1gT4SyrsI5txz+YguBkidS5IqXaFaAsubUF5QbAApUy1CZo3WfEI/LkTLcQ32SZCaYcZLFsZ3I3B+9ogrRx3L5z2py383JZiynmvEVxonVjEP+YC/wc5wUP46o0I1UWp4hRCQD3sc22lsZ26A8E74duHgUsRKwh9YRq+7kZw7YAGApwnTRpc/EwlZF7iSdinbjFK+gMc/iJNDHnmnk9sERDiZqFxxdFl1u+ibu1O4xJV0fqHq9YqAYNZtKC+BfgrAjnQ9D3+AeiSYfUq0yE5hnQaEtskKGtIVg3m8+hvhpaAjS8bNfYq8x2wzusUqczyAorh/4/lq49Ds+UDD6k9nm95OXOHAQrUyR8emcU6C7VRu0Qy95CkBbHttiEn4izU+4B57GDAGBpiQxv97kPUA38DJh1E/TKIYwqBWnJ14kQCap+eQvOo7pIt2l1lhpDR27jHzbCHYrF8PsIR0gnwlIq/e7oW1e1fWSpe0+R4zHNCxMjw5ODoyxSZ547ufo94XwU9QfJOv2O2FNz0N3CUmLO6eVHGDXR8Bc8gP/5Uq/fcCsLN82YQrl9avdBq/gHkVDY1Wf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999255.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(3023799007)(261009223027099003)(11063799006)(4143699003)(921020)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vRLeC3GeZpMklmniE6jzuA1ki0NN4YNVG3EB6DlskLfg/uNMLNmzVAKAd9CH?=
 =?us-ascii?Q?xrhxEbauMO1ZJK85Z0XhXMCIpNxmRVP/NCpDuseOyoN0TmWxRHSKDg3QOgPC?=
 =?us-ascii?Q?SQp0XH9ZKtO56MqysMJv5HugFRRBu7eJplUNEC04EOYPyiMvOMOUdHrpwKAi?=
 =?us-ascii?Q?RhAaiIMsZ2tfQB1yNHFnwpm35dVTVW3SI0WZbnIuO+/94cTppy9qb2dl5drk?=
 =?us-ascii?Q?66yMAmtNKIZjAzo+aukH/xu8X+goOS2d3uXBGke85sfnHlT2JOSVXVAS7EAh?=
 =?us-ascii?Q?/V9Ygbb7JenyIOFcy2AZ0YnhcZMRAFAcWe/6Oc59ygte3ARkQ831miFHFfPF?=
 =?us-ascii?Q?4aPv/hBueFEQC5yN/TrXNFTrIxYmmlT82I458YC4PW6DE7cXL/h0jfX4oD59?=
 =?us-ascii?Q?7IJd2c300Lywf42cvgS5SO6POChzYQb9MM1uiaREMVAwwV7t/BJPt42d/BlT?=
 =?us-ascii?Q?h9bZNgmPfIN6uJvPBT7ww322QRLGMxVIW7X8jRVGEcejTgdwjPFW3mpswnm6?=
 =?us-ascii?Q?tlhDm8PBMaXVvrZOjoCueaFFnOgSpFNayHh5UHJhEmoQhUtE4Dm1jdCxgxeB?=
 =?us-ascii?Q?2G2Km/CYmI48ipyJAvqHFNAVDhBu+SVlpaH1cEv6OkyVCfv6hsOC1mw3dtz0?=
 =?us-ascii?Q?L3r7iIQGMb2jLEsSlm5LMVU8xzHZtCaGW+TzdcY458U9iVrArRSAPj6ze1Xd?=
 =?us-ascii?Q?uPkXk6G1esQTyIH0ou4FmRmDmc+0+5OIBq9STG5/tpvOuipY1fntub4pymnE?=
 =?us-ascii?Q?ak1UyLXo4QgojXL9ugcuZSZY0KHcYgNxoweZe39NW7FwFjKjakKWsGZ+QqBP?=
 =?us-ascii?Q?0gv8sGCriUrFfgE9rknjI9hAIQOtONq8nwPg+HsnaKiF24pl6L3kZ7DSkAdj?=
 =?us-ascii?Q?6nRLUaK+/qRhDRi+648oisH4RVlcV2J4fiI1rCCU1wZSKH6M9UOjnyq+TmDt?=
 =?us-ascii?Q?UmAz/LqaJclYy2pb/G7bXSwi7PYb6uwHv30XSipamr8Mr/v4chF8V/ZFIytV?=
 =?us-ascii?Q?zoRk6oDPBHLNPT+xHkRcDKgEAZuipQXuMqUOvj4zB8eW4OqRsAGA0Z5LSP+r?=
 =?us-ascii?Q?8JI5ADYeu8mf+du9ejI0wu0Eu2NLNEqrhp3UMGea+S+up75208lKLwjnBq0F?=
 =?us-ascii?Q?3uRIKjjkQWU4GbnMDjboeOsMvT6+IiRIAjYgR362fL8lcNynheo0Iel880hB?=
 =?us-ascii?Q?tNnsywOMVbAMCOTX9z30CCLnuKRUCoD++bXEnEFiRzPaj8pYOSbQ/GT9JBRS?=
 =?us-ascii?Q?9ycMeejZ1DGO4opF4dPd3kA4LwmPbXoxArEslg6XJPclJ1oViEMskyq3ixpU?=
 =?us-ascii?Q?IrSppFLIdOQQh9FNsz9Zc/xwERaXWb4T1AZIh2EhDPoR7i2ux5hNyv1U57zV?=
 =?us-ascii?Q?pOYGZQs/q04EPmjI2o+YRyUHsocCxDL4Wm+5sjQUN/rcda772n4PJXYXJnWu?=
 =?us-ascii?Q?1wDl7qi1dtsncGd9XrpdM19kyCCRYENglRQ6Aum5Shc+uFk+IiqpLPz6iB2Y?=
 =?us-ascii?Q?oQx7LjXRV+c+b/iUE0Zr7JwqQGEy4ba7AlXC7IT/1HtUpT+8ffaTOdixicMK?=
 =?us-ascii?Q?0Cl/1DObNarknn7oxJBE+YI4vYq09f3hfAZCPaPQv49b1lpW3AqUXWMfw8sR?=
 =?us-ascii?Q?kQlBc0qKaN5Wr5cD5MjjeT5dk5+7fhFPgIT4eM9QLGkLAGHgh9pZeQH3jr7u?=
 =?us-ascii?Q?fBd8i7NrR4wASGJZUz+H1L601JX9bJsiruUz1RtARGAJLfLS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999255.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad8865e-e19d-4e71-a453-08df2aa69fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 10:25:24.0851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXRfUChRS1gnCKD5/qffDu5idyfvKIhTFk4WASVSb+8oDxYUylws+JhyCMS/0koB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB144179
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

>> [PATCH] drm/amd/pm: reapply umd profile state after recovery

Could you please double check this change? It seems it already covers your =
case as I see.

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hosur,=
 Priya
> Sent: Thursday, October 15, 2026 17:47
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Deuc=
her,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan,
> Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya
> <Priya.Hosur@amd.com>
> Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance le=
vel after
> a reset
>
> AMD General
>
> Hi Team,
>
> Gentle reminder on this patch.
>
> Lijo, v2 follows your feedback to restore the forced level rather than re=
port the
> default. Could you take a look when you get a chance?
>
> Thanks and Regards,
> Priya
>
> -----Original Message-----
> From: Priya Hosur <Priya.Hosur@amd.com>
> Sent: Thursday, October 8, 2026 4:10 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Cc: Hosur, Priya <Priya.Hosur@amd.com>; Vishwakarma, Pratik
> <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> <Veerabadhran.Gopalakrishnan@amd.com>
> Subject: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level =
after a
> reset
>
> smu_late_init() re-applies the DPM level after a reset with
>
>   smu_handle_task(smu, smu->smu_dpm.dpm_level,
> AMD_PP_TASK_COMPLETE_INIT);
>
> but smu_adjust_power_state_dynamic() only programs the hardware when
>
>   if (smu_dpm_ctx->dpm_level !=3D level)
>
> and smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself=
.
> The branch is never taken for this caller and
> smu_asic_set_performance_level() is never called.
>
> PMFW is reinitialised by the reset and comes back on its default curve, w=
hile
> smu_dpm.dpm_level still holds the level the user forced. The device there=
fore runs
> at the default level while sysfs keeps reporting the forced one. On an SM=
U 14.0.1
> APU gfxclk drops from 2.8GHz to 600MHz while sysfs still reports high. Wr=
iting the
> same level again does not help either, as
> amdgpu_dpm_force_performance_level() returns early when the requested lev=
el
> matches the cached one.
>
> Sync the cached level with the state PMFW came back in before re-applying=
 the
> forced level, so that it is programmed again. Suspend/resume is not cover=
ed, as
> PMFW retains its state across s2idle and the forced level still applies o=
n resume.
>
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a65aa2129845..2d318726c521 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -998,9 +998,18 @@ static int smu_late_init(struct amdgpu_ip_block *ip_=
block)
>
>         smu_get_fan_parameters(smu);
>
> -       smu_handle_task(smu,
> -                       smu->smu_dpm.dpm_level,
> -                       AMD_PP_TASK_COMPLETE_INIT);
> +       if (amdgpu_reset_in_recovery(adev)) {
> +               enum amd_dpm_forced_level level =3D
> + smu->smu_dpm.dpm_level;
> +
> +               /* PMFW is reinitialised by the reset, so sync the cached=
 level
> +                * before re-applying the forced one
> +                */
> +               smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> +               smu_handle_task(smu, level, AMD_PP_TASK_COMPLETE_INIT);
> +       } else {
> +               smu_handle_task(smu, smu->smu_dpm.dpm_level,
> +                               AMD_PP_TASK_COMPLETE_INIT);
> +       }
>
>         ret =3D smu_apply_default_config_table_settings(smu);
>         if (ret && (ret !=3D -EOPNOTSUPP)) {
> --
> 2.43.0

