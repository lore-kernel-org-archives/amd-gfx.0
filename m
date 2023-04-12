Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E0BC77B72
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825E610E8AD;
	Wed, 12 Apr 2023 16:26:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555BF10E8AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj+mDkI1/vwLlxuZrZFZoeVyk7irQYNqsc5ulAx953F3X5ZJlOISUa+UWTTG50LQaFsciJJ8nIxp37RzFNa4GvO63/wRhNkPecSNCBUNW1shnedDNPpD4Jk2s/f5hd6rxT005KzBZDNVQPHhhPR6GOlpecskfHMC7PExDuY+V1nMHZg+Nlco6FWlxXuLQ/5FDzAOOw7Sj3JksPuWrLwJuKujxVPoog6tmkq7QFk3kb9GX1wcQl9DNUkmyN/FyUwS0Xv+c5N3TgUCSZArW96H0/3hiRDabs++YwCvwzQZUl+V39QcfHPI79kCdIEm2jNc667tnJ/cTVId1wZP+qUhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3JbGtMFhoaRSYEPMJRWmHebQDcXO3uc11jJuEFqDvs=;
 b=QjYWUcv26dioxofSgcCV3qBvVkkTjUBxmN/0X6FhoceTYprMbUP3wWGsiIuYcFgaBgxyf6NcffjZVeQ7Ui7fol527psPUGfY2sPPUayC8d43Q8VlgVq9lNWnLY0uk1a0zBeSrbVxQDJOefnAuSUDgF8jXqEu6dqKqQIcVOdTW6g/tD//QfwSVcIViKj0cz0TudZ4e91YUuZTZpDs+dsL2SGAhK5BVO2bIPIZm/qFW8oQ4KuiWX3wgdq7/dpUe23ZAipYy+W1+5NY9lZtkzc9j7PLrp41yLVpAR8z02CnpJw6nlZOhL1n4wk9i7iUu3humFB3m6xGIKTHgZwcKKAYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3JbGtMFhoaRSYEPMJRWmHebQDcXO3uc11jJuEFqDvs=;
 b=KkldmTmtPTZpeZ7wuyMogps1sgLsk8MWfwOryHHQ8Hwv36MNWGBH+3fN7rI73M1ma/7wzn9vE18ySZf9YeKVmWrNpr9QHB8UCRnlqjsCzXDXzoSq96S5AyYqPScSD+uF3MNC5hm++CPlBiqLpg8cs0pf9kNoMNF+KXRoKGHKX+k=
Received: from BN9PR03CA0423.namprd03.prod.outlook.com (2603:10b6:408:113::8)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 16:26:39 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::3f) by BN9PR03CA0423.outlook.office365.com
 (2603:10b6:408:113::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:39 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/12] drm/amdgpu: remove unused functions and variables
Date: Wed, 12 Apr 2023 18:25:34 +0200
Message-ID: <20230412162537.1357-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|CH2PR12MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c0f2a1-e2e4-47f6-9393-08db3b72b171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8Y99ZUY9Yz3QCSLsDrl4+URfkn0OMTJkQz+VceKGOwZVBDpC3XKki0feCsc/BvwLbsaaTljQ3xaOra4CEDfPInaY1EK8mCbmO5AGkgZZ3f4yrsvobP2Q/1+FNdpWcQMVPfmmxFshhMZkOfwhx6HQH0SP7/4uEVhDxdBm8z7is/pxKAXXQClbr36ACnHKUhzqrqg4/CrYDtz7p5ZniLU6jGNRkCKbqBpewrJiq3vTzSe3BRJfcCHjhRCYZUPhfV82Tejhs8bwHM54vi6ixAl0/LKPQSQ2qeiZRlK7DchKN+gta34ygCLU3nJzt4LJS0GVgPtIWxZa4LVO3W5v/wrnidFpuYZRmwDv/RWxNCXZ6W/SePDPyafnB05mAqrqyrZIMQNjZcr+k8Pm2/D6GvI2aDFHaEA9YlCX5Kbc4Q932NYlSSkhj9VfI5jEFUBlp0FgLnd9fn31GOspQncvhrD8hKusSWkmFmyJZQgx2x8dzJQ2LIIe18UtIVpSkZDX35vJzUnjy5uZNrjoh00+1dtpBdlRrKLPs8+Fmig+evCFMxXOETxX3on8W2MOway4ORnLU9Kojqvwd8/ySn5FDkcBZDHVDY26tqjrfXULn7JWRo9Wr1wOxOtExSwuhW8bNn2WaeUuxAJy3YT22/yUIJHvgF21PAPX+c/Y5NoB37cx3WE2S7vfLseDh72nu1oSWIgMLQbS7cwrvJaM61QFHNULk++JWV3aSntXOUCCgnkBLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(186003)(426003)(336012)(41300700001)(26005)(1076003)(6666004)(81166007)(2616005)(7696005)(86362001)(47076005)(83380400001)(478600001)(54906003)(40460700003)(36860700001)(6916009)(5660300002)(44832011)(2906002)(82310400005)(70586007)(356005)(70206006)(4326008)(40480700001)(8676002)(82740400003)(36756003)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:39.2065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c0f2a1-e2e4-47f6-9393-08db3b72b171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
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
index 718cfe9cb4f5..f4088cfd52db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -193,38 +193,6 @@ void write_kernel_doorbell64(void __iomem *db, u64 value)
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
index dfff77379acb..1bc6a8ed8cda 100644
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
@@ -754,7 +743,6 @@ struct kfd_process_device {
 	struct attribute attr_evict;
 
 	struct kobject *kobj_stats;
-	unsigned int doorbell_index;
 
 	/*
 	 * @cu_occupancy: Reports occupancy of Compute Units (CU) of a process
-- 
2.40.0

