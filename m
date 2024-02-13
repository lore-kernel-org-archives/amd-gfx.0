Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B9DC4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 18:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE63E10E193;
	Tue, 13 Feb 2024 18:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4nJUqDOa";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C445710E193
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 18:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fuoxug3jcxQcFWqiKIwiWVBDhsfY1s/F4+CQ/IQ50HOOpm5Tt5gbm583oHnjXGaRIe7l0uV6ZL7OSl+DFigQwNwB+sXak79JJkgAPhf6KbrEsHsubuHnUnks2rH4HCdqkTI7QRz8osR722Xqc39T/B89kVVjTk0phIOdx/xPy6rI9wkJ1xoc0CKqxLo8WRSKCHjIAvVCGPXVIbE7UaK0dgptD2gdEzxCo2FBPfvz9BLwg3IKpneIwh20QLFbzPdWE0NGzJwePGO7M6GWnnHDvyppVGqYMMoJiCQA3BIIXg7CTWifD4gqlUq/xPDlwvkW49swQ35DZV7o3COlLHhR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNofYC3n4QW/bXwexinoTwBm3UWRFyn1tjQE9EBXte8=;
 b=OTimfGQA+l2cNK/HfS1WI4by+ywtPjIwHLalWk6tOErmHgEZWd7D5XG4+5Dff2dLs+yvuRsKMnI4xgVwMMLBvcunWBX+eBxOAnHwqREUfe7SnoCwP9yfmd9Bc6MxwcC++VwZgvU6uyt2w1IZTs0VK9iBTGHjAf9G7hEcjecGNu7zx+WZGd48qeXIiAufAfNwqfmFiNviieWv8KMTNBwmpl6kWq5CXYEgm8ocB9heUBdI7NQ5SDh4yJfCJxWHq5igtfg34TS3R0aMB6MihAF7v+d50+RixkADTWN2Ma5pEFOrcwBFM8tpuwtC6kR9Xu0LKgr7uCMYxf8S5yRYntXGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNofYC3n4QW/bXwexinoTwBm3UWRFyn1tjQE9EBXte8=;
 b=4nJUqDOaRcwXhtVO0OOCeAloImOugEMCd+3Z54xZWJWNllQvuVy/jmOqAvj4F73uO5GnkxpvGmeYlQ1Mx8YFERSh1DNY65slk4Z6L7wQwzk2UW6VlbUqPs7vp31kzXFjA18nmC98L0vIoCU6BN4JOqVS+/ARtSLYgRSsbpulPIs=
Received: from MW4PR04CA0187.namprd04.prod.outlook.com (2603:10b6:303:86::12)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 18:48:16 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::c1) by MW4PR04CA0187.outlook.office365.com
 (2603:10b6:303:86::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 18:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 18:48:15 +0000
Received: from david-laptop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 12:48:14 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdgpu: Allow secure submission on SDMAv4.4.2 rings
Date: Tue, 13 Feb 2024 13:47:58 -0500
Message-ID: <20240213184758.1503483-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW3PR12MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 9887be49-d39a-4715-9260-08dc2cc456ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lTFvpHv28s+duMMJg6U6dmdbpVHLsS4vWP4O2oE1dmLl/Tgkm0C2lQqXutKhCKbbksnKDY4yOOWbdTyqZLmxOpxgL8eI6xbQlvmY3rubkKUQ6C1plPK1KK2BeTJpvy1v/7m3pLSy+13nlhoiMN9tFqs8LHMfA6h61a7AAmltWN/feG9w1UoteYmrUMB5SQqGjzuRPYvWXEvGIIAz7MfD8SFRz/iiQDC70sZ4c1XfJIpb+UzIPHdeNmsVKi9lHxaKDb+MzhVGm1nJ0NGaheybGW06Ww12fWIILcMSX90tHXqs1fwNVoU82+N8PNrCwQlZ33G1NeHxIFU0X4GMkPIKy+MhNWXzBIyHd9wAc3Qkpxb5Nlob09qBO75Pat2dISKYyKJYmJNUV3c9QL41LjLCHVxN1C5NnttVQkfhRT317lp/gKWM7Z3De+CIefKMVyS88dzRmEh0keNjBvNiI8OliYGJ6ObtGz2kQB7/ygUK9fwZa5jWHGgfCVsMSftZtETDrwf3ky6g14mx7rQHSURyDe5mk9rs32slWYGq7cLJ09NL0aVnzWxaft8CMsTrnKWxqABOtvX0BMZeuXoZwFw+DxdVJ6Utl1APdTxoZuvLWY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(2906002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(356005)(81166007)(86362001)(70206006)(36756003)(26005)(82740400003)(2616005)(16526019)(70586007)(7696005)(426003)(6666004)(336012)(316002)(6916009)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:48:15.9952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9887be49-d39a-4715-9260-08dc2cc456ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
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

This flag was accidentally left off of SDMAv4.4.2 when it was
added. SDMAv4.4.2, like all other SDMA engines, does support
secure submission.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..bd29b13bc3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1839,6 +1839,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
 	.get_wptr = sdma_v4_4_2_ring_get_wptr,
 	.set_wptr = sdma_v4_4_2_ring_set_wptr,
@@ -1870,6 +1871,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
 	.get_wptr = sdma_v4_4_2_page_ring_get_wptr,
 	.set_wptr = sdma_v4_4_2_page_ring_set_wptr,
-- 
2.25.1

