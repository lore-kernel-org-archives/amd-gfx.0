Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFFBC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 14:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE9910EA21;
	Thu, 20 Jun 2024 14:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LZ0tGSNY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50B310EA3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 14:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcoX45bCFiYaxRIFYnF61Mvp5B5XoO0klzRf+T/aPp2wa5j0TsPhFfm40wgfYM61GHg3+mS2B5HODOIShvoPENtjAnmqGmUMUWdGKT8t6sqkPYoYVc+gnMTcsZk1vh4H0uD85RpiLfNi5w0a0OE8AgbvXA9ZqPHFNOePGeDwPdwRAb9gRiywXHuA5nZOohBOElxS6jMAvcbJozhDpC5hkANcJGYhce4hDz5zW0EGbdTd0UFZhI7EnUzOK74IpbK55fhgZOg+bBz9wpdB+Ph2EPfrTB77mGeVl8J0PR+NJDnOc8JqDFbUbISTh5+dUjizGywrAjTSW4uvECTbBAFPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ3TL8CmhAZ4m4g00c6F/AI2bQ1HNKBPvJRDv87F4rU=;
 b=U0d2Ybiy2w+21LcVWIs7N6p05sYQoPx5aGSSc/XIsWuARzmO977+8BPS4stkvPannViUksZwf31o1KgH+rcr46wOFx6aGnujJT0GGRyPOoOYDleTUQysIHM5GMBhcDCGZ26wwYVWNerTevIfYS+EX4v5sw3RR6GteOB+QOIuDoPGkbMOByW43THuRljpPG76Qnc7unmnUnOR5ezIXZd7ydIK7OVkeTL3bXXNTtQaAoFaXl9jlAXEXhscjBml0XzVqYLMvT2RRVq5ddP5uw0Ym2rkgIzuvv8zmqwbP2xW4dsT3eAiX+AB2YhTQ+KeC8o4IYX2JzWImN/05OkbVaT1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ3TL8CmhAZ4m4g00c6F/AI2bQ1HNKBPvJRDv87F4rU=;
 b=LZ0tGSNYWVAiW1n/Chwqq4eRqu6YI3b4tgryBI4eJbhXqQ9WMkpvbWYYoQdaHMl33/eBsXUElo/5/IiseLqtKPREipxHHQ5n13wbZ7Ix75KNfOx9g0L3zO0MemQdBH9kd4wcwoeTh//rLLZD/czTko67qhXr+588Zpuk55jW1Gc=
