Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3D6D49C7C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D6110E979;
	Fri, 30 Jan 2026 08:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UwsmoydF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BC110E978
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfAWW1fhCznAJklo1eJ/yJjq14hUBRUjq6ECZf93yROGhHR9LyxA5gDE0qc0dBHhNfOFAMdpCnwgdyNwGwdZXlu772VJxSGviCju2FJdZpUwZ/Culum+Y45wuIvyGQgbaqgxZXvrPiOO5KU50OueIRihfyHCVyrw4FF2HjVsLxN106dYeR0NI7XyTUrLHSZE8Mpcx7fbGXPqDCKws896VThhF5d/JnPuZHT4riGiMzZCsnilovdKnrOPiFsmuNtKUH1WmyranfET2QBL6bdFEQDZvtaxrR0p8qd9ubpJ1LnGkXNtVuJJYpzibgNivQV58hqFXOAaReS2oMJ4uRu/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgYcAk5xWQHBk/rdhTtAv5pCrBxDvu61xLEu9Z5I6Ns=;
 b=unLNnqwMyodqzkEo25jJMC0Bo6LgxRypyyJypQhUWmLW5hnnv0fo/p9Jv1Ts2v7K+5fp8Aor6IXTDj0H+6ZyLU293RuQDrF55A5uZviEbGmSiemgy+La+RhdGy7qpvSv2XAnaOJH7VvUP57S9BCevWz9hxiwT2SljlucPa4+SosRkyq/hwGZywfWrNc8SK3zNgm42xUh+z/JwDws/agxmpel1APcquhXb9dXVVCZ2wjR+aSvSopo0dR5jYAL0duFjY6O+TCxxWVJYvXqlJp6cBTtUpk/uYZpCHuJb10F9CB58pFWJJzR37fj9b47vyqBH7PUts99O7UqwK9oE2zIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgYcAk5xWQHBk/rdhTtAv5pCrBxDvu61xLEu9Z5I6Ns=;
 b=UwsmoydFopYTo5W7jKJd50z9t5lPatDpa/iv3I+aZ5f2qqxj1hl9uMs9cEDeMBggrHWeyGRKXbZUOCFMyMf+5lmgaeKXDv3P0yevI3OLwB9/XxxjGWjShHSUwNToD4uwvD/xxJd+BI3ra93AgGIqzF2ppuZ37o/7gRX8/7cSkBs=
Received: from BY5PR17CA0008.namprd17.prod.outlook.com (2603:10b6:a03:1b8::21)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:42:17 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a) by BY5PR17CA0008.outlook.office365.com
 (2603:10b6:a03:1b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 05/11] drm/amdgpu: Add cwsr to device init/fini sequence
