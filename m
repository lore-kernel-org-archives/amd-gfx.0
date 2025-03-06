Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEC9C19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 00:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2B210E87A;
	Thu,  6 Mar 2025 00:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WDbACeNi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390ED10E87A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 00:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZoamfxHmJnyzSjBJLa1k6iG11n9McsHAlbd2nZKutNCKOIkQ4Xyv3xqpfZRPUQLOUBTpkZ30LepWmS5o4ZJct5sWYLqNGHftRbv3JvQtvizka1iN2KcmbSvZE+SA6/F88NgM9db58QFA50ivdWzPji6qfG25tOfDkUF3czp5llQezbrTK0zRuf09qcZ8nOmNAWJdpvAueQCq7oUGU+o356HAGgYqvMfCsCShV5UbChSrxREv1BW1CHav7Mr8c7KOeS+dkN2f0aMf1BOIfaH/8cWJuQll8aZsiO8wOxA5xcmrSXH9lqEuJNiRcPp8KPMUP7g0xJBTItkaE7HUZOgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhCGLV0JLftUqTFN/71XhKPUskRWG2ydI4Kv7y4QkhQ=;
 b=dLfYmAfio07dOQdcN1Q36CfNfT2uj6ShDlM9NyLwPdO0Y79VM24IfDaVmXeUQuZKFA8OkIhn0eTdy2iOZ1isIWpeobFJKt7vdFeihG/9ZBDXzjhaMhXjdpj00GTmUJXZ+/QLPIjN4Y3ND8gxB1G3mYD7GyIy2/JI/JvtuFHrWcbuQ8Ks7ICJbQklG2020GkTmAI32e8T7xUhhOM2+SccBH4oHczwWpKow1lhKJTn+ed40qM43UO7ajHIvCAAX8fy9HC9doTu7J7+uTE71ifIiqmW9Ya7HnhEDsk5coIX+V60csFQLuLQPNo1hgfBceLn7vdY/y6EzMGUEik8Aos3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhCGLV0JLftUqTFN/71XhKPUskRWG2ydI4Kv7y4QkhQ=;
 b=WDbACeNiEn1+jeyNFp/6ZdkDDGv3RkM1i6F1bIebQAuZDF07hgcEB2ZDxn/rHTbJs6xeLV8ltav7Xd3SQk/IvAx3CpFjzUM7NDqjG6HIZU3RKmyYdh358VMCcwfSNiQiNV9wQsCyS4kiRaH155U8wxyKaRXthDWm8pH8q3jt/p0=
