Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBDEC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 09:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5437F8F9A5;
	Tue,  9 Aug 2022 09:21:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551139134D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 09:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iwd1xoI7pBRJ+g6LWJKcSohy2ZiVRTmM5Ywocxo62lv1ggP0a8s0iKMedWtZuHsx5sBNDpJTPc/pnxrw+yO+Y0Tnavibmn22I2HSfsvBTOBFADSlhEFRia1gx7+94PQHrfumEgmZYBuX3Rvs1biAv/Dms+P5TbHQR+kb7YxoUYnbHj1iQdvqpUrH9poBRHRSiqMiqkc+xbwE4KZPd7h3ihQ/sAoC6JJz4kdm4N0xcUYGhAAhS1RGS5Ou8rfLzOHalsIh+MfVTG7xXYfVNuZOxBKFqogB3kUzgTDF8hB8yNJO/HvTg3dkXNmfj1lATtSoD1F/X67jnIM9hRBdnZTj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK5+LXayF7m5hEUyB5gBsYBOHDuLvBgNH2VG8oHg3YE=;
 b=Pi1IwOOxnID7JgDFHlGc4EwnCa4u33RofjX3kV6+CFh2sDsb6llgGqwUXUhgbVCsneOK9yhuZs/8Vc0sXx9RNtgP3f5I/rAIZ176lmMZB+bSKd1VHgKTdEge2lLAFqdf3yQTykbaZ3h1P88cCVOV6fgXhCXc6cZldxtO1Vz16q9XAQRJ9FPtvlnPBE6AkXGgSFP3DZIoPQuvjS2a4IESmOo6eAldf5cj2Er1InDU1grh8JUJ92QQ+03sWkbXge3JBHRBnJQC3h3yOFpDMGp86iCpa9CMVIgu0sAhACwxQfomDl15hIYStVfKTqPaGsdmyuFqJmPv4ukBdgbWlffTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK5+LXayF7m5hEUyB5gBsYBOHDuLvBgNH2VG8oHg3YE=;
 b=s/HCib61Mv4ys8IB8LC51sVlcD3z3/bHrJZCGQm/A2wXwD3oW7rXizaPj1Ip8uYk6dus1dJ/znldi5kW+Drem3kOUBa2zww12aAyxhqzHRQYPJhjARPoCYXxMicKpjfXRtsDaFeVhv5wgFjAJvXipj1TWN6ROkfIYmWs5WUgtMg=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 09:21:01 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::207d:4364:5b65:b484]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::207d:4364:5b65:b484%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 09:21:01 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: modify mcbp implement for gfx9(v2)
