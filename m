Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C85C761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7645710EB77;
	Wed, 29 Mar 2023 15:48:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAFA10EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GINOPPI6tx9VqsxCOzOGNlNJD3lxiAlvEtKZWhfvB1LUway2IFUrpQll7xtpWH4eGsEbfqBrvO9CgMiu20qs+IVdHuggK+Dp1AvbqLmab5HEgdgsAw3rFD6ajRi8+BdwirVOjtX5PS1g4NiiIzjGVWIIPSywlL5jpjZ7/pTjv4BB52LE3yYTXHnDEYHpTznQckcgxbZAs41ZoYUAMSkfYY6X74buJ8xu8GGvJ+fgaqUu/NH9v8WMQYJwpHWhTpfxH86/ldIHIljWWuXMAVakkxIjcOIFtnvR1Ts5PIHIwuYjri10mwIXLiR8mxQwkeiwnp7X6MZ8IgfEA8ddbKuq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEVtqYIxR9yBZKh+4dvmHvh3WJ9Cm4t9JGXvKD1s/yw=;
 b=Wl7Voo7U1fOR6mgnEjKX9MSIbyBpcYBwgb3F0xXDj3N7mJVSA8u0/IJJCH5j5mrnYKPTL/EoqwHtYDB9x11abgVqDjYKqPvdef2hVGyUPRYSpHU+N0Nj6wNTSPJzXcp+xWzGSKqa10RC3Wr+cQTM2ohxU38RNP8553Fnz+lX2CnxWGtVptZGi2E7docia+ikLpBHxK/rltxqvm5lUmiaYHTs6whbm8nTkScS6RoPGoOUhQiDYg0rOWpOxnKVTkniQXIp5ru3KBYTDctUg56TjBW0wo0rx4jSUmRDqLIWa0GldgC542kqQjUE4/ect4HW9e/5nItHL9+CvHW8KxR5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEVtqYIxR9yBZKh+4dvmHvh3WJ9Cm4t9JGXvKD1s/yw=;
 b=DPpXxrlWMLCSxbTCrTP2DCNDXf7XyaXquQ2yl5mddxMEoTN2qvjVRXXMsZTm1SBHJTTDYICm+4mIXhXMT66W2UzvzVP/t0KOq7rwrq98HQSWCGbXv/j96UXMsORxS6s+CZsB+oQxJGYHs/zBR5q7hnW3JkVUGJLDW+NS1LQE0BA=
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:48:39 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::e) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 15:48:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:36 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amdgpu: remove ununsed functions and variables
Date: Wed, 29 Mar 2023 17:47:51 +0200
Message-ID: <20230329154753.1261-15-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfd8ed2-0dda-4176-33c5-08db306d1078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSk86i68EOgjGk/NuP0hd+UHGTDp82WH//aW34CeKtkm0ydGKesobqIrFkU4v8izf6WIEk2FXhcyKJmRnNnHX6BBXEucgtKeT8hsjsFvxjXc3mi5imrDgGOQZ/L24OVYXqJlryulgVXiKJL3Ku63+qECzrIa/984KP7kSo1ozbo++L+PC6cvqDWwZWMi/fzVsKTalbP+m7vMzx42SHoanNtf2roOxf3W7HFA7Myapg7LmHSqK500FFiHKTQbabzaD2HrWruqg8pNFoAwCiGtYrGxUJvs8tOUlCApnfXMyDU9BCDW3BNb20Fsx0RhfN2Mz7bO+YEFMHUuvweAVawQE1qKeIAU4LT649i4/gX6co9VW1413QlnvNkKmA9VFiy9e8hhwrmlaIb9mDmpJ0/95VnRFHFqf1hMoBGa0gplexIjpF+WKsg2NIP/33MnWZvc+2Kwt/KNMq8DgM8cHugiBGaiiGqjlNWmUY09d41Ed2RZX5BEw/8FgZNzO9nUm3kgigOqmM+kOQ1SXzrEdCq30hG9VBUbnwsWJ3Ns7htvGQ/62BbXuqZzXp75LwszrcuVsUly/CJP7imokUEFwuCiqIoIO2V/nhfcIjqu9bsqBr4qQ0PgkgI76iE+QKhgmMvc3xLveBc78ifDRZoa6UXgZ1Ny9eXnr1zWkJa9Up0U0V3p7IaCEwfw4ThvJwhesC32U474kKB1ECNvhsJsea3J0Y/5+JIh6xxG3EzfbZLEKr8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(70586007)(6666004)(26005)(1076003)(6916009)(316002)(54906003)(478600001)(16526019)(36860700001)(47076005)(336012)(8676002)(70206006)(426003)(186003)(83380400001)(2616005)(81166007)(41300700001)(356005)(8936002)(2906002)(4326008)(5660300002)(44832011)(40460700003)(82740400003)(40480700001)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:38.8157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfd8ed2-0dda-4176-33c5-08db306d1078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul
 Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch removes some variables and functions from KFD
