Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958CEC47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 19:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE1111273F;
	Fri, 22 Mar 2024 19:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j9TK9PzW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A71E10EC12
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 19:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPsx4YScgr+Y+hH5cCUeStKppUDYY+yTI0DPRLzqdB9x9IMhL1EDNZloN/KoU0h0WjRj+vwFIWDD0+spxNtXW4sd9LzVAHFh40XBk0qEP3v9hWihVpATdrQ/1FPuwrS0xUJYkhdCksXtx9oHaLCqtZw/rdyBRkVFoKkK/5GpUjblnOhwSoihUh6kvG5OHaCuSZPhbli9rjyBX4E6OckXIkaS0SUQuf3bYa7YTkB/5C6isS8iDGnoQCEFuxxQotOfZul7fJNcVOkoYLDIFO/UhTHCAq2D7JMPCMMY8YmL24WEejClHpier9afSTO1+MEZWY0GrX8ztHkVG25NcYWc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9X5Irp9ffoWVKIFh8NqfVEKExJ1PkN3OHMp/ljG/o0=;
 b=ZGsju8cdgEDb41esYQJjFZ6xT+uK6i5SsigcqyAvcmx54C2knT7v3atB0XHueGXx0c+cHEH/DF6a6R5bkJhR9JGDoIs3ebPcKDi8Q0GC/UnaLc9BjdUhQVfs3oxFJppfJ/30ooAnbCq7XZb8rBzPuZ64SueM+v5LccAYihUQ0eKV+l1EXATqMYEvZxLorG3zDTfMD6IBNv6Jrs+8pdggvLXns3eey52hSuvxXTCkULdWSlT4OKqGaVKvWp/8nc4bZO69Hm4RAlBVwSrO6BwngPgZBbuSrIy4Cy5D9Dnb0MdWt8XYvyhKPaQjwls3LmDHvk/uT2pZl0TzKzZG0aZM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9X5Irp9ffoWVKIFh8NqfVEKExJ1PkN3OHMp/ljG/o0=;
 b=j9TK9PzWs1OKTS71ay+3T6vXan5WIu+gxqLIOt0Srkvp+P8EU6A3voKmAp3RNs2mQqOWh+Y4ATHdL1r6cNuv45bOJayaZTazfnr8j7dLMTopzXDlHbtmROxUiEf9AgSGD2y4HIhCCu8LIrRxgK6yH0oHgnj1IfcEJqk/6eC07OA=
Received: from DM6PR01CA0028.prod.exchangelabs.com (2603:10b6:5:296::33) by
 SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 19:57:54 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::76) by DM6PR01CA0028.outlook.office365.com
 (2603:10b6:5:296::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Fri, 22 Mar 2024 19:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 19:57:54 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 14:57:52 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH 1/3] amd/amdkfd: add a function to wait no process running in
 kfd
Date: Fri, 22 Mar 2024 15:57:35 -0400
Message-ID: <20240322195737.30795-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b68064a-7e2a-4a39-c07b-08dc4aaa5cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnlzy+Ni520ah/tprHI/x+FROKWKgQM+Oty9uhmk0XWtCIyWwMOjC6mMa5GQaThxdKHsct76yLguTin0ouPZj+c7QKwmM8W0bSw0Y6PfSd/TNsG0iM82HdopunX6rKi0ow+A74XJJiEz2XYC+c3mseV1BsddDLYCmEi63mJfbhmmk06Bd2JZscZnenxXQ0z3mG5L7VUgIPyUeyg/CeO0FL+3RKXULIDQLvb3i1yDOANqEgXKGgoKSKJTKn4FNEOdEn5O3ijHSLYdQgsSlpaqoTHnRZxHz4BfTkADEQWwUMPmnhMWsRDI+d2UGp8z45gLTPKKB+PRvpK2Nr63/FsgEJmngk8RqOZx3yDVUFJdr0K9uKQ2quY6vp7zWkWV77YFBuoBySoJkIDi7EA2QIHAkd0RLBm5GCtzWZ0+8YfHHIu8/09pk0lnANjlNbdYcWciiAw+DEBGDd1imS2bU9FuITbAAXQAQU3ec43AvqPrTWcfB8Q4wmJYESTEaZIMmbkVM+TR1o4zacrNH+KgVv//DfoNKb02G3zHhdPK3j8324+fXaeFR35FHS8+hTQpQWdBnk2Md1vb4nN5IuYMd+8TH8miuqE6PzDbqdNIUA8j9gD7tRHRh8TWwLJtUo6MjS59sKxJbTxNuuhNSIZYMMvdbU8NHSvCdm2Mn2rjGhDK7ZXM9Qfs91a6zTNHOIeJOw9EbxhXT6vHvcKMxHZ+jycLJsIhfOvmvEJjJK9E+zLD3/YpMhFu1wzn7kJPmZW4Offg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 19:57:54.1699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b68064a-7e2a-4a39-c07b-08dc4aaa5cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: I2a98d513c26107ac76ecf20e951c188afbc7ede6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 11 +++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d5fde8adf19b..e02bfcec608b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -261,6 +261,26 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 	return r;
 }
 
+int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev)
+{
+	unsigned long end_jiffies;
+
+	if (!adev->kfd.dev)
+		return 0;
+
+	end_jiffies = msecs_to_jiffies(AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS) + jiffies;
+	while (!kgd2kfd_is_processes_table_empty(adev->kfd.dev)) {
+		if (time_after(jiffies, end_jiffies)) {
+			dev_err(adev->dev, "wait no process running timeout\n");
+
+			return -ETIME;
+		}
+		schedule();
+	}
+
+	return 0;
+}
+
 int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index caee36e52a09..796e09abda69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -38,6 +38,8 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_xcp.h"
 
+#define AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS 10000
+
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
 enum TLB_FLUSH_TYPE {
@@ -169,7 +171,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle);
 bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
-
+int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev);
 int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
@@ -411,6 +413,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
+bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 041ec3de55e7..2bec79e0c721 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -894,6 +894,17 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	kfree(kfd);
 }
 
+bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd)
+{
+	bool is_empty;
+
+	mutex_lock(&kfd_processes_mutex);
+	is_empty = hash_empty(kfd_processes_table);
+	mutex_unlock(&kfd_processes_mutex);
+
+	return is_empty;
+}
+
 int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 {
 	struct kfd_node *node;
-- 
2.25.1

