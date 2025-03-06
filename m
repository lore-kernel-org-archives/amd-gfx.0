Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6435FC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 20:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC5E10EA85;
	Thu,  6 Mar 2025 20:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZUuF52zg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4DD10EA85
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 20:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsBJAU9HBG6X4syFhEJnfFdp57gMXZvKY9/PA48pZceMn3wY5BPnjk0kdr7xxapl9JkclR8tzGnqhdVUeq6mX+KyGn9/u+GVuR7jAkABkczMv5DPnZxlwK+v0yoOOZYlYHwVjqG5MLUaifAt4QAk1f4I6B6iovNGSjs9r7Nll/kRq89LPVo97wSDPetKMdQVqkUPlHp03cGGs3l5Qr29maoo5WunaorHjMFH1xAhdJjViNE3XAnQkd27Dj/IpSdsVoZkG2giOQ/Ru7LuaB2zghz0n94IcAQ+Ve4185iOQe30b9yNWwSmZLlIlcSh437z4JSaisB4yXz7vG7SXxAUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxGXnlgHt9C7/CCZ73iXfjRV8WQ14mulPokovLRSk/A=;
 b=O6iREsTFDuSjaVgbWHyTiOsqypvd09dXzFJiBNwfDvwVLlXivE89JSTP+VQW/B6PqKwiXjusWJnsvCUKnWTGQK/x+8jB4tAuIPMYLTigra2KW77va6fv02wNquN3To1oHfnn7X43H6XY+Noo31X7A2jEH8VCTMLL2IbQjI7T5TLgyIGhvAVbRgkSuZDB78nQSPdFrnWuxcV8nmxpfAtIP/svmjrNv885qCE+ND67ONuTnttscUI1dZ6erbpyFwEtSvRHAiKdX71a5RbtuzJR3Ty1IxWD/ujvOBYwA4nAj8rN/6ie0D1PShEkTxib+gU00HmN4FaoRscB7c5YnkhEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxGXnlgHt9C7/CCZ73iXfjRV8WQ14mulPokovLRSk/A=;
 b=ZUuF52zgBcCA1DfkfKRJm66OekzO7J7YLbj9/AfupI73tMLc9r5L3xua9PFV9JAq5ClRwQgUSq58kBZpwkpn17Hwg8ABPYA7hGaszYCHIw3PZzy62/F0SpXVKYOS9At0c3P2N5yE/V68M8pgc8N/jGLRvLBuW9MefCF3S/2QyWg=
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 20:50:39 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::aa) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Thu,
 6 Mar 2025 20:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 20:50:38 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 14:50:37 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] drm/amd: Fail initialization earlier when DC is disabled
Date: Thu, 6 Mar 2025 14:49:45 -0600
Message-ID: <20250306204945.2256-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f06c36-403a-46d0-f016-08dd5cf08d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bBM9J+2iWPCWSejvSkBAKlCszfw4/97iseRkuwwXdO4yrg6OKeUrG0nfDfDQ?=
 =?us-ascii?Q?FYKncK6nRjlM529XbDT6NE9dvYqgRz1trVh+ZVEVsRBjvTKJ1UWI0odKtWTu?=
 =?us-ascii?Q?EsyNmGYJ0xHf/WQ2KSBrNNxGy9rZIZ4k9nalE8XXgt+dhbuXK1w7dwdm+OrW?=
 =?us-ascii?Q?+DJNJBQxiwF2WkZXxdi8/Q60GZXAoF2TSFpU/WqkXa9WBVbrNYKW1EDbXLLC?=
 =?us-ascii?Q?mks1OjQS5qn2PClkIcZIUEim5gUWTL6Z2+/PAhWkUSJ44CWyjITSTpZCtA7B?=
 =?us-ascii?Q?Dghqw9XvpIvmylF6ZfmloUYdKnwa+Ium7f6M72G7LLjsT5nG+odfJUpjQ52g?=
 =?us-ascii?Q?ncysWjNSd6hMd3ARyh8m3+lSEhG4fUjUDKfG2gbEKkz9WbR9rWYTL112WKGc?=
 =?us-ascii?Q?6fsez+WZu38CFeGALvgektJOtegtMSU6sk5yK53ttokuuQ0oMjRoQF+sKMka?=
 =?us-ascii?Q?p4Q2KbiYMFyqY2nllzTgRbMTQn+VLSMzc6/9/35/dEz4V/vQv95esjBUvR+O?=
 =?us-ascii?Q?tVMQTEhQUX7xXRWQ53OkQwcIJbqxgHVy3qQ+kpuuS2+NTliHiQe5UbPIdqRk?=
 =?us-ascii?Q?un0vjRVgvx2jGpcaWQmSSQXrlfoNOmq5nHjl2Ib/uqMruasTjxEYhsBg84Vc?=
 =?us-ascii?Q?IUgzkj32gB6ZQ5xp8VFTbZQBfsPR+9BUmEuRiHajZUzgVhVTMyYr/PYczlYU?=
 =?us-ascii?Q?wc3mj63z0/tcnOFoiy+g5vSoiC6FNccwXaQ5EZ5NYkacLzIL+jbPIMc13+TI?=
 =?us-ascii?Q?hXqk1f1dtEEIBHW3dsVOHenzV3RsErLCwx3zx8YL30TvGe/6mszDvGcRAxu9?=
 =?us-ascii?Q?Tmt/XDTAYiMG40Y+1icQI4Z0gXdO6tVzkaS4dRhzrupoeQWprzMllhfZpyms?=
 =?us-ascii?Q?bAg0Up77LvWBFLZQ8OaaMvkxp3WamJw8fpPOWXB1UYHSC80PqOKkAOZrG74r?=
 =?us-ascii?Q?jngwirGqCB12Ixn/17IvAL/YlYMzgKd0i4IubHMXgM/0/TmbpD9sThs43RcM?=
 =?us-ascii?Q?Gbfop88DLs4bmlqbLa82yohB1fUqfhP4ck/kEKagfTGOeK8mZ8dKkJcjFAuG?=
 =?us-ascii?Q?TVMJk7I8XOpjoaBvGxEk4Ps23H1DWnr2komb3QokEIaruQGbeKhTWQOhveB+?=
 =?us-ascii?Q?BVNf0ZtNZ6JEWAepKmEOaHUJsurj7NTZuJuXYQYUuIKO5sgHkAIu0hx84+SS?=
 =?us-ascii?Q?booD0ozpCufuvv9vCOqBspTMaBO+Uh7NTHMRDfvFsADc8XFUbTdmieLdRSEM?=
 =?us-ascii?Q?Otrlb+8rxtr5NpZodShQjOb2TRYQFGWnHoCqGxE7N+HoBpLBAz9OQFOfc1aW?=
 =?us-ascii?Q?AaaVnpunQiiTZJUSnxJ/eHa6n8reU71FSmMnWhjstWqftPAjFhNoLTD+R4y+?=
 =?us-ascii?Q?axKr5Ak41/iiqGpSo6vTFDKnnM8eY6C9M5ukpiVR9i3HOmsuyf50L39LfIK+?=
 =?us-ascii?Q?CTIqh8Pb4IIVirliqMBkkpPV93eERmdcrL++MyeMBJHWN93dxYhzS1RPwyXr?=
 =?us-ascii?Q?Tc+dqR+DQPtNdt0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:50:38.9287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f06c36-403a-46d0-f016-08dd5cf08d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

