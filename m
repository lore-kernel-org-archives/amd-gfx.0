Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C65C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 17:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A7010E4AC;
	Fri, 14 Feb 2025 17:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3lzJnoO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479E010E4AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 17:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgTL142NhNvK74NInS1p1TFwbArsQJ67B2Ky7iX5TqGG+Ztc4/de+kAp9kDkbQ4o1uF3nxTALq2s2L/lMquHWWk2pgFpqrKMiBYkIdc77SNaa7OM88gZrybTeURg5Eum/3YCfLW12tN+RRzgvu2vIU1JWIks3hLiOQcOU3mdVQdXtBjGIzxe4JSk/8COz3WvbceGmQjfyq+hxHbzhTUC7yavgovROgXNIE+5V/LMHmpNm57i27GvYolA0CV4TPKrQk+2L0pHvmbjUidilpJthXydoBA55ohaUL+CGR2KcEAdGyNjW/0Ko7GVYQCmD3Y0Hid61/tE8pzkl/3C3uH8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ1V0lUZGT5wenv3pSebyRKee7ackacTMizZBDbKbks=;
 b=rXb3m6SD7YSkLF//c7Y549244CMkPuXzmXTbdEsM2XO2mKfjP1lljVIdWii/HIfbdTFFASYIEGHvz6cht/MYROUWVilp+Arb5rC8Kh7jdZbN2MSNRQ0pq+Vnf0JPtI17Kk671ntrNCdTQ1BO5qMtUVzYEXsDZi0V8+2IqFgaYlwVN73gwPr3O1cnFGjBC44zXI+ZNDncnE2LekVUxe8StAHU/LmhlCoSx8SItOk/muvVNtI6vw9Dcw1f93NJNLEZxDNWbM4OMM0Zcojk+9Vxc3ol/Sb8loqN1eRdFoUwUlY7sgNPoa2xV1nRQT2cW80hjipnAfNMmj9Q/bFUOA7Nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ1V0lUZGT5wenv3pSebyRKee7ackacTMizZBDbKbks=;
 b=d3lzJnoOetE5OSEQV8VUwA9DOGoutmaRb9EZv6aR56WNBXm0h4WA0Vyw/IITdsoGvY7p7+SOu5DoBjzPG8H96QSXnwzpnIqa8lMeoowZL5MxyPC7UqstaCEv3keJA8WOOyRmYeA87dfI1Gpl5trCE9l23yg1GVRPB0EzOjOpaQY=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 17:36:38 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:36:38 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Index: AQHbfvPVkRimjnZ/jEuMrl0aS+yjm7NHARBAgAAC8QCAAAuhkA==
Date: Fri, 14 Feb 2025 17:36:38 +0000
Message-ID: <CH0PR12MB53727651D93D9CE233CB86CFF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
 <20250214151901.2071738-2-alexander.deucher@amd.com>
 <CH0PR12MB5372425560C5BE3E4FED28B8F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T16:53:22.015Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|MN0PR12MB5788:EE_
