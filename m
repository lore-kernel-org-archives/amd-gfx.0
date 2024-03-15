Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A107C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 07:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7A010FCCD;
	Fri, 15 Mar 2024 07:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NVmdQYSQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE22110FCCD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 07:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl6oKjJO4TxU2ulbDJWPh+adyqIrkDUbl+jMzcQcjpdRkwkJOQAxyGjUYEtJ+OjFW0HlMp2ovugVjCMl+mrkfyP858tu/k1WIY9dQ+iEP2Kt9ZmChFTcaroRstko0XdRlp55wTL+Za4ZtDW8HlFnaon00ZUkPKv9dVDcwkvkvMabLbRP4Ni9Y8ZeIffsZ+QCWigUM20k5EzXI55PY1l4TrSumqXc4X6EHQGKsN6gkyigJaZsXfn4lVxTTB+ITZ+WNkWiPLkEDpiX9mWW5HevIyHQHWystOUwXb/CsUBEK66tKUBmPeDFB1nYjvRKJ7OkmZ4N2gR4fZrScFSdUoGEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rerTP+yC8DMY8m7+wU2mTM4jS6EQX/Z3fKeZMWjGDiU=;
 b=N4jomgAalpE152oYLGV7VEpGNn7ayqp/YM71NVwRNbDQkI+eP8trIU0aw2RAynKUmwR4x1I6G0n/BAHmvucyJykhwSAHKBzbbzMVmaj7YDMvU8mVZjkp2sEdkgGUHxuNWhS3ozSAN2swRmAld5FjB1tBQkQd+lR3W80TdZJP5uvcNqPETFdfAqqS7eIdO6XQv404SFzWSdcG6f6KLSds8x2PgCT+/9jOApyM+kEW8q1XE9nNpgz9h+3cSx/9Ony0LSMjyawpW68auAGscIPbT04hRc6tACr92oThYEv5aqfzD8cBCNXH5f16OkEzoV+/rr7zM1QISplJTOcINTxCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rerTP+yC8DMY8m7+wU2mTM4jS6EQX/Z3fKeZMWjGDiU=;
 b=NVmdQYSQd+ZWnLzzP9k9DaRZ/+wmOW0GjmyuOddPP+GPxyEZtK0PP7ccOwq4tbFeYN80W6z6rT+rznxb+BfgRS6upZX7A3HLKcqmbSKRPdPy2/HXBKidBIGb+Ovz7mCIVO8Mz46opiU8Z5V8fgK9kQmj4gdh9hIuEgSTxpQEYyg=
Received: from CH2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:5a::30)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 07:44:14 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::f7) by CH2PR08CA0020.outlook.office365.com
 (2603:10b6:610:5a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Fri, 15 Mar 2024 07:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 07:44:14 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 02:44:10 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: Use metric table for pcie speed/width
Date: Fri, 15 Mar 2024 15:43:55 +0800
Message-ID: <20240315074355.3297281-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240315074355.3297281-1-asad.kamal@amd.com>
References: <20240315074355.3297281-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc714e0-eb33-4883-f372-08dc44c3b604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EW5fCII/Iwm7mkEjRVS/6Hmnp5tzcY7gX8+eLeSQqp4v7WVcy2nausbnEo5hjPf2jUzF8yrC3Ge2BjzvnIvwH2D9DL/WDzaKEzPFRtZ2mcUUlnuPX1daE0chNQrjOilaznvz096HRJ/AH/7uXWfcEtEnkRP3P+lg0OYOiPN9AXheLG+VA+id4DStNcK7qzdxumvJv2uqCM767gpA/s46wFDbzInf2qAW+5WBGfrrdvxYh+trWDoILyHwics64uNXEJuINPzXOUDqONG/NSYa24N+qu+TF48pEcE2K2nH8y1p59n1ZLzXxRr/MQYPXyCg2o3qcifa58TqhXIWV/x2xiMYm4jvoOQ6EFcVuU/bzuQWAtKzLbLCEy820DRqSIqLkOhNr8h8VrkX8EKcNkUj5+SjK7pyLUBW3VDucnNiNpqJYkRJBfWZiTY6N3nhhekxaYJzt2DLfXCaeuR4whk/+yTb0DfTsFkkrSnOhmy5rcWigcbio5jbrB1MXDlRF70vFXPDbYrLii+FR7oJfDxbiM37CvS6Y1JBFFcx59RTt48nsjHaQ7aF+sWcskA7YuplRi3goJQtCW28bMIuHLMhGBoGc2FbQVXrPIxImz6xeAwy9HhP1ckwKRN0QA4Q6VPLOiDzpcttF9SE4Hsta8sZj0TbxFCBFXfj3KT8YKELsK3VmWzjHsA8yW/voWpIGYyqSUEs1WfzCZDvxu4Mdh1El4a/CT3+QYr0+prLzoxP/QhmYpbYj1fe2JqeSUkWFtC3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:44:14.2232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc714e0-eb33-4883-f372-08dc44c3b604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

Report pcie link speed/width using metric table in case
of one vf & if pmfw support is available, else report directly from
registers in case of pf. Skip reporting it for other cases.

v2: Skip multi-vf check(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 744c84f3029f..c1dcbbd88464 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2229,7 +2229,15 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
 
 	if (!(adev->flags & AMD_IS_APU)) {
-		if (!amdgpu_sriov_vf(adev)) {
+		/*Check smu version, PCIE link speed and width will be reported from pmfw metric
+		 * table for both pf & one vf for smu version 85.99.0 or higher else report only
+		 * for pf from registers
+		 */
+		if (smu->smc_fw_version >= 0x556300) {
+			gpu_metrics->pcie_link_width = metrics_x->PCIeLinkWidth;
+			gpu_metrics->pcie_link_speed =
+				pcie_gen_to_speed(metrics_x->PCIeLinkSpeed);
+		} else if (!amdgpu_sriov_vf(adev)) {
 			link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
 			if (link_width_level > MAX_LINK_WIDTH)
 				link_width_level = 0;
@@ -2239,6 +2247,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			gpu_metrics->pcie_link_speed =
 				smu_v13_0_6_get_current_pcie_link_speed(smu);
 		}
+
 		gpu_metrics->pcie_bandwidth_acc =
 				SMUQ10_ROUND(metrics_x->PcieBandwidthAcc[0]);
 		gpu_metrics->pcie_bandwidth_inst =
-- 
2.42.0

