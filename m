Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94454C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 09:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EED110E189;
	Thu, 20 Feb 2025 09:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TygXCtgL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2C610E189
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 09:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEk+5UVruS3k/LypzVZLkB+w60GegTEV0+hZc2P9Ju4L4kaugHc3ZN5tDJ6pC7rmzukkwNjKsp6KdpxWFWyiXNfM8DkyR5PJnpQ59m+TfTnKVm6hB8QxxUyXnBG7gRZq4R2ZJ2hNysoAAKcNYzgdR/gDSBU+LCDgIufwId8NZO4LGZyGf+SdByDaqNRLraiu/0DOqHZbuAkixevABjtFhgyFbCNeA8ivjcUMXmLZJAmkr1v1uwsdKIovsmMoTFjlnYgwSMzzZPToy+f2KkzpVzrQSzyKpZUl6CuckkwGih4fusmRxuOrYVfT5qhFJpdaG/zxO5O5yG/h6LFf/sHbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltZ5srBAqKo4wC7oJ61QVz6Qw17hi5kiH6r0lJyFlgY=;
 b=Zjnbm/V4wPHMD+evcxmvnspoLBgU5rP8fbtknBHw83DVCxBu4vHuboVJFRjFfzIw9h0nEwpTebKdgLySCT9PjikrHkkdEAKOEW7e/BvIh8xLlUBe1kWa0ogpX9GVtqQlbBz6lJsA6VliIS2RBxPBnzlEcg8QPz1wcFtkpAaGbfwhfIUDWt6eLSWw3DvNfp7yg+2/XTh0KLFqCus0UwgFvJsJEhvQjqUzEuI8+BLVADZiXP6uzUc+qA/7JWeCnQZYRdDJgcOXcEF2tMbitXy22ha7K/QvOJSiswt3sgqXBxy7kt3DMZRRL1ShZh/Ak+gfdaqgR0oNPRGN6Lf7nj7M2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltZ5srBAqKo4wC7oJ61QVz6Qw17hi5kiH6r0lJyFlgY=;
 b=TygXCtgLxLucf2X3oXLUzI2IS1Gicf5fHaoZM96wG7pwn6lWmZca8pVeUAblraFa5EytFt9fz/+66MuY8CofZY7BeueVESEugfJNkUKJ6zVpRzLZhvhpwcyL10Qdp8TQbwhCorXsjNyQe9AqDuWvcUyXvw8X11u6W8w9J3iuj1s=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:00:40 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:00:40 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Topic: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Index: AQHbg3HLW4TblSi4m0qXXIXkBp2ZZ7NP41OAgAABPQA=
Date: Thu, 20 Feb 2025 09:00:40 +0000
Message-ID: <DM4PR12MB5152DB06624071C6163F25DDE3C42@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250220083053.3834177-1-jesse.zhang@amd.com>
 <20250220083053.3834177-2-jesse.zhang@amd.com>
 <CH3PR12MB807403AB9842D5F5297C14F4F6C42@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB807403AB9842D5F5297C14F4F6C42@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=af18c5b4-b05b-4fdb-b1b4-24c8617cb755;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T08:52:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB5903:EE_
