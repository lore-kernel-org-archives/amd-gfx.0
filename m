Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC328C25B74
	for <amd-gfx@archiver.kernel.org>; Sat, 25 May 2024 02:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864B610E05C;
	Sat, 25 May 2024 02:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pzsKzsvP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2F210E05C
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 May 2024 02:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLf7gFNLU5Uw1bfRrTV8tNSzlJ1J0IEmiVX46l+kB0lqcBhwI7qAVI7yAySGqOOU+DUtgN40siuaMbdguR7JDGqbOjB+kZo9NgYOyQFFVz044fJItLcA81SVUhZippD7ZxsYUt2Nm+fXvlRSjmlm7yM4rPpCKfjci6J0lw8+TirJbH7F5eGn3zJbWzEAfTzXV+doElToIySaFcH4ufV6IVQaxV0xUOTEbzDllf8fOvTjorHd5/QHSROJT/pArvlumpBSLslvED7ocqifESS76hFjZYkvsTp/ru87IsXpJ6I6TmY1JFkxAhcKpjasNdKhGCTc9BDs700IT19UUGLQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vtEHpI8V29v1HRvLrelj375Sa5+kzU+ozyh0wbvIEg=;
 b=aJIqkkIC5ezTEFjk7FuBcwBqESth1+35SrkTVtBst0CaOr14gbcWgyxY7q1lMccYQHdTBoKi+wbsSj3suF0aPTdoAMw24V9pCH71slm/Wt/M/GeRrL5qn/7vk19YdUfenKYQpDUSn9Zbxv0Y8P+EUm0rlOnbJe8OS/x1xFV0Z/01BZ3tclqBMbs/rPzeIaqp984cMxExQVdBbjTPRaao8J2WoFxGNLReihIbT7PAn8dmrNjjAUYTCRzdyiD3Nr+ZXn6Mt+hBHPrXn2K94eh0BZ2jZs5G9EAZ7EtUOWq7pJ/+xZmy6xUIF3C9uiQFvlt2wudBinr/tPEWss6eFIHHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vtEHpI8V29v1HRvLrelj375Sa5+kzU+ozyh0wbvIEg=;
 b=pzsKzsvPkPSv5UIJFfKkWTfOuUjzfPuLWaj+32agyMJ+TEbOf6nFQt0HFzXf6vFBag1PDvht3j/BoE0mG1iSClsTElpVXzLuXWhu4Wtc6SAbFvA/eZfjkM5kGKffZaprLK9sJVpwCtK1oyFZ6qEoRz+Q4rTxb+GJG8XTu+XD7Rs=