Thread-Topic: [PATCH 1/2] drm/amdgpu: modify mcbp implement for gfx9(v2)
Thread-Index: AQHYq9CRjYhNQOsQvEWAPXqvcnpXC62mSZPQ
Date: Tue, 9 Aug 2022 09:21:01 +0000
Message-ID: <DS7PR12MB633394912926A7E531FB5D81F4629@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20220809091448.958375-1-jiadong.zhu@amd.com>
In-Reply-To: <20220809091448.958375-1-jiadong.zhu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e4ce5818-603d-4e82-a3f4-9e84c63708ba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-09T09:15:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3dc45e5-d0f6-4a98-0f71-08da79e87a12
x-ms-traffictypediagnostic: BN9PR12MB5179:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggDBqWXZgmn1TRRcC9g7bZxzzjs5y/62ZMuPUeR2uMnvrBZ70MmKo8qHu6NYRk9qxg3yGiW1jODoFdSudTVannz3QDwD9HGPee25JzrSajz4dJBsaoqXrcRmL38LBjnHWmYeO5Dmo71DVS+UwBcvoX72Hpl/Zx1DdeIKV/TguQedeLkoVsZ1gvANX0aNe+KGT2OOP1eUatdnKm8XJ/MI3vDsiAt40Duy5X1x7di0vC3CO40D25Ab3r+7+U1tP/+GENDv2ve6+ryKQZt6grMNcPXI8lw9RWCKfi1PATYpyGSvCQKwypNh/bdFz4dNKR+AFEoTvuTeIezrtJXQ8ObK1cgqkyIeVESYHAcpb0f8PLQ6IX3A8XqnP3LZHfbKAvflvtr/BCo1+KJ1mU9Lmp8KrA1qCMjD9gpq3+EF6l86zwVDP9vptxeHLMSMWHsj0zJ1edJ730YCiwsvy7NJ38nqGt8ytH0L7JIN7oHX3YKp4/QEtvpJgEIf1os6MVRrHYGa52JOESgkEm0RmBBFIbpyGF27rp1diR+QSwv9pJx18/pMuWoS4tgLsvdJjEVIktE4Zm/xXCA8CSSBI9zbZ/3AsOPksZjgP9TeWF2ZAZtdMR0Q/ZFnNIxfcLU9z6D0YV1wJ2UDznScLLpwqjZUmqjbhn2r2wIIKyBv8mLnnDsplkLd+HXga+4nAsZv+05OuIT+R7RmZnukiCiM77kswC35cS/JA1lGybfO9XWp/8lw6MWXZZatSopoIBfo3QKYifGfV9cEbu1jLdFI09ZTStxXmlQZRfD16YRrlRtdCyR+IFkAFPmVoR0Rbk3KdhPPY/9b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(76116006)(66946007)(122000001)(66476007)(8936002)(52536014)(66556008)(30864003)(186003)(64756008)(8676002)(38070700005)(38100700002)(4326008)(66446008)(5660300002)(55016003)(478600001)(71200400001)(9686003)(6506007)(7696005)(41300700001)(26005)(53546011)(2906002)(6916009)(316002)(54906003)(33656002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?92PWkN/aBI/IFjsG6Lb+7wKtyJnIVFLBR0RYL1YtBweztZMt9fJwnnibVRTN?=
 =?us-ascii?Q?4qMtXcNv+rjWJSgedfSPqRpxOytkXu7PQD705n3se0/YCo1HPIiaxDNr0hcR?=
 =?us-ascii?Q?3RI6IL+cYX00djPCacYQgFlmy3fZqIYfHdCBbWBMsS0AUaXRY4EEtdnwMNOx?=
 =?us-ascii?Q?PHAcrDtub0xHJvXLrUooRoHAIdLSnCNb1lbTEUTI5PLhs7+Ad97o+8PB7Fr2?=
 =?us-ascii?Q?rQOds9pcEy3O6iKGw1XwoGR3HfWfqmT/Eifqq9Xo31+Fp3rdg4E4z3d0gdze?=
 =?us-ascii?Q?wo6VRuyEw7pt3wTsRjJpeNEIOLzGrVaVKL3Vu94h4H/y40sQzjTisR8dhjdj?=
 =?us-ascii?Q?PYfospLJM6qdMwkEHr3S8AedaidPOSqE/MLP4TzgWlrQk8pN8fAEF+QlebP8?=
 =?us-ascii?Q?v8n2vX/Y4AwJs7KfcUNL7B41AwhO8jw7pOO/KZsl1K/RA/RF2gUq+No/NXGz?=
 =?us-ascii?Q?ufOXH+6tbtiL3N0b6nFlgj3qu9G8NNYl6lOmql8gU1iFjidwuDbBiTZBg2nu?=
 =?us-ascii?Q?OYbNSOSmRqLki6JzIE5V+hUDSfnmt431ilTn40BBKA5+3rjrzlXfd6U1osTj?=
 =?us-ascii?Q?bBqXLYbXy/J+Kbv30XXcvabGoSkT3sFV76ugPgNu5ClRvCpqQlJlJVcypkgT?=
 =?us-ascii?Q?gvibLT4BcSYa+n4W06BcWWeR4FZaTLEo5KTywWIw67yG5feS7Qq2Pyzou+1y?=
 =?us-ascii?Q?O9ZQLJZuIivxObKcXN4ElRgyBaGpWkjT50tm3Nk72O2yAWynmwN6PAAWU9DO?=
 =?us-ascii?Q?4w4V1qhyIsizPmDcjIhv9KjAMprjjykKuvKen8jhbHsEaJPbM1CgI6nkAH+T?=
 =?us-ascii?Q?wwhG5K2YNwxjaTOvTkpbAIhYrA3Ytx1uw7eoJM39te09gNOo9uRmywTDahBz?=
 =?us-ascii?Q?r0QmQm24uZxVhdExN0srLg0SFBxEvZugKHa3UERtIYMJ9PHR3wNymcYiqV5+?=
 =?us-ascii?Q?MtEgdtwm/hJpmSH+9TsvmGI5Uuf3y50Nb6b/q+xIIttTzt9h/6dXGP0gYF96?=
 =?us-ascii?Q?M+OPb6n5WKjkOQC70K0KD+5Zuh30dkpR2BtVSSHZVDiIc2Siq1UEGEpDV0Tn?=
 =?us-ascii?Q?P1vszVaCWds9bftqojguiJz/YxCnU5hu4Ii2f0fVm6GPUaPubjMqOPAeQ1Um?=
 =?us-ascii?Q?I3+kUEnVvKgYxE2IPtHQm8rGRQ4VyC5R4UoXrprfETXmHGAbgmKzsOhqZu35?=
 =?us-ascii?Q?dFIsHGU52+YXcg7OV0iIx2Twq9nGYO2k2352CnbXSMaDlMCWGDd7PlPKXYGP?=
 =?us-ascii?Q?knToolXEfCrW2V9vXVRAmRgozEXpfknHWzfM7umsAIp2iY3GaD5eI8hGSUrc?=
 =?us-ascii?Q?lOxkccCMN7hM2FqW7/gVRjUs0Py6bK8XnOV4x9iXGpLO0Pf5lxpYNTRefdwi?=
 =?us-ascii?Q?Vkm0vEmLw7LEXumbJgbYdMt5IoxX6e1cnXDwsNudVSV9n+EziY9WFOwpaPBu?=
 =?us-ascii?Q?yc0/aZSVgvpjtGwO+iF0ufIrinhDwfJLSLIdJbeCuRO1OCdWunGnaO6jzDZX?=
 =?us-ascii?Q?FxZ3jXaE5glgwCZVju/iXxsM8m85S3v+WBYatgYsidq4aLl1ubKsnec33SV/?=
 =?us-ascii?Q?+CpX+/DqRXTl7S1/XEDbDt+MDhDhSkIW+UR3qWCF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dc45e5-d0f6-4a98-0f71-08da79e87a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 09:21:01.3411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeVj3ItyvaB4FvFyv5Duu+aKWJNtZyaJrEj2/cfpH0khrGYoqPFCtv/0gqOUa84PKPyGSFB9XWp46J7jSSIlDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi,

This patch is to correct the mcbp package for gfx9, which is the basic func=
tion used for debugfs.
There are no logic about when to trigger mcbp.
Shall we get this reviewed?

Thanks,
Jiadong

-----Original Message-----
From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Sent: Tuesday, August 9, 2022 5:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Aaron <Aaron.Liu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Zhu, Ji=
adong <Jiadong.Zhu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: modify mcbp implement for gfx9(v2)

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

1. Use unmap_queue package to trigger preemption on gfx9
   Add trailing fence to track the preemption done.
2. Modify emit_ce_meta emit_de_meta functions
   for the resumed ibs.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 159 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
 3 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index 82c178a9033a..ca626f0ad7b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -59,6 +59,7 @@ enum amdgpu_ring_priority_level {
 #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
+#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)

 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 5332899642dc..0b7cb4cf13c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -751,7 +751,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device=
 *adev);  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
                                struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)=
