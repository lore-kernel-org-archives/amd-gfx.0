Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4943C021BC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 15:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D0F10E3DD;
	Mon, 24 Feb 2025 15:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PH7q3A+b";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635E810E3CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 15:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8PT4TKXiFpt8FSTdC6H69OBHOQLuclMNP3FT4+SHEx5Y05xfYBQdMYEgFBu1mKfhlWkSi1Bpys/oSoqEos0lGjtF4hCYVAySZBcBZIXlRli/J6ioQT9QIhQeeNL7MZTYTsyb6cvE1XkvuKhlQEhfKXTEX2R5S61xrsbR7p7X/0e8IgCvqDENnnrtRJLEstPoIkUxiUaex/q13KIdoow/GQi+cG6zEKTYuin8hj1/YRi8vmDuc3ksMw3DAYeLKMF/4VKTE4s5sOdSqCVzZAor3BdwrbxxaFHe2+f9AAold7V0Shqy8c0MMTXhDIIxKqdOlEhTBohbMOwp3RlLM7J6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDZ8ds/t2oFYn8auoEZanFunlyHhd2kAPOECdJAy2W0=;
 b=aUaP/MTQn7J5kdMSWDAiKq78UlpF65yi/X9BE3Fj1A7kPATbm01yekhNEYbtHWtFawAfreEfEGbmiCS/xHtvXLt0U1gG/XbKuRvb7rCyVyZjIvehwEjg1axtstGtwZCElVDqoD/KF8uu/0R4iJzoMwDS4OW8ZaxYaipp8qUQj7jGz0T3dJX0tknsJJuPvREJJjArWllgYGetGxwrrg7t4/sOSMA03cN0KnUYqNPBYYC5ShHoj0+PALsNS17qemecaV764A0s0BTOY+dIrI0L23Z9JB3PDV17RE5eFbS0gBUES5sYpvwdG0A/IHWt+vZ9DDuc/KM+zwctJIAAvyedWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDZ8ds/t2oFYn8auoEZanFunlyHhd2kAPOECdJAy2W0=;
 b=PH7q3A+bdc3orwWMuGYTmm5QFaoh3dvUI8sCSBNWgUmkKnO+rkI947nhhoeV1Yk2CVE/VZgIMpB7rQ6rcQkuDqN12MssJgzaoBOK8Tqh5KaxMfYNFNZeomLMThWQrhwR0dnTeUv24B+0LIv2SBjxHZZ1wXNbh3RRKmQJq2mTGFg=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:34:12 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:34:12 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "Yao, Yinjie" <Yinjie.Yao@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn: send session ctx along with msg buffer
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn: send session ctx along with msg
 buffer
Thread-Index: AQHbhM5PQnO+nQIZs0m919W7wN4Ds7NWmOVg
Date: Mon, 24 Feb 2025 15:34:11 +0000
Message-ID: <SJ1PR12MB6194FB0AD02D55601195551F95C02@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250222020530.8194-1-boyuan.zhang@amd.com>
 <20250222020530.8194-2-boyuan.zhang@amd.com>
