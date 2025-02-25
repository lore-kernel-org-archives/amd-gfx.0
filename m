Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028F8C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 11:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F2710E63F;
	Tue, 25 Feb 2025 11:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xp/jD/5V";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72E810E63F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 11:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXbDNuD94ojvoy7BAJmTQBjeomNWP4Kt25NUfQkt9x0fVjWJCqBM31Vo+MoMkGS9PXl1vJL1ZBiGD2JX4xBnl8rEI0bins8i45kruHAsfxG61UNUuO3OstGlkpDGaqD4LO+OgqUICVUpIWh1dU6SD+lwge+XqTG2ppUvrtIJl0+H7o/99R7rCgBDf0xauqKdgC0yzdAjSl/gX/q3+7tsKt0ejGDvRLnk4mi5tPiHJg8AXJ65ILVWnr8aB4Nn2wT3grjaDVunQazp2Gm0XKZkmrjUFzA8HAGWFawS4W27yMEnrlyHU8W+CKt6YBa6C2GXidC7NXQ+7ZaS+kMxRw4BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=104eu26NrXHKT8ukpFUigDwTs6A6dAGfUUwiR9ewIGE=;
 b=Aihs4/x4nZR4ajj5Sl2aAaHfgUo+wFSeI9BathAjmAGHTPrnAIfeBEkXTx/lhVl3E38jQ9/MpAXyqFz0TncXGIPCLas+q+LBt5cce95EJWmcpgcRLWYfTEDyT04FraGc0beRaRtaF5MTTDJGlzxp/Nca/eqEfOVyE/W75qa6RrgkR5NJGULPpG2sF+bJ7weSGbetYDriJl4/YQ4BBDCZGBMW8xIsdhoxpVWWhq3y8WRcWzEXyeHCqFqU1WoH69LQXGofk/iib9IJUFMpL5GBFb8KKtr2UjeFQyL2XKy8Z6Ztcm33z/VF2uFtJa+qds1ge3uqcZfaqwyzYZBYA1Q69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=104eu26NrXHKT8ukpFUigDwTs6A6dAGfUUwiR9ewIGE=;
 b=xp/jD/5V28pQTUhVDjg36A0VeLUyKWJJs3MxU5EFD+ehQaUm8InB7dfP/MKo6vcOfYFOouQ6yusrteyCVdgtaNj3ZB9RQHuYW4K9YGLPbKJfMlTHjW8G+r/d6lWcajczl2rTXkHA7JkbRZgipmEczj32drV5n3pQi67bv04hj6A=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:27:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 11:27:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lin, Amber"
 <Amber.Lin@amd.com>, "Zhang, Ava" <Niandong.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix logic to fetch supported NPS modes
