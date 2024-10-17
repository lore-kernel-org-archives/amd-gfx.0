Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2657D206BA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 08:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7756A10E13A;
	Thu, 17 Oct 2024 08:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c9MsOqb0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C87F10E13A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 08:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQCBvaWQzwWksGyOPlvncJeDFQZKU44L/KEBa5ZVY4KmfBLGc4prUibc9QPKS6wUYN6Z3Q4TXc6gc1wOssbbQFEoVBPSVqMZQujZfWMjtRdkBMVXqkDQP1LhoAO6Lq/YLzl4uc/H52NTcW3il8u+trODb+pZ6DJvnycr8saDA1fc7M7EUNnXGfojPnzd/eWwWaR9Gjz6aK1DFIVDznxHCngrTO+O6pXaxyS/GdgHd/cib6Ir1TI8p5Vjoj3Pwtf4M29aaOGbGj/Vy/zeXtNAYIXJqwsxhKaMRLe3Zil7wA8GfMHfwJq/jCRT1MjTDNYeuX0GFTfAGnOGmnxaP60Gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va8XaLzm1bfzmTgJnp4URQqTJK/RQhSBM2+UOpbkdJk=;
 b=m6gZaNINGEKh+Y631OVky9H7NOnPvjwN09MjwSHdpeOaIxaHLzMtvnbPUm51T1RpWhvXzknQ57yE6zwXeRtInJmns/XHSlBrz+JoRfDpkriDaEm1VepfUbaLCFSd+AL/JvN5S0ppAu5hwFSS19n4KRMNrx9fCulQH2rGisJBzmyiYxPT4UueoPc6V7z1prR5B8O2Mjb3KMCMwFpWY0hZZw2sGmMUu21QVVPshoOprYL80z9bRDSG/R0U/vNMan76hlSTNwq/Ucsc/Q7gY56UXaffqji2ra1w1UPQsN1maEUUfWu4L9tJOwq3daz+G8HbSpAKxBUzxDXMf0GNIJ0eEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va8XaLzm1bfzmTgJnp4URQqTJK/RQhSBM2+UOpbkdJk=;
 b=c9MsOqb04ikA1UzCzVk7jMulzLa0h8oFDNB+R/h8/Ne6oYqxfzVEB+vX7seUtryXX0LTgHrOMlgzkF31miV1+Vi6pkz4EsLYJGNyjW7lVqJSUfEImEn17xZeNeqDTkak9Gk8sH2ACdIhLkAIS71edLfzrNQszoCDnmmIViXS1Ko=
