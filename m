Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17188C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D71910E39D;
	Fri, 10 May 2024 06:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ARJr7civ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC4E10E342
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK8drbivlItB9J2dW8kHBbMO/5OCHZLRbG2hepicJ9+Hb57tGKSYz5nkxY3UscUOdIFVlBXI7OUCvgOLz88qd58q5e0MNzqlE6qyuucTeHkFm4i9Pqlr93Y1veGkU2PgPOWYOxXqIgO+kQbjzXDucjrdF+bL7G+n9/lPHke/3rc98mRwXWKHBgdAd2DOdMGGHzex8F9vElPefbcpjfH6KIRKgvfBSEufALI2gXgHXU5hUVdRGv7vsuQbjAnh6C7XEz5fQTwnudAsXFqzCT5pfkDjvCzTyeFSLY79GnAGgit1frAFjjYONrZvBdcGzs4eE0BlF/0OEXCcff0TXKAtsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/JdPBKRUr4XO+nVbc2d1/HBBREpiXPs38a8XFmQp5k=;
 b=chBhnv6iFu5+C+8fdYfYdqxBRuCNvRQAQZdXMv/5fsby0x9Egg8gohS0pNlXEkihChwjCdAw23Wb9kC2s5DDEa/QckCAopVYxxIhYvCCF5auOlHBrK3BUC1fpfCS0mUzjaMm9sJxs1sKc63mAoN9f720fG6kapUHx8xL5kqzl5j1UwAlC37MzW4MMZX6Frib/6KCAYA6XfFCPIjGEwvY4VfUt9lbxcKFmXNmqg6iZrHnsujs83Z5n859rDanDGftQGv2yfSI8bT3KqT0JRGdfxFD5ujG//nN7T1JrYejR3lEzW6r8BL2z1Deyh8Cz7fBeCxN9W63p6rCQ6wzIbgMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/JdPBKRUr4XO+nVbc2d1/HBBREpiXPs38a8XFmQp5k=;
 b=ARJr7civpzDEApgHDR0KFR630Jh6m8+5EkofwGranFNI7f+ywh2xwx6+aySsmfaPF8ZclGOgXaA3baJ6B2vD5sjil+7h4cwPCZp4EEONMKUjrjIesCggvWbeBg4vQlHZA4vkgHCcBGVOv9thsjWE53IdApBMlZrds2mZ4JaE7eQ=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 06:39:10 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:39:10 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 11/22] drm/amdgpu: remove structurally dead code for
 amd_gmc
Thread-Topic: [PATCH 11/22] drm/amdgpu: remove structurally dead code for
 amd_gmc
