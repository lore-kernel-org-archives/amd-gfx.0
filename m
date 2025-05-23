Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49258C54ED1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 23:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583AA10E1BE;
	Fri, 23 May 2025 23:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypAhNtof";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F19710E1BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 23:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZShHenjq4uDpPBfj4JVYH1B+3JBpd2tz25nRq8tJMPC1CTaO3j26tyhKYRSqMTF7WPh+2Mewl0fJ9j6a6EwNXfytWB5pNPJGWK0CMPo4TL3lLuCLewM9voTKOod0qpxx0eevOn/fpqGSYDryjoZ064oSVLq6//KrYxjHTh6qGpU174z7jJ+08IYb1e+bSXPgbntP27qHGMkjHA0/vCNe/zdPKGDX4u9Kd+0YhaG41bGo8qkvFDDd0vngWwVh7007frHILwL9/MoDdvwCYpHMtaMUgVVJGAYIRP79dMm9S2Z/W62h0Nif9A+nwUoTLw+qCzp2ewFtO+HbgfLD+cnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHfHmE4dakyM623hjopmB7ZiG987abWwH1IkSRygRkc=;
 b=FCQDAEfOxZY0wXgHi6dXq3+4WjnSrImZzrTopFzLCpExUYHZvhBJ/yXAPELvpjEr4+8JFZpjjBoSDV1KWXWI0J6MVctNhRbe7ghSAvmaTw6Xlf7mkNPC6uHIXHKcQTUzARSmq2PzFwOrqZhz4SB1cd5PkNtkuJXjJ8nNZnYIi2lq9X1Ngi+ehcSiNxiRUNrkwM5i7T0FPWnYoEqSEmIrgn1egvcOdbYTprsq82ml8kbiG3vMOijiZMcxE9YsgF2uF/lAljVh6adBrYPBlnA6rzVEP5cjGGKio/9WinBiLM2KzjEuUYE+owU3DFpiFeFdjpSfu+W6sBKKV1otuW8USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHfHmE4dakyM623hjopmB7ZiG987abWwH1IkSRygRkc=;
 b=ypAhNtofolaK0TlteEzHvsGQS9S3/AdcSEQmbXxPJUf8ohZzwAMKaNcgDDLojMgmgIEPrRq0EuI/GoL3sZBcn8G/Xy1imTSxbLTZsLCVFD2nggA5OwluLbzg1GZL6FtXz1T3QKlRWkLuwNqcxTc6DDNhXl5xyX/pMrgaroqY8Oc=
