Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E724ECCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5CF10E6D5;
	Wed, 22 Oct 2025 07:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RoYvazzy";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E6A10E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCAxjkOtcCFXyvLNE9CIgqC0dU5V3pSKm0rjP/1HXJ2A4MnRUNJGeh6xcr7D3SizD0zBsPd+tJP8YaSmGG6yvvdWOu0Algx0chdALaWIunMOQ/EYwTs0Wi5VWW53qA1QwlCYpJxXawY4WoxoInBWsc8yvjU0u5UHRBOjyR1RbG559LMURrY9wgaehyT/rByyfNdQGJLuEBthdkuvSduV7PNbJWX1jjwyNqlpwMYatdU9+KBZK3nfgnAPNN9SZsr8NHQu7v+SMEhpJJEheicVqXZAiVcvZaBnU4hZPFbBNuApyOMbbcTzHq1rMslJRl9Pk7cACtqrMkUySAT6HtnKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb5ju1pz8YhtNAEkl485/L41L0Xtie/zPj6MEdOl6sY=;
 b=uBcElu6YsT1z8Vxc9C4PzQCdwHs4qohlnXewZkYadZe3R7/FvON6XuRYL6uHq1YRWgDq47b9UDOXJsoKs8oq0RIONqDwmYoJS4XtCNFS+M7mE4ZOmNLJ1r0uavjkRCVs3uXSzIyR62DYQ3oQI63SJWqtlqGk4HlWDQ2qYdjHKiKCm3O9aE7ZtAHIico7tOWb7JuInCMXnJP621XTpxdAKDHbZVGpBUUJwkWe7z72g8G12821BzuSvgHvBv6ZcL0GYjYBH3b+3OTD2Liv1pFH60lXANPJgby5GLBhPNJuCXAxlBqsIfpCL3f8egtus/pgY8b6omlDkj45mU8k9EU9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb5ju1pz8YhtNAEkl485/L41L0Xtie/zPj6MEdOl6sY=;
 b=RoYvazzy/ekNbEwsOjA1+3wc+QV2PwIJnADxNJvoKK8VmqkCE8rwBJkv4kAbUnMcfmVryCeriQZOWzb49BXzwRoAZ/b3RJfzjeMRbnqg8X/hEiicE1msRRtx7SM4uhaovA7TTk5C4ZoitIZIU/cksYumWEn+KXEOqvCe/+0ia7Y=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:31:14 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::cf) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 07:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:13 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:11 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 03/18] amdkfd: find_process_by_mm always return the primary
 context
