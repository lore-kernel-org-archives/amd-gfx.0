Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B23C35FF3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F6C10E8CE;
	Thu, 13 Mar 2025 14:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbBav02s";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9312110E8BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxFN461ijzD/n+WemWB1gdN9qmnt3A7s+6ocg77PCTqnjqdL7Xltrd9wV8OpbLxD9kyDAyJOZcaY+WpyiTo7evmvFvHidSdqmNYo2D/nEow1PrtHIj6BnvrcF4wNbYUFdMrNQ4HgCeIQJsJEJr/yYJi/nAskcHrdvpX2JqGBlPYdUNZ3hY+o0/EzErzumCfQ2cEC2+3EOI70Gwb0L6xsHMxEv0Jg6Bi3K0m35Lz21Gyj1me+xRDb/4IWG8IrmyZw1+jWAglnUHsme60uejas5xGbWnHmlCFQPJb5Gm6WPklInqcwxjt/9/oD59dRCdM60JVv7z/7Uv1tlxfvoJrnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJY33nfiG9+o9C1TNMaqR2hxL5OZXNCjoZxYy9LZOM4=;
 b=q0b8ONTBBKO77TvCWSxusqUFaqkOJCIePokY+HKM30LDqlNPOgOgHJWn8/WZbmZs2wv1bii0ARBEussWD21dOBsqdMqGSL+CoB8B66K+WiLPTspiQcfqUHP8vbOop3G9alXnKb9jQhtbyzy7pcAo1FazlonL3ipipOHC0UeZjJFu0WTsfuN5g8Pkbo0aICFdDVa/+YSQrn/04SuEZph3SExLuFG914cc9b6VH4IaqZBGDjjdTkR6RLSBosVCl8JEKJWCgfJizli/5eiGYK3sxbGkrJpyUA3Vx7C7UBFvbTtRxqlkczbkbZuBASMmCIecGRLeqiRN2I3EXM7s/fCeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJY33nfiG9+o9C1TNMaqR2hxL5OZXNCjoZxYy9LZOM4=;
 b=dbBav02s79hKRtVgcZlQiJcCgEv6eVFzTQivqavE7jgMuNHgOa6CBa1xQuBvcNGp084OrDnbKAo/dqMXhTUsnoad0WLkSkts4KRaogAqTnKOD3/NUYdUpX3B5LyeQyUF1wq3BOnEYle0R7DqIrXb1/KnsLEbtoWhHLKDNHm12R0=
