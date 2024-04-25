Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFE3C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 10:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C047911A352;
	Thu, 25 Apr 2024 10:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KiFwYtOl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2115211A352
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 10:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIJCuEtZEwCIF4E2u7w5WRLshuqheec6qdLQfK7UfBdf85JlrwEOO3RMSjqTLQkmDhtCke48xoNg93z1Kf01+OgQTyRArYnr1+G5jehSXj6ooTUNLe/Kh0piz207Xju4N+nVU4zaxAe015kzoHkCZkZrpJszfXl1m8NpLUJQy+3cXsK7rcoCx7j6+cptu8pqR5Q4aG7q+eC0yn6YbKDUGAL0K0Cvm6SIjuiiMH8uHOv+/FokIB3HCWL7F4CRtdbgLtviwZMybeBC4KR0nRfvgcgctdxYu7LUwUJbrZ1JLkRnePFHqL4Wvuu+KtDZb4i2GUECw4mLHdPvStdbJ2H8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwHc9BT1ORxo/nwH1vw2PuUCDhBlvpEjCR1f6Mtgifk=;
 b=TWaUjPT2XZK36QU0NWG2kVjOciLPTp89+rTz65sTVGfVO+igWJnbkoc13xwsDCoLe02ymjz2rq6tTjYronhHbJE5SaatoW32VRjO84rQzk5kTPd2/BD4wJyeWf/WzkUbhesavznBuz8xqPjL7yKqVDXx6jB7F3OJ1h3CFQN4ulik0eQvm6f56lOaL47S9BodQeGgoIKn/eb2rvn789neA6fPm2/hyPl6ZyI+/SVOIBU8+StxYnsk+tIWONyk9ybShDwIIWRc9r8xWaTgun1d4U939ohq6udLP0ujN9hL78VKZStTJOMJXJOfhwnpHmhr1hruiLgtGwgM759jwyAXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwHc9BT1ORxo/nwH1vw2PuUCDhBlvpEjCR1f6Mtgifk=;
 b=KiFwYtOlJ7h776NOXbgXi34EhP5J9eO19cKnZkTmzup8UGED09jRYUe4lUiTtYY6Y7Ch/ew513ID3o1XYItKHerSWeT+z8rr4ZzQ4zhEfE/SQnDQ88CUjPse75bz1QtrZ9UORI5fnNBVYvvabkhg5vOIWGKO85k4DjNNrPvgbzk=
