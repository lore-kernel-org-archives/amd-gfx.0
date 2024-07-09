Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C60C3271E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 02:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6060710E3B5;
	Tue,  9 Jul 2024 02:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vjU/KX6z";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4326710E3B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 02:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyabtHpITE8/r0mHK4Tiu7tPpp/ahgCoSYJ6W6OZtUNHb8j6AwnGNFUu95dP6+ryV32trSPMqQMU6FnqGBNMF/rCW8FmSla+RfcMNc4MIduxjKTO05qY3XqGBeJ19dxXVlOCXDnRJaJK8Q1AipleRQvL99AmCZXEB+WRMr8p0zyYlzU0gD2JO1Kb+pIlhMm/PTnvTWI393g71MyCJjTCpaoySV7Zkpv4vRyAUQvioJqSb8TYDzc4paZeoEgZA/gWBHHIQ5iXsBDsXp0T2Qit4nOkvUv20Z7Ug5xebkgmH+7r56lpcYnkXZFj3dEw4WqI+fDt9S5btMJrn59RdhpYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p5+1icqFUfeVU8nr8Pb5cROo1OzxHrrk1PHr6D1aEk=;
 b=cNyQ1JhKaTgdv9k6xEewASvOZuRl3RBz4XVIpzKfkQSvdwRlPq1IJ+zTB0RMPeM5wlfVSZvrL/PHKMXsDjAjlSjl5S/dcLtRRjtaX68bGqAMEvYNyY0zy31Bo++x28fBMD1Xnh6uoo4R+WIL8tGBYIX7XKX6DxsziUEzaCWpuE1Suv5bCx78UdAYFd+wlNnj5M/yGT89ZYBtPPwOIKqmRlIfkUwYTb0vEZ7IsqvAvG1I+XH10FJ+zBr8ATs2IkRN5sJAGw0fHeEAo6u0euVnpmf4x8N+drQagwZPdAoBq91zYvglLb4inmVf19hoIuE1hP+a9RKP8yIugmZxi+bqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p5+1icqFUfeVU8nr8Pb5cROo1OzxHrrk1PHr6D1aEk=;
 b=vjU/KX6zGvbBJEBIEByum2/f01QGBN2Ew/5vZ2G1uGu4BdC7ljQ+ZKwaJne1uAfO9WVnEE0yYGdwJjQDe5msB13JG/Pf6D3jFjEuzYFikelAwWyvF6u1FXRuZ02gDtjH0Lxj5Mf8KrOxOjC8hJfPiUWNP2rVxFIcxwJWYbvPLVY=
Received: from DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Tue, 9 Jul
 2024 02:29:05 +0000
