Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6465C2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 08:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C6410E1FC;
	Fri, 28 Jun 2024 08:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JslxfM9Z";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D49B10E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 08:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWCGnI7xvg5cQNtncI8rEexQ8iV8xal5bbvVHzukhhV/yCjGlmq96bLWXwQ1lm+fYBjVTslBKzmpdfaCpLEyZdW3yP0fxTsGTKfPftjdEKohW7IrMu4FJyUHAFQGqsHJROf8KxEpbOxwMH8Uwl2qkchsmrZ97BuQmUL3N1aGD0MmwH+9jJRkmxGrwJ/boqgrYj89C4Ya9UQDFnOryWK32RAYCgj9p3JD1XVt+TQ5U2cS1kKcscx05mZ8aE8hStHaNrWbDAI9Sjs/kY4/gfS0QjhdsKvZgcTUP+aHu1DKHO6Bl4CP233sXAdp9wRXVK4mUUmBg+vTY+OKCbQSM6HERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AX8UrX+SCwY8QK9cka0b91d/5poCsMCbOwQn4jHndU=;
 b=GtUKSwTx+LK0xyeUb3/uxwSI3gm307z9K6BBI2sn0Zl8UrcHESYy+Xx/f80uoOR77Omre2/XM9H4SrJbWWIoI9W7jhMGVGgjWfh+qGf2CxLL4leywIMlzzaDTHBm4FaS4ZtJTxR5QlR/9poQtptF1n7Crrbie1Pkt2pOiiY+Ypy2m4IiTCrWGkEt6AmTrTgKRSfyvOHYotqKGc5ps5v7P9bLbvkYSZNwrxiGdf4dVSFv1DPlqUfkv962GOrCEPaO3o5djsbwkntpSM2ckqh9pGe2XLOF4biGaTqlVK9ts6klCX5/EruWH9HMBhy5igqSjfZ1CYnVeCaSM00+x6S4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AX8UrX+SCwY8QK9cka0b91d/5poCsMCbOwQn4jHndU=;
 b=JslxfM9ZRkdGcaxdcYx2O9sdi1+DePTIIUGLQlQtFY4KLCL+sJksygKffC+QUk1fT8iZWqq8Ms2LhNOfH0hzUbHCSokJIZpXCvKfwKN6yzFYblxG3zBh4b/N3zBmoYGRpRx2F+lRAVaZwkpT0sKcrMAdOXI9aLMGZCIwS56a9Qc=
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 08:42:29 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::21) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 08:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 08:42:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 03:42:28 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Jun 2024 03:42:26 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
CC: <Horace.Chen@amd.com>, <haijun.chang@amd.com>, Yifan Zha
 <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Set no_hw_access when VF request full GPU fails
