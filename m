Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E16C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 20:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A188A6128C
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 20:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A188A6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9676E04E;
	Thu, 18 Nov 2021 20:36:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C826E04E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 20:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXrlVFsYJa8o8pdAkMAZXSRjw1zqwFdeEwETWolZq5YW8XaYqk9s1qg30pHaMNmLzpo2kouCgolkxjkADLHcpTKFCF8OstD+zG0TYjheKuZwd1av6vLgZk10OKRAAG6XhSksGP7UgDm2GhX/lzWaFPtkBZ8+pDksF64AG6e2LRVQrbTbY+F11i4CvNjHB0XCruGP0wM2MPS6chGnyXTBa2gh2QRRi9bOp7Lyw5VuRdyN5xwP47XmVN/BAlvv89NDolngOExiHdX/eWbkd1bR6E6YhUS8/aoTw4sYm/Au8BaNL9kzrJXUr5E0QssckkxNhfdBMFA87TKSI4pme4HpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CennCL6/T/ZFIrZqewue92jZ35U9EGV9anhuO9BJuHA=;
 b=FJK7PEiZQuQzUQvtUnDHyVczOE2Lhg16YkqXLwpQlfX2VKK6nBeZ32oCr/Df/Pmrn1W0DHZaqV1voG5WMKFFS1CNqFvxPelc9x9cYmjXqJk3tiBM4/S6APxUA0Lyeo0neECezFloOEeMBgJnvAc+V8vLaPtZCD91KAnGUEEw27eyaz1LaX2adRxTQnKejzWACrnUzvDr+XbLnYV7zhN7nCY4OjOV1nd+3iiwnUkrXz2NkTeJTCeGLb3fVGwYA6lTYQxCgp7ixgiWNjYiZNOryTcPJirh7902uSr9vItygOELVcl8lblo8Eq+7lx66ZPzutN5iC1QFxUyI/m0IAF01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CennCL6/T/ZFIrZqewue92jZ35U9EGV9anhuO9BJuHA=;
 b=31BmgAMqgsjQU0mIrzaT6IivOy8S20ZjLizN4YXWACOtRCuQiQ6m8RBUSp8Mvz+zXZWuQd4orHDcBqVjhns+kysgjoIw7nhelQWPH1731UgkNRcwXXuwM1NKXIGSYXtwCYHyCixjb6KZ+haMz41SaAK+4/9E2Zq23UHo2Y5uKtw=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB3532.namprd12.prod.outlook.com (2603:10b6:5:182::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 20:36:40 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::95ab:4ece:7f8e:6e6f]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::95ab:4ece:7f8e:6e6f%2]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 20:36:40 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Remove unused entries in table
