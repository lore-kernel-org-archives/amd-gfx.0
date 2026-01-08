Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECF6D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D11F10E303;
	Thu,  8 Jan 2026 14:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXNYVWt9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFAC10E12C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2meiEVpCNtPOUBERp0C3wpexOiYEvbBd/D3/5qm9wuGDStDgH1PPxUKMLN5qTsqOzLq7SP4IN7hElNN/L5Wp8eNo9R4AZmBG+lk3/MlWZfjHI8pmASL/jgqGvCkeNUzEHwJ0moTFO1EZD7uAvp/Q/c3qvMrO9dstzPWtIl0E340SohvCGdqg2qABm5F/tqFLQoXkzJCG38BtwLS+uzlfyBVbpG69g1DyyxGE+GOWIBzY5rk+bA3rjj+9BObMaABZjewAyQQgD84sqPhTAyqWMqRLpF57to7olM+3uuPGg13MppKd2nQkSVK1If2CantORK0cVzvUt72UTdaDsoSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10xm+H6IuKz1jmvi8TQIRq3tSQ78Og2KauNM6tdjXeQ=;
 b=LiIY5RJrX9qJjh5k7KDq09cmGArmCz0u9GPZM2YEbdJePFKEeCMTq2EZQNDwBZ8tIYCBbD1eNI4PVxpiTYUEH2RLv2OnPgIwSJA5BmUEhmf4f0+0slwA+sc6IZzU8O8IienyA89kgrjNKybe9bGWouKRDmXYuMglQ01OwVvUjBMpWai+F6HlICsQHKKHZXfBkGkqsD23IOSeX2MXtwHS1QnnBPK5J3/q9sYRz+d47z6hgVBHD68qC/qKsoOc0RbnYq/cgcl2nBfyWti5amEPCO+FkzE8qOm7W/GyXUUBTX+BUgCR6YojiA1E5vC/tAG8jiVqwgqliXq+D5cBTqiOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10xm+H6IuKz1jmvi8TQIRq3tSQ78Og2KauNM6tdjXeQ=;
 b=LXNYVWt9Mr9Mf18JAiWkSo5m+GJ8QXks//QkVU4+Cm8qPxgMBnYgCwRXPperHSD+yJCWPPxvjJDGNkFZ+6Drp+cNGWPtxkSHn7YI03c7HTes2ojR1xwwlzc8dqev4lpvvLprfFLSkxASM6cUH+6uFnUtSmjLkwciROetwxiblzA=
Received: from BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:48:54 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::23) by BL0PR02CA0122.outlook.office365.com
 (2603:10b6:208:35::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 14:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/42] drm/amdgpu: fix error handling in ib_schedule()
