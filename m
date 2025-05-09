Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F42C3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 09:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5C410E0AB;
	Fri,  9 May 2025 09:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TjDVsOTm";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6AD10E0AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 09:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE61bOV6wquBcS4hjob0R2iqIsxDtbhWgrlOPRVVARKo3qbCSGQXbyPJoy7y5KaoHMK5icA6puNztn6BwQBPjzsXJdt5ggP6PjWvoRAU/cdsCsxCWCYBoZAs8iPqI3Sy8ybzUHc4OrnHONgiUjEPST9ufM/tDEnF5hEKuO1QMR3CIujqjjG1S/x/E10NCHyDOk4slgNWN5iE7I9nizCEs+7qYJqnUSGqkAbn6rU+s5d3yqO8Xn4HCFPL6MAo/ur9bz9KZ7Llwg+L5kiWRBs4XjQmtwzByaR9NnCN5Zg3aEKQcMweHXb4mO33b1wJJJ+sl2i1B7g498YtluP7/SCmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPJtrSxKNa79fIjQgkcDY/T6OY/QjEXi5xfXmacdwQ0=;
 b=Xfz+EMM1Dqmn/w8+v7euwH5hKTH//HYCPbLsnzeF+pKh1afyMVAedf5lFaL7anwX6USgx/Ydz2XlO/k5vUz51IvvY2Pw1hTlU3zLkTivimINnXtphGZPgNAMSLjO+cVddgPGDxJzBj8hxnTELt/fp4M8J4TjATWeOTx81RTZ5GRw44RqFmPYXgs93kWt4bfgVD383HrbqP/kcUeVXsmEDHvW9jJMPuv1/9kqvGIy92qYz9gKCYeRF8fnbukD6MRMtyTdjVy/r8Q3bgIInpFJTZeXYYTGirU/Ze2AzR5KtrhPt7hghnnCb0no9kZgk9Rx1NHovrRmOaFhKwSgM1+dWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPJtrSxKNa79fIjQgkcDY/T6OY/QjEXi5xfXmacdwQ0=;
 b=TjDVsOTmY5VkmHRlB4Zc3OsYZIcoayPsCAl7FRj0K2AkBvabc1Dg8B1vUQ2UumnySz6/nixwA4CsagUzqSoBojXob7z4fhfUhKpe6gdHlHcsUHwDZ7ThIy+7A+yw3TQuKWQ2KnrXJ5ULB9K4dYPRGViFvU68oEDI9u8wXauztZY=
