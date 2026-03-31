Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A23A1061B2C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 02:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A00D10E7C8;
	Tue, 31 Mar 2026 02:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvaTxhPb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C7610E1B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 02:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYoXCq/Xox2NJXmkdbieCOkFIXpaMr5sNx2Kwzk08fPhFgm0mPuf6I4ZIZK3yIpjhpZLoIaaa9WMvz6sE5WaMy28D+imxcDOfmNMOd16+ZAfNe58REHRp4ZNFd6BPwy2H6QNZ8smZX2dhqqpEEhHb9BKd1FzF3STbcdk6m+k8L2BdsTq+2W4gUaUUeLUzCmfOi+ef4llfXraIr0lVzTUJsmvCMVIv3jMuhu0Wfy05zsen12dBVpLh4HDx9j+EuBu6AX9CXM7rnzMkXzB4sznHUX1R7Pl3Gha6oFsTEmSbFz6854vWNIilIyFX8blSJxQSB1xUcgGVrMQH94ztCxDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+a2uqc0iUDkfGRhlssYB5SZ9ABTCEMgck0dS4rdWyw=;
 b=rkg8ylePYcs6b+0OrmVAekXC+zWMnanrj6w/VRDy9KOa74oZdHf+NafsCUlXFTQYFZcGl2OWX+UZJ7QrY4aH6miI/g0Ow3QZgplGeqCpYV/lOKHkpKNQibaqDF7SHDsQSdVoNfxBSRtcIL95bid15PqOeQd1dof4AFixi09UCeb1MxyEZRw11e9BtKDlZpntX3tkpGy/VXxi3DbYXZsoiJrc7ZpXwDWRwBQ5Q7Fo7HgsqPziyDW0KkKdIg1C4pqPx5wa1qmmCS0tW4oAdZzaxEz2WE96SDXfxEu7UK7mYeESDN+BczIFIsLA69ol7vNDJn/D5R68AorXz82QXjVw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+a2uqc0iUDkfGRhlssYB5SZ9ABTCEMgck0dS4rdWyw=;
 b=yvaTxhPbuCQtUBh5GNwFpoWnEdpYGzBWI/HGUlVzyRpBFfMqkf8z2H/C3thwWwF9XTSTifPUocY716UTh43Zuwvvl0be6NYdcLmWkOmAM9/OxxtEgAsWvSNXhNPp0ee6hQiL/VA6bLMUanse+AX+QmtRqP1ufMlwedEBUbe8mdc=
Received: from CH2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:610:4f::31)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 31 Mar
 2026 02:47:19 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::41) by CH2PR18CA0021.outlook.office365.com
 (2603:10b6:610:4f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 02:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 02:47:19 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 21:47:17 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <lijo.lazar@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: fix null pointer dereference issue in
 smu_v15_0_8_get_power_limit()
Date: Mon, 30 Mar 2026 22:47:04 -0400
Message-ID: <20260331024705.1361626-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331024705.1361626-1-kevinyang.wang@amd.com>
References: <20260331024705.1361626-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: f820b2bc-1973-43eb-e61a-08de8ecfd3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1dmZlkFh91HZsx8X0t3a3jcnmMFFZ3awDMbukc4Jm+LpXqylPhj57gaX9cAezVjuee0qySPpDC2lhr6ZRVvOPFQncW5KkqFr0Lynm3NbZqDsrKmTpbyfbOQSoD8wfTL6Zzd8oKN3h5ZcRh/Xl4Ti6gdgqmaUfP3+KdqJkb/gBDtZic6VmfRZN1vqT1CcSbFhjkZjragvbtEYSrOlggzRppvKj2GVMfOhzvQ7syNy8K0w29u+UCGBJmwTuyfkUcPa5Kz/hjitQsytNxkEMI2VGbMptEF+ZGOK082beiQTagLo6HFhDr7U+yXz1g0ewVkw7DT5Tn+YL2zk8m8qMKDwgLg8YwoL9DHUfhMTZA3txgm+AiyzCw/Vi3Y77ta/pZ2zhlqSOtkijE/tnQ5x9Losn6YejAuFE2xlVIg4CrReW3izRRcgLHpP3d8+0xCcWcymLkH2PfqEyP0jp2+6k5FL64kdK06Lv/0rueooXKDInkDRM8TYCm1wJxTbVTXcVgsgL0siDIlO/ceuOCqCnhAOc8Cn9R/0BxIF/boz9sfsKal/aMhhvMHRADbEjvvZekjee56HQHxJTf7xGjDywvskW7bCpV/vGHuhB2xnIRhcHX3R8zCs08ZiTwFUh/2jiZS2KUNP5GvdZMviBgcbIr7eK9bwf1ona5dtf9pOamKCKljFuRZfa2smhjbHVJfRBcIScVuGU/rTOKiGJ45CAHa4g3Ki8K7b7iU3kYiIFlI8fDXJd7PMRu3whP9MHKtaaaozIIEAlOVXNwH3+iDnyVJmLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wTXdUdrQT9/a9OD7SI1pP64KtMs/psXSo59XLk/Uxrt3rmZvRXa65g3ag7OFSuq0rTvzLDr1RaJ9Mc4KP5K6lutldGUIHQhJYgXICRfajfBlqMNLvspdgwnita0cEwnAQzXlcN//71qszPn9QhNujShwppymykIfZQJCefWEvM3E3/lMC/pz3oxVUf/jQGjBxBWWtVGP7Ji5UKXEmS8IVSPnboa6AijmIye7l4BNE39NXXDvQR5napfniCuvdlty/B36Lss7flVu0HPJHYyBiHTSE7xC3FaVQFc3Ab1rS3PsaStqdNdSChaxqqZjjyD+UKefcnd0kYKcnf6vCsUirsZoUz6yVTABCFyS7x+ip+bsmCLzjFMmz8f7+v3dxund3k9NCaDf4CaIBEmjFv6ar+GTXtSgWJT3fTfzRooVhXM7VIyQO+WlNliHFegw8Xt9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:47:19.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f820b2bc-1973-43eb-e61a-08de8ecfd3a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A
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

Fix null pointer issues caused by coding errors

Fixes: e4efa501f972 ("drm/amd/pm: add set{get}_power_limit support for smu 15.0.8")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index b158be7cd7bc..ae43edfa93a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1773,7 +1773,7 @@ static int smu_v15_0_8_get_power_limit(struct smu_context *smu,
 		*current_power_limit = power_limit;
 
 	if (default_power_limit)
-		*max_power_limit = pptable->MaxSocketPowerLimit;
+		*default_power_limit = pptable->MaxSocketPowerLimit;
 
 	if (max_power_limit)
 		*max_power_limit = pptable->MaxSocketPowerLimit;
-- 
2.47.3

