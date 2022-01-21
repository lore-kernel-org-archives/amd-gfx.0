Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9958C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 03:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259E610E5BE;
	Fri, 21 Jan 2022 03:37:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DEB10E5C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 03:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXZDpwxFW9nCVnyXWzXra4n/xoI/i8Hy6zdTM3LOvCKdh9OZPbg8iAsFSFAM41bCWOCReQLXHezIzeJbuBLPUF0zP+FAkyevkw7sl2lbcCb5pVVj/nWpfFusXulkPWcekuhjAe/A0tyhD/U+HBaLczRdpl+U5zcIJ9W6vZp1DTMwZlUoB7d3k64ZaHgrLETW8ScPJnm8rg0thhNh04MP2qgHomPP/AqzdFwt5RsJ4Moo2GNQcRB8op5BL47OaNF2gLu9f8ZD4IFuZP2qc43e5TNHole2zSluM1RFsTt4YigCNn86KoXTfIEYMImU5NWTXNh9EW6SLqQYbrqMwETkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDFldlhnhpX2cdVlvHHyrGy20SWJKIEkZUYdf86ZcW4=;
 b=Xpt1f/YSTSTUyqq1T2+sMQTVYilE4i3Mz0jP8VCaIydBqz6Jgsxe4P7z7dLeFRhjdmRTy/cWJlJ7RTu/buT4DkS0cCbVMSnQP5piWUGxmrGoh2AmauwZ4trPTPvK6KstMxLGkP+pajkOP5nymFEEZqdhADPjSLeMCnzmYPAoaj5hK7Yrl8iVIZ9/ReZJxGwrwlsu99jCCTuWQ9nSqYGc3Gj/oLZ2btc2Zpld7C/WDA4f2EU0syppNmxZw9Ui2HVAUXBISoHdDOsGFlHTPRh4zTpOkAXnsKXQOUWaVYFTXbbQS0AoSjTZyQi2OnYHwbNhjU9tOfBjEYWIU34NY2r8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDFldlhnhpX2cdVlvHHyrGy20SWJKIEkZUYdf86ZcW4=;
 b=aWYg0m957ugxQ7J0TdzIVCjRpbNE+ahhWrLD1kFF6BCz8bGesqj6Ne7mo1BLg5BVw12FvHNdXHqlZ0GJeafCZZxsyQT7c11J/nvjxfM5R19PJ4Ydmh9Y7+OKkudySyrYQHTH7e2J8jwXBH6MgeOpFGtlmm5z8VdrcxXIW5sTPnU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN6PR1201MB0084.namprd12.prod.outlook.com (2603:10b6:405:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 03:37:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 03:37:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GPUs
Thread-Topic: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GPUs
Thread-Index: AQHYDnE2nDxk6lug+kOca4X6IYgOBqxs05Ww
Date: Fri, 21 Jan 2022 03:37:43 +0000
Message-ID: <DM6PR12MB2619100E7D280FDA837DE308E45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220121024639.810-1-guchun.chen@amd.com>
In-Reply-To: <20220121024639.810-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-21T03:37:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cba8721d-04ab-42ef-a7b8-71c6bd616193;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d176d61-d3ff-415b-04ee-08d9dc8f6290
x-ms-traffictypediagnostic: BN6PR1201MB0084:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0084135CD6A70032D2FE7265E45B9@BN6PR1201MB0084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jxbeQjQZLujEsQdfLeODI19Op5R6CjS4ZDGxZ5XIK/twViuTyo1cW4CR2FESbsReJfac3umDHHi85F0JcHi9scTjydMoao6yb9seVjSQR4AhsBp92TQNSlmTicEhNaSFJkawDl/yUXlddTQU0ww2SVgk00VDLQa+DZzHA7Q6P2LuplVcGdWmOu8aVfduOh+C8WE5xx7N9+F7DchrTJ+NgWW8BQoLeJY2X4s/m4pC7FL2ImPHafiNBrUuk0nELPIF4EGhSgwosmq6DLcIrZTfp8ngc8eSKv3VIuac7uo7p8bgFuagXxKitzejWTrhrLT/m95flg3CBomKRy5edmF732XR2wn69e7l13B3h5R59+4/bsaCJ7PXzfnu4xMOQw30l6ldfI9G4UvhNFsCaXpRYg+bMXXYSNtCYVHMJoRvC/zrtLNdqlzkaVWIrpLLvC39cqB8H92xo9FE0wNLmksU9I9cOTg6m9SlcFcbfd9dqoJXSIOwl0Q6iHp+MlyJbfYoc2tVA56lkqRNzeF4qwY/8UN+dq5UFzKxmxWgThhYCvx+fndbvZIfU0i6XBWgYCCD3dLnHmv+/BX4STQzBr8z0wOO4+7gdafvx/028V9Ln3+s8c02VJ/qezbpAJJozZQRLpqdyyCDPXnMaNm1T4QiUFuMxmvXtzopoPosLYSaJvr0AZN3qgMYxo+SmTfU8NjkF8WuVfS/Yxp25thBYMo8nXVy7c+7+fBXol7LzQXNDS4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66946007)(76116006)(83380400001)(86362001)(8936002)(64756008)(71200400001)(38070700005)(66556008)(122000001)(38100700002)(9686003)(55016003)(316002)(2906002)(110136005)(921005)(508600001)(33656002)(186003)(6636002)(26005)(53546011)(7696005)(8676002)(66446008)(5660300002)(6506007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DBinGSqdYB5qT/hqXqK/3QNlNvQ8zKufPMRqTYdBd33O2sBmo7LHihFlpewS?=
 =?us-ascii?Q?qBiWAWQ7sJY0Qmb60jdKXboovhPU9zTvHtfYXme9WiE+jbgd/sh5geeE/jhw?=
 =?us-ascii?Q?dAhkwmGXSRuRutZTxsgUYWzjQrdeoQjMUTpaKelF5fLUMG+NdmOX2ipef14P?=
 =?us-ascii?Q?2gk9sSKjRxQGr3DbCJnM9T5T8ZHPBQWc/drw7W7Id3UpCbJW8WRax59kXdaR?=
 =?us-ascii?Q?08MnPOpIfrWR5iND1h4AaSBouGOUDVIdC0Asv/bB3yOnfyZQwzKOEPdTCQ4E?=
 =?us-ascii?Q?kWoC6J11rurkt2g6SedrlnzbqTttJamcGlxEl5/iBAd5d+YVWgWgGfXZOVxB?=
 =?us-ascii?Q?cuqNE4wf7hXOdRY3Bc0p57IW2GKNeu5F6qmQKXbabti2bYeD9SSohxdKfzrx?=
 =?us-ascii?Q?1Sbz0Lagp8F2GKuy4z6elP8kCGJGoHnHE+RMtno6xz/Hba/WmqMlVj/PTUsI?=
 =?us-ascii?Q?pwNXWwRH1YAQ5PDUEUVuyW7BqVnAPIIsQzS2xBwfXGAzvikXF7oW4iP+VBMN?=
 =?us-ascii?Q?TxhfAokvRtEW+5o2Cx6WEKLMpTgDyKDAhdbn/cN1rRJlXzol9K5H9+x3LDuA?=
 =?us-ascii?Q?8kwIqR9mIkcLqzAH2aYz4kNN+PC5SoItJDhO+NjOKRh1jLIo3SUDThrtxaT6?=
 =?us-ascii?Q?jbK9/p2sNq55OvJcveN2KHQnCfmZqt5eM94t88tlXoAWt1JV6LSI8px+hSqR?=
 =?us-ascii?Q?yl03A1b3Q6I3K+95KK16SnbWTiXBG5lPZTIwNDyzuVRJbjh0/IJa1qUSl2Cl?=
 =?us-ascii?Q?BmUHK30EgpiI04jk/Q7EqXTPmfNsmmutqEk2E+4Dt5NhfgF0oQuQWBNB7Dm8?=
 =?us-ascii?Q?HKL3TlaWCZ7p6cIIm6vFScTtvlBnA8HBobJxQX9q6oGWY88bGsITnmNy6vTK?=
 =?us-ascii?Q?KWPKwWb4StpaTmSeVhHe4eCrMWUILPWmFlAstfalTni6UZq5RcYItPPXHfpe?=
 =?us-ascii?Q?3RbRkI8TrDmsb+TT1/f2zus2fVE5Lg1/fkcIiABDXMs1UVoaooQ2BJNWCe2F?=
 =?us-ascii?Q?GHh0+HBXSqstqBOHGqeCeXKLm4XyONEfzDIUyeD8/TBb5gsCxhIHJ3XWAB5o?=
 =?us-ascii?Q?xcu6DWMwPqbGZn4zu/KJRbmRX9N7IV6igvatBGQCEsQDiAshXBFBmWNKG4AQ?=
 =?us-ascii?Q?FfpFhuVNLDnOPb4DpKbPLN+v2qhip3f/Q29G0UGsyinBnDhy+GQ4CTeRohEN?=
 =?us-ascii?Q?3WPUJBHN7z/C5uhl6P/BzRkM4SjfS+jm1GbbR2gE3XeNIAWybTkZQ5oKNQH9?=
 =?us-ascii?Q?8uWJGR2USHnOYHG6WhEMaB4+qo3hE3ea+nUCdz0w+jvb9qiadYcdF6ZRJn1u?=
 =?us-ascii?Q?5AjCxDBQ6K8ti5DQBth4Lk5xTOG6J1gfOUgVOsKPCEtXXFOv7HdcYK3ebZMD?=
 =?us-ascii?Q?AJiHH0jp6a9XXYSJm/25t1UzQenJCMIODtKuII2NwMSvnhRNyO4PFD0qW0GL?=
 =?us-ascii?Q?H0ARU56EGEd/GnSrK/X2QiCcuoGJnop2P57P41yvTJvTUXkvu9BBbaVtY/nh?=
 =?us-ascii?Q?HCViLmsZAaEbCFCeAORCPv8tDiL7IbtbOb6KfvNY2KqTYY1SdlGqSNJwesCg?=
 =?us-ascii?Q?Guz3Zwku1Ar+K7ThQG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d176d61-d3ff-415b-04ee-08d9dc8f6290
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 03:37:43.9956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2V5oDOjxOJUsNUyW3pfec26QkTOoAypcGAkOioRJDzKLVASAvJWEBoLw5Y19m35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0084
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

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, January 21, 2022 10:47 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Quan,
> Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: use dev_*** to print output in multiple
> GPUs
>=20
> In multiple GPU configuration, when failed to send a SMU
> message, it's hard to figure out which GPU has such problem.
> So it's not comfortable to user.
>=20
> [40190.142181] amdgpu: [powerplay]
>                 last message was failed ret is 65535
> [40190.242420] amdgpu: [powerplay]
>                 failed to send message 201 ret is 65535
> [40190.392763] amdgpu: [powerplay]
>                 last message was failed ret is 65535
> [40190.492997] amdgpu: [powerplay]
>                 failed to send message 200 ret is 65535
> [40190.743575] amdgpu: [powerplay]
>                 last message was failed ret is 65535
> [40190.843812] amdgpu: [powerplay]
>                 failed to send message 282 ret is 65535
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |  4 +++-
>  .../gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c    |  4 ++--
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 11
> +++++++----
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c |  2 +-
>  .../gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c   |  4 ++--
>  5 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> index 93a1c7248e26..5ca3c422f7d4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> @@ -208,6 +208,7 @@ static int ci_read_smc_sram_dword(struct pp_hwmgr
> *hwmgr, uint32_t smc_addr,
>=20
>  static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
>  {
> +	struct amdgpu_device *adev =3D hwmgr->adev;
>  	int ret;
>=20
>  	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
> @@ -218,7 +219,8 @@ static int ci_send_msg_to_smc(struct pp_hwmgr
> *hwmgr, uint16_t msg)
>  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
>=20
>  	if (ret !=3D 1)
> -		pr_info("\n failed to send message %x ret is %d\n",  msg, ret);
> +		dev_info(adev->dev,
> +			"failed to send message %x ret is %d\n", msg,ret);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> index 47b34c6ca924..88a5641465dc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> @@ -87,7 +87,7 @@ static int smu10_send_msg_to_smc(struct pp_hwmgr
> *hwmgr, uint16_t msg)
>  	smu10_send_msg_to_smc_without_waiting(hwmgr, msg);
>=20
>  	if (smu10_wait_for_response(hwmgr) =3D=3D 0)
> -		printk("Failed to send Message %x.\n", msg);
> +		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
>=20
>  	return 0;
>  }
> @@ -108,7 +108,7 @@ static int
> smu10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
>=20
>=20
>  	if (smu10_wait_for_response(hwmgr) =3D=3D 0)
> -		printk("Failed to send Message %x.\n", msg);
> +		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> index aae25243eb10..5a010cd38303 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> @@ -165,6 +165,7 @@ bool smu7_is_smc_ram_running(struct pp_hwmgr
> *hwmgr)
>=20
>  int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
>  {
> +	struct amdgpu_device *adev =3D hwmgr->adev;
>  	int ret;
>=20
>  	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0);
> @@ -172,9 +173,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr
> *hwmgr, uint16_t msg)
>  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
>=20
>  	if (ret =3D=3D 0xFE)
> -		pr_debug("last message was not supported\n");
> +		dev_dbg(adev->dev, "last message was not supported\n");
>  	else if (ret !=3D 1)
> -		pr_info("\n last message was failed ret is %d\n", ret);
> +		dev_info(adev->dev,
> +			"\nlast message was failed ret is %d\n", ret);
>=20
>  	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
>  	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, msg);
> @@ -184,9 +186,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr
> *hwmgr, uint16_t msg)
>  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
>=20
>  	if (ret =3D=3D 0xFE)
> -		pr_debug("message %x was not supported\n", msg);
> +		dev_dbg(adev->dev, "message %x was not supported\n",
> msg);
>  	else if (ret !=3D 1)
> -		pr_info("\n failed to send message %x ret is %d \n",  msg,
> ret);
> +		dev_dbg(adev->dev,
> +			"failed to send message %x ret is %d \n",  msg, ret);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> index 23e5de3c4ec1..8c9bf4940dc1 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> @@ -126,7 +126,7 @@ int smu9_send_msg_to_smc(struct pp_hwmgr
> *hwmgr, uint16_t msg)
>=20
>  	ret =3D smu9_wait_for_response(hwmgr);
>  	if (ret !=3D 1)
> -		pr_err("Failed to send message: 0x%x, ret value: 0x%x\n",
> msg, ret);
> +		dev_err(adev->dev, "Failed to send message: 0x%x, ret
> value: 0x%x\n", msg, ret);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> index 741fbc87467f..9ad26c285ecd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> @@ -115,7 +115,7 @@ static int vega20_send_msg_to_smc(struct
> pp_hwmgr *hwmgr, uint16_t msg)
>=20
>  	ret =3D vega20_wait_for_response(hwmgr);
>  	if (ret !=3D PPSMC_Result_OK)
> -		pr_err("Failed to send message 0x%x, response 0x%x\n",
> msg, ret);
> +		dev_err(adev->dev, "Failed to send message 0x%x, response
> 0x%x\n", msg, ret);
>=20
>  	return (ret =3D=3D PPSMC_Result_OK) ? 0 : -EIO;
>  }
> @@ -143,7 +143,7 @@ static int
> vega20_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
>=20
>  	ret =3D vega20_wait_for_response(hwmgr);
>  	if (ret !=3D PPSMC_Result_OK)
> -		pr_err("Failed to send message 0x%x, response 0x%x\n",
> msg, ret);
> +		dev_err(adev->dev, "Failed to send message 0x%x, response
> 0x%x\n", msg, ret);
>=20
>  	return (ret =3D=3D PPSMC_Result_OK) ? 0 : -EIO;
>  }
> --
> 2.17.1
