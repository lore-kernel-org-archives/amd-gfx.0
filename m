Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3FDC54FB9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 18:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96F710E30F;
	Fri, 17 Nov 2023 18:01:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEF110E30F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 18:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IceCmr9x/iz3J9uvY6ciqiibXSCUzoAwkVSyOL+nCCL+FihEWdC7E4eO+mQRU6pV3pPacAtqh9fmYfNGPBJeBiOYug1kg/dSu51wK15s1VTP3FaIf6Z5oeu2KuggyUM/JwQCziW3IGlaCWZ4ttEWStj9wFd8k6RtPzsABw2sUyO1RQSTap6CnYFyePa+L4hu5fMhBsxBpbc+NqQofcbT8WuHniV/x4OdnL/WMH4sey2iHAkJ4YM9WIHkaDjXnv1qHyFCewfDDP7cDqwUkZcd0CzaudfLuiuHBHNqoYKtlWH7qp8vb2Y2mXC58I9DBzpiLa6yNEkl+ssvKXY/LqyzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9uJqdHZCCIZH5ENat44LiKLER9zfDfABRotTYi5WRk=;
 b=YwiS0MiNBgQ5hFfbCUmrHAS6XskKJSB34asmzyOz63RooTR8wnBzuEsN5ZVbY6x/I4hwao72UfzDWFI5BVBEbme/28Uqn8RX8o4PP0FM98VLn6LZMFtZbj6WqnTe0D36bXxzeGSvghstgUlO9FfZrM+j2HBcNzWKHhGgb7RkxF72ULiDq+68POIwDmrW4KXyYwdDA9RBOaJ+o57rJDgnyD92Lkb+MB7Mvj5e5l5hnrgSEyqrXbcKF+os/a1y6HCxi/3oGi1Y5yIBINS7+Ca9B5dtscdg0q5D4hF3rhFNaoBPrLOdMIjknPOnAGe8mmv1Y2y9U8OkimUDb+1dPiBhhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9uJqdHZCCIZH5ENat44LiKLER9zfDfABRotTYi5WRk=;
 b=G/2tVntMYHWA8EQCqfQ5Tr++N/4rxQSigORKSBV9JYX614jQ8FnMGf36TfzixWCZ1zs+y4wuiYk0EO9tmB5sY5Z3Au/Nsh2wQvp7gjTHrygghkj2GUE+3BK2tsNRmJVFIfRHy0L9EENRmJVSA5+g/y+2tLTCk0//Qji+A7APzqE=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 18:01:31 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::19fe:6718:e3a5:e855]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::19fe:6718:e3a5:e855%3]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 18:01:31 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update xgmi num links info post gc9.4.2
