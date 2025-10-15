Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE0CCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 20:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA14610E8D9;
	Wed, 15 Oct 2025 20:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Ex0WyXH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1741910E8D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 20:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyHX8X9LFrZrW5YSMtgaYpH7yiWgAYpVNqx8pbCx+QkwT1KjgNVbkdx8yYL8Maa+8UPRt4BqVw1O4c8tjCjC8i5rJLdVz5DW+S0eG2krrpsKpQI1cVxzIEJaEmKGooznjSGA+O+6WBF+uKhzDPqqV9suwvxtKJDivOjXZyDXf6BwqukO5LKN+u7YzcTGOoFn/n0q7toh4dTX/c/DgYR4XznOcmJe1gvF0y+ZVeF3baPSSPjtmh9/QDhPX1w1lMcBA2Prqf21B3iAVyUY9GKQsaQwgVcny0WuhweONL6HF/zFVh1niZy/KTB79mVhnCUSdoWprCmS0pKFW7LHw86H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F9No7xQ07NQcWAFLklr41+mWPY9dBYoD7nNFAgtUnQ=;
 b=KOWMerBHP91sRAhL/inwxWKBfw0SFuQdQqqFPv7jxbZHuFbCVNFHtHa4Jvh2wwG5t7nilLLGEa7gxqSWpOYjdgWztR+/syvU4ueJx8BGJcSlaCBBmAEMImsnJrHayD+eDEon8HI9qIkPiVfg9cRdRoWHey1asFstBQW0I1k9Gvo1gWaTLdhLWCT0xcYqrIbsCuVQt1WNI4EIYf6awo5aSEtsXy49A28BxzLoPvjHbmS636VA6vTz352QimFcKmYxvnMLZjsumh4GxiITJq1NPLBvM4i+DFDLa2UZ2Pqe4cXvnBLOrXKSB23jRuIXaYxeScrSCutZiz81slgm6DODMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F9No7xQ07NQcWAFLklr41+mWPY9dBYoD7nNFAgtUnQ=;
 b=4Ex0WyXH8QEzQrBWhLjQ075ofFkGLVWh0QrAacGo1UyOlqUnSM3DZPpg05uBi9S7HL5TygU8DyDx8lU1L/FjIqcMXSu/+otULbOUS9BaQJ86tfXf9Zyu1jWys5TkO9essGicdJaZK/5RKo/H7FtSt/ODocz0Z4SEmopzNlhjW8s=
