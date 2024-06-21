Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3390FC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 06:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C5D10EA2A;
	Fri, 21 Jun 2024 06:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICpDsUO4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0563410EA2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 06:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/D++7VXXu3TlFGm5zVgETeoJVqdJb8r9HNQ1FrbIhcso4b323s+jdqa45o3skD7zO7GOIDTYY0HhgCKZgC5fc7tQkOqX/V3ZjlEPC8G/DsV5GWa0XCoJ9F8qRz5IlmLUozKIICIMv/p1oBSHnYHJSEUdwVLLGgGjfh/PNuBRGpbh4Ru0Rc5rl0HFRHEXdMnFmeksBspbApaSv9bkpKEx+0gPMfuzdA6Sv/QZbqEMwxn26tS/80XHNt8T+K5nDVVTsSkQPLaLhk3Z/z5VoN99BKJ9POUBXKL+7q4sRSxBJYU57RuVkEHgbcmHZHDDvZt2E0JV9GRGxqBJKzptgaPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9zH+sWm2U8jkHx+OUHB/e3fODebgVEbxZclGY8+kg0=;
 b=fWUIIeXgnydiIRaHjOdOXleTO1riwAuuxfsAKpNWfIbX+EeLKhbBe8NJ1EABQuGOuiso8vJ0r5RZSPKWxyzoj448a5RlFXWg8xl2EvjGHO0yFavDqai34AbZ8uXRtHxDcJTP+eyBwhFfUb6fI2M1i7oCXWz6QgLplqlK2ev1dr+HfFfAnvtpidQ1M6esy/ujxjIFz3YfKsv/P8pOPZpNYiYhgLbDdOPv8sNEqql5MWNQBX2baupqmKE841RpQm5hc6MGIc0c32d7Ra4bbLR77jOCpjwdYr6xuCsLo37qq/xGBgfLVJZ72FBP5noCd3as4r1DKiiciGkOGmwW9GM8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9zH+sWm2U8jkHx+OUHB/e3fODebgVEbxZclGY8+kg0=;
 b=ICpDsUO4BwG9bh8NZC5OfuENwNgvIDYPQXOkNdUYVbf3wFKTmzj4lG+OkfL0suNR2N0aro4qdwQ/V6ur+LC4RK5dyp+/uRD5hM9vlC/dJ95QzVNaGTbqIKi9tWqwYD8Qc3e2yefQ5CabFmPs9Y8dXkk8kpBUim/OJhCUV5ha3wo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 06:43:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:43:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 3/4] drm/amdgpu: refine poison consumption interrupt
 handler
Thread-Topic: [PATCH V2 3/4] drm/amdgpu: refine poison consumption interrupt
 handler
Thread-Index: AQHawtR/+Oasdzs+DUaYqykb0KYNUbHRxsmQ
Date: Fri, 21 Jun 2024 06:43:03 +0000
Message-ID: <BN9PR12MB5257E40B8A522E537189E3E0FCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
 <20240620054020.434523-3-YiPeng.Chai@amd.com>
