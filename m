Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08C2C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 15:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196C010E97B;
	Mon, 25 Mar 2024 15:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DE4utPPN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 024D010E0F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 15:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUW/0/Ng23i61qA27or1QIHx1Hy39DCR9h1jHFLfkbF5LDM9WGMSK2vX3WycMq5IxflqhrydUmW5EdPyQMmWjJaaxF/nzJbxsZ3Rwb992W36B/LFKAVOZoiIl2+gO9f+yJN9SMlEgqJvvKlhVU49MxgpUHjdP33kN0g1hY66AIRbmLg0d9E8jlHy71KyT4HwQhtGIw27//pSjNmCaFICM2n7TwuLvewvEpKBWOkZ3Rddxp52ZohQrlevlC4EcyZeQpcyq3naHnckF63bTcGFDjhJshMxJqmrrkZmTzX5DL7EiGkQzYowLMEDGInwWmUB8BR61jerJjn6ReU3kAdDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK77LuNRmt17coyORECXjsO8T64xyAyRlzgUuKwwPy8=;
 b=TovZI6mcw/y3lWByvnfIkQo1pgo2h5irh4U7AyGvYGNYEwfbvzPBMjqdLKTffgfmf7OzW/dAvwPzCggJqub6JmTr7rKKTlS7EcI3uDbhLROM6WK4MZHrj+001ioxXthdR9pEraARLGuT+lRGcwBE0pj76OE75iS8cZ5vS4y8rRrDJZX7tUOeIw+DULOXGbXEgBtgl5bGTZ4LVqGzIYhMZvh7vqjtYmO+wVN8KHPkVnaQKJtmPBUWKP6euzM++wyZB7jTvmBSRNBMsbvb3JrRaiehmTlZi3Y+mKO/SitElnWAyVbKiPKBbxV8HPEKO7/WSPTgCSodajZQaT8KFxAwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK77LuNRmt17coyORECXjsO8T64xyAyRlzgUuKwwPy8=;
 b=DE4utPPNBmHD66xeDYmJ+hn6ky1zqnLB21pyJrBn47gm0gK0th9KqWUaNjGkVVIpAyvZY7xYZUDU9ks8aAY8t5ZsgDDrjwXP3t01Ot32ZiIcFsyqNFKHx0wTcDcCwFoL3h4lWNalaTuIQwIRakLnpZ/TWqT5xs5Z1v690bD0SsM=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 15:18:21 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::15) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 15:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 15:18:20 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 10:18:18 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH 1/3] amd/amdkfd: add a function to wait no process running in
 kfd
Date: Mon, 25 Mar 2024 11:18:03 -0400
Message-ID: <20240325151805.6379-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 330aaf0a-94e4-441a-8322-08dc4cdece48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meB2Jnmif1oOlU9fj9ELhuCvDevJpInzsxjnouljeCqTuUuDln2dCRnkPP6hhJpcjLIzw3YkVjGGOdHDM/Ah+24qOjABNOl/P93xCEmeLq7s64ua5xIk9OJRD0t3+W8w2oNlizMQ92Rzj+ssBCaxL0LA0iKBCtGfQlpZfVsYgeLCA9yN7FHTxdObyaELFkWbBlJjbE94fB/emr+UaPQ1VeM6rQhn5yndGMcGl5Oi6oo+w+BxUixLVgXvGDmgClcuWelprqsfcvVBEYjkG2/ZjO+jAtb0f5m/hYRlOcCX+Fj0yLpcslDOtKcS0ehtxa359J53JB0rz50kXYRldonP+sHsx4WRiVi1nh/mpdDAAO1JFqCTBnS/ZpcO5z9niNceIFd8fEIqeP8EbYdnP24eiMilErU0TijnovJTgazFH5550wLFHpqkixIhLedYxbVoX1uPCwkpvwu1v8QpscPRfCtF7ty98B7MxgJPIUy1YvS7U6insRc1q0AhFjseHn/ewBQ3CUO2lRwvVxC0Bpo87/x0S6qC6Dj4zO3weW8S8p9zPWZEKzMqfOlFLWU/jO1xerbHYGQtsFO22Hi7fs6P+wrEVIm3VQT3DaESRrzUx27ipg4wFkqZOxXJOaJPR9Heq3EA+Fo4Yu694XkucWdofvxRyQ01DOqbS8Mngo9AyboLuBgQqiFKvFYTfscq3lfz0KBxAS5ht46ttXiBdU/6TTUiOh/qAGM4ofjewtRn1ZWkRRaKLXWwrtsZo1ceh4dX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:18:20.4420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 330aaf0a-94e4-441a-8322-08dc4cdece48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 10 +++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 11 +++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

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
index caee36e52a09..d46dccc5bbf7 100644
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
@@ -454,6 +457,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
+static inline bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd)
+{
+	return true;
+}
+
 static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 {
 	return 0;
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

