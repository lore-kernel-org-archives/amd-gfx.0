Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840ABCCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235D510EB62;
	Fri, 17 Oct 2025 08:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nb3X0k0j";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960CF10EB62
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcoaQGGcF/pgzjPqVwUl13s1xTN8qIox+x6roY5ja56azYN4eZrNLWYNzFG/Li4x+u53YxdikVu2JGcN5n4h5gUpVy7hScLU2T51ZR3H7x7lM/gCL0Q1vV9jUkcC8T1I+WQyFh+dk0EqYu0u5DCexwQlR76SzjAvY2IXbWySBavOq8nlrYPbQg4uhtB18oPF5VJgSo9Y/dIF5MsQxJegC7GskQ8SNB4sBsNuGwhFNjHp3UvYk8MbkNGwduBNTCDXLBYTwfYqVAUQ3yTK9B1B0ASv+MJ9dlkG7hH2Dz4O4NyboqNKhpN+fysx16498WEUPzUMee4F7SNsLTeJ5zhfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=774eHSc5xJsJBe5u50+E+MxIuJ2yJHh3V+lYfR2uQfQ=;
 b=j2E1t/qnTWBWXxyR3V0fQmtACL9UHSliXaW397xw+QJbTmY3j2ZiERabp9wQSc87YibK9hNytmzjOUjlSk0Z7NCIwzOPAmJR9VOGBRrtmY+i/lujbeP7g7nN5abQyj5zrHNmBOCaDunhO7K6KzUnLjgpRt3+ry4uqeO7Cyz5IsuHc4FTZodWcodzj5LZsc3FIou0UjLy2fMYnEyCZu2TpIZczb6ylQcjZxOK7mm7HlxI/oGLd4xyj2uNKPOloYnvzfFtYJugql/nP/ZxRzZKIlXYiHL8pRTY4sPH51mKhvNcs9aodEaenNz+GrJa5rVzHiBjWyzDFdtJt/ncyjT+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=774eHSc5xJsJBe5u50+E+MxIuJ2yJHh3V+lYfR2uQfQ=;
 b=nb3X0k0jG8r8ZfMFYOiRhxN8TYdh64ljKr7eK6adFkHl+3GV6VUbY+jxpliV1bVwzzA5rbBaCV0dPxaO9tXRuasahPbUIklRiLDQf/jAs/qFO3shDUdYIpr3ytiIYnfRHy1x9q4XNk7am8z2WBrGsygFjaPq/x/dFHe+HSLogVQ=
Received: from DM6PR01CA0022.prod.exchangelabs.com (2603:10b6:5:296::27) by
 PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 08:43:19 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::1c) by DM6PR01CA0022.outlook.office365.com
 (2603:10b6:5:296::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 08:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:18 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:11 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 03/18] amdkfd: find_process_by_mm always return the primary
 context
