Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5422CDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 14:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6295B10F2D0;
	Thu, 25 Jun 2026 14:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oru4CYH6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4259A10F2D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 14:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2/ZNkrbEjdaeDygeAHTV7talWEVK3v+xMXhWkXBKj1tELURNRl3rFhuRikFowUrvUxypze1AuaUdedNuhdMxBkLGrJnjpsUMrzZnCVfQAlucWfT2N5J7s8zudE0d397Oz+R2PjzMuCKUvcZHo9xpj0Ig+TTbWZncTeYXe3Huhdw+P0lvLgcRFVYpUbcYX2t+S/dY7l5ovM4ReNqPHkEXfEYo3wbE4LxdPSMowrsHsl3FE4ADN0cNKC7z/ok8BIvLeik1E8NORurb9zUyubiP5z/5Smcgpvmk0hZRkCItD/7a+8g0fWDVcUsMB4OcL8X+6WrCQOvppLyZ6Np3QwzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKXIRF+mPszLNt3IdFe5kK6fK8eicSZYr6pt25fYqoM=;
 b=hPd+4hJ5gBrrZtRur9C7u81oLOz0CyE10vjNGXHBEbbCwNMcT5o6ZEDxv8mfx4SjApOu0hglLCO81OQ34MXfosLC6zQe59RmjMSfG/joTFJ4Qd/RTg9tTIsYtKjkuY4uM9D8LkXGAOpxR/NlA2cYZ3cW+CNoOkyK54YgzHntsRXl68xFRFGwEKBM0+Pi+fr1IswcKW7D+gvVMnq6fsGEkNwoQOyz/aAF8d14UPNPvncA+CTJd/kR1NjktwLIlfBGzyXVIpjBmE4zZlQxmkrYP7CVO10LqwDab5ZcSYObW68St1Y6ZbQDJ6T3ufjxN6HX3gHRGUOA+cTQIUby9r6AIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKXIRF+mPszLNt3IdFe5kK6fK8eicSZYr6pt25fYqoM=;
 b=oru4CYH6o7V2ysUCO/b4umWUIaNvxrFsi5rqUc6csZc33XinzEC4Qoc9Khqey3b/yvjl99lJuiQ4+BLkhNJD+EWFjroRrjEg5DseQxkwzyNF2MEEvb2TjQ/gMPw8HdlJJPE67WmLYaPx2eP6tp33XXHismrD+6jCCooGRXz3k64=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 14:16:55 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::27) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 14:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 14:16:54 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 09:16:54 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Use kvmalloc_array to allocate arrays
