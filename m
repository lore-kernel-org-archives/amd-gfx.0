Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A40C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 15:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A2F10E2A9;
	Sun, 30 Jun 2024 15:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qyNdjDcx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B91010E2A9
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 15:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az+LramXk512eXQtro1q1QcxHaz6X90cu2QxVV8ch+SFlAPArrPdHy45fFEDuYznqaCG/NfmFwX6GsudtdLSH/yh7TTluWr3OYZzkOCh0H1uS2/UnzWd4kzDVVjo9SfrbcIGEH8SSTrRDVWjBd4To49xqt6NmxjSgjXVXxj5AW1CgVPFFB2GQWkOVn03CbNanm7FYxqE+FRPUIe8ynNZj/ipXG4/+9bpKdZyxs/0ufm2jjLY87l09bM2dWkqg1Ho7LETDoFbvNNQEYYbEIUNOTFinr0DBiAvF6IoZUBPk2Ljk113yUxtnfqWYGI12/SCsUTHR0qq9ppRyKqf5OCUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83V3icfl3AuTWloHXrfiXaT5zHeD6d1OPH45kzoJqSk=;
 b=bBP7nXLfq742QMOsjw7j8zQMpHAmfT6i2ychRhLhUJFgpM0wl2BHm4mZ/T9MZCTwUCoL3lyJVSzoSgsub41b0+TsbGj+GPYhzPciFFOdGLDrx20UrM/6hKXa3xf4MRyjhFfm+vq6ybolca6fpB4/5BUwuLf981JszAZf2wE37+XxFqVKdA6tT1i3RUtHH64NaasodNoL0nJL6B8K7F7ekwj0ZGm6iyNGjGPu/efNiZFP+ZZVJ418dQqyQnmfhECSdNfirOcz5OnpBKxUmg75b7VOIqxp/QTtlBB0ijAI6mfHNtQfz4ThxoFcZ/IW6cwDxWeqN8jKPq49eVfgafHq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83V3icfl3AuTWloHXrfiXaT5zHeD6d1OPH45kzoJqSk=;
 b=qyNdjDcxcOsofx2qfFFQe7tSZQyW3DXEZzTbimPffAsK2PL3JDXBv38ii5jpWVAKcfk1M/ujEaoapuKlyGsSTTZsdqyXvcd9Ernho8Zgp7pthpaRUJPVTekj67G+LDO1dFPiZJeh7GVC9ZQj8CsT7QQo5o7PPkSxDnn/6pnj5yM=
