Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A5FCE7AFD
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 09:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11D610E9E1;
	Fri,  6 Sep 2024 09:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2C5nTMWE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D2910E9E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 09:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgQNy/XpBth5va90DbtRAnVYIzT7D9Oef4owKJ9I4blFfVi6OStLspM6kiTd34r40mMSHrjUcW0Rvzt30tYaxSA0HgJsvzvKM88HCW07i0+4ChzueDL8s+nedDS4p9Sdrbk21F2C9i5rMyjHoK/og62YHWivTHiMW2cX+GvO07Un5d3djRziRRsWEyvSI3EW1znb3R+maRZnzbg0gFgs7EYn+LLJwk/k4tba/CZAC1byVJzi625Ddq+zfwve3Dfmv5ZklaTdpdX3sWKorgxchlMe+0obT6uBxZpkz+06EmrytFrcGwQb5xIsd0V2aAoxaMk9DGB3Ba0kjZOBAkM5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REIRafW7Tghojsbln7P+XWfJh2rXBV3KasYQrawKjCE=;
 b=lEqKYveE934VUNNXkV72QzTmItxcY/tqiY7TbI1JIyrWkuRxVpf0SI3kt6YDM7hzUaapOh2RPmFM2UvvLSaKtHT6eCo9ul3MIs0CPH3om7Q0nYNZTTLlO9UzvXZLSqZljx4ikdfPjjP6ygEywOqTjqf1RiltZo0DpSTCmnc0UzX3QCQwSoSUq/uztHX7fJWWlhibzpVj/8FP83DCYXh9xIhWs0dM8GlAd1Bu59WC8DEsuVz+l5xVKMEwh/0Ew68fG6DAxweTBiYJn7f3FJSSyM7NHsY1sy28eYUAI/zaWz9894tSG1PMFJf+8A9wR7VqvtRu6bDEC8XeR9nfkmP1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REIRafW7Tghojsbln7P+XWfJh2rXBV3KasYQrawKjCE=;
 b=2C5nTMWE5+W417rH9rIYnQfnm85ntIgaFbHwB0P/jLU4BgVotuIxOdw6pnTef/CrXo4Y55FLEQfc4EhIkKeF5RoSICcje/SMJzF0kAPbVYv3xwMwAo9ivFwHfgVq7WmSxL+oO3x2qHYrbaupX0uZ/T0O8OrewuE3+UCz49ux1xE=
