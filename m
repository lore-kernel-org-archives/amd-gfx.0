Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F11C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 16:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F69310F436;
	Fri, 14 Aug 2026 16:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cUUaK4D2";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8646B10E585
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 16:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVm+z9AcMnhUHWukBgaQaGRi6+TvyflRxTMcNKSk7A+qLxCqve0ma20w6KcTqMn3eVQjLgC7pglyG25ITvV+kUmp+abFTqK/TUIbDFbdzp2w5KtiPELDU8WPyvURB4DnVkjtiBg/TWMaLJ0cYp8QpEhKLxbDWZhWvG6SxgTdq1Gizj0IF7zF5XvlqwPSPVPd7O+VIbr1vXeqk2XGpaUN/0lhaUw48pPEJr4u26iPyKGcQGoUHw26s8tGhJGeFBUiCcpxkrsFWtnlUNI7cB5T9NFuPLBdGQC2nSrrVBWDqetgSzgqN3RUKrE6TznC00sKoSUSG3f4ZGd9YgVH+Ld20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGnevg34g+irX0tBDh5i8n5y8QQj2kt+N8CEpz8UZEw=;
 b=ybvbXqM7OXcJd56W0wg3etqp/KtIfDCWeJnY/ZwzBcx5efofMF4c2bEktjuf5cxL2svpYFsn5ga9e4MXGZUnLRmUwiW0SJ1WlFdFzwWv8DO/SCrEFzHf+pROK6bY+hJXMtxCpNyzSWy7UTXd9Sk0g+MLOr6EeJcaF9D/d8JGQP2YKaTYTEPF21ShXopwYrkbNW32ftFiqE2XJGSCmrHwciLsvX3Mme5KGdPhKlJxilGp9d2lpeTBgL21KD41PKnqp7Y5MJfg3hn5VemuTeS8JPrLQWz4lZjdekpmOqOoSHH5S43wSj4CPCFadOjgxJjtSdkrROysUngBYbDUVy9B/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGnevg34g+irX0tBDh5i8n5y8QQj2kt+N8CEpz8UZEw=;
 b=cUUaK4D2kw/jXI2866C56m7EfRLC6kbDnUkjD/DuszAe2xuv3qVgbzyCJbtMii78EoT2zIOeCfmARySN8ZSsdE2suxnykEbeQC8NYDJWVGGh51GhUI1zX+vLsgBI99RWLIx29j8kqH88LVknJD/kSwBzJi8Px63KuASrrrELPHM=
Received: from SJ0PR13CA0171.namprd13.prod.outlook.com (2603:10b6:a03:2c7::26)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 16:19:03 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::30) by SJ0PR13CA0171.outlook.office365.com
 (2603:10b6:a03:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 16:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 16:19:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 11:19:01 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 11:18:58 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Sunil.Khatri@amd.com>, <Felix.Kuehling@amd.com>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unmap
Date: Fri, 14 Aug 2026 21:48:40 +0530
Message-ID: <20260814161841.5906-3-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814161841.5906-1-Priya.Hosur@amd.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa2dd85-0030-4330-7875-08defa1fc159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: cFHqmok/bVphQy9ztJvmOguqF7NM0I8Y091W3rjUoHCWQ4eGAem1LKTfabxf6FH6WqFo5fFPmsnYIef777Elat494T+zSAMC2GF4xwGnVCrSlxllNF4eNffHXLas1WTozN6Bp3hkNVbhh4x+CiXosq1V1KTp8D06lPuAqI0GIr59X4lw2N4RA/G1Qsacj6j0z2JwoScsYLCIEx+Mt2FMLI7ZgF5enN85qTeB2XJG6XAIHIq9CHTB0IqqxyzhVgbyHjDTrZ97qCNkhsKt3zFoAe/fzS6oeVvRqjd+f+kESnOVrXItmMp7wVDMBwR/64aIBThVrVqhP64mX3CoZKfFAlnvJdSsW3mHDAr0tkpVo7NN2rYqBh9ySiH/pOSI6NEByn0sZF+xGwAsUBIgKJNlo+5MMKEe6DVaICGZ2ZYtTv5OiHrUn8h/Ieg3KlvpE261VJVJ36pnMhUSZKHNM1rVN2nLIwhGN069CZILRFb1PpBwe1ae4J0HacfAeUQ0I8KdF1vNL+Hefn5tbEQgtl5RSxSPV7An8rckT3KAccteAEs7QNrqr+4F7weDvVjPlD8MzGwkyGIn9o7RPhRKjE+M1o7EuqBWvKhNSrM1/rbwqoDE8skjP/QbqSUu252eUX1+5Z1HUzqyqOjKA+v1XnZptys+7ReQrZwjNeBVJ4bhOcyDFw7EPIz80tYgJf6/8cIFUq5S2Y7+haXJeiWqIShUBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: njNFe3W64IuEL00E/UXL/FtRMcpwMZhPQdKW5lwIS1dFwv1YKMQutsqMYyCPybamSaUzlIX1mbGuBRYF6Ha+IexYOpcd6b7OiklDRfQRw/qo+Iu8nl3EikL69hAfM1IHrppsa2BAJhn4w0VXjLTP29Z1riiWOrasZJAbjFavC4QSoorPhlt6OUm5+BkpKTbBtR+TYQJ88xgdKYfJagQKkYg83xf4fIvmSVXFlJ9enGKeO1Z3cJvJTK7eRbIxZ9loTglfiOcPkDLqZU554JTTWYOBhcPXkCrbaJcW+d96CVi1ap2AtizcOCOdAvL/wF5RVXixEZf3u01GqB3bt2yzbrKGVnzgzpgA4eth82MxkmvSUvBIwj8myujyoyVxwmIs7XAymDao/39GEUv1lTggPqfaa/IqtcMlsqEuqs3FcLGohjtTUiPhYgxzfmqeBurJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:19:02.7243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa2dd85-0030-4330-7875-08defa1fc159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
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

Similar to the KFD fix, MES does not perform heavy-weight TLB
invalidation after unmapping user queues. Add
amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
complete before memory is freed or migrated.

Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..9fcf15d69b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		} else {
 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+			/*
+			 * Heavy-weight TLB flush after MES unmaps queue to ensure
+			 * in-flight memory accesses complete before memory is freed/migrated.
+			 * MES does not do this automatically unlike HWS.
+			 */
+			amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->pasid, 2, true, 0);
 		}
 	}
 
-- 
2.43.0

