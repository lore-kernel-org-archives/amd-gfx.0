Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B23C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 19:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCB110FFD9;
	Fri, 19 Apr 2024 19:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fTGTYIer";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E9710FFD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 19:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAFz9g1+twPzh9Y3XxgVv4TLOygp35EnQKf1S6LeovbFXdeq8wWZ3CWeVfgHTTBBcWMo0XE2YKpVfLuIOeHc7HhR4HERt7IpLOAbuNdNwM47iRHnB9BDYoazMoi4PpM4WqLcR+rG3gjIBsulKiY6GzyQ72HFdOp/BLNZbady0FSHyEkT/Slraz8TFPaTPkb5Z88YSAHkUQXjhGQcuwCZzHM7pOg/JdA1TjDEpG4KrCgK5EaiPp6pDAeW5IiiHzqy5zoCieUadn0NuLqy146YrAOE4Ha9RBucVmY2+8FKjkl4ARGNiZ+E9cO6pZ7rNU1Daso/jIyeFLTSBbBazU6Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO1WYU1F64VuadkUNn4h2jDaKhdQjAVlpeUIWEMeGdA=;
 b=GAwMumL3Raa3MSnZQVSsqb9OtUSr4C9jzLtx3e/VOhba2zeacra3QoFksS6xuPjioqFp3ehyfi+ikZTWCtnR/+BX3GYcdxNNEcRrLBhuHw0Gt+E/vZvVHYoYR3gt1NbXpTzzM2qah94RbP9kFQeu+olnNIG7VPajAjgKijaisG2jEksZ8mOgwBCdywenqTb5be11HNLot41PO4zjthXL63Xup+iJBEppBkdwWsb14/Lm6CkqtNdP7yCtiuw2jCiJmmdM+QYpbW8SoQX2xLp3kYtExyC92/c1EmmhyoLEXltQbWvI+7nVklD73cQKlsoBgniUW7sjITcues/U/VRyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO1WYU1F64VuadkUNn4h2jDaKhdQjAVlpeUIWEMeGdA=;
 b=fTGTYIer/9XEWgFKlL/Ghb+2npRfKU4OUYIkBoOL7bE5MKU1b3TKOn9DU0zTjIHrGmZ0FI/W2O8HtEwY/wf4N4gbJI9nA3VkH2hAPGukgIe/O9Bc+ZJZmXo6q6dXAlLzHQ/Gne+fn9qHVRIz7vDf05EB+52pLzOPBqVfNS3CfVQ=
Received: from BYAPR11CA0071.namprd11.prod.outlook.com (2603:10b6:a03:80::48)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 19:01:12 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::9b) by BYAPR11CA0071.outlook.office365.com
 (2603:10b6:a03:80::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Fri, 19 Apr 2024 19:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 19:01:11 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 14:01:04 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdkfd: Fix rescheduling of restore worker
Date: Fri, 19 Apr 2024 15:00:43 -0400
Message-ID: <20240419190043.3069852-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1156c175-bf5a-4ce2-0378-08dc60a3145f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqxGptbZEPcVs+QfBot9uR93BSslXZy9Mcd9F+vlJn5OH4O2OPTI6TABIDMC2705rsncnW1Ef0XX0cvXZTZ6RwxgScVQgbjMPktDPCSwb7WMUQxQ/thk5cklsV7puh3llMBPBhVFa4Dz71LR3dmWQ1LqIgqF+bKUcXGrW2sCpdJJ1K4SWpjq1qgoT2bdmxDD0lN6wd1qYJOCnkSzXy9MlnCS1tjGlMfLVqFBkbo4arfDfBRQIzooDVu7uIhQDNaPnay6yA5ML33Jc88Chw/KkAXs10EM+jfXSXUWLNzdPTc0jn+YUchGXfgNkDwI+HGMIXPIHu02AOXsfGySfrgFtwxtCCttaesZdsD2f8KKenUcGcKLJJ6Ra0GsXehPDemnv4JtSnwIwxHtrP4KT/ZjFiukFmuDp5onVOuwxY+wiYQTFMek2yCWNTQGGy+NIKwwQwnazgR7FRVxOeNVupQJlGc4/vLDkOpx71p7PDZaYBZPSDCCyGMHBdiYQDlu3ElNdihzrBZegoRhLOnQ1sdr+EQs3UMtkuVUnNqULP5ztFB/qKKXDWTxEHfqAM8YxjkmjgrmAAdlH62/nWDt9DgC3/ARSKipVwDdkk58kqEnbiwLlkImpOUy9PByfw0tXBrkfEfmyaChI939nU6AnTNgD/3e8nh4t2590d351LAZ56wslqoaxmu1z1WLgsrpUM9w64z36XWihjr7LHb5h4T+zQQzadqPZUv6VAltv2+XSIRUbvGnZ94v41fc8/8CIVwC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 19:01:11.5912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1156c175-bf5a-4ce2-0378-08dc60a3145f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

Handle the case that the restore worker was already scheduled by another
eviction while the restore was in progress.

Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index aafdf064651f..58c1fe542193 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2012,9 +2012,9 @@ static void restore_process_worker(struct work_struct *work)
 	if (ret) {
 		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
 			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
-		ret = queue_delayed_work(kfd_restore_wq, &p->restore_work,
-				msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS));
-		WARN(!ret, "reschedule restore work failed\n");
+		if (mod_delayed_work(kfd_restore_wq, &p->restore_work,
+				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
+			kfd_process_restore_queues(p);
 	}
 }
 
-- 
2.34.1

