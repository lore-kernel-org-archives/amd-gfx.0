Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C14CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B4610E579;
	Mon, 22 Jun 2026 08:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKZW6nLV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224DA10E579
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn6ZEaKBkRf/pexiYLFgt6qMuGtm28oXovRq3NPRkXVoG+SwF5eMrtXcYCZz5veZc134KLfJspR59ai3FxpLG/yYDFxq/Tde6OLTB9/1HpZMc6xutf9NnZJOiFN3C0lAzMXOKDnG+1W4XcHYEq20QlaLB5Y4yazwKBWKbJ+gGN9HOc83uwUEH4mjJZDaLePweTWPQ3znMCTwr2X0v9Ynw/oNYGwA9qOUdxeEpLPo1UZd3zXFrl/8n/dQLcmQniB5Yla4sgjVlhWhO99ZQ7BMf7t7cLOWZTqTOV+09+MNcvYlStWgM5iwl5yPAThVREaPYXArW9HCboMxwsWvoIYoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72/Mm7RbrkPFDQeEnIiW/3QFl7ZOnvm849Iyf93CkBQ=;
 b=HlwIDnLXjOzwWfXAy0tqkIMZ+kQnmtBpDN1/q47EmHFZ1zpOyPJacSU5EYIOdfUkBcOEHXPkU1ufXbtUTEQDS/r84AQd06y5nh9f1bAJXp7/iMX8gsFccD0dnRDgTXCe2bij+8/XyBhDwsUe225FSsjf49lIERogE8e0Q81E+ubiIatdZi9lU0L80vbIuTDNA78/AS3kvTwdCagy7FvKkjfnVqvIxHWsDzbgyc6d3kJSknnFgH/zeznbqH0mzWiInRYkN9rQvNVxVLpJBediPszURsg9KeTd7iB3DOsj+mizpFf4WWGKPVH5L2SWDqhXWGG42fxJBTBEiu7yG8vbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72/Mm7RbrkPFDQeEnIiW/3QFl7ZOnvm849Iyf93CkBQ=;
 b=WKZW6nLV0axAigNLkDFV3rtk2hsGq1nc8jXpH3vHqV+VZsYCquVTfLC2Ojh6/gd88iIa6oshPZ6iTwiI/jMyk6fOLipUtCaDk20C+4gepD+A/Tprmg+DztLHrNmz23ZobzaXWhCchax1ADNRXSNX0loxENF5LsQ08ctEgtOw8aM=
Received: from DS7PR03CA0252.namprd03.prod.outlook.com (2603:10b6:5:3b3::17)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:46:22 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::34) by DS7PR03CA0252.outlook.office365.com
 (2603:10b6:5:3b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:22 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:20 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 37/48] drm/amdgpu: retire legacy pmfw eeprom init
Date: Mon, 22 Jun 2026 16:44:39 +0800
Message-ID: <6a617786496883710cd3420da380a5caaee36f37.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 08af4de4-c813-47fc-8521-08ded03abc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jy3aR9xL0ctIRu56QLV01b+85R/J0iuOZKFLhYsWJESu100MSNCgKT6wJDbgIRdjJ32Wm5iDs4VetEFAMLWm9NNE6KdYBKMaCt5eZTiL5pnihqh5NLwnNX7phhFhSkFHNT2K7hqIOKK+hQkloxvCxu6DhhHiqua4ZX/lXVTL6/gPaHUctmASBSjUIG3teZWQYAbkODLx8RdbpFyQQkFoxx/SRtyzRpwJ0Nvaq6ZZtWGX1du86PC+XXd+7ZSvhVWIE0cBzA8c+FsPQdYLZQhhQ6e/FCIUCVJ9HyFj0CMH4DSGa4qdRbhsrOBMG6xZppCyQRospoTqgQefw5hQFi+M9ppEjQr5+TkumhC/IyhZxJgu4Ggh3Np/2WmyRjSCpXYw2e6iVNtIjnTloNUtLCliQqirMep5uYU+GJftuxB86km8yKUgvM2aeQzb76tS4cqjEEVc90heuPWlfGAQmifHDK7LLHxGoGp8429vZrNRB46MPRJ6Dr9ipXEbtxCgo6MyYbhCc8pezZwe0Pw9Qb/K1gscko3i4hkqPoUGpPZFc+lVks4STK9tIIq5zI9alvkvpcNovHvk/qZU9mS1CnAJBZqhsZd+TqV06CeQu63cmT4ra5Z/zoBBhFjpIIKqpJSlx+MvCjMWubR0K+JmqYq8RDk8V+UbUIFF4iHVEXFwt1nCKJb1b1qEAybtSl7FIPcB1UdPpgIHD48o+717a4H97A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pZe41WjktiqWhdIhh0nZFIqtFsGeFbtaSGoAca2XDc8nWMBuwnPyboqMM5ydt+tCYruvx9zANXwJwcX7yROE3tm/JZHiBlFzW8wwuFDSB/mEw9IhwfL/D0g9boIIHyUnG1LojzXjLY0GjdPIBJjS9h0QH5T8Gqmd//GL+dHbvjtCfkQOktvrTN0qrD3PJ75xqtULAXpcP3LDjvH9b9hQmJ4v6CTnypHY9BmOepyopybmcQhvrhAFpVJ93cbYLIS0HQnv0h8KcbFpm8kqj2YzTQKpCJfqlwM1PP3Ubb4lWZ/UptjJYHK6hcx621GfWSjIhj/VO8rr802WDIPOGIwTLCwNHQ7v2j5cpknrUMAx4lftwUEVm6sO/PQrlTMXRZpr2BB2FzthGRJ7210F7+pT8DpgyhLY3Gsi+JqWOKl5KVhzNMrBY5QWx2XZJNsWqZsq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:22.3192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08af4de4-c813-47fc-8521-08ded03abc92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771
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

Remove the legacy pmfw eeprom initialization function,
as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f5d1bc1142a8..09aa5655e3c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1485,42 +1485,6 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
 }
 
-static int amdgpu_ras_smu_eeprom_init(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint64_t local_time;
-	int res;
-
-	ras->is_rma = false;
-
-	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-	mutex_init(&control->ras_tbl_mutex);
-
-	res = amdgpu_ras_smu_get_table_version(adev, &(hdr->version));
-	if (res)
-		return res;
-
-	res = amdgpu_ras_smu_get_badpage_count(adev,
-								&(control->ras_num_recs), 100);
-	if (res)
-		return res;
-
-	local_time = (uint64_t)ktime_get_real_seconds();
-	res = amdgpu_ras_smu_set_timestamp(adev, local_time);
-	if (res)
-		return res;
-
-	control->ras_max_record_count = 4000;
-
-	control->ras_num_mca_recs = 0;
-	control->ras_num_pa_recs = 0;
-
-	return 0;
-}
-
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1531,9 +1495,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	uint32_t vram_type = adev->gmc.vram_type;
 	int res;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_init(control);
-
 	ras->is_rma = false;
 
 	if (!__is_ras_eeprom_supported(adev))
-- 
2.34.1

