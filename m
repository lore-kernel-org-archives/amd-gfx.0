Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E2FC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 03:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1439A10E1C0;
	Tue,  7 Feb 2023 03:44:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA19B10E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 03:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFhg6aeh+NEG1vYYjIZtetMHGmIMuRBMk31Oitos8GIbuv7+lGgEIF/oTrIk9xCq1N0DXGAszzajQVFYjey5HVxiSNeqwLt9Te83fPyiJA0hrj7e+doZukC+14js0BO6KrLK7ceFYFFf1Zi+hJbOS/OuYSdF3iYf3KOz1sukzTJUMMACaXLoHwFM20hHVCnNPVwNthNjSL65ewhl2tLa7dzvAT8YxV88kNQEaPhhO1WBNDUeaywaxmQOr9r3XAcrA1HgLdkU8G3+xC7NJBXjVH1H3VpFEDVdeAJIsDRRfVFc7LXaPIcGdZLesef9AAijnic1Wo6xtk5x2kzgraf0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngSoMtPulClYaBYEJRJ0wCFSjNJM1Jq+kz/ZKBuS4Kc=;
 b=Bu1Iee19C1/3rSByNy0hHnWpPvZ6O61rCvXp+niSl8bEWdWNVnCZWW6OeHw/+XbSNjtgUTV9IG2E7dsk9dtS8cSu74jTzLZ48JldnNcOAUz9ODs7v/UP/VaVGiNbyIhlSz+qENNj/V8Jp07G1utxt2YzNUitVBp+J4M8uF+mJ5oATFqNvm11MLeFbd/jZEcGcH5g3jztYwQsEk/e0aE5vi03RDUOzAoGhIpQ68T9x6bbHhO+q/5OsDQHvUQswJHua6rVym5n+QaK/eFQSQ34cdZGvYyz1c4rBipMSaOBYUiXTj1WxQ7x8xjb0GThQnBwpADwSUNfWzjyYDOUvVBulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngSoMtPulClYaBYEJRJ0wCFSjNJM1Jq+kz/ZKBuS4Kc=;
 b=TydenXCG8k9ywXRP5EwP/yn7D1rPW67NF3/R3o8Iyh6hffCrhOwB/3O91JkuWcOgDJIHBUFxXU9M/CMeJJzdGopH3sZQeqPmXbKdLrfh3CxBPQPyaB6cfGuSjlRRZ+hdLqnA8qJcU+oKhGnshscCwYbqQECEMctLkJ0CBdkrKjA=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 03:44:13 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::a346:e2f0:d7f:7fe2]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::a346:e2f0:d7f:7fe2%3]) with mapi id 15.20.6064.029; Tue, 7 Feb 2023
 03:44:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm/smu7: move variables to where they are used
