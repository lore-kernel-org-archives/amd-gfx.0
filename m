Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B448C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 07:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA8B10E3EB;
	Wed, 22 Feb 2023 07:52:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B2610E3EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 07:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLC55nhatAyszooanckpU6DezfRXx6GGhS1PG1sb7FS+SQHa09mJ8qaFnYhIIlktRfbgAmcqeouMbaWbvSr9j3TwYyY5bocXDoDgk3PN5aNW7vI5sOnucMSaFPOpc9DFrc0GRSryrSJzEvSvk9bpk3TmEFjMKmDbUoFSOIdp7S8+tk/9XpvjxRGArGbcK9bHuo7J3tZ+p34oc/OV39Oa3oSGp4O/tf22JsbJ8bo26N+BX5rddyGzGcoCvs1wWjcaW+1tBXvctqO5uYoW0d1mPrcQnqMclnRTYGCD2jkYP+h9SRSyy66CMOigAijiB1rvNddKlLhKnoyTC6svkctIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAgoA+9IA3DKwk5p+6u52IrRzoow600Hnp73GgPTGwc=;
 b=looV/1VzTyj3c7BwvwUsI/1AxXRdYIb2wc9lLbFO/84qIphaWWNdkDSPm7Mpl+V+qPWjXJZtFkN8eHIsm1ULrpK4of2b+5jOE2Wf15uLOVtYEjaofDIE4twbmpL6x9me3SBZ0QTMwxFRTR9CCQmScFnf+bmbuYZgRw63RatwyfrZChCXYQrK7OLzf1QaYRS+ImXSlVkHkRjJmjqelKRWp3+qDUUin3he78lDFKFC1JTeKGI1fZk7Fh07whTs/GYuEavmsm5u0DMPvE+WZjjuzkmHQsDJA4hqaiuPWP5mSp4OLWJRx6Z6PVFUVK5vdM6IaILZS71NFwIrwk4KHYa3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAgoA+9IA3DKwk5p+6u52IrRzoow600Hnp73GgPTGwc=;
 b=2217JsY2SWsBFwgdt2ulICOzGb79s3RTXkAFBmpqglr74LbK1pSz7J4bndLJOVkG5a/rBUpc/ked0OPEKIxj9bi6DwtefR3EKduydllcp8Vm3q5hodqgxyFdtqtY5aq7JTMI0XQImPfUriYydP3l2VjOycg3hp6uhtRG+47n3xI=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 07:52:34 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 07:52:34 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add ecc info query interface for umc v8_10
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add ecc info query interface for umc
 v8_10