In-Reply-To: <20250222020530.8194-2-boyuan.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=429161af-e05e-44c7-bf2b-3b19b101e78e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T15:32:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SJ0PR12MB7065:EE_
x-ms-office365-filtering-correlation-id: 508d159a-d3cd-4a07-16ec-08dd54e8afb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?irFMECn7vpltP1ScIGHnzNzV4xknU64BP5Z9iwjBb7cnpAm7z+Jz3RKWJX9h?=
 =?us-ascii?Q?2XkYjwdvY6lHR2xRrqdLHDNaWKTMBOWi0WFQw9ixM5rJQGePzVpA4bTiOoob?=
 =?us-ascii?Q?NveUV7XNxoa1cJzpnaaCN6uvAwmei+vccHiGABNvJO+VuOAv5dX7jftfQmff?=
 =?us-ascii?Q?qwCZaaOmkGjwrmuF57Gs319B82Z2sqK0mDXgq3eATxrAmd/FYqBWnPEL+Bqb?=
 =?us-ascii?Q?ydTZlM9KKVDZPf4+P9PTb4aT/Zr9LBD+9nyYAlluCjwyLngYc/y/KFd7UIYL?=
 =?us-ascii?Q?JpOgf4HJv5qqyc020cwyCFKmJwaO5/+v1P+Vnij3SZ6vqYtdu3BM20H+Rb/U?=
 =?us-ascii?Q?X6kSqqB9V8sPictl1cAtIyLhHFMIQkipQ1XiQz8x5R2hm1PGenVtPgJMWjv5?=
 =?us-ascii?Q?ce6HfuomUfdWB/T/mbjkuT/KDM+BmtI+EIRaaR6Lc42jr2nG+uP4a786cUHq?=
 =?us-ascii?Q?6FrKUtxAUUXYK7ywXJtDyG9N15EmGfpzmk8B6RUijcLFDUeDNJ1bTk8TCLEE?=
 =?us-ascii?Q?GmC62gB2u6p0R0pGC/ujFi6VwOhVnb2p5RiQ8YDy5TIf6GTHPaMxgzJ9lKGB?=
 =?us-ascii?Q?QKANIgRZBLKRikNhZsZB6kw6hCwCSxthUmQXsQcPXZoc8I0y5cLTW3wixZaZ?=
 =?us-ascii?Q?c0QFVIMCeR3vbbyN3Ks87GCLbLaO2k3LKntrCgnMOkd+wJHatTLFM87ZAuwS?=
 =?us-ascii?Q?4ATa0oSHfL1JeokiqwTyAWRI6D07T8G4orf6v/0Ql8GWGYeFNf7tUSJ5gKwY?=
 =?us-ascii?Q?ZJK0bPEb8IzZsTdUVkdkkAMe2lHR2S2uLyFJoX7YR5Uzlk98NQEHCtReIuv2?=
 =?us-ascii?Q?Hwp9RyXTqAW0z0kGNpTs8kHKvls5yM+g9yfYj0H+r2B420lxyXGW6rfo1L6J?=
 =?us-ascii?Q?G3YRk3kAi6n9AKog2sEfEY/ISbFJfhmRbElvsomgGMRnUNof8T9hEDJ7RKnd?=
 =?us-ascii?Q?NmBedPovrjr3CwTbsledLD0BCkQ+0hXszib2o2Q7aFBFqAXajUlRHx3hz/rz?=
 =?us-ascii?Q?yuulY9UmQgB8UM6TC7Sdd+8UWUC5G+IylWJlSsbMwfrEuCzsa7CAO+9Zll/g?=
 =?us-ascii?Q?gg3NXBwfl/PwNL+CGqn29Dr4FwZtK/sNkl5pp8dt+oemaNZ5zyXBy73PWjnZ?=
 =?us-ascii?Q?5d087Kyb+HJAbFY2SiPayVK0XK+1MA7hV+7oUSbbqL42gKWdi7/U1OdcwNSJ?=
 =?us-ascii?Q?3TH5nkxrpnecbptzHC0cDBnzzw2z1zjCD/+9wQLyZvf7utQJcF8cK3ELND1l?=
 =?us-ascii?Q?8qHihNHg6ZHRRF5H7DlCpSdmLyGFk3T49Lb15FInCO+1s5KuIo72ilQQpPra?=
 =?us-ascii?Q?des6FxVKePgVZUSQ/bR9wjtgZV2kvl+B37TU8QuGBnWyr2r+858fG7oRXR3A?=
 =?us-ascii?Q?/3N5iZ3E6NYlnLwz5pP9rHm2M2gOZ09960f0SgynHnIrzNhqh1a0Iwk68hMj?=
 =?us-ascii?Q?leKW3mVUPiQaEBqR5Pfdvmrff3BogtvJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b6mdHLcKL0EXKWZxwf+nihc0eSUp/PPPNFL4frfDPFe1rZzNXShAl3zro1fu?=
 =?us-ascii?Q?nvCzYSxILm8PIvf5e/Ry6e8hAW3wksHvY22BHHxQSlg6sjqMMGAW1WqWSvB5?=
 =?us-ascii?Q?Kn0g5KDy9/GPb4kVDKnFVD86rNsm9d9SejMjGf4CuJx4Nh7fIqsaRJSoZTNJ?=
 =?us-ascii?Q?qIrc1QmV2rj19mpPu0kRLtgZtH9fY30O7W54YoZMv6u7LohB6XQDqGubC2Pt?=
 =?us-ascii?Q?GHWyk9xue07jFQUo95O9UECKRe9Rhiwyy0eWHd4gp5jcL0F9HBYRKHMBSua7?=
 =?us-ascii?Q?nPotEHXJIF6c6521zP/uqtxBPZlOywehJQn4Uq7eibbAT5zZj0GKUk6ONaKI?=
 =?us-ascii?Q?OX3JaRYg6udaDmsXRxbNJZiP5jywzt0GW0meyj/7RAvqQ0fILfjvcvC7p2ef?=
 =?us-ascii?Q?aw8hw2Ub5RsV/TvOJPh/zb4EjqCG6fpUkWMZd1k9F+XVB87IpYccVg0yG35e?=
 =?us-ascii?Q?hbAyOaZYghJDZpdca6YU+dj6hXG74gEHOrrrQYKGGPXqFON8aAc+zwYVRCK/?=
 =?us-ascii?Q?kWxubQ1vTZ6gGEs+YuPbcpkpVLIxpxMHwitu1ZySZHpPR+soLyitgbnt5jZU?=
 =?us-ascii?Q?LhcyBqaSalK+6qwTjyGu3J49a1l/SiN4pUIKCcbmQ9ZCNpCqwARIAG9D/0Xt?=
 =?us-ascii?Q?MmDxSVmVc980rQbrCLDoTGYctPlMuM6jM6HsnL2aD/LJM8c+auXpjc8ksSZF?=
 =?us-ascii?Q?WydD+UqJU0k1i5lwUfn9uKLcGLprzVL8QFTJ7ccUhdnDkNLoh4iOGMc1kSJn?=
 =?us-ascii?Q?FMg8UxOeXCYw/1IwFIHU4Q9oP8flkzJuzTutFc1QKcRcb+C1ZZYQZ96oeh1+?=
 =?us-ascii?Q?h7Sq3UFnACOSdMDqK6z2IfcDeHPSx8ZQoZoMgZ7fkgVoZO2StXU2INeklDwF?=
 =?us-ascii?Q?xaTAWL/C8C6eZJ8oztEwQ9F8hxClqbFD9b8NbvNpgpJDu2bPkDN/P+owrBdh?=
 =?us-ascii?Q?gegfV16PP8a2MzdzUsMMq+tcLRWU1NdqXXiRXeVMS0WO2ZgIWQ97Nt/fFOyE?=
 =?us-ascii?Q?0clBuze2pnLWAolhTKkPY7yk5apxywkjEjgpEHMablF6QjBjsex3TQc4GNOH?=
 =?us-ascii?Q?1UI+D68yr9LTma3YVek6umRN0ouy/lJrlhUBCnhaKd7+nFKPfQn2Ex8e/w9r?=
 =?us-ascii?Q?iyeERcofaiJacK6gHXLDJnT9BuW8fryZQf4CA/xgiQx03pOaXfhNCDtbvH5L?=
 =?us-ascii?Q?Q4e+QI3uwWf344lror2VhUwyN3gbSwbxjD3gjwJDz5dNgyWmx8PkFUvf1ul5?=
 =?us-ascii?Q?EXTJR823xZZMWjAIGYrGOmuTZvAEc0dJaEeqJ+f01vAOfJVuIJTcsH3GSi87?=
 =?us-ascii?Q?1WiMfGKYlZRUiFLMuplCRI1BaZUEh28og5ZLkR2BWgUamHsh8YGYEE7W51QU?=
 =?us-ascii?Q?y0UG7RkzvvF/6YD0crx47HCQ+vjOgckPF8WcFtDUXvI8zak5swjezcd5oLdl?=
 =?us-ascii?Q?RDTAixayWmYtCuLb+LJRHF9SDZIGPt1ztGazr6vCTJwFDHayrh/chGlO2Dn3?=
 =?us-ascii?Q?uqm8VTU9TPNFSTZ1sJYrKaRamGTyxcXrQ5h+pCrULIAA9S3b73IEJO1A63oM?=
 =?us-ascii?Q?bo2T1FuT9/SIwHPQ72I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508d159a-d3cd-4a07-16ec-08dd54e8afb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 15:34:11.3226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTWKZdTSqaS9AIg+cHPB4uCSrFIgDoMYW7AwkP725wmVGjFeja25ciWU2ouHSdVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
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

