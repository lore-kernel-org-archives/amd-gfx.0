Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F97D49206
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 09:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0203610E1F1;
	Mon, 18 Nov 2024 09:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m18/3YNi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0859C10E1F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 09:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGvZ+eo5T5eh4wYDJVL99GVEhxcS2XVTtEU84r4xQ+FQXMc8jH7nbhMINumVbwfEDvXNNYY1gIp1eNY01hjRFEGMHF0EygnzTUPZwwTFm0iX2rXgZm6bQ0nI5sQJssMJcDKMmONOG1MsiM9EbH/q/uX1DlslKAuY+SfAFXyu2X0hFf9OP51/9NjMRkGqgzBre12ZanOmhsbYgypavNvCIMfW4FjY9SsKD0RrWluv9YmqAZFUoBqFeQ1/LXY9YeGlpLTdoeg0gVYFgQO/lZ8nB4+s8iugfDP6Cf1F+CJu1p1yoHyB4pT3Dy+CiXGBnNp9cAIbRuUqfnfI0kGAiX+XWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfyzwHhvWPIhgEwHGZWewHVwfOyemaZ/MNJUlKrMxVU=;
 b=fVbbvyGzw+BUHXT7dOC9ddGvd3FVGaT5OncMN1OhxME6EGHXU3f20m68GFFBu5A/gc7otd4GWwt52Dd4s97Fp0J4rEW3TCp5Q0NPPWNvFxC+9ceGwCodqpTH2VNOHsEptcM7DrYWio/fa/bRKm6QxjQai7Tqzfzpqm0pwx1S5+aFyF8hT24ZPFp3Xlu+9opdhfg9+3TYpb7al/9RMlV4hg8p85OAOs2n5OVTyeYPuP7JjTWJMWluEJ40wlt6q6HqB1m7dip0HIFRJ6g7kL24vm3A4g0gFqH7zqYRhIu8kFNIoxpzjx+Fg+VRWQTSa8Bs7FNzrZgHE2slA9sOrBiwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfyzwHhvWPIhgEwHGZWewHVwfOyemaZ/MNJUlKrMxVU=;
 b=m18/3YNiT23m8jwXvjVmcL0GbK1S4bFXChEOlGZHD+x8Do7lxWAzPABoBetHc1hdD7SQwuv+WsLohE+wY3bE9wIyVq5HPRQ1AzeIxHRY6cfGUa+INx3qOqwc9dVG7gk72229EIFiZTetiJUBaoVHWitpUV0HKOF2LuDOS2iKSxc=
