Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED79C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 07:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F9810E8DC;
	Tue,  8 Mar 2022 07:00:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D2610E8DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 07:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgNcVc/XX8cbioyzi2KNudLQkh8eFxEMc0MwZk1UVMOGE5WIIKGsHYOHV9Czv/HDzq82Mql3D5Jbd4uhnHk5DhkfFXfW/R2Dv0WEoGNE/JudFKbOsbinpFsd0tj0VbirhOhJSFigSv946QMMHu1TneNRt9/bAfibFAZhMmOGKF9MDTrCWlslTUgVlBy9jy72vEyYSgZqC3/hQ0sKwoePHTI2BCPnR4/ZHBttv1yEzVS+BarETgjx1QQTcjAt8HKlFY4HQoTu46mSUlhJBVtK/FHeCZFG9S1F5kfPKk6A8KPTiqgCkpfZDoWWP583ifercmXjXhcNRjbQKDuDWsYwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FGZaW9F7P9DRIU01u3+/hMTFPovCy7HprtLypqGzeU=;
 b=azVJ83oyzJUu/ndmjjG9Wgl6ygQYnUmvYk+0OiCPqpD+z22BP7KSRaON98q1eMcIqBOhEcVWskiPCybIr1COp84AiLvlIepLoqLfs5lDC/iUcycr2rQQSuBHNytMK1Wijfr0z4yWc2gn///qGORtFGW+tTD8qZcvtll0iz4aT4E/fS6OI1hfd5ee9CzK/ddx+09jkshtkk7bdrRB1MO4K6Z2JXVYrsouLSrBUoMSrXMVCvtZkvLh1SAO/xqdNAFWwaHyoPodDpNTmOb0/YuUM6abYJoqQAD+mlhCHDktcOlVpmEwpQOzohpuUGOI77hCFYe6FbHCOAvX6V5DRR6R+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FGZaW9F7P9DRIU01u3+/hMTFPovCy7HprtLypqGzeU=;
 b=cdlzdvfLmLydAvJfixEw+fuWIdJ00bM+OBJP9tKmNvyt/0PnG35dojUA+rLKUuxDi5UzPm2oG1aYbUg1v5CdPphl/FcEQqo3M1B2OUE2HHS0klT2F5cizXTjqhaM6ucA4v1lOW3aQRNSTNr495flNMpDqczWZHYLNyM+8P49tp4=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 07:00:42 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:00:42 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: Move common initialization operations of
 each ras block to one function
Thread-Topic: [PATCH V2] drm/amdgpu: Move common initialization operations of
 each ras block to one function
