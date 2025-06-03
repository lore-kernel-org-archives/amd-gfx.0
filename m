Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0939C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 09:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE9610E17F;
	Tue,  3 Jun 2025 09:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="auGSsQih";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268EF10E17F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 09:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDA4qO+1dRlBbTgAe9VJtqNTg7YCFfRpSsm2tV471XwNOhHocGKQZklOF+HkwkGsjVsLhgQ2J1wmzRH9u7KMzSEBzbjl1dkSbS/wmCLi3lhBQrQ1j1TUhet/ADlvJ8PvqIUmXDCNrf7KX63HK/buY9qLuBIknZHP/R/fP15PP245tkk+yriR+vcXa/7nTW/DYunGf2l8026ZkpDi5mWWM75EXKxC/k0z1tfMaKBiMqda5vbQ6IWiREKA5GsrLN3Wa/wSrmV2CopRp1/1jCxMIwWX+YSomb9CAWU1+snemmrKiUU9JFidI7rdhIEBZZVQYG12KFuW9Kn+hv78+82bBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVvwhGP/sB4iOsgLIcpPMOUG+mZ8D9CxR/AqFiw0PRk=;
 b=NHfdDzQH1L0+1iVl8pquCzto3epUbbAiOxf9fxBCb9suDZAExUqX39KdrLD9GLdIqlPKZgdQNWjdu1VcWFkiWBEBftdyCOvk6l9WhsCGY/R4t+jcWjsN9GLWVpGCv+4ToR3cdOWi/vBOmeCsf/eGcib3nldxVDG3XcfBw7eJluoUWDf48GJAVw6vfmz7l6Viyz/Cscdz6k56BnIq8ABvS4XNX4+87SQPiA48lTZc75Jtp7YJcORPtvdIAQGkxg+WOu1YXwBdZBTRq7JsUVHbagWesfWogk6xV14yxtCkVUapsHrpn+Th+jMHgkQ4G7fNDxWHy0rEsoIQdHyPWsvF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVvwhGP/sB4iOsgLIcpPMOUG+mZ8D9CxR/AqFiw0PRk=;
 b=auGSsQihpJLo9DqCop5mIlLgntbRHgDhHuE4G9tPRUDSZ8ATKP9Hc6wJxHfW+TjQcvZnAeSv3z3Cca7Ogg13Zynw/zN1GhZw+P93W5G0OP8kpPU/Is+t2vgMmarlO5JeKOYwnn3QIArD9muPYf3Rd9b+ilRRgpw7bJzLGa0cC2o=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Tue, 3 Jun
 2025 09:12:23 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 09:12:23 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/ttm: Should to return the evict error
