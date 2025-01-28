Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1647C02190
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 06:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC3810E3E1;
	Tue, 28 Jan 2025 06:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u0B5hY7g";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9BA10E3E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 06:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA1glqio9zkdjgddOEFTtt2x+42Ck3kl5xsZuicTLFqQ+Z5QFRty1+nWZ2+y3nIwI0iA8vg4kyX30dATeqsf04fSws29kKJDur7WU9MHGXTzUPQpAXR0QOGM9NrSq//oGWT6DyAFMpmbCwoV53wETYXq1tXf8cHimo5OWiUpwXbwIKTj8t/V528TDTIoIcz7hU//U5s44ZJr8m0pevh2fsa7OMg39MDbN3R4k2+b8xbYcr30MNuXzKVHg+TB6mDrVy/poZeKR9C76j9zaQi583qmxbYgPy/9BIuE272Nl0yOIUrx1QntiH+z2RUseffcOJghIdLrtpVAF50E3O0JbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijhm6vzAdik59TdPElnhDo6BQyKVCLDZRts+kHhKQMU=;
 b=k+r5TncliiNs5lifa443sah6ZdPw2Ah5FUC55uDzPZ35MS2kqXwLx8GVl/A1jVCBi91wCPhqL3TEdYYqPGUQkr1YCCEmS/05r89LDRYE8Poq/KsYBxJpX/MROOvPyTjJoW7V7KY3l1VdKKFVIymh/AalT9Xpf2OKl057hhI8Oo6Yl/5PQcGMNV64cloiDhhnawc1gSKyLNjqIOUQY+tjXKgJ6OZgUi99CMflBAe176yixqCDjPL6ffdSX3CTsZwrJVsx0X290BOQevLme8Sm8zOlYKkV6CwSpFAuGorORSHkBJDWLMO1LFjatcuJ8wSK3i2mFtF8tkAGi8105FsLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijhm6vzAdik59TdPElnhDo6BQyKVCLDZRts+kHhKQMU=;
 b=u0B5hY7g3ujJn1dCIABKs4B2fW5NbZYm30JYhoR9cyA1XPlQQyoHHFriNgQujdePeEo9M9rcQ/wHa4SqrHPFS5nWDMmtw9Z7pcGEEWEdHKds9US31s8MTPqr9qdtSL2tDM/JII9zaXS85rfW78hF4LB0T89ebd3RBgXvcYb0ehA=
