Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C54C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3762469C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u8+rHmA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3762469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86D26E297;
	Mon,  2 Mar 2020 09:42:22 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0F36E228
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmg/TVev7SzsXBRV54lVS2qeNkDWvTdZ7Jo7hgUOo133P7HPpBO7AgH75eFZW+tV1j8uTC9YkFzZK8pAdf8aBKcA4FpbqN7+ZEwO74d0zxYX4Ql9OTgQv5rZzxJJF3XRwBuDKzLPwsCmuJgJDzYQD9vCgZyJ++UXATj09xbVYulqzFY3dz2LNVEtFNdJDYlYBUB/PsqEAaOg4SozNfCT/hNQ/IRyHhdNJU4d2AUlDikumbB8hVcK4iTkusmBkFdjbe4dkHoNF+jbswj/53b5jM7BZ0+DB5s42nstYnPicMKsGChvyEDNpmror223XEBhRE+SuXI4ANB9K8ZyCAGPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TZPmdYV613gq+tVfeDXyUVgY/aCgKzTjPe2mJ+cItY=;
 b=GViJiv4MsoDrdzZczH5Hb9REGYRIUn7rmLiqppOGVG6wggLsj/9b8MLAIaGzZW+0QIP+Z40R/DfPEDj/WBOoguTGP2IEFaJkS7BgreqBRcGauO/HhgHRLoOeFWFuYn4+ZhlfXOAjkHmlU49G9NNeIhg/A3dThVDj4VXKBlVH0qWSH9sRznRHUoGUfjeUL3JyME+uKPBurEX6qjAMBMczPHrQbamhaAZgcvGYsyxC16ImMEwxOsN6CumoGnPxa/ZAvCumBfOYTLlwd5Kzpd562r78JdddVKPAgBEUeeIa9xgdVIKRByNix7oPwxjZsaPqTgeam9YKtkCCsfo4y/fWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TZPmdYV613gq+tVfeDXyUVgY/aCgKzTjPe2mJ+cItY=;
 b=u8+rHmA5FdSWCQ4G3c81kzQNAnMuU9G2LL0FcZOYE01aIQwR9PYtfrD2kUZQBwhgFGAzRhF6mnHYpk9+gKzvHS/NDkIKEoEKKpBqWiwvvYrZ1CraUl9xVrL+I2EzMOQPGpU9mV5YXxrYZ8atLk05EVZlVL07J/UmTxfIsVKJz9Q=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by MN2SPR01MB0026.namprd12.prod.outlook.com (2603:10b6:208:cf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 09:42:20 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 09:42:20 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x
Thread-Topic: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x
Thread-Index: AQHV8DXs8c/IOH8RoUSvTISN+H5ILKg1CoGAgAAAy4CAAAHyzg==
Date: Mon, 2 Mar 2020 09:42:20 +0000
Message-ID: <MN2PR12MB2957E12293081257D05165B395E70@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200302015713.14355-1-tianci.yin@amd.com>
 <CH2PR12MB376760616A6D5482F486FFDAFEE70@CH2PR12MB3767.namprd12.prod.outlook.com>,
 <MN2PR12MB3933E900710ED92A0F80E93E84E70@MN2PR12MB3933.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3933E900710ED92A0F80E93E84E70@MN2PR12MB3933.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-02T09:41:29.254Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cde81d3a-ef1b-410b-0bb9-08d7be8e00b4
x-ms-traffictypediagnostic: MN2SPR01MB0026:|MN2SPR01MB0026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2SPR01MB002647882862A341A17D3ADB95E70@MN2SPR01MB0026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(189003)(199004)(9686003)(2906002)(55016002)(54906003)(186003)(26005)(6506007)(81156014)(81166006)(110136005)(33656002)(7696005)(8936002)(53546011)(52536014)(19627405001)(5660300002)(71200400001)(4326008)(966005)(66946007)(66476007)(66556008)(64756008)(478600001)(316002)(66446008)(91956017)(86362001)(8676002)(45080400002)(76116006)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2SPR01MB0026;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvBb/1wAl0APPqcEOOWN9D/SuqgDchsANa/BurdiZBNprIca05celZuiaVNxuC3tQKpm3U1uf9CyU8sJ5SF2qRo7k9DKxkUxAUcWJLv9HMj0v62UFHmBymFs6KZCBsdj1yopc2NQsGtHii/HcS1Dvzv/whVDr1mnFkvtt7sXgdcAvhZCy9WDcIbgvSYn00An3S0R56vRSvUtky5mMglA/0gaSTmlUJMYuICSYexzmf4DSvqsz1L1Vlj4W+yhv5Zsoc/WffuHHCcibTf2Ing67dBbw9GUi6+6ChySaKDmwuxgS76Znd6E2sXHGISaehKdB6YCBGpD+jn6BJBYO5Ibo/cCidgpGDekerfKIGG1kPb73kdYREs8Ml4Ki5buuRES6FGH8Ie53OK5NAU/TV86uYJG6iVWR5px3hnlp5VkRmvb5mnaQ1BgmqLumGdrr+zY0m40eO5EjCkVlo9FHhoIyvLThDC4oRjRuUWk2c0Ry7yQOMZYlXyp2XwJC7dPSqNiU68RgJQslxPKAMYSZmfHCA==
x-ms-exchange-antispam-messagedata: d7MXCySNgoqNUr/3A1q+v85ItZWHJv2rBJV0E4/JB4VvbApyUpY0/obqIsH/8SlaQYoHf3A56GX4D/Ms94OMwfFTUrKnXw7SJf9KFxil0oF/dO2tiAyn401bwBQKEwVC/3y0k8SsxyVAOscvrLL1pw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde81d3a-ef1b-410b-0bb9-08d7be8e00b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 09:42:20.1618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WcyF3NbOHz1FFRNugoUBWQcAEaqGjD1O8erF8xe/RMURoyZg9QYFfOK0xuF9GHL7tUk44gr4hzzXho5+kY9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2SPR01MB0026
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Li, Pauline" <Pauline.Li@amd.com>, "Yuan,
 Xiaojie" <Xiaojie.Yuan@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0633593952=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0633593952==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957E12293081257D05165B395E70MN2PR12MB2957namp_"

--_000_MN2PR12MB2957E12293081257D05165B395E70MN2PR12MB2957namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks Feifei and Monk!
________________________________
From: Liu, Monk <Monk.Liu@amd.com>
Sent: Monday, March 2, 2020 17:35
To: Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>=
; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Long, Gang <Gang.Long@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yin, =
Tianci (Rico) <Tianci.Yin@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Zhang, =
Hawking <Hawking.Zhang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xu, Feif=
ei
Sent: Monday, March 2, 2020 5:32 PM
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Long, Gang <Gang.Long@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yin, =
Tianci (Rico) <Tianci.Yin@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Zhang, =
Hawking <Hawking.Zhang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x

[AMD Official Use Only - Internal Distribution Only]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>


-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>
Sent: 2020=1B$BG/=1B(B3=1B$B7n=1B(B2=1B$BF|=1B(B 9:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Gao, Likun <Likun.Gao@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long=
, Gang <Gang.Long@amd.com>; Li, Pauline <Pauline.Li@amd.com>; Yin, Tianci (=
Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
CP firmware decide to skip setting the state for 3D pipe 1 for Navi1x as th=
ere is no use case.

[how]
Disable 3D pipe 1 on Navi1x.

Change-Id: I6898bdfe31d4e7908bd9bcfa82b6a75e118e8727
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 97 ++++++++++++++------------
 1 file changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 760fe2ebe799..f348512eb8c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -52,7 +52,7 @@
  * 1. Primary ring
  * 2. Async ring
  */
-#define GFX10_NUM_GFX_RINGS    2
+#define GFX10_NUM_GFX_RINGS_NV1X       1
 #define GFX10_MEC_HPD_SIZE      2048

 #define F32_CE_PROGRAM_RAM_SIZE         65536
@@ -1305,7 +1305,7 @@ static int gfx_v10_0_sw_init(void *handle)
         case CHIP_NAVI14:
         case CHIP_NAVI12:
                 adev->gfx.me.num_me =3D 1;
-               adev->gfx.me.num_pipe_per_me =3D 2;
+               adev->gfx.me.num_pipe_per_me =3D 1;
                 adev->gfx.me.num_queue_per_pipe =3D 1;
                 adev->gfx.mec.num_mec =3D 2;
                 adev->gfx.mec.num_pipe_per_mec =3D 4;
@@ -2711,18 +2711,20 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_dev=
ice *adev)
         amdgpu_ring_commit(ring);

         /* submit cs packet to copy state 0 to next available state */
-       ring =3D &adev->gfx.gfx_ring[1];
-       r =3D amdgpu_ring_alloc(ring, 2);
-       if (r) {
-               DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
-               return r;
-       }
-
-       amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
-       amdgpu_ring_write(ring, 0);
+       if (adev->gfx.num_gfx_rings > 1) {
+               /* maximum supported gfx ring is 2 */
+               ring =3D &adev->gfx.gfx_ring[1];
+               r =3D amdgpu_ring_alloc(ring, 2);
+               if (r) {
+                       DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n",=
 r);
+                       return r;
+               }

-       amdgpu_ring_commit(ring);
+               amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
+               amdgpu_ring_write(ring, 0);

+               amdgpu_ring_commit(ring);
+       }
         return 0;
 }

@@ -2819,39 +2821,41 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_de=
vice *adev)
         mutex_unlock(&adev->srbm_mutex);

         /* Init gfx ring 1 for pipe 1 */
-       mutex_lock(&adev->srbm_mutex);
-       gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
-       ring =3D &adev->gfx.gfx_ring[1];
-       rb_bufsz =3D order_base_2(ring->ring_size / 8);
-       tmp =3D REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
-       tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
-       WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-       /* Initialize the ring buffer's write pointers */
-       ring->wptr =3D 0;
-       WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
-       WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
-       /* Set the wb address wether it's enabled or not */
-       rptr_addr =3D adev->wb.gpu_addr + (ring->rptr_offs * 4);
-       WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
-       WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr)=
 &
