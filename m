Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25884C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07952073D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ueg6js5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07952073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995C96E9F5;
	Mon, 20 Jan 2020 16:41:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2436E9F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 16:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKiqggfFvKCa0wKMo6BTymQItVgYCEPAMBz35nWYLMR1ES5DBVGedOFd10fv4jqfvEeRrS9XmZwtVVDsoRu+8P9vdMCqaVRCT6R2PI6wPbM95AUXLIysy51mdmeUMMrHkAdz7GDjzn36S3t0XbOWvJ5iy2k5VipQ1jA58nL+KKWf2D+gkUiTYY0OcI9OWv6NYsUntnJDdbB0Jk7Mxf3tRcy7p8pm54j2mZ7DvlcKTBOfG+OzSZrwMtlR4xDoSorFhDcr/Fi/2hibDbdUIjZG1YLN7qkdfvX9kD91Hb/LG9b3lWK+DlQLUu1tB/pZsb652ddPZz7K0UujmTC8w4xxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jb+aDrIBic2wjtInd9zMO487vW3qGrJQjf6XSRdM8s=;
 b=KyTgqMX1RSbGhGxzvNZjSdcGcrr3LCn+3ON32wZZ2d60mUre4n4uHXlMZ24SP4rCcLUOIbY4/omJl0HtW0NoTYlzyBAeGfVj8I7tVskLqOP8/E6i4pfY2Q1eGSKdFn57PrzMFwV+havBWv9QNnJgRwJ4pjmtHt9txZdOvLpt9lL1MTER7kwtnvTgpg/QSaGpN0DLVIB8XUR19Mgl0nO+PA7N0LSFH9Y2wh5KLgipYjlJ11/uTzRs12NmBNtK4lJrHbWwqxUDUkAJ3aFEC64EQYDKsKXGOOhjWw7KSAtxX0zzsANmKR3EFA7lcWiuez7D52xCP2Bws0a57pwbtKNVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jb+aDrIBic2wjtInd9zMO487vW3qGrJQjf6XSRdM8s=;
 b=Ueg6js5dX4ly6URX7uOTmOOih8R7a111tT1dCamYso9l8gWwX6GdcFt3vjJPiaCLPTa27bK8+Ps6V5/wUhzhdMsEl+vopC0GbDqV0f+E9mHaeLd6NI1fldaVUVzZG7EWbwYvJX7QbgIPOUMcuDz/h7bKWMnf9nlFSVH7E0vCkl4=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2353.namprd12.prod.outlook.com (52.132.10.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Mon, 20 Jan 2020 16:41:10 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::2927:8ef9:d2e6:98fb]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::2927:8ef9:d2e6:98fb%3]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 16:41:10 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: Improve Vega20 XGMI TLB flush workaround
Thread-Topic: [PATCH 3/3] drm/amdgpu: Improve Vega20 XGMI TLB flush workaround
Thread-Index: AQHVzZ/7eXsbZxzKsEKesIHTN+7UAKfzxXMg
Date: Mon, 20 Jan 2020 16:41:10 +0000
Message-ID: <BL0PR12MB2580260BCEDE41E81208954580320@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
 <20200118013735.19361-3-Felix.Kuehling@amd.com>
In-Reply-To: <20200118013735.19361-3-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-20T16:41:08Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c4cff0a5-67dd-449c-8959-0000797fe45e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-20T16:41:09Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 04e5d87d-3433-4077-9ba4-000094df5ac5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35fe7e45-156f-495b-049d-08d79dc78e5e
x-ms-traffictypediagnostic: BL0PR12MB2353:|BL0PR12MB2353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2353241DD109F0F678BB024580320@BL0PR12MB2353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(81166006)(45080400002)(966005)(76116006)(55016002)(8936002)(186003)(26005)(8676002)(53546011)(2906002)(81156014)(6506007)(9686003)(478600001)(33656002)(110136005)(316002)(4326008)(86362001)(71200400001)(7696005)(5660300002)(52536014)(66946007)(66476007)(66446008)(64756008)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2353;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SyQYiYkDIn2Ed220E1t4e2ncvO47RkQjZSiiJBqndCI1bM7ZNeTXCSY90c8AEdH09iXMDW/sjH96QyQoSblLi2Wl98qoMmE+9Tm+8bjSMopicsM8KPf6BefeA0aMJU1gXt0ZpQ7ETmT2+opMv7nEnF+khaoXFJPTcPA9XDIyKUlZw3i5Dgqo0/9eoEzAhc9siHW1wBUBK+e/h6zpAMCze/VCI24vgEeYm0UpBkpugNJH3BQogaP/qQTMw7ldk8vRrsEM31k4cXnT7hPcNmameHiH3eAADw/nGV77InmetIBnDjsZ3uJM4roDwVaIdJvbSOar1O9KwKF95Sa4f06RhOq1ngWEyLp4V97BkQ3gkoUCi/q6he6Ai7RGvLbP7aDhnye87wj1LcOwa8nQj9tRlRXUoTxSLSlLakq6JmGh2e9vifrFHKJzz+sDyGw8PmBSlr2Ex/OYqCFgfHyhPh2rrpjgS9rZiwiwoRdnNoLp+TE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fe7e45-156f-495b-049d-08d79dc78e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:41:10.7234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKqDPBg5ytMW5cDhesVy9CZgdQyUQdtMECNOG8LGzklOUOikIvzmoh1DV2ETVZmB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Felix/Shaoyun,

