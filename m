Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBC9CD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 22:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B4210E248;
	Tue, 16 Jun 2026 22:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aqGLFwsN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C55A10E248
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 22:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3prRUic6/mSnfD2JKfdT/67IGbcuhLLSzMrbWi5vHNfMgcUHzs6ex0amptDSggdQF1c5R6HBZN5Xhmee3AmzSW1mS3UKT8JpqXleGtr3gIniWdYBpnczi2dyQ7yg++ocoN6JTZtZcduu0Gjac6s3VxmWfrLIXMbKZ+OhSB2fJ4o+CmgfN2mms+ib/NSi/xVPCNecE2rnJMPJvN0OTWCuNEG8KxcohCw63B4RlOHLuhuc9slpZV4ux4mM+IfwhEzCR3m8fxvhQYWIQIIXZGkoiGE/Hhe1S37ydFX1FqMfSPNk0R0zq2mT/X9ro9e9PU9lUwt1EaL1LzRjD+c2Jyaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV00OsURa8Oa5lIZJLlWiXzoIikt7I31AeaD3DtjOTA=;
 b=TdXJik9rMc82ZbfbK9tKqtu50V4FvCvXDi/3ZsEqRCiP6/i7tZoCNPcDMfN5kjBlwgMjkxjvAp8MBySYPZBtHwc+ocwOwsSm3epUJDJe+xqGd24gILoz4nnuElPdYDLzTQqP95vOwXZk/LSSt5xaPW71l0m5FV+2Iqh/k7WljNps+v1Jx1s6mJ/wr3ERUkIkAHr0wFG06ZBObY+mC3/Zlz6FtxAdM4FqvLC9WB4i+VTnbLgw+ckafbQMzKFX7qXrlEFzDdQUxI2c7Tl17zChMZFcxQXyD7QBLe2ajDPNeigD/4wg4nyqwMjGxvlJn/wov/75RhAaqMJNLVvsvimDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV00OsURa8Oa5lIZJLlWiXzoIikt7I31AeaD3DtjOTA=;
 b=aqGLFwsNYH/6N3LHdc2MGJq6++yThxAvtb0/sAj8ZbW40AaR024xE2wBp2m0Edsb57IXtqQDnfrGCo2doOqvsm5I1ZPnLt+CaJ1NbSSWSrFFhLEi4sT+GhxvPyKDJTDwRpgk0fOUKJ5Xbm/88L/Lt3nhxmzKI7Jmw45VuLgc+4w=
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 22:23:24 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::1c) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 22:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 22:23:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 17:23:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 15:23:23 -0700
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 16 Jun 2026 17:23:23 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Guard m->cp_hqd_eop_control setting by
 q->eop_ring_buffer_size
Date: Tue, 16 Jun 2026 17:23:03 -0500
Message-ID: <20260616222303.466318-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd74a4d-0e92-48c0-c758-08decbf5e170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 6eoPvzBejVBrCt5bzoAgmlXCuRw3ggGWLJG3V3MwJfL0gOFlo+k3pSmWJ5NDI+MZezji29OkETZpSBpN1UejhxHoN6lpmj/nBJPI06bWefrZG3CuNotRHhB66VKKkdFvRqkyoT/eMvpNDmT4KFP0t+ogW22lzghNcMPUAcUCdSHvPinqTvtsmRP7RAw5tsusXjl4/ts1hxhnpdA2C7RxyQTcDR1MgnX+Jl+PPj9y4RuqBy30Wuf7De9Rr9rgA5ohgdV4g3ZxScv5XqclqF8oiQzkDmq4acAcq/1TMXBOJrqRzXKSkVcPcYwIePyxsxp2UNbyG7jl2Rfa6SQCbNuY/yQKYLAM5glNWipUxg4KR3YkrXQMO4F2CSbx81splrrBXx6V5hxlM7i5IWITtl0TF1qq5IpvFqTycKLGX0Uib9p09IZXGWodRjkd2i8bgatzoCoClzxwMHBnJoZrfhpS3qG4taPY+nla2OhVLs88dd6WmoIV9R8bmnHhEdeZKSVulVS4GKmwLFbxF+eM5GR9rJ0YGBA80AtTizLwSrBKufBbXL9E7IBlp0TqaLh51WIhVdKSEGCTcEmg/9rmpJiRnJK5ymlLhdiIUpvaeR8966lEXVTpwQ1FL+kZugwkAganX4yIOtT4xPtKFpBJyu38yz4cV3vyuP9Drpj0oT02FQFFZ3fU19VVy/pyTMlY+Q+nkPBVxZAA8nwncfdvQH94HOX0fYc0AgsKQqDphuXAhXY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3rbnBKi0XMQrsZj5KSYUEqkL4zfihE7l1PMniJ0shU9vts39fP+YMwyTl/O/sRRgA9uPuAFUD2aMwGYUVdZCMRrtx7DksDHRFbxrosp3qeihArPcM37ipSYI1CADdRIVRYpcO0mPQGsRAhl3pRSgduuHOmq1ZvhHUNTTcrEkeBMZEAGCypSZkaD9irtiTudgnDhWSWV5R3Ds9epXtBaJWAweRzfPoql+4b6M5te4ADBS3GR7pmmlYRt4/QkcGVT/yi0V5oL7A56YQ1WKnOxaimwtEIGynPVRV2E1vok1hVsuNBVLIgwB8mw8o6dDVWQjdBrvdtZ1zs1Y4lbIy+BIGSsaTDJc4Q5clwY8hYhJwir8kQQFx2KOSDSqw9GbKbHzoCHPbYnHB78TfyhcySBRXhh3eq2hPzb8YHnBtRUIbcIeAvMDUUj6xhM1pTWUgFqq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:23:24.2088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd74a4d-0e92-48c0-c758-08decbf5e170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

To prevent getting incorrect m->cp_hqd_eop_control value.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index b3c3833b6874..14b4240de6f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -214,8 +214,8 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
 	 * is safe, giving a maximum field value of 0xA.
 	 */
-	m->cp_hqd_eop_control |= min(0xA,
-		order_base_2(q->eop_ring_buffer_size / 4) - 1);
+	m->cp_hqd_eop_control |= q->eop_ring_buffer_size ? min(0xA,
+		order_base_2(q->eop_ring_buffer_size / 4) - 1) : 0;
 	m->cp_hqd_eop_base_addr_lo =
 			lower_32_bits(q->eop_ring_buffer_address >> 8);
 	m->cp_hqd_eop_base_addr_hi =
-- 
2.34.1

