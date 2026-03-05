Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFF1F513E1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 22:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1279010E28F;
	Thu,  5 Mar 2026 22:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3yhKKYAm";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D06710E28F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 22:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRgKtS2K+4T6+v//8co82RRu+pyIGEjFm+/DhS+3R3IWcBCUraqzqj2HA/xmcNZCxCETd2kwi6kAhawDVtJ7dNx2hcoCkh6Eq5OEHts/OCpYijFkS6TJZyVWmZkY/r0ebEShwKdvR5mt6lk5xLGLubR2EACkaj2EWUOaJ/BtYq/f0TktJi+TevDCTyjavKPXTcG/YUvovn3p7tB30yoPkPQbJerMJF00Pgzntt1gmgfpqjUTUglTjO9cA99WITaoE6zkT1usvl3lpSeErLQ1r8f9Nel9LMDP6//rGNmnVieoDZuN0MIq7eBNcbkCW2VQLjggPWrlF2q5bfcPIb4cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ6EWwjFDRdoBjEDvYF21l3nvU7BjS9Vz6VUWuUtKDM=;
 b=wEiDVq/plBTv41eVx4Vvg0hPttPgfsld2yzgAwNmsGOChSiYEwET9C7yzrx9/Wt153HdYo6U/xZupAhUgL24ovYztblm+foLctduCo7k5Mfq+MzdIrdH/KHLlhFSbmHz3kDzzldgNQ0XOWw2h8EmwJU6GPBwhRQjk0Ye4d/mgUpkduLq3zqqqGhDT627R58VsU+DPgJV0Xn5wB8F17rSQSqIPgG7DvbjkozQq2H/wQjd6D7UgtkHU1h7n+IkAeOOfY6WdXPcLOoVftY4E5Fwxxu9AquwOurUy0GXNuolbsNn1XN+/tSLQ97W1G8X8fzhxxciNPpwjeZukK9MOqSVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ6EWwjFDRdoBjEDvYF21l3nvU7BjS9Vz6VUWuUtKDM=;
 b=3yhKKYAmNksm/ncXLdYfV6SpPdX0eUTpqCis7rLo2Kj0FRdL9fBZ2exZqI17JMZgg+ebWRbxDCBzqzST1nS0XvLfgEerXXThcERjalNCwonoFzmvf1iJsILMVYLhVpJORLnGjCBiUF+QbsUKsjxNWymSOBCKSFoqUrzOgA6hBQ8=
Received: from CH0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:610:e7::11)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 22:05:59 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::1e) by CH0PR03CA0216.outlook.office365.com
 (2603:10b6:610:e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 22:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 22:05:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 16:05:58 -0600
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 14:05:58 -0800
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] drm/amd: Fix more cases of NULL pointer deref at fini
Date: Thu, 5 Mar 2026 16:05:39 -0600
Message-ID: <20260305220540.1354776-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 525a429f-26d4-4613-db02-08de7b0361cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: Hl9O+vEBIjGm/IlVbLm/+rLZh/Nn/Q91smz6EwcvJi0/Zai5ACGTFkGp621CCgbhtafKbaLHS0cathlgXZalunbw8cO49ZA79d/EEjeYqgJ9zVpQSXbpy3281YyJCJeOPPGPCoAdKWnvCFJOWDQ3iZWNu54e5JovNeQdulFe+dAFWPSfaKmZdijP/wjasQ//yfw5nmlxAQrTS5KQ9SSGZHigkoKfmoF1z0qGzNsXHdzwU1tqAzPF3Uk6jBVA4Qjr4qq5drJBiFY3m8O9XBV2VIPF9hBhi9F9u+3et7+EIWD81h9px79Xy6OjxOXI2q6h5EKMrzt65OAC0nMqNNvKJvy6+/98yo8O3Bj+fR8Pe+aSRj+salgWlEr0e2y2S7FdpfhxcyfNChl5b/3On7R6jAaLQPaWU+cysr9AWWZaneMehLz4xQpYYF2d6zAElgP+0jFSRT7gWBZKVyKcw/2QaJ2F+DnL+zi6zv2I677rH+Lf/ckI8a5i/25Fe6taPSWJzsBSnpftTU1tZtpfMTuJgYkIHWFVBIsz8/leFrIfIWtPGAFDlP6nEOI58SgwTsPyWGFc0g5EmIlWYpgK3+wJfv5zWuAOv6q+8BiFCzvJwtGrWFWp25DGlgb/nZvZdG72Zgg85rIe4xHFwRIJoUISpyBHtVSMapTWWctQ73NOwMh0SaJNSF0RUIIpHVSp+CRakzZFkANvljlFA4XSmX7BJGcMvK/kxRvS8C08cNo20snsxV+Hj4jX4owlIy/O8FlMVpBLPDOwNHEeSu9e7xQm8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zCBDMjYd3D2b5EskwZDZFt0uqz779R+Elp/gusGJWRhFPm2Gs44qsAYw1TrwsVQMtHtSe2XHMIGXQyFNPkEoE4MHr4u3FnTothFiMTMog7foTqV30ElIZ5JKWw6r81tgs6WnA154uBQ9dK6THmyIsJCb3d8jplaQAiKlSxnTVsLQN/IX/96vX8RQbasesZz6NjfHDZjYNRd7vSnb8Z8vl+lkUWmzGrAi9uq17SXcnWITidxvwmzl070MU5eF+ukeklOCo7YFxH6wi5GYOeOgBixXW0UcTkiCH1X4CUFHzcRWBuYjEgXNdIXf/8FdSSwTkraqCTZwFEGY+eTMe4RY2hD77fVCW1UXOmah/wuNSo0m/pSQK/mVno5WF8Uk1e50RXm1IHWzUZTFSET7+ZqxIkgpUSSv86mtpUSeAlubN94ePNSwa3KpdaJdM8EOiQx6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 22:05:58.8813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525a429f-26d4-4613-db02-08de7b0361cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

I found more case that a NULL version causes problems.
Add NULL checks as applicable.

Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in powergated state in some paths")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bc6f714e8763a..74cbe58484fe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3463,6 +3463,9 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (!ip_block->version)
+		return;
+
 	if (!ip_block->version->funcs->hw_fini) {
 		dev_err(adev->dev, "hw_fini of IP block <%s> not defined\n",
 			ip_block->version->funcs->name);
@@ -3496,6 +3499,8 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.hw)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
 			amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
 			break;
-- 
2.53.0