; -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
+static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool
+resume);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);  stat=
ic void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
                                          void *ras_error_status);
@@ -824,9 +824,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ri=
ng *kiq_ring,
                        PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbel=
l_index));

        if (action =3D=3D PREEMPT_QUEUES_NO_UNMAP) {
-               amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
-               amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
-               amdgpu_ring_write(kiq_ring, seq);
+               amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring=
->buf_mask));
+               amdgpu_ring_write(kiq_ring, 0);
+               amdgpu_ring_write(kiq_ring, 0);
+
        } else {
                amdgpu_ring_write(kiq_ring, 0);
                amdgpu_ring_write(kiq_ring, 0);
@@ -5446,11 +5447,15 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu=
_ring *ring,

        control |=3D ib->length_dw | (vmid << 24);

-       if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREE=
MPT)) {
+       if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags &
+AMDGPU_IB_FLAG_PREEMPT)) {
                control |=3D INDIRECT_BUFFER_PRE_ENB(1);

+               if (flags & AMDGPU_IB_PREEMPTED)
+                       control |=3D INDIRECT_BUFFER_PRE_RESUME(1);
+
                if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
-                       gfx_v9_0_ring_emit_de_meta(ring);
+                       gfx_v9_0_ring_emit_de_meta(ring,
+                                (!amdgpu_sriov_vf(ring->adev) && flags & A=
MDGPU_IB_PREEMPTED) ?
+true : false);
        }

        amdgpu_ring_write(ring, header);
