Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163EDC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEBE288C11;
	Tue, 28 Jan 2025 09:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1tq/8z0O";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9E210E60B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTRB+Q31kNKP7Me8wBjj7BZenjNQKucKW/j16gNbaM2u3CSLnewFOIYFyPugjSHYCpAfQbyxvKss1jHnJBvAw+qJkk/stXtMlrJ0cWcTN5BzYdFr5fXtX3T+49meofkm3D/HetB0r1weWK7X9HQ9hFavR11TVN4rbL9pjHIZdAnSaR/l8Hqp5a9QLg42xJTZQlYXeAqRRi7jmdBgP5DhXatMJtLNWYPfF7oXrwXlUJzgk0JZZwSq7Hk11kZzFWPOnsOOtjdpTS1JolxZ6qrB0/XCsFxws8tMe6iTO8TxF1ItkDDQVxbMxGBohAjuvDQOaBIhplaVZVXi0UeJTIfqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXd6v5F+n0NXQO0cQQFUIzTghJNicp9+ZqAog49LjSA=;
 b=WdnRHJ2iHgltYe/tEbWq8QHXE4/Vu2QDboZyldfaIBQu2iIpLp7P2VGzyYBJx8LfvAcNkbzAZCgwQRn6hJztxsJdn9AxzaSgbRzTXXS3HPP4c1Nq+oOg3quyI4AjjmIlVhqlJsQFeEU94ybm3FtLWWhy2SpOvIem9bOQH/RLbGqmeYjg2ZbjeBnT5eGYZdg1EEqNYfVbigvUE1f69prBZnYjjeuaI6Sy9Uk7horP29KmuDXWJDj8UelzEmym2nB1gNUee+PSYjHZd+0bXtMGkFHGCvXpbGzyrLqetyfLnjG9rl9hkYqKjZYXu4CBEmA6yi4mlMFaA5aDcp0sqcCpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXd6v5F+n0NXQO0cQQFUIzTghJNicp9+ZqAog49LjSA=;
 b=1tq/8z0O+pr74lAQ2Wt5BnNiXX5RuqhjqRWX5IxYTSTDw/kM2Wh1Z87veJU6eyPjJ6nCpULmPZVuCUarfhz5vdaIUMZ0/+Ia2viVr+Rnj9TWvhic2rTyO9wbPVEXEfhc9eJgTd+Dm58HRL3jDCSR8AWVEKjQGuCHFHhUSo8o2QA=
