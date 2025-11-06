Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC17CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE5410E315;
	Thu,  6 Nov 2025 06:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jHLnujso";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705BE10E315
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBknaDOrGkxgrhSOks819DrKxCiPrC8o8/vh4E7KpES4ViI+/Kfu+99VKHSCi2u8c/McPrQx5BOTiHkbbSbkdECspftBBJILbScvODoRD7GVvbA9coIRg79YvZ+lvR0JEjPM/YdiwCDkRvijWYCSTQ4qr2yGH17HaZshocA1MAIPylP1v9wQ8efu3WJIMi3gTlHUSHWb/Y1SNc5n2H4sxs1txExgbm2Xxwj7VJDozfgM5KtfOtI+JLu2f+X6yIQEPboYcgCf10RUe5VoEVWHSj2DWIwOduVHOESb72cUPrUh3Dpi4BdzuWbwKRCCpIYWoLAwGlhcmcWfYUwRq42bVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb5ju1pz8YhtNAEkl485/L41L0Xtie/zPj6MEdOl6sY=;
 b=ROu/mfSW+/aDKN+Rq0SpFzowTSNjdHv4uRi4+mfES8kP6vD4+R6u/QEqsl17chqQIPhFgD0mdfvfoRU1Hywf++EAMXpQwlfCRiNjCnMC8WdpSLMwtzj1DhEzX+7Hr39yTxh4WUVA4d0MFMJdGLgcG0LI/ETZIB7OSwWzDsu4tnddC1854P53lX9ngcUlC0Pv7h1TycScAvk71exQynjl1v6lhuQ9U9ZsPM5AFCm0HEqZL393OR/i8REaE5lHqHDu3oonH5Ks0hTQZnlbAlBcw4M1WLwmYybaguz7TnHTXFCE/RSWZ4rxI+VL5XIrb2SBJJ4Bn0lmqCDed0Pl10/t3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb5ju1pz8YhtNAEkl485/L41L0Xtie/zPj6MEdOl6sY=;
 b=jHLnujso+ecduS1VzCVOl7VLyd2epAf+X7+aO4ZBOCJgspwxupYC/dQ7AtszjvUkmBMOtpAlYSfjrndIPO12BS5BNyCKWhy+WXB/Xeq08KP7g/oS8/Oxb700N+H7g5g128newtXjzRKussOan5lrGiOebXkUFVT4hQz/tdnTG7E=
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 06:08:10 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a0) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:09 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:08 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 03/18] amdkfd: find_process_by_mm always return the primary
 context
Date: Thu, 6 Nov 2025 14:07:24 +0800
Message-ID: <20251106060739.2281-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: f5af9ab0-1bf7-4980-b4e7-08de1cfadc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8pEDOHSrQbN1V1j96PaSCmVNOD0u7JlP077z/F5Ko10KicTzHLaMFg/ZLmjN?=
 =?us-ascii?Q?ndMisLfdS0W6S3lElbb4N4kYpdiAcmpmdGhvhO2BmS2zW63yfrl9wQVB6BNl?=
 =?us-ascii?Q?alHFI0sn+D/Z690kcMM6yKoH6Bq/6QzLeNQ4gp9Bn5MYq9EmO0HknKszzkBO?=
 =?us-ascii?Q?lFtYRoD4+NrrDAyrtUVWOYnvRsLPaeZba0pI7JZRDDbH7/04PfSsJGpz+HBH?=
 =?us-ascii?Q?C/i1XI7NL9KaAOem78k2QL/hQ1H8hlS/tqmNEm2R1rBMQcRJDJJkcpE2IlJQ?=
 =?us-ascii?Q?BzatL9l8pzRst4g+Kz7Pct6s1BoHB/CCv8OImqur9cXxpdzHq8yNukNog4HA?=
 =?us-ascii?Q?QGwb9xjtYpX3SZ0yiZWHSKmeil41ARlwmsVjkhjgPflZPa57XEPqvrvWFPGT?=
 =?us-ascii?Q?MESW+KeD/O10SNm3Efz7DpXP7gLA+EK6DvzymVyWlTDHyiHueXaacC1IR0HI?=
 =?us-ascii?Q?yeluijtaaIlM52cmhrlLh5U4D5rU/VlkAJUzTVMmXDj21qHKL7B1mF/zliE+?=
 =?us-ascii?Q?2K+6cjWhaAkNvu9bvOoumgnmMPUaGMLWm0Gbr1RGITOW/wnwB4VJku5fGiVw?=
 =?us-ascii?Q?JAB7AINW1RIzKZobL6xM3A3+4B8DWLbMpwkEm3u+7PdCDUgT25OVdr0qv2D1?=
 =?us-ascii?Q?ekfk8gBxAjLOD52W5L3qv3xKJnOO1HoFRZlrVGawjlBaMEQ3JCqHb2d+kecB?=
 =?us-ascii?Q?mR8qR1rJQrpmKeql9O7QrdAA5Cv9BopKgJIBpGTcW0uI+4HLWboPq8a2S/FS?=
 =?us-ascii?Q?KfGBAON+bo6TseuPILDPPyA5YVc6rzhDOQYv9mwT3btiwE0S23DfVgNPIQr4?=
 =?us-ascii?Q?qxNLJyTC2wH7CaKYRNQyIv9g3N1kIDHTXsiewLj0UOxT85ivA97H3CAmRH0i?=
 =?us-ascii?Q?442pO2SU9Olm8++p2YlrP8KPZSJXFfD0U5NCUXKhm7eprB0oi0kkQIeC0OkV?=
 =?us-ascii?Q?X+Pro6yVJKveCIyRb4I4oPIbnI3+uDu4CPRBEvrSz2FXlRnrtIU3df3k9cDS?=
 =?us-ascii?Q?zUkPryjVOaBuF4/2XHDbdSEu9gwePTmgJOokVauWwHBKMt5Ml4/ZNEnqrT+n?=
 =?us-ascii?Q?y+IShioHPuvDJMrLZwq8/EeFUD1XwXpAOU1duEVqLwYCsocMIOzSnDXQa8F8?=
 =?us-ascii?Q?nDnVz0TDkE8HQlVKgA/uGytrAcGcLYGtcs7tX2i+9rp3P0eFi0tTiunu+Ej9?=
 =?us-ascii?Q?e6RovOsBeWaZbXUMRbS7ACLj+8w/Urqrqq3ZG4yCliZjcF6CNQIgkeEf0JX7?=
 =?us-ascii?Q?6oBB47InaYIo20UgXwmbgDS3tRwzmjZ8VgdQBvdKLmvjhLqJZ82isBVb2RhW?=
 =?us-ascii?Q?O6XieuCmpa25xEzeVonJ0ca311kdMVMEn6g/8JsNE4PuVMwKz2RZjtiUsRBV?=
 =?us-ascii?Q?vczm6g5cvUFYq0CASZZiGUXUuEQEQAEjNpozm99JPNxEz8kLsf037W5SitnI?=
 =?us-ascii?Q?LsvKx2WpcpPKiuB/0k8OMl6pI8XOZhBaesd4eSq1uOPmQsL0CY5Paz16RlQK?=
 =?us-ascii?Q?Hz0hhGdQcoRhM5LBXrMlk1xnnCGoGrTRqltDL17NdiviDbPhBWJHfrZSSw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:09.9782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5af9ab0-1bf7-4980-b4e7-08de1cfadc91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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

