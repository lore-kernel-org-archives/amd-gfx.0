Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A37C35FF2
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DD210E719;
	Wed, 12 Mar 2025 18:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m85LwoWv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E424D10E34E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcAOFF0RLLHu5nxIEwiNnRaY7BHGRbOV2hTWDTMVzfP4rEe6Uaw+i/6cHvP4a8UAc8ntJaSGNBgyPZbDNxRwktkiZjiKlDQtYamrryA3gTDy7mXCol7jfwOAAph9rgGZ0sSL0l269GVBwU8kOT/lao2zbi1ph8Pwskla0WRnCLOeVnTGgTMSBPEy5GYtR7IvDu4hpNgVcftwg7oxrozAtEIXGkXxrNsKbmsrfLCGOuilzwKdqKBTvzWkw4eo+6Xi6qLj3EWrhvjM1y6tmQM5y813OIxZtGoIL9smagzhuXDGWaEU4ae8N1O5GOfen/+U4sXT/RH18DKcD8mBXE1j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o54aIPEtHSjU3Z0eCSAbQko3SkxHkrasq+bXzBdqzgY=;
 b=QXzGXgZBDQQh7Ctn6wy/b7/QL6mFGOjHVzSxA2wgg9F/GnYxFqbj1vM85YEOFw6gbu7PL1kWKmP+hpazPFAeG49mtpk8bZs7VaEgspUqaQ5R9mKyTjwnGMNl5W03TUJjIx85Hf4Y7uxHP5VTG9hs3mH1CZc7r/gNA47DXZX+7YEuEP4f2/HAAYBNVukd5rg36Bkwdke3sfzl3lm0NWj8/c6YIg0+skN6IsyD4O0+Hqp/0Rg0GU31N0NUbB895U+Hz6xZ4NLTyOX4tjaiDOtSDnIp3ffPR80jIeVFwIUFctKRZtQtULDU4Uf/+N6wIxFXdPtRliQ2p6KomofOkR6Jwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o54aIPEtHSjU3Z0eCSAbQko3SkxHkrasq+bXzBdqzgY=;
 b=m85LwoWvnt7TCCf9iKdcjfsmQj1NvJiV4+TCamydlwLzzkNKfBe763fHrBEPKioDluQC/Dd6oAa6mGnw+URalU+xZsVky3PlMRkEV6PYei26V1bXsCS4pzo6mn9kdopmu4LKCyg1OU2iaLsY1gF5HREn4zkwdGz9Dyvhjp7G5ME=
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:49 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e2) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 18:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Date: Wed, 12 Mar 2025 14:57:23 -0400
Message-ID: <20250312185731.211350-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: e7960ac1-d639-469c-72e8-08dd6197c8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fr0WGl91Dy9/EnRWPaAlfGsyWr9Q/rAbkazF89sqm5wTx8GeabxJ1eR6ZQuB?=
 =?us-ascii?Q?gqDeCRv7D9n+V4iNyZoR7b5SQqY0+x7iBQLPmFv6oQtHd3hfAMOg3PZCRWA1?=
 =?us-ascii?Q?m0zBABUM/BLtb7m5eOcHZ++h6hMwAVhiPHk1EIlYvdRB4AG0h+lFBmtLBIAU?=
 =?us-ascii?Q?r8LEWYtzYGFSP5Sd7j20gWgLCGN4LjsSuKkgN2ILZHj8XBeeyL4/qAUdD3Hd?=
 =?us-ascii?Q?/Aq7MPx2LrszX5CdIT4P/3XL1puWOGsJukoJm7/awO6oSiXONl7ebh2fJKxA?=
 =?us-ascii?Q?G8LJdDPagnqT3cqMP81G5OPQKPe9C7KkCJnsA8peEHHFBQcucYL4jFpUAYkZ?=
 =?us-ascii?Q?mP7bgou1zlSeHZsfUVCRhzPIh6lm7079Fl1nvuJqP/pY2oiTvW+U3N/iJ/Qr?=
 =?us-ascii?Q?ytCaIm5hYOp6yq6yRLuh/WliZUdKiD+fad8LDJaU7A9IOm+/Arj3AIOrUCeh?=
 =?us-ascii?Q?JuQsL0E9AsUdVFHTrzuJV+SZK/z/zK3Ot1pC21ICoz9W0b3SaOR33AFLCLJX?=
 =?us-ascii?Q?96KB+7o0gQehPQxV6EmjBQ/a1QP9bNy//ev4gNtAUJJKJvMUVqmbHwhtAopM?=
 =?us-ascii?Q?nt05XRc4+XV1sQRjqucH2HRZykKlht5QQJTnnp1TyZUuH653+vNkyrc6nuD4?=
 =?us-ascii?Q?Tzp30KuckO8CY8N3lKyWkuP8iyer/T7bM/wVjaYtXB7e+SMSPumILMA7aQaZ?=
 =?us-ascii?Q?vlbPPcdBncu4vRB1RBUqH0X9RtLd3nFBNTMa/j9h9J+IB0GXiKmh+ISP4pS6?=
 =?us-ascii?Q?w2xGB5eQ2fZ7KkApWG61o1Cn0PbEmzkyXp7X+G3VI1V2UQhBbS0OPVCZAmff?=
 =?us-ascii?Q?0kEId8ropVv0pwPZCtW3Y53anVqr3IOGMpNHddEYNgC8GBzu0an5ELSEa99q?=
 =?us-ascii?Q?AyhFSVJh4EwGRadOXJ/6LEbo6T6Z3i5r6NEtrCXdJomzG+/E6PtOCNIY3wC5?=
 =?us-ascii?Q?7mkTBWzEB70HC0goEBN2bzJV5ZbFDfq0N0V05RtSxxBNmB0idf0PMWa2I+Ox?=
 =?us-ascii?Q?UnrArWnO/4Mk4PNA97yx3ogsMP1cS5abqgsll/c1raADwNuhQ4aeWNmy+0KN?=
 =?us-ascii?Q?Y/D7zW5UPfz1RQGLZskg1dAAM9xzm+vlHcplpGFsIIqEBY8jwGlDDeD6FhRf?=
 =?us-ascii?Q?UYXYXB+fSdCg0qDJKQpq7Jvu4rtnUQPunP+dwpsBH1H4TtQWDI+fshiVxtEm?=
 =?us-ascii?Q?rshGy9ur/hGiiPGrXDIaY0wrXNQ3xT4q+f8YztObniFhx4Ra82MFxfRLHu9u?=
 =?us-ascii?Q?Q8yfYxsXNzxAVqaTxQIndEK0SN6jnCWKK8G1ZkC+QxCwjQ156a4h1I2rj/4G?=
 =?us-ascii?Q?ss/XvxMqZwrwEJ6LutgTRMnU5nk5BF/DDPiP+mP/OOYHZXZsmYiW/54fR3sL?=
 =?us-ascii?Q?MmPzSkyTmLtaRiB/MkP58wIyX4WxYck9KSTbnCoqZA4yAfurx40MGgkKiWk/?=
 =?us-ascii?Q?WN8rcWw63siO8PpT66g0+914BkGq/wT8kyuz3xIc38z3TsS6Cw7rVEyf0F4K?=
 =?us-ascii?Q?ke3jHomp00M8T7Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:49.3699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7960ac1-d639-469c-72e8-08dd6197c8dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
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

Add proper checks for disable_kq functionality in
gfx helper functions.  Add special logic for families
that require the clear state setup.

v2: use ring count as per Felix suggestion
v3: fix num_gfx_rings handling in amdgpu_gfx_graphics_queue_acquire()

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 984e6ff6e4632..a08243dd0798e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -258,8 +258,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 	}
 
 	/* update the number of active graphics rings */
-	adev->gfx.num_gfx_rings =
-		bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
+	if (adev->gfx.num_gfx_rings)
+		adev->gfx.num_gfx_rings =
+			bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
 }
 
 static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
@@ -1544,6 +1545,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
+	if (adev->gfx.disable_kq)
+		return -ENOTSUPP;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddf4533614bac..8fa68a4ac34f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -483,6 +483,8 @@ struct amdgpu_gfx {
 
 	atomic_t			total_submission_cnt;
 	struct delayed_work		idle_work;
+
+	bool				disable_kq;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.48.1

