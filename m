Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41CCCE8E77
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C3410E9D3;
	Fri, 25 Oct 2024 02:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lC07W3vJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FBD10E9D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruF7RL8iALKDl1HGNYyiawwZcr+tx03RLoReJX/RcO3Wk85BRAJoKNdx+HZf+QEbxwpZEutiPeyz4KfG/lArEtbq/M0nypVwSbC4g3ak/PSXmWbT/vE8BODYacFkVR+K25GZku1BjyiFZfCT5K+NABXXjbMGnWa1mZoGja0Nae62VXDAb/am5pDxzkST4IJqGFo6qxdf9DBeLN6RLcX5FoAEiApr+XkG3FrnAScjhDPaBWbUnyqGzGk8EsGrUExmyIbmA/MgDx1MdGf8aSUdV5R8mlylZILL7uVI7vOIZRdKsi5S08sEc3c8n6SdUBPA7kJCdoLabQrgA17LLnP3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYhWTKeUkgxo9C4GYSIlkMz1+R4FAJ7Fvky1YcYvpiY=;
 b=GnBpqzhJDf8WwKmx49Iz/k7m3WLEFqHUSB0hf7voy+HXvi2XuLVB69J6tjR/yd4xJjDwBnr7LhNG4W3zCgiWqPs8UYw9Ssb989+BpvRBsI4LOeax9b973Hq5Bm5VXqX3UIpS1FE5mvDo8igPThlKFsvc15/f5mbyPVOmnhMGwGeYAcn52OxlQ/jB/wGv2vuIvCEuPtGwjMgX1H8l8KBGrTszl48QB/KjDhIFsGbMborDdaYiAIwx7JW2OZjXFWq/t7WuBWVcruNgo3OACpLeIqWqsyZW+o9yV6IS1nrfiSsSTyOW0c+5RiU0Q19nUuor30Thxormsk1FFI6/LGnwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYhWTKeUkgxo9C4GYSIlkMz1+R4FAJ7Fvky1YcYvpiY=;
 b=lC07W3vJ26CACVV7p3EZorSs6bBH0D93tart58ammsTn//gqv3QcDgS1qslw9vjKNct5HXFT0nav3t8TJvb/ck5I7x7gMt3Wia21950rGZBJfM51HiEAyO0bdePMedNPfOqbEy9z8lRRakVmJUtl57FDgNBxeRoCohEHvbQU3bQ=
Received: from CY5PR15CA0181.namprd15.prod.outlook.com (2603:10b6:930:81::16)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:09 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::5b) by CY5PR15CA0181.outlook.office365.com
 (2603:10b6:930:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:05 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 05/29] drm/amd/pm: add inst to dpm_set_powergating_by_smu
