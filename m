Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8399ECDB475
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 03:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0827710E912;
	Tue, 23 Jun 2026 03:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KcaJ+Wrm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7C110E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 03:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUQRc8zLMUj0t5M0+4CJWlcVNuCJxHvR/6sbofgXSH0Z3Klwmjr8rqhSoi+7YFuM6Do3F0IHarVxytsW2Sp6+E4FJkB/Qy0eSqpWCOX91ONj4djsgruZSBRiAwuwTyZwYH9EBFFfuQctttZ4g9rh8NIegXE9JMevhKW/B96xhBb5/Ih/fjvxrycVoMLk0c7kPenS7o5hhyBKLtTfKv4DjZeG8vctKIF0BqeJYjDtLvtpux1KVKHxJBMEs3mQORJ9biVsrduSPbmkT4TsuAHSlhlkADZX1jyD0abiW2fXcGWyzdagacDd7YNgWiNachaOUC5C6WK0kkwEzetq/0UqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+6rZsYd/vbDYpsrQekBrBuCA8TZAnCYjr0kKQfT4tY=;
 b=ykqG8LyBIUremaXgg/K2Jb6R4YxtRDS/D6iw8wtVWYgNldcpEaROknB1FHTBlVDo+CkeD0ugjIbXIEMfzDLV46qgnToJ8aIxJWNjXJ/XfcRKCNy3L0Tgg8AVy0/ow/NK38JYEUSb+YUS9w9/ZpyxX8vwYqDfOqJIjkrbfpBCgtUvbuK3/k6IONnGBZh5leJ+hJDCxbqAcG8aQqAGqAYAubaDMLmLF0AmQdW2Exf8jH4crZSI8BSNuLOk8GuVU2cSy4ZDs8S2g4cewJ8QB320cEH7Q+SexH+rt7L1gBjf439Z3MlfHzuioQxwDMkKxd9XSIaa+unWNNOfvV1PlDxUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+6rZsYd/vbDYpsrQekBrBuCA8TZAnCYjr0kKQfT4tY=;
 b=KcaJ+Wrm79I7p+2nug/tuY8+2sHfFNumGpJEt72vs/XuBmhwrCRfgjzJ5tORRPgPVoT7CRZBeYFtgRrl7MTOV7TIeVCdwPmGKM44Tj5/b6CVBqTMygq+i+cANxS+NLwxUG1S/uul2tl25KljuT8XUKiAGdRhf4TaqAnLRJXQUSM=
Received: from CH0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:610:74::33)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 03:42:06 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::f) by CH0PR04CA0088.outlook.office365.com
 (2603:10b6:610:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Tue,
 23 Jun 2026 03:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 03:42:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 22:42:04 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Validate pp_table header before reading size
Date: Tue, 23 Jun 2026 11:41:47 +0800
Message-ID: <20260623034151.263746-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH0PR12MB999090:EE_
X-MS-Office365-Filtering-Correlation-Id: d681785f-f130-446c-40d6-08ded0d9655b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yJEN/Np8bLRD5DdY89fjFgReRG4Q8HYvrH+N5D4XEfEjVhAZVxGA253R4HNWBGqRua2nFBwE6h4jebHLcUxa5vrkbEBk47i38EjT70r77sohvtFTsgN0Hl2Jj6eKZ+DedIIctSVxJP0YIbPKv/np6iF/Et6Xplc/cXp8c2HhNPNIsKHHcJo2b06swvYunXv9otAdjvwgNLug+cLnV93roe0c8h8dhEpB5WXPp25CiE8c4AmByWZ4xIpESkRbGM10zGPgv28/FXlJ7fsEF/sX+PLzrcQ2ULh+qdGc4Mg1V98Uqdr6LqJZn3fQF0s9kO9UtmRYIi4cbhyvF34ECbIeOPG4i4zkcR5mmdET7eAcMLQPTjDOjVNkfFyY3327lihIpq97ZmgMGhaXgSfX/+QihMA3+6yL90l8NqeYBJKJUBbxGQti/NhS6AfVkNyvMx/FyTykgJSWyKAXRgsb1YhkEvDSF9AJZS3AuC7lawFaLaX/yhMTOZq28z+DLYui0GzStOvScc1OYNzr2BDfpSEb6wtBgPMucZCPpZf4kd+1ZFBPbITJIak2BH82pv8qEKr0S85pNxt+DL37KRs6UHM0OaMYCyUgQGBe2ADl3AKFro09Kb0CBp+NDQ4VKErAn85QEhxvdSIZzI/oq5PwimBCNDKLjVuYDPFVN0M3ABBpG1QdC/CetueEp8yAo1JN3Ki+0dHqWDzQKIue22FUOoxnXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DXb7FFeti7N9MfdoJbgube/+ikgkKShuQecypess8OL454x90/XtbOCXh9fPRKdTPwsV72b1/QENZk1QSaw6pejk+AbdQGb6GA/Hl/yf1PLD58s5E3oLOUK2f5zhVcBY1DsxPT8A3lxVsq6umpG4yIVMHreyheG0NhVvo0olSy4h/N/Hmimxe9CQTBsarcW+kCwNcwMDmxoJIRuF22ay/EVz3uxfT88mxnWW0JYl2GoLKhbIGj3ZTt4pA5a4e+Bizs5sii2MLS4qUHRz2OF2ipFnAmeRrlowA/r2mpW3Y8lvMutZtVhsaqS/O1AMGJosFhpqmVkOftRucPmX0LvJI/yhufIFPVxZP9YIWvMbX26/AUkGtpNnSBUH5Cc/Q4uDrezERfFrd8UFNkGli+aWDSg+Th56s+rnTFuwGh8Mdk3ZcqZHJhxg5+BTBWFCW0hs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:42:05.9594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d681785f-f130-446c-40d6-08ded0d9655b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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

smu_sys_set_pp_table() reads usStructureSize from the uploaded
pp_table buffer before validating that the buffer contains a complete
ATOM_COMMON_TABLE_HEADER. A short write can therefore make the driver
read past the supplied sysfs buffer.

Reject empty or header-short uploads before dereferencing the header.
Keep the existing structure-size check for the full uploaded table.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d809487205a4..a6e451f1fef3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -667,25 +667,28 @@ static int smu_sys_set_pp_table(void *handle,
 {
 	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
-	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
+	ATOM_COMMON_TABLE_HEADER *header;
+	void *hardcode_pptable;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!buf || size < sizeof(*header))
+		return -EINVAL;
+
+	header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	if (header->usStructureSize != size) {
 		dev_err(smu->adev->dev, "pp table size not matched !\n");
 		return -EIO;
 	}
 
-	if (!smu_table->hardcode_pptable || smu_table->power_play_table_size < size) {
-		kfree(smu_table->hardcode_pptable);
-		smu_table->hardcode_pptable = kzalloc(size, GFP_KERNEL);
-		if (!smu_table->hardcode_pptable)
-			return -ENOMEM;
-	}
+	hardcode_pptable = kmemdup(buf, size, GFP_KERNEL);
+	if (!hardcode_pptable)
+		return -ENOMEM;
 
-	memcpy(smu_table->hardcode_pptable, buf, size);
+	kfree(smu_table->hardcode_pptable);
+	smu_table->hardcode_pptable = hardcode_pptable;
 	smu_table->power_play_table = smu_table->hardcode_pptable;
 	smu_table->power_play_table_size = size;
 
-- 
2.47.3

