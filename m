Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F51CC3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 01:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD8210E4C1;
	Thu, 24 Aug 2023 01:53:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FEF10E4C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 01:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7Gunio5rHyfbQxuT/QVSIFG2mjTc1SVib0SfnizdvvmzhymGMgvqdUSawHF0SBmHLc4FxPu08MQniTFQyG/IJpzUNVmWtDiju/FulyRlR+ZNiydJ5/QVbKd2nO4p7IPlVyzjnz4qk5xbb7iZea+6orDHG3gGrMj28xd2AdJPRK7IauPEeOnulxW0iFEHTm2P81qgr6+TZk/galLGvS+b7eKHotQK5tR1BrJa7v9qro+7c80CY5XG4oh/bHUXfcYDz/bsKvuS5IoWgkQ3BCGVVelWebSyDeCNLSP2sU32qyb9epSpFk2zlyiKvqbrYw6wz8ArlWLxxglBEDyG4mETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh/KIsqnHsdi+Zha+hWLVAtMK372GFMd+YgUa4OH1y4=;
 b=AevVFMT/mhshffRcahd8+f+h3F8wTMuCZqXdnLKu5A7oZwkV82PpXVJz8N3hnvenCuXjc2cX8fsxrRyUoYTausF+Uqyd+N+T5yKzL2JjC84nz2gdyNMuPqRF56QcSpweGBLjqgl5MnvNigU2D2BSWXXBJk0iCcskKJeEQSdugpKxCCJQDHtuswi0rjr8ZwwZF36o2g+feGlsbci5W4eOYEWVk+guRJ0O6AqX3OSVUU9tYRJEs0yXAimm2KsQy1YJ0+dGFyZ2ttb7g7RR9Fjm7hOU2vubUVepbjdnx3jPMy20+28uP/3+RN7IVr3g2LNO9ML19gCNdUVqNULO1/Pm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh/KIsqnHsdi+Zha+hWLVAtMK372GFMd+YgUa4OH1y4=;
 b=0LCFXa9jKxOej+ITUqava3Jg2NPQFvG0xf2aS3La1y63MNSnnJ2Xciv4k5Xct4xikFFf19BruPIHQzQRtzS94DEfTNlfSrwqWRrsnxJehBiVC5rQrBe+Xazqjzhr5ZUQqWxTz/N/iYuQyieMIURk5iZAtmqPXEDUs5v2CMjgXUc=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 01:53:43 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::7abf:f750:1e18:e157]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::7abf:f750:1e18:e157%5]) with mapi id 15.20.6699.022; Thu, 24 Aug 2023
 01:53:42 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Allow issue disable gfx ras cmd to firmware