Received: from MN2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:208:120::36)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 15:46:18 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::85) by MN2PR10CA0023.outlook.office365.com
 (2603:10b6:208:120::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 15:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 15:46:18 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 10:46:16 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: avoid to load smu firmware for APUs
Date: Sun, 30 Jun 2024 23:45:05 +0800
Message-ID: <20240630154506.2292189-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b48e61-19f1-4a66-3df4-08dc991bc842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AnRzAuZB5aKwYgxSPBh7pjB3igpoPfvmzmocCLwdNEdYfUIK7Re2sbE4wFXI?=
 =?us-ascii?Q?iS5oseTBqEzCdBW9T9to1GsWzbLFj9mV1VbEtXpZrJKpSigs/AoqVK1gWjSN?=
 =?us-ascii?Q?TkV04tpgrB3qsdYtlswRWCwdIvKGYgIPdpied9uIkfe/47ddzc/2BlXU45al?=
 =?us-ascii?Q?lCErn95WcMcrlxyiOiUjpURJZdsY2+LPqkYWsNwePktqnfRLCTVlf+xqT6TY?=
 =?us-ascii?Q?Otyf6cf51k1/tj1Oefq2uPwZgbhu3vum3g06li3lpr60MU/bj3l711v4BVfR?=
 =?us-ascii?Q?840OGDLk1YuQ2U7gUAuwYv4HRhL4ii29NhvaRPlHn70iDBPJvQTfX/kEQ+wu?=
 =?us-ascii?Q?KLTOaoqGCb49PJGuaYOpCwxzH+tatp6kbUAUZUfVFGqfGCstRaN+icf2btcs?=
 =?us-ascii?Q?+BBP1DJzdl2fjY6HiBv6LIL2VK5iltFxzSQMYtsVBwHsY3GAPF0823XgZvrG?=
 =?us-ascii?Q?GyotEE3IgcMSzS6BI1Nqrx94eRHn8CnQL5GERgJhJKC/fXG7NqDQ0dhBgW7i?=
 =?us-ascii?Q?2Ah4M1PxYj5/7A5jsIMtnpGkmCqwoaTWanjdTmJJSlcX1oJa9RjOmL2qK/TH?=
 =?us-ascii?Q?/AxN+KwuzuUbXNtR5e6PVgNVruZmTUfNHiAHexzAQTOeGKOjhRmLsfQKEerY?=
 =?us-ascii?Q?8WtsbkU5lFkdyc0ACg6eH28wsHw9DzYr/3U8Fw+1xtkmdRPBDfxIEgnVkzIK?=
 =?us-ascii?Q?khXxsr/j5Be93v5099+DGE6taj248EG+UmJw8ceRDjfK/qk3ftmqE78hGhlS?=
 =?us-ascii?Q?kTylwAq+W65R3sQDZKqMYFRx07AZ/sw7XkS09NFFSAKl/8x1BklSZxsvM6/1?=
 =?us-ascii?Q?CYYYszU1n8gQFIhZGHxctGwlfcUNDsEAWTf4ny7ozNn1xLJUrxH/IvFXz3Vi?=
 =?us-ascii?Q?3sdnnbo7EPA7FqWFZbAmECWv1LT9wyCDYO9PJ1WDmeLRWynu0xxiNEEGU5iI?=
 =?us-ascii?Q?8yLV2gAw0X7R/DrhRLr2zk4ge+98e/Z1iKVg0Ser0TQlQk5oNkf5+XA2hvxk?=
 =?us-ascii?Q?caD+rghbtyW5XYm8IH/1ZHrEUWrrdthhQw0QH/YW2baRl9778+xQR8y1jPTY?=
 =?us-ascii?Q?nWfJTbsumVQKJA//nLSg1ZgRxlNqlAOOoQmKxT/MrKTcpqbownJ4m46H5qbl?=
 =?us-ascii?Q?UOinvKktP/ho9+NGJ5cXx8HbYQM5Ogle367LCLWMEM59Z/xG4Cy1ZJTV4vuF?=
 =?us-ascii?Q?fT2T0F+gtzEQSHiJtS2bE4ITEzj2RTwuqR4GofGEhMBTFHShGKrUPwrcSn1c?=
 =?us-ascii?Q?DRJrAtv8aODkn5b9RkbG9SJE/6sJO/WptpOxM9z89OjAl4my8dhtpDsjqLg/?=
 =?us-ascii?Q?Ew/yPzy0zZh9254tnKDxUzsc8YSItfJXdecEj6xVZ8U9j0LQRM2gbLzQXk0c?=
 =?us-ascii?Q?y45DNtNJHM6aBxPAIvy/JJcZxrY6YLW8wvFBWxXxFaGGhJ9smfKdgQMjfh6w?=
 =?us-ascii?Q?dT+bIGdb2QUlF0/ETxk7Vetu2NiOmKEr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 15:46:18.2094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b48e61-19f1-4a66-3df4-08dc991bc842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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

Certain call paths still load the SMU firmware for APUs,
which needs to be skipped.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 +++-----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c    | 2 +-
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 18488c02d1cf..c55518fe542c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7324,11 +7324,9 @@ static int gfx_v10_0_hw_init(void *handle)
 		 * loaded firstly, so in direct type, it has to load smc ucode
 		 * here before rlc.
 		 */
-		if (!(adev->flags & AMD_IS_APU)) {
-			r = amdgpu_pm_load_smu_firmware(adev, NULL);
-			if (r)
-				return r;
-		}
+		r = amdgpu_pm_load_smu_firmware(adev, NULL);
+		if (r)
+			return r;
 		gfx_v10_0_disable_gpa_mode(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 38150398a31b..0ad35e96d2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4558,11 +4558,9 @@ static int gfx_v11_0_hw_init(void *handle)
 		 * loaded firstly, so in direct type, it has to load smc ucode
 		 * here before rlc.
 		 */
-		if (!(adev->flags & AMD_IS_APU)) {
-			r = amdgpu_pm_load_smu_firmware(adev, NULL);
-			if (r)
-				return r;
-		}
+		r = amdgpu_pm_load_smu_firmware(adev, NULL);
+		if (r)
+			return r;
 	}
 
 	gfx_v11_0_constants_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ccb26f78252a..40edda2c3003 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3306,11 +3306,9 @@ static int gfx_v12_0_hw_init(void *handle)
 		 * loaded firstly, so in direct type, it has to load smc ucode
 		 * here before rlc.
 		 */
-		if (!(adev->flags & AMD_IS_APU)) {
-			r = amdgpu_pm_load_smu_firmware(adev, NULL);
-			if (r)
-				return r;
-		}
+		r = amdgpu_pm_load_smu_firmware(adev, NULL);
+		if (r)
+			return r;
 	}
 
 	gfx_v12_0_constants_init(adev);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index b3b5e7b74c85..a1b8a82d77cf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -618,7 +618,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int r = 0;
 
-	if (!pp_funcs || !pp_funcs->load_firmware)
+	if (!pp_funcs || !pp_funcs->load_firmware || adev->flags & AMD_IS_APU)
 		return 0;
 
 	mutex_lock(&adev->pm.mutex);
-- 
2.43.0

