Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7287EC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD3F10E830;
	Tue, 14 May 2024 11:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKBVDxQK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671B310E830
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix9Ds47QvvdWEbsxCgjtPYz6bOCZ5LzAcmIzvXywEAY1M6oWju95ug6RyfPrEfqEj6pw9cQK4m/hGx0Ij6YpCmInUsvWagYnzXvNrkFIC0HmV2mnIALR6Qel+22D1kpt5+8gbDjABg0haM+SPYgvPYtB1dPrSHAZxNndDP/dbR3X9WG+b7K9GwFuMTUQ9LcPQnduNNjm1arqBn6OD0c45RfdblQ7jyL6pEEBCSSU7YXSVKqI6Vaf28piM1cKdgztQ33CemPeV60Jt3I7NRq8Hi9nUYB4iBc0Ep5hekIDRrqihsogPCR0NroOyET5JjsuwbfNYiC7Yea+Mwa416W8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+Gq1laecWy9fvE7IYuUjDnefS8t6zL+bj820pdTPZc=;
 b=dcCSE3tQHckR3ZIB/Wi6wWJaqnCOYuY2pyk/XEBh0+s8sV1zSghC2bcHOwxblux/1lmFF53ShfAVLGafwo638cF80Q8bfahrzbMU+aGmrNrceryVsYxGDXN8WktKT2FPa3Fsfcdrz3BEmLffGA3Rwub0IWWXJ1Lw62hpm73cnvx2dpYjg3WMk6xL2b4QUfINqPdcuQua7ajeiwV1xuMsy12FrQpVbicShVFG9wG1Rpkmz4O5tHzjdpssHAi1JHfoH1z2oy88MfUUjLam5MEgmtl8yKi7L4dC9Z0WD2W7QQxThDQfXdUOPT86SRk0A4o3ZpQIOesqVI86eZawvFsbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+Gq1laecWy9fvE7IYuUjDnefS8t6zL+bj820pdTPZc=;
 b=WKBVDxQK3cNQpZNNVv8vnOKZ8tVnj+gS/BVFvCKi0Pg/PHd8PQBmjvsHC+nAiS086useExiNWIgn0qIGnkmRXxW/lJCzk/wLQzO7Lthd8QxVehHOavpgtNBAGsqolinJOCq20yDCjt2uC1psN7XCdsfs3+52f7rneEbqSmDzf78=
Received: from DM6PR07CA0050.namprd07.prod.outlook.com (2603:10b6:5:74::27) by
 DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 11:06:31 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::b) by DM6PR07CA0050.outlook.office365.com
 (2603:10b6:5:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 04/10] drm/amd/pm: Add xgmi plpd policy to pm_policy
