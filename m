Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD01BC32771
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 02:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0F3222C3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 02:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zv0bA9LD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0F3222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C054E6EBB7;
	Thu, 16 Jan 2020 02:30:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448A66EBB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 02:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BERXkXpACECTpM0mUqW8U6fbBZ30z220UtpARaNiDydUfqBFn1niokQa61Qp/8t8Z/bpy70+AxdV2kDLv6kJl+cSjlIR4Rjzh93uWFo8z9vF1C4IBDWRBZ5shoTFcddMHjhYc2vcCm3puDJ/fePJc+/dVjoIIKoiU/eCuJ8OYUt002ZwhJJ7ya9CJEYZUP5C/MoDIKSAM10Q4uET8NsfC902+Vof7DgxNvmrzatTtRsMkM4dEMlpaySDtbORLsAhtdxpO8Y5kgJ6KY93pXa1pSh/uSVdb7ADlQQOP5aeZB6DjkzFTTNZrejoXCLDB1mTG2g/MRbmOYKjuRidMdY5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=785bYdi67xk3aCFZd6EWvYvq7OD3z6ACDssayAzb0kY=;
 b=PIgeMEww4dv0Okv9py6UGdyOAoKkccIWvvm5uyC5qc+q1wIyBnmxfnTs6+kDIwEPN/l+2E+cKrRKg/bM0ibzAhlvlHYc0nNwCEnUSrBIwLXqvLLQsVxVGY2SCmQjuc0rk/NW3xQH9VonnBoEKKeHKgZlJXIrwEqBa7K4Hh7HIK6/NfZMpGWhutdqHLhIJOTU4qh7aWcE9CpF3ZWd6EP7ltOJ8n1BFosV65GxHeSSqvnQ8hv5lB7R2bZabkNx3Sdy0XZdDGJIWcnov4QL92XRtXBpZ98OXggRBtoxD5SxtSugBn7HFUgn95bmrjlO8rJtgg8zg2JfSuEdq/NJlcumCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=785bYdi67xk3aCFZd6EWvYvq7OD3z6ACDssayAzb0kY=;
 b=Zv0bA9LDc5fWZQokKn3md7RXGE5tWXzom33y6QIRFfVLWNCy1VcdKVkbiF98WwYAH3efTA9qdJHVnc9+KzqNGpTC6pMqqg8skuxnebxU/nnNipPqOKuvl0QK1NuUEAdRBBAI/1YCs4xkNFOtMTpZXD+i2DZUYw17OwE/q/MXH2g=
Received: from MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) by
 MN2PR12MB3821.namprd12.prod.outlook.com (10.255.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 02:30:34 +0000
Received: from MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19]) by MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19%7]) with mapi id 15.20.2623.015; Thu, 16 Jan 2020
 02:30:34 +0000
From: "Gong, Curry" <Curry.Gong@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: provide a generic function interface for
 reading register by KIQ
Thread-Topic: [PATCH 1/3] drm/amdgpu: provide a generic function interface for
 reading register by KIQ
Thread-Index: AQHVy4f5TIICcnml/k+mfG1v5PgNa6fskqoA
Date: Thu, 16 Jan 2020 02:30:34 +0000
Message-ID: <MN2PR12MB3069CBA7B3A2DC0FD6A365689D360@MN2PR12MB3069.namprd12.prod.outlook.com>
References: <1579081282-659-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1579081282-659-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-16T02:30:32Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=baac3b84-a0e4-45ee-9a55-000028ce5b7d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-16T02:30:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 351f24fe-8e94-4de8-9e1a-00006bfb737c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Curry.Gong@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08026b3d-de7b-47b9-2e42-08d79a2c10c2
x-ms-traffictypediagnostic: MN2PR12MB3821:|MN2PR12MB3821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38214596B5E05A5124055F8A9D360@MN2PR12MB3821.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:72;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(189003)(199004)(5660300002)(478600001)(66946007)(66476007)(55016002)(66556008)(316002)(26005)(52536014)(66446008)(71200400001)(76116006)(33656002)(2906002)(9686003)(64756008)(81156014)(30864003)(186003)(8676002)(110136005)(8936002)(6506007)(53546011)(81166006)(86362001)(7696005)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3821;
 H:MN2PR12MB3069.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAa1fkGaF2YOJg/T+AwoEoIbxXsxYhLTShOP4xWjyV6ZwUYe4TjU+7XwLEcNQ6SVwNoCcV3VDbFnr04IDD4PIOCdcZpzfJa6sMkKrDqFdYfkhtdZBzhgQOaFDvEZtqL03ehfOxaaq8Iqzi0aW+55ui509tixz6p/0zfYRwEdxGhahsFu8kC/BB5YtUhOB+oohOItyFc2zbIZckXTIA6G0HUihTn5vFeflW26Xgj+bn2V4Jv+kd7LErhqTApVXg/6jqNq9LdinirqEr5KTCkReF+cr6W14Sic9qAGOmT4vWsu8zV53OvApNDBcznE+yY2WuscrAnP2gUnMDH44iz84t0y09QulLDPTgGesaG6FUNxLRbnj9Tt/JzsLWowF1EDdCSihOqZm63Af0SniqwJ2YadbBQCSC0LSky5gcL+Exu4YpUtM5AmT4EPmJFFxjwC63FwOW/ptS40hyX153h5yRUp6yF85gjX0MbOSHnBzkEM5FspZLcyLkea3YpVuw78
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08026b3d-de7b-47b9-2e42-08d79a2c10c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:30:34.4355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MOG4MqboaQjm734B/uVCvTqY0DyO57DgNak6LsAH75MlUpl7Vz29cnHUgC7/umu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
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