Thread-Topic: [PATCH] drm/amdkfd: Remove unused entries in table
Thread-Index: AQHX3LmL/5QYpYuiPU2iGU7dLKau6KwJvZEw
Date: Thu, 18 Nov 2021 20:36:40 +0000
Message-ID: <DM6PR12MB306741A9F918CB65AC6170F38A9B9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20211118201839.22284-1-Amber.Lin@amd.com>
In-Reply-To: <20211118201839.22284-1-Amber.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-18T20:36:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=52536af0-c411-4329-87e4-eaf7eabb797c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-18T20:36:38Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 12fcbad2-caea-4850-811c-789f0a29b6ec
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9802d37-bcf3-461a-aea9-08d9aad3201e
x-ms-traffictypediagnostic: DM6PR12MB3532:
x-microsoft-antispam-prvs: <DM6PR12MB353273F90948E219FB22B6C38A9B9@DM6PR12MB3532.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ergj9nobfmDYLrC6Wq0PghCibr/GUMvWHjWN6+wkiktuM88K9PMlydGM/b8Xku/CVZOllow/icCbPugWeNdMXrlnikqLPPVuRCeDK4P+R27dQ75GpSkBTXFS1yK08cB4SfIpLwilrQOBC4JUy7BECUohH1WavPntjfl9mOj3Vc2re0Ui/PufJ3yCg62IRSMwM5h44jsYaflyHbICcKSddqggqDKZZwkQHMedHJRE/EV4pJZhAUt/gbtz2YTh+GuXo/qb7epex7scYga7lM49MRacXGYOVrQ2FallPDww+NIFMnLBl+2vR+5jKEsJj2brz5d26W2Rt/vpwsoCV+NxAWVTeWMnVMjCEW26t5Oqqy33mZH0iOgd/0YFUSZY5FGP3bdA1gSURvQB3IVemXWS1NUwUjE0QXGSnImuc7IoLQ76IM48Xor1+MKoav04Tn56wTRsgDeuipCUa986/vmMTGYDJe8J/LF39zmSkjhOw6eLHMXfCfYAxsHfWLpKjah9PbmArfHSMlwiQy6AzNRQICIxiBgg9VGD1WUmRbSUyaHdCbRwgIAZST2yVaQt3cYcf38dz6Z/XOiYRElDVG1c8TMqT32XQj8sopWEmbpGPlSDkv7vel0qxTVl2PH3bSceX93OmXk3oKG4OX5iftYuYbULo+LwpdA1hFRBm0+KyLDQ7UjsstUyMVK1bKBEpTGV77v12vVk1g3L4t6U00/7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(8676002)(33656002)(26005)(6506007)(55016002)(122000001)(186003)(38100700002)(110136005)(2906002)(8936002)(5660300002)(83380400001)(86362001)(4326008)(316002)(76116006)(38070700005)(66446008)(66476007)(64756008)(66556008)(7696005)(71200400001)(66946007)(508600001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1dHOaSbzRawsPTg6ZyGwFG/+O4i7h2He62T8prmA6W6g3Be7LHx2XTs0YS4z?=
 =?us-ascii?Q?L3zRWolT/A/cl2ui51atrZmaSXcleD4NUFZdxFd9LiMXUf7eCA0uys1FnNYw?=
 =?us-ascii?Q?k2Vwe09GlpQDXrR9yfOW7je7Sp2Y7PrvI/QZQuXFyKh8vcuPkD4HKpUcQURz?=
 =?us-ascii?Q?KwbD/nbVTYXqfFOc52aOHJ+6nQRILh/UfrgiMeF0CrITYBFWfvXqxfG5XTff?=
 =?us-ascii?Q?s/B6fUnwbNBoeF4wb9YiKZ7tw8zNess+9XyT9MYns7t1FoDBerQJmDXkGmye?=
 =?us-ascii?Q?Dx57WY9Hu8WpkZ3tLra39v47PWXTvQ3MXbySEQtUmRPeoxi5pGP+4xIQt0aZ?=
 =?us-ascii?Q?EfMH3UwMiLW11lrggtjn4cT/LmzvXRd2hRhp6u/o60mupWrXJVsh9YMOXlav?=
 =?us-ascii?Q?YBavlJNm3rTnyeyTfi5ylAwasqmV97lcPk34pGDCQQHLBFWKF6as+BwApLxJ?=
 =?us-ascii?Q?NsGIUdXsoRldg8oULCLKHGBpjMmH/NvOljBovhBz/kpvncr6nmZ5PhR8F7Xc?=
 =?us-ascii?Q?JPt5fIYQbVNcEC8cDUithclOqOGNBS4RD8e+O31lPxQZ2MXWmrB4RK1rtlPm?=
 =?us-ascii?Q?ucjBAH2FF3xA7LYZJlzqfANLrcXZI9p6pWw1LMGMzTr/VndpkXG2TXShP6d1?=
 =?us-ascii?Q?GwV3x45DkqmjSNpIlYx/qhVlqaKiSi2JSmZOzJ98HSMK4sNzg5ufMpuX9GZp?=
 =?us-ascii?Q?HHXnmh97/xviXN1Pd2c01B9A4bAeKTNTPod6iUWGsedtnvmqnlanROjYl0yo?=
 =?us-ascii?Q?EYWawhU3nndvuB50C5QKKGQiGgED7HPAmWzDBrdACtlAEKCavFOncQ6xcX4I?=
 =?us-ascii?Q?YtuKHgKXgjgTPQYpm5jVEnpV8xwptRnDGAFyswss8rUsj66YsNoHYUwll+xQ?=
 =?us-ascii?Q?jwkLqAeYWfGWr1JHVWznzGcHL55SF/W4V7PxsU1qPzDe9ixVsnvRHWiCUj7m?=
 =?us-ascii?Q?SL4vb7Hx1KTDBGJMBZfkGsb9ZgB27QrzITaWmEFf8/VavMOTnN70BZb/ww3K?=
 =?us-ascii?Q?3B+lBvOw30DAtQWblRJi2cOqwkvae8fSG+YEc3WvrTXUbgWAhI/uL1VCOqxv?=
 =?us-ascii?Q?nN1xI8WEEfpzectvW6n8TmLtY85drY/j+OLjbIOMbAITfQFg/af8PxP4Fmym?=
 =?us-ascii?Q?hhaFmGtIG5Dx3NY2HOGf1sbFJcO4ZTeSEG7eBUxI7DRvLmZSA9iDfwnMCnSY?=
 =?us-ascii?Q?8zXdxVPmRgbVw4haJgApCv70kfY2U5AjLU4BrMkLSn/c758AKtxqCIcxCofe?=
 =?us-ascii?Q?O5EWNVQS4ZrP86oD9Y4QZAEmTUt5FAPBpe7lLv6a4xd56pK6jQluJnmPXkb2?=
 =?us-ascii?Q?LU3JrxIsdM1peMYlow7ILHznA2tm4/QK+lh3IbHWyVHZ4kY299QDbdphxKwu?=
 =?us-ascii?Q?o3E8QYDxPgrsM3a4MfFme1QgOMdKTKBI4LQ8Ulgp+E5fHhtTlqlIXViU88qa?=
 =?us-ascii?Q?pBhlVje2mA3Uw5ddHdPs+1q26FFP43DsQx+lyS+knBlTf9ebvyy4CXTQLqJh?=
 =?us-ascii?Q?v6wQkFsltm2g52HwJ/85ZgAabiu4YIMmcGXF/mCnzxrIO2YQLG8ajqOuJ4G2?=
 =?us-ascii?Q?mPhkl7ezLjlu/jigFmusJyyHWkOG6RKbYMwrV5SxC/wGdT8w22OXt/adM+AC?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9802d37-bcf3-461a-aea9-08d9aad3201e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 20:36:40.2139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXZUUCa2/CDxOO5BSTzkNsMcSuJvD5yjGV+d5+AVrr5HGMm/XAnf+/qedG6BCnz+NdUoLMlYmef8MHT/zOf+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3532
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Graham Sider <Graham.Sider@amd.com>

> Remove unused entries in kfd_device_info table: num_xgmi_sdma_engines
> and num_sdma_queues_per_engine. They are calculated in
> kfd_get_num_sdma_engines and kfd_get_num_xgmi_sdma_engines
> instead.
>=20
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 58 -------------------------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  2 -
>  2 files changed, 60 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 3fea47e37c17..e1294fba0c26 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -68,8 +68,6 @@ static const struct kfd_device_info kaveri_device_info =
=3D
> {
>         .supports_cwsr =3D false,
>         .needs_iommu_device =3D true,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -87,8 +85,6 @@ static const struct kfd_device_info carrizo_device_info=
 =3D
> {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D true,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -105,8 +101,6 @@ static const struct kfd_device_info raven_device_info
> =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D true,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 1,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };  #endif @@ -126,8 +120,6 @=
@
> static const struct kfd_device_info hawaii_device_info =3D {
>         .supports_cwsr =3D false,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };  #endif @@ -145,8 +137,6 @=
@
> static const struct kfd_device_info tonga_device_info =3D {
>         .supports_cwsr =3D false,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -163,8 +153,6 @@ static const struct kfd_device_info fiji_device_info =
=3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -181,8 +169,6 @@ static const struct kfd_device_info fiji_vf_device_in=
fo
> =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -200,8 +186,6 @@ static const struct kfd_device_info
> polaris10_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -218,8 +202,6 @@ static const struct kfd_device_info
> polaris10_vf_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -236,8 +218,6 @@ static const struct kfd_device_info
> polaris11_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -254,8 +234,6 @@ static const struct kfd_device_info
> polaris12_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -272,8 +250,6 @@ static const struct kfd_device_info
> vegam_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -290,8 +266,6 @@ static const struct kfd_device_info
> vega10_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -308,8 +282,6 @@ static const struct kfd_device_info
> vega10_vf_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -326,8 +298,6 @@ static const struct kfd_device_info
> vega12_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -344,8 +314,6 @@ static const struct kfd_device_info
> vega20_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -362,8 +330,6 @@ static const struct kfd_device_info
> arcturus_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 6,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -380,8 +346,6 @@ static const struct kfd_device_info
> aldebaran_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 3,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -398,8 +362,6 @@ static const struct kfd_device_info renoir_device_inf=
o
> =3D {
>         .supports_cwsr =3D true,
>         .needs_iommu_device =3D false,
>         .needs_pci_atomics =3D false,
> -       .num_sdma_engines =3D 1,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -417,8 +379,6 @@ static const struct kfd_device_info
> navi10_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 145,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -436,8 +396,6 @@ static const struct kfd_device_info
> navi12_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 145,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -455,8 +413,6 @@ static const struct kfd_device_info
> navi14_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 145,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -474,8 +430,6 @@ static const struct kfd_device_info
> sienna_cichlid_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 92,
> -       .num_sdma_engines =3D 4,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -493,8 +447,6 @@ static const struct kfd_device_info
> navy_flounder_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 92,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -512,8 +464,6 @@ static const struct kfd_device_info
> vangogh_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 92,
> -       .num_sdma_engines =3D 1,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -531,8 +481,6 @@ static const struct kfd_device_info
> dimgrey_cavefish_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 92,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -550,8 +498,6 @@ static const struct kfd_device_info
> beige_goby_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 92,
> -       .num_sdma_engines =3D 1,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> @@ -569,8 +515,6 @@ static const struct kfd_device_info
> yellow_carp_device_info =3D {
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
>         .no_atomic_fw_version =3D 92,
> -       .num_sdma_engines =3D 1,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 2,  };
>=20
> @@ -587,8 +531,6 @@ static const struct kfd_device_info
> cyan_skillfish_device_info =3D {
>         .needs_iommu_device =3D false,
>         .supports_cwsr =3D true,
>         .needs_pci_atomics =3D true,
> -       .num_sdma_engines =3D 2,
> -       .num_xgmi_sdma_engines =3D 0,
>         .num_sdma_queues_per_engine =3D 8,  };
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 1054fedd7b3c..836ec8860c1b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -208,8 +208,6 @@ struct kfd_device_info {
>         bool needs_iommu_device;
>         bool needs_pci_atomics;
>         uint32_t no_atomic_fw_version;
> -       unsigned int num_sdma_engines;
> -       unsigned int num_xgmi_sdma_engines;
>         unsigned int num_sdma_queues_per_engine;  };
>=20
> --
> 2.17.1