Date: Tue, 14 May 2024 16:36:00 +0530
Message-ID: <20240514110606.396234-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514110606.396234-1-lijo.lazar@amd.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 668e9c3e-07a6-488e-8a15-08dc7405e967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2G6rhvlEViL9WbfHv+wHmok9wRDLYh8rD0dkh/NU+nTqvwxCKsZ6FvFRinCu?=
 =?us-ascii?Q?tT0t09Wxbiki3m1FJEvtkEqL6AxyRSWFrzPLjerZCj1w0BdY+9ko5SsaaYMB?=
 =?us-ascii?Q?aNTN35pwaj+DegQwzo7kBWPRi95RdaSXBycUfS5m0sh1p+riOt4xnEnkul22?=
 =?us-ascii?Q?H0B8cwTLxDvMb5SiLw816Eihc13hFKSV/4j5iiqKlVXemAoRZb7qNv+D4cpk?=
 =?us-ascii?Q?/q6MYOow3DeSDFkWbgacUzcez2NE41CMQIodtRkP9a9DF3+9OgFb773dBE7N?=
 =?us-ascii?Q?nqx9IFh0d1EEl3mQMtEVpbMIKdoI2yIN2PZv2hd/tqnrRH0WC2rZoWGQhhd2?=
 =?us-ascii?Q?+57FD1uz3ugDL6QinhXOVfNYBo1sei9PIgHlXtXYOlVQqE7xD55YIDvxWh3+?=
 =?us-ascii?Q?CRS9Xg3sKSVi3dyvy7I3cKmJ2hsK6VX824Z2aX3ExU2NRT7ljY9YbgvYtSgI?=
 =?us-ascii?Q?xYl/qOnTrT8sIJGtCGSe52m89kXrL9R7o6bIOsqbqDlrNG0aZkUM8bfzdzXg?=
 =?us-ascii?Q?LFPYWbX5a2dj3QlCJd2jiay2DQ+HOXCXzrnDGK3gSMwMYSx5Twlwb8s1aeWl?=
 =?us-ascii?Q?lZH+26OWBweK9P8G42qHlKJ+esUr95OR5Yv1GqAjdfZJe/y1s/mgvA+Dk9yq?=
 =?us-ascii?Q?45WOZbRbPmqlFIcTI1iu+PZQXdpIjJUjwGKN2egDTCxNU+PHCVBIcK6hF7UM?=
 =?us-ascii?Q?wla2yO20uTMT9czt+HgHFb2pgQhYvL48MMyvRdVKF7vF5Wfl25QL9MXAApXE?=
 =?us-ascii?Q?44eae2X0GZ9/xX/o+lOeLUq6uKylT3HGBP0cU6lQofIlZf9WOu9lKFfVJRE1?=
 =?us-ascii?Q?soP7KWniAMaIO1sUM/R6qDa3j5ny04ti818ZdA2lqFqJZn+vHsTSdOZE82jB?=
 =?us-ascii?Q?x8MO863FRFvzO9VoUDfInJnxhpu9cTyjpNw0Un5yK75ZqVvo7KOHDtXPNTID?=
 =?us-ascii?Q?cfTtmGX+eNkHPYfGj3XbZxsYgUSnSh/KcRay4xZ1SOrsnkFcYeA2V3fA4/9t?=
 =?us-ascii?Q?v4wLai63iPV7xGWmlpfWGv6VZcITEk2epHkxUiNPKhAoYStnhABzZ7M8IYKt?=
 =?us-ascii?Q?7D7ooLmkZxQO99wvGd8A8zf2Vw4LKS9sxqa18NGy+yLt/SE52VnFCIplZ/3Y?=
 =?us-ascii?Q?2mVqgNB+R/eSOwF6p6f3goqqo+KLmblIrD+htj7fnc4qytiIrWf8LXyoeG0Y?=
 =?us-ascii?Q?1bOd8uxw1K6AHLtpXBiq6RM99391JplvGWYAgQ/uNUx8TLkKVqKbhBlfTqOt?=
 =?us-ascii?Q?EcEYFkoeVcHZfrbT5qOO+EpjdQ4C9KL6sm1e7MpWeHLqLNKL18bGMcs8jmzE?=
 =?us-ascii?Q?OAArc+IIHKFo2OuWQa0Er8gMbaG0E85oAv6vtFlt3kKtX8hn/j5i1tDO0jWj?=
 =?us-ascii?Q?8AVap+8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:31.8678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 668e9c3e-07a6-488e-8a15-08dc7405e967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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
v2, v3: No change
v4: Use a macro for XGMI PLPD policy type

 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 8ed9aa9a990d..4b20e2274313 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -276,6 +276,7 @@ enum pp_xgmi_plpd_mode {
 enum pp_pm_policy {
 	PP_PM_POLICY_NONE = -1,
 	PP_PM_POLICY_SOC_PSTATE = 0,
+	PP_PM_POLICY_XGMI_PLPD,
 	PP_PM_POLICY_NUM,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6dab0b085239..b03c38d198ea 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2293,6 +2293,7 @@ static ssize_t amdgpu_get_pm_policy(struct device *dev,
 }
 
 #define STR_SOC_PSTATE_POLICY "soc_pstate"
+#define STR_XGMI_PLPD_POLICY "xgmi_plpd"
 
 static ssize_t amdgpu_set_pm_policy(struct device *dev,
 				    struct device_attribute *attr,
@@ -2320,6 +2321,9 @@ static ssize_t amdgpu_set_pm_policy(struct device *dev,
 	if (strncmp(tmp, STR_SOC_PSTATE_POLICY, strlen(STR_SOC_PSTATE_POLICY)) == 0) {
 		policy_type = PP_PM_POLICY_SOC_PSTATE;
 		tmp += strlen(STR_SOC_PSTATE_POLICY);
+	} else if (strncmp(tmp, STR_XGMI_PLPD_POLICY, strlen(STR_XGMI_PLPD_POLICY)) == 0) {
+		policy_type = PP_PM_POLICY_XGMI_PLPD;
+		tmp += strlen(STR_XGMI_PLPD_POLICY);
 	} else {
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index ee5b9701038c..f304071adee1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1574,6 +1574,7 @@ typedef struct {
 } WifiBandEntryTable_t;
 
 #define STR_SOC_PSTATE_POLICY "soc_pstate"
+#define STR_XGMI_PLPD_POLICY "xgmi_plpd"
 
 struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
 					 enum pp_pm_policy p_type);
-- 
2.25.1

