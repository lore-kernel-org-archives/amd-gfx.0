Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF11DC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D89F10E769;
	Wed, 29 Jan 2025 08:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y1uKiVhH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A8B10E769
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzeNKce8rVJGQOGo6a7jWbxngDFg6GVHynBzT1M3HYbqkXpjsVziOggdw6CMfdeHwPgsz3thPfFd4gtPkyD4eIJYlVbncW2VRsE7rGQT/KZQgg0HujXHxcE/XYJ78Tpjxd+SB0ewnOOo0xrRXkWamrHn9xQyfXCYcUkPgjHi0CuAR02ibvobt0TpoIG9DWI4XYSRwCPIvuyrCJddBjNblfcU9+M/SFVBBBGEMGqVQxTX8GI9DXb8ql2uNdfD1wWOo9qI+/AJaLGsSlanrqa9OI8pUdcZnqDGUwAGU/VB2SOo5C7grREJ+Url+QwhjczvR7jOnb4KklnKo5ysg1HefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8itppHXstJqf4WS4EupyrhT8Wv9W31KqEoiKOgvxr/U=;
 b=SZnX2k8RXkZzcDxKC+xMQVZdaW0xT9E+rWw8b6vkhtNcIdFpcJ0WzWY670wBUDLQRsQp5xBopFXqt8K/rgUOgLyN/vQ7/a+M27TgeylRJX3zHQPjDSbJyc0DOlgp+XATvtvPrkBkDsn/+VPauTm7qgJhnuaMih99QzvQ+xTw0RlO0YYZYngqII3wUw+JwDec7RmMZNpunK3tkG6ApN1eAO8mLa0HgH3rcRaxVXlyOv7ghya26htYkyD4frAKRUuMuEsZU17E9HsoYinH+3x0pfMamBz7LS3p5R7fhfOBOxFOgZPyXNd/RWCRGXRsDW5rn3wdRqhaWxqjUqVM+MlcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8itppHXstJqf4WS4EupyrhT8Wv9W31KqEoiKOgvxr/U=;
 b=y1uKiVhHZMQuaenvV6k1bklot9DPNIBJIdjdDXtVMTPOg5UIY1YWwNCBtigI5xafb3QoynyI4D0qZgAoOFr0dcol+TbKfLSoxNRjwg4LIb9e2U1t1zInV8lwS/N1obuNDupgDsfuq6jjdqochtoH8oXP24fmZZBNNobvc3Tk0KQ=
Received: from SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) by CH0PR12MB8578.namprd12.prod.outlook.com
 (2603:10b6:610:18e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 08:49:29 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::3c) by SN6PR2101CA0005.outlook.office365.com
 (2603:10b6:805:106::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 08:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:49:28 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:49:26 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 9/9] drm/amdgpu: Enable devcoredump for JPEG2_5_0
