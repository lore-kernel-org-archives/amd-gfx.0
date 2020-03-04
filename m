Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9CC3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 07:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC1A207FD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 07:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rKk5r1LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC1A207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4759D89D8E;
	Wed,  4 Mar 2020 07:40:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D94089D8E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 07:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf0ri0OS4A4Bk4T9C9pj795zc4eXf70qGIMEmghYJeR4TlKyVD+gNf8wSwuEqSK4d+sHk8BNyhPc3Au/cAPQFUMORQGh0R+pu9MsxwRxTFQi5uVoAVqG/VqFExXipZdFi+2v5g/T/AMHkLhzeJQlmqcBAEL7BfnyFcPLvQfGV9zlpTRjW12qLMvVdK6DQxPVLsAHkNc9s23pmAR+sWUvkMy1dpbM5UbTyLKEmqQNw2LKx/h+tLFWulClVQiOZ4rKD/bLd8cLT1pJk/kH/fQheRW+JLdiegFpadom7pLVB9mm6shoDEzIxzTBr+dltnJguiw+p7PHvr4ZGKi8jWlhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZz2JiUIiEv+LVAZa63qJiPPWphgpu3XT5obgcreSpE=;
 b=gThuNWSYyB4XPqX6QD3BU7ogNCbGSNJDcaAcDGsF5hY36qP6IcPTyvJWP1j9GHCTjlBr6d70+rg3HO3s8AslY/g8/iyLMoikjG41VrJmU4RXjDWE0QSiagTFclzxRgI/+KO9cNmAT8yuN5VQqFcDTJGe/2nj4hKVD9bnhcocByPGUeVRsx+dp0qqe2MjL4zwGY04c2as4xb4FMDIxprNXr6+XtAGMfjiLSvvnXkWXvtZIlJnWZO4yROZlaSJaxvbTqZDTGpfE2x1lCBuXkvOupzclKXJRUhczxjzzPqgoK7LPpYclVnzEkHfWNLY1K9RbsZsca/+eDke0vGj2uC6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZz2JiUIiEv+LVAZa63qJiPPWphgpu3XT5obgcreSpE=;
 b=rKk5r1LILFWtMq2C4Th7nvLyE6nTb374UZhKkEP47Cv5Rzzcp3STIK8pwWkHHxfVmuj0klvkYjO8M1PyV2U5z/dnsBOdeQruV6xYaj7bOzzNrawcXvh5guJp8ct77yEQYD+YQjDX0bGkbBwBpcPs3SniI7d8GFtWmAoC4yd27Gg=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12)
 by DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 07:40:27 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 07:40:26 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Topic: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Thread-Index: AQHV8edGWQwaPNokh0ev3f3hqZGFr6g4DHkg
Date: Wed, 4 Mar 2020 07:40:26 +0000
Message-ID: <DM6PR12MB3931139B3741AFCBCDC1BC4984E50@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <1583300351-3896-1-git-send-email-Jiange.Zhao@amd.com>
In-Reply-To: <1583300351-3896-1-git-send-email-Jiange.Zhao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5c23c52-967c-42af-5fdc-08d7c00f4e77
x-ms-traffictypediagnostic: DM6PR12MB3580:|DM6PR12MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB358047C47E8545DE7396385284E50@DM6PR12MB3580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(186003)(9686003)(66556008)(26005)(64756008)(66476007)(66446008)(55016002)(4326008)(71200400001)(86362001)(316002)(6506007)(478600001)(54906003)(53546011)(110136005)(81166006)(33656002)(8676002)(8936002)(81156014)(76116006)(7696005)(5660300002)(2906002)(66946007)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3580;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0PCwcIKJuTahk956DO/lyyIxmDVwq+usLiZRo3n02slkoaY4LqeQwFuP4tUtt8p3eBGtW/jI29cK0axrCTpkGB5VA5f1TM6IBkYvyzb/63ky/5LkfVARCNDjMjdgodscxYT3sVRaoJFJb0kRy6dkPIQNTKKJtv3CLc4Pgc/sfBFUY90bInPK3HfKClzC8STABMo72XownMKPqqVmofLLgs6yfA+p9dMhFvIUNIrba+Jszxlvbb6c64InSYtixfcGmX+jKuwjHwuyo+ChRGV08hAzwDIADEotobdeJfNaoLruvz/5gnxsYAPeCFAWAH/hTwp8fsBP+u8lty1rnStWhthNwrYVf2PCHiy5f4eoXGNzbQG9PmHI9BI2Ghbv03s2OjHOmR/Osh9fOfVoAnEoh/KQErNRtHfYGKNOJHbJjfTdq4rbwYZXq0sBqtiCXsI7
x-ms-exchange-antispam-messagedata: +ytUGyKNM7EeKsy6crYKHNoOzG9ESAMmRa3mXNeZbZwyvA6iGbKakQgoNAeH/tT6RqKkSZR7w+wlxPMRfnCoXFRVb+0vsxi94HJB/TS34INzCqmgiuW+LvJLSV66exGF91ODoK4J+/Wgc9jILPPU/g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c23c52-967c-42af-5fdc-08d7c00f4e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 07:40:26.7844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bna3LbbKyxPI7c6FMqw5zh9KuwbMcj8DsLUrOzxCwsfRE9iLWjemCG/6EMw2nOO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

You can put my RB.
_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Zhao, Jiange <Jiange.Zhao@amd.com> 
Sent: Wednesday, March 4, 2020 1:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for gpu_clock_count

Navi12 VK CTS subtest timestamp.calibrated.dev_domain_test failed because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be written in VF due to security policy.

Solution: use a VF-accessible timestamp register pair mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.

v2: according to Deucher Alexander's advice, switch to mmGOLDEN_TSC_COUNT_LOWER/UPPER for both bare metal and SRIOV.

Signed-off-by: jianzh <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 03655c3..22a07ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -35,6 +35,8 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
+#include "smuio/smuio_11_0_0_offset.h"
+#include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
 #include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
@@ -3925,9 +3927,8 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-	clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
-		((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
+		((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 
+32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
