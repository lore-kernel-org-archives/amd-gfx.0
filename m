Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B318AFA1FFF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583DA10E040;
	Wed, 22 Apr 2026 21:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Emin/ahk";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6CB10E040
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epKvqgDhR8N1xqjjWaYrrO5soPGyFaQthdrHWoAcsP4ade77O78BVCKY3nzjSIk+uaDfxXi4PAaXJz8Yms1zPL5x+PZZySdSqcEGmjXcn7Qw33RtmPFHdT0PuHMRq6o85WdVOpeT7CaDqCW0/d5k44Y/H3Qrm91srYES8zsdvLIR1atYr+8FCeYIBXjexCD3p31fwkpjn5DN0lylJNZFjcrRuR+D6IgKO7GMfL8IQBAtzuDNJLqkv/YJRXgyfbKODVGkKcNguV3hPiE/DxkZsm/qpstk4FbeumvtzdtCV0sdfBlTwBV2ge8VC3+cI2DbqpR+dbeGE2s8V1TthOyC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrXwCR6+CiNnynjvWcmxbLUEzx2gP7oRTU+ZWC7ZLt8=;
 b=Aj3Xk7HdaAxJzsEw1Bmdp8M4PS0CjwUCirjCGP2W06KXgUsCxdsW50yTf2JuCNK9wV4VICFA1M/35dfg0+m5M6xxcoe0EsmmeeIJaqtTVwCBWpVMG09drvzpjfhFvl7BQ+xEO63VTadJ7zwfyWox5fMAwfmlUpQQNvPvj3j1vra2yG+vGDLvN4D8UEsx1aGCHzL3bOEgLL6XoVh7O/Hc7NPwTXw0jFp0MLLsTs5NvvMf1+evnkhMJ1nTYzrhj/do+5CSTfUUYFn9gZ8ikaGTc3U903uuuFR7EL7+FqtZeBuzFb0n854mUpC6k85dGyuPfm2T6UHD21M31W4H1uxBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrXwCR6+CiNnynjvWcmxbLUEzx2gP7oRTU+ZWC7ZLt8=;
 b=Emin/ahkEJFIZeb6T8f7yZITl3lCyiu4hOD4mMJq5rJBRBMpG+3nZ51X2A3hpb/DMWebWqV3cqdjsLeC4TO5lhP5yq0lp2I/y7Y5r9WVukUFoFGQ8yedExXB5Zm04sgSyLZkSgRTqwFYgILFzdQhtBPjoUkjtVeEgQcraV9WOkU=
Received: from BN9PR03CA0908.namprd03.prod.outlook.com (2603:10b6:408:107::13)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 21:52:14 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::97) by BN9PR03CA0908.outlook.office365.com
 (2603:10b6:408:107::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:52:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:52:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 14:52:13 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:52:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip.Yang
 <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Set default xnack mode for gfx_v12.1 A0/B0
Date: Wed, 22 Apr 2026 17:51:58 -0400
Message-ID: <20260422215159.2242821-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422215159.2242821-1-alexander.deucher@amd.com>
References: <20260422215159.2242821-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: b97da116-684b-449f-2f36-08dea0b969f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8onNRFwl7utNvNzLtekc8IosprhNa+4hUVESXbYNZpHuSiX38+YG8lfns5cZTOs/KI7E7RjNi5RlvrLzD0TKGxNm9NefUZAa1PHablUXhWwPfah/Guxz67UuM0GnkHEs10NzuavAH0ACl4kD9JkKCkhQECgGriXpi2LC3m5JxNEfOtANs5T99eI5/N1CdiZFHecc2PLhcI5IXd97Xe9xnc+Pj2bZWeLbvKRmrJZgzJVJ8GN2onTorH9zu0//HXaFCc/pQ0wmI10Uf9f5Dx9gRnxmXmlbYmYWfVdzvbRyV+COfpdknnN41uBvrK5TImjhKo+qdBwbInAcnGuGqicY7m1I8CD1ck7QV+Uqq2QKbWGHLcnKtSbWQq2822YT0EpEYkFQEvHXRKxoN0VXz2oWrvvBmCLzC11G2Hc6J4g9PMRtOVBhfj506C0QbzfjqbBQlwQWlM0luOef4aviI416ESJk196OeZmmZleOvdGN0nkMWax7WwRg6JIjUbCtBwTqJUZuYw7Nz87/U/o+PTxjs9CRxUgjdsuNNmsd55+CuG2+kw4CmwVXp0PvuvGb9tMd1/hfYW4+WYS0xhFevToslJAXz8jQYfPua1eyBbAEieCWuXnfCeDrMUaZ2mNRmtYZatSJ/onJYcb21H0xYZZYHwrBmaXEk6nMQGIUJAX5s8bhzMV78JtJ2K22KBHRF/JtCrW86f8IegyiVrjCcI3skJ0VQsHMJe6uObwBD5FNV89L0YqJaBqDyj9DAIDQo97ku5dgJzmh6gW5Q8W/LBRqUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aes1PSJd7fX7FlSMJB5ATFRUQW5wLdYZawqAw3+ALXU2dL1/1B/sTudE85dbpfFh/UWE+qffFbTQ1dd1Ffyq4CArwUza6eWSbAIUExXxCNwnKWo5SZYNWHyObJe9oAeD5KO7hlDbglQWYbq83S3bUXa3+1vy15SGKx5M/eJ+bQGhdzK+5rX4Hbk8zKX0/cluedfKVK7qP6TAYDBoFmx/DiKH1foyN2ZHiQYsvqsA7K5LeshdQjc67eYWrBy/gn3c7N7/eNeg52kHd3692qPa+awRnur7xPg6E/iDATyDvgarjwbDuRy0FnNLM9AlBuhb843Ki0MpZtOuIy4c0j+U+M+GUqWqoohLihVrrpW9Ut2QZgVKuLgP4JrCd5Es/d6pSeIAEKl/2ipOLcM218/J6kAXWKqvir/Us1vZF5W/CnpTiZ4fuNwZ2KtALYM6Srh2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:52:13.9632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97da116-684b-449f-2f36-08dea0b969f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

For A0, default xnack mode is off
For BO, default xnack mode is on

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Philip.Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 290b9f9043036..1a982c6a35f37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1004,6 +1004,9 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 				gc_ver == IP_VERSION(9, 5, 0) ||
 				gc_ver >= IP_VERSION(10, 3, 0));
 
+	/* For GFX12.1 B0, set xnack (retry) on as default */
+	if (gc_ver == IP_VERSION(12, 1, 0) && (adev->rev_id & 0xf) == 0x1)
+		noretry_default = false;
 	if (!amdgpu_sriov_xnack_support(adev))
 		gmc->noretry = 1;
 	else
-- 
2.53.0