Thread-Index: AQHYMf9uRgt/5wPrKkKAT9Ekr/frmay1B/5Q
Date: Tue, 8 Mar 2022 07:00:41 +0000
Message-ID: <DM5PR12MB1770D6CDA5C6DAFDA7A9C400B0099@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220307084259.1752140-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220307084259.1752140-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-08T06:30:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f7fcb85b-ea39-4ace-a2ca-58fe6905d873;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-08T07:00:38Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9eb43c8b-e5e8-4a69-b972-369f6112bf1f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b85537b-45db-4d8e-c92e-08da00d15c1e
x-ms-traffictypediagnostic: MW3PR12MB4395:EE_
x-microsoft-antispam-prvs: <MW3PR12MB4395EDA2511B375DACAD48FAB0099@MW3PR12MB4395.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78A1WMP9yfaSDJZZdPHbtTDyw5cxbOkdcFHzt7ulQbvqRD4IyzwGJps1Bk/eij6MjilH0kCoy9WE8emN6AtygGcdf3FP9Ak+07oj/hBFg9XoxavpOMkIGUK+WPaLS9F2HSUbuuhC32a/4V8fJ+KbfqmdL3WBjisydVPL+37stptWlOlc4UQ0ZYwYMEjPSxvznOrfH9XsKy0hRC4O12u4jPpUShfs6Pm+CwDRLj878nhf1pwBGZdCkgxoTNNXlb2tSp5k6kockB3hjk41qThQVzKLr6C2pMkNMu/iPs0/oUg0dznm1YxoXKtOwGpV1IZOOZkX9+oWcJnZkqDvxqd/BPHNTDtJXtLj99DIHU1+b70GBuLk3LcdrmNX1Ka344R+8v8lWbp2ZSfOMBDQYUEaviniiUehx9Bdu7ji7ef4cwKcjnnw8Z9Dyd12+r1WQILDxR6FOTxTW/0sYg984soWMDdeRaBchf0N9wU9QffsTpzTxpVNYiXfYCFpAg4qGmqwEijTRCAT9yF1VHMMJSYQ3kiTeQ9kWTpkz9hV/82qkSjuwW4M51b+lxSuxC56MovDvB2h32dwSFgA/PnXRElO/xEFrJLU3FqpruWiFB/t9T0hNvHE0yRKGxbLLxg+gHghFzbx5prCQm4o7VyMao9bI1gAXG4upD3c4ODDRDlQjxmHH9FBump+rdqSKacApXyFBYKmE3D19S322pqe4fwsbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(122000001)(71200400001)(5660300002)(508600001)(30864003)(55016003)(8936002)(53546011)(52536014)(38100700002)(6506007)(83380400001)(7696005)(110136005)(54906003)(33656002)(8676002)(38070700005)(26005)(86362001)(4326008)(2906002)(186003)(66476007)(66946007)(9686003)(76116006)(64756008)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NzkLZuB4w/aO3CreT4q2dZrugH5a+yOZ0lYdV/cjH9ewReJ1OOAK6pWq5SKe?=
 =?us-ascii?Q?UXg3IL/zecDqhr4+48asky2tbfG/46zbm6BiH5OazKVJl0Pf+2w4RNtLevJQ?=
 =?us-ascii?Q?IaN0Qlj8rAfz+Kep/YKn+m/0HaU9OrIKqmX5csTXs0QtMYJZXf2LiYwapg1j?=
 =?us-ascii?Q?X23lkhAiP+4k//Wcd+v7MRyAWEkEWjaSTYAUSdA/PlDJvQWEGhomfdd4zy95?=
 =?us-ascii?Q?TmPp9nMhBwTwrs5JOAzB+R8PJZH8YrFfgvbPB3YagbLlx8wRT7bB11RdVfb+?=
 =?us-ascii?Q?8V9EIzPmoAXi+KpEgy94aqdB0kZZPI2N/U2MbvnsV686kUPrrlgSooIql9hX?=
 =?us-ascii?Q?rUKv7TyKu1WyEO6p1TH8Wjv+qR67wAI7OZ7rxj5IP/i3P68B37lDb9eegt0A?=
 =?us-ascii?Q?h/PEd/tFSzC7D0VZ8Yz01AJv8/hpoOFqIqJT0eM+wi5UgNrZpbQUt5dHyZ5N?=
 =?us-ascii?Q?qsjf1Nn4316YFB+rBpwC/YM9LWXh4i9VoMzVgZG4yvGBVr7ztiqfUrYGlXo0?=
 =?us-ascii?Q?JR01mbg2A4O+fP7WtBXc5QelDl25pfZ6pE07W7q3BGd48PGhOalfbIEJwgiG?=
 =?us-ascii?Q?TOvoPKZgaKYDAarQKToNcqa/ViV/6cBTmwe/xW6J2R1Jozz/TF4SjkGj4xJB?=
 =?us-ascii?Q?3dGd0Og//3xwBTF+l6eo1s6nc+LlsDd9z7gNyYaXOrBuismGgXN4Bhtgc9wZ?=
 =?us-ascii?Q?hM96tyweA8JGoJduTGmIjEA1V+vLFMCuAdy+SDN/75dBQ1Wn2DTzRpViqqFM?=
 =?us-ascii?Q?9bZFjGLZXI30V507EXuZrPtS343I8oAm0MsCFH41SRwhzDxiIes2JKNzYD+B?=
 =?us-ascii?Q?3o3dULiJ4qvr6g1+Ry+hSrP3WLa2fg6I+ir0HRiNzYlaoJdq0HTPwWjNwn1+?=
 =?us-ascii?Q?S30VRNNGYRIGDoTuKLq87vWI8jj46xOvGB1tIR1KprMV6GoOZ2eE4wi0bWup?=
 =?us-ascii?Q?8C2MyOro5jyEiWIwZBxzAMFXdg+ENp66GCz/Sn5nTn/32AoqziL7D3yEqV4K?=
 =?us-ascii?Q?kkupqAjJjeebm4hHrcpka8k9ZO0wvVoHcqb64c//MDndk3qsBPXX/fhg/V1W?=
 =?us-ascii?Q?ALBBjeLOxet/kURyjL/rCD93fwJMaqT/7OpmwkdfuRWxoXybXdtueSgKSB8i?=
 =?us-ascii?Q?awmec2iMmFt7fHSadjylR6K2jwHJVxq/L1nYWuUx9rfi1wy3tL+MVjcDCFtZ?=
 =?us-ascii?Q?aX47NXLTHRb1KtcXrAXHyadP3WQwUWwCoFUpwluWCqkFD442rkEUk15seek9?=
 =?us-ascii?Q?UWpFF13VYUc/oviBDwScl2HOxqruzgdLqR3MvdEOCIYgonFUe5WN5AQdV+Ry?=
 =?us-ascii?Q?RcT34dE+zC/RwbRlJNytECpOvNpFe19vcO7KK3Da4A5rsEwsDU7a5Y0y2whq?=
 =?us-ascii?Q?ra7JZLKwXKrzjAc2tXyqmCf/WQNplWFInqmtjFoeTCAb4WfJyNyY3cePQ1Jy?=
 =?us-ascii?Q?QmpY/ABjUU6Zo/O5ZrNZqN8jk8y31JXp4GFdUCxl7ybMIoiKHiNVSW6nmlVL?=
 =?us-ascii?Q?uN0vj3N9YAVWYBAinin0lJBVV9qW/uX/z8Ui/8nfZeF95yHkn1qZ8fxA28VP?=
 =?us-ascii?Q?CbrLIvGJV8bDgty4epg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b85537b-45db-4d8e-c92e-08da00d15c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 07:00:41.8314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpTHXgF4e5bSgqWRlZC+SXuWJTtIpzfawqVf3j0gYBl23H6g6frfpJ2NMLfx/Lh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, March 7, 2022 4:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2] drm/amdgpu: Move common initialization operations of
