Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B159C77B75
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 03:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0676210E09E;
	Thu, 18 May 2023 03:12:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED3110E09E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 03:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsbGH8qKcGJ0sv+ijtIdiyRaqp1+p7n+E+02D66yncJV6fUXcPnNnPIebkiADIAXNdGPT+o8oP7PDh4hAg8ut6e5sfgzGOe2RgxzXrtFvJUceDX9qU3PtDcpbDklVFmA4MhFXnzAwIpuKHESJdM3nJle3Lv4xNofuScTixA7MbI6Adg91PSvYO9BEki0FI5bH5uxAfmSl0FJueuTQO5c5/Fd3ZMYvz3kFaMN+XeUj6IAlC8k+kWaK3GE1ef1i4CsA51874cPUWrP2JM5lWmEJx8fhOILU13WBpF9CnW5NEHSyD8BUaZxXMG/Hsuao6WGkwHB4bZiYZhMkp21s2tF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/YDsDBdlxDJ8UMjTN82TEMtHcpOpFmbAjHQCUpsIlA=;
 b=oUKYxcOT3aJA6tdyJ8J/QDMMAfBNXS7/l4O6yj54DETmYomDr4eOmKXBw9/JJv0jijRxStzrvWqscFWKpiIbVV2SaJzQCUigDYKePTfnggHvBaLyVMCSGRuE6s8DSwRYxIuK/0duM/qlh88p12qVCe36cwa09UeUnifbs0E9L9XfcF8JYBR7ay7Kd8YEinFCobXtcMlqpXFVUEsWqAP4ePrv9Ap9VWEuoe4pRu9750NOFpQpoVJwYz3v3FLLreILObbX1fej+iEHlmfinzaC9/SCc8Uo1TgSD28jQK0q0C9++I0/oRi9efnF9c+MC41y4xhgEcZFOj0DU0Qp0MHkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/YDsDBdlxDJ8UMjTN82TEMtHcpOpFmbAjHQCUpsIlA=;
 b=bvbe4Cqsl7NxSP+dECGvnSqrOD5hAjB5N6BKa4TdVKy2wSod5jZlEy4LjKspBOMkLyQT2v8KZsEmVk6V/H9ojbnA6EvmQsavqwGxfzG9j7TpdSv+fYcrqQy6XmGZRxo4Gyy4oyeO4zyk+3OnItBGhcst+piQEx0RRjpGXzazIqU=
Received: from DS7PR03CA0144.namprd03.prod.outlook.com (2603:10b6:5:3b4::29)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 03:12:06 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::1d) by DS7PR03CA0144.outlook.office365.com
 (2603:10b6:5:3b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Thu, 18 May 2023 03:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 03:12:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 22:12:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 20:11:48 -0700
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 17 May 2023 22:11:45 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough case
Date: Thu, 18 May 2023 11:11:37 +0800
Message-ID: <20230518031137.192047-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e4bf39-63c1-4746-44c8-08db574da897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcq/06kl3xh3Z3vyIPMhWxZkRbd6N6qY1S45xRilUPchRD8Tdz67BKIiitHQn8uFtyS8/q/xVhnqvR/AAg4qXN573deFjeJo8mjXikFRGB7EG7iwO75ng9Tp5SUoHBsTHatFXGZbsC8JVbBWvHrEQqhEKQvUyxKkg5QrieFi3YS2AFrNRMS/RUSeLDScBP/Lygzu55gNH2S8EM/DFX+976pymjnlH19nXcflupNjSJmSjjgoMG+dunEctK+MCVnh9VC5VHBRywc4cnGXthcf5dQYt6Hkkc5JOsAwNSNCAQZ6uxSLJiIF57GZQBfWUHVhCN5dqPql0+Cm0x/nsIgP/E7rEwsF+xIV8ExWTFMFZUV+9T3LRi0+rlEb1DEXkMGoF8Pk1478fvvebtxkDapTDchgztnWiVbmIVcmArlXZGSwWDmq5BkvEwWg5/Dcc2BU6KYRQFTY49Jj6L5ru0/bkg2RPWja4ZZ/eLpiij2QUwiP73jtsTZvsqt7dvn/InwdoX1+Nxl/EAwW4p8VeyqO/zvpfZ2i9QdbUvf5cQQwxek+iTnSu1vFdBo16CrL37R7LfEEgWGEIDcbsLlAJeHIT/k0YhQKM5N0ZtR7foDSDqLMrP8W7uwsOXYk0i+9epkeq0fMMHCDg96Hnc8IblsSFPa22PYnP3Nwg0jucv5uvmWoNJ1211Jwdnar1k2vKny54dHKAvlrHFrKw1oAs2DiXt6ZXDt5/Wc2b6Am872nTaj+vfaoiEIF0LheL9HVFRzlRbIpRnxCE3cO/udNySIOfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(5660300002)(47076005)(83380400001)(316002)(36860700001)(1076003)(26005)(356005)(81166007)(186003)(426003)(86362001)(2616005)(82740400003)(40460700003)(41300700001)(7696005)(40480700001)(6666004)(82310400005)(70586007)(70206006)(336012)(36756003)(6916009)(4326008)(478600001)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:12:05.4860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e4bf39-63c1-4746-44c8-08db574da897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Tong Liu01 <Tong.Liu01@amd.com>, haijun.chang@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Passthrough case is treated as root bus and pcie_gen_mask is set as
default value that does not support GEN 3 and GEN 4 for PCIe link
speed. So PCIe link speed will be downgraded at smu hw init in
passthrough condition

[how]
Move get pci info after detect virtualization and check if it is
passthrough case when set pcie_gen_mask

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..18c6e9872247 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3813,8 +3813,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
 
-	amdgpu_device_get_pcie_info(adev);
-
 	if (amdgpu_mcbp)
 		DRM_INFO("MCBP is enabled\n");
 
@@ -3830,6 +3828,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
 
+	amdgpu_device_get_pcie_info(adev);
+
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
@@ -5589,7 +5589,7 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 		adev->pm.pcie_mlw_mask = amdgpu_pcie_lane_cap;
 
 	/* covers APUs as well */
-	if (pci_is_root_bus(adev->pdev->bus)) {
+	if (pci_is_root_bus(adev->pdev->bus) && !amdgpu_passthrough(adev)) {
 		if (adev->pm.pcie_gen_mask == 0)
 			adev->pm.pcie_gen_mask = AMDGPU_DEFAULT_PCIE_GEN_MASK;
 		if (adev->pm.pcie_mlw_mask == 0)
-- 
2.34.1