This series is

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of boyuan.z=
hang@amd.com
Sent: Friday, February 21, 2025 9:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Boyuan <Boyuan.Zhang@amd.com>; Yao, Yinjie <Yinjie.Yao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: send session ctx along with msg buffer

From: Boyuan Zhang <boyuan.zhang@amd.com>

Session context buffer is required to be sent along with message buffer

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Tested-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 43 ++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 83faf6e6788a..8d2cce3ea7af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -602,18 +602,29 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring=
 *ring,  }

 static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_=
t handle,
-               struct amdgpu_ib *ib)
+               struct amdgpu_ib *ib, struct amdgpu_ib *ctx)
 {
        struct amdgpu_device *adev =3D ring->adev;
        uint32_t *msg;
        int r, i;

-       memset(ib, 0, sizeof(*ib));
-       r =3D amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
-                       AMDGPU_IB_POOL_DIRECT,
-                       ib);
-       if (r)
-               return r;
+       if (ctx) {
+               memset(ctx, 0, sizeof(*ctx));
+               r =3D amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 32,
+                               AMDGPU_IB_POOL_DIRECT,
+                               ctx);
+               if (r)
+                       return r;
+       }
+
+       if (ib) {
+               memset(ib, 0, sizeof(*ib));
+               r =3D amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+                               AMDGPU_IB_POOL_DIRECT,
+                               ib);
+               if (r)
+                       return r;
+       }

        msg =3D (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
        msg[0] =3D cpu_to_le32(0x00000028);
@@ -669,7 +680,7 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *rin=
g, long timeout)
        struct amdgpu_ib ib;
        long r;

