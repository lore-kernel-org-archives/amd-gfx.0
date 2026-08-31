Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF969C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 11:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25AD510E00D;
	Mon, 31 Aug 2026 11:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0pjuSel";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3516610E00D
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 11:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8kjjTRz2LzGc7rU+vlfIp0ACuSvadoPxBd18ZdplXRSlrw7rFOjjmZPSS/M7OQaix+OiXobftcQRS67Abx+1B/DruXsBrMI4kHeV5XrWWhQWXA/KYyP+VwOKCvKJhYm20dv7bQR4gTx7NRIHY8hz2xx4L/KnDFfoNo40CK9mcsmoB1zbP7X0TQFDhGLdZI6lLSYkmtWme4ZQ61CKFKcQ1nxWw5ofFHhRiABihNw4VR9ndMM6eEQtYq3ryU/bp5+Z5yA0NVgY7SWYdYsr/2csbSLklJ1jd7f32R+qnqD/py31AnPb92XXnXorr4pV+XY3KBnQDEejmnShS8pCKQG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7xnSxK0KJoILduThJAZLfvi++FsjmG2lFBfW/EWwk4=;
 b=aZMidt/Q1/kVerFNRe01O95joJcj4817k5KWcrfJUvN2KNwCU88pdF+YOCo0LkcwJ3Xw8ZY1Sjfvh5qjXoYzpqZ5uWBfgKe4GOFN9DGMQ/OYRcfrMXC1BaCHr6n8S2DfPyPpwdUxJH9s4HbSM9BkTQSAfl4Vx+l+zXeDWDZO+5pWdOCp6tHtXg8+rNv410npEycRj2IqP9IY29bHLMgy6HxB2rj6+CQG2Zc92uajoA4aEhe+phGkxLyzEu8fmOAJ+/IRWUwoHJBIliv8IuF/YI0M+wMR4cSH+czDMgoppaDw8xbVgDnNeXi8iPl/mMh30dNM6c7vN94KgbqNCBAVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7xnSxK0KJoILduThJAZLfvi++FsjmG2lFBfW/EWwk4=;
 b=o0pjuSel+5MocZIotA+4cVXeSgq+SLIyx4DcR4LPdU9mqr4XH9+HHGr/QSK2o4Ar3XUg0irilWu7kauMUp+OKP5evV6cQNWlzsCHYPFtg7SOgWeEiapA7UWv5MmLzLYtHY1eJNcfJXmZOaRQ9FRCJCPawkpduG5zbnrH5MeFmCM=
Received: from DS7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:8:54::21) by
 SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:26:32 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::36) by DS7PR06CA0051.outlook.office365.com
 (2603:10b6:8:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 11:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 11:26:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 06:26:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 06:26:30 -0500
Received: from chengjya-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 31 Aug 2026 06:26:29 -0500
From: Chengjun Yao <Chengjun.Yao@amd.com>
To: <alexander.deucher@amd.com>, <Yuliang.Shi@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <asad.kamal@amd.com>, <andrey.grodzovsky@amd.com>, Chengjun Yao
 <Chengjun.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: fix rmmio iounmap skipped on device removal
Date: Mon, 31 Aug 2026 19:26:23 +0800
Message-ID: <20260831112623.1475796-1-Chengjun.Yao@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 553852f2-cfeb-478f-7ff2-08df0752b51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: JuOxPlqkpeoXNvXbsluQlWopoRmdOt9GF2z9SC4VFXJoK8LY10T/A2HDkQHmI/KmdFiuCpmNn2AYYivKtoTPhv5HvDHUgGlOQ4wJwN8B13IJTHa9YNWnmd+ZRqqV6+o/YP+7kHpqa50RddaSiK2h4b0rmQ0UIKJQm72SeoxP1A4zqLRhppD85fSgGKIIvHqX39QUafqvz7Lgz8UE9kBRhIKqlfQT7u7Rm/OGF6dEpSqk9GUb1yHQnbck2U5wlSCjSzJczjJ3DWsdej5tpyPrTxcq7HZdvzWWnXAOJaKYDroqx8t6/Ci7eOO03S7OItCUqp8seBHesrHJREJFfhVC/cAN7BCsNCFhp0V78ft6y2niNNt7PG8RTgKNrnVYAL0pnS4LrDb0ZEaKSC+oNuvecjkYavYOLgzfk7uHJ2mmyRwiZdnypMhs2xtECmGdDXJKJvsEHClsn/VllY1iMJ1AYKEFBQ8tw4FU7J5sCGk7m4IbgsH0bO/kt3vBT6ud+kkD5ANxE8qM+zsFEgsD5ktKUZcn1sx2zxK8ZDO0aL+N+zeN4zD9C83d1NMQTDThWXQi9p2I8T/M3yzTf0IbUWgqfJqRNepACvf4JmP1p3Hw69q/VBCluW29jilmVG8fq3hbmVONvozLsBYlmBne6ZrwC5QgNQ/07q3V/t6wQ9pipG9YYB/70wmkPpuwTLs40jwWoDV/OusFEv9K3lPKL5894w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kw2VZW5X5NtlfBLd6QqU3eQ9qBWNLCheNFhrOZ5VYvt1YN/u7O+iI8sc0UTZ+TFi6+1vHAU6orBLy2fFCyWZVPnR1sm+7+ZhNsgQSs8GGVdMmkZSkwHZpRtinPprKWOg1u+IRr46DIphEJQBsownrIOHntjCahasZ/UDpSu4fbh7tTEPqSfnoMzZoJ966WtZSeZYOOvk7zBdb7pzDx/D1kTUDBCqT7Vx/IQdYTOD6QOV/wTK5fMEJael67Wxjb+alF6gQHjWW5cS28y3iIn54TdjGcsd04sRggUk2oFESQYg9MVWipl/WwBPzVAkSN/kJDIokjTKGEyTODViJMPNi6ADzjkUuT/McO/7F4qSSA8wCPOKPuICQfoTxUfjyi7XpY3y1kH6xBBRlhMCEiX1BXXak6p9EMmdeAANWTRhXeJzoilD5MnyHx3EVOvlF6RI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:26:31.6755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553852f2-cfeb-478f-7ff2-08df0752b51d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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

amdgpu_pci_remove() calls drm_dev_unplug() before fini_sw(), so
drm_dev_enter() is already false there and the iounmap() guarded by it
is skipped. This .remove path runs on both hot-unplug and plain rmmod,
so the 512KB rmmio BAR leaks one mapping per unload/reload.

Unmap rmmio unconditionally (guard only on non-NULL) and drop the now
unused idx.

Fixes: 62d5f9f7110a ("drm/amdgpu: Unmap MMIO mappings when device is not unplugged")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 18cfa2dbcc2dc..c175c29040274 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4343,7 +4343,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	int i, idx;
+	int i;
 	bool px;
 
 	amdgpu_device_ip_fini(adev);
@@ -4385,11 +4385,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
+	/* Unmap rmmio unconditionally; drm_dev_enter() is false after unplug */
+	if (adev->rmmio) {
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		drm_dev_exit(idx);
 	}
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
-- 
2.43.0