@@ -5505,6 +5510,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ri=
ng *ring, u64 addr,
        bool write64bit =3D flags & AMDGPU_FENCE_FLAG_64BIT;
        bool int_sel =3D flags & AMDGPU_FENCE_FLAG_INT;
        bool writeback =3D flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
+       bool exec =3D flags & AMDGPU_FENCE_FLAG_EXEC;

        /* RELEASE_MEM - flush caches, send int */
        amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6)); @@ -5515,=
6 +5521,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring,=
 u64 addr,
                                               EOP_TC_WB_ACTION_EN |
                                               EOP_TC_MD_ACTION_EN)) |
                                 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
+                                (exec ? EOP_EXEC : 0x0) |
                                 EVENT_INDEX(5)));
        amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_=
sel ? 2 : 0));

@@ -5620,33 +5627,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring=
 *ring)
        amdgpu_ring_write(ring, 0);
 }

-static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
+static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool
+resume)
 {
+       struct amdgpu_device *adev =3D ring->adev;
        struct v9_ce_ib_state ce_payload =3D {0};
-       uint64_t csa_addr;
+       uint64_t offset, ce_payload_gpu_addr;
+       void *ce_payload_cpu_addr;
        int cnt;

        cnt =3D (sizeof(ce_payload) >> 2) + 4 - 2;
-       csa_addr =3D amdgpu_csa_vaddr(ring->adev);
+
+       if (ring->is_mes_queue) {
+               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
+                                 gfx[0].gfx_meta_data) +
+                       offsetof(struct v9_gfx_meta_data, ce_payload);
+               ce_payload_gpu_addr =3D
+                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+               ce_payload_cpu_addr =3D
+                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+       } else {
+               offset =3D offsetof(struct v9_gfx_meta_data, ce_payload);
+               ce_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + offs=
et;
+               ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
+       }

        amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
        amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
                                 WRITE_DATA_DST_SEL(8) |
                                 WR_CONFIRM) |
                                 WRITE_DATA_CACHE_POLICY(0));
-       amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9=
_gfx_meta_data, ce_payload)));
-       amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9=
_gfx_meta_data, ce_payload)));
-       amdgpu_ring_write_multiple(ring, (void *)&ce_payload, sizeof(ce_pay=
load) >> 2);
+       amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
+       amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
+
+       if (resume)
+               amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
+                                          sizeof(ce_payload) >> 2);
+       else
+               amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
+                                          sizeof(ce_payload) >> 2);
+}
+
+static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring) {
+       int i, r =3D 0;
+       struct amdgpu_device *adev =3D ring->adev;
+       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
+       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
+       unsigned long flags;
+
+       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+               return -EINVAL;
+
+       spin_lock_irqsave(&kiq->ring_lock, flags);
+
+       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+               spin_unlock_irqrestore(&kiq->ring_lock, flags);
+               return -ENOMEM;
+       }
+
+       /* assert preemption condition */
+       amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+       ring->trail_seq +=3D 1;
+       amdgpu_ring_alloc(ring, 13);
+       gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
+                                 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
+       /*reset the CP_VMID_PREEMPT after trailing fence*/
+       amdgpu_ring_emit_wreg(ring,
+                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT=
),
+                                 0x0);
+
+       /* assert IB preemption, emit the trailing fence */
+       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
+                                  ring->trail_fence_gpu_addr,
+                                  ring->trail_seq);
+
+       amdgpu_ring_commit(kiq_ring);
+       spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+       /* poll the trailing fence */
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               if (ring->trail_seq =3D=3D
+                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
+                       break;
+               udelay(1);
+       }
+
+       if (i >=3D adev->usec_timeout) {
+               r =3D -EINVAL;
+               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+       }
+
+       amdgpu_ring_commit(ring);
+
+       /* deassert preemption condition */
+       amdgpu_ring_set_preempt_cond_exec(ring, true);
+       return r;
 }

