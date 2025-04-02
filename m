Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69659C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 04:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68C310E1CE;
	Wed,  2 Apr 2025 04:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N18Gp2qz";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED9210E1CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 04:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTY1t8M8TDHJr9Os29VVfyDQ1W4us9Dt6zNFwhUn6iOjMNEhi+hnmAPOG28UTa7TliFyB6NxHFbGxp4E5fmzOzuggUKYGSlSOUA/0Gny7ejLOUcyCm9MvNhBPa2vGNnc86yTodIZ2FMYCl+WdRoF1oDVFvMQXWweUk86qPik1odR2lEK2BXTMk8vd7+pOL+o7LAufrH7Lx/q7ZzGHe627h80YUrIwjz5aOhaXqtOG9N1XGjCyG0nXpBRcom6UX6g5PDtNLFIRQsAvnJWhUDh2/64LmoJ7x/vDBprHxmweopC9e4VtehjvA+NzSWWt+o9DFmSq6oBgshjG/TmgVZdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL0bLx8NTx19GFqiYGtjtDr2+3fVg6T/kQSPVBmf43o=;
 b=zLepqZY04aDqCiwo/abeQf6Bxuz7V2I46fxsj24Dvf6kgsHGNJ3+ei4cgUcnty+0PbB+wyGErvyIK7rin0Vdc5N1GrLFS+FfsZl9xyUSYQtocS5ngo4Pu0iln9z8d8FF3/Pg7d/m9ZlJUFmFWW1IQOpjbxNsJiHfVl7qP868kDKmZVQZUg+t0omFw5PG0Zn7sssHNT4nTEdkwhx5fcVKvlVwdjWTLkfwts5GmUi2DQjCB7bO7w+xVNigjJijjK+5x+3A4r0L1wM5S/VKv5qsqyJZhuiPKNGAdsztxCk98D4osM3e0K3crsrQle3dn4WKlPSQ+Po4PbWCx2Vf1wDV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL0bLx8NTx19GFqiYGtjtDr2+3fVg6T/kQSPVBmf43o=;
 b=N18Gp2qz9oengfGdcmIPvpCX+GkW/iUFer/KhjFidJ5FO5vlAGbdSVHcx967zG9DAv2V8FlFxxJmuTJTI+q9CesAv4d8h0tx99Es5h2ENyT2RWh5rojmjplW4DmxMxpzHCBmwOpd3PbtMFl61ZRb9PXazkcNNk65wNJXTMtEQV0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 04:24:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.045; Wed, 2 Apr 2025
 04:24:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>, "Yi, Tony" <Tony.Yi@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs
Thread-Topic: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs
Thread-Index: AQHbo0kH8/Mvq3lFDEK11Jkfo+Ibn7OPx4gQ
Date: Wed, 2 Apr 2025 04:24:23 +0000
Message-ID: <BN9PR12MB525735BCB7D07D42F61E6E79FCAF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250401205901.421291-1-victor.skvortsov@amd.com>
In-Reply-To: <20250401205901.421291-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fe21b4bc-a706-4e9a-8a72-1e7be8d4c7d6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-02T04:23:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH2PR12MB4230:EE_
x-ms-office365-filtering-correlation-id: 8321b320-a586-4c47-8211-08dd719e3f7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sC9I7u8M3Mc8B5fpvR5o6FDhg0KSTRI+/W9cuMvXHKDijLWjuK+2frSyZS2i?=
 =?us-ascii?Q?7Bm9wj88dWfb1XAa4nGupmM5hLLiPNl3b/e+4m4NrD8qYdiHZlC+D/btY4MF?=
 =?us-ascii?Q?QeuOCrgtjWJr5ELbPx4CaTQL9skaw6qLi+W5EDzV/eFVPIUTgLtpWZ9W81vT?=
 =?us-ascii?Q?vEysz7RN5nBJKpMlxXzSqvjuc5mi2sPF4NpWdS4HArk0fAqbX48FKvAjOJQ0?=
 =?us-ascii?Q?QTTVDbJH78yaIGwrubI/XQ0mgwbDh40Py+JMG82MHAw0Tyc1ZNEZ6Bc/cvSF?=
 =?us-ascii?Q?PNFrNxlu54C1IfDClUzgJUPMAlxzoTu/df+DU3NtdDYUJCye8ODK4niLOW9/?=
 =?us-ascii?Q?J4kBkHgwhVOJUkhaKVp806Qn2t6HgYlII0CcprtYWHxWyqXtTfWbhrwc4wK8?=
 =?us-ascii?Q?sfTWOnkdqBM0Bo8tHkuiOrrX/Er6GXtmDCzaZfS/uzAtRVwjp2y2Mf2dOW6+?=
 =?us-ascii?Q?trKzawfj7xMoIvEdEpoyT1OWikt9Qfec2vqgBJWVGnbA5rzRj7hTKaMPQKZD?=
 =?us-ascii?Q?ppQOdZrzt95wuDd57XXXbIhPCLKWeJBRLvbuu0nEk5OH0bO0e5THAswcsJ+D?=
 =?us-ascii?Q?6WEs5PTYEdwfPsnq9xv5TcBwZch+4NNePeLvo65Akj/TnHgkp3dHxYkjzlgX?=
 =?us-ascii?Q?0z3Dx3AKYch1j/9UBQiH3IglZeI4ttxFO7zqdPf42N3ISqVlmrDkOd0SX+Z1?=
 =?us-ascii?Q?yfD28ZnC83/NM/MAf+MX8+s3q9zgfA8/nRDtqKB+T4AvIJTFEF/GFzWjEfqf?=
 =?us-ascii?Q?QUjsB9QqBWhDJleXJnIxVQnhkm5oav6qgkvv2IDPAz/06LFrcaGS2euqzbGX?=
 =?us-ascii?Q?3i1JGQCCKuNICZIf8xIwmc0UKIwjI9/SszlEExtewcoHrNjlq0Ir2pEb07RI?=
 =?us-ascii?Q?9uidtsx2dkvaWnqVMpsamMOO+71ddGWCwTRr9UqsR3OcGE+5FFXemiziEWJJ?=
 =?us-ascii?Q?fvLNlzvppmjTqCUn84s9E1W47YmLZKN/SdzgGAkYA485hWvhR4OegHwVZveB?=
 =?us-ascii?Q?6WudDZQu5k4ABdOLRShxFG3wjZgIw8E+Ht5dOQbQ9ovS5OUEggF6QB+NzDwB?=
 =?us-ascii?Q?N8E4u5yxHP6nvfz40jxTxgye4o7+jcbOoopeMVgJtT/ZDkT2tMr4g09ZyK9Z?=
 =?us-ascii?Q?qB6WqeMy0RzUq+KtNoLXu6j8G0P9cm70JuL49JUufVHHdjDgU8FCAC7Zcg/f?=
 =?us-ascii?Q?c67NW32RTz4Jfswk+kCCdDW9u5ueY59tex3yt4W/5AavxHnn0bx3Q4yN0b8U?=
 =?us-ascii?Q?hOIdv9ZqVSFyw4pLmCH4FMoIlQgcUucqWeLaVEm5qAtSEvFr6FOnX37a+P5R?=
 =?us-ascii?Q?SwIUFf5dPwhXYx1wooOAi8WK1JcxXo5Prz6nhylePMtvymyh9bL7ajkmRHAu?=
 =?us-ascii?Q?s/fa3Gq4Av5TJ16ss/gYbJj2TNBdJchqyCOS8we+4mKJMtRTeovXmAeYkm/T?=
 =?us-ascii?Q?JZQ1EhdzVI49gf5oUwX60VDVq5INXqbq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4+el8Yo3EyH2I8pyBuWiTNU07+OE8Bxws4DUr+o8HLDIIuuKHzz2fAcrQsu4?=
 =?us-ascii?Q?Jp+VPsOF+TUeeeig3OHshW2a5u+0xTAKIvzhPjRLrtOoVQfTGGiX/onHNOTH?=
 =?us-ascii?Q?mlIwVjqImXg2sbIWpMsNmYbYbCwJimtrVrw58zRqMV1nu1fnz53VTek8hfuG?=
 =?us-ascii?Q?98S1a+b1zxBsQZs997VVsWtNV78BTZB29N6OBkMJz6P8u+4XEiAduMIrM4uk?=
 =?us-ascii?Q?imCZmTO+qSoyJVVz6VbQsSxGwvLpXfwHLVzkQ6afW0h3APVkA1QDme/Iwew2?=
 =?us-ascii?Q?op9H0QtBG9/gsOU3s9wyDJZiJHxmkssPo0ahuK7zr/tKXDp6rh/QoyQfo4lL?=
 =?us-ascii?Q?KNtIImhfIt0dFpVCWgGKhDPNp2tOvDJ91tdj+Gd8cwfFmCxKOtHAZQqWjSst?=
 =?us-ascii?Q?O2aiMiOxxKR4b4yYl8PuKuSHjC7wZxV1Jj68238X+ECSzeQ6Pu3G/LFrUk+q?=
 =?us-ascii?Q?YwBgUhj7AlqbiB4Z3YQtlyPECcZ8NLqnxcXjpQdubVaKy+Y5Tkib+5oYG7cU?=
 =?us-ascii?Q?Dmb+j4KKYqNVBUGa77bRUAtVM3uoAMhLKr/2Xm3TEz4YwzN+qd2aronFRbON?=
 =?us-ascii?Q?kcNiehkWROx6KGpxYFFKl2h+ZHrggHB27J8OzPKsnMuLPbSfB7BRirtYuNC8?=
 =?us-ascii?Q?9c6qWyBTyOe46OomqZROwKGezwEvH6MOuMCkGW5l9Tyz/DvxarXRJGr8CbrY?=
 =?us-ascii?Q?rVv1HPgjawu9NAGB0B8qY621dY5DgI6ZVZTW7j9Lplr/l2d+54nNEXAJ5WCT?=
 =?us-ascii?Q?zS71ePT0Iu1uvoSgHvsCxzcrpMQC36V6h3Nc5Pkah6GFLIlIfK1yUV8DMRxN?=
 =?us-ascii?Q?ZulID66h9YsljtjuONdzVDcDfJcu8QUkIExKShK4XGqSUfcqnb3XXm6SqQ+G?=
 =?us-ascii?Q?WACf/styafWe32RCGD8bSRCpD1qdGOQ3cHGJwPvjYOJRtY3ZW7QOX/19nMJZ?=
 =?us-ascii?Q?EGtDx/X5MTaKEqi6hE/KQLq586HK9drT+XpKh3wbzOLR5eSp/CjTGsOfJtnG?=
 =?us-ascii?Q?a4KoMBl8tJwVSxspQb5gagvQPGi01rBxFlBq//B9TQHNpcHDCHx78GYm37Ba?=
 =?us-ascii?Q?XhhPNY+GrDOzWIQOgTSfFWvMv8UgXfqGGeCVYPKDKcjmyR5HuR7rw+J08RqH?=
 =?us-ascii?Q?y6G3uW0cTBRq9RXsQKqHTtjVNQRrUFhSNtGHuxrs1u8nZDFXevM5P00OegnL?=
 =?us-ascii?Q?m0XTo4Zwfp/4t8hKRvrUzwJvudqc0hgaBeudrwKR8lm3EwIUTrfsZ5FBkmkd?=
 =?us-ascii?Q?TirGZ0CG7BHThfIZzoTOjexJ8RemCBhoGjLYICVSddVQyrv4atxw9nuYg6Zx?=
 =?us-ascii?Q?h4SaZm3NX7MHDAMzphU+otViVdrx6be3iqJ7QIcHq7JpZwzj2dr/idtV/btM?=
 =?us-ascii?Q?2oLQj58ZZ2WJZGA07PXNPxGmekw9BzEQX/dobxigYUMSc1d9i/F0E5sUkJMJ?=
 =?us-ascii?Q?q5ssSiS5YaWWGnqcijPZEIJ8p6HvDfOG6LjL7cplHXgHgDqzU3VLhOWFUUfF?=
 =?us-ascii?Q?H65Ra6CAsTX3JZipfnouOIPVjde5CR1cBmnUXT/mfQ3upwcW5Ml3qm57azoK?=
 =?us-ascii?Q?F2SREnKHPPsiqFE17Wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8321b320-a586-4c47-8211-08dd719e3f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 04:24:24.0064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+XnXXkT4yukV+ZyCSyd6lvgxFQ31f6z3mFwhuaSCDMtIi50Z0YsNg+RiF+SR+TNe8wiXYuCSsx9/MeL/jtmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, April 2, 2025 04:59
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Yi=
, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix CPER error handling on VFs

