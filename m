Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39CFEDA00
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 18:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CE110E361;
	Tue, 17 Mar 2026 18:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jczgPlof";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C1110E361
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 18:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZusGfTkIjNUzjNkSo+L+ni0MWWXVqWlnCHsurqbxrgd4giE91XqOjw8xow0nlfakWATPRJL9v+roWltmYKFmnUz7Px7S1Ue0WjJp8oeKT1y8iJhwiYlY0gXueTiCny6R+Wx8l0p97OCiUwsZCjU12zqINJ8QQZEEqlUYsLk20ZbdCkFrOp7mvf6kU0FIOmd1Jk14YBzC6Bj+Xmfp6V77z5QN+68K1C4sfR4HdQAF3sm5fDoE2p94KSoIVQqSlhuUG8Ex99V0y++ABfPAta87+FxiSPGJGOvkuF0ziM4QNXsUxTcG3hkIohip9Ad/FQUTp1PUTrxjEYqjJmXspSm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWbW2gJxUw8QY1E5LPZXNhXbXMZiLIHWHvVbZe5SCcA=;
 b=sb57H4pQvT79HucR3DqPQCC/MuTZ5YcT/3UcrIYu+wBDzS8I4XmFkY77w3ii1qTfGuqtqUd/S8BzYk+yUE8btFu5VeVhijP04iraAp+VCl1jnEVynU3YIV+mATsNn92agcFdzNO9KIqkiARjmQ/aJ1vliw5/iCp1wa/gVv47nNCVp9oVMMqbNhYeph6zNSXy5c4yMPH8OmSKk2ukD7CgBKx1erJGnCoTJvH1eQMcD5kvN80/rW0y/Ps7N0OI/fublVWYVt8TEN2YpdEilT9cKTTAbpdwYEJs9eu8Qx44u8j/OV2MoROa/ezFM5Ob8dQtO+6oPdv5zmrO4/bC5rwZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWbW2gJxUw8QY1E5LPZXNhXbXMZiLIHWHvVbZe5SCcA=;
 b=jczgPlof4w53leZo1PZpyE3w0bCgA7eHglDbtiFAuw7ty9qnEh47ypLGGCDQWffmYTRh2gT4BB/3nXirgjBjr7I6SFwZSGvl73n6ddtd3/JS1gD5MEl1/7y7LSbYWK1MWEncegaWbFoYvZZsLa4XKEKsTGqhwTYtlF7PQVf4X+c=
