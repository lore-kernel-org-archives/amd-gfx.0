Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247BCC27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 20:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C5910E4F8;
	Fri, 14 Jun 2024 20:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQT0N2Qm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B454310E4F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 20:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGmK6s3WasdG18PuImY+ckBjA6/tn2MDFK1I5yS7Auu0HTXLg1qqtAxDN4QoPSswcfK0giHXvRjPwqHt6jWxBT65nC+Vdqhe1B+5O9Ilh2ZrYdM0aUwrBrDdQv8DyrsODeABZaSA0heM3ceMS9vwWYDyMs8+CBzCQCtyQNlW+qZE8Qv3ygoR0pg9zg4HmnLhiclPy0beDd155hT5GNS+9IDRWHowSIB9Yyh7NvYy2NJVQOOmMPJiItzlazCR1PiUAy4/lBkTohkKvd9aEhf+KcXH3zjqQF4QWnQ5Vj9MAO2b0/cdAgl9VKesoNxyXaCRLSa4n7hklD5hYtLwFsEiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMOiFJ2IokkmGRYgxKVEAJ2CenNq8Qer6O3qpO1YJAw=;
 b=G8rZmmbLPMAxpTo5Y89aL/RUpdA2QpYTRRXwiPdRDAqlgdXktANT+OxROgnoGY+QO+teoAIZKqdMTWeTorXPnscSExCwUxQ1ICPfXE2EAzok37x49y2fHUHhZIUlolsa36KVCnIXPTdmJ0YzU5bh/teaDkzolmp31p4SGoOG9KEzDEFxupQmfdbvXaVG1ygjgoEhf6CgV1g4FVjzFAKWZ/ntX9WfTtlVqyqkIvZHgEAiogXktKNXa4KCW/2n1o0kZI7QIs2LEsrU35zIF5rv5IedNepZj5uyksiAWgQX/xsN6UpA1X8WiDqzHros6ZuBVADUbJq8UYIjgEeaSdFUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMOiFJ2IokkmGRYgxKVEAJ2CenNq8Qer6O3qpO1YJAw=;
 b=SQT0N2QmT6fbxkz6VA5Z7eCwan3EHaJQBe/vp7/fZb08xTxHzB3ZZCyAqEg7imJfQnoJoEQjS+Q1wJlxqLnu6qPIAsVx05fnVUtzpLrQMTQEQ9e2x2VhNrA2S1ZhxsnfZi/z1pKoHnyiiZQcNgx2FnID3IsTeXRXlUOP63nXsR8=
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 20:32:17 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:51:cafe::7a) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 20:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Fri, 14 Jun 2024 20:32:17 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 15:32:16 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <vignesh.chander@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: Do not wait for MP0_C2PMSG_33 IFWI init in SRIOV
Date: Fri, 14 Jun 2024 16:32:05 -0400
Message-ID: <20240614203205.4266-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: f5af3d42-7e01-4a3d-6190-08dc8cb1156e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RmrxD2SKFLrIvFGbOzh6Wib+Rs+K0BjDn9dlDBGk6ubmgA1MJEJVRqVaAJ6F?=
 =?us-ascii?Q?JLaC8Ef/hv/aDjpsthewhmPKi/Fuw2Kc/Jw423Ua1CgN6BtSLiucqPrzsVCk?=
 =?us-ascii?Q?AeEg3HrsGOhAb6wGTH27WzOdVAf/UOt31JiwfKnqnEuUxM8uwbv4oBusqF24?=
 =?us-ascii?Q?RF5L/LWItTVJ5TddhjzkibQSMxpURR0ALtvVihXUG04UT2fB4RS0WEPzv7Jq?=
 =?us-ascii?Q?nWIo2jzFkpRUx2PlikXAiDqrQHg85VYekvo6SUSazCKFzBt9f0Ac/Cte8oKm?=
 =?us-ascii?Q?et/7VX+5vyLZKl3Arbyvm+3RkpskVI+BSkpCHvWEmAtJ0sTIhEbTWOwqigyK?=
 =?us-ascii?Q?niD0tufb7AtpBQKRSlZ7kLI0bgwV2vB7L7qiLBH1rbx9noUsrXL/6sWDkAQq?=
 =?us-ascii?Q?974vpd88kc3ME0qhnpN7hfFy8Vhtot8Vx+agWal4yo3KhEFUoc72vYhaoJeG?=
 =?us-ascii?Q?94jWDnCJasfb0mlz9YgSgY1+PmBE78TdoozPL+Cg7p9n3/2kWy82YYwfo8zn?=
 =?us-ascii?Q?wkZzWcXbqINs14FvvjNAnVZhlUK8CBcoDCPsKtxTX64ChToRe7u+fABXnNW0?=
 =?us-ascii?Q?XrEGeRMrN/+NuvOXrecQIMiBY10ol8sJrhlBO1F4yPl5xTTJrMsFhnzifyU5?=
 =?us-ascii?Q?q5kM1xuu2aMkc61B7urWY5uYz7JHFcl76M/2FMKIljDkN93ifjkvShbI72jU?=
 =?us-ascii?Q?XuHNrWb0fTYHvT3AcCiHgmRBqJXuOyuZr1diM8eU2bqqRVk2pvKmYmkYayR8?=
 =?us-ascii?Q?cdoBeHciB0ElxebZYvuRr9Vl0IMyBLjnJLlfkNiA21zRPOvhiuY6/OA92WT5?=
 =?us-ascii?Q?pKbe3wLGUP1diPp6Hi74x4MTGaZlkW95WjOgzRwnQULon1qYtP9NHpZFjI/k?=
 =?us-ascii?Q?9+prQH9ktjXlJvr6pWGClG2TNHiX1/svNGHbPeiJlCRmRNx8JIqXSwSwZ2vG?=
 =?us-ascii?Q?3FCwy8DRsrkLafGyDjfIIO/CJQrQ5nISG7cYzlM3oTjMmNxAdlx7jfAjlYmH?=
 =?us-ascii?Q?U6evttJ1cgcqdO/hel4AiN2i14MesrDlUP77ycS4TsXaxk7rKPlTSAMlIoKb?=
 =?us-ascii?Q?LvIFxf9AQBMlMqrbZOMX9GiT7GcPYLVAH77ijIeWNF8piKJL4VbX1/xMPbln?=
 =?us-ascii?Q?H88timEx5WvRxXXA6eOHwcPYx1dLhNgghuUEpdC685wwLZDmTLQibTDZWovK?=
 =?us-ascii?Q?6AXV3Ch5k2wvqOvjdWMStX3d0WsCaCcLbce27JirxM5BTamXdAGqjO80cg7U?=
 =?us-ascii?Q?eJMEvasIBqLrsIGSR+eoCl/L27UZMuIZ5Dx1eRAxF6dmxcs3cOoe9EYN3rhA?=
 =?us-ascii?Q?0wZQ7xDrFI3sV2KJCnla/vWpNHc1tIWTwBo+UDcD5A3/C3mrEqhU29wz1dFK?=
 =?us-ascii?Q?afeKXkM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 20:32:17.3767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5af3d42-7e01-4a3d-6190-08dc8cb1156e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

