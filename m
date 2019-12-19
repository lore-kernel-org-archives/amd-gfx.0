Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B82C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 11:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CE424672
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 11:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FhprgQ7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CE424672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CC36EB53;
	Thu, 19 Dec 2019 11:43:47 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690058.outbound.protection.outlook.com [40.107.69.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBAF6EB53
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 11:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSPIxWu7uUD7B7KL8vMgm9d6vWusO/aSyK2lpVRgWZNsO+GBNhD+cEGVSWSNZxaV9oLEAsIBACsegpD3RAHt1Pv7y0g/70MK2QOs6VnYuDlCzrM/w0kLB8fHHOBmzesIARKJ5mz6um9zrmuBMi+x5rySKFxFOIsqjH8susM0RWayinbony691zejuoXh1OHKlbSSDcR7ba2THC48o2GBCgX00PSK9Fm9pKqxB+IXYoXo1l1ilOObH74iEB/z9vKNZhcdH/FJI8zYQIfXRbs5WBYWhhD/439i3we8M3tUNrs9EWWxG66ZsSJij0euag/MJgvL7G0oy8YFG5nBV/S7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L36eix7Zz6KaQm9/A6VBRgDhHAgVD/lqBpYig1fg00=;
 b=HZ/yZ6BGGOlCj+aICqTH8qmkMoBxzHjtyMq0HvcncZFcXrenYpVRajTGor8rGumAKwDlQndjcDVz7F3Sg/ycciUW/+uTaDPzYFu1dEe7fgTgV3grxA/cISUXn9KqkfxTuJ6GBdC+k2zMDK+eI6MQvQB2/JQlHjk6idyXZt+9z/9OiXLSwLDb+N8DfkoynmgqRHtU4s39jrTZt7YjivBMM2rrwiI7b8q5kaQ3vp10+4Zf7IGG+LAesHtouCuEFNl453+vbtS3NJUea+b9lVtrbnozSrUX5ucc1w5x6oLoZv/SO5It5fYs48vTfAxkqhspMKJqnrYcYLj4lBW0y/xysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L36eix7Zz6KaQm9/A6VBRgDhHAgVD/lqBpYig1fg00=;
 b=FhprgQ7UwEgp1pP/kEbHmuaTbNPyi3e8vKaDwmtbXB+qMgJixB3TntC3gGKWxuMS03iwY325VYvRCN15uMA6q1zZJyy54E73KyZYHVlW+GC3DAsY0DsgbhUjojbHmR6HAXitFFsys0m2lwafzR3o8HNacdz/X7ywTNOh+UIUbL8=
Received: from DM5PR12CA0018.namprd12.prod.outlook.com (2603:10b6:4:1::28) by
 CY4PR12MB1862.namprd12.prod.outlook.com (2603:10b6:903:121::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Thu, 19 Dec 2019 11:43:44 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::203) by DM5PR12CA0018.outlook.office365.com
 (2603:10b6:4:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 11:43:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2559.15 via Frontend Transport; Thu, 19 Dec 2019 11:43:43 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 05:43:42 -0600
Received: from vbox-debug.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Dec 2019 05:43:41 -0600
From: Frank.Min <Frank.Min@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove FB location config for sriov
Date: Thu, 19 Dec 2019 19:43:34 +0800
Message-ID: <20191219114335.22528-1-Frank.Min@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39840400004)(376002)(346002)(428003)(189003)(199004)(26005)(4326008)(2906002)(36756003)(6916009)(70206006)(1076003)(70586007)(8936002)(81156014)(8676002)(81166006)(5660300002)(478600001)(356004)(186003)(2616005)(7696005)(316002)(6666004)(86362001)(336012)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1862; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b7586d-3ab9-4c39-6895-08d78478b394
X-MS-TrafficTypeDiagnostic: CY4PR12MB1862:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1862302C3CC3AC5539EC1C03E9520@CY4PR12MB1862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szR5LE932LVVbGGATPKdn90DpcjZK2coo2wJOoRAF6OOoAjnlG6uJTGLcxZCYjUDXy5GHfazPSCr+kqOQYmN4C2yjA4EnmtGu7BrgiWfcNTapCW5P4Fe6jIA01wL+2N296NDAcIyo/O2LUuRUgeUXR4yrSCIR0Da8g+B176dljxBMewMnJbVbQbYGkrTUIJRQ6NTAoFTeTxdW1ekzNLbmEWbtOWkN0voZ9IKpLgeQn3UyvaYBMpv6JGm67mA4Hmy1XA0sA99BpEBXCjmLcZA8RVDrsAJaNa0U8pmtELvQkNnCfkWOJNPvoFS6EjVtCyEVGAo9npXjwgWNU9+0l/a5zO2X6ZVi4JU5zlrhjWg8U+7Jl2c/XkDMDGX4qJtWTpsNaYGGeXp3hy0hU2mSFLZOSeEwmpTdUxVBQrv9TIZ4pNtWlOzlcff2XMsncOHRkjV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 11:43:43.9573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b7586d-3ab9-4c39-6895-08d78478b394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1862
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
Cc: "Frank.Min" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

FB location is already programmed by HV driver
for arcutus so remove this part

Change-Id: Ia357ae716bfc3084a4dd277ade219e57092f9b42
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index e91bd7945777..e9a9d24c2b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -264,7 +264,7 @@ static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 
 int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
 		/*
 		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
 		 * VF copy registers so vbios post doesn't program them, for
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index d9301e80522a..ac61206c4ce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -368,22 +368,6 @@ int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 	int i;
 
 	for (i = 0; i < MMHUB_NUM_INSTANCES; i++) {
-		if (amdgpu_sriov_vf(adev)) {
-			/*
-			 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase
-			 * they are VF copy registers so vbios post doesn't
-			 * program them, for SRIOV driver need to program them
-			 */
-			WREG32_SOC15_OFFSET(MMHUB, 0,
-				     mmVMSHAREDVC0_MC_VM_FB_LOCATION_BASE,
-				     i * MMHUB_INSTANCE_REGISTER_OFFSET,
-				     adev->gmc.vram_start >> 24);
-			WREG32_SOC15_OFFSET(MMHUB, 0,
-				     mmVMSHAREDVC0_MC_VM_FB_LOCATION_TOP,
-				     i * MMHUB_INSTANCE_REGISTER_OFFSET,
-				     adev->gmc.vram_end >> 24);
-		}
-
 		/* GART Enable. */
 		mmhub_v9_4_init_gart_aperture_regs(adev, i);
 		mmhub_v9_4_init_system_aperture_regs(adev, i);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
