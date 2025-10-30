Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A01CCF9EB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 01:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1504D10E874;
	Thu, 30 Oct 2025 01:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wphmmeDf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C418210E874
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 01:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppNjsS+sFXV7vAF1q1gyQ3QWjc2Ub929fyBAtapnJIk9W8W1u8wAeZpJDbS5Z5rwWPhhmYC1jSnFhUz/Dn+KrI+NBl2/Too1ZzrU+RzWodBh3kOYFcIMEJT+e5uNu8ENGCJFL7b6qGf9cxASsYNijh81l3SeQzWp/3wftSwE0lP3qoc5SlJZQsJ1LWLdJpizFjU8+CLr59i+zvW6Fx89k91NtrCPLvds/BYyIBiTEDJXydZh4t8ZrFUHE9jyqANajl03mDGyAgRBA8Lljsu3c5NuuAqrmRRvp9APuCk5zXkqqxmaZX4QeWpWqgJPVQ153LXZZ/Zx+TjWD3n4fDFSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31OwOoIjR5ZpM3s1VPEJ5Elzzuv6sn+c5PG5w/KP0NU=;
 b=KLtRrr5yV57gCnKOv+EE21r1t8wXuzn7V68tAnatjMysJ8vw8ia3lqigWJFfIiEBVNPQSr/l8RjpfL14iKeXqGCraQtsD/FriYCJRI5VrxCqXUqnfZpby2/LW2K7/N4XcII5PkuVRdLK8wuhE/eYt1b+PGfsuUIzO3kTeisPJGsFZu8FQ1+5iWHe9Atotc1gst9iHoTxf5eCdI/URIkeZ++F6Ca+hrf8FJ9QYhH6Sgghep4EinJVeOrVHN5Dfz9lD3syOv3savJ2i6gwB87YPAXd9B5breeB10uKMOuVWwVsCkaVMjXBtRY9/j9EYI3lB1/AwKbFYaTLObojFGYiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31OwOoIjR5ZpM3s1VPEJ5Elzzuv6sn+c5PG5w/KP0NU=;
 b=wphmmeDf63TURBWU8IbE2GSe+lZxP6KOdEVb2WtWZLOcn/N3VYAsZt2LbwHZG4vGRJkXONXibzY6TO6VOGcAxUv1vlsbwrSCNE4cNt2yyVjGu8fgEfN7LnCzDzVBZe96uOh4n/zjwvI77TpzIfrH65IbbI/DeMneTs11TahT/x0=