-               CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-       wptr_gpu_addr =3D adev->wb.gpu_addr + (ring->wptr_offs * 4);
-       WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
-               lower_32_bits(wptr_gpu_addr));
-       WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
-               upper_32_bits(wptr_gpu_addr));
-
-       mdelay(1);
-       WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-
-       rb_addr =3D ring->gpu_addr >> 8;
-       WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
-       WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr));
-       WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
-
-       gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
-       mutex_unlock(&adev->srbm_mutex);
-
+       if (adev->gfx.num_gfx_rings > 1) {
+               mutex_lock(&adev->srbm_mutex);
+               gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
+               /* maximum supported gfx ring is 2 */
+               ring =3D &adev->gfx.gfx_ring[1];
+               rb_bufsz =3D order_base_2(ring->ring_size / 8);
+               tmp =3D REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
+               tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz =
- 2);
+               WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
+               /* Initialize the ring buffer's write pointers */
+               ring->wptr =3D 0;
+               WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr=
));
+               WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->w=
ptr));
+               /* Set the wb address wether it's enabled or not */
+               rptr_addr =3D adev->wb.gpu_addr + (ring->rptr_offs * 4);
+               WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_=
addr));
+               WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rp=
tr_addr) &
+                            CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
+               wptr_gpu_addr =3D adev->wb.gpu_addr + (ring->wptr_offs * 4)=
;
+               WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
+                            lower_32_bits(wptr_gpu_addr));
+               WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
+                            upper_32_bits(wptr_gpu_addr));
+
+               mdelay(1);
+               WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
+
+               rb_addr =3D ring->gpu_addr >> 8;
+               WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
+               WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr=
));
+               WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
+
+               gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+               mutex_unlock(&adev->srbm_mutex);
+       }
         /* Switch to pipe 0 */
         mutex_lock(&adev->srbm_mutex);
         gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID0); @@ -3967,7 +3971,8 @=
