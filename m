Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08410C32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB42D2072A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aXcWKX+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB42D2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8111F6E02E;
	Thu,  9 Jan 2020 11:38:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BCC6E02E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 11:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFVmCdnZ1fy+2VUpSqq2ORR82cXUT/FpV4mcisW65Ulk2XgtsXX5jVHjso4g64WSTc0OlJdyJ0ESU9iZYuDs0j4G3r8OOaYp320ObeqrmTiVux2Q0IZGkfp1OUpWZFHi8Ohvq7IZFhq4HJevN9j+EBb1n4QioUBIfR9dfTDveqDO1I90rAJ7Jn4DE1Nv7hha+BAxcJTT0r/XCeQY8TQDFz0NwcN8wKzOQgl0A3KE1T+vLErX/BK3krjEV3RrkzgBFxuOs71UWZ0jAexwaBBbWF9x/UPrDUrfLPlxD9Ra3y+1Rr7pI3kGLnQwduq+R+DkjeV2chmgX3v2IxyeJvpmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4NOUL5k9WvJxXqveGorcKhwZLp4FWc96nI6f+Y3iVU=;
 b=iHe6ep/yIgsRzwCqsNho6DpGgBHlBc2JPWSpS7OX+xpsNEQVH6+VAn8zPB+jaNd4Fdf/Zj4aNDaInt6keaPMIkhnUFgh11eBAPPBXDDlE72Vn2ZoMJhj16XqThCeyiNGqz4of+2zdjLeCxJHXM2v2mJwnc/Rk2Q0WQxx+lJsxfZWWJNwzW/SJRx9W8JOlt0Vd0FXPM53RkQH13oEC8xtfTAxmYaxKTB4Aqg5OIaJjgIvxmnL8aRIfFdMD6lI5OXnkivDdRo9QVeyg93kUj7+etITsajf3UBMMf3ZYSW+G7ElYUlXjp7xq0jiHZ9oAzsum+QXwCZVKtJ8tnz5EYu4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4NOUL5k9WvJxXqveGorcKhwZLp4FWc96nI6f+Y3iVU=;
 b=aXcWKX+qe8eQ6mV/nMVVPQXVASTPS7QdroXEwHQXs555PIccVavCaoG2n3KTj8jXPil0b9lOlqHmo+O6NLm4RLo+OWFaxGY2xmKBhWbtk5CPcNa3t7u/S852td5b9z/IJUmXa7OkcheIyLx9Fto4qZcMagAJcE197AXS5wsrpxg=
Received: from BN8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:60::37)
 by MN2PR12MB3789.namprd12.prod.outlook.com (2603:10b6:208:16a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Thu, 9 Jan
 2020 11:38:13 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by BN8PR12CA0024.outlook.office365.com
 (2603:10b6:408:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Thu, 9 Jan 2020 11:38:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 11:38:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Jan 2020
 05:38:10 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 9 Jan 2020 05:38:08 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU when
 GDDR6 training enabled(V3)
Date: Thu, 9 Jan 2020 19:38:06 +0800
Message-ID: <20200109113806.19305-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(428003)(199004)(189003)(44832011)(26005)(2616005)(186003)(2906002)(336012)(426003)(70206006)(1076003)(70586007)(5660300002)(54906003)(6916009)(81156014)(8936002)(8676002)(86362001)(81166006)(36756003)(356004)(7696005)(316002)(4326008)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3789; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 049d6725-4526-4c8e-951a-08d794f86868
X-MS-TrafficTypeDiagnostic: MN2PR12MB3789:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3789A3DAB94113428A2916E695390@MN2PR12MB3789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDRr0Qtco3pjRsGmCwe3XsJ3yMR9go3YvDXp01G4UWYDujmuTP11fswxTMya1G31wRAz1oQmxyzkq2WTTyteKJXZP42hOdtls2viRQ4FrnTGRbI1sgG0upXfvGpaJdxZNOaCF3tTtB47hnjrQB2C1waKKTRp8w0wtRlHQLYvCCnFfN2noTBeFUobwzHoeHx+qcjLdUfEopOUFmfUGPeuFrVxY8X7lRcD3PqgfRYCgPc+X/JqkleCsRZvtLevPuXrnrYNm1LQ68OtRtP2yAxiOLKHwwWpOm0PUP8uVWTCbtZsn+HS89wr5YZF7KIirK5LZg1uMRxAlchOzohfbaU9juYBymeeFhTlbM45LEoNcfqKaZbt2Xow5YDHUlkJZ9ZWJaT7uSgKGnJLZo+X+92RNgE/ST5HhKbkEtgQcnWU2ltPfApM9GVcJH5V4/xhD83x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 11:38:11.9083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049d6725-4526-4c8e-951a-08d794f86868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3789
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
Cc: Long Gang <Gang.Long@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
In dual GPUs scenario, stolen_size is assigned to zero on the secondary GPU,
since there is no pre-OS console using that memory. Then the bottom region of
VRAM was allocated as GTT, unfortunately a small region of bottom VRAM was
encroached by UMC firmware during GDDR6 BIST training, this cause page fault.

[how]
Forcing stolen_size to 3MB, then the bottom region of VRAM was
allocated as stolen memory, GTT corruption avoid.

Change-Id: I310a72ba0402994defbe50839842a8edb025a868
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 27 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c91dd602d5f1..e4b2f9bcaeb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -60,6 +60,11 @@
  */
 #define AMDGPU_GMC_FAULT_TIMEOUT	5000ULL
 
+/*
+ * Default stolen memory size, 1024 * 768 * 4
+ */
+#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE	0x300000ULL
+
 struct firmware;
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7dc8c068c62a..b95add93d6b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -566,6 +566,13 @@ static int gmc_v10_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
+	/*
+	 * Can't free the stolen VGA memory when it might be used for memory
+	 * training again.
+	 */
+	if (!adev->fw_vram_usage.mem_train_support)
+		amdgpu_bo_late_init(adev);
+
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
@@ -757,6 +764,19 @@ static int gmc_v10_0_sw_init(void *handle)
 
 	adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
 
+	/*
+	 * In dual GPUs scenario, stolen_size is assigned to zero on the
+	 * secondary GPU, since there is no pre-OS console using that memory.
+	 * Then the bottom region of VRAM was allocated as GTT, unfortunately a
+	 * small region of bottom VRAM was encroached by UMC firmware during
+	 * GDDR6 BIST training, this cause page fault.
+	 * The page fault can be fixed by forcing stolen_size to 3MB, then the
+	 * bottom region of VRAM was allocated as stolen memory, GTT corruption
+	 * avoid.
+	 */
+	adev->gmc.stolen_size = max(adev->gmc.stolen_size,
+				    AMDGPU_STOLEN_VGA_DEFAULT_SIZE);
+
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
@@ -796,6 +816,13 @@ static void gmc_v10_0_gart_fini(struct amdgpu_device *adev)
 static int gmc_v10_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	void *stolen_vga_buf;
+
+	/*
+	 * Free the stolen memory if it wasn't already freed in late_init
+	 * because of memory training.
+	 */
+	amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
 
 	amdgpu_vm_manager_fini(adev);
 	gmc_v10_0_gart_fini(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
