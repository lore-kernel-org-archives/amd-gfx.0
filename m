Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8941E7E0B9
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 09:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFD510E012;
	Mon,  9 Feb 2026 09:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ia14uRHU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F30410E012
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 09:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd4C62yVS35+09ZTcZTKpIgObfb0sV8+pGNTzf/+VjUm0E8GNW1x+O93BOvyvt+hN6YfnDqlXIadsgbvn1lhrk2Y+EMUMzHEaduo6iG9X12MQjSa6Ut9iosaKMRnbkKW8iZSiZHC1pBb9axwwcExp05L16LOb4X7TDvKrk4cwyzAaUSrw7YX3sr5K3B1YsRMi21fD2LbAyE3oMgLnfvr9eKU9B1/RyhuKnP9pQ95EGFOg3LbVgF4ubQKD5Ip9Lqtxb1wu5z+EYCfCrcIkosDIOaKmnWoS2x7Dcs3hMNTelLzDqhCLzZwaZemPY7wC7uQ4MXnsLgPgjVllwthGgiOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVurcLk8fN9H+163LAc8IYzMkX6PmW7hlEK6G2u/8G4=;
 b=HULTGaWG2Vo/2xj5MV9KkduPNtSfYXilRDfYjCyVe/v/ubU/NRvVuVwell2YVUqHRbu/XcKQjZ1CknaZbYIhqswilEMlbnaehcYoxOrt/Vux8lLaq6n7/RgbEWBojseviBy79BUD+KcAapuMiME6mWlCDrcayM0jiKiqFOoHROAy05xK9sz8wZVZHPq2jhHoXA0OKoq0ekPu6S2qHOtXCJcXqNelYqvXkrwp2fcsDvpBvTNI2gy8lToOA8hZqPqEvn/PYhJVhkwJzAglqJxMadRAOu4Ke+IjxFGBIt4696HkoxNT4lBEPEDIo97fU0hr7nzmT5OvGClPI7FUHaCITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVurcLk8fN9H+163LAc8IYzMkX6PmW7hlEK6G2u/8G4=;
 b=ia14uRHUJb8zm+tograV33Um7BfGrp1k7j3AYQUcIRgTO+yu6W8jdDZXMljFA69LmZ+6osfM7iUWcyhGbE5ZyitN7wesqun+tB/plMAGx/gq37ZuZiZruyNS0dggS9q7vuJHt6b5mCZ+Yc3egM6npcIwiBXcsRu1y9q6atB0mn0=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:51:44 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:51:44 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Don't propagate errors from amdgpu_vm_flush()
Thread-Topic: [PATCH] drm/amdgpu: Don't propagate errors from amdgpu_vm_flush()
Thread-Index: AQHcmMQFcYr7xztpiE+yetRei84Kh7V6HvuAgAAChoA=
Date: Mon, 9 Feb 2026 09:51:43 +0000
Message-ID: <IA0PR12MB8208C4A6ED62884D4AC130EF9065A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260208062713.1500367-1-srinivasan.shanmugam@amd.com>
 <65a74779-bcf9-4d19-a1b7-ca0b148dfbda@amd.com>
