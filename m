Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF34C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EB010F604;
	Wed, 13 Mar 2024 11:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gq6uFIbT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7446710F3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBMiSkWTxCZRHHwOxdGA+bklzj9vaSnUtB7nAkUZEqCjqM7Eg95SPj2CyuzMnfK0xNUFr8PN7Y/6kpaVE01nGVBwY4xEQxHP1F83OjIJ5vPueYLKeAmuGjZnF4rQ29gmi1ba6OXS1e4Dfg0ujl/H8veP1zUVoUJPp+zdqj3omI2JFoGGjfgaN2OoAY8X/ZezH0RZCmQffEtVTm3yMcp6BZWpPzPRtJYgsWSFWof73sp1uC3UQj+kL0+5d8odDfGziAp6/ZxAGzplask8ZpmzltFYlX7pHLI3S7lypQYhs1YPJdgEwi+TwXyy4R1tCnQOfmmuDM1bXeOBe8S8ZGS8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDVwva+uwazN0QfnnvGLnRgQxtWQbjVGt7BugeSrreU=;
 b=Sl8+i9UI7aK06nIiW9KV7+Ogh81Z166m6LxpJCjoJOWjLxQ+5qkxQtAqpJzjUQ8oWGStruDLHAE2aVJDC/A32lY2FNvw9YHFdU6Mo+FL0A2X3aqOQqhbioCHhaji/bACvrJoNhMvTle+wW7f7RbSeBeNHVln1xT1w0iY0rqZ/e2twsJgBH+7UjnzIer4Q+vrR6LjEM/KLg2sDq+EOYGhdZAkPdo8zjFAD8DObCfHDDMaDnmBAqbx/DSdD5ssgoWhZNP70q4MNla7Xg52X38Jl287ExLkuIIkqOwhRt4YZGY26c9083Zn18oLZKRr5VR/vnK9NQ8y7tgrnJiPwR6U0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDVwva+uwazN0QfnnvGLnRgQxtWQbjVGt7BugeSrreU=;
 b=gq6uFIbTc1zr04DOk6AZV1+7VGFxJqpVObInGw9t9VoBK8wJzgUBp3kt6UIiOcKi1qjJZI7gI17xieNdkWhWh3MfagPLMcYImp4tOBnLYK7ErrefOI1TlZwuo8NuNyO3z7z8Etn7eiI+ScSvXRZ7unZWjEmc/0HwPPmKqM0P6V8=
Received: from MN2PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:160::17)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 11:03:28 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::82) by MN2PR13CA0004.outlook.office365.com
 (2603:10b6:208:160::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 4/9] drm/amd/pm: Add xgmi plpd policy to pm_policy
Date: Wed, 13 Mar 2024 16:32:51 +0530
Message-ID: <20240313110256.669474-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313110256.669474-1-lijo.lazar@amd.com>
References: <20240313110256.669474-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 581e0b72-5ffb-444f-2d92-08dc434d362e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0P1tzYTdKq5C/Tst9e8uesm3UbX/s3E7n5qF0okOWqKu1dygJSsu/YMbLwDvM/Qx8fYXXz1/w4FZEr24rCpHTNFu4fIMzFQQibKpwpQctVmJysKtyUYDUz1h+NuetZ2W/g4me/xmuBbGU8pPnBMQfb1zykjasIvoI1rC6+5ybUIX7etRIuLp4S1ip2TkT8qEQcvPhFwlq+RxHsGGZNTAS4w2suVQoy/TnnD1LA7GWq3FNq/3/ere7Co3WMxRiMBMbFEgHmIjr3DQ8OrhRwiLhJOMQOC2p/81u94nRaycEjQ6p/IuDrXby2B4x1ewPawq0cWPUptkBsKPxXWw+oR3kCB6HcsCpcF8iG9b+YFw0LuJ5V0wcgClFJD0U1X6AQ6aSBO3eJIBYy1KTIqJV6wOIFUh6hujJhB4dyZVkGaTj/h0KPmeAG6zIQ0+d9OIV03Z2+Hh7ya/CYPuEF4iLMZj+PmEIP7fT6bPYIsfWp27jUEuR0JnuvIk4vitF1fQTw6pOixI0fydpqG5K9x1DJrD0L0s7scJiL2m5mS//ur7DdYxvpCDFsE/cpkBQP1X8qElxSbwDTWAWtJnMT0rd5+unhG/xC8MJHdhBTB/JeKbedclGjflg+X0Kt+m6lRt88Ob7bdICM+fSO+u+OqVBF2UqQ9IX0rY0kVQB2foO65czVXoS5HyLjtLa48FOuEVDIMJzjE497cR5G/hqeQ53J/3iHlA72qzEr/eejE1Zi6N+aoWEkvXvzlQ6SHpacwUvAlr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:27.9837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581e0b72-5ffb-444f-2d92-08dc434d362e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

Add support to set XGMI PLPD policy levels through pm_policy sysfs node.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e48da7acd7a7..45c78cd08eae 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -275,6 +275,7 @@ enum pp_xgmi_plpd_mode {
 enum pp_pm_policy {
 	PP_PM_POLICY_NONE = -1,
 	PP_PM_POLICY_SOC_PSTATE = 0,
+	PP_PM_POLICY_XGMI_PLPD,
 	PP_PM_POLICY_NUM,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d8c8eaff3355..1d5a8428601d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2195,6 +2195,9 @@ static ssize_t amdgpu_set_pm_policy(struct device *dev,
 	if (strncmp(tmp, "soc_pstate", strlen("soc_pstate")) == 0) {
 		policy_type = PP_PM_POLICY_SOC_PSTATE;
 		tmp += strlen("soc_pstate");
+	} else if (strncmp(tmp, "xgmi", strlen("xgmi")) == 0) {
+		policy_type = PP_PM_POLICY_XGMI_PLPD;
+		tmp += strlen("xgmi");
 	} else {
 		return -EINVAL;
 	}
-- 
2.25.1

