Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B51FC5478C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 15:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9340111227F;
	Mon,  4 Mar 2024 15:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qUv6Ri3W";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5402711227F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 15:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY4HgPpHHdjuasqXD3zO21jNsII/YytvIcgkZ1qHa4/rgoALVw2o3q70atRt5uNGnRA3EW0xIwUfL7LmF3MO7RMLOq7b7yeW0tVMM8TZqWVJfoy9TSSim2zD1K2wCvGudwyVPyTI0YAi9BoInL1amyeOpZBArMCCuSb8nhFbT6946oeHzft16MURrBPVTFnTsFRzajxZh5qO4Eieu1Kw8hW32WCej0OOKyJppHz9m4go3163lIqBM7TewqZ+wUZ8yx0fducI2dD35h0R+xEAiiwH2+XPICf+3H68gQ4TCz21OlNUBegaSbjvKPQPJJOPNb5DZ66NJVEsqbxJwHw9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DitkrXfunp/kP4p4Jp8/ytEgYNlccU8ZhES6wTffmGc=;
 b=G2Byj5lEZfVSg8vwx+q3om7bfJlPiqi8W3wJTaU3hsIAKEa+gN46/i2z9ruPHhJPToD+tx1VRAuMZ95FHhxbRhRM1QlU2gHG43hKFW7NGWeDsiUdNRe8cA7Rs2Ua2P3kzHpi9dleOlotzXNEQVNDMVIe3aLmTKKcuJVCxMM5YvLW7o9ryS/kuaCJSxt0DA5R4AphPXaomntvJeB4WIV1onsOpjWv7UwL9IicgO7J5aY7HHdsIaPS9ss+THYcJsscsvmYekZpWUNPyfLGz3TmHm/Du9vCv9x0TsHEF9u8ECfTsq8rqDMgK/vFpfL4XynJs4LzNPbk6bc0T2AFTDlVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DitkrXfunp/kP4p4Jp8/ytEgYNlccU8ZhES6wTffmGc=;
 b=qUv6Ri3W+4YTg9v9p0kgmaB3j57/Th7wg6qTB5mkuDJiNEPMyUN+b0UvkVfscvUzCPeUvvzLaNZqoBJOfeUNW+9G/UIsZsHrQJe5igCLNO2JNqszPzqE08QYBjVD+r9f6rOMWbKrElMNy3A3d9KA7Jq3TPhwz7adiPuPzfgsYUk=
Received: from DS7PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:3bb::12)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 15:19:59 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::b6) by DS7PR03CA0067.outlook.office365.com
 (2603:10b6:5:3bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 15:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 15:19:58 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 09:19:57 -0600
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: sdma support for sriov cpx mode
Date: Mon, 4 Mar 2024 10:19:30 -0500
Message-ID: <20240304151931.802397-2-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304151931.802397-1-samir.dhume@amd.com>
References: <20240304151931.802397-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fc0068-468b-400f-24fe-08dc3c5e8e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/BB2Td8VmlpmkE0VnvYN0e8Z8hEpaVfwyXNG/o9IGJlW3cb07EP9kf8Jnbp+YCsnfDyH8hHaI18OleUpT4RJRowX0zvZH7vgkH+mR0ZBtReHn54gGRV+SEqMGDVIEFoCIeSDD5HU4gwU3+5WuF7RURnAtX6D4Fyvo8MDFb78DpsYnciqqT73ZP+lUZe7JPerjbM9p5sh4k42eSxVA9dG3357QXkStnJz25/h6gObHjRzASggrtYfJkY1Oz651uox/sjJMFeBeRX3hfrIs1AhYOwx6b+3AwRh/uvAAlWnQyZfnbuAEo6KfH0U+6hUxb2hevfebDAwRwjYW6ufQ6InBHnY8Ybr3i8B6qZo2Gvl9cvePqeLP1NKQgVNR4jpp3nob6bA1UhdWSwx7H8vU6RXSSbMhWE24jPXNEdJzSTr5dKtqEoc9h7kWH0VnHI72ehReN0+wNRRzxDACvGR2bS63n3QSgZihz3Q3ZULDt0NUx+I58vI3u2E9MvFlS4EfrJ1roGn6hRCnyUBWMyxa2cPiS8fuX8DEYmekoOdMBMLLkZlRKubgOQwiLdZ9ytclEYxedmHxkfUCVQQi4WPU9FS0ITsVikC0hBYmL8MBRkwkTG02uOt61CFUZMonPHXow84IJyJTJzg+r9K5rk0R2HudT1U4MNahIiteHdSY2ECrh5rP3cAJLJ7ZY7/trxxoy5PQ8WrVKPQqOyaGLRZkG6kkJvipJXGOh9kZsnBg7g7PmLPL+MawHL9dbgcqP09JeQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:19:58.6910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fc0068-468b-400f-24fe-08dc3c5e8e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 34 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..f666ececbe7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -82,17 +82,37 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
 	}
 }
 
-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev, unsigned client_id)
 {
+
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	bool sriov_cpx_odd = false;
+	int mode;
+
+	if (amdgpu_sriov_vf(adev)) {
+		mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
+
+		if (mode == AMDGPU_CPX_PARTITION_MODE) {
+			if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
+				sriov_cpx_odd = true;
+		}
+	}
+
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
 		return 0;
 	case SOC15_IH_CLIENTID_SDMA1:
 		return 1;
 	case SOC15_IH_CLIENTID_SDMA2:
-		return 2;
+		if (sriov_cpx_odd)
+			return 0;
+		else
+			return 2;
 	case SOC15_IH_CLIENTID_SDMA3:
-		return 3;
+		if (sriov_cpx_odd)
+			return 1;
+		else
+			return 3;
 	default:
 		return -EINVAL;
 	}
@@ -1541,7 +1561,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 	uint32_t instance, i;
 
 	DRM_DEBUG("IH: SDMA trap\n");
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 
 	/* Client id gives the SDMA instance in AID. To know the exact SDMA
 	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
@@ -1584,7 +1604,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
 		goto out;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		goto out;
 
@@ -1603,7 +1623,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
 
 	DRM_ERROR("Illegal instruction in SDMA command stream\n");
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		return 0;
 
@@ -1647,7 +1667,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	struct amdgpu_task_info task_info;
 	u64 addr;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
-- 
2.34.1