[AMD Official Use Only - Internal Distribution Only]

Ping

-----Original Message-----
From: chen gong <curry.gong@amd.com> 
Sent: Wednesday, January 15, 2020 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gong, Curry <Curry.Gong@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: provide a generic function interface for reading register by KIQ

Move amdgpu_virt_kiq_rreg/amdgpu_virt_kiq_wreg function to amdgpu_gfx.c, and rename them to amdgpu_kiq_rreg/amdgpu_kiq_wreg.Make it generic and flexible.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 96 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 92 ----------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  5 +-
 8 files changed, 108 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2c64d2a..963ea46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -218,7 +218,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 	uint32_t ret;
 
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_virt_kiq_rreg(adev, reg);
+		return amdgpu_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4)); @@ -296,7 +296,7 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 	}
 
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_virt_kiq_wreg(adev, reg, v);
+		return amdgpu_kiq_wreg(adev, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4)); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b88b8b8..0f960b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -296,7 +296,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 	spin_lock_init(&kiq->ring_lock);
 
-	r = amdgpu_device_wb_get(adev, &adev->virt.reg_val_offs);
+	r = amdgpu_device_wb_get(adev, &kiq->reg_val_offs);
 	if (r)
 		return r;
 
@@ -321,7 +321,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 
 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)  {
-	amdgpu_device_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
+	amdgpu_device_wb_free(ring->adev, ring->adev->gfx.kiq.reg_val_offs);
 	amdgpu_ring_fini(ring);
 }
 
@@ -658,3 +658,95 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
 	return 0;
 }
+
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg) {
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
+	amdgpu_ring_emit_rreg(ring, reg);
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
+	return adev->wb.wb[kiq->reg_val_offs];
+
+failed_kiq_read:
+	pr_err("failed to read reg:%x\n", reg);
+	return ~0;
+}
+
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t 
+v) {
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_wreg);
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_emit_wreg(ring, reg, v);
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
+		goto failed_kiq_write;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_write;
+
+	return;
+
+failed_kiq_write:
+	pr_err("failed to write reg:%x\n", reg); }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index af4bd27..ca17ffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -94,6 +94,7 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
+	uint32_t			reg_val_offs;
 };
 
 /*
@@ -375,4 +376,6 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,  int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry);
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg); 
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t 
+v);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 103033f..adc813c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -45,98 +45,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	adev->pg_flags = 0;
 }
 
-uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg) -{
-	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *ring = &kiq->ring;
-
-	BUG_ON(!ring->funcs->emit_rreg);
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_rreg(ring, reg);
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-	/* don't wait anymore for gpu reset case because this way may
-	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
-	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
-	 * never return if we keep waiting in virt_kiq_rreg, which cause
-	 * gpu_recover() hang there.
-	 *
-	 * also don't wait anymore for IRQ context
-	 * */
-	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
-		goto failed_kiq_read;
-
-	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
-		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-	}
-
-	if (cnt > MAX_KIQ_REG_TRY)
-		goto failed_kiq_read;
-
-	return adev->wb.wb[adev->virt.reg_val_offs];
-
-failed_kiq_read:
-	pr_err("failed to read reg:%x\n", reg);
-	return ~0;
-}
-
-void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v) -{
-	signed long r, cnt = 0;
-	unsigned long flags;
-	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
-	struct amdgpu_ring *ring = &kiq->ring;
-
-	BUG_ON(!ring->funcs->emit_wreg);
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
-	amdgpu_ring_emit_wreg(ring, reg, v);
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-	/* don't wait anymore for gpu reset case because this way may
-	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
-	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
-	 * never return if we keep waiting in virt_kiq_rreg, which cause
-	 * gpu_recover() hang there.
-	 *
-	 * also don't wait anymore for IRQ context
-	 * */
-	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
-		goto failed_kiq_write;
-
-	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
-
-		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-	}
-
-	if (cnt > MAX_KIQ_REG_TRY)
-		goto failed_kiq_write;
-
-	return;
-
-failed_kiq_write:
-	pr_err("failed to write reg:%x\n", reg);
-}
-
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 4d1ac76..daaf909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -287,8 +287,6 @@ static inline bool is_virtual_machine(void)
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);  void amdgpu_virt_init_setting(struct amdgpu_device *adev); -uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg); -void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);  void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t rreg1,
 					uint32_t ref, uint32_t mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d72b60f..353ecef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4743,6 +4743,7 @@ static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,  static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)  {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -4751,9 +4752,9 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 }
 
 static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8b9f440..d6dd8a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6447,6 +6447,7 @@ static void gfx_v8_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne  static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)  {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -6455,9 +6456,9 @@ static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 }
 
 static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 44cdb6f..425762a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5218,6 +5218,7 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne  static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)  {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -5226,9 +5227,9 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				adev->virt.reg_val_offs * 4));
+				kiq->reg_val_offs * 4));
 }
 
 static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