SRIOV does not need to wait for IFWI init, and MP0_C2PMSG_33 is blocked
for VF access.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9e0cfe06c8b1..4edcbd272fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -264,19 +264,21 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	u32 msg;
 	int i, ret = 0;
 
-	/* It can take up to a second for IFWI init to complete on some dGPUs,
-	 * but generally it should be in the 60-100ms range.  Normally this starts
-	 * as soon as the device gets power so by the time the OS loads this has long
-	 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
-	 * wait for this to complete.  Once the C2PMSG is updated, we can
-	 * continue.
-	 */
+	if (!amdgpu_sriov_vf(adev)) {
+		/* It can take up to a second for IFWI init to complete on some dGPUs,
+		 * but generally it should be in the 60-100ms range.  Normally this starts
+		 * as soon as the device gets power so by the time the OS loads this has long
+		 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
+		 * wait for this to complete.  Once the C2PMSG is updated, we can
+		 * continue.
+		 */
 
-	for (i = 0; i < 1000; i++) {
-		msg = RREG32(mmMP0_SMN_C2PMSG_33);
-		if (msg & 0x80000000)
-			break;
-		usleep_range(1000, 1100);
+		for (i = 0; i < 1000; i++) {
+			msg = RREG32(mmMP0_SMN_C2PMSG_33);
+			if (msg & 0x80000000)
+				break;
+			usleep_range(1000, 1100);
+		}
 	}
 
 	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
-- 
2.34.1