Thread-Topic: [PATCH] drm/amdgpu: update xgmi num links info post gc9.4.2
Thread-Index: AQHaGXgBweTxrZoIPE2SgQ8ndcW5HrB+zCJA
Date: Fri, 17 Nov 2023 18:01:31 +0000
Message-ID: <BL3PR12MB6425D5DDF3C3F55F673901A0EEB7A@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20231117170310.2917026-1-Jonathan.Kim@amd.com>
In-Reply-To: <20231117170310.2917026-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5b9ac17c-210d-4682-ad84-6b9398ebfeb4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-17T17:57:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|PH7PR12MB6442:EE_
x-ms-office365-filtering-correlation-id: f6e31443-8d2f-40ae-ec40-08dbe7973acd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ugxhqeGD+1YdCgWkWXLH+I3Wno+45iDT4JbrWMwMeNXbgvOqtaL2fGn7Fki18MtpZnSvHWZt6M5ZJp2erH2c4A0UE0XzSiXoO7aezf4Qo8kvJQgTin02W+Hvkn4CcfAufYJbGZLqud9x215wYZ3L4Y4wKchgKByCYm/o2D1ZSasZFdQV1PxdCErMWKiOAkj8E9JDU9I2BSLUyQZe+T1iRZcI4GJauQoZSkeNn1G/3VtPo5wFSUTe0S2g6o9x0rjTx/rYF2WgC9pWBw8lDjTFDcOu2lqH81YFBTr8NOOZKBIF5/PR98Nq7AaBOgVuiUFiN54zOyYiyWeaoxOkwSkQeuDHGIhpyIrtU52+11PJj8ZLEY06kKscYa2gLQ9CRjJZJQU+8dhOducWhqdRuCQQRCgD2YnDZhUd36Vzir9LwwVtRE8BYZ3oUNQPH+CuKNw9jBh06gCVvq7itavhpS5ibl9ykYVAuEvwvYyTaqE2FXb1ORDex+CabaDy0t1QLqYmrULarmM8x7QvV9DaoU0UGCYFYcbNbvxTKVoy0v05NufZSqO+jeWlpVelvOPxMDcO+GxBNLuUyPxTwHPoL2jPg81c4cJ/oPDiBO2b0E2eqVP6w/2ykGe3h6fzYQ1VKNU0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(26005)(66446008)(64756008)(76116006)(66556008)(66476007)(66946007)(110136005)(38070700009)(52536014)(8676002)(4326008)(8936002)(38100700002)(41300700001)(122000001)(86362001)(5660300002)(33656002)(15650500001)(2906002)(83380400001)(9686003)(71200400001)(478600001)(55016003)(7696005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2zpfZAoF8ZQ6eNCVEIb/oLVhpQk2aGShKUYv2xx4vZUhndJkbXKg+zfPbqKR?=
 =?us-ascii?Q?UFSHmcfE+WsTAQ1u4pHGgvDEXBuiOLKAgj5n7HFJcgSJjXslkbSrQMcjPvoY?=
 =?us-ascii?Q?6cTNSKNGx4vCaAUxvbgR57JCxLs+4dzFUD1PF5R8hhiZCFbwScoXPxBJ/R/6?=
 =?us-ascii?Q?V+8r5Lj6ub66wJpiZGimvdieXvfOyKpQpof4YGD/jnj8Ti46OKeNjv1OAsBX?=
 =?us-ascii?Q?R4b4GtNqX9FJK0lmC8RSEtWFwNSUbpk4V0Gu1ky0+kiZtuAu1jOyMtK4btwC?=
 =?us-ascii?Q?9/SUpiVFt7CX7HLgJxfdcH0z0Rq8WqHBvE99hZb0VeLc/csD/0cfDAfWHYmh?=
 =?us-ascii?Q?s5YgL7jVuAC7EpQdYI34k+LV88S46QXe+2UDjmSNmZYs3R86YVKpgFE1ApwM?=
 =?us-ascii?Q?L5Lu9X2t12bt2313Bz5dKxNUZ1WM5wwvLtbk0YNRzTm7g+MTCi0X/HByBO2V?=
 =?us-ascii?Q?dg2x9fLUtwtC8UGeVVaO/vKpWlMYV5UUMZ6j2cV+LLFaf5JEkDodo91zG2ub?=
 =?us-ascii?Q?xFa2KOb5lBKM7PxY2BOFL32hVgQMzhQOf2BDv9PqV2bMKgWG5aGQzoewzGzp?=
 =?us-ascii?Q?xLobecmiSrci4Nb2Ecc6lETHLCaB+sfCoHBvuq+CUfZJO/bxqVxcbqHENKay?=
 =?us-ascii?Q?qHoKd+na8oeFGVsU42eF7CLXg6jrLaoG4o4p8vhQWpNpawnn4B3X6Lkq8l21?=
 =?us-ascii?Q?SGaEmWP83lR9Ycu5Jo5KVzOOExDmTWrd9xnDTgVn/uaH8DslsEyi4tPjg11t?=
 =?us-ascii?Q?77jDZlaUNltNxctxv24eJpwxeg2JyyhQx1gyR2xs/bRyq3SaThii89Rj3WC9?=
 =?us-ascii?Q?2fSIoSMEqvwHsSOaa4BJfow1+SAypWGdd19A3NJPC3tQnuQFxxQYm+YiWE7S?=
 =?us-ascii?Q?JeLfxqRH5Z2JDTEH1cHPNkHle1mZlZDT8GCiXd8wegbkxM02wsdH04/AlPwe?=
 =?us-ascii?Q?jHRXa6DaoECfn+vGb02/awvTcMsl08oxChvvVaWnt8CoVMAhGWZi7ISVhLtp?=
 =?us-ascii?Q?E3F2LCGcOzJbXBgOGBcmSO71wUf6tB8yARJe/1d4+qoE/Yt2CfmxZWvKcZ+1?=
 =?us-ascii?Q?/bFgsz7JGkLw4cmCCBg5usvIldsToLIfhOHXL8m154K+UzuNo6jg5yBNlwT8?=
 =?us-ascii?Q?PeWEq7qv9Teiyb2nglGic+tERpCIHN6pkiIpOcEVHrJx4zIDB0q2qw1adpiz?=
 =?us-ascii?Q?bRwLDvVOInfgZZV561u8Grt6ArOVJzLFUUS1whFN5F4Y7fVRJbOdfXaqRdx1?=
 =?us-ascii?Q?oz+twj9ej4h931p6Mq+0RT46GgDx9GYXetN6Y6zGbcR8GAJaS1CRfA+D22Ad?=
 =?us-ascii?Q?yFW/WcuRc7vU3xc4C6bxzzVqmmM11vqg330F/MBS7Yyds1csQLqwGOM/sbiP?=
 =?us-ascii?Q?EDxzPJgQN0r9j6saZelqLOtydH21eSQJvgXWTgx0+wNGtHqcL8xIsdbJYULU?=
 =?us-ascii?Q?R9bGQRZYZf5BSODVB9kehwGKg5fnNqzIWjaGTn35k0ATk0zoKTR0Z07zoehz?=
 =?us-ascii?Q?9hfLNgY19mh+/QB+lr52xunbXuU4m9QjjLcvvoQUm3X4o9RhB2eVCOqYsq9P?=
 =?us-ascii?Q?5sOdAdx8TBQf5pdX5G4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e31443-8d2f-40ae-ec40-08dbe7973acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 18:01:31.5157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuP+aefZ+xYTxLX8XyhplEHsh7eFCtGmsBCXNR4PVSSSxSrmPBcG2eHHggFF2I906hogNmq3utwu/Q6GBt8tsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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
Cc: "Chander, Vignesh" <Vignesh.Chander@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, November 17, 2023 12:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Chander, Vignesh
> <Vignesh.Chander@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdgpu: update xgmi num links info post gc9.4.2
>
> GC IP 9.4.2 and up support TA reporting of the number of xGMI links betwe=
en
> peers.
>
> Tested-by: Vignesh Chander <vignesh.chander@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 6ab17330a6ed..2d22f7d45512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -547,7 +547,7 @@ int
> amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
>       struct amdgpu_device *adev =3D dst, *peer_adev;
>       int num_links;
>
> -     if (adev->asic_type !=3D CHIP_ALDEBARAN)
> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
>               return 0;
>
>       if (src)
> --
> 2.34.1