> each ras block to one function
>=20
> Define amdgpu_ras_sw_init function to initialize all ras blocks.
>=20
> V2: Modify error debugging information.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 143 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  21 ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  16 ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  28 ----
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c      |   6 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  17 ---
>  9 files changed, 148 insertions(+), 92 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6113ddc765a7..0c83eb69dad5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2402,6 +2402,12 @@ static int amdgpu_device_ip_init(struct
> amdgpu_device *adev)
>  		}
>  	}
>=20
> +	r =3D amdgpu_ras_sw_init(adev);
> +	if (r) {
> +		DRM_ERROR("amdgpu_ras_sw_init failed (%d).\n", r);
> +		goto init_failed;
> +	}
> +
>  	if (amdgpu_sriov_vf(adev))
>  		amdgpu_virt_init_data_exchange(adev);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ab75e189bc0b..544241f357b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -440,8 +440,6 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device
> *adev)  {
>  	if (!adev->gmc.xgmi.connected_to_cpu) {
>  		adev->gmc.xgmi.ras =3D &xgmi_ras;
> -		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras-
> >ras_block);
> -		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras-
> >ras_block.ras_comm;
>  	}
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d3875618ebf5..89075ab9e82e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2299,8 +2299,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  	case CHIP_ALDEBARAN:
>  		if (!adev->gmc.xgmi.connected_to_cpu) {
>  			adev->nbio.ras =3D &nbio_v7_4_ras;
> -			amdgpu_ras_register_ras_block(adev, &adev-
> >nbio.ras->ras_block);
> -			adev->nbio.ras_if =3D &adev->nbio.ras-
> >ras_block.ras_comm;
>  		}
>  		break;
>  	default:
> @@ -2533,6 +2531,147 @@ void amdgpu_ras_suspend(struct amdgpu_device
> *adev)
>  		amdgpu_ras_disable_all_features(adev, 1);  }
>=20
> +int amdgpu_ras_sw_init(struct amdgpu_device *adev) {
> +	int err =3D 0;
> +
> +	if (!amdgpu_ras_asic_supported(adev))
> +		return 0;
> +
> +	if (adev->nbio.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev->nbio.ras-
> >ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register nbio ras
> block!\n");
> +			return err;
> +		}
> +		adev->nbio.ras_if =3D &adev->nbio.ras->ras_block.ras_comm;
> +	}
> +
> +	if (adev->gmc.xgmi.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev-
> >gmc.xgmi.ras->ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register xgmi ras
> block!\n");
> +			return err;
> +		}
> +		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras-
> >ras_block.ras_comm;
> +	}
> +
> +	if (adev->gfx.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras-
> >ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register gfx ras block!\n");
> +			return err;
> +		}
> +
> +		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
> +		adev->gfx.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__GFX;
> +		adev->gfx.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +		adev->gfx.ras_if =3D &adev->gfx.ras->ras_block.ras_comm;
> +
> +		/* If not define special ras_late_init function, use gfx default
> ras_late_init */
> +		if (!adev->gfx.ras->ras_block.ras_late_init)
> +			adev->gfx.ras->ras_block.ras_late_init =3D
> amdgpu_gfx_ras_late_init;
> +
> +		/* If not defined special ras_cb function, use default ras_cb */
> +		if (!adev->gfx.ras->ras_block.ras_cb)
> +			adev->gfx.ras->ras_block.ras_cb =3D
> amdgpu_gfx_process_ras_data_cb;
> +	}
> +
> +	if (adev->umc.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev->umc.ras-
> >ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register umc ras
> block!\n");
> +			return err;
> +		}
> +
> +		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
> +		adev->umc.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__UMC;
> +		adev->umc.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
> +
> +		/* If don't define special ras_late_init function, use default
> ras_late_init */
> +		if (!adev->umc.ras->ras_block.ras_late_init)
> +			adev->umc.ras->ras_block.ras_late_init =3D
> amdgpu_umc_ras_late_init;
> +
> +		/* If not defined special ras_cb function, use default ras_cb */
> +		if (!adev->umc.ras->ras_block.ras_cb)
> +			adev->umc.ras->ras_block.ras_cb =3D
> amdgpu_umc_process_ras_data_cb;
> +	}
> +
> +	if (adev->mmhub.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev-
> >mmhub.ras->ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register mmhub ras
> block!\n");
> +			return err;
> +		}
> +
> +		strcpy(adev->mmhub.ras->ras_block.ras_comm.name,
> "mmhub");
> +		adev->mmhub.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__MMHUB;
> +		adev->mmhub.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +		adev->mmhub.ras_if =3D &adev->mmhub.ras-
> >ras_block.ras_comm;
> +	}
> +
> +	if (adev->hdp.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev->hdp.ras-
> >ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register hdp ras
> block!\n");
> +			return err;
> +		}
> +
> +		adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
> +	}
> +
> +	if (adev->mca.mp0.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev-
> >mca.mp0.ras->ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register mca mp0 ras
> block!\n");
> +			return err;
> +		}
> +		adev->mca.mp0.ras_if =3D &adev->mca.mp0.ras-
> >ras_block.ras_comm;
> +	}
> +
> +	if (adev->mca.mp1.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev-
> >mca.mp1.ras->ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register mca mp1 ras
> block!\n");
> +			return err;
> +		}
> +		adev->mca.mp1.ras_if =3D &adev->mca.mp1.ras-
> >ras_block.ras_comm;
> +	}
> +
> +	if (adev->mca.mpio.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev-
> >mca.mpio.ras->ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register mca mpio ras
> block!\n");
> +			return err;
> +		}
> +		adev->mca.mpio.ras_if =3D &adev->mca.mpio.ras-
> >ras_block.ras_comm;
> +	}
> +
> +	if (adev->sdma.ras) {
> +		err =3D amdgpu_ras_register_ras_block(adev, &adev->sdma.ras-
> >ras_block);
> +		if (err) {
> +			dev_err(adev->dev, "Failed to register sdma ras
[Tao]: do we need to unregister ras_block and deinitialize ras_if for previ=
ous RAS blocks?

> block!\n");
> +			return err;
> +		}
> +
> +		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
> +		adev->sdma.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__SDMA;
> +		adev->sdma.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +		adev->sdma.ras_if =3D &adev->sdma.ras->ras_block.ras_comm;
> +
> +		/* If don't define special ras_late_init function, use default
> ras_late_init */
> +		if (!adev->sdma.ras->ras_block.ras_late_init)
> +			adev->sdma.ras->ras_block.ras_late_init =3D
> amdgpu_sdma_ras_late_init;
> +
> +		/* If not defined special ras_cb function, use default ras_cb */
> +		if (!adev->sdma.ras->ras_block.ras_cb)
> +			adev->sdma.ras->ras_block.ras_cb =3D
> amdgpu_sdma_process_ras_data_cb;
> +	}
> +
> +	return 0;
> +}
> +
>  int amdgpu_ras_late_init(struct amdgpu_device *adev)  {
>  	struct amdgpu_ras_block_list *node, *tmp; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7cddaad90d6d..fc5ed6c47443 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum
> amdgpu_ras_error_type error) {
>=20
>  /* called in ip_init and ip_fini */
>  int amdgpu_ras_init(struct amdgpu_device *adev);
> +int amdgpu_ras_sw_init(struct amdgpu_device *adev);
>  int amdgpu_ras_late_init(struct amdgpu_device *adev);  int
> amdgpu_ras_fini(struct amdgpu_device *adev);  int amdgpu_ras_pre_fini(str=
uct
> amdgpu_device *adev); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 8def7f630d4c..e26fc2ae98e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2188,27 +2188,6 @@ static int gfx_v9_0_gpu_early_init(struct
> amdgpu_device *adev)
>  		break;
>  	}
>=20
> -	if (adev->gfx.ras) {
> -		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras-
> >ras_block);
> -		if (err) {
> -			DRM_ERROR("Failed to register gfx ras block!\n");
> -			return err;
> -		}
> -
> -		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
> -		adev->gfx.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__GFX;
> -		adev->gfx.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> -		adev->gfx.ras_if =3D &adev->gfx.ras->ras_block.ras_comm;
> -
> -		/* If not define special ras_late_init function, use gfx default
> ras_late_init */
> -		if (!adev->gfx.ras->ras_block.ras_late_init)
> -			adev->gfx.ras->ras_block.ras_late_init =3D
> amdgpu_gfx_ras_late_init;
> -
> -		/* If not defined special ras_cb function, use default ras_cb */
> -		if (!adev->gfx.ras->ras_block.ras_cb)
> -			adev->gfx.ras->ras_block.ras_cb =3D
> amdgpu_gfx_process_ras_data_cb;
> -	}
> -
>  	adev->gfx.config.gb_addr_config =3D gb_addr_config;
>=20
>  	adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 << diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d9353bb99314..5046be86702f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -669,22 +669,6 @@ static void gmc_v10_0_set_umc_funcs(struct
> amdgpu_device *adev)
>  	default:
>  		break;
>  	}
> -	if (adev->umc.ras) {
> -		amdgpu_ras_register_ras_block(adev, &adev->umc.ras-
> >ras_block);
> -
> -		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
> -		adev->umc.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__UMC;
> -		adev->umc.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> -		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
> -
> -		/* If don't define special ras_late_init function, use default
> ras_late_init */
> -		if (!adev->umc.ras->ras_block.ras_late_init)
> -				adev->umc.ras->ras_block.ras_late_init =3D
> amdgpu_umc_ras_late_init;
> -
> -		/* If not defined special ras_cb function, use default ras_cb */
> -		if (!adev->umc.ras->ras_block.ras_cb)
> -			adev->umc.ras->ras_block.ras_cb =3D
> amdgpu_umc_process_ras_data_cb;
> -	}
>  }
>=20
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4c3483fbe613..8f6aefb9be08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1228,23 +1228,6 @@ static void gmc_v9_0_set_umc_funcs(struct
> amdgpu_device *adev)
>  	default:
>  		break;
>  	}
> -
> -	if (adev->umc.ras) {
> -		amdgpu_ras_register_ras_block(adev, &adev->umc.ras-
> >ras_block);
> -
> -		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
> -		adev->umc.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__UMC;
> -		adev->umc.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> -		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
> -
> -		/* If don't define special ras_late_init function, use default
> ras_late_init */
> -		if (!adev->umc.ras->ras_block.ras_late_init)
> -				adev->umc.ras->ras_block.ras_late_init =3D
> amdgpu_umc_ras_late_init;
> -
> -		/* If not defined special ras_cb function, use default ras_cb */
> -		if (!adev->umc.ras->ras_block.ras_cb)
> -			adev->umc.ras->ras_block.ras_cb =3D
> amdgpu_umc_process_ras_data_cb;
> -	}
>  }
>=20
>  static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev) @@ -
> 1278,15 +1261,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct
> amdgpu_device *adev)
>  		/* mmhub ras is not available */
>  		break;
>  	}
> -
> -	if (adev->mmhub.ras) {
> -		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras-
> >ras_block);
> -
> -		strcpy(adev->mmhub.ras->ras_block.ras_comm.name,
> "mmhub");
> -		adev->mmhub.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__MMHUB;
> -		adev->mmhub.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> -		adev->mmhub.ras_if =3D &adev->mmhub.ras-
> >ras_block.ras_comm;
> -	}
>  }
>=20
>  static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev) @@ -
> 1297,8 +1271,6 @@ static void gmc_v9_0_set_gfxhub_funcs(struct
> amdgpu_device *adev)  static void gmc_v9_0_set_hdp_ras_funcs(struct
> amdgpu_device *adev)  {
>  	adev->hdp.ras =3D &hdp_v4_0_ras;
> -	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
> -	adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
>  }
>=20
>  static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev) diff --gi=
t
> a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index d4bd7d1d2649..3d2b974f6e0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -129,12 +129,6 @@ static void mca_v3_0_init(struct amdgpu_device *adev=
)
>  	mca->mp0.ras =3D &mca_v3_0_mp0_ras;
>  	mca->mp1.ras =3D &mca_v3_0_mp1_ras;
>  	mca->mpio.ras =3D &mca_v3_0_mpio_ras;
> -	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
> -	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
> -	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
> -	mca->mp0.ras_if =3D &mca->mp0.ras->ras_block.ras_comm;
> -	mca->mp1.ras_if =3D &mca->mp1.ras->ras_block.ras_comm;
> -	mca->mpio.ras_if =3D &mca->mpio.ras->ras_block.ras_comm;
>  }
>=20
>  const struct amdgpu_mca_funcs mca_v3_0_funcs =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 01b385568c14..fe61fcd22f18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2809,23 +2809,6 @@ static void sdma_v4_0_set_ras_funcs(struct
> amdgpu_device *adev)
>  	default:
>  		break;
>  	}
> -
> -	if (adev->sdma.ras) {
> -		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras-
> >ras_block);
> -
> -		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
> -		adev->sdma.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__SDMA;
> -		adev->sdma.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> -		adev->sdma.ras_if =3D &adev->sdma.ras->ras_block.ras_comm;
> -
> -		/* If don't define special ras_late_init function, use default
> ras_late_init */
> -		if (!adev->sdma.ras->ras_block.ras_late_init)
> -			adev->sdma.ras->ras_block.ras_late_init =3D
> amdgpu_sdma_ras_late_init;
> -
> -		/* If not defined special ras_cb function, use default ras_cb */
> -		if (!adev->sdma.ras->ras_block.ras_cb)
> -			adev->sdma.ras->ras_block.ras_cb =3D
> amdgpu_sdma_process_ras_data_cb;
> -	}
>  }
>=20
>  const struct amdgpu_ip_block_version sdma_v4_0_ip_block =3D {
> --
> 2.25.1
