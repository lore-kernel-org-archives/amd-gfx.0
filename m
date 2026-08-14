Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A7FC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 06:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2238D10E0CE;
	Fri, 14 Aug 2026 06:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IsQqmYOe";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B1710E0CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 06:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sU/DoS5G6aP2XguOeh7yAN8KN+f9C115hU5GOkIbj0WuAMNSWWOIbMamzeVMfkJvuoh0jfvuOH88o5SHpQrc8YXKkoXJjTIT5YBxckvexLhhD0/0J4H2VYlrtIEWkNLkbUz8Lc4b6hsBSAXCRdy+ARAbxN3zkqBQC18h3YWfqZaspWaV+AJTp2Mv+eTLWEyNY4RTj/pkBL4zA0OtHYABu4U3/e9SobTLP18mXNu1eJVPx3LTU8yPmA7MKxEQqTizboEaqMHnLCA0sDQwScSXko/VOFq1PwxuOIr/b5q9BdFUAzWtzjhT60THLXicfLDzzju9hX2ZtZGTEDgvsOdaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5z4ylwMDdlcJrzT1bv5KfyCz9VCmy9rC1GQv+9QR6Q=;
 b=SKLE/82yNwv4JNeXSqNL7t/JMPUTP/AhzPGOElTbrWXlokMiiTVrW4g2WOYd27OUfTKUhIURRc3xvGJN0IfVBJ/CFDUlryGrmI3KmQ+JWOIGNPhYZHpf+osz6FbhVVVkH4yf3uuWet4DpNZ3DD2HkpXFM2o4eNBeuKJryTyk/2r6tvGDwGe5sgGZcDJ7Vlr4Ase2NQauJI78SR5jPlChXF/7abeUcGbtpEwzMPZvQcK+CnsclM8zPFfCWBKzhPEOlNA6FAnxiTTPrnGQu9cQuN0bgHMXkG8qKdCzaEaGRO6sEukOGvPukXMjk8iLG6u/PqZPZqNTWr/mFm4WyOH0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5z4ylwMDdlcJrzT1bv5KfyCz9VCmy9rC1GQv+9QR6Q=;
 b=IsQqmYOe4kyYBa1LzGc+cDVgZilB6UbyAz028MfJ4TcK3GuvcqzNBIBqo2U3P/I5qxgwnS10oGR/7+mS2iaTKgtWsuGg6fWVbCt9iovNvZ+O+sHixou1anGILy4jqGqROGAd/8RHjRQef+ZJks4H7Mgg7spy6nsTia2kPYpZNLE=
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 06:22:56 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::3f) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 06:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 06:22:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 01:22:54 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: implement support for query status
Date: Fri, 14 Aug 2026 14:22:42 +0800
Message-ID: <20260814062242.407455-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814062242.407455-1-Prike.Liang@amd.com>
References: <20260814062242.407455-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: cf006429-26b4-4c49-fd31-08def9cc7ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: lznkcTOXJNE9EAeaJAWqUFVYVqXM64i/yFdQcVOULT1eZFdC5X3eXZi5Mbogah9xBCtpZRB7QVWiZi4THmcCfD5lPyYnoV3HRedb+ijhgmLWNsaB4yGcTDb0TQjKLzzCARijVOACygR3qXpxxtonSnwVScYOR/fO3aub9mO8zOYReLQzR4bxwbxvLE6xm6WRpnE9FEmeicN+ZSBXKIPVdB7l0IdHyjh9dSe7bboGnyEM1zRTWoBBr4clIVm4/PzZ5YdKJqWtkYnaY11r3EcM0cmilBBh7cU7RhL0r32FgmqtXhqyfWoziIYxoBcx11lNzGEhg4WuxdacWNYoNlqMA3GOfUqP4X9P6yWK+tRD/FBKQicxNcqvHHfPwihhjZsVTb2c3BqZqr3PJnj2jhOTTUb6AA5hN2lyHsU9Yi+oPjumx6536Jc0txUWlt4yAvYdFq2DhJisaSVT+1DcwJO96XhbKY14eHOLmdV+/tDEgfXOvkPEMBftiLxXJ8PbItm1X0fASE7IY2EOys/pSx6SHYtI/6tdlRQjAnK/z/TVDuGLGiFBK3LsYIwv1mBFUD0iNz5XsLvVJE/XGPOZZ/8zYThspEAeE1iv34taPT559fjBBx8BA1r2pqnR5Se8ti5wmz9plW6iRLK5dOSiyFMsyTMFYG3KpS6eEJBckagPoIS5EXyPLdGI8xF8mzD0psYQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qW9HhpLsXwbtv05LsHSIlE3bBaFXMiFwG2lAbdlb8CRqnR2V4xAr1hA5KZL19e2AsqWWPR0hSheQ+MBiW8M9cNgGYGQ9JnU0X2w+oh+6HO5CGCHzfyb9mW43KtdHBAco2prF3lP8Jvh7YjdfsKQgwdbsJU8lRFAu9MopaLT4WC+6MwPRapGx0nINWIGKT3Og+agjUiwziOf+m07TAxnQbd8y+jjNH14A6k0xCj5F7bJwdwmmHK+lu+zYGC52pr65wdIKP7S54UZKQqKBnBnsT6tkIx5EI5+5sKBp2Q2UN7sL3SQRCaARgmYdpTywA8S6/mdagpD/M2L/ktswJ3HPySKehLpnwHtHZO68bnO/D9KXegW93GXL+//OBoSM/4Sv/UyFKMhhPKFeLd0p2w2SmR2DshPTXL7SU9MtYlLW7GGZ9yT+dwXTa3RI/LCFvepT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 06:22:56.2500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf006429-26b4-4c49-fd31-08def9cc7ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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

From: Alex Deucher <alexander.deucher@amd.com>

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bcfbd7213dd6..911b4abfd126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -799,6 +799,33 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id = args->in.queue_id;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
+	if (!queue) {
+		dev_dbg(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -914,6 +941,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_dbg_driver(dev, "Failed to query usermode queue status\n");
+		break;
+
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
-- 
2.34.1