Date: Fri, 30 Jan 2026 14:07:59 +0530
Message-ID: <20260130084137.2906792-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d7b5ef-ce12-4e3a-2a7b-08de5fdb794d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IaGnVA9Jp+4o+8YbPld9KF8cYoqnnIsol+c7DY7QFITzthn1rCozXiA76fxc?=
 =?us-ascii?Q?8NJvCaaRlsLupOv4tJSwFc2fnvpgm8aQ7vi6W0U4vL4MvcDyDBQQjsPoJooB?=
 =?us-ascii?Q?3szQcQv4raiwunAsjj3ScnZVUleimeNz0Vkt0kPYsKzVXTTwhO77Rg16tggy?=
 =?us-ascii?Q?ZiVgkc4x/Nyhuo+vJYPqi6znt4Fkg625ag7fUiCiWNHaIN02vtaru0sINcW8?=
 =?us-ascii?Q?TJBKIhY20oi0m/w+BzUMB8QPfKthe5Jbozg65j4ldFZjh/qoB25khl/4T2yH?=
 =?us-ascii?Q?C5yYYzCLrCHVZqqnCkYW5RTx+hZ1V/xjPe0uYzXDsEXjNB8CbbAgszzzZYg1?=
 =?us-ascii?Q?tBrsTq63hJXccSxf6AhbPxMUJvITYBNi8GGpv308FnPUJfm9GhPzOdz5WBrc?=
 =?us-ascii?Q?0E4MnQjfsSLxcPk3lQSAn6P7AHnFrpblSb57yWQDmxaYpAzQZ6JiDXbqA2d8?=
 =?us-ascii?Q?gDhVIb2apYuCrMgh8FWvH0exEdw1OsyLdNzLYWSoD3uCtmG8l4wQ3Ut73TsV?=
 =?us-ascii?Q?Fd9BqRGzDDf6C0aAzfhuPogjLNgqBh+eXgO5YQ05BQosilvPIQpDN8UikHFR?=
 =?us-ascii?Q?DUARrRMcxepjc+b5o4mJn/r8vkln9Zsyd2d5vj4igGIU3brK+17aAWS1H22Y?=
 =?us-ascii?Q?Z2ewfA/CyOXo/ybJGoLUYEdNv+FpZg6H6QxUgOwddzvHp0Av9aHxje/Ag90w?=
 =?us-ascii?Q?DguMMcW4vw5R6gZ0Nup8UdjLd9QYnFzyceaM8N1QFg0wLzilvBJSuCOBojZp?=
 =?us-ascii?Q?1IEJmJSfJ2gahyDGIR56NjzV8nF2zAIJCeoKaRUvAU5n99PcPiSH56KSGLiw?=
 =?us-ascii?Q?vip8Sm28vzd13z5Vs59tlaT2Tih6u+WWiqeStzAh3vF64M8cR3Dit5gkJdEW?=
 =?us-ascii?Q?r8VNEv6BmibOKMoxH2OaT/+AC18jcGBA857UxzPmQtJzBe2DL0yDhQ+zwgL3?=
 =?us-ascii?Q?zAPbVc/YZP3evcD9ULuuYO+od4BZ+4HLBeqdmLD4q+fkSCECkg0tp9ujL8+q?=
 =?us-ascii?Q?we8X17Uuyj3D+96lWmRmMYuj7wcJqwHb4gO4XTLKkLBHJN5mPKtOKcbWPyud?=
 =?us-ascii?Q?TOkZ6IUUKJSB8WJy/VcOYtJkH5sYpB/lre/c2DH6FttuUKFjZyz5nybAQ8ND?=
 =?us-ascii?Q?7IGeEC1uBkDaas7Yde+R50rhfW2zKOsRffHvy1/ySE1RQbHM3ncisK2TPaPM?=
 =?us-ascii?Q?Wv3u9O/azYTuHmLZtg79T54oYStsMGE8USWDd50bvMV8ukLH81stHVXSSZrS?=
 =?us-ascii?Q?dV0pV6lraLhWgrfz4XS7ruLOFVzLXTRYYyXigeqf8eZ/2ESvzOgS3P29FQPN?=
 =?us-ascii?Q?TdKKH/NdNBFwit4ISmmd1S3QAGleZR0HH++QVFCIVFvyXczYPqXfxVCQEZFD?=
 =?us-ascii?Q?+GH6VCQr9BIs0b1/ujZ2pWa3RMzOTrkRb82Eoj6XURe3amCGvtx3DT/kyEnj?=
 =?us-ascii?Q?JaklIAKZmDDcPRiVH7FDohkOA/OtFu57sj4mB0MLOcRAe4sH9031bU5LU2ge?=
 =?us-ascii?Q?vYo79hsnlkkExvzb9Lp5yBQ/RNQhaV2DFoBZKT++JDdr+ytm6f5n4Y2eYlg1?=
 =?us-ascii?Q?HCvkqArl7A7uVn/ySgWKJtVUpxDPWCrs0A6gkPzOU5ZUohvKgOSOakLVz8Dl?=
 =?us-ascii?Q?knzm7s6du2ITqcpVbOoP1xpDvdbRy1Do/iueCrAi+8YlyLQWP0pn1KRPQfDJ?=
 =?us-ascii?Q?XAL7iA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KwdtvzzCFvvp3Kt3YGkWJyy2C9htXrMmu4CKi3V03y6UKylair16Oya/cJAgd8m5uCaNUT4ocizfooAyvRs81SY3H5btG+N9+yNp78NK4jbIP2OHMExWf1blUwt+guEuOehlqAtNop2OoROJ6WxhQbDxjx1RifIqD2VZzytq+NnjyfwMJJCVekZLUmF64Ski0HfIX/EnUPR217QXWuZd8I9rOonCKiPwtRPgjYdeLITwBzPD7N8YKcUy03Y7CmP6oEW8Qr60hLYzbUvDwgxVrX4HPFtJgOJ5CW3nyO4Mw13O2vl1sNUKSuqJjtd8WtRMTkk3EAZwj8yd1xx6o6pmJ4LnYtE7ZcbXllN9BLliOEovoh5ST3Z0Tuv0u1KRWHOva/SNi2552K5AeIEZI8vjhOmTSoYPQghUvcxOKauXC6WEW/deDK6POXTnC0dMRuPd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:16.9407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d7b5ef-ce12-4e3a-2a7b-08de5fdb794d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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

Initialize cwsr handler related info during device initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b34498..d84e513613d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_cwsr.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -3171,6 +3172,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	r = amdgpu_cper_init(adev);
 
+	if (!r) {
+		r = amdgpu_cwsr_init(adev);
+		if (r == -EOPNOTSUPP)
+			r = 0;
+	}
+
 init_failed:
 
 	return r;
@@ -3561,6 +3568,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_cwsr_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
-- 
2.49.0

