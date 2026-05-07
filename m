Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A3ECD343F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 20:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6553610E59B;
	Thu,  7 May 2026 20:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lNhOa++N";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7EF10E59B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 20:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFfvWP+ykNaBKXOBEfjReSDaUq5lPT1xsLw8O6gpMipjTVGZpAEM1ldcaZ982VoKNLFz0hWCl1knSyPhTkIwzIPRlFBryIws9jvT8nKbci8XnxAKCCbqiis7V3yP5HwOIiZH1U29697yHdZUOc9Il75OowUcxkGhAaImfZ4hIBUX3Yb0Svpixm2tM1oJZaiAfuj/QV6N62xYdWGb63sLmZKG+2MXMAPZ/ZD8uHk51VngsjZJJ59eVZCkilsvt9IWiaE67SGs9pJrBwEMzCTDsqw6W/HH5X5a6ksahUbIDDwq1yxuSIEMhW8kyarAfiCSLTWht0j7xCPR0XqzkrC5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scqXiHzGLzBG2yH2FVMHxz5vJ9hjAevfi6uOVECWQ4A=;
 b=nGha/yfF9olgRiXGx0LQnAwwFj/JvcjtDFr6gp22aF2Uqb8WRUluNpdgyh/39I+upXnYUgFXOtmxfff/1BIyp8O3nGHx+RlskmpzOKgGUqIqFmsy5cbpYjQpC75jNzc6DZ6vcgRgwnhI3aZW0pUkTeipE2j2XnEHAlHmAVA5wMhgOcp38bwvTdHEMJ9Ktik9/LXiM3gMvfICyLu1yKza7j64r2EsEI0Hx4oo7hZcH7uTRKwRA2coPvPimQsAv1pTgLsDWEq/8VjuvGA0nPmH9oim8Q6lvh0m2JQy0xt7h0Xg+hVcI1AZYpyI7ryw5sT4zlqcRBlkCQ4vpJ8fU9ZciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scqXiHzGLzBG2yH2FVMHxz5vJ9hjAevfi6uOVECWQ4A=;
 b=lNhOa++N+VXrKuRv0OK7A3mIZgsVXJgXGZPf64xGsncva6N32bPUIFMYA+0p6hsNyUxwZFXZaIbMcxug5ZKEqXhpNowGA2uZ3rrQk4m+dgdzW5LEWIQAVaH32XQSVFwE964elWAV1ppv99+PH4ajCLK2WqolTAbzGUdI56QBGxs=
Received: from DM6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:5:15b::24)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 7 May
 2026 20:04:25 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::d1) by DM6PR18CA0011.outlook.office365.com
 (2603:10b6:5:15b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 20:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 20:04:24 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 7 May 2026 15:04:23 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
Date: Thu, 7 May 2026 16:04:08 -0400
Message-ID: <20260507200408.208219-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: d783003f-642c-4c76-b3a0-08deac73d620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: g4iqUSgoC942B1nhpwoJNgg+e0TaQEQ6DuHMCIOZdaU+UUE6+HGVfy38opOTp2qwjR7oM4HBC7OHFSTyiq6p38CrieI9dCRPf1iZBWY0Asa4f7/PnEXzxAE+7znEKB39XMT6SOY/ORguRXufJ1M9IMTwG0TWe/SXfK6V51vqNOU+bJTvnjQzjAUlX8sCryXh63gSPebbNAy6+ePGWzmDSh4BECB9IaD/0w8Pbxb2LplpcsUKl/R2HVgTS/A9J2G5I6FQOowD6jIEAnxzrxSQJtUrn2yMSor8cMqTX3cgONpsyWpwmctLOEJ8xZOn89ucdzF7x5A/bf8tMC2zgBiHJb1zadRCcfpViN43nv4/RXGtQwC6EqOsV5Jh7SOeZBIiC6UXKHY0iuT/VBeKMnzoVbMUswjtmnP0spuEbUZgG98MG5lSt4891dndLyuYBrcQ4FELFm3waO0U0HwWL4rrKZOQYFLNQNoxqyygdxF0rVXbZRwAzwYC8awQ+EZdTNtryucWY+b6Oljtb0Y/jzwlIcvI0mBmcy+Cryx+32wfq0jQUx0V73XCp/6BvwJuNXTS9v0sokSX151FEJGGDBMp8YHTAG5tC9P4qeI7oju1Qsbo2bwGOHAERibsYGR7h8dRCTLdUR+Cg0l/C98xxFQdA9tlZf7K8m5a4H90jTIKF7/isGXAXIKldoHzZOEFyU/UNMYZWRf/Yk25rcSQLSjA4wBH2O1fazSWwQ9kMKqyok8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ssKwMid5qTv/bAuTUiIgFLpJLeFhjbzkVcoiXyGiDhv6P0uhh6BFmthKiw1Kw7l6zo0co+fL9c+uZjMSO2oePr/xq/GFMXZpDONdAhhKjiUC7pQ9xQSJEtkkV4lLnBu6GYsxNhMt2DFd+hO1BbxTlQXbIovNCVCg+aPtceY9GyVW1tuk9KlR40Dvy2adjVdJs80ecRHNQ82po/mWRQNgQwzmwf+Ct9/esqt3ZkDCSgwIdqHarvz8BoXJXQll9JLzWV5phQYfgh3wQ9ykHqiOZUc5ubk7fU/Y4qnnxkRbyJeeO3cDEAYAQTzw8h2xcivUbrYM8ZxNbnaKrqN/iamDbG/bytnnPnAeZn000rJdv8GFSVX6iYOAms6TdLGR65d96BB4U8q4ST0XNZX6TAnrDOk83jKsktsXWmVdky9zPnD3jpDltTl6pUMBv8vwp92w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 20:04:24.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d783003f-642c-4c76-b3a0-08deac73d620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432
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

The process_info could be NULL if user doesn't call kfd_ioctl_acquire_vm
before calling kfd_ioctl_svm.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 25b3ecf85f30..72cfb4a6ab3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3732,6 +3732,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	svms = &p->svms;
 
+	if (!process_info)
+		return -EINVAL;
+
 	mutex_lock(&process_info->lock);
 
 	svm_range_list_lock_and_flush_work(svms, mm);
-- 
2.34.1

