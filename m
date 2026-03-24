Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A82FEC11A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C920A10E168;
	Tue, 24 Mar 2026 21:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VXLj99rx";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD30310E168
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YY05kDep/N/k5D59uloqJMl896JfD4o9UulzlNOf9kFDc20nZ4rZSvZKhuiFYTnlNRSFippW9Agw1vlWVNr7KsOPsAfTibbJ9gM0doH8AQHDPPrFA+6Zhbghb55c3FlR5BP9uujXAHv/AGKOFNbZlPyuG8kX0SY2b0Qj3gINvhDuCmTWefkXaL5uBSb2pCxddphnMEx/veJoKTKg6BxKBdY7qoRTNoBJQEC479gQqlBUL1uboyRRboUetkTcNctc8019rQi2Yv+UpZqkmUgX9vDMFhc0SF/h5i9jbOb9J8fpbTcB9b08My0BsA7H35rGHdz+bjCJgdD0YPuxwOPlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsZkGoiGXeSnWayJg12SRtGTXXDCdgVXagUbQCdUS74=;
 b=olNz/PsBsIVOf+y/QL/p5EsBL1S1a6I1V9f6iLi8NZ9L1iKeEm7W/OxE6FjbfkI53GRal/kH0eJQ6UmE5E+H46S+uk4JYiltJj+oBYIoJ3SNncoS5HHX9d9SExqk3e01VVe2a2+FUNqMQox1xl27MoVlA2vbEduKQzcHUdonIYGwIBTTWo3nX7GNzMxvnCOFqUiXhNOmauSjNpZlF0aMQk00YL92Je7A4JIyBMyjdUxpGQNfMh2wb6POP6f76r402bUTirRTb3vpjz1MwLj0/XS+7nSgaEW3ejaVmMa5NQ0CMIVmXDYNfPU7vmF+JH9Ybqx6SfjxEDQM2PQyVJ9nGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsZkGoiGXeSnWayJg12SRtGTXXDCdgVXagUbQCdUS74=;
 b=VXLj99rxyS7Ug6YTKUr0cnQwX0Ivh+Brj6Dm8EV5UTYkrzYBgdi0PNWyqZl2vZu+VpI3OgzWtDHTm/GrpiXIIvle8ws6T405msUixro/P+utXV8/hhMUB6xu17nXPRwoIoHXL0G9V/8kLTz3XE8WzblZ2PjY5ehX8OY0ow0PurQ=
Received: from SA0PR11CA0204.namprd11.prod.outlook.com (2603:10b6:806:1bc::29)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:56 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::2a) by SA0PR11CA0204.outlook.office365.com
 (2603:10b6:806:1bc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:56 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:45 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 09/17] drm/amdgpu: add profiler/spm ioctl
