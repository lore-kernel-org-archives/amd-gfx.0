Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56ACC3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 06:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9A610E51D;
	Tue,  2 Jul 2024 06:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JKHVESnD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CA110E51D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 06:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALifq7Wa9zkMWSxEaoJ1vMLSQCDLzDkBrPcKl3dOpm3HZs1CH2recYV/BUO3gVUxkrINJff5MDV11e+EmEBOnqbKA8bozWiwWPaB/MUM/DC0V4/71H1FFPaAohNQGwaF1HB3CfZhDtFU7SheLvwfIyajDbeCoLmaPW1zagu8+edCw1qdRt4TBe+cQ0HiT2YFdYEMgjd4092shHveNyobiLElgmMgwYebWag7xJ1dkNlSphnmbMVqKhfKzxS63vv17xiKYfyqfN4LE6nx3FYLn3MV3jQSUQnL858wZn4rMj+rlih+BPOK5GZdTldtQb82EEkGhqZWJToXWv6c7SJlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeYBy/fNfTSPkyUs5qKOz5blimdM8JcJ4+/xyDw/cLc=;
 b=fx0va+Lh9tdwKG+gxTfoMihOj7SV9l7JNiMOPKhc6YfQZHgehVt7LLFz/7dDNRVRSgpMBe24hi9nReFjoDlDO7gMFViAhvHLHC8ajoy1SNTdBmgUf5oPQ7DDbq2R2iQL+uhkD/V121hbUcoUGkLYkDaU3JRg4YfuTE27lGqsXclbuvdfi4FRum7XmPdH8U7nPOzEcZJ2R0zjIMds5FB8WFCq7muGTIqzZ7tXEwNxQdVF4K3RzquqmVcqLM7JWPgrMkn8+vKfd3/zhU+VhBBIdd5Fua6Ik9s82Qbh11jk6tZ1eDEvWcXzgnMt6tYOcWKLSVlTAYm6z2wZ+Ek/v1YBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeYBy/fNfTSPkyUs5qKOz5blimdM8JcJ4+/xyDw/cLc=;
 b=JKHVESnD05sTYXSaU3yl79ZN6Kc4GCP+IpUwLWBNCEDna5/oCntIXtb9p+CrA2dXALODvTYzewIZnn668nDxxEdVJqBTGDUOPP2FKcCmNlYXdlCz8aY+2XN2isNrXP9hebwGnibZjL2hyQhXtDq3q3smQWL5CSL/ouqX7cKXQ8c=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 06:28:38 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 06:28:37 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH v3] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Topic: [PATCH v3] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Index: AQHazEgtFcCMU+9FJ02U9ACrjeJmkLHi+POw
