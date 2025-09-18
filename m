Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD14CA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 19:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9377810E8ED;
	Thu, 18 Sep 2025 19:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ETbeK/1X";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AFF10E8ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 19:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQBUfJEMaczRnQfa30ZPfXI8MBMf1xDQ3yxqbyDaGHpPtwFVKXzl4qJ1/9tPi3YzOwkE7Qw7Aue/xjJi3QiIkG5C/u+q50jtBYq+tcW8r4H6anBc4SLjDfgZO9LAb3kfd3DzWKvlhK2bZlXZh9sd9le79ql4RbepGiz/l0BDXv6UleDqLSujo7PFE2VBMvbCPvFWC50qnyhwIa0GWubkzraQAw9mL97PdbAv5fJaywfOqTumAR+Y1HlBO5tlXr5UqN2WTA/O+GfAYdOm31U9SV+cydxXtpjrNNNHCCyM8m27L9kArscVT/e/+OiUP+1xW6P32W3Dhdag7ut05CRFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FFBIl9Uz8BQL2HrdmOTgFSWNGOBfaqHvFBVu1CUwq0=;
 b=QjC+k5K9YkYK8T+t/Q0aac/ChpSI3O0sj4zlB5taYfg2Q5ryx2vVa19r0C88TwlkfBRWccXjCNzp3y1gHFohQahkRPNZo36l3yxyODaaw/t/u7FU9ngA92SG9+XIdDK0LV7jfeeflblgZs/lB04jzRPZiGBZNf64cv65p2puzrj0Xo+XniE+yCrYyRHmAFaV9uZKc78Zqy/mdj0l2hA2cKbBvWhGiIFBq59hi9Oq1Cc+zXzvVnGLC3xPw95L9Fbsjbp8Gu2Qpw3cSx3XrTHx+GzTGH+y8cQA89ki2sV6OQbrKBcUBdSj6BKAcaiDVnmwzJ/c+D/Gs5+Rf42EutE0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FFBIl9Uz8BQL2HrdmOTgFSWNGOBfaqHvFBVu1CUwq0=;
 b=ETbeK/1Xq+ldgd8/7vmTxrt/UcevFDCd1jnBoI2QHxNZ2lNShZ18J+W+LsSVi7lXW45wc2jHzBN6P/WAdz+dldspALKyHhe4ByoNWnS5jrANhp3KPWYZfFjaDczg1VRvSBjcyDTglDmsvfQPW/43+4Br0+ukAj9G/5ddHBDPF98=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 19:17:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 19:17:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 01/21] drm/amd/ras: Add unified ras core folder
