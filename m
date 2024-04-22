Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5433FC07E8E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD09112B16;
	Mon, 22 Apr 2024 13:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HIXyV9Mr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EFB7112B14
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRnXM9VN3OXOBzFox6HIArh2CQkLWcV49lJq+O/rxT/CxE8iiQqtibk5HncBysNtCD5Kr2t3vvhXLHe2j6ctIa2QBMnhq3zRIpEMVIHrXxNGhuoHoUsJckUXF81HfIGML39Hj27tZinwr1UxkWqImaip12/Oh4hfNfeHa/VxyiktbKk5DND9HYitEx5gm30pjOLFX/6WQraUCPFk53uiijPxfQCAo4HTJwbJDsNR4A0D6Pnj2RQOJRfzzvwNLJX7I7GNbzr9iyvokI7M6gVAn/WrUYR8nfA7Pa6bG+FcmqHfCFBvbafCtwyd0fxETL45lUL/edJ0+dTS4opoK4LFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihOHjrIX6J7gtqiEtbuyb+wURe+2oQhDrzT/T9fjFkg=;
 b=diIPUnhffwdC38xhHRG+5F6M3EqeEh7KakHPA+OCkNtHDufr/+G1SSk2QTmh23XvXDw3CcFSxedGqfTFCoRr+hlE4G6OQ1hIWh27fWEbDZZGwmyv4apafDndxrILqo+KrWTxRyn+UW6MgqiB3BEj7SjIDPbVbvL3437PsYyTe5o1jE7RAJeeIx/pdF4aX4IAFgTO7feBNxp2X6KehoWoNwECJa5d49XPtIbnQvErp6+RkFMDxVITmH6DpQwH9xLQYCBmbFPE1ELZNJHId3L3Y58fYMJGd7/Bw/TjvLFX0dtO+itp5bHsApWNGhumYfMELm7muK578Uv/DjHe0mdsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihOHjrIX6J7gtqiEtbuyb+wURe+2oQhDrzT/T9fjFkg=;
 b=HIXyV9Mr/pSgATONnK45XE3ImbvL1kdHC7B0rUkl+FtIx9Y86qkDt/xd818eDtXGPRnq0AI3PVFBKi/7jumonx3VGM+xWGPxy3LLJQaATZT364StqqdcrT2ycaoALZHjRw4ipGYO+2NosC6idnOvzWZQXXnRzktlzBS3hTHXZbI=
Received: from DM6PR05CA0060.namprd05.prod.outlook.com (2603:10b6:5:335::29)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:57:58 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::2c) by DM6PR05CA0060.outlook.office365.com
 (2603:10b6:5:335::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:57 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:54 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 5/7] drm/amdkfd: Increase KFD bo restore wait time
