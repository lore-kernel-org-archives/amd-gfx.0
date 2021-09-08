Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508E8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 05:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174DE61100
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 05:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 174DE61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124C66E105;
	Wed,  8 Sep 2021 05:46:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D3C6E105
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 05:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvAOo7E7gKS0MUjLBh4dnDaqxArpkfjbfSB/pa9Vzne6CSWPDFvw5vngByVMNhpOj3pOaXNha7RSj/uPOIWj5Xi7GMnQLoqkjT+Z+4CXKEOxGKJvU1sihaLYHDCUh4Yx3hXpMgfw32BPncki0zvka5ngkBXP68MUcQcEpuGFU8g8y6faeZnT81yJQLpLbWCvc3aE8DDzRA7Fv2W477pjy6KDDjvKsvnWIVdzfRebd3ei4R8d2wRb5ThDDflgga6Oizc+nqzQy/uBLQ7tew/Tx22HQg8F/zncMNutdJ4aosTkOzNKJMDaP1cXavT/bOhy+/6SEImm/wHIm6hI2yIzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=HN4QyolcFpQHM6898UBwgDTjUYhRxMmwWnO4LSn92wk=;
 b=VnpEiHWdgBlXlccplGS/2nDQjK8jYWiaMEZjsSRbfw1rRhULYH7mD6fJVxx3dH3I1k18sa6S4j8hHv9ESs22eE9Cw8evoY+yMi42sBxJEzsXfxpSGJjG8BtxrWKfMPrZ85v4dKKrU1pn3R4BTuIV4yfgt2MZzbm5o99q4K9+TDbqgW2rPoZRHmp2h0ZjFou+TgZ4b6pedxWRvJIFIgdoVTx6WE+6GhfpEAt+pew694L/p0Fl7Drfd/uIx/m0HPvqZM4xiOZ2M1W4AbLNIDFwQu6+Odov9jM5ek+YLNft8LNwpYvfV+VC1Trpu9q4KS+5yFWiYP6mS2doQQlY9Ckhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN4QyolcFpQHM6898UBwgDTjUYhRxMmwWnO4LSn92wk=;
 b=bzHwbBTekAcrwxHzEvzdswvsxLz6jJXQZeHaLTeY/K5Zog+kQHNTGZ4Nu0+kVUJhVLZX/2Rcs5Pk9W2amb9BInoQvg6IBZQN9xWRsrEiMHxECs/M8o1SKTX7ncePCa3B/vudxMXE+WMJJlSGux67k3h8TdPOdHi7GF1FLkh811c=
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by SN6PR12MB2783.namprd12.prod.outlook.com (2603:10b6:805:78::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 05:46:20 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::94) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 05:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 05:46:20 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 00:46:18 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [RFC PATCH 1/2] drm/amdgpu: Add IB test dedicated BOs
Date: Wed, 8 Sep 2021 13:45:52 +0800
Message-ID: <20210908054553.3290-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3037135b-8a9e-46de-fe84-08d9728bfc05
X-MS-TrafficTypeDiagnostic: SN6PR12MB2783:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27834317C1049896879EF4F487D49@SN6PR12MB2783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7aOXXizgMQ59WaNhwCYnagnfGfE8hJJtZoq01F7sADlr3uxHWBnejui4nFu3JxUOHS+Ibi/ur0csA+UbzEp0tXMetwAYu1NdhCmJPWO4CH2iic2WRHw1DLqfFUbLJRb9hFpAZjXLnededdJvXf5VAYB7oL3wS/7wGS0mVcUeWQ1FoLBa9AO/8ird1sIVSWVBy+sEZnRj1VsO1ijluQygHzTKJlk/Ndeo/QrBRAZu+VHDWaND5yNZG/tIiW2BQr8GsNDGyNqkN47E8+30wlG65Ckho/Sdn05EBHhvS8pSoyiAPfHR6GwEYTf8JZLMNkVJ0Tr5rlT+1eibmmG0DilP6sv+R4nSWlZoXhAHtc2HGV1eQU+Sys7YVVGWuoUm2pY2yE2AQf4S55K6Vd0LG6T/zV+XFgQy9GWqOh9loe0nm4EiaPw2U8amTLj/FwIapDAmof8R28iLjUAOUnZG+pa4Hw565RLxKudvJi0a5AqNeermUbgEGLT31XNfGrgOfBpQ1i1QvGthqBv8eoFtMpzDR9uHoqY/oY9zSqTrp9ORJqCEFnxjfV00jEw0hYwwdtjh4dEZ2z0hbKd7Ayw/j0P/Uri9WyDBWpzlvT7tFFoK3TBrrHCOFER25UmYacTNup8USKnljvOd6hNNNU+9b3043R019HgSgoPRSRuZErsKS8avTEBf0kjDRYOxvUBl3wsgCmsZKpPgNrattyFpjUfu29UPF4etzqJNjZ0R2VGJ4os=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(83380400001)(86362001)(478600001)(54906003)(16526019)(186003)(70206006)(36756003)(70586007)(356005)(6666004)(5660300002)(7696005)(316002)(2906002)(1076003)(4326008)(8936002)(81166007)(82310400003)(8676002)(82740400003)(36860700001)(6916009)(336012)(47076005)(426003)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 05:46:20.3447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3037135b-8a9e-46de-fe84-08d9728bfc05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 54 ++++++++++++++++++++++
 3 files changed, 64 insertions(+)

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
index c076a6b9a5a2..67865f6a91b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -429,6 +429,60 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 	return ret;
 }
 
+void amdgpu_ib_test_destroy_bo(struct amdgpu_device *adev)
+{
+	if (adev->ib_test_gtt_bo)
+		amdgpu_bo_free_kernel(&adev->ib_test_gtt_bo, NULL, NULL);
+	if (adev->ib_test_vram_bo)
+		amdgpu_bo_free_kernel(&adev->ib_test_vram_bo, NULL, NULL);
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
+	if (!adev->uvd.address_64_bit) {
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

