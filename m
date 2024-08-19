Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F272FC52D6F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 15:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F85610E2C3;
	Mon, 19 Aug 2024 15:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qk/tPlLh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7734010E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 15:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnUrinlnf/NkjtEk7rfy1vwa+0i7EGRfT/Es24LAC3W83qzjwF71Lod9hJzQAx2KrwUhTx6+l7DFbxLWh0iuYWxifjXF0BBK+M1Jlu/dmhPtBoQBDgPYgcoV9UqsuRJBt7kjL1QJm411hDiCcDYLdSk5kxBS3O0NkEepR+qco3uuidJNUr+P20boj0sW6OuOsj8j1IY18q7Ebm+iyLpixNsBV7/YUOkldrS6Rc7T4PhAJo3AHu4iIfRGXMQ4+2nQYwtbbN1+K6abW+RfP9OW5kcIs5XKtvXCcFBUMwiCImMvq4yGVYCnzkCyq9Wvz1ppRB8/k8nDw1QAjR4xbEVWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT1HlV/7FL8Jg8wti8QFTVP+85VOEaYXWCYTCfoiTCg=;
 b=VklqQfS/gYOFhUKGB9DZlwljmOgdRsnDoi62mpPswv0mME/m1GFsex74mUuxodZmxHLhJUsSu4TQaDv6t5Y8K4l0Cgfo4Mb7eULd37FgdmRBLibGhOtKYewtr/low+s6IhLUCIZygE8y+6fjdXc8Hs0SudDoQMry338A8nWj8GuCkNgX5iW3G09Mb6eoXW9t0bp3aO93/SCPs8nClqeaz1HBOSvImBkjKsuivV3b7fZ8oy+0gHFkciaxwt70FxfiomQAcFr/szA1338eAqc22UpXejTHD8ioEdXGSpeAqNDI+kbPxzf9OSjKeHBt3RB4JF13SB4PhH49FntpaT2lKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT1HlV/7FL8Jg8wti8QFTVP+85VOEaYXWCYTCfoiTCg=;
 b=qk/tPlLhaPHJbbb+BvhfFPXoUDrM7WusKThMSm7NI4BHkUGT6TiY8BNC8ECfgfzLRpA1O2tnBywNTF1+kj7Oznb1Q1XpJ4Dx3dk/23IQUCwgZnRITDECB5BPMIn1jA74wY7ZwOuN5zFZlN9HnkmcaMlWKemibyJmDtIQSSBBXVk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:26:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:26:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix eGPU hotplug regression