x-ms-office365-filtering-correlation-id: fa242749-598d-4e03-8ee9-08dd4d1e22ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GVtUuadwuKxajeehVNJ+6A5DblZXRyWP0+AO8JaQrYb7J7USMKnQDbMo+RbW?=
 =?us-ascii?Q?4XhfV8ZLfBPbZmHH9B1e4WsvA38bjnOQOYMLFEDvxZInwp7ibRVr2hYBzZdn?=
 =?us-ascii?Q?6KSSIswODR7DiFs1HaAlicxbwGRT5CaWFlQK6L22AXXWNruvHdJ2GYIQmJ9U?=
 =?us-ascii?Q?9m53UVf+bO8Q9WfMw+aZmc1V5muszzh4ysTRJ5zxzwLT4LeTDgFtjtRp1/xj?=
 =?us-ascii?Q?8tiSjnc1PyBGdqs/UMKLRK5i8rtjClXc84PJkYVagxn6ZLBbqgW4bujwwt+9?=
 =?us-ascii?Q?xmruBIQbfd07JoQaR33b/HyZP4RboCW9sw7IL6ctThxOZeJe1Z/eOBPXgNGD?=
 =?us-ascii?Q?OtqfRFvkkeJ+XtpEuAum6lhg1wxT2mvywXamJPBW92/sLiLB4B2j7vCMlSTb?=
 =?us-ascii?Q?gqRasUX41nwRZt/i95lsj+Oaxks0ETyC0v/VTqmUrhIL7b7DxofcEyoHMkw3?=
 =?us-ascii?Q?jOcWjCqQdoBEcdPpm0qCplwpqDs23hJ7+wvjNUsQgioFWJ0qNxSXGc/trzne?=
 =?us-ascii?Q?3ZUbXmrleyeS9wq1WdE+zb//Pzprf0AintKDysz5/gGE+pi7EawBz5hslDHw?=
 =?us-ascii?Q?dh7NPsKCwKC9/3NgH0xWuwlb9Tp9TTypLmTOY6ta0RAPK5R1dY9+8gZqJvjt?=
 =?us-ascii?Q?oSHCce5eTp1+u7dLYczNfUG6Y6pHVuGukmd4TvURHVYEutjc9XOhRTd6Fogs?=
 =?us-ascii?Q?ir0u7cfc3S2Rdh6wYXEFfQJOfO9ZNyTtcWbuGJDBtWsYbrPYhQHpZxR0WWzb?=
 =?us-ascii?Q?zJyarxZWnXXJrMnajs7Om8d7CQlfg8DK5VOyIU7Bobf40zE1WRyFXHtJPlaz?=
 =?us-ascii?Q?xqmh6soj1GKW8sStSKOZkdpWGT0CDzJDMKd/Y9C5VC7X5G9hRtN+Yb3QJVL8?=
 =?us-ascii?Q?iMagvKnUXVLyKBfZeag4I+l74YCG9amr5d4dQQ8btGGhD/eBcrUhbmYyAnPC?=
 =?us-ascii?Q?CH/MNMcSUYcGIvBbVrIxoquDnnPasCDrdPpkeqHXKkyIL2E95/lgAeXAL4Uh?=
 =?us-ascii?Q?iend89c/9QVtaURX8MGSLDxri7yXQ6/86ea3F57eBeOPSLfIV7+Abyick2Wd?=
 =?us-ascii?Q?wqfQa+rzhrxACy1Eo1xmWolvJo3rERBzlKoLwEN1QESgJ52OVfswpmYWJKH+?=
 =?us-ascii?Q?dMzOVnd8unbaRs+cW7NFdnEBW36F4bco6FetEZbMgMEjJXH04hFkO7ouKwS5?=
 =?us-ascii?Q?tpDltJRM54Xa7SCf/Ht+hTK3+ehlJ5JaFzjtRnI+A3KE8a3AdaS3jn0sECLu?=
 =?us-ascii?Q?Jnl2Zt7Qj3pTg5rndYzol8Ja0QoiAEIuj10BgOowoUUg07dS6ET/Nu2dtYd8?=
 =?us-ascii?Q?mu8SJH+KMect7+r5CqthSTGnQb6YmVGc6pQS+zpTJeNeb8yOovl+iRWxitUx?=
 =?us-ascii?Q?LeVKOSDBM2hHmEgU2jlLGEIbc4hPdpcZqPfZb1vCzpG7JPgG82FwPzKN5971?=
 =?us-ascii?Q?SsvjkXLm9Beq6zTrEPld+8oTGDLSWTco?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M5jEN3Z0JlBm2BD2+6stDZvOUzI3adX/aKhb9tl6uIvSNsAG7mGEWmKGTORN?=
 =?us-ascii?Q?sDHOfXCY4LrpbKLOSnLcd6uEGPwkb8YyAsQ2dCmkBixCFmjtHI+19G4PFy3z?=
 =?us-ascii?Q?y8XVfCcRhKbNGzUooDPgXIYD6f7KH+qJVYPeb93RRvDW6mewPhfREBf44aFK?=
 =?us-ascii?Q?qJ30JKOxwQz4Cj86Cqx0cjpRqUZZMZJUW/+czkU5k97iHdgVnpWMy4f96Iml?=
 =?us-ascii?Q?B2eDSKa025xQtAESy/kjEzGM4HzJbOyxKZMNT2ik+8QCp+0Mk4Nc8Jno723Q?=
 =?us-ascii?Q?kPG4kD2aTWcfMKm6+YcVsqstr7SGMuRqRnHL2gzeO/YpcbiArQEpaZQ08K0s?=
 =?us-ascii?Q?40bAK+6+5FDqo4wXzjXBCBM56cZNBWq1nhpDFAKBUMXU8+WRZCvI+a9qNlIO?=
 =?us-ascii?Q?y8WOp0q2Fho3d/PyGvThUaSX98iQphLfIjJtr+20BayRfwUJnb7ML2kMLzjF?=
 =?us-ascii?Q?XThn+iC20wHrYKKPqUnzpguWTC+IS3eKqFOp0SqheZVeXGW7U5wMWxgkVg0C?=
 =?us-ascii?Q?ipA0+G6dwFNmbuWzoChchYVtarAm/eugORxI+V1bFSbfzI/zq7FH64yjtMQF?=
 =?us-ascii?Q?CTjUUrv+PnqlXnRAyWHXP/7Qk3M88mUmjEikr469ddXFy4ZvtTyJPCnkVFug?=
 =?us-ascii?Q?o35H0ML/IuZf7ucwqE6idmeeJel82v51icNvVbupkD4Rzz/ygXj+zDzZayDz?=
 =?us-ascii?Q?N+qp2UqN8EODLXiARyS4ZCYb/DrQT/FeJfZjN2NmWmhT0TCDEyo8gO0XBtGE?=
 =?us-ascii?Q?xUCPX6luL9PdvEr/gLvCxHCplKvQeM4BMqNrDECPdUBDEry+SJi4bQYcTFDV?=
 =?us-ascii?Q?kA9fHDrjkUcjkb9VILpec5hcTydbug2YjBSCvCoAX8CB8tBp+1HkY4c9e6YU?=
 =?us-ascii?Q?MhFd2KtUQUAkEk+me8Uj/aRee1y4RM3PE9ohJ7rw95UlkmGvCjkgdC4vsASD?=
 =?us-ascii?Q?/k4A8hnKSMQoOrwyMip+73/GPHwVzMZJwjovyL5F5QHBCIL5i8qnenRwriQp?=
 =?us-ascii?Q?ZNamJsP477GZrdowSDcao1jiOtyXrwrIR/g0GOuyu+PXBaJ8tylHBD6QMVmB?=
 =?us-ascii?Q?AL7mpxAwMWYi5osiDh4ODUhClm/gXxitWgDw9pTHqy7qcj6ZUj5z3JO6XYeB?=
 =?us-ascii?Q?stKYHM1BWQVOF5NZd0o0sJpwHOfKCNBu6FX3c6Rn7zh48cwfnGwXKGU5LNYd?=
 =?us-ascii?Q?X21BL38FNhPSd+5Lu+lRBeBQzs0xfK+xrXuQqrQ862uzBJEGGH40DE0qYo1f?=
 =?us-ascii?Q?9c9f9/YmFrBIOHYgdmyWKBKhQKb9FVT4yinx+r1go27Ke6BD1VMQFOGQdq34?=
 =?us-ascii?Q?lhmNHL1fLT37CgSUlZ1D7GARr7k7D646Em7wV/FQd4CsapcFWwR0X9y9GXNZ?=
 =?us-ascii?Q?RL5wSuzV0Dt9hB3IIroR+y8u2HbgZtv3mgDyUIbpSHfS7DZqoYzaQm76Qtyu?=
 =?us-ascii?Q?NZd+316Wrqc0OGOAH/W4GZjPnaT5ZvAwFyX1bCVEWG+voAUSSFHH6Bljrtcs?=
 =?us-ascii?Q?ma/mIx1qWO34bT7TagszWSWljxnpvMNjmhTWwhK0aU4zgNrf/ecbzORYfjgV?=
 =?us-ascii?Q?+kM6CaarU+ZY+jpWszc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53727651D93D9CE233CB86CFF4FE2CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa242749-598d-4e03-8ee9-08dd4d1e22ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:36:38.2020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dk8iLDW8XTjkLxxG4oiIlAk/q4E4MJNAVz2JmYtbmGqYXm4aVZqwCtbZxmhWiEDnwGpFOuXgR8NBlqOY+3KRZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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

