Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C66C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A43A206E2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SDSCKvId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A43A206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123966EB6F;
	Fri, 10 Jul 2020 06:35:20 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750070.outbound.protection.outlook.com [40.107.75.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026036EB6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 06:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zpl6ZiuGY3IUJT8q6PhyooASOC0MZcowcy9qNijk4CXPeU97mYwKsKvzh8AMJbzNK+qMkEDRvF7f5RyK7KuNdEHoIvf9wSnAyKy9rAxKcCV4imnZXQnywuP/EIDMFOPECPetlFeF6dXVLHSzYOrTR9ScEuE/refgDAlKs4AD1Tp5XfkQuIGR66W5JuTHWARiS6L9C5PMMdZ/JZjA8z1NW0WZEgRlcGOcYK4xmthwtNfrJWYOJQTeHYZKrdhxcOJlVcLWlOBvqJe+ePdixXSDC3KCoUE6fkEix/fyIgTaAHYGRqLaN4av/DcrV6b8RDugSYh0DU88+sMwG76nVXcZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWAfLIhgTWpvn4nVGjqeP6m1HzC300Tbtrv7oIlHPXs=;
 b=BHVlq0s7N+S3eMapcXzNQxtUMby4AbZ6pu0SsdV9Qo26OPlMnSLyW8axX/S/bGAwOMC43WepZuvG+T+ERzybRF/LD762HAM26R2wXCxz/ag4mb0gQGSUoioDEmHdOEQnZrFJErYrHCx8tvQNffoNfuuo8CCZfyuOVS45PMx3THKtl74xLA3LiazGHsGhLiifYT7MeXND8wzeUKc0DNNNZusxo5CR22xB0sui6OwQcYeg4CzNqxcTa85DtZKioNMUQ7OHjGnfs//8nBanhlhPphUJhB5TP2+k+yBZYq7VU5yOQP4Adstf5gBJVXDPZkX3aSNeXrsBzdAmlQFkztcRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWAfLIhgTWpvn4nVGjqeP6m1HzC300Tbtrv7oIlHPXs=;
 b=SDSCKvId6ckzs4j9wsqZjyQ+aBGqx5HvW7et1plJWk3zOJAJ/lXHykz9Zr4J3XOd8Uwci3yhak5U+7aWnlUOC6sXoJIjKJ5hshJkNSnZmMgTaHDqnm5GSNwDFBOXV0r2TJn73Xuw2Xa3rxaFeL7GsdBm6HD6ArH+wMYExlNDV9I=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Fri, 10 Jul 2020 06:35:15 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 06:35:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Topic: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Index: AQHWVn1806epXjnlC0euHye63Ot9b6kAWQUQ
Date: Fri, 10 Jul 2020 06:35:15 +0000
Message-ID: <DM6PR12MB40752D83CCCC8F1891FF3115FC650@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
 <20200710054626.2487-2-Wenhui.Sheng@amd.com>
In-Reply-To: <20200710054626.2487-2-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Wenhui.Sheng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-10T06:35:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c7832111-3d76-42aa-9bd4-0000dacf5f0d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-10T06:35:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 58872961-6b8e-4b17-bd9e-0000c0cd07e1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-10T06:35:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0107e9e9-6b89-4b75-8e9c-00007eb87786
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab3ab1e6-17b5-4fc0-b12e-08d8249b6804
x-ms-traffictypediagnostic: DM6PR12MB4219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4219B7C7F68F5BD3C9C15B45FC650@DM6PR12MB4219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSwWT3+Vzvfz6D3UEinGfBdIbs/MFlla7mCf/yrmJb/3ykObr2mSRNOp3SvZLuCRkHEhKal+frNo5gYXXvgKgasxf0lHoxMrHLHl6+Ci15O+35qfUin1DSCF13dPhJuLC7l73Q2UysZEBTh+haN7NazWu9QDBfWOo3G6+Ta8CK58TojXLE60h7zwrsKfw6blmkyy0IArx4VOIgv7lETmmrF1pPQePFtxMYowKpzWnRVtEivkpB0U+QeviYox+e/P7WnhP0V4Ue9q6OdW/GNzMS81M3HjwT48QHfeFFtWnZ8wQCcywH49N6+3T9dW+KjIos7LvNTl+NP2QenfTtUhsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(64756008)(66556008)(66446008)(86362001)(8676002)(76116006)(71200400001)(53546011)(110136005)(186003)(66476007)(6506007)(66946007)(7696005)(8936002)(316002)(26005)(83380400001)(55016002)(33656002)(9686003)(52536014)(478600001)(2906002)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Fx45546fC3f74HyUsQxX38w9junsGZ8C1h/Wk4q2gzKgVYUDDBHOuZKodBh4+U4CT1HpXbHIhVWuAuj+9v1KRi1K52scfr7psUH6cqqpgHMYu3xxbiT7/J83w/tC+Zq9FY1GbUzjjPU4fC2+DdMuLkE8GOSokkN+HRDYBDrAYLBvJ1CPTuZQfhUxk/cJL6XHJ2uWivJFggB3m7bg2gdc2DLPaFeBWBESjVZ08irD8aIFd0IxQIzLzquQv74Sdf6X9IgJzsR+7PaghuOfzWaxmzOjgu4F+uTiv8uwyRWuWgRTN7I4M3znt06Nt046fotPChBHSTPzSOUUjC+cwvo7B/dR4vbmrWRsjLNreWpn1LEh5L4Abf7Yvwgzu3XYq4oEAa2zlq2T48GTp+vWegPDbY8Qc5QvHnhBzf89xZFuFQvfOZ6/QCWwQ1Op5RDKaV72rPTbJ3FzVJOM8TifKJ0LwEXNi0dDnUdT6GwlhJtQI/y9QAqGElNzJnssr3RrlRrK
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3ab1e6-17b5-4fc0-b12e-08d8249b6804
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 06:35:15.4523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/Qz5596eUKsnRRJ82aXUTq+nzrz7CiVncOOh1DM1emxvKS/DncmFi2dFJjTWHzBb3z3tvs0e07z9IDAlvbGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi @Sheng, Wenhui,

I'm thinking of hiding the MP0/MP1 mode 1 reset under AMD_RESET_METHOD_MODE1. the callback function reset is per ASIC function, where nv_asic_reset and soc15_aisc_reset serve for NV series and pre-NV series respectively.

The new mode 1 reset will be used starting from sienna_cichlid. It should be quite strait forward for us to either initialize a flag like is_smu_support_mode1 during sw_init or even check the asic_type in nv_asic_mode1_reset to decide whether we use psp_gpu_reset or smu_gpu_reset.etc.

That's saying, we don't need to change the reset_method interface, where we decide whether we go to BACO/mode reset/pci config space reset.etc. We just differentiate the approach (i.e. psp or smu) in nv_asic_mode1_reset.

Thoughts?

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Friday, July 10, 2020 13:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode

AMD_RESET_METHOD_MODE1 will be used by SMU
mode1 reset for sienna cichlid, so add
AMD_RESET_METHOD_PSP_MODE1 for psp mode1 reset.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/nv.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..0682a270c17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -580,7 +580,8 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
 	AMD_RESET_METHOD_MODE2,
-	AMD_RESET_METHOD_BACO
+	AMD_RESET_METHOD_BACO,
+	AMD_RESET_METHOD_PSP_MODE1,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fec6cf3f0c8a..565dc59a9e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2119,7 +2119,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 	 */
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_BACO:
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		return true;
 	default:
 		return false;
@@ -4174,7 +4174,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool trylock)
 	atomic_inc(&adev->gpu_reset_counter);
 	adev->in_gpu_reset = true;
 	switch (amdgpu_asic_reset_method(adev)) {
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
 		break;
 	case AMD_RESET_METHOD_MODE2:
@@ -4220,7 +4220,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 	 */
 	reset_method = amdgpu_asic_reset_method(adev);
 	if ((reset_method != AMD_RESET_METHOD_BACO) &&
-	     (reset_method != AMD_RESET_METHOD_MODE1))
+	     (reset_method != AMD_RESET_METHOD_PSP_MODE1))
 		return -EINVAL;
 
 	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 356849136d1d..1d27dd3676ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -265,7 +265,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -274,7 +274,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -310,7 +310,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int nv_asic_reset(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..86ce2f165038 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -479,7 +479,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -488,7 +488,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -559,7 +559,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	if (baco_reset)
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
