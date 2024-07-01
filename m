Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2BFC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 09:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514C110E379;
	Mon,  1 Jul 2024 09:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oV4TZiP/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F4F10E379
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 09:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwf0wHHZRBy7VRC//ag/RoqxqP/VZssrw4W29b95P0U7UKbosWshH0yYmIY43bDqRC05P/3m4oMtGtBZ+7akKgcbsrsMblBIDGLTJJo7vXbWXnHPoBNc7mzLkUAkVr7MXrqjObzOtGHA0iSY+NDsUsJ/yPMRf6nVcuE3trgoAeHLZqN8H1ZNJZbLA5bf4uQmr/aUoEYEGcdgTsJi1snrmbvTfBCcBUiA6k+ncXh6LUmk/lRlAX7+YuacJf9Bd5gH9U+gpws7jQEmZhZ9F15MLGGdj8zudR3hBjs+mR8jO5S+jH+cKstfkixlQ5YJTH3z3i6KmkBpNULx0PtnIZ4JPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk0QSmBoV4yBFpzLVqBt6g+y957riCxlxqBi8tIt1jM=;
 b=GO+tsKLVj3OimSFw7e5kY3L66pgVpWZts8VkN2B0PjDn5BGGwvROyhq7dQrm/wNg2Y2+7IV58BuOaBW6qfju+xPWp4F+0vChld1RpVjdICqKNfzYb+7ELhfYPcPOUshyPyHXC4l+U6VHjGjFp3RsKiycmq0I7AjSNirSpI/+2/2IOcI9NP4mp0ultlBEUxH0rWXTElhX04GZBMDRqIk2D5E0U/OPJX2zHk4wUiH64uk+hB+OFT0QCeb1LShixkqsbh/r6KYhfdMT340yo1VMS3YxHw7TY71phCeKUVZQ01uJuU1Ib0KPmeAcjCkXWLQU0g7wx2kfXTghK3Yenv5HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk0QSmBoV4yBFpzLVqBt6g+y957riCxlxqBi8tIt1jM=;
 b=oV4TZiP/Qm1bi1Ly+rbqeKAkj2Rx2Gm6Z0ogiZuUtjtqhsi40zJ/sewvrchXFJhl7a03Wwi/xIKofSozu/rEmmspHAzytndVqoNFTZaPQfyzjeZFkZK7FHrH4tekAcbO+gqRRHwwzGqY9xPmBtnjvK5A/EK0WpGPk7E94LqEIRc=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 09:34:09 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 09:34:09 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: enable more Pstates profile levels for SMU
 v14.0.0 and v14.0.1
