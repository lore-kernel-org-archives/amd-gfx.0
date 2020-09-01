Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A2C433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 08:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD25205CB
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 08:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p5NBJfiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD25205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8266E484;
	Tue,  1 Sep 2020 08:50:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7666E41B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 08:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ8TYivNLx3A8r4xcc5n+GaV3LI/k4a2YB8p9UyWyKWvCgJA3RAuhecBQl5sC+RyyBtHs8Z9rR4FOrdgme6y/z/OCT5q+aMxFtgDPhoQYNUsoVmz1z3v7xPIv7gkfhEdJpFlqdk2DGX6KmS7xqdrFAxmYhnynAQFUBID66B7+J4XAPPV9ZDRveOFkNUbrLhoSxDdqZiBAZHv1Pl5WOhWx0riWUjaNAn5ljSNFtnNPz1kD5WfaKtMGt7V/M4rZGbWulVrUAHkC/tHb3QqN3cLoKPtXqGiAedF1nIZSqJF4SD7sK4xfvItsrF0mAIfMnhre7YiWm2OdnIttjQr/s0/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u7J+dRa2UC0TlUh347/io0ywCakD7UPzNWPnnV3Anw=;
 b=G30sl+Q6UJM57sjuDIsjuytWD0lZ/aL3e0TcWGU6PLq/r/ynjiMoprMSssR747a1/JhpwNvEaT5ZDu7faVPqhnoeSTYJ3H7cb7H8IKC1W66S7TGF2VZSO1y09KkogZ/Gfr0JMBAksP5eWKj1mGOplA738xne1cZHB/zgfX7wfJ45GUkcX3Lsg6/OgdlypVfZdIewYVEK9xjZ9ciWejDJDYTpTgpw0KSvoEp1YarbwJIOBp5lRb7L1Dns0DCeaUkDG8srSNHHczFL4wKdj37bEGfVIACvsyugUSQfk8JN1it9+8aDkWk6OcQCBDqRaWC9g6AR29ZxGfZKvTtRT/ZCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u7J+dRa2UC0TlUh347/io0ywCakD7UPzNWPnnV3Anw=;
 b=p5NBJfiYMX3gaeAnHbdTHSSQm/RpQ9KAL+lyaqVC7g987ssvJhGeCQiWOXbXlPgJjRYko95wIGvh+VwSZW/GRX1I9bjBA5d9it/tOFOxMgkSUo0S/tYwgWx3UEvHd3w7XMBMJwAzsFbGeA3SywlCP5pRHRXGiDaicZ2QhHHwbM0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.24; Tue, 1 Sep 2020 08:49:55 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 08:49:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: block ring buffer access during GPU
 recovery
Thread-Topic: [PATCH v2] drm/amdgpu: block ring buffer access during GPU
 recovery