Received: from SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 09:50:04 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::17) by SJ0PR13CA0080.outlook.office365.com
 (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13 via Frontend
 Transport; Mon, 18 Nov 2024 09:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 09:50:03 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 03:49:10 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <david.wu3@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: reset firmware flags after VCPU buffers are
 cleared to 0
Date: Mon, 18 Nov 2024 17:47:37 +0800
Message-ID: <20241118094737.1024533-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 14efd432-6094-4122-734a-08dd07b66082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+H7m17eLKJ/WYq+Njmlj1r4h9NNvN4jF7kZZ0AAYlZzHPXjxqdgRcrZjta8V?=
 =?us-ascii?Q?Pg3QqR2opTIqFT26bizwrAR3nk5rF0zuAvnFg5f/vsqY7A76W4HgVGt7gbwd?=
 =?us-ascii?Q?IauRXY2tsGhCO0a1seKel+nT8vUg/wmmj/UrIavBc7i7dCo7/ElWY5YdJAuv?=
 =?us-ascii?Q?39coCJcOviWE7lyU4UCKGIIYm2+Ri7089ysndkP1/vkRshbYcJaVbCPesHN7?=
 =?us-ascii?Q?MmbCZE0ri/4OpAYiIA2KiXMNoxeqeG40cSlr/m/lsfJ6ZOFVAZ/27vvvax3A?=
 =?us-ascii?Q?7ibWA/1Ee6hJ5ajA3ltvonc+YlhL4PCGh13ORz3AG3Zqzy5seLComcoUe34W?=
 =?us-ascii?Q?QELGXee4GX4bEOCjpVi8etGmBIH5k6LsyY63sIQgupGk+AsOvSWtx6+9dCxW?=
 =?us-ascii?Q?8hR8A+g8bEf6g3Qkjv20Rx2Nh6TSPw1pFMp802Lh0v6mErlVcRkJ6zwH9wPy?=
 =?us-ascii?Q?3Kuf7/WEgZkTRq6fHd1iCxq0Ab4P7py74WSV2nl03vrgjU/E+RMiQkYCQbUk?=
 =?us-ascii?Q?1raFCdwOHkaANKtKlzwsTHVnQIrEhcjkfNPJ0PGOrSCwoSNuBii4pPjizG0T?=
 =?us-ascii?Q?cYUxZRJB1ip25uPytegnnKt/R1lFBzMbxzfD9jNck0AUgLKex76+xUSNj/Z8?=
 =?us-ascii?Q?Uij0vQK0JjOffiAmm8GHqblfGIo8+SJZ92b1YDrmEwYAJ2DPTnBTIg0jQ+9O?=
 =?us-ascii?Q?nwxSQKqY37Wt6ByZNv0bfnzTu5egoWkrMKB0ezAhc96jcGI6ZZWd3TB0J/D3?=
 =?us-ascii?Q?HaoprzrncVCPTvoSwkGlmWorP9z+lYJtXYC02AR29dc7wZOSKuBrTc6vfFYz?=
 =?us-ascii?Q?Q6BtCpZPqymyrr9gXRyNwV+elkNOXiDW4UfBsiheVCzocn7L08hrEdj2Do5b?=
 =?us-ascii?Q?rs8JoNcfqMJHNb4+hl279upbNore6zx10kPnoOKodNKC0+udg5jAaopA0CZe?=
 =?us-ascii?Q?UfrISp2pRmTx1otDNwDTdPOdMpc86l5JH8ZJhM0+0rsmXA6Ri9K1OqFDV2eU?=
 =?us-ascii?Q?b0yhpp/P2Eq0hfdQgB/AusAbqlNRspH/MqqjSotEyttoTgcfV3qd3ozcFlKN?=
 =?us-ascii?Q?3EK3gPzdTXRgRZmcPDYOQCarwsaLj6hZkSFxbMy6Hoy+h0T6tlB0m60QRjSY?=
 =?us-ascii?Q?byG3Lxz8260c8mDo0faUjPOJMBu/7EK7d4PeCE3Z/rtzSmQ42dA3Di2ffftN?=
 =?us-ascii?Q?+KIAtLkGk1lYJzo65a8VxIaw50q2Sf0wmJurbtu55YET7AthxCh7lvASIZGr?=
 =?us-ascii?Q?DqJJQz/lNa8HN/p84pJY89rwdEDem982t6rLgs1qdyakiKt3QAqc/vSG1I2C?=
 =?us-ascii?Q?Cs6wn4d4MWAowW5V8O4RG6ME5rlM6F1Ku5kDwEUc25quhpeDYMagzDt38GQv?=
 =?us-ascii?Q?GQZMct+eRCnH5IgKyg1leaHujzgC5FF2wr9LmVxW99bNEgxgUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 09:50:03.9363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14efd432-6094-4122-734a-08dd07b66082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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

In the case of RAS err_event_athub, the VCPU buffers are corrupted and
cannot be restored in amdgpu_vcn_resume(), the buffers are cleared to
0 for good. However, the firmware flags stored in the buffers need to be
reset, or the firmware cannot work properly.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d011e4678ca1..49ef8f43e3c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -279,6 +279,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 			ring->sched.ready = true;
 		}
 	} else {
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 			vcn_inst = GET_INST(VCN, i);
 			ring = &adev->vcn.inst[i].ring_enc[0];
@@ -303,6 +305,16 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 					regVCN_RB1_DB_CTRL);
 			}
 
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			if (!fw_shared->sq.is_enabled) {
+				fw_shared->present_flag_0 = cpu_to_le32(
+						AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+				fw_shared->sq.is_enabled = true;
+
+				if (amdgpu_vcnfw_log)
+					amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+			}
+
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				return r;
-- 
2.34.1

