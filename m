Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5469BC36001
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 19:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE60C10E319;
	Wed, 19 Mar 2025 19:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lZKCJUXQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED2810E1CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 19:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj+GLpAL57X/hZ6FFNp1mBv9ajvbMTyeWP8V1iQI6AGw2iXqWWuVf3askguZErouB12DHYWoemwTZg9uRVv2hilpu4ljXOjby6igOgn70+tYENTsUf+Tnyt1MwXGOIGMTxSgm1pxIQAkdSUD4IbZpPQ5cY3ojIv2hEKvQ6G6WNQVjtbY2N41pFc21kFSVhGNm++dNmn2JT+/DJ6C0pbZ0eMel1Ig4t4h7mCHZziTPRwIgZduqbdm7GUWu8vpm0hJk8EqHCtLNbDFCL4kxQ8eUO+EiEetYxZuwdpgiyjmSeD9R0toQA/jOWo7m29VOYVScqUe9n0RzounrgwjLi2Bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+SmeJbtwcj04JZBNTxwVS4GO1StxPIup8JB0M8WjsA=;
 b=Pa2YvaGQz/LQUu+uYF7b2ujKdHZYVk69kKJL7XKkEMx1Eq6G4tvpKYOw667YRT81SVzh+7uBNatCiNxFc8H8nEZc7yQ0VjdySP3uLtMwbke65M+3XICivfU8MF1MmRHiibqzTFb74Vb1rPdrME0uJ8THB3pdBwrmRgtlqmcUmzIsksMn/wSls2ny7DXVojPhy4yJXExG8ppZkm17fCob9dOh8/1iUy0wOfG8T5k5NuAMTbs9tJvevsAMZTUTk/9CU4oXYPiO5JqjL6PLaAnU8F4Bntqo9LiZS1imjEY1+DFLZmml7p0M32ArOyhYCUWZQAxkZJcTWFH53S7V6/BjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+SmeJbtwcj04JZBNTxwVS4GO1StxPIup8JB0M8WjsA=;
 b=lZKCJUXQJFIfmgUo695dtJe1A9m36Bj119G+vvb1+VSqC3glVjoRFFUSur3XBbmBBI1Za0kDWlghBJV7tPI4AC1fT3PqtUMs7q0TV/wTmc1Mv9Q2D2gy2z6i6hYAeujmEwQdETCOEdfwi2qkrmOYy+CZqvz7q9Q1mSRT7vaLYlc=
