Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9596EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 22:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414B410F109;
	Wed, 20 Apr 2022 22:48:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A7510F109
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 22:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS6QXWH9JdnBCE09SvG1poVn1lTE/T67JTDSbsnMnq3m0DzHWCvXSsmFEcR7f2TsnEM4CkjRL+EjhorIA3L+ucqiB5UetpF9sc+hHl0ut3iaVOQr+bnsH7JSbnL6t2wUaAhuDms+Afm5OwudXCz3hOV2LnJacPlj0p2S4Go1HvyNZLQoGh9j04Pq893u5a3eVwHXN3Rg00EF93RJIfbiMwaYxk3/6gUAQEjufuHxUmVynLFuRm+LVEn9AUu09nuHnWEdoAstxj1s4LD7SczWIMxlIKx4MrQ42KOcXwS3RZWqV+gFcEnbrMxRft6ntTfNm33nj7DTR5VHfdlf1ptRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEQ102DwXDMLHKnG82evR6FPw3Al7l8JxssZjtESmik=;
 b=e8LSOLHhbHD1pqpeBSkXMjBN2cat5NTu6/9wfveoVeqar+7UnROj4NovDUteqgKjMC/GyCbktb0tyFvkXkLzz0GgUDv/6ozBjHPjKjOOwMBg8NpbyKe3kzvN2OQXZjhIoRtZqZma9Nw0HvwQFEZFnhIWW+PzRK1YZpCmvoG6wfAxDl1yaVzAMC6sVaNyOWdhU8I3xHWJEM1pM+CruGxLGTTOHKypw2GwGFvLB8k6KBH8ksaQiTDZyZAsVpcdFMfYinJhyK8sjnGS68eRRo3Y81KbjhBi4V7xCNj8B0UhxDmK+a1uMz0h9UwgPP142U5hPCk/TGX4RJg7DTSpKEZSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEQ102DwXDMLHKnG82evR6FPw3Al7l8JxssZjtESmik=;
 b=qjMQakdedpRyTR329D+D4pFbeeX4ovOAf49UNwCCz1LG2GaTEx09ECclWi5ymGOOkY2Yw++kLFN8GE2RHv8m2mPAvA26By9roOiD+KnQSPSWYmp6hUKpMog3bsWNzhcfpXeR46FwvJvt7CIlBBuRkuUM73hsTh/xUDy7aF5oSuI=
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by BN8PR12MB3026.namprd12.prod.outlook.com (2603:10b6:408:41::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 22:48:54 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::93) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Wed, 20 Apr 2022 22:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 22:48:53 +0000
Received: from AWS-Host-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 17:48:52 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3 v3] drm/amd/amdgpu: Update PF2VF header
Date: Wed, 20 Apr 2022 18:48:25 -0400
Message-ID: <20220420224825.275180-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 551d2d49-a9c3-448b-0da6-08da231ff1f7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3026:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30267050D6E05A5AD07ABD76F4F59@BN8PR12MB3026.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HS5nQqJAuZeAjOy4D5WVXOAIckIWGNnppe+F7RBBEz1tR1IMmyx2QZHAIuli4cNsgqfG7lerSRoCKPS21F/ASe9MAFtMEZlrpNSLh+xH+nNDWDW8GNfdtGweb7YJd75YM6pux1/hKLTIIrhhg2Fz8gKic5IirFG2IAgVCovutA9s3Mvd7bG0oRqopPMkdHprsLoUpl7vIhHZNOHjwFzTTf4kkJbXQ9w5QXFynYJbeEhfehe8lKM+v/yj0707Y9ttEHCWg7wrtbqClMLKM+/t9VHXM0ZbiIH6Pguov0EkDxTPOEHMNg07kiUluoz0A5hH2Cp153TygxBWYG5MLX7j6kAO6bMNaagz7vshKdF142NzW532JyzDp56HTyDYImPyNVktb1dsaASCjTtwpjHcIISWuKivZv7g2mHgEJLEGutte+vJyWdD3eagFRQYiVbytv/IirlKlrJVzimo1ath6nYwEsUKW3b9w1tmwB1mi8viYAm6ouq8+XAEa68M0NH/5yBJm5qaClVnURfYcceX/QXXd0NfXobF8laReix6bZCXqQhKCPgZKGdCZdA8Ng6exCjUu3lUsQmDkqCpntd2+pBozswy4nvueeFq0EDax4XjPLCydRU8PVdn0G14InBbUJCy7LQ6bQWiRQEa2Expx0NUqZ6WRPTAdcRxywiCcIapyrawh2z8W1AG3fhMNvCJNk9uFgvVgj+w/StpagVvKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(26005)(82310400005)(36756003)(1076003)(16526019)(186003)(81166007)(4326008)(83380400001)(70586007)(426003)(6666004)(6916009)(70206006)(8676002)(2616005)(47076005)(316002)(356005)(36860700001)(5660300002)(508600001)(8936002)(7696005)(15650500001)(86362001)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 22:48:53.4929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551d2d49-a9c3-448b-0da6-08da231ff1f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3026
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- In the latest version of the header, there is a variable name change.
  This should not cause any backward compatibility since the variable is
  at the same offset in the struct.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2e0a81831e0..14c5ccf81e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3725,7 +3725,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable PCIE atomic ops */
 	if (amdgpu_sriov_vf(adev))
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
-			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
+			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
 			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
 	else
 		adev->have_atomics_support =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 65433cbb00c5..43dc9026ef7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -155,6 +155,7 @@ struct amd_sriov_msg_pf2vf_info_header {
 	uint32_t reserved[2];
 };
 
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (48)
 struct amd_sriov_msg_pf2vf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -204,9 +205,9 @@ struct amd_sriov_msg_pf2vf_info {
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
 	/* PCIE atomic ops support flag */
-	uint32_t pcie_atomic_ops_enabled_flags;
+	uint32_t pcie_atomic_ops_support_flags;
 	/* reserved */
-	uint32_t reserved[256 - 48];
+	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
@@ -218,6 +219,7 @@ struct amd_sriov_msg_vf2pf_info_header {
 	uint32_t reserved[2];
 };
 
+#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (70)
 struct amd_sriov_msg_vf2pf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_vf2pf_info_header header;
@@ -264,7 +266,7 @@ struct amd_sriov_msg_vf2pf_info {
 	uint64_t dummy_page_addr;
 
 	/* reserved */
-	uint32_t reserved[256 - 70];
+	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
 };
 
 /* mailbox message send from guest to host  */
-- 
2.25.1

