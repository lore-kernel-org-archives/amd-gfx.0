Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B18EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 20:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D8110E22B;
	Mon, 10 Jul 2023 20:19:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B70A310E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 20:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsRRCA1PXFzmc6xBIhAUG4rrcoAwfY0yh28fkYETFfcua+aR1DtIIiaToYei7gfwAvyHssGWzXHUS+jGCBpLyKGWPIkNLeRN+wPbGhrtADRwc0vMeYmAklCieUZELPKnfBRSDAeNdTgOasYoBwexBNV/NmVVDTZPrgwbbOmYUh4FZV6aKAlianLbvTyucdkj4Kv65re0XWzkIkGPbWLzxvUtQp9BiZw3SXO/70ZEQQlezJZdVZM+kyX2Cd9Yh81GJuP64m2beB1Yn3Dp7ZyOmkkGj9NucMu6eoii/k0Koo4ePuDoE1NxlZJFh9dYnZHVocozE+X1LvQUy6A97MH5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z526+vgPz2bYWCvuvAkcipiHsz22/LUi3I3ncj55GNk=;
 b=LcLy1U4FZk1HTTyxaC8jk5u6QOUoc7FN/5rhvKBvH2fSwPkB+7EAKyS4uTRNw31e7ipqlIxeDQkpTP3D1GVtdaP9pz5QN7RQSYfMuCrBFYuzLKncaHzLgZ5wabexgyCIhAfQOMVD1LWCiEePC7lKXQlryfDcvzFk3EybzuJZ+YWzPB2AYf7F0a00rgoWE45lCgHZZkK1oMa9m9zgFmzhNsWyWhqXW1JAGNhliK69bUZdsr5D2Y5btau9q4KC2oPMAOA5OibuIqe7mxMNjGIvyMGEcvu4GBrX3TICPCvPp0mvarpZ+61qZGYSzn+T6ybbqRJvqyiSfMS78m4Je3j/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z526+vgPz2bYWCvuvAkcipiHsz22/LUi3I3ncj55GNk=;
 b=3WyJQnGhm8Mef/xONhzt8dKN53c4TW0GcPZD9DMd1KlEDaE70WXa5qiSiBliPzpQVuU7wdMmEr6014deJCUI4V+RMm27NNS6u4KoRBYwJtHMMZRgy8bSnf0xIbUky9sxF1oa6k42g+1xoMhqssCgt7kQYV8BNg1NuXuPtR0d0vo=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 20:19:19 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 20:19:19 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gopalakrishnan, Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, 
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: update kernel vcn ring test
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: update kernel vcn ring test
Thread-Index: AQHZs08/5cpv8QaXLEqGCSnNGwimM6+zcJ0w
Date: Mon, 10 Jul 2023 20:19:19 +0000
Message-ID: <DM8PR12MB53998C8B2790D5B1F80BD9E5E530A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20230710165425.257696-1-saleemkhan.jamadar@amd.com>
In-Reply-To: <20230710165425.257696-1-saleemkhan.jamadar@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d1184877-3f18-4f30-8fcf-5ecae47b0bb6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-10T20:17:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|PH7PR12MB5805:EE_
x-ms-office365-filtering-correlation-id: 2ee71841-a832-4d0b-ace3-08db8182f126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SkT3lq9M3yO8zWwzMn36eEhzGzhxWxTLe2EEYTXly3y9uHaVCk6CSb+lCco/VLBZv4lm+d/+SjvZnFuTqahu+XuJ5UVHPKvj6Kg/+P1sAhWZIDrTwjj08U79wXSHnRVSeClea0ftWwWje8a7AzHOBz11pN/1FlTFc7TJz0i3UsoHtY6gRhD5YfCs4ZKDrCRJszG9j/RjiCnJyj4MJsv40n+xDlhifNXQWcWHiQ+s5c9OjdHfrk0FnORqMhjP0gyZADQbC5RNwTbDHaE1BRNIZNy540zroiLII5h56TeRewYtqMG71fUGdBF/jxIV6M8smcPKHuDuMItNG57+ihoLLeDmeaSKejbwOCQxvge49dgXbMSoxTRqyo+0lDdRX6fvRkdRERvVD9S1xWFZcPJzAGb/mo0pvHwLomk493IS9sjTTj5jwHvCfs7fMwEo/GRxhwUJRFl3apmX3Tu0FBYmlvY2AohnDkNRKjGSf+y4P4/w48zFtgkFjPdZtQ5B0/rzBHwRCTJ7umabagGPOkDJf0+k4Rx6RHn2P0iqd0NwoogAoVhWHKy44vIeaIozyUWKr0pGlghzjj14wJL9sp51PGPDc7GuCbNxq7kjjKqwlQ6HB7gvnlE2yLKNOgyfO8Nh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(86362001)(38100700002)(38070700005)(33656002)(55016003)(76116006)(7696005)(110136005)(54906003)(71200400001)(122000001)(26005)(9686003)(6506007)(186003)(53546011)(5660300002)(316002)(66556008)(15650500001)(478600001)(66946007)(8936002)(8676002)(52536014)(2906002)(66476007)(83380400001)(4326008)(6636002)(64756008)(66446008)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XR8mMJTLGUPVotn8FFYJlc+JyBEbQ39pzApZcwNyTkJo+s62b1BiGYTJtOMl?=
 =?us-ascii?Q?mvsePsePf7WR80rAhKxat7jqhnIN61VI8lbSc1ruqVDCV5hGijIfTQB5fNet?=
 =?us-ascii?Q?FpxpEQ5tFjOQQu6MLlKJeMlgXPxVYS3HmROSvDtI+3Wa8asAu3EOjuT0gNgf?=
 =?us-ascii?Q?4lNI1AMlPgAuVPchAcKerGKWaYXnoLeJ6vuvXgDrOX1y7XOdawDRbpVMM4BA?=
 =?us-ascii?Q?73x8dhkp7lWe+saKFeh7CV6TpYZSiE4s2u+0y8c7Xn6IFdNTTQfJ6H3A3SF7?=
 =?us-ascii?Q?x2mJXoNv5kSX9tEqfTEga4AesO3sGrhJJSshBOj39T4PvcCYuD9kr3ZF7wvC?=
 =?us-ascii?Q?pSxpuzRLDmXmqAYOYeK+QrZxRa+LJsalFQdRhRbFiyClqFBVCPxDOd/02JOp?=
 =?us-ascii?Q?3u9wEu98ITI0CBmKQU2ZAJe18710/pGWvYgNhFLZHCSkk98z+nqWvjNcGFo2?=
 =?us-ascii?Q?iQBFqVXPjwEzhD8H5qhbZPJH4jpjODi6cZkVCBDZN+q5X8G2xjQUuUuGe617?=
 =?us-ascii?Q?P8NBxjzQ4GMRmiL+/y7o8FlkBaFXhEScEW8liEDRr6O0Ie+DsUIUwUZA9DKk?=
 =?us-ascii?Q?GPLpmGnBwwvM9RmIHYJbA+Toosu+KuD6ZajmSmQb9RBbSAyhD5nTk/HifX9T?=
 =?us-ascii?Q?lz/4alX9dY93rFVx28RkkGngUAY+gMMlnWngo44G7Ch0AMoIJNCYMTlQ6/Fd?=
 =?us-ascii?Q?VZGXP6Y3rFpaJd8zWwIZrUNaqaET1gmgYb/BG8ghtGAD6XhGsvC1f1IThN2B?=
 =?us-ascii?Q?seCwPdqxqutuR0T0r7pvx1PlrQ9HStbnI22P+m3vev3JuFgOCv8XYBr3Wttk?=
 =?us-ascii?Q?4Ij63OU7FKlQEc14z/rAhj483wVsM8CAFGTzCVyiNpocevSHDfE24FSQwYBy?=
 =?us-ascii?Q?uVAtLEs+DAAa8WenrpjeWb41ADZ6SI1HWtBMilaoPrTTCSz6bT4GevCeFt9I?=
 =?us-ascii?Q?gf9B8BOggU7w91VdCI9MH4r2s/mi95MtYMREzNeplZ0VxJGJ5q5t1oixGh4G?=
 =?us-ascii?Q?ZVxM6m0fyGxDXT5WvptoVdKJ8caJ8LmZCC5R45wLx76oMXmYw7aHy6IlrKGt?=
 =?us-ascii?Q?bQvigaGbTqRVXl0pKkmQIfAEPAf693g2U6x+A4D4MpqOv7hejbfURNyYzdLS?=
 =?us-ascii?Q?aUS6a2blQE/N26uXHBJIjmjeiKvagw36uC2BaakvmjKrcpE/CDXMs7zEmiCe?=
 =?us-ascii?Q?0a4O1DayBtCjbxzn4StFi6qiJYfJkMDjMRGq/WXrs2UaEmywZVAoN7rHIIgm?=
 =?us-ascii?Q?H3YfmuxvNoYt7MBM5UpFejZmZfbcLm+t74R2oQGDSVsRe58ImDYIYtCHB5ax?=
 =?us-ascii?Q?y2zzf2DWqgUP1IOLItaP3BhhQsXgU85UMK1PfCdmluKvx/qrAMiL1iYkO63Z?=
 =?us-ascii?Q?eQzGA+X58tqWTFBNB41D5nf+t3Os7N4JgZ545VynFQRbfv58hhxiZ9vzO4hN?=
 =?us-ascii?Q?N1+nt0KRH7KqhfSyIYdtf5ANbA/kEIixPL51GJp18TycgTSWwakEu0pzTiHK?=
 =?us-ascii?Q?1zWB14wQjpnQLihIKAbw6VDYEfBzQ9sd+1mCB5JaYU1aFln2QEF8jMSC0whA?=
 =?us-ascii?Q?5qjfb/apNW5jfQvnXMI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee71841-a832-4d0b-ace3-08db8182f126
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 20:19:19.4521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDP3a/tCP4r+HiFelJdrhYDG5J1XDdev0glvHdkscPu7carImuMxW35T1FvqhHXk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Rao,
 Srinath" <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
