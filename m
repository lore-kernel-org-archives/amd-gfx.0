Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C026ECCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CD310E82B;
	Thu,  2 Oct 2025 17:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LefYtde3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44DE10E826
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb16oCCCvACkoWsBvlcVBYlX6mcTifPSsYXl3lG70E1C3TxCR2JJRHh+WpBQzcEDslrNNecB85IhrzzjMdfifrxf+FXUdpXzBRi5L5NuPxB2z5APDKn8zXBZD1gOvo2GjD3TUwK0l7totHUqPiiBI+rL8uY+a8iYnO5Tf/PtMLZG7LIH1ueYzB1OIyraZn7m2tlF0/tX+INTsw3tJmtBxjIn4/hxZkE0BWGDjqgXgJUymijDf5cSD0tImT632roqEBR2L2xQjRy/jhzck7M5WPFXuJI8lLYuTXT8a4sGKV5emKVLzbdk8NhnuyHxYElWwwPDyJb2jMLYS/cbJnq3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xygWJz7RXFKHANrEmQbg8krLPsEhkWv715jCvIwaTL0=;
 b=ZoUkOLj/f6JjRDAG02dZep2e0kX5M5u9G/EkRon9oqj+p1OEteP//he4E8/gPZEbxoLnqJgmWD9U2nrW7S+EFEWpBdJtyWCOGPw0VrKepi7iiI6j7OkGN6jOmUyNqb4v53BvDn2uAaSS2wg1L4gmjBIdlRFNVva5cj/9ObCOcO7skiLU3UNUTR3dsnXRhIllvhAkeV1BMpieXA9TAst6f+NsaaZfwLivWf/UUHMkZQ7eQuofA90ZGWfCYqEweki/J0XWA4EzGOe1FEEamMTKxNXYb/JHeHQ0A4EJqDGA0ZmhqPm9ukLMQT/+PSaxA7cAMWcH7zL5A0lkrybyukOlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xygWJz7RXFKHANrEmQbg8krLPsEhkWv715jCvIwaTL0=;
 b=LefYtde3UtyxIUf1/Qxqtvm7/P2Aef5Im4PzGSVMRJIjMhNHbbxzocDUffFCG4t2M5mLqs3r0U91mRJn6TjdJrjLZkDcuc8lpIZaB4ENKQNaPXSgCBOc2D2RNmCD3nrFqbPD+ByuddTMb5opNYLYRr/9x8DiY6DA28qRq6PdRPg=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:43:56 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::16) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:56 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:50 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amd: Fix error handling with multiple userq IDRs
