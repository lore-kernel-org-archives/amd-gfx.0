Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EF5C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 09:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5994110E131;
	Wed,  3 Jul 2024 09:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1bU/iK5H";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15F410E131
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 09:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+gJhJFWOcKSgbh2VJDrV8LdSlGnlIZSj2dtpHeQrsGqU73s/okGlIGYHOjnEj8s6y6hZRMorV3OTvgw4S5Vj7DdIRhips4gGfEypvLDzsMjvWIxZwoKEmWxEqmHuKvLEKyBvW2c99J7UnitWb/UnZsjY2BunO8QeRYTb2Xq7ZYjH2RNkrbmfIrR23najzeDpuN031h7qAv82Ys01VXpLrREZ3EHiMbRsRHghP/+eD/YFDxBWwpMIHsxILaHSgxPg0CKhc5ZJF+oe4CcoOTiBF924gSoOvF8q/VAshayooQvlYzxgjaFn0vIf5uvhoyIW+edAEYFI32V+OQIPDYR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaC5mb9HDoLKOomC4bnMQ+Bh1UPTKWYhl8EUvxOD1Oo=;
 b=RL/+IOpKFqHwxO0Xz92Idy+g71BgnsPZmvRETU95Da186if1/fiPdkb2K51d6LoPVoTfh9CYaF1JBXCsaQL53rf6yFm5xpDuhjtxWKV4xSN0kNXd0CSdgbiE9QrrRhRJExXRlzBCWAABuhTR9yeIDf3CIPXMgwsXXiyMm7S7JCLO6ocLmZZl7S9ETCELwu4sIUQSmR72l3Fm5l/7cNkRQ2iOdDstcozoYVCkfLEuTev2vcUTapDJo/OcV8V5+3ZMBaw9JJOdyFUMZSrzJsxkAnuzxR4LrmLBuRFMOXKgsOwOAyei0k/6qEZTn4FuzZrcNSfWhxrIbs7smvHa44S9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaC5mb9HDoLKOomC4bnMQ+Bh1UPTKWYhl8EUvxOD1Oo=;
 b=1bU/iK5H6D37Q/ij/M7b2DqaNU1mh18Nqynp/Jzmzvt2HSkrjk+saJwYLHO9IaJM+4BJAc6WHiZ7XJbBVR4qZ2P30kuBRa4UUWJNnwRkoVhAsgzxZuBQkJ+p8xk/Ea0hJnuw7YYI4YA3PArqCXoVbtdw40k9v06Y59fATTNLPFs=
