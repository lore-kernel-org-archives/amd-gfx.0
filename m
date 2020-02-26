Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E099C4BA0B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 11:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662F424684
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 11:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h0m3L3iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662F424684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162446E26F;
	Wed, 26 Feb 2020 11:06:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AB76E270
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 11:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhkN1Pnh9ysMEdOwdxkyeaq/rH7Xb5BZ8S7ANN2LEY2MwlwyFmaUkWzPiZEw3qsfcMQM22cgsY8Oo5aAdMh7JuEIO5a3UBqqo3wPIfcR8TlSOiYfLPD7NiBA9e0f9tFRFc0QaG9uyOOzDCnmg/i74Z/RZrE2qHKR9W2zJPbph8Z23isPnQLRSQSL3TevfeQ2PDq3xEpHsfPqn9f8850e03d3FLz5WFwAid4TH90IY0VtfRky3y/j05hu3F5/c+YjAAip6Xbc2PdRnj+nm8qUFaqEzU0j3V/ifKbFuyE0omtxNCnFKF32t+2Q5VjIZMrWJmf06/ShNwFxFPUZ4Bo7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Svrnaa65PCr+TzuQsYPm2Ows5vkwofBwkGwDOaZJHk=;
 b=kDp1Q2aiM9J6wx5+oSOT0YU7C2Jv15SsJi/I4Xj3TOHaeAIoneAiucbZ/3yhnSEj1WY4nly9psOWuDfHRjh/J0SZoNT5accVCUJe12GkE3s4TtIrN0idU402lJS/lQTPvFfHnJZy4/OECDg5dg/9NZY6gVUjNdvlmc+uEf/Y/szi+hC/Mt3XkVDVaXpRPQ/qxFhIxNboaApGmYhIzLdITRQsCXzxIraOSonVdLCIj5KeTEC+IcDV1RGiff2HqmlvH9UWM9Cyx+J6CHyK9tlaGHlFAivvG1JES2Fd+7dWsq/QcUvqQ0UGAg3yXt7RCsexVwVpyMJE6oclkINs+6EU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Svrnaa65PCr+TzuQsYPm2Ows5vkwofBwkGwDOaZJHk=;
 b=h0m3L3iJ9qx+WyUv87YSu5Z7kx2fiZYlQj5hpRLL4o2sRrFJnCWfFbYTjqFSVlkm+XOf/eS7t/iVXFNAPiqQJUiu9QjUPPCneajVKNZ3Rr+yb6HJ4O6WtKhx3AEqqxUbZ46FIHoGhFiB7x1FsDj01x/h+hpRTUq5HhH8+edARgE=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3678.namprd12.prod.outlook.com (2603:10b6:208:158::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 11:06:09 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::4905:91cf:ae95:6ffb%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 11:06:08 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Thread-Topic: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Thread-Index: AQHV7F4HsBD07ppbakS1HSBpZKouM6gtUKLg
Date: Wed, 26 Feb 2020 11:06:08 +0000
Message-ID: <MN2PR12MB3933591B1646ADFD4F962B0584EA0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1582691649-4876-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1582691649-4876-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a8922e8-f42f-40ee-4501-08d7baabe1f9
x-ms-traffictypediagnostic: MN2PR12MB3678:|MN2PR12MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB367881AD4270682D0B0E444D84EA0@MN2PR12MB3678.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(53546011)(6506007)(45080400002)(110136005)(71200400001)(8936002)(86362001)(81156014)(478600001)(8676002)(81166006)(7696005)(4326008)(52536014)(66946007)(66556008)(9686003)(76116006)(66446008)(55016002)(33656002)(316002)(2906002)(966005)(64756008)(5660300002)(66476007)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3678;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxIFmPVOV2TucHy1twGsW1XEFIfuzKhVw2gKi+v2MYqdiXOeEkkHxPwDeACiNRHBmc9DhYj/iJeHxR7OBhx63v0rVtQTx6PrW3GghfoaDR+E3y6pcfSSxIcpwp8n8885JY14OYv80fX9kZQpQDMGc/oN8flUkXBtuoSrhDg7Gg2XtutZXcxroWJ84m6zCzZjMVzTtZ3hWc46z2u5OUeFpJadfHRt9AwX7nMm8zzjDqjz72T0aTlOGEOP0SLL6Fm7kO4Vto2dhNaVXDYfOaX9/DlyTFQHJ9VcBKmPyk+QxNVRT9fnKWHsWpUzguDPoJboYfkOCpX2pRXvZMDAMP7Be44kmlopQ1NWLbnMbRUzt2OXVnlovuEqbKVV4QmP1UuZ5ZL/Rp+hyHermHcMoziMoz0UIGKrXH0XFTV1Y53GUi0LOt3zqZyFA6i/OZ6d6P/hRJaMcxbRxY6ZZSig54T95LDG2ZPOHZq0Q1XSq9/Ffhf7pZszTI8QZI+DkWulWyv4IPpfaWT3yp8BWT+vRWvKrA==
x-ms-exchange-antispam-messagedata: 43EwOCCXSYVqWaDGYHgLoB36VY0mLSfsMWpNTSFJX8BGBVr8JkYCbTYMXQAOJjUKCRkrq1DPpiV93uppE/XGK0ThtmXQjGI7GvT2CLykIJf4BQ81QRT1zK6418dxzmf/2Z3ZzG2bL5l9qQ+rj5/mtQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8922e8-f42f-40ee-4501-08d7baabe1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 11:06:08.8298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2d7+amUcZQwVd3n3beCfYTcXt5R+He4zJxnFYd0K7Hdo2YjRjruWKj1c5InSwV7A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3678
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Wednesday, February 26, 2020 12:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock

For vega10 sriov, the register is blocked, use copy data command to fix the issue.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 68 +++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1c7a16b..71df0d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3963,6 +3963,63 @@ static int gfx_v9_0_soft_reset(void *handle)
 	return 0;
 }
 
+static uint64_t amdgpu_kiq_read_clock(struct amdgpu_device *adev) {
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_rreg);
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
+	amdgpu_ring_write(ring, 9 |	/* src: register*/
+				(5 << 8) |	/* dst: memory */
+				(1 << 16) |	/* count sel */
+				(1 << 20));	/* write confirm */
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
+				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
+				kiq->reg_val_offs * 4));
+	amdgpu_fence_emit_polling(ring, &seq);
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+		goto failed_kiq_read;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_read;
+
+	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
+		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
+
+failed_kiq_read:
+	pr_err("failed to read gpu clock\n");
+	return ~0;
+}
+
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)  {
 	uint64_t clock;
@@ -3970,16 +4027,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	if (adev->asic_type == CHIP_VEGA10 && amdgpu_sriov_runtime(adev)) {
-		uint32_t tmp, lsb, msb, i = 0;
-		do {
-			if (i != 0)
-				udelay(1);
-			tmp = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
-			lsb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_LSB);
-			msb = RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
-			i++;
-		} while (unlikely(tmp != msb) && (i < adev->usec_timeout));
-		clock = (uint64_t)lsb | ((uint64_t)msb << 32ULL);
+		clock = amdgpu_kiq_read_clock(adev);
 	} else {
 		WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
 		clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C7abf207a7f1e4eb2d94908d7ba7526c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637182884675110117&amp;sdata=ApOBTmtTF3WtSh8%2BLqp1EsivkfCAK4ft1GfXVm%2Fok3I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
