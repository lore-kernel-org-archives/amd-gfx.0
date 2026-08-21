Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14590C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A330C10F48D;
	Fri, 21 Aug 2026 19:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3jxMA/ON";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8316B10F483
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsGcMmR8TGqGfzpzBfdvRChMOWu9VuiwXmOGIuayJl/WkVCHuVnKECi9abbC5HmColjrYn5InuLdmfAtdJ2FYjgzwGDVwDiYaYsSRRhzGCorpjGKwiJVpssueWL9sFLHUEI1ZlqpDcIsNK3O4TnIeuROrGVGo594/eadgQe/2OWNHhMZlxNrDDQUthEZIPvnCUqbXS3WRtgSY4dOFQUiBKL9iBMcXUHxDP/y7dJAT/UZ3DItm4M/cwQMWziCrEs9SCFvSpT98JAeaeBeA2oN2KrVOZzbDsctfsItAJz16N1wZuWVKyDtR9/WhdF9b/i1JzToJ4zOFI8XvZlOLYIRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEbUP45MVcIk8CajSXBbKEfM8P7I1d967ktL3QiAHkM=;
 b=qO660XmlhhFHCmzfpsj3iY/DIzowbSFIU3Ea5aENJJjUUPiEVYsGayTBp5FW3jmZhUOMgEyQi4/FVTsjYXmdIqyAYUclI1LOyMq9018wriYlfEnDld9icWrDLOqqNY8vLKG82kXxG9TzM//TCyvyL8I6ji8Z37e4coOshmW/4WdRbHQS3MwPvWuLKyeQAjNNOy9ldABQMlnXyH9NRvfpshRw8ateUS+rSa9XSUNScbM7uyj7Rs9g5ner1BIkhMYMjqpKOvV5Dw/Masuxw5u9AyI2h5Nifhhv64HyV0DCJjPLrSzsl/n1PBXAjsjVsqFFMh73HVPWxckAEzCDMU9UGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEbUP45MVcIk8CajSXBbKEfM8P7I1d967ktL3QiAHkM=;
 b=3jxMA/ONjUU9+lEa+LT62CeOcSzEv0+xx8WwffCbQC0iN1EdHXuREFEgIEaX3zVsUhYbci3UZxjKQcIkIai6W/dqOFpq5AuHE8REBYtHwdSu3X5SLe+eOA/Z3i/cd7a29OneFyZBz7SABXnuk3ZpSpNZEoE74IYFza+nUWsMqXM=
Received: from DS1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::18) by
 CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:56 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::4a) by DS1P222CA0005.outlook.office365.com
 (2603:10b6:8:454::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 63/95] drm/amdgpu: Prevent double-free of drm_exec
Date: Fri, 21 Aug 2026 15:34:26 -0400
Message-ID: <20260821193458.808626-64-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1dd618-2eb5-4b30-5822-08deffbb6bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IEDn3B7tBC2Vgw0vsd+q/QVk1gjBQ0GREvEGHmezdcj4qWB/usN/pu0y8iJO5RAwZx8HuxO3FBPMxNzX/pqdbcOuNx80/mkK40GhIy60ngp7URDP1v3ETKzNim9bfdXWAf/Gs58sduKkFShasMYQ09uKOFCgXDRXeK1LhSZWwFqah1s5YhxVpXLx1gLYJZqx8cSqx/D+siCJx7/R61aNaGlA+dSQi4UFkk63j3igbeY4tgz7ODcq9zNIhfopsR+pp8GK6GTm9ts90udLZsv+h69ymMkU9RrsaOd65CE4PtCHVdyiBSP7HspGG3wCvZbmSq7hvRmoJ3Ywn1mZjMvxxSf/xmuC+VbxQdS2mZQheUrn5gRXuckmh9UnQIx7F+b2L57KVN/vrPLHpFQBhzFFxQo50dW7LYk0/a2nWE+mCLQ8GuH+FoE7z9WRcSkGtSXClAU+IWVfBShLBL+ZEGES6ihCehJvey0jNrpVjOtJ4+qgQVjEBNI/ZZxE3587viZWs45lSwSmvAxOw19L2iQkWbpnir5fTuZwYk5t1JFXssuCNDJ2XLlWAziOcBMv75vULkAbWlqdpq/18Y9wu/G/beAz2cyplwqvu/BK8sHUawdmIq0KJ8Tnsnw7Q/lsgA7/A80Ww/5jHcrQ1mJrf8Lrtapkw7AvoQaOo72HPIRzKNDutid1TTcYLa8fV/jc1IfG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z/XOcLysPRV5yen/8lSH27XDGEmoxXDtw212Di1RQzuPl2Y2kOpv0N/rnm1Y4zKKa8A6t/ChFZH0bP/GCCzMDZhRYSBW6jxGLWDUJELVTWo9CJ6/MQNPgKA5zcLMLIHi240rZ/ibfTo2g55JLJOm67DNHMBYvpW69j04NaE6nZYxhZLOhFuKLrzUfvZ46j3iUHOmJFOwDbq+oNlNGjuGZWlMwcrwL8h8fLkYOpU+c7ZUmTFuzdXgGHVOfUisQRN6ZmP3Z+l7BLAIZJnDe0F+YCapCE6UHoIvur9lZqVDQhBR+VDfz9Im1wz3Y3xATKFlKt2gCChPXTtdmKamaORoNgt7COYGNJdldNJZjVyXCn/cldhSEkqM08wJ7H/JKJItath+iTA32xZAt7e6s9zqxbjgx2zRrzKC6O/1Sv/4xrO0qbHWzCVgIsKbTsn0a+gL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:56.3289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1dd618-2eb5-4b30-5822-08deffbb6bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718
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

From: Felix Kuehling <felix.kuehling@amd.com>

Always check the return value of amdgpu_ualink_reserve_npa_vm_and_bos.
It's not expected to fail when used in non-interruptible mode. But if it
fails anyway it calls drm_exec_fini. The caller must not call
amdgpu_ualink_unreserve_npa_vm_and_bos in this case to avoid a
double-free.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 26 +++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 1f4eef01e4b74..e2f1829ab844c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1447,7 +1447,11 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 	struct drm_exec exec;
 	int r;
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in unmap_npa_addr\n");
+		return r;
+	}
 
 	r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false, false, true,
 				false, NULL, npa_addr, npa_addr + size - 1,
@@ -1491,7 +1495,11 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 	struct drm_exec exec;
 	int r;
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, bos, ARRAY_SIZE(bos), &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in map_npa_addr\n");
+		return r;
+	}
 
 	r = amdgpu_vm_update_range(adev, vm, false, false, true,
 				false, NULL, npa_addr, npa_addr + size - 1,
@@ -1955,7 +1963,11 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 	bo = exp_xa_node->bo;
 	size = amdgpu_bo_ngpu_pages(bo);
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, &bo, 1, &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, &bo, 1, &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in force_retry_rpcs\n");
+		return;
+	}
 
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 			 AMDGPU_UALINK_ACCEL_MAX) {
@@ -2081,8 +2093,12 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 
 	size = amdgpu_bo_ngpu_pages(exp_xa_node->bo);
 
-	amdgpu_ualink_reserve_npa_vm_and_bos(adev, &exp_xa_node->bo, 1,
-					     &exec, false);
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, &exp_xa_node->bo, 1,
+						 &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM and BO in unmap_all_npa_addr\n");
+		return;
+	}
 
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 			 AMDGPU_UALINK_ACCEL_MAX) {
-- 
2.55.0

