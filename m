Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68AACD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E9710E865;
	Tue, 16 Jun 2026 21:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCj40NG3";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32B210E865
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkxicDTOGS1ETaDx5wM2GxsA3W4ah/ukd0ZnN6IrcIaYrVFIvCyTFQGGCbUcPxykWhN8slTR1K7cFjmPyUh5NApLZU7Yquk+ROEx3Jwcy5LaHUOlx0epIQEoIjdzaTDRFMoWG5rZKWOs6v9GN+jT4QqBPO4HSFgVTOxnEyKWTr8//7B0pU3GucCG2LP8GDlF6NKwujOfVj/vb4s/KiAtQ5718frP/OaiRxSusA2NoTJyBo9dI67JWYYmN0O7qpCEw4N0P7bTMz02u5EkjoT8BmbTemFy6r5uE0ZHskRqb5F079k8N1rnmr6vLHTT+dqsXwjpudKfHlEwx+sOxsodWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBzpOW/ohLAyXdqHlMg2G3xmRKdXM1rahNarRwD1P9w=;
 b=twver73JtuxMvtrLZ19+vOPfzyDBHlueWyZVJpZxtzAb1ayEqcYlytLFCJtJSmFb7Agf7xB74g+HyfmbfucC0sQRcMtt72CqTPpfaHkCD5QTuOKGpa5ON4LNct5qGG0R+gInIQVJfjY84oQHx8MvXHqDdvdUcedSBFgM1czwRyH2kHTXoq5cGdlnxUw/WCe08Ev939ujTFF3crXeO0e0ucXZvheZzW1RezGJK6o1+ESgueGLBb0WZGIdjjuv+bNJ/9AnZD9cX7Iqb9ogio64TjuKJSSS9Q4mC0NBkvl+TKs/bpgTo7ODwAN7hqdJzKtXimqwR0urdtOG/sMsEuJ47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBzpOW/ohLAyXdqHlMg2G3xmRKdXM1rahNarRwD1P9w=;
 b=cCj40NG3B0TAWoevVfFXeVgtfUdwrVlb5Jjgl2unnEiWQz8SHIIEeseHkhY5tksi397UR6ee/Q4AmjrmdiCtWxTz9Q8nmzMjuZrW4EYxaDZnGbbV7MJuPklAO+1C1+plgWnil24BJ4F4dJ24DTRJY8aP9lSoOYEOtKLckC6WlXM=
Received: from MN0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::19)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 21:34:25 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::5c) by MN0P221CA0016.outlook.office365.com
 (2603:10b6:208:52a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 21:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 21:34:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 16:34:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 16:34:24 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 16 Jun 2026 16:34:24 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Guard m->cp_hqd_eop_control setting by
 q->eop_ring_buffer_size
Date: Tue, 16 Jun 2026 16:33:25 -0500
Message-ID: <20260616213325.444949-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b80f03-1b03-4e0c-98cb-08decbef09b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /s6k1ZKHH0jbP0FmKnh1bE4M2MM1Et+di2uhU9PJWfaKsFhjilYhFITeUFv+3bPamYJ07EQpOrSf6h6ivZYU9Gudo9Cv/5u/t1aGszk5LA5TG/76dIkRCcA22MtEcdnBUGyFQIcWCS7gdrY5WVfbyMmH6Ve7hf0It5Gc1/64D0uJyQRJrBJuDvbw3GHuIYDVevXo/U7XzCa7hfPTFWV8+fOQqYFK2blOEeCnbl+PyyBnqdTvRZcLQyZ9LXfZ+XpB6S9ne7UkHgS+cHZj8le5WXIdqA7J+G6C8ld5y9qgrD/nNSAKJkUTEzO27H42qZJwgHW6Xt7j2L04JEHr2AE5ynsV97sayGaQBZnDIX1HDPLnjqLRQJX0FvLPORGrVrxGSLcFnZrOXBnXPsUJwgKFFHHZKleZ14t8cdXo+EdpkZIyp1moJnIJ2H6mnfdnrgOwU4H4IcGF73tDBGUSN77DcNUqjKwZB/DbWhlYJBN7+Y7AtHFg8MBcsK8XA/vGB9pnXjrEQW58Ja2+o/eJtfLua8piXuTxeq6QApGr7VzT/teBCOhZOZ+PX+l2VexMF0dd28SDU0wg1FPSevPV7JPXqgrDVcKoNnGdxBzsJw5Yo30c9zUqDDJkEHKFVX20CBL19jPm2MhlvIIUwBTkoNZLCRmS1gDj/vftvpztJOMRr8XVlLqPabNDQd0bTrI0fs8ueiq9iHUBgj9Vrvbj6dfiGLbbXVhZJR1PR5rStuXo/FU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tcDwSiXG2VeAD6BEVV+cHiF/vOx/Tur+lZgK53PC2mDgXn/OEPcehgis1kGxGY1UYvl1FmeCVK2KYvtuyvj8a6Pz9lE2ZRIJQtThCsR0FJ+tW4vE6Q2Rf9YnxFGOCC/13IX0SbRnGTyo1MXf8dZZrCvQCCQO3kPF3QKtL6WNXSrk7bCtbLrH9PahsRsIe7oF6+auunXhqxUjWrHJVFLXy7yvib5Mv/9TNE6MUEEtZhMWIkLggRlVd38BtIXJRV/TxSgTIH61aCSdRgw+CieVyTmVOPKDKk+X2EUmxjDrPOURcYQvGY1PFYKq18N1nosFswdMkl6dI9J6aRX6FTj1DXjqlKDbv3+T4b0hQl9wACPgKmUpOwhcbXrzNCpT2ufnCT+vFW3+Ow9PpcfR3vMJ3j740WfvUFLi093r8t7B7Bx8k2OBa5evlKJdqj/JBZ0S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 21:34:25.3066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b80f03-1b03-4e0c-98cb-08decbef09b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619
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

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 82f194ea2a21..5f8bf87f475e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -203,8 +203,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
 	 * is safe, giving a maximum field value of 0xA.
 	 */
-	m->cp_hqd_eop_control = min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1);
+	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index dff016c9c65c..7506a1410385 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -241,8 +241,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
 	 * is safe, giving a maximum field value of 0xA.
 	 */
-	m->cp_hqd_eop_control = min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1);
+	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 51dde2c86eb3..f1f923eb0ea5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -216,8 +216,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
 	 * is safe, giving a maximum field value of 0xA.
 	 */
-	m->cp_hqd_eop_control = min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1);
+	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 9014912ed82c..a6fff8032dce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -294,8 +294,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
 	 * is safe, giving a maximum field value of 0xA.
 	 */
-	m->cp_hqd_eop_control = min(0xA,
-		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1);
+	m->cp_hqd_eop_control = q->eop_ring_buffer_size ? min(0xA,
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
-- 
2.34.1