Date: Thu, 8 Jan 2026 09:48:03 -0500
Message-ID: <20260108144843.493816-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fa6c71-6d30-4a69-72b6-08de4ec50b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uamWMLg5OO2eR2RJJ4QR5z2P0WgDeCWAf93iGwV0VbXna2tiYlud+ZGjBvx+?=
 =?us-ascii?Q?owAi27Q4caeH7yMHRb8m+qi72tu07N7siU5xgsMHJXA0veiUtDYuqbp2rvjs?=
 =?us-ascii?Q?UoQVHO5g02zKaLBFPnQdqpyImrSk1gdBsefz4HKm0B0CuOOt9s5SXryqumBe?=
 =?us-ascii?Q?VFbhdZLDivwq8UYSb7gXIB7Dd03LL6PvEF/X4Hw1U3Xh/5ulK1sYN8tyDla9?=
 =?us-ascii?Q?8RhyZNjnExVBcxXCQ7vT1HxvKS19tuZULooNmYb0sRLfL25ZDkEopTh5fyma?=
 =?us-ascii?Q?nt2vIkbEc1RFs+c+LiVwIGNKqip2YoPNVuY4FKi6ChCDw6yax8rtj7SV9375?=
 =?us-ascii?Q?/PpF4ixEl0RX6e63cwsWDTcPaKXF9pJWd7Kd48a458SmlMVoWF3ElbtESpXc?=
 =?us-ascii?Q?+s/Ksvwa1MNunCMeD59xD6t5adBiP8HwEb+fVdr05FwC3B4nCnUMIOdv5xji?=
 =?us-ascii?Q?+6EvlySTkqdTrjMhf5pTwRieVkvvXBlWegS5Ic+OXSrIrWUPM0SUb20SqQiB?=
 =?us-ascii?Q?iBa/dEJVm2DqGWSUmWMeOa2E/bRMn8qHnCMoy5Bt19QNwh5FzlqAaqRIy2AI?=
 =?us-ascii?Q?Q9QYPkZUN6kibVywwbJuE3VJeO7sAoDEIgNUMBZ5l84iOPji1r3Iitvp6KLM?=
 =?us-ascii?Q?p4iXBBgX5FLfiGANfoS8Dv4N5VVZqlzSTt3LyqkYwBmfvh0cu1CDsjW4nlXr?=
 =?us-ascii?Q?q0wyQFnm8wKNRX4wfIlMS7p6NCfnjGeT/WEmVR2sOtRni7Gares0eSDr1CLc?=
 =?us-ascii?Q?yu7ue6l2Z6egx3eEIBBPH1kHGSLBOMd/qcYZOeh9rpR5jXXT5nrXHWPm+EFo?=
 =?us-ascii?Q?txzf8sel9Pp5C3pEoce6nIkr7ezL/oDND2ChmmRQSws9Z+WC4AOgEXrvRf6m?=
 =?us-ascii?Q?FDULl/R6hB33tBINQPt6nL6hUuOGR3KckoABh3wMUyAtzUGvhLaeeH4ZUwAb?=
 =?us-ascii?Q?iU3LCACWhAdR2C7TIZh5UjeU9iJZLURNfmAqtElixvHrpLtrfgmlZN8UptaP?=
 =?us-ascii?Q?tLMaMQwET1YqIW/36EsweK33qgo32Xxp7XiRdsCRtq/244W7HbIdQIaFiOIS?=
 =?us-ascii?Q?ENWVoifvC2cfjRNRtb8Is/+mvZDipOAL1RoO+Pf56rjjYKNFz0v/zb00/cjl?=
 =?us-ascii?Q?FLIEqwfLfaCxQKG+38XWupH2xVgcXYwmz2xcSN5lng8Q41P3wkTMn4XS2kig?=
 =?us-ascii?Q?4ccQCzBf+fIsyzGCgP8aUJC0wxKB1pJMjL0nRj9RsVAeXaks1mfPH2aGcOvg?=
 =?us-ascii?Q?l0hXSwi25hL0sgd0M8WC2iBAindEN0Kb6T1/D1p9TsTLuf4ikOHZuUiVmyZ6?=
 =?us-ascii?Q?T6MnjZLha3+APonswn4ahm0gA7EVPCjD2u0hsK61SY0wPEgMORLdQbfBtD3W?=
 =?us-ascii?Q?dmw4qYhK8g8HlpXB+zQYyavEYvbsvWuQXH/34UsrG4/TTi6t+35CrGlJHmO8?=
 =?us-ascii?Q?9NPQgN557ZKj2iIbt2SK0mtYEfhz7z7iitlpdNQs/2CyiFPB9jae5qwtA7kX?=
 =?us-ascii?Q?ovr82wr2JYlnNGpSj3m5KF6x4VwxbnKTNcH8MY4a5Svvy1c/gD0OxQz7p1jM?=
 =?us-ascii?Q?twvJIwehL831qpQrmrc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:54.3009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fa6c71-6d30-4a69-72b6-08de4ec50b9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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

If fence emit fails, free the fence if necessary.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 586a58facca10..72ec455fa932c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -302,7 +302,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		if (job && job->vmid)
 			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
 		amdgpu_ring_undo(ring);
-		return r;
+		goto free_fence;
 	}
 	*f = &af->base;
 	/* get a ref for the job */
-- 
2.52.0

