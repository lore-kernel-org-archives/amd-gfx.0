Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683AEC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 05:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808FD10E163;
	Mon, 14 Nov 2022 05:57:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6121010E163
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 05:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3IVeJoNT1XknCAvGQjatqLTMZAoIuN8TxqAWlBGoo3XaBLSzldwHSb4FBU/54cMJZ93bx6DSSbWxeEbslK+9iBQI054eLU/0+RbjYZkLXxeG/iVjHefbOEglr0U35ZpBhjUMyx2Kn3nO4pHFMlq8xFWDC+1Hwo6BjxstJ1/ctOc91xdfN6O6nksEzX9mwiXpF2EXV+EhcYhMdrdmFFGN9jp21ZfjUIzl5ddFnyGM+O1hxDUr1DG/920+FtMXqjOyCp84F/KdfS9QtXCNuQQKRQWDwdqzNgapggVKiB5XO67oGcoEoi823780tJAdmlz37lAKr0HXHz6L3lD+T0yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1PbjySWuCAx3RP1bMQ0TgY2K14CdVILHe7uPcJ3WDw=;
 b=GuACpS+F1/eVIPDJfn34gIi8Ip7wPQUbRD+jPwwrlXcl4eaexvtR/EhCgbRI5FZD7q1SbAw6b7JfSy07sv4YaF37cIzM62cDrypSvflUfpoyeYGTiZh1uTnF0P/lnaOBHjFGhCXqm2DLeQNxRZyHY6F2fvveJZ19xSjsb76QWR0gBymWDatfLQe3iXWzXL8neh1kycUBRx+dQ5VJqJQf9iHeE6mafh4GJn5fMQzDX3PXWwYNtz6wF0fU8IwqqBJHxahu4aME3uCcSrz474CW0rx8CMKpWfD/G7RhjILgUvNrchO+tirhxMJ3XnuDW0yb9Q+90jsZDjcIuHPXqz1XTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1PbjySWuCAx3RP1bMQ0TgY2K14CdVILHe7uPcJ3WDw=;
 b=Hxh74OFmncB2kedQSKdGSQLIoZ3vuEJ0BvpcVUi/28O64NFLJtBrM+jfPf9bxSJ1tpYPjGMknWyF7NNAoNyM3lK4uXITQr9WG3YMrg1ljce9csegXSRmeAmmpk8GZwZeOGtmoEHdiVPPlsJ6LcDbxtsBV4BlaPhPOtpstwhUHFc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.16; Mon, 14 Nov 2022 05:57:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 05:57:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: there is no vbios fb on devices with no
 display hw (v2)
Thread-Topic: [PATCH] drm/amdgpu: there is no vbios fb on devices with no
 display hw (v2)
