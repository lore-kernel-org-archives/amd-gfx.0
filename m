Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204B9C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5F910FF26;
	Mon, 29 Apr 2024 14:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xJTXD9Fh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B2F10FEEF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGhhQADxHK35qC0oMluiTdyKgxUNABUxDcA6d92jQNZrqleMOpIWIAec2V2rNDOTQjqsscrwcVY3Raq6X8f/5Dv/SQXq0d2lwi12KM4TnvNB8jVWT6EOoFa2Ne+QGqPbWLTyiv6KhnmLayl8vRmya2hUGoVcSib0Uhl1x5mwaJvtSgWN75l4olXBb8W21Vgba+Qhr3gBc80u0JuXXqGucJqDRnQ89mRby4lF52iYSnueUILLBfT45pNDQx8C+EyTDq2AmlLb1NFVvkRPkVMwai7WoS/5ZPAVXF9ij6dihRgMhtIooizJfc0e44RZEl88j1fDr3jhxCqhTPpmEJs8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiBFPotvvU/p6BkS7l8hI2I90i9PYqcQiIj3SC3eIzQ=;
 b=YMKX+xJ2orofMOwXxR3JnVxxx8LZBw9gZUigYdvPQCysLXtJWDjgNAnGJVqaNWjDSaS4yRzb9O1zD7NADy7b9zz2Xj/bFXcRGJXyOc84geAf2qFPNMkdmgeaqwLA3XxWlKha4xaLXqK5IaUOjBXxPKOgqDtVUrDwfH0mJDpXoWSkZvzCJ6ok0YF3BA68MjkrRj1uAxAYdV+FriVQL2EdJuK1eE6qtT6Cv5X5JPM7lCn1oQnktePdGnIELLUcP6HWgANAvMgIbKtZbLMnHhIJ2zbSuByI5mdufYd7Ai7YJ8K8kObi1O1/QGF6zy1T5KJU7U80V6FjNdgInI5zM9DToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiBFPotvvU/p6BkS7l8hI2I90i9PYqcQiIj3SC3eIzQ=;
 b=xJTXD9FhmNXcbgEPDLcgTy9ggqJD6WGsEKEyQoznhGihQ8yF4njhIGIBs473jflEr1dj3COEf7lWJAvlZm6X9m/LD6VtMXd1Pe1YsM9K+wttz/7PWD0S5nre0ptNT99X4X2i9fTFLO+Q+a03bJWkx7nIKLC5n8wipwiIT2BYAnA=
Received: from BY5PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:180::34)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:57:57 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::86) by BY5PR13CA0021.outlook.office365.com
 (2603:10b6:a03:180::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/14] drm/amdkfd: Enable atomic support for GFX12
