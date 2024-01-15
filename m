Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEBC4707B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5BCC10E3AE;
	Mon, 15 Jan 2024 22:51:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DC610E3A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8me1Pdvpy4c1kFX2djPhs5ii4suE1JYCKRpsjUryY3GRGgGXznxcboIaqF2CQozdHX/zAQgshjWuqfP89FWdgrFnYwh4OiES42RzthbJiRXdUpDm/Xe8HHViacq5Cl5CchEVgfBchFml8twXY1fZhnTUJ7yBIwE61zR0XdXlS7nypGgBP9F1oqZODdEbcWTDztZpyEqFF8cXwHvfITGBOcaZkq5tw80xRL71wnx5lvURMr9ioyIE5AKombD5b1f3h1YMMtv2DfxzxptpV8OJnVekH3A/Fe0rpgff7NpbfRnhmGkr1+dLGxblBjYu16+PnhkRKExXtHuM+2wbM/PsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05vREdtaHS54D+3nRtYSNkTcMgYatZCpaJ4Cy3CdXO0=;
 b=Hd/WYCLUDCi7Kxigsb/Dty3eLfTMcm3avdKQTG0AG1ZL59kybuckVO91YDK0NeD7xL06qazpRxyCuELKR7+GoFzkgSn1CZq9AXg91Sqdt9xgf7UOwAp/tJRd7wU05zplreiQQnQiLO0bUH1jYkHZQEACd7mOR+MazIpVvXgIovKa+wRHWervF7nQcRgvmztaSYwJ6AyBCRQ0w43nCdSxKos2P2wYHnds3FS6EamgGuZMqnmSi2h4AI2rzujde0vNmSp1SCejSt3QWGGXYIjLkWhHRn7UZOsxAhEJIpyVCJys4WU8bIZjif6kQ4iFA3yRve6vKKQL7LwspskVlgUJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05vREdtaHS54D+3nRtYSNkTcMgYatZCpaJ4Cy3CdXO0=;
 b=G8FAtYMRdN/obu1ssx1pvRc8qYOQ7h+y+U84qjns1cxvH/oAndkFMG5YyvvzvBL9P6tr42RqIiAcIc+GeQ++5nYsqHnsSLeHGAtNxz1adhiYOKyFXPObhe/c5WWzq2P/jn5F71TAExk9Zu3hLsC+J6/7kyhHkoHNB/wX4ma5sxE=
Received: from SA9PR13CA0170.namprd13.prod.outlook.com (2603:10b6:806:28::25)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 22:51:25 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::82) by SA9PR13CA0170.outlook.office365.com
 (2603:10b6:806:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.17 via Frontend
 Transport; Mon, 15 Jan 2024 22:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:51:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:51:23 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 6/7] drm/amdkfd: Check bitmap_map flag to skip retry fault
Date: Mon, 15 Jan 2024 17:49:49 -0500
Message-ID: <20240115224950.3300-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240115224950.3300-1-Philip.Yang@amd.com>
References: <20240115224950.3300-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: bfabc1cf-dc45-4679-ebfd-08dc161c8078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neQqQsGUjhnEFzO3fshVkjouIaippbN6skiHbBU0BOZIWfZP8tCHFcQV9BrSDXLrCC5g8xhFuvslaiNWBTpNerBs9iCpZB7GUOFzp5wuGDOhmxEK80MLAF7xGBPyhy185fyxGKZqGxhtVBH1gRiwpWpDKu18A1+gW1Ohi/+z5oL4K1RBsfri2NMqyNvHqFY8HTwAP3mjkcL7gfZK04LNDhEqTSNEMeMDVkRSHsOwy+XEhyCuP6iPkqWAEhnyGaEtDw5XYnufEcHzwToVr7XyYVPgZQKnAV/B/1dHHoU2XqYPAlb93j5xe0TC/L/uVZFU9Wr2mAIFlxiRckyvV+MbVJ8ZE8M45a4LfAlijE3yya1beZXLVn0pEGHQ1jac55J3UsYVDtveNYKvG5NyVyrk5CfmpaHp0Sk4D5D1suInWDE6BfO3RPBdJdVEsO+8xvUpOdkKNoyV81YVRzLbfrZKQROmD1Bb0Rjt9KJzeW09pIYKVbKjv34wCBsJuCeZfVfINJTYPY93js9izyR7zP3BaO5nX6n9f8Anldh2+APWtK9Zv1Kl2SXCK9s7DfJ07AB4fULg0+K26nh1oTct1PJYt1WtMRBh9B56Vxy5nvV6Flp29anDF0eMA7jgRWNAizl5uvXwogm+qj3SLYzjHkpK0XrppzsPWzMi4q/a1xw6fhCtVKiffNxylS5Hm9wk84HZtV34HGaRHAA1JmZ8LgJn+k1QyopmkQxk0zPCJMgY4tXNNIr1PwqGhrPobO7vuWdCYtxfm520YTJ9Zi7S+jxS/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(2616005)(26005)(5660300002)(1076003)(16526019)(4326008)(336012)(426003)(2906002)(478600001)(6666004)(7696005)(8936002)(8676002)(70206006)(70586007)(316002)(54906003)(6916009)(41300700001)(86362001)(36756003)(36860700001)(82740400003)(83380400001)(47076005)(81166007)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:51:24.9446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfabc1cf-dc45-4679-ebfd-08dc161c8078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove prange validate_timestamp which is not accurate for multiple
GPUs.

Use the bitmap_map flag to skip the retry fault from different pages of
the same granularity range if the granularity range is already mapped
on the specific GPU.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++----------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ebc4cce801bf..b36d997e7a3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -45,10 +45,6 @@
 
 #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
 
-/* Long enough to ensure no retry fault comes after svm range is restored and
- * page table is updated.
- */
-#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
 #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
 #define dynamic_svm_range_dump(svms) \
 	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
@@ -380,7 +376,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->deferred_list);
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
-	prange->validate_timestamp = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -1965,8 +1960,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	}
 
 	svm_range_unreserve_bos(ctx);
-	if (!r)
-		prange->validate_timestamp = ktime_get_boottime();
 
 free_ctx:
 	kfree(ctx);
@@ -3226,15 +3219,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_mm;
 	}
 
-	/* skip duplicate vm fault on different pages of same range */
-	if (ktime_before(timestamp, ktime_add_ns(prange->validate_timestamp,
-				AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
-		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
-			 svms, prange->start, prange->last);
-		r = 0;
-		goto out_unlock_mm;
-	}
-
 	/* __do_munmap removed VMA, return success as we are handling stale
 	 * retry fault.
 	 */
@@ -3260,6 +3244,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out_unlock_mm;
 	}
 
+	/* skip duplicate vm fault on different pages of same granularity range */
+	if (svm_range_partial_mapped_dev(gpuidx, prange, addr, addr)) {
+		pr_debug("svms 0x%p [0x%lx %lx] addr 0x%llx already mapped on gpu %d\n",
+			 svms, prange->start, prange->last, addr, gpuidx);
+		r = 0;
+		goto out_unlock_mm;
+	}
+
 	mutex_lock(&prange->migrate_mutex);
 
 	pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a10eeb77f83e..5a9688d5c18c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -129,7 +129,6 @@ struct svm_range {
 	uint32_t			actual_loc;
 	uint8_t				granularity;
 	atomic_t			invalid;
-	ktime_t				validate_timestamp;
 	struct mmu_interval_notifier	notifier;
 	struct svm_work_list_item	work_item;
 	struct list_head		deferred_list;
-- 
2.35.1

