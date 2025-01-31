Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBA4C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF82E10E1E7;
	Fri, 31 Jan 2025 16:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49ywU5p1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488DD10E1E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTSdMUoghmxYrx81/z1+xI3ptLDv8PEW2hf6GOeRs7Ty0OWa8t2w6zxRtlCrze+wx+mQlA1eX6axCITdXOCJwi2TyMKCuzv1HAtA2q/qxTqUk4x9Y4LWeCNycISvySBZlDZJGMc/Ty3Ia75iZXUyKQcTarRLgPVc5Goow9GiWz0HK/ncrQWlpyqpIy0wHGwjbjKRkCmJ0EUuoTc1Xx+m9gUEBn9LzadNwVXagFvpfSYdikTZQAZkQXm4rZAgcs1UohEfCesMU5nu5w7KtGe37RJcuH9FmHWdbkxpoBkSKbCln4bKRq9P7qSkTrOQxeLvBcKmFxK4ZcXEaY7KqzVevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0TXVYuprXpft1YxeaHKK1A3IJdXyUa9meM7viiOetI=;
 b=JYPcvstInwCgJHyjplGH3nRSf/k2XbEOfDiFafbs6Wtyr1LPeZzycmkSkSD69wqFVEix+ct3ypQfs9UVNNA3AlFNYdo0m+a3ctDKJvGz7X21400oKHirYedD5YU68gRTLDUTksddMzOIcy8gzoZfq7KThEIuFiF7lSwgwvmyfwVVEZz8PUunu/CqzEH96/3ZhQt0+KDEGXAMaD+LOPyj/BxOJ3DABmb7+sgerud4rPOZN0pwkNdICQk0mnT35+d4v8VRcpcKE7QUQ+wtfqpcR5IXbEJHZWr9GQMWWHS4koN1LBw8/bBe9Gib7eNNpINWlv543iyVZ0YnrIey+VgclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0TXVYuprXpft1YxeaHKK1A3IJdXyUa9meM7viiOetI=;
 b=49ywU5p1sC3LgUPtuU2XoKm6LchhBW5UrRpozfe1Le34W2Hm8X03ZvC6gdJ48fr7BBYg8gTcOjZbAHzO5WjgVN5T4n8CF14x4cxd8JegCezMq1JCzjzBf3Pb6wl4fPtexTXoKsBE38wcboATY3gJZqySbfEILkvwXxIr9PfOdnY=
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:53:16 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::23) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:53:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:53:14 -0600
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 31 Jan 2025 10:53:13 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
Date: Fri, 31 Jan 2025 10:58:39 -0600
Message-ID: <20250131165839.8433-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f32e0e4-3ecb-4494-9dc8-08dd4217c1bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOqs8TN7GOKEZ26SIeTQLjSoa38rvQIxrGRICbvmllb6vrijAYtpTlA/qUXW?=
 =?us-ascii?Q?R3lzz7wdDjsdC96KdXGeTjWd67VkiT0uYEKPGNuzlvrbe4SOWE6jAQU55Aad?=
 =?us-ascii?Q?JpDDgT3dzv39bB5zqiliV3g8f/bFAQxVgtuwly+sU8o2bBjGNcLoKoOkmPyb?=
 =?us-ascii?Q?CXvtVx8gSsJWRYJlXT/taRVx90PoI0slTcyBHEh1+8tzaJ6OyShtwpSmMJR+?=
 =?us-ascii?Q?AGEuMniZBmui0UNmLEf2MUBTQXvLFA07uuAszopERsvM9iOwKAWXpa0ogQv5?=
 =?us-ascii?Q?mmJ76RftEUIaab0OLbW34GJcuWZETfQ3MTP2pAp74wGHLbQqau/c1U/sa+hf?=
 =?us-ascii?Q?aXzs9GwW9+UJyVLeZGrgUTdTT5VhhgQSw3NdlZkzirR+d9sINezlqImekoSM?=
 =?us-ascii?Q?ykUO92gw3+WT8MIkyzyfgE9glN8/39ElH3kRkPv4XVxZfv+xsHsznXaQIjHf?=
 =?us-ascii?Q?k8U7qmB3tV/wX0duEbloHTB6x0fnsC9zjsD9nHEbjeNjdoJk+BRcpefpEtqJ?=
 =?us-ascii?Q?dNLbz4Hu0axAucrHpxmdaJTY0C9ZLtEtT8nqwWdSHYVkuFsU03Raxm48Hd6y?=
 =?us-ascii?Q?khZMB2R6XpnDskatsi2DO54em9JksUhho76eyg+RbdOuOaJvUKOXSGse1C2n?=
 =?us-ascii?Q?9yndj37qlInB0ij3sAglu8LcwhpSjUiQ7tdJUwHh2mRUUrH9MKrZ6xyRuMER?=
 =?us-ascii?Q?Iaihueiakr/ZrqkDBA/vnditz7nYwykKkVWo0IqvTd5eJqKCNy9rhR2CyjA1?=
 =?us-ascii?Q?adUOrB8IjKquQtTk6PJs+lkzK/L0kJD22Tq5qivpAlSPOcq/VyF+MVdkYVAF?=
 =?us-ascii?Q?c85CBdMqGkl+rPtxs1dWTYbzFNhCBYo8L+FJUJQ6yjXdf86ENGxx5PGxUHvF?=
 =?us-ascii?Q?/GtLDK5n900/WvthAuQN725uBf/R44eRfNiqMpgcIZ84CSjxzjajIQQgbzJH?=
 =?us-ascii?Q?vOnFafq6Y/YPymbpFiB2t9h0PCIginYGWOB778+tBvOADStf45Fo/N1uJJwd?=
 =?us-ascii?Q?lsCcntnYYaLdjX66l8SRtA9xc1L7/tErP3DT6aLANQLAG25cXzY2LQsqvbpR?=
 =?us-ascii?Q?ADN6Z5v8KKBUzqyKONDrLKY4GYK2LIucsrlzx2GXtiDJLUWiqzzNFQ1ICVLr?=
 =?us-ascii?Q?AQ+wNUMtLC3NtozbzrYgzFOQ1ewCEvF5SnBNObvZCPEhI6PsVn0epb6di/SF?=
 =?us-ascii?Q?Dow39G1f2GTw7WHiH/QREwIa386tfCP4de2TrZvtk5NI3/1iXQqtdh4ztmXH?=
 =?us-ascii?Q?1y4MQmfLCdulswVoDYS2JKoYpySDld/5YHIBYORi4wWMAo3iQhQyLfnsmU/U?=
 =?us-ascii?Q?LIYqT+lXWHxOo9nkvbIDJGyFiwAMDgIGFjyJt0KcrOViJdRV92TzBqSPWaOv?=
 =?us-ascii?Q?Ns3rkk2T4koVOTa7bmQ1MsN8n11JAzKrn/f0pK91eHAK1TQHEYk/uxuI91aE?=
 =?us-ascii?Q?WigQQgzvdf8X1ykGlxYhuCncqZBA3IQ+uSFP0OTVImCbzt55096Fpi+xeJMr?=
 =?us-ascii?Q?+ilJ13lkQokL55E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:53:15.7026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f32e0e4-3ecb-4494-9dc8-08dd4217c1bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When register a vm range at svm the added vm range may be split into multiple