In-Reply-To: <20240620054020.434523-3-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5d670264-c390-499f-926e-9ec7576397a2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T06:42:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8366:EE_
x-ms-office365-filtering-correlation-id: ea158590-6e66-41dd-c6e1-08dc91bd66ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?pyiiE+JG2y25wuRv/EObOHn743DZ6Olg+rnfSil4vpuujCLxOrpQNmcDQ1Vf?=
 =?us-ascii?Q?hRZg8IFw9LTp+ajAPwh7Pj0DStv6vx+MzfdVgzAioCBJ33EcxoUiFuLfXBgO?=
 =?us-ascii?Q?kRG6s4QgfkHHnDpRIqaJHST40NdIYuSfJAM6/gsQOMCcuNB/DHlmQXlM19wR?=
 =?us-ascii?Q?8MefmZb79nDaFZbpHoS2E1qNS0lrNSvS0QNG9HJ5kP10kYGNI9zviNW2oIdS?=
 =?us-ascii?Q?w0zpEmngH+ngcWZi9FSNI5CCrHPNDJp6bHeHIdfTB3fytu3QTdi5HQhcDIxI?=
 =?us-ascii?Q?ORIX7drqWVZDt85WUMJsBgopZDh2d0jAzRNeRnBqr1MaKdpTv3b4jNQKvNWD?=
 =?us-ascii?Q?wZO8cu+8mkxTkb+YrIgoiQIZe8dRRkxMMUr9LpndLmEEuKFzbvN3j9bZvseI?=
 =?us-ascii?Q?YxAhDYQlrKBrLuaFSweXjQZk2JK/IXDQnJtVKZuT/m1Afy4+jB2d8LCmWSKS?=
 =?us-ascii?Q?fKm+e01JBz0Hw0VVmnzeyze23h+5uSyKewFvOROpQlTtthtpOqIZ05UpuG6y?=
 =?us-ascii?Q?x8mCT96bauKOoK5zxVYhUDFR5FW0MO/whj3DEziKgTGtlEnIVZp0XmubV4Y+?=
 =?us-ascii?Q?Lr618RajM3zNmjFgnokCnmmZC2E2MTridRaCBOOZZQMO9x5IyEu3RsgOP9vl?=
 =?us-ascii?Q?OKmlyAKSyXu/jQXZ7WlrVIOQEqCjCmIxqCStjxqeeUmHNPjBe4VZRMI2Vm/6?=
 =?us-ascii?Q?YVQcWKfAeqpv1Cfp9CYieSzqma/IdSB2jFQ8UYRQlG+LL1aCQddMQLgzmOKb?=
 =?us-ascii?Q?jovQhsjKTWX1oHX14X+/47kcfp6f8fs3i1qAkCyKiVaLQQugwLVvvC1IUzDf?=
 =?us-ascii?Q?j4m2QG0Do0t1YiK33IQDDAo0ICMIv/39HvbAkdvvJHpPm9M9ScP1mDPHShJ6?=
 =?us-ascii?Q?MJnjC3W067MKL0BWilUjnO7A5hTByV+2DfijVJfO9iarkUFLGj7cnbippbom?=
 =?us-ascii?Q?Vg5n87waMIXvRIumZBosmKVXN1aMbCpjhR943gUOe55JUuDf2Dv0VL5l6g8F?=
 =?us-ascii?Q?DdcV/Md6bgFEwIsnCVLgbJtGv3Y80n0wtcnYbBHVyvX8jozSXkvTmJtaLj/I?=
 =?us-ascii?Q?LyweoSEcNG3Pae1979RwSnyMnQCBCXizD+Dt4YN467kFHRPihmRjGmTzFDNI?=
 =?us-ascii?Q?3jd/cTDx+5X+U3hC6uj6gIldRLFfM7PXlAfR80hGq23Rjvn9dYBXPV5vKtlK?=
 =?us-ascii?Q?MhlgO3VkgiKvx3nWkwxa0HzIlEiNKdUgs1AsbhlKClXBgN+QrbDhalcwTT3/?=
 =?us-ascii?Q?XGQakuFfQx1/yzEXvRnO6ACQqHiZyYoQadiKFRPF37o31RS3I8+6m5wZ82e/?=
 =?us-ascii?Q?VJe6CKbMXX8YJaA9p3jcYyNeZRtf3MidIr2bRPTlOQ+tqCSXsAuSKVTJvKhz?=
 =?us-ascii?Q?HtRvAGw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OepaX04/NoU+Is/QAsYZ7/kuaH6c+5h2yHfMnuhjt72F9cZzUG2NGCQ3+B1V?=
 =?us-ascii?Q?9ihPCrSQPcidSlxfsYJxUSxKYS8nuWS1r+a3AKW51WxLla/NDNVaZUX5F51+?=
 =?us-ascii?Q?v1IajnwTFRSwLatHnxXuvZ8ucf5JFrrmNS0ZbEmrR8TnbaNNSONxLS5eDde7?=
 =?us-ascii?Q?hYjjcJBSd+VV3fGgIDE2aSXgVRxXZ5NSixhGDSSVLCgur6iB9mJqng+q1+FI?=
 =?us-ascii?Q?qsUWTtowOGsxAry6boE9REQnweUQvUJD/aTsrv0zkw+rTDuTtZi6/KHXkuM6?=
 =?us-ascii?Q?SH+1FjD0mLFxjq/EpXZbTzja6DRcObjmIbRWvJNuNTROA+DQE/YbGNd45Akk?=
 =?us-ascii?Q?4h9Q2KiXUlY7p/fCYyX2Pcd6BZpWNTJthtVlRwhhh8kBeYt3VFrOP4HlZYMl?=
 =?us-ascii?Q?BOTwSoPG+Hv8cfMgJcr8FpqETYRwzla8x7dc71se36SlBDlfOSONZVEwUp2j?=
 =?us-ascii?Q?kwCsANwBDIERjAzHdBbK6a3ius4XsyZ5aAIRe8CNbw0sKcz9ndW7z+3pSmbf?=
 =?us-ascii?Q?3stWBGlFZgZ4w33D6ClPWpaABWouoiRpU8h6+v8W0Jn11P8bn+PVf/pMbTGs?=
 =?us-ascii?Q?Jhdcep+9jUGNGPkVT0Mk9SunGUoNe0TzL9u86H5G+zQmlvbG62EQSq9NJdmH?=
 =?us-ascii?Q?BUmtwICvViyJSefyTI3hbiKizDaAVy0PrZsM48pHcFmUl4Tsny9cfvGgx+9y?=
 =?us-ascii?Q?nnsih1TKu5NrbzZM5tyO+3KmCD/IYQ+YIDFAaiKySWH51j8nozgxLB90IHOM?=
 =?us-ascii?Q?2m2NYpxy2tiZ3eebLSVB3dIwW0cfTnDZIw+Td8PwV/mSgaVixkrUh0MX/HSR?=
 =?us-ascii?Q?n7zwoTFILVg3mSLHmFuY/KMFMXoXGuu76s12CtIHMWoe2HRzilTH6bksP8sV?=
 =?us-ascii?Q?ttIiaySttgGJsiGQLKjrlcApupBJfUduAXvEDsSW6FR3M/JF14xSYKE1NQ0h?=
 =?us-ascii?Q?OJGL/P8Sx605xxn9+si8nRFWBLTwaBBpxC7XcIZBdbFCC81EFYcgk//RcbDt?=
 =?us-ascii?Q?U1Vvn0VBoKT/pbJst+qAhgoXiP7GENxkJN2SzUNS8AchUPZfJUVpCo9fLTdz?=
 =?us-ascii?Q?agiELAg3XOB18PrxeCVhrh64qnrz3zUK8n5Xsax5BazcWaGe/nOwnCWU3Ov5?=
 =?us-ascii?Q?suJnr+4aM27HnSZ+/xM+QS6gXFgCGZofY2c5L19Ao1UW/LsR8c3spwbrDJcL?=
 =?us-ascii?Q?dEBtHdg7eqvyKKakhuQVzhAxgoTJPwNtKh3jlzK/lsGdvMVXrAICgDj28/Ao?=
 =?us-ascii?Q?7d3WKfbslT27MdmTzulw7z6m83KMcQYqhQRPk+dzQvCNq0URs5oGHhtduV1X?=
 =?us-ascii?Q?pixjmt+4mYiVAYSjI+WG14HPjQOCKMRzvXVLZTUB0rWJZ/MsFk8lTUlT76XK?=
 =?us-ascii?Q?tL53lFR0V4Cre39a0sndpCLrffLKY070fWstRhKWwsmWPXZRNr0I8psP27Pb?=
 =?us-ascii?Q?XETM5+gyTLZ/bTtTUUoPUdqlcL2g+nrMw+81aNOcFFYKvOXfEZ51gjf/PAjz?=
 =?us-ascii?Q?TZwYStS+rk6pQwNOmMaf4XqwLyytd/9ZpXXWT8iARX3bC5nRC6JxSU3kF612?=
 =?us-ascii?Q?ja2OFJqcOKLkpIRvyjcxU+IqD/IoGpk9AUqv0jOf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea158590-6e66-41dd-c6e1-08dc91bd66ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 06:43:03.9179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWILam2fU316CUsar9h+IcjSlp6YTuX1YyBf3fzHoQ/75E3OlLb6OsFmSxv5gaj1zitnSgEXXDQGIEDBRPNQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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
