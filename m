Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE5CC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 13:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757F410E154;
	Tue,  9 May 2023 13:35:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C1510E154
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 13:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiIRt6bSTmN9AsmLvZwX8Mn8UDUef3qj/ErSw2h5DIXTapc0Ye7t+GDPGq1SPewP8kXFyxGdCnXO24ztFLahF7cSyWqFa+Hzgo2l44zj0aI1uM3QCGm1ia/7fTyT7bMZpONmmd46Mda5kgxcPaegk+3gTbMoEjRhIgzUQlfBL+PLKWVZiHpaQ7Nz4pg5LSi1OGPU99WGsttI8Usyi8Pt4EcfIIRR+hmeMUW5U2XmvKJH77VPca+67lB+cT0vMSaPYVlj/fiZThEiUM9NiCSVzG6fnGwAbwgU2I8xu0qdG0vO29GBg4e9I5DGAW7lZq1qik2BMufh8dqK5LG0dJWOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Syi75h2ulimwTwbIbQNMHFGPV5bT2u+xJ/pZp/OgQ=;
 b=jVwi0jILGvfOaoOU3mU7E6L3h/Ypxd4rFazO/xQgi5heQkbIghN467qBN/xZi2s7ImNFmV3uftkqXFMGOmf8e2mSL2lN3HU+52osVue+ZBSI+HWhOB2E3RlCLUPr0gU3wyfIqR1+B7BHNWi5C8FBg/YihsmDDD1+MRnhFIZKkpsBv7mUPH2DeBxzEmGPTyAubNn2k9k6RAuhkV8qyBubr5zMDRgd18tFO1F0HDanTbJnqmWRk+UjfjrvIpGYmaB/yvd06giUPZnn0tkfEqoTdRFfXw9e/gKTfBxunYJXmmfb9dI1b0HT5a0SpOL5Em9zlj15nlaPiFsjvm57Zet+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Syi75h2ulimwTwbIbQNMHFGPV5bT2u+xJ/pZp/OgQ=;
 b=X40TovIzPZjrKmuAWMTAN604v+KA1pVmlUH8q/JgCgCfw6N47TxeeTCQS4IJqwkVYFiQUZPYslUqQWpOQaMQ1SuY4HIWLyqydM1fyurtCgiue1SbzDXgDuMUs9dvGvHjDPNRIyVS+j63dCfKBExZU4oDE4+R204mzFX5PUOCqPA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:35:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:35:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH v3] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Thread-Topic: [PATCH v3] drm/amd/pm: avoid potential UBSAN issue on legacy
 asics