Date: Wed, 29 Jan 2025 14:16:43 +0530
Message-ID: <20250129084643.507727-10-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a75e83e-1915-4edc-a720-08dd4041d777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUthMUY4TEJ2Uk13dkRoUVZlSGNobWMrK2thVElYQzhiRDhEYXgwSWU0alcr?=
 =?utf-8?B?RE5naVFnYzY3TDE5QWlOV1FybC8wbnRaQ1UwaFdvWGJQeVdtNThjWWdkU0t2?=
 =?utf-8?B?V0NBMDBpemgvRDZxZURsZGtzVzUrTDRqUFRFdmtPbUs0cE9CNVZUUHRFNytM?=
 =?utf-8?B?bGhCbWswak5ScXV2K2pVcUdpbk80UkNydjVFei9DSllsOTJhRU5ydzdUOHQy?=
 =?utf-8?B?NHZIWFJtWFVJMzlCdlV6TjBFR0h1WGJlUCtDSXdVQnJLaEhhLysrcW9DS0JK?=
 =?utf-8?B?WFBlT1JmSmRJa0M5MjNMWVJiRCtGWGxHMUxMQmV2MHZMbTZkRExLaUVod1Jv?=
 =?utf-8?B?SU5PY2FFdmM1dExNOEtMNUtUZE5YeEtvSXgrb1RzOWxJWVQ3eXREWC9DS0FC?=
 =?utf-8?B?MkgyQXZtSTQyZGpSc09oUFVrMkYyQThDa0M5S2tpaUo3c090aWVOV01QSlQr?=
 =?utf-8?B?RFFra25PMG1YTHRCQ3Z1b0tabXpqZ1dlMU9PVGJScjZPRUlzZ3dWZlZzNms5?=
 =?utf-8?B?QkNPd0JWNXVmN1k2c1FmbmN1VTNBckhZMTdPa3N6SHU0blMyZVpsTVhlU2Q5?=
 =?utf-8?B?eXJ6OVJRUmRBWE9tZi9nMUZtYU04QW05YTJoS0E1NFpDcHNsNVV2OUhwT2xY?=
 =?utf-8?B?czR0ZnN4SndOMFdjUXRVb0U1S1pkK25XWUJSZWdEL25LdmM4RG15UDRrOVRZ?=
 =?utf-8?B?WUd3UUMxSHI5bGVISjZDMHF6MnBEYytacUtjWWppVlc0SEIvRkcyMTVOMlZC?=
 =?utf-8?B?ekxyQjJDck9KazhPVktGTWQ2L3Vpdkl6c1RDUUJ0UU9rdWd1LzFsQkFjOVNV?=
 =?utf-8?B?Nmx4TlF5VDVuS3U5V1ZtcGF1bTBiakJMSUk1RHZaN3VlWXBHUU95YkRsdFVh?=
 =?utf-8?B?SER4b3ZWSHlHMXdvVmV0a0Y5eDZLbCtZTGZ5Zk9PVThaTEFMdmRNK2tBUi9n?=
 =?utf-8?B?Y1BCOUQ4bDRiZ1paRUk0Q2xpUUtHTi9TSWp3dGNWTG9SaEF4OThCZGpoeFlo?=
 =?utf-8?B?WWxYSTB6akRycjVrRUFTSkIzeGdIL2RKWHRTVzFuN3RKWCtFUXBraUNlWVpl?=
 =?utf-8?B?VGp1cjYyWUhsRExtZVRnSjN2NFdwdlBYY085VytXMjdEWGx0RzNFRVJRb2lL?=
 =?utf-8?B?dTNyVlBqb3c3WnlyRXJYQ0dRRGsvdEVRbnByd1hzTC9oSVl5dHNrYUpLUTdQ?=
 =?utf-8?B?a094QW41YUxGR3E5NVJHWmNieXl1a1VLeG1PS016ei9xQmkxOUYxWUUzQnFY?=
 =?utf-8?B?RmRIRThIQVNVbXNzSE1NY0p6RzdURE5DLzVIcEh3bEZuNStXK0hxN0pwdTBz?=
 =?utf-8?B?THZEckpqM2VmVFFMQU1EUW40TVNsM2ZCY04vM3c0L291NWJEWWVKWnZ2MFNO?=
 =?utf-8?B?a0drMjFpWjZkTVZhQUFzaUt0OHBUaTFyMDE0WThyeXREKzZSa0ptdUZ1Q1hQ?=
 =?utf-8?B?SWpJYU1wL3J5aHFRbC9ZTm9WSVhZOWVxNGJQcXB1ZmtMUWlGUzRMRmcxLzZD?=
 =?utf-8?B?R2JJMSs1TG5oR1ZGSkJDVDNpWjFDT00vNHNmdXE1M1BTRU83bWFTMmhscFh3?=
 =?utf-8?B?eFFMQnhRcTlPMGVUUG5GNVpQd3BhR05YaXRVbitrbGVGRUJBWjQ3eHVjeDNx?=
 =?utf-8?B?OHoyb2RrMnhNbjJZaktXWnZ6K29OVmZhTGdheVVrd29WNkhTYjczWHNXK0R0?=
 =?utf-8?B?eWxsYzZnSlRCTFdoY1g3a3VTbFI5V1R5a2hDNklZUWVla1NaZ1hVVGtxTCsy?=
 =?utf-8?B?ZGlSeks5Nm02YXdCYXVIYkc2UUl1OWJ6dmIwUGpPd0Jldm5tTEdOMExHYW5s?=
 =?utf-8?B?dVdNUUJ5VlBJTkg0amEzbzNjcjNiTjJYNm1tUHd4djJsU0plWmR2MWl0T3g5?=
 =?utf-8?B?RFE2UHZTM2dsN1prR1paaEVhQ0h4SktKeHl0UXV6dEZhc0JFTkZ4MlRYcFBF?=
 =?utf-8?B?Q1J1eGsrNDRIYWNjaGpISTFObHBSNDFSNi9zQXZnZXdHdCthTDlFS0lka2wy?=
 =?utf-8?B?cWoxekRaem9BPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:49:28.7535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a75e83e-1915-4edc-a720-08dd4041d777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

Add register list and enable devcoredump for JPEG2_5_0

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 11f6af2646e7..536a6101dcf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -36,6 +36,22 @@
 
 #define JPEG25_MAX_HW_INSTANCES_ARCTURUS			2
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_5[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -147,6 +163,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_2_5, ARRAY_SIZE(jpeg_reg_list_2_5));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -168,6 +188,8 @@ static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	amdgpu_jpeg_reg_dump_fini(adev);
+
 	return r;
 }
 
@@ -623,6 +645,8 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
@@ -638,6 +662,8 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
-- 
2.25.1