Received: from BL1PR13CA0360.namprd13.prod.outlook.com (2603:10b6:208:2c6::35)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Thu, 13 Mar
 2025 14:41:57 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::96) by BL1PR13CA0360.outlook.office365.com
 (2603:10b6:208:2c6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Thu,
 13 Mar 2025 14:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
Date: Thu, 13 Mar 2025 10:41:31 -0400
Message-ID: <20250313144136.1117072-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a0681f-00f3-4404-9e4e-08dd623d34a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zm30J8nPlepL4vn/80rx3fUC5B/M8KD+l2RtL6GIvD/HD5ZmNedAsYcQF87i?=
 =?us-ascii?Q?0kNh5ZgWUGMn5/boNp2METke93w3ZYfj0Z384SwPB1ZXNxUrIp7VS/IhN3Tm?=
 =?us-ascii?Q?MGTnNOkAxPZX7YwK+6Jv4gGEuUzi8h2s10tcmNjPQYL5rgb8vVMYusHORYUW?=
 =?us-ascii?Q?LtZa2Ad83G5TSe3ELisUvy33WTjgtUCh5vSMZSt0w2YM6xW95dPTcxWukhcC?=
 =?us-ascii?Q?S3i5FoSYjzlfSTWEyi7rPB5Y39+Ob09LinYXnOps4kLiNZb32Iy8sigd+1n6?=
 =?us-ascii?Q?k7oHNAEdim3vnR4zf2bHwuUmY2PdussBhHZx6cJ8zb1mSD6SNfPK0LxPP2UR?=
 =?us-ascii?Q?Cvo3JNq/yn8C6wasWvk4NRi/w3O6O5Rhbhb1m+NniQBZKlmZXBCE811pVQjA?=
 =?us-ascii?Q?QWYDL1o8d0Z4JthbaOcxAkeUM0aDy4arCTRfpgL/vCEe37iRjxkG8UYbidQa?=
 =?us-ascii?Q?h2emhF1Kk2d9HFDSjH9e6R3o+/Lyelz9XmTjZuUaofKP9v+JMGGfAZjgWP4H?=
 =?us-ascii?Q?m0elFUStj9nUZRYUfKlzoCzkzvsB+vkeiRUlnaFzKFqjZYtrUGyy7rULacW0?=
 =?us-ascii?Q?qpByrGX4eJ9V9Vd5ZHV+Mj6qUuIpGz42ETmnAQkn3f1bKQ5B77J9xAY17Icr?=
 =?us-ascii?Q?vH8wJ+NYK530I65BYa+9BNgoJGI55BEldMHmyhC3ktN6X7ID3gDnN8dV1mpq?=
 =?us-ascii?Q?o4lpH8Zm8eSQLjUF84O5RyRqkXdqjgDHpHh4eU+jWOCcc3rJhMOOQ8EV+/LS?=
 =?us-ascii?Q?yBTC6IwGbpELV4jI0rC+Ff/3ykduFXaNLotBbT/q1H87Gxytd7IL3n6A2ABA?=
 =?us-ascii?Q?Z/i+G3xTbIs6wEgbs7nvWmVKto1XQUUmumHSOvSHG9vtNWBe0Qi+gWbssNki?=
 =?us-ascii?Q?+DGPncKB/hFypxD1jiPYj4bkwCBUZEclTd3QZWiZL5oONQijSgqQEqMHCv11?=
 =?us-ascii?Q?2rTt6YdzH/unUab27T//I8VWmERNUGZ/l7UMfKbV54VNSDKYFjwxggevjEK8?=
 =?us-ascii?Q?mAk7ishoyLZjjgVaHzXkw/CQlNjbD4QxGRZIrsfITR2IQbyLcIjRFBmKvmB+?=
 =?us-ascii?Q?OTybJPOectVQZs5y0FZU27MCI84MM7g+MXQn5zz3qyCrsYZu/AxNjh04sllw?=
 =?us-ascii?Q?EqMB9lCH+2BuMB0BYjixu5RA6BhmlcKnugWMyrRvqfequ+81lHvzmDjZtrsf?=
 =?us-ascii?Q?0Ljw6rQ5mhByzw7KObU0Ko/Pq8fXzKagn9S51AC1vFGBJ+D7s3b13YiKu8Cn?=
 =?us-ascii?Q?THzDvFBEhZrhm0ItZCO81mIblucG3Fj2TdXRTa62qTI1jR1fXJIAi9RDFRxo?=
 =?us-ascii?Q?7br+eV2ucBKlJw1NqX0nvbaLVxzPpF8/Q+ysE3B9DvU14q/Chuh7jP/L7GC3?=
 =?us-ascii?Q?/VfEJ/jiKDX/XYZb4xJbHTpD+W0lX4LPko6UDUsWQlAduOx23O15xS1Fc40K?=
 =?us-ascii?Q?abaX+y+sOlBM3bj4RS9IU9RfSGfoY42m6MhubhSeBv0D/ISGnzm5lQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:57.1831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a0681f-00f3-4404-9e4e-08dd623d34a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
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

If we don't have kernel queues, the vmids can be used by
the MES for user queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 971bf01fe46a9..a536a78342a09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -106,7 +106,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
-	adev->mes.vmid_mask_gfxhub = 0xffffff00;
+	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xfffffffe : 0xffffff00;
 
 	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
 		/* use only 1st ME pipe */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 95d894a231fcf..19a5f196829f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index bf8d01da88154..a2f6c9f4ebf2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -838,7 +838,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.48.1

