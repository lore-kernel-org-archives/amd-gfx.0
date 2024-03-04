Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07434C5478C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 15:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAD910EE30;
	Mon,  4 Mar 2024 15:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UCLIOvkx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4057F10EE30
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 15:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAnPoI1Ki/el8+uW65vA9gBp0ZW9RRQXU37yTrAX8DbV0A3IF3mHErv0s2hKL3/O7SENdwDnv8gKYgX1Pltn+Jdn8BtorDNcMfNTqc3qZckbil5t5IqG/2cHGBoHfKFPRRb5mf/8E8nlsmYOQjNVrPRz5ecC7u9YSCpYsGIiM/2lRWHl0q5uaU6jaIO0xv3vTygjaOsmzkow+K731xLJk7ZgOUtBTZl7MvOstljpsTwkdNhu7duKgNB3HoTZ+4z05mj+/2RdfpqhW328B9An9A6dJmwQie5hEe91ORb850HU4yxNscBWFg5zgrWQEbHGgy1qcmM9FjUHdpqMNgifkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRNSoH5D435Hd7xA32qVEGdpnrAGEdjj1uJe6anN8yM=;
 b=VOw5+j6FnI+E5F5q0MQNofwsaWSziuoE3Z64R2Ql6zFW365aP+vtjvE8ln+jo+fI4wEuLH+Tw3n/7wfZ3q15U5mbRx2Ur5FTagkJE4gta9rRkjqs1dGqrVAXfEEEMysiGWXxBlGk+ncxHMi0UwYbzhcs6JD55Ge07J3xG+zqgqWmRj0Ws2R+PgmlEbHvGhciIFwzzSRPZqc8LT+ZQP7mL/CJ3aM/61VjuBNwQBNbpaf7zvA3y/cjc48wZdiOrPvJPJ9du4N4MFheBq0Gg9lwCW5QdyhjFbhJfJ9rjGe23RpLHxMv9cs2GgHRBF3XSYkjkKlV/JUPmaychre1sqwp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRNSoH5D435Hd7xA32qVEGdpnrAGEdjj1uJe6anN8yM=;
 b=UCLIOvkxYIUyOdBmSH5aLXv40mrmnPDHx7cD+ufIaZWVRe4zste6j7IIHLHcpYBA+4XmvYQfurBW9i+XSAuuj4Os6DeRfUIQjq/L59djvpHKxbBMV3ZTg8QQVT+vub3Qj94Du/HkzqZytZtTqz18X7YYS7Jk5pY6fZJtSlfHA4U=
Received: from DS7PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:3b7::11)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 15:19:53 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::ef) by DS7PR03CA0096.outlook.office365.com
 (2603:10b6:5:3b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 15:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 15:19:52 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 09:19:51 -0600
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: function to read physical xcc_id
Date: Mon, 4 Mar 2024 10:19:29 -0500
Message-ID: <20240304151931.802397-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 008aa719-5e28-43cf-4c06-08dc3c5e8a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKS0DIX8aEyWLFvkOuGmPW3Z36q2eDWD0I7iuJeJpf3kEQMcYmKJJ2/CuVG+MFXV2G7sAG2DAZ1orufhvmXPv63RX2zH/n6dlncseUdHoZWG6nerKYzAvitFr3Zs4npCDOZyYPyVrb5Cdyq1mW/vLMm1/oU6KLzyPFou060DYaRxkstAoSxlgPy64+gWi34kHoEoirqvt/ysU2DeTneQOv1a0wAFqD4mtpuhq8sIQc8SyVYUcgYfByJwRZdd8i3ZkQcD0uHhlPLYtixQUPe6OQUH1WTkS9EWpr5B7Pk5x1OhPSQxVMBMyPHtdnNAcyRurLY4t/ExaXGcwP7UU9cnALA42j41CMtZacB5QF261UXG/NyB3ZxcfgYcOWa7vPB4FfYaf91KRprQqIxExLoRffJuBR6/4LI6cVRapWB5mVliL2xY3NSYxTSw7HSm5jR6U22dWguHXbZ9dtUmnpedxLf+ckwOFYuec6z2Y7HpYb7jxUC/GBRIQzRo4ifPOiccW60iVqF/0SvKCtZSKoX3RF7xZxakZDRPwT+NE3Xmd6WcTiJtX/lwOVe/5zACfRvlZ+XfAB9LPoQOrQY7VUQR2QH3tIb/zUntx7R7MGgaIYl5mSmIf3O462c3C7GUR2i9Sf4a/u8rPx9FXerEv2OCk/YUos6r5cwWnCXHfr037in6RR7rLvp6nwqMlwjVqJo7xiC35Qh7UDxDUYMOYVFx8p6bDB0s2lFRQIjYuU/pte/2hAp/9IZxkKEQ4lyL5myp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:19:52.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008aa719-5e28-43cf-4c06-08dc3c5e8a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8fcf889ddce9..bebda5501cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -298,6 +298,7 @@ struct amdgpu_gfx_funcs {
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
+	int (*get_xcc_id)(struct amdgpu_device *adev, int inst);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b53c8fd4e8cf..68508c19a9b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -669,6 +669,11 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 	return xcc - 1;
 }
 
+static int gfx_v9_4_3_get_xcc_id(struct amdgpu_device *adev, int inst)
+{
+	return RREG32_SOC15(GC, GET_INST(GC, inst), regCP_PSP_XCP_CTL);
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
@@ -678,6 +683,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
+	.get_xcc_id = &gfx_v9_4_3_get_xcc_id,
 };
 
 static int gfx_v9_4_3_aca_bank_generate_report(struct aca_handle *handle,
-- 
2.34.1

