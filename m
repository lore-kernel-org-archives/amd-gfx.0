Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672DCC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 06:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CD810E8F3;
	Thu, 30 Jan 2025 06:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkK24lxV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6766310E8F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 06:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4Eg5MKoqaf8sDL6fK1bSoq1rrMVay8GAlxj4FGPbMdRM+D9WpvM4reUYpEXolASpkxoUrpAEjRUc/rldd7OpfUC7ly/TcAeJVC2WDd0HAPbv6/gILdmnpXV4ZUQ471GIu4BFEr10WJUH1K/ar4a7UR+GmGz6gq3CYhHoNTaVlE/bnVe8ff3+VxbjE0sO+la8wRffF1KTg0zuNpUpsdOV0Pf4soIhf+gDPOLs/NSYpVIk90NyIQNxVHSblEjq+IdoSvlweV+n81emy2+3+neHOeQhwn+5VKWT/jt+QVq3QPJC+W+a2wQ60yUbPbZ06Qs8bWFziJ1dISdG8JhZjgG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyQXrJnOeQWH/0UeW0qtfqhDLXJl7X8eN/RMkG8l7FM=;
 b=Fh+Q7sRHr+pdFDggNxqDHF17Fp/08bSQfWP9r7nCssZN5eid/bLVJDJquMqSsnx2Y5gCQ3j4VouWOmgseqgYohRpkGlbjVSA2+djHKk4pWT5G9xxWa7qDdazY8ICicBRREjD34cZ+51ZPxW8vErou+I5ek9BziIqZaK1hxpzKDI9o0XVxek3ADwIagmgrKF9DaQYSabMrNwe8eVrZfQYwAntQAzVNThr1JG8B6uWxfa2w5pN6r/4IDLTwDtB1cQ/ypE8/XVq4fosfdQMIzOL07HNflCp9WpqymGV2rVNrZ5rcUxSqXDTcPm5SRjAvzECv7Ke388H/73V+N9LBQK/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyQXrJnOeQWH/0UeW0qtfqhDLXJl7X8eN/RMkG8l7FM=;
 b=bkK24lxVuVioGAiEkqBUVqya2gOdW/8mxycxPg6hmsUt7483jGE2wb+Lu89KsHiz66P/MQYix31wc1TyamtXJ3rZKKAwEQBmfjaJQwwBnjRs0guZvSvssk7S9tVx9hQSR7THOaGXKl1aiWwqHweuLsR4bc94KSt+asZz7JTBJzQ=
