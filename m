Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A612CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF1510E3E4;
	Tue, 19 May 2026 18:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rYvfrIXT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC3510E3E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H43+hM88OM+ZkjnHC9CRUBoQVJH132QS14lMxuIU3CXyA32muFQR6irFbo1+Qvvzt4RdinOaE4nAEbHR3exUUmy9y2482NXYWIsFz6TPrJf/srGbFKuJs5xiQtESH2gkCDR4KMvdOJTvHSQyR/RD+m8dSWPdrqqKej+NYm9ysc5N20X81o5WuZ4Z2O8O3jc0gyFcuRQVBpOFZxpAF8uuFXSxaJ8X6FbtRZyA7Uvbbv5sCw4abjfVntt/7Qh0pt65UeF2cK/sf0ZMfdMf9RuTXB7erK1SAyjncKWZVvvi20iMfBZEKmlE9xKkVo8gNH/N1nBy03y/3/n2B1DDwm4qMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjcFZzCeDNdYH6Ql2zeOktonVVUVRkgo9mT8Tqmkizo=;
 b=nu0MXgBzff/S6A8OKyOsXdV7mtv1UE7Kal7ydJscdECGMESQ+oeo439RpjUE4r39sQF/4dYrn3zCV7gZPeI6pVu8kgEv3lmyU5m3DosX4yj8kNBQZnXW3slAK9JFQ4+OpO92IbUs6N/8fHHqGIqeDIM9lN30s6hHR1SGF9BcB5Km4JhyrPVe0t/yjXnb1suLWhkia6LAGCSM/mOgms7CIEoLBsjlduOKhQRn3D0FCoLK8QEC9EU2QSy9hRWPGCNbT4EknaZh9lk15GAGBguMHqCxjR/URb75q5sv16vuKIFM+pqfSyJiKOTa3sE24VkiVhtbUdIACste4Fj4Rw1F6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjcFZzCeDNdYH6Ql2zeOktonVVUVRkgo9mT8Tqmkizo=;
 b=rYvfrIXTHzWJLS/enAmJVJa7SJzLxRPbki9I6rrqc2p9nxCJE+ouwKzdKjhZRP1ZWIfDmbazoLHi8Griw74fV0aZMKDGu2PtCC3mfgQ4hGjTF3SLyFe+2zFUZfCtKBKCL6ntyfowjovfi+wQm2pM0wBJkuMMXJGJX62AoElo6Tg=
Received: from SJ0PR05CA0182.namprd05.prod.outlook.com (2603:10b6:a03:330::7)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:29:15 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::e) by SJ0PR05CA0182.outlook.office365.com
 (2603:10b6:a03:330::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Tue, 19
 May 2026 18:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:29:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:29:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:29:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: always resume_all after suspend_all
Date: Tue, 19 May 2026 14:29:05 -0400
Message-ID: <20260519182905.21715-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f63617-73d2-4eca-b7c9-08deb5d486be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aC1K1ZxLpU3U501zYYBGOstX8G2HQrjvsubLtRDF02Vum6mKypOkgBHbL6PnPVrdGYuBLVQVNsLR8phf/zGSrqZlxfDThqw18SxOULIWLJKUlhJb9mXd17D6fDg3hzu6FLFPnxQB2fEd9pZwlfH5Yp3COEz24aZzwd0BXvJ0jKLuz/I5POgDIuSEf3KF57HjRIaURMj5sCotE9BUT6D+S+XdnfFqzL5BaJ22CSSwA/thjaPscNceXfNxypj7OTwF4SRNmWlgxgRK/NyUn5e8S4keh44b1VgDwbuf6hFdfNS9UsgCP8Az1r/T3H3yrptWVOsG3ZB3+IuZmQf1DWclP1/Z1PMFYUuqM0UMxMj0uVy97H6jb1V7Kb1Gv/xoz4RfbUxa8evd5oCTG7E9Yh3fQHI3Osog3j4ANzeS9EY3GurIp+D8HqG50+FQ4GLEOMF0tHnY4JQw3QNPW9pgTo4pFZEBAig1qUjJgQ/i01o7y2ErxMBVXzXW8ekPBbMocYDDy9CORjnaewJIz8B6pLwx10+m2EkfY4TWLKc0y/MFSPu8JY8pG0Jg3t0e1tIv3F/dlcJ0fLYaXQKA6jpHP7mQE7LmTvkv4EHnrrlTriLAwB3BdvlACeW/3dlNwtk9kamqI5nOyZnx79GXYpnazD5J2m/yJJYRPs1DQ8g4nmE1lqCF6N0CmbivbJaxxmyTANR3L6DODoY4HQCgd6Pxui9cpcOG7ig02ahBnA9dayoF2Ss=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sCrZvlcJ0UbDuMsETMITMeF3cD4a0VvHv7X06AEnBC44EeFmIVyjeVs6RrQJzE2OxRX33wGN3mUOGqR/FARZ3k7BesRQQJIf2RD85UfD0vVGma7SWIRK2CALsysEU3ba7SJeiOxF8/pADyAzqTaRSRlE16dxHvyH4kirBvN+DoVVcJTgiBAHt5pcmSW4PcJdRbfu6QTl96cuYNtpuqSt3myvhkILkaBk49EDuIvfD8VvR31u2uD8cL9XpQjVf3Mk7GOI48BUVGgNaTnRvZpOapG9a+zX99wq3fJYNK7HqZKgcpbgJ/DLJ4vnSQgv4MhR4GESy6TYpoWJ/SUmACwQb0gSt0F+tqHSIH1TgD+SMFKaKfANiyWGgKxIOuHbQDROIlNBgJjqiwUTlpkHDxK+TcoW/hLIqkuIu9bOLaUuTLyGKjpQd2a1wLyZSbZhzZoP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:29:13.0204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f63617-73d2-4eca-b7c9-08deb5d486be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

Need to restore any good queues even if the suspend_all
failed for some.  Always run remove_queue as that will
schedule a GPU reset is removing the queue fails.

v2: move resume_all after remove

Fixes: eb067d65c33e ("drm/amdkfd: Update BadOpcode Interrupt handling with MES")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c351f7cff0553..08006ce8126c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3258,32 +3258,24 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				ret = suspend_all_queues_mes(dqm);
-				if (ret) {
-					dev_err(dev, "Suspending all queues failed");
-					goto out;
-				}
+				/* suspend all queues will save any good queues and mark the rest as bad */
+				suspend_all_queues_mes(dqm);
 
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
 
+				/* this will remove the bad queue and sched a GPU reset if needed */
 				ret = remove_queue_mes(dqm, q, qpd);
-				if (ret) {
-					dev_err(dev, "Removing bad queue failed");
-					goto out;
-				}
-
-				ret = resume_all_queues_mes(dqm);
 				if (ret)
-					dev_err(dev, "Resuming all queues failed");
-
+					dev_err(dev, "Removing bad queue failed");
+				/* resume the good queues */
+				resume_all_queues_mes(dqm);
 				break;
 			}
 		}
 	}
 
-out:
 	dqm_unlock(dqm);
 	kfd_unref_process(p);
 	return ret;
-- 
2.54.0

