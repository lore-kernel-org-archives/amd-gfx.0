Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84696C5321D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 13:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377AA89321;
	Mon, 26 Aug 2024 13:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TSZCML8o";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FE289321
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 13:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW+wqwjKM6pjBMsSKHQ3a9Z4j7+jNR8Xv/MeCAT5XSPpUYssj17PeiHeA7DAa26uZ7NqSEuBmastRWuY5WlpPCNVm8D5KO4WOdhDS3kQk7FtK8OYn/mPidlq4+lJkie3QugR6LKcVPPHE2LIXcaq9435Z+bSgtHs4uTF8Av68JGe89nqF6/ShdmmKAvFqoP7qL1JbILCxdyt7qI78qTg1inn1h5i6IgjUunwy+tfNkfkD8c5Op7ivZ34YRB2uomZzAsfztUu9SUSw+e6mdyQhi6WnQoTHqljC45K+Ov1gKwYZ2ORyg5ZKtc7z3V62i2EpxXnxS9a8cU3nDYNlyYujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQYb8gLXWr1/3L46Uj94tEIS0nDWK0T+VbvFwPIlKQA=;
 b=p/5TIimrrNdwzNS5BhCtQcQ2LSng9HVhPJaZ6JKGReoGEDw6MXfmTq36BCOSyow76o9OQxsJ9Ioi//npAEVB016X2vohcs92/l9znuUMzuXrRyUZf2yw4g3FFxy2bUngK1yNA1GpQuRTwQeVK1o9Gwo7PYz6fJyVhdIwUFuz5OCDSfVkEw0NpInQUUKKyoROqyLCNWZRICKewk1TzhOEbIPqqED8i8myPATyXpAEz0puCS38ScLb2CqjT5dglreXQeIki+KUrTM/BaG/F38+SEZk+WxWvtvh2hRys8WqZw1ByPjEj04CPSlQeeP6bYm+OjkYR0tA6iKXqe1ALUr8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQYb8gLXWr1/3L46Uj94tEIS0nDWK0T+VbvFwPIlKQA=;
 b=TSZCML8oAbh9zpe8J69IYxESWCvcAN0i1Rs6pw30wc5N8bs5mAha4LyPHylFGInGizPJezM/txPYUuwkvGiNXBzNomMyoye0beilKzR3bp8kcF0Ps/MagORc6QGL/OczQSe8xqsPU7RB2Pm7pGgW9DM40HYW9DjzrNA/e5tv/A4=
