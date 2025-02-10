Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB9CC0219E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 16:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9F810E5C3;
	Mon, 10 Feb 2025 16:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eiTt6I3X";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC9C10E392
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 16:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfpwuzqWJoPjXFdsFP9UJztgnJ99KoSCOaDyAcmi/86Ft7yqVCXy2DU+HoROEgIBNSZS+OqShfMb3jjNa83u7oiAxjfduqHnI4ljFcOXhrQcbkgDY1VKRj/5moGSUc0dWt7wE6ACKmRHBtxy7TS4oTdJ37z7ml0KAZYmMNd4GGMxAkxNhEeJdKrkooCOpU9zIEpRcmOCx7d9e369zpqMggutq17UTkUGbNgBYzEtFPQIh3q4Qhu+5NsM7JpCnNnTIFAtuiCbzvYVUrzCumqmTcSHniDh/M60SZUhMWaqzXoZAGZfiDBzQJGrNIYn8xaSvJDIDHDH9134t/YaVaStLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNWuvvNHi7lHJp3Fm04bHYoBjmyHp2o8hT+aqBb33rM=;
 b=dVPa3j1tJ+53b34NwS4Ob3XrL6GeQGNL/dsVVN9UDDhwSqS7Ar6EOg9aL21yHdfpU0WNHHDq6wc7gxf1tgYnUxUVxkU7lHM4iLengzOZsh6X9pXISyp5qu56Uw94ZM0m7uJvxeyWbFd/0a+Ml5w80Mc+dGpkl8rQG+0H1G0lYqn2yQG+9lU2T3ENEpCBWINlBOaRPcVORH6i86JfAjo5eDsRU04ksASxkDMz/pJxeWhjBaQ/2xe1T+9TfwTAJGgZwAueuZBBfcbwmMElAz+6w1r4twxyd7UhjRkdlwnNuUM3SzeWJSMah0j1zSQODpT1nSH9Gw+L4wEDFPMyGEzNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNWuvvNHi7lHJp3Fm04bHYoBjmyHp2o8hT+aqBb33rM=;
 b=eiTt6I3X6anyMBzdDX2Y8an2YjgncaYnPV6UIHencOc0qhqFDcs5VfzZxvpnedOUICIIMaPOwS3HvfjZQQ/Lsw9ReChcfH/ahb4/uQ8Q2hm8xPtbS9brDZ2pUxRKjd6Qnwr6TegY9l4Sw8n6NdDwrXQ48myGjhkpdXWnQV8Y1r8=
