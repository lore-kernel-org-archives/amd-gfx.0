Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB497C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6C764EE3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6C764EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99366E45D;
	Thu,  4 Mar 2021 03:45:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680043.outbound.protection.outlook.com [40.107.68.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5E36E45D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 03:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3bfmQQbprj6qeqH9jJQQnnd6Fr7lwXjCC3Cc7ANZLVlAn2XCOA0XM5yt7ughhwW3PTtr+zeQ4Ume+QZ+L7mrU8mJgyzf/xOvUBEWhKDIh+nG3FIbgGOjdaHzvy+Rrk2R6clEcrnSPNiqhN4uDvT385In6QQ8MKq+eE8RBflixi58NWVZFqIyanBznr1D3KMBq8neVvqWHn5Z8N5E/e7SvsFdMcXAHd90zpTqIZECAW6GdB1KSeNp+SB4oTtrobqeyOg3KVrHR+GXO9CSGP+UMjumiPfZIuwMYUzJZP2q0ZApYWyMHTWrSaGOJS9G1s05DrcLzCaKO/2aWaeg3RXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZReqH/Obr63AVSktkI3AUAvKhsdwg8YaoC8JNdsvmw=;
 b=VsComygJ2A4357EtzMH1irn295TiPag/Nt26JBbuwS4rHdtDpuGKmlLcLvL3UreXzAtBnSEyOjI2UEmhlA+36O2XRhwq3/pYrPW2b9NVKiAIh6B52Lgmo1hLL5X29tRqaFJ04P1yBJgk2LqzJxALOf1OQn28IaRCpaPd9BRXS0bRGH7PWj76dvnrcDo7qrfcFveVKhETLTh9EXpeINJwW4BVcSJORrtgT15WLW2mYAk6iLJsMmxUObwxgAzoBbYiEMjl3aUWZGsZR/aUACbiA8xH30I9fE7WRoXpgaXtjn4leAYIbBoWmvUcrPC2ctitwhtlQ3GH89l7JqhP/PzC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZReqH/Obr63AVSktkI3AUAvKhsdwg8YaoC8JNdsvmw=;
 b=D5s5TfbYqM4ZJeNcw9W7NaspMLiDW/kH4ukRkjyi5aQ56xWGRmHex58VrvgyT+4aK9wRDgZc4xzL1c1FlMkdDcH0+4/i21/2SkVvbRl7goEf488zvDjROcxGiC9VQ+3bhwe385FMRuH2yWpAjh51TNCRy0Lm9f3pUbkbPs6cvEg=
Received: from DM6PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:333::31)
 by BN6PR12MB1348.namprd12.prod.outlook.com (2603:10b6:404:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 03:44:57 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::22) by DM6PR03CA0098.outlook.office365.com
 (2603:10b6:5:333::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 03:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 03:44:55 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 21:44:54 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 3 Mar 2021 21:44:53 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Date: Thu, 4 Mar 2021 11:44:50 +0800
Message-ID: <20210304034450.37535-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88992672-04be-4332-d810-08d8debfe036
X-MS-TrafficTypeDiagnostic: BN6PR12MB1348:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13482DBB8AB98D8AC3AB1194FE979@BN6PR12MB1348.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSmYdFl4r+YWc4P5BN+sHnNLPB6tGQwLJ/pEvnqpmTDPrAKti+23nRPX4hLu2mdSDZZ1svlI+4AEyZeOpJLH2sMK87E0RkPGPEX7jscEl/JgTm9pnI/FRs10/a0CfJAY25ptCpUgMYXtt+xsj7Tr//Sm2+ZURm7uIwvEVZvRgapjKev3xJzpjgydpHnUYlMXhunfq/v6UrxPDtMkaHPnDfZiq7LALnSdccCeyS4NMXmNEZR+LB/+bYho38tcggFImMkqxKFWuZ1gQU4hZcIQ4jyOLcWZIqSMRmeN1F+NXWbjbICMnmR5Yn7XglD1tGDde2+myEEPyiHZgQL8H3aVpdQB8kv+qO1vjxjI5Zp/8t4TCuKr4SndQKkDCwKUCkEQQcduNfBzylsA8vfJmprcoQQ8qaWEdj38EKUJCsTZ4/+GVzjrtlzooBYv8J7N1VyxlntdgiammzuuLOIKixyxOmyPGWoTWg6G9SeJ9ErwhZME2ZGTuXQ1i//TBLHqLMC+8TdacxK0hDemQxIIAzk8r+zXayOPwRDfMwk0LB9wY4cN+8Dl/h4KSl+IVyP82C+inYkGQMpLfwgGK9WzTGlA1vuHIC+Iao7Mmdh2FMstWdYaw3iMNeYALvV5F1XpycAwCgRGzEhb1q44vcu6KaQ/y3oTzWwzCRGc9u3MOSGqZGsYELULsqDR2ArpJblp0uds
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(83380400001)(8676002)(1076003)(186003)(6916009)(26005)(47076005)(356005)(82310400003)(2616005)(86362001)(36756003)(2906002)(426003)(81166007)(478600001)(336012)(70586007)(7696005)(4326008)(8936002)(5660300002)(70206006)(82740400003)(36860700001)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 03:44:55.3416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88992672-04be-4332-d810-08d8debfe036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1348
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add VM_HOLE/DOORBELL_INVALID_BE/POLL_TIMEOUT/SRBMWRITE
interrupt info printing.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   5 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 119 +++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index e5b8fb8e75c5..f8fb755e3aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -64,6 +64,11 @@ struct amdgpu_sdma {
 	struct amdgpu_irq_src	trap_irq;
 	struct amdgpu_irq_src	illegal_inst_irq;
 	struct amdgpu_irq_src	ecc_irq;
+	struct amdgpu_irq_src	vm_hole_irq;
+	struct amdgpu_irq_src	doorbell_invalid_irq;
+	struct amdgpu_irq_src	pool_timeout_irq;
+	struct amdgpu_irq_src	srbm_write_irq;
+
 	int			num_instances;
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..3305b8ec5025 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1944,6 +1944,33 @@ static int sdma_v4_0_sw_init(void *handle)
 			return r;
 	}
 
+	/* SDMA VM_HOLE/DOORBELL_INV/POLL_TIMEOUT/SRBM_WRITE_PROTECTION event*/
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_VM_HOLE,
+				      &adev->sdma.vm_hole_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_DOORBELL_INVALID,
+				      &adev->sdma.doorbell_invalid_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_POLL_TIMEOUT,
+				      &adev->sdma.pool_timeout_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_SRBMWRITE,
+				      &adev->sdma.srbm_write_irq);
+		if (r)
+			return r;
+	}
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
@@ -2198,6 +2225,72 @@ static int sdma_v4_0_set_ecc_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
+					      struct amdgpu_iv_entry *entry)
+{
+	int instance;
+	struct amdgpu_task_info task_info;
+	u64 addr;
+	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+	if (instance < 0 || instance > 7){
+		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+		return -EINVAL;
+	}
+
+	addr = (u64)entry->src_data[0] << 12;
+	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
+
+	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
+	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+
+	dev_info(adev->dev,
+		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
+		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+		   entry->pasid, task_info.process_name, task_info.tgid,
+		   task_info.task_name, task_info.pid);
+	return 0;
+}
+
+static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev,"MC or SEM address in VM hole. \n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev,
+		"SDMA received a doorbell from BIF with byte_enable != 0xff.  \n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev,
+		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev,
+		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer.\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
 static void sdma_v4_0_update_medium_grain_clock_gating(
 		struct amdgpu_device *adev,
 		bool enable)