Received: from PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::12)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Thu, 30 Jan
 2025 06:46:13 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::2a) by PH0P220CA0003.outlook.office365.com
 (2603:10b6:510:d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 06:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 06:46:12 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 00:46:09 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: update ip versioning for smuio
Date: Thu, 30 Jan 2025 14:44:29 +0800
Message-ID: <20250130064429.2215628-4-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
References: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dc7ee0-81b6-4fb9-3146-08dd40f9c97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JKb/S3BL2QeD0/NL0ksJE/jwpRFYG8N9p9PTwmvHe++jARJMwycwdW6zfD2x?=
 =?us-ascii?Q?jMM2tDabBbqz8bIVdkPqATJgMokS4zccaQ2WMxV1Jb17Ho+YUFENtHf2pthN?=
 =?us-ascii?Q?zOlhUUYk2lsZ0D4ZpnUCYSsDe+w76OSngsosjhGtmQ704MSHLMCG6nj/Nx3G?=
 =?us-ascii?Q?aCFi0r6vG307Rl0A95hUqLDKTOHUDFu/eWhjz6yT736mP8bUGcVNlU98pVaw?=
 =?us-ascii?Q?Xpojrx+5oVX9b0dfeuFiQsVin7f3LYpjT6esd6xEftj5aBWEP8h+g+dMZE5q?=
 =?us-ascii?Q?7+/RQn+MaqGVZZDOlheWJuGTZXM650sDaVcn8T6dmw4X6AAXuPV93hggxsWD?=
 =?us-ascii?Q?cw6QB3R7iwO3fwdje+pWXODuAux7mlou+S5RgddnavtYBA+JAovRNTAGnwIy?=
 =?us-ascii?Q?HxcvZyYvrz+Q7RnXykNAqNBuZpLjcipongIJDSF6X4IpKGfaPVtqcjq8LlgY?=
 =?us-ascii?Q?4qIRWVqDw3XbjhSn4lK+f8ErxD2UrEf1Fa/iyrnCLfRtHrOTAOyVVt1ZXATV?=
 =?us-ascii?Q?sMoMlyAln8NuXHZ3w4vXu9f7m8jguIBKrgtnAL5R5U4EkDrQnnnZ3qcGLRrs?=
 =?us-ascii?Q?NKAUNpYXG9zDqDuyMAY2dXpv06g7miVip9vqfehoRXcxI9KMOtfgMvFSAj7n?=
 =?us-ascii?Q?5LICzkEX9DWqXHQ1AUHUttVl+EL/kyOae9eO7tvKiQccBQawyFM3F0lPubGJ?=
 =?us-ascii?Q?5VFaHTBU8PKbKZFwjEOEQFA4WnB4+5nhV6kAJRAsozjk/DqsQvNbKis5I9mg?=
 =?us-ascii?Q?6QWDAVw1IXe7pLAMcaQlI93MtiubGN1YrcGk+12MLeIXfpK4BNLRsI+d7K32?=
 =?us-ascii?Q?2uyjJtVcG4xAm8Fnp5b4XwkPSBkZ4bptVV7IrlfL17Pkxa5135fdO179l6pm?=
 =?us-ascii?Q?Hnphm2ajzgOiFOleKSeIpFgijGFl5Ox3Fk0DDtpIEC4dyxcW0W89brY+yRgj?=
 =?us-ascii?Q?BO6aIvWzB2Ki5rR47Gi7OS9hTEt2aHzFAECXj4l7CRck1ktQCY0xUJT8epqb?=
 =?us-ascii?Q?XxrppBCOxCZLJICr5wiOV/o3ZsnKDyFhPVVidUJbG59rKlVIezeNEkxs1ZIU?=
 =?us-ascii?Q?m6GSnjr3uzso1NOBK62itqMevaUdPwyyqfhPBwaaH+yikVt6y30a+J4LO5BM?=
 =?us-ascii?Q?8mKLYSQOVpyNCS8XZbmYvFzeXRiHU5oQXHWNo3mJ7+ibJ1ISfKGicPGdnkYT?=
 =?us-ascii?Q?NXneecDxLSpLweIDDoaiGbasWOuGwffsQu4dbHi5sDfqu5Qc04ILNPXFTa/i?=
 =?us-ascii?Q?1R0hwLDveh5IemJBJg38B+rI/cmyiSCOrvUXrmXRTUhxWIg5FBG+GYsEOmx3?=
 =?us-ascii?Q?FQqBePA0SAySK94apIZizT8VQ1UvLgacXZ/17iblTyBH3tVCxpsJyh/LH/bO?=
 =?us-ascii?Q?NIyN2J7yAVjird6XMNfSAEME8uX9Igpzauocn/OuZkoLoOVMh3OkW3W2LAqM?=
 =?us-ascii?Q?w/g66hjZ5+Jv5X2CqdpVm3wxim5awdECPmjbgqPFscy99iFs7Q+UBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 06:46:12.6219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dc7ee0-81b6-4fb9-3146-08dd40f9c97d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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

support smuio ip versioning though ip discovery binary

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3981b8dbd73c..f32a14235c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2920,6 +2920,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->smuio.funcs = &smuio_v13_0_funcs;
 		break;
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 11):
 		adev->smuio.funcs = &smuio_v13_0_3_funcs;
 		if (adev->smuio.funcs->get_pkg_type(adev) == AMDGPU_PKG_TYPE_APU) {
 			adev->flags |= AMD_IS_APU;
-- 
2.34.1

