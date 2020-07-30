Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBEBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 13:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2BF2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 13:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vt4E1xUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2BF2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FA56E8F8;
	Thu, 30 Jul 2020 13:58:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF45A6E8F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhkHxylmpshsz4Ym0zKRM4NGcwISKm07V/2RQ//gbXjy8mIxkbD3KLbphTDvX2A17DI0E7jRNIKwacaEPjPF6xF3tTy5RRJF1ADqhzjfF6Rf2jfCaaEiNXNvlF4jNlOfZhTjCJJZefzcO/bweVlW/eBojwUGWy4xJ6ZkGHVg1X29efTdNVDM7hn5Tpt28FuFQxjXIJfy70WU5bX2kyLLuxNJFqgdsLDhelu74zzT3fnsCkGVFj4I5WtwwkGLd2d4BMxUvQbz/oY4XawWGgmGM0W9iQRPAdFeco4Jpz+H+lz3i0Tas0Lk3J9Spc2H5wzAqw3zHHNburDJGV+fYsvfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VerVf/BPDEFewnG9x+54cSllW5Y5p5b+JFZIQxu/j7M=;
 b=m+24qOp4VZz28t+s80Bc8Do7DeWLh4r9dKhGUdGV+hTPKMEc/bSGoSMxq3n2R0hJw+1P3zFjGXNG6oSpS3+JM8hHgrp86x9O/G8ORM1kAN5K1i+Q3ovYPEA/zp37I//KWgUIE2phFbCDgH8YTqmP5C4sSTfq0XqAuJcspDF0P874YED8zBqaovX0GMscD0O+eCupkRFZ7VcARsO3kfAUSgbI3YTAvgYFTO+feufB2s/0Cpuvx2yF0D2pAk32wcyhlLdkTuOCm7nd3sYIXXGhks5fBLpjlJgAgV8OdcSagywNSF9/PoZ/HI9/cPWsz9Xu7rEVSJKTdlgpynPWaQ8Bgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VerVf/BPDEFewnG9x+54cSllW5Y5p5b+JFZIQxu/j7M=;
 b=vt4E1xUx26GgaYJvhg8YYo1bVvr7khqD4whDeewvu/kiAc5xwzLFqnSU+Bh6kY8AJhprh8ArN8RGc6gJvzmyhsNYL2ADW3okJdU63+/sGCnC3Xdz8/9I/Nn60sNnvzTg3dAD8gb3CH0LzcLUBblqHq4mQjtO8XrKEirH++xPtJ0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 13:58:19 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3%4]) with mapi id 15.20.3216.033; Thu, 30 Jul 2020
 13:58:19 +0000
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: new ids flag for tmz (v2)
Date: Thu, 30 Jul 2020 15:54:59 +0200
Message-Id: <20200730135457.38848-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: PR0P264CA0153.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::21) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from patasel.lan (109.190.135.109) by
 PR0P264CA0153.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Thu, 30 Jul 2020 13:58:18 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab9a8ab2-fc84-48d6-b321-08d834909d5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB280920563652C9A6452556458D710@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNZ92xGDZu4+ALpSAZiDBVDZk57hhEBJpKUp1Q4voiFYcB5kXks3x89T+dmRfW2FUFgPmopcJXFlnS9pGlq1eSK6uOs2Z0Xbt3EJzrcLdKTNmeacJkp/vdTYZvGiWFmW2MQxMmTNVuPwXlgLsKl0UoRC0Mp+Xx9/wf1zIMfZtJqcQpGnoRSJeAo3qkPr/8XyCBNKL9yuG/A4VBw+LmDzfuvAY/CzelNhdi6kXOoiOpYczwqfKW9kVBPZvr2vNInVtPQ+RCkCd+8nAJCdIOxmTn7UTwAuVMaKnMHRHS7685uAF4zHWg4gNzZEggEV7zbPbRQvGeOTgsX8Kh7ywU/ffpXQP5zHkh7U0E3cvj1+U7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(8676002)(83380400001)(8936002)(6486002)(4326008)(966005)(6916009)(316002)(36756003)(6506007)(6666004)(26005)(5660300002)(86362001)(16526019)(55236004)(66556008)(956004)(52116002)(2906002)(66476007)(478600001)(6512007)(186003)(66946007)(2616005)(8886007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pXS/IEIaKUYYZiaClXVegi54KTx5pXmATWs3MFLOcTSsCyG4gKczwxpZ6bog8oTEeN35Xrpcx5wPxaVHJ3Gg6ij81JGwTjrSa2jO/DyBN6XUnhfn4x4TjpquNOT8PYyGbf8nHVl6S2ppRT3V0RyUywQR3l8I0WdH9nXLXckD9byMhu6xM2BrSSTzI+NFIQNvMHsNcNILobBgTUCwxGBV16Yb5wujKUWeQ1wFCnCF0RukkgW+K7BaSw0WAWF8t5g/xCb/Mcy1XLOiV9pdRubaiW1SmNfQZPnyObYlr/xfPRz4M/eYVuq3ipNo7KRxPFYcXmFQakFhiswDk1ItRiEv5WOTcorun5d8UwwA9s5TjETt/5joeww0REvz6qIWYHci0AqDms55lVK4wkNRrg4C4igh2gHAL/X2TivV856aV/XWbhEGuan08k7mUWQahWLf8d0eU/IfGyg0ra5JOuAvocR5siWKM6CG8ZemnxJiBp2dI+YXE9BgYC3IJxWFhiO0xNGg/563kurTKKKiSFtjyF/f+uFjftX//1Sjw6e/TqX6wVqwZoLvTjQ3fuFUHSXop4134/ngAq8qC5Z1yf/k6DyzxkkM31wVtKRdn0rtAPafwGuKEnIEMVLqtwbotV5z+2IP88eFnWkLXOc7UCre2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9a8ab2-fc84-48d6-b321-08d834909d5f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 13:58:19.5803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Py8yXQKTCExrJcYp2HbIlDcjedmVQUneuFHyAwEguTLFj7b2N7eoiwZoDdjT3rAQKXMEQ+jQdGKWOOC4Pqo/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows UMD to know if TMZ is supported and enabled.

This commit also bumps KMS_DRIVER_MINOR because if we don't
UMD can't tell if "ids_flags & AMDGPU_IDS_FLAGS_TMZ == 0" means
"tmz is not enabled" or "tmz may be enabled but the kernel doesn't
report it".

v2: use amdgpu_is_tmz() and reworded commit message.
---
Patch for using it in Mesa is at https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/6049
(ac/gpu_info: add detection of TMZ support).
I've kept the AMDGPU_IDS_FLAGS_TMZ name to match the existing
AMDGPU_IDS_FLAGS_PREEMPTION flag.

Pierre-Eric

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
 include/uapi/drm/amdgpu_drm.h           | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6291f5f0d223..6dcab25914cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -88,9 +88,10 @@
  * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctness
  * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
+ * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	39
+#define KMS_DRIVER_MINOR	40
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index eebbe2103e32..d353ded353bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -736,6 +736,8 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
 		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
+		if (amdgpu_is_tmz(adev))
+			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
 
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_SIZE;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 765a94ec4420..b826f2d6efe1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -676,6 +676,7 @@ struct drm_amdgpu_cs_chunk_data {
  */
 #define AMDGPU_IDS_FLAGS_FUSION         0x1
 #define AMDGPU_IDS_FLAGS_PREEMPTION     0x2
+#define AMDGPU_IDS_FLAGS_TMZ            0x4
 
 /* indicate if acceleration can be working */
 #define AMDGPU_INFO_ACCEL_WORKING		0x00
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
