Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11EAC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1040E10E876;
	Thu, 25 Jul 2024 15:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U03Lk8QO";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3423310E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p009L6INsee33FQ7h43YwsbmePFNzOnUKvRXq7PFw13uIk3uRjCS0MEcRo3ozrRXO65uwppviQahWiQVKvUvDNB8p5xA00psGYdJ/9o6aWlAPnMFLekjrKG+o6U8sgTBvMEW77kMBLv5WheGkbhyipS3NFK8xvZy3KzzWyMsD0u4TC7R/PvV1K5OhgvetAkQKJP5wHy0HSPnTWXEW5wPN3qT0ERHnfJHmr82JNvSpdCTPLAAM/1eYys173hVKb8rkbyF4KlRpcdrtxRB19FFoFQ+tuxoEL8IcaWhOj3wLF1IFcJ+lcmzmLdLbq021K7fpi6N3eX1beWkniKTzr7pAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vioEXsCSXNVVM2PEDTmFJSWV4hO6qWLckvro2NdOdk=;
 b=TtWf37SoNSVhx7VxdZOkeIMsqhgIYCmWRjkg0o7l43cI7iGoXEvG0kgz9CrG1BXEqPU+L15vSkvXd+hZgt7qu8UewTu00qGKORTFcCWwkfU/nZFYjtCXgAk/SULs4hILmEU9W3GsQz0n4xzzvcFQTuaDMwFV3Gy/rnYWV8phA+FaOVly3xMpb4Hc5pK23Kla2EHAzVPz3osnmaIXyHUPYFuN7TYSleo/hix46Xe9VIATPdsPteJjIB9S8+1u7YjLfEBD+F4sjX/ehLlMqZYGXiLrxI9yeLGdZXOOyiXVfy0aAQDke+bn+uJkR4wfI9T+hEQnNlu6dCFMEW0t1OyGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vioEXsCSXNVVM2PEDTmFJSWV4hO6qWLckvro2NdOdk=;
 b=U03Lk8QOzK9hJ+jq1p579BKqWPPXdivDwNjQNjiSiM9vCLNjFH1dafROWB7ofv+RHDBJ32fGWDajS1MbkObk55M1JKDZmNO86wN67B3RxhhoiXH6RLSqajl7F4P4t7MHYtATEH+TxKuRjk94Dl9rz02ObvuOM/GX2tRAVpcXURo=
Received: from PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::25)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 15:01:32 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::ca) by PH7P220CA0042.outlook.office365.com
 (2603:10b6:510:32b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/53] drm/amdgpu/gfx11: per queue reset only on bare metal
Date: Thu, 25 Jul 2024 11:00:41 -0400
Message-ID: <20240725150055.1991893-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c3e031-71b7-46b1-4d19-08dcacbaab43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VYHa269B6qZ6o58VwA67i5zWPLR845GjqklanoUl2W9MjF6evDNj0q3N8aV9?=
 =?us-ascii?Q?t5MAb5cfECumLKgV7PIbnVPqhmUhPFKR3CjzdRdRKpCBMjh7Mk6DabH7HUJq?=
 =?us-ascii?Q?c9Nk10bH1C5UZYgthBGvLDMUqu2+UbwhlskdOncVPuSagEMvbF81EhckrChI?=
 =?us-ascii?Q?XollHmJFP1aXEVDwq/qaPdwxJF8iMhehyYvKvO4Fg8K6NholuuuZKkcu/Qnt?=
 =?us-ascii?Q?96XINP82hbM8MCAw1hHR3+0iySV8qCv3rj9YKgLnDLDFffLCr0K+aHPJuq3D?=
 =?us-ascii?Q?99nMQxeRKio5hCItzNr0bPeShCC8hN497xXLbMXBjB3fZT4RxD7V4JZNGW1l?=
 =?us-ascii?Q?MoNuh//cYBSaMBpx5OggoIsYQ4CFufo/+DCg/lBTFVAuuarfpkSIH9AzOl3/?=
 =?us-ascii?Q?Fv38OB/OB0kVO7bTRNK85cIs5ztk2HzJunAuRgPvVW0BC2mGnnNfLg0vaPkh?=
 =?us-ascii?Q?859VogxkJ32hckpvjvEY/i9uj2KQYHd/tQHkD2bgHraSM/xt1kzAt86HKqwe?=
 =?us-ascii?Q?leUwvFDdIyGTajtmkCJjcwuvepBrBxQUMcym+KIWAIdTRE7pvFNwbklHxPmz?=
 =?us-ascii?Q?f5GLMPUGn+CMhmGchHqO1H4XdEYfww8nEB2HLsjJ8ESHRJhXdF/BS5Hq6Mu1?=
 =?us-ascii?Q?B9+nUE239kLzHi7QY3DsO6uEsGb7GhJLQAoOkmfR1JU6UgLfNFhreNVaVyp2?=
 =?us-ascii?Q?6csNwrK30PRmqEoXYVbUGu/b7cjaHY28P8N6KPwKIoAhy0bEhlD2YppDUHjl?=
 =?us-ascii?Q?kYz5jScBSYbB1t0jvtRXcCvgKDDc4fh6I9gF/L3kkQm2PzIvmuAg1Xym9CfV?=
 =?us-ascii?Q?Ysxw1anllNozrCQ4tIpVDdhLL+F31PdIkACW+v197S+GRzmpegBtL3c6ZJb3?=
 =?us-ascii?Q?Oi0SAPehq6iTho3qlQteIIPpKzM8iC1VCOyX7rkfoWs2TsjnObTm/hHbO3BA?=
 =?us-ascii?Q?eYrUtmGJ2OCV9UX4rcRlRUBYqxQ/PrOrt9DyVKeMnE+hYEUG9Hh6Mh6X2n2y?=
 =?us-ascii?Q?TYL+zhWL3d9TYbn3B17/fsqJJXBTrjjlmDjp3h3MINzaSKSkYRicgLAau2EH?=
 =?us-ascii?Q?/hFlKLundUpGXVCT3z9bXNkUOhc/m/DB4NU0TxguYfWKvZzQLwD7Zz22F55T?=
 =?us-ascii?Q?ErOqmfxPnXIQ6AM5k6W2rW7SU8Rqtbk4i9AX5Hy8CgBd20yJflj5BmeiICtR?=
 =?us-ascii?Q?Xzuo1TQ23rIbIpvep/cQ/o9PG4q7WYgxBDO1mQigJPdkpgeWFjlM+3atADp4?=
 =?us-ascii?Q?WTTz4H+WBmNHEuwIHO+PReR/mq2PBXjIIebNUOuPbjly6u2re3LEnYu4QSJS?=
 =?us-ascii?Q?8Dn3tl+O0CveuoU+9L7FuTCjD+AJYmV6fvMV3EFze33j9RlDF/6AZH91jUii?=
 =?us-ascii?Q?hAHfNh9tZ/hxpHXTTwrBZapon07xxlnyPNUmeEGxuo2ERoPLcxJsH7DIGsqn?=
 =?us-ascii?Q?WBnyFcb3qI/JBZgAXeTYm/ye2GET/ZY3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:31.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c3e031-71b7-46b1-4d19-08dcacbaab43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

It's not supported under SR-IOV at the moment.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37dd5002e92f..c1f799651b25 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6529,6 +6529,9 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r)
 		return r;
@@ -6564,6 +6567,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int i, r = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-- 
2.45.2

