Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92326C55185
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655E32076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jf/uKf29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655E32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8D86EA1C;
	Wed, 22 Apr 2020 14:54:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA2E6EA0D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 14:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e80zSH+DheAdhJcsEJSQiWnNALHhLMKo3b/0Ilz9HsRle4TPk9iUsvEte6CPQrCG1wWKKBZSe5LwOpg1ce6ssApa4EsbeLP6QhQGiWKNSC+CN8D64hlBAB3/RI6pRcGUPmaRkq7oHIwhXtJUMwYDzsMST8aLh/ku5HaVnnxDNxSkqZxmLB2D61C15YwoxUHy0TiAX/qTKkvdnBpfOomL/47BvOpJnMRIJI0ynNhpLbR6Wb1fYlWEQyapn2lxxt43RFCxAc+psu3cMl7F/GCq72M2XQYQHdFvRVUuxclGBShdXXAZTnQJ9xZtMv8zDQY6GakESztjFqFEgAtn9O3Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNKPVxPgiT4vJW1T3X4l1+Ls1qgjxR4fNpaMiH9GAaU=;
 b=INil++9BT68mLtXJbQfWEGFO2JKjxiVuF7f8UzqCGacD2XyvVfnFXO+akCr3PcKDKmmY68UzmHyzZpb4s+JkKVY/0Mhxn1Li/ljNmVfDt6ZDJsjJVhH87kjoM++RPfGyYqbuCBC6oagyDabkJEGLGzqjcwvZ5/1H4EM61jMLBmnr6YzNCbksGjejDZ+ajgMTyKAJ+EgxIGeb2E5VlZ3F7sWMtJiOZaRNMl97Miz9K0v6sybcB8O67PWbtzm/qvO6iWcuA8YEGufJaYwguXDDpam5phIfrWRRFFWL/lBPNx5fVq56HVNmdpudP3nXuawUxQTCz5EQkXiWdA8q7Dra5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNKPVxPgiT4vJW1T3X4l1+Ls1qgjxR4fNpaMiH9GAaU=;
 b=jf/uKf29aed/vODmJdRSQLSzfgZl8IQxjKJ7xqHsi2TWgfXuvPXkWnqLEoZZSVIXc6hY2RpG/e8Zt+NsoYndSy3QRfFvc2q6aF5MTGYGpue6mR7xlTX18Lftke6YhJzQGoz9LIjZ7GTAT00TTDuzRxV0xavYaUeV1lWwQdtKNtA=
Received: from BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28)
 by BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 14:54:13 +0000