Thread-Index: AQHaooVMVtt/bbMbu0OdBnlYnJi9kbGP+JMA
Date: Fri, 10 May 2024 06:39:10 +0000
Message-ID: <CH3PR12MB80744BA221D2E7380B7902D5F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-11-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-11-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5169c3ef-3ab1-4340-ba89-997589bf2bdb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:56:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB8918:EE_
x-ms-office365-filtering-correlation-id: bf14a612-5814-4b8d-d9f8-08dc70bbe67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tdFZ/y6v507pHy264BzODSMwlaZeoqpP5BVbGRakiKb+JatAwZnx69s/Vr?=
 =?iso-8859-1?Q?eZWH6t3Z8rlwtlkkSEKYTt9wVQ7eRdECktNW6I8U0GyA+kemMIJp1wjLk0?=
 =?iso-8859-1?Q?jY8pMw9ijLGGqfpjHCpt+eeYtyFXFpsvS/AigzsTnXbE0viLweSQz+qLgT?=
 =?iso-8859-1?Q?PADfEz+825DSVCRwLHYrGEutETfOo83m6h6mZ1w9nfzYmeBmXf3nbPJSTu?=
 =?iso-8859-1?Q?l1PsXNPlE4f8tnFrin6q3ERSiSWHbk6AFl58ewSxK3+cfv6pi72d3ZAHpN?=
 =?iso-8859-1?Q?JEFZxyqDrp26GpNjDdOGifnYodtQzGYnDhCugewLFINP6FlRvZupfflPEq?=
 =?iso-8859-1?Q?H3+IgW/xW+Nexs3jn/axqZbTOwZmtRrjIGjU/h2qA5I3lwnLm3iztOjW/f?=
 =?iso-8859-1?Q?loYUq4kIQxTPczoi6wkfHU8f6K3V66sBRceIP4Z9LP8QhX1f+Teg6jDY1a?=
 =?iso-8859-1?Q?Dqnm/wsPWte4r6ekbpMymNr3aPDVNQo39dXdOlXduig6SPBbrmLCrDrnKQ?=
 =?iso-8859-1?Q?Ute1pGsw5yimDHBX1Rl56K0WIb/+uLaiLUu6DJ7kmZvym/O5QNX8BnqgzE?=
 =?iso-8859-1?Q?ernYdbijsrj88pY0CcwripT5tVBgtQIy4xdHuHzzGmHjrmuu6WzmFZdRd+?=
 =?iso-8859-1?Q?oEWa42lRBWG37lR+jnONimwUZap69gKYwKM1Vc0BrTr3Oxr1gqsJujlivm?=
 =?iso-8859-1?Q?1+B9jb6JzBoYUkEwBmyKU/COVSuse4vA7FdkaajEjJDUWaTYBNsLAfnMCI?=
 =?iso-8859-1?Q?yAITbeTEMLQ7cOcD3dnjKhzx8Uk+3oQCQEDowpsJ2hgiXqyszihnIbjUG9?=
 =?iso-8859-1?Q?j8HUWmYHG/ODBdF6NnrEkoYzNMruLPHDdR2n5E1ozC5zvoAs1jAYkckDHQ?=
 =?iso-8859-1?Q?DNux8w8Tp8JhT+K9MSn3Ts8+wgaqMA756Qk56G1fKuE1E+gtQ0PBaeTjmU?=
 =?iso-8859-1?Q?3hQHFLUUHOR2x1/updtOe9Wqw2OUJ/wvlRYibhHEl6Aok9y8ZpeSjToTAW?=
 =?iso-8859-1?Q?OiA1QBnPFFCt8iFfZOHPBMYU2XW+nvxGfH3ARy19I57jqEu18AYoTWtBDQ?=
 =?iso-8859-1?Q?4zFHVN5b3mYAk4RUTIHNML5AmMmUjOT/549PMuoBse2VBHaA38sFsZzAQM?=
 =?iso-8859-1?Q?Bp/eexysOiAo+A21IoRRFndqSyZGi9OqLyXSG8cVYtC/rIW1U8CGqUC976?=
 =?iso-8859-1?Q?EsRax1DNZcskb7YePcOstvJ68eAw8JnND+1T9bSN3jXpcSmnep5j74cF38?=
 =?iso-8859-1?Q?7nvvYXrKjWfgw8j980OML4K8QLPgkeEcihQfNrDbLvOXHUXQsKNgNfJVe6?=
 =?iso-8859-1?Q?AkajnZS26ys8SsuzhBF2Hl2HVosCdLPhTfkPWJx4Dfem35jbTKIShiHJNA?=
 =?iso-8859-1?Q?KFaM1cPO8L4Cm77ZG3iXFje0flqm1dPA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NpGZKpofllHJfMtq/d7ARYqHlSIOLj36dPCxA8JjQfGmxYmaEmQvdkXkcm?=
 =?iso-8859-1?Q?HKf8qiVDTi3w8dKDdeW6jLB4KKOXHgzeVIWv4TL4CnP+ifVWEX4ErAUMnu?=
 =?iso-8859-1?Q?q2PdLqFm8X0won43DQRh79ZvMdRKibERZmsvF8Y4DQLEP7zh21uBNiIP5m?=
 =?iso-8859-1?Q?YZ9zqmTVsESlDINLl061PJ0lvZNc8i+3nhTFNxRCwPZybax17QNNiR6wWP?=
 =?iso-8859-1?Q?L16cfKOucILgXHGyx6NVq0E1Uk4Vssshy5CNT3nowZJBFZ07UmjKEiJFvs?=
 =?iso-8859-1?Q?IgIWSDpxylNIHfRPO1pDGGHFFl0QlRHCt4b764oqxcgpQEqa+AzI5YU2Yg?=
 =?iso-8859-1?Q?g6+o223dUgt+xxsMSoDofgwBBihRypVS1sqd5rN5DHoHnl+t+LD4DWdeWf?=
 =?iso-8859-1?Q?K+apGt0sWIe16ZxvvwqeOQ7nzqQBWNKyPzvuMBQgBm+r1tB+ny2LSpukIB?=
 =?iso-8859-1?Q?erLXItvOaNwNnsdPOFTdf5t5EYZ+TDvpZhIdo8O9r/9NsBxTiggpRiR1y0?=
 =?iso-8859-1?Q?330fBhomBRn6o2sNpbJPnFfFpPRK1/57MRukdoc67PZkRtKemFBJH1K2nY?=
 =?iso-8859-1?Q?18cdB9eipY7d5/OyjRNN0vgWOw6oikZCVw69dLah4o197BaIhsXz788sQl?=
 =?iso-8859-1?Q?qy6r1zOa6C56D/cNGXVzWgGtSpJpGJuBnP/L5k8k5Kuqg7W1xBJbornMWn?=
 =?iso-8859-1?Q?ickwLSXLBzxfq92e1UbMj3BcLrirp8M0eCXcI+V6vAUVBa6MCzBb2Yy+Y6?=
 =?iso-8859-1?Q?fc0/JP5X2NpM5kPip9hQdHBMljQ0punrWi/SzU0K1SwMxdQBevkwLPheoP?=
 =?iso-8859-1?Q?Yxzce7QZy3lP4oJtj6KoLgEKqkdyuRciZ1ucZcT4mkJHushM/uk5hzCHjE?=
 =?iso-8859-1?Q?ZOBCcBJIgm4QR/EV3a+VmISP0PJMoZWbFV70gcCMdkCaMS33YKc7RgP3za?=
 =?iso-8859-1?Q?56QwI1hHFLLR8WXs+iCs+TBQMgc7Mui47/lVmLqb/LT9fL9e5p7XBMLqrk?=
 =?iso-8859-1?Q?Vdnzb6JzYdUMW7jQLW9jWrTCNVKs2gRwOaNN8ts5MjknLjnBcE4Hw5n65a?=
 =?iso-8859-1?Q?9ZR6lZAf8Y/v1QgMSnvqvZWVlQznJgi/c6xlUj4kzQ21OjO5Og0wAlvPiR?=
 =?iso-8859-1?Q?rLgDbXdZfKevNXyqetb5yag105gazDBRNiki3tf+yE2PfuU36qWn32spOd?=
 =?iso-8859-1?Q?Vl0OsmNG5v3EnWzzk0Lr8PjaFCkJWUnkNSrh/QW69UaVK2XS0F8YjAdRDl?=
 =?iso-8859-1?Q?yJlIl0XlSmVFDDHNStlWV6WN/0mKx2S1NPrlyugK8jXKGVFUSIw5jYGnpM?=
 =?iso-8859-1?Q?FNV7a3SdwoatS9PC3Eb5op/DHNi1w1SO/tGXwEr7lpFOgsv1S4vQ5Y5iyG?=
 =?iso-8859-1?Q?xhFYLJDMFy3MM2yhe9Q4U102u7JxIs24jeEO2nrHq3fq9t3WjOl3n6Egx4?=
 =?iso-8859-1?Q?xN+IugucX6z356DPImHZG0hSVVtV2gAPn7BVHXubHt+1bjetuCnsWemlon?=
 =?iso-8859-1?Q?jSuOM08FN97QWdNURwetlHfkJMUXdcFOV5K6+ZYkw1HzUomzHgtaHxoiu6?=
 =?iso-8859-1?Q?y9IvLRezX1/8v2YoGezT4PEnUD1PPP1kegyBPkuBBu2lXgZcbbCa+eFLJD?=
 =?iso-8859-1?Q?6bjBC7myqlgQs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf14a612-5814-4b8d-d9f8-08dc70bbe67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:39:10.7647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UM4DH5hShWmQM/P7SrmPqw03lQry2VlYY8vNcLXgdHeffKJYJ2jXl4ZrzrQAryhLpbzRi23sDUugGDHUIUwQNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

[AMD Official Use Only - General]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 11/22] drm/amdgpu: remove structurally dead code for
> amd_gmc
>
> This code cannot be reached: return sysfs_emit(buf, "UNK....)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index a5f970fec242..f8ed886ffca3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1148,8 +1148,6 @@ static ssize_t current_memory_partition_show(
>       default:
>               return sysfs_emit(buf, "UNKNOWN\n");
>       }
> -
> -     return sysfs_emit(buf, "UNKNOWN\n");
>  }
>
>  static DEVICE_ATTR_RO(current_memory_partition);
> --
> 2.25.1

