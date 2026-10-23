Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C4606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4PiyarUc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7631010E5BD;
	Fri, 23 Oct 2026 08:35:00 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098F010E5BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvxKKmxIRPwOoutxRMgR/s855zOx2pgYmrQsoLm1D7CkEMlz97TRCx8vl1FZlly7uK5V8tSxPHJPD7nimBuIicSMzGi3HKs63gEdMJ3gZxxGhzZ4FyfCAVvsJENdY+2NkgDP36VhF+bvnRx49nyz8dPnyRZJDAz7tol4xNKkApDuTHwv72GbT7zpyUkSYIjzbv+X9XN1jdpHQm1UHx0/6WXl+kkkbV/7rpE+n4xZAuEjv/HrCFTJbnlWuuTtlw8OzQSZRl92n40hSzAXC5+Xbfwa4fJhCK6OmJcy6dKcOslYLF5HHMrRKEqqiwTfBVkOb685+12bxox2urTVRxzFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSUWFSLpTu8w4DmE1Njj3LKLwL0/cdjkfhxmbiEa2Vc=;
 b=GGj9Qh/z5mrhXbT9qNgmBmnZq1ApebcdsBYN5rVKDr7cGJEIksqdY2XaCAYemuhsSQ1OXYqvjlSY/FxIsmO+FvqHgZhwD5+pI03Hc8okbHdLYhc9MS+Z6dcEOy5LYCvLD3S/4gvMRkvUue/oqsG3GC9QTPqHlqftx3psW9j/0WZAUm1+is/DqmN0xGcWtk4lbFUScfHeDOLB7qzUQ+issiT5VGWVQYCt1NXwdkL2GYUGBrh/yPlrX/tICsCh0XA+KmtWLwsdrwcQjGe3PNf+j0ajvNH5qFsdAA7oHEcYnVQzKZNFKe5ZawColhzAYqTaj2EmQo6vKIcGI0lQ0DoAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSUWFSLpTu8w4DmE1Njj3LKLwL0/cdjkfhxmbiEa2Vc=;
 b=4PiyarUcOeVRlly2h82KP5hByw3I6vEcvpBlcLuhadp6xa8wnVk76DWkvNUleZvNaqHUekWsLCOG4nfDFE0IwI2DvlZjYj8oKCVuVYgVYQMQ/9Jd847mlxTNAqpflHE7uGHe4P3hYUIezW3+RaiLFNgg3HJfzmO4L0VThkv+lKI=
Received: from BY3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:254::12)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 08:34:49 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::3a) by BY3PR05CA0007.outlook.office365.com
 (2603:10b6:a03:254::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Fri,
 23 Oct 2026 08:34:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 8/8] drm/amdgpu/gmc11: don't access the fault registers during
 GPU reset