Date: Thu, 24 Oct 2024 22:35:21 -0400
Message-ID: <20241025023545.465886-6-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b149c3-c6d8-4efb-7146-08dcf49dc8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkRRL1BjRFlORDFDdTR0a3VUaWZlYTVDYnRVNXZQSU5GVHhEMHVLRFlsVmpk?=
 =?utf-8?B?bTlzTUhJRXErUHNPNEpOZndmdERMYS96QStOZ0FwOFRQcDJQak1wZ09yOU9C?=
 =?utf-8?B?Vzh4UUJmZ0ZFTURkdUVtQXMxTmRhdFBva0o2eHg3QlNrd2R2dmhBaEFDdHgr?=
 =?utf-8?B?ZThsM3RQVGh4ZFJOVzc1bzk5aVlNU3FMbk8zMHk1WHNUM3o0bTJmeGliaGQ1?=
 =?utf-8?B?enZRTHd1QlB0NjFvT0Z6dDNsTjFONUt1dWx5OTBoS0pYU0F5REk3RTBBMVlp?=
 =?utf-8?B?WThlNS9QQ0JWUTlzV2Zlb0E4K01RSmJBUEpLc1htV3JZTGI3dDJGcktCYU5X?=
 =?utf-8?B?NUt2S1JSZ2JzU2RVMTdlenNvNmM2NCtEQWFYbnRiS2VZeE5ma0VuVGorenNv?=
 =?utf-8?B?RGIyTm1yRlovN3FhK2RLcFBMSXZPOTNmSHpqTndORUlYRitGeVIrWXcra2Uw?=
 =?utf-8?B?MlUzeTJ4d01ZNFpjRlFkWk1sVkR6dlh4eiszRzVFWWZPZkNBSnhJMFg4ZDYx?=
 =?utf-8?B?KzJ4di9jVWtiS3RydUtYZS9FUkMwNkFQM25DeXpYdERiQzBMc3MrTUQzQW5S?=
 =?utf-8?B?aE43YXF0aCs5UThvVG45YTljSWhKNUV5WGV2U3I2QjJsZ3dVODR6Y1ZCeElt?=
 =?utf-8?B?NlhNYmtwQmJmYTRHd1gwdzdjZFQ4ZGh2MVBaREoyeWh0ekhWUzdMUlRybnBq?=
 =?utf-8?B?eDh6SytTMU9rdExRVU9ZUG41ZGRkVnNIRjhrQlRNZWd4bU1nNXVYN29LRVVT?=
 =?utf-8?B?V0FBYzVWci9oWnZXU0p0eFB5eFYwYVU4cDZUOUx2bGNPRVp3WHB0TnNtbHFM?=
 =?utf-8?B?QjJWVUlsM096aTFkN0d6L2lLMGwxcEpKSGFlQ1YySHI1L1U3TlVmNTJkeEE2?=
 =?utf-8?B?VFgrVFpyVmZ4cy9PeFpQdXVnVWZ3d1luZkJQUHlXWXNxQXJoMS9LOWN2ZEtR?=
 =?utf-8?B?SW94dmV4ci9TRjdjNVVRdmxmaHlqbndZbFhqWDRic3o3OFliZG9neWVHcnJJ?=
 =?utf-8?B?WGhZdlJ5d2doeVdYZ0Q3aXFUQVpwVEpvTGJ3Z0VCbGVhQ2l4WlkwZUtPNzYz?=
 =?utf-8?B?bjRTU2lKbmtqOElsUGsvNmFDeElMa3FpUy9uV3BXUnRwdGhmbWQ2SDJXTjVy?=
 =?utf-8?B?cnFuTjJUc2txdHIxOFZ5VEZ6UjBPN01ya1B3Nm14cDRsNjJKNkFsM0RkQmVr?=
 =?utf-8?B?MGFrVXRRaTZlRTZqR2dQVHYrbERkcmtaMDdQVkhDL1dCczRQWkRwRVBhRkFz?=
 =?utf-8?B?bmZ4VWYrbTNBdERqSGl1bHFDa1NIaWRucnhZa1IyamZFdW1GdytkbGtEeXND?=
 =?utf-8?B?VHZzMGhKNE9tRzBXQ0kybnVBRlgvVUd4WklSR3pya0JWUkpnSk5STENxdzJi?=
 =?utf-8?B?K3FCWWE4algrMjBNTlBkdE54aEVQUVFWbGRUajhlVGErWTVRSXovM2JXK2RG?=
 =?utf-8?B?clpwRTIrQnN1K05OOENtSWZxRzhnU0hEUHB1NmRFb2kwaVF1QW1HQ0p3enhp?=
 =?utf-8?B?dm9FUzk2dGZXL24xZjRIMHh3RFF6SVd4UkNFeGRzaHdJclZVTy9ocHFoeHZE?=
 =?utf-8?B?NGhuTG8wSGZoYzViakovRWNYZjF5VmJhcmdvNHF3TXlRWE1BMFp3UllGZndW?=
 =?utf-8?B?bWpMdU9kM3JvTDlHQjhJOXlOTWxQS1dTUXlHVXR4Q2x6YVcveFN6OXh4ODFR?=
 =?utf-8?B?dmpta3gxTzYrUGZvS3dzaFlzRGhyUDJOK091enRrU0pvUFVlRlNuUGl2cUF2?=
 =?utf-8?B?eTBrT3g3SzZkV3QzZkthbGpEaGtrN2VpRGZORXZKY2kyUmhYVU5nQlBJVWp1?=
 =?utf-8?B?QndvTHVzRTRtdll6aXFoK0gzaFRvdDdnSFJIcXpYZWNvVEttaDVaLzJaQWtW?=
 =?utf-8?B?Z1owd2g4NXJmc1hKK0tvc0dielR6amh1UnlHZHRpU2NzUlE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:09.1851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b149c3-c6d8-4efb-7146-08dcf49dc8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add an instance parameter to amdgpu_dpm_set_powergating_by_smu() function,
