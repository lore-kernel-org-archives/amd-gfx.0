Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D8C021BC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 05:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC40A10E211;
	Wed, 26 Feb 2025 05:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gDi5FBFo";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4720710E211
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 05:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+ZsIKs+sSc9JM8Xmxt1v6SfTiW4cH1LR4lW7XlhjWHV9ISAgzgoFVxH5e02jFu6wu99i3T4SAw4VeG/UzTBgw2B4ya7ujlAY1TamXd1BsMcob7HKTulI+kub9cVMMYSeGD6hy2+3StADS+db5cQ83dTUnsw/tXXF8ekIKP2b9MDpH6VC5jgGVlXp4cWmFMWFELrMGM4tXunOhWrkhVeBiN9L3mMOvIGR5q5OwBh0tuDFHZAJXmukvH0PjvysefLvRkmQ+wj3WudaseI9dfZI7zb0x7MVhCf6O48W9ZAxeCk/fEUfdBIPD+9pb7b9LDy3vawM0uTBfRl7mA/KrQSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pPEhHdkOzTa1xVqhchMeAYLb9Sr0RCvJwv+72HGu7k=;
 b=jBlm4L9Oq2crRg9SBmQPzXuxyhDrQZOluQK46j/C2rnPC7jtAPbqRwZPKNjX+Iex6HVV+kcovPu7YPx2DSPMI0qioE8oZkDjU8y46RrDhOX15t+OhBt4GxurECLM2cJffPOf9jQcudX9bmo5FhLHUDpKYJxDXyoDKaS5QfRqkQdlYBL8vlzukFbYXsW2QFDoCxE1Zjjjd5rtr+3rBz4JHI1yPetdGScDJS4iLhXx3zhwwYGklyx87nRIcvTLy3uIkbs7SXGf4mOHzkACoOjKZiikgU67ncQ4aOXB0RjMrMrvsaj0YCmIf1jN6rknjDVC0IuAi51SehbhNdcmcxS46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pPEhHdkOzTa1xVqhchMeAYLb9Sr0RCvJwv+72HGu7k=;
 b=gDi5FBFonJkXxGZ+OC5yWqTSBhV/YKlfspblO+K97eNJsJyur1CT9O05mysgal/WqepszO3i37di9X3UiASg93OXkWRr7UHA5PmCrXkOfub/U5XXT2CjjW5HKdzDKL8Y9HEiGMqZxoYEmO0fIb6vh4hASO8aJXRMO0UUX72sxw4=
