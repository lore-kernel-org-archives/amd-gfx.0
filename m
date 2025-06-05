Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50900C678DA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C639A10E9BA;
	Thu,  5 Jun 2025 01:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="45DX2nfH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B26110E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQYQwhmJIlid6RqOSRkc3dLXcssXEFpBFrEghNROPNNu9WR2F6JbljIFj2NKTELHebpYpg467G4lrTaupeqHEa6BlYWvlpV4T6AzdpfX8aOehAsIye0i/tf9GS8Our6kSXFcboTySAyWje7TkDk2mOyivaDVbMGnSQKQ9fNjm9YqwrGDcdwfQjZyorvAO2Ij+64ubB9fzA1F5/xlb7SqOluWD1JNReda3WJK/6tXc31ShsL0LZrerSa30mH7nKdrM7y2ix8Xt+W5jNCRmYlxgh3Eu6OPPRZpbqJHFfuAaUbFORo067kI1n9RB5R/KRUSPCKopD1Q/5qH+qU+87zIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU1zBItHic8HshKX9mnBPZqzsMHs4IzRCJuvEm5H00U=;
 b=ek75D7peapHzcf9z7soZgJ2zwEubkEGQ17wVtSyeTPwdxyDBouX448/NYlHXp6sZ3JZtbN51/PFdnwMW2GXCqhQroIyTJN7EWjTk6wrxIwpwkxvyEQx6blGo6BFJCVm6TDA3s+H+90N8p9//Zj++Qi5Okiu/ozKJZeC9N387WXqP3HHawvHvDqe3CjT5yNcRkmMs/tTilUw9I2I2eMDdhonaCPudTxHko+7xQTxQR0DoxkVOdRm8ZgB78ESR1D/67I9w9Db/9IBQdd/Vk1t3TSwxg6zHOcNqDAxlkuYH6sEBK428WzEIGJ5I1HwyUNvqdwCwt4oyESqPKSsuGnwV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU1zBItHic8HshKX9mnBPZqzsMHs4IzRCJuvEm5H00U=;
 b=45DX2nfHOhlmv5oXRNNZ8ZgZWfrbJf5O3boCViSJTw59m7VIgkF7hVUJZf8ZHiKL78V/IZaFOXMKpIOtx0U2J5IR8NZM6aQPvtUswL8uvQkxLjybQjTZmL/24fi6wOyxRlPkVGWTsJ7dhkbgwk8z8n4OPk58T1THsuuoGtKDZfM=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:31 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::42) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32 via Frontend Transport; Thu,
 5 Jun 2025 01:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/31] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:48 -0400
Message-ID: <20250605014602.5915-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0867e0-0c2e-4c2f-7999-08dda3d2cb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uDpIEMzeO06Se+8TfsfM/kfhc3o8VFkESqiMLrcKdn805v6SCf8+RS51ErVd?=
 =?us-ascii?Q?6fOfMXn0YJCwFrOihiqH4GjZpAdWQKRt/4AtyEDTr1Fmg0+xSDtLQwVq7oX0?=
 =?us-ascii?Q?Exs41Ow6gnIbFh1v5sm65WQlNwbdRMl0g9Hjht5rqDXy9WptkMszMx0pLtqy?=
 =?us-ascii?Q?B6S5RGGWBgacNRb7DRgoyadMMorHO6qa6joxRohmNwsfUn+mjpeDGirh2Z38?=
 =?us-ascii?Q?dPogSLWKOYG0t72eURBC8oH0ZjX/QotnstZGF/xJbHu4JcP3cFCo+j+vyEk0?=
 =?us-ascii?Q?owAkhbnfNwOgZRBUlmvJQXUYpqmJp6+WoYo2SJcA1ZzyJ+Q8EIKCib187xim?=
 =?us-ascii?Q?wUMg+MZLK49VBFYysHAnFzxE3Alpv8/EmVi5bQjkLadD454pEVKmczifoLkj?=
 =?us-ascii?Q?GKBC4XPTCLos0d8U/JZcJLAvyjk+RDZFDGmix67LMYnPfKPiFZr3N8mu9jpj?=
 =?us-ascii?Q?pQ30c6Xob9zMGRFJazgUqVNkuU6iSx1oQUlzYWmhmEpby01Y+IbMjBXPbCJF?=
 =?us-ascii?Q?G3Unoqn3+W7G50EnanCM97YDztpi/A+XS6U8ceQD+wYMUsZE5ZGtD33S+RVr?=
 =?us-ascii?Q?k5tphbOIbA9F5735oW4YoBWEy53P6bjx0+yYfRZXY7m35rRhI5l8lph8mvdL?=
 =?us-ascii?Q?zP+ko3jnuPjydi9zwyoiFY42L06s5n7mHHxru/+UJIvuHVs6L15WdCYS11id?=
 =?us-ascii?Q?E14mUhaAGKl5tBTHc3Qrd3r/Utbv1nfvDoxDAZim8tSIIRcnrnvDtyNPm72v?=
 =?us-ascii?Q?QcGRMYHlO7mLYRAGPD3f1mfs9lxXqJH1fWAvS1oDhvl0jC7OO9oYqz6NqUGX?=
 =?us-ascii?Q?Yl8KpzWRKpszKBwTdbfMByDRaPD6A/rCqp5gNbxwJmbJlHH5HqfySQmWtJkV?=
 =?us-ascii?Q?GhsXGKQSNib6lFNfxrTTDMYZJRWFfs/SyqcdlkjP5FzEnMOD3H82N+aCTbOL?=
 =?us-ascii?Q?Xld1ti54lt/D8odzRiVljc8+vGQbHZG+isvR9SPk8Vx2l0Lu7ISMAhcVIC2k?=
 =?us-ascii?Q?FlKA06YzzCdR/zDCP/mihf3v+mNvbMpIQ/r3ZQU+NOgXb4BZLWo1QitriES8?=
 =?us-ascii?Q?Jkf8OTK8S8Con3Etf9FzlcI9eTr4b2oGH56iFQ/VAPbz9nqvvXO/3Q9BUeDa?=
 =?us-ascii?Q?FucBsUfoEJ2XWvgeeltP04jVc/7+dLSXS0eRgKJl/aep2JcYvYmKg7CHk/S5?=
 =?us-ascii?Q?uLpx3kY/5X8Tiq36KLAj0fzAvK8CDdbM1D/XRlQn9+Crtp2ns8Oyz0MrGoW6?=
 =?us-ascii?Q?mGto67NG6SLN4TX12ch90lIdO4BWfeZ37SmjXCjX27qcvtj68/7mhvHj+d0P?=
 =?us-ascii?Q?kioYCNqJQxw5/r04Ow0H3Y+4PZxaeYw7vDC328+3rWdm5rYWNyTR0t5E6SEJ?=
 =?us-ascii?Q?mP7y74pOKjMySaM/+Xp++qBG+vhFIt/LLo7Z8wWhF8kncFDuOSF0pt62FtpF?=
 =?us-ascii?Q?ktPLDtFlgcxBbxL1GohD8E6mqgSulXK+fgK4i9Hx9myTgR3idx8sAUZklIS9?=
 =?us-ascii?Q?bSnrutZA3iqAaGhpnfiRh1OhoLwnfpnLPsZM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:30.9190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0867e0-0c2e-4c2f-7999-08dda3d2cb8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 86ef0e30a89e8..09c4e3b228632 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1559,8 +1559,11 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	amdgpu_fence_driver_force_completion(ring);
-	return sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.49.0