Thread-Topic: [PATCH] drm/amd/pm/smu7: move variables to where they are used
Thread-Index: AQHZOk02PPpFBT/mZEKDTZb0AP+kdq7C2BvQ
Date: Tue, 7 Feb 2023 03:44:13 +0000
Message-ID: <BYAPR12MB2615FCD05A3D887CA375B6DEE4DB9@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <20230206170502.105165-1-alexander.deucher@amd.com>
In-Reply-To: <20230206170502.105165-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-07T03:44:10Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a5fd5df2-8e44-460e-82a4-427e82343ea7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2615:EE_|SN7PR12MB7933:EE_
x-ms-office365-filtering-correlation-id: 79063fd4-d22c-47f1-ce29-08db08bd944c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkb77vzl197Pq3Eb2xUjuNgjewxXm5WtXOnIaqekiZcRxIIruaIUtqUHhRQEM6hL+mlFZewM5X9x++ct0Rj21dZT7xCw1J5BUQjvYkUwZhmO+RjZ1Pb4i0U92kucrLRt07pprj1liIbT4Pdq17eZ3gcV/BlHbbtYqBHotmSPStJs705NOY/LsBG1cWnv7dBy3/DV6RZxwi535lGNgykdT8+7D8JENFBvUTc2jXWrDf3DuBYTn+rcuCIi1jpwTBADVjAeU852GN1zRnrPgxG/1vSIsxoSqzPdpMfTCizpwfvi4rbMO9S38m/z9HltFsOh5CXGePJToBRtoKb/J7CivtC21s2o8jsOyEql5XHksmnTLNNwy0C6GOtuGKXBQBi2TrXYvSvbneQNvazZ7t5rr3NHdFgrrpfQvzfaRVym9Zo32aoT0CN88eCkMqx6w6zxDwvq9VQVpvbpfY35cZXQPN/0vnt0/t8DOlX+YOoAwATEAiqmAMKmep4cuKVrkwgBELNMaY81lLD5Ebn3bH5TG3vZB7Bxj4efuEApnjVeWlVy6KWZ0j0nkQhAO3ZXyAnE/Oifxy5k8SHKh7P37ebGpqiiQAaTlcbgALrR9796egNi3dmv0c+3VGM3WYJvDNmnzQz/8V47Q4jvu4+Q2snKgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199018)(966005)(7696005)(478600001)(316002)(122000001)(71200400001)(8936002)(52536014)(38100700002)(9686003)(41300700001)(83380400001)(55016003)(33656002)(6506007)(53546011)(186003)(26005)(2906002)(8676002)(38070700005)(5660300002)(86362001)(76116006)(66446008)(66946007)(66476007)(64756008)(66556008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZjWpk3qm87axbxyLO48IqtL5W/QjREpQudqiOX9pEJNwiPKBSwU6AuuN7C5O?=
 =?us-ascii?Q?GXXfNEHndPPECFjg+AARNBkwlNk+7jBp+0RKzyZ0sszwqUV10DghnJvHXVfY?=
 =?us-ascii?Q?Ic+Za+jtrTWeVG8v1r7u56eao19uD0rSNRUJlj/Nf5Wtc0xfnlIxWgEAbZwe?=
 =?us-ascii?Q?vMEUTzwbBdwfCzSYcSo9ZF2ZhqMonWyEMM168+b4MNtCCiZxQJozLMNp9QHt?=
 =?us-ascii?Q?FFIWoWiSkVTOf0lde2cpA9KrCvojh25XRhFEwEpoourO4FZC404FzJKbSUA1?=
 =?us-ascii?Q?sKjY7i5t6ziRUTA+PNVkTlUTnte2hz0axH5Iii4dbnaS5Dp0OFESDsa34yKq?=
 =?us-ascii?Q?cYLc9Krdg4Ri/vwe9F6pnU/Uo/RSI6+d2KXoKZv73Uw5ihevmLmaYd88Dbh8?=
 =?us-ascii?Q?4mJMleIVh01P2NsRArfc0HNjkmOjSuwj9HJzIO2VfdhhsM8Lsh67jniMzm99?=
 =?us-ascii?Q?kFvBE3nLIHLkelZwRyQsQ7r4XSPr11mA7+w+NEIZ0LYCphAWXlN/TkRW/CBh?=
 =?us-ascii?Q?QIQdNhw6vYk+bXzaHmS2vwTE/UEkkInk/PyRAmVqXtHaa7JLevMeQkXxkF7+?=
 =?us-ascii?Q?zQ1fWOiV8AjLehRu/wK2DZPvHSA0ymC4rTTGHhXr2ybcxyFZluvgb7LmWOEU?=
 =?us-ascii?Q?LCBb525c4a8IEYTSXRBI9nTmNBv+0UbHLegERslp4v6bUIy4VcMTPyHBMQn/?=
 =?us-ascii?Q?UYg6xwhGLqrMQZy+WW8Poh4MrZAbsLqM98EWQH7w0gJXma9OG4wDoiqOxYMr?=
 =?us-ascii?Q?0dyRvOKjd5QASWAZIgwj3yzRFKdOmwohmqJDL/gK4bwQtaRXhD3LHNasvRaQ?=
 =?us-ascii?Q?KZdsgAbjqt0Xym3bfbD/RUGkW4dbhrQf9EvWC11HfBuv5u+l3rtiqPaipMIS?=
 =?us-ascii?Q?1QkkneH/FgnTEGhmQc+XTa0CHbqk+TDNMW7mIKcPosh5DsyplbHXn3srHBdn?=
 =?us-ascii?Q?mARJVL0HR9TMgKPTqLTYY87SgNKSAC217mCBQMRMaEJqY3OojJSXdITjOFcp?=
 =?us-ascii?Q?Ov5AfRRrLRX6jGaOWefPwPDTMsmOnAhcVTbU3RVWYrmZihFTONv873jCqVBO?=
 =?us-ascii?Q?NatuajHb8uDiGmNhv5+hfJ509lVJajXMjwhDkUEGnBXvVx3qKK59/fnyd5ff?=
 =?us-ascii?Q?0QbATElvTtn6Tdk7prIi7VpqxUqPCoOY5XgklvtqBTviKmQPzr6Tw9hLOTSE?=
 =?us-ascii?Q?kEYg9x8G9DWRIfdAoVX9C9XmeR9yb/hZjQjiBldpnE+dIF1Xt5rTDV/F9UKz?=
 =?us-ascii?Q?aZH15k08yDYlv+G/1dfbBE2D2atInAhhQap47apN1xa/w2MkKBoqDuZCM76f?=
 =?us-ascii?Q?UDeJA4J+9TmuhTkdc9Q+3OuTq0TDzbGEfazdiMkynnDw3C6Y1XUXEPUDguzf?=
 =?us-ascii?Q?kwg1FSeKIfvrJ/RBaII+evmywTxbDhWfaP7aLNa3y2zIq+hHuHQ+jfFyoqGo?=
 =?us-ascii?Q?Y/HOhKJCWZ0w9W8fe2NBLC2qQCUpG9NUl2puyQu2vexJbtxf52cto30PjmW2?=
 =?us-ascii?Q?45hWk+eVcWmSWOIvw4I9edkkKmEmiVtJgpbLTMCVQM3xJAy1CcJiqy/EUEkC?=
 =?us-ascii?Q?oyU/NJKFhAu2zJJZikQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79063fd4-d22c-47f1-ce29-08db08bd944c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 03:44:13.2491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28o4p+edoQ7fDG0+8Zthc8JrTN+yLgEV2YSodNSKIKIZtg/rA1MEXAvJV9mUyhBb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
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

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, February 7, 2023 1:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm/smu7: move variables to where they are
> used
>=20
> Move variable declarations to where they are used.  Fixes
> a segfault on smu7 V0 structures where some tables don't
> exist.
>=20
> Cc: Evan Quan <evan.quan@amd.com>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2388
> Fixes: 711d3c39503b ("drm/amd/pm: fulfill powerplay peak profiling mode
> shader/memory clock settings")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 14 ++++++++--
> ----
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 89fc32318d80..e10cc5e7928e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1504,12 +1504,6 @@ static void
> smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
>  {
>  	struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr-
> >backend);
>  	struct smu7_dpm_table *golden_dpm_table =3D &data-
> >golden_dpm_table;
> -	struct phm_clock_voltage_dependency_table
> *vddc_dependency_on_sclk =3D
> -			hwmgr->dyn_state.vddc_dependency_on_sclk;
> -	struct phm_ppt_v1_information *table_info =3D
> -			(struct phm_ppt_v1_information *)(hwmgr-
> >pptable);
> -	struct phm_ppt_v1_clock_voltage_dependency_table
> *vdd_dep_on_sclk =3D
> -			table_info->vdd_dep_on_sclk;
>  	int32_t tmp_sclk, count, percentage;
>=20
>  	if (golden_dpm_table->mclk_table.count =3D=3D 1) {
> @@ -1524,6 +1518,9 @@ static void
> smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
>  	tmp_sclk =3D hwmgr->pstate_mclk * percentage / 100;
>=20
>  	if (hwmgr->pp_table_version =3D=3D PP_TABLE_V0) {
> +		struct phm_clock_voltage_dependency_table
> *vddc_dependency_on_sclk =3D
> +			hwmgr->dyn_state.vddc_dependency_on_sclk;
> +
>  		for (count =3D vddc_dependency_on_sclk->count - 1; count >=3D
> 0; count--) {
>  			if (tmp_sclk >=3D vddc_dependency_on_sclk-
> >entries[count].clk) {
>  				hwmgr->pstate_sclk =3D
> vddc_dependency_on_sclk->entries[count].clk;
> @@ -1536,6 +1533,11 @@ static void
> smu7_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
>  		hwmgr->pstate_sclk_peak =3D
>  			vddc_dependency_on_sclk-
> >entries[vddc_dependency_on_sclk->count - 1].clk;
>  	} else if (hwmgr->pp_table_version =3D=3D PP_TABLE_V1) {
> +		struct phm_ppt_v1_information *table_info =3D
> +			(struct phm_ppt_v1_information *)(hwmgr-
> >pptable);
> +		struct phm_ppt_v1_clock_voltage_dependency_table
> *vdd_dep_on_sclk =3D
> +			table_info->vdd_dep_on_sclk;
> +
>  		for (count =3D vdd_dep_on_sclk->count - 1; count >=3D 0; count--)
> {
>  			if (tmp_sclk >=3D vdd_dep_on_sclk->entries[count].clk)
> {
>  				hwmgr->pstate_sclk =3D vdd_dep_on_sclk-
> >entries[count].clk;
> --
> 2.39.1
