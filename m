Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C636CD1296
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 18:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840041127E7;
	Wed,  3 Apr 2024 18:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h32hkuNk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082C0112E23
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 18:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzLB1FJx7d4kSMbyYyJ9Z9Na2KxFBdddgIx0x9YxXnrJIs3N7WhVfBm0SU5nAWD0qBzqI/poc2yRu0apFfRqJl3P2ELbQskLMElOW6IMP/Lgt+FJeXcQe5fxEwMdGH4CqrJDAOS+V8UFXeXgvnLFRiXruK5mnMHmGPGuLbL/gTeayKVN/+11h3mtx8u/e+3x/t5+PFcYPaPMpjcucipQdkDL/kU7yt2Y9gp0SDI3RIJ2/rYIXCz9ZqT4OFhQrAjkefUIQ7rObQadtxJzFisxqowIowy1mSkXDYKf3P/OLQtxcjqOcXtLS+HiDSyGIGtVWUm6dM1G4CloUT+fW9f/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9qqRfChlZBJM/nCAs87dP89lIdoIExT7mvZCb9eHPU=;
 b=hjj13zBr0aM5YfdgHg+3fOyEoOMbrb3AQLM8SAE9j9lTocnsz3HqdeWGouZc+Nm6NxsNbNBV+xRDlrD3bUxH0AVTBJQwz++/85Mxn/AXDvE1k1K8ezisKm7TFptct2PpmYCwAGwxoT00z0GBI3IDrWo36LGwU9ZX5Yu+Ya+vJ4GeCRL4AjINuZm1l7Ijf5DYFJbRGTTEhh5EpvKg/2gSFfUhHbUNB9g0H35+85yqbjM/Ngvv/Z3n84qQ5hua8YkkqD+DEKNBCDc0MtHkMA5LivM7o1+xPsYT9gntHXVTZueRwJwlrxVL1VEiaHy9lXWevJay8z3hCYJFM5T1ykE86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9qqRfChlZBJM/nCAs87dP89lIdoIExT7mvZCb9eHPU=;
 b=h32hkuNkkpheUYWk3aaU/4vfUgtDdDu1d4OmeSn9trYTiG8ZIW41ORxozY0VdQbG51ohz62bUCO8fkXuxfRSjBY8C1D3feil+XkDI74nOrGLYtFtC57wJhWdywHBcSXZ7m63CXGZWKLDlTBInH3kcyziCOaVCk8rj0DGoysLZLg=
Received: from DM6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:5:bc::40) by
 CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 18:12:37 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::c1) by DM6PR13CA0027.outlook.office365.com
 (2603:10b6:5:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 3 Apr 2024 18:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 18:12:37 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 13:12:36 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, <felix.kuehling@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH 1/2] amd/amdkfd: sync all devices to wait all processes being
 evicted
Date: Wed, 3 Apr 2024 14:12:22 -0400
Message-ID: <20240403181223.25079-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d1e018-946b-4586-0bf7-08dc5409a4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hALChObuxfZRnoPxvR79ajEueXlvvX/E/CK7G0TlHMSc7ke5+fq50HqDzdjr4ZaXGLjatDLrKcLBuZd08vYqiqHNEBYAuxLInlN45cf4cqmhd9c5z4PGQz4d4oLjnhuoZfU53GWJm9dtfc+Z9DT3je0uCV4s8AhRAEykUFgEgk9DcHrIDpk1A7178GWbjbzatUXBDzB8UpLfAqPaxRbONmOxvYFk0AKDKexrYDl709CWYPRr1YJCzMhw/0pgEs+RpM/zzL4efWsMgml1v6i2pN7/zNLeq1GYAvxwTy6d5dUyQDhVu0WtDPu57V3Hs5P50bw4ODiXtEVU1l3/Cbo5aTox1qRpy8lpSd228HfR47vIx0pXf4wqliwzWStBmBkga63k45cbY7KxwDmnQ8JKi+J5B+OdholYVwd1NxpwsbBC5fx4dC8A0T/uX60Rul05BmVdd3JA9+FESu3WPEl3UgX/049i9Qlawqz5vgaZ8rIGliVqDOIxRsrQqipfza28DPNCN2PLMbcHtX3l9iNxrZ7INmlL3KsQOCMOLi+w/3ew/V6wWNQg4PllJR9f4zjvTu/qN4XM/gDO4HQ0Ni8wjSOxTEeimItat5A83MbvDlRv15ZYbXRCiOYCMgot9dJZHdqAMXreShNB1iH5NcBDs2wmAMdj6e0MQrQ8aLFXo0+eho9H8VvP7T1LJthxDF4ZEaq8btJIVq3PbUcgcSCfuzBSsEpNCsDsHv6jUH0WXgiuuwR3r2q5TzggAUJkDRJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 18:12:37.2483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d1e018-946b-4586-0bf7-08dc5409a4a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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

If there are more than one device doing reset in parallel, the first
device will call kfd_suspend_all_processes() to evict all processes
on all devices, this call takes time to finish. other device will
start reset and recover without waiting. if the process has not been
evicted before doing recover, it will be restored, then caused page
fault.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 041ec3de55e7..719d6d365e15 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -960,7 +960,6 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 	struct kfd_node *node;
 	int i;
-	int count;
 
 	if (!kfd->init_complete)
 		return;
@@ -968,12 +967,10 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	/* for runtime suspend, skip locking kfd */
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
-		count = ++kfd_locked;
-		mutex_unlock(&kfd_processes_mutex);
-
 		/* For first KFD device suspend all the KFD processes */
-		if (count == 1)
+		if (++kfd_locked == 1)
 			kfd_suspend_all_processes();
+		mutex_unlock(&kfd_processes_mutex);
 	}
 
 	for (i = 0; i < kfd->num_nodes; i++) {
@@ -984,7 +981,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
-	int ret, count, i;
+	int ret, i;
 
 	if (!kfd->init_complete)
 		return 0;
@@ -998,12 +995,10 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	/* for runtime resume, skip unlocking kfd */
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
-		count = --kfd_locked;
-		mutex_unlock(&kfd_processes_mutex);
-
-		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
-		if (count == 0)
+		if (--kfd_locked == 0)
 			ret = kfd_resume_all_processes();
+		WARN_ONCE(kfd_locked < 0, "KFD suspend / resume ref. error");
+		mutex_unlock(&kfd_processes_mutex);
 	}
 
 	return ret;
-- 
2.25.1