Received: from DM4PR12MB5230.namprd12.prod.outlook.com
 ([fe80::4290:52f4:8724:3dab]) by DM4PR12MB5230.namprd12.prod.outlook.com
 ([fe80::4290:52f4:8724:3dab%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 02:29:05 +0000
From: "Wan, Gavin" <Gavin.Wan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Thread-Topic: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Thread-Index: AQHa0Vs1V7HxUzFljk641NSP7NhysbHtqx8AgAABdNM=
Date: Tue, 9 Jul 2024 02:29:05 +0000
Message-ID: <DM4PR12MB52304F27C7B28D9FBFDB5251FCDB2@DM4PR12MB5230.namprd12.prod.outlook.com>
References: <20240708172024.1951-1-Gavin.Wan@amd.com>
 <BN9PR12MB52579AD521AB3758251C1AC2FCDB2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52579AD521AB3758251C1AC2FCDB2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T02:29:05.280Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5230:EE_|PH0PR12MB8051:EE_
x-ms-office365-filtering-correlation-id: 0276b8ad-7db5-44ac-a098-08dc9fbee776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?A0XR8Cw+ZmXzLwXjFKQNVIx5FD73MLJkjSQteP3ZdI+7580wjMTVms0IKrHv?=
 =?us-ascii?Q?pcx7i6ABQviZOpIzDhsbbFqfa8qwKKciZzpoZ8+7AJRRRr7jl4krBUbA1fGW?=
 =?us-ascii?Q?MMqq7gNemhiS1hHTUULIkxolsNeaQpRMoaK2K05jNoawPeLvr6XxDiFHCU+J?=
 =?us-ascii?Q?ZJXY5VS7B6bglsC1nmpxYeEHtHqiHt9FT1BpVwKlVa5VyoIadE76Fm03uGFy?=
 =?us-ascii?Q?NLVuszDtfbgcVu2CYeyEqjemAWMMhsviD6biqYqAg1yPpPYTmnke8ukpyQp3?=
 =?us-ascii?Q?E0GFg9c6u394ZMlOKM6jWxxZW0Q3HsA8Rxg3NVQ8vzoBMvWScXIVLrrgJ2Mc?=
 =?us-ascii?Q?HoBa23gN57CEWVpK5tv8Dh19IFFeqhEpJHCiPFjFg1m7zPZo4Kh81mvSE2jC?=
 =?us-ascii?Q?wx1Ovz6quqIHGSN4HsPZoe81MWFCWQBOoA7kwSKtmfaUrtLn6vVFzsJMvzHB?=
 =?us-ascii?Q?DkyL8uJmGlFm1l7HKIxn8wMacBILNROhSNG61vqFozKXVo3OeGqGlInGW1qx?=
 =?us-ascii?Q?tb+nKX9ureJdqK94QQoFof7kyHrRp4rP6ZZbuh3tfKnakc56ct4zR4MJSgr4?=
 =?us-ascii?Q?ghI5Evcrz1DJlKMToXgh+EesX5Ho+h+GJ1wG/zQ+Xabr6XXKSrkY+lIVXRdl?=
 =?us-ascii?Q?GFaYxhiP5XEHjVl+n4PLjVJLxqLgWSI/Do5hbM51HbKl1u9t8hZZ3oGt6UlU?=
 =?us-ascii?Q?tFanGxZOzFIfpCJ+yNsKVPiCMgZWKc/hdXh4PQIOYBXDi2TSEhKiL2tbvklT?=
 =?us-ascii?Q?vQ/fSJPzuR7tHGlLsAz/FixJwDkycGG1/rNIRY9eaZu28kBTtqSnIUHE3YVV?=
 =?us-ascii?Q?vG6XfIkylaJ+5t8WLUBb9l64YTjFBMD50tfdsNV87AjC3SfffBomJJ+xHfYd?=
 =?us-ascii?Q?NnfJzOfrizz2fY5T7WETcF6cLBQWoLb042+hl/8sGuHWIAmOY248B+iA62ef?=
 =?us-ascii?Q?VMr42rFQ96e9ylzAI88S3oajZr2VUjRfFpT0IlnP82b2BjczLlNUISPStlf6?=
 =?us-ascii?Q?ZoG0tjcxbBqsSr5nAh9/b5AU6k7m5lL5MxFyX5r6VYJkvgNT+c8K+xE1v6MI?=
 =?us-ascii?Q?uOO4XDZOckXE970/vyri6GCKZ7V/fmlaCRLfJqoQRoTOkjWkmiSx3sZSMrfa?=
 =?us-ascii?Q?6cM3BDvdgGify3ZGqKXOwesRy35cpSivs25V0yzwJKgfdsgoyEGyDHaer11f?=
 =?us-ascii?Q?wuLaHs9DG8JAp3h7jCPDEMno7NvzFFmP8QCeBGE9KmeedFx0xYMUQLL4FDNQ?=
 =?us-ascii?Q?lgQIGLLa7XWEcz07HUbZ+7n25M7HJoOSe8WDy7ZlDYnYPhQLjSMQeCR/adhn?=
 =?us-ascii?Q?GKFM95CXPKE60k8Ma7D7EBP2upKwCpo0RPvH+AS+vKrvRwJj7rCXmEj3Ydi9?=
 =?us-ascii?Q?lWrJWkTGMwuvBEzwM8cNGz0z2loLoLPqp4pia0dFOYPbQDBOKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5230.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oLC0rr5kIa8OZSKw7w+VXadJ7kZl8ec9ZLhYPUYhhbFmRm4VfpQbpG+zkul+?=
 =?us-ascii?Q?bg4RxlcdD4Rxja6IsBPfKr8fbETP27f4Q3guEugMgvmB/N7dSlEeMTNTc0KT?=
 =?us-ascii?Q?WFI81Bzr7+2J6A+xbVZ/FRzZVbiicsPqp1yz1R8+jLPfAq57mDTVf5yfDzsj?=
 =?us-ascii?Q?TKPRGTo61KlxuUI2auWWKzJReJ4xfieFKHWfkWx33QtPCGX1IOFCMJh80wp3?=
 =?us-ascii?Q?VZIz179wBrNiiagEduqrNd7bwiCy7WACbUcv8+EJcYqNNy7oq09/Km3SSJpd?=
 =?us-ascii?Q?ESaptG5XWnQydXWwulJkcdkx6y7PnGKHnFJF+jctUfh3k1uifbpqBUu4HfaY?=
 =?us-ascii?Q?pzaz7EEG27wdunwxAqdg9+9nuwnENTsxPkhO2mUXlO/ZRnXUXG/4xRKz3aSw?=
 =?us-ascii?Q?CBeeVlkEpW+KEbqBBPDUvP010kgH6rOQRU8k6oiBBNvwpz0ytZwNoM+KkJes?=
 =?us-ascii?Q?CVIa74JXa69fxNZcFQihtK+j7Bqspsqfnq/RY6ChwbFKOXiLQLpbm2jYeSez?=
 =?us-ascii?Q?MNdSrIbxxxKGycEYteF0fIYrSaccxAgSnaeSFPXVh53/x8jh6s6awz55fF+o?=
 =?us-ascii?Q?ww2xQziG6rFRxKPTFWxB8HbQLHsKlCToQXhFJ4xRDMqXRmKksY5uz4Su4eAw?=
 =?us-ascii?Q?NUIDrjzhq41Jh6bIB/1xERi2ymz4/zG44BnXgsndi4QNTim82t0//+fDlyM1?=
 =?us-ascii?Q?RKoEDzHo/pWzLCbLJNtjvcbO4bEICsZ468PQsAI9kwPPt8U/0IpMic8xkYp1?=
 =?us-ascii?Q?7DpcK2aWcz9aLLc7AdOwg01v9WhyvQ+XMAHA9ucEvIEv7469b4EIibr9DBpG?=
 =?us-ascii?Q?mgiZkgo66xbf8WVEkUmM27uPhI2MDMzxhvenfer47HP6oFQTjPWdu9PjjJft?=
 =?us-ascii?Q?xsTXayABkypqO9BSUFRkFWQFKZRXifVBew33+RWntzpHY4zVx5+TY6SI3Si3?=
 =?us-ascii?Q?+7aQZnInoK6qBQtAUHsvffqumITpDslzQAmWbK6W20LwuYjokPGYRNWr9jZe?=
 =?us-ascii?Q?O5RyQjt76BOlZKUurVHDHVnEPL2eURqenuW3SZG6ehkOYmkwiP0y2q0n55Ma?=
 =?us-ascii?Q?FUVmoMhMFwBn4mGGly49wu1bTcAJ0RQ+3//FOYYNHkoNgFrjiczNbLCvr4RU?=
 =?us-ascii?Q?RHwKZDUCkxzETYwPeognBZM56i3MuwLa/aO3az+3/OUqwx60YJtbrvjQcLS8?=
 =?us-ascii?Q?Nl4kv2E4ywC+lJhXQk+fFUkq7FWdKvYJMNZAL7RBJrSDQaNT8wc4Vn3XMuQQ?=
 =?us-ascii?Q?H7HUzh9r7HaCx622wLwsMuEUA//59+FvulzPoep4JB68u+BV+WFAIGCOgKvq?=
 =?us-ascii?Q?ujbssLNhLuC1jVi/yC+feHhJTnMpZuIBYouvd9cl6WpMLnAS2a2Z5TH/PmLW?=
 =?us-ascii?Q?R/P/ftEyM8AOFLAsoT1UAefWdQriZ1nV6rnvQZI803+HxxCCDS7BcH59FqcI?=
 =?us-ascii?Q?zxf7HJVZ6KdYNBMUvg7qbnQUIY4Yx5ec63sdoJ6affcK9F0DBDj2rTRCwE7C?=
 =?us-ascii?Q?dBNqvsWe+ir3aMpwOqPNNmeCafoOTioPK7eq8H1e9tPdKTz1RtwoLSzoFZTd?=
 =?us-ascii?Q?aP6Mw0adsQ7PRGYj5cY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB52304F27C7B28D9FBFDB5251FCDB2DM4PR12MB5230namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5230.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0276b8ad-7db5-44ac-a098-08dc9fbee776
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 02:29:05.5534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xKwaS5wyDtaoqklrx4IgMZtTHSmWYIdNyAVnStlUR0k8+YN3HJla5M5LQ9/N8z4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

--_000_DM4PR12MB52304F27C7B28D9FBFDB5251FCDB2DM4PR12MB5230namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Hawking,

Fixed the typo and a new email is sent.

Thanks,
Gavin
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, July 8, 2024 10:23 PM
To: Wan, Gavin <Gavin.Wan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping=
.

[AMD Official Use Only - AMD Internal Distribution Only]

Please correct the typo in description
CLIENTID_SDMA2 and CLIENTID_SDMA2

With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gavin Wa=
n
Sent: Tuesday, July 9, 2024 01:20
To: amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.

sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3. For Even numbere=
d vfs, the sdma2 & sdma3 (irq srouce id
CLIENTID_SDMA2 and CLIENTID_SDMA2) shoud map to irq seq 0 & 1.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Ie850114932ca98ea3c9176370dde5dd393ddf7e7
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..4516cb0b3ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -82,7 +82,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
        }
 }