From: Tony Yi <Tony.Yi@amd.com>

CPER read will loop infinitely if an error is encountered and the more bit =
is set. Add error checks to break upon failure.

v2: added function pointer checks

Suggested-by: Tony Yi <Tony.Yi@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 0bb8cbe0dcc0..83f3334b3931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1323,6 +1323,9 @@ static int amdgpu_virt_req_ras_err_count_internal(str=
uct amdgpu_device *adev, bo  {
        struct amdgpu_virt *virt =3D &adev->virt;

+       if (!virt->ops || !virt->ops->req_ras_err_count)
+               return -EOPNOTSUPP;
+
        /* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich=
, the Host
         * will ignore incoming guest messages. Ratelimit the guest message=
s to
         * prevent guest self DOS.
@@ -1378,14 +1381,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
        used_size =3D host_telemetry->header.used_size;

        if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
-               return 0;
+               return -EINVAL;

        cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, G=
FP_KERNEL);
        if (!cper_dump)
                return -ENOMEM;

-       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
+       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
)) {
+               ret =3D -EINVAL;
                goto out;
+       }

        *more =3D cper_dump->more;

@@ -1425,7 +1430,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)
        int ret =3D 0;
        uint32_t more =3D 0;

-       if (!amdgpu_sriov_ras_cper_en(adev))
+       if (!virt->ops || !virt->ops->req_ras_cper_dump)
                return -EOPNOTSUPP;

        do {
@@ -1434,7 +1439,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)
                                adev, virt->fw_reserve.ras_telemetry, &more=
);
                else
                        ret =3D 0;
-       } while (more);
+       } while (more && !ret);

        return ret;
 }
@@ -1444,6 +1449,9 @@ int amdgpu_virt_req_ras_cper_dump(struct amdgpu_devic=
e *adev, bool force_update)
        struct amdgpu_virt *virt =3D &adev->virt;
        int ret =3D 0;

+       if (!amdgpu_sriov_ras_cper_en(adev))
+               return -EOPNOTSUPP;
+
        if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
            down_read_trylock(&adev->reset_domain->sem)) {
                mutex_lock(&virt->ras.ras_telemetry_mutex);
--
2.34.1

