Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEF4D14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7FF10E687;
	Thu,  8 Jan 2026 04:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KM+VzSd1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBA310E688
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wnfuw1radMu0/+xtvlrRsmOygzetDKr5JAlsr4daEQItzid2wgD56zkCJN3WuN9MmlowsP6yQSm7r3uETEzAYa/3HHisvLNGLRTYzy65irtr0Ap5eD1WV7QiKdJVxtBsrh4T7VaugjCTkb+vgxfaB81xfjWe2nB5Gx0zHeJhD2EuJb7lY4dkp3Nqv5BfNORt+t1lzN+8dcCnI0Tt/Q2VBp1dgDwt+29vMLW8u1L+hEYrbrSyO+8WMw6JgwqPrJ63IvtkAf8QInTungFcBG+Pm8Xzbq7O6eUllyT628t3fhgiGFd3kWOOIjzrU3lMjqTRuAOXEeomjswpgkgFpsXV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntIiPhXG8tzcGr8+iIhL4qtzZCeZdaaPtsNVBiN9cpQ=;
 b=J0CLzMFD4hTO7m0at4kvFb3JYoVSfD67Rr7zv1lGUsbw3c0+NVocwYm+iREurwejyRLmsLTrZSD6PyMGampTKatig9yHfUIFpIoJazZz/0dX4OZupO4Tbh89PJS3xGYw/bZU+QzC+w2r8Rrm26Wh45EKLbAOOSZVR9JrHO0GxN20bzOhRt9TxQstXznfSeke15cJiCVFLnZvOF7ejx+/FmzPjWbsxvc6w5cU8w4/MHcjf8M2HV2F+//qUo7OvEa664wE+5h9/Zis5SUIzwfeLyo95zZFLNTNo7ijL83991iuUz7qmbfPsxlmpRDFrY7Y8HurnDhiJWoFeYF7NjTfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntIiPhXG8tzcGr8+iIhL4qtzZCeZdaaPtsNVBiN9cpQ=;
 b=KM+VzSd1Y/opu8cJmJA1EV3T7KSRZTxVrCUmyuIisyMUKLxb7A7SwgEzez2yiywXc1bnIPDqsWkGHrbXPfc7W+gXe8lLe8UtcCkRmSRXZSBxCeLhC/DObboLV+U+qgyvNC5yhEeozOvOjgn9nW8cOVFVe2W+zQuQGwomjZmSGKE=
Received: from CH0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:610:33::32)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:50 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::6e) by CH0PR08CA0027.outlook.office365.com
 (2603:10b6:610:33::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 16/24] drm/amd/pm: Drop legacy message related fields