Date: Fri, 28 Jun 2024 16:42:02 +0800
Message-ID: <20240628084200.315216-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Yifan.Zha@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 06686ac6-a750-4dbd-e83e-08dc974e3e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hei206fgpFsAYZdc82QhWCGZhasvCrusOUhHkEZUiMYJheKoltAtrLnTBnU4?=
 =?us-ascii?Q?KnwCCh7ZNa6n2X8FGvcdG9vesxNWv5KRcI/5SpSeK2Umjc7SlPcsWyjt3GGs?=
 =?us-ascii?Q?F+U8CkGm7c0vS+tLIe+75AaZcZMAavd7S3yDUbOzw4mi/KZihN4nk5ZuCmKt?=
 =?us-ascii?Q?Ry0k+xXcRWpNK1ULO4XJZ7wKsjNziM3JN7yGh4KaW3JP4CbnsDH7GNeUKTlK?=
 =?us-ascii?Q?/jB3aV5WWg/e0OIsv+BAdT3Y6ifLkTffYNGiTt+8y0jDnslcCGoDDZvuPgP4?=
 =?us-ascii?Q?lZy8JIS3pAGh0bXCFTRIvdzXO6OufApULUIu8Td/gJv1cNSQE5VNno7AkGK+?=
 =?us-ascii?Q?SkCVsyJ4zvrUACbp58jan5F54nVK+ZwR8pTsfeMLaimsA94npizg2W1bLee6?=
 =?us-ascii?Q?EHtIuB8kONk/YQvmxm1M1McOt+bI6xpZY8q77DEcD8r7Vm/2T7tLSLacfTNa?=
 =?us-ascii?Q?g7O1mE/ByZe1wZ+VWOy4INz8hfnfgxk3xX4C4EjYmzzJugYIuTgzeWmGvfHv?=
 =?us-ascii?Q?3GatF2q1s5sPzqh+U2Jyxr5yRlUFpmqJ7FORFQjJRqoTb1CFroJmYxEbdEsC?=
 =?us-ascii?Q?iieUxeOae3CYRU7AisoNNKXVdme7ElwnSQCRwuk6/UUvlCwVLzoIOeaCK5EP?=
 =?us-ascii?Q?ab6j3ZQGaqwEohOKiML4cnFYbw83geAH8/O62QUEbtekKsZhjd7Jj3H9ANLt?=
 =?us-ascii?Q?R4lBylIxhE5nUUcqzqHv8gMkWMrcJ5XJ4qyjDdMVRXI6OQQt0GRm6YussTA4?=
 =?us-ascii?Q?xOBPSr1xpjzzdb2tZJD/R5+2uSEgAHOTUJXZm3gZb5QJkmHVDbPwxRCnXv1Y?=
 =?us-ascii?Q?pXt4dDWc6puwVLidh8Kv73h5KwelEYQQtEFhovUT1Cz9ADaNBTbcGlkRjzjX?=
 =?us-ascii?Q?WDoDaU6g90GdOexXepyPxDQdvI+GgOF0ynLP6cu41cG0XZvmTUbpFGtsa09x?=
 =?us-ascii?Q?+ymw2+PWnz9yAlFj/3jKnwOKyODthpUMzBOrIyKhYK2LDmKFN1fHbNwBkGij?=
 =?us-ascii?Q?YQW+n/iXWtpmxgZKhL6SLkXcNTgYqpxQ0RWqHGhgkHZdkHB/hOFHsUYdNMqn?=
 =?us-ascii?Q?hSqXWrGxzADsQcmcSnLOqcHL16Glm+v/+jHem/GvV5kN2G0w3WOVhXq9WwM8?=
 =?us-ascii?Q?s+dX1nq43yON0srO8MgRmkTOnWZEy2h2RdQ5LswPnngYOJi6x+a/NwAi+CgA?=
 =?us-ascii?Q?POv6B2TWHHhB8mdbNSRpfXheiR0V2/OeWu91iLmxNEqSoh9a6lqw+3zm2aKf?=
 =?us-ascii?Q?mTFFplCveKD/CcYYxU/8X2j5ukZzeoLSuJiQKUgPWcsyQ9oR4jE8JAqUb96X?=
 =?us-ascii?Q?yqFLM9S8uE8yOITnCIKMUU8LIxxDUHZP+vdxSTASKDGsgY+95uHHe7VmZZu+?=
 =?us-ascii?Q?Gf+eXkJELCq18/hgvizYScRJNVoh5h41ARV3ggHqrCXsfJ822F8tTI/yQcgG?=
 =?us-ascii?Q?CKkGjpgsUXiDTU+L7DkT8+m15qOZSHmA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 08:42:29.2281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06686ac6-a750-4dbd-e83e-08dc974e3e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

[Why]
If VF request full GPU access and the request failed,
the VF driver can get stuck accessing registers for an extended period during
the unload of KMS.

[How]
Set no_hw_access flag when VF request for full GPU access fails
This prevents further hardware access attempts, avoiding the prolonged
stuck state.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ccb3d041c2b2..111c380f929b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -86,8 +86,10 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 
 	if (virt->ops && virt->ops->req_full_gpu) {
 		r = virt->ops->req_full_gpu(adev, init);
-		if (r)
+		if (r) {
+			adev->no_hw_access = true;
 			return r;
+		}
 
 		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 	}
-- 
2.25.1

