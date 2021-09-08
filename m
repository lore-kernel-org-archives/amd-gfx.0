Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAEFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B3161101
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48B3161101
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E287C6E10D;
	Wed,  8 Sep 2021 06:00:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACE16E10D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 06:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNitn7rUK3LwsYLcvsvFvcWpBaU7YsC39R2qaSQCgUp9lae7dVrtBk5HVfzHBdFAiGXINDZ2VDsdCt17pzRT4KNTams7AkZhWFJk1sUL9cy3F+uz3NekBv3ExD3BNNEyr1kPET0MXwWIOCWXLDHFv7IB8I8kwauN9XrR80O83G8GhxPUOTtv+lnXRnbPi8t6GZBEIv1GMxONTJd6JqNaS3QeePYSA146EGMnBm3yTjquPd4drlBDNCu8OrbWqs9wVCkvbXqG4mVdU9X6DiEyq8QLnVZSimAOedF+CeTfSfDzMfTJ668liX2m1o+fO9CN+vsufWFLHna8mkx5Sjzvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPVESWhYZqQlhffQs3cl/3+/xuHG+5GCVc8R3aYYNZ8=;
 b=iYzv9S8I8NQbXl077/YgCjwFlOe9hTFvunhANNP6IpRFZlI+J5ruVUr4MDWnXIJna3r3DNyiyNi3QJVYx1pAycH0KoTRnQY1xataAz2YH7xSNhWHtX4+bO8867jC390AIAnSKuVAflJOA3tJlodc4VciP6B6fDsV5CWq+o3b/EDOl5c8oTy37KIMpD+5WiEXZkJNGos3QYLLTdv9EJ/ZrivqWAp8mxw/UYdBrejVR/jaeC2c2KjhfLUKfPZBQLRcXFnAk1hCQtTueQZk2uivAKjyDQ23tjA1tKk+YnmcwbkgUrOLtl+1irY3tfgCgwi0B3LHKx23g0Lmelu3A+WL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPVESWhYZqQlhffQs3cl/3+/xuHG+5GCVc8R3aYYNZ8=;
 b=oUn5bjipbNK8X350oSl+tW8wsPWqImMbuUfXbekRg9QLcniiJKTg42U7zOtUoz4AEcXY3xvIEwGWNyGydoOeG9F2lFbHopF6m7IZI31w1QIWSAKaKZLd4axA1NAdMwlwMooIZBOUYVaM6PTkqn6FbQ62iJ1xsJ/3368cPFHEsrg=
