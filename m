Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD90C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC08310E39F;
	Thu,  8 May 2025 13:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXlWz+Vp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7115510E39F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 13:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjtKL3+NyXScQptlx6TWBk7Aw/96rRBq/+xFf5Qp5CgH/zQXPrWkKIFEKKCmUzZFDp+7JV1/Uh+J2y22jfcnfvhwamw8ruWTNBijOOCv5ZNfUPXL6axSHbTWqa/zEwJSc1tTVffHMuW91EIZ3ItaecxaHkBRVD2Gb3G0hUutCxhkSILHkpYL3KKx9H9udvBtwXUiMcwD/Y6fU5Bbv8Tlp+1ClVPZKyhGQnN1hio88i3f9YLaWJwMFp/dy5YGWYdnP2lKJ5AmK+yNCOoySOUWQOTPC315s6OnNidhT9Cc9sO+PLn2H/8zRfeHoxYhZ4zKa1NEEoQ21yQ29iJtNzW8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTdrc1RgwlRa3Xy0aU+kqFPxJTYR0WAd21ukSH2IbWM=;
 b=Xh1H0Y0+TMGMxeIuxZ/WTwBYhL0+QwXaxvLLbnkTqlREtRZvrvNXbaa7sJjqBcSyyJzZuecG9YX+4crAIAAOWAJabSnmzx8eN4+SmNSu2telun005IIBY+risnJhuogNfwT1r/MBW1u//hkvEdYkFMn+6r7bgW3JtEqlLCjegktluxqhcCPDExgxgzxFrr/bgPMQzBqnr8BQtpxGc0vZNlv9h0mukCalZSAoGp7ImO7Bd0q6KTTZWgh+pWh2ECwaw5HOwG/767FTbJ9mbBRzyC34i/leesJ8P0tyf5N69LE1EL7aEfirLGJchPFFYpydyBIzO0Dyut7XGYc7aD7UFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTdrc1RgwlRa3Xy0aU+kqFPxJTYR0WAd21ukSH2IbWM=;
 b=pXlWz+Vpn7VZIqdA8+hq/1ZZB4rCC/dB3MOGfPAqPU+Xb9fnroYa+6Zx632L15IwQ0PDCfKtYb/nFH+nWVG5UDMAj9d0nA4t0HfrSHqO3mKKJaIPDB3hP8XVPoSd4vz8BzeuF9z3ICz09wol6DYG1j2z6VfzqJ9D6cef2cMVM2M=