Thread-Index: AQHY9g/T9sqSaqTflkmFp+WRW6k99a49757g
Date: Mon, 14 Nov 2022 05:57:19 +0000
Message-ID: <DM6PR12MB26197EE38F8473524F78A710E4059@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221111205412.41093-1-alexander.deucher@amd.com>
In-Reply-To: <20221111205412.41093-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-14T05:57:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fcb5a90b-4c3a-4d6d-afe8-4b9a9bc94b76;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MW4PR12MB6730:EE_
x-ms-office365-filtering-correlation-id: 9206c538-d8d8-4fd8-fc81-08dac6051774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ImgQN0V7FYxZFgktaO82ZzOdgbO8FIsSt+6a/HMjMlatLXxkuAYCKS5YDTBDrazwdhoxKKTQukokVI99Z5Opou/yQMeASbOlZ6os5ex/osf6A/Ynor/ho6LDHY8q6UD/k/cVpsgoKLBjiHcc2RiUQi4nrtBymmoOMb1iP0lD1cwGzV4mi/S1ES7uCfdWs2RX5b44ImlMLhywgWZVf6lxx7L0SBePUnQ3PMHUIqkplncPx8ISytJTjmJPWn36Z/m1Hrcij7JYyREhtlA+9ORGEBZ9Qu5urIVnGjXpD1sJawTTqxMi5vdaSmAQ0kZAGhsQ21HsRxnBEisZI5FVWa19rbmBoEggOmI67mi1ppvcPGQCpIRuVNt9fKziWP2Lysj3RKqGxjRGAHQqMqDP/Phjk3ttFleeTnCVJsQoS6U2HpjvQroUcuYQWUrvkW4L4cWm+CVg2Z57JLf/DL0uu7fFrhNcvABmoGaWsohcIwdTLTGgEag/mvy6N0eB2nFNfNDbcLnl2JyNs+VOinlVhJHjYb0AQIdBY6yaZ5NQ6/OxqyN/bx0wgYj8Zpp7vyA5JwYzuCInz1AReGwJmn6V+bBIzH8Gtlxo8/VwPeUTM+3skazUWJQWJPPmiqU3EakpNSjUjR2onpTLdvzZ9W1hyDZyXze7q8DCV4flStokEKr31Zzi7kd17CAn7QBmDIaJ0CUtNm2VzJ1tvRf4yoxWHozfaxOXM4Rqfjq8qdoaxa3s4m5k/qr2Z1mhydDONjxlrefRMmHLUs7Dbr5JF5Jgxb25Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(110136005)(9686003)(53546011)(186003)(478600001)(7696005)(33656002)(41300700001)(55016003)(6506007)(86362001)(26005)(2906002)(8676002)(122000001)(66476007)(66946007)(64756008)(66446008)(66556008)(76116006)(316002)(4326008)(38070700005)(83380400001)(38100700002)(71200400001)(52536014)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ICxXaDxP4gB0iuFcWuIOCcZpa4tVkz63KzqQU033kSy2Vfo2RMoO8CWsDa6a?=
 =?us-ascii?Q?dSB56HRCoZXaxSeWOX9LGO4WL06PAUMWcQDSuSaAGRYxrJUcrzziGaAcmvKD?=
 =?us-ascii?Q?eDUq0ArW2a0+kGicmcmCaI0kSvLWS79skMaJaS9ycYF9WaX6g0aLkwVrXvc4?=
 =?us-ascii?Q?xhFDMi+Rbt3rbbPDx2dtsdEaXBHSYuw2R4YvMkLIgFcbPGuocxO42+9lhfPB?=
 =?us-ascii?Q?Oq4miMazE4SoVB9IMufc28Sa07un9AxVBfEl8cQKXyVk/yml9Gh91B94g57d?=
 =?us-ascii?Q?CU1T+5KaI4Iuxru+XjOX1Q6gaFObfh3gKyvm9IHEogBsMGic1qZDkDL1hgkO?=
 =?us-ascii?Q?19Nm0XMk8wmaJrT6Lt6xkg7uqJZc1FdK9318pMGEb2FARA/9jZv/M1sr7MrY?=
 =?us-ascii?Q?fEzCg7IGUD7OyW71eE6NzCFL2hE9+ZTjc95CVodV5B6Yk6MZvosEDFtblP52?=
 =?us-ascii?Q?Q3TbqwCZIqrjXVmdzM7UhMnAPChyNkbzjGvcheDhJcp/fXHMY4AevdLuMN6l?=
 =?us-ascii?Q?4XlSWB0NDlTpEe303urs83JS/U3WqPy37BPZGD+DWxsyWjujt4xXp2chrcZz?=
 =?us-ascii?Q?yEUHWIzvuZ04QGCZagKQhgaDXRAR2mKQ6gyPUf4EjNOLnhkpAqTHnR7GoCgY?=
 =?us-ascii?Q?OlDQdTVkA0WkwYqNK7S9pbsQmVfehk1k0KjiWU8fbqlhNnYKgWfF4GXH931O?=
 =?us-ascii?Q?0ft3U6dXaPkLS9tSLXqZmta3tgJtkWLWe1P2HPMLSwfx9SORm1BGxSz2ZtD5?=
 =?us-ascii?Q?YCrogC+f4N4dXfu834nQgXqDw4rCl0EXlr4q0hqTSHvITpDxxuXcvjGxaBC4?=
 =?us-ascii?Q?gck0SVEPwOtqPjbLvLCdNvJUX7YNLI7YtMr8NuoeF7LPWW3T7KSL+E6SGFBJ?=
 =?us-ascii?Q?ool5G5Yc36f8/uR35lVGbMjGoVW7dCR1EOUaGr8WDoZXzU45hfN4mlEIrtLw?=
 =?us-ascii?Q?PQHDovbc3ltHacS1G5nGBW/UQwy06sOAMVo2Kx5LEivNFvU3e97OX6IaYSO+?=
 =?us-ascii?Q?BQ1d0aiUBoDzw5nhw/mmktDo6OyuqqnTyDrkNj4b1xLIvLMp3JUk/stsKSnQ?=
 =?us-ascii?Q?MXMpWOMktAMQ6EaH6NXz9q437Gj1/owukfFlzWZusbBZSJOU0a8ZYgkekzCJ?=
 =?us-ascii?Q?RhBz21yphdQ3rtmy1xso36ZnOCaNCoaxH9GS5il4Fny6DCv1rIvOoeRGx71A?=
 =?us-ascii?Q?nnZM/80LL0Ek2HN1a3Ke74en6ePkE5lCfHVNWZhb4hPh9uunec+4M3NWJisA?=
 =?us-ascii?Q?jTxZH79gkwMGlFGmXBjCcVjsCB657D0cwzSWeeb91cU3CqWQcYdNQv/MeNHx?=
 =?us-ascii?Q?WOgxNuso185E3CRBXR+4L3xnujr1Ilk9bIj1fVf6B8Y1WevbOCqU6KsLu2OM?=
 =?us-ascii?Q?UbGeEP6kkv+axPmhiEq/gRNVjAirIhq+ZwpCj6UZRI2CIYNvg/2QRY0fYzqc?=
 =?us-ascii?Q?OmYAIPmNov0frp1eO+2xL2kI0q/JGBCCaryS+tnGyKW8qjpI0Vip9KxErVhl?=
 =?us-ascii?Q?8k6wc5VvV1qypbLgmvsdJ4Q1IZOwNUEVroxnXRnYowEsnz2hRwQMyLa7fg4o?=
 =?us-ascii?Q?SI1tk3Q8ngdJRs4O3EU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9206c538-d8d8-4fd8-fc81-08dac6051774
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 05:57:19.6400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLMgpMNA0ueqbxl8jzG0VABAiNR42WckgcmIiOiOXjBDZn9XBrmyGS9e9RUZ1OU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, November 12, 2022 4:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: there is no vbios fb on devices with no
> display hw (v2)
>=20
> If we enable virtual display functionality on parts with
> no display hardware we can end up trying to check for and
> reserve the vbios FB area on devices where it doesn't exist.
> Check if display hardware is actually present on the hardware
> before trying to reserve the memory.
>=20
> v2: move the check into common code
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  2 +-
>  3 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5a4aaf4d9ed1..1f3a4d596d0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1298,6 +1298,7 @@ void amdgpu_device_pcie_port_wreg(struct
> amdgpu_device *adev,
>  				u32 reg, u32 v);
>  struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device
> *adev,
>  					    struct dma_fence *gang);
> +bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
>=20
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e039df9fb3dd..148ac2e9f31f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6045,3 +6045,44 @@ struct dma_fence
> *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>  	dma_fence_put(old);
>  	return NULL;
>  }
> +
> +bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev)
> +{
> +	switch (adev->asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +	case CHIP_HAINAN:
> +#endif
> +	case CHIP_TOPAZ:
> +		/* chips with no display hardware */
> +		return false;
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +	case CHIP_TAHITI:
> +	case CHIP_PITCAIRN:
> +	case CHIP_VERDE:
> +	case CHIP_OLAND:
> +#endif
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +	case CHIP_BONAIRE:
> +	case CHIP_HAWAII:
> +	case CHIP_KAVERI:
> +	case CHIP_KABINI:
> +	case CHIP_MULLINS:
> +#endif
> +	case CHIP_TONGA:
> +	case CHIP_FIJI:
> +	case CHIP_POLARIS10:
> +	case CHIP_POLARIS11:
> +	case CHIP_POLARIS12:
> +	case CHIP_VEGAM:
> +	case CHIP_CARRIZO:
> +	case CHIP_STONEY:
> +		/* chips with display hardware */
> +		return true;
> +	default:
> +		/* IP discovery */
> +		if (!adev->ip_versions[DCE_HWIP][0] ||
> +		    (adev->harvest_ip_mask &
> AMD_HARVEST_IP_DMU_MASK))
> +			return false;
> +		return true;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 9c0d9baab4e2..4365ede42855 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -657,7 +657,7 @@ void amdgpu_gmc_get_vbios_allocations(struct
> amdgpu_device *adev)
>  	}
>=20
>  	if (amdgpu_sriov_vf(adev) ||
> -	    !amdgpu_device_ip_get_ip_block(adev,
> AMD_IP_BLOCK_TYPE_DCE)) {
> +	    !amdgpu_device_has_display_hardware(adev)) {
>  		size =3D 0;
>  	} else {
>  		size =3D amdgpu_gmc_get_vbios_fb_size(adev);
> --
> 2.38.1