@ static int gfx_v10_0_early_init(void *handle)  {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       adev->gfx.num_gfx_rings =3D GFX10_NUM_GFX_RINGS;
+       adev->gfx.num_gfx_rings =3D GFX10_NUM_GFX_RINGS_NV1X;
+
         adev->gfx.num_compute_rings =3D AMDGPU_MAX_COMPUTE_RINGS;

         gfx_v10_0_set_kiq_pm4_funcs(adev);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cmonk.liu=
%40amd.com%7C76b6cb68c8524e24a71a08d7be8c9b91%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637187383465069039&amp;sdata=3D5CYyoryFFaDwGEuB%2F1jyI5FuZC=
M2kM7hUKD2OuKN%2BhU%3D&amp;reserved=3D0

--_000_MN2PR12MB2957E12293081257D05165B395E70MN2PR12MB2957namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Feifei and Monk!</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Monk &lt;Monk.Li=
u@amd.com&gt;<br>
<b>Sent:</b> Monday, March 2, 2020 17:35<br>
<b>To:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yin, Tianci (Rico) &lt;Tia=
nci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freede=
sktop.org&gt;<br>
<b>Cc:</b> Long, Gang &lt;Gang.Long@amd.com&gt;; Li, Pauline &lt;Pauline.Li=
@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Gao, Likun &lt=
;Likun.Gao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Yuan,=
 Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reviewed-by: Monk Liu &lt;monk.liu@amd.com&gt;<br>
<br>
_____________________________________<br>
Monk Liu|GPU Virtualization Team |AMD<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Xu=
, Feifei<br>
Sent: Monday, March 2, 2020 5:32 PM<br>
To: Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
Cc: Long, Gang &lt;Gang.Long@amd.com&gt;; Li, Pauline &lt;Pauline.Li@amd.co=
m&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Gao, Likun &lt;Likun.=
Gao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Yuan, Xiaoji=
e &lt;Xiaojie.Yuan@amd.com&gt;<br>
Subject: RE: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
<br>
<br>
Reviewed-by: Feifei Xu &lt;Feifei.Xu@amd.com&gt;<br>
<br>
<br>
-----Original Message-----<br>
From: Tianci Yin &lt;tianci.yin@amd.com&gt; <br>
Sent: 2020=1B$BG/=1B(B3=1B$B7n=1B(B2=1B$BF|=1B(B 9:57<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@=
amd.com&gt;; Gao, Likun &lt;Likun.Gao@amd.com&gt;; Yuan, Xiaojie &lt;Xiaoji=
e.Yuan@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Li, Pauline &lt;P=
auline.Li@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
<br>
[why]<br>
CP firmware decide to skip setting the state for 3D pipe 1 for Navi1x as th=
ere is no use case.<br>
<br>
[how]<br>
Disable 3D pipe 1 on Navi1x.<br>
<br>
Change-Id: I6898bdfe31d4e7908bd9bcfa82b6a75e118e8727<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 97 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------------<br>
&nbsp;1 file changed, 51 insertions(&#43;), 46 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 760fe2ebe799..f348512eb8c3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -52,7 &#43;52,7 @@<br>
&nbsp; * 1. Primary ring<br>
&nbsp; * 2. Async ring<br>
&nbsp; */<br>
-#define GFX10_NUM_GFX_RINGS&nbsp;&nbsp;&nbsp; 2<br>
&#43;#define GFX10_NUM_GFX_RINGS_NV1X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
<br>
&nbsp;#define GFX10_MEC_HPD_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2048<br>
&nbsp;<br>
&nbsp;#define F32_CE_PROGRAM_RAM_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 65536<br>
@@ -1305,7 &#43;1305,7 @@ static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_me =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me =3D 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_queue_per_pipe =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_mec =3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_per_mec =3D 4;<br>
@@ -2711,18 &#43;2711,20 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* submit cs packet to cop=
y state 0 to next available state */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;gfx.gfx_ring[1=
];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_alloc(ring, 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;amdgpu: cp failed to lock ring (%d).\n&quot;, r)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(PACKE=
T3_CLEAR_STATE, 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.num_gfx_rings &g=
t; 1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* maximum supported gfx ring is 2 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ring =3D &amp;adev-&gt;gfx.gfx_ring[1];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_ring_alloc(ring, 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&q=
uot;amdgpu: cp failed to lock ring (%d).\n&quot;, r);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2819,39 &#43;2821,41 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgp=
u_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;srbm_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Init gfx ring 1 for pip=
e 1 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_cp_gfx_switch_pipe(adev, PI=
PE_ID1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;gfx.gfx_ring[1=
];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rb_bufsz =3D order_base_2(ring-&gt;ri=
ng_size / 8);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(0, CP_RB1_CNTL,=
 RB_BUFSZ, rb_bufsz);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNT=
L, RB_BLKSZ, rb_bufsz - 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tm=
p);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize the ring buffer's write=
 pointers */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lo=
wer_32_bits(ring-&gt;wptr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI,=
 upper_32_bits(ring-&gt;wptr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set the wb address wether it's ena=
bled or not */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rptr_addr =3D adev-&gt;wb.gpu_addr &#=
43; (ring-&gt;rptr_offs * 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADD=
R, lower_32_bits(rptr_addr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADD=
R_HI, upper_32_bits(rptr_addr) &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_gpu_addr =3D adev-&gt;wb.gpu_add=
r &#43; (ring-&gt;wptr_offs * 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL=
_ADDR_LO,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; lower_32_bits(wptr_gpu_addr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL=
_ADDR_HI,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; upper_32_bits(wptr_gpu_addr));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tm=
p);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rb_addr =3D ring-&gt;gpu_addr &gt;&gt=
; 8;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb=
_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI,=
 upper_32_bits(rb_addr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, =
1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_cp_gfx_set_doorbell(adev, r=
ing);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex=
);<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.num_gfx_rings &g=
t; 1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* maximum supported gfx ring is 2 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ring =3D &amp;adev-&gt;gfx.gfx_ring[1];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rb_bufsz =3D order_base_2(ring-&gt;ring_size / 8);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz -=
 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Initialize the ring buffer's write pointers */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ring-&gt;wptr =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring-&gt;wp=
tr));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring-&gt=
;wptr));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Set the wb address wether it's enabled or not */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rptr_addr =3D adev-&gt;wb.gpu_addr &#43; (ring-&gt;rptr_offs=
 * 4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_a=
ddr));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rpt=
r_addr) &amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; wptr_gpu_addr =3D adev-&gt;wb.gpu_addr &#43; (ring-&gt;wptr_=
offs * 4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; lower_32_bits(wptr_gpu_addr));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; upper_32_bits(wptr_gpu_addr));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mdelay(1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rb_addr =3D ring-&gt;gpu_addr &gt;&gt; 8;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr)=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v10_0_cp_gfx_set_doorbell(adev, ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Switch to pipe 0 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;s=
rbm_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_cp_gfx_switch_pi=
pe(adev, PIPE_ID0); @@ -3967,7 &#43;3971,8 @@ static int gfx_v10_0_early_in=
it(void *handle)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings =3D GFX10_=
NUM_GFX_RINGS;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings =3D GF=
X10_NUM_GFX_RINGS_NV1X;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_compute_r=
ings =3D AMDGPU_MAX_COMPUTE_RINGS;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_set_kiq_pm4_func=
s(adev);<br>
--<br>
2.17.1<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cmonk.liu%40amd.com%7C76b6cb68c8524e24a71a08d7be8c9b91%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637187383465069039&amp;amp;sdata=3D5CYyoryFF=
aDwGEuB%2F1jyI5FuZCM2kM7hUKD2OuKN%2BhU%3D&amp;amp;reserved=3D0">https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cmonk.liu%40amd.=
com%7C76b6cb68c8524e24a71a08d7be8c9b91%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637187383465069039&amp;amp;sdata=3D5CYyoryFFaDwGEuB%2F1jyI5FuZCM2k=
M7hUKD2OuKN%2BhU%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB2957E12293081257D05165B395E70MN2PR12MB2957namp_--

--===============0633593952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0633593952==--
