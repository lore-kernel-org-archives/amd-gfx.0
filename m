Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054FECAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E3A10E581;
	Tue, 23 Sep 2025 07:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7n6+l+A";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB99F10E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBCT49JpMLGcXqQtiwP6BMYoJFbbUqXa4qsftIWwexFRbXAD2LDho5aFTl6Rfyeejb8inuotH9ZK47OBku29btKyUrhkG+3X8FCqw0BPQUHOavhcPK39mgt1JKOijY/xBPBjlGdosvFeUw8018garbUnc7/2TPNk8nnTIdjRwDA2P5lh654aOCxi/1U1YOvZElvZ2Ih1EyTeCgiMaCKMdJO2PUgX6lkr+glSz3UuKK0Wbr2QgAaLldqnVq0xizR52X1UIUVv/OA9jd1A4a1JL9HmPAayQBQn58Wpt4Fls/QoiIYbQjmw9aWzjeVYxj+9MGLqSYGfF8frvCAgZcCFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53UvV2hyeeasFwpKn8JJ9hRa/XjKFyOXp/yTABDt5AY=;
 b=jIbvoWjWuRZtVanmrvBqwgtzYt6c6zDGAgYASVonUIeaSy11XuHijPo/ZmGz4GCg8vFg8nwJHrwu6kfPzxT/aMj+G6c+GreNQb5etYWWAopXooUd8C3gZhHIbBUpWPPxJDyywipM6SEH3OjdTfRRe4Noe/L8enTD6bMhhPAkT1n8Br+l4o6Q8ujrTa83PCfyzDRyCCu079nJoYrJ+ofv4JiY2KGETDqhbWzYcMpebtqdiWj1iKHJBmCb7nTwI7G1LNKnGUjw5MZ6RBe8dkiJqGXCEq/J+FfmI7eVk9UrxbXpJmxDLsOBBcfXC663xu0IlitdT4gfoevmb30gQsO1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53UvV2hyeeasFwpKn8JJ9hRa/XjKFyOXp/yTABDt5AY=;
 b=b7n6+l+AN79FASQKOJYZPIN9gE5a8YwzMM/t6gh8lfebaTDCFNOl5i29naIwQRrE74tNx9UI6uUSj+SNz7VKGuusb3ivfndCcHWktVvYxfH9O0qzChcKaP6H3FqqVREWsG7BteJEvSWSmFqzFKndavJ1vYG6QU1PqhPRpZFIGM8=
Received: from SJ0PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:33f::26)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 23 Sep
 2025 07:26:55 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::8) by SJ0PR05CA0051.outlook.office365.com
 (2603:10b6:a03:33f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:55 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:52 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 13/18] amdkfd: introduce new helper kfd_lookup_process_by_id