subranges and/or existing pranges got spitted. The new pranges need validated
and mapped. This patch changes error handling for pranges that fail updating:

1: free prange resources and remove it from svms if its updating fails as it
will not be used.
2: return -EAGAIN when all pranges at update_list need redo valid/map,
otherwise return no -EAGAIN error to user space to indicate failure. That
removes unnecessary retries.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e32e19196f6b..455cb98bf16a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 out_unlock_range:
 		mutex_unlock(&prange->migrate_mutex);
-		if (r)
-			ret = r;
+		/* this prange cannot be migraed, valid or map */
+		if (r) {
+			/* free this prange resources, remove it from svms */
+			svm_range_unlink(prange);
+			svm_range_remove_notifier(prange);
+			svm_range_free(prange, false);
+
+			/* ret got update when any r != -EAGAIN;
+			 * return -EAGAIN when all pranges at update_list
+			 * need redo valid/map */
+			if (r != -EAGAIN || !ret)
+				ret = r;
+		}
 	}
 
 	list_for_each_entry(prange, &remap_list, update_list) {
@@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		if (r)
 			pr_debug("failed %d on remap svm range\n", r);
 		mutex_unlock(&prange->migrate_mutex);
-		if (r)
-			ret = r;
+
+		if (r) {
+			/* remove this prange */
+			svm_range_unlink(prange);
+			svm_range_remove_notifier(prange);
+			svm_range_free(prange, false);
+
+			if (r != -EAGAIN || !ret)
+				ret = r;
+		}
 	}
 
 	dynamic_svm_range_dump(svms);
-- 
2.25.1