doorbell handling code, which are no more required since
doorbell manager is handling doorbell calculations.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 32 -----------------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 12 ---------
 2 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 7d29653bff81..fecf68976ac8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -194,38 +194,6 @@ void write_kernel_doorbell64(void __iomem *db, u64 value)
 	}
 }
 
-unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
-					struct kfd_process_device *pdd,
-					unsigned int doorbell_id)
-{
-	/*
-	 * doorbell_base_dw_offset accounts for doorbells taken by KGD.
-	 * index * kfd_doorbell_process_slice/sizeof(u32) adjusts to
-	 * the process's doorbells. The offset returned is in dword
-	 * units regardless of the ASIC-dependent doorbell size.
-	 */
-	if (!kfd->shared_resources.enable_mes)
-		return kfd->doorbell_base_dw_offset +
-			pdd->doorbell_index
-			* kfd_doorbell_process_slice(kfd) / sizeof(u32) +
-			doorbell_id *
-			kfd->device_info.doorbell_size / sizeof(u32);
-	else
-		return amdgpu_mes_get_doorbell_dw_offset_in_bar(
-				(struct amdgpu_device *)kfd->adev,
-				pdd->doorbell_index, doorbell_id);
-}
-
-uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
-{
-	uint64_t num_of_elems = (kfd->shared_resources.doorbell_aperture_size -
-				kfd->shared_resources.doorbell_start_offset) /
-					kfd_doorbell_process_slice(kfd) + 1;
-
-	return num_of_elems;
-
-}
-
 phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c97ed8e7e02d..9c3b31c148b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -257,15 +257,6 @@ struct kfd_dev {
 
 	unsigned int id;		/* topology stub index */
 
-	phys_addr_t doorbell_base;	/* Start of actual doorbells used by
-					 * KFD. It is aligned for mapping
-					 * into user mode
-					 */
-	size_t doorbell_base_dw_offset;	/* Offset from the start of the PCI
-					 * doorbell BAR to the first KFD
-					 * doorbell in dwords. GFX reserves
-					 * the segment before this offset.
-					 */
 	u32 __iomem *doorbell_kernel_ptr; /* This is a pointer for a doorbells
 					   * page used by kernel queue
 					   */
@@ -276,8 +267,6 @@ struct kfd_dev {
 
 	const struct kfd2kgd_calls *kfd2kgd;
 	struct mutex doorbell_mutex;
-	DECLARE_BITMAP(doorbell_available_index,
-			KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
 
 	void *gtt_mem;
 	uint64_t gtt_start_gpu_addr;
@@ -748,7 +737,6 @@ struct kfd_process_device {
 	struct attribute attr_evict;
 
 	struct kobject *kobj_stats;
-	unsigned int doorbell_index;
 
 	/*
 	 * @cu_occupancy: Reports occupancy of Compute Units (CU) of a process
-- 
2.40.0

