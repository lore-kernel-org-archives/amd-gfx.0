Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4FEC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 21:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A241137DA;
	Wed, 17 Apr 2024 21:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ioKReECK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3338B1137DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 21:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps//lNuZC/p5BTK0u0fN1LND3GqwdUXsWEwUGCm3nn/oVpim4CwsfCrNlrNr0qMr3Yf9EiSUy9tJUrlB9hSTkOSZNW+DOcuAyWGYOCgQjw06eI9LN7UtLuNDW6oulz5eNJjIZXa0nr6TGrat6tnFwIB/69FYtBBgs3SANz11naeZ+gEoun0DjoBAMoV+Xf0hNSuJsn2MvXBiIjkoTNfaYdehPvEKbx8RP6TjQMuTVVACEh1eBq/l8SD7hygJ0qrx2EEg9efcSZjz3OnhK/Sn0K4K4Dorzi4dfI6pGS0g77cYlN5nXiS5Q8ZVpuPsvBDu6lY1mNQTBjoTMNHW5z12zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tasBpq9tSYHyGc+net0z35NQzDgc3wWLzWzPjxD8RI0=;
 b=jVul3OznSb4up86JdglpLswED6w1Mvge1GmNH9K9mluFND91eM7IWMpXqjX9g/WQW97KZLJfcQONroe2KHVDtFvzSTcTup4HmWFagiPRmF2Q+Lb/6vitKzwNZ24BjXFOeIXvPZvMkXZmKS+FGXJt+o/5PfOvVZa2XXtUTh8loFjPJ5GOTfOoR+FQm6zqe5iGXzHW8/MNytURORDe10lcwvKhgmH+8bq4GZlUFAtgBHe1+pGfeklToT/nHG0KyDvOQqzeisisrBoudBe5bhwZ9LKG8+5xeJCGSCXm1lz4l0J9G8fFkveKKYMO6Y3edak6fg6IgG/+i9dDbm596Bffmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tasBpq9tSYHyGc+net0z35NQzDgc3wWLzWzPjxD8RI0=;
 b=ioKReECKEULH5tOP5em5aD0FACcOjzgnegFazxuITSLHdK4nkGzhWxDKzuxOs1+T/fIY1URJ7XkVzpGaRvSRdv/cJcw2W5CVQLWtJeev58vJ2lzvtcYPAw73rDzBlJsTH1D9vRQD4NvUvf7v63JHAz/HX9b92t92ZXVecGO6fHY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 21:14:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 21:14:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Saye, Sashank" <Sashank.Saye@amd.com>, "Chan, Hing Pong"
 <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove virt_init_data_exchange from poison
 consumption handler
Thread-Topic: [PATCH] drm/amdgpu: remove virt_init_data_exchange from poison
 consumption handler