Received: from CH0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:b0::23)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 18:39:55 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::68) by CH0PR03CA0018.outlook.office365.com
 (2603:10b6:610:b0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 18:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:39:55 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:39:54 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <ruijing.dong@amd.com>, <leo.liu@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix strsep() corrupting lockup_timeout on
 multi-GPU (v2)
Date: Tue, 17 Mar 2026 14:39:43 -0400
Message-ID: <20260317183943.43849-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.49.0.593.gd86a19f485
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: d204e0db-0725-4f5a-7bf8-08de84549594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: K3yoYPsHzVOPPBCwinvhnRKlxwH4brfXWSYdNa7eEkcGHjODx4RIDKH3xt4zElKjWu+gwCQjVXYYRNl7PTwa6qzosnJNg9aDNBJIM9qH07Ic0LDmzcNToHE3pigwhA7ywfsEGL1WNwDgf6v5NjeGh1WN7IAUFyqMYME/Vsx2DCgwR4zL4/H1IWop1191yjNPLh5HK0BJysWZRuds6pma5Y26uwzR2MkYzDm3QRBXSte+MMF3Kk6E7HxMgPFP3oBXhghigNouXQtTxqaCvVFrtwirLpDgubTbPcXgAw9CyhcnjPFTv6cz3brH8zASVcRhf3ArnxzvFEjfx5g/05/CK8OLlVDLvEVyZR+ycEGmS7EqZWwpm0u/nxBA6rdXNyNfmtFReFjJ2yO/GozIt0NdqvEMfmLgXy5gDs/PCakWnQqoIJud1scXIycCKu+nU+41akv92zi9HcJX7xo7kcn4DX4ZLbTh/rTZ4jogt+PuXS9ikpEx1Z5mslartQSuX546targtiahJ9jZsyg5qG0zVvBXD7dsFJJvqXOgmzpFlBfIGHB2WBg6xxg4Y7+UTjdp8+mbEs/DkBaF8iTaHaxFzomDicuGLPZk/vk9svC9h2443xyYvsI90sLETDzQEqikIhozjzUwPLCJT558cQlCQT3N1QeIdjSn3r8xIMuRwvHCymSZHrwih2gGIqrSGVlHhFj5vCMPSTC91y9z/CwRkgKW3yv+GPttCiiCD+FnCxv3MTrb55Ht/k7GfhWIw5kWXVFnDJdM8mwzfRQ2fCxFmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 43i2vkvWSH7LgQX8PkkZucZ2hdSg0KfpG+tj9lNdMAtB1aTDGT++FCe3QeIRQfXSbLrYHF4rRKbn9s50mXNxylw+vpHIgo+/79LAtOiiTHRsdbQJ1N76PCmaLX1qoGpgNlTxnd568sP2RYIF4P1BXnROfOHRniAKe6Jsp+be/+tK82rzaOOMgNquLupNYWnX71mYAJBVi4iV2CF1cIciYPdZsMwidV0LmhE+SLSGpmJpikH2m4PYMdl8vqByO657OOdj1H97aabYJ0c/nb+jxT2ZAViDUqHgImv+KeIy3FPdCAXLWTvhyaRYjIt+Cd45cf0O/UzK+x+Nc4xiL94822WfLwa0Msm9xaxbL+5Jnb0N/g/d6/5vr6f/Xop1yk6CaIAgmW6qo98zSitWk51v76khsu13qgsiTFLrx8K7x+rOlWhP6vI8IulhC6u0dfDf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:39:55.4286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d204e0db-0725-4f5a-7bf8-08de84549594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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

amdgpu_device_get_job_timeout_settings() passes a pointer directly
to the global amdgpu_lockup_timeout[] buffer into strsep().
strsep() destructively replaces delimiter characters with '\0'
in-place.

On multi-GPU systems, this function is called once per device.
When a multi-value setting like "0,0,0,-1" is used, the first
GPU's call transforms the global buffer into "0\00\00\0-1". The
second GPU then sees only "0" (terminated at the first '\0'),
parses a single value, hits the single-value fallthrough
(index == 1), and applies timeout=0 to all rings — causing
immediate false job timeouts.

Fix this by using kstrdup() to make a local copy before calling
strsep(), so the global module parameter buffer remains intact
across calls. A separate pointer is kept to the allocation start
since strsep() advances the working pointer to NULL by the end
of parsing.

v2: wrap commit message to 72 columns, add Assisted-by tag.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dcae77b6c272..97ebcc5bb763 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3498,7 +3498,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 {
-	char *input = amdgpu_lockup_timeout;
+	char *input, *input_copy;
 	char *timeout_setting = NULL;
 	int index = 0;
 	long timeout;
@@ -3508,14 +3508,25 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
 		adev->video_timeout = msecs_to_jiffies(2000);
 
-	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
+	if (!strnlen(amdgpu_lockup_timeout, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
 		return 0;
 
+	/*
+	 * strsep() destructively modifies its input by replacing delimiters
+	 * with '\0'. Make a local copy so the global module parameter buffer
+	 * remains intact for multi-GPU systems where this function is called
+	 * once per device.
+	 */
+	input = kstrdup(amdgpu_lockup_timeout, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+	input_copy = input;
+
 	while ((timeout_setting = strsep(&input, ",")) &&
 	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		ret = kstrtol(timeout_setting, 0, &timeout);
 		if (ret)
-			return ret;
+			goto out_free;
 
 		if (timeout == 0) {
 			index++;
@@ -3551,6 +3562,8 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 		adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
 			adev->video_timeout = timeout;
 
+out_free:
+	kfree(input_copy);
 	return ret;
 }
 
-- 
2.49.0.593.gd86a19f485

