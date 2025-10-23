Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E8CCCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 05:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF8C10E86D;
	Thu, 23 Oct 2025 05:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y6LN5tN7";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB25010E86D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 05:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShScmOykimgO+XQ5Fp0Qju0bCjgJO/Z3RKkkMiBvCEjZILCToyzdvTHeKl6umfEEYPyB/bzX4xzW/i4QVf+EEEJfaEktOb9c3VJRHFuoyuMXWfDy5BaO8bbF84hcoN4imvh40nmV5W9kslMShG5aunBICbMTgC+e4KuHre66yPEQT/Zkj5Wb7wRPiUv75tO7y0Lbf3eoSzS7P1BSC+iPn8JL8W/zcz5y4SpbX4vT/yH7DfJ/08ZEj+I8hJowjMLUt8KL4vDXM2rJSHU1MsriYHKAeWPnBw65NJIYWD96h8kfahfa/tYnSup4l6OnrCa1nuRaa29tszOmKOrExq7WuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QPgS8OceTYbqBVnk924EhJ07fylajUY5JRh3Coo2hA=;
 b=mka26EDWV2HWauZtOgARDAYygKxuWU8SfnAKUsqOTvCvgqVV8te6uiHwAWZoyb2UeIcb7stc/eC8+nBml7iJfQgdgQP099J2+eZDLk683vYwnJhrzBLNU1o6U2yfppXjok9L5WJCj4qMDn3gxM2h5i09mmiDbz0huI072iJ5kKEmNKab6hmDnXRM3YoorsAs5r0qebQY+K+h9G8Y5JRh/X2ie0ROVqKwD81hECPKkNY4NqvdCCtpepWe6wMXB8If8dVvKggq6oeiXNil15IhH5nnH5wCndUdx5FHmFtx4DjjNoR/+EZ7tvzYZpsr0M+crfx+wBxqbUvWXhwHgZ/BvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QPgS8OceTYbqBVnk924EhJ07fylajUY5JRh3Coo2hA=;
 b=Y6LN5tN7I047fo8lMvgMPSGZ2RIkil4W/lDt3upQHRGC3TgQy8IKsrfKqjq+Uq0hVeMFsHb8YDOLNmoT+Kj6EIn9rQC0Gxe3ybXWwkmSUTjMQ+Abd47m+A9NiRX+X97ehc5CDmevzuYlILKBVU8FJtxQEd6lPPMkzkPU9oNXuaE=