Date: Thu, 25 Jun 2026 10:16:41 -0400
Message-ID: <20260625141641.1826100-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ff079f-6000-45cc-6437-08ded2c4690d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: X0lKAM2kQdgbAjQs72cwKr+2jepFqi4ArV62IVmq3Tlvg5M0LPxmpc7aAfE96kTWAfYaQrZmdlSc1vS7TBsya4jqgYen8ACNeU3J3PxEI7wG6UiKpj/61H6NpRK9HHuDO/CUnzMv2abQBLgTOTfI8rhXPDloipLjqj/pxVSCm5SHAoa/9Sm6B0cTWGjKnhBRjnfdwnvFMQZBbpAxWEPAviVHaCqq/nTB21zM97yxVgeKmUjIEMrZhIELsLYPy+IbeIbhYtfXX+tWEMD2L5kL0etXZb4Ut6pUffAKthggbpF+MY6fyAOYPd9oBR+zmUI3sTB4WU4+lacXQ9x0RrFIkT2Ox5QIFEJVV8PFjqHEyotauTQYFOBO5pLt7wVAqrH8GfQ7HkdmggOhXRo6h3DTtBK035avkLHv3Htk34GDyWtBmAXa8z/c0TV30TCwDNZovLMld4NayYyMm87KNJMq9RSDWuKzBJxPG8r8hGa7182H9BL5COZAI3IcGKyjkIe78h4wGnUEWDzCPvDei486qFd4QstYb+ysEwxjsv+ET3sDtd9oA13PZ16Qa0fkl4fjELus0K4I+DMBvfO/pkP9U/YRy5oRlFTX30JlUayBSiKhyzgsUMYi1rqVGCc4U0kelqztGaAlMDgoNrIUgbX2wWtk4ip2sm/1aCS/5N7+Ckjtb1nleuB70fG9g191SVofrcrwM2ySSXGaP9BUkgApSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jc3F8nGjetwhoVPv2DWxCZ9Ep+JOos1+Mm0GHjHxgqhIS4O38P4CauerNLwdjLmSfVWnxvosAXJkn2dCkw1HndQRU9y7vIzWK1um6VOpXI2MDTtk3uADLoTA2jMd5k0cUPzQjvZ7xJzngvbxHYCkNtg48zoHM1eWQEOVkjMmWbMzlRZleR4iF7t8JVmB4v2wsXg1PO1Zbq7umh0sbeHbMg4tMMMpMAz63n6OGbkNIwv/4x/fn9Qfp1wUeKNa9DMFRzhIJARxaie4RXx1Gi9rp4fvs9/yFjIPoOQQrg/fgTeLDwbCEdL20nnejOzAPfe8y00MZVjHKGlCCO90CWSrd90Om/V2IcgW0yvvvbTNAIy6wlljIPVdSm6hkIHHNjW7pTaMYV5oXtNXLFvDyYGFLuAjT946EbRbDmF3XK/a5Uuco7DWc+msRWo8hE+w379v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:16:54.9800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ff079f-6000-45cc-6437-08ded2c4690d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
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

There were a few instances in kfd_chardev.c of kvzalloc being
used to allocate memory for an array.

Switch those to kvmalloc_array, which
- is the standard way of doing this
- does a check for the mul overflowing

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ab9e53dc8deb..dbfb574f4fed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1917,13 +1917,13 @@ static int criu_checkpoint_devices(struct kfd_process *p,
 	struct kfd_criu_device_bucket *device_buckets = NULL;
 	int ret = 0, i;
 
-	device_buckets = kvzalloc(num_devices * sizeof(*device_buckets), GFP_KERNEL);
+	device_buckets = kvmalloc_array(num_devices, sizeof(*device_buckets), GFP_KERNEL);
 	if (!device_buckets) {
 		ret = -ENOMEM;
 		goto exit;
 	}
 
-	device_priv = kvzalloc(num_devices * sizeof(*device_priv), GFP_KERNEL);
+	device_priv = kvmalloc_array(num_devices, sizeof(*device_priv), GFP_KERNEL);
 	if (!device_priv) {
 		ret = -ENOMEM;
 		goto exit;
@@ -2043,17 +2043,17 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	int ret = 0, pdd_index, bo_index = 0, id;
 	void *mem;
 
-	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
+	bo_buckets = kvmalloc_array(num_bos, sizeof(*bo_buckets), GFP_KERNEL);
 	if (!bo_buckets)
 		return -ENOMEM;
 
-	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
+	bo_privs = kvmalloc_array(num_bos, sizeof(*bo_privs), GFP_KERNEL);
 	if (!bo_privs) {
 		ret = -ENOMEM;
 		goto exit;
 	}
 
-	files = kvzalloc(num_bos * sizeof(struct file *), GFP_KERNEL);
+	files = kvmalloc_array(num_bos, sizeof(struct file *), GFP_KERNEL);
 	if (!files) {
 		ret = -ENOMEM;
 		goto exit;
@@ -2584,7 +2584,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (!bo_buckets)
 		return -ENOMEM;
 
-	files = kvzalloc(args->num_bos * sizeof(struct file *), GFP_KERNEL);
+	files = kvmalloc_array(args->num_bos, sizeof(struct file *), GFP_KERNEL);
 	if (!files) {
 		ret = -ENOMEM;
 		goto exit;
-- 
2.34.1