Date: Tue, 24 Mar 2026 17:20:22 -0400
Message-ID: <20260324212030.822932-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dab8d5b-7e21-4a05-4b1c-08de89eb3cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: hjul8cPd6MGADWS43tSlN6Ac67JbLsc2zjC5uojw7MfOUrelNQU3Hf70C7sWNeqDs6RUaABKXrQX26WeUx0oFFNhLLNXq2zkvtK3yrNgBMJ33C969/tgWbEfHQWvGWH2zKGm41SgLs6eaoA3O54cYt6HBYlNEY8gjjemOBeu769Wa6UsLZYtoWw4uXtBGg4bNEqdiBSOouk645ioKrpIaPAuyjoOq4QpLp6B2QB8fbyOPEK91R2Bo3ZCrXgcDeUSgvueNW7WUCdgq+ey5eEfhmdjPgQfnLDIJrly3qYoveRBx3zfpXG4BzstY154kC/Ca3y1hnp29xBnZg7dheqqDBClUwtMoLX2YkU3V2U/ySYC30ot3IYrc7l7DOh4QmbIuhf0y9wrqkd6dT8cRVuhpEtRKAq/1zOTHUme8xH2jkwKIUSNk3oVp7q+NLA32fAs1yWy1TIJC93B7Y9NUGWejMOObo6b9ETd7kq8/1z9jMhu/96KcQa/3dAQlpuTMj4avWKz2uhHi6mkc0y5ny+0tkqJ4xsSVam08EmlxiETJCDqlDUuCse4NlLeUc659sBaGPkz5ezrCpdIg0zU5QbeU2t4ghxzukmg17bPRMQc34K6GdQtwsx+BepxfWCMpqMsW3AVnaXYjvSc078j8v+H2dKFcZC9oTZ0HRwMemK97eSd1CYjBb03yTEdzE2pr2YfqXQf0S3yACjkWwzRi9odRQdvU20/5oS9l9016BPL0nPuJriTH8yE7tXoLcXhY4vECPx3BBVIZV1+RW0sOgBZCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XjzgCuTp5KuLbGTxwSJJo4IROXAUZg1SIbjxazSJRVVeoczaQZ+slCt3mg+DW/tjB40dLMGEwMlww4SH9GH1/C4NTpDtp0L0wadRaKeOyw6vF07HqjXSkzZUF18u7tz3anBXUSjJCXE8PsjP8t8MFYUKtFCrDCzws4Q40jNZQWfRI0vRcJD+KMEvN/1ts1G87Mc95ZLb6QLkNntoYx43RzonE966wsXMJwbmDvFV1IgdzVdHaYwWISX+I6hGuR5+jDiDEvYSaevfnFT6BMFwpxi6bCsBIgESyqlU7+MQpcM7LIckevV9Zgoux0psbEqUVZ58L2h0Bv+h374QLMfzYiLnnamGWg5FkSg8Ia4Jswscku79gU3kBDXhmveIVQxDOdIJN/9+6SSzn3jNNATudpSxaOG6GIu565w+0IRG6LUx3xXttz7E8NJe52LHjInb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:56.1339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dab8d5b-7e21-4a05-4b1c-08de89eb3cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

to wire the AMDGPU_PROFILER_SPM operation into the profiler ioctl
dispatch path, and introduce amdgpu_spm_ioctl() as the dedicated
SPM sub-ioctl handler.

In amdgpu_profiler_ioctl(), the new AMDGPU_PROFILER_SPM case extracts
the embedded drm_amdgpu_spm_args from the profiler args union and
forwards it to amdgpu_spm_ioctl(dev, &args->spm, filp).

amdgpu_spm_ioctl() resolves the per-device amdgpu_device from the
drm_file's driver_priv and switches on args->op. At this point only
the default error path is present, returning -EINVAL for all unknown
operations. Subsequent patches will add cases for
AMDGPU_SPM_OP_ACQUIRE, AMDGPU_SPM_OP_SET_DEST_BUF, and
AMDGPU_SPM_OP_RELEASE.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index d462d99dc8bb..194bd9339cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -50,6 +50,9 @@ int amdgpu_profiler_ioctl(
 					AMDGPU_PROFILER_VERSION_MINOR;
 		return 0;
 
+	case AMDGPU_PROFILER_SPM:
+		return amdgpu_spm_ioctl(dev, &args->spm, filp);
+
 	default:
 		dev_dbg(adev->dev, "Invalid option: %i", args->op);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index af7ee74aaa35..6ff88dfabf1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -47,6 +47,20 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return 0;
 }
 
+int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct drm_amdgpu_spm_args *args = data;
+
+	switch (args->op) {
+	default:
+		dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
+		return -EINVAL;
+	}
+}
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
 {
 	amdgpu_spm_init_device(spm_mgr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index ade50abfa590..dc55d2a8f016 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -28,6 +28,9 @@ struct amdgpu_spm_mgr {
 	struct drm_file *file;
 };
 
+int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp);
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
-- 
2.34.1