Received: from MN2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:208:134::16)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 13:26:29 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::3a) by MN2PR16CA0003.outlook.office365.com
 (2603:10b6:208:134::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Mon, 26 Aug 2024 13:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 13:26:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 08:26:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/: Add missing kdoc entry in amdgpu_vm_handle_fault
 function
Date: Mon, 26 Aug 2024 18:56:11 +0530
Message-ID: <20240826132611.3331242-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: fe67f20b-7f07-46b4-25a9-08dcc5d2b04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUNmNTUwUWlwQlh3cmF0cFlzQzJPZWJWMnNKTGZ0ZXJnZXZWdUxvU3F5QjYx?=
 =?utf-8?B?SDRrdzh1Uy9qZHNSOFVsVWd6M1UrckIwSjdZZzlFa1d1NWxydjFVcHFlVFgy?=
 =?utf-8?B?RTl0alZ3TGNYZGc4bjlTSXREeEF0L0Zvd0JKSnYxWGo1RFNkTzJpNGN5L1dS?=
 =?utf-8?B?UVdRQXhXTU55Wjhwa3FOdkdMNW81SXFqdnhQdEJLbnlyNFBHUXEveUxCNTRB?=
 =?utf-8?B?d010K2hwTERoK1JaMzU3SzZSTzZ6Y0pINm5sL25wN1NNMXFEcXpFYjg1cU5F?=
 =?utf-8?B?aFVleU1abGtMeVlPbC8vcVIxKzVHdjBUSzM5ODh3dllvbThkclo1MWV5MWgv?=
 =?utf-8?B?UUhwNVFHSG95YXBZSFh3Z1Y5emQ5dG9QcUl5OHkxVVlpajYwYkY2WnZhYW55?=
 =?utf-8?B?SUVGc09QM2lId25haXdpdjZPTS9KaVgxc0F1WU1TWVl1MVhOUW45dDAxU3pv?=
 =?utf-8?B?Uk9ENGxISDhqb05lN1N0VVZpZjBnb1I0VGpwa3l3YnNzQWt1WkpNcnZ2ZnU1?=
 =?utf-8?B?cUU5amVXdkFBQ2RNUS9IcVF4OHpMK2ZQNVYwN1QySm1RTWlML0ViRHBwQlBF?=
 =?utf-8?B?VDJJYTB3bzJUTUxQd0c0REhRalE5TXpyMHJsTFpkdmU0RjhMTlRQbGtrd1Rr?=
 =?utf-8?B?N0VCWW10ekFKSlJnRmtKbmFvZmFsOVBmbmEzTkc0NGNta3NtTExVOHBYMGF3?=
 =?utf-8?B?bjIvR3FXN09XLy8zclRuV3RJcm9vRTBsSm5oZG9teXhyL1A5cmRvdlhybEo5?=
 =?utf-8?B?K2l6eC9EZnlGSEJ5dmEwSmo4MXBnZ3h1cGlDdWllUTFaVkxQa25RVUdwRXh4?=
 =?utf-8?B?eDN1QlpGcVVmODZwVXZ3RlN3TGN1dzBaeXBMYUZIU3czYzRpQktmNlllOHJw?=
 =?utf-8?B?T3ZKQVdvV0ViNGxrb2dFNmlzWXFVTmZRa094NUFGNW9IU3RYdTJwSmNPUnp4?=
 =?utf-8?B?cDM2Mk1BTVdBdm9vRi9EZHpySk53TDN1SjEvYzhVcUN4RkVXVTVsd2M4Vmho?=
 =?utf-8?B?RFJOa0tHNitJZWJQZW9TcTdBNlpXc2Y2NTZCdzhtNFZWTCtvbUg2QTRUSUdI?=
 =?utf-8?B?a1RNQkRGYjdsUGJ6L3BHbTM5N211SEhWZTY2QkZ1NlhpLy9aQWxaRWxLN0NP?=
 =?utf-8?B?NjFocFJpaEJpcDN5QTdpM05mMDdGM0RLcHVmLzEzdGYyd2RXWm84NXZLQ3Vw?=
 =?utf-8?B?TDRiMnFFNVpaSk1tdDA4emxoaTB5Vm54ZmI1TWQ5Mlc4N0VISDlKM0dqdDhn?=
 =?utf-8?B?MmxKcXUwc1JiWjRXQnFhbFUxaWdQSDdQSGlYUnZmUkVHWk5VU29LcEhGUlpm?=
 =?utf-8?B?cks5cGJCT3ZRb2RaNzZBL0FEQUhHUkZ2ZU5vbUNvK0NtbXhHcU15Zkt3OUg0?=
 =?utf-8?B?QSsxMEpueUxkZW5iRW9SR2JSUGs4ZWFNMTRUcm5MOGpwS2R5TTZJemY2ZEl4?=
 =?utf-8?B?bGJJUy9wUW5YeXJjWU1FZkxYa3VDMFp4UWJGVnF0TmNrV2lMMzJpTkpkNUh2?=
 =?utf-8?B?ZDZCTnlJZktnVXp0dk9EZWtwM3FWSWdhRkgxVXpZcnNhTTJ1ejhGM0NUOG9G?=
 =?utf-8?B?QkVHNW1JMXo0VGhlTUN1bTkxQ051V29OVEhyM0hKbXRTcnFXZ0srczIxYU1F?=
 =?utf-8?B?UE54NjVkTGYxSElGTXVJT3E4RW9DSGhNcVQzZmNFci9OL2htdDZIQ3JqVldr?=
 =?utf-8?B?Njl0K2JGOUVIN3lEcjNoVyt1cnBmb0tDdGkvRGU0c2c5UzF4N3FHMjY5YjBq?=
 =?utf-8?B?VEtRTWhEK1QvK01vNGJaYXNRRElWMHNJWUxDcXhrbDBBRFpCZlBWRk5MSzJa?=
 =?utf-8?B?bkRPL3BQdERoWUl4Z21rbEtNbmdzZjB5RmxPUjV0Rkltc1J5M0MyeE5ZWEpy?=
 =?utf-8?B?bVMwdnNVMHpvZ3RHQnFTZmFVZkpIdG9jb2FzaEpveFdQY3NqN2c2bkZJWmgy?=
 =?utf-8?Q?4e7fqn35jyLSAFrH4qORzeJqMN2DXaU+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:26:27.0570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe67f20b-7f07-46b4-25a9-08dcc5d2b04c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
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

This commit adds a description for the 'ts' parameter in the
amdgpu_vm_handle_fault function's comment block.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2781: warning: Function parameter or struct member 'ts' not described in 'amdgpu_vm_handle_fault'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ad2e469548c9..0fa165e8fb40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2766,6 +2766,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
  * @pasid: PASID of the VM
+ * @ts: Timestamp of the fault
  * @vmid: VMID, only used for GFX 9.4.3.
  * @node_id: Node_id received in IH cookie. Only applicable for
  *           GFX 9.4.3.
-- 
2.34.1