Received: from DM5PR07CA0071.namprd07.prod.outlook.com (2603:10b6:4:ad::36) by
 DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.33; Wed, 3 Jul 2024 09:01:47 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::14) by DM5PR07CA0071.outlook.office365.com
 (2603:10b6:4:ad::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 09:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 09:01:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 04:01:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 04:01:46 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Jul 2024 04:01:44 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: : Fix the null pointer dereference for
 amdgpu_device_switch_gang
Date: Wed, 3 Jul 2024 17:01:44 +0800
Message-ID: <20240703090144.11241-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: b45c2f9a-cce1-46f2-a8aa-08dc9b3ec50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dmYuSKZELM1h7Vp7PDHmLuCvNZomIAVStQFC39gcJdvhSyPjkwHXYaqrd3fb?=
 =?us-ascii?Q?OqnMP0dpB/yHYx0idT8+Nlhasjs4XMrPxTEHwr3XAJQvw9KuJ8DARXrChRHy?=
 =?us-ascii?Q?ztIB4u94OlM3aKXTFCIR7vQhFX0JMN56PpbKhStFO3vC5UqH5a1uwUR5ZRJH?=
 =?us-ascii?Q?weI1H/5p3NmOme2hNEM/IWVgnoA/8T9JsxxA4HTJcqRqPE/WjrYsm/X2gVLi?=
 =?us-ascii?Q?mmy5/+G3n7PDWDzsRTnZNf6NX+73yFYZ94IE6yjHDtgayg3j84G0EN0aUmX2?=
 =?us-ascii?Q?DMKAkQ+mS9aOo92P7z7cV9FljPMqmaLj5FIrAxFGOp7bZSyYskKu04Yr+0ND?=
 =?us-ascii?Q?4cqa6rkpjCnGVW/UD1/KRbIlGglSgAJqERE+93G0tGdIshWzwoHuWMxo6zJX?=
 =?us-ascii?Q?uU45uQA7czXokr8Qt26aBRui90GidtV+lsO+sxu0Z2UPPpi0JTtRG432TCpT?=
 =?us-ascii?Q?Om2L0cyUtsvJkyfLcrEfajvP+JyKaBqWJz3fMaSjnn+5DKSTZOfrUjKtUSu+?=
 =?us-ascii?Q?uBRWXJsiKeATFvtTAoqIuGj+7q55hHZRilYOSSCwqiRxkh+6bqibWGG5QvFB?=
 =?us-ascii?Q?jRvJy8Y9X9A1XwJwMBi1G3C79Q+CNF2TN6TGBBO6BDDywrh0kYOQihCH3Dfe?=
 =?us-ascii?Q?t76sREqaVjjrqmQqgXx5wh37FjMIQhcDRlvtjFOqYZN/tXp+spAkaUKU0aBu?=
 =?us-ascii?Q?iHkfwUzHLyMPuYLoW7CTfOTKt8VAordroW1eR8pHapdSZBSeMqTNZ5zFPpvf?=
 =?us-ascii?Q?UPrsbL6gMVKGZy65SHyNDpEzSLV77ekUk3ppncQoucRnlGLTahC45a9kQlc/?=
 =?us-ascii?Q?mYHRBvGYdYqR7s4jhpo1mc6b398bSe5NgdxfHUF23Bmw6kTPvl6fd8gthKLB?=
 =?us-ascii?Q?qkM0xyhKTwDmoTJE73knYx8rIH+I65vRYiSf1K1Oo1n3ankgdmd4ucZ04kHB?=
 =?us-ascii?Q?yaIsDWhRLC7fWZC8M5RW4yjdwkRlATz2G2kRbA0F1B0g/kRrTLLnZytdyW7n?=
 =?us-ascii?Q?2D0nUpEAkNuZz+jRf6Zdrw9Qpd8LRiillInmS6cRtVFgV89JMD4nmGyqNWjg?=
 =?us-ascii?Q?3346jvVg5Fs0YEAPUQtIt9IpgFM0gLTu2XrkqIYl7VkFvgew/DLi2hGavFRw?=
 =?us-ascii?Q?nPyJ2uWbHdOkBSlEoV6IqRqcY0zqPizE04UodNmrMyR60JSBB+4lkcdZfW3T?=
 =?us-ascii?Q?ndBF4qox06t053BUwyGQnBfwEsZrfX/VcJ3ewfYGxnMEeWa65Tb4HeOenTWq?=
 =?us-ascii?Q?YRXrVJ8bAzQhBJXW8jQpRYkNXNruuJPTUB037EO6gq3zyOSqYegH+2U9Co1C?=
 =?us-ascii?Q?BEH/DGZa8qp++9e4ByT5+7I52KqHoM/PUNYbhTs3BWJTGtEE5AB2QTw2IbZD?=
 =?us-ascii?Q?FZWYIV4LCp0uVxa1/b00+MmBnIOwfz2xz8aeR+MskZvNSMg+YHnsNOLji7cQ?=
 =?us-ascii?Q?aAF4dRtQNqa41hBTlFCIUFWxlAOb0vrW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:01:47.4711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45c2f9a-cce1-46f2-a8aa-08dc9b3ec50e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
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

To avoid null pointer dereference reported by Coverity,
so add null pointer check for the return of amdgpu_device_get_gang().

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bcacf2e35eba..c1d82c346daa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6569,7 +6569,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 		if (old == gang)
 			break;
 
-		if (!dma_fence_is_signaled(old))
+		if (!old || !dma_fence_is_signaled(old))
 			return old;
 
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
-- 
2.34.1

