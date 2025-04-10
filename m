Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D179C369A9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0254810E388;
	Thu, 10 Apr 2025 18:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gzjYUpSf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C5C10E388
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5kLEiUelAexeSezdorwYqbWjsCTEXJ1dO5iCr1HDoZhUUt7jmS6gbL+DFhA3hwD0c0wNZcD5TkfIV0uS9XBJU9iqkpFol3/EB8StEK7kd5TlFxYDJbVNTtusIN1Y0PjYojzypGUXwQ+35eUDIGuZcXLLz/2EJ6DI2jKVPVRc7czfGYQDUiA6Wz5Y50r08Wa53qNz/fLaAvRfFDhfg8z6fvLUnTt/uuFYi4NMtFVIUqQDd1q0bjXoFWUQANyijn4PMUrRZ0/35l29RdLFu4FcVFupWyLZElItKQXC57TBALJ9VoZmMaIr/ekCQ8MUw4JJcbjXGUEnFjZIt822gtsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQo1l9OJ44P7PaGo9lIvOWA9o2P6ZLpxU9eS1bI40eA=;
 b=rrwR3myvRDwK8RJWy7/H/OVvrgWYEuYPTgX4TS/5tI/bt3Yx7aMRzykpb6bPzJK4wAaFaU8a8B0zukJRzNTUPLTMJV9rgMO3vabWogyoFY4AKk43UxH44MU6UgXAR3EbTI/UGmUiJrbbosBF/YHz32UoWdiqJObnFZFNt0DXJfmmBTK7028ML4JAe+58REoRUOV2ScqwCP5jrgFe268uZgH33NLx9APdFsnyDm3fDcUtwbmebkHK5V9aetxsXIr+Z0RTqu9jtuQa3Muf5Ob4VU/ibuu2WD0h6JRqmnBVVd/EO+Rj0vFvFSJlxI80w+SBqnSkBGx0Ysnbww56F7CtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQo1l9OJ44P7PaGo9lIvOWA9o2P6ZLpxU9eS1bI40eA=;
 b=gzjYUpSfuMRRVweTQPXxExtbe6JRNWIWA4kzMSYmoM7X/qXnm2aigim+bEPVxCjVmzOTzEO3hS8k3fupZp5qNnNJdxm16aCJbF84RA9Mw9zyXbF4jC8AxkPzBwNt3smPLFkJu29e1sWr7yGlfc1MvoGqiI8iY9bVN6C8GDuLIWs=
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:54:16 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::53) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.25 via Frontend Transport; Thu,
 10 Apr 2025 18:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/13] drm/amdgpu/mes11: add conversion for priority levels