Thread-Topic: [PATCH v3] drm/ttm: Should to return the evict error
Thread-Index: AQHb1GdCW3aJlzOy6kWPTrOdm+a9GLPxJlkA
Date: Tue, 3 Jun 2025 09:12:23 +0000
Message-ID: <PH0PR12MB54175EF24EA5D939B453A5EE8F6DA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250603090943.3468608-1-Emily.Deng@amd.com>
In-Reply-To: <20250603090943.3468608-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fcacae88-693f-4d3e-a9cd-13c3994abeb7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-03T09:12:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SA0PR12MB4416:EE_
x-ms-office365-filtering-correlation-id: 8caa01ab-dd5f-4fb1-e8a1-08dda27ec03f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vE3k4UCWdP0Ib9+mO8locgto9J1p9/dyFgeH3XUvGd9hyu2OMkX69B80Ascs?=
 =?us-ascii?Q?zDmWyFwQTeYV3bqP4f/Q2h2xiXhvD7lGpi0ga6a6wAWC6jrKyPuFNU4zNdnS?=
 =?us-ascii?Q?xe6ejofyTu+g0JWGmGGnkLUg4nZLo1dGXpffb+Mi8VCBjqAcKK5m+J3EzBaM?=
 =?us-ascii?Q?LIrZr/OKcl0OSCM94flusu2gPldxlSq7PISPaHMCr/3VOTKm0uNDuQ3kYpWx?=
 =?us-ascii?Q?gys3uXLTcHphStHWqsg6oVZjddfIUpGB+LWD+A2nSzcBLiPCfDgKJcOSWiNn?=
 =?us-ascii?Q?cCzZsgxwGkj8IpR942vTVxEP/OvbSbtxm/CFGhEFgsKoJ9WMJ4kR4+jZ5nGs?=
 =?us-ascii?Q?ZC4QcYf43iA8Yx1w6zKmUvIFZ210gbgHZmoad4YTwKjQvCIhlvnVZgfPZ8Xc?=
 =?us-ascii?Q?jaP4/nSiZx6TMpDHdgCcxGOj3CFROlvWJrnIZzoIFnTjNFOf0eH6lULYE5zG?=
 =?us-ascii?Q?yVDlfWulqroLVJ9waOEyTllzHo0OGIK1diBc63l6oFYfLx3ntH+Y0F8gaDKu?=
 =?us-ascii?Q?uOBZa+gYbcl/w0USn0JOJkWLE5D19+32ZGqVhFktkg6dH8HbIP2ipvK30n6l?=
 =?us-ascii?Q?TehGnS40OZxBfEnsny1Sj2DNADPAggFCseE8SFV0sM9CpgnFeMQXaOfgVxzg?=
 =?us-ascii?Q?N4ULRO9ms5+3ZWk0z0gMqJciuJuCBbZs+trGezsBWYhk3OGxUhfftL6zab8j?=
 =?us-ascii?Q?WR8RHE/sc4GV9XZ1Qs+xznYgRLDQVwst3PO7SqLHDSdKCkViq/31+ADQunhF?=
 =?us-ascii?Q?Vnu/1yJ7q7QW78dCuaSf07GnkWKng5DGx6uKFZknlSvIs7FV+vMQTybt9DkA?=
 =?us-ascii?Q?n25imIqqPZQ//KUxmKRFhYMZz3H4C2tewpzD47eAkw3Uh9d/PTl3NrZwZcrP?=
 =?us-ascii?Q?e6oWIKffVQgRQkwRb6dCCKyF7Dwm50PQ6hkcYCzd/VQthqhg0BKsHJ/wYMhz?=
 =?us-ascii?Q?y+221yhSVbIqeuAO0m5KZJxG0XeMxG5/GWrpAF7sQWyKhx/YPC7iaeOkmalt?=
 =?us-ascii?Q?VTLTaUi8/Z9Qrx3hsHzNem+YlkSWdjZDI59ZsaDrUbFlRhKZUAAJTNuZ6UbG?=
 =?us-ascii?Q?Z7Liktt520wie8j0mfDDV+UwwYqaAnm+NtunJMugpASnBfnQBJJ4fwzSNKNY?=
 =?us-ascii?Q?RxDuLu//OoJlysTnWxhneu9tIUb8Spr8IdCMcLCY+FVd0vDhOgiPaJR7+lqF?=
 =?us-ascii?Q?J7gvcOKCIu388UqB6LkOECHiuonxITlu9g8HrbcniicP1Ia4f76DBRJHYdKV?=
 =?us-ascii?Q?a5zBhCuT6JUQY2vC8GVkIkxmMvpYIEvWcPCYGj3LGfQjodo1zyv/iZpzhLgS?=
 =?us-ascii?Q?LpcN0eQLDXaXuB69kJrHaBwMKDUArl++bie41uLvCh98eKXtr7bC2og2DL64?=
 =?us-ascii?Q?cZNHM3MDSimvEP67s+Q8y4BM/BsK2SQjDwh+iLqRfTllPntTpKKttafnc3dG?=
 =?us-ascii?Q?rJlU2GkaIs9ZbTOl6ghRkXrgLaFTAa78TuWp1DK4Chc0I2gfE/vexA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hwPqrJd3dUlUcZSJZCrlLLNUCGQAiZ/GRPDf7kShla0jCSum702nSUfbkPEc?=
 =?us-ascii?Q?i9BXC/SjI3F/KSdctp+zZwEE4KwHSJruSyxTmooqPnmZXDyt0SVqbuZsrnJE?=
 =?us-ascii?Q?dV/xQdF2jh7A4EjKzSJ7Zpx5mc3sxHceUgtjb4LIL72wQM32rHiuWVAQbkAs?=
 =?us-ascii?Q?DPRbQY14oXUA+1JNF3celYtI2jkAPfelGDIRp+mr4oX3YD7ft5uSLeYvCLy4?=
 =?us-ascii?Q?whcmApbd2edJrRLavaGcy6voaL1J/TZE6P1/e/x6Nnu3RQMK+i4jl8DWUCBz?=
 =?us-ascii?Q?6MIZnYnZnbvAOF8lM779gEC/lgwrQCYqmHgq0OM6BMdjEvhgOn1tgY8YoKvq?=
 =?us-ascii?Q?YPXf6H06KuLFpbOaSp9HLEPFpdhbWBmQ8OcGmO34sPpxG4jPpfNsImpeO+PM?=
 =?us-ascii?Q?TeZyYYRSRsoJsGrTSaJHJG3yYYbmAOeaXRWQdHM39qiw859qgaMTdCF8MXUI?=
 =?us-ascii?Q?+0U8iTAv0nO9Ho8pYVOqgbZqlgCieIjYEfn725stNYVQS2eKsYZJu4oi48Hq?=
 =?us-ascii?Q?bdymOLGRWe7eX26FXvqE9PtFndRgxhe0r4J6bVB0DUM0BI6cqZq/yQz+wls/?=
 =?us-ascii?Q?7YiAeu2AeoFvo+uWJH77maQHikMsZOU0k0R8zrOyklb3eaT6/qhkCtlQi7o+?=
 =?us-ascii?Q?EbLL9IRLpxAsSJBJ7CQ1N8NZn/MmImRYRHbLDwI4Xv3umVe3rosEzNC8ud4o?=
 =?us-ascii?Q?ipzHVwgq8OSrYDIRglAaKSGdmD07CnSq77HUkliggfL/n7Y97xlUwHlRO4Uu?=
 =?us-ascii?Q?8BxJ+YjCcPrwSI/koEaGV6JPHLkvsIjttmXkHvmxsC0x8GyATpqzMwdM5aWl?=
 =?us-ascii?Q?X7LntyX5hJhOw3Q6VPot35KdjyKIss+byEzTE3l3YwkH9piqRmXY6Pmtpf3D?=
 =?us-ascii?Q?4eb43o0iKL1qgyXyrnTAOFrfcXusRa1JxUWrKPuG/ZHOLbA6iqQ5JTQGHDD8?=
 =?us-ascii?Q?PggV8ZqZAIckMA5QwkNaFgmWr2QmkUICFAnOJYBkGVLi164E0Sqaib+yqqoM?=
 =?us-ascii?Q?B4f0N3dPZeyku/r6qOlprcGblM3NPmlD1m88xn/GMiNNeFGyrDGLQhsW6EMH?=
 =?us-ascii?Q?dH7ZH6B1IXSVz5erphw3iwwqdBmTT+tyRE2l09lq7cTYbu5qKnPnAKOdX9KY?=
 =?us-ascii?Q?28LuKw0SbVCv9MyOFMqgkNRMvYixye2nZfAt+I6xYX79JNxJMDj567W4znBq?=
 =?us-ascii?Q?7DKAuKpjLuR5Z19sETj7cMhzoKDzUOcCKh9s8pqFLxc0vhnuCQYB4dTSqKVJ?=
 =?us-ascii?Q?Dd0++SqqGi4QJ5+8Do/xxQFQBpi4acicxnNo06kWN0YEqAXa04kRE7Ntktc/?=
 =?us-ascii?Q?ArUxtGPqLkXJMgq932JF8Wray93XgLEiPLP8A2ov0TibdQnnn1XcRNA3/SUR?=
 =?us-ascii?Q?wsRrwhQbppgUmkEH9YygHZIH0/mchmfeOzZuKvImfuUY9SfFNqEBe8SpMM/m?=
 =?us-ascii?Q?+7hTb8datqLKwfaLu5+QWeBtL9rRC7z0Vj+50V2fdRcy5eND2pg8mtxJ8dWM?=
 =?us-ascii?Q?N3tMUmCuc4CwHnEgseMLX1o+KSYeCZqw1DdP8r2YnIFmLIJi+aVU7Km8by3n?=
 =?us-ascii?Q?HBhCdHvIB8qNllLiM3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caa01ab-dd5f-4fb1-e8a1-08dda27ec03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 09:12:23.1097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxEaIPToE2B1HXwU/huvlYBBUk8hG13C8KpYMkou0xo+ELFbTRBLGk7OwnLbUGN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

Sorry, send the wrong patch, please ignore this.

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, June 3, 2025 5:10 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v3] drm/ttm: Should to return the evict error
>
>For the evict fail case, the evict error should be returned.
>
>v2: Consider ENOENT case.
>
>v3: Abort directly when the eviction failed for some reason (except for -E=
NOENT)  and
>not wait for the move to finish
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/ttm/ttm_resource.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_=
resource.c
>index 7e5a60c55813..a9fa903b8e39 100644
>--- a/drivers/gpu/drm/ttm/ttm_resource.c
>+++ b/drivers/gpu/drm/ttm/ttm_resource.c
>@@ -558,6 +558,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *=
bdev,
>               cond_resched();
>       } while (!ret);
>
>+      if (ret !=3D -ENOENT)
>+              return ret;
>+
>       spin_lock(&man->move_lock);
>       fence =3D dma_fence_get(man->move);
>       spin_unlock(&man->move_lock);
>--
>2.34.1