x-ms-office365-filtering-correlation-id: 4098af67-66f0-4678-cb78-08dd518d0cda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IRpuYf4K8Z++GMPYguj/JmKg0snmu7uPYxgEZni1OUDQtz+XOyL2uU+ifpoX?=
 =?us-ascii?Q?RkDC8JbEowkA5rWnuZf392sX2O11zpS5vld0pdi2IVjEwLS+X70Cxa/AKqSb?=
 =?us-ascii?Q?VyEFLUJzTZH9BwLQMJAkXZPqlBJK2EX5BqHCREoUGHMpgdXqRp+j55Svy0OK?=
 =?us-ascii?Q?8THFiPzcapi4dNIx9iADAn4KuoqRmSEpe4W4GOcFkD0ufbyKRyAYuppn8C5M?=
 =?us-ascii?Q?UGmBuK6i2KJ2uA37JpJjDh6YLDEv3SgVidTiOvnjeXJ+TzyPWG3F+XTQfoLO?=
 =?us-ascii?Q?ea60cMBIAG7ZlwiIFZ6YE4pgvu9XQ1Zp4SUkbv/8QBAGTLsj/iQh+EPBV40p?=
 =?us-ascii?Q?TAY5Kfko7DHSBPV9fA7zNRaGOwSUFMPKsqUbhn58nrAJvAJm6SLYoITgyVKn?=
 =?us-ascii?Q?MhMHH0gl2xmPIc8mozWLUjQ4FOBBxuE6lVQC0r9MV26nqMGFvBBkuUpWyZNL?=
 =?us-ascii?Q?jEaro2ZHldNhCYYOmKPMd9ujFnclnJJV7PAsOx5Rx7edva/uq4d2qZBrq1Wa?=
 =?us-ascii?Q?rXY1/wWEfunzdpkWjscpKGZHeD/jNFGgi4pw1nzFLOgZ07Wyqb0AYcskS98j?=
 =?us-ascii?Q?0enSWJU5/vMD+JuW2hjIaHemZR60lcflNw3Q0/RZd3edBrLl4Hwkt7o0Wegi?=
 =?us-ascii?Q?gkVVAmIXe7tbrK6EK0lKV0J4DptZRJp9ek3PpYIhLQ9xY7Oqm1cMVK1WLURJ?=
 =?us-ascii?Q?8u6YhFspWQCTIFHL+w62uT5jcG4xCz1mXCVPcO13ZkBoM0zHfupBNffTxkBK?=
 =?us-ascii?Q?mTShP8scZt55GHyfk6NLnIymf/LLVL2uZtngWVWHCZfC9nTq9nQkAAQhhD36?=
 =?us-ascii?Q?ZXevHEBeBhEcfFtF5OYunPEzrUaD4khA2onlKDYyJRS/y9QuPJgGL6Fc8Lkm?=
 =?us-ascii?Q?qg+53NYSfOTzNjZ18lv1jXYd9bvRaVF3J+ytMkVxMM25yLiHklyzlm7HiMvo?=
 =?us-ascii?Q?Ex0dXKndNXB/M9JjiEwTidL69s9sHg5TEFW1CQKxLlWaTg4IiLHhaCfceLG/?=
 =?us-ascii?Q?p/Cj0bkLlvgT8K+p49FuZ2L6Njcjh/8l4CreJp1NxU3HxIq3NeIBH4GuSMWQ?=
 =?us-ascii?Q?514LG5b1e+S+BOUmDaA6NV47FoNEl2Hs2++U68vIlTPfhCDxkqr8tW1FOKGE?=
 =?us-ascii?Q?oivhgQL3Pya3AxayFkIwe66IfZ5kWFY9mQET1ev5yMfdrmELoEumX53bNqBS?=
 =?us-ascii?Q?heeYPMhQRoHZhG10IgNxerRkd9qje8Tn5t84bMFis0qADP2cJ+E8uU7HAjq2?=
 =?us-ascii?Q?tkyq2HdaDd/vLXygLS+BS0bVbuHl5Ug6ldPC1KRqAzDGKhr787tZMLWa4X3T?=
 =?us-ascii?Q?MzQ22kPMtBjXc4V8hE3+EKtP+xzRUEmcKJyzplnRap4vB2GTJz/HakSw0Q0f?=
 =?us-ascii?Q?OPAXfq8Vexvd66iHnkAUHp2la/UQHY2jNRKltL1xg14CfoP6sjxO8bzXmoXv?=
 =?us-ascii?Q?JkGqUrqF8jDHqG5I3ocESNfvg/M5dCq2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6SONJ6h3PVyQmXBVeLI7ADsMqK2hgBEFMrDae/jbaq9M62FZ1Xmd6i70obVj?=
 =?us-ascii?Q?FuaWVrR96SP6//nZtAT3m7rA88vcalEz813VY2JzBfUPYkb5YRaO4s95og1T?=
 =?us-ascii?Q?4GeAlQlVFJDY6GmYdLtTS5re1oa3uIl04nZl9Hwnd0qMF8t9j7l6lSYU1NZq?=
 =?us-ascii?Q?3US/uwiNHdGY7lstvAXAFZzvnhF0HuqFCHY3lo8xL2bTRbPQ5QTGjj5Re3P2?=
 =?us-ascii?Q?sQ2DYZOEWFZblXW137Ff9ZTZMF6fbYoLxHU2yzwXMpdyldgm5HuPTmA+WJtt?=
 =?us-ascii?Q?NuHWZDeevLDNudpp6w/OkxjZ2wew4Yloa/s+IOFV0YtMpCxQR1Qj9Fn4gsuo?=
 =?us-ascii?Q?DRMnhxLt2JIkGPmUj1cc+Q7dytFGCol/k516nUMVCaHm9WqIcCYvZjKY+v7v?=
 =?us-ascii?Q?Cq5WTpjEIRSWFd4X3NgPWnRLoJiPmUeUvpfIdxYwdEPW7b6u9zYoyoRBRg7L?=
 =?us-ascii?Q?wR0DJhxFYwaDJSZKstF+fwcWmfcECFA3NoXf9wAl4MRyyq1fFBRWdxi8b1PH?=
 =?us-ascii?Q?DZpnLp0+bCk2Br8NJ8XMpq8Pt182Gk0deLTizPjodleEMMErB5VfA9njl2yc?=
 =?us-ascii?Q?XsE0ukAcRLSzv3ISbtzCGE7uf0IvPxkSKNCkAgvW8Iw0IydSdUYZst71VCNA?=
 =?us-ascii?Q?+LiVffKC3JBt+Kfb63hHUo9Dcx0hxYMATs22zvTvJxf/nTMHsddxrS+XXUYX?=
 =?us-ascii?Q?8vARz8KYyidEOVXL6UeIHnBuW0pMjxGV8eudKo6mweAAMRG1ml6l75qdPlJw?=
 =?us-ascii?Q?PXFZeO72XxGeKJzrQm9RYe1dSChIHPNYjITe3E/TU1n/2KpXhAWYJT84Zmuj?=
 =?us-ascii?Q?d5xUHPXlxyv25My25vHw6b3HNg+k76ilFqZTiUZHa2VPR2J89lPm2Rb51SFo?=
 =?us-ascii?Q?sOlcVP/C1AREzJXNIfsQoFXNtyqDjoNK4d+npegkPZlt98nLkjoavKOuQJN0?=
 =?us-ascii?Q?wwndN8+lFAYSNIt2sW6JtuJYfnHC5Y3WoLf0JA2EBLqcyfLqA1vAxM0mSAdI?=
 =?us-ascii?Q?UzNnoJDkkx3JL5meeUvVNtq0PGJFgvgH1sVUqzKsbJVsND+VNeS5MIiwSauG?=
 =?us-ascii?Q?v/SjbbPHqi5HipLcIkQSRyQLBAwqxVPHqI3UIBpYows9TCTwhQk5InLEVWRn?=
 =?us-ascii?Q?hIfejZkFX3gUwDRji7QR+cgI+ABFxTyWQwBMgaUTrQPMutUSE3/3TQkAhhsu?=
 =?us-ascii?Q?0VOORTMrGXQ3bA+QapHghNq8cndIYi8lv2UEz4U5hYlT7ljlZzGVqP5665hj?=
 =?us-ascii?Q?CKSscqSSLjmDscuJhYkrJZGmNaav733J/bYTpU0Qa3JHLTbSuheVJvbz3/ia?=
 =?us-ascii?Q?XUuqktJcD4zGZX5LDFrbM9GCmDWkh36ko97Tpw7hSOYQ75e+KNGvhsy1mu9N?=
 =?us-ascii?Q?zTLmwn84YeReOl/6MPboY255zz49PzenvItTbRWHcTlc5SdR8HBTxbhImenc?=
 =?us-ascii?Q?IhD1LL3AUEFN2IfMr/I5CC8ralIyNK6uPC5xzeN8LGLcuLeg9IqeonILSMfW?=
 =?us-ascii?Q?l9VVSr/ut/eX8UDebtPSRgYrcUQMzxBnx02Mb3O8EcGyUDmKMMZFaPBIUNPx?=
 =?us-ascii?Q?xlLp0i94iCJXKnzg2UU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098af67-66f0-4678-cb78-08dd518d0cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 09:00:40.3763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Jlq+ZrB2NIvpf4uBlqrvahCeNq6UrwqRwbmAajQoQRsp3Fodk/bX8R6dHQ2EhCRpqRX9x783y7b2tdB7bLvAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Thursday, February 20, 2025 4:55 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Jiadong <Jiadong.Z=
