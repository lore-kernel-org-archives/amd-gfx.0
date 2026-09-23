Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1BEC98302
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A67A10E2B8;
	Wed, 23 Sep 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rq2JnA0Z";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C94A10E2B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCLGXdQANxOTSATztNf7ocV0sDBPEfpfuBpFIkplxLIFd1X8i2x0ACmRui44FntHkRgRmJ9yh6zCkLX/5N2JYWSKUHhz7owr9ih1ENs/q0srAieD2FHiumiCW1/pm5aGzEvpznOEH+VII8NPld2RGq6mqvw9+wHEcTfSdrG2h9sLn/SG2UpTJA/S4L7+o/ykddr10rs9sZrm4GuKQIaXckElZHZSF5Tj6UvvhEAfR29xp3vIeKZI1t0sc+cj40R9DB/qCjv7dfX1rl/z4ZnhRx0ITfn0t0WD99x0BqbQ50VucKp4bJN4MzuhtMveum688ZbWhcxqQREQk72wkwd3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uGrxW/0s59hPVWgi7ciTJ+ep2b70VUYKfXH2UF28Ug=;
 b=Y7S7L45WU+5ao83reG/YC24MD4qD3wyfqqUdbPDZafjliM21N5JrcDkqDC5Lu0LBPDBoL4Q+ubycuz6N07Of3SWjlV3D3cnI5d6YqVC0WTm07bI7Gh/kkfaPCix21GHVOqaJZtJ3CYbS/b3AlimR7zP8I/IXZQG0uM3Kr8rO21jU24m69PxRqC4G2S5vTh+DiEssosOgNKyJzSqpLhBiJ2NMu4K1GHdY0ByNDdUDB74gEUomZPZbEuh2Nevre+VIW7zRxWkJiHXV5dJQTbUJh0Wahfwlw4Uztvike74NiOLZOvJylRwu036+OROdq5i+1q8we8gU+Qwy/0O8b4ByQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uGrxW/0s59hPVWgi7ciTJ+ep2b70VUYKfXH2UF28Ug=;
 b=rq2JnA0ZKJSCopfkN7z+UJhgTg3SHZBu+Q/qsNd96L5jidDNIIPZb3TRKb/NELsJE5dEzyn+kuC8dYvSoYzViO2hu1OY4ulfIfR4IYMAjhHndXDw8Xjwq6f3wEKaNdlNw69RqrA7V2BY0l1OOORmUI0pmn9fy6xkeb5pQZiwGrQ=
Received: from PH8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:2d0::24)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 15:12:40 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::73) by PH8PR02CA0012.outlook.office365.com
 (2603:10b6:510:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Frank Min <Frank.Min@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: expose MP5 firmware version in sysfs
Date: Wed, 23 Sep 2026 11:12:21 -0400
Message-ID: <20260923151226.2778589-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbd3717-6831-4822-07a4-08df19851bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NbgsV6Erb39Lxa5abhjc213zU0rYy1IvC/botiyiTfveJFRX2rexpiVYODcBML5StgMc8o3uUitkr/OBzOjaCVp2vTWw9bTprpSNjr8HxrJibUiytMja8qglfVcPMbUHlqfJsJYwhVa/LcF3G3nyTg4RiRHFWeYxcYQ0BPnZZ+XyhiuPeoXt43KsFWdFQW3VBudCl0FmhxIyrJ4N1qvbLRx2R7snyqteJ5vMbXbq+XFNW6cu3fnLQWz7wl+zua41/pXC+hQCU2+uX49lsOk8rWtIhvpOHuRoFUcE9t0cLBv+ON6IB+qdf4Nw8RjtKlW+I1FXJTUkRQ9PWAbOhPVrhr6J2KCwScfLqBoo7ZuIzPR+7oYj0ZdYCDX2nr1myL8/tsNs6+3HoCR/W/K/9UtlFyhM6SiTaMQgaUXYqtIm9rcuOTzIAAljwRNq3ikaU1Q7uiXAzO3cd8AU+8mKOMCP2K8uicOr6qKgPfZennbbp6wtqThqTbzGPOpmfP0rc2wXuFzI4iruRdIFMEYeTAnS7YkCc9TsauWqSV18r8mAXznJFgeu/2KqrQwnwwKmTRuvmRKP/vmiWzxEZXQCNoSQkS9k5qMuiApD/ZmAeBg8FX4wfb/KoOP9cJ1T/dWKZ5ot+ms8OqlIEQh2GQz/wg9rMYe4AkBgLZYXFqcN41irm4OJVXg/dKqsh4kKPApV+dje+oco/TzgHSTSSTymic/vng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZVypgBMAPARYkX4PGBasJPCgE7qgeRyVmNXLcJEWrchc3Ou7ab4BIMITNHeirEemM89k3YXJOxLp5GUMb1yc+I+M6bNSzKUmp9VXRxxZJ4TLvR76JCy9PoXrNOe9D0vYOPeq6EAaxdTWXEOdHBK+5fcJiXZ2TbggR2rH3kCl4u9a4y4bUTaxCIoC1VRwUHC9NWfwWq9NkxiTmSFHDPdt2hV6mH1GghJcZawskKnlLC2W66z34ff0Zgpl/8AkkoitAuc4nsa+no7/99GibsVeIc/BwEFqiGx2vz5KEbMmQ0aC+uU0tP4lN5fWiV3elySGTWHLvcCcbpJAlSOX4ayRwLqAGTdf+aWgKLAS+oSIbBoFWyjEUZFnhJmbT9SaeYiH7gqEjvfG6xTFqI5GQDdhOD9CxKEhuW8XDHZq5w0VxDkzkgZDEhUb3BcLeTpJM5hi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:39.5830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbd3717-6831-4822-07a4-08df19851bbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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

From: Yang Wang <kevinyang.wang@amd.com>

Add an mp5_fw_version attribute to the fw_version sysfs group,
so userspace can read the MP5 firmware version.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-By: Frank Min<Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 31c10e3046b37..e5d47f08715f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -800,6 +800,7 @@ FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_context.bin_desc.fw_version);
 FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.fw_version);
 FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.xgmi_context.context.bin_desc.fw_version);
 FW_VERSION_ATTR(smc_fw_version, 0444, pm.fw_version);
+FW_VERSION_ATTR(mp5_fw_version, 0444, pm.mp5_fw_version);
 FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
 FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
 FW_VERSION_ATTR(vcn_fw_version, 0444, vcn.fw_version);
@@ -823,6 +824,7 @@ static struct attribute *fw_attrs[] = {
 	&dev_attr_dmcu_fw_version.attr, &dev_attr_dmcub_fw_version.attr,
 	&dev_attr_imu_fw_version.attr, &dev_attr_mes_fw_version.attr,
 	&dev_attr_mes_kiq_fw_version.attr, &dev_attr_pldm_fw_version.attr,
+	&dev_attr_mp5_fw_version.attr,
 	NULL
 };
 
-- 
2.55.0