Thread-Topic: [PATCH] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Index: AQHay5AGf8e7xbb1Nk22Eh3GWu24uLHhmyvQ
Date: Mon, 1 Jul 2024 09:34:09 +0000
Message-ID: <CH3PR12MB807405FC838F23406317E6AFF6D32@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240701082253.497435-1-li.ma@amd.com>
In-Reply-To: <20240701082253.497435-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=38d3300f-7874-46ad-be2d-18fe3b150fee;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T09:29:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|BL3PR12MB6547:EE_
x-ms-office365-filtering-correlation-id: edd29f9f-f295-4036-0cc7-08dc99b0f59c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AwIReAf4JNKRa0JZDvZOECrjWAl7C/MsXquxyQUjIDVFaLl4Yk35U5pBqYV3?=
 =?us-ascii?Q?Gvg1UrzBBi7bmhiNDO2ztarXw+A00fv4r833tevW2jNbtXaL6zkaogSdd4G4?=
 =?us-ascii?Q?xrYGeXoa0gnjiRFLTAi05mSs1GNYrwM8L4lLw9b2PcjmTQRNcVstfRcusZgT?=
 =?us-ascii?Q?DFjaqJ68dsEKGCIaghFsPFnKFcMP1XuSkGZ46M4mesRenuo+H+e8BmcMqSqv?=
 =?us-ascii?Q?+ktha4mP3glzU/VEieYDAp2dEMx0Xt5YDV76CzcS8K/6IZj0nCzjs+g4GtcE?=
 =?us-ascii?Q?XcT87ihCfVtYrygMKhr46y5dmxOaWD4ReBpG+AGM+KZ4qC8C2Nu+5d8d3uiy?=
 =?us-ascii?Q?bABDrmh/q8uwVWAz+v1zf3uxH4FJMf3aoqD49q7Ad/W7VHHES9mlh6L+5E7M?=
 =?us-ascii?Q?gW0fiFPR9so4e+/pCWO+rLyOOFx2Tc8ZgGOUVS8rO5mGgUDIT7npbYOAOZRf?=
 =?us-ascii?Q?O/8O7Zk2h1nT9yLFNW7fkwTTS4p9GNnCJ8fXOZedD7BbK6TACcUjkWRRJCSo?=
 =?us-ascii?Q?8MfBwZ0nREIZmxchD9kTA9wfuIAKfbq3RDDH1OJ/Xq4tc9WNefuUsFOGhlCF?=
 =?us-ascii?Q?j6M8FgUsKpcKgv+6DeU5e3Yiw8/8KxKKgogTUUAOkn0xzzBa+81/TpdcA8k2?=
 =?us-ascii?Q?1AG/Rl5WXYreQvLBD2vvlPRrTZ9SOjeuEW7D0qKp3xVkCQadlPr9lC1Ta0Iy?=
 =?us-ascii?Q?ilP57s08TwnUompGp3n3kvu7UPC7PtM485Hfy5gm0AhWsJ1zzgVg6qAxUUNe?=
 =?us-ascii?Q?xt2r6vFyTJUkQgOUiLbkS1NZpfeBvD0wfG+9CNHUXWG+s/r+88JLsD84rx2P?=
 =?us-ascii?Q?MJaEJM7O5EbHfrlWYkGYM49kn1f66KKRpm+N35/csLm28vAKWJ6d9EfaEP32?=
 =?us-ascii?Q?qv4+DVF/wgn7lUJ+ort9h42LkedEKwpH1qTqvC5BOJ6hJ8UfiUZVs6sIFHJ/?=
 =?us-ascii?Q?HxVTTtbkDMtgwIUPBHciMuCfdCKfG713IoL4D0R8Kjo/ybYkOdMDX313GQen?=
 =?us-ascii?Q?oWJsxsWHuKYtq0LWw72ltb+e9Os3glAxwCP8jpK0A1Lmt3XJCX0hB3J41kQb?=
 =?us-ascii?Q?FqGltAjboFIJKjcMIKSGR6rnAfI49tryJl4Q0/9T7m4oPsu/06VpxnoG17dI?=
 =?us-ascii?Q?UPtIH2CtPYvRAmOffaTRwYcZ+TNOmaT9uDHq+9uMAaeGQCC0k20Z6o16pU1+?=
 =?us-ascii?Q?oQI4P6AvaG5Cpv8tceE/TVQ5hQ40MMWPG9tLyJ8PyVgaz7sBNQVyRNgPAIa1?=
 =?us-ascii?Q?UddK3CrMdxdV2RmVpImxE0Zf+QuoDPtE6CirNzHHemGPoknv3CmvdG8MlWDL?=
 =?us-ascii?Q?9zdqF+dcyB1suwYJKqogJtHtmru162PgKpcdvUxFS8roB/Q6nNu7s1pfY/JJ?=
 =?us-ascii?Q?mbmnksFyGsM31wSV6uzrFMrNnsx0Ue7lqlBCeF7ILsNUGkrKng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GvMBC2MrDiBMnSUpR2I+KNSXMoXJ/14iLc2Cy8cQjMOzQi4twSXAoECvepna?=
 =?us-ascii?Q?ZB/nm/9N0FdHiXLlMUZKN7rzLjdkKOPds+M+R+Iux51wqy9Ys5MOs+ruMRNo?=
 =?us-ascii?Q?pbEtUb33PWB6njdBp3ztot9UHlPmOmDbmbRJQ4ITNt2Sryw8jPw5NixNfhCn?=
 =?us-ascii?Q?GzRixOigVbHVHO6OzXFuKXM18rWjTaYvolByDoAPefRGp5/2cIMYOOz/M4Mv?=
 =?us-ascii?Q?xpBazSZ+BtZ2+HRPN8oxm9Og+BnDFj4p6zHqyyqSIPeIAjak7Hc7gHC6g//q?=
 =?us-ascii?Q?z8H7nHaPGfzteIkY3anlTFC8KchnNRAXlXMQqDl6nwEQFrc9Iby5HBxZiQP+?=
 =?us-ascii?Q?Q3K/at8jXARfGEeimztaT9fnlbEmQJsUta2zfKKyh6u5yU/5Edzj5b8vgezc?=
 =?us-ascii?Q?WQ7zqEuLbcrNbFGqvH5+TsVl2XTs5v+P95Mr+rFsI2nTc2PNfAq77pKGbthU?=
 =?us-ascii?Q?1suuzItcXlyLkJDMlAt40nDkHT70k9QdIotcBbNMHaX+JQIy6r2wyMNWya/v?=
 =?us-ascii?Q?rsi7Sv3EQkQV+XkO2HBFpNrh8E73PBkT+s1wicl8oLuIG3Zx2hciWdDtyDRA?=
 =?us-ascii?Q?J8raMlf+2BZ0TJxegpxmGSCRQ6gskV3oMgslj1P2PWTjRIy91gg1r8mz+jOA?=
 =?us-ascii?Q?pCUhSNzyNv2zbr8Sgbu82khP3Vz3Ki+FfQp1b+76GzfhVAw9F+Vvcn0WEY21?=
 =?us-ascii?Q?L0sret2Vmrx9CLVubRXrcGqNOfhqWVCZ6I7VDuc7Wg5oSs/2ycEKmO5fZtlG?=
 =?us-ascii?Q?v5/oAFqbzLCDOlpbQqnPaPZ8YPk1+CDeg2AxLlgvollr6fXfl5W7Whwf+tR2?=
 =?us-ascii?Q?nGD3PtFT3TPOLZC/RiHQ519ibXZZjeoUiszrA4qz88qC6NxadJh/TKNf3vLb?=
 =?us-ascii?Q?24QNt3+TqMQFVwvC1jRnGbTG8dR52i95IkA95tFsOzyWtgUp0qax+YGE3uMH?=
 =?us-ascii?Q?TCZzZq5NDcOuyZ/R4gOo+dLAm981KkUL++7f3fTdnESlQWtTXphMjqR+T+go?=
 =?us-ascii?Q?UBWcmNtISgUPnc8IBwioIrL8vNhmuLygb3tGUEFsfigD1Yi8LTpW+To9tYWY?=
 =?us-ascii?Q?VZNm9Eicqyl3wZpw2Jn/PNiRQaEzUKeukK6fIF7/bHSgPrCmMKGAxT8QExTE?=
 =?us-ascii?Q?eMbpUUuAVjj88czFrBeitfVCEuW5h6Pzqzwug4m6DatI37IWxVduu4qM5YMN?=
 =?us-ascii?Q?665lgQ5o3xivo/5GZmHqNtqAmECrDcp15g4ctSEeQihklsHljbZ+EC1pwBsh?=
 =?us-ascii?Q?T3hK9hFgB6rEVqUNuMhUK5I/B77bwhvY/RqylW7briVUnXj8FkF1FDsrJaym?=
 =?us-ascii?Q?0NrYfnlzlX+U7Ajy0fa72AnvPNfCgp9MuI2zd14W7V3/6yEq4Nry8oYz9IfZ?=
 =?us-ascii?Q?z7g8ST2aZKkN0PUOGIhsQ1KEzX0Ubae75ekJJyBxA9xFsv8Gd7K1dX49Cbxf?=
 =?us-ascii?Q?sMItx2uHDCw1yW/WY1NvoIwphKBI87EJ9ePUqIz72t0jFdcqn8EmFxaGwZTp?=
 =?us-ascii?Q?79RDG6G3G68oaKYd+I2wGlK7MqxLHAXIWcOCU//gnQ/ynDF0kDJVlI4aUkzQ?=
 =?us-ascii?Q?LnJcZQ94ZlamfUyt56c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd29f9f-f295-4036-0cc7-08dc99b0f59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 09:34:09.3552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBXaMBmBWJbmtOBusOx912ZUv3QeFZKjMqpnRwU5SW/adtWvD0p0SUZ0QxvkNynqpTn22xYSzP7KTEyqYvVd3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

