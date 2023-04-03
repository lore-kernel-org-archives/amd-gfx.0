Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65444C76188
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 19:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F8D10E188;
	Mon,  3 Apr 2023 19:59:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D15910E188
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 19:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdhxLw9gnJjJfTm2e9J9f4bA+JmWWrvADKXx1Nm91Hh+AeOR+DXJzoqX78mJT3pWkqL5kJZfidGCWhUP1UiVQkJbN6gFy22/ecaIRoObSjlVEOQzbqvAofqOHo7Wf2g6hEA8OGaoOXUDlX3HV6q7md3lFUT8MmZAJUpd4iL+GqsYFS6iFrSGByaYFsH42tZDe38Vdp8+vQotA/XRC1IOrPdOtwcQcSBNtPad5KLQIxzt/jWILFysnDVPsaJIpFAWds7L5ZBnEcQClrJoSc3pdqDqY2j+oKcbb+Xhvxc9HN9fNEni0Elm+vQgZAqfyefDmSM1o0dZeo8QjJNF27op1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfC338xnAyUcuSSSTKaSatBkb615XINkA2Y/EvhGO7o=;
 b=bxFXDqT9G3pA6IulboV4qvwQmJPtIwlxedNtPdeP1feJlOmhcBKNPPsyegz8YVckQSVdKDpKLR97xJvysx/KfuocPuzeIU3Wln1A8sI5piMHR69oLSxXuu4is0pP4OsJZqXm7KTHqjfcXYqOfdgriZzEnBb296IVDViTVdVTSwD7/llAL/x/rLfk+Pz56k0lEvrPweEN9i/W+g8cAZ2espsxiCYn60MVtN4xQ5zymeRlm3DLEzOQn5x3cfkdoYmYOD7DiZmTwdYftdeY58kqA7wjxhQr9u6K2TUT4AvvNJeDNjKO6jhaPZXROb7w816F5P5QShMcO3f/pBQZJw6Ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfC338xnAyUcuSSSTKaSatBkb615XINkA2Y/EvhGO7o=;
 b=nhnuG4q4P/pd2iNBqTU5/NemZLEz5S+wqo9aKd7rzEovLWs4NPvb+0J/ycYCdRq0hU1idMgNqkwUm929hetYSZgG0cS7QidqHSRsfzblzeLEwY9zccd3Gq0BkR/+4qIX1yNN6jflo96d8eKMFEuZewCAmLEhd/G45vDDKBXVpqg=
