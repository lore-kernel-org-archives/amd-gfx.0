Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8151125847
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 16:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB80610E8FC;
	Wed, 11 Mar 2026 16:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awA+j6Jx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5863510E8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 16:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXIJF9Fm/9XQDu31yx+G5Jh1YwEaHO/kCS+68/uW84ec6VpYF+yWEZ8JlQCAEtFEYlfVUIB5hEKeqgjTgIdMrkdkHjFCcDMXsmkKMKn85lFS8u2XHMfbb4bkmZ5vT2GjBAvEyttPNKffGf0pMsD0+P2+dI5y1wEcvsBO8IYsyQODrnTi7wzRsmO7qjxNmRw0emzOHEEXjzgspGY05P+4IDQjU/bn5iIIPcMbyZtt5M3bUPo1ljivvu6d3+tmEfJ+LFvapiN4H49xssqv6vMBBe923CMIYkr+yX/SQRBlhMlKwbBjqSLLgRxvhskzTg/28m71mA747mEp73NcJp/i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnicSAXUFHYMA+EeyExrqhs/vhBJSZyDONZ05uCzwZU=;
 b=aaOXo7vjfBCpGyhJ9kOA47keW480ZLgwMKKW7nE1WL6ARP0Io1BVyD9MBlyCqAr75mvoNC2c7F0NLP7uKkD8kBCu2S+1NZfL9wGLv8MW/f8kKDd4ziOGNzLJ/j3ahEsltRPkZuTZLndQli481BmQ8cEAGbJD5ArXW/c8V00nkPdHG9ac5w5M99+WwxeKoWXceuJtn16YPjer8FhuJVCxfcurvEvBqJIpJaMSpVCdET7KPankyhCMjdOhR3i8eED4Y0kH/k9qFkX9sumlwxwKKHSLzPJlHw64t53/d2vfYfmYf4gTPnAhsWBzSNl3At+mgxhlj0dUaEmn1vnDsBwc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnicSAXUFHYMA+EeyExrqhs/vhBJSZyDONZ05uCzwZU=;
 b=awA+j6JxtpBi3F8TWCowrcdQbCCuzQRSp6KO1keTerrgEs3FrcL8orC7sKHi1uj+1dP36UgCMcH/HFYN8PYneGbLPv69+K2ooPA/8F+PwEspIJgq9lTEEN1GfV7bnRhl0AiBtD10gccnGCm6oNdhklVvnIzkuPP8OCNsVHDWMc4=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 16:20:01 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::6b) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 16:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 16:20:01 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 11:19:59 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <rafael.j.wysocki@intel.com>, <benjamin.chan@amd.com>, <bin.du@amd.com>,
 <king.li@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>, Bin Du
 <Bin.Du@amd.com>
Subject: [PATCH v1] drm/amdgpu: Fix ISP segfault in kernel v7.0
Date: Wed, 11 Mar 2026 12:19:08 -0400
Message-ID: <20260311161937.3089824-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6a0837-df7e-493a-8d53-08de7f8a0be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: cHfZf3lvSrBABw/Qc9eIx+ce1yvSzwnU09hLwBe5Eas+Aswjf7PfBMhhT4U5CyoMunZAfjWIteyJ38AmBlS7gIyrUr3CwSwZkOf2vlQKZXcoKggUZmyJ+q6LQRUP42dsZuX00ix+4NznvmW5owXVVT6Y1MMGdwLhjJbm4M/ZhlsL78kV1Pe8vNWWy+8pteg+NichexpgAMIJocNMtDsu70JHCdo/x0/4bOxbeoz5c3rXX78Ixttmk3cRGMAr95NKfc/hx4pWG8nf3/Os4QP5tRue6z0MqRSqMhOLIvWdsxdw8yhvIi/rtgzg6GSpRep63Wv3BlEh6uRyYTdbxHotRpn0K8rEgkq0a1RlIsrly/MB56k2av2OishF8vEuovB5IMzrEmtbuRoyA+aLJoVyXeEolXPFiQ1Iaw7ncqr4OxPzq9Xfr8VOF4qe3+5jde3LnHDp4+Gkv+POzc0MZc00kiMSE37vqR31TyFKLU68jXXYwaQ7ubA6qzcTCiUNfaUTMMmyb+MVoyTCRBrt/iljGbXipHBRUTVbQgs268ruTOeJC0Fa+VaGm2zeZOvguGhwAbDlm9/BLjv2sfLftS1PlrH7WU4u8gf1rbiuNUD3almhy7pMV+NLaeebEoWBv8BGmkOgV55NSNS6/6MvWmXFI+iVDQQKMdzN/q8W56T1BE/8xjJ/2Y4K7PDeX7rkOsWANjFOK4PbcKMpMbOl+txLOGFP76P4Ik9hO9OXRH03ZJnQfNcrl9Xe7skL4QhJr9fx+FoLmEyIAXz7fwy6tcXsSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9QK4PVQ2KpHkrTk7jr3OBdgu+0LK2zWkQ2lnvVELksgciM38uALP3mbO6h/4vLxVko3CpW0QxMMPmmdKeltGza7uVW5R3q2JEZL6amaYXB3ObBNVyp0i+qsH8KxK0FbDcw/zUbOVcC7qgbQvCqSH/09TSkfYujNM7S2x9fG07zTk9aW/SoORLJ1d2FPZA+pRoC9Kmz3EsN4nDqxuOYoDiOnNDJfBNc7ubVfBzGzS48b+1LQN5st1HwsYllCmpySGwalVApbSjxudZ6Fo4TxxXSho42M3wIG+g5wgNiXV736HNNewJ70uJwOeHf4Sa9nMIoLwmv9SKMvn6vOKgOK7wPoPgKatPoeOLhjqVPMW7iPBsFasD2JvPLHlarWqkqBKs5IDRQZV93IODUVj6mSMOdCNV+3PMvdFKD5VUN71l+k0gQm+4t+HKVh8E44zDF62
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:20:01.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6a0837-df7e-493a-8d53-08de7f8a0be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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

Add NULL pointer checks for dev->type before accessing
dev->type->name in ISP genpd add/remove functions to
prevent kernel crashes.

This regression was introduced in v7.0 as the wakeup sources
are registered using physical device instead of ACPI device.
This led to adding wakeup source device as the first child of
AMDGPU device without initializing dev-type variable, and
resulted in segfault when accessed it in the amdgpu isp driver.

Fixes: 057edc58aa59 ("ACPI: PM: Register wakeup sources under physical devices")
Co-developed-by: Bin Du <Bin.Du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index b3590b33cab9e..485ecdec96184 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to add\n");
 		goto exit;
 	}
@@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
 		goto exit;
 	}
-- 
2.43.0

