Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11752C54E65
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 04:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08A410E5CA;
	Tue, 20 May 2025 04:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gfANgXwO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DD510E50A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 04:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxeNfBejbwT7+Jh1goFchHoCA1/ocQ2hpPaP8cx7wt5fnLJCROG2htZDYwEdwD+26sW6rewxAsZ8ujFoYecJqzuFf+73XuYOY5IvrTcyXi2Poiq+8gDie7w+hGRL/qXgaGdGkeOldT7WqlDskMaSaL5gEbgTg/Obb7dYXp5YvG6A0Lo0EmId3gJ528IDv3911f1D4Qe8NMxoKEX9feLeFZiBJtB4gZObMigieV4YqMdyCCd/gB3wyA72rTfvNW5QMyoquoJtPnjpIlDWfg0BBx/RO5/xixvYm5jorOZhsHdMdT+ULdPhspGsBycuoL/qK35NnaetnpAKKKJNhKhLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4prlkNW7fHdOHly/pyHKbElbKeidDlZr0/e6vjv9RD0=;
 b=RdPjtroth/PDwfBm5AY6/xItk6hhu+Qgv+qNw54dPJuFHHOVqgS2XjhoFm89zpH1tXMVGrP0ntl1ei740cwcSfMv5XrN4kNDGvoiPgKGGR/5XTsHGMGipBJ4/xUIkZ7ZIi+X0qs7Gp40syGWf/P9M4O3nhMLStF3eSF6eu1t8BUQxnpk9k9LW61Uo/4r3qlbLAusfmdvxiYp231GAorD0IN1bn/uNTEQsEKqh4zikQJp3malPmr/WwK2q3eCnx4egx8TTa4aniSeOs3pNG981TeHPL51Rq2zU2xzwVc1IjQ56NMqt4P1IWyuwGypQbXyCdx/7Jh0cWhfSQplK0NaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4prlkNW7fHdOHly/pyHKbElbKeidDlZr0/e6vjv9RD0=;
 b=gfANgXwO9tpNkkEc922dbCVCQC2S8FBhYW3KDFRzLv5lKac+2XjZ/PS0IKv1hraBkpREAS11d9k3CmDS4nM8zmCJHCcwFZ0gwfXFDGudmnSYYDFD+ulKOhWYVu7EwHlOBhT4hQERqsPe+6CGWwyYrxWHvP7UVIxfzWS13bmWlO4=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 04:27:55 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::9f) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 04:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Tue, 20 May 2025 04:27:54 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 23:27:52 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Stanley.Yang@amd.com>, <Tao.Zhou1@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu: update ras support check