Date: Mon, 29 Apr 2024 10:57:24 -0400
Message-ID: <20240429145726.3459450-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: e7430d42-1fa1-4d24-264c-08dc685cc1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q/Wf2iGLmzlZ6GZj1ltARBW9QN/zk9H7lqtwJJVaBfyKMEae08mOT7K839gI?=
 =?us-ascii?Q?Y9cuT6prl2Gyd6SUU3CEcFkMq3Cb//EmYgHwG2S7nyG/kIPX1wzfzHpS1qdS?=
 =?us-ascii?Q?6qvnnySGT/iy4ZMp3nqaocUWgp94FQdeKUSYN6nLtN6JI7VrliHTttSOv5rt?=
 =?us-ascii?Q?r8lZ9y0s+6e4j09mH5/VUX7M4aB370/lAxWtwYEyokApYriDj/IjHs4eGCjW?=
 =?us-ascii?Q?SU649v8dDztQD6O5a1b1Cm3orPrdZmkn6rvtcPH4fICoyYyv4OUAQcoKPT3M?=
 =?us-ascii?Q?1mVqC2sV4n5zbMHLyBjFF2IiwpJgAB8JZfXW6pPdDsVQZmDgO2Bim/Q7smj2?=
 =?us-ascii?Q?xrz6DLr78Zw5kEGr06aY+nWH/k7YdOVtgc08Pzos4ShxMitw/QZa7xBUEu1P?=
 =?us-ascii?Q?uMfP15ek9akmrb51rWjoDIcL/ljdhTYaGjiruugiSIu8HOTwLsUyGIegmDJb?=
 =?us-ascii?Q?YNeT/mybCHjRwJvqq5Xuj9G4Je/rVIwuScXjyxdevUXgW4HnvCrUeB41BDeM?=
 =?us-ascii?Q?0Hj9tNzOQoxtZ53uGE+0OT9Hf+wnRB4Swoutb2XMnlleS3eE+MbaHcobBVbV?=
 =?us-ascii?Q?KtCvMe05+ikP0dO/RQkT5gsemie8CgNrZEnijuDlYdt7n/ssVvPuOJw/xn1T?=
 =?us-ascii?Q?3etZIHOxhItvQ+xuaVu73y37t3kLnaZ3MM8FtZUVImwzuOEEgjvjPCBhto0O?=
 =?us-ascii?Q?gXu0qeStDi/7JkFrfCH3vOR9XYzIcs5mBLDrZA/BlSqDe4U5Yn69O2kFqP0s?=
 =?us-ascii?Q?ALZnL+8gxvWDOLRMhnFJLXkjMZSFwNVNbLNV+NH/nVDAhw658atPAskNAJN+?=
 =?us-ascii?Q?4wjc1Rg4dEBfDYK1DRZtztJLVMs800agoAGBeBMJUhSiraSyy2ixoEIxZtaT?=
 =?us-ascii?Q?Q8RAcm2snLRCwUndRchlnrE9OymFnkhuBMVc8zwkeJbpob4uDT+Uowtxz5Bj?=
 =?us-ascii?Q?BRiJ0Xej1fzFRhmr+i4Ig8q+z1GHFdkx+7YRpZP1g/uZq5xJsviDz1EIHiPm?=
 =?us-ascii?Q?Eie9wwbZ85aeZeaWaszRI6QbRpWF/62NluCjHymk1Y9OSczaC80x4p7he2uZ?=
 =?us-ascii?Q?/GClBbyhEujeJfOZrO6RYeYJXlBm83iXfOnTLzmejmo4W4nptZ8GzRv/s8JB?=
 =?us-ascii?Q?jLX4SYC2AvZoAOMaGbwUlD0TrbCJ882J3y0F8hOWWZOgWdLqnzpBcaUDgmES?=
 =?us-ascii?Q?fjP5j+fTU5lh+UdgdqWqrJqvmNQAS50AiEsTx2WSmCdI+rlSmjAEjtbcF2Dc?=
 =?us-ascii?Q?g0gzYDNXlisNWmktubwMzVcintvaiH0VkAaM26+P2fE+Oh94z5GjbOwxvB9H?=
 =?us-ascii?Q?tFuFmM5Ab2I4AeUDrzwtrgAeWUObv7xhy1DOvv37Fd3/Kv4BK5dz4XdX2nxy?=
 =?us-ascii?Q?RU6RKG+gokf3JTTrR/Ny6XEOOcbj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:57.4329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7430d42-1fa1-4d24-264c-08dc685cc1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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

From: David Belanger <david.belanger@amd.com>

Enable flag in KFD and set the atomic support bit in MQD.

Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 093987b1e373e..5e5c6acb08bea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -230,6 +230,8 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 			 */
 			kfd->device_info.needs_pci_atomics = true;
 			kfd->device_info.no_atomic_fw_version = kfd->adev->gfx.rs64_enable ? 509 : 0;
+		} else {
+			kfd->device_info.needs_pci_atomics = true;
 		}
 	} else {
 		kfd->device_info.doorbell_size = 4;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index aa900b651eb0e..b7a08e7a44234 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -135,6 +135,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	 */
 	m->cp_hqd_hq_status0 = 1 << 14;
 
+	if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
+		m->cp_hqd_hq_status0 |= 1 << 29;
+
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
-- 
2.44.0

