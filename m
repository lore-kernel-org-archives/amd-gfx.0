Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30518E64AB3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 14:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F5610EA2F;
	Tue,  3 Dec 2024 14:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xj95wLgh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DABF10EA2E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 14:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WacWHsfcVEDxK9P7u22lY/E+Nr8rl3/HvQ6snysJJg951LpqhVNzu/8oEnZ00kqtC5L55DZ3WgLi8mbmYWVjrC/X8BOh/EAwrmsafcI3dCLfMiecYNvZ0h7nV6htZ6bnUIr5dlHdzkaxy3rpoKKz81YjWlAruvzrhqryGPZBf03sB+YKwnohv1GPKkV331pp7z/yv0PaJ9IpvAVkwQZGG5Fo/3w71ENJomLqx/pm/vnt30OjR1utY+APM+Sh1lUq39oPnDO2RH09fT3Hoy7I3rsCRgn4AyHiYKFoGizxgsxERUIGNalW16jigV6WlKnPgyJs29WDFL+oPEV7dhHCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cerz78mqGwgJ8SDG7nbuvFEpP/t9/GMBk20mSrzK1G4=;
 b=rQ5Wii65Dd5l8DdAhw15DuuFMHTdDJqFlTmXEWCNU3Gx/ZBSeAQmeqThlf0fEyDoJTYapeoeFCPcElsC5xcsw4hFxUEb0B2QKvnMWf+JPH2wdveoGkHKbhCJgc1Mvc5HbyXjpH7BllrWvKIYvzbrBdmC5QbwVfKUwqVo1ckNXRrXRTpGV7PPhLBMn27L6BCKCUFEqgBKwA9I7ISRe92ZCPldX+mfyIW48VZoQVzKCuLK/rWRBIeyxwFZ7A5CMW/qcgMGALVOjA27GQ89XXb5aid+zOx76sOSRqOlL3XtaiRR/LxuLVMlhtE1myCfWN7AkM/sfl6UEsNeY01XM7xXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cerz78mqGwgJ8SDG7nbuvFEpP/t9/GMBk20mSrzK1G4=;
 b=xj95wLghYD1Ivt8CZq0zC7EkPY/GfAc1hB767Pr9/lDQiTjUiirvb/r1h+Mb35fr20xHWF0u13DvT9M5OVMOQkU7nXHVcn5t9wBGgCopDXbOnlODmsJMvGvb2+z2FmgVeDrjHFzsjiGEoHRK/XthG1IUcHdulpea0dK7IY/iMfM=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:31:02 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::f) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:31:01 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 08:31:00 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <mukul.joshi@amd.com>, <Felix.Kuehling@amd.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: pause autosuspend when creating pdd