Received: from DS7PR06CA0009.namprd06.prod.outlook.com (2603:10b6:8:2a::28) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.45; Thu, 25 Apr 2024 10:00:48 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::d9) by DS7PR06CA0009.outlook.office365.com
 (2603:10b6:8:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.27 via Frontend
 Transport; Thu, 25 Apr 2024 10:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 10:00:47 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 05:00:44 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Fix the uninitialized variable warning
Date: Thu, 25 Apr 2024 18:00:27 +0800
Message-ID: <20240425100027.637016-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425100027.637016-1-Jun.Ma2@amd.com>
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: bca6f614-9333-414e-08be-08dc650e94c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PCAcjTQhAfEfi5qNQQlSk69qM3+GdtC/LckGxCHAIdGPQUGcCVumsz1HsHYs?=
 =?us-ascii?Q?qalP9Vi0ER5Yt4t+jYm+aOiwT1Q0+2WQw0Zh91cL0Q2sAJGjaCdfGh/saEga?=
 =?us-ascii?Q?CSlgvP0d0vRYIT49BVvswG+yiNDLFwcWrruu+czGbolZcun9mTSfid9j4kBP?=
 =?us-ascii?Q?6thBbHSjjh56E9ul2a9zZ7uSTSf8zmuTgtQQyUTpPNyPexwFMs4otbRCqiL9?=
 =?us-ascii?Q?mjPrNUX9DYRbBJUUPt/FxrsNdKzlct0A1/d2OPhevBCPBZtlcI+muTGkR2Ys?=
 =?us-ascii?Q?Z/1ZRRQP2CuKUYKp+Kzd8EGrW+6L0CpW75Io9EyJNN4bgmZXL8yo4RqYc32G?=
 =?us-ascii?Q?pmoZwIJZ3RKrrBUyLpt9WoFk8lJsjazUbAYymS/fiyoNqeNZTlKQDQWOFh0i?=
 =?us-ascii?Q?wRBvHnyh6nbONuJhgTTPOC8b0nfI7FLixYI5jLiwpUvGz4nvWLoC+cFhlOqF?=
 =?us-ascii?Q?ujVGpKaxQNhcHj3RoR7siaStvG5kR5eVMgPnTeeCUjcXdQBRXG5rPPVocsIT?=
 =?us-ascii?Q?khYveJE42/3Zkzl/q2i7QAq8piFyGflYI/pKTYxULO+VL3YnLRORDrbrRFXG?=
 =?us-ascii?Q?jV4sEodNW3NVHpgzclNCoPJmheLhUk4bMn9F6x9x/CEep0FEuRXifGCP99WZ?=
 =?us-ascii?Q?jjrE6XRRmQp32qd2KfXXt9WiWOqt7E0vkOKCOn/gzYjgyipcCOFLHpBH2FwW?=
 =?us-ascii?Q?1fUGdKGhnNthJbRGV3zGXQESBw1Uv7gYO+hHYJwbH45QsdZzmH4AIJFbPSJX?=
 =?us-ascii?Q?Fm9pNQmsMCx0fWiIBPRHbaTOR+OeTXDo2WflubAvRl8IETOwTzGRJXJa8htl?=
 =?us-ascii?Q?WrtztkuANt09NKzFSWKDvTbXjuQk17VOfz5+NkdDf1lCQ8r+AqiWEQKLj1gd?=
 =?us-ascii?Q?J+CRnGeK7jULgbke2GwxFSIwMZS17+Yw2ZYjiBWXXYcxDc+e5ew2Z56cI1ov?=
 =?us-ascii?Q?Qknne4rm3OsIlcfM6napnEVIGwfmaTDLvZknX0yTPkeiq7uw3sVVJwV8GEyI?=
 =?us-ascii?Q?QT5RhKDn7iIkC9V1uMz/GZYdGC+DhM/XAqVYvkz2iDbZrrsKuS36S2BVwWxx?=
 =?us-ascii?Q?d2G6RoxjQKcjzMCQqowkBFWvfdNraWqpL5zdrLZRLUkWwhcT7DTnKoJFE67g?=
 =?us-ascii?Q?JfBonUdebGQPij91Tt9Ag5kTgVXP0gboeCm9E812IN+bX2tilN8H7AclYW+P?=
 =?us-ascii?Q?v5yflpUXv/mLI50g2OHKu3ZXLaJ2R4GB2s8q1n2XTbm45bkIy5D43l2aC7TI?=
 =?us-ascii?Q?kyrF5eVHB9WQ8MYodQHN2WeBdUrOFmKhfrPZTq49sOcOJMx7GCOX1BxFNlR+?=
 =?us-ascii?Q?KbxYiyhBArup6AhrUofHI+4ESu5aa44SBCbYwpOjz3fXtr/ZcbsDcLdNlSLb?=
 =?us-ascii?Q?3obJj5QWP6nhETYSUZ30Zd4u/zrT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:00:47.8365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca6f614-9333-414e-08be-08dc650e94c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

Initialize the phy_id to 0 to fix the warning of
"Using uninitialized value phy_id"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 8ed0e073656f..53d85fafd8ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -95,7 +95,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 	struct psp_context *psp = &adev->psp;
 	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_device *dev = adev_to_drm(adev);
-	uint32_t phy_id;
+	uint32_t phy_id = 0;
 	uint32_t op;
 	char str[64];
 	int ret;
@@ -135,6 +135,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		mutex_unlock(&psp->securedisplay_context.mutex);
 		break;
 	case 2:
+		if (size < 3) {
+			dev_err(adev->dev, "Invalid input: %s\n", str);
+			return -EINVAL;
+		}
 		mutex_lock(&psp->securedisplay_context.mutex);
 		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
 			TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
-- 
2.34.1

