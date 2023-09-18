Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6A6CD37B0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 03:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA00510E067;
	Mon, 18 Sep 2023 03:39:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A615510E067
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 03:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/F9tfuHjhri/XNt3kb8Re6bwwNX/mfZbjo8+RBsIJ2TYUz1aVBQ0k/3Qn7HW2a3rXxUuM5zXIi5yG+rbaKiPYvoLZmGcUW8l669KvEGXrHzCeo4fLVM6b+LQG0Jzj9+1kqfNn7CmzyaLkPv0W6w9NXimVDHofEqean3d3rzP1K4TYX0SM9DXXPqtkAXuPNXl14KXaQmeHCF9Hyr+N/imc5QKJZVolXYXtiojcQv8BI8bzi0WEEzWtRviqtvQ6DAZIUtiKQF+O0a/ambFVWnU2wGuKlwtyFaC8r/tyS/fa7blcBXVPN7uxKgWA3t0I9tDxLjaLuoxQXE6yB6X2Z7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pymuehVMACmxr06dWEyanzXgjz3Jucc3sWJuhYmH54s=;
 b=ZUAQKgv3cKGrpA3PuoVmbK/zl2LDB7shWWZvvGg+oQPG9KZrkgIvYBrr/xfFLHhO5pihHPhDpmgGRvAxVS8Sui6oSUtQpn+fum3Ntyad+lml2PJgi7us/+g41wu6BEcteWfTYJhWvVp922o5mb1DMbrfiGOTXO8YhuP6FD5+bSpORY8MtaDOX1owTmecRT7rLhLsmhV9lB8OMqJNQCFaxIuwFIsleqT/JQpL/nW7BOIpvQB4cB5P9kqQ2TxONRO/1e5+zxTnEVTetud6crKb4GPMKfLtvIai8s//E1mIcOkGOImQYX+fQAbd1NVbwEZ5X67NwNCPU8SYrC7HObth1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pymuehVMACmxr06dWEyanzXgjz3Jucc3sWJuhYmH54s=;
 b=tvhGC//Vh0vz02Y9+EZ6ly1LWXgxbbPBfl9E4wsatCtXGVPWUGM8MxiT2q3Avgp23eK+2LkUfEX28qYsFhiryefN0wm+HmsH+Q4bseH2UIipQxBbpuf5nf+9+vZuD19SsMQCnzNaPN2tg3fq/MToZ16T7TMM0lMDCRRpNCYKdLw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.25; Mon, 18 Sep 2023 03:39:26 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100%3]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 03:39:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix false positive error log
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Fix false positive error log
Thread-Index: AQHZ58TEfRQkG92rhUCb6AOyBg46qLAf8waA
Date: Mon, 18 Sep 2023 03:39:25 +0000
Message-ID: <PH7PR12MB879657A9111E6A37A1BF916FB0FBA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230915110651.1849740-1-Stanley.Yang@amd.com>
In-Reply-To: <20230915110651.1849740-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=686417ae-f23a-433a-8145-9fb68f97cca6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-18T03:36:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB6112:EE_
x-ms-office365-filtering-correlation-id: 27d92624-cb08-41cb-e4dc-08dbb7f8daef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vy7tgbqyw5q7mBxS5f3c2ekv0u5cz4H7CYsaTRHLfHZyiMfPFMTBTqAedgOdTA6/qmko1lyZza3226LqvvT7v/HgMz5jdK9MgleLQ7NX0oY8oWzEOvEA/TbEUg13T46+N7dQPol9GKuRRvO0sgmEHwe8HjBC9QqHv1ppXzN7n3oTC1ItoxafliFZ0XGUH6xJ+qIu4Tui6dyF6NgEarymm9RuB04jrmwGqiU0QUZ876BXfx/tbmXO2FVWe+c0B6231lpa8Alj6ZemNKMp13pbRv2UKrEyAAUgzn9Z2fOHWCEvWvj7OaTQFl6pNbmsd78G14leURJPeUerhlPS12oIAuRFZy2wz9DG403+GAicuMNR4TiKDupuhj/kLhhV/WY0e0u5lxRn0SA9zp8p9fxViSRmsXdBg1GK9Hzw5iLTlHHDjO3Z8TOSgeqV0bSx7opggd8ZT0pOfzpF7RAfGi2LljrfDQR9bibG3wIzfF+5daqAeo29a1WA4lhqkx8jhXyd+s8Eey91AcZxyMdvp4OsfbNUS1LTa7f8Jp7EDKrM3QIRD49sC8EbkUg4G+v3bwnfMTQVVoLI8VHPfsLumJnFE3lcZx8xaU8U2Kyh3I0P3fNxWyM7EwsIWaGuK0F2oCqL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199024)(186009)(1800799009)(7696005)(6506007)(53546011)(33656002)(38100700002)(38070700005)(122000001)(55016003)(86362001)(26005)(2906002)(9686003)(71200400001)(478600001)(83380400001)(5660300002)(52536014)(8676002)(4326008)(110136005)(8936002)(41300700001)(66476007)(66946007)(64756008)(76116006)(316002)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NqISWYZlTeYgcX1cqftdcCgzqYxPVqycQQSwEKPoRf6hSyr+V8tnhG77WMHC?=
 =?us-ascii?Q?j33Gpx5Vy8XlWGw1lQNZLsTkVwrbcSHP+GGTFRfkKkTKO5Q/zQTYsZmu1wE1?=
 =?us-ascii?Q?WZsYjILvBq26KrwCTPaPJCYkvqy2KexgU3baIOSsE2skgzb/HTNQXSPpNs4T?=
 =?us-ascii?Q?1nojkM6P/+83wW/emT0OjDq0qomUIYIx9ptLU/H/ce6JCHCZ9jZ/x8sr0uDv?=
 =?us-ascii?Q?KJPk5P8pHDIdK62R48yxwRXwNPFsZnvpGmuV2ham2d3M6rVXz4PDi881+hVL?=
 =?us-ascii?Q?fGa6WISRN+sAc1jW/0wwW3ps95OZgt6VPZfXjY81Ztt3BM5s/Rcn2K5rbDOB?=
 =?us-ascii?Q?uFWqgSZ9D0IU4s6ZaktWh4ldV8emC2gG5j0VIF4S2tHgr7/5FQCTrzhg3aBO?=
 =?us-ascii?Q?Tsb4QI7rnxG+Ye4HjysWkRx2ZYxmCoScuTvlla01H1mxDX5TqvBHwFC27fUa?=
 =?us-ascii?Q?NYEg67eRvHmg7FmTUAtC7gZkWEdEc51m9yN23t9G2np4gacyms47+MzWHWNm?=
 =?us-ascii?Q?bCjeWIslJCkKGaFftr7CO5614Y6MoXJRS7t+qDkMIuLqIocgfd/1KvY1T+T2?=
 =?us-ascii?Q?h+JQpU9gmbptFJy8R0pVSkIU3zq1AcgQunQEpNF2pL18pfnOPAiYZenizfka?=
 =?us-ascii?Q?QpkXtBce2cgg5p1Yc9xIHV+dYysOWrIIRvXDYjmARiUuGcXQHc+gU6esIoRE?=
 =?us-ascii?Q?7vAohItuh94+JrpuUA7Z4XgDbYq8F8cDiQermrQTS2uUPxChc1rt/2VLFO5N?=
 =?us-ascii?Q?sxEj5RHmWV7KTKvzY6fA3U2daxdobJLhd5EL4RRVwGQq2D0g+el+IUNE6Pmn?=
 =?us-ascii?Q?lHeQuANLvSVGdThf1AUMHB8o8ZKuBovTnbmMK5YGZaXlUdKLIvI1juuB2aeP?=
 =?us-ascii?Q?KIdqslXjJR7u4q95zVyFGjr/ZTFYn3VV1nPFyH+wUr6FF9Wo/wT2XJuhAJvC?=
 =?us-ascii?Q?w6K5+yberxnfl2ry/Y3pnFbSvcMobk7n97SPOAkRqoyC5GF/QyDiykOEsrd0?=
 =?us-ascii?Q?iISwsvwesQDHe2+dKLJyZnxEI2O+E84gxSvrOAxuSgVnSNq97ufcujg7mAql?=
 =?us-ascii?Q?cKwh2pRg1zRFOoZUVVdxcQq444OdmWR5YFL1KXpVoixLQsyn3omp2VUvkV9U?=
 =?us-ascii?Q?wMpnSpQMPBLXqnn+gEtSO6OHmXN++DwFzeetMesduD4khc6hvsFdZ6WGufVn?=
 =?us-ascii?Q?3JHzrdqxrHkvr4c7CqtLHiKH9h77itybnF0z+sBDb2P6wq+xC8M5AcnsC/vb?=
 =?us-ascii?Q?vyMOtawtKcsld/sdKrkHnRys3bpBV8i5DM29/oODdsQRXBFtUetqUYHLJ7eB?=
 =?us-ascii?Q?6eH9VjIxtvFCEdRHlzfLIPYcKELuJs6OgZGL7d0oosVJ14a97plFYhXbIepb?=
 =?us-ascii?Q?spAaOWkMa6Ouh4dXZ0K67gm5NW6M9cOE3hmMAMUsGD4AMBXrJBqXnjNO8Twz?=
 =?us-ascii?Q?8SMZVReSnNsbBLtmF4H4RdKb00ijC0GlsZHlxUvL2018FQKgQiyCG0sSQOF7?=
 =?us-ascii?Q?dfPcMl0pXCUi9nFM/wq2JLea9l4Qx3tWvPj6a3AiyaqZdhpIx/nt70dlOu7z?=
 =?us-ascii?Q?m6OUogUZ6NhRdXLL9x0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d92624-cb08-41cb-e4dc-08dbb7f8daef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 03:39:25.5896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJCeRNMsIQeAfNjNQxd3XL2o8wWTytaE0sPFGxGFcUBC0ofRsjaZdxwNHecJud/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The update is fine for me, but since "!block_obj || !block_obj->hw_ops" is =
not considered as error status, can we change the dev_dbg_once to dev_info_=
once?
With that fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Friday, September 15, 2023 7:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix false positive error log
>
> It should first check block ras obj whether be set, it should return 0 di=
rectly if
> block ras obj or hw_ops is not set.
>
> Changed from V1:
>       return 0 directly if block ras obj or hw ops is not set
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4a6df4e24243..25514af6cf8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1105,15 +1105,15 @@ int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,  {
>       struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
>
> -     if (!amdgpu_ras_is_supported(adev, block))
> -             return -EINVAL;
> -
> -     if (!block_obj || !block_obj->hw_ops)   {
> +     if (!block_obj || !block_obj->hw_ops) {
>               dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
>                            ras_block_str(block));
> -             return -EINVAL;
> +             return 0;
>       }
>
> +     if (!amdgpu_ras_is_supported(adev, block))
> +             return -EINVAL;
> +
>       if (block_obj->hw_ops->reset_ras_error_count)
>               block_obj->hw_ops->reset_ras_error_count(adev);
>
> --
> 2.25.1

