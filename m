Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F0FC87FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671D610E406;
	Fri, 25 Jul 2025 02:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfz0YG0v";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B910010E406
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVvNjMkRBJUvR91BWm5lGHRueVJTbQlOYr5dHIJPcAb1i7V1Iqce8ZrwNrNP/HV9zaCYUaPCJ4su93npcYfjew/UZOFFhTtzlXp3L5rvQPEHalpjnpIrMEDXRS7UIyCk9Aoq2JkoF2Brlx/69hbXuNr+jx4jjQMGT2H9g7mnKaKwUd+CqA0uI9hPJ/rJmVhFbT37Wm4AEmRrqyD2pxxmHDtMcZHr4vBY+SHiqNWEJlVXG9dJoWSQo3M3PP+zUeV2d718B2CoVR+SmW+CTEMzzJRYDYWBxjhpJoTa3OL86u5GoaHpSd8rnWmfsu7PiUZjJhzaeyPy5aCNQPEDnFwO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7+svn030H0Ud47LTVIDK6unQjnqIhNEEODqTu55DXE=;
 b=ebcdUWsMligfkrHhjDiwtrmNRAm4zfbJWqBcDHlfYs95b2ztLgEXw03v/7Bu2GCtcOsR+Jfly/nPzbmFBuyshRjovwcRSIfMwodoE22lmqxM4CJ8wlnz2mb6FFkMoEH42l94cCiDjqnCxso4bM6O+fEIMS/8ZbA77fOnb/e+fV+XZTRzl/o1ztEH7J48p1Rx9YlSCPVUP3zw/S5BmV/7q0y46cdxn3ENNv4T5KZMONrYSlRpZU7O95Z1V024fdhcks+u+GJhhYxcEOgvx+CytG8I/lh0ssMBhPvQvG1r6U0XUR4ans4sde+HbZz4zEUC2auLBH5lgaFTErlmHbBQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7+svn030H0Ud47LTVIDK6unQjnqIhNEEODqTu55DXE=;
 b=cfz0YG0v/jpVj+LAB7/Bz2yhy8Xn6rRP2K34V5SE53Lls8VbYeuzkSyLKFjMDUMglV6y45/CEyhtKUAv7iWpWDOj1hOSSARrtot6zmyERdBhCyV7ugNvH2wOEFdRH2RvdFJi9H67h6Pd0njDyoHyUo7eYzQvJoGyvBwe4QmdV3I=
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 02:43:36 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::e) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 02:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:36 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:34 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 3/9] amdkfd: find_process_by_mm always return the primary
 context