Received: from DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Sat, 25 May
 2024 02:10:57 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::bb) by DM6PR02CA0109.outlook.office365.com
 (2603:10b6:5:1b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26 via Frontend
 Transport; Sat, 25 May 2024 02:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Sat, 25 May 2024 02:10:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 May 2024 21:10:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, kernel test robot <lkp@intel.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix type mismatch in amdgpu_gfx_kiq_init_ring
Date: Sat, 25 May 2024 07:40:41 +0530
Message-ID: <20240525021041.1780050-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9964b7c3-6040-45b7-40b5-08dc7c5fe9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1dULzBNemVEeiswdEovemtQT0xFditER0tTYnlRdXRRNVMwUk50c3A4Nkhz?=
 =?utf-8?B?L3F3ZnNCWWZuVHJRL0svaWlKdmRaS1FrZ0g4ZmdWLzNMWnpSVVErVWFFRjUz?=
 =?utf-8?B?VkVCVFkwcGdFR003NWNlYVhPTGZpSS8vNlFSdGFjZTBLTTkwbFFQOFNKMThQ?=
 =?utf-8?B?a2JQUWwvY2tIK0szRVhNYjhML2dCK3RJWGRHVVpxY2hyeEVGVnFaeXVaM1dK?=
 =?utf-8?B?SzlRbHRKTWFFV0dNMGV0SklveXZxN1JUMVFCc0RjZGpWa0l6eFlBU0V5RU0z?=
 =?utf-8?B?M0xGblI5eFR1YVluWkhTTFM5V0xPQk1RZVNjUFJJdHZmb3daQmdRRTVDc2N5?=
 =?utf-8?B?VUd1Skc1VCtxSlMrcG5naTdKdFdBdUpQUGtqY3BqRmVJd2RyZkplRTg3ZnV2?=
 =?utf-8?B?ZEZKVkhiWHY1RWY5OWdycEFHMkxJZW1ZTnA5ZTBoUEpaTnNWcjZMbTRmL3ZE?=
 =?utf-8?B?VFFVY01VZlZvOWltRzE5Y3RNKzFwNEs2YkZJRm51MHRmM2lOREV0eWFzTEV6?=
 =?utf-8?B?NTcxQmI5aFlUakNKbC9sYVJITGE4a1plU0JoOWFKdytXMGVTRmRrYjhTZTh6?=
 =?utf-8?B?Y1Z3blh4elNMaWdjcTVWd1ZNZXdVWXplWm5LOXY0UFBtQzlEaEQ1RkpKUjF3?=
 =?utf-8?B?d1FKN3pPcXFzSWluNzlFaTFqMjdVbFVLeUl5K0Uxc0trZmhEaHhTN2lPeGV1?=
 =?utf-8?B?Z2ZQNnI3VFd1akdEeFZaeXNTZzFBQUoyVURHdCtpRExWNjc0eU91bzJoMUE3?=
 =?utf-8?B?Y3h6QjA1dlNiaHo5dHVJZjU0ZnZ4SXBKWjlyOXJpVnErYjNoSjBRdExZUmpM?=
 =?utf-8?B?M0lPTm9XSTJNVVFtWGFZdmQ3OEM5MnJzTVVka0R6VGNKRXpGalUrZ3NFSTJQ?=
 =?utf-8?B?TEJVcVBhaXAvLy8yZit3TXRneWQxOVVBWmFRUjdxbUorMjdBdEoxWjFXMCs4?=
 =?utf-8?B?UFFiVmUvVFI2bzBHSnZQUUFUQkJ1U2g5MU5ubDhhN0JRejQvcEM2eDczM1pU?=
 =?utf-8?B?dG11eXlJV3haV3czNzNIQy8rN3BmVWhGWTNFTi9FT1VSdzh6NFI2cFNsbU9u?=
 =?utf-8?B?Mi95aVFuNkZ1SHZFV0owU2g4MnREMXhydEx0OVcxRFBJUi9WdTlIcW9CRG8r?=
 =?utf-8?B?VkM5bmVSUGREOWp2dnUxUHhvcUJlMHN4MElic0NtYjZDZlRjUDFrWDNyUWl4?=
 =?utf-8?B?N3MxQjR6VTV0YXQ1UWN6b0t6RnVPb2owVmJ6UUlodGV4ZmxNS1RBUGJ1WTEz?=
 =?utf-8?B?V0dQem1XUlF0clpMSDNIMnY3Z3NubVljclZzQ0M4VXA5bkRQa0hCVzY1SVFS?=
 =?utf-8?B?Snh6RlRxTk5vR25CZ2ZYTlJsOG5URWsyMkluMklGeFBZaUg4U0V2R3J3VzIy?=
 =?utf-8?B?NFo2NVVLYmt4TDZyenNWc2hhdk5MVFh0QVBJOFN3TkpLVWZmOUljVFNLakQx?=
 =?utf-8?B?SC9qVmY2cXNSVzNPR3J2Y255ek1qa3o3RXA2RFdINkZ0ZTJMNnFRcnNvY1Vr?=
 =?utf-8?B?OEQyeDN6MjNUSzVUelZqamVlUzF6bk9ENmxLMXhoZnl1Tmp6K3FuOVhxTWgv?=
 =?utf-8?B?Tm1XWDhDemgySm9QdnpHMDBKSzExL0pxc2I0ajhzbDFXWFZDVXUzU3MzdzZM?=
 =?utf-8?B?eUgybjNQb0dWRFpnSnI3dC9kc01wTmh2amxKRWRwdkVSbUFKUXhXTW8vV2Mr?=
 =?utf-8?B?ak9GbnFRWGllNVRZSVM3blErSGN1NGx0Um9UZHFBNHZzQjFLQUphdW1VNzYy?=
 =?utf-8?Q?CqiSvcccBNyRtTw/U35Et+xmLnNL+iUk0gNC3Fk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 02:10:56.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9964b7c3-6040-45b7-40b5-08dc7c5fe9d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

This commit fixes a type mismatch in the amdgpu_gfx_kiq_init_ring
function triggered by the snprintf function expecting unsigned char
arguments due to the '%hhu' format specifier, but receiving int and u32
arguments.

The issue occurred because the arguments xcc_id, ring->me, ring->pipe,
and ring->queue were of type int and u32, not unsigned char. This led to
a type mismatch when these arguments were passed to snprintf.

To resolve this, the snprintf line was modified to cast these arguments
to unsigned char. This ensures that the arguments are of the correct
type for the '%hhu' format specifier and resolves the warning.

Fixes the below:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:4: warning: format
>> specifies type 'unsigned char' but the argument has type 'int'
>> [-Wformat]
                    xcc_id, ring->me, ring->pipe, ring->queue);
                    ^~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:12: warning: format
>> specifies type 'unsigned char' but the argument has type 'u32' (aka
>> 'unsigned int') [-Wformat]
                    xcc_id, ring->me, ring->pipe, ring->queue);
                            ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:22: warning: format specifies type 'unsigned char' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
                    xcc_id, ring->me, ring->pipe, ring->queue);
                                      ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:34: warning: format specifies type 'unsigned char' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
                    xcc_id, ring->me, ring->pipe, ring->queue);
                                                  ^~~~~~~~~~~
   4 warnings generated.

Fixes: 0eb430076172 ("drm/amdgpu: Fix snprintf usage in amdgpu_gfx_kiq_init_ring")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405250446.XeaWe66u-lkp@intel.com/
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 68505eaa92f9..19b1817b55d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -330,7 +330,8 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
 	ring->eop_gpu_addr = kiq->eop_gpu_addr;
 	ring->no_scheduler = true;
 	snprintf(ring->name, sizeof(ring->name), "kiq_%hhu.%hhu.%hhu.%hhu",
-		 xcc_id, ring->me, ring->pipe, ring->queue);
+		 (unsigned char)xcc_id, (unsigned char)ring->me,
+		 (unsigned char)ring->pipe, (unsigned char)ring->queue);
 	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
 	if (r)
-- 
2.34.1

