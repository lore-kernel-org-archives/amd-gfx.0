Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27923C3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 02:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5AAA10E1E2;
	Mon, 12 May 2025 02:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YR+vYzo9";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88AFE10E0BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 02:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUP1hU1PtFqG6cd8fqc4K8OpjEQDbV3yrVIa3a+8JelPEeniMK5+yacYhPx5yVKQOANd/97T7wpMS8EqmOObA/aMhFkWR0K6dLWkDfl+sxAiBtcgfBOJ/zDsDjda2D6AAIAhiKZkYhXJwcRRo1dsPkO++sXm+K/ds17LqxW5UejCYEYPUmTDB7VMxWkoAHeiWsuZqeAYZg4ufXV+9f5XzRBxSi2OxsXqoEyp+kfEUPokEj7ludJeDR9P3nh3VN71yvmnfqhQnFaX+VErgac4UOVWHpgwl7Crd69ai/hnJobUcVYZh0I9ddm/vikY4G6tZXydxHkQvAm9HqW5YjStFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwBpd8JfmzBsvkZjYoqLmAAW++LnykXAck5kuseCgEU=;
 b=R2R6dCdBbuRqr8GTUoMsOFg7c4uToRkrzVrNNOay7n+p7MLttb6IzLabBlmYzrAWckNEySAZ7/Ra5qJkKP4EvaA+Us2C6uG9f0WKdYZoEq3sSCthHqS81ETvan/H98AK7ljKkrKf/TfAs/11sCJRwK7jlFjjJMfVJ9CzC2OFOOsobXc9RaUMwrqhbKiLOOWpqhaOuoJkZrxD7cVp+adcMonxFyhveE09HVRGCGMlW9uY38Egs79n1cF6jPvN3q9RatD3N0wryod7+8/ccNhcTiVqtSVoo78di2Cx6HeU5CX0S+PLRXxBXBnAdfOToeiY4sz0Ghv8nV76pGSjEFeUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwBpd8JfmzBsvkZjYoqLmAAW++LnykXAck5kuseCgEU=;
 b=YR+vYzo93ZkVQI2so9muKbfvj3gPrfWmv3N0Bhx7TpAqSXyQb8fDvo2oXNr+xzo+/R0QuXLnHZhTf5I3DlXMt1wGp86MJ8pnFrDrVpXtfZne4IVgKWvuXiQqd1T4TJ9vyaBPXH6WfzG015hm9vAO6zJk0uf+Qy82FaEzuylyiw0=