Modern APU and dGPU require DC support to be able to light up the
display.  If DC support has been disabled either by kernel config
or by kernel command line the screen will visibly freeze when the
driver finishes early init.

As it's known before early init is done whether DC support is required
detect this during discovery and bail if DC support was disabled
for any reason.  This will ensure that the existing framebuffer
provided by efifb or simpledrm keeps working.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Use amdgpu_device_asic_has_dc_support() instead to cover virtual
   displays and bringup
v2:
 * Update commit message justification
 * Add correct "default" handling
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 49 ++++++++++++++-----
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a4258127083d0..ddd10e6345601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2134,15 +2134,14 @@ static void amdgpu_discovery_set_sriov_display(struct amdgpu_device *adev)
 
 static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 {
+	bool asic_support;
+
 	if (adev->enable_virtual_display) {
 		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 		return 0;
 	}
 
-	if (!amdgpu_device_has_dc_support(adev))
-		return 0;
-
-#if defined(CONFIG_DRM_AMD_DC)
+	asic_support = amdgpu_device_asic_has_dc_support(adev->asic_type);
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		case IP_VERSION(1, 0, 0):
@@ -2166,39 +2165,63 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 1, 0):
+			if (!asic_support) {
+				dev_err(adev->dev,
+					"DC support is required for dm ip block(DCE_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCE_HWIP, 0));
+				return -EINVAL;
+			}
+
 			/* TODO: Fix IP version. DC code expects version 4.0.1 */
 			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
 				adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
 
+#if defined(CONFIG_DRM_AMD_DC)
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
+#endif
 		default:
-			dev_err(adev->dev,
-				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
-				amdgpu_ip_version(adev, DCE_HWIP, 0));
-			return -EINVAL;
+			if (asic_support) {
+				dev_err(adev->dev,
+					"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCE_HWIP, 0));
+				return -EINVAL;
+			}
+			return 0;
 		}
 	} else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
 		switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 		case IP_VERSION(12, 1, 0):
+
+			if (!asic_support) {
+				dev_err(adev->dev,
+					"DC support is required for dm ip block(DCI_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCI_HWIP, 0));
+				return -EINVAL;
+			}
+
+#if defined(CONFIG_DRM_AMD_DC)
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
+#endif
 		default:
-			dev_err(adev->dev,
-				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
-				amdgpu_ip_version(adev, DCI_HWIP, 0));
-			return -EINVAL;
+			if (asic_support) {
+				dev_err(adev->dev,
+					"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCI_HWIP, 0));
+				return -EINVAL;
+			}
+			return 0;
 		}
 	}
-#endif
 	return 0;
 }
 
-- 
2.43.0

