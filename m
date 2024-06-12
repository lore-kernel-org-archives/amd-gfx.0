Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B00C27C75
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 09:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7867710E7D8;
	Wed, 12 Jun 2024 09:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RW+wqX1l";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8A610E7D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 09:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ4PSY31WJ0ZUmYSRB0eSFRvCiJIswip7dvADRX824kkBpBf1ZoEX/kAWwCR5h1taG+JC5O17CXKwL6NvLPbE8LgFXIRnP3Q7Y4iRn1X5g15ag2ck1KU3N+2DpmWuadG/yx/Zb4DG3l2WnFjv73Of33/Zgyn+A2ZOG9tQhHCiF5PPNRiUCWnoj6f7rLmFt29q6dootbe2bvTfUzqBbnZltrv0eXKLsGkwWxuKFJAVCNPqJcYdtnpGNn4XYquaGu66ksFXPPUDg/V5QRiZgNapeF+72l7ojcFKeX1GmvOE3emeLw9gn7XIVV7E3P8cLSSa3tjBY0v2nN6llcqqsnC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkDf6hRlxnI882DoVaNIPGGU0Z/gh6Cm66lQEgAd2Lw=;
 b=UNVI05g28eV5UYfB+YYWvL5nIvoC1G2L7/jl4sYFdo12ajgyQe07G7DxhxZQOcjFfpTfCpeq7h6rNlw1ndnYu59GzBeY5gOAZtpWjlMSprzDxxctriZ9XjYJWfGeeOXxZIuSICovwuWn6YOlCQAx7/NgZAX+Ffm9mZjQzArA0n3Ti8JnhxQ1efxMVrBOgPsj2ePLLktopFrnS98jbWJNMfYKLF4rSrlThAJqSe14u6hQVdDZWHGQIASAV27UZ84y7V2JRIX8SQif+pl3QMnTF9Q4xkXohpE4xFd7C4GbeoCeXVxN9J6bB8orBDTD+1Fo/bHQ5wL4smsxk/DONkwwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkDf6hRlxnI882DoVaNIPGGU0Z/gh6Cm66lQEgAd2Lw=;
 b=RW+wqX1l9T/fHp4c3BKmfrTxqjwc9yMJrQw4NY3H+6YkEhhdQIhq+NO7bUbWBd+hZsBCi1dXmlFU0nmhpzMG+E96NveH0fof+k/EZw3TQQr0ug4IGBcrp/CohFJ7sH5yWyeNIHE+kCyHNyFDT4qG++m7fVHNS+LgOeY8gNHfb8c=
