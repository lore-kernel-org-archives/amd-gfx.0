Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D7C5B555
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 07:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B2F10E034;
	Wed,  4 Jun 2025 07:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFlnrMfa";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F73410E034
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 07:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw2nrzBwByD6TObfS4PBDUdS5SB48SEdaOVE7WAvFzNfw3WUNc/ZQwRyFqbkAvA3rJRLLmmAeXMdBilukI2wHd/9PVlqGl65fLV/pU0b4tTTxOeFSfNsWNqAZRMsiAefi7LdwxFOAjZxW6xaMgjVkc/Xwwsb75lBpAVnIKD8A89IWJepA6ZIyIC7MUjO/CV4cjnFo306OqZrUiWuPrf6RdgWxGJgURkxOEO9FqyPCca9Xp9h5uReAb9UWDrWYUUDOvJjoQxQOkrWZaR6PBVcogu+dzaB002LZBzxH9x3fUKUXi7fPcytiQYET9zWy4B1rG9kb+RupByoDTzekxdtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOckcAMMVbaEvnMkd5ykvE+eV47wiTsSn6aAj/J5IXc=;
 b=y2zu9NuOxN02I5e5IoAm+bzEkmakxKP0An7gYF4SZZv96SKO9gSW0VLesP21h5W0ZPh0RYNt3L5GD7b+jfsNUxL30YIyqsOkmeK7ndMzAdOIvNKlm+DU3DRqbBIfsE6sab5vV+DYXf40+f1IVYfxuYEbDxIXEqaE1YvnrOwmy5W3dZ1R0aFmjWzBl7vX3teUm7mi+lqedapc/V3nLcpxP7+0Nsd/gTNfZ92ijVjPHsCLSEjhja0EuqAO/ElebbCdb52t0gw1G2H0/PFfc/MCwVng+yaHHx9s/YwO50gDWp7qyBYmsGtLD+RMFl6OY0DgGcGFCdpaVV0wIRz3hjcCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOckcAMMVbaEvnMkd5ykvE+eV47wiTsSn6aAj/J5IXc=;
 b=HFlnrMfa7kzxReA9dt1kNweDEmOYL5i5p4dbFNlJSlB2RH8J9dlwiXsNjZCce2cHWkxQa6FCaGW5Gza1mZx+EmyG4S27mOaNUkRIJLLsfs3rj+LBhhSoS1mYm+XztccN3mBRukJPcylHhWwADj71+0OHgbu6KqvanYvEzcp4oZg=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 07:48:15 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::b3) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 07:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 07:48:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 02:48:13 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Jun 2025 02:48:11 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <andrey.grodzovsky@amd.com>,
 <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
CC: <Horace.Chen@amd.com>, <emily.deng@amd.com>, <yunxiang.li@amd.com>,
 <zhenguo.yin@amd.com>, Yifan Zha <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Lock reset domain when VF get host FLR work
 message