Received: from MN2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:208:1a0::34)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 00:49:37 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::86) by MN2PR07CA0024.outlook.office365.com
 (2603:10b6:208:1a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 00:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 00:49:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 18:49:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 18:49:34 -0600
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 5 Mar 2025 18:49:33 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the race condition for draining retry fault
Date: Thu, 6 Mar 2025 08:49:32 +0800
Message-ID: <20250306004932.3219705-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c1f57c-6dd5-40ef-97a0-08dd5c48c48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+PACorQHtUuzqJiWPbEYzeABrrRJLW7/f7mvoOtd1P8ioYYNSL0wSm1ZtCoV?=
 =?us-ascii?Q?SUzsI4CcqBSe7BzvWEhap/78UWdmHYSPEGoPf+Ky7XF8o+q+teAWpBw1gTZd?=
 =?us-ascii?Q?2u6Y1b9ahgfed0Tuiv5SHXvhrl4BGqfF/9b8nesRPbzxugLkbFJafRNHyVxl?=
 =?us-ascii?Q?FE9wL5FpVKnAJmixtz3v80UzoT0vQTOQ25tnWalWfkAc+1bRksMx/CDqbRRx?=
 =?us-ascii?Q?Aq1kUwqnqlM9qjDJM51ck6s+bM480XB/yAsfpf58QUjbiRKImBttZ7lk3k5Y?=
 =?us-ascii?Q?KG1PtQH61vvvEQAu8gu0ojbWaod7vs5+7nHnd9ix88X2vnvOsrAKi4+hzge6?=
 =?us-ascii?Q?99qQcnAIabKKlaZD85Bfdhn0OE6zzOPySiFZ62baHV5duSQACUlO1+7yaudh?=
 =?us-ascii?Q?MYjT61857qI1V0Efu1vvUQlADMNMIn1uHtUy0PZOFdkmvfw4Fe/3lKJdvsNk?=
 =?us-ascii?Q?TQldDww9+7J7Y82x6dBu1F06teozSpgegcW9nb3vgV/ZjU+5sOWVDF8hMeV+?=
 =?us-ascii?Q?7Z6yebF+KUbPyxjI6ag7gMIYLxPhOwZMh5PaItN/WdQzHzofNx3WPOV3Z8J0?=
 =?us-ascii?Q?CSNAvagsiecGlOc8g0WMSHGNXQESZCar4wOofAVxF5grJs7ZHpstSllgzuOe?=
 =?us-ascii?Q?zGr691VIUXQsVcQ0bDk1Mhtn9tj501KRzHT0XX914CviFod0EbZLIRrJAfX5?=
 =?us-ascii?Q?xxmgkdz8Ggfl5fntUKO2IHFICvUHIVnNaY5XfjgnbLexQLdLmFJq0T4pmFWN?=
 =?us-ascii?Q?bVEM29vYh3XJOuJ+2yxwLPiHN39dp32vLrn27vUI/rIhBwMoMp2Lk+onULOH?=
 =?us-ascii?Q?c3g2rxNWxmbio6gMok/yZA0W30suW0NnB8M2l7r4n3G/zrlBv5A44ejKTxje?=
 =?us-ascii?Q?XCKlTxUBc+X8Qf599mbNXayIH8k9h3+8xYG1A5JZ3qgugjInXk2OWTflWkTT?=
 =?us-ascii?Q?Kh4S48v4NypJExmjKOp8lNfW5iIIhOj0IB3ireRQFho2Llipwy0p9WnLYmoX?=
 =?us-ascii?Q?El1NDLwwd/l/3dBbHGEL1RuR/g79/Xx9sjwlATpoqARqby9WC/PttNGi9OcI?=
 =?us-ascii?Q?aPcXjSyYMYsVpHVMRyNN24Aht3cNoCxmO4UNepdIHxyyxoNR7isIKKA1t6D3?=
 =?us-ascii?Q?kc7weED/+b7AT3CKyVph1KPM83LHPoBS6Ga9kBxij3oizQD0J7H8Z8n3J32W?=
 =?us-ascii?Q?C2JlxrgiqCYTQeB18NV0e+xZ05+mWIKeMB3gUwxLMIY+j/633MCJpZcHPUx7?=
 =?us-ascii?Q?OTPFtP/g9YJF0NqHkx0kWok6N9WKp2RV2HVMT4U+pau/EPtDFgWBRAXBa1LT?=
 =?us-ascii?Q?TNQkZuQQS8YwX3Ap4P9Ywd5W1c/glh7kyNpDun2/0N8OWiH+JE0hFS+nERbd?=
 =?us-ascii?Q?QEWxBFiiP8pyIb2ZTGG05TcbWcvK1e8c82JM14QO39qZcVgDc2kD6GBka5vA?=
 =?us-ascii?Q?x0QQ4xoVfgSXeBJbQkC4IsNhgmWkKK1Go3VMEwbB7iZypavriLBI7oRovpO0?=
 =?us-ascii?Q?VYM0cQl1LUiW1vE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 00:49:36.1155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c1f57c-6dd5-40ef-97a0-08dd5c48c48f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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

Issue:
In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
 has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
continues execution and reaches svm_range_from_addr. This results in
a "failed to find prange..." error, causing the page recovery to fail.

How to fix:
Move the timestamp check code under the protection of svm->lock.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d04725583f19..c99c10e247ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
-			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
-			r = 0;
-			goto out;
-		} else
-			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
-			 * to zero to avoid following ts wrap around give wrong comparing
-			 */
-			svms->checkpoint_ts[gpuidx] = 0;
-	}
-
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
+			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			r = 0;
+			goto out;
+		} else
+			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms->checkpoint_ts[gpuidx] = 0;
+	}
+
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
-- 
2.34.1