Thread-Index: AQHWgDSXE1KuwT00AkaGJ+uqI3Oip6lTeTGg
Date: Tue, 1 Sep 2020 08:49:55 +0000
Message-ID: <DM6PR12MB4075482C48FCBBB7C119C71BFC2E0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200901075029.23502-1-Dennis.Li@amd.com>
In-Reply-To: <20200901075029.23502-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-01T08:49:52Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9937768e-43f8-4fd5-af64-00000918663a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-01T08:49:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2dc12650-5d6f-4866-ace5-0000fefac438
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-01T08:49:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3af53ad4-e0c7-4b38-bdaa-000047bbb958
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d341c9b-99d6-49a4-5640-08d84e540014
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB317927FF3E869AFA29A3C3FBFC2E0@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxC4miJvFtHANpLww6eHbTJfwqk42H6ouVKTiQRLtgoFvOBITvQ+TFMkIpl6sPsO2rJSuG1OHv2+k3O+V1adoKfA+VYlIi/nlktf/YKduyVZkn2n/4PAantarGkOAdpc1mkfZhWMkyfM6s8UcKFOhHGODb2KVdBTIs4/iUTrbegtdzBRwir3k6ueHXzU14pkWQiGTFsyD11U8NCRVz6ih7fHxdRsF1A+H+LF4qkzq2Ri3urtqBwBrcwTzp3PRfI5qQllEyBGfVkMJAyGMhVM9tfVLC17GFPTyCE3xEXtugRPy+gnL6yeOThFG4gp/ZKbzj+rlhFy84xjQVmhKZkAeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(4326008)(52536014)(316002)(55016002)(186003)(33656002)(66446008)(64756008)(66556008)(83380400001)(2906002)(478600001)(110136005)(86362001)(6636002)(66476007)(66946007)(76116006)(53546011)(8676002)(8936002)(71200400001)(5660300002)(7696005)(9686003)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: G3Fa1PQIjezDBeEFTd527mw7NLTiBVVHPirZGn18juw8tz0giCNWuhGQvyyUKMabsQ7yCPSHDE4p2H7Bbz1O/uDccjdQylbUXq8///Aqu/Gda/QMeqEBntyBvhxXKy3SK6REVOWKRXztHVqvd2erPgPROnY2nIH8m0xzBQ9v4AGnbAEoV3cb+r1k+fovCdA2j3h0fH3AgRVUE/fB2Mqbf4kNPVUzfiLLJP9bvmOkolduo5JziXc3AP9S3cYEJUHIvw84D5JNbhg24P2SGGdZnYqCtf9imIgBpwYgvh1Bjb5UL7KGGzFGHo98pvQUNmZjCodZyIGyHpelwgGjClEFzWZFj+loTFCC6N3aUcQpOARYtm/0u9toHvbc53HRkZqD7KO7nm6LrUixVBat56i4ozI3PmoUuk8LwzEtRE3F56PDnlQMEfWCyH8X7MltEDUAbhUQtuAWdpy4P3RcKud3A2u1ekX2aRiK3t8a5RIzf1fjqjG7HEM49ZkFj7bYz8HF67ieR+D+t/5MfIqmCTDS+ErCsPWsNUa+mMtUOM+VMok41DECg7rXhSvQTkiVhPJKZ32YjEfl48sxCEMogQZTnOlL6pXviwh44AMvtP5e0bGpQM3oMlWgc1QmvG+YYbVYX+iZm9huGCrzV3XJW9quIA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d341c9b-99d6-49a4-5640-08d84e540014
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 08:49:55.7860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCaynHROMTWbXQ3wvkvw5J8m+qljL9+/M7Oksfa+q9z5XIDIZzdunp4UNFs1nJ3GYgOIKaNmGO1/7671ML+c6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Tuesday, September 1, 2020 15:50
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: block ring buffer access during GPU recovery

When GPU is in reset, its status isn't stable and ring buffer also need be reset when resuming. Therefore driver should protect GPU recovery thread from ring buffer accessed by other threads. Otherwise GPU will randomly hang during recovery.

v2: correct indent

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 172dc47b7f39..9b586bc80c38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,8 +319,12 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,  {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_kiq_rreg(adev, reg);
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
+	    down_read_trylock(&adev->reset_sem)) {
+		ret = amdgpu_kiq_rreg(adev, reg);
+		up_read(&adev->reset_sem);
+		return ret;
+	}
 
 	if ((reg * 4) < adev->rmmio_size)
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4)); @@ -332,6 +336,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
 		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
 	}
+
 	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
 	return ret;
 }
@@ -407,8 +412,12 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
-		return amdgpu_kiq_wreg(adev, reg, v);
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
+	    down_read_trylock(&adev->reset_sem)) {
+		amdgpu_kiq_wreg(adev, reg, v);
+		up_read(&adev->reset_sem);
+		return;
+	}
 
 	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);  } diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ad9ad622ccce..31359e519d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -287,8 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    !amdgpu_in_reset(adev)) {
-
+	    down_read_trylock(&adev->reset_sem)) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type); @@ -297,6 +296,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 				1 << vmid);
+
+		up_read(&adev->reset_sem);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e1a0ae327cf5..c602ddc68384 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -500,13 +500,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * as GFXOFF under bare metal
 	 */
 	if (adev->gfx.kiq.ring.sched.ready &&
-			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-			!amdgpu_in_reset(adev)) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
+	    down_read_trylock(&adev->reset_sem)) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
+		up_read(&adev->reset_sem);
 		return;
 	}
 
@@ -599,7 +600,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	if (ring->sched.ready) {
+	if (ring->sched.ready && down_read_trylock(&adev->reset_sem)) {
 		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
 		 * heavy-weight TLB flush (type 2), which flushes
 		 * both. Due to a race condition with concurrent @@ -626,6 +627,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (r) {
 			amdgpu_ring_undo(ring);
 			spin_unlock(&adev->gfx.kiq.ring_lock);
+			up_read(&adev->reset_sem);
 			return -ETIME;
 		}
 
@@ -634,9 +636,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
+			up_read(&adev->reset_sem);
 			return -ETIME;
 		}
-
+		up_read(&adev->reset_sem);
 		return 0;
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