Received: from BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:09:05 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::9d) by BL1PR13CA0382.outlook.office365.com
 (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.30 via Frontend Transport; Wed,
 19 Mar 2025 19:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 19:09:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:09:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shaoyun.liu <Shaoyun.liu@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
Date: Wed, 19 Mar 2025 15:08:47 -0400
Message-ID: <20250319190850.3899718-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: ea47a5e0-3521-4b5a-b7af-08dd67198381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3HrJlDaAxPeiV3yLeECUTGRpzLt0uIQVrJxPe3jxgUsuSNVZXAhHeYG7kZyG?=
 =?us-ascii?Q?TtnRZnQfvFZViFZHpfKBOj7c+GeCIZydpWmWhuIrEpfEB5BtKpEDPcMq8c6P?=
 =?us-ascii?Q?enqh+S+SAI6E6riivEMjgBnJEkDTsK8Upd72fcbdnCs358yBzqQAl2/7sT6T?=
 =?us-ascii?Q?gxICYALDd9xZzcpjB8bJCoC23NHYO8ZwU79qvybPZPQMB4ee/dydp3a/4vQV?=
 =?us-ascii?Q?NR9STgfOy/M0xT4Kcy+PKFr05bcj5/l8KUpJRQwikuGxEcDsjUfRd5aCO7tD?=
 =?us-ascii?Q?h6oW1J8VQG2hubB8li055wkCeoCyMHYBbaSlbqxvQsjtf7fP6TlrI07sYxWX?=
 =?us-ascii?Q?3cNlb7c1/K3KwFk+TcNQ3l5Eaw5R9ZNsJjI1H0dYpw2zST52uWk6O5yqPl/8?=
 =?us-ascii?Q?+zeNP64Ut/SC/4A+0PGuebzF+bk1anU/YRPkgPFNPguPVbPZbn0FfqE94Lnq?=
 =?us-ascii?Q?SgI13sgPANitlIeZa1VEacPuGnyTGltmHR51/JG3SQi1/GG5VTy7Dc01u9D5?=
 =?us-ascii?Q?czVnBeRrfjjjFL6UUCUsSLb27Vdvs/rASE9cvCYxKMfDU3jGwB4N3ovd8hfn?=
 =?us-ascii?Q?UBnWq62W7GI7988VgpC+yN8uNR20C3Td6IXeCf04AmerflTwwCB9ymFefnT9?=
 =?us-ascii?Q?5Kce6GHiySgg0tL7RVHL7J5Kp/KwfH9RIJH7yWbHHDeD1bYDGWH7lBUelUOp?=
 =?us-ascii?Q?MnC2p9yB3nxqDAuuSU0MiQZv/5OJnUqP4uBBVgdyAmZqw/5RjWf/DG+tq6bo?=
 =?us-ascii?Q?XR3ht2lDnRvOWAu5uJVcP+tVADXFyeBy25qjSIcZFPiSdA7KLr9hFSqZk2K2?=
 =?us-ascii?Q?M9+wba9REJKBvNDKo/n9w7QLfFNQQZHAOvDNITET1wEycfgjmczhZUiShdLt?=
 =?us-ascii?Q?o4N0oaEpFvnYYtXTtdJgQJTPaxxdnrEgV1uovhWr5HKcFqlSMCvrZ7S20GFq?=
 =?us-ascii?Q?F995FHYm+zcvCF2tuTGq21Nd7zOzfY23i4gkdTqKHtrSWbEbgzuF5gip/WLO?=
 =?us-ascii?Q?jOHGVRNo9jX9WrvYyFbD6zKXdgdg3nAKXBIOsW7NkfOO2Ic+MwernxZiBXLt?=
 =?us-ascii?Q?0eABN4EwpTRgRnNKwzE8LNDckFLUYnrCj1ENmHK6gbNjGB9aP9ku1jBQ7HM6?=
 =?us-ascii?Q?Zdd1gJz+tWiMwzvz5opwYJVXn/cYgQcRkqibewhOROWXekfKdJxoMKR6atLv?=
 =?us-ascii?Q?/VRCvjM1pcy9CnhU1OqUdE5uRA2s7kp7dfURPi74rIuGERyxJmsRrLgTZuUL?=
 =?us-ascii?Q?u6WojwJY2AGKB9zUadbfqhWTa8dWwjXXl0tQE7cNtMnIQalcyCvHnQ0C/ZzY?=
 =?us-ascii?Q?KZnWuWMgFMSdsUq1LLjn5HdfGivSuzsEGIwpdzEq7Y1b3Q0PGFRnpMtufJUP?=
 =?us-ascii?Q?HgoMLkxXNM9X0e92H/niUgI0eQO39WQvhipHG1A7K5185Kb3Nhh2t5RCbzIW?=
 =?us-ascii?Q?AkJjOiCB/I/HWWorcO8vMcdtOGi7HYdpG/MpDcIxcD3rSfko+dahPzMAQIb8?=
 =?us-ascii?Q?Qo5MmBX/azS7cNc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:09:03.4169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea47a5e0-3521-4b5a-b7af-08dd67198381
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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

Break when we get to the end of the supported pipes
rather than continuing the loop.

Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 3b83880f9e2cc..10f14bf925778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -132,7 +132,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
-			continue;
+			break;
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
 
-- 
2.48.1

