Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FADC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 08:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBBA10E25B;
	Wed,  1 Jul 2026 08:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S5lwMpjW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55CB610E25B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 08:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nM8Zxc5ShkQkQCE5tfrC6amq26BvQk3yEJNZ0OO2tXrCDsKdlvs0V6oHnSMiEnSGdsc6x1fb0Jw94pVeoXAapzCz143ftd4ZmKyDCsCwX5+WOJm6jlvf6waOLgfjBHJyow3UkTz7tXyWotQAWoy9p98itu+JvewZidzpt8uOI1PzTnt0AVyU2iBnjwyd1NAtP3a8O0dd3Fnr/NxuURa+MxLN6O+7Ken20X7cdxj8gOvWTMxc/pCms1y0PoT9qVF5or2Fp8VxS4EQ8F+Yxi280WjPrvCQP6JtCeObxlrMj5QXYJ7YKph7kAb/Zt5cXkF0KchiR2QAnEMeSoJC94cJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qevnIeAYDj0+S/sE8Gl+WQbkSJV4pG2iY/rW7tZx/Jg=;
 b=BPJlVSuZltnIl/ueSxnygkYPe7a1xZHTjVmP2HAaP0X5wx/ECJs4cjDBDldouD0055kWbhvzG1C3ETQJE4ATDinUtI9hUFjDBcdjrT0EusjLIC0tc1IuXIsmsFc0Cm0YSrhtQMpoMlm7PKbNkhmwhCeT9qlcOz+cWDFAO4lJ9i7yOlYrYdvfkJnGrDdZbS8rNtLTN7v9NLuVG8Cd/iQTCKhNlBKhTl7y/cka9NqDEcIEP4ITvucS3wJ8lfWw7zmtNmg33vTq0Mc6ANYead/5clGM3i1Rg2jQIzxO5m0YZIsKTJXm/5huMAyMKkcy9OYbdtRo3UEQOCJpDInoiWxfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qevnIeAYDj0+S/sE8Gl+WQbkSJV4pG2iY/rW7tZx/Jg=;
 b=S5lwMpjWFRIIWEX5HTxlaDLlzalkaoNfKnrN8q4cLxaL6swqgBhmFSd6LDiRlrPxZPIRPQfoBhX4n/xYqTMca5rP8z/hqj9gYJnsqyqKS/yOWeBxWdYjDDUQdb/6934XwLaOBo85DFp52sv6g6/CeDQxNNPOkGXI3PeR4KWTQpE=
Received: from SA1PR05CA0010.namprd05.prod.outlook.com (2603:10b6:806:2d2::12)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 08:14:59 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::d) by SA1PR05CA0010.outlook.office365.com
 (2603:10b6:806:2d2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Wed, 1
 Jul 2026 08:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 08:14:58 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 03:14:56 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Felix.Kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: properly free secondary context id
Date: Wed, 1 Jul 2026 16:14:33 +0800
Message-ID: <20260701081433.11134-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: b54e793a-b386-4499-b35d-08ded748d768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XHJ0JuT74tZNV/x7mkaKbGayqwNE735DyadxrEN/vyQfd0zyxswDFoS4QSh5Qu4Hoqis7lWe3nJd3SX+OkZ++XoHJ6fho45ClYpAA8e+0+F1v/Hiukz+AGp/L2R5XnH/xwp38ToQAaRY8kSdunInqYXZcGQzRSLxVSn5iNQoIVZBOrFIyMxR+rTDIa7YEDEbOVEeIJoYhK53PYkerRLnuEBIClh9h7puxqgXXa+BfoLWU617kRiFsnR5Mk+h/P/r8WE3Lh0IunyUVlNBrJJ+cFcWrZkBYQsSfnjS8QwS5Kb8+m790IP5Rk8vRmQnUVLxxHj8EnnPthh1g8O3FG9q1L1nvnK0f+QOLTF/GZPjW07W64Cwl9fHq3PplSbkZF7EoBp1jrOHpPjv7JJU5UlUL+WwXl/sNRSUDqN/80I/15a31qswbbGz5CzLlYvItpdhbJV/SCO3HDvoRv0EdEz53n9K3w+1hrdPH7s8+6zAX2FOynLTkAEPhDrDcsWwOs1HBoAioD2LdQo8cLNdzqGElUUPJYoYNWYwQpdX2GCC8ToG8mowfFLy9koLCO5MyqfLNr/oISbQTUi/M7qWPrslaYl+OpIRs1jGVrcAcsrHUyNHySgMnQEfZEKlMEV2bsMUVGWPtQdbRDZVcONMLAqYQHmgH09/WlqTJaRRXEIYtTyfLpGKsbnmDAmHv1aKjlf/XXjq4b9lTWLrOea0St+zLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: znoSpaJ09ZpNuVBW0qtylWtMD4jBkOG6slbvYtHrICccXkeThgMDuioef+RE3hSPNCvw8AlYZyTmBUWpvbLbrw/b73sDRysRy23fsmK8KET3SLkn+dsy0ix0RO4Mp4FwWAJRHQLGu4yiPFVipz6mKH0CA3t3Zh9minRBwmmNn2MbsztaivF4gAPvNkAx4b9FPKb887yYIYjAFL0MRZI/TODeU+RxEi/H0UWNxMU56bzk4OLhOJbuaF8UltM6jjPS5pKJg9XWBdPW8Ecj6dc3ee5Ejb8m0nzwCqjYyj/KeXONw0b4Dq0sb/xupBmvFQfwhFZZxfiIF46Rbw8lPjbLmammCPGNXZvYbtRk8BVqDE3MTnQTdpCtNqy0V4z31NJpvj9ov4OvAvDNtAg2+vj9kToAKYt59+Y7tNcz9CfoKPgbNI1rb9hoUAsFUO7x0cJu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:14:58.4151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54e793a-b386-4499-b35d-08ded748d768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

Function kfd_process_free_id() should skip over
the primary kfd process because its context id
is fixed assigned, not allocated through the ida table.
This function should only work on secondary contexts.

Fixes: fac682a1d1af ("amdkfd: identify a secondary kfd process by its id")
Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8e701dcda8ec..d0c083e018b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -931,7 +931,7 @@ static void kfd_process_free_id(struct kfd_process *process)
 {
 	struct kfd_process *primary_process;
 
-	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
+	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
 		return;
 
 	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
-- 
2.53.0