Received: from CH2PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:4e::13)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 08:35:11 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::a) by CH2PR02CA0003.outlook.office365.com
 (2603:10b6:610:4e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 08:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 08:35:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 03:35:10 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 17 Oct 2024 03:35:09 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
Date: Thu, 17 Oct 2024 16:34:57 +0800
Message-ID: <20241017083457.183631-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 48244dff-fafd-42eb-47e5-08dcee869da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2NY7dn9635uFiBgzioDpOw3shVZIRe9EgGWj5R5r4SyLTKEyZty7ZUDGbY0J?=
 =?us-ascii?Q?PuZWF22qNvH4eTBWn7W6RX4XhzM68EwDENJJOWwy6NwCliX9ygcWall8rWeg?=
 =?us-ascii?Q?RHsTlOkh+vC3zhdYzunbn5dz2QsAAZUpIHIgMr79vcGKoQ/iFSHrP82/hnK+?=
 =?us-ascii?Q?RENzwXCqEKwoU++TxfVRwHki8a0WlxcMVU0dvvxhl60TKFqcqdTen8JeDBqB?=
 =?us-ascii?Q?WMQJhSrbPfyW6SfMXsSvzGDrXMAgDUU5fuPfBMWAuRsZ02LfA/IxafO1B4Lg?=
 =?us-ascii?Q?r1BI3Kg4yph8lSUJgIs1RC790jg+aQzkEH6i5cpNWF06JJE1qF6wTtHv2pWF?=
 =?us-ascii?Q?Dhy+Qzai9Esl6XCb1QcAseTMYxm2evYCf/Fp7gY/ai1tiX5P6Ph4Fpc63/5r?=
 =?us-ascii?Q?y0fiTA9pj7/UC5OCyGIIhfYpsjslcWmRYtW5VfwfizGHyc65ZVBzeeP1HHaY?=
 =?us-ascii?Q?lVXtdz2j2dSikpQjvraYCiSORdl2k0KJmp+yqmYika1aOy9drA5q6+thsGvU?=
 =?us-ascii?Q?oXRwwm1LQZTUSmtZAc0GmXV7cZxAFepXlk/A4iXtobr3e1phtD+FGwBoURbQ?=
 =?us-ascii?Q?7V6qz60ZToZ6TfedtfF9VFb6KPNScObRdpFPMLRAZkNw+sOs2OA13xXQ53rp?=
 =?us-ascii?Q?FY9hKW2nlQpv3bRkEyReiJL9m3ADTnDgI8PNR9mZod3E49LBqsTlxPo6rjHk?=
 =?us-ascii?Q?XxV0BUNmRM2rWZs4dN74KJ8vvGloBLzGB1IWuoed4b0Miafkj/aqYTaxzYft?=
 =?us-ascii?Q?erjtlSlLcgxHTiRoYJOTS7ktbR08S+2xpsN8MAEF8fHakHC5YR8+1vx20cBp?=
 =?us-ascii?Q?FoRhtQOE1NmO9qFmeV3lritY6Fohql7USe6Z7/dz4y+f4Ap35STDx+MPGVSb?=
 =?us-ascii?Q?4PhIAtpjWk9dGr8Ra+zAWJtboruRmm3w5lRGkcCqZFddqcLRA+bKwQ7i/HiR?=
 =?us-ascii?Q?1GvpJSC9J7/G0yGxiyE04YL3NBVl4tYyskRis13MVyta77/oaKMoW8bSLAvY?=
 =?us-ascii?Q?IJlSwBv4khjrfqyqP99nzkS10Me18FiScvo4H4DQBAjf+tTqZAcT+7sQ+zz0?=
 =?us-ascii?Q?AS2h0Y3QiTUnSChKP29j7MqgT3WhlojLvcKbPH98xb4LpUeGNgPVugmdn4LD?=
 =?us-ascii?Q?N+CaE2DBGOnetEDJxX1bEc9cuMw+viKNqIRT4eEsBhy2x/AMu3Z492zMGTkC?=
 =?us-ascii?Q?B0mV1Gg54uLR4PlVvKl2mADwNZpxIO8LftMCOJQO4A8D/v7CveqSn3Zqb1d4?=
 =?us-ascii?Q?zUgo5ZHanHmk0B17uZc+0awmhdAS1jpVpLJ1H3pmkmeB8YyiEc9AoQ3pfEYP?=
 =?us-ascii?Q?VI3WN9IqqkntdPoe/2nuVFvnoTJK1iBtwZ2s6kBwGzJ9b5dsK5D5S3TesFHJ?=
 =?us-ascii?Q?MkMBr4EC6EaIdHmBNBDTp2WSAwthxJCDDlhIfNHp0ByOfUnsRw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:35:11.6360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48244dff-fafd-42eb-47e5-08dcee869da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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

make sure KFD_FENCE_INIT write to fence_addr before pm_send_query_status
called, to avoid qcm fence timeout caused by incorrect ordering.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..d9264a353775 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2254,6 +2254,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		goto out;
 
 	*dqm->fence_addr = KFD_FENCE_INIT;
+	mb();
 	pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
 				KFD_FENCE_COMPLETED);
 	/* should be timed out */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..bddb169bb301 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -260,7 +260,7 @@ struct device_queue_manager {
 	uint16_t		vmid_pasid[VMID_NUM];
 	uint64_t		pipelines_addr;
 	uint64_t		fence_gpu_addr;
-	uint64_t		*fence_addr;
+	volatile uint64_t	*fence_addr;
 	struct kfd_mem_obj	*fence_mem;
 	bool			active_runlist;
 	int			sched_policy;
-- 
2.34.1

