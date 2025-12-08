Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3035ED3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B3110E3F4;
	Mon,  8 Dec 2025 17:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CPrD8rX9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C283110E3F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqWb/ml3Z1k8T/nB09+mkL4ngf1ZSIte7yvJ3FVCuTGbKriBEDLb/PQugFkbodsvE55ZlnM5QzK5BjGa7I7lmjoTcL1rDU9AL64KxEZ+Qc8ioHancw88pQCK+j3VJXWgg2q+YprZ58D5SMbmvEkffkZen9kn0n5898WAuQoI0t8k8QbGmW/O1MuAnLugiSFIJ4CoSat3tCSzGjd82TtE/2TUqeWQodqwWgAaFe4JEsQSTtZgmtwjPCqYj1q7SKYbbq36VYkJ8n72W8aDP9+kKXQC5P102jAlQ2uEjuqi7IgZcdv6IFWpttUHC9SDSOZBSuW7KQ+YaHegGAjvIHQnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpzJB3S1Wo4brIeFm8IkCx+3xd16iTIxe0IugG/a6zk=;
 b=ZllgQ10/nvN467StKx1PRLCnGpkrpFAUiPk+rcMHtWZ8WCgTDBR/6SlPgUep7zswpjNU5XeOJ+YJZCN/dAQwNZsFyzSeuQWG0nbxh5yrY4O47zr6ROcAzogOqmHpvF30iJEK6RKxei241gnx0sINH/FTA+aJyIaDIOOr+SCi7J2q3sUFpWAy9RciYv0Ub4TT1o+ETjbnmnJQK2WW69MNMHvIePZCnpiVMLE2Nll49oNCZq7HbO6skPAjCTS7l4l4EyjCuLhjPV/adNRBnaOyivtyOmdUwyf2+SVXlFC9/6TPTFZeChml+HaIx6gEJSsxDul/WH5uS18AM0U8VwRCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpzJB3S1Wo4brIeFm8IkCx+3xd16iTIxe0IugG/a6zk=;
 b=CPrD8rX9AvbP4jNwYSAZqumNqGt8whJBOoUVe6Zumz1lOZseKz5h3OxTQQf/u6SRdj7qO5h5V4p7dDRBMnBwjef8UMalB8xWSJKKvndO7eS1CrdJ/euGAYnWe3Ims9g7g1Q2Vkfz0HzAOtAcfpf+YpRed2YBw1dLGTgAfewDzlI=