Received: from MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 01:00:46 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::66) by MN2PR22CA0006.outlook.office365.com
 (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 01:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 01:00:46 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 18:00:45 -0700
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
Date: Wed, 29 Oct 2025 21:00:27 -0400
Message-ID: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cc36bf-27f7-481f-2999-08de174fc282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z/EvTCmhoDuQnT+4zJ8FS+lnGxqIeBLVCf5BcLAfsGfxh/+3ohGmKuYvTsIN?=
 =?us-ascii?Q?hOh8FUlQK+UzglhFU6v9rYucW5QGeib64gSVH7oBsjr87QdqA8TB//GSmMnB?=
 =?us-ascii?Q?Lc7NCUy6ovR+SoGpjLQbDfqCwJVrMw22vu1W4R+0oLC6lo0cEWNCKVMckw0S?=
 =?us-ascii?Q?SNUARmtGNZvNzFAgNrHkKSRaFW4YHpiADOs/DUwVGeIk6xTGgQZDFEzxsnEM?=
 =?us-ascii?Q?Tm8KYn5sHZiQzPbByNDkVXbEV8jlk2zNpwI+3jQv40vb581yQwrbbwIKJQyL?=
 =?us-ascii?Q?mxHDGjKXwZr2UBnN+By/+rhnnoj8Hq2siPGSktGkaH7PHkCLB1IC7AtpEWNi?=
 =?us-ascii?Q?2sbNK4nDnvTVrKi5L4ULKhlE6OxY75kaytxvdKUTBVUFZPiT70ft57/96bAq?=
 =?us-ascii?Q?nq0Meh1AfGYEX5KVJta75fiic97tFGwdQD9LxMIcWpcShXtNb9Y8Vk0VlpjN?=
 =?us-ascii?Q?5gtdbAAjljwij3zvrpG4PcnEinzA9Dpf6GFt1DtjRXJeEX7JUZO+SN3mkxku?=
 =?us-ascii?Q?ONg0OrVnVpeLNOo8acy02x04P1b7VlA6XOZQUBEimYV2WFYVqzBG2MAYvE46?=
 =?us-ascii?Q?MlHn3Jd+nesaCfIh/WcdeCS6EUVz6tDC3A5AlyCwYHN3/y21n1QM7EHqWHov?=
 =?us-ascii?Q?TaQ7JpWnVVbP/5ElC+QqKY5A/UQr7yPAndPObCZZktQRhVUFdAeDzylqdmGI?=
 =?us-ascii?Q?QvMXp+VavbPYxPMy5ial/kBTqovyBuOANLE8P4sqOHL2+00A780R3ta9HYha?=
 =?us-ascii?Q?6sOXFGHSgCPq3zwg7g6QpzvL3Oq8p8tzQQGjcERIgmjY9zjIhxtInUnOGBW7?=
 =?us-ascii?Q?tIXAuBJEeLgaNnNXApLC0NJL4RsAix59cyb/Yv0D4PQ43zk1cuSxRpyNPg3J?=
 =?us-ascii?Q?fjYYOf8TEnj3fWITktIBPtNbRH1k6XfHKKgWJLxQVyTl5CoSecSi/qbfXH3j?=
 =?us-ascii?Q?y0NRDPVzIta6zcnNDBd/l4xKr84t4NHZaBR0GCE3Yipl+rlmNai79q+MOZfP?=
 =?us-ascii?Q?bU7Uen/Kkx+lBitnKg2illG/7tiGhrmvAiFvuqp4/GtowbQ4VXDN5qjmdm5Q?=
 =?us-ascii?Q?Oy09iLwM95+13ec6rOmxp0ckF3IixKI+j+geeQi+86W/zZhDUzOmmLNCkfMm?=
 =?us-ascii?Q?M02D0ml/aIbI+XiGaV4LUgk6G18r15hn5RNslXzR4b9ZZggTad4AFzlM9AR0?=
 =?us-ascii?Q?ly60J03WfOMZ3W/lCEZdc3VzKsabNnTSRTO7ORlELfS5yj79rN3Tn5+58WnM?=
 =?us-ascii?Q?1OQFuZ0BMX0PfCshFeh8ej43WG3mBo7GD1xPhrW9VQ4dqdGkL450gQU9BwI5?=
 =?us-ascii?Q?KxLxCwzSd6vwjbtZ8ZGbcsxfB004Yhgb8+mK8IE7fsCT1QCUVjnWEwH8jJAt?=
 =?us-ascii?Q?YXfveX/Dpm0JmFd6JmTaPetpwrJEiinn+Zd7Acf1umVZiU48pSbGlj+c1Gac?=
 =?us-ascii?Q?7Z3V0U/jZ3xApbv2MROi966epMlowBrPPg1V66lhwCrsm7krJIjuhje7n6F9?=
 =?us-ascii?Q?D24Lr8yluXcuMk0PY01BxM92lABaAIL4mBLLXR86siW2cgq+jx0MOhk1YPos?=
 =?us-ascii?Q?AjXv0MMWO1P/jIcQvNg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:00:46.5918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cc36bf-27f7-481f-2999-08de174fc282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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

Fix the following corner case:-
 Consider a 2M huge page SVM allocation, followed by prefetch call for
the first 4K page. The whole range is initially mapped with single PTE.
After the prefetch, this range gets split to first page + rest of the
pages. Currently, the first page mapping is not updated on MI300A (APU)
since page hasn't migrated. However, after range split PTE mapping it not
valid.

Fix this by forcing page table update for the whole range when prefetch
is called.  Calling prefetch on APU doesn't improve performance. If all
it deteriotes. However, functionality has to be supported.

v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
VRAM

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c30dfb8ec236..76cab1c8aaa2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 {
 	uint32_t i;
 	int gpuidx;
+	struct kfd_node *node;
 
 	for (i = 0; i < nattr; i++) {
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
 			prange->preferred_loc = attrs[i].value;
+			node = svm_range_get_node_by_id(prange, attrs[i].value);
+			if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)
+				*update_mapping = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
 			prange->prefetch_loc = attrs[i].value;
+			node = svm_range_get_node_by_id(prange, attrs[i].value);
+			if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)
+				*update_mapping = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
-- 
2.34.1

