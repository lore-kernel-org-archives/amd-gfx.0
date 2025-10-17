Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E391CCD184
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 07:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4AB510EB3E;
	Fri, 17 Oct 2025 07:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1/tk5ycv";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE9B10EB3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 07:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh60TkwQP67fnMi6MjyIQ+q6qBKnuF6ENWaQWeRiTdbydHeJ6a8B0FzwV24hziJv4uAzyJObObbZGVbUYV4sjDS6/BmYOmdEo4zgt4P4/0nFsz6fZSoIsf2E8AdPOYG4/DrioMz+KppPlOR5IfSV8dXHsKA63y1CnyWXI68rz9s/NUxwKJ1lhAchdp0XlE47n5eAVqUNTPFZVbBMiT0YOvOLDkEIPil1cQ82Xz3mD58D28P/bvVKXlqVS/rywiA0fv/61nNitGhr9c2hNRGJyVIolkCy/3PkhhiRnsu1EaT/VwR1RjjYq6qM1/RcCyouuv14YOJuWynaDnehKc7ehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsUyFlCcd+mJENn5e/AnSXW9cW5rGmCNYNlWa58nZ6o=;
 b=soVddYi1wT8OQvA+gmScTbGjk37W4YQ13SfjzkPsBGC0pHZ98N48WfwSZUcdH/8yQdZJeQyI1DM3cRRbEAfa3PrJW1mT1vPj6e/FzrC6en2d+YB9pX6QKcZukC6Pnc3HeO+x4zqCBU5o6DpsKnyuDoRXo59o1GQ6wPNQLxgC+E+LwzQm7JqKoeD/lZm/si7o6zl0JNDsrpYQBawQ7jLVBHb+u+Sd6KyDxE3e7A7UH/bncIUocN/fbRH9c2Y0j93F/Su2F+R8LodiLLJFDdfUGSQFI4FBb3n3LFTS0Wn90WR2F9fmXQ+Lao4ALVaWkIfjn+hYI3X55wjOylhAODg/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsUyFlCcd+mJENn5e/AnSXW9cW5rGmCNYNlWa58nZ6o=;
 b=1/tk5ycv7MsqpfQ/PzQHMFf+l9E8OMH0bV26W7H+S8U/Jb5rMcPXJxJO1uL7yIHyT3YR7DVLO8c7iGUruMQH7koQFiFH8+5IPewGmaO26LjiV9thJgBmp+hudGKp9AAEaDPhw+3OST+VM+SFsr33Dhl1jRlrWW1F+P0aGYdJIBU=