Date: Fri, 23 Oct 2026 16:34:22 +0800
Message-ID: <20261023083422.3049246-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023083422.3049246-1-Prike.Liang@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: 471ddf43-595c-4759-5fef-08df30e08046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|22082099003|11063799006|56012099006|261022075727099003|261009223027099003|261022105027099003|10067099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: oTywNLxA/p8tsCCFWJ5LMv7apLBEjyBe1J6G+7Mi53u7+R//GkqCvV6xtBvF2wiYFXhHayaP4lwXHVihjA7N8J9tpnOIH6x39k6tQre3hOWr4aORCPDkLJMnZEMSNGlXn4E30GrgluS8AwNCIT5qs/A6YPi65DjmdgvcC9xoYepyD/RUn1e0C85R1y2X+GeHYUGH/DHFLoMXt3t9DzjcmXRCbAruCVpyNF+0x/z6l2cZjNfxERI2Mgjw+Wdhv3sb0B9Vmh9deX8AblAzlzW5jyg/sZmw+dmSJ/ofT71s9aIo3+uCF9LShFMYy/IiyrGnyI3EKI2N16R/3uhQlhpCl/RnFIrx3NgSbFFQAgF5C3v/XTAFDk1cus6BesAGWEbIPssuD52ux+AWZgaqhWU8qA4dFHt0o5h/GE3mcaPiRLBaGVuOFgWh5nQEqYbVhE5kuW5arw5XJFzHe+F+yPeY4W+6yoAKATIvt1+jkbq2RE8AWo7PbePyKgaA9w1IK7MBz3LzFnQn0yFGrXQie3fJt/uDMTgWTQUjhDytguVsytW2ES/oYEm1WynqMltjkAGzK9MTipnEb0XQmHPA2NU/VGwK60d/V8S/4Whw3VDQYHNnPGGd3Q2C+LJHF+pXZkSULVbZJ2f+Us2k2cBQQseR8xpaSQRDng3To4boEZJA0tmR9dRA++6lSBM0SQ/W56KMr7EyD3f7xNFlAcPM8CgTYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(261022105027099003)(10067099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xMvmpgplZnAdP+rY3tOOwOy3XkPCAw5puJavoF1Gk3pBLnV2p900x0jHosEzGpdwPugY8BwlwjT9ne8RfRGKYfAHAO+bM1HCrF1BoVpVpviEINzqEIlPM+SMUotZ+ftJeQWjB/1H70WjTSZBH/jcHV3PyjyzIH6WLsqjITE1dBBb40abFWok84XEvIJy3jDbbdmjqqXpTsMv415qIpQeaFJkm/84rIUoFd7ihLCqNlJamaxoj2yYjZBepLGy1bTf99TjPrQbJD6Ce18tJW2xv7MZwTVtsPOHUeCjinDpvhH4hfB6I2I4NgwY/CbtshEuqO0Bv/BYF9JRyBHw415FykRqpBvUX/BATFraz8xztC9DKFsapFm8E7Rxz7Mrrpmc84V40ElCs2KcMpqL2YQ1XOJ2vISHJgTL4JhjZ7YNKvnQ/bTcaHVaZboOP5Mg3M/q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:49.1573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471ddf43-595c-4759-5fef-08df30e08046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999188
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IH1 and IH2 are processed from a work item, so a VM fault delivered
there can read and write the VM L2 fault registers while a GPU reset is
running:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_irq_handle_ih1 [amdgpu]
  Call Trace:
   amdgpu_device_rreg+0x21/0x50 [amdgpu]
   gmc_v11_0_process_interrupt+0x241/0x250 [amdgpu]
   amdgpu_irq_dispatch+0x12d/0x2f0 [amdgpu]
   amdgpu_ih_process+0x70/0x190 [amdgpu]
   amdgpu_irq_handle_ih1+0x23/0x30 [amdgpu]

Trylock reset_domain->sem around the register access when running in
task context instead, and only print the fault when that fails. The
semaphore is held just for the register access, so the reset never
waits for the fault handling. The hard IRQ path for IH0 is unchanged,
the IH is disabled before the ASIC reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 709c3d1b9998..bc3b1ffb5488 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -108,6 +108,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
+	bool read_status = !amdgpu_sriov_vf(adev);
 	uint32_t status = 0;
 	uint32_t cam_index;
 	u64 addr;
@@ -125,7 +126,15 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 	}
 
-	if (!amdgpu_sriov_vf(adev)) {
+	/*
+	 * IH1/IH2 are processed from a work item, don't touch the registers
+	 * while a GPU reset is running there.
+	 */
+	if (read_status && in_task() &&
+	    !down_read_trylock(&adev->reset_domain->sem))
+		read_status = false;
+
+	if (read_status) {
 		/*
 		 * Issue a dummy read to wait for the status register to
 		 * be updated to avoid reading an incorrect value due to
@@ -137,6 +146,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+		if (in_task())
+			up_read(&adev->reset_domain->sem);
+
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
-- 
2.34.1

