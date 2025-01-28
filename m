Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E1BC0218D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 06:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EFED10E350;
	Tue, 28 Jan 2025 06:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R64bJtrR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B429810E350
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 06:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1rUitXmuGBl19HAbm8Q/Kz/wEgyE7DG7FOs0aRVwKFJiELbyRHD+3vpHzPJ/CMU+hd+XkLi1BVEsAh7h3h4E2jGeFQX95MGNY3hHemTzUMBDbnI2fmb3FmXWkjJXMKNdiA1s213HtpxBSwU5MGA/8K2OG4gE0pNr9dQSL238uXrgqgC7y6LQt3bjWrihyxFRy5OAYTf4XgMAYroyH7aT56TPSdMNRfWFu0FYIdfLeYK4CAYUuranmuqJ+IQVe4Lm7c5ga/jqW2piEd/aeLxsDDTZYoTZ+NZI78as5uGa0dmQoJhiri/V8RE5kEUvS/J7I0Oe67ZR05oL7JAzJpxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNJwiVwsn5DoIuwZLO3luTTmNSmjaogKFay2msNaiLM=;
 b=te0exbLHbU8yvqkN8oVNx8YChflWy/fJtJ4OUfDEbIp156FXhgWHvlZUvF+CiSkA16sSVOBF4DcOc9/thqyMiar43Nez2wP1sZ5qxMszIsKxVPfXKe66Dytkc1T2yQonY59WvPjV6X7ROw9l/DR6MD8OeLtxWhfJhuijPrE6+dO0DPy7OZWnpfxufbTXjzAyDA2h5UwYAlU9wCCmBG/1rfVOsVniolq9oKdjlTZ8LcEiLmeJPSxADCkADldDW4toAG5+IIYwLrM+bqAEytPDVY5WUKvJ9xb0kOnGlgQjerGR9XMFAjtBihhq3JlNaiAa3NH6HNmsaKaluUARsRitPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNJwiVwsn5DoIuwZLO3luTTmNSmjaogKFay2msNaiLM=;
 b=R64bJtrRjWvywgP7O0i3yjeSJBl3WJFGlF9pJX80EQzWQjuKuSJcacLVcg3CjQEX5JGES/g5UXTAHWGR72scjgm5hhzam6ZumvbTeCQLNhhEXQ2iUesM1h2JLAnZbYonSXEXEg28NyslP2eLRzCj18tS745bGodir02bWRBhZlo=
Received: from SA9PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:6e::10)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 06:31:33 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com (2603:10b6:806:6e::4)
 by SA9PR11CA0005.outlook.office365.com (2603:10b6:806:6e::10) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23
 via Frontend Transport; Tue, 28 Jan 2025 06:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 06:31:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 00:31:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Pass IP instance/hwid as parameters
Date: Tue, 28 Jan 2025 12:01:14 +0530
Message-ID: <20250128063115.1690375-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a74dee-35f3-4a23-3cf2-08dd3f65683a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jEKsL9G+1WeICwtI4oFjEJJ+982V10n4NnWPpbvxSTAkiQE7hwG2/xkH05jd?=
 =?us-ascii?Q?0GXwKpjAicQZR6tIhDVMasMJllFr7zeLsNebQLRGeP2pYAGgqBTNZH/+o04K?=
 =?us-ascii?Q?ioOQNf5cischlPsJoiIoIid+gfrNfu6L6W05+30TGWhHjO5KCliXhP3i/mMz?=
 =?us-ascii?Q?lJkgjfCjNtDKO+EXAnGg23bvC4BzD3SsUeIsOK88iUKJ4IoD0TfZXxD44439?=
 =?us-ascii?Q?8hSTs+D4TX2Wo+gIbU7szceN9S2TBGekw/RetT/GQ/AG6FjUwG1IHNi2suim?=
 =?us-ascii?Q?rUVz4hWFNgd+ds7pYzOHehfGhL2F99aXDPIgJE6JDhk/oPPtm1NAUMWnqvuz?=
 =?us-ascii?Q?Xwx+lSIZ5IxwpqA0hehggdYmeo2gH56DtDYWbT1Fd3VqGwlyYR07hMQbj0DS?=
 =?us-ascii?Q?NwPlIgL4J+npdDFkWbmMjsPSrDoC25vdZC/I4g/3Z70rrvF2a6wbhdDdoxEm?=
 =?us-ascii?Q?3ECN0Jhekz6B9yktJ/zzgVftwlvX2FWmTJOguqCyMSgQj9r9bPMbYlPoI0Fo?=
 =?us-ascii?Q?c5zaJz1y9PhgdPZiY6gddXuhB3lQF3uCYvfUmw9zByIZEyEDAcGzC8NMwM/v?=
 =?us-ascii?Q?1a6IReNuSwtdprHKWx4R5hnTFCGwOBAzyYd11l6j4nl6bB9h0AtYj7CTFYQB?=
 =?us-ascii?Q?kIWC5mox0N099MQ6whB3v+WbwnmIdqRxXyXp6oA23i1QsDc60eP5dwi5qiNm?=
 =?us-ascii?Q?NCWVp2O2517W0ZLQNd1sK7jefLcUwAeZwAjGQ1wLsIQFcOgCiBdmIlq/kVM+?=
 =?us-ascii?Q?O/zXgeFimSYgcdFLeiw9R9lEPCQU/lUUu+xoMyWl2L0K2eX8fOddftFCrvWu?=
 =?us-ascii?Q?yXEZdA95URRCtlKMe6vuj7FLZntL/m5QmV7EKTlI+uGUcw+LIbi9s9fWBHiz?=
 =?us-ascii?Q?ZNi2XAujEWEn5WuhETk606Q3VAhHsVf2wy+Feb2hv0S2jx7RybpsG2grAW1l?=
 =?us-ascii?Q?zW1Eo9X+7iCTnWLUNyHtlQPkaj1LjdbKMnZp04VUtA0VPiA3ALOXgerQ25WB?=
 =?us-ascii?Q?OeU+etmvQYKGCWnKGSCfg8aYYv8KDSF6C73zvnIZxsumImQ4KYgL7eoA/Cyn?=
 =?us-ascii?Q?bshmtnsi4ndeCi7zZ3VSO/ILVtwEV/ZgJGeUITvKVe6iKjkdeIATTT57rdCs?=
 =?us-ascii?Q?Afn4C84mGeqM/Coow1gv19YoSJ/ZohFWrl3vu215bJSrCkulKxpw1Y/fY+rf?=
 =?us-ascii?Q?W6VIfPaLGpq7q0FWxbHzDA+gfVEyF9UjcsmO0mnsiYsqJ6eyl3VZh6I/mycG?=
 =?us-ascii?Q?pSPhx1KcxbRd812rBag9jB8zozjWTnEEsnma93Hz6q5HRC2g3QoeBy9uDpNT?=
 =?us-ascii?Q?zGJYBrXj5LkcHuOMtBT3Wn9urStyJR+ys5g4aPZB0fBmjo5GQahJtuvHT/A8?=
 =?us-ascii?Q?jvJyDIPwjFR7cIKWcQZhSQNPhd2U7EK9sBNn0amY+8pH5S4U79/TJAs6VdWd?=
 =?us-ascii?Q?1tccHqm3lArTL6NOh3/4/BqYhGJp97LzEIneTvv1H1x+szImHToKyhuVkGck?=
 =?us-ascii?Q?MGFO8m6+XEMwYzE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 06:31:32.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a74dee-35f3-4a23-3cf2-08dd3f65683a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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

