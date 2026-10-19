Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5836CCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B1510E79D;
	Mon, 19 Oct 2026 06:49:05 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD3E10E79D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIbdLZEMFMjLklI/LAesg5Mwfwgdo0ncqAikgq5IH5Kh/ifBegNfd3/KH7dFwTJg+uusEkxwKIrb/UizoMZh03/SO7KqWysu7HjEz8RE2JQ/Vx+6l4jIwZinj/qawl6lp9KTZ1jrn9UlU2AodqDZT1Ngys5t2FHzMbPo15DkW6+x3CCHC8P2JdLonlC8Rrd4nolQRWzTlEHayIV6eRzov1671dKbDjcOLI3DHY0K0sQSP/ln8AhPZraRByTaSjBl8COZdFPObmZpxMq6WAg7i7KU996+OE0O9FIoUrwLAjzJNOYyuYHx0MiKBX0U9dHY7lbnfgwmnC+gR2n3Wc4sRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9kaW6oQF1/7Ip8JjEmhuNxZmTtFOMnJzol9Ukgxc0M=;
 b=hLgJeJTpiOycqHNr2EoEFvh8fZbuSnoiQii4Aq5j6xylvmdwhrq+z8kpfbQayl4WMQEoO6IsdIb6hZH9dlvTtEhgRQIKl7RBtUNzaaKwPl+p5t8ixoizkC24XBI8laLNtLRqIyt0H8uRP2UjgbobK4+YAXN1Ca3tueDl/ihU/9TvogrZ7JXxfc02GGl0cF+Dm4CawljXvsWMX9LHhEdFwYDhkg+K16yYgig3FNh2+WL+de+CR+LSY+QE5ixOb7KUYkHVbfUdkmzFSHNw55T04og8/747WMiE5S5Tpr3r/z1fBa/BcXRMg7l/gRQ5PVSYc9KuM5Yr0CL62dP2WK7KSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9kaW6oQF1/7Ip8JjEmhuNxZmTtFOMnJzol9Ukgxc0M=;
 b=oaL+DURKjkouTQOYCgyN1mycyCmjngK55CD4nWJeMXsLjCn1JQ+86GZI0phIik10SudhkH02j2AZinR4jutWM+ksFa/Yxd/I5jL2h+tzS1zR1bofg+Dwoh35QLFVZOjpsMcLhyuXY+mtEJZ0F8O8BTGdaaNwgdjY9kYmK5Ze9XM=
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:48:55 +0000
Received: from EA8PEPF00000009.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::22) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 06:48:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000009.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:48:55 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:48:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
Date: Mon, 19 Oct 2026 14:48:30 +0800
Message-ID: <20261019064838.2577746-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000009:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c47fc9-224a-4fc2-02d2-08df2dad0b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2L8idS+JYj19UuHIkZyZIsPT6cMvWgbJgTpbZi+EHc5ncR8zWTwqnsUWuq5ihbjNfGQFC1pBTYPcj5HM1sGc3HK6l1wD3E7wtWGD74np2lScMJJX+fQQQFk7Hq8z98HiQBrKheVwTD5gKruOeeB5nx5WT483QK3UNWoPX93IDgCJfzH19xT+GzSWkhAXnHMPeDlTzQzOO2BI+bnyHHoFXEOksR11vkRCyr3UqcIxTKPA6NuksB3twXj6bJP8DR2cETtgQ8YCmFTNrRDfD98yo0QYT12Kelha17y0FYwVjZxOY9XCsDVLqLZR9JH4pQHqPpWdgLDOgos83PQrwgg7ormRWSrHi4GneLN3d1TkfU6PlRFsKV/nioZ4ewTHd/npH8YhwjOamP+Xdhl0gql9h3uVTrpHh+rNOTvzovuWjC1DTt7O/HPMCUM3Eu/25Zhm3PwdWyEWFIsN9drKlo3BXqxvVjdOxivWL0gk9GbhgWmS+OS3aixW7ddIa9OMmUmVKDuD7pjdtHpWazz9li2Mpja9VVj8EnsBawS0v0Gt3cPbY6h0Tpnn++kzL4mOCz6HfsOeKC0Pyj9GJb8WJh1o+fxDkqUimOzPb4zEPjOX/mY5sUupXeuuq4P4EEyRsKU0hjMGNGodJzqrDtiIs6G6s29MPq1twaBdEbKWx+b01e2hzDFZg0Sd74kaf0xGGHK1eazQZZC3Ggx2hFxsots1Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r7bmkURrpm+nR7YTdoOClh2gb/8z9YlTazpmgN6F4cOk5ASZdO9xqjoKywJVsar9t8n7IGzJf2IoekwCJgignTugzZG9VboGy275NMip+cZzgCOdEC42QH40y4iKHS69our5zOGs/DR9TN6HTJdBYUmsgwbCepfzDZ1+OHCjDFTCrtsu2x6BK50umI8b40IFXmXI/9vMkkCHg/WzZ2rrW9cuR4iu9vBtHQJiHsajgpsPJly36d4+Z3IGL6+Q4eCtDFjwSmmfEirOiNH8gYx1HFnFgf9fya1ozVuez9gm3fbv69OPLWGO0nhvuBnHwgVfXuvIPC3QMjw83WYQzZh9Yn8rsxXEL7F0XVX17/BRnmRk1D6KiPKnHvIiqj41Mt7cFuYw+Z845QXQ4ipgbtOmftP/zTYSSrloglsFq7HAm/2zAJoQa4hfYlYQSybw9Dl7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:48:55.4380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c47fc9-224a-4fc2-02d2-08df2dad0b7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000009.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218
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

Run GPU post-reset callbacks, including KFD and display-audio resume,
before restarting DRM scheduler workqueues. IP hardware initialization
already happens inside ASIC recovery; this change orders the remaining
callbacks before new scheduler submissions. Preserve the emergency-stop
and guity job completition path's callbacks without starting schedulers,

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 406c5f2fbee1..20f02dd14c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5816,8 +5816,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
-	if (need_emergency_restart)
-		goto skip_sched_resume;
+	if (need_emergency_restart) {
+		amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
+		goto reset_unlock;
+	}
 	/*
 	 * Must check guilty signal here since after this point all old
 	 * HW fences are force signaled.
@@ -5827,18 +5829,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
 	if (r)
 		goto reset_unlock;
-skip_hw_reset:
+post_resume:
+	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
 	if (r)
 		goto reset_unlock;
-skip_sched_resume:
-	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	amdgpu_ras_post_reset(adev, &device_list);
-- 
2.34.1

