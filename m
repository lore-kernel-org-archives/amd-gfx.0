Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBC1F588C4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB02010E662;
	Mon, 20 Apr 2026 13:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tAf6V6AT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B0F10E62B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 13:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFHVRId2dHdto1bZGeEl044qqyvzvfYTzBNCbw7HL2zebzCt7FGhW/0yMIJ4gwL4d+eLZUYcywbtF4HSLdzw0JBl26F5yrPVDUOlUdywOltTzEvmgMwJYRZXQP9tUdwlhhMOJZ6TWSbFl/GpPuU56ffvy8B1yYQH9jJjTVkfiV4KZORAkH5hh6Ymu3cD+LTd4CRqSmoCNj5Mag9uq59LDTG+FfEnuS3T8fyt7oS/+6GfcPls2Psq2ePvOFbEg2uMKC+FfeORI7ZMF8ql10p/MziAQortMWdh/mqNLKgzbNPxSuQcj56QEz5fiKv4yaL20lgsJTQZc/pApStSRTcFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x00Wgr1wReXGgS4/9xzqkwn5KNjwJlBpz+vU+fB4Fkg=;
 b=HufWWBzuTA79dx5NKpamjbc+dfeQiJgBCXisIiF69DHEIiVZAroFKVInS1dijcM59epsgK0U2go+LFwOoQR1QUA1VRgFTRrtXJRF9nu9TjRec5tOZgOg/lM3LEa+C9DlGgQ3MTErlpV8+SiS1Sa32gadvPQNDGOH0TFHL98JmM/yXTTU/AImwDqFAAu12qf5TSLDMMu688tA0Mi++pcgXt/THajX7P8QOawGFm9/EjYGJxuUFzJzY8+okPBP5g3a021yH8BIA3j6A1dvPvCGxbpoZUoGqsLO4t8pvvm+B0rljAmg0jkwMetOKqOJtre4IuDOFiTw4vdidVDmH8Cu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x00Wgr1wReXGgS4/9xzqkwn5KNjwJlBpz+vU+fB4Fkg=;
 b=tAf6V6ATG8Za/7/wd9ytT7ZHvnv8tYdWaUfRIMJUGIGEqDkCfVV2uNkyw5cL+BkYuaK8IGhQ43N1T6wfjIA/t6UY1QaeKVuJuuRk6TT75ANH4fAsvhyoWBolVwcrrxCaB+Oj9DzJyQX3DebhNC9tNYqWBJR5JCzyigIRvUyjBgI=
Received: from BYAPR08CA0009.namprd08.prod.outlook.com (2603:10b6:a03:100::22)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 13:38:02 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::9d) by BYAPR08CA0009.outlook.office365.com
 (2603:10b6:a03:100::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:38:02 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:38:01 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Kent.Russell@amd.com>, <Andrew.Martin@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Move
 amdgpu_device_check_iommu_direct_map() earlier
Date: Mon, 20 Apr 2026 09:37:04 -0400
Message-ID: <20260420133705.3721315-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420133705.3721315-1-Philip.Yang@amd.com>
References: <20260420133705.3721315-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e1e2b0-c572-44db-482b-08de9ee20b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: fc8+NxmEW5OGURLVd2JONEnB23pqJCL7eFdUejszoaSktQ7h6C7Ypo67EOILZaoVXRFniYWvk9PgC7c31IhWAay4r7t2R78lm3ifTPb1VUoefWIILse2Rla38fxRa3c3MZ1a3pzz3DqGJqtYE6DSSV9w46ev760sf8hwulfgsoUEBL04WByQ2a1GM7XEknsCggNsPXxOhgvOZncdjUxR+WW6x97KpToTvCVo2D0cIr/xCtsKnbCc6FfuDzYjA1sMo3nK2ojbHXyK3HFjpWa/wqbADz2RH3ALXZN7Wxwzm+wkAXTGao9NXhzvNgsDjUz54DdGumINKHjVw77uk6N2149S5SH5RZZXFl9AIzlr3cc4pTRwSKLF1iAXVxh4L7d+sp58aHcHQP8k4FtRJSGrkeWtsJnCnPIStxtIFr/udOV9hoHQuGA8T9x/iB+bKpyAUe8CFElcbvQES5/gBh3Tq4N3lElyGlyKxxIs/LeV8q+NMxa8KIt2NtvCsdIrNH671KUjiz4z0tfb43hkU7CLzgkuos+iz8/8TmuIQs2TO43P/nI8bzAUww5pYbj1Uy9dgKrviLwEs+K9BwhT4qHZkj09UzOX5sifsrhJe0VY7CnqFJT15Zv4X9wtxaVoypUhl3pI474YXizE7ZFe7FZ258JjN5ruw//6mKOED6Q/KU4tQLmSDith/pkstQcBk1sTwl4YkR+RQshkMOu2tetB4kqL6FHM/k93lN+b5hbdwmgV+NRcSsLppF54xnCdi4vvoaRcgXjSh31UQkxHkRtqBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6mvqvgxSLF0nMsL8GOwp8p0YTXgdCJgrou25bSOBF+wfJCmC+R2mDwKV5b8Vwk12GqH6SojdNpZ4GQkG2JCRTRYr8nGAEZOLCs/fFjmWw8PddZZ0gOxpjRRBDkbdCadqVkeYt9Gxbtpm1ZR10AxaCzyWAinxULHUQA22EYCgSEeQUabl2OeJ3+/3myX9bt4iqs2BcH5ZvfUFQ9LUuRlXgUo0qeDjTCtGnlbs3vVy8ZOq6Gc5StSNlb/RAJ5kXEt7oYmWt3b7EdmqLTighvxAelx3hW6cXDzVQdQGlXAbSrOAMrNn7AG3SiKYdim3cBBX6+hinE4Dd5Cllt+vY5d8BtQq5mCBeV+tD5U9YcsDdUXQbT+oq3uRTj4/e5urokng8KfJeEul2zm2e/34FSCdTVslBGrmF0tA48dhY4yBVmWuEZnjP86qbWzGvr5FPF7c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:38:02.4507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e1e2b0-c572-44db-482b-08de9ee20b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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

So device init ram_is_direct_mapped is available when gmc_funcs are selected
during IP early init.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bc7e96b58d3f..b139475f65cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3860,6 +3860,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * completed before the need for a different level is detected.
 	 */
 	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
+
+	amdgpu_device_check_iommu_direct_map(adev);
+
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
@@ -4117,8 +4120,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
-	amdgpu_device_check_iommu_direct_map(adev);
-
 	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
 	r = register_pm_notifier(&adev->pm_nb);
 	if (r)
-- 
2.50.1