Thread-Index: AQHZgkyYQDpCZ6iBeU6faQHRYS6s4a9R8aDw
Date: Tue, 9 May 2023 13:35:39 +0000
Message-ID: <BL1PR12MB5144E8D71DFD0423732C072EF7769@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230509080153.2169783-1-guchun.chen@amd.com>
In-Reply-To: <20230509080153.2169783-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-09T13:35:38Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b0c3d9e3-4e3a-47cc-84e0-fb6708cbb4be;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-05-09T13:35:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 68118a6a-bfd8-4a88-87b5-0fc3712a8075
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: 4c0c590e-c9d6-4114-91d8-08db50924772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DC2IVqT2YPom9lkBGCweMMEbf7Q5mF9hIdyElXq/kYFA91wmCL0eeAVY1LqRVj5qahrkI3K9956vCVFOokYSLS7gcAW4sPpfsWf6q3SqHzI5Be1hTtQmas/WMWHV0oNzM7vfDXiw2XKVXAoh4MeaTnzrDoCx8wMlBwhmvFf8YGPazqapmXs0W2O1clgIICknvveKx8QAJEJaSll5VRgKBCgNoOR9WnhQRK52Ha4p/5QXZJ1/rYP71i3WHnM+KQdY3uAjJl7p9LJ853XQ6WnmGDPDDslDdCFvC0uHIjBOSFOnWGj/ctFc6QSyQ9IYzbcgehVYjakCf6oEBouq4FR6A1o5hV7wZ7P2tVb1Vpcqg/eCQCGJkNr+qbp+WfxitRg4e/xgDQXAUFML1qJZvp37P/rZx4+vRRJ5w0uMm7JeG5766ept/HR88846t8KRoT6lp7eQJqq4v0hzFRxbcO/lJNeR4uDljwhjhTc/9n+x7iBPJTs7Pd+3FEXEK9VuogGYHuuTKvK9WN7TY6FSZ1jIUtHUDj/AN5B7bRPZED2HtQBeSFCkBOwipuiAurEBgStjoCOR5YlEj2sknm4epqkRtKmLKnCSxUb//AinsY7DikJs9OH4EZcF9DZy5uErEkOy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(66446008)(64756008)(4326008)(86362001)(316002)(478600001)(6636002)(76116006)(66946007)(7696005)(66556008)(110136005)(66476007)(53546011)(33656002)(83380400001)(9686003)(6506007)(26005)(2906002)(71200400001)(5660300002)(41300700001)(52536014)(8936002)(8676002)(55016003)(122000001)(38100700002)(38070700005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s7t0elE72Ovmg8ceqQLAtTsMGV+Wc61eCmQW6nBX3AOCDNbN5NLnaqs7xljA?=
 =?us-ascii?Q?E3PB18T+BJf1j4Q/X28t/HtPazsFScNAJJk7JWHG1LgC/6OTVbRraqUqipZg?=
 =?us-ascii?Q?p5+sZ4v4e1FyW0P4cPixJ2hFfMIXqGGdaip5H9CarX7eg4SuNT4eaO1R300C?=
 =?us-ascii?Q?SwZp1tCb7Z9p40UnjzdFF/Vcz/BRd2KFq95iopS/2SYHCCD/EIX8M8g0XnY2?=
 =?us-ascii?Q?/WXfQjtrgzFIKMwXXmOPzk0z90q9+b0oLdj3QRULYWQXsgyQ8Y/b7nh8e6TV?=
 =?us-ascii?Q?Izq1L7TyJPrUbREznh3S82ntxFDCetKfmpIFjZ8RHNSTZ3+tDt5PIwIYTaYM?=
 =?us-ascii?Q?8rPnupD2GocYyFL66nsoghwodXfCivNnt7YgGHBHeX23v2xNo6Mk7zKfZb1s?=
 =?us-ascii?Q?g+XY7igks8N66TDAgLJeQhbI0gC7hsOc58AsZESyS8KKSceaRb5dTvkZIKRM?=
 =?us-ascii?Q?jGSrM1ekHF3Tc24tbq4yWOnqcUEQd7p24c8ZgevCE0TSY2gczlXHGOBSaerV?=
 =?us-ascii?Q?zPpYi2BOvw8mme8t6MFpyc+wxZqzB27sxqzqUMEX/k8BXM5bsnp8HG/yZe4E?=
 =?us-ascii?Q?9JZUl523z0TR2sOcvQrqgoAXweQFRQLEWRweE0Neo9AvMV1F0+ZTAOKbsur7?=
 =?us-ascii?Q?rMz264RgeORN9c5NjRAXAE9uh+s77n3XUCILsI/ejX0kSVgJQ9jlKVgKHgLf?=
 =?us-ascii?Q?30xMGt1jymqek5DkUCOERyqFJfw8NVtRb+aV7RQlxBa0hfQy1+V6MwmWk+6L?=
 =?us-ascii?Q?AhWUHdUQK1C2lyiow8HgZ32EBlG8OszE6KLEu1dEPuO78sWe86a1ww/wSu36?=
 =?us-ascii?Q?V4nMZgkiUZMHxJJzuNv2pcr60ymoL7yOSk5uFNdnDSX0L6fJD3palQxTQY+9?=
 =?us-ascii?Q?cxMgLFHJ2MbnAqayw5wy+gLdyDO67xB7lgzqJeCzOZ99zFOiW1Jm6x7KIe4K?=
 =?us-ascii?Q?z6G/zY7ymmxNct69d/Mthd9AwzpMPVKDh8/De0zRbw6osdtTO4x32R/RFiPd?=
 =?us-ascii?Q?up7xjx375Ig9fNP3Vr4fz9KXZ/cxaWlRLZNslhjv8YTmlHYcZv1w7ewDrBsD?=
 =?us-ascii?Q?fZSwFR4kMVsJSkoM6UCSdwXKaZvDfYBgh7VEbHGrkzkttybuNxGn54+sBaLl?=
 =?us-ascii?Q?bGQjAXiCoyFnXpWP5gEgLfLFr2Jy2YF7A4MkjEeRObNnODCQ17OWyqSSelF0?=
 =?us-ascii?Q?D+EwE0Mv4On946+UoHrYxA1wBgH6XEMHKJ3e0n2IEePpwGMYZ8thnQPXuGqy?=
 =?us-ascii?Q?lUVomavlelRTzfgoBAWljpxPWPMGU5o7lvj3cbAkp604htTXjc+WLSlGZm6h?=
 =?us-ascii?Q?I1Azb1dEzSTsl3JMbDHkxfOrwdcAcXa0BQBi31zGSANb4I3EnzZyLh1EpTIq?=
 =?us-ascii?Q?YmOxjgEWz1edBvS7DlRi6NFEttLp4N58l5eV6HYJiqez2uswT/c1jvzRjcph?=
 =?us-ascii?Q?seJbkr8+NZmgPX3twpDuaCqaVXLlNatjLf63tZjNdZo94kX4F885z1fRpzaQ?=
 =?us-ascii?Q?J+PQ22Xtyl33D4n3J3hPcRJJovc784XKtsNLEi3JM8ejdirKvb8ub4kofifH?=
 =?us-ascii?Q?9qFtqLidyp6i+F/UQMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0c590e-c9d6-4114-91d8-08db50924772
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:35:39.6758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krdObda3CHxUHutLoAh+Wuc836WiW365MsqR16pIMAmW2c4KxCfn17tvm2/3wdIRmRw422P9Nz2DU9CzbUMHPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Guchun Chen
> Sent: Tuesday, May 9, 2023 4:02 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH v3] drm/amd/pm: avoid potential UBSAN issue on legacy
> asics
>=20
> Prevent further dpm casting on legacy asics without od_enabled in
> amdgpu_dpm_is_overdrive_supported. This can avoid UBSAN complain in
> init sequence.
>=20
> v2: add a macro to check legacy dpm instead of checking asic family/type
> v3: refine macro name for naming consistency
>=20
> Suggested-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 86246f69dbe1..078aaaa53162 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -36,6 +36,8 @@
>  #define amdgpu_dpm_enable_bapm(adev, e) \
>  		((adev)->powerplay.pp_funcs->enable_bapm((adev)-
> >powerplay.pp_handle, (e)))
>=20
> +#define amdgpu_dpm_is_legacy_dpm(adev) ((adev)-
> >powerplay.pp_handle =3D=3D
> +(adev))
> +
>  int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)  {
>  	const struct amd_pm_funcs *pp_funcs =3D adev-
> >powerplay.pp_funcs; @@ -1467,8 +1469,11 @@ int
> amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>  	} else {
>  		struct pp_hwmgr *hwmgr;
>=20
> -		/* SI asic does not carry od_enabled */
> -		if (adev->family =3D=3D AMDGPU_FAMILY_SI)
> +		/*
> +		 * dpm on some legacy asics don't carry od_enabled member
> +		 * as its pp_handle is casted directly from adev.
> +		 */
> +		if (amdgpu_dpm_is_legacy_dpm(adev))
>  			return false;
>=20
>  		hwmgr =3D (struct pp_hwmgr *)adev->powerplay.pp_handle;
> --
> 2.25.1
