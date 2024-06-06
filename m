Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D641AC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 19:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5679710EA74;
	Thu,  6 Jun 2024 19:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WD6DfMX6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E8710EA74
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 19:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgDLkyRf1lsh6DurJ/avcF7DBQrKzeVDaHxEIPsh7QXeeNZFI0dDHa5VqUNPYtdZpCkKqLNazSwLSQsxkRyjWTbf2x452Hk76iqgfa867QSHcXCYWPpRysF8Dl6Afsck4/65MvMtmoIld6mgwEyMXcXvF8/UFJaWS5gMQ1BFH7Opv6EuX2p3i19SnMJeRIoD3/MbHlLHWMCQovs5NDucpUMv72nZARm98UQqlqDAyRW+ggdRqSnTSRcUK6FUIR0s/pZktLpBvWA3O3OYQlwnqYDLP1KRIVYjeGs8NMNbKuhqT7T8zwZMmDY14jpLnkeouyxK5q9tm5Exvjo7XLLqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3XB/lxV7ixr38a2sL4qE6BBo3dT9O3lMChXkPVtzcs=;
 b=WIcIxAgQ7BI/KxKSFeS9WAnqfKBTz1HcwzP/yEmJKxReLSJQ0KwBfktuMJw9O0OiGojAQjxMcBvhU9LxMNxdURPmElJu5LcLFvdM/uVpJL8Iek+uK9PY1Gj/5gr07f4oXWDg0EldW2VVc/78QkkewtjOo1FA3syNFx9818OZ62d2nP+kU4d+RaMdaADqGTPeNXmN0h6Wcse7qDePzQixFd+N7WghKwA56KWuA8/1RmOO8CoXPwb8xEUOfqnGCXA9bXxlMxHUxOW4+dxPp1ap3RxxtgOM/54Uc8EwGnVbd8ewihh/7sLyW0fNpYSaFcBv8qx7PhssaPjGfZW0hasBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3XB/lxV7ixr38a2sL4qE6BBo3dT9O3lMChXkPVtzcs=;
 b=WD6DfMX6cqyQmgZOJA3mzR/SDbP5qkGxoDE0U9KUI4GJxZDOKGBDu63h7Hv7D9ENCGMZ2wMddHn2M92YNhVT7C9flqHn5EnkFWlNBLrdiEoZ6LRyoHZO9UUmv54jiHnZm+DaQB8myNRn+kQdlS3tFJvtDV3cdPzTMl4NBUVF3Wc=