Thread-Topic: [PATCH] drm/amdgpu: fix eGPU hotplug regression
Thread-Index: AQHa8kvgOBK9vIuZvU2dcVQBkFFiprIus6pw
Date: Mon, 19 Aug 2024 15:26:53 +0000
Message-ID: <BN9PR12MB5257B996E83BBC03C9984E15FC8C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240819152353.233303-1-alexander.deucher@amd.com>
In-Reply-To: <20240819152353.233303-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4d00e45d-1f86-4f69-82d4-1fc9208669a0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-19T15:26:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB7981:EE_
x-ms-office365-filtering-correlation-id: 85a55a3a-011e-453f-0b77-08dcc0635a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?70Dp9mh7nZuyClEIv9tcBYZK/hWPaxuYGpGw6d0GkVNVef2TYLu+wAyhV5DE?=
 =?us-ascii?Q?9DSWx5HBLbtdNXGpctaoF2RsT6pGKSZMoIFDgGQ2hkWx0T7Svzw4KKS2AutM?=
 =?us-ascii?Q?Mp5M3iLDqPT85wKcm9kbGQa8O2DCclZ47SlF4fwt/B5NlCXMVE2UyoQ3AyHr?=
 =?us-ascii?Q?j/0rEAn81YiS6ROfuzrVFswZWN6AQV93mHmVG8LElEoDq6nJBApOGXZ1XiE3?=
 =?us-ascii?Q?L9okEewt71B71zj1vFk5Wz9F1HVUcR+wYREMUHHeBASta+JyL0ucBOgkf5Aq?=
 =?us-ascii?Q?wUQp8pyl9lGS3qdnp19bkQJAg3mFFCoFgODxqW44ryKtzQKxlmWEr0KxoKET?=
 =?us-ascii?Q?JeKF5fzsfjZWw2JNOUcZvO97wlSLuCxVWC2e9JuLLzTW7lHGabMAst3kcx28?=
 =?us-ascii?Q?j7axnwgrGK5CWB0ODJQ/WMUptcOu2wZOb/Q0AihDxSMqIMxhlwUWdhYH+mZy?=
 =?us-ascii?Q?kaMO3tA/phdSpTsv4gKnX9KTjo/gRVYKIuUWXI04b16W2yDxfdVbuXPHVATv?=
 =?us-ascii?Q?3Uc7BN+4lbwjggS41aR4ePBP0ac2ufVJppbvYwIHzb8nygE04DaSFeXghdE4?=
 =?us-ascii?Q?6OxtgVqCS88zbOSizkzVWV5jQnjNprGci3tsVy5dnJVeJiAkWQMDgnby3DUZ?=
 =?us-ascii?Q?yIh953X4G08edfJKMTa/WY7g2ntBzcKGWrTliZs7NZRznJM5PNbxw8nJW87T?=
 =?us-ascii?Q?Oi1nEfIeB7utcLZSZwdY34dGPLN4fC/Uzm6Ofl60Dye++GAyODYaXoMLPvig?=
 =?us-ascii?Q?y61Zg4IKMZFJgWoUajSmzekC1EcO3UxbyGGjxyPAbj/Zbur0CMms2o0+O2mO?=
 =?us-ascii?Q?R/yhaNFpUSrXmIpSRUE1FO2Dg4tJD0r9u1HaziR9niMd/+D14tRcZeuRLZna?=
 =?us-ascii?Q?8arTLOoMwb2VOiNgYOcX/eljj85Tgca6D3tgbFMAPhA5msHYD/Eo3aIVOqAT?=
 =?us-ascii?Q?UX1JwjHqOihbYpNmqY0ftEGytPwHwr3RBOwe+ZzrgPMqofk17ACz8BmpI/ZU?=
 =?us-ascii?Q?3GL8uYFNAVPRLXwKS+d2FvQJMWYqwegNJ1XiBkt3HDRRGlC0LngbzZZCmnCT?=
 =?us-ascii?Q?XprtFwYlCNhCharwPKsFR8gCIUsomXTTKlm98cppMPbBkqMcAtMl8F40xr/1?=
 =?us-ascii?Q?/3ltcu+NrqjaVISLp78NsKyU3vdEYiKDBFvb1MSi1wDVq5VJQSlcYaHGiNCC?=
 =?us-ascii?Q?v7XJwA9yZFKLiFu8535EX3/+aOyqvzsDwXbMQMsDMn8AsxQ0fstvmc4xbODP?=
 =?us-ascii?Q?xRY6QjjhJV3oPJGbsS/0gmeZB6Qt0oROhqKBW9/KokVznVXMy+AXR3fRI0l2?=
 =?us-ascii?Q?ZPNnQxeDsZ2Zaa/JqXlBBlo2IVrWum1QDnzJyq0VEU3lBOjs6VzqA3GLO2LK?=
 =?us-ascii?Q?lBrArZU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1qJSUp9ApniB7OWwyVu0zsCg+BUC0URNOB1Fi1phY34RryPondTavpCHyOQO?=
 =?us-ascii?Q?oS7sRbztlme49ryOTGGOP8li3hr3LlabtN2zZ1jjD8kpq9KGnTCcHR/pnAnA?=
 =?us-ascii?Q?HzheODRLJHC06AO5hx7fBzfX/4zQYY/Swg9VpOCGHoo1jLsoai1K6hrr6Biv?=
 =?us-ascii?Q?k4jb4nMh+8yJ5TyKgkX/PQUelr/hDxkRv+kccZU6ZEyXeQwbB/DKUHq80MCm?=
 =?us-ascii?Q?BFcIQWWIgsOKCxfPsm1aI8AVjJ2RohC7pfW5ySV0va46dF6peklTttJnaiwA?=
 =?us-ascii?Q?iRLrw+X/yR/NP6PjdPZmtbM4Mlqd7ZsQQPYpf7Ir2rTfeFwumB9NKFdvqrqT?=
 =?us-ascii?Q?Uy50jQ3kHvwXxMN3b5AwCVy1NmWirAZuRuk2vi4HWzFLbj2M/oT+lajNkMbC?=
 =?us-ascii?Q?NRCwvCrDlfnhJfRTeJng+Ym+kE+pGy7POP1ftcag0HpyaltZrrDyojeEaNH9?=
 =?us-ascii?Q?xd16e8/ql4+boZ6mLDeNbYQdOMPQfLTQabWZsCqfK286HwO4zYkp5Ar47MVr?=
 =?us-ascii?Q?38SNa54AlcqQgGWzIDUSO5nfl3q/wvo0onjujrKzi5lQY48stXrPoObErINl?=
 =?us-ascii?Q?fFhhFS+ByihAyjLFefTWk+yoAdyOJ2klKA3530s4APAfhlQESPdFjntY8tLU?=
 =?us-ascii?Q?GWgSTPS338ImVpv6xKzz4pPqQj5aFNAlQlwFNx+TYWRJb+1r+hX8VKzVSGvM?=
 =?us-ascii?Q?Js12y58oBjnt81dlVkhbls3/XvacUXyFZrltatvbfQomAiq4PIqM0+Kn4LtS?=
 =?us-ascii?Q?mIh+iHDOE7+zAy0oBPjZjyTFJ7lGb97Px5HZ8FTl6rdO8Igc0gkzNi9CWIbs?=
 =?us-ascii?Q?zWJpMebjMSkXrERjUhwMNuw3UJSBkAQr300Y0PTzM140cvl8xpTw9LWeYqQy?=
 =?us-ascii?Q?7fi4/lPuN0mAJuXpYPUa3qHjuO7hoBnG8/WSXQoPilMaRRy/tFsk0pmsDCV1?=
 =?us-ascii?Q?F8vOACchB99ZmENamgAJg6+bnwxPoR9XxmnMa0BzctGTzqpA/CHZFBs+Z9ed?=
 =?us-ascii?Q?Mk9X6ZSIaXMBJvgFUz3ysFhxb73Hq+WALxyYLEGzU/OoGqoFAjbaDf542XHK?=
 =?us-ascii?Q?xFqBZrJpbOkvE6qFEpboKbWhPWSvgHGPw/LmLxbjo5IZCC8LrOkP2vXZxNXJ?=
 =?us-ascii?Q?pLqRe0dYt+Q2jBhdvkdraSpSeLvZyEfwrxt87lDO3XvT4DG+e+bqIQwbrBXy?=
 =?us-ascii?Q?1OR71d3r+s2t2tWiBqTn2gUZOAIb5Us36mZxE0AVmtZdldsCYgbxu6m49lqt?=
 =?us-ascii?Q?LKz6TFFXbAYjiwgE/nJYA/OF9UzE7a5+aVkxHZmIhI/s9tr5uYWcNykclxCW?=
 =?us-ascii?Q?pabxBdUAcCddmHIEKzjy8RTJORgd7Br0RX0wwj1RM7BdIViEdDNE3krQJjbd?=
 =?us-ascii?Q?ogMErENNqZ3pq/BzWyNKlpGl8EcOayduV2jLO9niF99HyO6xL/HXQ9CP7pqL?=
 =?us-ascii?Q?MpSeOzErVI72qjOUVtoFE78M9z6IZA6t/HUMpbPl+t179hDSrUAWyLSQMHcB?=
 =?us-ascii?Q?TxhsWT2+5Y9APWSYFnkR+dhkCcByQfukIfVhn/YylDgFoyCO2Gfwsfuv2qEo?=
 =?us-ascii?Q?fLcPzrROuQVj3y7N90GRbq8iYya4rENodVEfQDNE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a55a3a-011e-453f-0b77-08dcc0635a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 15:26:53.1361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEeCYSCrJjlEEXL9KcP/vUpb9zQljEk5RX5x6Kon6ChDiVxrH0Bnp3D9VVVgOvj6Px/p56lrAr1TDmKZTZAQTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, August 19, 2024 23:24
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma Jun <Jun.Ma2@amd.com=
>
Subject: [PATCH] drm/amdgpu: fix eGPU hotplug regression

The driver needs to wait for the on board firmware to finish its initializa=
tion before probing the card.
Commit 959056982a9b ("drm/amdgpu: Fix discovery initialization failure duri=
ng pci rescan") switched from using msleep() to using usleep_range() which =
seems to have caused init failures on some navi1x boards. Switch back to ms=
leep().

Fixes: 959056982a9b ("drm/amdgpu: Fix discovery initialization failure duri=
ng pci rescan")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3559
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3500
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index ac108fca64fe6..7b561e8e3cafc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -278,7 +278,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct=
 amdgpu_device *adev,
                        msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
                        if (msg & 0x80000000)
                                break;
-                       usleep_range(1000, 1100);
+                       msleep(1);
                }
        }

--
2.46.0

