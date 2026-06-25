Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71AFCDE00B
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 20:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CD010F373;
	Thu, 25 Jun 2026 20:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oGs74fOS";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E53BA10F373
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 20:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keL9kiM6ticUJoe57k1PxqmYFR2fi//uvvVP8m1OWTs/9ot9orqSHyjJE62DJsgCWCXJnDcWJ0YwVADr7+jc/99AhEJjtz/7gf8td2jPIcJDqxBU3Sh0m+pe465RFlYgo0JtqXi95IoFaDwplAmIYHfuSb2m5yYTRiHOg5JY/D7FXrmqU7cCGR98lV5NJ4UpKFUNzVgzzsIaBZVkucd/nB1XuyH5mBv7BXTwnC0JUPKLiT1cp438VbHXTmzMM7ojFP3wKtqONyulfEp0OJDwBJ57LGqjSZNHvaWFgF8tDkhfYPbqGLctXeX8J+RcqEfp1VyBsdlw6r5Z07kbwfdy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDmkOmGzvxOxQ/zqod8wQ9kQ3wssyHlSJe06sLiX5XU=;
 b=uaLRHE9YRwIYvjSFOENS46fao0/7VnB4V83j5Eiqeh44EjE0MqFmjfnbAouIxd09MRfq/ngIfbmrd2wmetxDjmL6xW1l+6Dak9SQ/3r0XcKS2i9Dyq/VHgSPw+ElDq3cxGX5EJgPKdDw28kvru4B1WQ+pEfvxemDMdWjmOm5noXUljJr/YScl9gcmtS0Tigow8YPXlBJRl5U8jObsmJ3A1Qtc24NhyndqoGQKrqjutEZZyhaxCSSFcM+CALyUyLa6dWMoZWRhbL4ifb7UC7KlDOydohUvbM3wta8IZXHpnWcUsbzCBMGDtvYqTcF+VFeqYTqR0/9g8R9dpRbPKAxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDmkOmGzvxOxQ/zqod8wQ9kQ3wssyHlSJe06sLiX5XU=;
 b=oGs74fOSofStelx5vNBJ6yh49gCw0zLaalXAvfX2px5LubAieYXy/GUHriMAXyZ8Swa4K7RR70mNdO8wNHhac9SLbRo++wUqWn+1RYAwCM6uQzRTVomAFC70D2NOo6kZuurfIs2MvRLq09/m0JlUfOfnAJU11H3bTNjtKkunlsU=
Received: from BN9PR03CA0751.namprd03.prod.outlook.com (2603:10b6:408:13a::6)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 20:58:22 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::af) by BN9PR03CA0751.outlook.office365.com
 (2603:10b6:408:13a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 20:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 20:58:22 +0000
Received: from bokun-linux (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 15:58:22 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>
Subject: [PATCH 3/4] drm/amd/amdgpu: prevent PF's RAS trace_num accesses out
 of bound
Date: Thu, 25 Jun 2026 20:58:11 +0000
Message-ID: <20260625205811.125062-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: fb893830-c759-437a-6928-08ded2fc7e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: h2/BIGWyT0EdBK4KBp3leroFIrXW+flD1MqNoAxuXem/JKriOO0tqyne+T8zMJ4iGeVQrRwtmrAc2qhek2Cwcj1dP4knsBiqNsnGTSTGz7PvFw8v5vU0iSbiwaHTs7w/ZZs17jOD05wJaGR6eH3aKwkk+6gSCakut2V8zt+Xc7dOU8KAR1Fh39T1rc0SbQA75bYP0Rl0FbWZirUTqNvlkaW+yqi9teaJmsfSRrC47ROXH/SV4mfxgahTW+1A349D+DKkEP5uueInl2J/gIb2eNLunggx8AWZM5IGYsMTPIzxZ+svr5ASv83ktOvkEbk2+7DJ4coVTarZANTVSOyr4g+umlQ5qAJYdxLTIQjhvpa6Pz49HWNxkOeTynaBWN6pwPRqnf3J0qX/aBiSUhuC/dY10L8FSMCmZkU8hHlkK864jRefSBbQGS7DI8KqeQ/ayG15/iqdQ0Yagp572r17R8xmHsh2eMFkZKKWbxSNuwuCuBUZa3cYEssCitfRMzHYv8Tov0LTR/+5GFAdqsO1CxXT4Lo44o7lCIsG3ZyQQETBSSGXUhHgMXyeGS0OUmzWU7mu+0+WyIhjEDyz47IuAvhScuQajssRtZKaADQkNE1cZ07LvhjNeebGwIEZqeWbkW+bMpRD67WWRnGuULCLP/hYsi6DlMD44kvwEWZ2vEwtjRjO+q9pZ3oFBoI0FK/rjJVjdorTv1qKtuI5MR0Kxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kw4TB3wxtZo0MzrEMTTc2pWYtTByfUuh3VZi4J+01UfpQvgi0zvvDfam6BGq7qdkGg2kxeqhNYu/NnlPeFac/hiIu2tlS7uMDoPWn/SldAVmLry23cbVE9iajrYNqXWkc8123PTbzLZ3lAjiRKFO/rXUokTfDL42TLsavdUc+cMXw8KBK9siRp+Bvk+yFIH7yj0DXqfK3DAU6ioA78iyqynYDacmme+uhiA3dKHXx/KMtIGfMxk8HpojafieuO9hhuZxkqyb649RYr8PVL/gh0yisUGSGrY+5crxazRDw6I9u7mCg5dnpGE+KwEvaIg+OeL407QGKV/mLZl8/y4fEr0O4LEdxzGE3fNv58UZFvcRw4qn5+6qHaIG+mug+ZvPWhIrJAKqrCse3WKp4bD0osaunlFbw/tRVcp7+lxJPYPBcY2PLyTBLrmqenwtSpL1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 20:58:22.8530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb893830-c759-437a-6928-08ded2fc7e7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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

- There is a bug that the PF's RAS trace_num may access out of
  bound memory from the VF size

- Must move the iterator to a dedicated variable and add a
  boundary check

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index e73443b933dc..c6e7aa6ecb8f 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -205,6 +205,8 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 	};
 	struct ras_cmd_batch_trace_record_rsp *rsp = rsp_cache;
 	struct batch_ras_trace_info *batch;
+	uint32_t trace_num;
+	uint32_t offset;
 	int ret = 0;
 	uint32_t i;
 
@@ -222,10 +224,14 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 	if (batch_id != batch->batch_id)
 		return -ENODATA;
 
-	for (i = 0; i < batch->trace_num; i++) {
+	trace_num = batch->trace_num;
+	offset = batch->offset;
+	for (i = 0; i < trace_num; i++) {
 		if (i >= arr_num)
 			break;
-		trace_arr[i] = &rsp->records[batch->offset + i];
+		if ((offset + i) >= RAS_CMD_MAX_TRACE_NUM)
+			break;
+		trace_arr[i] = &rsp->records[offset + i];
 	}
 
 	return i;
-- 
2.51.0