Hi Li,

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Monday, July 1, 2024 4:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma, Li
> <Li.Ma@amd.com>
> Subject: [PATCH] drm/amd/swsmu: enable more Pstates profile levels for SM=
U
> v14.0.0 and v14.0.1
>
> This patch enables following UMD stable Pstates profile levels for
> power_dpm_force_performance_level interface.
>
> - profile_peak
> - profile_min_mclk
> - profile_min_sclk
> - profile_standard
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 150
> ++++++++++++++++--
>  1 file changed, 137 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 18abfbd6d059..d999e3b23173 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -65,6 +65,10 @@
>
>  #define SMU_MALL_PG_CONFIG_DEFAULT
> SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
>
> +#define SMU_14_0_0_UMD_PSTATE_GFXCLK                 700
> +#define SMU_14_0_0_UMD_PSTATE_SOCCLK                 678
> +#define SMU_14_0_0_UMD_PSTATE_FCLK                   1800
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> SMC_DPM_FEATURE ( \
>       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -723,10 +727,10 @@
> static int smu_v14_0_common_get_dpm_freq_by_index(struct smu_context
> *smu,
>                                               uint32_t dpm_level,
>                                               uint32_t *freq)
>  {
> -     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0,
> 0))
> -             smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level,
> freq);
> -     else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14,
> 0, 1))
> +     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0,
> 1))
>               smu_v14_0_1_get_dpm_freq_by_index(smu, clk_type, dpm_level,
> freq);
> +     else
> +             smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level,
> freq);
>
>       return 0;
>  }

