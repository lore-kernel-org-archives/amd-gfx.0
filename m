Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B5FCA0ED1
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 02:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F0910E06F;
	Tue, 12 Aug 2025 02:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hHBc4cbb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8844A10E06F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 02:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayA3X1/Wfyb7RtQPk7HLwUMdV9lgXwluiFoT4nt68FhQroojIM/y6hhTQDaI/xMaMvFvGQDY7lYADyfwdEoTw7/KBFAyj8ni4kCArwxTbEPKQazR/QGyPq6fWwmCcovrMrPniALZZK1HEzZzNJjG5QuwESUDXEC+6q0cdhfcY7ZegxuEDMwYO1n0AgiLhvLUub/TBCy0HezJTVKUChk++OxKJt8bO4A4qGoP2U8LpARzx6PPZv0uI7vASFD4iydoa8s/nnEROcyQAi/RL0WtGkwaFiHIi1ZRGfPLdVPytaxm6+cUDoa3Foar9qNGMA/xJGNXUXx2Xy8JiWQiNP8S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/Yr4uHBzKCHOEKI6DyYlBYEeN3+FyDmvMfxe/s0WXo=;
 b=P4xyelmVlHzolQBPQZ1ElACfdyeCTuE6yXC6BY5cEhp9exhxIV9c/AxYPMCcfwcpiXaAEFa548Eam7dMDggmlInp0gtgdEPA758nMG/2W+uGOhK+TN+GISaaxE2Mt41dnPOB5RHNdeV7bb/gqW2yTPolcwJXSHigleRb2xfmM3tHmyC4KeSMdYj0sF7pO9ar8wYCoU/5d+87JC8P6IuL6nGl2ee2oTEUAB5Cy5OIpHEY5DYkTuM0THjWQvCxZ01NijCF+sztZ1NQ99gdDug2I1NrjkwgIWGuV/XCBTxqnVG1/Hev7lR94YCjeSY4E6bPZRqFsoa+gBcqke96BJ2s4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/Yr4uHBzKCHOEKI6DyYlBYEeN3+FyDmvMfxe/s0WXo=;
 b=hHBc4cbbhTfr/kri/wIXEDpmz1OZrP8Lx14SUcswkdcnYFJz0GHANTvlH1r4HqD5zbUb8EV8tDNIykQvKgIHU1WPPvG6dAcmlsnkwZVRQ/HWWgGlEPVtOHgeOe9aGM6emV4xEp2xjexzI6MFOKULOp8IAXJTu0UTZSYA4kf0pEc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 02:09:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 02:09:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix vram reservation issue