Received: from BL1PR13CA0281.namprd13.prod.outlook.com (2603:10b6:208:2bc::16)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 23:56:34 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::54) by BL1PR13CA0281.outlook.office365.com
 (2603:10b6:208:2bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Fri,
 23 May 2025 23:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 23:56:34 +0000
Received: from sclement-U2202a.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 18:56:33 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexandru.Tudor@amd.com>, <Harish.Kasiviswanathan@amd.com>, "Sunday
 Clement" <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Identical code for different branches
Date: Fri, 23 May 2025 19:53:39 -0400
Message-ID: <20250523235339.828608-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb5936b-39c5-4b07-cb5a-08dd9a557294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qt5ktmFiL9BXU+Kxe6j2xDdW2hpSFWM1tJs0dv5riLpHE+bbNP5ij5/Kgd0y?=
 =?us-ascii?Q?6sxEUDV2lYlkJEegf+I7a0GH0s9rNuBZIU1d4chLR3NTxKezQIQFShzQd19Z?=
 =?us-ascii?Q?anFiYfOaPq8+uAS4I/SP74KRjlGe0ptbGrTJWcxhbMZ+pqaHfy9/wAC5ApGM?=
 =?us-ascii?Q?cWquTg+JJnGXZFDQsozFWetKH3pBjSwalLyraWhOXelxOkHSgx6m4p32WVyP?=
 =?us-ascii?Q?3q/I6OxC784KDSzbPXPXV0d3qJ8At6T1PZib6IeXLwAhmrn7+gs+Yyeg9FVo?=
 =?us-ascii?Q?2FLggMDDs824v54Y0bqbgJMVE8/UQeyOB3E15VmihdVhzGAZlbeinNDLMLM4?=
 =?us-ascii?Q?S2YJgU7H4ziwWnBoOLGQUvw7+jjV+vcieusBeK+eYoPWpkHhtSkxfEVQUR/7?=
 =?us-ascii?Q?SMeJO+QILxfPKc5jUYZvYR6fSgf7AqEXyh2tcaEpmTDZdIEnXcbytCbiKQ7O?=
 =?us-ascii?Q?AwKN25BSifQFEstqs8ordaMPXNmsKEHwnkhuw18xJ1in0+hKzGQl0iv4tSNN?=
 =?us-ascii?Q?QSCumku3a15+JfP4rlUL2/0Q+8QAZtHiGPB+/Axr211SyuWss59h1Bia5Gob?=
 =?us-ascii?Q?Ea5KeV40c7NSmRB7tO1r0YuDzlW1X45TYzTzcQ0lBHqBDJhxe+CElkLxTHnE?=
 =?us-ascii?Q?Twp/+nYZx1vbjV9c7MhGoN1OWh/6gXOgmQcXnphEX7Gmx202bjlCfqQDz/tD?=
 =?us-ascii?Q?AlnRpP4gO9kVRJlsRXiqoH2xXkyMQYpWLLNGHTRHTGcWNyU+MPUHZiVANYIJ?=
 =?us-ascii?Q?ulx17BuULoP9vvtMGr9QgZasG2V+lOzFCAJkR0V0IZPGo0ThM97z7d40gs7b?=
 =?us-ascii?Q?7mms1GCL7Md8ifcG6pFZkmisL+VtLHdrboFU1POd3XqkLmYd0i6L7cz4i9Fb?=
 =?us-ascii?Q?lWysdtG8F5lS3lU4Zqad1m+PHL1Dp6o0QX4i3BQjogOUmNqmiB1Vwiq1LMLI?=
 =?us-ascii?Q?4ut9qmuBLCQOhlM8F6ev2Hwl9o2zC4WqD5lh61oC8/RiWWdFv/SsulY7yK3v?=
 =?us-ascii?Q?d8OVtWG/z8TyFul8xAmMyrxY1FNe0pYmwqixy3CgfhYxnso4GmReFv3xQTOV?=
 =?us-ascii?Q?Z4qb+al/cSCiKeis3BEZthZsfVTc84QnJazcMQlzrM+Em7V6LMCbJTJ4CkWu?=
 =?us-ascii?Q?zAfrf70b7fTr8zhFLnuJMC8LsbjXl5q9ywIbIBtB42/PRFcWs0jR2xze/Kvb?=
 =?us-ascii?Q?hmQGLaRGs2A9BrXqlfQLRFG1n+ZzKZcfpJ4/O8RyDNBT1oXbFYtXtsHJvrTn?=
 =?us-ascii?Q?LL4PozBaeChdxFR2Wk4ma7kq8p26uYBJNzxTmmKNbkh8y3mW2jbyXRiXwhB6?=
 =?us-ascii?Q?wpR5Ytul2VJNAsLqZf5rozSu2ERvlcinjgL1qiFDyUNtxeyZDR6NAVMqAk2V?=
 =?us-ascii?Q?M65vwLVLLdhNrd9t71CpfRdRRR1v7eWNfZBFM6QYqwsF0r4Q2ldqWd2lucS6?=
 =?us-ascii?Q?koBvFadBul5D190k6TMeJoIuSA+hio7czH69LZ6y/vmkKvhzuAqylepNsAUG?=
 =?us-ascii?Q?mcapQbnMZznb/Fz3EREz/JmXFkFIOV0jEPJ3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 23:56:34.1296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb5936b-39c5-4b07-cb5a-08dd9a557294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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

This patch removes the if/else statement in the
cik_event_interrupt_wq function because it is redundant
with both branches resulting in identical outcomes,
this improves code readibility.

BUG:SWDEV-534537

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 981d9adcc5e1..25f32771b228 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -125,11 +125,7 @@ static void cik_event_interrupt_wq(struct kfd_node *dev,
 			return;
 		}
 
-		if (info.vmid == vmid)
-			kfd_signal_vm_fault_event(pdd, &info, NULL);
-		else
-			kfd_signal_vm_fault_event(pdd, &info, NULL);
-
+		kfd_signal_vm_fault_event(pdd, &info, NULL);
 		kfd_unref_process(p);
 	}
 }
-- 
2.43.0