Received: from MN2PR20CA0060.namprd20.prod.outlook.com (2603:10b6:208:235::29)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 19:23:18 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::59) by MN2PR20CA0060.outlook.office365.com
 (2603:10b6:208:235::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 19:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 19:23:18 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 14:23:17 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <christian.koenig@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Philip Yang
 <philip.yang@amd.com>
Subject: [PATCH] drm/ttm: Add cgroup memory accounting for GTT memory
Date: Thu, 6 Jun 2024 15:22:33 -0400
Message-ID: <20240606192233.2836986-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 1317a97d-628c-4d5e-6960-08dc865e1ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dp17IIqQalSnD4HB+3bPEQvTYEYlhnd3u5766w03HnjpDrqLzA+eD5Z0gwOc?=
 =?us-ascii?Q?6PB7hLmdP1F3SVfqaTVT+/wxvU58ttTL7dJmS0B0cE01Osz6IXgldq1wSyAU?=
 =?us-ascii?Q?4HywHG7q2z3pIcnilFDg+Hl54j5MLMrsS0nhT39k9+fTbMYbUXK+EP75qnyH?=
 =?us-ascii?Q?sADTSATaJ75/EVc8b7POo/d2vMq0wZPPhcm18mTVTpe7ICiRcu+336iBof4I?=
 =?us-ascii?Q?NWryDqrqKPly05h6jtbKBdKNMtJ50zJvxjEDFMjIFggOHMARjtDUfsseKgq1?=
 =?us-ascii?Q?gsHBzXB2yWMUvDViuCm8Oh4EcRHYJ1DkII71s7HYD0tZDD3SYLQDURg0/gOb?=
 =?us-ascii?Q?Pmwo08sTy4hlTgS9AZpMmOuBTgGtQqkn26jX02i+7VMTIaN7jnhwb1/ImSHy?=
 =?us-ascii?Q?CsW4KPSpD6ktZ0937Vz9kK8j1EbYBS8izbSNksduDjoq41Ffy1aH18t0rug/?=
 =?us-ascii?Q?8FzkcQ0wL1IYJ1IucUVgt8JRL5iGqke6NR0jVLH/omwLzBfYbg9WZHQVOQzZ?=
 =?us-ascii?Q?+Nl742WgtHBoOx22ka5mAJEjiJvMmvkXOKrcvwJs34ugffA5kD3YKpVrjhDQ?=
 =?us-ascii?Q?L+dkFZm/T0UD3wSsHNGDXlI4lZr38IxuFbzWfD2qjMX/Kx7lXbKss6T1IuEQ?=
 =?us-ascii?Q?xmkk1Efr4Yqb4tgS9LIHhkusRqLHXEXVxpbXnfLbynxTERJR20Dl6FXMYqIz?=
 =?us-ascii?Q?KLJyredMDPT+oyZEii8quf05zkJ3DlT7rX1kxkBnPIFjbc7xC/62wwPqBkuh?=
 =?us-ascii?Q?DAfJKjpEmtmx0bgOys7TB7wHhimy9eq/7csRfhHB1yMvnugkKEXfQ66E4Ktg?=
 =?us-ascii?Q?cuNi6IdftybS9xOdBTPVJuyMCRuZE3AUKhdQHZjK0PovKOa7icyU8TVf9jNA?=
 =?us-ascii?Q?3IzeHiVJpHl+0lwCmVKHxns8F9j+C4hAQUe/iBJ3toGmiK5Yt8TFigETseZd?=
 =?us-ascii?Q?jS0mzPDe1rHm9Q7vukkDHhftn0r5ZDc70fSEsJcW7EmIJGrKjCYSBv1XzDSR?=
 =?us-ascii?Q?20eWcp5LFcgT3IPN1lwB6iHHwF2fVd5rAbrmOnIy4QhKVcdd3ILDRFfpPED+?=
 =?us-ascii?Q?2LsdkJ5Or9s2wwkmpdQ5PodPmhBgZBIRbt5zZV5vR9xGVDRi3ptqxOHAFcYO?=
 =?us-ascii?Q?Q0bijqu3HrZVZ4Q4TabRMWNNp5KhA/5tJ97GtHNVetA27aYAlWygazA+53Jr?=
 =?us-ascii?Q?9Ib9yxfu1b/2yknmiXXl/6eJSDj+zDlBjrKgKLyBBm20NsHjYzSA9lq6XZEO?=
 =?us-ascii?Q?iXDIeWbkJBR5o6lEkip4+qnhRIJdJ2hU7y1wLL70iIM4bYsSQ58Ey5BKJZNy?=
 =?us-ascii?Q?Cir7q3ruaa0Zr6zGRCZBV/Prx2jNjgeH2ZjvtV+Dr494svPi34Cb4h1N50Wj?=
 =?us-ascii?Q?INKnrdlBs7ojRg0OKIFBgrew4IW2I8MKzSDtlB7DWOPPfMWoJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 19:23:18.0091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1317a97d-628c-4d5e-6960-08dc865e1ec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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

Make sure we do not overflow the memory limits set for a cgroup when doing
GTT memory allocations.

Suggested-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 6e1fd6985ffc..59e1accdef08 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -91,7 +91,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	 */
 	if (order)
 		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
-			__GFP_KSWAPD_RECLAIM;
+			__GFP_KSWAPD_RECLAIM | __GFP_ACCOUNT;
 
 	if (!pool->use_dma_alloc) {
 		p = alloc_pages_node(pool->nid, gfp_flags, order);
-- 
2.35.1