Received: from CH2PR19CA0007.namprd19.prod.outlook.com (2603:10b6:610:4d::17)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:28:17 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::3e) by CH2PR19CA0007.outlook.office365.com
 (2603:10b6:610:4d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 16:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 16:28:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 10:28:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, lin cao
 <lin.cao@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH V4 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Date: Mon, 10 Feb 2025 11:27:54 -0500
Message-ID: <20250210162755.2488728-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210162755.2488728-1-alexander.deucher@amd.com>
References: <20250210162755.2488728-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8708b05e-e959-4d3b-fa2d-08dd49efec81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGRqWnpneTJnZU9PQTJQeCtOQUZ3a1NxVFJqK2hFWjVSaGpwMXRocUNtRHgr?=
 =?utf-8?B?WkdXVmo0TFUwUlA3dTF0dGExbGtHRjBoSE5UQ2YrS0xFUWpKaHVLQ0xWcmdK?=
 =?utf-8?B?S0NPbVYyanlwdWNEbVVGVENSRkJ3ZlM4ZjNid2prMlVXeXNmRXZUV3VmK3Jj?=
 =?utf-8?B?WG9ydUVtWHh0VVJCdnM3VnBzM1JveTVNSHFURlpOaUp6dXdObWt0WjFHK2d0?=
 =?utf-8?B?MEoxV0lnbE5KWmxCYUM3MHNCRWp4MVFTeTZYMGZUN3lzT1NmaE9KVCsvLzJT?=
 =?utf-8?B?M0JlZFNXb0g1eGFVdkQydmZFK25KTHZQTkpLWEowb28xUnJneW90WnA4NU1U?=
 =?utf-8?B?OHBlZWwrcVZhdnJ5RmJHY05jUkFWTW4rTnYxejNRTXFZbzRPOW9CcWE5VzZw?=
 =?utf-8?B?NHBqRjNUR0hrckh4YkFWaSs3NnVCa2U0T3EyYXFYSHN1UDgzS0p5WnZxNzdC?=
 =?utf-8?B?RTJYM013OXBiRXY4djhRdnJYdjVlMXVqK3Q5Zmw1d0hjelNYN1NQaGpaL2NC?=
 =?utf-8?B?d0VoV1lnMGxZS0pYeG8vWmZ6cUxxdm9Gcjdab0FndFE0NXJxdG43T042VjAr?=
 =?utf-8?B?aTNEb21qT01PK3N5dGN0eGtpK2plbW1OVEZQalRwT2NwK0dvT0NtaGkvYlBy?=
 =?utf-8?B?K3luOS9PZjhBRUhTcG96UnU5eXhoTVB0eEFRc3dIaGZab29JRW9tOVMvSDRT?=
 =?utf-8?B?L3VCMXZMT3NXR1ZyNTRsSkliWmQ3aE13dmYxdW9aYVdHQ3VQK2tlMzRFSUNK?=
 =?utf-8?B?SWcwTU9IWUExK1BrZW9GZHlHcExsdmEwY3J3cmU4SGlCeE1TcEllZGQ1NWs1?=
 =?utf-8?B?bUdMbndrVG9rWFNLQ1FNZWFhVHJ6TWpyV3pYQWI2K25qc1o2c3dvazJQQUZO?=
 =?utf-8?B?ZGZuYTBZWXlzR3Y2dVYwaThhT1dvT1RqREZSTXNnM21pSEl2WkVCYjBtb2xI?=
 =?utf-8?B?ZUxFbUMwUGs0VTVUVnZJWE8vdTVCeVo1ZFg2Wlh4RUFCd1FOSFdDTVE2OVp6?=
 =?utf-8?B?QnNDYmFnWTBRMnFYOHNhRnlhSyt4WEdtT1lKanNPMHo4NGlhVW1jMldyZ2N4?=
 =?utf-8?B?RFcyL0JOdHBCMFl4Z1dneFE1YkRSYURoczZMZ29JR25PRmhNVTdPcEdrL0dp?=
 =?utf-8?B?a2U0dFRoclUwZWRUeGkvNTN4UWg0TTAwMTYrdGhjNEk3SHU1UzlXZmw3SFUy?=
 =?utf-8?B?OU50WXdvVEs3M2cxb0hPT0xOaHF5RGJnekYreTdRWUNoMnpBYnVxai9VRmhZ?=
 =?utf-8?B?MGxTMnl1Z0EyRUx1QVZTNzVFaWpFVzFXZjBRR2lOZ0ZFaC9rVjRaM25hWGxn?=
 =?utf-8?B?NER4N2pvMjFvL095ZWtCR1pzZGhDSmpFK3BxVXZXVkxzcEs3bkJKcHNKaGU3?=
 =?utf-8?B?RUxhYSswdTBRNEJWOXpBc1FXYW9Ub1BTakU4VEkwUXRZUTZ6TWRLNzBaNHU5?=
 =?utf-8?B?WmY5amFjUWRmUnl1U1dhM0VOZWlnLysyOE82UVExUEIwbVRIOC8yUzVpdzRU?=
 =?utf-8?B?dmdmeDViSmZYOEpOQlpLOC9DcWlsUDBiSktRcDZMZzBIQWY1Ylk4aGlib0Yv?=
 =?utf-8?B?c2cwYkNFb1QzOUw2eDhML2NudERweDJ0OXZqSDV4TWk3empPK2dDdm8xc2pP?=
 =?utf-8?B?aEM2Tlp1NlJ6cVR2ZjdpTWlxbG5rUnVhd2c4UU0wSmdVL2RkZExac2g0d01R?=
 =?utf-8?B?VXhFRGh6QjdnWGNZM3RhTUZYbnE4ZEN1eEVYaEJyT1ZzeFB1OWs3RFdwK2w0?=
 =?utf-8?B?N3F0eE5rbjRrbUdRL0FsUTBtb3U5VE5VZFcwbmpaaWJ3Mko3WC9GcnB2bk4z?=
 =?utf-8?B?bEY5Y29mbzJxWm4xVlFnMEFyVDFTTVc0SjBXWHcrSGdJZnVnSkhCQ243MGNO?=
 =?utf-8?B?VVlGSWdvbXpQa0hlMUFBZzRpcktVV3c5RGZyNDRTQ2E0Y1lRcEZmTG9lODlC?=
 =?utf-8?B?VHIvNUVXN2VhenpmeE50ejlid2FQNmlGVWF2c1k0T1ppM3VpWmVCZXJBR2I4?=
 =?utf-8?Q?nHnwafqrIhVhO09J7XRy9jnZRRCNIk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:28:16.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8708b05e-e959-4d3b-fa2d-08dd49efec81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit introduces enhancements to the handling of the cleaner
shader fence in the AMDGPU MES driver:

- The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
  KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
  that requests are handled in a controlled manner and avoiding the
  race conditions.
- The CP (Compute Processor) firmware has been updated to use a private
  bus for accessing specific registers, avoiding unnecessary operations
  that could lead to issues in VF (Virtual Function) mode.
- The cleaner shader fence memory address is now set correctly in the
  `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
  the cleaner shader execution. This is done by calculating the address
  using the write-back memory base address and the cleaner fence offset.

Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e862a3febe2b2..661268172dcf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -754,7 +754,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
 
-	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+	ret = amdgpu_bo_create_kernel(adev, size + AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_VRAM,
 				&mes->resource_1,
 				&mes->resource_1_gpu_addr,
@@ -765,7 +765,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	}
 
 	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
-	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
+	mes_set_hw_res_pkt.mes_info_ctx_size = size;
+	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
+		mes->resource_1_gpu_addr + size;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
@@ -1632,7 +1635,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+	if (amdgpu_sriov_is_mes_info_enable(adev) ||
+	    adev->gfx.enable_cleaner_shader) {
 		r = mes_v11_0_set_hw_resources_1(&adev->mes);
 		if (r) {
 			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
@@ -1665,10 +1669,13 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+
+	if (amdgpu_sriov_is_mes_info_enable(adev) ||
+	    adev->gfx.enable_cleaner_shader) {
 		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
-					&adev->mes.resource_1_addr);
+				      &adev->mes.resource_1_addr);
 	}
+
 	return 0;
 }
 
-- 
2.48.1