Sent: Thursday, June 20, 2024 13:40
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH V2 3/4] drm/amdgpu: refine poison consumption interrupt han=
dler

1. The poison fifo is only used for poison consumption
   requests.
2. Merge reset requests when poison fifo caches multiple
   poison consumption messages

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 56 ++++++++++++++++---------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 +++---
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 308348b4644f..a4030dc12a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2917,23 +2917,41 @@ static int amdgpu_ras_poison_creation_handler(struc=
t amdgpu_device *adev,  }

 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *ade=
v,
-                       struct ras_poison_msg *poison_msg)
+                       uint32_t msg_count, uint32_t *gpu_reset)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       uint32_t reset =3D poison_msg->reset;
-       uint16_t pasid =3D poison_msg->pasid;
+       uint32_t reset_flags =3D 0, reset =3D 0;
+       struct ras_poison_msg msg;
+       int ret, i;

        kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);

-       if (poison_msg->pasid_fn)
-               poison_msg->pasid_fn(adev, pasid, poison_msg->data);
+       for (i =3D 0; i < msg_count; i++) {
+               ret =3D amdgpu_ras_get_poison_req(adev, &msg);
+               if (!ret)
+                       continue;
+
+               if (msg.pasid_fn)
+                       msg.pasid_fn(adev, msg.pasid, msg.data);
+
+               reset_flags |=3D msg.reset;
+       }

        /* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu res=
et */
-       if (reset && !con->is_rma) {
+       if (reset_flags && !con->is_rma) {
+               if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+               else if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               else
+                       reset =3D reset_flags;
+
                flush_delayed_work(&con->page_retirement_dwork);

                con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
+
+               *gpu_reset =3D reset;
        }

        return 0;
@@ -2943,11 +2961,9 @@ static int amdgpu_ras_page_retirement_thread(void *p=
aram)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)param;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       uint32_t poison_creation_count;
+       uint32_t poison_creation_count, msg_count;
+       uint32_t gpu_reset;
        int ret;
