Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F92CF357DB
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 07:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E8810E1DB;
	Wed, 25 Feb 2026 07:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aqo4Dq7q";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5320810E1DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 07:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuHeBCO+XizxYcGuI05MLz8kS2Ez1HANPZlmwqj6XrZ0eBmJd+2mDyx+lf49nw7D5wf2hC1atHVommY+LCvv05Q1XHUj820/FshRbLjw/WILnXpaxTBTx/4+eIARGf52VnfI1H8fKx4FD/ahwPAmF8zokC3/Oq9PBOeijWvQycGOaL+w6M/INsPHpjkBuz4gRdNEaEirNf1yVLK8MbktMhGa2inieSmbLcrrFt9pPm0ar8wEYFo2ASe0ymlHa4Y7WCkuMum742Alye0IJolxYPkdexiu4raf9TqqKVsRiPJUskIopC82h699PrEZMAEriDM+vbN7d+3MBmvGOf5BPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjuWriBP7vITczkA8edngFX7cq1CNYyR6kMIDNzF+Sg=;
 b=i5E5vqeswsbxe1QuidGfEJrm5fUimtGB/NY8mssodHVQMA5vmInWpZ/phy3WImlXoNhHzBYzKVsCRA0He495tJQxGSDGSA5WvlptFQCdlZ7swjxocKniTCOTaRofCMaJPa2IOMA0wQga08Supqi2imGtpCE3y2dDpI+ZB8YyVuRrgCknjc6dg4zdinXKMeeYlOdv8Q8ea1rDXkRrvXDKd8fSsqIdeFzmLYljEOKOTKM1nfV/E6V3ntH2JbDkm5XP4XsOEFJgIkxZvWK/Jq0s2nW37y6MaovbD5FmfQV9Z/V8Qx37ZCqvhkyKN17/Eq90QXIdpmQ2fbIKXFcyRZHbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjuWriBP7vITczkA8edngFX7cq1CNYyR6kMIDNzF+Sg=;
 b=aqo4Dq7q6r1U/e1ni0vg5IGo+4ZBeefCdV46mkjsV3atIrU2Ftsk0fPLooqxciTz6DrZMtjxCxu8my4nM7JpBwyY7WtZoLoqbz60562pQILr/DZ8zP+ViS+SVS00PHNg7IUqqdQ49ImPVmRXP+E5ubxdgYAEErUykeoGxk3L+O0=