Does this conflict with the ongoing commit drm/amd/pm: smu v14.0.4 reuse sm=
u v14.0.0 dpmtable ?

Tim

> @@ -818,9 +822,11 @@ static int
> smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
>                       break;
>               case SMU_MCLK:
>               case SMU_UCLK:
> -             case SMU_FCLK:
>                       max_dpm_level =3D 0;
>                       break;
> +             case SMU_FCLK:
> +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     break;
>               case SMU_SOCCLK:
>                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabled=
 - 1;
>                       break;
> @@ -855,7 +861,7 @@ static int
> smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
>                       min_dpm_level =3D clk_table->NumMemPstatesEnabled -=
 1;
>                       break;
>               case SMU_FCLK:
> -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     min_dpm_level =3D 0;
>                       break;
>               case SMU_SOCCLK:
>                       min_dpm_level =3D 0;
> @@ -936,9 +942,11 @@ static int
> smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
>                       break;
>               case SMU_MCLK:
>               case SMU_UCLK:
> -             case SMU_FCLK:
>                       max_dpm_level =3D 0;
>                       break;
> +             case SMU_FCLK:
> +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     break;
>               case SMU_SOCCLK:
>                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabled=
 - 1;
>                       break;
> @@ -969,7 +977,7 @@ static int
> smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
>                       min_dpm_level =3D clk_table->NumMemPstatesEnabled -=
 1;
