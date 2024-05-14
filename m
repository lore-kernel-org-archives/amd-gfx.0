Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AC7C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 15:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AD010EA8D;
	Tue, 14 May 2024 15:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BpIkreep";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC86B10EA8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 15:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVJRAwAPq1EgfdenPtWwQBWgDHbotMdgFg6Cr8ouXBNPq2Lf0gTcCFgbJwx0qTHPgW+JueCshE1L9NZtgqVuqqJGt1DGPlLvBYEDoVp/9iqwLLbGN3Tr01SpKdKvzJnGtYfKXX+Pr07TbAr1irAvCry7+unFpFaufeTHqmBjPdmcdVi2S0T6T14XvihAgLgXsPLMqoEHfwRSZh2qAlkgR5H17yEYLc4z+55TYFILmDFOr6IGyFCYzV8cnBgbIGuZn7piJpVcsikYVdsDdu6t8P0jNEIxg/pewDTkvEpj6hVyUi/ssD0QqZCRYjd3XGq8gtNShP7SmhfpS+B8pAdP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAdkMHQWvt9lscYjXQ4s3PwIqgbEsm6siJt+lny/L5s=;
 b=kPjD9Xi1yIXMR1LGrZT4zoz4Ar6QjqkrKyQ6YM6cvLbJBuEAdSr+ojyZVo6iHlHjxnCDxWwycLKd2AldcdOBSmzCdkTJre8t7cHlmIer2qFfnX9n69KJ8lJywMXvYcXNy0nDlFn0Cp3SRR2Vy/wfCY8eS8EDK28P8tOvxwbfqy+QAKvKgWm1jO6D6TYN3595Ope5CWqamRKimIjEUSywDPtbukET1m96Wp/1PVs5bEfYyB2eecDzig+Y47AhaKGS4uyx50hkDNDtwAypEx377onpRVrjTWFiJCWGmjIl4lXJgDRqIdgQy6aoLw4HgaX3wozYLr/J2JrSUsuT49y/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAdkMHQWvt9lscYjXQ4s3PwIqgbEsm6siJt+lny/L5s=;
 b=BpIkreepYsPCN9RI9k0w2TZMwebiTqDJDCr3R+Gvp7S+P62AeF4Fy/shGLRwoM4aeplpT30ZGA8PY0jRtkFKv/MvAvS4+f7wdtoUb4Do67WOnRreDuJpkUSNdm2QLSVr25o0ZNgWzoSclR16v6wuFJwGTUgTZHrmZXgcpCP642c=
Received: from BYAPR11CA0059.namprd11.prod.outlook.com (2603:10b6:a03:80::36)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:14:10 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::ba) by BYAPR11CA0059.outlook.office365.com
 (2603:10b6:a03:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25 via Frontend
 Transport; Tue, 14 May 2024 15:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 15:14:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 10:14:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>
Subject: [PATCH] drm/amdgpu: Add documentation for AMD_IP_BLOCK_TYPE_ISP
Date: Tue, 14 May 2024 11:13:53 -0400
Message-ID: <20240514151353.1072181-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f5693a-5039-47a6-3cdf-08dc742881b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/QyQY4jw+MWV4Vc/k0gHd6b0IUdt5zSfdg76a2cRTgUie3RzmnkWzWMEV77c?=
 =?us-ascii?Q?u58zb2zyV/XuvlqV0mtzYkeJSEUC2FcLUO+qlCiSliPUFSQJ3XL0VBFrmICz?=
 =?us-ascii?Q?lvI5i3pslkU9uArjdlBKvDNk2HKmH7DCWVOBVq+lVKTWqAhF6QVQB5KobCTe?=
 =?us-ascii?Q?7Fzy9H//M8cDIpuoM/Wmt2e817SJm7B2pfvsFlf1gxjZGOLRIJkL/i4Qgt3Z?=
 =?us-ascii?Q?78ydIflgSuyUS5I+mb2c8ak26TzLKUhcPI9BBclLG8+5dVGdfeFzYuGuUcaq?=
 =?us-ascii?Q?AOnY3KM9Mwxzu6nerdk3WckSJxNCzP/UqfZy3d8AlnnvVrhNXIDjhyeJY61a?=
 =?us-ascii?Q?ihSkfguA0abBETZWcWIZM6JmntwHZMsNTkPDqlaUORc33p6QLaYQ0W8hoECK?=
 =?us-ascii?Q?KYBnC4gNqSamyEk4alHlqq5MUgAriLtCIeIeGKi65FHFuzUKtk3V/9oYz1sp?=
 =?us-ascii?Q?/LvNPM3gWG2ISOUCK1kDvxeTV9Bggjcp1YVddaVY/XE/kLHSSuT3wunQRzf4?=
 =?us-ascii?Q?Zu8wS7W2wXdhnWAMbJhhpgUHF39eh1T8+P6rok3ctsEGk8+44HLv2UQti/2H?=
 =?us-ascii?Q?qaPeYchT9UIZDVCf0nkvXJDkHLC8b0EbXq4E01UNzUgV91Lb7vdf49Un+T6e?=
 =?us-ascii?Q?TfmCQwJhSnayaQimKS4ifGOjIpCtcDY+L6pUu4WqrVhv1e4ChqK0U9ai445b?=
 =?us-ascii?Q?GGGHCqLjvJajxrpHl6pNvoCGgCWo2UmNAjw0LqzS6W9UBy/XrZgYMQkj9GKH?=
 =?us-ascii?Q?TVYBGiIERDyGM9OSDMPlzLQIp2NUbkbYxtnmnsdHmg44paWLJOIUxsJCO+3Y?=
 =?us-ascii?Q?rZlHcxsaIRNLY52ZFn2duA9yQ6T2tj7Dla2PLGFI4pgthb6niIK2umrzaD5B?=
 =?us-ascii?Q?BT2a0LsginAkfgKqYV8qjBByVhsuKR2YYCFb6vJ+FO7P1WSiseyMiJfjUpVd?=
 =?us-ascii?Q?O7zuCEpsSPbDoUGrCIQaSgxLiZfxYJo1IxlIHF69PWbUxipnfjC4cobq5fM/?=
 =?us-ascii?Q?+dktvXF7byqvE4cXNdyDjfa/XkOo47/svgreAApta6KMkryzJR+lyc9Vm+Fh?=
 =?us-ascii?Q?fuaS3gq6+KXNZ+/F5apNGovjAMCHGxa3Rzoq9SWQnIdphx+3ZyLUkcsKl3eP?=
 =?us-ascii?Q?Y2dlxwYbdR/IBsgqwZWrpWQ1gexpyWi8hYClR5bdSXBkSoHTdPg1GGdGni7G?=
 =?us-ascii?Q?LkzJMfmF4HvFlx5Uhtzd5mim5QER1cN5BPRA+0u3vgLYdWld8zXw6qPGuQnL?=
 =?us-ascii?Q?kAtD5RdBkO99zGbA296VoTHHMRyxkPing+7AIxeKpCBg8FbRhHdM5khIJPyA?=
 =?us-ascii?Q?NHeSzNkwhbPlS8jbqOotEkLJP0y/CP9ZKvXyooyM56DxwlLdnthDLXyztqbi?=
 =?us-ascii?Q?wkuy7qg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:14:10.1686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f5693a-5039-47a6-3cdf-08dc742881b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892
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

Add missing documentation for the IP block.

Fixes: a83048bfa402 ("drm/amd/amdgpu: Add ISP support to amdgpu_discovery")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 8bc2134cdd6b8..f5b725f10a7ce 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -86,6 +86,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
 * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
 * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
+* @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
-- 
2.45.0