Date: Fri, 17 Oct 2025 16:42:07 +0800
Message-ID: <20251017084222.54721-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e2823b-0a1a-4cec-6a4c-08de0d59388c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YknjLcVwp2CA30NhJb7LmjzKaqTJCTCmHL9oeRTUTKHawHjjc7GtXAOBAVq/?=
 =?us-ascii?Q?br9rr+g0rqyyv3siwSH9GNMEKNnWsdoIl4hQvLCSj6rGFo6S/4yTIo5QjS1e?=
 =?us-ascii?Q?I5uLbY9UyVQPGRF08zaX758QDBMgbBQAwcRqUgsBm1XF1NOh1GKeHx75dlVU?=
 =?us-ascii?Q?l2Neexlt6Lof1fBp8MFfZTAXSjTr1O8l0+YMjnHTavA2Zi2AQzCfwOglNaYG?=
 =?us-ascii?Q?Sklrn/FRInauhTU2LIl1YehQE+Z+rGqBqr7e1Y2lO+S7BmhhgnrsZ+Tf80Aa?=
 =?us-ascii?Q?TIeDboPosnCi5L5/BFaUm7cMU3QkJeofSNVavWyDPZrxMkGQ3aMxq4fSPypi?=
 =?us-ascii?Q?fuMEm+3lcHvqXCLLBwMLHRQib/RkLtgCXHY3tS8CLVc4Njy6DnFXlRVOtU0w?=
 =?us-ascii?Q?b87/uJhRP/PfGBQthQjfVonknRksabeuHSPjAru9u+F1WDetCtlmBDyqKrK1?=
 =?us-ascii?Q?cqFrHItu7V1Qs0rzS61dwbwaNQFDeuHcDkWlE0maX7C4pIBdiKwqC5bWPZ1V?=
 =?us-ascii?Q?W2Z+uSk7hbPoFMwmpvMrnIch4big+Pe0Uq1u89JbiWZeu4onITzFCuAL5y8z?=
 =?us-ascii?Q?pD7H0a0uW6I31fGPx3z2y9sMBHG606C+25w24iiodwvAh+5qutvsVIIFhlgA?=
 =?us-ascii?Q?Ot012EaRoknQaoUBgoYDtoje5rT7aFa22AF+goBgXsrVctokS2HhJNwSywHx?=
 =?us-ascii?Q?Rz/vi1m0dp0PXgYhesaPPO3gRX55LfRuY3WWH1hfzA9xtagu5Ni2AWZWZr5o?=
 =?us-ascii?Q?XXmiE/mchosY5nbGrm8v2ljgtgrzEKXamzO0wJgsA9tzj8ucPfSgMRIJf+Il?=
 =?us-ascii?Q?adGKBAlDSyFdezbKHJwO0qDo1sdO0q5PseguJpJ3SNYdW0yP+423WOw6PRv7?=
 =?us-ascii?Q?tAysbyJDxAbVRNDFUTNtci3wUZX66PEYgBBvK8gY38wYBnBfXZvUqnQKDoR2?=
 =?us-ascii?Q?dlCT+c8MbngBBlZoeJwvmUxGDAglpYqKKyCXfLRV/tmMgs2DYvcc+4jhdgxp?=
 =?us-ascii?Q?B+Nk86+/g1PX8qB+hkPI0XI/OaEcMXOcvSCJcjkT7EYvM3nSPI+esql38+k/?=
 =?us-ascii?Q?zlBB/aIt0QHPGcBe/dSg1UVei7xXSnv7YXxVnMCyOiytzdbRtYVkql/NWhWy?=
 =?us-ascii?Q?ZV/FWvcaW4ONQlE3ju3i70ZEsjl4t/DzHkqU7Yaf287DAkzuiUNAr4LxwDoL?=
 =?us-ascii?Q?I3HKqgDyWTBx9+tjQMke6Ww7/R4RnZn/hhRa9+7K4loFi0s8mfACG//VpgxM?=
 =?us-ascii?Q?hJQzDRX1lalgbUi1UHEC15A5IBvcdYaberJnEI03QWG0hha3kZDYFLYDRBFw?=
 =?us-ascii?Q?orSJNmX9nSBPNf5r1yLr6ZHl9dhlQAltCX0cdvXhxAIrhKR3fg7u/TIjAGjq?=
 =?us-ascii?Q?ycIK0Ev6FMoVpmwm592MNQfvrQPINgkCzoxUx7iAu/WKvDA3aThXSSRG7wKi?=
 =?us-ascii?Q?A+s+pZSjVCBiL2hyEueCkMa1dm1lxXS2ZQt5JdL6Ckgj1SpmynpxmIihNaut?=
 =?us-ascii?Q?vK+bZQTj2Qq2PyrSGO9NppNU7Qrn7MhcBfJB25sOxwZUSqxgZs1iiNi/7A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:18.4492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e2823b-0a1a-4cec-6a4c-08de0d59388c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965
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