Date: Mon, 22 Apr 2024 09:57:23 -0400
Message-ID: <20240422135725.11898-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135725.11898-1-Philip.Yang@amd.com>
References: <20240422135725.11898-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 53414291-0101-42e7-55a7-08dc62d43708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SbgQClwY+6xsifaGydhTNqqtJvKu1j7TnMuH5DTEHZtByXXgFpAqiEvy/45E?=
 =?us-ascii?Q?pAFT0rd5uKt8dR3qdtx4seiG7uAHUKZu2x8S0b0vQGSmUFMKHska6V9M5uTg?=
 =?us-ascii?Q?L4ZS8CcKscZ6gYGz6WWZNk1KM2WUrPhji6u7i7YYlUbOQoHW9UMfeBKZ6rIk?=
 =?us-ascii?Q?UJG4Mlt5p2j2XEDOm8GpoLFbPGg9kcp0YHjykpztKFp509xbYmlXoifeqyps?=
 =?us-ascii?Q?XJAeXObiuvtvSZvWGBviJIiS+qIJxsJnzb/yZ2I+jsS9wLNqC/pG3+28pI+c?=
 =?us-ascii?Q?osHLIcyDIWViKwZX/6r7sRrfqpvm/oXsJJFDwNaNzfsW+brcUyPNJ6ZK2LRa?=
 =?us-ascii?Q?CrMz6VGyvlDS3Pfn7e55LkGtqnwgX1d0pl+SwWUBEBSlCshsBLGUm3uDB0eM?=
 =?us-ascii?Q?TnvLmWCTsOtpQVBhJHXbDwaAo6bJtu1jj+lWQXFvz8nCNsmqCeN4T6zAvVqH?=
 =?us-ascii?Q?2VkA5oqIQdvgJciCmlg5DBA2NJXawKojQfguLKMRYMLvUQeEtdIeYksvslkQ?=
 =?us-ascii?Q?Jjsr2PW6k9NyVJouJi83nZM74VZP8CY0MLEskwZUVrw6o3Fzz3oNSl0IKlGW?=
 =?us-ascii?Q?mSiap1I8+13haILseoTePDc9hzu+lhUnAiAuHixjtcC+8La2YmXLqFbeThBZ?=
 =?us-ascii?Q?oDUyT1K6Jjz7nIVtusyyNvLMli61bbb7FzOrEWD/ddCwyeyo0+PuWMl1xdM/?=
 =?us-ascii?Q?wC0OX+SfC3nkJE4sJL2FVn8b1GzdXl4AIC/v9mvtxWyT8Nkl4gmhPL9A1Hfm?=
 =?us-ascii?Q?6i9v5N34ouczfJkphYEx9yOXvEHSHUvasyfpQ/WfhGzpPju4ypD3c1w6z+DQ?=
 =?us-ascii?Q?knZurrRej+/rCBhgA45j37zBC1fD50vVl3yn9EFhz9zjsIEoVCfOmGxiBwVl?=
 =?us-ascii?Q?04H3BzjAFsh7UFLBO0ZAv7M8lQwHm6QmuGFrXnmVrSKSeSwj24KZa933Ol0P?=
 =?us-ascii?Q?XdD0joO3RIkhUYf/9cu8h+yU3R/bfxWLWlEwHc1vEBVGELOveOqeEIlUe5Ao?=
 =?us-ascii?Q?wsHzSi7/hlsfe+vgZ8hEWnbFHQPxtiThZQTHjCh3UWZZxddh5TOmrbbmyxPO?=
 =?us-ascii?Q?proR3s4U5BF9OYCoyyTUddqNKkopQckXL+X6lT8IVRUnjSjNfXIhBSoBHVn0?=
 =?us-ascii?Q?lrt337pLmmPgxm0c8wXSewrjurMX6PZyjXpfep6rbQvvkfBav2QT7OXr4r7H?=
 =?us-ascii?Q?QIB5IYKSiuu0FkZGpbTju6bgoM0yis0gZ3YSdcrz+It4wtGvYmAE9DiEDRSM?=
 =?us-ascii?Q?LhRx2ftaXMyAa0s8j5MKh0e7nu9sXSTSJe0Nz8rsLZeVduBdMVEcOMqGScaB?=
 =?us-ascii?Q?zgaBUyIkInZ7udTM1NXYiroWbd+4REe3h2ciebbf9XgwGkuQd0JixYg2J2gP?=
 =?us-ascii?Q?jNH/iVro369OYEMz2vSRGl2yehef?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:57.3305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53414291-0101-42e7-55a7-08dc62d43708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

TTM allocate contiguous VRAM may takes more than 1 second to evict BOs
for larger size RDMA buffer. Because KFD restore bo worker reserves all
KFD BOs, then TTM cannot hold the remainning KFD BOs lock to evict them,
this causes TTM failed to alloc contiguous VRAM.

Increase the KFD restore BO wait time to 2 seconds, long enough for RDMA
pin BO to alloc the contiguous VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a81ef232fdef..c205e2d3acf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -698,7 +698,7 @@ struct qcm_process_device {
 /* KFD Memory Eviction */
 
 /* Approx. wait time before attempting to restore evicted BOs */
-#define PROCESS_RESTORE_TIME_MS 100
+#define PROCESS_RESTORE_TIME_MS 2000
 /* Approx. back off time if restore fails due to lack of memory */
 #define PROCESS_BACK_OFF_TIME_MS 100
 /* Approx. time before evicting the process again */
-- 
2.43.2

