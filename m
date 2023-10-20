Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D98CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 06:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE5010E582;
	Fri, 20 Oct 2023 06:13:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C575210E582
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 06:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4vPU9Fg6MV/51Nxm/4TJzz78bkiGzUd/wvYP6W5ZsfQk8PDaVkvqERi7qpi5ENH9pJhupV/lQYG/akhLsARVuOItyqAF671mkuz2ANHQpbg1TDsHvson30YOesd/S6cdsmCPtd7exoCYvVrSoZcIVkvnYSpbdzs1xU8NcYFvkSV6wHS/sXChXRIPvxh6amYTQlzJzWZLoBfOCB+ASQ75nWn8pIHIEfVQP5MDFPJf5nK/rnDpjBx57YuWs4TC7h0Obw+ydQn6wgzQHU3/mbnC9tGupVcMb6QYr/J0mJg7kBXrY7Gp1FhcyKX71fuVJBynQeONMEiphg7u02U+KL4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaW1To/6ppvr7+m8MTpsDWhPPUCGVcRF5aRMhNa5Dlc=;
 b=f+2RYCt4q8onBNsJP4i469eDQ2uBXWy8Y2Qgd+oQqUYA8++TJ7EXy1orfb2Q/GNLhYW4vy+1/cZIbVsGpLrMI60iR0lPKQyrU84pzQMM50XaWRzyc8JlqkOosCUprRIoV9w0VVc2EDBfmJubSFzM+Q5tTaGeNSYB71/3OR/HKzlD2A7GYXMY2heMUbxffLcijh++Z23LmoQMLI39NlgnKA0blo4bRK9jagjlvgD7IGrYPNYrrlpC3oAuSr5QTXOoCJPHDJMkcG0JkBNDXNiMj4miqBv6OAB9Qy4WUrVuTCmoXrlGJCnYfZhSVzb8k1+RS+UGCVizhqNmxe0LVdlHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaW1To/6ppvr7+m8MTpsDWhPPUCGVcRF5aRMhNa5Dlc=;
 b=xryQVN7Kve/FY0pjRv+59b6mwvD70KXlPm5/IHTMMW9RhYGTES/dzxEUx3NDOZHJipfeUO1TcKkMHtRM3SafP641RGBBXydTDYlPRvAOQoVPw+FGIo/np2VG4AuCSn8rXYvW31An2sH66MkFHWC2YPM3sqEu1TutmSo9Z2yWNHo=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 06:13:23 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::3) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Fri, 20 Oct 2023 06:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 06:13:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 01:13:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 23:13:11 -0700
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 01:13:10 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
Date: Fri, 20 Oct 2023 14:13:06 +0800
Message-ID: <20231020061307.588900-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH0PR12MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e31b54f-271f-4e07-633b-08dbd133aa41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZwVUwlzVdhfOavxVCGswgbUCfsdFfNluir85KI72s18fItlm4dZEebQ6Wg46yhO6Z1Jjrgqjq/ecxOLsp1NEzrIA7I3xmjM1UjMre7DTwyX70sE9KSM77kXqNbM22nbe/NJNjtCbfITT1Ykg8vi86xQzYuuE3nQgEwRzSYoDQIdWTyx0yyhp035bd51uZf/tEEgqud/O+Faq2s94NJYBh54lgrlVnov3LjnlBKNi0nFkBfGqxytYt6p9wJ9k9VSds5dnlWo3cHtPjLOh2Wa9FSg1h+TD5q4ZTiepqkUX6MryvKAzzABJJm/VlHN5DLFyUZ+w2jH+mRYI4Y4w/3Ev5gDWhswj3FC8uGzc9dkcvO8KlCZRdN+WGgkcF+Z5oVOd0kh46MzpaOI72BXMr//+IGdV+bfgR3m/jYrIW+U9OIfbh7BS9wQ7l/gxFDbzmKWcux0e1PvljkKoRwR/+zuD6Oj9uYttYUBCXWgAoikRvrETSA5DQ11t3IExQO7N1gEwp+jTkipDAmPPjhgvdghXIGAmDPTNbzV7Sr82gJApJB6aFqZG7gv2GyodjdFlflbapkd+AnkrMRVYfUuLxvOXKc4acRcz13guwB6F4XiH/X75A6Ks0JN+NyU3vvQIy8oNkQZ7y2MtRI8KJWEGi5DEHbwQzGvpAOE9JoQiMxy9kw5hDVdDoX2k3j3OAU/EAe+HYrabRmpfGUqUnTTmlhcspnJ2Ruu5Ib58yOzlYuoTs2OCfmmMKFlig+oeyxPm5KktBoh+9srcBbO7DcIGgy0Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(83380400001)(336012)(356005)(36860700001)(426003)(47076005)(2906002)(26005)(1076003)(7696005)(478600001)(5660300002)(2616005)(6666004)(81166007)(4326008)(40480700001)(86362001)(36756003)(41300700001)(8936002)(70206006)(70586007)(82740400003)(8676002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 06:13:23.2537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e31b54f-271f-4e07-633b-08dbd133aa41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Issue: Dead heappen during gpu recover, the call sequence as below:

amdgpu_device_gpu_recover->amdgpu_amdkfd_pre_reset->flush_delayed_work->
amdgpu_amdkfd_gpuvm_restore_process_bos->amdgpu_sync_wait

It is because the amdgpu_sync_wait is waiting for the bad job's fence, and
never return, so the recover couldn't continue.


Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index dcd8c066bc1f..6253d6aab7f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -406,8 +406,15 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync, bool intr)
 	int i, r;
 
 	hash_for_each_safe(sync->fences, i, tmp, e, node) {
-		r = dma_fence_wait(e->fence, intr);
-		if (r)
+		struct drm_sched_fence *s_fence = to_drm_sched_fence(e->fence);
+		long timeout = msecs_to_jiffies(10000);
+
+		if (s_fence)
+			timeout = s_fence->sched->timeout;
+
+		if (r == 0)
+			r = -ETIMEDOUT;
+		if (r < 0)
 			return r;
 
 		amdgpu_sync_entry_free(e);
-- 
2.36.1

