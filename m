Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842AC43463
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 03:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD01206FC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 03:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X/z3+OkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD01206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9653A6EC90;
	Fri, 18 Sep 2020 03:27:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D706EC90
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 03:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVvl0Egx5nTZbmp2Aqn9kqDtGmyqAg8/fMH9GUM08HqRshukz9qWPh95TJdknpDCJlVY/igDIPj2pJ/RWgWHY1fRnpAOQ3IsNVbxYMmYBB+2Zt7vo54GtYd5zT5fQ6WkfHATut1Og3FUmeMqiotleZq9vn1mPjJ+2UROZ/E7nRg1ylpXMY1FzsHPk2dXbsFwt+O5KJwO8UIyXqFsfl/KTX7esuLTyK2yKJQIqJjFIq6YlrJMn7cVtEbrYYwB4yaxAC65JOO/CXhs3z20pRdtW4X5dc77tjucr0Z+wVWvktuYeZy8S3dJ22eHCDhHYgmDzuHI/VDgqFgxSrrcYbFiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fLLCmhu8Bz5q4FDg4ZwmSUIo8m6F1fvXh14UlPr9Wg=;
 b=PzHsJjYVaTU7NX55srJLY9aNcK7X1VGmaTxz6+bkMLpqf1yu+M1vQo7YGKPQCZmWpTSrjTksODfBgZOx+uNHDVArH4XTpwn9e5+wBZA2jXZjExKx+EoeZmKpkHWSCfLJ9caSQb9yX5OFhotCCqGLs05qSg/lXyZeLIegJfxb2FChgcgYCIvho9vgM5qO0PlAbffzPBW8kEGZJgBztfR2a3LisGngLhtzPY1M1odDoq9NOchlR6HEx1rcLrQP7gNjHnyNRIXnWxD8kumvk1rI9WDZS/oub4Tvp8/aszVQsYdLa5AqUWbcQkea8pEK28M4Uxoy0lJ7YRFX8HEUKzHkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fLLCmhu8Bz5q4FDg4ZwmSUIo8m6F1fvXh14UlPr9Wg=;
 b=X/z3+OkGViz8zEgpXs47LFj6OII8vXKroqmZzov+I3rEJgWJw863qK3A4xcPxoQxaGuE2MvRzbCVCNJ0g0H4NetDzr32fRhg9WT9qyYBv2v5e6Swf5Yp4zp4FC000hPneRHFuCQmw9MPMP59BBmD2TSkNcQ8WxQ5nZRVffrlk1U=
Received: from BN6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:405:75::21)
 by MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 18 Sep
 2020 03:27:25 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::6c) by BN6PR17CA0032.outlook.office365.com
 (2603:10b6:405:75::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Fri, 18 Sep 2020 03:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 03:27:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 22:27:25 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 22:27:25 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 17 Sep 2020 22:27:24 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
Date: Fri, 18 Sep 2020 11:27:16 +0800
Message-ID: <20200918032717.184758-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e5463b-de33-46cc-f90c-08d85b82c378
X-MS-TrafficTypeDiagnostic: MN2PR12MB3933:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39332172E2DA0DC68FC3F57C8F3F0@MN2PR12MB3933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hf6Q1OA0N9qKN6X+YRcAExI8avnEedNkS6AZZNXeoDkMOvaZ44wlgPsVeC0baVlQI8mkYYtdcn5ygRgWnHOlPI7hLQASWKjJBBvrecXx0Zj5RHMJlvEUNHZ3Sd7XbtY9VHzf5ul0gYMhpHMT+5JpoygIyuB0A7uE2QrTwN3iMBtcuJWVLCer5mtMI37ni9tKKPYmCIT9PtukJfcXIbRl9EG/J+h7QzK7VN+FjmFkgxvXeTDdFFG6GhAa1t2lswlq4aU2o0rRYYwbzCUrDi3SRp/YttD52TgsGAtpop/heomj4jdEcuYN9kEXnCItY/b3A+OE9Q/UJRWUj444rt5PaS3Y9xHk77H7rMjrT/qn5Adc3uRk9kAsJ9RDBU6lnJE3l2b9CSvLtSWfJEwAs5kfkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(70586007)(426003)(81166007)(5660300002)(2906002)(336012)(186003)(356005)(8936002)(83380400001)(82310400003)(6666004)(82740400003)(70206006)(4326008)(6916009)(47076004)(86362001)(316002)(8676002)(26005)(2616005)(36756003)(478600001)(7696005)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 03:27:25.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e5463b-de33-46cc-f90c-08d85b82c378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3933
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For debug convenient, add sriov_mcbp parameter.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I84019eb4344e00d85b2ecc853145aabb312412fe
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 13f92dea182a..a255fbf4d370 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -183,6 +183,7 @@ extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
+extern int amdgpu_sriov_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes;
 extern int amdgpu_noretry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3f07d1475bd2..b0b2f0f7be94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -145,6 +145,7 @@ uint amdgpu_dc_feature_mask = 0;
 uint amdgpu_dc_debug_mask = 0;
 int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = 0;
+int amdgpu_sriov_mcbp = 1;
 int amdgpu_discovery = -1;
 int amdgpu_mes = 0;
 int amdgpu_noretry;
@@ -578,6 +579,14 @@ MODULE_PARM_DESC(mcbp,
 	"Enable Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");
 module_param_named(mcbp, amdgpu_mcbp, int, 0444);
 
+/**
+ * DOC: sriov_mcbp (int)
+ * It is used to enable mid command buffer preemption. (0 = disabled, 1 = enabled(default))
+ */
+MODULE_PARM_DESC(sriov_mcbp,
+	"Enable sriov Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");
+module_param_named(sriov_mcbp, amdgpu_sriov_mcbp, int, 0444);
+
 /**
  * DOC: discovery (int)
  * Allow driver to discover hardware IP information from IP Discovery table at the top of VRAM.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2f53fa0ae9a6..ca0e17688bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -236,7 +236,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
-
+		if (!amdgpu_sriov_mcbp)
+			ib->flags &= ~AMDGPU_IB_FLAG_PREEMPT;
 		/* drop preamble IBs if we don't have a context switch */
 		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
 		    skip_preamble &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d7f37cb92a97..156e76a5a6e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -742,7 +742,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		dev_info.ids_flags = 0;
 		if (adev->flags & AMD_IS_APU)
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
-		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
+		if (amdgpu_mcbp || (amdgpu_sriov_vf(adev) && amdgpu_sriov_mcbp))
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
 		if (amdgpu_is_tmz(adev))
 			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
