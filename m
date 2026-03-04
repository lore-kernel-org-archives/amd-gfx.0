Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD30EFCE42
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 20:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2FB10E1A0;
	Wed,  4 Mar 2026 20:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNahv0Ri";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8E210E1A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 20:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIzaGs4Ciz96b2HLN9t153iRuhG4AwxLDzyLoLQoLYA4mOYtrOoyFVTF0jY6WrSVDabTN1CbjDaJi7ioqYimK7OyZqQqgJWse/Ff2vaz25eszFkvI9g6W4ixCUH3k99KO/zr4cGAScarfYR8N6I09UCBv7S4W/l+kfCzUNT4AuELfN5bZjSvl4f/4xgimHi2qPY2lCG+MrIZWwf7hLl2fEq4Y+feDum7uFTjg8kMJey0JIn8jlCY/OX0UmyB3GH5TJF9jL2sr0kUmq/dG6inQJLBXvaendd4aaTJac6lwxcdrBXHEguP38/4vOTjCuJhjTPWoJSJy9qu8kyrjn8Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reqZN7D8Eys/h0V5inMnUWkR/4Q1hEJ47ocOt267PTQ=;
 b=LDx0cWTrkI0A99Z98Vdx6PDVeLDs3aOJNSxXI67GaKBh9jFrLEqdtrhO8z+7uLXfCCzwewopvMPGbAE9UeolyFtvKCebW8ycDxy1HRp4ToA6LNope09T0A5T1Z2ch26oTXv5KY03w1HwVyq3TfGs+FxecRbmsqGRer7xuOgMVsWqEfPg1so5WqcfP3p85FY4VKphjGKJysh9zlMXKqP73FWmLFeG4V6XGkQv4blX+Pupo0hN94vuRh5LgfkJ6ew7EIG0wbwluKclAMqIxQx4ojVDcde/u3Mu4vTwuKIUUnmmREcH3s+NYImc14lB+6DhwAbMv0GYanRE0nooG+8DdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reqZN7D8Eys/h0V5inMnUWkR/4Q1hEJ47ocOt267PTQ=;
 b=pNahv0RiBmdI1y9YCnDg8rHz5FmfjdzbDlo2K7Bb/ZAeLCU1LY41GXfvDRL3sJNgK/zrd1a8SbGSppWVPLsLld/3EwScBQOI7cVaKqi5ZWUmhfw0pYFWQEwSY8R8RW473eZ6SlvW6J/6aTxnH1gKDqkwKtYEpARmWquKYeh1nfM=
Received: from BYAPR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:c0::35)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 20:08:04 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::6b) by BYAPR05CA0022.outlook.office365.com
 (2603:10b6:a03:c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Wed,
 4 Mar 2026 20:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 20:08:03 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 4 Mar 2026 14:08:03 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fix NULL pointer dereference in device cleanup
Date: Wed, 4 Mar 2026 14:07:40 -0600
Message-ID: <20260304200741.1096953-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 26283e2c-2124-4724-a63a-08de7a29be71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: iDG/RuPBlZXTyrkxGNl0eJRwT8+NepsJLcGKK0z1OUoQlDi4Uphwv73Xhmp63ndSAn+Hbxz/du89i+EREQifzlE1hVQTZ+KRD26eA44uU9NuDHrIqXA2LVY7CJTF+CkC6kMnlt4e8rjDPjKwS844/GjA1MkfgBqpAiVpSYHNlZ6Yu29jv3G9JqTAQeC04U1mw/RgxXaHute8Q0gaSGefKzr6hhQD9x9FjBFaDfpNSxhwtSG6Z0xFDRWMFEH4kFIPHzjIypVhLaK3xc3TGBsjYGBqTrmlbxK+Rd2l8ysEaKE5EWGjw4qe2Xd6/SeQVzqHCTh5S+gAPW/hT2qwKpVfBwYYsmPxxYdAJmBTFPK3ONNZsznIBfu5xz7BDp93OAZK7vuCRJm3O/n7qBb+jyuiA2TqvRQClv1aLeRS1rrkpuT9ltSzn7lOZlgfArGHplfL8lQzbhV/8xTf8GLDrTzv0qt8CYYgOKFGQEkqUv/3NQB7Ok23APhE5dNncSbsjAxgNxbdxb1hxJqalwAq/SVRoiPwUl846D7nWB9PiqbrkgaTJJjxPoL93G18DSXDRr16FjTamBwAV8DmcVK8g1jo7R9x8o3NiJN49j4RoPP1hPdAb0RyHUKg7l+1IMhkhnN+7QQLlfiRykdzm9oc9xu75NyLKXXWl+15nMrdlkJA7l65/C7rtKdZMWKvpPWtU70LmblabuMv30S1Ce5Qq5nnMJqcQk3/TmkM7oGu6v/ZEUrQILWFIKwtebgxYjjWyyM7+GUv4JGnVFjubsajVMbO7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sIMMDUjw/fqxGVz6WwmhY0XMEDi+ln8qDSCKQKvNBj9EJYdYfuVpUhUgp7mGkZA6yUgyhIlSavI9c+s973c4OzoS4NPiORy1CNhUkZ1z7qzyl7KO4KTu3C0BCbKCvfQ757gyMgNixjfKLOhSrvI9huNuFwucFxrVwYPXBbObZ65gecQMh3bop2IwTSODsGWyiAVJ9fMdVw2V4Nn10H6YnvieGiZE7LmnIGVlPQB/ltBvzP3vHUGMjwreIFl5eEQsZ+gzzgKhOy150VytE14liL0DDaDqs4KQGkB1sH7UVoSGjOGl1AKLxoZ6cuMXsSEFSjYSC4HYFZyN1Nr8mrlpOHFwgIhpmxYALOfFDM/9h+5ru5DmIVWb+JtFxAU/DPGx8A4/JWS1Es+pdXdbRNzzbLyxivqeQnrAkr7gEIBBz+MaJAm7t3v3jtBh0vBC/nUb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:08:03.9214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26283e2c-2124-4724-a63a-08de7a29be71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

When GPU initialization fails due to an unsupported HW block
IP blocks may have a NULL version pointer. During cleanup in
amdgpu_device_fini_hw, the code calls amdgpu_device_set_pg_state and
amdgpu_device_set_cg_state which iterate over all IP blocks and access
adev->ip_blocks[i].version without NULL checks, leading to a kernel
NULL pointer dereference.

Add NULL checks for adev->ip_blocks[i].version in both
amdgpu_device_set_cg_state and amdgpu_device_set_pg_state to prevent
dereferencing NULL pointers during GPU teardown when initialization has
failed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c24369821e47..258391ddee7c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3258,6 +3258,8 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		/* skip CG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
@@ -3297,6 +3299,8 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		/* skip PG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
-- 
2.53.0

