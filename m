Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9861606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z85GGxsP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821B210E790;
	Tue, 20 Oct 2026 16:04:42 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D8C10E790
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 16:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1b8+nfIIZky+4V0XxJi+CJEEvG2IDl4DByX4OwIO/iYfLZnMhLxo/EHdWuD3VjObXcAcWPUcITiZLVb17/E/xGgx3ZFE8cbpDn3t9DqkvFxgmex2q7ehcK0iDK6uabzNPsjo+yunRxHaEf/oWTil2RxRgT8vSdm1bxIXSLzxWrxBsUBbfC/AVLqm9YHVcYoqCFN3YM0YgIzWl8dW8bzWvvdh+WuzlLXjLNQHinCE/0LSFuC5yZFu5YSAxAeXtVWqlu306/mF+PEwVroyXFHNYjqrzzXE4rRTHfwAnAbn4Q39gJjQSxCQSCgOWZqNMCyxcgLne2JFNSJzE+1U5DGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLRznQOD9tMbgLGBOlhejHuEtlXX/48J+vIX5+W+XYU=;
 b=xO0t6NtpbHccmA/wc4FGgssO/q+9Hjwxu8nltlV1aK8QWFXx6QMcXjG/QCuyGwTq86DL5px2DAk/YS+lTlLAcV45F8c2UekY7ZqcB9yn+krIyHrX5hvpqGIm1PkqPlsKsEVVLBMgMrvu9rCKzuzAaKv3eJdHGJdTW5q/YQMp4bC0yfrSowaPD3iiFrY/IpHSUq3qSmKW7U451OLFd5mWRwuNGeTB5jJYR00H1GaE+++Sx/kX4Od6jIz+SeMkZ8zqa8E/PSacDrOzrzc5O+08QHBfj+jvyABUQfxBpApDeqp335LGA7kditBQgt1ztIs+yAIYTJ6qNNv1buaxNy9XZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLRznQOD9tMbgLGBOlhejHuEtlXX/48J+vIX5+W+XYU=;
 b=z85GGxsPyFMKXfCd8cKnf4MeNMZD0mLWdoAQk6IWeOB+1Rvp0MXAZ0RquHTU51YIjSXxebsfDnt/ZKvJA//IqNSDNnI9a6Y3mt490dkL+i+vnIAaQF+Cv/HoYYTpwNtwNB1IlHnOy9Y5PnLEsr4nOl2OuuaMy1uwytoBSreyV5U=
Received: from CH2PR11CA0017.namprd11.prod.outlook.com (2603:10b6:610:54::27)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 20 Oct
 2026 16:04:31 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::44) by CH2PR11CA0017.outlook.office365.com
 (2603:10b6:610:54::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 16:04:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 16:04:30 +0000
Received: from rocm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 11:04:30 -0500
From: Harkirat Gill <harkirat.gill@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kenneth.feng@amd.com>, Harkirat Gill <harkirat.gill@amd.com>
Subject: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12
Date: Tue, 20 Oct 2026 12:03:16 -0400
Message-ID: <20261020160316.2411569-1-harkirat.gill@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: e3575c3f-4519-431a-bb29-08df2ec3d338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|11063799006|18002099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: GrDIpsa12rD33MKnK+86rmkWNUxQTc8dB1NHxiIzHp4U77HfNQqeKSReD6X5ZBW8t+QuEWKye/ooyW6baM3InW6Iuv3pfbpnT89baPHbztltToGp3JJwahEwG8IirshQ+JijqhT/q81LZy7bDSXLGeZAMuGq+m4Lb+IzpjXC/weIYVTJbWmzvXxK9jM2rPjg7nTkGpzFFzFsz3u1ZRAWhJ8HSWG+eY5nLqoszFfLDjXW6ORpoA6b8wvE6DrkZtfNxzPliz0dBHi4ce2PGVLqpHWO9qnKBIWDDH+7HUEN8Lmz0KGpN9Srj37q1ds0Z8RhhP1dbpWbvo+Ksd6Pkyu22ubF9nwxJNsMBXXu40U588tTXHz7Ia+jKw8DB3KmPbI7nKv4L72G4N5iPlkFahToxHQGwO3MPNvZReYBMdaZV7RyFSEbAXr4Q0myNsUOOr4/VFKSmuY7HyKhsEy6fnCYJ3x7hEMOe9lORoFP9GnKEW7bYMf3vZwjRXwytYwf4Spf6D9Zop4FedhrJ5Tn+ImuVt9cdh/e4cPbcYS23Aj7gY++Q8NldhlLd2Jxfq+1uswtXU/fzhiDrRktMnPSPlcnDFJTvNs8ZRhm924Nev0W7Ab9AcHf+rWiaPzqH26cSCLe8tF1F6LnkwLEjPiZkg7DYgbG85dOaO37j0OSEO8euSaDfmLkvcOttMhehI2wi9gIbBwWSe+Y6xfqU9e3D7xTAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(18002099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MIuFJglkKuGEJCklJEPSpQBoUfubwWriFMEUCVXAPFgpgtO4wskLOXRg1LPjVrnDQJ3IXTaFfu3ENPbkvvNyS8sB7fm2Y4YWydqI2ZitH2axteKFSgIRIGQ11b0eaSoTkzwz+YGlR9RJKUoeqGkwB7chSFCfY8ulvbU5l/KL2siU3fD1FSSWEp8nIaXE9p1IYvLUvw8yTqCw4nu0I55ehD52P/hrhJcT2YGBdt+TPR/HgAgoVOLUgIJWwn9cz2d9W5Bcc7I9KqOIn9LKmTFWQ2eHS9MfzZnjmol23i4iwBLQeP+wXLdcLtCliPfykrS5pFr+OQNvjrIcxeTbDbUHHXcykO/Tpoh1GP1+pQO0t5l7BtBkpV2FQH3qBtL2St7RManzrGAuqFi9l5pMnBk2xllDq+TovANoh18C8xIw2qKgLWUyJqre58p0Yj/e08qS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:04:30.6392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3575c3f-4519-431a-bb29-08df2ec3d338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute
workload on gfx12") disabled GFXOFF whenever a user-mode compute queue
exists, as a workaround for an OpenCL test failure. The MES firmware
issue behind that failure has since been addressed, so the workaround
is no longer required.

Without this change, idle inference servers that hold a context for
hours never let the graphics block power down, costing roughly 3-4%
reported GPU activity and ~3 W per GPU at idle.

Measured on gfx1200 with an idle HIP process holding one stream and
two resident KFD queues:

  before:  VDDGFX 695 mV, GPU load 2%, ~9-10 W
  after:   VDDGFX  35 mV, GPU load 0%, ~8 W (idle baseline)

The resident queue count is unchanged in both cases; only GFXOFF
availability differs. The ocltst runtime suite (40 tests) passes with
and without this change.

Fixes: 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute workload on gfx12")
Signed-off-by: Harkirat Gill <harkirat.gill@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 121282dd30c1..34573cef3393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -746,9 +746,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
 	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
-	if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
-	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) ||
-		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 12)) {
+	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) {
 		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
 	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
-- 
2.43.0