Use IP instance number and hwid as function args for validation checks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 42 ++++++++++++-------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fbe1e23526f0..d34b97a081d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -587,16 +587,19 @@ void amdgpu_discovery_fini(struct amdgpu_device *adev)
 	adev->mman.discovery_bin = NULL;
 }
 
-static int amdgpu_discovery_validate_ip(const struct ip_v4 *ip)
+static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
+					uint8_t instance, uint16_t hw_id)
 {
-	if (ip->instance_number >= HWIP_MAX_INSTANCE) {
-		DRM_ERROR("Unexpected instance_number (%d) from ip discovery blob\n",
-			  ip->instance_number);
+	if (instance >= HWIP_MAX_INSTANCE) {
+		dev_err(adev->dev,
+			"Unexpected instance_number (%d) from ip discovery blob\n",
+			instance);
 		return -EINVAL;
 	}
-	if (le16_to_cpu(ip->hw_id) >= HW_ID_MAX) {
-		DRM_ERROR("Unexpected hw_id (%d) from ip discovery blob\n",
-			  le16_to_cpu(ip->hw_id));
+	if (hw_id >= HW_ID_MAX) {
+		dev_err(adev->dev,
+			"Unexpected hw_id (%d) from ip discovery blob\n",
+			hw_id);
 		return -EINVAL;
 	}
 
@@ -611,6 +614,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	struct die_header *dhdr;
 	struct ip_v4 *ip;
 	uint16_t die_offset, ip_offset, num_dies, num_ips;
+	uint16_t hw_id;
+	uint8_t inst;
 	int i, j;
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
@@ -627,15 +632,16 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 
 		for (j = 0; j < num_ips; j++) {
 			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
-
-			if (amdgpu_discovery_validate_ip(ip))
+			inst = ip->instance_number;
+			hw_id = le16_to_cpu(ip->hw_id);
+			if (amdgpu_discovery_validate_ip(adev, inst, hw_id))
 				goto next_ip;
 
 			if (le16_to_cpu(ip->variant) == 1) {
-				switch (le16_to_cpu(ip->hw_id)) {
+				switch (hw_id) {
 				case VCN_HWID:
 					(*vcn_harvest_count)++;
-					if (ip->instance_number == 0) {
+					if (inst == 0) {
 						adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
 						adev->vcn.inst_mask &=
 							~AMDGPU_VCN_HARVEST_VCN0;
@@ -1019,6 +1025,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				      bool reg_base_64)
 {
 	int ii, jj, kk, res;
+	uint16_t hw_id;
+	uint8_t inst;
 
 	DRM_DEBUG("num_ips:%d", num_ips);
 
@@ -1034,8 +1042,10 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			struct ip_hw_instance *ip_hw_instance;
 
 			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
-			if (amdgpu_discovery_validate_ip(ip) ||
-			    le16_to_cpu(ip->hw_id) != ii)
+			inst = ip->instance_number;
+			hw_id = le16_to_cpu(ip->hw_id);
+			if (amdgpu_discovery_validate_ip(adev, inst, hw_id) ||
+			    hw_id != ii)
 				goto next_ip;
 
 			DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
@@ -1282,6 +1292,8 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	uint16_t ip_offset;
 	uint16_t num_dies;
 	uint16_t num_ips;
+	uint16_t hw_id;
+	uint8_t inst;
 	int hw_ip;
 	int i, j, k;
 	int r;
@@ -1321,7 +1333,9 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		for (j = 0; j < num_ips; j++) {
 			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
 
-			if (amdgpu_discovery_validate_ip(ip))
+			inst = ip->instance_number;
+			hw_id = le16_to_cpu(ip->hw_id);
+			if (amdgpu_discovery_validate_ip(adev, inst, hw_id))
 				goto next_ip;
 
 			num_base_address = ip->num_base_address;
-- 
2.25.1

