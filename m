Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4D3FEC0E6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C288110E60A;
	Tue, 24 Mar 2026 17:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0yW1Mz0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B3C10E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5sJt+13daMOcIq1Q9UF7/v5bX8og3fReiD8v9zr30InOQKxBnXrUBZ4TBW6q10UT3UNaDhKVZ2ks83VcGnBDgyeJWmrjziFND3Eg6tlRdXKVY/dbx/O7IyddOROaCByZl9L2pbyE52xkxNpXCNNX/F2aulEqR6Zr3ApcR1VrAk5DlrBQUdYAfgc86i17HOBQtcQVYddps7+De2y2AnZCSJoZXi6pQ384CehVdL47faiFMhOLfcM6x63dWKOeHlkXzA83oVn42ys3p8MFVMaD2WM1fkPv4agufutzySi8VvoMWL1zvo5g1tzxOEROYHrs6BDxt8giYr5PjzFNbs2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMIZ/fU4EjcaQkTg/cCrLesXYWOXD1QWbuXo++4OMGg=;
 b=aFsoV3UrVgeXWElONwnjfcftqoVD5E3d1qFUduq55MpYQspSx/m2PgECh7AV8j4z0/ntDB5lfvccipEE/ndrA+wt3GFJU6LNpt/5ZSjo9UiS3PvJiZqrHOSNCOw1KRU2ERNT4+eBdhJdNH7CZE7YrjJ9MlyGCIdXmtUmvCznyeGDAPQGZmoOC6hgA2dZqAQLDUcfzFgoQwZs7ENpwCd5X0DIdXUdCP5tvdQVExGpVU9nofQC/3nSi70j3fpNYV8HyrZhhqdUsRl27hBDK5EaZuUmzir9t8j+jmhURiWz3f5HWZz+1avyIXPtd+tgRZ5rAFZqMCVlstx2f50QePipfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMIZ/fU4EjcaQkTg/cCrLesXYWOXD1QWbuXo++4OMGg=;
 b=d0yW1Mz0sTZ35s1x8qCCYxyvNX5n+WNB10rAR+REroG1pLxE25pyNbf+k1jqyV0r6mVL+xB7Ir0eki+wQbmpiHix7M9mNZpuJehoWI6j3y2JMME4KeUp7F6mRBPlwM8wIo9DmcqhlF/Zu/eRcQ/H6thZnU2CLYOEymQyhqWlSjs=
Received: from BY3PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:39a::31)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 24 Mar
 2026 17:57:45 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::14) by BY3PR03CA0026.outlook.office365.com
 (2603:10b6:a03:39a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:44 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:40 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH v2 04/10] drm/amdgpu: Create hqd info structure
Date: Tue, 24 Mar 2026 13:56:46 -0400
Message-ID: <20260324175653.1325754-5-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 59db10d8-3f66-436b-7389-08de89ceda08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /TkMYUy7ZzGFThlFBeEOfCHXJRUGojw0NwmSp/1628ZOuAmtiTumWzezNtNveFFk3czAurfrS0ziz1jl+jmYLD4Uj7EfO9EV3ltNGUWfHIbdaMWWWmBsq7B+r/ZE0dCabDOZgS36hz2RxuvwMyh7WIV+RMD6NPJ5I7Z7NfjbXuca7Lj6LecFZxpqJYQW3/zN8BUOpTdtOOsNlSiRsuLqBOCQbr12M5fiLtyhE8VOO/R6tuus3UgG+dGq2YvHEQmpPBe9oWUoXqOGzv4Lmbs8Jv/hevgN+dDGQOlz1UsL+PaI/EJ9v/QdDd3So9M5yQZ/WrrKjefvxzbO6P+BlBN1//rkFHjqTyTMg9JaQjDVE7h8i7Xvw4wjv86lYVTQBp9zwXXfcVzc8ZZcF0zdn//UaHRUlDewJxjGn2cnZbn/4J8LeXAfbNm32/HLtFc5Hkmzqom+xs7SiBupJW5iQRTCzMpXqoV91sgSFKrFDZTsXWnMTJj8ubCe/rHakvxL5dKKvrJCwrSYMgjcvjH4vvhK2ESHiQPsNZrJfYJuzrqud1UOHvb4HRZ4UZn83vZQUEabXMlRVESngWX93K1gnSjBpP9Ncc17U0QpwvkitZ0IZK4RG8FmXWwhrH2H3iKY901WabMP4PzHB9KVDlgDqFG0dLFwcXFkWwgNyFzIplJ47mVm4SC4KMW8JnIKTg6RzvX44QFuiYTqX6jgRjCyU8BxBue5k+CjnC7ZpMnCUfcOvh5ZpkWJIrx0wLmzlsy1UFMCmGKWBlqPIn/r67nG8BIbjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CaGmJElIB1jx04igdRw++dGwpwKaz08QQ1Wst9rPQVI6Z6GnnsiRe7tX2i8b7z+J/ZZFEGQ2++EUEi/DrPnrKpWKkpWf52k9gML+340MVL68TVL4x36l5zA+ptNMmKInbxNQ1S2xr+63glLHfPBfqiWzeJxSG0ZfcWCejblOiaUSZsnWt7VObPfB9MrUUoVnXdbTY/Nvc06Hpvd5+3A7pqGLjVJuKUKqgngnRkQ6tDNkrZajz5VsOSZ+fQVwy6XbUgurUCol/32tcxY3Gqei7JosCmsGXDts2LXG5A8Z1q88S/uxG42f5aLXXnaelswGv+ZSWEY2UQYlRFMJJt7ahu6XyBLDJoTbp2RPNaegMu208fDuRUutieyAvxG95lhPHu/VPU0kcWT1K63jawn7FwwRrMp1/TJ6ylrcyOiB9tuYoLz4QllyAJFaq4qCovr/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:44.6108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59db10d8-3f66-436b-7389-08de89ceda08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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

Create hung_queue_hqd_info structure and fill in hung queses information
passed by MES, including queue type, pipe id, and queue id.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f1f8bbfc31e0..d778c3da8203 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 {
 	struct mes_detect_and_reset_queue_input input;
 	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
-	int r, i;
+	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
 
 	if (!hung_db_num || !hung_db_array)
 		return -EINVAL;
@@ -486,10 +486,11 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return r;
 	}
 
-	/*
-	 * TODO: return HQD info for MES scheduled user compute queue reset cases
-	 * stored in hung_db_array hqd info offset to full array size
-	 */
+	if (queue_type != AMDGPU_RING_TYPE_COMPUTE)
+		return r;
+
+	for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
+		hung_db_array[i] = db_array[i];
 
 	if (r)
 		dev_err(adev->dev, "failed to reset\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index f80e3aca9c78..2e6ae9f84db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -170,6 +170,19 @@ struct amdgpu_mes {
 	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
 };
 
+struct amdgpu_mes_hung_queue_hqd_info {
+	union {
+		struct {
+			uint32_t queue_type: 3; // queue type
+			uint32_t pipe_index: 4; // pipe index
+			uint32_t queue_index: 8; // queue index
+			uint32_t reserved: 17;
+		};
+
+		uint32_t bit0_31;
+	};
+};
+
 struct amdgpu_mes_gang {
 	int 				gang_id;
 	int 				priority;
-- 
2.43.0