Date: Wed, 4 Jun 2025 15:47:17 +0800
Message-ID: <20250604074715.2229924-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Yifan.Zha@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 1741f036-948a-4ba0-5d44-08dda33c29a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvERKcUsKaPM1uGdn1maj8xER2MJUT+UbvWuMxefOj541tH6EeawJQzERRdE?=
 =?us-ascii?Q?7FhElyHFoXK3Gg4+RkkpZW3SJ2xty6TEKpqkfUovQLPLVFJKI5PYQ2z18TUm?=
 =?us-ascii?Q?fR7Axa7+XdWd1RYgMWn3IBsBX/em3MZw2TsnUHJ5McWTYkFKoUK7PKkGseLO?=
 =?us-ascii?Q?rBGUAJp1EuusfrMYZbQmXaRamidHeZHtXqdDGT4XHaEzYyMok0Tpq63KrkzD?=
 =?us-ascii?Q?oTUbpAlb0h6oyDTFAxSKO28bnIocadhQ6HoDEzMdR4rPbKGTY36aRBxQRxTJ?=
 =?us-ascii?Q?rvUxVqi3ugmlaL87Xq3l/Vx32XkDz40a2cUb0JpP6jhgPfZw8usTpOHeTmsv?=
 =?us-ascii?Q?bIWJ+Igx5FHWkZNb5nsrCCNVHg7Xcl6cxs1bzMEIIe6uGDInOQnqbXvEa1bv?=
 =?us-ascii?Q?g4Opj1OzRMNTpcr3uVwx0MfPnV9/aUzndDW8NSYI4HMjbxqF5sqDmpM5jdXP?=
 =?us-ascii?Q?eFG8PCRbD4u3DQe3RS+QPToLrLPa5Hzg/Avheu/0Ho4fX9shOVSaUpUOGVyK?=
 =?us-ascii?Q?UN8WwXHHEPtnG9s39sCGzO/O0CfLCctRjRtnpWzWJurErtUVqayDE/fCiA70?=
 =?us-ascii?Q?UKRDLDFMGvFAu08Vr0Hm9eygPrSTlp6xd7thK0v66Gtmqhql2DeHBo2n2FbF?=
 =?us-ascii?Q?SJkBHLjx3ey+IW8XKzr5G8eQaC1v8wVNcfDG+j8TzeGkEBRcEB5hrs0APunI?=
 =?us-ascii?Q?cF62cqrCz+/f4/jELWU2T0t196FKhL2PRLWUnQwR1el9hNMi/vBVxgoBKfAd?=
 =?us-ascii?Q?FzGTlda2Hhu2v8thfzshQqaUXdXpbtHE3CPPx3+IedkQdxmQLhHgFZJaJObL?=
 =?us-ascii?Q?inOQCaiir9rdDPDRwPLVZDC7T3skaZDflnFuhnO9XDIeJ+urtv54/v1NTxrw?=
 =?us-ascii?Q?+W+DnHYJSW3MJqMEaNOLuUdnXRRn3L9NVRnJM/81GRocDTixTTmg3aApoSEJ?=
 =?us-ascii?Q?x+FKw3Y7kaeYKYZV437ehXPCpgivlI9fkDiasPou4CxjcgXCKngkIBN5o5KI?=
 =?us-ascii?Q?TTzJ+NjgQxd1YNCJvIj8W/Nf5yKkCTs7UJhuX2hmuMROtQJKcZ9SXwEQMGZ6?=
 =?us-ascii?Q?eKIBNInhRyBA4pNUR3lfJzNWFx8tD216gD0b6sPcjzcfm5gOZKjblbcK3q/c?=
 =?us-ascii?Q?qowRQxJg/VsgkrDFDxSKLus8vKoXHFU6NdnZ+zr/n1rnTHvlJ1jx169d7pCe?=
 =?us-ascii?Q?YS6DMz0qs2pzRa3Uoi74QsoA7rktJByYF0+ayLAhoe8UkXT0p/LPiFqvxf5x?=
 =?us-ascii?Q?VPvBDOMEQ6WHQEXDHrka38ElO1RcbomCvwmLjO0Es+AiJap2urDAW6WQTKaz?=
 =?us-ascii?Q?078jj5kq85iO8cVz5yaUPQ+OcW9jtOAFU1q1uNh3YL73EJgk0VAGtLFh6Uhs?=
 =?us-ascii?Q?nmR43pJlcfZsUAeaAhsnLeyzUNtLmTbAQPjn1E0Os/iartfiDceWxEaNZl/C?=
 =?us-ascii?Q?Bp5Hsz5mlkA5zXoRxxd3rGMpqMEg2GW5ZSMfah4DTP6xjRf4andFSh0qDoxG?=
 =?us-ascii?Q?K24q4SFw0gEkstKl16F7RibfgMkQ1Ctp8u2Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 07:48:14.7498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1741f036-948a-4ba0-5d44-08dda33c29a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
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

[Why]
When host detected FLR earlier than guest, it will do HW reset.
Under multi process scenario, MES could use hardware resource and failed,
if host complete FLR work.

[How]
- Lock reset domain in *mailbox_flr_work
- Use AMDGPU_HOST_FLR flag checking in gpu recover to aviod double locking
- Clear AMDGPU_HOST_FLR bit after recovery completes

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 4 ++++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e64969d576a6..d59053a2a7e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5413,7 +5413,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		if (!amdgpu_ras_get_fed_status(adev))
 			amdgpu_virt_ready_to_reset(adev);
 		amdgpu_virt_wait_reset(adev);
-		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	} else {
 		r = amdgpu_virt_reset_gpu(adev);
@@ -6098,7 +6097,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
-	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+	if (!test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
+		amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
@@ -6293,7 +6293,8 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 
 	tmp_adev = list_first_entry(device_list, struct amdgpu_device,
 					    reset_list);
-	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
+	if (!test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
+		amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 48101a34e049..f16449fbbc5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -287,8 +287,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index f6d8597452ed..15e6e7cdd1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -354,8 +354,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index e1d63bed84bf..c1b32081e7ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -524,8 +524,12 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		clear_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 	}
 }
 
-- 
2.25.1