-       r =3D amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
+       r =3D amdgpu_vcn_dec_get_create_msg(ring, 1, &ib, NULL);
        if (r)
                goto error;

@@ -727,6 +738,7 @@ static void amdgpu_vcn_unified_ring_ib_checksum(uint32_=
t **ib_checksum,

 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
                                      struct amdgpu_ib *ib_msg,
+                                     struct amdgpu_ib *ib_ctx,
                                      struct dma_fence **fence)
 {
        struct amdgpu_vcn_decode_buffer *decode_buffer =3D NULL; @@ -735,6 =
+747,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
        struct dma_fence *f =3D NULL;
        struct amdgpu_job *job;
        struct amdgpu_ib *ib;
+       uint64_t addr_ctx =3D AMDGPU_GPU_PAGE_ALIGN(ib_ctx->gpu_addr);
        uint64_t addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
        uint32_t *ib_checksum;
        uint32_t ib_pack_in_dw;
@@ -765,6 +778,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ri=
ng *ring,
        ib->length_dw +=3D sizeof(struct amdgpu_vcn_decode_buffer) / 4;
        memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));

+       decode_buffer->valid_buf_flag |=3D cpu_to_le32(AMDGPU_VCN_CMD_FLAG_=
SESSION_CONTEXT_BUFFER);
+       decode_buffer->session_ctx_buffer_address_hi =3D cpu_to_le32(addr_c=
tx >> 32);
+       decode_buffer->session_ctx_buffer_address_lo =3D cpu_to_le32(addr_c=
tx);
+
        decode_buffer->valid_buf_flag |=3D cpu_to_le32(AMDGPU_VCN_CMD_FLAG_=
MSG_BUFFER);
        decode_buffer->msg_buffer_address_hi =3D cpu_to_le32(addr >> 32);
        decode_buffer->msg_buffer_address_lo =3D cpu_to_le32(addr); @@ -780=
,6 +797,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring=
,
                goto err_free;

        amdgpu_ib_free(ib_msg, f);
+       amdgpu_ib_free(ib_ctx, f);

        if (fence)
                *fence =3D dma_fence_get(f);
@@ -791,27 +809,28 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_r=
ing *ring,
        amdgpu_job_free(job);
 err:
        amdgpu_ib_free(ib_msg, f);
+       amdgpu_ib_free(ib_ctx, f);
        return r;
 }

 int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)=
  {
        struct dma_fence *fence =3D NULL;
-       struct amdgpu_ib ib;
+       struct amdgpu_ib ib, ctx;
        long r;

-       r =3D amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
+       r =3D amdgpu_vcn_dec_get_create_msg(ring, 1, &ib, &ctx);
        if (r)
                goto error;

-       r =3D amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
+       r =3D amdgpu_vcn_dec_sw_send_msg(ring, &ib, &ctx, NULL);
        if (r)
                goto error;
        r =3D amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
        if (r)
                goto error;

-       r =3D amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
+       r =3D amdgpu_vcn_dec_sw_send_msg(ring, &ib, &ctx, &fence);
        if (r)
                goto error;

--
2.34.1