Received: from MN2PR19CA0070.namprd19.prod.outlook.com (2603:10b6:208:19b::47)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 19:59:02 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::7d) by MN2PR19CA0070.outlook.office365.com
 (2603:10b6:208:19b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 19:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 19:59:02 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 14:59:01 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Date: Mon, 3 Apr 2023 15:58:39 -0400
Message-ID: <20230403195839.80419-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: b397e820-432a-4668-6fd7-08db347ddf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4WEtJm+ppiHYetCXn4Qc7EfuSGcw6qb1rNVl2rl7/HfmaM2xdi0X27nzfHN0Yc/UEtde6Ter1mlq04e1FID9OxyB5+FY79syVdHsFA2x2jAmh+TzrC/mUt1MmyHrBFdhgdrpcFi4OlT6wL+kRYxR15xNYVJVy91MbSEATDijGUsOTpL3LpGB9/1ur1G+/7uf47im0COMA/428UqwyMumKYvZAG5WhIGO/3b4QM6IqbbaaRTXthyR3hVZ7bU51NRzGr/u1T3HCuaDkldEEXAP0LxKbzF5dAcGy5xaSDozeLgK6L5xvA4KFR8wHqSDfs+UYw1JL/B7nwLPqWvGBdlBv4ZiQiLWhCbHA9fXtqPL/QmXirfd/Srg3EIrrROHzEAaKCnMLIqidkaAROGWGG2qZs88CYRp/jllDsfHPl2kSwCpAtfwxEN6+ERfVAWYEmFv+wHfKxRUKHnumT3uT5JZAYLoj/oOpZicvB9UXhoO/LV7cyarX8rJJZdKEYIQSejC+7/woMWoGeTleqV92b/05XLoplKiCY/Wzs0Vl9SqOl2m07FUAitXxYV0UKLVKm1BXslDpLMkLBQsMtWCdmqHMZqM27CsoEnQOA8QuC3RHKdmyIGxJ+0EU+pUq5kI1s0nu26rprinoG6UNhYAUTJVcPGvDBHFaTAH9qV3LMhwu/MRO4fS+E2w50xUuVbflfvIx7SqKTCVu22EyerfXwwBvxKmDE1NFWJcMalB/7AMrc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(4326008)(82740400003)(82310400005)(8936002)(81166007)(6916009)(356005)(316002)(5660300002)(86362001)(44832011)(8676002)(70586007)(70206006)(36860700001)(26005)(478600001)(2906002)(47076005)(83380400001)(7696005)(336012)(426003)(40460700003)(2616005)(40480700001)(186003)(16526019)(36756003)(6666004)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:59:02.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b397e820-432a-4668-6fd7-08db347ddf45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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
Cc: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX11, CP_HQD_HQ_STATUS0[29] bit will be used by CPFW to acknowledge
whether PCIe atomics are supported. The default value of this bit is set
to 0. Driver will check whether PCIe atomics are supported and set the
bit to 1 if supported. This will force CPFW to use real atomic ops.
If the bit is not set, CPFW will default to read/modify/write using the
firmware itself.

This is applicable only to RS64 based GFX11 with MEC FW greater than or
equal to 509. If MEC FW is less than 509, PCIe atomics needs to be
supported, else it will skip the device.

This commit also involves moving amdgpu_amdkfd_device_probe() function
call after per-IP early_init loop in amdgpu_device_ip_early_init()
function so as to check for RS64 enabled device.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c |  9 +++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7116119ed038..b3a754ca0923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2150,7 +2150,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 
-	amdgpu_amdkfd_device_probe(adev);
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
@@ -2206,6 +2205,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	amdgpu_amdkfd_device_probe(adev);
 	adev->cg_flags &= amdgpu_cg_mask;
 	adev->pg_flags &= amdgpu_pg_mask;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 521dfa88aad8..64a295a35d37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -204,6 +204,17 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 			/* Navi1x+ */
 			if (gc_version >= IP_VERSION(10, 1, 1))
 				kfd->device_info.needs_pci_atomics = true;
+		} else if (gc_version < IP_VERSION(12, 0, 0)) {
+			/* On GFX11 running on RS64, MEC FW version must be greater than
+			 * or equal to version 509 to support acknowledging whether
+			 * PCIe atomics are supported. Before MEC version 509, PCIe
+			 * atomics are required. After that, the FW's use of atomics
+			 * is controlled by CP_HQD_HQ_STATUS0[29].
+			 * This will fail on GFX11 when PCIe atomics are not supported
+			 * and MEC FW version < 509 for RS64 based CPFW.
+			 */
+			kfd->device_info.needs_pci_atomics = true;
+			kfd->device_info.no_atomic_fw_version = kfd->adev->gfx.rs64_enable ? 509 : 0;
 		}
 	} else {
 		kfd->device_info.doorbell_size = 4;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4a9af800b1f1..c5ea594abbf6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -143,6 +143,15 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
 			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
 
+	/*
+	 * If PCIe atomics are supported, set CP_HQD_HQ_STATUS0[29] == 1
+	 * to force CPFW to use atomics. This is supported only on MEC FW
+	 * version >= 509 and on RS64 based CPFW only. On previous versions,
+	 * platforms running on GFX11 must support atomics else will skip the device.
+	 */
+	if (amdgpu_amdkfd_have_atomics_support((mm->dev->adev)))
+		m->cp_hqd_hq_status0 |= 1 << 29;
+
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
-- 
2.25.1