Received: from DM5PR20CA0048.namprd20.prod.outlook.com (2603:10b6:3:13d::34)
 by DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 8 Sep
 2021 06:00:44 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::b6) by DM5PR20CA0048.outlook.office365.com
 (2603:10b6:3:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 06:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:00:43 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 01:00:42 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [RFC PATCH v2 1/2] drm/amdgpu: Add IB test dedicated BOs
Date: Wed, 8 Sep 2021 14:00:01 +0800
Message-ID: <20210908060002.15881-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 634cff01-a9e2-4e2a-ba34-08d9728dfec2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2566:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2566E9E64BCEC45EB5C236EB87D49@DM5PR12MB2566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEMtBdl7rxbwUR9gDkNl1h1TFI+lRPp46lhkeI77Guoyh2RWOXnjcGvhpWiqyIFQktg+icgRKJpUVwq+5H1hkJ8SBeQxJlVo6oPYkJTo9Ga/EiZSSVZmCQSYImr1XlCZj1Cfd3Fo/fq9kQv+NbVwXbxGaRdPRpm/KvFurl8w77qxqqH9EZl6nmrN8fYmliKd3e53nlWGQanvRI4d8/8fnZLK4zHtyI8eO/SoztbtkK/9NxYy9iJwYqKLRwN1IU9R30sKLhI1Gc6xixUqO7LjE6dpoJMXohj3kz2oJ59acwNmTEKEea6N9BoGjX2mx7Euo7j2jTD50srCRJHeTMzBrqWn20TZmXmi+JZjftmWgKgKSt1g73XB7Y5ql6myhegcbogPK1RBXFnGhrhKloAXtw1cRo8MeYv8Rsq++6yGwaBzrI+Uj1QLYUv35z+ycZ8un2T8snIzJq22g2DjKURAfuC9hLK749EqYnM39b5mO2LjsjOoXFnBX8Xi1JTaMbDmFEAgLvUIOHgCRsY3ov9Pxh8RVQB4ou4csptiSPWhmhtD03tYASbVpX8jmXiwhZWarRFC4PHumg4FFId8dTDbqC1ujGp1AJvJygO6FTBCAew+m9F+dP0tgAJhVd7Qawk6UyAQPNk8g1+lcELfH92Pgbs3Rz0+faxBlvxRathJK3mXm3EhZIgU2SdroxzX2mOFkDNVwpYwTAWtajatRzd2XyQf78GCMCLSbtv1HmlPjnM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(36860700001)(316002)(6916009)(16526019)(186003)(426003)(6666004)(83380400001)(26005)(47076005)(1076003)(81166007)(356005)(7696005)(336012)(86362001)(478600001)(70586007)(2906002)(2616005)(36756003)(5660300002)(4326008)(54906003)(8936002)(82740400003)(70206006)(82310400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:00:43.8856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634cff01-a9e2-4e2a-ba34-08d9728dfec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Two dedicated VRAM and GTT BOs for IB test.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
change from v1
	check the existence of uvd and clean the code
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 53 ++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e9e3ea0bdf37..93db6ee9b719 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -519,6 +519,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
+int amdgpu_ib_test_create_bo(struct amdgpu_device *adev);
+void amdgpu_ib_test_destroy_bo(struct amdgpu_device *adev);
 
 /*
  * CS.
@@ -949,6 +951,8 @@ struct amdgpu_device {
 	bool				ib_pool_ready;
 	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
 	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
+	struct amdgpu_bo		*ib_test_vram_bo;
+	struct amdgpu_bo		*ib_test_gtt_bo;
 
 	/* interrupts */
 	struct amdgpu_irq		irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4e13381e9b5f..5f9b6ca671db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2389,6 +2389,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		goto init_failed;
 	}
 
+	r = amdgpu_ib_test_create_bo(adev);
+	if (r)
+		goto init_failed;
+
 	r = amdgpu_ucode_create_bo(adev); /* create ucode bo when sw_init complete*/
 	if (r)
 		goto init_failed;
@@ -2768,6 +2772,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_fini_sw(adev);
 
+	amdgpu_ib_test_destroy_bo(adev);
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.sw)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index c076a6b9a5a2..fc2316839e2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -429,6 +429,59 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 	return ret;
 }
 
+void amdgpu_ib_test_destroy_bo(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->ib_test_gtt_bo, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->ib_test_vram_bo, NULL, NULL);
+}
+
+int amdgpu_ib_test_create_bo(struct amdgpu_device *adev)
+{
+	struct amdgpu_bo *bo = NULL;
+	void *addr;
+	int r;
+
+	amdgpu_ib_test_destroy_bo(adev);
+
+	r = amdgpu_bo_create_reserved(adev, 128 * 1024, PAGE_SIZE,
+			AMDGPU_GEM_DOMAIN_GTT,
+			&bo, NULL, &addr);
+	if (r)
+		return r;
+	adev->ib_test_gtt_bo = bo;
+	amdgpu_bo_unreserve(bo);
+
+	bo = NULL;
+	r = amdgpu_bo_create_reserved(adev, 128 * 1024, PAGE_SIZE,
+			AMDGPU_GEM_DOMAIN_VRAM,
+			&bo, NULL, &addr);
+	if (r)
+		goto err_create;
+	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) &&
+			!adev->uvd.address_64_bit) {
+		amdgpu_bo_kunmap(bo);
+		amdgpu_bo_unpin(bo);
+		r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
+				0, 256 << 20);
+		if (r)
+			goto err_pin;
+		r = amdgpu_bo_kmap(bo, &addr);
+		if (r)
+			goto err_map;
+	}
+	adev->ib_test_vram_bo = bo;
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+err_map:
+	amdgpu_bo_unpin(bo);
+err_pin:
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
+err_create:
+	amdgpu_bo_free_kernel(&adev->ib_test_gtt_bo, NULL, NULL);
+	return r;
+}
 /*
  * Debugfs info
  */
-- 
2.25.1