Sent: Monday, July 10, 2023 12:54 PM
To: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>; amd-gfx@lists.freedes=
ktop.org; Liu, Leo <Leo.Liu@amd.com>; Gopalakrishnan, Veerabadhran (Veera) =
<Veerabadhran.Gopalakrishnan@amd.com>; Sundararaju, Sathishkumar <Sathishku=
mar.Sundararaju@amd.com>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Rao, Srinath <Srinath.rao=
@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: update kernel vcn ring test

add session context buffer to decoder ring test fro vcn v1 to v3.

v3 - correct the cmd for sesssion ctx buf
v2 - add the buffer into IB (Leo liu)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 76e9a2418286..4ee5f933e420 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -521,6 +521,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *=
ring,
                                   struct dma_fence **fence)
 {
        u64 addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+       uint64_t session_ctx_buf_gaddr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gp=
u_addr + 8192);
        struct amdgpu_device *adev =3D ring->adev;
        struct dma_fence *f =3D NULL;
        struct amdgpu_job *job;
@@ -546,6 +547,19 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring =
*ring,
        }
        ib->length_dw =3D 16;

This line above can be removed. With that the patch is:
Reviewed-by: Leo Liu <leo.liu@amd.com>

+       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data0, 0);
+       ib->ptr[ib->length_dw++] =3D lower_32_bits(session_ctx_buf_gaddr);
+       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.data1, 0);
+       ib->ptr[ib->length_dw++] =3D upper_32_bits(session_ctx_buf_gaddr);
+       /* session ctx buffer cmd */
+       ib->ptr[ib->length_dw++] =3D PACKET0(adev->vcn.internal.cmd, 0xa);
+       ib->ptr[ib->length_dw++] =3D 0;
+       for (i =3D ib->length_dw; i < 32; i +=3D 2) {
+               ib->ptr[i] =3D PACKET0(adev->vcn.internal.nop, 0);
+               ib->ptr[i+1] =3D 0;
+       }
+       ib->length_dw =3D 32;
+
        r =3D amdgpu_job_submit_direct(job, ring, &f);
        if (r)
                goto err_free;
--
2.25.1

