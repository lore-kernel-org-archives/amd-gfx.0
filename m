Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9876C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 21:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E86310E297;
	Fri, 22 Apr 2022 21:16:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F0510E297
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 21:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJUNb3o0DUlKnKpczvdcNJlvwDzUVKTezlNtOdtC5+iNxW0TQHwVHaKuOq+3d02nt45UiZsJun7ai0BXBthHIb8ap4Eowoodbf7pVH3s9tUUWmB2MRQrjwiPwBAlXmPF1VR5uuBAM54fginu4r/FN7swRWZlMDjkAGgt1m1hQ1bSYUIXlFrIEEcqvJ8iDTlK7n4I3TZFdLXxFjpJSOqZRkshKbbPb/wKSlAycMi9ul+nHM3pcgmwUbgiSsPr+v2rYFrGCUHyP2+/eJTXKZkqVFjV4P29lG2c7mlyN9exZvBvzNQ1g7+kjg3XylPgMm3B8Fl0LSAqc6BH4rOEAoPTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyjC1qkW5lRgn10z2MbuimbLS/HCtHkDtNxAWZts13I=;
 b=WlzQNaf32RnrzqLSlKl0fBvoU9NRD2U91p13SVbd7dbw6LYIA4RKS/kQ8mBCIKY2ByNY73nly+23Lomx1G1VkVKk1dRAUO/wvll5UPQZtnTK6izmte/UClIFY4mw9Py0RG57a2mWFmEYeVJOmfUJeKHfd68RxFIhSUYdkACN8KxaQlRc5SQDvZwBLL6aqLx/lOVCsl9OLL+dXs036mhrNlgoi7+Y0kFP5gStf9325MTIgKrO5yO4CZmcLcIprRR+FM9cNrGpubJkYOSfiZ9cZJapn2sTafOs0cFajMf9fLX1xQdn00WRglJceHGgbdC/fzDuYnnSmaIEnUDAUG8RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyjC1qkW5lRgn10z2MbuimbLS/HCtHkDtNxAWZts13I=;
 b=4ioJpFb6jbQj067lMu6X4JeFkLZ9oUmsL49Jy0OzJbesqhQUVWVeibrEVxgbRTo/vjZqIf6Uigg6T/Ukh93jR7bLocRkRfAfXWaKT1cVkRmADEfl/DTNs3w+VrtX77Twp8gIPp2DdfqIQ7ykPO0275vDURfDXdf9XDzfFQVLCE0=
Received: from DM6PR10CA0006.namprd10.prod.outlook.com (2603:10b6:5:60::19) by
 LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 21:16:05 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::88) by DM6PR10CA0006.outlook.office365.com
 (2603:10b6:5:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 21:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 21:16:04 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 16:16:04 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: replace VM fault error by info logs
Date: Fri, 22 Apr 2022 16:15:53 -0500
Message-ID: <20220422211553.1240-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9926b076-9d48-4e18-aef9-08da24a54fa2
X-MS-TrafficTypeDiagnostic: LV2PR12MB5944:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB59445B18FC83BB40BD30537BFDF79@LV2PR12MB5944.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8zWAFg3EpwBWzTjj7hpYmrPQffL3FMsMCbCQK6mK225Iqqvc/rOkKMZK5CMV35wCM854jmpFv6+N6xAYuajolxEBua0986XEcG973/g+lbZ737tQTO94gMsv90mlRJwa442c8tlv7uS8/YfRh3+2tbnYpYKwuNzXpkIc6sgqFWZzcGc4KqZGjBB1NX9X02IczMoWLrPfk/GQvP6v7RpYiQEEgfk3n5moUEBvlesjZICIrlXyGCzYIdZEfQ08OlgoxjYjELygZNctf5hOB2oavdmHtd4PwO3ChK1teKnVqeWZ3lukunAFIVbs5R+b/A8DfHb2NPW3/uUp2NLFnJEFHS8+6RKwG2JMb66PEc6l3uViD+ofIJZji6GmvPN8EU3tN5JS/cyyL34nbrhRyp0WE1+bQnMpUq43ZSMmV1dDcI+6zmy6t2R7mWjS8lyzEjOaps+x+OYluG3MIrXoFKvQp32hGVvVL3O4uCRcvUpDb+C5CFsXMT3ytLNRSbnlm5mj03+YyjT15BfLdTPSO+0CVqd48DEXWlZxfFTfWp0Zm5odXxNiIg98pyVa0RQ+kAWvbO++s46Ogm6xWUqcn+RGKvH5N7UKdRkz5uZhaeh+ho7BA6yik8BLJ7K+89+s/vlaj8GtDquMa8u6U+8Grk6Dq1zPVwjqqoIg6124aoWzHynucYPDhpOBAdIhk/G7VHW0NVGE3TVU/M+kVk2KuahrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(86362001)(1076003)(36860700001)(7696005)(47076005)(2616005)(6666004)(186003)(82310400005)(5660300002)(16526019)(426003)(336012)(83380400001)(36756003)(6916009)(8936002)(2906002)(70586007)(508600001)(4326008)(316002)(70206006)(356005)(40460700003)(8676002)(81166007)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 21:16:04.9518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9926b076-9d48-4e18-aef9-08da24a54fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not a kernel error. These logs are caused by VM faults that
could not be handled. Typically, generated by user mode applications.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 22761a3bb818..98c8de7307be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -582,14 +582,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"[%s] %s page fault (src_id:%u ring:%u vmid:%u "
 		"pasid:%u, for process %s pid %d thread %s pid %d)\n",
 		hub_name, retry_fault ? "retry" : "no-retry",
 		entry->src_id, entry->ring_id, entry->vmid,
 		entry->pasid, task_info.process_name, task_info.tgid,
 		task_info.task_name, task_info.pid);
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
+	dev_info(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
@@ -611,11 +611,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
-		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
 			gfxhub_client_ids[cid],
 			cid);
@@ -648,22 +648,22 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			mmhub_cid = NULL;
 			break;
 		}
-		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			mmhub_cid ? mmhub_cid : "unknown", cid);
 	}
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
 	return 0;
 }
 
-- 
2.32.0

