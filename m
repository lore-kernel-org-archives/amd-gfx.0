Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF04C25B7E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9BF10F12B;
	Tue, 28 May 2024 17:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHrXH6Bu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330CE10EE0F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQGRpmPusKQD+5e1se5GFRUce+lIT9B3+I5oOVYm91JdN0IfG2mafo4uKXKn8yluANWXJNzUdx1PJlceTNyU/9X+O/Cym90OiCv14AvsCx4F/oq2rTENxtUbbn7IZ1/DZJ2QSMWsuwTafizwnKMjdBPjVA9Y277AwwwlMIrYfPUHbcQ18n8aeg5fwToaPlLc4d7rPU5SHfXkHcPC4+tqHcXqh9AbH4xd4OKvGJROXYHzSydv18RFXvFIikCelLEqf8ynSCLsNVxKL1RNzpJ2vfEFXQAoEfIYiKDg27/akT9ILREW9zOtalGNWDy63Dx8N0jSY/TR4G2cxwKxM4H++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc70dj7JV4XriW8un5X2XIWrEuDbV9j02/C2/nx8zag=;
 b=m0bxTZyGSWbBqdeiVw0MNP37/LwQH5+Foujq2eXsdAh5DuKMflQ3l9Ky2J1jJ5Nrc3PwuZs/sEz73LietGIZl/wMCpWXBN5IsfHprOeTLs2HXwO9dW97rE/dIem3eRg9+V187CeTq9XhD0SnHqP4gs7SalolMN0y1uGKsPfzGFGLL73Bse7Br3t8U0ucZgo2Wz4OcmqN8gQ26rwNGQhv8ZTlnBdpSM5F0Dc3v6qA6fEF9ICXhzI2XyGgxA9wkLMmhdebm1zxXjjX5I0Rfvt5ACqyZ+adHcJqIGlHEKQ6X6qkmUD1wOdJ0fQQafTQ/mKVcfA4J1niQEbwHm0GKRubbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc70dj7JV4XriW8un5X2XIWrEuDbV9j02/C2/nx8zag=;
 b=OHrXH6BuDtSYxrJFE8mda6zqlG0kMN1HvgEP6N886S105byYrIoHogXLPdXZXFW+Mpw1Rnj76kvwL0sDsOKFcTxVALMFJiAmQrxSWlxW8+bb6cLC+Fm58VbQdIHUYnax5uB/8t9G7KhqNYw/mE2fmK2XTG5rvPtGuWkBJk/g2wk=
Received: from PH1PEPF000132F9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2a)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 17:24:10 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132F9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 17:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:09 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:08 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 01/10] drm/amdgpu: add skip_hw_access checks for sriov
Date: Tue, 28 May 2024 13:23:31 -0400
Message-ID: <20240528172340.34517-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: e63cb4f6-10e7-431a-8439-08dc7f3afc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jr4y2RiD8HAiOcCAwsIi3xQyaO8dTaifGdrdFez1I0ERCusoGYX8TpQVdAyg?=
 =?us-ascii?Q?ebkHhgJfRBMijbxdaHLO4XSrmL8I1BKb6cJoYrOuuzg4Yv4h7SSaGEEymJE+?=
 =?us-ascii?Q?ZJnY0t9CCC7qPDMcOg7HPWRpnmJ/Ls6aHWZAP7LUSp/D0bpGwXi/p7IDcHjb?=
 =?us-ascii?Q?095rAts6RTWDGzKBFChEEQy/nN64bBPOsujkGl1YPiBdDDi/gUXLPswQOTmt?=
 =?us-ascii?Q?Dd+D74aZKaQFGRX/diEwB6O0XBqQ645r+AMjTrNvXvkV9yYt6+aCg4tmeWgx?=
 =?us-ascii?Q?UOk/NXvy6fvkfOWp2ZWcYWm+bcRMLiix/uQLze6anBuCxX/xIgCSzhHPdd2R?=
 =?us-ascii?Q?ZIM5DcPIV4ZGpGYrg18kquHUXFdqdd2dj8GW7yqQMfIdUGZz5AAs98dVjmlB?=
 =?us-ascii?Q?e5LCIL3l32jnAVSM5kyB8uNLssUvDE45sk6rkb67tAbE5dzaFolcUQlbGgy5?=
 =?us-ascii?Q?+2XjMqeW5wb85k8X4VuyIiD2/Cd9SDlb5SpSJg44Ntw/nQu4zgStEGl8H6qt?=
 =?us-ascii?Q?n28ZwXatqX6YMcIXtrZQVJC45zMRxbc7dtvcjUVbIbcoHDVyXte2z3qhBxdc?=
 =?us-ascii?Q?+UodwQP697y8Qe1J1vcJ2xLwIIZ3+9H9n9KJQk7m2KBn3WPCa4zUgwoBJwBX?=
 =?us-ascii?Q?dv/5PtDSFTuUywKIY1dljiWzEix2cQhG/BcOv+VkPnSMHHXECzLxsfh3afEF?=
 =?us-ascii?Q?XUNntQGO8ZOtsAPiL1y8rU/L7Z2Nns++uD+s5dGtq/Veej3jQHGIvTz1hpLG?=
 =?us-ascii?Q?jV8Lcl4HTf6O+LJiYAseTD3mm20wtEuhzAyATww0prGa+UxoywPM1KcJLOiq?=
 =?us-ascii?Q?DdFEP4yD6rYrcFu0D/vzO9twdtAOjXhqKBeVfGuNcDB4xcwdpzT2NzYhRmgi?=
 =?us-ascii?Q?zx7iZeelzG/G0BogcW4fJfl/dJng88GbEnY2tFuvGHd3gKXuDKr1qYX4nbhc?=
 =?us-ascii?Q?13g5n/83oBP/31HLeIMec3wG8Sq4vgB+fOU1NwRmTNgMRCQ6PTIJ2r7Ct7Ez?=
 =?us-ascii?Q?pE3T79kkZ86Je2p/VHvJ2anKw/0qFs+3j//fPr8gfvilfpVXFJxfPOUcqidD?=
 =?us-ascii?Q?SCpIuHXczrqhF7c4J+ueYPsISh8Xi4t/t8kKph2VPC4MTGuW/4NHEFrWRYZs?=
 =?us-ascii?Q?INb5J+qpfPOvWAPvdAfQ4CEDgvtyzVwsSButCXHglZ0WwFAq2RlZ3WoDlPvo?=
 =?us-ascii?Q?sQ2VTGkNzbxfvjLUjN8X9yj4+w3OPMYoPN26w+wDGfmUeEptJLGsDsT85O/y?=
 =?us-ascii?Q?MbX+m9QV4kxEpUJ3yJsNqASQkFd2MphaLPUnaO4Usyjofwhvw9eTkkc3Vlgk?=
 =?us-ascii?Q?sQ7Y6h1tw4J1/aEmYk7FOftKUSDf+26+Fj4Qgt1mGCFGFSPqCf5rJ1FS4D8j?=
 =?us-ascii?Q?4Xq0SE0YZPKMp8JZj6zIz5eW+GT8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:09.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63cb4f6-10e7-431a-8439-08dc7f3afc4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

Accessing registers via host is missing the check for skip_hw_access and
the lockdep check that comes with it.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3d5f58e76f2d..3cf8416f8cb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -977,6 +977,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 		return 0;
 	}
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
 	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
@@ -1047,6 +1050,9 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 {
 	u32 rlcg_flag;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
@@ -1064,6 +1070,9 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 {
 	u32 rlcg_flag;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
-- 
2.34.1