Date: Tue, 20 May 2025 12:27:30 +0800
Message-ID: <20250520042730.1606737-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: f4be7b35-3a72-4c48-6839-08dd9756b0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yoXp4Dr13/uF2VJnvhCK/gJ63x8QW/p0Y6aflZxzTm++vweJ+R0+k/yFcYYa?=
 =?us-ascii?Q?9GwKhmJL2AxKwaaBGss89gQikt4w+rtYaorox0mbgGufCnHkG3LsnylPg4JN?=
 =?us-ascii?Q?nr27W1XGW2KfL+luMRhhyXmHc7UemQ7H54sC/F7AB0hMDIL6gyHqpmoUx/hp?=
 =?us-ascii?Q?mVwiLe9NgFIWC4i+zQ+xl6/LJrIXYctmVMDNLqTaUQ4Bu8+QZvSAyfvHA4PW?=
 =?us-ascii?Q?fDA+rJByh11yVu5E306ANfHWuX6JQg6TOj5wzrxpBEXjWxzp0VFK81TPZFc/?=
 =?us-ascii?Q?ghJevdcNA5qOjkQx6zFarghRpSnh0cyTLBHWRo35ZPq1PNf3VNV4S7uwBYXV?=
 =?us-ascii?Q?/0fUofPKxkS83b0Dqn7uvApW62+/CzSR6cunWcuX2JB06Hb6fy6Bo9cHjIsJ?=
 =?us-ascii?Q?z0UzDin6YKisvQHcAdCovg69TqQGiWdq1iBjsg/h5iLatiQI/pqKQg/skbtC?=
 =?us-ascii?Q?hTOyuqYgJhvxTljqG/GSp7kDJOR+xruWX1s8z7ibY/M/LKKqCV5IItJo8YUV?=
 =?us-ascii?Q?xAy4FJ1bf2uVEdcbXsUv/jfFwNfLQTl1LcPkpOGelnP5wAsR3g+buvgGj78H?=
 =?us-ascii?Q?OGR01kdL8Vy1rCV/cDdO4SBskEnXquvNVovmSozgECqsywp0JGqDUDxRFH31?=
 =?us-ascii?Q?azG0BEjYidaLGhLrB+j+QpG1//T3H9mcI6LaGy1KD/iPKmUO1WeUHnSsyEb2?=
 =?us-ascii?Q?oCtq6zlPRzh2j/LbLXG2LHeEenoRm2qoyd5L0nwdrknMxWte+3qdNx8FucKZ?=
 =?us-ascii?Q?PkuV1Xx6Q8ZS6DMJh/MTqx9hSlPCNG9IkZDIC1nWcnfVHqK7dU8xYc8wSmMx?=
 =?us-ascii?Q?rinOFlfZEiY7X1Uhs8GX7+qIFkXJKYkWa8SmVNamY1J2ddARpm86JnlyHFzg?=
 =?us-ascii?Q?XsIGweXNm//xd7kmsWrCIBAvN5P0/hjCDHJ3rLNBI72qs/b8Rrn3UTQ0PRvv?=
 =?us-ascii?Q?9a1nd1GGDiWUYBNlkd/aKEeiA1rf1Qaj4NLy965PxNpISiC1uY+duC9dt76s?=
 =?us-ascii?Q?T046kZ8iyCdFn6pkAMbFEaTgFYOyyZ5IQpbt1MyDVry551IL3LELogAB51wF?=
 =?us-ascii?Q?AF/3kweFqlOD0BcjS+qGomH0q9QVxPZ85mBm7GGRz6U8J36rzDIq8R5FalnA?=
 =?us-ascii?Q?t6fUt8r4N9pmr6+h0xaWJl+p1kVGvtHNbPJUJIKIhkL2iUfBcM/COUGx1f4Z?=
 =?us-ascii?Q?sRwRe7K9cAl9K+2sEnVGFKy/k0BCKAX90xLr5oaTfS5vjaZxjlhKS5BKQo6Z?=
 =?us-ascii?Q?iN60CZkrv/og5ONE0CrDQwfPJXbg03s0S0nf5dy1wYLVBLKo3Ha2RyJ7BclG?=
 =?us-ascii?Q?kK3fMWNhiRiELGrxivHS1M4OyqrYNdX3Pf4lzxvUBk/u3+yJbVlsyDErM5TL?=
 =?us-ascii?Q?I1yrYy1xo9DwLoPDZHaR7xq05J8Bgt9nPl3bTFU2IWCzsro9lKaXmVFtO7GO?=
 =?us-ascii?Q?vD5UO7QS+k6p1qAcSKAZHakO1A0jD9GXGQUhivcYdIPsLhTdZrI7+OIzFgWU?=
 =?us-ascii?Q?ig/MSF+GHOlG6HNLMd7p4k03zuMZ2NJzeN/e?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 04:27:54.6012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4be7b35-3a72-4c48-6839-08dd9756b0d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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

update ras support check for vcn 5.0.1

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e641bd57bb6d..071412b8bd55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3709,7 +3709,8 @@ static void amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev
 		 */
 		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(2, 6, 0) ||
 		    amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 0) ||
-		    amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 3))
+		    amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 3) ||
+		    amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(5, 0, 1))
 			adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
 						 1 << AMDGPU_RAS_BLOCK__JPEG);
 		else
-- 
2.34.1