Received: from BN0PR04CA0159.namprd04.prod.outlook.com (2603:10b6:408:eb::14)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 05:51:43 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::1d) by BN0PR04CA0159.outlook.office365.com
 (2603:10b6:408:eb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 05:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 05:51:43 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 23:51:41 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add support for xgmi_v6_4_1
Date: Wed, 26 Feb 2025 13:51:23 +0800
Message-ID: <20250226055123.805639-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: cca832c4-12c1-4a58-021a-08dd5629a600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NEQlqdCtvPjws78ZdEJbx0xwv1s0FLDSnvHr6BWMqA2WepxCxeAVl1r/4McE?=
 =?us-ascii?Q?dJawolxzYJksI6J0jnm8Hl+z2Ydy8hkjOys8LyGCuotZKjPRRSyCq/RmD+M+?=
 =?us-ascii?Q?OMcXg9/kOZRjcnfhlucu+h+YAuMCaOKexT6GgZwg4Wi9da7LkOmIXY7c0oGi?=
 =?us-ascii?Q?sg4ZqqeGmk2XDYyTswPjEPEnTMj0UsO2Vk6349Qs9QnXf/VqTduhn1ev3yx4?=
 =?us-ascii?Q?BnoHRmag+momib6xKxeNMwwKXHEIiBNKldVwnKx6ikmDfvht66z5db0gtHAD?=
 =?us-ascii?Q?m3gvQZiV704w/Tb5UMhY1pGfwS9cslNdMLCrVb4mlv2eHxpcgOGkcIYkGm2C?=
 =?us-ascii?Q?aJ0VE3a2Sumg5Wob4VMw3jnuiaowJFHJaiwhiOh+2xgcRMgDsk/8YbSVRXXb?=
 =?us-ascii?Q?2UtWD2Gb+LzsycDkldS/zgS5QOz5oeBoiuzE1WKC6sxhENXiOzgyO3xaJviP?=
 =?us-ascii?Q?nL3nX3jvky8pIw4aNHE3MfZGYSy64qllMrFPndkuLMW2SrfbNk+1rdCE8LmG?=
 =?us-ascii?Q?oe5Vd+xcYKaf3/lKIKsI1r67I+SN+H+SrWaZmoruNjxu3C/MJ1NE81yq0+hK?=
 =?us-ascii?Q?bmr47LUnQdbYtISGLf/257goJuEJ/lAlDpzbj2eHB53Pl63YRdz6xsZTUN5b?=
 =?us-ascii?Q?tZ9Rr6a/4x7QLZGHe8VI2xDG0uTSRteY4859r+veEbc2Ckfr3y7XRi3i7fBd?=
 =?us-ascii?Q?MqFUT5mzkHKB1+z8CHx7nLFZpW5/YaPdvhPER8ijb4F6f5BnWhntFDCxtT6U?=
 =?us-ascii?Q?f4rilXrdJbA8QdPsg1vleeli5bMUwJDSB3GiEt1BfA6aR5vck8eaDokRqPuW?=
 =?us-ascii?Q?x+evc8y/R5NhL6ZwELEnkIUUJWaIdMX1LzDuMt/hD/4AAFpu3EMLB/RGJy1+?=
 =?us-ascii?Q?dF/5SuL4+tFB+e/hoFoVY3lfs90nHkhL4kPlrE9RhhYsk7BdYkPrxJYEHvmZ?=
 =?us-ascii?Q?5T56h9M3gVmx0oT5lVre5VyicweloQQKKqQBDcnfOBdw9MM5XZN0S5yAGNE+?=
 =?us-ascii?Q?k+DAMeqhqJQk4tKJpFl+eP5L2f1i/mdwApxOWEpGD66h/bXa6wGVJkahkih5?=
 =?us-ascii?Q?cxGLLkPvGSBHK+cQVZIqWN52dcUG2Xmnp6RVB3cYbzmeHdOwZ8ssJGmiarNo?=
 =?us-ascii?Q?xCojy1QWIyhpYhl57V8xnod6kotN2j5E5MFwFwNHfmlgvGySBxodD90Mg21K?=
 =?us-ascii?Q?17XCycXy+zft/6+Xa/8MagXfOK2QSBa9ojhBZqWAgqUTgPX3P9YJ1noSsAMX?=
 =?us-ascii?Q?vle0N5Dp6wFH43pUFjT0sRABXjlPTRj8Ts6UL8zVJLVy5Yqgf4K7d/BuJ5yv?=
 =?us-ascii?Q?xNQUBpkjE1+zveJ+g0eZt6AM4/pcUloOMKUzxN9GU8MzjyMNSG05kiyYbKal?=
 =?us-ascii?Q?CuFWvE7ObjjTF0DnCwX0u9OTNpVoqPPLurNGQcRGEaaT8ic02rXz5O+Qaqm5?=
 =?us-ascii?Q?SefZw3rfT3Zt6WhaTXuuLJxtDQQPlBCaFo5dZEK7XBKKR3sm1rREm9D+VmiW?=
 =?us-ascii?Q?CIoVqUIRFEA9OZY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:51:43.4675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca832c4-12c1-4a58-021a-08dd5629a600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

Add support for xgmi_v6_4_1 and use it appropriate places

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 49da137d42c9..e180803b67a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -315,6 +315,7 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev, int global_link_num)
 
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
+	case IP_VERSION(6, 4, 1):
 		xgmi_state_reg_val = xgmi_v6_4_get_link_status(adev, global_link_num);
 		break;
 	default:
@@ -1205,6 +1206,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
+	case IP_VERSION(6, 4, 1):
 		r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL,
 					&xgmi_v6_4_0_aca_info, NULL);
 		if (r)
@@ -1264,6 +1266,7 @@ static void amdgpu_xgmi_legacy_reset_ras_error_count(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
+	case IP_VERSION(6, 4, 1):
 		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++)
 			pcs_clear_status(adev,
 					xgmi3x16_pcs_err_status_reg_v6_4[i]);
@@ -1298,6 +1301,7 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
+	case IP_VERSION(6, 4, 1):
 		xgmi_v6_4_0_reset_ras_error_count(adev);
 		break;
 	default:
@@ -1323,7 +1327,9 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 		if (amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
 		    IP_VERSION(6, 1, 0) ||
 		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 4, 0)) {
+		    IP_VERSION(6, 4, 0) ||
+		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
+		    IP_VERSION(6, 4, 1)) {
 			pcs_ras_fields = &xgmi3x16_pcs_ras_fields[0];
 			field_array_size = ARRAY_SIZE(xgmi3x16_pcs_ras_fields);
 		} else {
@@ -1431,6 +1437,7 @@ static void amdgpu_xgmi_legacy_query_ras_error_count(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
+	case IP_VERSION(6, 4, 1):
 		/* check xgmi3x16 pcs error */
 		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++) {
 			data = RREG32_PCIE(xgmi3x16_pcs_err_status_reg_v6_4[i]);
@@ -1527,6 +1534,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 {
 	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
 	case IP_VERSION(6, 4, 0):
+	case IP_VERSION(6, 4, 1):
 		xgmi_v6_4_0_query_ras_error_count(adev, ras_error_status);
 		break;
 	default:
-- 
2.46.0