Thread-Index: AQHZRncTTHrO+qImN0+VLGRKlz/4eq7amBWQ
Date: Wed, 22 Feb 2023 07:52:34 +0000
Message-ID: <BL1PR12MB5334AE1493A199727A7C5DE09AAA9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230222043451.25463-1-candice.li@amd.com>
In-Reply-To: <20230222043451.25463-1-candice.li@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-22T07:52:32Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f3ab073-4134-4448-876f-99b6b5c9e8b4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-22T07:52:32Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d30096a7-4e1c-4adb-b152-7c3896788cde
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|DM4PR12MB8449:EE_
x-ms-office365-filtering-correlation-id: ceb19e97-ba06-477f-27b4-08db14a9c274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJVl+S3L6DN+SAZrcfsrZDzSXLCAS10VG1vrOdtMRg5U/nvH1uRUOtXKaWpIv40jA8bwZea82MYICau1W2+rwVG7fjZnaEVdjRVjpDIfoyILllVwXvPNIU85hUqj4augZcMkOoA+Pu3tJfMbglp74q6Z4+2zLEqgRvWvMEQoCy7bDPHeqpCz6xiI++cNuctPCVjzz8ILgQetm3ar0VwqWdIODZYAzJWTf9l5XkET8hxIZxb+nDJpQNJWLPHkK5KUsPjG4Qq2APg64Pt3+B7/q38gbkBeFacTorSTmqHqe1zGWjwP/p+csDdtjA3QQVEFU1BT6gWWDthVWkchnMGd4EtFx8nH6S0NRoIW7NM8EVehRmq0wiWjBQbnJa/O5XEvb/YLxB06DDlsaNV4EzHV3hHXhNQtWkDDWyyrI/f1GmRsVeGzH1mZ8J+qQRksy+tJcvQMzjVUOEEKWzJkjyJmpBPuPLwvk1JLZbphEvFnSOqFI3WyQQpxlBu/yfp0r8u//ST5Ra2Jh4tfjY2bcT/0+iWFkEMZ0TJdM55q7jEMbIy7kQEbx+cODQQGK7Cjyn5qv22RC7MEmheZpH+yAbSpDQ/slp/Pe9I2C3QDG7BNO/tnE3Y5P6WnkHUZe/EehFciJhNhjYSper8zRCrvwPckmCsnD3TCJVRD8fBk41s4/atEqEj2206HvoOJz+OZ2ApL1pBbPgity/24YfbA6G4T8w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199018)(122000001)(5660300002)(38070700005)(38100700002)(8936002)(52536014)(2906002)(41300700001)(8676002)(66476007)(76116006)(66946007)(33656002)(478600001)(86362001)(64756008)(4326008)(316002)(110136005)(66556008)(66446008)(6506007)(26005)(9686003)(7696005)(83380400001)(71200400001)(53546011)(186003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f/sXHV+OFUxUqLVawyJAr5YgOoRyvXbRx8+FVBpwOmCm3RDugP3YFQT9dOfE?=
 =?us-ascii?Q?gk+ncfdUQ5e3PbbhBVFFSlAUaPh4W6xlmyVMeLXbgQXbF1bn6ftRuM7dyZGt?=
 =?us-ascii?Q?L4kOS6T0PYyfe4qu4yNHOy9ppO1J14g4nCID/CXUFSjCoFHTwPycA2IKAObQ?=
 =?us-ascii?Q?aemgMJ4UxYqkl8+Ki+rFkgDXSmM5wJ+pvuK/PSFKEokcHqVgy48nUlBKc6Fm?=
 =?us-ascii?Q?zP1vFmVDPDmVW8WINahUGlACZm0qgRRDBs2bqRqXdqvmCYjy4BE9daTblLJj?=
 =?us-ascii?Q?3VfjQ8EeuwPwupJLLfMEwmW5BEx6LCtNrZcE2W6w/hNT0iRImzw+HFUCbn7B?=
 =?us-ascii?Q?J4g+4lEUMLKK2cERPIwa+OsjFb7jgouVPsZb5g49OqIVdoXD5d8yVAMUyGEh?=
 =?us-ascii?Q?7Y2v3znzrktVaHGsgOb/MesUjNPnHcwnQOQWvkORNJbkx/Axn3YA/e5ds0Ka?=
 =?us-ascii?Q?r/iWUGUx4gdC5RxUmaFqyw57/DaGKMn3wAH/CrBZWzfdgxv+ZdWfurzo1Vc2?=
 =?us-ascii?Q?9uqkwefXpBRCVFKqyv5x95KfRZV2T8SDTnWyBV7kRARWfGSEFQCd3eRoR4oO?=
 =?us-ascii?Q?P1KMvzriGH92AtDbYOjxs75VtvXpxJ8pMfGR9Xx88ioTDhYZeNsua/DIN4NJ?=
 =?us-ascii?Q?JdqYf6bRhgnrFBUupjRxMA0VQ8OJNdadwcC7E2zoVTDfwmOB4BLScnTskk9H?=
 =?us-ascii?Q?367I6VMQ2DP+h0FA69E3LIPpKbFWIJEWgdhBr2GwEgjOy8AQGugfmsNbvrjR?=
 =?us-ascii?Q?l0kredMkKhUyzoTBKHa6KpW/wttC+x8v6w4bhFcFUS1fC0zmeHXaAroE26gq?=
 =?us-ascii?Q?m+gZnJH+8nqEgvHeHUkXPsydh+5+sJsN5Zx3fmjoSEpCi2RyJdPf76d8byIM?=
 =?us-ascii?Q?B/IjafvNB9bw8S6erDEZCmGhRENTMskjn28eeToRFOO4MuJmQ92Rrp+O3FCb?=
 =?us-ascii?Q?U3zGrJ6k1C8HaGERiAKPlm+l09SvHCZ2IkuMCGcoOCei0YugRLKKWZClSnmI?=
 =?us-ascii?Q?UkVlhmEtbTPazFD+FWg2pvqrGxPVTXWqFcu8DCbEJxiQWfi3jB6PAVVY4p7q?=
 =?us-ascii?Q?RfK0zj3k9ec95yS9aCGS3oi+Qm6X3zo/GvyWTniW8Dj90w1QUlDBBG00XJgk?=
 =?us-ascii?Q?HSDH8uo58eNHB42UsiH0qNuJRK1BBaqacn5cnUljICsc+fAsQUcDnUrjPI/P?=
 =?us-ascii?Q?GfXgDWPECCWZDP7vhr8BrgrnzAkAP2ZCEqrYLmnRRWzDShHKEGFLemMtqVJg?=
 =?us-ascii?Q?Y6yGUcohccN4nwlCKLQ+QzH5nGQCeC9XkDlUZ5LIdVbMFamC5p6+yNV8d4xr?=
 =?us-ascii?Q?YKn2rs/iHjRnXgxBE+GP3OEFflAki18JmjRe1Hl9Og40SImGZF1WLHfjgUwp?=
 =?us-ascii?Q?VG9HA59zsxsrdp4YokCWDqxZxN4D7Evh6hbG6RA9mEckYIDH43Gl2pIP5DwG?=
 =?us-ascii?Q?HRekwoM6rRbFesLVFrM5BTuofhIogLYxJY88FGs+vivbXx+3aor3EE0W1np3?=
 =?us-ascii?Q?ddOK0qay/SjtAnf7CMPtXlQ5IAwAOIWyqzjvZ6OCXsXxIRc8QcJuo5lS8gEN?=
 =?us-ascii?Q?XTuaqlXqXCgHgVCSw7BvOcT4AviplETYqirLXOpe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb19e97-ba06-477f-27b4-08db14a9c274
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 07:52:34.7009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fems5OAwSpIqXICbGJ+FD+WZM8L2QbvVEVQvqfELmLBAtqXGzFavE6QT8/z8vVqmTiRUHkGcrnpuIdo+BXGh7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Candice Li
> Sent: Wednesday, February 22, 2023 12:35 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Add ecc info query interface for umc
> v8_10
>=20
> Support ecc info query for umc v8_10.
>=20
> v2: Simplied by convert_error_address.
> v3: Remove unused variable and invalid checking.
>=20
> Signed-off-by: Candice Li <candice.li@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 134
> +++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> index 293ba39c8a2fda..66158219f791cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> @@ -360,6 +360,138 @@ static bool
> umc_v8_10_query_ras_poison_mode(struct amdgpu_device *adev)
>  	return true;
>  }
>=20
> +static void umc_v8_10_ecc_info_query_correctable_error_count(struct
> amdgpu_device *adev,
> +				      uint32_t node_inst, uint32_t umc_inst,
> uint32_t ch_inst,
> +				      unsigned long *error_count)
> +{
> +	uint64_t mc_umc_status;
> +	uint32_t eccinfo_table_idx;
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	eccinfo_table_idx =3D node_inst * adev->umc.umc_inst_num *
> +				  adev->umc.channel_inst_num +
> +				  umc_inst * adev->umc.channel_inst_num +
> +				  ch_inst;
> +
> +	/* check the MCUMC_STATUS */
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> +	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1) {
> +		*error_count +=3D 1;
> +	}
> +}
> +
> +static void umc_v8_10_ecc_info_query_uncorrectable_error_count(struct
> amdgpu_device *adev,
> +				      uint32_t node_inst, uint32_t umc_inst,
> uint32_t ch_inst,
> +				      unsigned long *error_count)
> +{
> +	uint64_t mc_umc_status;
> +	uint32_t eccinfo_table_idx;
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	eccinfo_table_idx =3D node_inst * adev->umc.umc_inst_num *
> +				  adev->umc.channel_inst_num +
> +				  umc_inst * adev->umc.channel_inst_num +
> +				  ch_inst;
> +
> +	/* check the MCUMC_STATUS */
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> +	if ((REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1) &&
> +	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D 1 ||
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D 1)) {
> +		*error_count +=3D 1;
> +	}
> +}
> +
> +static void umc_v8_10_ecc_info_query_ras_error_count(struct
> amdgpu_device *adev,
> +					void *ras_error_status)
> +{
> +	struct ras_err_data *err_data =3D (struct ras_err_data
> *)ras_error_status;
> +
> +	uint32_t node_inst       =3D 0;
> +	uint32_t umc_inst        =3D 0;
> +	uint32_t ch_inst         =3D 0;
> +
> +	/* TODO: driver needs to toggle DF Cstate to ensure
> +	 * safe access of UMC registers. Will add the protection
> +	 */
> +	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) {
> +		umc_v8_10_ecc_info_query_correctable_error_count(adev,
> +							node_inst, umc_inst,
> ch_inst,
> +							&(err_data-
> >ce_count));
> +
> 	umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
> +							node_inst, umc_inst,
> ch_inst,
> +							&(err_data-
> >ue_count));
> +	}
> +}
> +
> +static void umc_v8_10_ecc_info_query_error_address(struct
> amdgpu_device *adev,
> +					struct ras_err_data *err_data,
> +					uint32_t ch_inst,
> +					uint32_t umc_inst,
> +					uint32_t node_inst)
> +{
> +	uint32_t eccinfo_table_idx, channel_index;
> +	uint64_t mc_umc_status, err_addr;
> +
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	eccinfo_table_idx =3D node_inst * adev->umc.umc_inst_num *
> +				  adev->umc.channel_inst_num +
> +				  umc_inst * adev->umc.channel_inst_num +
> +				  ch_inst;
> +	channel_index =3D
> +		adev->umc.channel_idx_tbl[node_inst * adev-
> >umc.umc_inst_num *
> +						  adev-
> >umc.channel_inst_num +
> +						  umc_inst * adev-
> >umc.channel_inst_num +
> +						  ch_inst];
> +
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> +
> +	if (mc_umc_status =3D=3D 0)
> +		return;
> +
> +	if (!err_data->err_addr)
> +		return;
> +
> +	/* calculate error address if ue error is detected */
> +	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) =3D=3D 1 &&
> +	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1)) {
> +
> +		err_addr =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
> +		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +
> +		umc_v8_10_convert_error_address(adev, err_data,
> err_addr,
> +					ch_inst, umc_inst, node_inst,
> mc_umc_status);
> +	}
> +}
> +
> +static void umc_v8_10_ecc_info_query_ras_error_address(struct
> amdgpu_device *adev,
> +					void *ras_error_status)
> +{
> +	struct ras_err_data *err_data =3D (struct ras_err_data
> *)ras_error_status;
> +
> +	uint32_t node_inst       =3D 0;
> +	uint32_t umc_inst        =3D 0;
> +	uint32_t ch_inst         =3D 0;
> +
> +	/* TODO: driver needs to toggle DF Cstate to ensure
> +	 * safe access of UMC resgisters. Will add the protection
> +	 * when firmware interface is ready
> +	 */
> +	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst) {
> +		umc_v8_10_ecc_info_query_error_address(adev,
> +						err_data,
> +						ch_inst,
> +						umc_inst,
> +						node_inst);
> +	}
> +}
> +
>  const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops =3D {
>  	.query_ras_error_count =3D umc_v8_10_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v8_10_query_ras_error_address,
> @@ -371,4 +503,6 @@ struct amdgpu_umc_ras umc_v8_10_ras =3D {
>  	},
>  	.err_cnt_init =3D umc_v8_10_err_cnt_init,
>  	.query_ras_poison_mode =3D umc_v8_10_query_ras_poison_mode,
> +	.ecc_info_query_ras_error_count =3D
> umc_v8_10_ecc_info_query_ras_error_count,
> +	.ecc_info_query_ras_error_address =3D
> umc_v8_10_ecc_info_query_ras_error_address,
>  };
> --
> 2.17.1