Date: Tue, 3 Dec 2024 09:30:46 -0500
Message-ID: <20241203143046.3643-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203143046.3643-1-Yunxiang.Li@amd.com>
References: <20241203143046.3643-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1e9aad-3731-499d-e3ff-08dd13a71cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RG+fr87q11vJ83I+aW2ezBzoQDOs4CqxmxqKK6lO2X+VqN0MQQn+kPnXJfiL?=
 =?us-ascii?Q?hzQQ+yLwmKdmYxuycHn06gmssaaWr548VUtzeWz+2Dtvf6QamAuPYypn4e+A?=
 =?us-ascii?Q?mcscj5+DfHnFhRFgw3pORrbkEd/l0+mzHUz0kyU+asuWoyfHBN1P8pJHz/tF?=
 =?us-ascii?Q?xT7RrwlvrLjI+uEn7/nsg+3b1SRL008YQEsYIoV/pQb1cEI2awX/p21+FQt8?=
 =?us-ascii?Q?fvmAnHfRnsTcUlwV96kQ6xDDr1dum/Ub+GASE0TZbpDN3S921jBLxFetL/Hl?=
 =?us-ascii?Q?Q3KXzynJb7NC0wlMLOJahyvoKUmg0PXXc1v/T3FL141xqdRimufAJ/kEX/6v?=
 =?us-ascii?Q?oF3mguhUAJzvAvcMzHtM10+BwuriPRRalfjeq8YR59/Og6SWGDsNj52lWHg9?=
 =?us-ascii?Q?kLVDNRD0GknwzJpDx0XC5hOpLe3Jj+Lwf9tHLX1eVfC9ElveCfq9x7pNju/n?=
 =?us-ascii?Q?2tlcWE/I7BnwHvg8l8papVGSYs1xS040SsXmN8gg9UG3rAMic4SSTuqooL0Q?=
 =?us-ascii?Q?GWyVTAHlnVSHwPCll2IN1dDArJ6vK0fW0eyT0PnArKaCg0ofmGNWTTbRR9sJ?=
 =?us-ascii?Q?WwgR7YbTJwvyvDjeQDN0qsoA7Z7lN8Ax/bkUuVNraVkRPYDj5go0/oHPVq5N?=
 =?us-ascii?Q?5zt+dTGUMNfTxhn7f5BySN1eQDHjfWZzaXN+7my9yjq67sKHZUWHRXIHMNfP?=
 =?us-ascii?Q?pVmXEQAlWljv4k695Gs/XRZlB9vfq7rKAbX2XKWLbu5oFc+Wg63ieYzqP3pS?=
 =?us-ascii?Q?vONUt3L0AF1LGFfpbYk3LlYcWgYftIEtN7BskZ3qwJ2rqzS6Vb/0Kb7sgr1/?=
 =?us-ascii?Q?mANSHlD6e0GoOeegvFoOVbjoEcZYbddOhMHx1fBDzl+RcA726FC6xqSRWaZn?=
 =?us-ascii?Q?KL7bS4iRihMksXqmYFcjAq3hmilVhcUE4s5eECnSDSjU7hpwPfK/8yHObOZJ?=
 =?us-ascii?Q?7CCnIwoEnh62bu/BhtvRDQ4EpJcN5pTPa1ROyTErUgs3Dm5Qtq3zjfQye0/t?=
 =?us-ascii?Q?RJFaDa6oybGUNsWpwkXsxcm0G3klwZmrgixMD9rir8//6NKrVGqSznxjBJMK?=
 =?us-ascii?Q?dopbFfOHP5vTaY9NlNf28D51k4Mi+fbAd88v7kXFI/EmDpoB8b1iJL/DV6fy?=
 =?us-ascii?Q?pmO4Gtb/iWcUDGgXGASI8fBqr5QC9X/p7w18bG2E8xWRpfKHgjmyyuAqZKqW?=
 =?us-ascii?Q?wNlqsZOcYXGswLEVfEpfeiy51TOeTOJKllwEhXHMwKShYjngmVB5Yttjx9NO?=
 =?us-ascii?Q?ngxHErtzExw9W0bNPfr8rHtIulr3udW5zew76G/OqZGk4WGAeIeVkHPEEbA5?=
 =?us-ascii?Q?BTo8UES+buwB+qSYNrl/5adCs1IAMNi/m8geXFUM6Gslkc4PWx348DgOn4Lb?=
 =?us-ascii?Q?bex3fqIWVZFyVuSxWhI+rtu5ctecaUI8TM9CtiJ5Jpum3wgQH02tddEZ4wbV?=
 =?us-ascii?Q?jeDizdDI6j1M4RR6iJKcLLdgrKYFHxUc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:31:01.9092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1e9aad-3731-499d-e3ff-08dd13a71cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
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

When using MES creating a pdd will require talking to the GPU to setup
the relevant context. The code here forgot to wake up the GPU in case it
was in suspend, this causes KVM to EFAULT for passthrough GPU for
example. This issue can be masked if the GPU was woken up by other
things (e.g. opening the KMS node) first and have not yet gone to sleep.

Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v3: remove the cleanup in kfd_bind_process_to_device and document why
this issue doesn't always happen

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 555a892fcf963..c81c020af75d1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1635,12 +1635,19 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	atomic64_set(&pdd->evict_duration_counter, 0);
 
 	if (dev->kfd->shared_resources.enable_mes) {
+		retval = pm_runtime_resume_and_get(bdev);
+		if (retval < 0) {
+			pr_err("failed to stop autosuspend\n");
+			goto err_free_pdd;
+		}
 		retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
 						AMDGPU_MES_PROC_CTX_SIZE,
 						&pdd->proc_ctx_bo,
 						&pdd->proc_ctx_gpu_addr,
 						&pdd->proc_ctx_cpu_ptr,
 						false);
+		pm_runtime_mark_last_busy(bdev);
+		pm_runtime_put_autosuspend(bdev);
 		if (retval) {
 			dev_err(bdev,
 				"failed to allocate process context bo\n");
-- 
2.34.1