and use the instance to call set_powergating_by_smu().

v2: remove duplicated functions.

remove for-loop in amdgpu_dpm_set_powergating_by_smu(), and temporarily
move it to amdgpu_dpm_enable_vcn(), in order to keep the exact same logic
as before, until further separation in next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    | 14 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 51 +++++++++++++++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  3 +-
 16 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index ec5e0dcf8613..769200cda626 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -140,7 +140,7 @@ static int acp_poweroff(struct generic_pm_domain *genpd)
 	 * 2. power off the acp tiles
 	 * 3. check and enter ulv state
 	 */
-	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
 	return 0;
 }
 
@@ -157,7 +157,7 @@ static int acp_poweron(struct generic_pm_domain *genpd)
 	 * 2. turn on acp clock
 	 * 3. power on acp tiles
 	 */
-	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
 	return 0;
 }
 
@@ -236,7 +236,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 			    ip_block->version->major, ip_block->version->minor);
 	/* -ENODEV means board uses AZ rather than ACP */
 	if (r == -ENODEV) {
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
 		return 0;
 	} else if (r) {
 		return r;
@@ -508,7 +508,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	/* return early if no ACP */
 	if (!adev->acp.acp_genpd) {
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
 		return 0;
 	}
 
@@ -565,7 +565,7 @@ static int acp_suspend(struct amdgpu_ip_block *ip_block)
 
 	/* power up on suspend */
 	if (!adev->acp.acp_cell)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
 	return 0;
 }
 
@@ -575,7 +575,7 @@ static int acp_resume(struct amdgpu_ip_block *ip_block)
 
 	/* power down again on resume */
 	if (!adev->acp.acp_cell)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
 	return 0;
 }
 
@@ -596,7 +596,7 @@ static int acp_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
-	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6c0ff1c2ae4c..2924fa15b74b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3469,7 +3469,7 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 	WARN_ON_ONCE(adev->gfx.gfx_off_state);
 	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
 
-	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
+	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true, 0))
 		adev->gfx.gfx_off_state = true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..0c3249db2f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -787,7 +787,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 			/* If going to s2idle, no need to wait */
 			if (adev->in_s0ix) {
 				if (!amdgpu_dpm_set_powergating_by_smu(adev,
-						AMD_IP_BLOCK_TYPE_GFX, true))
+						AMD_IP_BLOCK_TYPE_GFX, true, 0))
 					adev->gfx.gfx_off_state = true;
 			} else {
 				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
@@ -799,7 +799,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
 
 			if (adev->gfx.gfx_off_state &&
-			    !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false)) {
+			    !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false, 0)) {
 				adev->gfx.gfx_off_state = false;
 
 				if (adev->gfx.funcs->init_spm_golden) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 480c41ee947e..9f5a5b2e6de6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5314,7 +5314,7 @@ static void gfx_v8_0_enable_gfx_static_mg_power_gating(struct amdgpu_device *ade
 	    (adev->asic_type == CHIP_POLARIS12) ||
 	    (adev->asic_type == CHIP_VEGAM))
 		/* Send msg to SMU via Powerplay */
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, enable);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, enable, 0);
 
 	WREG32_FIELD(RLC_PG_CNTL, STATIC_PER_CU_PG_ENABLE, enable ? 1 : 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index e9a6f33ca710..243eabda0607 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -356,7 +356,7 @@ static void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
 	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
 		amdgpu_dpm_set_powergating_by_smu(adev,
 						  AMD_IP_BLOCK_TYPE_GMC,
-						  enable);
+						  enable, 0);
 }
 
 static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index c1f98f6cf20d..3f5959557727 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1956,7 +1956,7 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->flags & AMD_IS_APU)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false, 0);
 
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_0_init_golden_registers(adev);
@@ -1983,7 +1983,7 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	sdma_v4_0_enable(adev, false);
 
 	if (adev->flags & AMD_IS_APU)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 10e99c926fb8..511d76e188f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false);
 	}
 
 	r = vcn_v1_0_hw_fini(ip_block);