Date: Thu, 8 Jan 2026 10:17:32 +0530
Message-ID: <20260108044839.4084279-17-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e9cd2f-882e-465b-5643-08de4e715b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ofgu2bcUDB3RGuewVdFMXMa6hemUKUZSoyB3/WCMqaL5PxfTwhJIvrctqm7Z?=
 =?us-ascii?Q?5YuazAKBBJzu1ZuX0G9QoS9s7fxCzi0MgNAeFttzP8uGBL2mc+e+KCCLRUsZ?=
 =?us-ascii?Q?wIEh7s9IovrqcW6OwzhZtexWjX2tFjwHkx9yqyqz40T4wtTMbhfue1Xz9/5f?=
 =?us-ascii?Q?9S0oznBl2mG0kDRixCvlHb4PVFvX7LtrHRmZgmmkJaI+3jK+CdR9zJi91Kz5?=
 =?us-ascii?Q?azCeDg2/RaPwAyC+2ZLiKR9BplwnYELVGhGnJxvn+ajBk3pZsfRaY9EbN8TF?=
 =?us-ascii?Q?klYpNZUZnLfqEHtwlxbsjDGXCgo0+6HfTSJGWCTPf4dkXyto72vNtUjdxY7S?=
 =?us-ascii?Q?CsH1iRXevPxD+rvNCrKu62DYtozjJlfU4EP+eAnxWNmSjl57D7kETvgNz64w?=
 =?us-ascii?Q?fquerRxrCltLGWBeVEhs86Jaal+zGSEmdNNtUkeE8m0b54Yy51NX4kr72SAo?=
 =?us-ascii?Q?tW9DjG/u8C3NBxSTAlwlEN6KROeMJ27djpQUqzJWrVNV495my+qOkdztA6Nl?=
 =?us-ascii?Q?BBIf++kOKoAnzFM9Vk1Tv6JkAxiOjzeZLTFvF+DJa/ErCAJ6HeaTHTnGjHxU?=
 =?us-ascii?Q?z4TSEYulGA5x8mTnpv5kKEBRutWv8vxwsXnQ+Vacf+HGQAZOpYwXzZoELJaD?=
 =?us-ascii?Q?/TlZ8YjkzSos1Qns+Zrk9iwG1Qau9JMYoEvTpoLgQMCs11N8ji5fgPShHCBu?=
 =?us-ascii?Q?GL2MouUe5mje8tX+lT1jZn926l+f5vp81gPAxOhlE8JqRw7o4WrFEg5yYaas?=
 =?us-ascii?Q?qnQynjzxrYI8szqf0MyWCq1V3rOtbOcxQP6izVz5lJ7JENIh865WBYRGAeQG?=
 =?us-ascii?Q?U955wFo2CKqE0qG0M+5ffMSKyghXvA2PL6KwEDUt2XAwGX1/I2saTulV5NAB?=
 =?us-ascii?Q?Axamlkeum0EZOpQ3L9+ZUe4OT18BFJAbORtRrIqKsetZHH6QIr1MbW+J5VWq?=
 =?us-ascii?Q?brIbl9guWzfAkZJb+EPd0EFQF95mLuA1NeNSx3WbOs+0HIi4+6fqq4qjxWhR?=
 =?us-ascii?Q?+/A6S0QZ91mZY6GgXrGXPn1Mk6h3l4m6poeJgFjUNzes92r45AnOHv6/7YOV?=
 =?us-ascii?Q?FHr6jr4VpCZrA3GAv4WaO0/LzHXqQNo9QKKN58MpewnJ7vEfmsN4Ip8QPUEZ?=
 =?us-ascii?Q?beO0yhDcuFs/50VbSzwjNv0jbVhZKEfI3llmG1ynOtXNcHicXR85KGH3hzi9?=
 =?us-ascii?Q?cu/8vWMe/U7FxADNNvwEdTiR5SjGc73aYxCb+f39a5F6Pv6q1yPYgC5rPvPQ?=
 =?us-ascii?Q?k6VQoUslzCnpqhYNphhTA8HXAs1xOY/qPHW+eAGHiVnv+ShWtBgHQ46PssfZ?=
 =?us-ascii?Q?5Gf1mzSbyXz6oJOovDhXGrgHqT7k1K0l93IEr3Mu06XbISxW+IVE5O/IcGYS?=
 =?us-ascii?Q?Pu7t7fJxnHJmL5V5urc7LH7bBBacB7iVjQE823479p3I518vDLYghbHWaHnP?=
 =?us-ascii?Q?v9ZGDflK6xdVHsBYtpCdxOBHkliLzS0xme7fEpw2mXkvA3Tpdvvp4CmGE8iS?=
 =?us-ascii?Q?n4G3tGrSfq8tZwUtVrEWBBF4OXdjjS/nPAy1LbbI0sLYcKz6THM1hCSGBFr7?=
 =?us-ascii?Q?RMn7GQO+GQL7h0OMR08=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:50.3638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e9cd2f-882e-465b-5643-08de4e715b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
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

Remove legacy message related fields from smu context.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 2 --
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8284f74b6c54..6b6b05e8f736 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -826,8 +826,6 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->user_dpm_profile.fan_mode = -1;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_UNKNOWN;
 
-	mutex_init(&smu->message_lock);
-
 	adev->powerplay.pp_handle = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3b2937c07cad..9e0c8ed67e73 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -655,13 +655,11 @@ struct smu_context {
 	struct amdgpu_irq_src		irq_source;
 
 	const struct pptable_funcs	*ppt_funcs;
-	const struct cmn2asic_msg_mapping	*message_map;
 	const struct cmn2asic_mapping	*clock_map;
 	const struct cmn2asic_mapping	*feature_map;
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			message_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
@@ -745,10 +743,6 @@ struct smu_context {
 
 	struct firmware pptable_firmware;
 
-	u32 param_reg;
-	u32 msg_reg;
-	u32 resp_reg;
-
 	u32 debug_param_reg;
 	u32 debug_msg_reg;
 	u32 debug_resp_reg;
-- 
2.49.0