>                       break;
>               case SMU_FCLK:
> -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     min_dpm_level =3D 0;
>                       break;
>               case SMU_SOCCLK:
>                       min_dpm_level =3D 0;
> @@ -999,10 +1007,10 @@ static int
> smu_v14_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
>                                                       uint32_t *min,
>                                                       uint32_t *max)
>  {
> -     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0,
> 0))
> -             smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
> -     else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(14,
> 0, 1))
> +     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0,
> 1))
>               smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max);
> +     else if (clk_type !=3D SMU_VCLK1 && clk_type !=3D SMU_DCLK1)
> +             smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
>
>       return 0;
>  }
> @@ -1268,13 +1276,67 @@ static int smu_v14_0_0_force_clk_levels(struct
> smu_context *smu,
>       return ret;
>  }
>
> -static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
> +static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context
> *smu,
> +                                     enum amd_dpm_forced_level level,
> +                                     enum smu_clk_type clk_type,
> +                                     uint32_t *min_clk,
> +                                     uint32_t *max_clk)
> +{
> +     uint32_t clk_limit =3D 0;
> +     int ret =3D 0;
> +
> +     switch (clk_type) {
> +     case SMU_GFXCLK:
> +     case SMU_SCLK:
> +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_GFXCLK;
> +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCL=
K,
> NULL, &clk_limit);
> +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK=
)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCL=
K,
> &clk_limit, NULL);
> +             break;
> +     case SMU_SOCCLK:
> +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_SOCCLK;
> +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_SOCCLK, NULL, &clk_limit);
> +             break;
> +     case SMU_FCLK:
> +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_FCLK;
> +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCL=
K,
> NULL, &clk_limit);
> +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK=
)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCL=
K,
> &clk_limit, NULL);
> +             break;
> +     case SMU_VCLK:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> NULL, &clk_limit);
> +             break;
> +     case SMU_VCLK1:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> NULL, &clk_limit);
> +             break;
> +     case SMU_DCLK:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> NULL, &clk_limit);
> +             break;
> +     case SMU_DCLK1:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> NULL, &clk_limit);
> +             break;
> +     default:
> +             ret =3D -EINVAL;
> +             break;
> +     }
> +     *min_clk =3D *max_clk =3D clk_limit;
> +     return ret;
> +}
> +
> +static int smu_v14_0_common_set_performance_level(struct smu_context
> +*smu,
>                                            enum amd_dpm_forced_level leve=
l)  {
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t sclk_min =3D 0, sclk_max =3D 0;
>       uint32_t fclk_min =3D 0, fclk_max =3D 0;
>       uint32_t socclk_min =3D 0, socclk_max =3D 0;
> +     uint32_t vclk_min =3D 0, vclk_max =3D 0;
> +     uint32_t dclk_min =3D 0, dclk_max =3D 0;
> +     uint32_t vclk1_min =3D 0, vclk1_max =3D 0;
> +     uint32_t dclk1_min =3D 0, dclk1_max =3D 0;
>       int ret =3D 0;
>
>       switch (level) {
> @@ -1282,28 +1344,54 @@ static int
> smu_v14_0_0_set_performance_level(struct smu_context *smu,
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> NULL, &sclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> NULL, &fclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> NULL, &socclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> NULL, &vclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> NULL, &dclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> NULL, &vclk1_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> NULL,
> +&dclk1_max);
>               sclk_min =3D sclk_max;
>               fclk_min =3D fclk_max;
>               socclk_min =3D socclk_max;
> +             vclk_min =3D vclk_max;
> +             dclk_min =3D dclk_max;
> +             vclk1_min =3D vclk1_max;
> +             dclk1_min =3D dclk1_max;
>               break;
>       case AMD_DPM_FORCED_LEVEL_LOW:
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> &sclk_min, NULL);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> &fclk_min, NULL);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> &socclk_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> &vclk_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> &dclk_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> &vclk1_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> &dclk1_min,
> +NULL);
>               sclk_max =3D sclk_min;
>               fclk_max =3D fclk_min;
>               socclk_max =3D socclk_min;
> +             vclk_max =3D vclk_min;
> +             dclk_max =3D dclk_min;
> +             vclk1_max =3D vclk1_min;
> +             dclk1_max =3D dclk1_min;
>               break;
>       case AMD_DPM_FORCED_LEVEL_AUTO:
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> &sclk_min, &sclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> &fclk_min, &fclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> &socclk_min, &socclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> &vclk_min, &vclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> &dclk_min, &dclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> &vclk1_min, &vclk1_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> &dclk1_min,
> +&dclk1_max);
>               break;
>       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> -             /* Temporarily do nothing since the optimal clocks haven't =
been
> provided yet */
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_SCLK,
> &sclk_min, &sclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_FCLK,
> &fclk_min, &fclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_SOCCLK, &socclk_min, &socclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK,
> &vclk_min, &vclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK,
> &dclk_min, &dclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK1=
,
> &vclk1_min, &vclk1_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_DCLK1,
> +&dclk1_min, &dclk1_max);
>               break;
>       case AMD_DPM_FORCED_LEVEL_MANUAL:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> @@ -1343,6 +1431,42 @@ static int
> smu_v14_0_0_set_performance_level(struct smu_context *smu,
>                       return ret;
>       }
>
> +     if (vclk_min && vclk_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_VCLK,
> +                                                           vclk_min,
> +                                                           vclk_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     if (vclk1_min && vclk1_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_VCLK1,
> +                                                           vclk1_min,
> +                                                           vclk1_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     if (dclk_min && dclk_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_DCLK,
> +                                                           dclk_min,
> +                                                           dclk_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     if (dclk1_min && dclk1_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_DCLK1,
> +                                                           dclk1_min,
> +                                                           dclk1_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
>       return ret;
>  }
>
> @@ -1520,7 +1644,7 @@ static const struct pptable_funcs
> smu_v14_0_0_ppt_funcs =3D {
>       .od_edit_dpm_table =3D smu_v14_0_od_edit_dpm_table,
>       .print_clk_levels =3D smu_v14_0_0_print_clk_levels,
>       .force_clk_levels =3D smu_v14_0_0_force_clk_levels,
> -     .set_performance_level =3D smu_v14_0_0_set_performance_level,
> +     .set_performance_level =3D smu_v14_0_common_set_performance_level,
>       .set_fine_grain_gfx_freq_parameters =3D
> smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
>       .set_gfx_power_up_by_imu =3D smu_v14_0_set_gfx_power_up_by_imu,
>       .dpm_set_vpe_enable =3D smu_v14_0_0_set_vpe_enable,
> --
> 2.25.1