Thread-Index: AQHakQESZ8lz0jFAD0STKQ0SlfrjZbFs9hng
Date: Wed, 17 Apr 2024 21:14:21 +0000
Message-ID: <BN9PR12MB5257958F1B4BBE692F776DA6FC0F2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240417195416.10997-1-Zhigang.Luo@amd.com>
In-Reply-To: <20240417195416.10997-1-Zhigang.Luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f3a5e256-a625-424f-a0a2-179d852cd17e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-17T21:13:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB8150:EE_
x-ms-office365-filtering-correlation-id: d7539052-4102-4168-797a-08dc5f235a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CRpOqOUCK+X507Wxn51gme8JQtc2WDyu1xikmk/+v+cIppDgMnuH+0m48DIQXLHTg0lPqsNuTsqfWLGIqmRht1VSoWCyvGyE4vHIuIZ0Jvy4f2cH41OaF/W+NWBox8f1ZGWV+aZQeIyEL+LIrMk45ItOM4BLpjWW+hHwdmOsRo7SWM6eqtgLSmD7Dt4TA/TMlGXMjPutBfHg5eC2KMiHzQDv+0Qks09HQTWEQCRYcfSF4v+2w5RFOUt3dS4wkvRZYQIqXF27Hv9/h8Jj3Y6J+TWthjO2VTbMNU+8+k4FvMalnAHsVRqgW3eXdAxN+3K1xb/K6W1CcyWoTAXOsQGHY4tU9QTFE3yhrC/eTlVJHUqPnJtpXWOapjwU9JvP+VOEv4oR5S176rsGyKHJyjxFTxnZ6VuPH1T8Ejz0xbS7o7pSELbvJXDHcvkLAG0ZRsFo99vu2lBA6Lp1yYhm+bRb3zitc+uo4EaCNT1oIwunMF5drgnZhFLGRMncSyGF9Es3A2elbPdnFcHNqyVWIrbkpXBJdnHbfMv+7Reqqtc2E2MLavW/NLowxWJFlEKa9tu/xVVrIzwTSJao5miYEnIgkHIeDfeqS8lrkWTXEVBHmpOvYeT5tX5tBdRK33RttI2DXwOeQFGJzPQAlaivvMOytBGYstvhxI5VnuLT2B9DioJGxAVsVTVG8/tZnNhAo5A/1NyGDTcXSHOtgh0EV+aEVUqilUbA+6HSydtJ0doIrVo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ukhkb17MWDsIRFANK8VREsVy14LPH7I05+72WWMHNd3KkAlEQpJtK0ijPPFo?=
 =?us-ascii?Q?TyXLeiqq1XBa+KAj/qmjAkC+tIs6+d4spVm/BrRJsMDnZZen18tGKueRJ/wW?=
 =?us-ascii?Q?YJOk2Dd3+kmvsK0bqn+UvtwrFPq2XPPsEAnIf12+8edX4VChbIogatXIfb1t?=
 =?us-ascii?Q?c371Iy6SkAqkT/oJzJP0UouJ7TBIQDcsF6IwWstWQl5CsILQ1Po35wz7wf0r?=
 =?us-ascii?Q?Dox/95FLNwzau4moQ+CcWJmFR6N9mbk+cKqTFh37I0nW0J6JBnavHUyu5qkW?=
 =?us-ascii?Q?j8m7WvoAMACoRzjlsD6vGX7bFhhubgM/4LyR1RW+DcDHY7v6iFSHa2noxlnE?=
 =?us-ascii?Q?Qt6WYAi6P0RXM8InvAZzna5u9ZlpzThdHHh14re9rhGMDLYRPLsKcae0KWWo?=
 =?us-ascii?Q?akj/IJQXLTDcQuO4apfkmllNKegRzqmhPJkiYDyZdgMFjJ8L4GC1Aud05mOJ?=
 =?us-ascii?Q?x9abclhbC2CVuwb9PGTu5Jw188HKi75WcK2aMTvQB8mmVe6YFmuF2TqbDl/L?=
 =?us-ascii?Q?YIRMHkh1a1sHIkn8joDOmIsaotxTam+So9VyPTLC6Vr3cC4eol6Jq8ySRdld?=
 =?us-ascii?Q?qlzs5Z2iKQm5JtpBbXBnNY93wessylBzmeGmE9SgGNjLCLf/sfbJFh46ilIC?=
 =?us-ascii?Q?NYBkoX/cla8dhZvoJ81N9v4zeC2rA+yB3G+658S8i7f/dVtdSpC78+0Irq00?=
 =?us-ascii?Q?YSA5bUmPjrOmCtG8cuLJYvPl7BpqkXCtGBcSvLJvlqyTyR8iriYG6OMwDM7g?=
 =?us-ascii?Q?lu9SrGC0+s6gr1X3TJ4WSMAbT2ksfGszv32KSLaMVs+nXoH8ACrVNvcBF4kP?=
 =?us-ascii?Q?X4kRtojhdXCsomDh3x83Qt9qt6O0hH+dyP4q6SV3mgv4VDBzsW3T2UPPoMUm?=
 =?us-ascii?Q?SnHw4hbTubDRlIaWl3Oxh9DSvR7dCRNegQ32qodD2VbOgKVMI5s0C1/eyrmY?=
 =?us-ascii?Q?EzC90C0vutjLh60scp4tPqGFkq07Pdt10lXYiy05bsH/sDpvfKVwXjAwLHKz?=
 =?us-ascii?Q?rlv3ny99hMFp9HJFv77UDrjk44JMwoPNcXTHr312SP4LYxS4pRZcsQDGbGuO?=
 =?us-ascii?Q?cvsJ032X3t99kfEUyVuI9wZtsGODSDESx4QboQ94Eg9zF2oVXPPPay83yVfa?=
 =?us-ascii?Q?DESZ9U2BXlJ8RoQ0/tMCgsIEKFLGbOSSTu6lXyboOkgiUXziFtzO9gidQS35?=
 =?us-ascii?Q?5VhVhDQlF/Vz6AeW+k9qwomE9bbD761HdLBUBRkjP6Gmpw1ULxiG3FijS786?=
 =?us-ascii?Q?CsgsC8fPNBXoYroCH+9i7ifs1v+i6I+2z02h3kH9+QXmvRuRYziW4ydgJWQt?=
 =?us-ascii?Q?6egYwSzV/5gBELlR9yPkdFFUbApJCOV/l8SWiBwg//L+9E2SFxVKNV8eHV3N?=
 =?us-ascii?Q?9Kj7+l/6+Byey7xzinEkJWBcECuxMMx2L+DV4UwqdnZAgKZEYrcS7J4gCSM+?=
 =?us-ascii?Q?UhobdP7K242/U3+V1KH8C4cbvG7z9Gjo+vlEoBsd3x9U/lycmsYiomADHFsn?=
 =?us-ascii?Q?3Wtb0mZw1UTGGkPJvJ93rEC/oYH5P41hEvwPKA8rPMVEpWEvqTizMKPpg27r?=
 =?us-ascii?Q?G+duBDYqxL9fEUiDdAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7539052-4102-4168-797a-08dc5f235a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 21:14:21.8182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF8aWoeoS+WfmY8BO3ywnqb9FCAUEoIQNNsvSbikuNaIFIlH1XroOJCfqGtBjQXs9MXkWwIVZJf/Ib5LMZmRqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Luo, Zhigang <Zhigang.Luo@amd.com>
Sent: Wednesday, April 17, 2024 15:54
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Saye, Sashank <Sashank.Saye@amd=
.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@am=
d.com>
Subject: [PATCH] drm/amdgpu: remove virt_init_data_exchange from poison con=
sumption handler

Host will initiate an FLR for all poison consumption.
Guest should wait for FLR message to re-init data exchange.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 89992c1c9a62..aba00d961627 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -446,8 +446,6 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_de=
vice *adev,
                amdgpu_virt_fini_data_exchange(adev);
                xgpu_nv_send_access_requests_with_param(adev,
                                        IDH_RAS_POISON, block, 0, 0);
-               if (block !=3D AMDGPU_RAS_BLOCK__SDMA)
-                       amdgpu_virt_init_data_exchange(adev);
        }
 }

--
2.25.1

