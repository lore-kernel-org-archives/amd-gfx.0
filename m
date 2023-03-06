Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A93CC678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 07:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3423D10E063;
	Mon,  6 Mar 2023 07:18:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53D610E063
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 07:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyD58tPrDNbw2idW5qYOnmkHPXvhJUNCmAV45Cehuvh1449kWE2xs4yxUKVUG8iFtGoDKAGLNnKs7Vodt9+eXy7wwJA4/SXZtDclMcy/ugaQGU42rr4Atlf20p7do6vrozEtaBUWtgx+DU8N3MykCguZXbn81h+m3d8+bUYDsvV6828y7jUxigG+Vf2cCpMEIR82yT9RV2sNBXep9lI4hGjT19QOYlVnu6J5Z433ezyGCI+VBY0sg/LXA2Ob1Xzek27qwseVv2q2csX+epFkCQ9g6rmUpW4UKfvhqIygoS3kJcfxkiijclt9Cn8UUz2tcvpnQelPNh6Om0ZYuRpjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpS504Kv7TwscpvS/BaYDwqAbqLs5XGRKhAhc+iThPQ=;
 b=UA19T7fIVZ5crirP4kHODdFn6MhA5sxVuU0/867ZgObCU38+MPhCTNrtePAYnDOiAUlsg+3PYsjtmYNQOatkPmvlvG9WRP79odIm2zpcbUp6b63+SKgEknvE7AlF6+PwKfix6HYt7xgWfq2n1TK5L0ysae4/DELB7vytX8i8ANY8Ar5HFw90ycChbk+9T7hDQc3nu2Y4xV4W8vZgGX0NXCDQDmS7/euU9uUYvYb6JxnmeSTfZTDt/Mbw/a9r/vZc4qBO56xsP/58sa0NQih1e+G+0nucnmV1cc3lPtq/8HDK9bmS3HN3v1PCTUjP8RsDXJAKQpdxjxwXTZSp74nyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpS504Kv7TwscpvS/BaYDwqAbqLs5XGRKhAhc+iThPQ=;
 b=2/gGmgPGsTRbituANKPd79O6pXmNaezjPuCFvQvsZGNZnSd5TL5DsWY05EZ+mMsbGWz0Z5Hp9tySBux3BP4R0wBcRoMByA4GPebLVOlJIZ4qzRAfYE1TMMDYBU+H5ijT0nS+Fv+BgVvNNsozGSKq8XQMHOUeiGMXsRtanFPHcFI=
Received: from CY5PR22CA0045.namprd22.prod.outlook.com (2603:10b6:930:1d::22)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 07:18:38 +0000
Received: from CY4PEPF0000C985.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::a7) by CY5PR22CA0045.outlook.office365.com
 (2603:10b6:930:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 07:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C985.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Mon, 6 Mar 2023 07:18:37 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 01:18:36 -0600
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdkfd: Fix memory availability double accounting of kfd
 pinned objects
Date: Sun, 5 Mar 2023 23:18:27 -0800
Message-ID: <20230306071827.510614-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C985:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f9ba5d-eeb3-4c54-7ece-08db1e130167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxXpKBSJN2dw6jMuiJn1sAPNp6b5fHv72/pAWAf0U4R10BKqzrDGOh/hbkdOrWga6Sf269I+7Io4SddFccmkoacFIy6NmvNv02L8hvYS15p5RDoPPjv1hYOyYSisLh/pmno52vPIs08Z5op/qFfZe8o6BX3o1YHJy/rBY4SbMM1hQzPmQ2dnII0O0uwQHn2o4q7WsqtQMHaqnVYyUaGsaJwbbQLoMbpM/z5aINKADCH/T233nAFxB+xyXFGggz0JjU2QeIvqplUP0fFzmG3yX4KJNAa229nbnAczqsWu8Xhgk+mDGxuoSjXohycuhrlK+dBvwyJkurALzSSuw+jXwiKcKxQscvkkWvQc2GgdvAJESr+PwGE5dUZD9Z2Ln252FIk2vJnH8ptQx/b0Jh1ooFxurBvnYyErKAjD8yOpMHMqGOVKwb8I/DCkhTNuhBYUXdB8NqzJdpj01lmQhZt6fRAKHbO/MbRmFTPd2brfgN/11YuY12XY0c2EMEsuSGJHpAy0g31uK8AUOL+RYZcW9Q3sAXezzwE0rrcUBlGHzc1Rqe3ydYPOrobK/EgwrFHmJj0K28b+Rx5job4XhSEt9LJcEIG8L/Et0CKeeiPGRvbeQE3je1DUTXSb/KMGS2L+zYdixvINwPqQoY9U5RPpK1vL2jQztOEZ2ELBauMdTcLQE7/jSnM0N58CrjG5d/PBYCIuLYTFSva34muwFf51ODCKId74wWwJbM8wE+eaPJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(8936002)(41300700001)(70586007)(70206006)(15650500001)(2906002)(44832011)(6916009)(8676002)(4326008)(54906003)(316002)(478600001)(7696005)(36860700001)(36756003)(47076005)(426003)(6666004)(26005)(1076003)(186003)(336012)(2616005)(81166007)(40480700001)(86362001)(82740400003)(83380400001)(82310400005)(40460700003)(356005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 07:18:37.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f9ba5d-eeb3-4c54-7ece-08db1e130167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C985.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pinned objects that are not kfd objects reduce the total vram available
to kfd, so we subtract the total size of pinned objects from kdf vram
availability. However this double counts objects pinned by kfd itself
because they are counted both as used and pinned. So track the total
size of objects pinned by kfd and add it back to kfd availability to
remove the double accounting.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 01ba3589b60a..f53514c66973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -99,6 +99,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used;
 	uint64_t vram_used_aligned;
+	atomic64_t vram_pinned;
 	bool init_complete;
 	struct work_struct reset_work;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e7403f8e4eba..97a4e3dba053 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1414,6 +1414,9 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
 	amdgpu_bo_unreserve(bo);
 
+	atomic64_add(amdgpu_bo_size(bo),
+		&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	return ret;
 }
 
@@ -1435,6 +1438,9 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 
 	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
+
+	atomic64_sub(amdgpu_bo_size(bo),
+		&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
 }
 
 int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
@@ -1588,6 +1594,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 	available = adev->gmc.real_vram_size
 		- adev->kfd.vram_used_aligned
 		- atomic64_read(&adev->vram_pin_size)
+		+ atomic64_read(&adev->kfd.vram_pinned)
 		- reserved_for_pt;
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
-- 
2.39.0

