Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A9EC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA4D221E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4FZSh4mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA4D221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186B66E3AA;
	Fri, 17 Apr 2020 07:01:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94D36E3AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 07:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFFVd84c6ZmxquVcn7KInsJ5OVMaiAv1OYyaTc0nPXgDmgpaxY8n825M7+jnTDkU6vSYVga0TckhBBsm8yZprGD8YcBsmEeE0GuprMo+dPNt5+KfKbD4XaSk1s1wWeONmHG8R9rdsSXNq0346aD+fg/t3Ku1AKe3wq58GOAVXQ5O5Pede5Z7MbmRxAkALkcxrEGK4+TbuPFHy/psSj6BjDhn2b+QvE0RqLaCjKTDmotJOouDZ8Zz98auKAtz94Ab50pTtyxV9nV3zgA+fCrl3+I36UAL1SbBYhxlmZtUS1Dg748033SZAdkFgcibMtzTIVpbsopojRxKultob5U+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6yHKZA/bUE1sTZXCMGy+ksLz7YoipsPtqu8eZ2ej5w=;
 b=Z8XfB5k0FyiZSXZKoXqsJeRZVJPZHLt3gn8nEeO7btgcQ+jWXXK9HuhTPidOnOa0q/L+6bPE/vHAnqikHwjkhHPN3Yf76Jx0T9ErXuyPbdcGAP1tKGdjePNI+hJ+zG0krBYKEeoS5wxkXXhDoWIZntCtouUlWwYYkWbvmaZyXaDh1qGoy1jqXjVsGqSum/xYfdfdPJoH5SbMTk4bM2jFws0soeJ+cOoFGzWxyfus4JscOfN+9oxjV3RSIjqT0Zaq+dsUSaZ0lVLwh2BZzynK9ENQwxFZLkTOzeDx8hnDjZGyhW0k+p0rr5R32KvU4l160WALEtDRyyZf8tKWBhjvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6yHKZA/bUE1sTZXCMGy+ksLz7YoipsPtqu8eZ2ej5w=;
 b=4FZSh4mk69jtLyBEH0a5Uon1ZuZPNktEGDicneHTyFgF/0uZGpWAHPDzDNUZbEMYuiVyte8T8/T+iYjXOV0Y59IhpdJlK0PK+P1EvH5T2VmI3Mb7BZ7zyTcvQczc95yNl5pTw+qj2QXSlQ27hfONRiwiffXl78mNDl0INJ+Dfvg=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1673.namprd12.prod.outlook.com (2603:10b6:4:e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Fri, 17 Apr 2020 07:01:23 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 07:01:23 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine kiq read register
Thread-Topic: [PATCH] drm/amdgpu: refine kiq read register
Thread-Index: AQHWFITfuUsBKum0lUeua8U6BgyKnKh84n1w
Date: Fri, 17 Apr 2020 07:01:23 +0000
Message-ID: <DM5PR12MB1708AB26054FA715829B65A684D90@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200417065310.21108-1-yttao@amd.com>
In-Reply-To: <20200417065310.21108-1-yttao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Hawking.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [101.87.149.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af0567e8-1fcf-4005-9867-08d7e29d23e3
x-ms-traffictypediagnostic: DM5PR12MB1673:|DM5PR12MB1673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16738F4D6F93182CA2B696CE84D90@DM5PR12MB1673.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(7696005)(5660300002)(66446008)(110136005)(66476007)(8936002)(66556008)(186003)(54906003)(8676002)(76116006)(478600001)(86362001)(6506007)(2906002)(71200400001)(53546011)(4326008)(66946007)(316002)(64756008)(30864003)(26005)(81156014)(55016002)(6636002)(33656002)(52536014)(9686003)(921003)(1121003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHW+3oAF28at/fkuSLKJO5ppXhi/7HjVrApp3oYXten7+fEX/RG/ggFPS6BC8K6qy6Ep4Ep2HrZDF6t5KutW0SA12GirzovbXa2VHby8yIfEYR+fQeGRLAjreafeLSllAKGceOZQuyzwaXL+XvD0PAk9AKCsemb34JSpzzQhz9l0rK1ebgKuRZ60hyKnoetlB0nPW028vzGuL7xwtHxJ0up+3E9EPg/ZmC9YJCm0npfBqm2Oejr+iVlfaM1fEEyX4OsrXWvcsDWaz3TMYEyd0mJ0YoJXJtBGM0+4wsZ3niIJtdLNlWNs2AkXrYbsJwRSuSA6bnyForonJkCzZ/5dG0zMbl4OBhQaEJ4zyQHfFh4EZgP/Pwy7npk1qATiUihR55rg7iuuIM1nqMQdQauv6Tla0r6qEQng83T1tUQLmfa20L/vbflN3BPyzu7VwUxCZPMT9N7KYQbfe/ROPtm8ioBoi0NRSCiUumzx19P+a/PrJaIfhfWv08KzfUT5KUp+
x-ms-exchange-antispam-messagedata: kcCxf1Lr9W6xorcmhokWjXZwO97iyLpaXzc0L4SY5kzqQjyeUaOND4mHnd90ihW81tJjemOKwXsAEbGcJRVSjBUcAJOJSAId9Y5jZKZ8wfUHUyUhtsakex2NwZSxR7FJu3p4i5eQE0xGvrud/eDkXA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0567e8-1fcf-4005-9867-08d7e29d23e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 07:01:23.4666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2d0jwIGNzikWzvNvNjxndeQ+eEhRCU/bha1Q1wgnzlCFNtuOPlwbFufJ3zEmONp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The change Looks good with me, you can put my RB to your patch .

Since this patch impact on general logic (not SRIOV only) I would like you wait a little longer for @Kuehling, Felix and @Deucher, Alexander and @Koenig, Christian  @Zhang, Hawking 

If any of them gave you a RB I think we can go this way 

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Yintian Tao <yttao@amd.com> 
Sent: Friday, April 17, 2020 2:53 PM
To: Liu, Monk <Monk.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amdgpu: refine kiq read register

According to the current kiq read register method, there will be race condition when using KIQ to read register if multiple clients want to read at same time just like the expample below:
1. client-A start to read REG-0 throguh KIQ 2. client-A poll the seqno-0 3. client-B start to read REG-1 through KIQ 4. client-B poll the seqno-1 5. the kiq complete these two read operation 6. client-A to read the register at the wb buffer and
   get REG-1 value

Therefore, directly make kiq write the register value at the ring buffer then there will be no race condition for the wb buffer.

v2: supply the read_clock and move the reg_val_offs back

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 11 ++++------  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 -  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 14 +++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 +++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 28 ++++++++++++------------
 6 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ea576b4260a4..4e1c0239e561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -304,10 +304,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 	spin_lock_init(&kiq->ring_lock);
 
-	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
-	if (r)
-		return r;
-
 	ring->adev = NULL;
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
@@ -331,7 +327,6 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)  {
-	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
 	amdgpu_ring_fini(ring);
 }
 
@@ -675,12 +670,14 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	uint32_t seq;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
+	uint64_t reg_val_offs = 0;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_rreg(ring, reg);
+	reg_val_offs = (ring->wptr & ring->buf_mask) + 30;
+	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags); @@ -707,7 +704,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return adev->wb.wb[kiq->reg_val_offs];
+	return ring->ring[reg_val_offs];
 
 failed_kiq_read:
 	pr_err("failed to read reg:%x\n", reg); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 634746829024..ee698f0246d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -103,7 +103,6 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
-	uint32_t			reg_val_offs;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f61664ee4940..a3d88f2aa9f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -181,7 +181,8 @@ struct amdgpu_ring_funcs {
 	void (*end_use)(struct amdgpu_ring *ring);
 	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
 	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
-	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
+	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
+			  uint64_t reg_val_offs);
 	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 	void (*emit_reg_wait)(struct amdgpu_ring *ring, uint32_t reg,
 			      uint32_t val, uint32_t mask);
@@ -265,7 +266,7 @@ struct amdgpu_ring {  #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))  #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
 #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d)) -#define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
+#define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), 
+(o))
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))  #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))  #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m)) diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0a03e2ad5d95..7c9a5e440509 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7594,21 +7594,19 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
 	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));  }
 
-static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				     uint64_t reg_val_offs)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 }
 
 static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc6c2f2bc76c..8e7eee7838e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6383,21 +6383,19 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size >> 2) - offset + cur;  }
 
-static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint64_t reg_val_offs)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 }
 
 static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 84fcf842316d..ff279b1f5c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4046,11 +4046,13 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	uint32_t seq;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
+	uint64_t reg_val_offs = 0;
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
+	reg_val_offs = (ring->wptr & ring->buf_mask) + 30;
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 9 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
@@ -4058,10 +4060,10 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 	amdgpu_fence_emit_polling(ring, &seq);
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags); @@ -4088,8 +4090,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	if (cnt > MAX_KIQ_REG_TRY)
 		goto failed_kiq_read;
 
-	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
-		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
+	return (uint64_t)ring->ring[reg_val_offs] |
+		(uint64_t)ring->ring[reg_val_offs + 1 ] << 32ULL;
 
 failed_kiq_read:
 	pr_err("failed to read gpu clock\n");
@@ -5482,21 +5484,19 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
 		ring->ring[offset] = (ring->ring_size>>2) - offset + cur;  }
 
-static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
+static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				    uint64_t reg_val_offs)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr +
+					      reg_val_offs * 4));
 }
 
 static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
