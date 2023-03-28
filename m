Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285A5C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AD910E10F;
	Tue, 28 Mar 2023 15:04:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204D510E10F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYUWL6jf/kblPYK7bIxW8ZsLKEtIhWypvTi8BKK0hmVfkitDxeLFgsNpkw6gt89RWfxxqzL6Yf+0G6eXAmaAF9aWMf0RovYZwk00Zje6QhME6VPzAL63tfQMoTRewLHP0WXRYBYIIrWkifV1Y1ylTzVjPyuyOCsU4F1XeRkr8rJ7VYazMhZDIEylhGPNM9Ln6BQYBqojZBctIfp3OLrnhiSQLqM2JpaYifx3LPbEd6V9fYsqKDIYXqLtigbGS+Rjn4ikBnw6auad54xGUtVq2AGUURZU8zp1aVJS5KycxRRD95x/r8KI9BZ6omh+nf3KN4jYXFM68pWorNqBU7DnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZAWcMg/o1cxYatRRgFNhcxfEngeMKD9F4CLwiz5MgI=;
 b=LKYTu/f8TZ5v9wlWbif7dUtfUX4O7Ju+pZgL1dkP+6/FKuAaQkIFpYM8NUA1NgQlB6aBboDQ2JNu4NYS4nmyrmXB6RgzXV3wO6MVNkrFwENfOc6/OxfKVpM6hWXblOgKSUVVE1hBQqhl1khxgD3DZfEuew6SKR+gZ0dpdgf4WcNhuULz7VspC/6aWL133Rqks1UAf7/qoKoiRwZPeZAH6iWq3gbXWfIqlGAiCeMmcRy2LryngU6SgTnD4bka5i8HVNbXqLxO7dkVpDdXAIXh24QW/9RiUEq/XJX+TMGofDUN4zRUfj6HJfefZgcQUBbfpiwmIdKvO3B9cCpNKEqprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZAWcMg/o1cxYatRRgFNhcxfEngeMKD9F4CLwiz5MgI=;
 b=h1FrxnWc1tORKAJTwzuaWRTCb5SBuhJ/cfkV3NDul+u1ab6a67kDnqHmL3H8edMi6PzjvNV1Z3gRVPSgD/0hSiGNMUjk6OzyCHRwWLT0pmp/voy2IcjT0qWdVs94CrxJFo0VoZT6RcTNvE0Cr5KvbTpRJaKxA0aogc64bGub9uQ=
Received: from CY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:930:1e::23)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 15:04:37 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::16) by CY5PR04CA0030.outlook.office365.com
 (2603:10b6:930:1e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:04:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:04:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Set F8_MODE for gc_v9_4_3
Date: Tue, 28 Mar 2023 11:04:13 -0400
Message-ID: <20230328150413.1933313-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a3028b-3529-4f28-317f-08db2f9dbf96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjFcPhr2w5au306fYnuAqCBGz+4a4Lo5UhrvVd5TJ0wypMzN5k3ToUQJgOAgfPcklKrTIod3RH12IF6Fo0AEZHUvOgDr5ofnTii/VlEwLNl3FJFCqI9dJef4h1VD8I+2NnMywDKEPKfs/Quhz/kC/+Xjc7IjZ9ct8SMm7iTld3m3h6364lnpGPKlud2jZOXLJWuuCGbCZ+CZwS1ZZ5SVxq41JLbjBvzB1dhK8acibsbkHTgPkHapytdOwkT0C0aOevIajWpQcgx0XmtQXgLIQmTxiZVyFKkCrQkkFKD76oyden7cpbB0tthYXKFsPU3c27YQaWLx2w17hsEvFr+mzZwB5bmFTd58IU1zK/nXd+0wmUf6pIT8rYMCm4kTMExrqtbeF4QziE8e5OzBchblzBxfmkloNYn7i0BqmU4Wc8dKrZFvg4BqXkQXNIDQl7Tbus7dGyH1HLyHjYFGHEotj2BGan1S3pi3u2k1veY3S7Knf5xiTpdthCsGAi2zYatOrTuDDkI89gqKVqszjMYDAZoVZwTwxnqGq4pfLZSWwZlcpaqBBSURWpkWcV8x1htim1FdBGAdl+0c28MHbxTaXFVdtizRH8r+y364jEtwpdZjbJWphmQ1+MCpgBgOGzUziy12tqWFbSPUGrC8v7OK/yKtJHW0ff1WAV/Rd7a41fA8OmAZKFmXmA3ckcqJQsWvmMWBU3hJKcxWWg36RsPLsGc84fLK3ZEMSStavHPeXZs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(316002)(40460700003)(36860700001)(478600001)(54906003)(356005)(81166007)(82740400003)(8936002)(82310400005)(36756003)(86362001)(5660300002)(70586007)(4326008)(70206006)(6916009)(8676002)(2906002)(41300700001)(40480700001)(426003)(1076003)(6666004)(186003)(16526019)(26005)(336012)(2616005)(83380400001)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:04:37.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a3028b-3529-4f28-317f-08db2f9dbf96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

Set F8_MODE for GC 9.4.3 as optimal/non-IEEE. Also update gc_v9_0
to gc_v9_4_3 to include more definitions such as the F8_MODE bit, and
remove unused header files.

v2: fix IP version check (Alex)

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 8b2dd2670ab7..914d94679d73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -24,9 +24,7 @@
 
 #include "kfd_device_queue_manager.h"
 #include "vega10_enum.h"
-#include "gc/gc_9_0_offset.h"
-#include "gc/gc_9_0_sh_mask.h"
-#include "sdma0/sdma0_4_0_sh_mask.h"
+#include "gc/gc_9_4_3_sh_mask.h"
 
 static int update_qpd_v9(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd);
@@ -65,6 +63,10 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 		if (dqm->dev->noretry && !dqm->dev->use_iommu_v2)
 			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
+		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
+			qpd->sh_mem_config |=
+				(1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
+
 		qpd->sh_mem_ape1_limit = 0;
 		qpd->sh_mem_ape1_base = 0;
 	}
-- 
2.39.2