hu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Kim, Jonathan <Jonath=
an.Kim@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Zhang, Jesse(Jie=
) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Thursday, February 20, 2025 4:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Jiadong
> <Jiadong.Zhu@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> - Modify the `sdma_v4_4_2_sw_init` function to conditionally enable
> per-queue reset support.
> - For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC
> firmware version is at least 0xb0 and PMFW supports queue reset.
> - Add a TODO comment for future support of per-queue reset for IP
> version 9.4.5.
>
> This change ensures that per-queue reset is only enabled when the MEC
> and PMFW support it.
>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9925b183c07f..0e004b156e95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1458,9 +1458,23 @@ static int sdma_v4_4_2_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> -     /* TODO: Add queue reset mask when FW fully supports it */
>       adev->sdma.supported_reset =3D
>
> amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> +     /*
> +      * the user queue relies on MEC fw and pmfw when the sdma queue
> + do
> reset.
> +      * it needs to check both of them at here to skip old mec and pmfw.
> +      */
> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +     case IP_VERSION(9, 4, 3):
> +     case IP_VERSION(9, 4, 4):
> +             if ((adev->gfx.mec_fw_version >=3D 0xb0) &&
> amdgpu_dpm_reset_sdma_is_supported(adev))
> +                     adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;

Do you want to check the adev->gfx.compute_supported_reset here or a typo?
Thanks Tim, will fix the type. It should be adev->sdma.compute_supported_re=
set

Tim

> +             break;
> +     case IP_VERSION(9, 4, 5):
> +             /*TODO: enable the queue reset flag until fw supported */
> +     default:
> +             break;
> +     }
>
>       if (amdgpu_sdma_ras_sw_init(adev)) {
>               dev_err(adev->dev, "fail to initialize sdma ras
> block\n");
> --
> 2.25.1


