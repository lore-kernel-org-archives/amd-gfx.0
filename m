Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E99C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C7C20757
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y2wvUxjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C7C20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2A56EB69;
	Fri,  3 Apr 2020 10:56:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE98D6EB69
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwTreiDp9/EfQpIhDAmoepYFNdfs8DEi+EYIrnqKu1LH3iC0a+g9RA1pkEGzR3pS+dnacb5EwgolG8FXtg1yTR9+WcYb/+roQU2VeJSCGE1d3GdAHID181WdavjBkMI0TOZbHg9QTKMZEDvYVk80vt4nogdLRvCJXziJqfoKhyjK7fys/D0oRvtggmU6DpTmScXEjxYvoldCepx73Dr4+ARVRtyrOC4ZrYASDLPzx1FxuuYpXB6YeTQwZ5H30VLv0WC3H5YXGrKMe8tWXJcjc4HO4MQ7XEOlgfgnhrxwHs5GwTlj4cMZPZIaOlpvh1Z1Wdp0bomZVkyL07TiMXTVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K9cOy8mPicJC3UkLp6gwVWsNJVIr/lVuo6+RnS43wc=;
 b=KERLXlXIuY3b+sAcJoCA6zUtx0iSGgkQ8+vsCosaDo7p9VYsgCU+UGweUR0BpcR59xI7ypr3wRresmsyfXvO8d82znwsbHRbMkGrb2m2z6YC7Qkz72N73xDl9vgD2bei/2TWkBI/bHR7gY5Rl/VXNdjrJElPyFUGeTljkK2a3Dw/JlPDwUVPhSJThgWNefyOp/Cd/dOTcCbHXf+mH0osHtrVAk66nVOT7DGGoZGelCrVQ8OrNIQhZc5QiUCQQfYlkId0OzMQnQWZcQPJn+atL0qZVl0H1idOpgrpNtSNB0ta5Ty3k1Jet5PHfXW+iq3yTA1OKB2paGYopXef3B5W0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K9cOy8mPicJC3UkLp6gwVWsNJVIr/lVuo6+RnS43wc=;
 b=Y2wvUxjbLqFRKFTPU1XAgPoOQlPnIzD6uWkgFiWpiedXHAiTCo/3x3y43rkUmy731hjqJyAyW/bpM9zqvFh6O7vmD1TeiWMEUuFSSmZO0FqRN6v6EtIgm/Roc4sfOiekKtto43rJ28dzrcfvzLhHxSKhFx5kXR28yqdVQGZ7KUo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 10:56:05 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 10:56:05 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdgpu: retire AMDGPU_REGS_KIQ flag
Date: Fri,  3 Apr 2020 18:55:29 +0800
Message-Id: <1585911330-27664-6-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
References: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:56:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24fb35c2-a66f-4335-cb6b-08d7d7bd9b59
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3833965C898A93B30F92D7DEFCC70@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(8936002)(36756003)(7696005)(66556008)(66946007)(5660300002)(81156014)(66476007)(52116002)(8676002)(81166006)(186003)(4326008)(2616005)(956004)(26005)(16526019)(86362001)(6666004)(478600001)(6916009)(6486002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDGri0qXX+3BR0n4g9X2B70GHdmjGNOha/POt4iMvKO8yHFwW3hVbE/bSjsxm8c6Yl5eYfqYLOC/YYNrEz5kXn5d1PVsVrcD4x/7m3YZmce3K0DG1GDPyC7ndRekPPVpLhY4BxyTPnRaygmR4wDzlHNi2Uv+lSN/IiPIcvN+2KVc0DUiNBfFwNiVLe3EPdWrDg59yudOP/EW+DDqefGkcbPGPEgniA/Pl/Cs/uGmdGVm+ffYlPc0CqGTNefBUFz2lH6D/fNEl4zsmkopZbr0xCd5I3cA3RZLWe7sG1ItOqJw5qZx5nVkRxJIj8vl5TbFpq8am2gpEt4gVQMqz6gvpG9Oa4+hhurXqryXME+14iGdDSawptx94vnELDOQ49Lt1E9Og/BH1NYyBdHZmIREuk1OCNBHVGiuDrc4miKbo+4wnvwTDV44KhOUJd/8qAUD
X-MS-Exchange-AntiSpam-MessageData: 5NXOwl+MFoxhHokuGfxfmRvoJDWNt77HfOaaeXtgS9JwA4DWUrFNw7hANAyURoO3l8LIT09PRj57mj4dMrosVU4fBCXeRxCqOS8dvJpTOyyxfz3+33tCYImWqvpIUZPBbJCRsWAkUv1wPngim75fGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fb35c2-a66f-4335-cb6b-08d7d7bd9b59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:56:05.3658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voVMvuihEZTteovcMjsBf/hQQc5yT7CLRAWBOVyijl9IXGiYyzVubBFak2MdK8VMj8dc5dAuB/tXkRC0hJ6Vlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

all the register access through kiq is redirected
to amdgpu_kiq_rreg/amdgpu_kiq_wreg

Change-Id: Ib46637c7095ca0cb9c3200a7ed19347e47cb816d
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e1647625..4466d96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1028,13 +1028,12 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
  * Registers read & write functions.
  */
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
-#define AMDGPU_REGS_KIQ       (1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
-#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
-#define WREG32_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_KIQ)
+#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
+#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
 
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b4d338..23d75449 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -314,7 +314,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
-	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size)
@@ -402,7 +402,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
-	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
+	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
 	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
