Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E108CD98E5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031C210E792;
	Mon, 15 Jun 2026 23:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1w1AeaGw";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386F110E784
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfF9nQfJ44ytniaFjbAvsZkJP0ObmUasCJQcl1djrNMDVtw2K2PFrzgvqy11wN1ii9b13MIM2sg1ho/rDFBPvNnIqmoeDGydvCNgwU6uE/QjmU2WS0J4lh8kFqd03ibcRZzfHzt4pJa3Sn2n/vL1cojQ+TEBBw2u1NHHy+pEbdpcRvk/ybJlgjA/+y+tq6uOJUa7zBXoPRw4XiYgpcI98eFUkH2HwmWXoUWLVNSUGlDWgKLFJcZZZRANfDVCIRE++rrMmWNE1F0WjW+k21fzv0zZUsZpMV3Ca9L9Td/AE2gB9iEa/6kRhPfAIjNMsaVx4eDECUHKcycAsS0BtdGghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e24JC24+Rt50FBRD9Ye9+6Ln4ZZZD5d21Qx8L1CUwa4=;
 b=eWlwYGbPMplQxRgW7aJ3MVWXAhgpzHI8gjW05BBs5ZRKsGGQy1XOvqbJlIS6txIeD2NCBpreZCcfMYxZTIlHkFKd9RItzApj+VDS+5943dqEN/nvzUDVEgQnSdsYPZ2EgAN9tbxX8O6JrtyMfe68UCjtFUZofzcfekAu/wV2BDT6GvmTwpzYD+MBkEdhFokgM5HMB4kqs4c4tvyLqjEIz4Lcf5BrQlECQo3OCrA45fCWM0ISgcoRJKqKFeUsAVy06MdUuC4zolEd+vJfnj2Rmkuw04q+HGsJf47fzNuyqWTz0P7YSEnabKktrTbYwpI/iLetP7q7LB+wiIUX32Umew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e24JC24+Rt50FBRD9Ye9+6Ln4ZZZD5d21Qx8L1CUwa4=;
 b=1w1AeaGwMXJ3YsYknJJZuIzMMEg1oiiRyCWU024CS8oO6rDURhBC3dVFgirPs9v2bgjQAJjTRHDMbSTkexo1cH1418KqpOOPPx+j8YUjRBTgsbbrSxJsEcx0m86PxUw3q3IsMnESzQXwWGt4rAtZb6RK1K/H2f4qm4ksvZP21EA=
Received: from CY5PR22CA0043.namprd22.prod.outlook.com (2603:10b6:930:1d::26)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 23:57:17 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::91) by CY5PR22CA0043.outlook.office365.com
 (2603:10b6:930:1d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/43] drm/amdgpu/gfx8: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:39 -0400
Message-ID: <20260615235645.737189-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: b5efa252-53b1-4483-1ca5-08decb39d44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uA5/5yCkZ7s1tvgvIPCYdPZwwwADMAhHkbB8JRAj8uwq9i3+aO+wUIzadA0IEyACsoAHAguRBzdPD2U7sTfjdDx2uQ5sjPKSy+sJg57YDswgvVULLSQ3inqVkBSg0kufaJGeKAXStIAM2p97wQVVK94VmM+3U0YtMmVyb56th4ckJgs46EZKQgHuH6OmNtQzVT2kc/FjcL5VO9/qeZ0uLZJcuqbxRt2iufQGrOZ9boyXd7QQ3b4SjaUnfKqLTuuhpNnYybPblYx3A77F3Y8RtiykyieK4+XWNaNRPhj0P5qwLU0LrFOu/K3UrtPatzF8R99jzjMc54PQ522XTJq9YFLZ8pnVvLqijpb9bSj8fBstaennnz2Kzx8l+0mFGEZ0r50UbOryE68Tv0ahJ6k6SOlmBFKargdU+WDvWtL0ZMBL31PyCVNrUX3IytvzHSMSiKxLWkJBiW2So767G3gHfE8joisib7tS+hyg3JJ34Z2pvl7feBj+9HIU9UiOkYkq1U5QfB6CUS7pUHjR4XUzqeU2lDskHWIyARBYHbhzRzwHFmJOpV9nCtGV3Kk8PtbSOSOEzsQqKjl2tk82A1l068rwZ1ZFfjNHI7GSPBemEs2rbXpK9XEwRWk9YvsVGDmVAg4UuVjpXlvBSG2etJpahnQde5OaUBookmWCCqgYtmBDS58KQQTEMMfS2jyTXfIxMTmBXtoXp7DJpuFbg45Aa5v4FBJ1wYC96AbJCFyX/CQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FGTwAZkh2kYYD/W9Nkc4HrgSMboJ24pp8fUtYhNaRHCC7eD2LVtlt3gGCbZCp4dAbT2N8NjAcF2u/Emrg2zSGWPgO+zH9ut8x742iY4jTYrXT42wA9Lg0UTh0BAcQRywgFPAbd5cELmvbORKXi6/+umESVIKkl8+1UXkKSLNuf2D1ZdNojw6WRJl880WudbPdVLmDRvMPJIUNS12ElC9m4j4Vw7n99hBdCZ+DmuhWpjxzGN1bqVKfhfJiUzCpSBSW5/arrm/wR+sdnUvJmzvrM6RTOFPCE5wkwS+haKHggTxmRsC66rm/p0iE5JVjogtqXzZXxaJD+VcafvAVZw90LyipKgZpddFKRwkKsqvlPlsV/J3+b/M8QSJxYoyR/SAegtM0qtOF+swzxxwarunJvIcXSfZVSggFafSpwqKrx7V/yjTF1ZUu0W8uJWvDGT8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:16.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5efa252-53b1-4483-1ca5-08decb39d44b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 70ba81e6b4d43..389ad2d33abfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -977,7 +977,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "vegam";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-- 
2.54.0

