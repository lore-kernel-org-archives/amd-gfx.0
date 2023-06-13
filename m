Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B61C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 07:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E766810E328;
	Tue, 13 Jun 2023 07:09:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451B010E328
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 07:09:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYhwyKAf6Ohop8vDYD+XJ/dKnaP2Xsh6lrwdVPcYtZRqoih1ubNKmXfsmPRLCdJEAcOWv11M0mWPBpqDZabYCL8mtyJPJO0xprQ8NwvD2ozn1oAmQxFcBsB7OqOwZih2C6bmtkcS/privDyVPQTiCrmlTufu2Xlm4U5VO5HxCGSuVBqfE5+2+0/+PWEHoyB5RVHaIu3OzJ7P7ycPw6mzCV3GNP3WmyJzJiqrbFdDmV8VVC444SRLdhq49J4K0GiycTpAhY+Yjz1Q1PXGsd4wvf0IX1+pYdALc8WSIJdrpGCuNTiSue3xt0NWxIsw6PwUpQ+uhITxxIHb6yKyvkejtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7lJsFaK9+qLAoE/B198VNOoP8t/+AeMZ21zQotI1eU=;
 b=S02/z1+vj5QEm2FDcfTbPUwreOQXR3xLjS3l7ldEGOe9lTGzyops9mI1VMh3vBPzBP36e3pS4PtAM+CCUwGcBt1FUhy89S+UBgvuaCIL56BWzxnd75S30JQD+BiVqrBBfNy3pxh/vlrN7mDCGOvPBJdzM7wG7lzravUHR2pHPSW9PyfhocpU9ywOIHCzoYbsXtMEG/eQtX0rKwFP5h67MXecOQvQ5FuNWMtu3mOxVUatR7WMTIU4Q+V+5QZXM2aWWth8PLwuuVF3LRfzXIlFC4nHaXhhVVfpgcyjN9xBn5ic6sgVaHYfv/nIzk2e+tiKT6A2hHjAkJa0OFXJ0ORrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7lJsFaK9+qLAoE/B198VNOoP8t/+AeMZ21zQotI1eU=;
 b=eLyCrhpOuNS2mfMshp3gZs/csQCF7386zZPEDpZeXGRIuf1oL0pQz1dc3FlOV6f09iqokhe5UZHVGbCmql2y+Nib92iesHLcQHKB0lHIk4ebd2IpSX6N2/meeRJX3aq2W9bqn13MuPGgnN/fWsCgbJKpk4WmVu9ev8kcFw4Ud6k=