Date: Fri, 25 Jul 2025 10:43:10 +0800
Message-ID: <20250725024316.9273-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: a5872d7f-2e52-408d-9b29-08ddcb250dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0nWN35mXL9xrZiWSbDA+s+We9PfJO16wcljizMi1CpuGyICoQyrQQ9jFD05J?=
 =?us-ascii?Q?dSjkXLAgAWVJxV1kbfGG+I1Mn18WJcSSkXXAglB7FASVX9XKJJ2V+pcPT/ia?=
 =?us-ascii?Q?3Py1Ik83XmIF201VgsjoqrV6LA1QD36gwPcorBytM8qtjn97j6oKPFvDuG6d?=
 =?us-ascii?Q?ReDfY9p78sXd1RUtCcJNZgqdbvKOKJkNrelFdFV95AKXWX1whvkTnYT4xUoI?=
 =?us-ascii?Q?bGHomtVDIwdQxIbrnFZ2oPjd7J+YHs2Ys63AjJ6VRPiFfQxU+oKn0gipiE7e?=
 =?us-ascii?Q?DhcFZ9OqmSQ2umI8a5Hr0SqH/l99t6FlgqGDJF7ZpVeZJoKWk9474t+Fc44n?=
 =?us-ascii?Q?UvKdGVjf9eRZh81BKGPj60pODa+zcALtUqbl3R4S7xIza+Nryp4LPB/5uxqt?=
 =?us-ascii?Q?dwrApXXlApcMO/C32lY7k2BuVOurdwtNkPl6l7aKkc8AVQaLKrXkzB6BCMsb?=
 =?us-ascii?Q?O02oft4Vp8hnJbhfxgu4Pvvsfp/yKyywcQ93tX4yJIa2lBZlVECKJrZPt9fp?=
 =?us-ascii?Q?vuTWaQmYhQZpe7drTAm+PQyb3NTO2DKvM/cIaxmN/YcRT0HbO2mEppO+fLSH?=
 =?us-ascii?Q?hy1hH4xC7QYFbPY/soZj0xtJe+39ZeXPE9fuOGeXn/yZiJWv5+vbnjuFLsD8?=
 =?us-ascii?Q?Lm5waiNP4CL/KPqz8vJCnFlVwPNFdaKRZvGbHFXDVttFDeqGHp6vEtBz7Ptr?=
 =?us-ascii?Q?pHABlyaU1jrDfHoI1+/gBMM0VyfnI6+wOE3J2PpB1JYsCXgugiZEurbtWxe/?=
 =?us-ascii?Q?qxBlPMEe8k8PHno6CfDEHN/VaVfY0OpHkXhvMgfHCe/eiqo94wBun7z52z4h?=
 =?us-ascii?Q?hTN1tT0DXE3abseljJ+AaAyztmz5GmhWTauIUKtK2sWe6U6sDqqPp8Oxfpo3?=
 =?us-ascii?Q?S2XMJEx71ZUA84lG9vYVmtMPEvjaxQZMowRlDOdkO+4zFI//TilKG85d8F9U?=
 =?us-ascii?Q?nPbbAC0WOUaVaP+MFjFigXORxLvW+5R94bfx62LCZFb7qlDVnHWYR969Mu5c?=
 =?us-ascii?Q?tWwztcKF6Azimxocgt5XcNiaG1gSUa3RyScm9gqdEv6MWe4CliqqLWxL2ioc?=
 =?us-ascii?Q?+raFpDNvrDMvzCrtsBvJ9d3HRJZDCo/CmXmUmqd9Cxf57pKLsgObE8p2HRbb?=
 =?us-ascii?Q?xqzQDfxiwR4aft8pCa/cytX2AFgUl2xb3TLgrdVDhrYwdJxMWsCw1yNwFPc4?=
 =?us-ascii?Q?0uRamtvf6KbAoX9DDqnDuVrxSjt0/cckaYRCHGZ/GWZ6Wuidk0isN001a7Cn?=
 =?us-ascii?Q?eq8sbfqLw8qcBjk84WcYgiXEnCIniKmp9gjtEhdZNhfcr68jvKj0RJm8/Gkx?=
 =?us-ascii?Q?yEIJ7F7rW1vNOzINUR5KZ0MEBRE6GI1Bl/c98FGkYaGk8d8jGpfkEITKyoDp?=
 =?us-ascii?Q?SQxrSsTdNY7NwNNdbUnW02MNhm9zKYcQl8RQYzLIflhkQ88TElPzmoddVQGs?=
 =?us-ascii?Q?fKCrDtLaCJ1foJWWxTtHBborVa8o62oawwDOQHxZircDCdZUTPI57ouDByMX?=
 =?us-ascii?Q?SXboOoCufbkbq2VdHrXDTP6/1tX9Am5zudXL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:36.1414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5872d7f-2e52-408d-9b29-08ddcb250dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Up until this commit, the kfd multiple contexts feature has
not been fully implemented in mainline kernel yet.

For backawrd compatibility, not break existing use cases,
this commit changes function find_process_by_mm, let it
always return the primary kfd_process.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 955ca8725bc5..3f4ac9122203 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -935,7 +935,7 @@ static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 
 	hash_for_each_possible_rcu(kfd_processes_table, process,
 					kfd_processes, (uintptr_t)mm)
-		if (process->mm == mm)
+		if (process->mm == mm && process->primary)
 			return process;
 
 	return NULL;
-- 
2.47.1

