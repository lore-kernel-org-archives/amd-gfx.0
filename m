Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D51FC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D62E206DA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 12:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qAkTbicZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D62E206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458DC6E1A2;
	Wed,  8 Jan 2020 12:36:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397106E1A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 12:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4dARbhtlZBsDHhEO7KktM54z4EaadnOs4Vtp7hfvoB1JfYcLZKwTwAhgXm74G2NncQyI7HqfxsGFwaZjHLaYo7X2HsdWScqTCaz6Trx+JSvw7oYb837wdGjoDUxm7s6jv17WI5jYuHMrlO8kmOESK+dOQw8/yHHMrnXxu+S8Qw4xDWC7QdAG7UMlSXESLb5BMKag120JcIwsAcNri+DQDO2qfJm65gIH7/k9DdJTX1E7X5iLdc8OgLiirEKFngwL0bJVG5AnDZFL4eDLZ+ofxdgmID8RWxX4kYJ3+UlokhZ+e+gIjknZRNjShyx0nO+yQhKHEmuwQD2omOtc5u/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjRmiAxuVJciaK9VtkLH5YCSVQb70cVqwkV2dTtkzOY=;
 b=IiffXUBH1h78mmnC6uTh1Tngi/gZHifbUs/tWHvGTa76yifD37TV75xhRrDtcW8dfCB45cXgcIuAeBWuCtfHhu/EsLAqXF32sbRfjp5Upt8P3Gzublj8o9dfbDMbn51ZDvr35kaMT/wPApnGDCMOye1UfwVkA2lDEw7rCWVLa/8dNT6ts6m/NQXDGEwRbqd98+5WD8tR+zM70cncMRsD8238OlwcohVs4itVJxXVEkAnpneUuZmJMliXuW7i/DmkZVZ00Lj4PsQVEbSyP8jNOdkf2hsPfmFK+g+skgdvPWOW4tTI/AOXRFAytKfaKZykbt1zAtWebXUuMq1fsPSwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjRmiAxuVJciaK9VtkLH5YCSVQb70cVqwkV2dTtkzOY=;
 b=qAkTbicZZDqPlJ8sL5y9MFn8u3GojEEEfoeio/Eu3chWc/6Kv+qJ87j/NuB9Y2FbfxFUdxqQTRbvzanywd/DaiBe5mPz24TpU0Mqs04vr2BiTGdoNNt+vh4LalCHvbzTgvdgrAMYWrZLqaHBLCVnfVCSX+Sc0Q+MbAa89C79GWs=
Received: from DM3PR12CA0063.namprd12.prod.outlook.com (2603:10b6:0:56::31) by
 CY4PR1201MB0040.namprd12.prod.outlook.com (2603:10b6:910:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Wed, 8 Jan
 2020 12:36:56 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by DM3PR12CA0063.outlook.office365.com
 (2603:10b6:0:56::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Wed, 8 Jan 2020 12:36:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 12:36:56 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 06:36:54 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 8 Jan 2020 06:36:52 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when GDDR6
 training enabled
Date: Wed, 8 Jan 2020 20:36:48 +0800
Message-ID: <20200108123648.7422-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(428003)(199004)(189003)(2906002)(336012)(426003)(6666004)(478600001)(26005)(186003)(356004)(4326008)(44832011)(1076003)(5660300002)(7696005)(8676002)(54906003)(86362001)(81166006)(81156014)(6916009)(316002)(8936002)(36756003)(2616005)(70206006)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0040; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819cdb16-f56e-4bc6-9bd1-08d794377287
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0040:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00401C4FB2EB79702671D052953E0@CY4PR1201MB0040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/EjeVX5BF3Ed7Zclmv36RO+rtGFAHpYIRi3ZMHD9vXZZLXdgyJKDu+Zdkdr7p3p9xv/UpsxDJIOb7Q98Nf2zUjEGIlz5B3w/pl1oKzyhDcMTR2MynKCKS5/cVEFPNWNDQ98ktfXdo9go0PRyhVQgHpJcgu/Y+cgZFNt2pgYXuBZy035yiXTCgpqlNO6AEm+bvTBN1R94plNCv4ZwJwXNPZN2HgPgqU/ZxiZonljxuwH/UkDiQrouhtEDS5I/q4wTw3ICazdwgvUZgGX5aEry0opX/1HzikpUTS0vv/kWY7t3X3P+z6ZBhE4IjnBZ3VXX5nNzu7/cfvcuctpVR25F438vlvZ2D/H9HAK3yA3oROkREVPixLdMVBtqbaMClJtgVEstumLXmMdFiZT2vnDHbW5OJIsAlK6twCJzONj6WHxxy80ydMJaB9Tsh9cuQq2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 12:36:56.0225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819cdb16-f56e-4bc6-9bd1-08d794377287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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
In dual GPUs scenario, stolen_size is assigned to zero on the 2nd GPU,
then the bottom region of VRAM was allocated as GTT, unfortunately
a small region of bottom VRAM was encroached by UMC firmware during
GDDR6 BIST training, this cause pagefault.

[how]
Forcing stolen_size to 3MB, then the bottom region of VRAM was
allocated as stolen memory, GTT corruption avoid.
The stolen memory of the 2nd GPU will be free in late_init phase,
no memory wasted.

Change-Id: Icd0ad7de41333282949bb1e3e676c6c307ddd081
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c91dd602d5f1..440b793316df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -60,6 +60,11 @@
  */
 #define AMDGPU_GMC_FAULT_TIMEOUT	5000ULL
 
+/*
+ * Default stolen memory size, 1024 * 768 * 4
+ */
+#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE	0x300000
+
 struct firmware;
 
 /*
@@ -192,6 +197,7 @@ struct amdgpu_gmc {
 	uint32_t                srbm_soft_reset;
 	bool			prt_warning;
 	uint64_t		stolen_size;
+	bool			stolen_temp_reserved;
 	/* apertures */
 	u64			shared_aperture_start;
 	u64			shared_aperture_end;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7dc8c068c62a..0c96b67d6ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -566,6 +566,11 @@ static int gmc_v10_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
+	if (adev->gmc.stolen_temp_reserved) {
+		amdgpu_bo_late_init(adev);
+		adev->gmc.stolen_temp_reserved = false;
+	}
+
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
@@ -756,6 +761,22 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 
 	adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
+	/*
+	 * In dual GPUs scenario, stolen_size is assigned to zero on the 2nd GPU,
+	 * then the bottom region of VRAM was allocated as GTT, unfortunately
+	 * a small region of bottom VRAM was encroached by UMC firmware during
+	 * GDDR6 BIST training, this cause pagefault.
+	 * The page fault can be fixed by forcing stolen_size to 3MB, then the bottom
+	 * region of VRAM was allocated as stolen memory, GTT corruption avoid.
+	 * The stolen memory of the 2nd GPU will be free in late_init phase,
+	 * no memory wasted.
+	 */
+	if (adev->fw_vram_usage.mem_train_support &&
+		adev->gmc.stolen_size == 0) {
+		adev->gmc.stolen_size = AMDGPU_STOLEN_VGA_DEFAULT_SIZE;
+		adev->gmc.stolen_temp_reserved = true;
+	} else
+		adev->gmc.stolen_temp_reserved = false;
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