Received: from CH0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:610:b3::21)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 09:38:16 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::2b) by CH0PR03CA0046.outlook.office365.com
 (2603:10b6:610:b3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Fri,
 9 May 2025 09:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 09:38:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 04:38:15 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 9 May 2025 04:38:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add GFX 9.5.0 support for per-queue/pipe reset
Date: Fri, 9 May 2025 17:34:31 +0800
Message-ID: <20250509093813.3669072-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: e2da2c98-0cec-422a-2220-08dd8edd39c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dDGflLecnXHnQWE7agdAJ7iYIyBiDPp0jtOFz2RAl/T8CF2AcOI143DCHzSj?=
 =?us-ascii?Q?6NAeDJ+UZ+xhkIDyos4mLJ989vtYwsqlVfZ2qJydyxGzwsKP0WmCx+vIMch9?=
 =?us-ascii?Q?Lw7EaY316qX698e/3qv88iPuYa9cAVqW48oOVQyg7wBH2Yi6mKUjk0VWId4D?=
 =?us-ascii?Q?UDk3hqKUpSTczuU9GPFOtJKSo6WGyYkdX/4fBsBNBZtbmrZECNGDB/MJHA8x?=
 =?us-ascii?Q?DbUSDKi0Hie7eLh6wIxaNZU3KAaVCQeYYxLUqpoGdnc+01RnOgNAprgStCMr?=
 =?us-ascii?Q?hn/VrBcfNpbx+ZNsRBQWjDIiB2huNRkNzKJaPDUYTYA4k2cWEOlbhCagDCSQ?=
 =?us-ascii?Q?5vRQgrTevDf87KrEtc0RxnJk4bi+d82Zke9icJep1XXgXDhs/it+JW5LoNoe?=
 =?us-ascii?Q?668anViEpqMAgPFP+01XXfpdR7Li6050AihJwhzyk7+k8wfZN91ATuKo1pux?=
 =?us-ascii?Q?2Bd2w0vPqD43ArpKH/MFmtn1yKoo2oU4TbBbzu+Tr9p3OT/gdg6qbjqRXDUK?=
 =?us-ascii?Q?QcAHeErc0qAg7e88WCppQw545mNPYUCxRwwvmDO45zkZOEmRBJ8Y+aZj8NcW?=
 =?us-ascii?Q?IBI8A1TajhdfwGa+n0ONeddbOMthwxZZgqhL8tVCC/guGaAi6C4w4SO4ZPyF?=
 =?us-ascii?Q?o+qEVj67HYQWcpHm2YZr7pfmnaQuXyD/WIDTjZrJtLk1TXKOF28YouGNBXYG?=
 =?us-ascii?Q?uBPF7Qut6mJxXxPitx67Njna9C5EJ1xx2Q77RRcJSjjJzaCqncbYPYNtNZDR?=
 =?us-ascii?Q?GPUO+xY8S7jLYMNGO6JrLgu2ZQ9+WXIohNYKvlfBUQ1ilgkV/sVt/8BHCiF+?=
 =?us-ascii?Q?Y5fMYnjk5JH6L3nuIo0MZSlpSAHm4ywhdDIqcowppdMux4ixi1psXsu8aFCZ?=
 =?us-ascii?Q?NdU+ZOYJexRmwArw6FAWqZamuDAN+YuMZ9LkaHJN1a5UJAhwqLzK2IeM7cpL?=
 =?us-ascii?Q?Abn7XjPbU1ZRDU9mgYtPH7Tzbjz0W/m8etgF6vn/KdFGZ29Rvba5VHcIMWLi?=
 =?us-ascii?Q?ZwIyWckigZO2NDmjsD3BOwg5nFv6om8EGOEiNwz1dcP/bAz7D4+xVfxOFu79?=
 =?us-ascii?Q?3WPBVj4sXAxtbPRjS+c08lHXJN1qiutPmkFKj0GC1e40+UyxaXj1eJL5Gyz/?=
 =?us-ascii?Q?y0WYYmK2m6En0OjN1y6xu8dv7sIcjRY0youfOuajlJbBxAPkMvOe6K+1KU49?=
 =?us-ascii?Q?mrn8TvIMq6VGe4pdP9zAUkE0scbgUiPYYRZZj/kXPEqAz5Q33XbpeHaAmbYJ?=
 =?us-ascii?Q?yF3fdA4/0SrL6fjI5zDq//YAg2z9+VfxvXMKrPxfwg/dPOjM9184jIga6CSg?=
 =?us-ascii?Q?dwRZjiydavY0WyZfRkTr9ggvdIT0YsoIyq+mEAbuxJTUexkfnWxibrLYIonL?=
 =?us-ascii?Q?yyrdeGR/rMoHGf7TwTs+QaM5AEQj+cFoh0xw+92tUjZvSFzckTqTI54s83RA?=
 =?us-ascii?Q?ykNstzOshvYeKwOufsTmxhsvJF9TUXu8jCmE5iwjkqEb+poio9NMkarKdeZ9?=
 =?us-ascii?Q?p5QNNqajeBnpZXhR70EQ8poFocZjGQQ6uiMP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:38:16.3813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2da2c98-0cec-422a-2220-08dd8edd39c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
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

From: Asad Kamal <asad.kamal@amd.com>

This patch enables per-queue and per-pipe reset functionality for
GFX IP v9.5.0 when using MEC firmware version 21 (0x15) or later.

Changes include:
1. Added IP_VERSION(9,5,0) case in gfx_v9_4_3_sw_init() to enable
   per-queue and per-pipe reset flags when MEC FW >= 21
2. Extended pipe reset support check in gfx_v9_4_3_pipe_reset_support()
   to include GFX 9.5.0 with MEC FW >= 0x15 requirement

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9db2bde5c59d..a832639c07b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1153,6 +1153,12 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
+	case IP_VERSION(9, 5, 0):
+		if (adev->gfx.mec_fw_version >= 21) {
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
+		}
+		break;
 	default:
 		break;
 	}
@@ -3453,8 +3459,10 @@ static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
 static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
 {
 	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
-			adev->gfx.mec_fw_version >= 0x0000009b)
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+			adev->gfx.mec_fw_version >= 0x0000009b) ||
+			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) &&
+			adev->gfx.mec_fw_version >= 0x15))
 		return true;
 	else
 		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
-- 
2.49.0