@@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
@@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, true);
+			amdgpu_dpm_enable_vcn(adev, true);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e0322cbca3ec..697822abf3fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	int i, j, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
@@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 power_off:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 6aa08281d094..0afbcf72cd51 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1013,7 +1013,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1486,7 +1486,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6732ad7f16f5..b28aad37d9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1142,7 +1142,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1633,7 +1633,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5512259cac79..d87850dec27c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1089,7 +1089,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1615,7 +1615,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0d5c94bfc0ef..6fc52a1bda31 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1092,7 +1092,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1366,7 +1366,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 	}
 Done:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 71961fb3f7ff..398191a48446 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1001,7 +1001,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1278,7 +1278,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index fe2cc1a80c13..58f0611b8fb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -762,7 +762,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1009,7 +1009,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index bcedbeec082f..8531e0993b17 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -70,13 +70,18 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 	return ret;
 }
 
-int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block_type, bool gate)
+int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
+				       uint32_t block_type,
+				       bool gate,
+				       int inst)
 {
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
+	bool is_vcn = (block_type == AMD_IP_BLOCK_TYPE_UVD || block_type == AMD_IP_BLOCK_TYPE_VCN);
 
-	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
+	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
+			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
 		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
 				block_type, gate ? "gate" : "ungate");
 		return 0;
@@ -98,11 +103,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 				(adev)->powerplay.pp_handle, block_type, gate, 0));
 		break;
 	case AMD_IP_BLOCK_TYPE_VCN:
-		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
-			for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
-				ret = (pp_funcs->set_powergating_by_smu(
-					(adev)->powerplay.pp_handle, block_type, gate, i));
-		}
+		if (pp_funcs && pp_funcs->set_powergating_by_smu)
+			ret = (pp_funcs->set_powergating_by_smu(
+				(adev)->powerplay.pp_handle, block_type, gate, inst));
 		break;
 	default:
 		break;
@@ -572,12 +575,38 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
 }
 
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
+{
+	int ret = 0;
+
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		mutex_lock(&adev->pm.mutex);
+		if (enable) {
+			adev->pm.dpm.uvd_active = true;
+			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+		} else {
+			adev->pm.dpm.uvd_active = false;
+		}
+		mutex_unlock(&adev->pm.mutex);
+
+		amdgpu_dpm_compute_clocks(adev);
+		return;
+	}
+
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
+		if (ret)
+			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+				  enable ? "enable" : "disable", ret);
+	}
+}
+
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
@@ -597,7 +626,7 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
@@ -607,7 +636,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
@@ -617,7 +646,7 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s vpe failed, ret = %d.\n",
 			  enable ? "enable" : "disable", ret);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c41..e7c84d4a431a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -393,7 +393,7 @@ int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit
 int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit);
 
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
-				      uint32_t block_type, bool gate);
+				      uint32_t block_type, bool gate, int inst);
 
 extern int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low);
 
@@ -442,6 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