Is this HW issue fixed on MI100?

Regards,
Oak

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
Sent: Friday, January 17, 2020 8:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Improve Vega20 XGMI TLB flush workaround

Using a heavy-weight TLB flush once is not sufficient. Concurrent memory accesses in the same TLB cache line can re-populate TLB entries from stale texture cache (TC) entries while the heavy-weight TLB flush is in progress. To fix this race condition, perform another TLB flush after the heavy-weight one, when TC is known to be clean.

Move the workaround into the low-level TLB flushing functions. This way they apply to amdgpu as well, and KIQ-based TLB flush only needs to synchronize once.

CC: shaoyun.liu@amd.com
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 68 +++++++++++++++++-----
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 8609287620ea..5325f6b455f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -647,13 +647,9 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)  int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	uint32_t flush_type = 0;
+	const uint32_t flush_type = 0;
 	bool all_hub = false;
 
-	if (adev->gmc.xgmi.num_physical_nodes &&
-		adev->asic_type == CHIP_VEGA20)
-		flush_type = 2;
-
 	if (adev->family == AMDGPU_FAMILY_AI)
 		all_hub = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..e2a5e852bdb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -476,13 +476,26 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,  {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
 	const unsigned eng = 17;
-	u32 j, inv_req, tmp;
+	u32 j, inv_req, inv_req2, tmp;
 	struct amdgpu_vmhub *hub;
 
 	BUG_ON(vmhub >= adev->num_vmhubs);
 
 	hub = &adev->vmhub[vmhub];
-	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	if (adev->gmc.xgmi.num_physical_nodes &&
+	    adev->asic_type == CHIP_VEGA20) {
+		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
+		 * heavy-weight TLB flush (type 2), which flushes
+		 * both. Due to a race condition with concurrent
+		 * memory accesses using the same TLB cache line, we
+		 * still need a second TLB flush after this.
+		 */
+		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
+		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	} else {
+		inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+		inv_req2 = 0;
+	}
 
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
@@ -521,21 +534,27 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
+	do {
+		WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
 
-	/*
-	 * Issue a dummy read to wait for the ACK register to be cleared
-	 * to avoid a false ACK due to the new fast GRBM interface.
-	 */
-	if (vmhub == AMDGPU_GFXHUB_0)
-		RREG32_NO_KIQ(hub->vm_inv_eng0_req + eng);
+		/*
+		 * Issue a dummy read to wait for the ACK register to
+		 * be cleared to avoid a false ACK due to the new fast
+		 * GRBM interface.
+		 */
+		if (vmhub == AMDGPU_GFXHUB_0)
+			RREG32_NO_KIQ(hub->vm_inv_eng0_req + eng);
 
-	for (j = 0; j < adev->usec_timeout; j++) {
-		tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack + eng);
-		if (tmp & (1 << vmid))
-			break;
-		udelay(1);
-	}
+		for (j = 0; j < adev->usec_timeout; j++) {
+			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack + eng);
+			if (tmp & (1 << vmid))
+				break;
+			udelay(1);
+		}
+
+		inv_req = inv_req2;
+		inv_req2 = 0;
+	} while (inv_req);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
@@ -577,9 +596,26 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		return -EIO;
 
 	if (ring->sched.ready) {
+		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
+		 * heavy-weight TLB flush (type 2), which flushes
+		 * both. Due to a race condition with concurrent
+		 * memory accesses using the same TLB cache line, we
+		 * still need a second TLB flush after this.
+		 */
+		bool vega20_xgmi_wa = (adev->gmc.xgmi.num_physical_nodes &&
+				       adev->asic_type == CHIP_VEGA20);
+		/* 2 dwords flush + 8 dwords fence */
+		unsigned int ndw = kiq->pmf->invalidate_tlbs_size + 8;
+
+		if (vega20_xgmi_wa)
+			ndw += kiq->pmf->invalidate_tlbs_size;
+
 		spin_lock(&adev->gfx.kiq.ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
-		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
+		amdgpu_ring_alloc(ring, ndw);
+		if (vega20_xgmi_wa)
+			kiq->pmf->kiq_invalidate_tlbs(ring,
+						      pasid, 2, all_hub);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
 		amdgpu_fence_emit_polling(ring, &seq);
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7Cb6e8fc1d4a464f9a3a5e08d79bb71b15%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637149083076774221&amp;sdata=WGOHumpie7M6weZNK3stNKGKFW2HancXQa6%2BEhZfqMo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
