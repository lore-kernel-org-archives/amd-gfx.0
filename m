Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5393DCD5BAA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 08:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB1410E0B4;
	Thu, 21 May 2026 08:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vVhNpi3V";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED45A10E0B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 08:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi4ebGeV9WsquBEvy4eB9YRcl1TSHn0p56KvOgdN8UWnUk4a3Nt/bDjZHvX7oYamc1NGWXrbylBzLh0Ry+mtnk4Q1O4n482BELkP/9qPYSsMTo8tE2uIsMKUOtkCccR1QJt3dzek8g08nPay2eTfBTMyKMim/exhA+57sDtT3kF7kJ6iCo0phaH6HMOM2RojWNXWi65l319An3EesSl9tvEx8g/OhXujcdTZep5rvM5oSkgDPiXiNDFf4/k60Qya4tw9YtJbnnTUYpKtfMR069dmhI1UIOdqjaFBnMGwINkJU+j6TzM9AZbpSid/lMsJjFa3Su+eFY/7o2f6Be2Z/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL/araRvQrC270N7oU+2UFklwXz9c1Cq7s7Mn+rgf6A=;
 b=hK+37AbQLX33/NVzrrR8GDMj9lkKJs8qbTECjD2n1KPa+SnnRjU0laXHfjfnVKtP5GHaZQcNehtouh5oQKe0lOsR/hHrnx4sNgYzimyFQaRzPBK1+mRW3eOqSV59oOng0zL2LoBSXgpfdLmcjLisUT8R2vKHY4ZF9vMxed2BBMFyN+awHSo16uKF2EHysD9clLvs6F/g3BU5TnYirrIyl/BeO9Y22cBWtWw/C19CRptUCQD9Hx7q2cdDbPhGbgLnDlPFP7ACTOasCwoae9IT8ziGUhpdWhfYDBcfWud5dUA/hFIzrND+yGH80hbn3aQqLJXVi3AkytaaAmpvf8zIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL/araRvQrC270N7oU+2UFklwXz9c1Cq7s7Mn+rgf6A=;
 b=vVhNpi3VLxz/uVP/VYlb4NUJnLys3ihyIZCobi8Fz+3koMxJY5mgN4l098BSDX9Yj2VGR1uY1xc6JbhtS8lM6Fd33iS+jU0+srF0ulTvTtc6pJplwNTj6G8qyp03XX4xUUEqQRRzsmoWIFGLf6TSqkO3H5w86Yh0VTzfRaR5g80=
Received: from BY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:180::21)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::999) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 21 May
 2026 08:46:38 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::8c) by BY5PR13CA0008.outlook.office365.com
 (2603:10b6:a03:180::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Thu, 21
 May 2026 08:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 08:46:37 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 21 May 2026 03:46:35 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <jmuthyal@amd.com>
Subject: [PATCH] drm/amdgpu/vcn_v4_0_5.c: enable secure submission on unified
 ring
Date: Thu, 21 May 2026 14:16:26 +0530
Message-ID: <20260521084626.525113-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 0229cb4d-ad1e-4fde-703d-08deb715785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: F8CnPFQz0Gbx3LD+3pLyYmTdKd1qgK8zDWBf0Tj4p7qo+phHVAMzYXQioyJcPhaiH4aV9vXQjCqEWf3A+ElAI6fPrNQ+rJElFqBidIeMGd1fqaNAhnIr87aCh7LckzxZdWAxDlu8hl/ndRRfirxz/pgfoPBMjCNuvGzXNo9OvkfRvkCWiu0Sdw8Hpwl0aQiXnbug1ufAmdWZGYVn8z0LdD8jth/vhQ4etD9+hezM3X7Pc895qcIx2MBFqqBKSw38fQRRCq+VMZnyjQSDCLkYDSPLys6U+mHRAGDO8pWV9+vp3Yq/9oAvuhWE+7eVhUQkTKHs45Mig1gWSjhouD76UYyswG6iCCOOcBXa3k8Lq4KBt4yMtT730Qmt2OO11XdtsERK6+FxZ0spxzMEJLQ0WgctfxBlOXakZQ9u5nv3pdtV80KbrDtDgfNSLKgjDtXJYfkvINAxNt7mHOrN0xbfNxKjA7rkUHfcrbmCv10wbj70DgyANyubNIo71kNdItPGHnJsH50vvd6v1UH+iZ/xlBI8hK3yK2CFjG+79mS3GcsWJCu+G6+HIFKyURiwXI+AKvwizBWIZlNaSlypHIza+YKhAY/65XEea/YGh0gwo4RWo+s4RNB6IJJJQgVFwwsb5Pve7WrFa3qQKWhD2iNXH96quzxXO+ctYG8yhmn1LkiYVcxWCWiyVjTOjEvcQu399ZlUxEmsiuYI2Y4/cf71kuG6EepMmxRsx6dxQpAE4g0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SYduA+mhw7e7Uxi4G5aVRxvVv6wDpB0PKFIG9XyuEVNvHNXM5mWkj7ODnrdf1g4NCuApVmaAejMJyubSkQJDFcd3swhcegwet6kuZfGtuWAK6X9PMvIc9ehI7x7re0n87qq0GTlGkKgQ6Rvmk0CKUGWc3JfrJyiZtXKhuWcoTXVWziM+Rwc+CpOcjBVVm0EhY549RI+LfIeOMm4tejNM0DwEjLvKa3B2QgyyMeMijwY5hWdFnt/V6OOFMfRjRotywVGJuG6mdiXX+OM1AQ7WdijGiLtzeCXL7igrhfeE3BvZqLv20Jp5ZhVCrkxOG4nX4jp3i45GYFjot+0nvfdkODdMepf8z07d/UV0Vd5SYhdAntX43Nj0vJS4DKJ1P9fzOSmKvd/GUiFuJZR0ApCiZzkAQ3UsEryx8SxAV6XWyEtj17r552caMAeDkEKEqRiJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:46:37.3671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0229cb4d-ad1e-4fde-703d-08deb715785d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39
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

Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1571cc5a148c..c8879a6e5297 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1479,10 +1479,11 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
+static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.secure_submission_supported = true,
 	.no_user_fence = true,
 	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
@@ -1525,9 +1526,6 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 5))
-			vcn_v4_0_5_unified_ring_vm_funcs.secure_submission_supported = true;
-
 		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
 	}
-- 
2.43.0

