Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5091FE7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 09:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FD010E55E;
	Mon, 16 Dec 2024 09:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PX0My4n4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F5D10E55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 09:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM6fcm/kipzP0M51X2EWpWRUN+nv0iv2kUyK8TKzCyJ8N6l0XqqTj0xZmr4rBWm//I71IsFkQuiaPdojjA3TeBP+63gBLPKzijU5K2Q/eYkRGEvKp6FhGoRbqaftLwrOSRiucYSf856bcedd8AglfdkwRxK0a8bMkBhUb1TpPoOTXXYbUMAf4QFJd1LN13R70UIWpxRufGczmZ3cJyS5pvBRLnE2h2c38Zb8Oqf/4vlSkHL9Q/GfYrhn1rthMyO3EVdPgID1lSb9KXtXD6aciMiLHddNx/YWPBskbfj2IdpdaEDiwATKcc6Mncxte2sgBqoPlV19xtq0FeEILqjfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGs6mpP72I5I8oD+PjV6zVp50YZzflMRg+p8pPk+Y0Y=;
 b=DYmjIzT8xWbjk5o26C17JQMH+lZzOuCdA4uGfDEwfw6mQislsZmOCDf+/M3wkgVm6serMmzCUKNc4PS8PHj7VrusXXzY9a1AH8czrmWwRxHj1T9IeN5GrzZiHR0ilutxUiFrRM6C0Djppp6iU5eFtwwVZTvVvNfqB/IavPZMUl2/lQGsHoSlKLFaomybO+m3ZX/Mg3HNSKeOCcy1Pyx28B7x0INy3wEue4ExA3OSRBK6wUmqt9EKRQTxZFb8FLWFeiXs4ZNVfk6MT4rzhfgEhOShdxNJlAyh1+tMSugjVzFENrPYRdZrdIG8OWMhZayT9RbKPBiutHPw5+jonD/vkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGs6mpP72I5I8oD+PjV6zVp50YZzflMRg+p8pPk+Y0Y=;
 b=PX0My4n4lUFq1/UCz6UmrNwfzhgISXiVcwbxQfFXxb9JV+sw81nJmE0qpW5ae1dTlekqrUjtt07Lb10TC4w+aDUJNuVUQG3ODFgiOTsuj1c4K7TFzTt/9YBHhbNqjGh6nAwwJpICeM4uuPmGWudM9K/ioqXbT2tuGxwDCapR468=