In-Reply-To: <65a74779-bcf9-4d19-a1b7-ca0b148dfbda@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-09T09:50:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|IA1PR12MB6628:EE_
x-ms-office365-filtering-correlation-id: 2ad304ef-2b77-4e1e-8096-08de67c0d51e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MkFTL0txYmU4T0M0OGovN0hFK3ppMFZCSFRNa2d3NU5uRUJtUkVaY3JYRDhi?=
 =?utf-8?B?T09ibUR3TDNCa29XY0EwV0JaQ3dpSjM5S0tyWDE3UVJGb1BvTS9BN0lYUHMz?=
 =?utf-8?B?NnpoZDBtQU5URm9tZ1l2K2tnMDhhMkxFQVdGL2ZIWmo4QkxEbU1aVEZtNTdW?=
 =?utf-8?B?dVhjQWtnRXdNTDRVdmgvSEZwUWNLQkRDWksvNitVN1JWNGJ2RHUxZEhNM2dt?=
 =?utf-8?B?SjFkWVlYMmFMLzF0STBZelpwb2pYanoxV2FzRFhweG1lQUxQK1lPcTZIamU4?=
 =?utf-8?B?TkVhSHRTWWp0aEVBZ0tCVms1clhzS0h5bVVUWVBOWlQwZTJrL1BXQVRUSStV?=
 =?utf-8?B?WTZERDJBVGpCSVlhWWZ0U2dramhvTzJ0TEN3R0IrZHJLNHhoWW5qVUtxbVd2?=
 =?utf-8?B?dGRwRlZ3NllSc055YTg0eE53N25uOVhOVmJ0aXk5SkZYNFU2WWU3VHFwc01P?=
 =?utf-8?B?eUp4ZkdURW53MzJnekNiWk1PUVpEb2NpaXdaaEpXMjB0a0FFM21LY1hJeWhG?=
 =?utf-8?B?TDd5Y012RzdRK1VGcnV5cnpKU1E0WWJiVmpKQXUyd2Z1dnJzWWUrUUVuUWZW?=
 =?utf-8?B?WTcwYU16TmJ2Wk8rK2lnL1Zyd0FuTDJRVlB0RVVIUDRJSUFtZVZzbzZJMFVt?=
 =?utf-8?B?YVc1MVE4L2ZQMjlZUis0RCt2K2hQdzZUdUpTZ3V2M3dXZFNSM0p1KzhvZWhY?=
 =?utf-8?B?MXlGcDlzbTFMcDJhQUd3WFdBODN4Q21FV3JpNXA1bTllTDNrNnFHQVZBUUZS?=
 =?utf-8?B?SFBTbmNpS0ZXN2gwcWZVL2tBeWFUTkxJa2hZS1IwZ1VsUHA5NDNZb21uamNH?=
 =?utf-8?B?aXI3YkJ1S2pKNDZoMEM4cWlZV1FRYU81Z3phZ2gwcEFnVHkwTlBkaXAzamVX?=
 =?utf-8?B?T3ZCOXRFQnJma09TbGZtb1ZqTXIydW5QdWdPS09LcTNUTDNZUlBvMGFkYUxL?=
 =?utf-8?B?U1cwcHdsUTRiM3k2WnpNVEpaYTdoYlN6VlZ4RWFnU2RPQTJjTDY5ZEJPL1l2?=
 =?utf-8?B?VVpSOGUwL3NTc1RjeTJKMjJVd3NJcmFmOWF4ZHhDbEFqbkd6S0phNmJQeTdy?=
 =?utf-8?B?ZUI0VmNxSjhGYTR0RkQ4K2N0eXFyWXFkNFk5WGVyazN0SC9VYmYxeGlaSTJH?=
 =?utf-8?B?dHdUY1ZGYjdScUljZEtnQTd6OWZQU2lpcHgzcmdidngwL0lZSjdpYXhtWGY0?=
 =?utf-8?B?RjJWYWpXVnpXUlVlVFNBajJWNTNPeHF1OVBnOHphWExQU3FQSEtzeStHcnpy?=
 =?utf-8?B?TVJpU1RLT3hZNXdaM2F4ZktQQUFwTkJ6OVZHOGxPTmp5RDlEbllqRW5xMGV5?=
 =?utf-8?B?Z3Q0MWRHOE55UVQxMjUwb2o4eUpXVHo3SXRQTWN6bkJ2Z3B6cnY2LzlxWGU5?=
 =?utf-8?B?WVg3VzlydFhpT0VHYm1UWW9rcWJtV1FoQ1JqUGJIVW4rMUpSLzRqcEZqVVpG?=
 =?utf-8?B?UFUwN2hEL2FJV2ZYOEcwM3FkeEtta3kveFF5QWI1bGZsR1UwbFo0R3BOTmw2?=
 =?utf-8?B?anorS3VUWm5Cakxxc0FVeHNGNzZtbmZwY1hVaENuQWJsd0d0U2lUU1phZGIv?=
 =?utf-8?B?VW1DY1kzeTlsM0VpSWZNYlVvV0lVR3IxekhkRWdSZkt3dlVrRWNzTytWMVU5?=
 =?utf-8?B?SWpaMDlCK2VmSWNtcEYwWWI1TGxoVGt0K2oyRGkxTzV3NzE5R0JHUHpyaWdK?=
 =?utf-8?B?aDAvQ3pKM01LMXlzSDVwYWdsTGU4QjBEbGNNQVV1Y1RBem9jalRyZ2hLT2V6?=
 =?utf-8?B?MlN3N0VhKzdEaVd5ekNLc3RYRnVFY1JpYmt3LzFvdUp5dmd3VkNxNVN3M3A2?=
 =?utf-8?B?ZFNoY1FBMUVhVm42dEozdStMRVpmRTBQZjQ0eWZqMllxZWQ2c1JoSzN0NVFt?=
 =?utf-8?B?TW90bWxqSFZQZUxhbktaR1pmMkhybGFiSjBFTmVkdjViZGFGUFlTWHlvaFho?=
 =?utf-8?B?K2ltQ1I4ZlROMjBIUGZxYzVuVzFFL0dlMmFVa3YzZEV1emtJQ0JjUXBQWVgw?=
 =?utf-8?B?TGF5RXF5RUc2U1Nycm9vZWxQTWhoZkJ6MGdTa2IwQjFGZXBTQ1E4ejYvL2Jt?=
 =?utf-8?B?WTlrYVgrWTJBd0J4NTBESGVJZnFhYkdnMG9QbnBOYWl6QnVuMzRsQzFVMXQx?=
 =?utf-8?B?TG5XWllFUG5KZ2hqMFhtYnk3S2g4dzg4V1ZRNElObFo5SlBidWoyR3VpUWJ5?=
 =?utf-8?Q?ENdttaZIp7HT99PWvtImHVI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWFXV0dwSE15WDdZb2FNa3YwUmtST3pSZzJOSzdRc1Nsa2lNSVo0VzY0Sm0w?=
 =?utf-8?B?MENmK2ZTWWRqU3hpdHBKNlRqWDNOSVhQNXB5TjkzdHp3U0M4TWtENGgzdlJt?=
 =?utf-8?B?dDlzMkthNFBJbHZNdk5MYk44RnBsWXd4WGVRSmVSZ01qekFudkVuQm4vWUlN?=
 =?utf-8?B?RGZISHNXRDdCOS9pVWZuRlhzNFE5aVBvOU5wL0orVi9EZHBNb1UzZjUrNkhQ?=
 =?utf-8?B?TUh1ZkhQcGQ0R3Z6N1czdjBTQnJGSmJjVHVNZnZCUUhsczcwMjEreWhZTDRk?=
 =?utf-8?B?YUFuNDRDS0l1cWdzSTBlS1hEYVZ2clJPQk9EbjZkWis4NFlpMXk4OGNqNHZj?=
 =?utf-8?B?b3V4Qy85VHRQeUNpTnYzTHJYMW54b29vZ1lJcG5DYWZQZUtieVY2YTJieHVh?=
 =?utf-8?B?ZmpFNEo5YU4wbVlWT05FalB0UkdBY014MGtwbGo3QWJKaFd6ems1RDJuWlly?=
 =?utf-8?B?ZGV3aE55R1BnUGRxQ1Q5dzdCVFhpOHVQZVZEamM1Q1ZjcUFLTWRXQlZ6UGFY?=
 =?utf-8?B?a1VaYXRQeWI1QWVnUGNmeEdVZDYyNkJYdjJKUERsTEtxQVoybVE3RVRrLzA2?=
 =?utf-8?B?c2lMdUZZeW15V1BuNmtqUlBUbk10d292eWdpVllzYk80RmQ4WXJYazlFd1Uv?=
 =?utf-8?B?VDBEUzJmQjYzb1dHaHpweXJ1YVZEdSs3c1draWJjWXU2Q0VwNksrckxST0k4?=
 =?utf-8?B?V241QnRYMWhsbVlFVjVKdVBGQjVVUWpPcDNCU1NGdVo2WTBzQW9KemJZQmV2?=
 =?utf-8?B?M2pBQWZnS3l6NHBocmd5MlZLQXhmWmtYb3RwU2ZlU1NxZnEyd2VVV29WRGlO?=
 =?utf-8?B?OVc4aW44aWxKRE4wK0RiTTRZZ25qVlF1Mzh4L1dsYVE4bW5TSjhKMERTWk5R?=
 =?utf-8?B?ZUhDUlBuUGNuakU2SDhFWlZPdm5ydVpUWTNzVWdFSHY2c25tMi9QalAzczhH?=
 =?utf-8?B?dFBFeXJiUkw0L2xaK3Q0bVY4QUZBbUswcjBOb3FLWUVvdTZWTGhXZGhFOTVn?=
 =?utf-8?B?VG9YWjZFcHNmRVpoS2VwNVN4UlFlbFBYdjFWMlBqRmJOcWduVDUyYjBMenBx?=
 =?utf-8?B?TE9TcVV3aVVKRlBJeFplQ2IzU2xBeUtwd25JVXFCQVpMKzRxc29IN2dFUlNF?=
 =?utf-8?B?U2t2VGFEeEduakU0eUJjUC9wL0MwSmxBdC94bWpndGpZM2xYRlZKOEtqZXB2?=
 =?utf-8?B?MWpqK3dsTERBUXhiQzBzUWlYVllVb0dkUFBkVGt4S2x4YUlUU2hZMHhyQTJG?=
 =?utf-8?B?M2dXWStUcHh6dXR0YjVKU3lvOWtkY2xnUzRoemlnUHNtdGMvLzdMN01qQ3Vh?=
 =?utf-8?B?TkdBM1FTenRtUGY2ZFB1WjBpSm5rKzRHOXVNWW9weW1MSE1Hbm9FYWpON0FN?=
 =?utf-8?B?ZklrM3RnaEg3SmlpWHV2OUZJOVpSWTZSRDdTL3V5andNZFc0dExSU3ZhREl4?=
 =?utf-8?B?TnZzQWFpUjVpZGdnU0Nqam8ycW04RmJnLytiekNWcURadVhSL0lRUVdBTmpa?=
 =?utf-8?B?Z1JhT3ZzY1lhbmhwZ2lGVkdkaXNmTVdtN0hHelRlTndTb3ZSS1ZSRE9Eb3VY?=
 =?utf-8?B?L3kzbHEzZk1FTm0yd2NPajZFMUd1Y3MwQzhTQzNDSnhvM0paVVdQNUFhU3ln?=
 =?utf-8?B?Qlc1TlR1YTZHS1dHZEFOdEdLaFpQZFBncEtOVForaDZFaEpUVThwRi9kZGpl?=
 =?utf-8?B?Z3lDOVJVWWp3eFpSVUF0QTZYRXF6Q1kzYVpYZlQxbkxwdENick5MbTl3Rkda?=
 =?utf-8?B?OS9RVk1wSkZqbVpXMlNkTHVLdVB5WFlzeXlPek5kcVFMK05YOHByZWMwUkxH?=
 =?utf-8?B?MStMQ0tvU1NJSHhSWk9aS3g4cjNJWUVQWnRkZ1ZLRzNFdDlyWVJ2SXhTN1hZ?=
 =?utf-8?B?ZzcrZElEbEdkZGZ4MGwvTW01SDN3VmQ0OVZZTDVKcUpoR2dVRWd3QlZma1lh?=
 =?utf-8?B?cjZHZmlpb3ErUGcyRVR5aDVnVG51UU1yYmhTTVIraUFlU1RlRStISFloYklD?=
 =?utf-8?B?RHJtZTdEVmx2V0JQNkR1bzY5NzZRZ0VyOWJ4WmVuMGxVeXNHaUNSNVRsYmpo?=
 =?utf-8?B?VTVEcG0xZ29LbXhncW9taUdsaVNza2pDeEtDY2FHUVpTL3NsTVRkaGJ5c3VX?=
 =?utf-8?B?MFZYdVNkNWptekUxWHNkSmpaRWZjK1lRTUtXU3RJRmtIYXdDTjY5akcvVmhP?=
 =?utf-8?B?dCt2RTA2bXFON1VhSk1zU1dNQXVITkRXVi9vcktNRVUwWHlsWW9QTmFQSFFV?=
 =?utf-8?B?N21tdFVHOGxQRndWcWZMYWd3Nys5ZEx3RFRQYlFvNHN3NE9IWmlzTC9nWnJl?=
 =?utf-8?Q?t0AD0Vx83h1pY6P5Ry?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad304ef-2b77-4e1e-8096-08de67c0d51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:51:43.9635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kH9tIzDo7OD56PdlsLPlcpvgajSYPJWjF6qE9TCRMoZwpTrAS520VImsGHZp924XsBzlpSTs8aw9Q6b9/EJTxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDks
IDIwMjYgMzoxMSBQTQ0KPiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRG9uJ3QgcHJvcGFnYXRlIGVycm9ycyBmcm9tDQo+
IGFtZGdwdV92bV9mbHVzaCgpDQo+DQo+IE9uIDIvOC8yNiAwNzoyNywgU3Jpbml2YXNhbiBTaGFu
bXVnYW0gd3JvdGU6DQo+ID4gYW1kZ3B1X3ZtX2ZsdXNoKCkgb25seSByZXR1cm5zIGFuIGVycm9y
IHdoZW4gYW1kZ3B1X2ZlbmNlX2VtaXQoKSBmYWlscy4NCj4NCj4gWW91IG5lZWQgdG8gdGFrZSBh
IHN0ZXAgZnVydGhlciBhbWRncHVfZmVuY2VfZW1pdCgpIGNhbid0IGZhaWwgZWl0aGVyLg0KPg0K
PiBUaGUgZmFsbGJhY2sgd2FpdCBpbnNpZGUgdGhhdCBmdW5jdGlvbiBibG9ja3MgZm9yZXZlciB1
bnRpbCB0aGUgZmVuY2Ugc2lnbmFscyBhbmQgdGhhdA0KPiBzaG91bGQgbmV2ZXIgaGFwcGVuIGlu
IHRoZSBqb2Igc3VibWlzc2lvbiBwYXRoIGluIHRoZSBmaXJzdCBwbGFjZS4NCg0KVGhhbmtzIENo
cmlzdGlhbiwgdW5kZXJzdG9vZC4NCg0KRm9yIGFtZGdwdV9mZW5jZV9lbWl0KCksIEkgd2lsbCBu
b3QgYWRkIGFueSByZWNvdmVyeSBsb2dpYy4NCkkgd2lsbCBrZWVwIG9ubHkgYSBXQVJOX09OX09O
Q0UoKSBhbmQgcmV0dXJuIGVhcmx5IGlmIGl0IGV2ZXIgdHJpZ2dlcnMuDQoNClBsZWFzZSBsZXQg
bWUga25vdyBpZiB0aGlzIGFwcHJvYWNoIGlzIE9LLCBhbmQgaWYgeW91IHdvdWxkIGxpa2UgdGhp
cyBhcyBhIGZvbGxvdy11cCBwYXRjaC4NCg0KUmVnYXJkcywNClNyaW5pDQoNCj4NCj4gUmVnYXJk
cywNCj4gQ2hyaXN0aWFuLg0K
