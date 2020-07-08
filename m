Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 06:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655D1206E2
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 06:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="npo14pND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655D1206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BF46E0F2;
	Wed,  8 Jul 2020 06:00:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB676E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 06:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZMGRweGP5citHWanUOABhTE/gw10nlPp2gMF32EaAL6mFi3obOH4dpVElDWkx6LJWTHGLuAACW9npATPTfvRF4pNTTdb1hcJ46uMcFQGQ1dulHYScxxsY+BSpbP9Wvf3ZoMny/NnOw+HSX7+mZdE27YSCFMyoIfZb49//dSfHTDZhk94kbr89SLK4vQUZitl0fl4aZPMyV/j4D9BruwoHjB5Nt5OqYIe1cmFaVzch+9HwfTvnGf86foO2irPrsDhwDqm4AERnh38RlIP/VKBIYJ6kjIVtSM313xkxo2oSUmG24KjI2Fgyyaq2DAXJbUYrUrxNgzyeZteKPP6zszSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmNrpaSbY6VN13wouPsCR4gNSzYcTDBInwG8Cn4LAos=;
 b=LPNcdBI6oi3yVYgTZaM9GECCTEsbqEKDQo4TTzDpYCNiRv9LXzsg1HwbGrUNZ81PckaR7breXEED/9TPDgz+7OnpgDmT2WSHwGN2TBumwEe+RDuYh++zoTo94FD0mRhIhvqseMUnLrd2xODCgKONNd5gEKx3FwqEh3cItJ+iPJjHWCvuwYvlI877BO7FjyS85ugjDKeA9Q6aYzb4n+OL4N1jHDvphDu3VokXu3CVkl+FFKmskOks39uOEpuu0pfZBwqr3wofYHWpIZelvaTWey92SSkHSfYIA7YDFGEu0QWv48PdPYYetq5fMQKGwyFLwlLbyzLTa7n7OU9lT3rQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmNrpaSbY6VN13wouPsCR4gNSzYcTDBInwG8Cn4LAos=;
 b=npo14pNDHH64xIyfCeWxSWqliTutz/FWyAhxp9eswR3vU4QIvGyxLZNWICgFINlIm/vlNcL1boO6XurV/JxhKBEB22WgtTwdBBrPtuBhNiaXV9X+6BynP7kyf4nSCbnTrXZWV87KT43Ev8Cc09h/t1bpCfbekHnsi9kLwZE7gE0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1706.namprd12.prod.outlook.com (2603:10b6:3:10f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 8 Jul 2020 06:00:39 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 06:00:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [v2] drm/amdgpu: remove unnecessary logic of ASIC check
Thread-Topic: [v2] drm/amdgpu: remove unnecessary logic of ASIC check
Thread-Index: AQHWVOtiX96grpuQQE6VAt9HO1SOJaj9MD+g
Date: Wed, 8 Jul 2020 06:00:38 +0000
Message-ID: <DM6PR12MB40757879B649785103F08AFBFC670@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200708054737.3015735-1-likun.gao@amd.com>
In-Reply-To: <20200708054737.3015735-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-08T06:00:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4541be1e-d380-4ae9-b8bb-00000faa3355;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-08T06:00:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0fc8b8a6-3fe5-40ae-95e9-000064fd5026
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-08T06:00:36Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b5aad774-e5ab-453f-a4a1-00007dc446b2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62039bd2-7b25-43e6-eb1b-08d823043d77
x-ms-traffictypediagnostic: DM5PR12MB1706:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB170612C46D322EEB1DD32001FC670@DM5PR12MB1706.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4gIqV2MYKDRYvXy9W6OYAUmPVQ/5Iw6o4e0dJYVxuSViegv0vhBgnBL1zPI3oFHQzwykRcSfueBbpyFFaMuaFbXNiMXAuqT/9KYlJvrU8b4kLIA5vmm7ZxX+0jvicvyAhHR0TlrVeTgETg9AHZfxfHxs5FOltOK6+jNrhtSIjiYdR9DaCZDrQ+/jsOb5tB5QymYEBqxYrIwo2Qk97Zu9sHDbfu+xTZwn2Vo2IlnFL/CBhXnW2MsDwwb4yDQ13na8gHLNEo+73yo15HbZQ97sQ0aoUzMQWEwIBBgD+HkLZIpx8hl0X+Mc41trB9T0THr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(2906002)(7696005)(55016002)(9686003)(33656002)(5660300002)(26005)(76116006)(66476007)(52536014)(186003)(66946007)(53546011)(71200400001)(66446008)(66556008)(6506007)(64756008)(83380400001)(86362001)(478600001)(8936002)(316002)(8676002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Hw5Yl01tx9JeabHkEBNlykhPiMkQ4VDGryBiGNA3TwnTcVE7meLdiw6C30WMxtWOuYErZV8DeBBs2nMHqDfHzU6jhwZG5yl0lj/AV7LH0lr5se4w0d1mgo98dgx7vXEC+ns6OWHtoThvnTXaTkt+dT//BdzK0vDSnq1qZaJDVz9B/Bx54DL5l8Um25TwBP0jqevThSj2SSi6I+Kaungz2vMX6HngIXr38GdktMTHFRxpkT3QSrxuj51Jgg3CPPPTfrMXHoAxj5hEyE6hdPYKINeapeRHDsPOKYhwTOMeoOVcTW4DhhRkR6/+d75qLMQdRM362+QLMHfyGh2dbVzg05I4G3uY0Un1fusF9KBd5oh3VqF91UkUW4hDE5UxhadxX3rzqeHu1N1qcQuKJZdM5xLvj+++pJveciBHFy2D6lRlGDg/0RIZxmXHY0k91E2LLh8O0qtatTlGhJ3i6SgfMQ0AxKKI2n2WJRw6DzJFYzp4R8bdCGtgT4eZoa9xAzGQ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62039bd2-7b25-43e6-eb1b-08d823043d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 06:00:38.9263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAcZ3WJpI3+0hwmPC3w/RL+ckMt0bn4sZvv6eABQzUJeeNZ+5R/YGG8IS4kJywzwGMwnpRVQb9iipO7lE4Tmww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1706
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Wednesday, July 8, 2020 13:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [v2] drm/amdgpu: remove unnecessary logic of ASIC check

From: Likun Gao <Likun.Gao@amd.com>

Remove some unused ASIC check logic.
Remove some definition of amdgpu_device which only used by the removed ASIC check logic.(V2)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I5b06a51b41790b4df1078099848025851f79c320
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 -----  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 +-------  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 +---
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 82680ce51cd1..786193a38689 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7683,14 +7683,9 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,  static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				     u64 seq, unsigned flags)
 {
-	struct amdgpu_device *adev = ring->adev;
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if (adev->pdev->device == 0x50)
-		int_sel = false;
-
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ | diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1baeddf2f1e6..abb0ab653b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -485,7 +485,6 @@ static void sdma_v5_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)  static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 				      unsigned flags)
 {
-	struct amdgpu_device *adev = ring->adev;
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) | @@ -508,8 +507,7 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
@@ -887,10 +885,6 @@ static int sdma_v5_0_start(struct amdgpu_device *adev)
 		r = sdma_v5_0_load_microcode(adev);
 		if (r)
 			return r;
-
-		/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
-		if (amdgpu_emu_mode == 1 && adev->pdev->device == 0x4d)
-			msleep(1000);
 	}
 
 	/* unhalt the MEs */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4dbc11907bc6..1ef14b610a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -417,7 +417,6 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)  static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 				      unsigned flags)
 {
-	struct amdgpu_device *adev = ring->adev;
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) | @@ -440,8 +439,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