Received: from IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:08:59 +0000
Received: from IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69]) by IA0PR12MB8981.namprd12.prod.outlook.com
 ([fe80::9731:385a:f48:ff69%7]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 07:08:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: Add checking mc_vram_size
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: Add checking mc_vram_size
Thread-Index: AQHZnaqbu8f8dQrAwUiO08NBileCwq+IUGbA
Date: Tue, 13 Jun 2023 07:08:59 +0000
Message-ID: <IA0PR12MB8981C10C661723D3713900C7B055A@IA0PR12MB8981.namprd12.prod.outlook.com>
References: <20230613035318.10613-1-Stanley.Yang@amd.com>
 <20230613035318.10613-2-Stanley.Yang@amd.com>
In-Reply-To: <20230613035318.10613-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6e2debb8-fa2b-4205-b4e3-957e8c591f33;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T07:08:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8981:EE_|IA1PR12MB7686:EE_
x-ms-office365-filtering-correlation-id: b3d6d117-8e67-4d89-527f-08db6bdd0f87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3/wi8bamy0vG7H8dqGr7yARfYKRWnTTXs2Af1P7cCtdQ1WGZHOKUgytDd/SGINo8Xj5G/6Mn1IELjblDGBAmNK8MUlj4z8Wg2xrwE6jHgo7ISPW5kh2+MtgDvxi+8FJgg205967YbE77g4fVeZ4VqxIjayNuW9LUhIMB7B/uwAsQuSpoBeEACLG4U3dFH11vnwNIDJN0yhvKNt111RylLcqWPSbYyvUgXSikW5TX7wJ1NQzX83tQpyGVReaDZJubLOLNb2OMblKAOjA7EONAB2bGmxcUMPmNqQ4d7hviKgj/jIOflR4B51FH5Js2r/2VH5LUWKkvbid2WjBNrbcifZShgxG6thIwxaYwocHr+2Y1azV2TVslPCZJW5y7V57j6GXTkgfBFG3zqgw/Rj9QFA2BQatyP7XhyfsWahRneDcM8AtbFnusyM88uQJtZrEqAePNBBhSucQfhAjEjDZ2V0I8WE+K884WBtlFiC9eQFknsC/Txi0PNFy1vc338oUF28XJKn8ZTPXjZWP1qR9BxWSYa9FWOHWi5x9qy48/wNZ6hKVxR8JDPm0TFFrYrBO3zZjlrC6UMcAin0mWjUUp4dJ17kBNkNMr+LI+4hp9lIFklYyNXp7P1ERdanpelKj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8981.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(71200400001)(478600001)(7696005)(122000001)(33656002)(6506007)(53546011)(83380400001)(186003)(38070700005)(38100700002)(86362001)(9686003)(55016003)(4326008)(76116006)(66946007)(66476007)(64756008)(66446008)(6636002)(66556008)(316002)(8676002)(8936002)(52536014)(5660300002)(41300700001)(2906002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NiwyzBehXhkZAkyzshSF4O9wrW/yl8BZ9Jg4DCPZAAlwtfbpCtIuM2jUzSRK?=
 =?us-ascii?Q?ZJ3VZ1Bo3vggSWzFatXu1HxId9QCeNXi4OGdJ0BQOsha/6o74n7At/QOinfr?=
 =?us-ascii?Q?4dgBHGXGsO/Eq8+aRY8Tul+V1DzqU+ESjbAs5uIyf/WSkg0++WTZEl/jUf89?=
 =?us-ascii?Q?zK5LM9cFXweTUX3yrPguonqaHP6Uvfuo1hPsWlag2lmDI+j3XJms9EDHAPtK?=
 =?us-ascii?Q?dqzO3PDtTcUX9k44FZkx5pdf+QnOehslAcFLL4Wn6UjB5YtT2SQT4n3jqlk2?=
 =?us-ascii?Q?t5pvY8OXE7FKVvAbAMT6IeW63VkqOfwjLyDORiGjStAAhXvKOxYoF0cafKMo?=
 =?us-ascii?Q?cib/fYYH1Sz6q/8xoQPrH5NgjNgDovFfJC3nk/OSXukUbq043n7KjcCMyL4p?=
 =?us-ascii?Q?Wh3+FWu3lRMIotCusQJ3urAn+GsvLixfAyrbs3mV0l0C+WR5o9FpiuAUhC3j?=
 =?us-ascii?Q?5e9LVCuA7qjJ66JtuD0Qgaq1vmjoRNm/9UPvtwuxBo0UahWzXm/LK5KW3wKv?=
 =?us-ascii?Q?1FZOFpP5aZE2aIXg0fvZV6uxlBBJvFJ+bYSxYYNlTJPhD5L4HFWzYQE+1jGN?=
 =?us-ascii?Q?HFq3pvJ4R64r54DmDxdwVv5iC+O7y1OJOoh2bFfOhcjUiQmR8esWzO1yqPuQ?=
 =?us-ascii?Q?hfXjoLsvo81XhJYHalJbswknn1iFib3RBcLedVck2yiNN0BrxUsDEYe91LCe?=
 =?us-ascii?Q?Z7mEjp0fqg9b3yOQOaLKHFrQA/GBRoEq714qEppF9jXaXPxIBjmVSbfLZJ23?=
 =?us-ascii?Q?ZP0bewPX9f1pR7PVPDA1JucYLI696R6hqrAWHlvc11uNGrDbr50sSXRne0sd?=
 =?us-ascii?Q?hbqkhPU4Zr2RKUul4syAntlWzJiWfyVQNNMhSEPF8zprTYeU/EVlGpTAk/XN?=
 =?us-ascii?Q?u7mrTaXX9E5MrwWOZMEEi7O41OjEa7BsVHN2ge9mDlXZshPWF+k1DQRXAhov?=
 =?us-ascii?Q?yMmw66XqmCL1H3B0kc3YlI8UDhGMp5rl/ctcscyVrTe8/jL4GfW1GMpZut14?=
 =?us-ascii?Q?b+Cwd0T2mhVyEffimfTecD84w3AKet4BTCTFsoLcklezE5CP+pCg81VtEWmH?=
 =?us-ascii?Q?TLOXhDFeIOZSwwvUrBxEvHLgbM1IBpLc1kj6FljuiMKL2KZcYm8JCBTCwzgh?=
 =?us-ascii?Q?lmsNLeTjbMbqrFAH0ceSHEetzwgG0vQRO16XjPfam6UmVnjtmqmaOmd8xNF3?=
 =?us-ascii?Q?DlAMDtI9qNWhHr9Wck7Q3SkXT+Ta3xfRa3OoYzK7ksWCiUOm3a6chMDw1d38?=
 =?us-ascii?Q?CCKjHQvGhl/gX//hEVw0/0zE0JDjdlNDfAthDFVB+vUQSyB1W+T2jD7g2G/W?=
 =?us-ascii?Q?OJVixp3cBydIHt+DkRzBMDGFEFUU4d4H5zwYNO8aDPMKK/+AY6eEGt6nDwKf?=
 =?us-ascii?Q?kwvWxFwpG6kiAfl0DHK2GHZyux9hCdjqxWSW8s8gHq5Cvq3uP9he+ARmTn4f?=
 =?us-ascii?Q?h2ey/HG4R6MxMNI8fw3ynriFmYcNjDsFm5ngK276Dg+7YPPo5QBH6EDj0967?=
 =?us-ascii?Q?OEhUv7ORDGQOE0DUzX/ifI4MmpeCjDbFMikofqTuJImoumkSZ0/R+juMvw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8981.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d6d117-8e67-4d89-527f-08db6bdd0f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:08:59.5308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zH1Tk9ZcTEHr5BzWjK3sUFqoWqRsA/BVzUhTKwxwUbvWkOb+dptmwIpmxcZUToCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

With my concerns fixed, the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Tuesday, June 13, 2023 11:53 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 2/2] drm/amdgpu: Add checking mc_vram_size
>
> Do not compare injection address with mc_vram_size if mc_vram_size is zer=
o.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 56bb0db207b9..3c041efcf0c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -494,7 +494,8 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct f=
ile
> *f,
>               ret =3D amdgpu_ras_feature_enable(adev, &data.head, 1);
>               break;
>       case 2:
> -             if ((data.inject.address >=3D adev->gmc.mc_vram_size) ||
> +             if ((data.inject.address >=3D adev->gmc.mc_vram_size &&
> +                 adev->gmc.mc_vram_size) ||
>                   (data.inject.address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
>                       dev_warn(adev->dev, "RAS WARN: input address "
>                                       "0x%llx is invalid.",
> --
> 2.17.1