Thread-Topic: [PATCH] drm/amdgpu: Allow issue disable gfx ras cmd to firmware
Thread-Index: AQHZ1i0jCk8x41M180aSJwERLIkgb6/4ry3w
Date: Thu, 24 Aug 2023 01:53:42 +0000
Message-ID: <PH7PR12MB8796C19EB8AB78E0E554EE79B01DA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230824014836.1404-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230824014836.1404-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7ccd5c54-7c40-45fe-a56d-534678e70ad4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-24T01:53:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CYXPR12MB9385:EE_
x-ms-office365-filtering-correlation-id: 9e2dc8e9-5611-442f-469d-08dba444f1f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cofeo8gB/XqPe5/Unyb9n+/HJ9UWq8yzspQBv2O3XjWwxs3g49Pv79OmqBiTvYg0gPJi/CBGQeLcXPLfPSx1W+ZStPrHpyApzY49h6+oiCdGOf9kvMiZk5xgzvWXRMKQbVihUYp5mA8J62ImpvvEYssgGFqm7fV3PMymhiiF+5f7675vK1ETieXN0IESh+NGEh+3vGXpvxOVT3avL3+HtY492wd4nK7Xyn2BeLQDxiNX/wDhyZjzvhVDXR7RXc3x+nM2QXWI0EOQtbp8CW5WjFM41K/jpmMIxy6Yeoq6hbsamGG09B1yqc3dBmKgxWqALBfvU3ZE4Bq7Bx4ZcwI3wxiuncIjXFe1pXfeXy5FYceLgAoyB0HrHJ585ZN+G5nEKhyE+GhD2wdFWRxMic5BRI/kIersi29YxTklrWhy3fEG6gdDrSxUq7N/2fgOgGBc5NMU3QqC0YrrbBUAMWaged3f8D7vIpn6//ixFsxzK8rQ4Nvh/g4xFGjCtrs8Hehnl9NBDLk+fAk3AqG4tiyxIqB/VghZbNJWPc2lF1wqbcAuYN1s9Ca6+1rWDNqc4a5dNWZiW/Nf3+wH8jke9iVod6/sVL89Z3epsBp7BdisQUvQ1E5f/q0Wy6XAlfQVOIcj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(66446008)(64756008)(66556008)(76116006)(66476007)(66946007)(6636002)(316002)(122000001)(478600001)(110136005)(38100700002)(55016003)(26005)(38070700005)(71200400001)(41300700001)(53546011)(86362001)(7696005)(2906002)(6506007)(9686003)(4326008)(8676002)(8936002)(52536014)(5660300002)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/RzM+tmY2btc+fIV4FsS70lCCv5HgXh13e2vqjAeHJpep8RNCjFqcUYlfESE?=
 =?us-ascii?Q?YAliY8trRrsVElCReHMJJtUaO+jHMk2OGVgz9hjWYguEwbdPeMgTTwaQ9xbi?=
 =?us-ascii?Q?w+FJi+P1IU9tY47sSHOE+qqUp49Od2KZ6PHYmAosJZHdkpkfgnHA2sgGFfMd?=
 =?us-ascii?Q?jAn/jzwfsEcu5S+3/vIwJXcRWrhEHNNcg7Q2sXFXd4OM16OUZVSeDsb+z3Fu?=
 =?us-ascii?Q?Jq2j4k9RuWtwYiUt95o1oIdJSrw8kQrov2S+bdEn+HPvo9VLm+kknNU5bh0z?=
 =?us-ascii?Q?qqC8tVvUWBzGsjrWJZOT41MZ+MQfv1F1FirkEFNjr2RglPa1OEDWCK4hAhcf?=
 =?us-ascii?Q?EnylGReDczWupN6d+DqIQf8KTaNxCPeghHkdXNi6GCmir8BRfsxcLES6tpWk?=
 =?us-ascii?Q?NNgxZ2cwkuYAk0/G56uTthdLB5TjP5maQNDePR8I2NLNcBNL1KVrR/HtjcOX?=
 =?us-ascii?Q?ur0XGl/H4RPTHSMXdHEzPfdIjK1B/38lSpLgD/Sce+/4qI73pfpOJrQQlK3R?=
 =?us-ascii?Q?JX9arJIG+7y0v4Gkbf9xQ2LykenBuC5PtsTwnBNglwBfDD/ofcityCP2/O9C?=
 =?us-ascii?Q?EGygH+zedqJE9uYrugAgW4UUauMUxeXy94lKbjqxBLK1y5tnEw7Bt+HelbjQ?=
 =?us-ascii?Q?qwpQHxcVIlkme+MeH2NpI06JM/JpGlgvhaBPaTvREjC3aYlAJPD+pjo2hljY?=
 =?us-ascii?Q?GMgnIeS6vDK8ckhwgqxgdKcdnKKhjBJlqNIwQ/K0HH6xN0zVsem15cT6g8xn?=
 =?us-ascii?Q?7Idx8LdmE0fb+UIKJqEkm5UE1dCJokbX3pQhXmORmM55Kp9gc3T4k+1DM+Mm?=
 =?us-ascii?Q?KoxgxEKf7Sl/M2DeiSj7/maJ1MUvyaFT7RRwKqmI/63sPxlpRWX6X/Qg903M?=
 =?us-ascii?Q?uWdtySu5rL7rddZWYmMeLnFnWtIVmRVs+O6HSJq2iNNUny28839mbrrTgDM0?=
 =?us-ascii?Q?DSgAh9VJaO5SdcIUdc7dXGulG9R5GHXcgTj9LlHNbxTemWCRI4ZOyz30QA0t?=
 =?us-ascii?Q?FgNTtr0K7Fc8TglaqboJ9H+OHGuRuy+G6Ey0TWjm0TidrKdTdJ3nHogm6Dgp?=
 =?us-ascii?Q?XrD2Zgau2137huXfxF8/r+oHJ+XX20wZTSHQBBd5FLGqKj8C2D0Mo6P6mWKq?=
 =?us-ascii?Q?ycZEHGk0SrgOxkDowgNtwgIBollvdrXyDvjLXVfr9CvDWLkU2R7jD7tA0yVk?=
 =?us-ascii?Q?zX0xQTM7YfOJ/YRi06dHhGKL1HO0yMG6QH8gpjnKTY6zbwn9cxZfd+VcCEWB?=
 =?us-ascii?Q?2G/BXeES2RAf7cJnVwld7NiTVREZxaVuds/S9J07CRLUN825pUCcbW2jqfB+?=
 =?us-ascii?Q?7DrhalUwwUuBoxQlznaYyfeVXjwvFL/rZT6m2+k+9C/IeAwuZECdWIoF+GfA?=
 =?us-ascii?Q?iqzP5O6P3k910AIkEesOZpbGdYmmRc/cifNPTds3g3IiqXjKcR1zHPVVFhNP?=
 =?us-ascii?Q?9CHH0w+kvnHKdvrhHlf84NTo3djRDnbDd8rFUPFmoFNn1oBYkqu8Le3VARIG?=
 =?us-ascii?Q?KxQNRIg2Ot2x5uppXJLs0lDorPUcOLksT1DjYWqokLw1Q7tMj1bNyRQ8Qixr?=
 =?us-ascii?Q?iui0/z1griCbY8oyz9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2dc8e9-5611-442f-469d-08dba444f1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 01:53:42.7062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gDpxAvfdrgfnY/ET0ml6QwEobmvIkY72u7ItTISQXkO612+rAXHmExQVM5Pw9GW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawkin=
g
> Zhang
> Sent: Thursday, August 24, 2023 9:49 AM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Allow issue disable gfx ras cmd to firmware
>
> Disable gfx ras command is needed in some use cases like live migration.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 378478cf9c21..7db6baa16236 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -769,9 +769,10 @@ int amdgpu_ras_feature_enable(struct amdgpu_device
> *adev,
>       if (!con)
>               return -EINVAL;
>
> -     /* Do not enable ras feature if it is not allowed */
> -     if (enable &&
> -         head->block !=3D AMDGPU_RAS_BLOCK__GFX &&
> +     /* For non-gfx ip, do not enable ras feature if it is not allowed.
> +      * For gfx ip, regardless of feature support status,
> +      * force issue enable or disable ras feature commands */
> +     if (head->block !=3D AMDGPU_RAS_BLOCK__GFX &&
>           !amdgpu_ras_is_feature_allowed(adev, head))
>               goto out;
>
> --
> 2.17.1

