Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F69C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D80B10EA06;
	Fri, 11 Feb 2022 07:53:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2F310EA06
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqocORDIGwhFivA282GboNBavXAx4expZ6in8+V2XU1GxQVSjJHpHZhlYFmXo6VcJeqCSfEQiojvxqaR7qWdg6qp7exga4i10unJV7oAYk2TIvdPfiLMPpXD4ve2/JSRDc+M0REejMCPTFjfUm0/T6Xe88W/UsB+HFI6phXpU9KTI40O+2Twqw5w2G75VjEBbeQmyRtL8qAvAVrCAZGeIZWvPM+VR9wGgAHPEwL+b/EzCqiWW8eIity3vJvQqMlod48aY14YE0FzAhjZ10Myk+AjbVQd2swqO/sRVsBojtDifZ75QepIFTMXON9AI9ff1SpgUQyg3y3GvbDdGQZfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK1FRoz1CG7ZC4DF6+hF0vWFNz+P7SDkPlmJT/JD/G8=;
 b=ODM6mdLXzOM3AR6x8xU2mw51saMSdgUvneFBsd87ZmFUPBqlevjGQTtLQD8vC9XFGDcOY1Y1Ny6AKjcZGgf0tXEgEeL6pEfMVQDksKVibrsDYPqUEYm1iX0rSiVu/Ck3gPToeoFf6LoC1rM61cieP9WMWFWOq3AfqohXPC9jw9PXOVbCyLux/y3RdhWq/zfJghWiTCGyvMQO3GOZjHCD+p6elzC05emdbYa1iuDazcUuVdF9pYkHIW6lQTKBxJNBRqedRxqst419l2TguEdbpzKIEKwT2JKAb6PboVXZIeHDtZPu0MIURHQRlW8wWNeBnQo4s0Ft1spSYiY14wrFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK1FRoz1CG7ZC4DF6+hF0vWFNz+P7SDkPlmJT/JD/G8=;
 b=US1oxHYfo6xuwkqCUP7eAgS8Wkiudovo0H2AZ7xgQCwXB+ecfvissy83mo2MXNAW6wgH/zH2WPgCySjKyaf5l0gTZes+yd423lMklGG8hvP7fUW1T0BBIu/VrfFUY19cjdQGCytG+VRLBXvtwtSRX+m7NlCBiJNSUOajewm810w=