@@ -2515,7 +2608,21 @@ static const struct amdgpu_irq_src_funcs sdma_v4_0_ecc_irq_funcs = {
 	.process = amdgpu_sdma_process_ecc_irq,
 };
 
+static const struct amdgpu_irq_src_funcs sdma_v4_0_vm_hole_irq_funcs = {
+	.process = sdma_v4_0_process_vm_hole_irq,
+};
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_doorbell_invalid_irq_funcs = {
+	.process = sdma_v4_0_process_doorbell_invalid_irq,
+};
 
+static const struct amdgpu_irq_src_funcs sdma_v4_0_pool_timeout_irq_funcs = {
+	.process = sdma_v4_0_process_pool_timeout_irq,
+};
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_srbm_write_irq_funcs = {
+	.process = sdma_v4_0_process_srbm_write_irq,
+};
 
 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 {
@@ -2527,10 +2634,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	case 5:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		break;
 	case 8:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 		break;
 	case 2:
 	default:
@@ -2541,6 +2656,10 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->sdma.trap_irq.funcs = &sdma_v4_0_trap_irq_funcs;
 	adev->sdma.illegal_inst_irq.funcs = &sdma_v4_0_illegal_inst_irq_funcs;
 	adev->sdma.ecc_irq.funcs = &sdma_v4_0_ecc_irq_funcs;
+	adev->sdma.vm_hole_irq.funcs = &sdma_v4_0_vm_hole_irq_funcs;
+	adev->sdma.doorbell_invalid_irq.funcs = &sdma_v4_0_doorbell_invalid_irq_funcs;
+	adev->sdma.pool_timeout_irq.funcs = &sdma_v4_0_pool_timeout_irq_funcs;
+	adev->sdma.srbm_write_irq.funcs = &sdma_v4_0_srbm_write_irq_funcs;
 }
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