Received: from MW4PR04CA0373.namprd04.prod.outlook.com (2603:10b6:303:81::18)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:29:43 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::b8) by MW4PR04CA0373.outlook.office365.com
 (2603:10b6:303:81::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 09:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:29:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:29:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:29:42 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 16 Dec 2024 03:29:35 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/sdma4.4.2: add apu support in sdma queue reset
Date: Mon, 16 Dec 2024 17:29:27 +0800
Message-ID: <20241216092929.105280-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: da201a21-de5f-4fd7-c8f5-08dd1db42c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?983zDU38zOtQriB8vyUS3c5a2aYAJXfX75liXQuyTlMZzvpUO3JmrUF/9s+U?=
 =?us-ascii?Q?WC3NdFFlyltIzdgg++foT/4utU+IDuOsV2xljfsisykFM13eX2j8Cd02E2A5?=
 =?us-ascii?Q?FXcJmVCnDoBTmWGDBqW0KUR+SQK9CdfRHTcBhmkVnM4xkA4aBIHCG7L5UCxX?=
 =?us-ascii?Q?wa4j23XkDZx3tP4DDeWjMjBb6UsSb532vqCv/9DC9izL8grKDoOpksXjCmHN?=
 =?us-ascii?Q?7K+43Xpnh3iCsluhNj+gf8BeCyRyF1I1FU/h949wJyUU/5u9Dv+O6bXUhAlP?=
 =?us-ascii?Q?02kulMQh23MdI2VY78JCa6JQvnUZuysBbYxon2GYwAseCMHNqd/JQxadg8zA?=
 =?us-ascii?Q?zujI6rEF3NKkxw2n+FoExbD2MzG1MCLCWrRxUYys1qgL/uBKGnIcm1gfnray?=
 =?us-ascii?Q?OZ1Fat1LfS2u27fP/8dC2a6DNjoGln4uJHgqUTEE/bz3O+WuobmehnaFqZWN?=
 =?us-ascii?Q?139SHcijG5ER483cl2VwTudO7Tryae+VyD0RkfqRbXfk5PWwRNe7G5b+usOK?=
 =?us-ascii?Q?DRslwZHXdR/K6xEy1iH5dpIa4nB0pjCPRtxi/YsT2BjnocfX60GdchaU/A5f?=
 =?us-ascii?Q?cX0LbQ0GS9XwN7aJ7gIc5QFElueDP03DzL0cWBnx/V5u5VBXupaBfiY0EkLu?=
 =?us-ascii?Q?O5sS+HZmfOmA34w2CI1GXUvckyYuXxfjUEp3UUKHusWHGwJw/cmOeOp8iUtV?=
 =?us-ascii?Q?OBWqcQeJ5OhOMhvt4Afa/XnpafFshixMjiD5Bfqvoq0ge3z7jRY7ztT9E+k5?=
 =?us-ascii?Q?VhKZ8ExQbqlhcnvH6vnfYqYhth00JzWmntB9CjYm8MWhQ+a03QNUJ/4/kRsb?=
 =?us-ascii?Q?2rdTI0U+znF4jY4qSlPlwnVSFqRoh+IT7LRJrOWyfZTBeoTCficT78w7OoWb?=
 =?us-ascii?Q?SIFHEJd1USuOIA3YYSI4H13avZkIBytQNgaiYgjX/WeB/WXs91k6yzHVHlHA?=
 =?us-ascii?Q?1LKa3ypP+gLNSUXahlL00tlt2qeO0J09ghmgJClhnEWG2tAP/jSOH+hBNsua?=
 =?us-ascii?Q?xeP46a+rJc+uhKQPBxYFz2ljoL4qTC9HUxv6LYhn0k8Y2F9WIe9QZxinZqMf?=
 =?us-ascii?Q?sWe29vgifk0FgtZRYAXUSX6xV+ziclGleyVrmbePVWNcTcwKndlGQDitgqeD?=
 =?us-ascii?Q?Jt4cIhOBxEI39C+6cUrrEbwm48vlZJinLEAoSTaL9wIbvujS0fB+qKQnnEKc?=
 =?us-ascii?Q?CXeKgZQeiwe2W2cyZzkeTgb0SAYKdrhg7DbH5rKW18F5xIB/HaUUqm5EazAq?=
 =?us-ascii?Q?SeHk7Q4HcwIlO+elR2WrT8gDAsmD8lOTE/Cq7Y4iYFBKvfrwpw1aKftmss+L?=
 =?us-ascii?Q?NzxVh8h78M+4mUH5lpw/t+DDx4ddY02BG2EtdTcoV+wqT8IHfCGkqkoh/vVv?=
 =?us-ascii?Q?5E55p1DDSOjyr/lcuZkZN2fFeei3/foqWbkJ9aQJhWLOgC0WtcigM/rCecmb?=
 =?us-ascii?Q?nLGUq7SG8UJqp1mUsaQs7b9PXvBb58EJJ+Yek3GigeNBMuCD18yL3hrvqcpJ?=
 =?us-ascii?Q?al0XAXoOVCwqtyg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:29:43.3462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da201a21-de5f-4fd7-c8f5-08dd1db42c89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Remove apu check in sdma queue reset.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5e1cb1c2c0f8..e39f1f495ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1600,7 +1600,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	int i, r;
 	u32 inst_mask;
 
-	if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
 	/* stop queue */
-- 
2.25.1