Received: from SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 02:20:42 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a3) by SJ0PR13CA0026.outlook.office365.com
 (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Mon,
 12 May 2025 02:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 02:20:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 21:20:26 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: lock the eviction fence for wq signals it
Date: Mon, 12 May 2025 10:20:16 +0800
Message-ID: <20250512022016.395502-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: b315e625-03f9-46af-d179-08dd90fb978f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0ZlY3ZhZmlXZS9IRnlMVzY0eHYyd1JGMzlmeDFORldOY3pURUNvMElpbS8y?=
 =?utf-8?B?d3FFZ1c2WVp0czgzY1l4djFJdTBtTzhpQmhMNUNDNHo4WXRodDRDTHB0SFhl?=
 =?utf-8?B?NHB5NmhxbnhKZ0ZPa0kxdHpuN3VCVVNlNjlHb3hhN25wVVRpNEZaVWYzWU9i?=
 =?utf-8?B?VW9ZYXE5UVJpZWwvbmYxZi8wV1ZLSTZ1ZU4ycDhVc3VodkVSY2picUJwL3Vs?=
 =?utf-8?B?Yk1RVnByWVRIaGMrOS9iaVV0Z0tjcnpuY2V2ZUdZSTFuNXloMlQwOW1Bak5o?=
 =?utf-8?B?MVp0bDJwa09oT29TQkg5TmR3ZG5IbEJza3YrL284N29RNkF6cmd0RUQ2cTc0?=
 =?utf-8?B?Y3VZTzlVemtDTGxCQ013WE4vWEorTVNyR2JoKzVCdXBzc0w0YzU4eXZ4K2Rl?=
 =?utf-8?B?TSt4Y1JVNytpdTd2TVFkdXFySm5KTW1QeUJjdHFiZVJHNnI5SFVnOTcrZ2gx?=
 =?utf-8?B?azhHOS92eFJraTNlaHdvR2YwY1hSa0tSWHMwZ1h1S2lodkE2eWVXdXE1WnBP?=
 =?utf-8?B?aHQzdS9pWG9HNnQxUEliblozQ2I1NDRGUGNlTmgwRlpmcWs4MkNUYVVURlk2?=
 =?utf-8?B?TmQ5a2lqN2l4K3pOQktVTU1qbndlSFZyMWpIUGlYcHkxOTB1K0xuaEIyRmNu?=
 =?utf-8?B?Rk1TN1hvSE14V0x0alVleXE2d3BQSE81alhCOXNZdnY2WjhTKzA3dW1iNDNa?=
 =?utf-8?B?UUpwRVZzcTdpZkJzRytINkpFRXZIS0JaMzJqSnp5WVZqMXFuYkU2eXhjbTIx?=
 =?utf-8?B?QWRucjVuVEV5eDA0c3dsRUNiVDFkVWpYUTNUdDV3RlZveDhVMTBjS25oTDVk?=
 =?utf-8?B?bDlpL1lJSmxzOWVpeUx0dWJVWGdTRVo3RlFMd25xR1F0RzFGR1FhbGZDbVN3?=
 =?utf-8?B?RDExR1pzTDZFQWNpbU1TSHcvci8xTjBnamxjWUVmZTlId2w2K0llVEc5bXRS?=
 =?utf-8?B?SzkvU0dQK2RHQUpwM2RSVkZQU3Y3bjU3NllZeXU3bC81eWhkNDd5bFVWMEZl?=
 =?utf-8?B?K2Q3cnVMbXVteUhQdllsVUtieUJCM29XRFptcngzMEZkVTB0WWU1NWlvVkta?=
 =?utf-8?B?MzlzdU1CVW5EdVFPQ0RKMGMzTVpzdVVWbzZBcTRVbGZqdllyMGFKM1dvdjBJ?=
 =?utf-8?B?eEd3TGVTMnlkWk5Wcm9RNW1vNHhBcW5PczZseGVEaUFPVVVKOWJ1M2hEdlhW?=
 =?utf-8?B?R0tHK1J0NU80YUc5M3NXNGlJWDdJVWlLbkVseVhVTkErc3Y3NnVXamZjNjhz?=
 =?utf-8?B?Q2FWSHlJUnExd0xXL1RldTI3aXBEbmEyYmVHblFsdjk3di8wd1dpb2VRUW5F?=
 =?utf-8?B?aHZmWkRPNDZtTEtJcUpEVnI5dXhoNVRINE5GZzZtWFBzUUNDeVRlcUxEZ1Ba?=
 =?utf-8?B?bGVlREl3Qk9rS3AzMFo4MVFtUElHbVZZcmpISG1UWFZkSjBhTlg3aGVHa0Z1?=
 =?utf-8?B?MkhZNm9xSThOZHlhRzFQd21iWFdnQnV6OUxTdGVOcS9JRnBZWXlFb0taRWdC?=
 =?utf-8?B?ZklaZWRhS1VMbld6OGZZMlRJRGg2bHRabnI1U2hlQ21DUGN0bjBVMnpKRGE5?=
 =?utf-8?B?OTRCN1lZQU1BdmxiOHNVaXRLNXVFMTJBTjdzMTBDejA2SDRUNTR6MGFQQWQ2?=
 =?utf-8?B?ZDF4Ylk2c1JLem40c2QwL0g3bC9PNXNBaCtVZkhYejdOUG15TnN4V2p5TFph?=
 =?utf-8?B?SEJ4dVl1WGFnTXNjNWlRVXYxY2ZJZlp1a1V1NXQ2VVdtNENUajdpcjJEdzF3?=
 =?utf-8?B?b3haaHBUV0E1UDJvU3pJUWNrZ0s0VnBVS3JjajlZL3dOand0QUYwVHZGcmJt?=
 =?utf-8?B?UmZ5Z1QwUitlTFZtZktWU2hIY0xrY2V0NDN1bjRmWmFsa3EvbFd5SnlGYWUx?=
 =?utf-8?B?d3FGR2lkUzN0c01PcHpVNmlqL1JSU0FBSXBNSmxqaWFBTnNXbmJLcllZdkpk?=
 =?utf-8?B?NUJ3SzhUZ2NiVTNqQjhQSEFPdWRKT3NIRzhEbGdwandXc2NuQm93bjFURUlr?=
 =?utf-8?B?WkdRSjhHTDNSOHF6MmlONzhUQkJtTDU1QXNZMFc3UTNqbVNQRHRDN2VPU01H?=
 =?utf-8?Q?ujd8bV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 02:20:40.9081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b315e625-03f9-46af-d179-08dd90fb978f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

Lock and refer to the eviction fence before the eviction fence
schedules work queue tries to signal it.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 1a7469543db5..d5f176fef357 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -108,12 +108,18 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_eviction_fence *ev_fence;
 
 	mutex_lock(&uq_mgr->userq_mutex);
+	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
-	if (!ev_fence)
+	spin_unlock(&evf_mgr->ev_fence_lock);
+
+	if (ev_fence)
+		dma_fence_get(&ev_fence->base);
+	else
 		goto unlock;
 
 	amdgpu_userq_evict(uq_mgr, ev_fence);
 
+	dma_fence_put(&ev_fence->base);
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
-- 
2.34.1