Received: from DM6PR11CA0069.namprd11.prod.outlook.com (2603:10b6:5:14c::46)
 by DM6PR12MB3851.namprd12.prod.outlook.com (2603:10b6:5:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 11 Feb
 2022 07:52:56 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::a3) by DM6PR11CA0069.outlook.office365.com
 (2603:10b6:5:14c::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:56 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:53 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/pm: drop redundant !pp_funcs check
Date: Fri, 11 Feb 2022 15:52:06 +0800
Message-ID: <20220211075209.894833-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e42cd13-5036-47dd-ba7a-08d9ed338434
X-MS-TrafficTypeDiagnostic: DM6PR12MB3851:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38514FC7AEBC483BF1C2D684E4309@DM6PR12MB3851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbox4VfsTw1m7KqEIECMDW6exLZCq7oMMYTIWTKuBodfNOdBDLR7ihMcmYKxfGkDv+ODTQGOwr8hbCSAY2MOs2aA/vHFPaEyg+SVaH4O+xj5CemDU1nK/6egucZ35sMHifcngmypAet7lyBYjZ1vJtxkVkCE/dRoDblSFeDTN4yIyE53uljCTJto3knLo+jglaRSu+Xyr3KTbU2YV5itdQLl6tuJWKarBQfX0Lxo4dLPn5fLTZcKx7hlTJ/pLzBgsqSlxbbespQ9ouG3p+MYQlw3A7tQ19MQ4cluJQtVE3KJU3qjbTuUAshFqeH2J74/u5YEAf8Liubda6ZGvOMKDYVtAAqyHMrJj1Ad044bEzMAXfI/pudw+xgOizJN1YeJ8hG/vkrYVgHiJTmxK3MIc5F+tCLUcalAKjkk1VjHRSlncDC7dQi0wBZ2EbTXabRyAMAdLuK363QsnHUtX+Lcb7I9GF5rrKPU/ePqM+UlHQNh26Jvq6+kWMUMcanMVPV0EfREUgYbBeH3DvTE3M9uVnkvH5WxwbhdktPJ0R+o/OpAy+KH8d6gBH7QQf5MjRlO6jAzMIVsAIguDX6ByAMrIQdoZrYYRKWvNJdAVafCFG3/j2B9Md0WIEzEuNTqDE75NfyRRwy1r2JP9D9Ctado5Q4YJjinMV0k6/vAISzbMiyKYFZh9w1uNos0F+i4ZnuzToao6hNtzvpAWA9/k4WNfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(40460700003)(7696005)(508600001)(47076005)(6916009)(86362001)(6666004)(36756003)(26005)(54906003)(83380400001)(1076003)(81166007)(8936002)(70586007)(4326008)(70206006)(8676002)(82310400004)(44832011)(336012)(5660300002)(426003)(316002)(186003)(36860700001)(2906002)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:56.5705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e42cd13-5036-47dd-ba7a-08d9ed338434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3851
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As it can be covered by the "!adev->pm.dpm_enabled" check. As long as
"adev->pm.dpm_enabled != NULL", "pp_funcs != NULL" can be also guarded.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iec801f18a0069ad5fd384c4133016977fb2b67e8
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5f1d3342f87b..f237dd3a3f66 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -104,7 +104,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_JPEG:
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
-		if (pp_funcs && pp_funcs->set_powergating_by_smu)
+		if (pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
 		break;
@@ -314,7 +314,7 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (pp_funcs && pp_funcs->switch_power_profile) {
+	if (pp_funcs->switch_power_profile) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->switch_power_profile(
 			adev->powerplay.pp_handle, type, en);
@@ -333,7 +333,7 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 	if (!adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->set_xgmi_pstate) {
+	if (pp_funcs->set_xgmi_pstate) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
 								pstate);
@@ -353,7 +353,7 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 	if (!adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->set_df_cstate) {
+	if (pp_funcs->set_df_cstate) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
 		mutex_unlock(&adev->pm.mutex);
@@ -389,7 +389,7 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 	if (!adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost) {
+	if (pp_funcs->enable_mgpu_fan_boost) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
 		mutex_unlock(&adev->pm.mutex);
@@ -409,7 +409,7 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
 	if (!adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->set_clockgating_by_smu) {
+	if (pp_funcs->set_clockgating_by_smu) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->set_clockgating_by_smu(pp_handle,
 						       msg_id);
@@ -430,7 +430,7 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 	if (!adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (pp_funcs && pp_funcs->smu_i2c_bus_access) {
+	if (pp_funcs->smu_i2c_bus_access) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->smu_i2c_bus_access(pp_handle,
 						   acquire);
@@ -449,8 +449,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 		else
 			adev->pm.ac_power = false;
 
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->enable_bapm)
+		if (adev->powerplay.pp_funcs->enable_bapm)
 			amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
 
 		if (is_support_sw_smu(adev))
@@ -472,7 +471,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 	if (!data || !size)
 		return -EINVAL;
 
-	if (pp_funcs && pp_funcs->read_sensor) {
+	if (pp_funcs->read_sensor) {
 		mutex_lock(&adev->pm.mutex);
 		ret = pp_funcs->read_sensor(adev->powerplay.pp_handle,
 					    sensor,
@@ -719,8 +718,7 @@ void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
 		return;
 
 	mutex_lock(&adev->pm.mutex);
-	if (adev->powerplay.pp_funcs &&
-	    adev->powerplay.pp_funcs->gfx_state_change_set)
+	if (adev->powerplay.pp_funcs->gfx_state_change_set)
 		((adev)->powerplay.pp_funcs->gfx_state_change_set(
 			(adev)->powerplay.pp_handle, state));
 	mutex_unlock(&adev->pm.mutex);
-- 
2.29.0