--_000_CH0PR12MB53727651D93D9CE233CB86CFF4FE2CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ok .  From MES point of view , we expecting  both set_hw_resource and set_h=
w_resource_1 been called all the time.

Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 14, 2025 11:53 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce


[AMD Official Use Only - AMD Internal Distribution Only]

I can add that as a follow up patch as I don't want to change the current b=
ehavior to avoid a potential regression.  Should we submit both the resourc=
e and resource_1 packets all the time?

Thanks,

Alex

________________________________
From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, February 14, 2025 11:45 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce

[AMD Official Use Only - AMD Internal Distribution Only]

I'd suggest remove the  enable_uni_mes check, set_hw_resource_1 is always r=
equired for gfx12 and  up. Especially after add the  cleaner_shader_fence_a=
ddr there.

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Friday, February 14, 2025 10:19 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once

Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 8dbab3834d82d..6db88584dd529 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,

 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe) =
 {
-       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;

        memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @@ =
-689,17 +686,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_1_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
-
-       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-                               AMDGPU_GEM_DOMAIN_VRAM,
-                               &mes->resource_1,
-                               &mes->resource_1_gpu_addr,
-                               &mes->resource_1_addr);
-       if (ret) {
-               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
-               return ret;
-       }
-
        mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
                mes->resource_1_gpu_addr;

