Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F5C7114A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 06:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1DAB10E070;
	Tue, 17 Jun 2025 06:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxrZti83";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0DE10E070
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 06:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rais2goB/PUvmxUL6qbTQESQgee+fE3oxEuTIDIjjEkCObE7lqcfjJbyPR8YRzI8y1gU7+r9adLoPWPWeLLkPa+sLIw8FSFkiqGJAZzK2bSvYdLwfMYl49uATh6vGwYlnwd+kUzfHnTtc+ZRbMN0GC1Y4FKrkZ/DEMo7EW10C5hvs+JFVXc23oe1ehD3vRZMFrEyudbfof5R9qo68wtyrzB2izM/34PjdKuBbs1DBM5PBMFwG41qIfSjwHLhBUGaQeKWSXFsxvThwiXOx7AEBj3JwDIHpqQWc/K+PLXcAUqQ15u7bMyfCoXN0c2zutj36go6w6/6kNXL4ooaLjByzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/RZfNLwM+AlCMiaJLQzOOvzFJR/3Sp0at4WXkYqaIM=;
 b=Rgm/IyLhV53HOIurLyQUkU+nhii+JSWMuiV4gCJYGTn90+VLmx8XxyLSOlLjreXIauZmfzSpW6HiQc+oaTbxAOu9a55RlhBdkHqy+7L8q1tMw8m9y9nsgW1hr0fran50igfQfFo0WiITC9papYZIz0pFYWPfJeGh1Y36j3rso/Coh4gK3f/SIDrjZRllvz4rp+Z8oxAkfOd1pcaqbuIu/7dJqwbibc16nV3GmW6dZM27giL+PhkSmfdd4WEPPgZNTWBf0WVNJRpCorwmIbA1fIvflnQERIKfKPCfDrOPGf88znMMqSFV8YSVMI3Ivjt5AXYsZMAodcC33M750BFPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/RZfNLwM+AlCMiaJLQzOOvzFJR/3Sp0at4WXkYqaIM=;
 b=zxrZti83+ePJGOvB9DK3mFlU4YuDmyJPT0+DRQ7Vhuj50DAQASIcnhf5la24wROYemoiMHrgvy5mg1oj3vaVF8vc2HiKUK7oArynefgj7LA9VMOuIR60QcFADGjVYtgtzFkqj2XNaboMMu7/2JDBhZeZgusKpyqreAiBHiVCRGc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 06:08:59 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:08:59 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 07/36] drm/amdgpu/sdma5.2: init engine reset mutex
