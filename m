Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F80C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D962D10E416;
	Mon, 23 Jun 2025 16:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PjO7eJs3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9094310E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qztXzY18Ve8mRFgYwtB/ErLI10WErlY+hNMB+mL4ypD0gKkDzsRg8YmJqx3DFWnXJnwAvnhLmhKrPnQJfsE7dM9w2sfQMDO1tNRDN2GXnXM6puyfCqroXFTLuvQ0bke0H+/ziYLGKSL1fkMGcP3Jf8vl9hpHiIKN90lRdWQpfuQoy5qmczReIZB8B0Fx7E6ZxgIzaPs5YnsJEU2p8Q72qnSfSvlpxMz2X1+S2tINpItMebMxkGIedylapzU+UkabCmB/EM5TRbXPrt44NEjFhhZb2Fd6AeUFK5C9YRENzOtFjZv3yTMaSmFo26IlTCvCZPqaldQIPqTj6pEijXOuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enal3lR9GDZFzVNviZnyUMkjAJoRegnKtpon7aLC8Zo=;
 b=o0shUED009p/6V6BPMge3qhCBeWR5jpT/0TLOk+Q1H7viqV+JLzX02tpEk0HtWs9Ho1fO5YbqryNyaNAkJ90XlmrACZ2ECzcaIS03S7UEie8oD+VDfJoislsu4fZA/iB1xpNImL+H6jGp2yinWdg8GNZ7mw/p3Ecc/LYtfqCjcIXvHy/zlxRZBQfMLsYbzFef85TVhzrQ12BEmCaI5AP1aUT/WZknz0Elxe6eySfn/c8370l4FKAbbo1ZeXLAUsXYVNe4sFd6pZrOnGzB3W1GDbjCVLhiSwo66vHzcfym1OY97kg2nn3BXJgac3WqIqoVT0UWJDRcrIS+b8HmDbq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enal3lR9GDZFzVNviZnyUMkjAJoRegnKtpon7aLC8Zo=;
 b=PjO7eJs3CtByrqU6SyAZBuB+TzsElsy+ujWEWt/twii8h48JhVLX6BzARgItSQmypuAX2Aa6aqDDEpmnlTZxMsLFLyCBP6k4izmq8cXwMs6eW9DOlO2/OfR3RXXU55TqgwX84SNv63Bjfq2kLj70D0CMovXxCqYA71k3B3bnTp0=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 16:15:09 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::d2) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 16:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 19/31] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:25 -0400
Message-ID: <20250623161438.124020-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: b853411a-219f-474d-1f74-08ddb2711fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vu3cjs5i/iw2mj8KqDsJiAAuAB1j3PYCPFk5grM2ceHXkFRbpG1JY7QAvFoc?=
 =?us-ascii?Q?0z0xnNHxvka8PZbAxyLRyEy2ROhdmxXWWbExnFK8mfsbFoB9rKD9cqmVipre?=
 =?us-ascii?Q?5X8g/iS86o0uuTPi7P3O1l0K/ohA8/l/0LDVSHfPhqDZISY1UI9m9gcvaJu2?=
 =?us-ascii?Q?1vHPLih1XR/CKYT0xm6a68C8VCc/kL0ansr5yzyX3guWkj5orP/oavR2+kxR?=
 =?us-ascii?Q?QDx9iScRagTTQ8r+p0ulXrwq4TJ781z3PXQmKv7JAZjgLBjl8xzM9iFmXhHg?=
 =?us-ascii?Q?c7Uf5TwqdO1EmIj+DksHwu44ePv16C5q36FtnauWqEeRLmPYN/R3F6rUfjHm?=
 =?us-ascii?Q?AnEyH5Otp6M0MTKbsgaSIWLmBxLA4PxM0npTcJ97Lir/xtqGmUc+19UcaplW?=
 =?us-ascii?Q?skURBRCUw/rIvGS0ZCYsbEidwnT0OiGM4FpfgLpXopisK4ExoFBdvoT0Cc1P?=
 =?us-ascii?Q?AxQf9mPV2AChd90Okn3uJs/kq/YIajDgFn+tSCOLSDkSetWnzefuq9bDKP+S?=
 =?us-ascii?Q?CLhJbHXugMFSj/FJLeMUL2n3jJEKbnLnFEdxuEr+qJl4YgErIH4e/Z9SLbUK?=
 =?us-ascii?Q?u2562Wxgo+M83xoy1gBGeof2qJWrekEPi5xYToUJDRf6fvMV8JIWiEiJkt3d?=
 =?us-ascii?Q?Q6YTf1wig+dEpL/PTRX3w+xJUXBSZ+cdHMtHhRfIwjXHnpVo3ZYIHCggj2ul?=
 =?us-ascii?Q?LoZ0GqLGYkBlnyKs/ZxSn6ryiYNxM/G/cqQWV/YMuiE0JzChhjhW7zEvY+7x?=
 =?us-ascii?Q?G0tIYHr+QxCsXRywVvl6kl5iN2uZHQLudqoSL1z71/D11pf6xiQuy8dOkNHW?=
 =?us-ascii?Q?wCF7kEGzg4pHgKRxZlwY4kP4RW4QzYRGtmaiLTg6bNbhF2Bwx1boZc4beaGQ?=
 =?us-ascii?Q?tWCFcvU1fOChWLhAl1LEIQ7GABhs3u/AjlnYVBL9/ZKiDSLCLiIurQym6FB4?=
 =?us-ascii?Q?tVoFx2Uzrm0xADMzcmhvNIeNn4Phg8gJUR4wnWyWtdgLOBCKVcFDZgA23LSa?=
 =?us-ascii?Q?zNNeptnvrqAlBFAyGjQ3UKaPR+K8lhBAXk/OuVWCvreIoUOzNgaSewNhY/es?=
 =?us-ascii?Q?F7heVLAqhWtjvxRvSVR3qOCC6EWvBevQcRmCTun8+DpbtEHLfi8JYADEpykk?=
 =?us-ascii?Q?pk8bROVdWWV2Idq2DPg3LcJnKcc8kadSF2H8lzhHUAnLMzFty4LMR7GHz2Dx?=
 =?us-ascii?Q?yxZ7LzXNFoPOgMq22+M3hCo9WUGId8zvdK1Yb3zqV0xugmtCcZhOpYCzvDkq?=
 =?us-ascii?Q?YhNkfYhhSvF5OMZEHQI9+fRZ1SEmfm2onKq/HFdWsG6K6icovHRIZRzx8VTZ?=
 =?us-ascii?Q?cbAPS+F28EH9zAiVTkxJYCAvaHqDfipV4/g2e7FlxmbpNpoYvXvogJj2mJYw?=
 =?us-ascii?Q?gQs9Jj2m93RylWKpWLwUU3nPB1cC0i5M1bNc33O9WY1nR2taFXODW7u6C0JJ?=
 =?us-ascii?Q?e6ZJtP3ZNbV7rueIfSv+5AKgE19/OielOeG0uXoeEMSruDdcDsR6T0SlwLYe?=
 =?us-ascii?Q?sfHeIv0K9XA3umv7Qf3WN6HeERhIaqFAOJqG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:09.2337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b853411a-219f-474d-1f74-08ddb2711fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 1d4edd77837d0..e9acbd5afbb7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -724,20 +724,13 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.49.0