Thread-Topic: [PATCH 01/21] drm/amd/ras: Add unified ras core folder
Thread-Index: AQHcKDwx6ilezMXyXEiOsGX9b3qwkbSZR4zg
Date: Thu, 18 Sep 2025 19:17:27 +0000
Message-ID: <BN9PR12MB5257D57D08BE20AB38A39DCCFC16A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-18T18:42:39.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV8PR12MB9153:EE_
x-ms-office365-filtering-correlation-id: 252438cc-2a19-480f-1f86-08ddf6e801cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xye5XeRsm/sH3nlxLLfa7wMd4ZN5ZJHg/GGUy/8c6N6fhKWZ/mmHK6kxmVL4?=
 =?us-ascii?Q?AXY5xhj8spupa1PWJ+gFhEJ7mDhtZDsnYBn4aS8Bhd9YBF/PeGzAnNMxXwea?=
 =?us-ascii?Q?7o1NdGN2MyqLVv/UgcotXeuB1iuDyeoae/aZoiZjSGUt/KGfvRhpGW9eq+To?=
 =?us-ascii?Q?Zl4Pg6dMZzDWkAd8ICSjuwQR4tJIoKGD+g6SdePXJOphLMv0kN37GIdwcCIH?=
 =?us-ascii?Q?Jbd9HRUVfWUcmw4fz4YFKU/wDHtqabBZ6vgraUFI8Q1bzuQAbV7WxU18M0df?=
 =?us-ascii?Q?cM06wv1Tk0WsY31331dTFoA+nTA5mVvUkgoqL32V2eZvZEQyOOB67Vhs57bH?=
 =?us-ascii?Q?UeTRkF5enPCVJQMu19MQGqLhl6MtNdfalqseUy0gibHQ4mLq98IYrzZH2zNe?=
 =?us-ascii?Q?Dqjs9sikkOKMhtV8HWzwuMFCGJpcV3VFrZm3+9Q1h5qIAy7ykHZDqu8eULa1?=
 =?us-ascii?Q?f6E8UqZPx3HysHMFvQyg9175+LukGjvvtQBP82tZF2J+pN9Zh7WxwIAwZAg0?=
 =?us-ascii?Q?nbZs0F0UfTRMWRCtXOR4osZzdHqvr59nekUxQOA3hUdlkNgO3AFUC55m7Rsm?=
 =?us-ascii?Q?Er6+qhRwhym+9RJ732K7XhgisBwKkwvI+YgUt/2l8G6lWWYiRFMMLTz7zWa4?=
 =?us-ascii?Q?MN6MzHuu6S5KDtOfPVQXSrM0lAqhL72zt4rQKoygn2xUHcqdfQZiCz/++bgm?=
 =?us-ascii?Q?B8h69LPYVkc8A4gzOTa8I31lEHUcjvM+WITZu09a97JTPhcDXsfscQkrWm3N?=
 =?us-ascii?Q?qiS04tY0SB/NxIBlRfww4xioGSgCd7856dl9Uys1SGK/m/A4A6ZdiGsdmmQm?=
 =?us-ascii?Q?GACwMP3DT+yRecW526zVaC3j2NEyZ1/Vce1mSOZdxII/fwTpNlBlR2TEfeUf?=
 =?us-ascii?Q?i0ttp5Al3ry0kC97XPn3aa1J4sVt+JD1KP58iocFFg1Ix6vfirK5+Qi6LfY7?=
 =?us-ascii?Q?FWBcgw8uIrfST6jFszio+HLANBCz/lEgD2YMlY9+iGDJ3+0y2HhGH4+vJlGF?=
 =?us-ascii?Q?+LS5lGpbjcj8OCMYwjolxAoz1gePzkQOvlgXt6GGEzQ2ernSjdWC1QpbeYh8?=
 =?us-ascii?Q?mGmljxE9JgK2T84+TrkPqkZucqANApB7UD+Fr5rPeWGuQ5/4GDzqOcK6FKw3?=
 =?us-ascii?Q?YNkj18AxlqDHY537D07EnlDhRLVIMuaR1TMnSx632+xOrBf1BVwchlqMIpe0?=
 =?us-ascii?Q?9K5KmZGrpOwwhB9V9h7MUP7K+8osDy3jAvPT3fhv1wnDOlurnqwaTQaJklky?=
 =?us-ascii?Q?lvq3VJSoJbMlp0Rq6FnwLpZJrty/RrYnWgG8+Ud7NAV1EP+NHBazWaqqZx/M?=
 =?us-ascii?Q?4770O4ExJo5Eu8hx3ApwIEngsq+chhFQE/raLqQTaQWA+DNiqdivkXfoppHr?=
 =?us-ascii?Q?s05aQnBJFoUv00UI6yOG8ewv0GPrBQ8yz5vEmMscKFaywj+XbNjunczFRY4L?=
 =?us-ascii?Q?qpoKgGQJZffcFsgOleY0Sc0Gtycv72eXgS9QTt1/bV24hNmuMm7bFoXzF+kI?=
 =?us-ascii?Q?wOGswbgDESWb0ro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SDbfJtn2CLAYYobXOdTKaWGFHLwoA+gCUoeCq77ZD23FCVRpcwIfXnOe3y1s?=
 =?us-ascii?Q?12OMytfFZj/JVfngUDykgB3Z6sPJ5qRD5pU06aS1ksJQ2FRnliEi2Tu6y91E?=
 =?us-ascii?Q?iRcxc32o2CDkvRO9oklB/+0kiKeBPVZfrxTRvSO3gr//ZFqtkpwjZbDBqzzz?=
 =?us-ascii?Q?GDY/FkSp51uGvTuFjtqV0lWx/SYzxwF4bzqgb/g2eTuqqE5uVwj/3CCBmghT?=
 =?us-ascii?Q?NbGbDq8hZJn5C9AC7ndEKSM4S9VXjHYrV7t3rq5oCyY4Pxg7tfdxzlW5UP+V?=
 =?us-ascii?Q?zJb27C/LTty6yDq7QeT5vZVffzp9CMZJniAVpeOos22GoKf17XAiCTy2YJQ7?=
 =?us-ascii?Q?GZTY8xzQq+YON9CtlVrdG5/gMlQDcL256rgzeyEq+0aBQUoL7fG4qyiHkZM/?=
 =?us-ascii?Q?Rv28UAX7d7b/JVpWEQvLiBsnbb7bvLZaeyy5hYBuV1yxYE2mpr6Q4oW26LQJ?=
 =?us-ascii?Q?iIoowhGNUDhgPRthAL33KbMeLr7/fP47Ug58/CUvV8wpBZSgHNoEn2bsLY5n?=
 =?us-ascii?Q?pL2G+AxCLebbHwh1LGRYEpXHyVQ1M86V09a8R9XBnm7SrY10i8RX+ddjCBMQ?=
 =?us-ascii?Q?bK6Mxb8y+R3xK46+GnY7bycxjVNxOafd4bxXV32CjOoQ4tMxoZVhwL1xRfiJ?=
 =?us-ascii?Q?nF9gzvl441DLJWxREYs2MideIcEKdYDDDtW/ltEgz1+eJr87gEJmzlGWqaTQ?=
 =?us-ascii?Q?Dit5DZOeBv0vXRVO+ZaHakeI+Dg5/8Ogz740Y7boKQzA9iiO1w63Yv7Y0eqW?=
 =?us-ascii?Q?EtA+G5bxu8iCTvUshky9leKxQTVdNereG6o6HJLNVlghwmNPHE1uqs58OLgP?=
 =?us-ascii?Q?vD8OFhDH4MQ933tPM4LU4ApupcUNPy5B7zjv+3EhvAPB5eI96PBAhRvFHnLG?=
 =?us-ascii?Q?myEZDhNfag1SYY97VynGuACEhVamMQLpH0sxNogeUma74hmFIkE36Y3YU4Au?=
 =?us-ascii?Q?iOP1lKaBhUFkpBQi0Xc2cXos3YWiFSGbY0IqkG/ZxR4NK0u03J8PRvnUAAWy?=
 =?us-ascii?Q?ztySg2H0EJT4LFfBc7zJbNzRJlxD0a3XjSYSooAN5UiKvgMQwqJgZOFsAnh1?=
 =?us-ascii?Q?+kb8JeoknIwWf/adYDIMS3MJHTnR0+qV50mwHp2Z7O0e/V/c8z55ecykz+tp?=
 =?us-ascii?Q?cC3yXK2jDja1rTEA9Ca2CCh35SYtIgRthCwMDuI0sSeh36iY0WV6oucqulfg?=
 =?us-ascii?Q?dR6PxM7cRt/fWAi7JiceKlJiqKo56MvuABcehDWy3Zs+DseZuAMohEUh82kS?=
 =?us-ascii?Q?YT8dgctZcz78Rhmaa5uI4EW1UwjMPIAA9beD5hB5ssNTHcjWzK9uimKTo5Li?=
 =?us-ascii?Q?o8wEnk4CTiuaRctEc7thZMejHvxd0RuV9rUHcqpBtDBbHZpekBHKs645xJO8?=
 =?us-ascii?Q?kabOluKi4ROlfpPfP/R1vFCquv67knff04j9fr3mID5TYkVX5Z8qa+6pt9Gl?=
 =?us-ascii?Q?h/T9v9BRpXZeQA7OFi8nFsTtIyBT7CP8bPJuZvoqyXfZhKwgTKmVOrt07K3f?=
 =?us-ascii?Q?VP51xSBJYfYavnoi8H3mFg8q7L9XUJlP9ieuUSPcNvxF6ne9HZq51AYyAF9e?=
 =?us-ascii?Q?eU+ETW8Fc54PORSOwH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252438cc-2a19-480f-1f86-08ddf6e801cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 19:17:27.9332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjWTVzc9H84j4ZC8PtHbpKQT0pPijSy8cdfJJqhvxQu736aPZXHk3RaSSjVMsDcFgv4U2fmWalJ4ySgugDM+WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, September 17, 2025 21:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Ch=
ai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 01/21] drm/amd/ras: Add unified ras core folder

Add unified ras core folder.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/Makefile | 0
 1 file changed, 0 insertions(+), 0 deletions(-)  create mode 100644 driver=
s/gpu/drm/amd/ras/rascore/Makefile

diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd=
/ras/rascore/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
--
2.34.1