Date: Tue, 2 Jul 2024 06:28:37 +0000
Message-ID: <CH3PR12MB80743FE8E7181F162D858D1BF6DC2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240702062013.529169-1-li.ma@amd.com>
In-Reply-To: <20240702062013.529169-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7d6790f1-8420-43de-9ada-3e345ed502fc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-02T06:26:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|LV2PR12MB5822:EE_
x-ms-office365-filtering-correlation-id: 4872c0ec-056a-4f18-f5d1-08dc9a60350f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QCWI7tcBKepL9tf3YOhgo0B5fXc/qF2GRX4R/gSOAE9NjMtQ9s9DtKEA3z?=
 =?iso-8859-1?Q?BnF9c+EWMAcksJlYsf73+nk2XZaJ1eBI7Rk35D81JZ4YxWqR4VRKKSu94Z?=
 =?iso-8859-1?Q?6voGkjongqVVpyRgxz3dWPmo4qNGkRykteAZmI3V/T+PCy8IGn1zFnkKr8?=
 =?iso-8859-1?Q?qPtAdP8zFWyaZgm7gUTZBCTjY7wx5V5CleshBnjWR9LH9ut05grN16hKNn?=
 =?iso-8859-1?Q?Sq08Z1nWCp3ou/evsgNbXFLU24TkTGqfgQFaMlgSYHJNBZalNeK8QPyRsJ?=
 =?iso-8859-1?Q?JNiaYzcQZOcufNlBTly9SrmkQ4Iv4K6pBV/XziQAhpJ/07HgymC9Kh8PJ/?=
 =?iso-8859-1?Q?FaR7X1w3nyC3yt4AplmnxKh1v2mv30I1iZ15LMrSSSAlILF1gty7p4uTYd?=
 =?iso-8859-1?Q?fFrWF9EpfP0dFu9/0KezrxaD7angs94gsIDHbxM+UaBK3L10CBy8EBD09a?=
 =?iso-8859-1?Q?gyuY0J4hhK+uzbch8rbwf8BA+xPy2mchxzSm3eXKQf9VxSvW4BajcDm7gf?=
 =?iso-8859-1?Q?2YmMw+aJEuXi1vMTCvllSNWH/Z5N6pAYML3zW/z5e9wf/TkTMc6kVn2knv?=
 =?iso-8859-1?Q?ieHazTA2tUeu7Y4pOa8/RnPua/kB9Sykbv33tc9SoX2FJrnE8+/JFRM9WH?=
 =?iso-8859-1?Q?fsqAclqSjo+ZGABGH1SgxhYMCYrfozYn3vwEeoMuUtkplIM+BarADORsjc?=
 =?iso-8859-1?Q?AVXMk9hM983Ozvd2Vn3nwh9sXx6DQKwW75M+cn9plB3/Mio/lA4ske9XKo?=
 =?iso-8859-1?Q?cdBAH5FokhKPz1wRpOFcBVp0nBEfihmz0Ig0fZxy38T1rp6lEyaBUwuvDy?=
 =?iso-8859-1?Q?Mb3RcjSww2aKfVHaiElQf4VA8YKT52aS31mL0YYDngtfmJw8Ll8eaZRYIw?=
 =?iso-8859-1?Q?O3Yy9emwotJJEOQStnRDV+uQ/2Xk3hOluDaHMPrxT9yMa9v9CiXr6YqMXd?=
 =?iso-8859-1?Q?88RsEahIljtNrOU23BJN2d/88bP+1fGlNJd2Toa8L+9zMkitmvCPQOsz+e?=
 =?iso-8859-1?Q?Pn5lBGDNwNIh1+BUAJyDHu0fZ6aMOVv062u87boQpv/xT2NRx1J1rui0cH?=
 =?iso-8859-1?Q?wyipwRAnVP+U8AH1btOotMbX6vNf6aoyIKM0Ln+zy5gS09m00Afo25rfu9?=
 =?iso-8859-1?Q?zGGzpFTQy3LdbAJBi8q888W1eYLd65zb+u9sbusJ3Ejiybzl0WfB23Szqj?=
 =?iso-8859-1?Q?7q88QxpwBnCADvw4aZTrO+Yi1ph9H6N5U1CVjtwBIISJ0vDGYXIldKOYpx?=
 =?iso-8859-1?Q?MiIXM/fJ0eyJrDBK5HORVxtOK8Hld3HRl7VdA1wNpho4JjGqp/kInLDVo2?=
 =?iso-8859-1?Q?/XGxipw0RQy8CD0N3cZIlpf34LEunJFtrfXPIpKLF+nG5Of3SffGBsrfyG?=
 =?iso-8859-1?Q?K7GiQZOrOScumgl9czBFLFZZMRqbe9jiqpbhu1e+5pZ0enK/cUNKuuqBla?=
 =?iso-8859-1?Q?a5ktM+qdjrnsCqPFm/+NcR6yXLVYIWpVmzXplQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iKvtnvSF5dGNkeGi5Yh0i+XXWoE8mhKRNMLuwqoftbtM6cGgKoIqgluAfg?=
 =?iso-8859-1?Q?PIbXjA4tdouf/sHvYM5vrGKMj83nYmQJCFHtfU+GP2LyTW76xuNf3swJOD?=
 =?iso-8859-1?Q?xbV7hQ0sgOIHquGhTyBNppSbhjtFQIepuav+gW3hozQIuOIUi6ZFVrFm1C?=
 =?iso-8859-1?Q?pAQCO46u5QIN+HsJ4UWj4GHWvkT9HcEC+HeFhXiDEgUxrVXogy6OfQp1zg?=
 =?iso-8859-1?Q?bqlhG/eHyTFuOV8IHfhcHkvKl7naoq2AYd6duBpZ9EQ8eQPAjvYJNC/NfP?=
 =?iso-8859-1?Q?zfZpNoBCEh7bIUwrIz2UFjViOsOJ5x1ya2oE8Uxr8zb+bCrxSsr1LAAc4o?=
 =?iso-8859-1?Q?UhXnWpN/1NpDr5qs3+CIe0wT+7WvI9shWLTOzD1nKXGWuGNN/B+IM4yjHZ?=
 =?iso-8859-1?Q?tihPPxZBTKJj4BT+vzwnRtK3762vhdF1LtMLjgQp/qGR9mq93pOb7hC96T?=
 =?iso-8859-1?Q?Q77WOPTGz9ebHjhe8koym483TzyLiY/AW1vQYbIDwSRuW3ioQ+f5XB1LPZ?=
 =?iso-8859-1?Q?kp6VEwpPGyp88ZqDz83rd0MIdoOkNIX/yX5SEIsqIBm0Piw04aikGW87f6?=
 =?iso-8859-1?Q?9F0R/fVp/5gLrjgqwG27oIaF+R2PY9gPE5FEdHgRWL+YXRfjmvoe5v/m5Q?=
 =?iso-8859-1?Q?XE3GoNL4RI3F+DeYxKw1q7vwsqgXBbvbBimqJO4LcBoF3IvTD+7x+TqnFV?=
 =?iso-8859-1?Q?opz1YCEyRsIVMITD0QPiCevUlkqhqU+4OuHRJHHnh2YtMr7afLBlvawRKh?=
 =?iso-8859-1?Q?Tmhb5tH/Sc3uk3pl6Ra1AJDZEmNSgv9r1DUGsy4zcqDZlUUO1E/1TF7Pbt?=
 =?iso-8859-1?Q?Yuebh4UXfJkcbMu+vb2Hrvi9ca0AMNU28MIyJml0bBOCCPXVgY65SPyS3f?=
 =?iso-8859-1?Q?WxIY7WINF9U/xa0xaixM0LQYB+ebqNJcuIahmo6j7/5KEATok9URbeuW1g?=
 =?iso-8859-1?Q?U/mI/TDNDh/hwbmKzj/ZHKivPOtVJhJWTz8qB9AW+BS3UpBULBj3zGqZS9?=
 =?iso-8859-1?Q?U77CBjCunICasdYn0RKZsKDpYD89eAa4OV98BCGCKRe6jvpuMZ9LUWhPDY?=
 =?iso-8859-1?Q?W3z+OdrZ057xtw4H/xokYriWCClXTKxRDXBDsnMCV0e2RH1ifmdUkBzndK?=
 =?iso-8859-1?Q?tTJwByJwgRJCjWH3afWBASLIa2Hs4E1G+6NGVUAKdlk84G7yHgxqxXtvqr?=
 =?iso-8859-1?Q?kDmo09/F+4cOMaxi3Rnfv72RpgiX4xdQjPLjADND8dG36kPE133rxjAEHN?=
 =?iso-8859-1?Q?6cUFvX43AgavNJmjGgRiO+2O4USVbKC1fcVZJh7JqRKl4Yu/Z5tJ7WOI7e?=
 =?iso-8859-1?Q?+ZUc+Wpneasi7IRSnvjzLT9l0mlqqjpl9ZWesCMoq/QYt6GdOkB4GkZnOP?=
 =?iso-8859-1?Q?/3/UUBVJU7B6KNWKNg3yd0xqlUZ5mo00tkgydR7U7kIoLteI7NwCtKWdjO?=
 =?iso-8859-1?Q?Byv8HCSguE2yliHIR/SGhh9EDSGhra5JJjdSbk2SheAnLj8bMJA2URum9+?=
 =?iso-8859-1?Q?6E12EFUjCyjpVH8w4uqddiTXXkNutjIZZn7t8+TskWIDRjeOvgIVMHuflL?=
 =?iso-8859-1?Q?hTHqSE2ALxdg9YMy8gWowXch98oU/keIfgSX3sE8PrZy+Fhnd1ayiS/iZ8?=
 =?iso-8859-1?Q?aIZt2uGEEkghU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4872c0ec-056a-4f18-f5d1-08dc9a60350f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 06:28:37.7204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTOpRmqa/tSnBvwq1SED8utpuOMhO0MQs4rULmmParfk5lxnJj+jandPmIeu41to73tqJdGUbgWr0UcCL0Molg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>



> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Tuesday, July 2, 2024 2:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, Tim <Tim.Huang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma,
> Li <Li.Ma@amd.com>
> Subject: [PATCH v3] drm/amd/swsmu: enable more Pstates profile levels for
> SMU v14.0.0 and v14.0.1
>
> V1:   This patch enables following UMD stable Pstates profile
>       levels for power_dpm_force_performance_level interface.
>
>       - profile_peak
>       - profile_min_mclk
>       - profile_min_sclk
>       - profile_standard
>
> V2:   Fix conflict with commit "drm/amd/pm: smu v14.0.4 reuse smu v14.0.0
> dpmtable "
>
> V3:   Add VCLK1 and DCLK1 support for SMU V14.0.1
>       And avoid to set VCLK1 and DCLK1 for SMU v14.0.0
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 152
> ++++++++++++++++--
>  1 file changed, 142 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 3a9d58c036ea..5d47d58944f6 100644
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
>       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -725,7 +729,7 @@
> static int smu_v14_0_common_get_dpm_freq_by_index(struct smu_context
> *smu,  {
>       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0,
> 1))
>               smu_v14_0_1_get_dpm_freq_by_index(smu, clk_type, dpm_level,
> freq);
> -     else
> +     else if (clk_type !=3D SMU_VCLK1 && clk_type !=3D SMU_DCLK1)
>               smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level,
> freq);
>
>       return 0;
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
> @@ -1001,7 +1009,7 @@ static int
> smu_v14_0_common_get_dpm_ultimate_freq(struct smu_context *smu,  {
>       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0,
> 1))
>               smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max);
> -     else
> +     else if (clk_type !=3D SMU_VCLK1 && clk_type !=3D SMU_DCLK1)
>               smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
>
>       return 0;
> @@ -1020,9 +1028,15 @@ static int
> smu_v14_0_0_get_current_clk_freq(struct smu_context *smu,
>       case SMU_VCLK:
>               member_type =3D METRICS_AVERAGE_VCLK;
>               break;
> +     case SMU_VCLK1:
> +             member_type =3D METRICS_AVERAGE_VCLK1;
> +             break;
>       case SMU_DCLK:
>               member_type =3D METRICS_AVERAGE_DCLK;
>               break;
> +     case SMU_DCLK1:
> +             member_type =3D METRICS_AVERAGE_DCLK1;
> +             break;
>       case SMU_MCLK:
>               member_type =3D METRICS_AVERAGE_UCLK;
>               break;
> @@ -1106,7 +1120,7 @@ static int
> smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,  {
>       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0,
> 1))
>               smu_v14_0_1_get_dpm_level_count(smu, clk_type, count);
> -     else
> +     else if (clk_type !=3D SMU_VCLK1 && clk_type !=3D SMU_DCLK1)
>               smu_v14_0_0_get_dpm_level_count(smu, clk_type, count);
>
>       return 0;
> @@ -1250,6 +1264,8 @@ static int smu_v14_0_0_force_clk_levels(struct
> smu_context *smu,
>       case SMU_FCLK:
>       case SMU_VCLK:
>       case SMU_DCLK:
> +     case SMU_VCLK1:
> +     case SMU_DCLK1:
>               ret =3D smu_v14_0_common_get_dpm_freq_by_index(smu, clk_typ=
e,
> soft_min_level, &min_freq);
>               if (ret)
>                       break;
> @@ -1268,13 +1284,67 @@ static int smu_v14_0_0_force_clk_levels(struct
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
> @@ -1282,28 +1352,54 @@ static int
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
> @@ -1343,6 +1439,42 @@ static int
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
> @@ -1520,7 +1652,7 @@ static const struct pptable_funcs
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