Received: from BY5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:a03:1a0::42)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 15 Oct
 2025 20:12:14 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::73) by BY5PR16CA0029.outlook.office365.com
 (2603:10b6:a03:1a0::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 20:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 15 Oct 2025 20:12:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Oct
 2025 13:12:08 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
Date: Wed, 15 Oct 2025 16:11:32 -0400
Message-ID: <20251015201134.2540-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c4a295-3be6-4d3b-3895-08de0c27213c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wlEfxyxjODGbOv7E3F4gxItYgFZSqzdCt3aS3BxpAHuWP7pQoUHVz3lDqRJ/?=
 =?us-ascii?Q?tqbD4dCgmk4JOTnTVm3DfBtDjtJ5Rd20J/Q7mt8P21HIgfxKe+mEEYHLOUeW?=
 =?us-ascii?Q?iCic/A02QoVFCmpMRqC1beL3V0Z61CCEvFQs5bAY/0KZS5fuuK/QwFrTnOVS?=
 =?us-ascii?Q?PjKtRnQsLNc8cGe+ZLYeJJWaViUsc3ZgQwf/MuK+cT0dgKa8XM2KOfyCOlaJ?=
 =?us-ascii?Q?tToNqdAkwNaWD99dIKXqfrHYmFZpxr1jNsjmak9QcqEDcfAjoC+w+Nxt0wJ+?=
 =?us-ascii?Q?XLIrLeiFmRHz73pn8uoeHBUC60Nvb0NYpTHMEwNFXPxLhUobMBJUvfg1gujG?=
 =?us-ascii?Q?FXMH7TNzR/OlBy14dY19Yjm8bkPJAqNvLolmsMsuEVKGuLJKhWpYgPscmmJU?=
 =?us-ascii?Q?So5Aygfn9ecUxb9QnFWsF72FQ/4Q2Fp5vFHY4ikym+OhmtMNg+C/I4mGINWd?=
 =?us-ascii?Q?sdhdpgt+gW8U4y0nuFxXPhnOKqpwoHf9DREnMjSGBuj9X/Mq31EMfEkXVNLy?=
 =?us-ascii?Q?7kKh7kuOIfrIloB68vfbBCj07Q9cO+lvhqjD4hpmt2kZg+kjkKcSXbSf9TNP?=
 =?us-ascii?Q?CYBki63QIdfR6Nsc8Ts88GH7HIWgyKfJ7zpcOG4UD7ufIkXAVhKLrpDvAF0L?=
 =?us-ascii?Q?fi9lP8kgP73cE4jxPyXb9ipVl5CZD+TBdgXcZqGUzxlcfOPNCdkZyeoLZGOM?=
 =?us-ascii?Q?o8yIXtai8hJ7ObHjREHA2izywdCVzCGQj5VkFg8v6n2HSSKfW0ClLVC8vT0S?=
 =?us-ascii?Q?s2nobYD/npYiLUL25C8QQ/IiwpfAEPx34uu61FsMyEmgLuncyD9njqqQoIh+?=
 =?us-ascii?Q?GHrH3vr4bURIWSU+/UQQwbIXony5QPg80czDIiEAQhuLG+WjlzfAiOxX4ERu?=
 =?us-ascii?Q?IvvB4QnkDk3qyNZCtPMDATnLH3F92lSWNqTHK/RGvhpLwKF6Mro+5aSH+JmD?=
 =?us-ascii?Q?KluMnubdaViAa/qOkqjSIzbGGBNFPcQYuMR/eUS9HkYG2r4Iz33DRtsk7sJR?=
 =?us-ascii?Q?J+tOjKlnR/3imdLs1cwS/IWg71lcsLkAfAV26bhd2wk0o0ZTro/DazcK6ZCl?=
 =?us-ascii?Q?NyRl4eVJrffi3HcCxb6EE96pkR7Syjryc1aPjrV7ChVV4hsoNORb/F9Brti+?=
 =?us-ascii?Q?MzgGBrHosYGr/5tSS28fJm3QcwlmG9Qt/oTgoxWCoTc3JAVEfxOhnV1UhjmS?=
 =?us-ascii?Q?8LgJzlvsNq8KO7RulojBbjw3HEpzLj9HAPGxX9Q0fBleGb2jAnCoPdoHpN2v?=
 =?us-ascii?Q?+yQoIIBNApm3WMEL9FmKNS2j03Zxm3akZXQMadXTTwkMNS6TSO5BDjMDGcfT?=
 =?us-ascii?Q?anuNXyjB2JAFZuGK58cc69a/DoAs4TWk8+90UHC5bkFTZZN3RIcIG85Q1y24?=
 =?us-ascii?Q?ge0Iwbi24L+wE13nAxbToxRZIiTJ/u3G+dp4ufE+87O4yW7/fhyzzXw6AiNP?=
 =?us-ascii?Q?0SFHVewwRAv8ZhEuXTseX13EWrJ74QZrJijbjmUsnLYUBNlgqClh+iffjcy4?=
 =?us-ascii?Q?qnqbZKGSjgCUtrUuPjYYaX1NIRiVG8hP8i0MhUUhrOIK4dAse5d2iCrXKzAn?=
 =?us-ascii?Q?1vwd/Cyjh+ifj7sCt2Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:12:13.2699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c4a295-3be6-4d3b-3895-08de0c27213c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

Only show warning message if process mm is still alive when queue
buffer is freed to evcit the queues.

If kfd_lookup_process_by_mm return NULL, means the process is already
exited and mm is gone, it is fine to free queue buffer.

Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4d4a47313f5b..d1b2f8525f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	bool unmap_parent;
 	uint32_t i;
 
-	if (atomic_read(&prange->queue_refcount)) {
+	p = kfd_lookup_process_by_mm(mm);
+
+	if (p && atomic_read(&prange->queue_refcount)) {
 		int r;
 
 		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
@@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 			pr_debug("failed %d to quiesce KFD queues\n", r);
 	}
 
-	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
 		return;
 	svms = &p->svms;
-- 
2.49.0