Received: from DS7PR05CA0093.namprd05.prod.outlook.com (2603:10b6:8:56::17) by
 DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.21; Thu, 8 May 2025 13:44:41 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::43) by DS7PR05CA0093.outlook.office365.com
 (2603:10b6:8:56::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 13:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 13:44:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 08:44:38 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: lock the eviction fence before signaling it
Date: Thu, 8 May 2025 21:44:28 +0800
Message-ID: <20250508134428.383605-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d84ba7-531e-42e8-4dc3-08dd8e367b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BrIbwkORZ52h6DFU0gC6Pszvtg76Hhq4lPH/rH4kXUe/6r7zDp2kPWXHtoXI?=
 =?us-ascii?Q?SpPosycJFnErnduyn9g2q6AxRxtG3Z10x+khvUc9scTKOzEm8sYpXeTr3SrM?=
 =?us-ascii?Q?VNIblnJ9+HQsTp1dasyswcBSgIS59+M102hvDT1CrMjbkwToocSVsl1aHo/9?=
 =?us-ascii?Q?DzYmh/EtAWI4rySaEaJrUYlekEiDkNcFTQ9DbrKmwMSyALAkh4dNK+/omtf9?=
 =?us-ascii?Q?7CG5HOd5ohOk5tgIDzIX5rPgEcodSE+Tkn5Jvi/JxbgWtQY7gFH6QIy60OiI?=
 =?us-ascii?Q?UotbLiJTOWMEQ3Mo3Jb3Sr5K+8AIEdKl3n+YEasZ2iRCsgUf8apzfkIPM8qk?=
 =?us-ascii?Q?0mWSfbOweA1Q90f3SnSHsg7u81fVH62GKunS9cGBzhpiM79z6Q2UnqRXH2mG?=
 =?us-ascii?Q?7qw8gygvAN+QLBF/o9plfPWQt+DvNtNuLjeVfbdguneit1bJ+T9dy6m/FmAT?=
 =?us-ascii?Q?XMVqDco/o+ZoDv2P1uykl12mT0wntYanR5NbxGMOnrCz3x440yk4EAKvwXRZ?=
 =?us-ascii?Q?VQorXk9dMJ7WkZhVBygEV1TTx8fSvspD3G/IRbW1j9Nup8So/k1Yi8pqsmsQ?=
 =?us-ascii?Q?CIzAneIEEsWWKEgFjx+le1zLjAsM12qnhVu0BGjSiq7Lk26r25rokoJTS/7w?=
 =?us-ascii?Q?UEWYxIHdTiNKObe28HoysNvci3tuk1VVVtqVYkgQ+MKdudY8WEENTSjPjjVO?=
 =?us-ascii?Q?iq0Hq+48IbSCE+mTJV/sNg42qxrvopZb+UiBh5y9WOCQiFhFcbI50xNRoYK1?=
 =?us-ascii?Q?enxdNxNHn2a+MATgm3jacPmsWBdXTsZ/2Yk7bm5VgTmSxfCLXYRIoNHmlX7e?=
 =?us-ascii?Q?OllJLQY4QPCOyhZ/uLrZfG6CZcSQO6J5gvy2eSTUAUezUKlhKrC5tARvltWR?=
 =?us-ascii?Q?girSIjuKcQfmgDtuxJYhUAdHRiZk9AJNAm7YQHzODP3KlSQNfPB2vk2xrdjG?=
 =?us-ascii?Q?zafQINdNf5e3LkhHAZljXwugYr7y6EawFkpfqoRFRfu7kmrV3YXrNmcscKHj?=
 =?us-ascii?Q?+g00sNBgqSdQwWXNZRxaezckf272oWSifVytZx+6JfLLa/EvMQJIR1OB++VF?=
 =?us-ascii?Q?9RD+wLcx/z8VwZXRtr788nx0l0FXCBz9s1sa/kXp1V0/tJDZ3UXaALyTxcsa?=
 =?us-ascii?Q?WP5eMNMkuuPLSJxefnemD+Srk1L5qUe+AneOVNiWh7HT68DQ9BX1rJKxHHj2?=
 =?us-ascii?Q?j7rLAksmgL5VEPSICwB05rRumCVbBGv6mEhIxg8zVLtih8XhaSzHxu/hJ/hH?=
 =?us-ascii?Q?DCHmmTuS6F0XBf5wBizqels7Hetwa45xR+gXhu5LWr2jIIHa2T2ZzU0D/Fyd?=
 =?us-ascii?Q?Wntbby18V5FCdrLMqXtrZmjTNaeUzox8nu4QqNb2bpgsLV+mHKRTm7jjTGu0?=
 =?us-ascii?Q?i457CYdm5GHOj+uSlIooOiPEAmGbuvbPP3CKNNR6N6DCtZS8aElvlAuVdUVX?=
 =?us-ascii?Q?qz4v0S2GKY/Zo/BtkUbIo5Cpg+5Y+Y2qVG4lr2j5RUtd52eNbrMVIJ8qlFhC?=
 =?us-ascii?Q?vL231HhknwZvvalSI8mn07SlGh8IehjuiEMM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:44:40.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d84ba7-531e-42e8-4dc3-08dd8e367b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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

Lock and refer to the eviction fence before trying to signal it.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 1a7469543db5..dd272c1fcbb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -108,13 +108,16 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_eviction_fence *ev_fence;
 
 	mutex_lock(&uq_mgr->userq_mutex);
-	ev_fence = evf_mgr->ev_fence;
+	spin_lock(&evf_mgr->ev_fence_lock);
+	ev_fence = (struct amdgpu_eviction_fence *)dma_fence_get(&evf_mgr->ev_fence->base);
+	spin_unlock(&evf_mgr->ev_fence_lock);
 	if (!ev_fence)
 		goto unlock;
 
 	amdgpu_userq_evict(uq_mgr, ev_fence);
 
 unlock:
+	dma_fence_put(&evf_mgr->ev_fence->base);
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
-- 
2.34.1

