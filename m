Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA3CC28B27
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAA310EBD2;
	Fri,  7 Mar 2025 15:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5B850msZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6D010EBCD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCobrYQS7e8AAHjpU7kSzyABkM/qAZSZX1BeRZfBbvOm6z5JtAcO3MQ4RIXVIsZlVV6otvCeN4TuxLYXGPjYi9qXJ66nUfzOnCjT5TYKd7JDxI5fCNGEnbFdmvAfvEcBPepebS+LC0XNT5ufr7aXzHrCc6jkXbQ7WiIza88hRyQPbwubYeB89sDLgFFqisje/S0q+opTZdQNFmuiYPIlxdza/ZH4BgtG2yyFIjc8+JS5huhK4LODI61E6PZFXMCED9BdkZy7qKb2G7x1gO3vo/5i1ybiApZRYrSe5Ji+TkbtdT4mxbLDY6iktCqa8YkEVGNAwVHTRZI48MswfxUibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=ixPBtSh999TCc0xYn5pEdRSPJt5LfGCpKi8M4yXF4voIQY4RjNittMGNXZJ5eKtCvQrdmTT5nrmNFywxvfq9nSwArt0uaWcKohg4OKp/lLji+j+ugX2gUyFSZno8U/yoT6b87tw5w+arajsPiRnBK3hs1we9NrYpLL2qJRBRGycmPO+o6HMyGHP0q0jc3qjiDwv1sudhziGz0q1yjD//PfFPwGszmNCwJPYPyCPOnIr4z62aCbOHPFbyVjXkYwlX1XaZp4iCKUu0Jr2kPbEQfTfaabtGDeya06IGDQs+By7PUel4szYQ+zyZsnxXtOFzyO7R/KbLxOG8Jlxuwn9p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=5B850msZiPr5eZa6pmjA6+iROBoQwitYPe7sVTiYUZYbCCfFqHUSz5vvNQScKzZGccyFZ8dhLbWrQpKsnyNGOK4tZCXSFdyB9qMyMxl9gmuYhCf9MkWlEedN45bffwWgIcT3Rssi7e9efovFRY/KihomraB7g13VDi+t9I9Rgtc=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:16:26 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::86) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 11/11] drm/amdgpu/sdma7: add support for disable_kq
Date: Fri, 7 Mar 2025 10:16:05 -0500
Message-ID: <20250307151605.946109-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8ad3dd-01ab-458f-178a-08dd5d8b070a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ivEfYNAX0W1ruOQYmM/ZRAvOr6Prj0KCuGqeBpRcF1VQTGEE+KeEA9Ue9/jO?=
 =?us-ascii?Q?9N4imDhVrK85lsZaxRXtelvbzqXyHs2QKSpR8Wp/tVH/MmYwf2UPTIP2pb01?=
 =?us-ascii?Q?UU5GuXixC8GfX6/fpFVEaO6EobFQOm2LwMfQBJbbGAxHrMIrFm3QvqGUBQde?=
 =?us-ascii?Q?UOEl0xO8hx2oF0Huscp/eWjpyC6Y2XP42HnjFfO9sPzhW5P4Lzzv1oWxiMrI?=
 =?us-ascii?Q?/bjBcQOrpV6yfrYjh7BJJuddc+RfTpEd0j+yQxJ86RZrRE5yxiU10Va6GPhT?=
 =?us-ascii?Q?rcjqoUFfoEVRu8e04uLrBuH6wag1Vu25RFIghrBv98/LqoEZ8hXMQBFfN1/G?=
 =?us-ascii?Q?92WcLQduj49qhmr+E4KVvRupv0hjBY9ug0O2S7mGuZ7K9b0/xdRPmkQ/aqVM?=
 =?us-ascii?Q?Z0DcLCMQDVFsJIpMpaLcjaE7vaAXTxZl/e/XL7f20CDnODAmZ80CW1x8RUNJ?=
 =?us-ascii?Q?fkBoms3ACoa638PWGxqsHzR90uJ+9Ngy+GS/NkntvroH2giSQM4KlZa+/u12?=
 =?us-ascii?Q?3brIG3jA22Beli3ITkkY9e0kQv0t2p2pR1JC10JoxVE9kair+fIcSZf4C0as?=
 =?us-ascii?Q?W/UNHSIdsdxy1BpzMeX2rTZahmZPGtxtAqdI6ILAcsRMZ7So64sZURK/jhyB?=
 =?us-ascii?Q?6wncpT2x0sMI10UjDwI1Y3axJfdKWRpA4q936TPJIlfPczNQhjqjctsDLKos?=
 =?us-ascii?Q?YiftdEy0o6F2lN73VvWr6dEEOaBBwxqthKBoULdy9pc7xyiEc49i8LDdem4F?=
 =?us-ascii?Q?9piSYQa1n2ASFec7YUulSEtlK8UIqqZYJ3K/tZkG82zjUwdQB+5FvzChhECt?=
 =?us-ascii?Q?4PI+7K5o+nJRkIR4CBlqD2mq7Lff3CL40L5f2/7exDn2XrAhZVU5vYuG6lJt?=
 =?us-ascii?Q?n6BQhVa7nHnI0Yryo0VtqAOCtJTrl/BdTyI9C6np2mKnRYdxodmBaG7jrN79?=
 =?us-ascii?Q?dsmz0ymDHDVf6VycBeOBH+fxrURNqko/7oELsHkRFaBHQvuI5rDTun4vsmZj?=
 =?us-ascii?Q?lgpyEknAU+U2uOm8yZTwyJhAPUmdbP/1EnjsHDw7YoWYoOvfDERE8SNtZpRZ?=
 =?us-ascii?Q?uXSrvghoA8IsRNnGIwfK2ezIqitCQfMkStoaewoqZlpwO5q29DkR1R4HtdYq?=
 =?us-ascii?Q?pEf90AIb/hUxqQRNcGAcPEU5u6FTLPrtZaHuTVP7XPpiyhAf7+tCGe0HkdFh?=
 =?us-ascii?Q?1WfaPzJmxIwmtKBJ56Q1YPUYxBRTrKLJlN9+FrQImnG+tZsEPwBfxnIIzCO4?=
 =?us-ascii?Q?L8QeXD5ZI8RC5JLBqgPqYX6E2QdSTmLzDZKcQOK7LmMHijKxPUf/5ElszY0a?=
 =?us-ascii?Q?ykrRAF2oQOPuymgdZtzYlLjbWBmOTzTqsCeWQS2vsjU3jEVLaGG3ElafP79A?=
 =?us-ascii?Q?rRjP1/08uSYK3jH3ucdrOCQ7lRu2ZDeqtmRZ4Tq6CMFhkzeBVBu6Rbu69YzJ?=
 =?us-ascii?Q?EjJDYEyK82hTAwXM5ZjYriiqmvHU30oVV4z/uKMcWjClVTGf2ccCXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:25.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8ad3dd-01ab-458f-178a-08dd5d8b070a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 92a79296708ae..40d45f738c0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1316,6 +1316,9 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
 		DRM_ERROR("Failed to init sdma firmware!\n");
@@ -1351,6 +1354,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

