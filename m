Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D3C5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 07:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D16D10E274;
	Fri,  1 Mar 2024 07:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3x80TxQT";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD7F10E282
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 07:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss6TY4CUoaQMzjCWaSJcXZ0dXbQarcSszkGb2MoCPosBS4SBvawpQCxyhFHUYTYaFMYoQFcplughhhCow5I+vhwVHLFJL25iIy8ba6aDLyi7D40IT5U1lStwJaQMyFTtJfag3eAbaeDqfC0cfcg2U0dX28RHtg5KmcXfkRgi0NIX1J/jc7u24EYfYimAru5OyhbiIKFlu1NVAEjH57nWyf9rGQMcdPHekzK86B8avbL/Nmi15+R+0sIYD4TTPUIuvPIrLmVgVSQb+jql5jqg24J7QfeADWPl0Ip4/+5XHYSVs/WxgecNWNvASuAMKGdoO2faCU3Ec9xZ1k4lE0mRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbmsOo7Df38tTpLNe1lv7O61SxLucUUVdRHkP1da36k=;
 b=gVl/88lXkes7KkTrmVA023xVo/qZurpR/WQHZvBplp+s2wZ1+egebVSaL5D68QkqiBUyYM33ofENuS3mDnN7h3p5oR9ndkxjKjnW8l21tGLTcgASg3dftsqTDo50WFbjBG7Sjp5Wb5dM4bZnsi9VEnUrpplAhhgC1nLYKGIwBT1RUC+HdL5xCbeZh309nZzm+k5dOM6rnYjsVMkXD4q3DQ8GBXNcgCUJ8DBRlZMKOuAgX3zTnwsnoeKxMm7NiTeRkhsGTpBkUoEMKKsjrrcDSq+7Lk/OAHLErnDyj2UY+beLglig8O0URiz/R/q3NZpJJYE7jLuBxSIOTHjjrkQcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbmsOo7Df38tTpLNe1lv7O61SxLucUUVdRHkP1da36k=;
 b=3x80TxQTpI7LOsFnu1TIxqnGaohEj+wlBG7i0qvn/xUMeedNuy5zmifml9FcMwDozabElso0MWSn01IQwTguLclP2pFy6bIW0dHKnb+5ydxRyp7LPBEq7K+qdI4Bd0RvxrEFNdKhFho5HMhybHzAl2GQU1igBzmx+nIjb3ppeJ0=
Received: from CY5PR15CA0156.namprd15.prod.outlook.com (2603:10b6:930:67::22)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.33; Fri, 1 Mar
 2024 07:45:22 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::b9) by CY5PR15CA0156.outlook.office365.com
 (2603:10b6:930:67::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 07:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 07:45:21 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 01:45:19 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Fix the error of pwm1_enable setting
Date: Fri, 1 Mar 2024 15:45:06 +0800
Message-ID: <20240301074506.2018577-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e97c2c-f096-4788-ba67-08dc39c38c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+TQjrxsdY9Cvs/OE6OVEmPfDw5qIP7iAmOi5JeCZPBzyr6OL4VxHNF0NVro9ieQBdrU4/MCgst7tTE1IvcI1Hmv3TqTQ38DiQqrV+5N5b17ednlM9Uu7WIa9UcRVwgvzcRC1xOdklUtVET4Rn/Qx9TY4lAhzItcXrdEPg/mucjSxrtUsoW/2Raju86dXkyM3mYXMn5MaEARTdf6QGrGbHwBbcpV3ykMuzEiTwFT38RLnFwOvyXF6bv7Fd5GScOtUDAgV8oMhpIUqHXDysSIE2K/qH9Xm4ZhG5EZnPlrc98kz3Q9YXThmdZmf75WmfYDDLfKODYL2gZRXSzKkS+kgS9X75cATAyv6oOmoKgX1BTvigSVPaNvV4JR2UJGmMVrBHQZNUtUpgTlREj81gZAhelRMr2VjONpq6gnWyR5ESeDxCWFfgOgZHtAYI12gGNE+ha5RhlAQhx5/E9SU9/dzJv165MqnHXwafFQK8pgSR//xsBkMuQo4eHhXe76UGgr0DRTcLCcT8zeZcbdxOaCdybj5EfEv1c8t/biZ1GlbBFLr4yH8VP9AE3yo/djZHcOrX5Eh6YgOmc9sCzj/0vn3VIVLcqZB2x8GItX+sugH5jhvRslDREuziO4MywiLGigMoa1ClE4nluGxs1sln9eHfQHKCDSBQ+JXi50QdhyN3HYAGYKDOxy3HAWmMNRdPBUXlicxh4wYTARAdSW/hPS5Uwka1rvhaRg4aMGvOCHFDDp0nO1qB11q4q8MKYiR5e3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:45:21.5184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e97c2c-f096-4788-ba67-08dc39c38c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
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

Fix the pwm_mode value error which used for
pwm1_enable setting

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9e70c41ad98f..7cc5cd7616b1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2582,6 +2582,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int err, ret;
 	int value;
+	u32 pwm_mode;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -2592,13 +2593,22 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	if (err)
 		return err;
 
+	if (value == 0)
+		pwm_mode = AMD_FAN_CTRL_NONE;
+	else if (value == 1)
+		pwm_mode = AMD_FAN_CTRL_MANUAL;
+	else if (value == 2)
+		pwm_mode = AMD_FAN_CTRL_AUTO;
+	else
+		return -EINVAL;
+
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (ret < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		return ret;
 	}
 
-	ret = amdgpu_dpm_set_fan_control_mode(adev, value);
+	ret = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.34.1

