Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879EA1061B2B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 02:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162E810E1B8;
	Tue, 31 Mar 2026 02:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxgfJvH9";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6329C10E1B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 02:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq3vh2AUwqA94nE9/9sEO5cc4BQKqYMlv9DLz07jeNcIXV2Z57VitEIxVaxcr7Gw7qmp4C5114h/JXspxE7E1eaA5pQkVe8qxx34xCcuc1bKLzQlGcLpBiHmhSL93D2PjVq5gKnr/USg45cyX0XJrolu+EL1uEvIgFYvEYNV/ehLcz50RES7335yMpe4gCy2mGfIx6TPMIr1QVlyeXI3JpkMm+VTquDmpmNYzNIprjEWcQ4a7HenIDbjRmu/B2vAMA1YR+b0z/DdLCOwFA+d9a4lV87OpwPn3LZX5SOCAeZLBbW/hGRABjYnhYmaweyYyucggqD5hXaCAMAz5TkN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyxGwXD2ZakjOBM1MuA2vNoXysl8LOVlapwWbFANFxs=;
 b=NCAA7OPnJjVsCfKHPqUyQ2V5HQDIfE9LSI0ow5SOAiCXRW+7dTLptJ4Ue1E810xystHO6sszii9ZEDvEMx57S0pi4WZzDsiYnR3FLJfHTZ8hd1TRCzYYLB/LlY9pgFgrzgBq+esG8dk+ddRH/yR6IoDqFowfq4VXclGfxvCGJffO5Ea0nqHR0u/wE0TlAmdUJi4n0E/h7GmjN1HilClSNY7K7WiCyhIJ7IhvjCW3+8slpPD3JjgYzKLXAZaqeoK13hS+mB0Jfko86apEGFa/DlF9QhZNIBXjtMfTcuU2tBT3VlCF3hOJm1bsgmQhHKFT48dL9yEtOSi2JhZvfZFsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyxGwXD2ZakjOBM1MuA2vNoXysl8LOVlapwWbFANFxs=;
 b=xxgfJvH9SYcUrjM7IejTztWP5I/A4Vb2mdBm5rbNnCxEqO0v2Vkn27NyeaQcsT9H/S26S2Kh73Y3O2Kn8WSN0fNc5Fa+TfmbVyavQXI5nRlkXL0hzFlHvN55d2cuqvv0upv5HOQdYQp8dGC6rw9FvVimBupanv1cF04nlugdCiU=
Received: from CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::9)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 31 Mar
 2026 02:47:18 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ee) by CH0P221CA0025.outlook.office365.com
 (2603:10b6:610:11d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 02:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 02:47:17 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 21:47:15 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <lijo.lazar@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: fix memleak issue in
 smu_v15_0_8_get_gpu_metrics()
Date: Mon, 30 Mar 2026 22:47:03 -0400
Message-ID: <20260331024705.1361626-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 840c5c75-6efc-4c41-d957-08de8ecfd299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ykIxdealVnvdm0TFP2FCJj8IFYonR7uzQ4g7F91q8WZvi5LdZYO1jW4GNgbEOtK8MKeZZRvcwMOWHMMcdhnjYZUOeODUSRGNYQWpTSfZ79DuUaglUeM1YzihN7iAhkLT5sPp2ShNhIQiRlvz5kt8NvomCe40XccIHz0GGjzrK4KehmWQmXYDjwad35O+lx85Blr0tFFNWDLubhFUJW1bmD69fmz5WYWmA7vZkyw8a0jNU9B7UUVHSsoN5h6vCEJx2MmVtP9ewElN4hcDiufEtKJ3HawXtsoMLtbxuSdz0DNJbGmnnfQ7+UG7xAcE3xrCc9mbKgq/qoISc0KCIT7dKj2VjMTqSBTwgP8YvdYrPU42T5FN3DmXvgUEMuI7OdSK7fyz6PCE3XNMGE/ODaZsugc3YtGvCICK8CDy4Pjy5Lx+ULEiAXVqucJUOfD8CKf6Dcl1DtMtVpuGYuzc8DEHklrBefb64v60iWXfbgn1NFNEmaBDnRRQC2UzXQEQH5ZYdKO9uu2uZQIH1i5bodI3wv+HDuycMLwEjGaEtfN8ai8+hDPXz2qSJE7BuffOaTPDAyJsUyZy1xDw3IpgHMLG+/x9madfIGYUZWzCcgnVl9RPkknnOGQtrQwF4/Fe9BEPPRJbkrCfpsAz44h8LoFolgO012yZ2rl8T+pdHLr6cLFEeHPyMdDxsYgcbJJBugfg32xtrrlVNsGxmoOIewsKozrhk5WGSPODJ/U3KVWdDt7HE9aI6T/CKfL9+c12q6kfz8MY2nIcDKZvdFL5SIWd+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cYIBMcw9Xm3Ykl9endPvqFNxLdez+Vt8cvvTymsIC7V5dVLU+FOyHqZ6JkMP9gYuQ6vpwyoWIccQt10ThXHFgXSGSYjKWZNwK41Pv/Hpq33iXx8gkehfgZzmhKjL9muJuBRj08Xl5Td45BrI0eFia7TpBnoLLr4ugQSWAwwsMGqpU39Oz1xRNF4g98cgw4AjAMXZqvV2sfIz5vsekm7i91mldexF8zePFleB5ubty25uLUv1nOO5K7okZy8hRKn4BMpCxT5ve3TJvYJf8pjt1aJ39zwVOZXTwoO44AbdqhlrQy4m0J+IgqXCLup8aG5olWIY0Sfmxg3e7fRrIf/FJ6JCFt3N6NBXT2EM0JeH81tntccC0MGx4GgZu1PjTDS1JJpjXQ0aU4xbLu/fUo0dDsSxcgX8biD3ZAX02gB4CQ6ZwBYdyuEYNvtz25gZHHWD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:47:17.5307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840c5c75-6efc-4c41-d957-08de8ecfd299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

remove unsued code to avoid memleak issue.
(NOTE: This bug occurs during internal branch switching)

Fixes: 60c033841eb9 ("drm/amd/pm: add get_gpu_metrics support for 15.0.8")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 89a44b456e8a..b158be7cd7bc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1601,8 +1601,6 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 	uint32_t mid_mask = adev->aid_mask;
 	MetricsTable_t *metrics;
 
-	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
-
 	ret = smu_v15_0_8_get_metrics_table_internal(smu, 1, NULL);
 	if (ret)
 		return ret;
-- 
2.47.3