-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev,
+unsigned client_id)
 {
        switch (client_id) {
        case SOC15_IH_CLIENTID_SDMA0:
@@ -90,9 +90,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
        case SOC15_IH_CLIENTID_SDMA1:
                return 1;
        case SOC15_IH_CLIENTID_SDMA2:
-               return 2;
+               if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
+                       return 0;
+               else
+                       return 2;
        case SOC15_IH_CLIENTID_SDMA3:
-               return 3;
+               if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
+                       return 1;
+               else
+                       return 3;
        default:
                return -EINVAL;
        }
@@ -1541,7 +1547,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu=
_device *adev,
        uint32_t instance, i;

        DRM_DEBUG("IH: SDMA trap\n");
-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);

        /* Client id gives the SDMA instance in AID. To know the exact SDMA
         * instance, interrupt entry gives the node id which corresponds to=
 the AID instance.
@@ -1584,7 +1590,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amd=
gpu_device *adev,
        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
                goto out;

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0)
                goto out;

@@ -1603,7 +1609,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struc=
t amdgpu_device *adev,

        DRM_ERROR("Illegal instruction in SDMA command stream\n");

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0)
                return 0;

@@ -1647,7 +1653,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_d=
evice *adev,
        struct amdgpu_task_info task_info;
        u64 addr;

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0 || instance >=3D adev->sdma.num_instances) {
                dev_err(adev->dev, "sdma instance invalid %d\n", instance);
                return -EINVAL;
--
2.40.1


--_000_DM4PR12MB52304F27C7B28D9FBFDB5251FCDB2DM4PR12MB5230namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Hawking,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Fixed the typo and a new email is sent.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Gavin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, July 8, 2024 10:23 PM<br>
<b>To:</b> Wan, Gavin &lt;Gavin.Wan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wan, Gavin &lt;Gavin.Wan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID &lt;-&gt=
; req mapping.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
Please correct the typo in description<br>
CLIENTID_SDMA2 and CLIENTID_SDMA2<br>
<br>
With that fixed, the patch is<br>
<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ga=
vin Wan<br>
Sent: Tuesday, July 9, 2024 01:20<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Wan, Gavin &lt;Gavin.Wan@amd.com&gt;<br>
Subject: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID &lt;-&gt; req mappi=
ng.<br>
<br>
sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have<br>
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3. For Even numbere=
d vfs, the sdma2 &amp; sdma3 (irq srouce id<br>
CLIENTID_SDMA2 and CLIENTID_SDMA2) shoud map to irq seq 0 &amp; 1.<br>
<br>
Signed-off-by: Gavin Wan &lt;Gavin.Wan@amd.com&gt;<br>
Change-Id: Ie850114932ca98ea3c9176370dde5dd393ddf7e7<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------<br=
>
&nbsp;1 file changed, 13 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c<br>
index fec5a3d1c4bc..4516cb0b3ae8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
@@ -82,7 +82,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
<br>
-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)<br>
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev,<br>
+unsigned client_id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (client_id) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA0:<br=
>
@@ -90,9 +90,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA1:<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA2:<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; (adev-&gt;gfx.xcc_mask =3D=
=3D 0x1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SOC15_IH_CLIENTID_SDMA3:<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 3;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; (adev-&gt;gfx.xcc_mask =3D=
=3D 0x1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1541,7 +1547,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t instance, i;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;IH: SDMA trap\n&=
quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(entry-&gt;client_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(adev, entry-&gt;client_id);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Client id gives the SDMA inst=
ance in AID. To know the exact SDMA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * instance, interrupt entr=
y gives the node id which corresponds to the AID instance.<br>
@@ -1584,7 +1590,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amd=
gpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_supported(adev=
, AMDGPU_RAS_BLOCK__SDMA))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto out;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(entry-&gt;client_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(adev, entry-&gt;client_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (instance &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto out;<br>
<br>
@@ -1603,7 +1609,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struc=
t amdgpu_device *adev,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal instruct=
ion in SDMA command stream\n&quot;);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(entry-&gt;client_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(adev, entry-&gt;client_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (instance &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
@@ -1647,7 +1653,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info task_inf=
o;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(entry-&gt;client_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance =3D sdma_v4_4_2_irq_id_to_se=
q(adev, entry-&gt;client_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (instance &lt; 0 || instance =
&gt;=3D adev-&gt;sdma.num_instances) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;sdma instance invalid %d\n&quot=
;, instance);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<br>
--<br>
2.40.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB52304F27C7B28D9FBFDB5251FCDB2DM4PR12MB5230namp_--