Received: from CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 09:48:24 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::5e) by CH2PR14CA0016.outlook.office365.com
 (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:48:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 04:48:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 04:48:22 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 04:48:20 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Rahul.Jain@amd.com>,
 <felix.kuehling@amd.com>, <Ramesh.Errabolu@amd.com>, <Flora.Cui@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing check pcie_p2p module param
Date: Fri, 6 Sep 2024 17:48:20 +0800
Message-ID: <20240906094820.405313-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: de2a9349-4121-4493-4161-08dcce590c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ewTX3LYsMQm4TCcFf2W9g1Kx2whicos4eGdmr1uEzuGk/D2kvRqpir8eCOpq?=
 =?us-ascii?Q?QBIKKAM6cdfy5gIVSnzZwt++ThzQLFqbPwmSf4cYXY6ddU89lWOGYMUfbHM1?=
 =?us-ascii?Q?yiKeZhj5Qk5YP2i9M+wYZl357wfsiXENXoQN0nfG/W3GIyyaV9zmEnApU5la?=
 =?us-ascii?Q?UysKteKCPdsFFf+Gy03o4/xHYNfKABjuVE/+1rn66yCl2D3tEYtgd8dO6Y/t?=
 =?us-ascii?Q?ONTT8FhJ6o99UNfhtLRZTWs/U8RnWGBNpHX15FUhWau93zdLsLe0m3XHVWOZ?=
 =?us-ascii?Q?QQeT82sHDrRH8HksLkhnbrP+lC/VFzkT0GJL0sY6JSMPw7E5bB3QM5Eghsp7?=
 =?us-ascii?Q?PbOg7P4pNuuc/fzHu9AIFLyTiEHRPKFVkNwmYtJA2yyjao2y8QeKnY9731qB?=
 =?us-ascii?Q?wkrkecKkn0YZaq4lDFp6eDqkW763UMM81jQd/N+CJ/0yg670xPtjXMHRwBHB?=
 =?us-ascii?Q?oNF3kX2Gb4Keqp0626adF10ubdedRMxcYEy2S0Zcxj6Ea0ENNrplJGY5YL6J?=
 =?us-ascii?Q?E1In/VMFY2iNVdhVwsakEHwoy7AnmZvuZ1zVCEcHRZ3UrNDL7RGJq9I0/4bN?=
 =?us-ascii?Q?oRNaJQVEPcoyG3VsHSaADDMWPX8EcsGkpqYP2EHigaagOhpyznbNjoBFDMQP?=
 =?us-ascii?Q?7hyCmlmdOWnSYWZy2rbzncLat/0yUuLCWB3CoQOVg33fx0YPzuedfplqNcHU?=
 =?us-ascii?Q?nQzDGQhNbH5qPG4a5KVVjnCQWqKs27vHZbZPB1+ABCuLvvtU7kJStZmZxMI5?=
 =?us-ascii?Q?z24SaOp7gE5MWzSn0G1rp+5zsIC4AWiddjVXz+t/knUSDQNA2qSfXA15uXkH?=
 =?us-ascii?Q?0NTL1/3jkKzg+rbUx05ucmmSVBTM4XtpJKwpGEjqZZnNpNOe/DhjMxkodNGn?=
 =?us-ascii?Q?LkMRKnpgZkysSfvJTwuAnKpARfY3/TOSM8D0/uJLB/6egsA1Uk06DNpscWtl?=
 =?us-ascii?Q?YupR80b964oyJ1CPkJOgC6HBcgAYnUp1Uhi9UeMMuFqgRXZxAYPlWzdV9amK?=
 =?us-ascii?Q?QBZzG1aiBS9yZ8cJ/Y6IwCINl4lOcdnCP33PtfwRc0ShKTXH71++dbolC3Ll?=
 =?us-ascii?Q?hXwFPmep822+xO/vrbHiSbp9lUFmmTataSKAq0QDfxkCMB7ruJYVvBvKe066?=
 =?us-ascii?Q?d1kJXB8KyKSp4IjG6fKeYgJ95GpN576P6iM9bo8ba+PUuCWcTW7PEHKmpjwK?=
 =?us-ascii?Q?W6mOQghdXHgn7ER80JdshbiYQ7g/OYy7HWkyL9MHfTG2sPZ77MyLsDqqV5iw?=
 =?us-ascii?Q?p6X8l4eqFCgJ2H2wmi+qwdX4SocRbfa7W8fW02hbpJyGM9d+PkqfLAxGVcmd?=
 =?us-ascii?Q?aHUPEg6Ik7ysGGgnKbkFyAp44trdT7kyV5dwloCoHo0bwdDR9YBvPMQNcY40?=
 =?us-ascii?Q?KpiERmjyTb/zlcGLvSM0qWWCGKcVjvjz1++kQ828Y0uNja5MVS+CGxPz2u91?=
 =?us-ascii?Q?FWgp6+L85XeaaRBUvmLc8T9pD8V8L0MF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:48:23.6301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2a9349-4121-4493-4161-08dcce590c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
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

The module param pcie_p2p should be checked for kfd p2p feature, so add it.

Fixes: a9b55f03989a ("drm/amdgpu: Take IOMMU remapping into account for p2p checks")
Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 61a189e30bcd..20910c0187c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6189,7 +6189,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		p2p_addressable = !(adev->gmc.aper_base & address_mask ||
 				     aper_limit & address_mask);
 	}
-	return is_large_bar && p2p_access && p2p_addressable;
+	return pcie_p2p && is_large_bar && p2p_access && p2p_addressable;
 #else
 	return false;
 #endif
-- 
2.34.1