Received: from PH8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:2d0::22)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 09:37:14 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::55) by PH8PR02CA0009.outlook.office365.com
 (2603:10b6:510:2d0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 09:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 09:37:14 +0000
Received: from f9br11f2r-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 04:37:07 -0500
From: Yiqing Yao <YiQing.Yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <owen.zhang2@amd.com>, <haijun.chang@amd.com>, <horace.chen@amd.com>,
 <qing.ma@amd.com>, Yiqing Yao <YiQing.Yao@amd.com>
Subject: [PATCH v2] drm/amdgpu: use local xcc to flush tlb
Date: Wed, 12 Jun 2024 17:36:41 +0800
Message-ID: <20240612093641.3682677-1-YiQing.Yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: e87f47f2-d75d-4f5d-b58d-08dc8ac33e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|1800799016|82310400018|376006|36860700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2zsomr4fwP8BCCrvnXPzl3cbe8aRkaTlurjJ6jutFPgFUUEM1pa3iqRWCNQ9?=
 =?us-ascii?Q?+hn80TGc+n5yVUd9/1qU9JRG5SNynr+BMxQFEj59frSzeZZIriI+Dh3AmWn6?=
 =?us-ascii?Q?YFNGg+Uofyz44oK1UMaYUtem0wpEVFCqUuxCQVW0f14NvClTv0SMOVclYzad?=
 =?us-ascii?Q?11UF3dg+xkHrl/iCp1oAyIVA6b/lOZsGk1hWFgPCgZe4F+avITkv7/1NWNU8?=
 =?us-ascii?Q?4X2X9mIv9Vl3meI+MygvBW4pdWlJJqw5+ebH8d+tKX7xvOlHw0srAXxG5ipY?=
 =?us-ascii?Q?FpvPxOWMFx/Xj9MbNoxiclH2zE5TU0fSd/FflavYwZO+0iQ2rBIzAmdByCPY?=
 =?us-ascii?Q?RlGVDT9ctzRCcZNQ3Z8lzBQk0M5LeF299SBZEpej8Jzk+tKPJDAYOEA0ZrSF?=
 =?us-ascii?Q?qdrX4ZbtiQmDXnWj3sedKrYZberOGs1QvmLeYHBpxwPq3G4ZeHpSziCRoLpe?=
 =?us-ascii?Q?ARcIZCdrpGDNRugeHI4Saqs2/189sIADlbjk1vHf+c+XqEVPh9GWOoT9DIHq?=
 =?us-ascii?Q?jjUdfOqRS/5zJL4CxywoXZ6pMyl0gGWxZGgBjNNnzUIDJfCgFkDsDQU6dT7N?=
 =?us-ascii?Q?XTG9Gag2g4hz0tCs3LmBwOyM3fZhTgc1mbr8to+ynpkYb2zapbZmxfexmA69?=
 =?us-ascii?Q?EV1tyGjh7azJEVZWEAlgzlVzhdTmvTJqJ8f6HKGWqq1XspE6ccjJ8xbK1zIa?=
 =?us-ascii?Q?AKarwsEP5zwOStAQgy0VO/1gKzt0zEMIiXQuW+uKbRKK7JZm9AU6Thdeocgq?=
 =?us-ascii?Q?2VvWZyiiXkr/zXhN+YNPt7fY9fR3WEs+2YErc5O3OwSs7h6CJR56LlYc17aE?=
 =?us-ascii?Q?+AMulQFGvAelsjYRW7goe5Vw4LAmic9IOqKSEOb7UQleKBy1C5HLcic4hI+O?=
 =?us-ascii?Q?CV0FAr6ngNFIitXQ2Hfqn4vXjav588QOBNj9RKk3BEF2YPNeNvzXtcZfAqYB?=
 =?us-ascii?Q?22Zqx9xqPRNm1h5JfnH6Hl3JvLg9Y71727Y1IamSE3eJlz+5OKAmCnNwTnDE?=
 =?us-ascii?Q?GxsDOM6OX9e86SAJF5OgHKqO6YvlnoTHeDCmZIjP1L3u8/za0TuMZAyB43qx?=
 =?us-ascii?Q?EHdbjZty2JkY9ABaNU5JirWi7MCOVaetwB/2hsaIFDV0lXAM8y/VVrF9hGud?=
 =?us-ascii?Q?5XovI+PxNxCHWq6/v629aiQlcaZ8VlitSPTezqoELlMTCrY8aPrC0d3n70ld?=
 =?us-ascii?Q?kxPfYcNIiUkyqAA5waPDJcwiiXnTjUryYUN9f0ZKOT0tdg57o0l/Cx1hZ1I6?=
 =?us-ascii?Q?PnzG9ZIh8smCe7e1Sf9tjarU0T/oDFeAoRMcmw8d3dLNTNh3+zUqVULt+4iX?=
 =?us-ascii?Q?mzhYTHEwNM2ZXjhRlVe5pS/8c0+3qXkMDHz6C5/LM3d1h7HzKY9mj34XDF22?=
 =?us-ascii?Q?6aflDtZvorlmMuWRo9gQzTmQnWOCGMqq8InRM/ZGycVdZtNpMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(1800799016)(82310400018)(376006)(36860700005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 09:37:14.2279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87f47f2-d75d-4f5d-b58d-08dc8ac33e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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

When flushing gpu tlb using kiq for gfxhub, kiq ring is always
local by selecting kiq instance. Test shows mmreg write data packet's
higher bits then 16 have no effect when flush using kiq on gfxhub.

Also some variant have policy blocking higher offset when req/ack is set
with extra bits and can cause flush to timeout.

So keep the lower 16 bits only.

Remove redundant code.

Signed-off-by: Yiqing Yao <YiQing.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 350f6b6676f1..f3fe318e0c1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,16 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* 
+		 * Select lower 16 bits to write in local xcc when flushing
+		 * using kiq to write gfx as higher bits are always ignored
+		 */
+		if (vmhub < AMDGPU_MMHUB0(0))
+		{
+			req = req & 0xffff;
+			ack = ack & 0xffff;
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
-- 
2.34.1

