Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24A4EE49A3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 06:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3962D10E2DF;
	Tue, 22 Aug 2023 06:18:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E4010E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 06:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoioVRtqtqDcNzzbh/2g2MCvBZBj+WbcpEtr1shsMIspq/R4InE+K6ibg/c9c7fElLAxucTNlrEY+iIiXw3dy2hum9xAu9q0apHr1dQfRafNlK2JM9eGOEnj2qHsauYGVvcOE75uWWhxjr6OgeCaPAEj3ni5QFiP5ofJcBEDRAKCAjTEkgU6g3bGOVwztg0zdnokRC7s5eFlY+AP0rOaxmauJiTFBy22RkoCQdq2FYgsSPaozN1QXCsXFy3wMXMno3eyef1NignUgnVBBzbe+JRCPcvMhEn7vMvlvH50hV1CKXXa0lSPsUC2gBG2PvVuu6UO+tpNaU3XfizX0hXBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HAt0l476OqTJ/ZT+0z0NBN1QWW1kTE7bvjT1pb0iu4=;
 b=nq7WHfRmHu8pp9zAwrMSn3v4WoaZTNZhC6oFCLVcHki3JxtegUNRN7BHNLXXLYZPCZiCW1085eVgelL32Vv7/F978u6RYOai98JmFDQxLNbFWTC3b/eluzdslX1Ze/OeObu5VVbI4x+c5UrDWaHSzx7R9ZFWFdi3EnqGwyXyHnkffIyKwacc1FNElCMC6Abrjg4NsZdbkMuy1kO3WO/qgQaKRKzPQOjRJzwYn2IdGf33jk9xJ62eeSyPFT2q874kvXHJRqyv+TMBq0ev/5TEEOcxaP+rzWg62B8tPrR2p46uSCewd7SNpoz4RnNHy3k22mALwHZzR3oyGSAki8itJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HAt0l476OqTJ/ZT+0z0NBN1QWW1kTE7bvjT1pb0iu4=;
 b=I0WloyebWnHa/aNwIaSk6yP+3Tnv3pesum/c3mP3nINMd+nM8vfe14I86S1q3X6+x+WR9JCz1znq+kbeY9CSpBzloPabrNBRRd0sz5fGo6mRgAC+9eyvKl3/B5uhwRZqapg+zZOjW4VdEmtj39F8axpobekg9UApbi9dr+DC8kQ=
Received: from PH0PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:e::17)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 22 Aug
 2023 06:18:01 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::bf) by PH0PR07CA0042.outlook.office365.com
 (2603:10b6:510:e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 06:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 06:18:01 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:17:59 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: change page_table_base_addr caculation in mes
 queue property
Date: Tue, 22 Aug 2023 14:17:23 +0800
Message-ID: <20230822061724.3917603-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 090cf272-bde2-46b7-e875-08dba2d7898a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIb3rLRKVwRKVLCx+fP938YKdKmnblmWKanUi3Z2gf1iOPMIZLKfTG3iWvSOmVozPsGMW0Y0yeioxfW5WP6T1C/eVg4ZyFt1VwxUzpyFcK8UaRwe85MCJaaP78uKd24MGDnBANur/Da9mfcEJmH0bcL535ZDPG/ew2QuJz0lCn+fpjUjMw6opKqp67vdsT8+MWpTnGyRaY77NQhTKTeJ/FFbZXInH/wJNljFBUVbxZbPldU2sdnGth1zA31mrKHOilN2ZAaYnqUMbhhu3dOpMXsfNllC6SNh3c6sptFFhbJdAhJESzfBQiNv/k3LuKa36LMEhtorISipBJWFXwEH3SxrrLgoY2jocpMJDP2Djh/2EEIN6RJzm8wictz5Q2PFdaFabvkBebfixPUhuMpGMfIcZbylNlL1NwYC2QuxbNG84tS1XE1m7EljyH+9HEzZpW4GystA2hDkqqBvVlwhs9QqWa7MydTyGyFS0yOW263vIZZm0RJAEe6Heg7o6htXXvxHBw2aRtb5WVwye36JKs5hyz5lFX99LSPA0Lzn0ZIPvOsl2L3gujhcPXUQKPWL5SwpbQ+UTiHDOOBWWWIA7gz6gPagXotSrr2XeTIQpe6lVJevJR++t5vfUHCzH3VxyMDNcI4aVK2jQ9goZyL0+N1vXy41Pq81MyCJFtoJz/gC0YGvGTMGtgxA5Kui0Mt9DENFkbbVlCKCIuycQ0c4/SRz6JsQtmexSi6T0k5rIvSLy3id+3wqyHCPgjbc6SjmEzrgr9FD9RA0JjrqQTvs3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(54906003)(70206006)(70586007)(82740400003)(81166007)(356005)(316002)(6916009)(5660300002)(41300700001)(36860700001)(47076005)(4326008)(8676002)(8936002)(26005)(40460700003)(2906002)(83380400001)(16526019)(336012)(478600001)(40480700001)(426003)(86362001)(6666004)(1076003)(2616005)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:18:01.1682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090cf272-bde2-46b7-e875-08dba2d7898a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

current method doesn't work for GTT domain page table, change
it to support both VRAM and GTT domain.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 10ce5557bb11..ee957f059786 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -259,7 +259,7 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	process->vm = vm;
 	process->pasid = pasid;
 	process->process_quantum = adev->mes.default_process_quantum;
-	process->pd_gpu_addr = amdgpu_bo_gpu_offset(vm->root.bo);
+	process->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 
 	amdgpu_mes_unlock(&adev->mes);
 	return 0;
@@ -621,9 +621,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	/* add hw queue to mes */
 	queue_input.process_id = gang->process->pasid;
 
-	queue_input.page_table_base_addr =
-		adev->vm_manager.vram_base_offset + gang->process->pd_gpu_addr -
-		adev->gmc.vram_start;
+	queue_input.page_table_base_addr =gang->process->pd_phys_addr;
 
 	queue_input.process_va_start = 0;
 	queue_input.process_va_end =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a27b424ffe00..e1c20e2453c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -140,7 +140,7 @@ struct amdgpu_mes {
 struct amdgpu_mes_process {
 	int			pasid;
 	struct			amdgpu_vm *vm;
-	uint64_t		pd_gpu_addr;
+	uint64_t		pd_phys_addr;
 	struct amdgpu_bo 	*proc_ctx_bo;
 	uint64_t 		proc_ctx_gpu_addr;
 	void 			*proc_ctx_cpu_ptr;
-- 
2.37.3