-static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
+static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool
+resume)
 {
+       struct amdgpu_device *adev =3D ring->adev;
        struct v9_de_ib_state de_payload =3D {0};
-       uint64_t csa_addr, gds_addr;
+       uint64_t offset, gds_addr, de_payload_gpu_addr;
+       void *de_payload_cpu_addr;
        int cnt;

-       csa_addr =3D amdgpu_csa_vaddr(ring->adev);
-       gds_addr =3D csa_addr + 4096;
+       if (ring->is_mes_queue) {
+               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
+                                 gfx[0].gfx_meta_data) +
+                       offsetof(struct v9_gfx_meta_data, de_payload);
+               de_payload_gpu_addr =3D
+                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+               de_payload_cpu_addr =3D
+                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+
+               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
+                                 gfx[0].gds_backup) +
+                       offsetof(struct v9_gfx_meta_data, de_payload);
+               gds_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)=
;
+       } else {
+               offset =3D offsetof(struct v9_gfx_meta_data, de_payload);
+               de_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + offs=
et;
+               de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
+
+               gds_addr =3D ALIGN(amdgpu_csa_vaddr(ring->adev) +
+                                AMDGPU_CSA_SIZE - adev->gds.gds_size,
+                                PAGE_SIZE);
+       }
+
        de_payload.gds_backup_addrlo =3D lower_32_bits(gds_addr);
        de_payload.gds_backup_addrhi =3D upper_32_bits(gds_addr);

@@ -5656,9 +5765,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu=
_ring *ring)
                                 WRITE_DATA_DST_SEL(8) |
                                 WR_CONFIRM) |
                                 WRITE_DATA_CACHE_POLICY(0));
-       amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9=
_gfx_meta_data, de_payload)));
-       amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9=
_gfx_meta_data, de_payload)));
-       amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_pay=
load) >> 2);
+       amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
+       amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
+
+       if (resume)
+               amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
+                                          sizeof(de_payload) >> 2);
+       else
+               amdgpu_ring_write_multiple(ring, (void *)&de_payload,
+                                          sizeof(de_payload) >> 2);
 }

 static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool s=
tart, @@ -5674,8 +5789,9 @@ static void gfx_v9_ring_emit_cntxcntl(struct am=
dgpu_ring *ring, uint32_t flags)  {
        uint32_t dw2 =3D 0;

-       if (amdgpu_sriov_vf(ring->adev))
-               gfx_v9_0_ring_emit_ce_meta(ring);
+       if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
+               gfx_v9_0_ring_emit_ce_meta(ring,
+                                   (!amdgpu_sriov_vf(ring->adev) && flags =
& AMDGPU_IB_PREEMPTED) ?
+true : false);

        dw2 |=3D 0x80000000; /* set load_enable otherwise this package is j=
ust NOPs */
        if (flags & AMDGPU_HAVE_CTX_SWITCH) {
@@ -7024,6 +7140,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_f=
uncs_gfx =3D {
        .emit_cntxcntl =3D gfx_v9_ring_emit_cntxcntl,
        .init_cond_exec =3D gfx_v9_0_ring_emit_init_cond_exec,
        .patch_cond_exec =3D gfx_v9_0_ring_emit_patch_cond_exec,
+       .preempt_ib =3D gfx_v9_0_ring_preempt_ib,
        .emit_frame_cntl =3D gfx_v9_0_ring_emit_frame_cntl,
        .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
        .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait, diff --git a/driver=
s/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index 799925d22fc8..614e9f8467fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -162,6 +162,7 @@
                 * 2 - Bypass
                 */
 #define     INDIRECT_BUFFER_PRE_ENB(x)          ((x) << 21)
+#define     INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
 #define        PACKET3_COPY_DATA                               0x40
 #define        PACKET3_PFP_SYNC_ME                             0x42
 #define        PACKET3_COND_WRITE                              0x45
@@ -184,6 +185,7 @@
 #define                EOP_TC_ACTION_EN                        (1 << 17) /=
* L2 */
 #define                EOP_TC_NC_ACTION_EN                     (1 << 19)
 #define                EOP_TC_MD_ACTION_EN                     (1 << 21) /=
* L2 metadata */
+#define                EOP_EXEC                                        (1 =
<< 28) /* For Trailing Fence */

 #define                DATA_SEL(x)                             ((x) << 29)
                /* 0 - discard
--
2.25.1