Date: Wed, 22 Oct 2025 15:30:28 +0800
Message-ID: <20251022073043.13009-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: bee8e96a-87de-4fc7-c34b-08de113cfab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KFlhrIxFC8LM3f8AWTSkJ4tQj1cfclVrzpsrq67lEOeIJGCZ8fREyUax+Zed?=
 =?us-ascii?Q?TDXoR4NthkUxv9La4ee1DvYpVFmRvYfXp/FrLDpPQTjvHBu+xiHti88I2i7N?=
 =?us-ascii?Q?vWE2liu+veyfc5PPjkJCdULo67Pw067qYcztrYuNQK8UsjTBHvjuvm2hpQxq?=
 =?us-ascii?Q?WSaJ721aXtqZ6aLAETi0o9O3R2TPl2H++SBnYKMK54u54NNXB/HV6AN5fI4L?=
 =?us-ascii?Q?Q2gO7nJh/Q5+cu2HybgrVRPHJe2d4pkinDpSPq88UDRAYvRRYacc2IOHMywh?=
 =?us-ascii?Q?DdnP80lyYZ4VeZHJLtixHrT3DE0Njjlf7/Z7V5oL5/GITbWz/YANXZV/Ght1?=
 =?us-ascii?Q?Vlta0mNeMNckm2ycvPzjr12XwOaba3/tH9rk2Yg9GJtV70hKTgwFW/Jk/p0X?=
 =?us-ascii?Q?oAR5clFFY0uZ9ASmCpHPuWt6EF6LK6tNbwwG3jKOYzeMDBzCB3TqrIDWJGPE?=
 =?us-ascii?Q?sVAHOsNBbigs5X70CxxxP41DpZ2iyg6aJXcox9HRXdkCfO8zWOsZMTibBq7E?=
 =?us-ascii?Q?sGUJV+Ts8mpg77SJFevf06/Km35S65vb7+PcMkIZEKb88KcyjwnYgfF9vxUS?=
 =?us-ascii?Q?SRjfnVKPhkpMGFeZUnMvZT87dIkCdxEJZ+d9R/KUe9MLlNWIsKhNuAhG2DVM?=
 =?us-ascii?Q?YBROyx4O2p82ovNXSZ/vXLaGJ8CCzZ6Mqypwp+y5eZ2oqsMbw7LDd9bSKHCn?=
 =?us-ascii?Q?Km/S9qRstzh/VvjhQpYWmVkk7KCv5KAhTx0lZLBS5vIqV6ZYyahlUogzE6/T?=
 =?us-ascii?Q?Rv60p/C8ycMBmBPaMsWgytcQ8d9JOfiRjhFEGANlhCTk2GtfAthspeNXDN2b?=
 =?us-ascii?Q?VLSBdq1ygUCGLKap1q/ZmcMGNDo8GJmh6XT0CED6agKR2jk8xtFitBi01q6F?=
 =?us-ascii?Q?S5ujseTDSkXcujnb0oV6IgVMXZD40pJrHPQMphII70Cv2B0GLDoL2qB2rOO7?=
 =?us-ascii?Q?5WSAE09IImGarDkOMdtfyq0pFKdUR0gJsPeLmg3tNfDeyaAp7vNqRJwRBWSB?=
 =?us-ascii?Q?w4Cb5zYSvGiyeuMcMCcNmPlWyIQOstJXax967nsPi/6wOuvXmAjxAGVPaZY6?=
 =?us-ascii?Q?4lElvsxQiG7SPh9edMeGIwuVlVboqe2+BvqWyRzer5N5rFMxCto4bTICbz4k?=
 =?us-ascii?Q?VH2mJ6o0VizCekF58N87hugivuFVecao02vE0ipUddXX/gj44xqcYDK+Tgjx?=
 =?us-ascii?Q?YvwnLqMFXxWp3OJoM7Ke9GlL73ughVOvp7YQGZj0GGAYV6CF/IU5kXcPK6eV?=
 =?us-ascii?Q?gd2mY1w0NGA7reN4Lw1yx8v82faYYJ19/1DY0PgKy1MtZHrs4wO0fUnqeGam?=
 =?us-ascii?Q?AzZGCl68a+1JQKIHaJML8qsNEOCJromCfOrV7N1mCFIGzfkIBuiMUGWCouuZ?=
 =?us-ascii?Q?k/Zd6hBdgLC0Mqn3i4oWbymNQUb+41zjy4wFejxWV7E6ci1qHNhQ4V3StR5y?=
 =?us-ascii?Q?1AH6SDXm/RmivuP5Qni1Cfrc4OWF6hICyt6NZbVyxD/8p0zmjhXlIRNLY/I0?=
 =?us-ascii?Q?2KjAgItFQ0I2iQpkDUsJReAdKkjtb2cNujBhcqiBPjgS+E4YfgswZ3y8Fg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:13.3879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee8e96a-87de-4fc7-c34b-08de113cfab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 2a22c718ee94..051000e79e95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -935,7 +935,7 @@ static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 
 	hash_for_each_possible_rcu(kfd_processes_table, process,
 					kfd_processes, (uintptr_t)mm)
-		if (process->mm == mm)
+		if (process->mm == mm && process->context_id == KFD_CONTEXT_ID_PRIMARY)
 			return process;
 
 	return NULL;
-- 
2.51.0