-       struct ras_poison_msg poison_msg;
-       enum amdgpu_ras_block ras_block;
-       bool poison_creation_is_handled =3D false;

        while (!kthread_should_stop()) {

@@ -2958,6 +2974,7 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)
                if (kthread_should_stop())
                        break;

+               gpu_reset =3D 0;

                do {
                        poison_creation_count =3D atomic_read(&con->poison_=
creation_count);
@@ -2972,16 +2989,17 @@ static int amdgpu_ras_page_retirement_thread(void *=
param)
                } while (atomic_read(&con->poison_creation_count));

 #ifdef HAVE_KFIFO_PUT_NON_POINTER
-               if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
-                       continue;
-
-               ras_block =3D poison_msg.block;
-
-               dev_dbg(adev->dev, "Start processing ras block %s(%d)\n",
-                               ras_block_str(ras_block), ras_block);
-
+               if (ret !=3D -EIO) {
+                       msg_count =3D kfifo_len(&con->poison_fifo);
+                       if (msg_count) {
+                               ret =3D amdgpu_ras_poison_consumption_handl=
er(adev,
+                                               msg_count, &gpu_reset);
+                               if ((ret !=3D -EIO) &&
+                                   (gpu_reset !=3D AMDGPU_RAS_GPU_RESET_MO=
DE1_RESET))
+                                       atomic_sub(msg_count, &con->page_re=
tirement_req_cnt);
+                       }
+               }

-                       amdgpu_ras_poison_consumption_handler(adev, &poison=
_msg);
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\=
n",
                     atomic_read(&con->page_retirement_req_cnt));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 4a72ff8d8d80..38e7793137ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -296,13 +296,15 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_dev=
ice *adev,
                                struct amdgpu_ras *con =3D amdgpu_ras_get_c=
ontext(adev);

 #ifdef HAVE_KFIFO_PUT_NON_POINTER
-                               amdgpu_ras_put_poison_req(adev,
+                               int ret;
+
+                               ret =3D amdgpu_ras_put_poison_req(adev,
                                        block, pasid, pasid_fn, data, reset=
);
+                               if (!ret) {
+                                       atomic_inc(&con->page_retirement_re=
q_cnt);
+                                       wake_up(&con->page_retirement_wq);
+                               }
 #endif
-
-                               atomic_inc(&con->page_retirement_req_cnt);
-
-                               wake_up(&con->page_retirement_wq);
                }
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
--
2.34.1