Received: from BYAPR12MB3240.namprd12.prod.outlook.com
 ([fe80::559d:610f:20d3:23bd]) by BYAPR12MB3240.namprd12.prod.outlook.com
 ([fe80::559d:610f:20d3:23bd%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 14:54:12 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect kiq overrun
Thread-Topic: [PATCH] drm/amdgpu: protect kiq overrun
Thread-Index: AQHWGLVlexbJPjDgzku1D7lh1cyg9KiFOa7g
Date: Wed, 22 Apr 2020 14:54:12 +0000
Message-ID: <BYAPR12MB324027891F92EFEE9CCF5E85F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
References: <20200422145027.2209-1-yttao@amd.com>
In-Reply-To: <20200422145027.2209-1-yttao@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-22T14:54:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9cf86d3c-3045-4ed3-b266-0000edea98c7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-22T14:54:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 15fc0cba-ba33-4b61-8e68-00004d267d9d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
x-originating-ip: [2607:fea8:3bc0:316:7809:5b9c:9bf3:2f61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5bc9891-96f2-479e-31bc-08d7e6cd0569
x-ms-traffictypediagnostic: BYAPR12MB3176:|BYAPR12MB3176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3176991AA67ED24CEA606EB7F4D20@BYAPR12MB3176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3240.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(66556008)(45080400002)(66446008)(478600001)(81156014)(4326008)(66946007)(8936002)(66476007)(6636002)(316002)(5660300002)(64756008)(52536014)(966005)(55016002)(71200400001)(8676002)(33656002)(110136005)(76116006)(54906003)(53546011)(86362001)(6506007)(7696005)(2906002)(9686003)(186003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WVa7ubXa6VXPL4WHEgYZEpCLeTYAqc3TQb0XcstVyE+faH4CoRsOKPL95hQhSf2y8zdawau5c6zMUo+QsTNRvOuq8Mh/p8b7SoZDv6E141k3pMkYKUWERdivSN2R3/7DreiM7ZcNbho1XT0784DelMcJeyowvRqNrh3W4UAwGuSmGZU2OFin9iPDtwo+B49kPbfHQbzfBSzS9QQ+Am2OKn6FP7oe00jygETCcTAiBvA5ysnUH6M8Sho0FehYONm59TLkEE4r28sqJUABombE55y+UJ0hamYLYcdp4pfx00J3bWpB+/bopZ0Ospj1ePTtr9Zerq4TUJN+IR2lfyAwSAP4cUOwkvNladzkQqyv9hHdam/CdXTN7CI7WKok+XYYZrZG+4eo5fpcu4B6Xm69NHUccGjJwHA1O0iIiCWJfMZT5FdBwaGUWmgzBodAsscB4ZJy3Ua6r3RGMmNGBR5WyNWvXedxbB8BC7UotKJ/tNw=
x-ms-exchange-antispam-messagedata: bmkcbEzFcaa6FFGqwgSNJUPbzvdPNejlYyBmnAONiFZoV0cBGX3pOX0eDNPQcYV76O3Yy8TPaeKTuQkkbA0LwXDVXiL4QyQmNeGXJR2ZjNi7Y2n/V7U7RHsNot2rxNH751+xibvcy2d40/dyJpwGR6rWmVdjvxC+O2m2dQIJNddbtDMX1nU4NCYzRovpJUNNEnUJQR9vTuMi6weh6m9GLg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bc9891-96f2-479e-31bc-08d7e6cd0569
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 14:54:12.8019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tviKkzQ75iojaWWU0M2YBAf8AMM1T+yl5IW3ftL6D1Zl1qH7f3iDL/IrsHy13dJjV1Es6BDBHA5VMxU6QrKGsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3176
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

[AMD Official Use Only - Internal Distribution Only]

I think each  kiq operation will call ring_alloc  for the package space  , why  not just check whether this allocation is succeed or not ?  

Shaoyun.liu 

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yintian Tao
Sent: Wednesday, April 22, 2020 10:50 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amdgpu: protect kiq overrun

Wait for the oldest sequence on the kiq ring to be signaled in order to make sure there will be no kiq overrun.

v2: remove unused the variable and correct
    kiq max_sub_num value

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  6 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 30 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  7 +++++
 8 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 691c89705bcd..fac8b9713dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -325,6 +325,12 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 		 mec, pipe, queue_id);
 
 	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		pr_err("critical bug! too many kiq submission\n");
+		goto out_unlock;
+	}
+
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2ac5e7..fd42c126510f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -323,6 +323,12 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 		 mec, pipe, queue_id);
 
 	spin_lock(&adev->gfx.kiq.ring_lock);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		pr_err("critical bug! too many kiq submissions\n");
+		goto out_unlock;
+	}
+
 	r = amdgpu_ring_alloc(kiq_ring, 7);
 	if (r) {
 		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a721b0e0ff69..84e66c45df37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -321,6 +321,9 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
+	else
+		kiq->max_sub_num = (ring->ring_size / 4) /
+				(ring->funcs->align_mask + 1);
 
 	return r;
 }
@@ -663,6 +666,21 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq) {
+	uint32_t seq = 0;
+	signed long r = 0;
+
+	seq = abs(kiq->ring.fence_drv.sync_seq - kiq->max_sub_num);
+	if (seq > kiq->max_sub_num) {
+		r = amdgpu_fence_wait_polling(&kiq->ring, seq,
+					      MAX_KIQ_REG_WAIT);
+		return r < 1 ? -ETIME : 0;
+	}
+
+	return 0;
+}
+
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)  {
 	signed long r, cnt = 0;
@@ -674,6 +692,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_read;
+	}
+
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		pr_err("critical bug! too many kiq readers\n"); @@ -728,6 +752,12 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	BUG_ON(!ring->funcs->emit_wreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_write;
+	}
+
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
 	amdgpu_fence_emit_polling(ring, &seq); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ee698f0246d8..1ee59a927bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -103,6 +103,7 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
+	uint32_t		max_sub_num;
 };
 
 /*
@@ -387,4 +388,6 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+
+int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c10084f44ef..4b027006d072 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -57,6 +57,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 	uint32_t seq;
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq;
+	}
+
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
 					    ref, mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5b1549f167b0..a136e2229f7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4051,6 +4051,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		goto failed_kiq_read;
+	}
+
 	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		pr_err("critical bug! too many kiq readers\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 30b75d79efdb..77d8bc9c0111 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -423,6 +423,13 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
 		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+		if (r) {
+			spin_unlock(&kiq->ring_lock);
+			DRM_ERROR("too many kiq submissions\n");
+			return -ETIME;
+		}
+
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fecdbc471983..c429a2a5fe3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -614,6 +614,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
 		spin_lock(&adev->gfx.kiq.ring_lock);
+		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
+		if (r) {
+			spin_unlock(&kiq->ring_lock);
+			DRM_ERROR("critical bug! too many kiq submissions\n");
+			return -ETIME;
+		}
+
 		/* 2 dwords flush + 8 dwords fence */
 		amdgpu_ring_alloc(ring, ndw);
 		if (vega20_xgmi_wa)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CShaoyun.Liu%40amd.com%7C0cd26307c0a149ebe0bd08d7e6cc84b1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637231638419034830&amp;sdata=rxkhyMutFwbe5Nw%2BeBGiESW9wTdflDUo%2F4xEvbCbR6U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
