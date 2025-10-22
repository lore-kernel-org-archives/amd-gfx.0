Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B6FCCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 21:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C0610E851;
	Wed, 22 Oct 2025 21:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kwZUBnsK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A77FC10E851
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 21:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzNFuFA3z4gIh+cahmvyIayqzFAKCIoGS/0gXiBt1X0qGkmeDlRkHbfq2yyPGrwiuVH7CstYmCT9Ohih70AcYfHUNXW/XC2fLghiQOjGyDch8lKfkUmaGUu/sDBJ25hxGE/5pwgLPhxaz1WROPsduWb/0WwXxbqG2224/UXlHw9PRIGyBjMujvlsSJ8vpO1jWDAHakwDXcTgfIxKD1fYYAoetXPgmRyDhxCIke+YOrFWHAUQPJ+1uC63bvrRcQpMKHwTA5IwKOyTAVlKM1mI4E+EelyEkekzNatMyfTpWE6aNNUfqJouwOW0VruonaaBs2Lrai7Wo20j6w+5I08Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkjG8xyJ8KwgoMFn3zKztC65ttltgyRm2zEfnCl4sOM=;
 b=Yir5YF4xQuNMykqxWl06L9DnjFNKdDW0wJyZbfjnxRnyLXPm/GoEoWiKPO4jIdiDUYu2a4wulJgJU0DgzW+amsYXeSMiJMaCj/+/2t0mnRKUMBNTrMUtdGV6ZpG4KNU3lY5bfhnH6emp4vGtlcWQLS3uz4+dN1S/DLkQl1hwRDc6pb8ydcTaABBHFDYi5tVK1hRqmoUrOllHXGVmMnQGAvS+xR2JWgmanfA7zQL0YVznzmgG7LROlPmrHGBMTlZjg11zzI9DP2kAyJ1CUD/K5O/8jxbKka6kGcUz/ITx6XS01XDtiUGbzqlQZRvfICbsadcpKRQ+iKa38ttGmeJMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkjG8xyJ8KwgoMFn3zKztC65ttltgyRm2zEfnCl4sOM=;
 b=kwZUBnsKPrVmzWzHSYMOz8iVTiYW0LrQ6n8/dVHj/XKMOvw3OR/VeVMJ9lETB/1/u+VWHvpr6T6HTprHKrfZ5mhKR7S3pQ1KQcz0v5U9inJlA3Hp2LiC40qKF1DwycjIxUK5EZHvcGPgw1ZKoh5aCI0PQ6/mlytS1Mh8hcmnmF4=
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 21:20:58 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::ef) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 21:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 21:20:58 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 14:20:57 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
Date: Wed, 22 Oct 2025 17:20:26 -0400
Message-ID: <20251022212026.1785896-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be358e7-31e9-480c-db13-08de11b0e4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y2B0OJvsTHfXiatmDBOKmTVD9VX/XcfzAtUnJEazRF7liRw0p8dla2NFA0pK?=
 =?us-ascii?Q?G8c4Wq/Em5bM9qtuFqjVJu8MjysmhA+v+AHdSPhXPwBbWs7Bwtg6Dt33LZkl?=
 =?us-ascii?Q?h1mXbngTmh59UA629/d928onl+1T4foii3mIKO6GqS9VgoHXAzwOK07Edpwu?=
 =?us-ascii?Q?4ZR0D0QBfLQTXcG1hOYSSOstZHlBXm8bjhhL8SeuP2/IGYoH9uA5zyTczrWi?=
 =?us-ascii?Q?kneUZl+sHlhZ133yCwJocTHHURcOR/rDd1FyHCV+ad6VSjr8MA472aEDB2Lg?=
 =?us-ascii?Q?VFkLMK2FWUadZq9A9P/tOq6xjChBzZzkdnA/5YVaANH+M1j0iwV9mtNNHogt?=
 =?us-ascii?Q?6HJI0BXVUWXhw6jnCDNJo16iC0vTsAc1hCt2dWMfDMZ7P8cEEHpyTsu19uJe?=
 =?us-ascii?Q?hK/vYeL9B0nCxYxUdSqlI0jEFg1v0V3o20p+QebHDEiHqfcyImgfFZOpoAQZ?=
 =?us-ascii?Q?VN9sypYndRq35VhRMDBpdc64nMgT8nEFpNtTxRbgzwE5SoV0hcY2bvmfu+yU?=
 =?us-ascii?Q?UEwVfxIhNigClmEk+bRIR1xto5qIpHKjpHGDK60ljsFiBid3QW/8SrQcZh3N?=
 =?us-ascii?Q?iU68ZLOw3R/CRHa/TYsiqDY2LhXQXJntIbBxVRFG9KoGmz+WX9MKDRl5dZ1d?=
 =?us-ascii?Q?qs5uQqFtUNsY+JqNWXRiZSSi3WumtiV1a2zq+1S8T9noWwMWVAXwLkZkGcXb?=
 =?us-ascii?Q?pp61sXXyqWktIIWoSzeoB3XHWM+h7mTIjuPSK0vJT/FmbBdmua2rjsFAjpv1?=
 =?us-ascii?Q?P9rZJdnh8HS4NKtekBDoyPf30PHDZgiv1zweLaMuN/M/K8aoKN5G/Dvu/i/X?=
 =?us-ascii?Q?lYucRsl6KD7dCdDNWaaY0oX12tU+Hc34COluq97B2vRIHKaZWYMOZJUtKgwD?=
 =?us-ascii?Q?KEWLeN0WVjZPjBozbWBWNFNF9HP4Kfk1y/lsV/8eXAsiJxPclmwmi/d8fVMo?=
 =?us-ascii?Q?lfXb0Zsakm+2zbjEV0IIpGYDKEyLedlpQa/P/Iqv2F9TFseapPgb5hvs6wnZ?=
 =?us-ascii?Q?78k4PD/m2fK/nzQiDxjFmZvGIUoGeNsdl4kFREMeTkAdjt5tCvUpZDCyO1ex?=
 =?us-ascii?Q?kKH3PylrfHQZ3Xq6gz4qfRI7Uc3lV8/Xo2SwRmrkH1LVuvSvnljnDADdPci1?=
 =?us-ascii?Q?vEd6QxxZi26Nac7bVW/4sNHGF4Eo4P+EW5TW573OaXNV9cjoUzY+JJ9uI2Y8?=
 =?us-ascii?Q?Y7aWzo4/YkqD5TuZre1O50BB9Y2bXZNEbyYZdqgw33p7lLj5lp1V2sz4D5CD?=
 =?us-ascii?Q?Kym/Neu6iSkIgs5Xd/kgF1BIe1NEGYHPKAsdrCd+yPKbKs6f5X+BtDVg6IB7?=
 =?us-ascii?Q?UsULiwdO56xVHg4e6od3yTpU7tEvtL3M/RQqRPKcbo45/kpabx0Pt+ARhtL8?=
 =?us-ascii?Q?XwvdsGMD29HhDvmmiuO5zYRfDQRJJ4VgSakD3VCDF+G4tx4DQVAMkP1fpUjL?=
 =?us-ascii?Q?6wUspmSSeBIwZikWI5571+akh4cY7Q9LyuJHTmM7ORMkknacTN4TWMQfD5M7?=
 =?us-ascii?Q?TS4cKrrR36evrDnMv4OQ0QY97udnWYSF9+A00xp8Vr0QdLEr+vpp6h6M1FdD?=
 =?us-ascii?Q?9qAKAUzJwVZVRbaGRTg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 21:20:58.2806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be358e7-31e9-480c-db13-08de11b0e4c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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

If we don't end up initializing the fences, free then when
we free the job.

Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3d396ab625f33..8ad8b16e96760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -295,6 +295,11 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
+	if (!job->hw_fence->base.ops)
+		kfree(job->hw_fence);
+	if (!job->hw_vm_fence->base.ops)
+		kfree(job->hw_vm_fence);
+
 	kfree(job);
 }
 
@@ -324,6 +329,11 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
+	if (!job->hw_fence->base.ops)
+		kfree(job->hw_fence);
+	if (!job->hw_vm_fence->base.ops)
+		kfree(job->hw_vm_fence);
+
 	kfree(job);
 }
 
-- 
2.51.0