Received: from SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 14:15:03 +0000
Received: from SA3PR12MB7902.namprd12.prod.outlook.com
 ([fe80::d6f6:d78b:2d33:30e0]) by SA3PR12MB7902.namprd12.prod.outlook.com
 ([fe80::d6f6:d78b:2d33:30e0%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 14:15:02 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: update gfxhub client id for gfx12
Thread-Topic: [PATCH] drm/amdgpu: update gfxhub client id for gfx12
Thread-Index: AQHawtsN4FkTADp4hUWgaZVCDJmamLHQNmhggAB8LYA=
Date: Thu, 20 Jun 2024 14:15:02 +0000
Message-ID: <SA3PR12MB7902C19B353CA08B038A7F08E9C82@SA3PR12MB7902.namprd12.prod.outlook.com>
References: <20240620062618.3285-1-Frank.Min@amd.com>
 <SA1PR12MB5659B0EAF1A7F230F5875C73E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB5659B0EAF1A7F230F5875C73E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cba6d378-1fb5-4df4-a7f8-b86ef26d7486;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-20T06:49:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB7902:EE_|SA1PR12MB7101:EE_
x-ms-office365-filtering-correlation-id: 6dc33b64-e485-4f09-1697-08dc9133604d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZCBwo6zcubIjNRxymP8w8FbyeE0ZzIHza+YZt1dpA5H698oQIfG4hRZy4ufJ?=
 =?us-ascii?Q?JK2hV00pJIHxSMAqpbLdfcEEptKd85gI59TraZMP4IHpVALaClnJJxd01eHF?=
 =?us-ascii?Q?YTjuveKPCxdFoRkyD7TcMQTuElhOgjwIMLQ8K+i2TBMFhiS05stZ21RXHHzs?=
 =?us-ascii?Q?RtYmWomyU7Ob8Yo4qKeWdgFsUG5jTmeVur6gcyHjz0k3Lf7f5FXpVL59rTGl?=
 =?us-ascii?Q?5E9GHXVDYXEO5ebTmHOzzzP9bW+3ur2Rk7uLBiVZCiUUcTV0w6R2O9JnwgBU?=
 =?us-ascii?Q?i4uGpCxIi9SNheJFiMCnIC3oTS8l9vrwdCMDlUxGVfb7CYFuuqwZ1UZfWkmi?=
 =?us-ascii?Q?mNJkxLt9qJF/nYuFXdKgqg659WMCS3jzG0IacTPLqf5GS+vgZrG9YhYLEEoj?=
 =?us-ascii?Q?BQAC1B533L/w7bKicbGHyX8Ps9Aze78IazIiQGRUy9SoItJUzKTPd2mpiDLQ?=
 =?us-ascii?Q?6netNDMU6aQ4z5G/n9IzEGdZA3qWMNs5ry5/vLeH+Zi86942evimJWI3Kuew?=
 =?us-ascii?Q?ZAE9JzpYGjs0lky2cgzyFAwRPSVsTLectwJE+663mICGmidwILLwBJtmDtPE?=
 =?us-ascii?Q?5MC+nw5iqpWDvbckB+RVXUrhMDK5xTf/WAn9bIClGu4GNo8GChkcDmEoXJEq?=
 =?us-ascii?Q?DlqBrMYVBu8XeZphnsPhna1tQ/IuLDDo3EHIHPo+/HThA81joMTtQCW/G9ea?=
 =?us-ascii?Q?Dc23AfSQOIZv+yOrIRE92SE+krWs69esucCpnSzxMaeq06aGHZLiVrGwSfQO?=
 =?us-ascii?Q?KXBh06pBR5jOwiqGKyYTWEgfr8kk2jp1edhNxFGXrcya2D1JisTY3s5KIc7C?=
 =?us-ascii?Q?Y077eKAHvjkI3AogUUB449VgQZqKMirqJZyqBcrRd4zjyHTJIDBooaQbQgUZ?=
 =?us-ascii?Q?DxHsnZh+gQYFooxvprU6rdZXvw32mO47jd3VfUzlh4M3hpWD/+KzOgmmgQX8?=
 =?us-ascii?Q?6iMj37pn63g1TiqP1t7H+k9kSrMxsfH/PZB8T5nUb2zCFVCD4b4nL3HWiald?=
 =?us-ascii?Q?r14WCl+YRxMdEipeXulWkzZtQPXKaj/jJBbJcgjfjenSRK1b3ZHDqnxOR0JM?=
 =?us-ascii?Q?LJ4/2qiDkKuD1E8yGQgiiFI5Je7zbEkJTPZKw536lh40EBMLP0JJNXf+2soJ?=
 =?us-ascii?Q?rtLVVKBiN6GpcmZbx+xvkaiR7XR12OlIrL89w5b+KifDfmzia543uPqxXRYY?=
 =?us-ascii?Q?HdffVGuqh+jCoaz2wzJNtUIzlf6nk6oM4J32WIjSAnBKJvd+yKn0rPc4tHy2?=
 =?us-ascii?Q?9rYGEnS3Pi3UTm8TGegtnSC3P/B8BLbFDJD1AyN+PocIAeqiSVRtGUwVTol7?=
 =?us-ascii?Q?XXiGuYrmTVniq3k07KpMEYSBWsRVxGzRNwd4gokhVGlyNFAyh9ElNqflpz6j?=
 =?us-ascii?Q?YQRE9So=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PuTYyvVXMGmkDau6QCXDCfaO62MQN078UB9vvicTRI7GG6jVfc3R7B0/rUaB?=
 =?us-ascii?Q?t4JLoPk/LT0z45Snex7LnGDnL7tii2UNWmbnhStN9Zg1RBuGZ4AbhFe84ddR?=
 =?us-ascii?Q?4+Cwo5tQXSKo3xKeHOUTPb4++XdSm1EAhziyKqPZ8nY92JC79GUl+dp8sZu/?=
 =?us-ascii?Q?eZSpxLU1EaFeb8GioxWxicdqs6bwzPLXJCBfVhtXY9bOLuK6/ZAs4ZSD8/Uv?=
 =?us-ascii?Q?BsFKkMnCuRkl/MY9T3sVbaK/NJqCMeJ7OPSGabM7zIF8hNHkdXM0+HE3dyBA?=
 =?us-ascii?Q?jycD0mpDV4/ncIrxohqie81MV7Zc3drbsxy3OlGi01O1uGC7+DKfx2YAheWZ?=
 =?us-ascii?Q?lQgxp8uldKhckoQ2neSuJ1pwwbxw7elAcylLq/x3OedYYawcQqMw975ae5zK?=
 =?us-ascii?Q?/lpoX6hKZA9C1OOM2zdq5AnPfVenFVopmYwjEnhv7JI5n7HW9hgcVVMLKCQX?=
 =?us-ascii?Q?OC6vqcS8ZlL5JKO4xwj3KDKmuYoT4LVCWBodKyyHUoaTVARDINpKUqcGW4gT?=
 =?us-ascii?Q?CAV1qIbgGGyZmeV5sLyL5/t8Eq4hRDuYretVa0bRFRrs4V5QWV2dqvb9Kw/7?=
 =?us-ascii?Q?oYjJUh4c4sUJTR8LOAHiesnizbD8pmDUF9KrKaIgMHp6U2/ljNPyvMxDEawB?=
 =?us-ascii?Q?KYvGZt2aKt7ZPDU1OQfMLvN7XwJOmV36MetwvtAtPICtR9Fmk9B/B1HU3Ikv?=
 =?us-ascii?Q?nPbhmX4OuLVz+e6msbKfRD5+pmb6kvSHdiitz9xxCV1LGBBLB1SdPynPpazg?=
 =?us-ascii?Q?zLuL5sXH65UGIMWyLQyycRCKb8N/QTk47oPmizhVG7yA1XhwP4uqk4uW4i3S?=
 =?us-ascii?Q?fb344qTjrB+2SybE5YxlBVgCEqQOTGKzYV+ulPRUEzRDBr7T5Ow23aEgsETn?=
 =?us-ascii?Q?dbm0Glp+Y4ovSf21FXHxeGSlvsXQsI0g7p5VygjjiCcSqeWM5oSnSrVWPZgo?=
 =?us-ascii?Q?KesvrzEgshPMkI81adu7jqK3KbLlTNh1MYKrYJsRomPPqxp32r2WcZwCNmf2?=
 =?us-ascii?Q?WhtdQD+QlAgO3dkZ549Lm3QyZFdf79fRC2u+dj5Dc/bV6reVj+zXzf315hN5?=
 =?us-ascii?Q?Vt6VtpG+XQtXSlDpNYPM5zml0rpXtFiikkeYji3spTTKk6a4aA1ept3LsLEs?=
 =?us-ascii?Q?dnHjApIeLP20qB/ZUBx0Fe0ZTKCgi+bJkItVLDkoY+RCWvB9ojFPZ0HPjdPA?=
 =?us-ascii?Q?oPlmsJtDxOLEmDN9uMOfsIw8Kn47WhQQuG/4UWQBScUYgylemqW2r+P37iAF?=
 =?us-ascii?Q?vgdh5/NumKoQeRjdlqmxBZlRB17f8YELSyaLfDBVt/bXjOPcgB97hCqEkPrh?=
 =?us-ascii?Q?yQXYtuExTN6M2FfBjVonwQDq2/tDbU4hU/0cj2sZWrJHs09cSofAH5jXuWmU?=
 =?us-ascii?Q?ZmCZ2TUc3cd1dW+3I949zVYjZR6AKQFNrpNHIDly+FSfc3jLDhxnFv3G5mqx?=
 =?us-ascii?Q?7PXmdZ1ZYBs82bRJIec9dzR1bQzE3NEX6sOs76agZnRGQcMeun+nfnP8GT/S?=
 =?us-ascii?Q?9fN/cPcuBX6W0W+xzmfjtkrVkO1HwXljZcBpqAR5pde14VyjwNlQqJ5Y89l+?=
 =?us-ascii?Q?jO2M5tRW/OyAOOxn/cg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc33b64-e485-4f09-1697-08dc9133604d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 14:15:02.4492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prf4PVtE+4VJqrCkuqJJ5Fx4HoLQo50ESjRknnkQhB+/t+CroN/gFGOTw3PX960Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

From: Frank Min <Frank.Min@amd.com>

update gfxhub client id for gfx12

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfxhub_v12_0.c
index 7ea64f1e1e48..7609b9cecae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -35,7 +35,27 @@
 #define regGRBM_GFX_INDEX_DEFAULT      0xe0000000

 static const char *gfxhub_client_ids[] =3D {
-       /* TODO */
+       "CB",
+       "DB",
+       "GE1",
+       "GE2",
+       "CPF",
+       "CPC",
+       "CPG",
+       "RLC",
+       "TCP",
+       "SQC (inst)",
+       "SQC (data)",
+       "SQG/PC/SC",
+       "Reserved",
+       "SDMA0",
+       "SDMA1",
+       "GCR",
+       "Reserved",
+       "Reserved",
+       "WGS",
+       "DSM",
+       "PA"
 };

 static uint32_t gfxhub_v12_0_get_invalidate_req(unsigned int vmid,
--
2.34.1