Thread-Topic: [PATCH] drm/amdgpu: fix vram reservation issue
Thread-Index: AQHcCyzatCfh00FJkU+05QuEk5A5YrReRbSg
Date: Tue, 12 Aug 2025 02:09:07 +0000
Message-ID: <BN9PR12MB5257AD751BB5ABF75162729DFC2BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250812015933.2360801-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250812015933.2360801-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-12T02:08:43.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV8PR12MB9450:EE_
x-ms-office365-filtering-correlation-id: 1055925f-bda9-4897-eae9-08ddd9453832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eiXlZVjr8ZfSn6stMilzxs9Nk1JllFHWdR7i8Vt1IW0kF8P35OfPyzkmMnAp?=
 =?us-ascii?Q?Sej6jRoqXQmf1zJwTXyPeuHs7ckwSwkRJUilM/V8UJ99TzAWl8YIBcUTXltZ?=
 =?us-ascii?Q?BKxV+eKHakWd+NZaIfsq/l5J4dz1RiykNbnpslxZ1QNlkkKQ9AGYNvbGBYpB?=
 =?us-ascii?Q?rep8CZFfmgFpKaWJXmrjtL0hTmyAaKttvQJiwSw0Zq6+YC/ix0f6u/lnOV3u?=
 =?us-ascii?Q?1oXSv8R4NKqwZB9631SmQ4Hc/fbMVVLDZhUVZ2ONh/9/A/ncpRgvHBqHYuvu?=
 =?us-ascii?Q?vF7vu6sAQ4vPwKZJnpI6lnv+DFBW+Mxvx21pfNziZDu+Tsh1D1AtLZA5RYO8?=
 =?us-ascii?Q?sNgSwbJ3g+4Y2NFLUMUsiRS8Wg8chnfeoPLADiIzhTj+B4ZDsVEIvmOB6sgZ?=
 =?us-ascii?Q?R8BlySfr9e0dZ9OJDSwzDmyMXKDf9GaLiYH/sXL86Np0l7a4CxheGYxsQ0Z+?=
 =?us-ascii?Q?3tYCb22uP8S4hs3R9mGfZnVFGBWJW7GbjieA30m4oRQ8o/1tTfPFKhV3qPR/?=
 =?us-ascii?Q?FnibXUcuWJMixa0Xbp0vn2CkQj8yEemSuTxN7iRMqxfj1gvgMnLt1Y3/wOPx?=
 =?us-ascii?Q?0oCbCRLqK9QWne+FZxo2vhPcdOApjZS8rNVvVwVbhkcpevNXqArU7wmKjwBD?=
 =?us-ascii?Q?s/TEwD8HLBROPYb0R1h6kSkP4xGSa4WZ+MNs3dWgkP0M94pQiemP5olKQyjM?=
 =?us-ascii?Q?er+EPRCtEBJal8lITulmH7hFTBf4a/aw1MpT96/VkSOSJnL18bMa2QOjOgIK?=
 =?us-ascii?Q?taZxkTvLdj5nWcH3Rq4mCu+Q0X6maZeYrnNEqfJs3YaYBaLjpMj5SW8Ko6Kp?=
 =?us-ascii?Q?dmm1DM9XUjHOi5AuJnA3Totpkl2tcS7EvwTlvfCHK7RRdAmk2v8RmzaW3EDS?=
 =?us-ascii?Q?jdN2wdN77xxFk4fYvoqdx3C2wulU8vWHwSZkjqtiX6fDKkrHuhgRq3gesyFR?=
 =?us-ascii?Q?EnpRZ12RPccDmi24KFc5WNyJkRTwKEzCkKUr56G5Hkf+evgHVU448OglgkB5?=
 =?us-ascii?Q?S5twajFzJbOLr/8ntjDpCUCYBebAqoJKydEwRlOw9t8nmnXrl1wnn8ycITi4?=
 =?us-ascii?Q?fNqASogrYx03xzF2JghzNZuOOcgpohita7pcK9SQI72M2Z0Y5pRERJFP6jc0?=
 =?us-ascii?Q?fjleOe2/kMQavibkbvzhJdL6bfYFRmG1YyUAc63R7I2ktkjxHDvVN1Wg9i8k?=
 =?us-ascii?Q?7BBwcu1D3j0GGJfN37aIQSmj0K3TxQ/qFNNdDSxnsDrhznWI5VkzmTRY0/xK?=
 =?us-ascii?Q?/994180CO9lNdU3D1IqC8qV5DpbtBou6BgspebqBnoJWBu8x4yv74Ysaik7m?=
 =?us-ascii?Q?cI5W8V64BxaDL5ZQfNaFJifG/3U6/XurtWIf1J5YV+52gDi6ryUQuFk8F6/L?=
 =?us-ascii?Q?wNWhmR2vQ7deD7dOx3VdZi9rIqQ/uGLQdsYJAw/KCw5HZ3TCK7yfpVBcN9/x?=
 =?us-ascii?Q?u1DyAaPwkZPGzG9LAoBoL2UjdJOcHrZ+0GTYgSGgO5I21sZ5ruoVdFD7plhO?=
 =?us-ascii?Q?lEFQyyQ6lwt2Q/w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2WPLAdOQ6h2p1UN1lmxMuLL61A2rk986lUutNu/qTrBvIJepVhdK/mTJjwhN?=
 =?us-ascii?Q?I1bgXcaMHdIaM1gbWyJTTVJEec9a6YAHTxpEIV7IVaYbz9eYs5SkbbICfASG?=
 =?us-ascii?Q?Rnpdk/ZDhl7a66VRaCh5AbZOgdOKGvygz6pT2AGQktzHY9HTU8acx2+SJPLE?=
 =?us-ascii?Q?M6gbCKOwzSJSR8BHNLLaYKJy3REw+SIEYPDgS8PlOca0GjJ0cnz6rGlrNlEo?=
 =?us-ascii?Q?wnOZE4J9fPz+245ZGAU3WftKhWu/0bIarFhm23/cSt2n67DVBlhkAAb1QNrG?=
 =?us-ascii?Q?ENANDwCsJTUwTK9VIc/9O1VLTjiKqJhsQz9/ST4RkqJ50mWkm03pLirppG2S?=
 =?us-ascii?Q?OCpwXf5Rnj7EKbFirC8cBYcBJgt4i6Pl8NmTNxXfwhfp3qZ9TdsSyEuwR9Mb?=
 =?us-ascii?Q?Pg9Y3uGl8lKzIs86O7ORYjDv1t60s7KDFyxkKUGKg6S9gVzht02YipM809lO?=
 =?us-ascii?Q?1hmjS+SUeyYxJnftxwOQqaNbfhLYRrrqAg2RhJTvb7h3s1hXGkX0g+b80MNx?=
 =?us-ascii?Q?p3ZZ2QylOVTkJh/iwW+vSCDTOStf7jBdmxJky61LNtGIx3GJNc53sQ3/8GWo?=
 =?us-ascii?Q?Ut7orGAEqvM21CKVLEjFUPoqCzY+oiUd0AsVo7lSb2hxjVCqmX58BLHY7S9+?=
 =?us-ascii?Q?MvC7TY4H7YRqgVVuCoTuklL5EHYdicW42+AjmSTx7Ie4zufrH7orCPmiS2Hp?=
 =?us-ascii?Q?tjamOQ4zYCS6PaJYlgZBE/IC5v0KphXN1OnGCfNeNyPC/JKioOIkXYvgPV72?=
 =?us-ascii?Q?t9gKyRQoVIyeI+m7H3SwQi65BsdeBADvlPv2RhGzMZixlCorL4quEDI9CZaG?=
 =?us-ascii?Q?LtMwMCE/NFRV+bMhwiFZ0S5RsAuPbVkK2kBTkVHJ6kmBn6CqC+Do+mCUj8y7?=
 =?us-ascii?Q?WQla5nxd1en06Q74iYoAfGGoMPuVVbTPtlwg/x2vsb2yXOOB+/rm8lX4nVBq?=
 =?us-ascii?Q?Qm5woF78HYx362sNZWX54uKBIdx9EZstf7vxfUvAPKITr2b9ANDRkeR0jFR/?=
 =?us-ascii?Q?wF99EWtkMtE1ijmwCYUSGOK2Drnz7Atj6QR0mD35p2IMx19FK432s2RVEZfg?=
 =?us-ascii?Q?AkeeSIAIDdXUxOBUcoh4J8Pzgal6KziuO3p8RfhqeTzFONj8EjVAQFXa362Q?=
 =?us-ascii?Q?8JVTc6yIb7bxWkRnCkSf2jlN0I4revzz4erQX+RefB439V+d6CR/ze4I/ia0?=
 =?us-ascii?Q?XQogYoPU8XGuw9S3geagCluY6jLH8ugLOZALrgCkKu4kL0U6AmpQK2uSItLV?=
 =?us-ascii?Q?m568TEeI085sNxulVPXwPMljCNG/9hav2fpj7ZQXCPaxxwZSC4ndQ0l+dGNM?=
 =?us-ascii?Q?RWNO2YUjTqSj0FzTljB9NZOMJ6RP+xO8KdsBCWP3fvZsBdP0+JamRUQojQ0V?=
 =?us-ascii?Q?5C6o2u89rzqoFEMQw0AROvYsTrKFVG8mxQkfjyPlT+/6imhXVP5OwW/oFiY9?=
 =?us-ascii?Q?m0c7MpalpcmgT8EjC/kvR3hWTNt5dytVkeN+yh/q3K7AqppA/aDHBGEJf7bF?=
 =?us-ascii?Q?wfkWY8rCbm1MxL3xOxhIKMPzLLWGoSnMs6vrKvIhDx6jPewLH1NQe5TxzHT5?=
 =?us-ascii?Q?tpSNmC8XZL5UrQkBRaQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1055925f-bda9-4897-eae9-08ddd9453832
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 02:09:07.4835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIXPRAXn/d6Ffr3kl1A6nYB+7vzJO9+oSxt1yZxlG8xF/jBrJxQNMoBJQnRZrAPVIPqnEp79vLh52h30bClDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, August 12, 2025 10:00
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: fix vram reservation issue

The vram block allocation flag must be cleared before making vram reservati=
on, otherwise reserving addresses within the currently freed memory range w=
ill always fail.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vram_mgr.c
index 77ce9cf28051..e69db0a93378 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -685,9 +685,8 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_man=
ager *man,
        list_for_each_entry(block, &vres->blocks, link)
                vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);

-       amdgpu_vram_mgr_do_reserve(man);
-
        drm_buddy_free_list(mm, &vres->blocks, vres->flags);
+       amdgpu_vram_mgr_do_reserve(man);
        mutex_unlock(&mgr->lock);

        atomic64_sub(vis_usage, &mgr->vis_usage);
--
2.34.1