Thread-Topic: [PATCH] drm/amdgpu: Fix logic to fetch supported NPS modes
Thread-Index: AQHbh3TiPmv5ELtyVkSJQc2ygf8xvbNX4YZw
Date: Tue, 25 Feb 2025 11:27:33 +0000
Message-ID: <BN9PR12MB5257B70ACA3A6744980258CFFCC32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250225110300.120674-1-lijo.lazar@amd.com>
In-Reply-To: <20250225110300.120674-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=32d18eba-bfe1-4d00-8272-42f15274b1e4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T11:27:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8814:EE_
x-ms-office365-filtering-correlation-id: 6e2362c4-f89f-40e1-efa0-08dd558f661b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tbkf8Yg5L/LUuXSvuhmVtoSCwPuqJIB7swhjc/IfwkjmgVKp2YKhsIq5C0gH?=
 =?us-ascii?Q?UW1BAYWQkANSERUAK3gtWqeUh3rH5iHH9l8qeQS9V8HRieF+7l2jN5UGqo4n?=
 =?us-ascii?Q?N/iX2GFmaUd5M/ICkJvIrY9L3KGp2nEdcHsz7FHL/G4QOCU84DE3+9hMSfIJ?=
 =?us-ascii?Q?6wQw0cc370zFw7oQE91O2jKhc8q4dHX1bWs2nZwAzVsvEyEYWWYrv5Y1sIKY?=
 =?us-ascii?Q?e+5w3JCnonRVtuTbIQnr0+k8Zn8GYQ681DvWfDgWNkoZcwSBQMdvHxhaca32?=
 =?us-ascii?Q?BBWg+z/aZRw7ri/Fx3Aee0OfOQhXWoB5NTdK4l0+0FrgMOye9T+m27W1C0SM?=
 =?us-ascii?Q?tuPDmk+zxW/jUXpKptIhwIHl1dPBAmGZjjzV+J+cS6vFM8v9Q2LCgjrjn1JD?=
 =?us-ascii?Q?iZF9ygwFrtczkvJSnJpOPC//RPwNFXi3VPUv4RBbRtRahgZw/zFBb5uDpjdQ?=
 =?us-ascii?Q?W6EAnRZxFij7nNZfUttqU2sTkdS+fRELWVn9HoaB8TjakJr4p9yRyZdsb+Xy?=
 =?us-ascii?Q?9TiNkMGkb0zxgmh7x65ZyZ6nK4JTHhEwvH7GaqDHF6aHOv5cNWd+6ZO9m1n1?=
 =?us-ascii?Q?2iWSt9R7UD8y8anzXhAD2S8Wvxro1RQK0T/XSZSGaB1Eaj3r6+a5Uo7vTsBs?=
 =?us-ascii?Q?ESfScnFZQO1HuQTQ6mQWry5I0qXi0llP2xibDQkbKbFm8E4wA36lQAQTrVG/?=
 =?us-ascii?Q?CktMMOPD2gToJMnZ82wEYmHoGoTlLpKpUYrFP6L9BnEy5PA5FyIBo8M9awZo?=
 =?us-ascii?Q?nvT0DGweFqWwh68lYFfQJPR7p0RB22PdhCf6VEOIZdOOSrMG+3EnPCMPdl3i?=
 =?us-ascii?Q?ZWkcfwmelpawaUj7I/BP/aWxbyRQ3rBnn836HbuM7Q5k14R8ltYYuivcXTZr?=
 =?us-ascii?Q?L1fo69rZmfREG2KaemyEH5iKQt8R/yEna6nH3bE0mNu8ZI43JyY0d00s2VlN?=
 =?us-ascii?Q?wdf1+tUZ9OAbp11xrikU4pd8svTKSYYccqCz1dwqVZw9k7lZS6fZxlKIPFZu?=
 =?us-ascii?Q?6hwMJKeTi86pKLNSKJR0JAQmdIPuHYSQG/AWn1PNs21ZShuGAYrR55rE5yNV?=
 =?us-ascii?Q?1IFj5yabFHcGrK3xbKWYEZx1BpsyGbJVPrCet+yciWEIoc13YFhZpCTDfi3h?=
 =?us-ascii?Q?1VkUnYnBV3mIKD79rshsfzlf82iu1C+R1e2W5EEc07tREznvEa+iIAxQdCBb?=
 =?us-ascii?Q?i1dMPp9qn1+s8v3kqGUTqnOyAbHTGFswzPaO3kRiFJkj9YCjMhIrUIOnXwBk?=
 =?us-ascii?Q?VoYq8/tF8ZpIdGD1DPY8NQklFA4eiOwJF5xjfvaOYmaC+zGkwAQOktdD8+Zy?=
 =?us-ascii?Q?bwKEAVt90zgyVkddXcYpvulG8XPS+VYIjv6DXbjCZav75SLaTFijK0ZPm2/I?=
 =?us-ascii?Q?Evh4lHLLO0E3D6FRW80wpeA8Dba0RvhIFFgiicis9EMy1mHvgi/TVLOxF/g7?=
 =?us-ascii?Q?whQ591S+vYZuKLeFz8XKwj4x2HJvmkxq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3tR6h+NuNjXi/G0RWmC89YkPLKb7JuyosYy8NkjiEhLPlHMuknFXZ/R+2JhS?=
 =?us-ascii?Q?UO73t4BXto1+SKy0CfQ7YNSPFc1hdujEHhvwQWTBiE8pJGCSzemazfHH1hxl?=
 =?us-ascii?Q?Ecnt8EdV2D6cbg7UH5y1XYZQ6Rrqn4NusD8xUMJLJ6O1eCxBPIkrrFBrc1os?=
 =?us-ascii?Q?L4nnI+py0lxPa7Ji1th21UCVWfS7z+XvgQZJp/FQoPWS5qBX+wc7UOn/lFgh?=
 =?us-ascii?Q?9s2ftuf+pKsmY1TKy5SY+K3IQXk15/FOYJzqKGWJzcWfEazrviQSvAS8T3JW?=
 =?us-ascii?Q?8sXy0H925kwv7P8Q6GbotqvCJAhrzgAKylOxx4FHP95USZmZKjnH1kmuZhKe?=
 =?us-ascii?Q?hYx6f4aJx6QFkg6Z/Nlj3PDAdkV6Cd7saSiA4ALCbOgRgKnl+aRfOUoYWXz5?=
 =?us-ascii?Q?+3m5GCEa1xi0mqi84lVfMuRNqgPB+h4fFe5rfnG/tbHfibj2wX69inrXHlnB?=
 =?us-ascii?Q?KUt9HBDKAuMkEZXE3nreAZzUFdRWavdJcZVp6/n0xkyTJMePbnLFUMB503Z1?=
 =?us-ascii?Q?Y1cAExgv9GYcxBd5dsKPnB8tGLQnhmO7wWJqdWCNeF+FeDgepazDOPtakVJq?=
 =?us-ascii?Q?YtJvaV1J4PuyycnrbVDnDDiY2N+5YU1zWZ54DVv41sNQ+/2lv7ZBaBLYKpLC?=
 =?us-ascii?Q?rrviq0sXtbFLltrtEnRjtIx2RZRVHLGetqicv8Uq7M4QE7408nsvy/WX8+t6?=
 =?us-ascii?Q?YE0MHefFrRVtqJPgKcCl/0sufCtRxC3hevPPrPauR6nJQFxNZAlrr4MiHlMu?=
 =?us-ascii?Q?UefT8oxGLrXOXVqtKPZEv+jaZ3FXYsT9lWGrk1FpU7pwd4djVarkIYQhlQlw?=
 =?us-ascii?Q?hFAxk8rKTEneMqgA9VPtB08OECdoGTtjF2qshcxoAdR5tg8yXB75nb+ASKX1?=
 =?us-ascii?Q?sItBV6g+lhrlhOp6uEnVDpCoXH+AqfXrWqPdWIesiYV7Nzweuhop2WB88lFr?=
 =?us-ascii?Q?waAvH81ngl30WAdMyCsw1d80KUYhjrJ7rOkHapzxLnlNNLgmFO/fIKSupc4N?=
 =?us-ascii?Q?+QELptW6oCczoMy+BCsotCYQLIPbwCjR1WQJDvMUKpJ8lrSP17nk9EUEHup8?=
 =?us-ascii?Q?/lLmbe8Ayq3xHJdzPFks2qrokgukt49M9ozhcMojjvNAWhsMgBdNnu5B8xsF?=
 =?us-ascii?Q?cbq4fVPn6PDUl6OIZcovj0TKVnzqYpZqFVGgIgzI+ISIsqv+8NKr2gciYAqx?=
 =?us-ascii?Q?Y2ZALaJh3CHto6qyqsLVJYX8UY4+6TMk1uZYmBCRm2MMm/HEJJsdvoB8UCTt?=
 =?us-ascii?Q?lvpSF8uOXCesGsJHsnU3WsGJfgRAY05r7HMCTyKrelViPO00bqV9lb+OsmcU?=
 =?us-ascii?Q?sL4Xc94j8bh0mK5VBAJH/U8LZP+xb4rK58RsPrjB1AxHwlqFtou8h9wTZfVY?=
 =?us-ascii?Q?8supTLNm76zALa6gDd5bVlUjrXJskWgBEp2kRglb2Of2cZHxd9jWijYHyxNn?=
 =?us-ascii?Q?HtBv+/Y7P9QJx56uz2HL7Qvo1RpcxSZqXWbfCBxWsws+/+Ewf0Npp8vgyJBX?=
 =?us-ascii?Q?wiKW3/+jJWBzApy4f39qKSN+5aeetCATaq6yWawu987kacm56KReHfXBq3mM?=
 =?us-ascii?Q?SMnagGFZEUkH4jMIU7M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2362c4-f89f-40e1-efa0-08dd558f661b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 11:27:33.8167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xp1dSiT9bLLAEl8Z1+VW/1HIQKxvuUwfCjw9mEhFw7lLCADj/inoZa6rXYp5DHAt1MejM1k4yiFly6d/v2TM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, February 25, 2025 19:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lin, Amber <Amber.Lin@amd.com>; Zhang, Ava <Niandong.Zhang=
@amd.com>
Subject: [PATCH] drm/amdgpu: Fix logic to fetch supported NPS modes

Correct the logic to find supported NPS modes from firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Ava Zhang <niandong.zhang@amd.com>

Fixes: cdb41537812f ("drm/amdgpu: Use firmware supported NPS modes")
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index ccb31e724b55..49630f838d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1607,9 +1607,8 @@ static void gmc_v9_0_init_nps_details(struct amdgpu_d=
evice *adev)

        /* Mode detected by hardware and supported modes available */
        if ((mode !=3D UNKNOWN_MEMORY_PARTITION_MODE) && supp_modes) {
-               for (i =3D AMDGPU_NPS1_PARTITION_MODE;
-                    supp_modes && i <=3D AMDGPU_NPS8_PARTITION_MODE; i++) =
{
-                       if (supp_modes & BIT(i - 1))
+               while (i =3D ffs(supp_modes)) {
+                       if (AMDGPU_ALL_NPS_MASK & BIT(i))
                                adev->gmc.supported_nps_modes |=3D BIT(i);
                        supp_modes &=3D supp_modes - 1;
                }
--
2.25.1