Received: from DM6PR13CA0025.namprd13.prod.outlook.com (2603:10b6:5:bc::38) by
 DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Tue, 28 Jan 2025 09:12:34 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::17) by DM6PR13CA0025.outlook.office365.com
 (2603:10b6:5:bc::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.16 via Frontend Transport; Tue,
 28 Jan 2025 09:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:12:33 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:12:31 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: Enable devcoredump for JPEG2_0_0
Date: Tue, 28 Jan 2025 14:39:49 +0530
Message-ID: <20250128090950.461291-9-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5cccf9-61b4-477f-3326-08dd3f7be6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVZYK2dJV1NLUXE0YmtaOElQbUdYa0xJejFUdHlTVFdJN0ViNFM1VnE5LzZH?=
 =?utf-8?B?aUtlaWx3NTd5SEtnWXlnN0lnTkhtZXc4ZUMwYVNyYnBaSWFOaklPcFZTcWNH?=
 =?utf-8?B?WnhzM2M0czF0WU1CSWpJZVlNNCswQnpJNnB6QmM3eTNqd3FJUUNQTXZvUk5x?=
 =?utf-8?B?L2VRb0JDYVczaFZvSGhsd1hxN3hCUFRsYkNRZG5MYVQyWk9KdVo2ZTBCTnkr?=
 =?utf-8?B?U2puMzhGSC9maXZrL0kveXRsTjQxaTFIV1krRnVCSHNLdE1Hem1pS0d1bU43?=
 =?utf-8?B?dktqbHo2elhEd1hKV2JaK3NUcXhiMGRQNWp2VXFnWTVFa0JsR0VLYks2L2li?=
 =?utf-8?B?ckhoclJjZEV0aGdIV2hrSDQ2L29WV0tlYSt0dTErWmI1MTlNSk5raDNBNnpl?=
 =?utf-8?B?Nk4wSStqOG9xUlVvbW9UR0xBOWE2SytoQjF4SzFlTzFYVXhMYkYrQ0JwcGdR?=
 =?utf-8?B?RzJWa3FNMElySWNzdDdrQUhTMFA3bmdmc1hzZXBpUnJCUXl5S0lwR3M3dEFs?=
 =?utf-8?B?SXIyRENVVEc3NWZIbWhmSnREZkdITXRyNCt3WEF0dFM4OElGSFVEb1ZlWlJG?=
 =?utf-8?B?bDF6UTRJbVhic2dUYjRXemZHdGZ2dEZDQitJU2FOaVozeEJ0V3dHMGhYMFMv?=
 =?utf-8?B?eGo4c21PdUg4MVI5Q3NqdmJwOExwMDBZSmRzek1iM2Q1NllpN3hIaVBKanRw?=
 =?utf-8?B?NUFQZDlvbFV2RXc4V2hBKzk3dFZTK25GN3Bxa3NWeXJGL2s5bXh2bEV5dUYy?=
 =?utf-8?B?WUVyY0lEd3oyMDZ5WHR6V2tkMHJBYzQxYmlYMmNSdSs0bTBPRS9ZbUFnMUgr?=
 =?utf-8?B?U0lQb1dvYlpMcFlaOTdEd2hIWnBtMmxzYVJhcmFsL2N3a1EzMUtoampVYUxP?=
 =?utf-8?B?Q1pWUDR0NHdJRSsreFVGc0ZCeUJ0eUxsMmlrRXBuNVNaR1l2SlVwTEltRWJn?=
 =?utf-8?B?T3duSzd1TDA0TXk2cGQ1ODZWNjhqa1VzMzduNGNILy9aSzVmZ1VudGFpZEgw?=
 =?utf-8?B?RVhSOUFlM1NyZnZud3NNRGtGSi9LY0E0cy9odTA0dklaMXhqS3RMRGo4WTBy?=
 =?utf-8?B?VTkrcmx6Y3l0K1pFcllLSmZmd2Q5NWNTeEoreW0rOHhLdFlaSlNmckd4T3M1?=
 =?utf-8?B?V3Z6Y1prbURmazQyL0cyUFJpVlo4eUdCTTM1bitQVGpMaFI3cXdWSUFVYjk2?=
 =?utf-8?B?SkNQZTVhVE5sNGtiU2o5L2R5WHRSVXp6ZVdQRGF2cXVYS0ZGVTNCbDI5clQr?=
 =?utf-8?B?dGNVSkxiS0ZNU0d4eGR2UmhCUDZ5SXZYWk9ZUEJwVjBPeGY4ZjVPTlQ4NEJZ?=
 =?utf-8?B?OTZsOGtLcUpzV2o5OUV0WmpmdnA5NjZPZXBsc2YrSlN4NUJXUGxYWXRtVWMw?=
 =?utf-8?B?NU1EWW1ZSDJvanQzcU16Z3BEaklybVJJZ0U5WEoyV2VycmpJNWt0cmF2ME1W?=
 =?utf-8?B?UnJzOFYrYytHTmx6WDF6OWZicTczR05uRVRyRWl3RzVCN25ENUQ3TjBHK3pa?=
 =?utf-8?B?b2lJUllsQUN0cUVEVFQzM0RKb29hTzhURmwrM2VNbWJiWEVVY0oxVmNQbkFB?=
 =?utf-8?B?K0ZBZmZEZE5OblpxdzZHL2dNMllZZys1K0F3a1RQdVcveUdiZThDSnVkSTB0?=
 =?utf-8?B?YklybmZScFhSQVZINTZDOFhmMjl1YnpGanZzRWE2M1RVM0xGVUlSSE52ems2?=
 =?utf-8?B?eW5mMXhlZWM4Q0dybXJqYzBwWjBSZVU2aUFmS08yWjMvb0E3dnlGWXkxa2dt?=
 =?utf-8?B?Si9WUXVUdE12NlVRRHV3NkJJN3FDejRlR1BQMTZHby9ZMVNQMlF2alRwd2NG?=
 =?utf-8?B?UUZyaC9BWFYyWjBsRnhodWdESE85bndqWWE4bHRaN2pWY0poa05aRXlPc1do?=
 =?utf-8?B?NU8xaWlld1ZyY0NQdmgrU3lhSXNVZVJoQkVDVmQ0SmdVRmpHWnFtR1pjWWZG?=
 =?utf-8?B?dUU2U2tuY1R4dFBnZ2ZQbEJia0p0cGNGMExLaG96ZGp3SjUwY3E2Z2p3d0E4?=
 =?utf-8?B?Q250N1FaaHN3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:12:33.9506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5cccf9-61b4-477f-3326-08dd3f7be6b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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

Add register list and enable devcoredump for JPEG2_0_0

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 7c9251c03815..4476769e94b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -33,10 +33,28 @@
 #include "vcn/vcn_2_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_0[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
+static void jpeg_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block);
+static void jpeg_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 
 /**
  * jpeg_v2_0_early_init - set function pointers
@@ -98,6 +116,11 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_2_0),
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump)
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+
 	return 0;
 }
 
@@ -119,6 +142,8 @@ static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	kfree(adev->jpeg.ip_dump);
+
 	return r;
 }
 
@@ -739,6 +764,17 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_2_0, ARRAY_SIZE(jpeg_reg_list_2_0));
+}
+
+static void jpeg_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_2_0,
+				   ARRAY_SIZE(jpeg_reg_list_2_0));
+}
+
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.name = "jpeg_v2_0",
 	.early_init = jpeg_v2_0_early_init,
@@ -752,6 +788,8 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.wait_for_idle = jpeg_v2_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_0_set_powergating_state,
+	.dump_ip_state = jpeg_v2_0_dump_ip_state,
+	.print_ip_state = jpeg_v2_0_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
-- 
2.25.1