Received: from SN7PR04CA0213.namprd04.prod.outlook.com (2603:10b6:806:127::8)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 06:31:35 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::eb) by SN7PR04CA0213.outlook.office365.com
 (2603:10b6:806:127::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 06:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 06:31:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 00:31:32 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Use version to figure out harvest info
Date: Tue, 28 Jan 2025 12:01:15 +0530
Message-ID: <20250128063115.1690375-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128063115.1690375-1-lijo.lazar@amd.com>
References: <20250128063115.1690375-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f476cb-f4ef-487d-b2fe-08dd3f656971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KHssgcKbmLVxdtshlcaKht7UjmRodRIVuASDy9O3gBUMPcqMfTL8vx5bSWPo?=
 =?us-ascii?Q?WFTuHjm0rnRrLMZH4QXveltYInA/yC52QUBtc0BlG7t4ngZ1vtNjINUwxhx/?=
 =?us-ascii?Q?esUiwx/wxAiq6Gt/iw3RHktQmhgwbjx3q549crLlpOFfLmYy+3X0GrYka9+X?=
 =?us-ascii?Q?GqNkOXXJ4C3dSc98mOLqOqx33WPUoW5/pG3VIJaqtAnwxi2dTQNtF2nKY4EO?=
 =?us-ascii?Q?6Avb3AIoLI580+DOk2AkWKmjVgxv1j2YjkJZSWm8zgqU+ntGqo8+TI/7/i2b?=
 =?us-ascii?Q?kDOHQQ8Zw/HFUkcmQXQGxe2c1N9H2DRh3kCuHRpinc+qUYX8IWYSurlXCA9r?=
 =?us-ascii?Q?e08SbFQFn7UOryvVFRjHoX42ilVgvnEwxJ0plcpQZCd26ruOhqw4PJ3+Elqc?=
 =?us-ascii?Q?YmczRzN0fFg92o3sDy//SizWuu3d4S2JAQOPR+NF5CVLQzeSxBwsh+gXuixF?=
 =?us-ascii?Q?NjxwMPbGfVBezTnrszENgWnWu7J7D2Yyp8TCrPqoylRG1UUqMaRF8mFB2gKN?=
 =?us-ascii?Q?WPviIyTCdl1EQukaWWB8m5+C0p0rGy44Y/b5+xFe1Bve5PaJCts6MkJTrjmR?=
 =?us-ascii?Q?tc6LaNXmiIURSBOvSKwzOKl6BQQ8sURdgkyVLqzMGA0lq/Ra2tU/hmGXyUKb?=
 =?us-ascii?Q?J7ccA5lAWdn2pa1Wkd28L3U8fUg8H3fZLCEpU1hsEFQDWhMIEAG+LLtdV+LO?=
 =?us-ascii?Q?hW93BWdbo8soBJ2OnO50H29/5RuQa+O64ifYNptIK1cBhJjA1k/R18R1oUqW?=
 =?us-ascii?Q?kUQcNt4jHCOvM64rHpg0YQtiPiIqmr+YxMq+E8kBzebJMZEBBhGSVrsGq9AB?=
 =?us-ascii?Q?zC1IUnFT7ZkzPUeb3OxzFO1woIDPz6Rk+w8P7HXNLPxDZDnbaMwj+Ytv47Rb?=
 =?us-ascii?Q?MJ3wgyxvMsEieKsjsUm5k5hYZQw30V1H43BBBQbN8+PeP0jvzKjhAWLm9735?=
 =?us-ascii?Q?C2sJOJmhOhDeZxQkEjJpMO+45g2LiBW84TjI/kSuomXEie4CQj5KpQbiYMLN?=
 =?us-ascii?Q?iJNGB1tuIFhbUporhOAUC/nhNOK3rS9U/Vpv8LMhC37cbkIRkUsmYGJNQsZe?=
 =?us-ascii?Q?HJBwk1kwS9wPSz4qJC7HC1KIGg9M1EAlfOyqNH0155JdyH3Ta/8txkylT2dB?=
 =?us-ascii?Q?2YEWNjzp/RwZ+qMNkJtCqUHw9QMESogbgUiO5dL9PwaLv56pK+/UpGXNvsor?=
 =?us-ascii?Q?xs7QS7y9pI5XSKOCJpJQnzZmDgEt1KZXv/J/EiFB8NuE18MEjpPs4Ux+427Y?=
 =?us-ascii?Q?ui7mOnYtR/e76mRpZMhJdtP07/5nHaz58FtCxd2wXYXRHB67trQnTHOtwWz0?=
 =?us-ascii?Q?JTOoKXDJPKVXE0npbqcEA5hRrZP7sPo2Z5/oXtcGyjZYYNPFuPotQMKf/EK7?=
 =?us-ascii?Q?JZ19ZJQj3XMOEA+eTZFn7nB0s9xSZEZfTSIfQlfMz47fmXWmXvD4ypZlLQiG?=
 =?us-ascii?Q?gsr2juc6+rmCAKD0c4RR/Sprlm2ZxJLNpGCegj+yF6KCFrxuyFaJog=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 06:31:34.8846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f476cb-f4ef-487d-b2fe-08dd3f656971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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

IP tables with version <=2 may use harvest bit. For version 3 and above,
harvest bit is not applicable, instead uses harvest table. Fix the
logic accordingly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d34b97a081d8..e3afdf933dc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -612,7 +612,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
-	struct ip_v4 *ip;
+	struct ip *ip;
 	uint16_t die_offset, ip_offset, num_dies, num_ips;
 	uint16_t hw_id;
 	uint8_t inst;
@@ -631,13 +631,14 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
-			inst = ip->instance_number;
+			ip = (struct ip *)(adev->mman.discovery_bin +
+					   ip_offset);
+			inst = ip->number_instance;
 			hw_id = le16_to_cpu(ip->hw_id);
 			if (amdgpu_discovery_validate_ip(adev, inst, hw_id))
 				goto next_ip;
 
-			if (le16_to_cpu(ip->variant) == 1) {
+			if (le16_to_cpu(ip->harvest) == 1) {
 				switch (hw_id) {
 				case VCN_HWID:
 					(*vcn_harvest_count)++;
@@ -663,10 +664,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 				}
 			}
 next_ip:
-			if (ihdr->base_addr_64_bit)
-				ip_offset += struct_size(ip, base_address_64, ip->num_base_address);
-			else
-				ip_offset += struct_size(ip, base_address, ip->num_base_address);
+			ip_offset += struct_size(ip, base_address,
+						 ip->num_base_address);
 		}
 	}
 }
@@ -1474,18 +1473,24 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
+	struct ip_discovery_header *ihdr;
+	struct binary_header *bhdr;
 	int vcn_harvest_count = 0;
 	int umc_harvest_count = 0;
+	uint16_t offset, ihdr_ver;
 
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	offset = le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset);
+	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
+					      offset);
+	ihdr_ver = le16_to_cpu(ihdr->version);
 	/*
 	 * Harvest table does not fit Navi1x and legacy GPUs,
 	 * so read harvest bit per IP data structure to set
 	 * harvest configuration.
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 2, 0) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 5, 0)) {
+	    ihdr_ver <= 2) {
 		if ((adev->pdev->device == 0x731E &&
 			(adev->pdev->revision == 0xC6 ||
 			 adev->pdev->revision == 0xC7)) ||
-- 
2.25.1