Thread-Topic: [PATCH 07/36] drm/amdgpu/sdma5.2: init engine reset mutex
Thread-Index: AQHb3zUpOFo/lSwS8kC+DzfX3qhvjrQG3i7g
Date: Tue, 17 Jun 2025 06:08:59 +0000
Message-ID: <DM4PR12MB5152716F888F5F3204788741E373A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-8-alexander.deucher@amd.com>
In-Reply-To: <20250617030815.5785-8-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-17T06:08:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV3PR12MB9167:EE_
x-ms-office365-filtering-correlation-id: b3948300-0443-4ca2-4fd5-08ddad657358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fDC9cBPAwmBHCgVFd6Ao/cLfhVOF3HMnRH5zFq57elhfWmciNW7JAOJPl1Aj?=
 =?us-ascii?Q?Ieh4Q+G6jXyLlJv7v+FsY+EpQQxTV8izLjzUhoupO/GJMBZbC+cODzrC/Afn?=
 =?us-ascii?Q?466g3Xawe0r54UvkVZlOjK8k2PbnrmmHN2S5RvHKLmA549N8En0cEbOA/CqI?=
 =?us-ascii?Q?GFf11hFNcFYsx/H0rqB2agMcmVqBws8Smi4G2KzanFXFZvyuedf6xF4lslzM?=
 =?us-ascii?Q?M8j5IIM0aaFg/fIuldBOLXWjz1IkjMl0cl/oyfIHCqSAibqe8OCYCA4ivIe4?=
 =?us-ascii?Q?wLhSZP1LDgYGo2vXaUAmaE5hDXUii8zV3Y/1Ok2J+JF7JwowOhsdchF8/Tsc?=
 =?us-ascii?Q?bcdaHWySGa72XjDtj6+hTgNkCzLhLwuuvWSWZTvqDR2HUgTyzuD1E2rOqM/A?=
 =?us-ascii?Q?+3kyF+DdnApAThgPT1gTV/7PrPx0ya7kyF4VUB4IydSyo/EvqoTph0IV0CTL?=
 =?us-ascii?Q?yQQSMpY1nNjH+tJbHB4yr+ry/FieCtq+ZsSKxLIKv1wEjxvaBFjeJJabvSLp?=
 =?us-ascii?Q?HipZOHWjQPvsIbHxUhdaPtDvxDtiQNano3H7315tyoOaVWNrpmOrBPFGDC6S?=
 =?us-ascii?Q?OyJUwaTee0uQqxV1KxwJyFLOyh/0oTh0L+UTXC9p74Q2RlMwiB8MdlUAsx80?=
 =?us-ascii?Q?ykesvPpsL+FxMvPpZCGRyooOpYU8ZDxGqboi3INilv+tg/CuxxdLndTV9ldf?=
 =?us-ascii?Q?iURXI8RE07qdIMM1f9MZKhH4s6R6YdrMQF9WdHl8rGVAfSzQQkzQ6xuQf3WG?=
 =?us-ascii?Q?GoHvFOjT/yYdiRNvIVA703yqFMSSTisHxjthHATsJodP3kEZyzfX6U1tDa5h?=
 =?us-ascii?Q?AuzkgQZ2YoOFQ3CKT80S1DLLpmAPoGUdLoSie1x44etrxGlCxCVceS8fAzjk?=
 =?us-ascii?Q?HH3TKVu7OuTkhOZVvozYfXU6l+IGdA3RYq8/VZMyqXCS8h8IY42SN9xzypfU?=
 =?us-ascii?Q?Otl/HS/bV5LKPy20O+sunGq60lgEGB/9l0JNBVnmXr52hzjeo8mBfJr912N0?=
 =?us-ascii?Q?PDjt++x1ClSj1GAR7siWcE59yDiu+8PZ7v/nrTPhQHWXoCj/8cCdHIkwtAIK?=
 =?us-ascii?Q?ZbC4zu16HRQPivpX1MdwRi3JIvxX01ioZuY/HmcawtuTtpa3sMZM1mYibZux?=
 =?us-ascii?Q?WC4VXp+c79gAzpNu2hc9ValGdXRRMuCvLCqvpuFXsirmcw2/dOBL9MApmX20?=
 =?us-ascii?Q?2khzHs6tFBAatL+IDDBo4mbt4zAuGgeZaxB9oXAFjW0J72Y0VwoAGg2edRuk?=
 =?us-ascii?Q?ZftBJ7eLgfCw3XHsPnYo0QqEs0AT6qAsoCig4x9jA06uuiDhJHvHe+hDEmah?=
 =?us-ascii?Q?YKt+xMfSY39hh27jiGZsNqbjWESVLFgxYtYW+uIXxvzb8mcW25C1227RpDhr?=
 =?us-ascii?Q?cXeLqDXE4ft0815sNQy4I7aLCORAAGMAUgsWGHRlIZj2RLlwVp0pLVY21bqQ?=
 =?us-ascii?Q?+kQ6NoxWQ2jJpX2CF2zpVoXyYyNEd+59ih59JxCgK+PybODF7/dvwg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p9yMGryXjQTy4cIA4MuMGYxMFEftgDx52jZ4Ax3RBlQ40cQRzsqkOKJuzyF1?=
 =?us-ascii?Q?hYAdabgdMq1yQYHuVcF//wNIkRbgiKNpRDJTMbgJuEh8mpOIIT/WWJ4PR+0s?=
 =?us-ascii?Q?kcJn1kOf37220dbxmSxxBVeApyBi/ZGg3fsiyQZXjmKS67U5ssOtyIjRxo8j?=
 =?us-ascii?Q?27yNaa2VhU1j1Xg4sEiAUiNLoacazWmNgwYJnHggPmzzV5AU3UUFR+yUax8a?=
 =?us-ascii?Q?4eBO+sEx0/WTLnspfginS2VGNyx0d/zZ0u5+jDMJNNj/PFCmfl5T/VgzbT1w?=
 =?us-ascii?Q?AcbnoyVu2xR51mZM594WM+jZ/wBxJWxSvk7JUgDVvVyb69+Tbsg4U1vUfe/R?=
 =?us-ascii?Q?5tL9AnTFYG7INBsDHB3k5fwsniyUQBt+qauLggGFKQFR0pPWTYO6d7wKWUVl?=
 =?us-ascii?Q?UxDS0hYEJhV6vXQZyq+turADo6xo+JumtzOms9ppswdSmhehWpJPjBMOTaGR?=
 =?us-ascii?Q?ZIIdXjfSMROkBHSHtqWS6Z7xwtWxchtU6wONRLB+/kOZCmWsjVhy4qfgKl6B?=
 =?us-ascii?Q?jBeaXjSoTfY1ewZiLXXLSpxyGmJMc8Q6rmYB1c2mhFkkvmnJj3+YRpHn0SP/?=
 =?us-ascii?Q?KVdEfbsykWa+ybH5Tc76Ug35dHtMdgbFKe01NP9BUlAEqQ6gII8zEV+teD0H?=
 =?us-ascii?Q?5LhF1bNkO9nvQQrpz08oxtO1YWkE9Iof2rwjGxUsKTWEOI6h6CgtF1Rx5rnU?=
 =?us-ascii?Q?SsZo0jtWardPNaIKqNYb2sXORND64lthjYVbI0sE9Gnq1PVA1RPGJmfZCsKX?=
 =?us-ascii?Q?zQVZcL90sDyOpQXxqnTmbvwK1K0+We3Kf30XJr8awK6TrNwTbCOcWKw6CjQD?=
 =?us-ascii?Q?UxBVZLa3ozpk9RlS8yOdHL4yznOVT9bKnXQkULE8BjRo2qgONz0NqwdqqkA1?=
 =?us-ascii?Q?ca2N2C/BFEj31WiQ4TikTTSNh6YFRW7e1LbUtpeEoinwIQCHll2e5VlU3pUU?=
 =?us-ascii?Q?wbkIMljcr9id6JE2CkaPW+ocOVm1E1AnjASZy1Q7LEV8G2oX2VBUNlLpe9i6?=
 =?us-ascii?Q?f6VEg/1nQNb3fPpd1/kr2Q/cDKawKGKXT2xg/5XTi/NAxLuNkFzSkc3ZQMDr?=
 =?us-ascii?Q?xOKfV/1gozZPM8fglh0AUR5Bxx1BzRYgHkWjAFKsl2h4LTipC8HEEhxkg4hV?=
 =?us-ascii?Q?AgzELR2wmyJpfI0oJ9XLEL6LL+BXD2Qp75cIUxvQ16qxYT4akIe6j5TDSDTC?=
 =?us-ascii?Q?4OvQrNUuho1xuAIRAH0C+PGMRMoUNwYRg5nJurHst8y36rHyqX5PpLb1b0n7?=
 =?us-ascii?Q?/DQl/fUoK+qrb/rQi7o38UOPBEZ3Aow6mUcEbKOsOo0IXLSPs0uiLtKB+V8U?=
 =?us-ascii?Q?6e/Ahs5Np+Vk4EGiZdkUy03jXQlvQmQIGz81DhQUXkxKCQ6iRfmE0ubrdgBC?=
 =?us-ascii?Q?Trmndo6NqNeD429bnK229ABg+J1miavO9Lm2kg+VX8rfS2cpBTYBU2VOL7yf?=
 =?us-ascii?Q?bOfGMkUQ+Z7HB7wv2oioDKsC57mvn9H+6xF5QH67xsVzjnGkQFpng7L0DrN4?=
 =?us-ascii?Q?b1LdCiXl1NFNbVBzqIOlZfyK7v1P8vgx9zizc/kcRoaIPWlQt6wf/56rQUkK?=
 =?us-ascii?Q?L7kkdaqkTq2f1pCQlgs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3948300-0443-4ca2-4fd5-08ddad657358
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 06:08:59.4823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUyG8DuZSTCVdYfZCawpXnlxRsPY1DNT9SIBD5earbOlSiyppAY19c+uoNsZAwLIVMj/G3ZKGyN65Fgp2P4Pjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

This patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, June 17, 2025 11:08 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 07/36] drm/amdgpu/sdma5.2: init engine reset mutex

Missing the mutex init.

Fixes: 47454f2dc0bf ("drm/amdgpu: Register the new sdma function pointers f=
or sdma_v5_2")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index cc934724f387c..0b40411b92a0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1318,6 +1318,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *=
ip_block)
        }

        for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
                adev->sdma.instance[i].funcs =3D &sdma_v5_2_sdma_funcs;
                ring =3D &adev->sdma.instance[i].ring;
                ring->ring_obj =3D NULL;
--
2.49.0