Received: from BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::34)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 07:52:45 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::6f) by BN9P222CA0029.outlook.office365.com
 (2603:10b6:408:10c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 07:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 07:52:44 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 00:52:41 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: ras module supports error injection
Date: Fri, 17 Oct 2025 15:51:29 +0800
Message-ID: <20251017075131.23939-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017075131.23939-1-YiPeng.Chai@amd.com>
References: <20251017075131.23939-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: f424807d-018c-42f6-accd-08de0d522865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WDY3O9rp+LrVNYJhTKJlJeAeDTrCr/SnSoF/glFITS1hc/BEMPpMTJrDFt10?=
 =?us-ascii?Q?HEiLao8SbY+vqfcrS7qOCX/rN6WxewRvzMkTM+3GcChbNBQe9ljETheqRqGw?=
 =?us-ascii?Q?u5JoMMSeupPv7z2eQUNJiF+hyogXpCTSAoo1P43nNr1Psp+2YZJubkW59NtF?=
 =?us-ascii?Q?vtOTFIMb8gwWHJ0yikbzOvj0hdzzJmMygeSuecSmimqnl2wNEI7H/4VyrEEY?=
 =?us-ascii?Q?YWavgY9l5r13B75P9Fl7aG2xE8ZDkJZmgBQumB7gS7307pmFDpPy122P5KmT?=
 =?us-ascii?Q?n92MUaHTVSFt7E911sFE6/d24mMarm0FpCeuoS6i30cwaZQsxrGc5B4sDfuf?=
 =?us-ascii?Q?gFGUhnz0HSvqmej7L37CFDJmPO53SJXZotTHRRKULgrGx7ljhoy3JBH99tA4?=
 =?us-ascii?Q?ZgiqpwM4pNnz8Foo/ROnOXzEj2JE8PCNa7vvDPLJVJE3WHkgL0e7ZQgyu2HZ?=
 =?us-ascii?Q?n9PIaj34vkxwl3xA1KjgYb7ew9pvfhI9hJOsgbjcPyRgNepzHckiuy+Lhmy7?=
 =?us-ascii?Q?wisV7cHIJukCTs0MZtjrgZ/L0n9a4NrfRi9y8BIWP3tjso8O0VYjI7TWu5ml?=
 =?us-ascii?Q?Ed4GYRoWHvIOaViiJQfSrHjsOq6vLpBgdTg3ovJP5KGAlCUZmRPTv9HVsjXI?=
 =?us-ascii?Q?ocPD9wSQ9cOFeLhfY/3tjkYHYiXhH03HiTMIwVbYPB/7P8RqRQmME08Iq0KU?=
 =?us-ascii?Q?UIDdzoRJ2SjZv44i+VkYzChYzMbGR6RsgHHO+LsylrFsg0ElUQgetsG2WzIL?=
 =?us-ascii?Q?8oPPUZVTM/vrT8eQXGUNLNFlq1ynabCbS7rEz32ZqpaTlDHCCm/PbodkU/6v?=
 =?us-ascii?Q?G9yTwaSPKcMd8X8slfR2z6EbwY5pURPCuPRZRvdoTvB8TKCa2C2WD/s5ZELD?=
 =?us-ascii?Q?oLHHLJbPhYI8DG8sevkvUOkurNDUXE5C9llSG2355jfePG8goa688J/Hv4us?=
 =?us-ascii?Q?4CgET8sq+FjCSEvetStJOsC/9AAiH+NjlUjDbpcd/aR8AK86DFTFN4uB53ps?=
 =?us-ascii?Q?/S1A0rRZoo5u/jHI3AdhtXSaEIL+k3eCUD4mtTBPby8WUCmeIXyoSvfURr8c?=
 =?us-ascii?Q?xn3FsJCHDOW3Hx5RzpiXaYt7KH6HcJ2Dkql0AbygoLqrXVmHibb9breT56P6?=
 =?us-ascii?Q?n1K9m5BcwwLvfyjVWQj/ruA8aNoin/uJTPVep4C+DVYEi9IcNG/Cw/qyeWv3?=
 =?us-ascii?Q?QpsxtplGJOp0UpGGVwb2YPWU5uuxGvHsLfOWMsLiYDhgZcX4QQfote1RHGrY?=
 =?us-ascii?Q?hfMuTUYncIhKBMoWTUN08+cJFzY54Bt4TgKXhq/zDyCEdNrvJYkuWBr5Itkc?=
 =?us-ascii?Q?P4J0IxWxNx5vnfmDkb01E0aSULuCvoIXxytm6NnoBoIicoA292M5wBFiFF57?=
 =?us-ascii?Q?LrDgGHs3keppJon+Zq/lcl3H41LiRvIrIROcqyRBKvfHTfFKtplA2PmptTCQ?=
 =?us-ascii?Q?45VEBmW4CXOj5tNQ7YV2Mv9E5z5ZKizL/sQMTbZBa1ciSsqyk71z0MWgYbkI?=
 =?us-ascii?Q?wN4UoMvFhCKhr3XL0LBfCsfTN6k7ODZQVVOMWD6TZ7Mrlk9X7vjxA99DFfO5?=
 =?us-ascii?Q?NWd4OqOHqhdrA8XjhE4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 07:52:44.8960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f424807d-018c-42f6-accd-08de0d522865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679
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

ras module supports error injection.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6a1a9278cd6a..566143ff9ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1597,6 +1597,27 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int amdgpu_uniras_error_inject(struct amdgpu_device *adev,
+		struct ras_inject_if *info)
+{
+	struct ras_cmd_inject_error_req inject_req;
+	struct ras_cmd_inject_error_rsp rsp;
+
+	if (!info)
+		return -EINVAL;
+
+	memset(&inject_req, 0, sizeof(inject_req));
+	inject_req.block_id = info->head.block;
+	inject_req.subblock_id = info->head.sub_block_index;
+	inject_req.address = info->address;
+	inject_req.error_type = info->head.type;
+	inject_req.instance_mask = info->instance_mask;
+	inject_req.value = info->value;
+
+	return amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__INJECT_ERROR,
+			&inject_req, sizeof(inject_req), &rsp, sizeof(rsp));
+}
+
 /* wrapper of psp_ras_trigger_error */
 int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		struct ras_inject_if *info)
@@ -1614,6 +1635,9 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 							info->head.block,
 							info->head.sub_block_index);
 
+	if (amdgpu_uniras_enabled(adev))
+		return amdgpu_uniras_error_inject(adev, info);
+
 	/* inject on guest isn't allowed, return success directly */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
-- 
2.34.1