Received: from SJ0PR13CA0213.namprd13.prod.outlook.com (2603:10b6:a03:2c1::8)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:44 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::1) by SJ0PR13CA0213.outlook.office365.com
 (2603:10b6:a03:2c1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Mon, 8
 Dec 2025 17:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:44 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Enable retry faults for GFX 12.1
Date: Mon, 8 Dec 2025 12:17:04 -0500
Message-ID: <20251208171720.153355-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5cefe7-87f8-43e4-6f24-08de367db365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5vuAMsiDxbL1ffrpQAIV5gdEpVBhyNW9B+rAM9oGhIsG79BhuNimgtYTeuT5?=
 =?us-ascii?Q?yZ4PqCf10upVMkEd5aLWpGE5elxcGD60V8vtxuu5PnncQAfnyx/IMgyCn25a?=
 =?us-ascii?Q?pQnRFd0IgpPvy3K5ig6RW3sTgehUpwRMmfsmNPHL8CzAUikNRFNBffA5TDLu?=
 =?us-ascii?Q?UpJEHyM4AW+zbiKk73nn4vHnzqbjTpv1JhxcRQhs8DYNv4Q3vr+NZjm48Izo?=
 =?us-ascii?Q?E7db65F4q2FBbLN/5ZbmeOqMGX15LLDMXWdcmjPUMLHY8P1WuWS/R+7rMfBD?=
 =?us-ascii?Q?gDl4f2OWomRfQndm+yoGPbveiv1oYHlFmsKLhcoDsTDXxGelprGeKn1IGHCv?=
 =?us-ascii?Q?tIEQJ+Mb1VLFIdzVpy9YdD4t6G0O3/FvvCzUSOk5ocFNgNaoWa6EQDLguQ8X?=
 =?us-ascii?Q?BFVO0yB24Suv2V3kL5KojPadlaEyZk+nHSBJn/w/F/8B0Twqi59QXf+d0C9+?=
 =?us-ascii?Q?h2sHhlOiUkOu0K48xJQpag8JhFrhsV2Ka6RE97xS6SC8gQlhF7uMP4WnMkQS?=
 =?us-ascii?Q?A9kleTNDwAmz09x22cBVMWNz01zdiJUj9eeR2utdEdBrVmuNtsa7euYRCQWE?=
 =?us-ascii?Q?ahTiv0oPa6ZJFYmEtSfjsujg8rVxajEDn9xfaE47Bl9qRSsExhM8m6wlis4u?=
 =?us-ascii?Q?0Dvb8ga4hgyXO+o0m1Lwzi7RiH3X2y+JO4Kr5V6M3dusm90h05Jg7ChFfO3h?=
 =?us-ascii?Q?3LEgpugcIxomFBs6Z+x0BdBTO+qhf9tZui9eCh7c+8oktTBAF82EiCpPMG8d?=
 =?us-ascii?Q?Y5tSCaIU72/yuP4UrIVEkpDYFiIUIyV5w+YImMtuH6f7hN3sEdzZCVcvsZMQ?=
 =?us-ascii?Q?6x+tKbmk2OfWn0wAsqfqWiA3TGW8scLpG84Wi9CxbGVHbLdkJpbX0W+tz+OA?=
 =?us-ascii?Q?mDcRgpIH6uPGgvVmersFx2MOGL5KQkEx0HnbfUheNp3VATMWow/FSCaDfXCg?=
 =?us-ascii?Q?gp4rGUb2nRVEFtdOxvPGMdHHSnTxjQ9qAA13JZkGttME64zwuG7iUWFfAvTy?=
 =?us-ascii?Q?lYySvTTh/JcToT1V41LQgQXaYV0A5OCeY4trsgmpm2Mx6jAPxetDI8ERWAzd?=
 =?us-ascii?Q?Fz96bZTAMyUR6KJ2wEBW1lsXOyZR9Vu+d2GINKshqLlcSHci+ct7GedTgs60?=
 =?us-ascii?Q?LrBQysSoaHGfUyzStf1qKLItsJTkt0EUMUbTxQdl+kP9EatYnBQloIZjhhbD?=
 =?us-ascii?Q?m8oVeuqlPy0SmSrYTrWI2hyWwIpMMjAy3TNhdBuxc+6Kqj0jn51sd3RYiOGu?=
 =?us-ascii?Q?0ypaaL42hM2lnmKx1r/Me4i2nq2bY4MZ1UrL5DpthbOAr3UIJedsMSI+TbH7?=
 =?us-ascii?Q?dlcaHkkNy49EYOSMCziE7axRo8SHvKpGmTNjAHn9Xp19Mt0viSbPj6GkUNGB?=
 =?us-ascii?Q?IauQReDQQMBcMJEkkhnrEYnhsVW5uxqMJJJI39vISYTb4/YcTY4iRAdX3aNU?=
 =?us-ascii?Q?ts1EZn0Kiz3kWKwaUZr030Lvv8CyQnBrQT15E1TEVNtMPAJGR1T24s4nx3zD?=
 =?us-ascii?Q?edOB+Qax/BDToCrQmYI6ZNkNrIvsZUed98ZeHteSoUSQBWHiJAwfQjS0pMdf?=
 =?us-ascii?Q?LaiY3TuiMjvV2YLsadE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:44.0433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5cefe7-87f8-43e4-6f24-08de367db365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
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

From: Mukul Joshi <mukul.joshi@amd.com>

Enable retry faults in both GCVM/MMVM Context1 Control
and L2_PROTECTION_FAULT_CNTL2 registers for GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index ceb7eb562ef0a..ab002f327f763 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -200,6 +200,8 @@ static void gfxhub_v12_1_xcc_init_system_aperture_regs(struct amdgpu_device *ade
 					   regGCVM_L2_PROTECTION_FAULT_CNTL2);
 			tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
 					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+			tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+					    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
 			WREG32_SOC15(GC, GET_INST(GC, i),
 				     regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 		}
@@ -429,7 +431,7 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 			/* Send no-retry XNACK on fault to suppress VM fault storm */
 			tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-					    !amdgpu_noretry);
+					    1);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regGCVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 24582b8d90ffd..75f7df7db5b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -247,6 +247,8 @@ static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *ade
 				   regMMVM_L2_PROTECTION_FAULT_CNTL2);
 		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
 				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
+				    ENABLE_RETRY_FAULT_INTERRUPT, 0x1);
 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 			     regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
-- 
2.51.1