Received: from BN9PR03CA0442.namprd03.prod.outlook.com (2603:10b6:408:113::27)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 05:35:55 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::8b) by BN9PR03CA0442.outlook.office365.com
 (2603:10b6:408:113::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 05:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Thu, 23 Oct 2025 05:35:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 22:35:51 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix pointer casts when reading dynamic region
 sizes
Date: Thu, 23 Oct 2025 11:05:36 +0530
Message-ID: <20251023053536.265550-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022133425.245953-1-srinivasan.shanmugam@amd.com>
References: <20251022133425.245953-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: b065b488-f3a2-4790-3266-08de11f60914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3pSUWxjQ3lxcThkbnpnelJSNmZDMytnQzlnMEZWbW1uMytTUDMySWQxeEh1?=
 =?utf-8?B?STc0NWZTRGJ4KzNEZlJrSzlrOFNwcy9xSVJaR3RSa3BEcElVMXByTU04dHQ2?=
 =?utf-8?B?M3ZCam9ZWnl2RXpPL0lHVi9GSmMzcUxjU09aN1h5NHRPcU9wQlJoU09tbUlL?=
 =?utf-8?B?d2lZRFJWdnJOR21YZEhtWkE3bFNJQ2JqazltN3EwWDY0REZsU1FScGJERWFJ?=
 =?utf-8?B?S0ZNdVFTYlBzRWp5M0R0NHpabDdzcndBc1FNNnZYWmQrU2thZFZwSzRCVVhs?=
 =?utf-8?B?SUtwckh1V1RVeUJSd2h4aW5pY1F5aUtVa25uNVZQODhZVDRqMWI4dk02NW04?=
 =?utf-8?B?SlFqU2NJSm9pL2ZobnR0RytPSmhQVWRuaFFpb2xJSDRtZ1pJMk9sN3BEekl4?=
 =?utf-8?B?RUZUVlllTzIxODBTTlNxRFpLTjYwV3hwNUpMd043aDBSMDNQQ05vc2xNbGE2?=
 =?utf-8?B?S3dva2VEUTRZRXNETVo1VjIyZnczaUpza25GRENtZCt2RExWTUZwbjQ4NHhK?=
 =?utf-8?B?YncwNDZYaGl6aFV6MVNjaXZzS3dpa1hhMU1jOFZXRVhUSjdOc2hpQXJZTEQ4?=
 =?utf-8?B?ckhCQTJEUW1uWGhZek1OQ1pYc3RJNXM5VmZzWVNFOUUwUkIzdlBrT3h2WlBm?=
 =?utf-8?B?elFDUHg1ZGh4d0hlSE8vYVI2d2g4b05CajJkeXo5dnJ2VEpjYTBPdWR2anZn?=
 =?utf-8?B?Y052TGswQTc1Syt4TEo4SHJqaGhMd0ZUTkRyWjFKaVpxU1pzQ1hJN1lSOFRZ?=
 =?utf-8?B?L3dtazJBUGc2SURCUUtiOUR1enNnSlU0ZW1jVG1VcHBOSVRCSnhJaml1RThV?=
 =?utf-8?B?aU5aTTVZc1BqNDJqYUl5bVA1cFhFZlZaZXVtTjA5QVJkaGlFa1BXdVloR2Ra?=
 =?utf-8?B?djRoL1hCRzlWN1l0UWJ4RWxUOS9DY01jLzFsbzVSUFdXRTJIV2I1S3FBc3Jl?=
 =?utf-8?B?eVNycDlmZnlNOXM5cHEzZUU0eGMrZ1V5RE8vOG12NTBLTk02R24rY1pzMjdz?=
 =?utf-8?B?YkxNUUY5TmtIRW9ra2d4bzhPdlBFSkFkdjB1R0JyQUNzZS9WOEFpaE9YV1Yr?=
 =?utf-8?B?MzFXK0ZMZVBiMVoxKzhpV1RHT1ZkYmJCcGNTZlJYcmVPaU1YRGlOS0NkQ2R1?=
 =?utf-8?B?bUswZ1RkNXpnQVpaSXRrRUs4SFZRME1jRzI4blBNOCtrVkJDdnBLMGhaWkdx?=
 =?utf-8?B?R20vN0Q0QkZyV2ZYTGQvSG1Ga0x4clNZd0dNcG01TlB1WnhDOExmYTFWVWZq?=
 =?utf-8?B?TENib2Y5a3JPLzJUbUErTjZWeDdkWDV0djFxUytWdlNIRGJJU3puUVV1SlNR?=
 =?utf-8?B?cGVMcEVxcGtOa1JMTU1TMDhtcTVIWEllZUx6cWp2cWtVQllNa1pSelhLbGha?=
 =?utf-8?B?YS9nVEVZZExPYi9PeUJWSlExYzNibXJwRWJmeUF4VDdwakE5cVRRMWhCZWhE?=
 =?utf-8?B?UlNhUGxVQ3pXR1ovWFBHTGVwS0FLUXZaRkhaLzFaK0E1VjBTTnM1MXhXUlh5?=
 =?utf-8?B?d29SbVowZ2djNWhNeUFDbTFxVVV1TXRBeFB2bHJzTTFHazdRVFpiNS8xMkFn?=
 =?utf-8?B?SWpJRTQ5T3FBRDRCRnRxYUsrYXJlNm8vTFdjV0lyYnRoMzRwMVBFZ000NUdy?=
 =?utf-8?B?cEdpSjlDV1N4RjJtMjgxWnVuSlZFbjlyT1NLTm1INzVLMGxibHN0S053RE5I?=
 =?utf-8?B?SHZQc1BHbWlpc0F0bVk3d1FHMjZvSW40OENnRkRqOVRMRHE4MkU1QXdDcUx2?=
 =?utf-8?B?Rzh6VFNaS0cxVVNOL1ZyZHF2Mk8zcVcvc3ZLbVlrNW1JeVRiSFFtclV5QXFC?=
 =?utf-8?B?cTJOSFQyelVpNTQ0SGxBOXBaRUt1Nms5VUNJUUpoejFuV3pZRUZoZlZPd1ZG?=
 =?utf-8?B?VWVJSG1aSENlRXFUQmJCMytDN1lHWSt5eDZKUDF0ZWRCcWp5SE1zbEpzSEFj?=
 =?utf-8?B?V1lORGJEOXpaOWZKSHkwS0x0ejNJWHpyWDBqWUNwQ1VzUmJVZWM3ZnF1Z2Ez?=
 =?utf-8?B?TFJ3VjdQeG41Sy8raitQbThRRFp1bFdiY3JjcmZGbjFhaVY0L21XSGkvUzRH?=
 =?utf-8?B?RHV2bnBsZytLQ1VZTVV3cWJKbGFCVEx4RWhpQU01ZjFPZTAyYlhNNS9qcEk3?=
 =?utf-8?Q?l5LQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 05:35:54.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b065b488-f3a2-4790-3266-08de11f60914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967
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

The function amdgpu_virt_get_dynamic_data_info() writes a 64-bit size
value.  In two places (amdgpu_bios.c and amdgpu_discovery.c), the code
passed the address of a smaller variable by casting it to u64 *, which
is unsafe.

This could make the function write more bytes than the smaller variable
can hold, possibly overwriting nearby memory. Reported by static
analysis tools.

v2: Dynamic region size comes from the host (SR-IOV setup) and is always
fixed to 5 MB. (Lijo/Ellen)

5 MB easily fits inside a 32-bit value, so using a 64-bit type is not
needed. It also avoids extra type casts

Fixes: ae92010fb321 ("drm/amdgpu: Add logic for VF ipd and VF bios to init from dynamic crit_region offsets")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ellen Pan <yunru.pan@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index db705bf723f1..35d04e69aec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -103,7 +103,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 {
 	uint8_t __iomem *bios = NULL;
 	resource_size_t vram_base;
-	resource_size_t size = 256 * 1024; /* ??? */
+	u32 size = 256U * 1024U; /* ??? */
 
 	if (!(adev->flags & AMD_IS_APU))
 		if (amdgpu_device_need_post(adev))
@@ -126,7 +126,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	 */
 	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
 		if (amdgpu_virt_get_dynamic_data_info(adev,
-				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, (uint64_t *)&size)) {
+				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size)) {
 			amdgpu_bios_release(adev);
 			return false;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a7cb4665f485..fa2a22dfa048 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -311,7 +311,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 			 */
 			if (amdgpu_virt_get_dynamic_data_info(adev,
 						AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
-						(uint64_t *)&adev->discovery.size)) {
+						&adev->discovery.size)) {
 				dev_err(adev->dev,
 						"failed to read discovery info from dynamic critical region.");
 				ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 66e9cd103597..38cc446500d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1101,7 +1101,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 }
 
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
-	int data_id, uint8_t *binary, uint64_t *size)
+	int data_id, uint8_t *binary, u32 *size)
 {
 	uint32_t data_offset = 0;
 	uint32_t data_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 2a13cc892a13..14d864be5800 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -443,7 +443,7 @@ void amdgpu_virt_init(struct amdgpu_device *adev);
 
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
-	int data_id, uint8_t *binary, uint64_t *size);
+	int data_id, uint8_t *binary, u32 *size);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