Date: Tue, 23 Sep 2025 15:26:03 +0800
Message-ID: <20250923072608.252345-14-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: a2aec5d0-972c-4eaf-db2f-08ddfa7292f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7d0mVLo9UYZ0qSYBSWAz7cZL3h7yH95w021AWZXgYXbEQls/N7KzFXgLUCdu?=
 =?us-ascii?Q?mtGoSDOoMYuKJqVE3zoSjbN5sIgs15191FzenZP4DTFFR+vLfhpOJkLtDyIW?=
 =?us-ascii?Q?GY2ugjQFmSNwNroFY6RsWARy74qOgMt4nziC3voZJs4vFfEC9VZlIQXRunWp?=
 =?us-ascii?Q?O1KcZYSBPkAbf/hDMW0ouke1oMWnH0eK/XmBR/V/AyUP7SNgtLhDplIuLBsR?=
 =?us-ascii?Q?l4NIP3cDlcqCr0LJJWnohgTE88uS6fBOH1WFaTQkNJ8k8S5qvuq1Svg1+7gU?=
 =?us-ascii?Q?t5wEIfUtoq7Yb1t3rAIhA8sJUMb27x7ayqBIIE9NZIqwc63U2pDfMgckZ5f4?=
 =?us-ascii?Q?CB3x8u7knUR6TRl+MIrDt1uZwgjoVrvDWt6pspuXMF/mRfvuiZJXnWj0Zaj/?=
 =?us-ascii?Q?UGIoYgg9sVe9yT7hrbylCMGITUSkg7d0HWKbFpEOBuDry7P67VBRlcy8+xWM?=
 =?us-ascii?Q?IYZBpt+G9YySURnmx3WcPvoqgoib1Oxpl8Hy90MK/5wVTkdnxG7S9Hzn1ALB?=
 =?us-ascii?Q?S1ZtyW7RP1TOLaD2E35LDclfy0UFVlxL14TgqGRcIbpoPb1wpM1NlhA1ApNE?=
 =?us-ascii?Q?Tyo0OyjprF9kBcFvfW3fG3xLv/dbTkp/D9YKoEkHHExBMW/ziZoPdvI4FWgi?=
 =?us-ascii?Q?sxCXE8+ZeLz9w3Z3OABKQJXjqpurkjjOC6i2+1QqWqd6ZhZ7y0XS80+PSnuX?=
 =?us-ascii?Q?wd5jJlRvSObg7JMyMyyGpB3q80XWsfutDXl1JWgGN3KsOVHmV7E0dSVY7gii?=
 =?us-ascii?Q?+vGu+j1RI20EQS9Po47nIVttYI7QeyIyYvBNuv5PJyLXj3hog1UNVxdcfZkX?=
 =?us-ascii?Q?irA3iNQATIC5zrHLo7z0wZEO9nPfv0uprBW5WbVHZAkh++RaqEaTEc56dqd/?=
 =?us-ascii?Q?XZ1QSdYZWh8rvBiznzqOfffYU3bEdDyCyIN2C2vbFmROK8tycCkG7WPKbpAt?=
 =?us-ascii?Q?F9ZsnTx7pcp/OSHriTq9Xz76w0/yFW6UkID4zan0+U2TvwtchcpuvpUQgOeG?=
 =?us-ascii?Q?aOKZ454tayj8RKbOFOad7qs6LZjKb8sN3hk4jy8X4ot9OMDmTENEuUawpt34?=
 =?us-ascii?Q?dZqhUFdlQq/ikY6yKwLb4W2H5I2qccZyCLIduziuGq5nIxK4Db8uUn7gaMeb?=
 =?us-ascii?Q?RJRWUNJW3/bsVEyXIh85FUUne+ZHyPwCYdX03E/AmrX59S/1xQkYXg1HxqHf?=
 =?us-ascii?Q?bV0EYFjN6xH2FHBo4h7AjiDMy+GPMtCNoteGAEOTFMmu39ZmLE6oVSZD5HKW?=
 =?us-ascii?Q?YK2j8y8gqNqKyyVdmOUawhOGNa479Cy5P8WcIHs+j5s06ENQm5sAMCKvgLt4?=
 =?us-ascii?Q?iNyd7WqYIlmS5PH3o/GsIE4Z6n7zbiACMoKolsWay6CL8NTcO1OcpVWtEm/m?=
 =?us-ascii?Q?+4Z2xFmKQ5p4gRPr3APSoowSLLTBa6DcIO0y5uUasAYGelxdnYh1QIE/tUMT?=
 =?us-ascii?Q?XtIJF8N5NBsm4rsQJO1w7pJ+w2oPZWFCJvOCrv9y/ikAPP7OonDcIPP1/HIR?=
 =?us-ascii?Q?ZV2MvSJXmiCTcNFkHW71Fu25M3LR9v42oxc5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:55.3680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2aec5d0-972c-4eaf-db2f-08ddfa7292f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171
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

This commit introduces a new helper function
kfd_lookup_process_by_id which can find a
kfd process that identified by its id from
the kfd process table

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e09c8bd3e138..65cf4c366124 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1052,6 +1052,7 @@ int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
+struct kfd_process *kfd_lookup_process_by_id(const struct mm_struct *mm, u16 id);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0c3f0cc16bf4..e469ed951579 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1956,6 +1956,27 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
 	return p;
 }
 
+/* This increments the process->ref counter. */
+struct kfd_process *kfd_lookup_process_by_id(const struct mm_struct *mm, u16 id)
+{
+	struct kfd_process *p, *ret_p = NULL;
+	unsigned int temp;
+
+	int idx = srcu_read_lock(&kfd_processes_srcu);
+
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		if (p->mm == mm && p->id == id) {
+			kref_get(&p->ref);
+			ret_p = p;
+			break;
+		}
+	}
+
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+	return ret_p;
+}
+
 /* kfd_process_evict_queues - Evict all user queues of a process
  *
  * Eviction is reference-counted per process-device. This means multiple
-- 
2.51.0