Date: Thu, 2 Oct 2025 12:42:44 -0500
Message-ID: <20251002174245.1691343-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: e9db76de-9b40-4ce4-b6c0-08de01db42ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tW5/n1+Rp3uGmM2bAa4R8QzA0J6DbblAnDXEoBtFbcZRG9RC+UF+3aNEXzSr?=
 =?us-ascii?Q?04H3h+/G+pRX26t4YP4Z5qrGa4jhmHRoMXwitmsXLV6sGjQTJBtj9vvBCQko?=
 =?us-ascii?Q?M3N1Vzr1B3agsqV2bKTDLhRNWO0v/vh/GCOy4WiDVuveu1XU63/8e0vK0MSs?=
 =?us-ascii?Q?FeRSGTlCHVUnTqx0+X4129NoUyHfEpaF/sDLI1oj32UY0gBD0yOsZyoNe1NK?=
 =?us-ascii?Q?NqSaaL40vXszPNvz0UeNjP4ZS4CpQ6bPo3uzjtSQmg6r3z2Ji95rfFkF4oyN?=
 =?us-ascii?Q?Y+8VSfKhtOE6uC1Jrdv7vBAV+/k4Se7GWN7z0qrOGwSXAqi1JBkkjmABmDoh?=
 =?us-ascii?Q?oGaWPVBJAU23a/WhDxmdScCNhKH7+oUcoep3RIZTlRxe366CKN0MgUjzQS2X?=
 =?us-ascii?Q?79WPuDuIaQlPlrRC8vnPmg7oB1M76BU188srmAP0shMqRINz1LWHFRl767gD?=
 =?us-ascii?Q?X3BNsf4G5DTaJIi5xrIRjQu97FS2RYqjZ45HNTjCDadZBw5n7jPF7k87HDRn?=
 =?us-ascii?Q?Xip6V4LA5gUo8TmCFETMcbBfA84OacZTkj6nlEeW29gc8R4g/dAaR3ZNkGee?=
 =?us-ascii?Q?nrYRpF24XXzCYW3xknR+//n30HdRrB8nCGWKPRX2YO0HFae6/1V/qxPbhCcu?=
 =?us-ascii?Q?T+XzQEppMjYp/s6TSi0mGkaiGRXD5OZqQQlAHldjgIN8gSWtRNgHPogTEoLm?=
 =?us-ascii?Q?6DTDPb5s2A97i8wgsB0XnWgS/dYsyCRlb39lWc06/stLtw2fFZat1Rhg+Goc?=
 =?us-ascii?Q?WjFxw0aeXeEOzSe4uTe9BX/0KVTfWpjqbDBOcngQ9IldRt095B/8aX0hYrO6?=
 =?us-ascii?Q?Mwfd2uJZyFLA4pOI0cJakhbl8F7nVRJsnaxXH5pkp+aSj9irMgq4Der7cz3L?=
 =?us-ascii?Q?cqeVspnd/3giUSTWY+Xa6YJVHnOiArJ2dB4qR2niqtzolNGhj+gs/uT10K2Z?=
 =?us-ascii?Q?52bkMwOSAY9BCUxDwFzDe3+OhnHnKFV5rVbi2NgT0qz1TEB5cDYEO3aMIYdX?=
 =?us-ascii?Q?WE8TtT9XCZwGxxxYZAlcpJ+brmcS7OL/Nz/BxXIA8hrcS3oe7TBa8nX6VQ9y?=
 =?us-ascii?Q?DKpMK5NN5vKCXmYFpT7YSxKOaAjnGzucHezF5KBPjzAEP2Z+bBDPGgGUVueR?=
 =?us-ascii?Q?lUq+yV5fWXle/hamiCCIWZo916+dths8eKXGRFN4hNLANjO0mJrbgYfW/cT9?=
 =?us-ascii?Q?HP64Nwgil+lxnwmdLfaFncYZ7k0E+0+mLMdPE0Xx+WLInWgfgzaqL2/nhjVZ?=
 =?us-ascii?Q?IN+kTbGklRIAw3aQ8yLvWBHjWBl16tvD/xvFJ167W25ZL8CS8E6/f01Rd+Aj?=
 =?us-ascii?Q?/6HHiYHGJLMc3ausTU7bYq6VVCh9B15fvfKFIAPDDK5Y12882oYm3ALnu6o0?=
 =?us-ascii?Q?kYiygWyF/AFWHcgdy6pbricFNx6p0alUU1FjB65ki2bUYSb0dv+vLwpZGaEL?=
 =?us-ascii?Q?tuchPM3HW8kKlAOejrVMNy7WHgP1cmc43aJJALbtC14/sX+ikP3VfjGxhucY?=
 =?us-ascii?Q?+gbeD0EGQaPc2o8W36v7wjMk8UJt/8uUDbSESas14wA30ow+REAfJghfRKaq?=
 =?us-ascii?Q?s6JwdZk2xtSB7B7aMfU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:56.4097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9db76de-9b40-4ce4-b6c0-08de01db42ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

If multiple userq IDR are in use and there is an error handling one
at suspend or resume it will be silently discarded.
Switch the suspend/resume() code to use guards and return immediately.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 25 ++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3bbe1001fda1..1e9358c70f26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -967,27 +967,25 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
-	int ret = 0, r;
+	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
+	guard(mutex)(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
-		mutex_lock(&uqm->userq_mutex);
+		guard(mutex)(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (adev->in_s0ix)
 				r = amdgpu_userq_preempt_helper(uqm, queue);
 			else
 				r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
-				ret = r;
+				return r;
 		}
-		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
-	return ret;
+	return 0;
 }
 
 int amdgpu_userq_resume(struct amdgpu_device *adev)
@@ -996,26 +994,25 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
-	int ret = 0, r;
+	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
+	guard(mutex)(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		mutex_lock(&uqm->userq_mutex);
+		guard(mutex)(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (adev->in_s0ix)
 				r = amdgpu_userq_restore_helper(uqm, queue);
 			else
 				r = amdgpu_userq_map_helper(uqm, queue);
 			if (r)
-				ret = r;
+				return r;
 		}
-		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
-	return ret;
+
+	return 0;
 }
 
 int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
-- 
2.51.0

