Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A54F9D0F3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8238910E159;
	Tue, 14 Apr 2026 19:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bt9H6iH0";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB9310E159
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7KWfkjW81xGd4Wr9Z9dEiAs8/kyYEAL/GMHsgsgElGkawEVE1KxSr7tfDZo+Tuu0gkPqf6v/SiuHeWuIVIRG1PlFqcwZfampOwJeBhOdUQut/Q1dRUbgQnkIEIWprY1fI4Oc7A+O7wBn6R9JYU7Sx19GuZ5Hk9LK3SdV1pyA20+FoRkh3GS3OX/P7YZnKmRmdInfm5/iGBB1TmTAmlN3hNQ1pSTVAJwP2wBiTDrrEtXOocfM5s/cFaQUkBXlC/jpZl4x+qiQ5X4ehSgNurrgVyye9Ad0+UOi3f2TL/jQ1EiHa0PONC+dok92qFbiEZw11sr+XTHPn2iNYW/26R4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnvJ3mMT5pTCp1IiFYG3GD03WCiYAomvpxZvpAcPZFM=;
 b=wf/H8IG34/4q5bUYd7igqRQNeI7L3TKkGAZMi80FAlcyKyZxoYYOkDD25rc39CKdgt7P71aDYWwL5hHSZSdW4QeSTb1/DNB3OPfZzoC47KOGH6zrl+WRRC/BoY+0w2H1hcR0iXjklyZ84g6wCk8BwFQbg3f9yUESJ0QEaSdiqG3yxcSlMsoT3j+i7evbs4mHe4QqSn8NkqLMJE485dU52tD3bWZWuPmQ7FUQ4qfoj5ju0SkFM43qg64u3wknUcaMOyGWxf9OMU0BDrFH2SWSLJCB9B7V9fIS5asga7L/NyrjEAtWjGJodpnxJHSv/FIaMIlsATAQ9k10hvY6N7wcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnvJ3mMT5pTCp1IiFYG3GD03WCiYAomvpxZvpAcPZFM=;
 b=bt9H6iH0x0CiaWx4pFfdjlDlfNoT5S4FBW/+Z9HboeWl+trBZ/XTBd76pF4aEcB0CC8dVvMusJ5C8WH6IHQi97o9789tWjSqSAcfkMVzGHfjWGblJKzfuHnBpqZRRRedfKYCeibaCgVmuALl2ZPAKlkSpmJfnJ/3YTfW96mmzbM=
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 19:53:46 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::ee) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:53:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 14:53:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 14:53:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:53:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: fix redundant MQD iterations in GFX v12.1
Date: Tue, 14 Apr 2026 15:53:31 -0400
Message-ID: <20260414195331.2214700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 03653c05-3883-4740-1253-08de9a5f8a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zVjQPYAEfMGBjuhbm44e4U2UiHJLUb7J3yn79ijtTrrkHjVBFQedu18MNTq2AeS5oo+IBxk5e0r51jID0kyNkvQ6SxJFbn4zMLQjjgbOrX8MpjhKHcv7IAoIxLXQII/IOInTQb13hTSYbfBgj9ANyEscJS9/+GeXaEAX+JO0qF5JXZcRI32bSqx11fNVuxYh1/ywJ/VkUEwQvE+stl/yvPMKH6eEtr3tBPzy3Q9oD+zLd9BrjVn9kCuYf4D1fLZ3Tph+1c1SO/Niu/Vogk3cce7o9rqPggKuFmhdUdpJVhWovM5MEwbI926QksnNiqoDsdjjTNJt5lYjeEPR4YxgxmZeF0rJ/Cily7/vQHu2F0TLmWULoIkDyFzAWPXZICO3MKuxCyg5hfXy0nBuflRahq/ZCrWFP7/1p+m1/XbRCT1XpTCk4hHS1xwT2aX9/KTbiUErOv1SGbiEI0MCrpGM5nNWVaRQJ4wikO3d3E+/LyTZNMiJGJYEcf0MCreIDuxhyiYZqDHuZB5QjBiaRUHOgMXBgUOp7AuQR6OZHrd1K1mvdxdS65GvwToQYlJtbpGkANef7Au9FXD/PHVl4Qt6+PBXHY17uqs6bquLwBSlvb9gNnymVfO3uUmrnCUX4qt1lToC3MDICtd2QKSgaHLYIpZJyskGM79W1Q1md8W3ucg8nsU20Ge/1PiPGYJ1hnwZH7JjCurtW4pkUHuGGCcS+0S8lYi+64DLwUG8k3WsiZOyPNzn7hTXjSoEVPvdI6bsl5vjOtEjdvE47NYo7+lsQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sGVTAKp6t/MkeZ4/EZgqiLgZQiVqtW1ha1D9ogosF8FJgCBOLInEA7hRvjrO+JsCh9fYEIBa2yK3Phd/40eVxZkdPF2Qtedm04ECpXDxqNAeQVePRuqKh88JuNX7yxLdi4iMGbzyPdPDODwhqREvNNowoHp3GrkX9n63VkJwJh6Fpa2uYwLdESqF4gIuse7DKSG7ixJ0tSg9z6E3Nh716C4XPJAcqNHfBvfUjcszFmq2PeD6qxubEBWWPKXgvvG/XWSKjVNAG3/DaCpVFHGcV6oBdTG2wMrPVbHdbZcaiBFd3mmNFMLJv1kRox0YzMVl3MM8dmtQP2kktpkWHmfYv216jeMW6K9NCU9mj8VkRv3NxgbAgV2BkWF4txTSG07Pdeq+Qeb24BaFoMr+Ug6PkP9ekoxoPdjVDdhnrQ+987jSiP5Pit+dLZi+FPARNl2E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:53:46.0376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03653c05-3883-4740-1253-08de9a5f8a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
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

From: Alex Sierra <alex.sierra@amd.com>

The init_mqd_v12_1 function and its sub-call update_mqd_v12_1 both independently
iterate over XCC-specific MQDs. This nested iteration is redundant and can cause
MQDs in different queues to be overwritten. This patch removes the duplicate
loop logic to prevent queue corruption.

Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 6e591103c3b60..9014912ed82ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -32,6 +32,10 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_device_queue_manager.h"
 
+static void update_mqd(struct mqd_manager *mm, void *mqd,
+		       struct queue_properties *q,
+		       struct mqd_update_info *minfo);
+
 static inline struct v12_1_compute_mqd *get_mqd(void *mqd)
 {
 	return (struct v12_1_compute_mqd *)mqd;
@@ -215,7 +219,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q, NULL);
+	update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
-- 
2.53.0