Received: from DM6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:5:bc::28) by
 DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Wed, 25 Feb 2026 07:21:20 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::e9) by DM6PR13CA0015.outlook.office365.com
 (2603:10b6:5:bc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 07:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 07:21:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Feb 2026 01:21:18 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix incorrect max handle limit in userq wait ioctl
Date: Wed, 25 Feb 2026 12:50:50 +0530
Message-ID: <20260225072050.1640920-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bbf532-2ea1-4d3b-d75d-08de743e796d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmtmUHZCdUNKSE00UFgxUFNHejVaMlNjSC9lNW9iZGFadHJxQkU1Z0xEb2ht?=
 =?utf-8?B?UEd5WWJUUW91aEU4UTBPRHA5Y1VmTEZFcU1wbnN4K1pOWUMySERwUWJzREhk?=
 =?utf-8?B?UVZSUmV1cXVSVEpUNE1FbkxlNC9EOWxjU3NPZE11QjN4MUUxMWQvSitpekNh?=
 =?utf-8?B?YzJMdUtIcUVTb1JWUmdDb1JicWdsQ2d6WFA2N2NHdzhmUkFqZHRCTC9uWm1h?=
 =?utf-8?B?SkxlRFRFaDY0MTlLUytnc2FaRG5qU3FTcVFKVWdDVzJZSU9lYnlTWXNGeVJV?=
 =?utf-8?B?UjlnWlR0WnJJdlFZZVN0ZVZCR3RmRE9tanduUkkwdXowWTlyS2JaQkhKeE90?=
 =?utf-8?B?eDVRMTZvdE1DS2xQMEhHUjYvK1VVclBBck5oSGZqY255NXoxcVZWVGNHbmNy?=
 =?utf-8?B?TUFUUVJLcDdqNUEzQnIxUHByVzBscFFOOU5xSmhmQkN6K0lRQ0IybDkrOWlK?=
 =?utf-8?B?VFNpOVorempyQ3hyeWNpTUkvMzdLd1FIU2wvUkYyTXhBQU4yMmpvSVR0c0F6?=
 =?utf-8?B?NUcrSFhNZzhJZFlOWFIwUnd6VStwa3ZldVVNcUVKbWdqUjdyd2NpL09XNUhF?=
 =?utf-8?B?d25LdENtZnpOcHdoOUhQcHh5cXk3bTdOOWwrWlRRMlQ4UGRhUFNoZmdXWHNC?=
 =?utf-8?B?Um91TlgzdThheWRGbGp4TktzZ0ZGWDhJK01zVjJLMTlFK1VIY2w3ellZbzZl?=
 =?utf-8?B?K3BMajdjdTlJTUMwZVZmWmFtRkVvM0MvSnhwRG0xNm9icDVkQkVpaWozUERx?=
 =?utf-8?B?MkE3SFdBdVR2RFVpdFhHbm1VRm5JMFdwVFRtcHBkQ3YxTjAvZ1JsRGJvbnA4?=
 =?utf-8?B?KzlNeDJqLzdTNjNNNS9ZRHVTQnRhZitPTldCZ29lT0gvUWEwNDdXL0s2K2Vi?=
 =?utf-8?B?ckNnakNJWFVTYWxDcFM4MnpTcTVEMmhVYzNCL2hQc1pURmVmZEhSQWpnY3A2?=
 =?utf-8?B?QmNTK1ltTG1tbEJHeUhsdkJ6czJaRG1ITklSamZVMEtVeDhrYXpJQlpocHYz?=
 =?utf-8?B?ci9NOG1sMGdCdnd1ZThybFZ6VXVXWW5FMnpNZi8xYVNLaE1hZU1wQXErTFBS?=
 =?utf-8?B?cjlNa0I4UnI2VUtBcFVjUytiYmFQSE9RZmh1akVYai9nMXFLMUpxK0tEV09S?=
 =?utf-8?B?SE1QTWdtU2hYcW10czRFS2F0QndCZ3BvSzY0a0IwWG1nR1NwR2w2ZnRTd1FW?=
 =?utf-8?B?MVNMaTJ2K2lyZ24zVDhWUFFKcXlxaS9qYitOOG1HbDAycnMvc3NRdVJEeFNM?=
 =?utf-8?B?QVBBSmVRa1dVa1JOV29JZ0tCTE9pNEc3K0g5Z3B2RkJyY3dPTHQrUFdkVjEz?=
 =?utf-8?B?cTJ3MG1rdkVlYjJkWVoyZWdKdWE0eVhlVkdPSmt1VnNoVnBuZDQ5eTBGL2tx?=
 =?utf-8?B?ZkJ3cHk1KzM2eHhkZkRJS3U3VlhzWUcyak9aQmpSKzNhZ0R0SmhkWU9LUW91?=
 =?utf-8?B?dU9iaTA5V0ZqN2pXSVhuV2c5Qmd3ZndSMjhKdTl5c2l4WWVGbFFXSHhJOUhj?=
 =?utf-8?B?VnEzMGdqak5wckdDcXp1ZzhkeWM3Ny9PRDMzaERYNnJmdUxPbHpMZm1MS0F4?=
 =?utf-8?B?a1IvOGNmc2phbVRiVktIcVpMRUVTTG93SDFUdVIvbFJBT2VXOUp4SFRzTEZ3?=
 =?utf-8?B?UHFwckFIcG90dFlsV1M5cmgxditKK25DU2ZvZHRRc0htbm9UeFhJLzY2L0xW?=
 =?utf-8?B?RWltQkVIY3F4T2Z4bHkwVlVwK1lKRGgvSDR4TkQxV2RDU21tWjQ4T0tqc3hN?=
 =?utf-8?B?TzZGMjV0NGVIL1pGNkdXc0VyaUJlZ1ZWU01WNnJyNEhMOC9xbllTT1g5SDhh?=
 =?utf-8?B?aWZPM0lqWFp2MEliL0NjKzNDVFcvdm0yRnRCci9hV2premFTWDN2RWZ6MmlS?=
 =?utf-8?B?R2JXWXZtVUgxTVM0NUxOdVFMNGVRVDF2U2xrSUY3KzRMZldndzJKcXdNc2FL?=
 =?utf-8?B?TUQ4cHVOWk5nNmhHOHBvejNIbjlhSjBDeWdOT3Q5NGlRTnI0RXNTTDVYamdv?=
 =?utf-8?B?enB4VDlJSlY2T2VRUTJqRHlNUlpZQ2NDQXpqQ1Fma3g3YS9ueGFvUnI1OUJE?=
 =?utf-8?B?bjV3ZVNpZHVSMGxkVzNWb1ZCb3JoeTFmZmxXYnJzRUNTYUdrcUJpanIrY1JE?=
 =?utf-8?B?aVQ1VFNGV0FLNGlqM1dXT2d0Mk9mNEdYN1YveXlIdXlmd1NyVVQ1ckp1V2l1?=
 =?utf-8?B?MEtDTU53NU9mR1Z5TThaSU91ZHYyNyt4MmYxSDZMZXU4V2hCanBFQ3orNFRh?=
 =?utf-8?B?dHA4dmhBTkp4V2JxWElWa200QmNRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O7kzZnJymJ/veHlkEhUHE2DWRKJdFI0n0rkEdi6iIkr4K0VUMzUFg4qlN+JSBcnccD5+wvwb7BwPeo8VtZILOFh5YfZ7y2NC5c2fIGZ0TJHt/3mmsAQPD6sXhuutCmK1HiILpvNvgzUzfdUCNMYcm4N7KttbCFXN4krxoNNV1fmTNsuQRzV7JmTDEwfJziUrt/W7znQFzXLNC6VXkx1kWWteflIGb08o6ewpq+aZ9nrfv4njsj8SKusz+VqYCpMSm6ecBqrVL5UlL436akM26madRltXDzfgnOxhBsiCWIc41Q+6cyXFuJz6ND8XYWgn80u1sz3+fiyPVrowwyVOSIWLhIbdyhFgjVybgdgSlMgt7V5AHeEe2IEDPN20aBe7LcLG5o33WVt87vdeZ557cUmhznmyV9I2DFRNKBdOKKmOof/VjxC2sZzPVBzCHim6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 07:21:20.6440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bbf532-2ea1-4d3b-d75d-08de743e796d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
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

Clang reports that a comparison in amdgpu_userq_wait_ioctl()
is always false.

The field num_syncobj_timeline_handles is defined as __u16.
A __u16 value can only go up to 65535.

But AMDGPU_USERQ_MAX_HANDLES was defined as 65536.
So the check comparing the field with this limit could
never be true.

Change the limit to U16_MAX (65535) to match the field type.

Fixes the below:
amdgpu_userq_fence.c:642:46: warning: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
            wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 136071172111..e4bca62bcf14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -35,7 +35,7 @@
 static const struct dma_fence_ops amdgpu_userq_fence_ops;
 static struct kmem_cache *amdgpu_userq_fence_slab;
 
-#define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
+#define AMDGPU_USERQ_MAX_HANDLES       U16_MAX
 
 int amdgpu_userq_fence_slab_init(void)
 {
-- 
2.34.1