@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)
                        return r;
        }

+       if (adev->enable_uni_mes) {
+               int ret;
+
+               ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,=
 PAGE_SIZE,
+                                             AMDGPU_GEM_DOMAIN_VRAM,
+                                             &adev->mes.resource_1,
+                                             &adev->mes.resource_1_gpu_add=
r,
+                                             &adev->mes.resource_1_addr);
+               if (ret) {
+                       dev_err(adev->dev, "(%d) failed to create mes resou=
rce_1 bo\n", ret);
+                       return ret;
+               }
+       }
+
        return 0;
 }

@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int pipe;

+       if (adev->enable_uni_mes)
+               amdgpu_bo_free_kernel(&adev->mes.resource_1,
+                                     &adev->mes.resource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
+
        for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
                kfree(adev->mes.mqd_backup[pipe]);

@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (adev->enable_uni_mes)
-               amdgpu_bo_free_kernel(&adev->mes.resource_1,
-                                     &adev->mes.resource_1_gpu_addr,
-                                     &adev->mes.resource_1_addr);
        return 0;
 }

--
2.48.1

--_000_CH0PR12MB53727651D93D9CE233CB86CFF4FE2CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Ok .&nbsp; From MES point of view , we expecting &nbs=
p;both set_hw_resource and set_hw_resource_1 been called all the time.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Reviewed-by: Shaoyun.liu &lt;Shaoyun.liu@amd.com&gt;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 14, 2025 11:53 AM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">I can add that as a foll=
ow up patch as I don't want to change the current behavior to avoid a poten=
tial regression.&nbsp; Should we submit both the resource and resource_1 pa=
ckets all the time?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks,<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Alex<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liu, S=
haoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&g=
t;<br>
<b>Sent:</b> Friday, February 14, 2025 11:45 AM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
I'd suggest remove the&nbsp; enable_uni_mes check, set_hw_resource_1 is alw=
ays required for gfx12 and&nbsp; up. Especially after add the&nbsp; cleaner=
_shader_fence_addr there.<br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Friday, February 14, 2025 10:19 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once<b=
r>
<br>
Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++------------=
-<br>
&nbsp;1 file changed, 19 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 8dbab3834d82d..6db88584dd529 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,<br=
>
<br>
&nbsp;static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int p=
ipe)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int alloc_size =3D AMDGPU_GP=
U_PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D mes-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union MESAPI_SET_HW_RESOURCES_1 =
mes_set_hw_res_1_pkt;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;mes_set_hw_res_1_pkt=
, 0, sizeof(mes_set_hw_res_1_pkt)); @@ -689,17 +686,6 @@ static int mes_v12=
_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.opco=
de =3D MES_SCH_API_SET_HW_RSRC_1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.dwsi=
ze =3D API_FRAME_SIZE_IN_DWORDS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.mes_kiq_unm=
ap_timeout =3D 0xa;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev,=
 alloc_size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;(%d) failed to create mes resource_1=
 bo\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.cleaner_sha=
der_fence_mc_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mes-&gt;resource_1_gpu_addr;<br>
<br>
@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE=
_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_gpu_a=
ddr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_addr)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;(%d) failed to create mes resource_1 bo\n&quot;, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D i=
p_block-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pipe;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; AMDGP=
U_MAX_MES_PIPES; pipe++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(adev-&gt;mes.mqd_backup[pipe]);<br>
<br>
@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)<br>
<br>
&nbsp;static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)&nbsp; =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_blo=
ck-&gt;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
--<br>
2.48.1</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif">=
<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB53727651D93D9CE233CB86CFF4FE2CH0PR12MB5372namp_--
