Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BFAC5516D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 05:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFD010E1AC;
	Fri, 31 Jul 2026 05:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BmAkugIi";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D68410E1AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 05:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbvUTaIjU59KJznK6xPYg3ANQt15UmGYpLPcVXQt8Y+mSkKarCjUHjheTkkfCeE6kkoMg/Z0WHT+yAleeJ0T1+ki4DV7VXMlPq4OD8MNCFiVBXagn5d5K7Y1Bn805UuCgiv57Nt4WN3hwmKyeSq3mi1PGABQ6HkJmIPPfR5yCMidy43O4jcqM+AtjMfg/qCPN3bi9eEp3ZJEzi5PprAIkvuIgjqBcSjVFmakCJHJbOpwXfeTyVbpjgmMEpRvruVa8umIF+NEUgOdnf5r6c/zO8nfKzza6Lxe8oZXJTlH/pLV33qcQf07/Cr8GFw8+nGtIAc2Hp0EeyN9hBntGGh3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuATkLKg2NLdPnX5MMGTbeTqliH0h8KB8L5kBgr2VOo=;
 b=hK6fDrJvIIkQ0QebkbwjQbwgi0W9CHEadcLLdYUV4oeT4GZNDzBMVn5nEy3e93WAGKqvU0jBZTrapJGpT+AZ1xqimxZdStJ66gBRMpFNuz2HM3PxzaKHZlBUbU305Avi21hfJJF1AYzNfCzeEuQ23LjlGUgkHp/5Bu2171uZQjDQAbL7c1tOaCPXqlW7DSRrwnGFerl7ztbC9bAfnI0fgtM9ugO0gAjiE5IphJ7VskKLDE2UHNxub6oEllFxsdlsXmlMAxXg1eCZU+DrGhQhCxp1RuXUatbpNHcjd4AuLt32p2qMeF948UL1IpoZLTu136h9r6UWxZZPNYmQvwbpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuATkLKg2NLdPnX5MMGTbeTqliH0h8KB8L5kBgr2VOo=;
 b=BmAkugIieWxT7jCBDX1qvjVE0ROoFkp99nAweon1UM1cEedpK3YPR49gapApjwv02/L9Irw6/C1bGFjNJqT/Oz/SC1bo+eEjYWHPK1djBSMR/JUuf+4X3RZmOmB4ZdsKWwmUDHTxlGDD4miZZHj7nX9fkFdwB5larNiVXlamgE8=
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 05:42:57 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::68) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 05:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 05:42:55 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 00:42:53 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdkfd: skip unbound processes during reset notification
Date: Fri, 31 Jul 2026 13:41:49 +0800
Message-ID: <20260731054149.115301-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: e359bcec-9d0d-4d24-dc5c-08deeec6926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: NeVgErnrcG0205zgcU5xgaf6AjZlS//3o7dT2AOGKsIvZAvCQiwfyt/7mP+1h1h78Xu1GEJmiZ5PCUauYYAOgWMUySTxhvuiMdpv9Cmeql7MkuvblDecKKszWthBY9U3G5waXJ3YNtFNNXX1v3PgWNddhojDVg9+GSeddNHY7b1X84IfG97hzenrJZT5jf6OdL0hZeIkQan/IJrZno5ZQ1U7W26thBHCbUYnOWzGiPljTRezcBr0b4YzdQ7TkeV4N4R2r954Gmg1MjabE1mfjbe62CMMjidX6ywCL2aQ9M+9NpbBvY0LpgnuoIRT3drJee5yaHWbWx4dtBI0Hfnv5jAUK1iYKJom6uvxZhSXnyrOAKz/Ewumdc4/ma/ZKCN3IjwEmGfxAxQ5mVU/teUwcy9r0tw4b+acuF9edqUCxR1/OLwuuwU66VxjV2TY1VCFVuZ2PZDeZW9/UYTEzo7qBw/HKEnERYnaGC0vGOTpBce397qeMWj+MjMlutNXLwsMubVbcSM6o1M5SHxBM2dehKIka4JnPVkhBLZ2vWfyqrsAODwt+hrpBRQVPWNCW0EF8WLoLMBVTzSQXD5j0zxKAAmtzxAP5Qm6JhGyv7wyPtemoml40eBX5rlYcm4bvHjJC5qliVE9TvVfDyfp800M5dKZFa5UBRjB1//BM++mK22WEER0Mk5CQZr3xTnVDqjdOZTDI2j3WDixvsddEj8eVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fEtFbhuok4Y9qnhcmwRdvExZvMLLs8sM3CKHxfCKiuYd78kNxgoLQB9LLYxY8rUdOY4lKMHfeyPSyLMs3bFsWMuc26V1E93fF6Fr7d3hip7P60+3TX+9oHeZyYA43Mek1WOfgHAMjM4aUP4jOxsuoykgSqDDd7OmBOB/OksHN30jakp40gpNkdV2dbSCbhMIFldwR0p1sovHv5xWt/uEo6MAEXskiXxH1faXIU5HAXgu+QgGe7PxhaJGmU5djB9DgI1BnduGW9zg6ULIwDTF3J2ULVNK/zGopc0zXBdoNLMNO3TnEIgMF81q+eMRzkIMs0/iO6DMNPM9Yox9xAWRX9Wo/zqpexWqKG8s6a5cAuPsisGBw863MTjcmIR8Rq6+4/SqsIa/lmYOairo/80aC89l+HRdBijmDgcT4MDf6MW2QSsJwDwk3JIngPhldmr8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 05:42:55.9518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e359bcec-9d0d-4d24-dc5c-08deeec6926e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

A whole-GPU reset can cover every device in an XGMI hive, while a KFD
process may be bound to only one of those devices. The reset notifier
currently looks up a user GPU ID for every process on every reset node.
For an unrelated node the lookup returns -EINVAL and triggers a false
WARN_ONCE().

Look up the process device data first and skip processes that are not
bound to the reset node. Keep the warning for a missing user GPU ID when
a process device mapping does exist, since that remains an inconsistent
state.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index eb6fa4af295c..05ce2fbfa4f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1162,17 +1162,18 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 
 	idx = srcu_read_lock(&kfd_processes_srcu);
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		int user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
-		struct kfd_process_device *pdd = kfd_get_process_device_data(dev, p);
+		struct kfd_process_device *pdd;
+		int user_gpu_id;
 
-		if (unlikely(user_gpu_id == -EINVAL)) {
-			WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
+		pdd = kfd_get_process_device_data(dev, p);
+		/* A hive reset can include nodes this process never opened. */
+		if (!pdd)
 			continue;
-		}
 
-		if (unlikely(!pdd)) {
-			WARN_ONCE(1, "Could not get device data from process pid:%d\n",
-				  p->lead_thread->pid);
+		user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
+
+		if (unlikely(user_gpu_id == -EINVAL)) {
+			WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
 			continue;
 		}
 
-- 
2.34.1