Date: Thu, 10 Apr 2025 14:53:52 -0400
Message-ID: <20250410185402.2352109-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e95d96-42a5-4055-c8a5-08dd786117da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2cCKHeloerO5sZ3UtshVibvNyXL8slWIiGyu4lus8p2V44R1GpaGr4f94tci?=
 =?us-ascii?Q?rju81DfDLUD1ni1s3Yw/RMNVfVhA5KJv63qYCxytcOj9mVGsTDJXM9utGSE4?=
 =?us-ascii?Q?FmAJRff9GcY2xIa5TUDjt13EV7KmOx2CpDn0IEWvZWo64IOnRGqIzK/kZ/c5?=
 =?us-ascii?Q?3gWxykoJb+wwrDiwPxQP/qXsyknFonivOQ5SxFv9K1XqjdiMY9ZKKcDzvUlh?=
 =?us-ascii?Q?83+83dllxxNkz+uvXOJ45VCjQvMW0iXlD0VbNIrEYji2kzviyvNDctwDQ2Td?=
 =?us-ascii?Q?rN7/db8HS8D9GB1Kb6PaIF59Bf/uZybz9oxiY/FXc30RdAXXpRBKZdt+eiff?=
 =?us-ascii?Q?rqKVuETgCEiIE8vK+fS0sT7KZHK8ZcZ6npluetQbZHGpX+fJ651D8uaVUpbm?=
 =?us-ascii?Q?Mje+MTu6KGn1JuizePuVQ+w5Md4BA2aSDaBcCWoqZJxd3V0nzDx/ePAELPl4?=
 =?us-ascii?Q?7taA2G3veEJQR9mJHetAm+Wm1Exzn7fPCOZreUzSYdVuv774i/pf+nTZsoJF?=
 =?us-ascii?Q?MZqTboDUNDtyvtHNOQWF6hqorFVPrWHT4ZHlpPrRDBP+VenKFsakoox3DhIR?=
 =?us-ascii?Q?tn+uGkqdjsD3EoKkoUajsur9BldW1pcOry+rRYLW+r+VHELxDfnAHPu1o2GZ?=
 =?us-ascii?Q?6Tog8Zl40AtaKkDpq4FXPc/PJECMr+pIs1+VHkan8yPC5nAF9FuEgG3G+OsB?=
 =?us-ascii?Q?6EyJLA3J0jsSKnUIi9AeY3lcb1oGh6R9IFP8lA5myAA7n+AhXJJQsLVLM49c?=
 =?us-ascii?Q?QUcJLY8B8v1wiqKDn8EqGRE9gARy4qKzYTLXWGO1xvhMGKVsp3hgYeL8nHOP?=
 =?us-ascii?Q?90FudwpcCGAnXqKlcE7AfJojCqiW4KPwrDcq7hEKFfIYgi/LFjUQUmHNrNNc?=
 =?us-ascii?Q?qMfkDBJBMkssUNv82VNLUWb0/vD3Y63llRdef4ng7pHTa1A9VXn6cyn/8Y7C?=
 =?us-ascii?Q?2Qyz5ig/Cn67wQcguYuI9n1l3OMvTMAviWfL2WBxh5xFJkB3fh9bhIWrciUU?=
 =?us-ascii?Q?FhtrRE6BjwgM+gqv23VJhwgAZlBRvgkN6G7sZHkkwVSY8PG93iabUarij9Nl?=
 =?us-ascii?Q?auJHxR3jLJPDqz1JCW2r93b37NGBWjZHGVyI3r3nkVfSOt2Jk/1P1h9fvFqs?=
 =?us-ascii?Q?S234fu2UeKMKo7ZvrvUM7jUjQy+g8E0THjbb3Lll0sSe5VboqPmousZBJ+kL?=
 =?us-ascii?Q?XHnZmKu+fsJluK3FerdWfz9yxHgdv/KWJSiK34V7iBwz9vihGU/nX9hm8+Rw?=
 =?us-ascii?Q?KYDkx0oG1XE7T73CG97jWgb6Bhz3zjHJc9DT9WhQv7dHjPL4NC+dkPno20h6?=
 =?us-ascii?Q?1Zi184VZp+TpRJwSQFURSOPfurXjeImYHrsmqUY8QXOR6XhcOCjJlvup8kgK?=
 =?us-ascii?Q?m5T0rcV6S491gK+4oZ/7jxaPIkXhZQtCF/p58RB0fmEVCiG9S1ENNsVk4K7E?=
 =?us-ascii?Q?GiALKgxMpch84xfcSuL1mbPgmshKS0R0CMa8e3v9mssiy2aNfVXiyR5ebdcw?=
 =?us-ascii?Q?bp3bgBpUyLvo3JE1zH9nYQXSNcYOwjy6oI6b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:16.3359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e95d96-42a5-4055-c8a5-08dd786117da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

Convert driver priority levels to MES11 priority levels.
At the moment they are the same, but they may not always
be.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 06b51867c9aac..b39a538cfc4e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -287,6 +287,23 @@ static int convert_to_mes_queue_type(int queue_type)
 	return -1;
 }
 
+static int convert_to_mes_priority_level(int priority_level)
+{
+	switch (priority_level) {
+	case AMDGPU_MES_PRIORITY_LEVEL_LOW:
+		return AMD_PRIORITY_LEVEL_LOW;
+	case AMDGPU_MES_PRIORITY_LEVEL_NORMAL:
+	default:
+		return AMD_PRIORITY_LEVEL_NORMAL;
+	case AMDGPU_MES_PRIORITY_LEVEL_MEDIUM:
+		return AMD_PRIORITY_LEVEL_MEDIUM;
+	case AMDGPU_MES_PRIORITY_LEVEL_HIGH:
+		return AMD_PRIORITY_LEVEL_HIGH;
+	case AMDGPU_MES_PRIORITY_LEVEL_REALTIME:
+		return AMD_PRIORITY_LEVEL_REALTIME;
+	}
+}
+
 static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 				  struct mes_add_queue_input *input)
 {
@@ -310,9 +327,9 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
 	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
 	mes_add_queue_pkt.inprocess_gang_priority =
-		input->inprocess_gang_priority;
+		convert_to_mes_priority_level(input->inprocess_gang_priority);
 	mes_add_queue_pkt.gang_global_priority_level =
-		input->gang_global_priority_level;
+		convert_to_mes_priority_level(input->gang_global_priority_level);
 	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
 
-- 
2.49.0

