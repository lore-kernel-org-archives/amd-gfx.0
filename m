Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B63BC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 03:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E9710E203;
	Fri, 17 Jan 2025 03:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gql3lFCd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AED10E203
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 03:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyXf5ZD3iAuCq1T/vwrCJbSnyuQACT1TrBqL1h/dP2IdrzlWymd76OW2X88KBRjwUHL5rxMjzxIpWU2mYE4WLNLzJU5CeV9IUkQdGcYDq+PzjYp2DlHEsTvRN7Ra1HehDoeI2dXG3xHIOGrXDYn2zIWRuC/IsKO41khSioe2+Kf5T4MP9Xyi6DhMzig1/85JqNoVm5JZHRQy4nTfvsgKip6NuC/Lqc1RhduiogHHqV0sS4G1+EAMQB2Qxc/kY3fOInsTnduVHJxnOBjHEQ0yBXJTwoY235E3LRszbFGGvnfgAAQ+14WqKCSYZk+Nf9x84v0AauhsQOcwsjW0pkMNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyidJq+v+n3Z6/7kJqwS63hQF6BynlO3/DC/tVeXVRc=;
 b=h41ujlR5xEDSQFhXBmiNlsW861pmrF35CxpSQv0M/wdzcgtjhNEvXsOfM4utuhb0z09U5u8lgROaNhGCU+c0DqAjocwBQji5YEOW3N13cszbwjYvgclz9mGEU21Ne4EJihorD78NoHDHSfhgVKc94Ao9DP8IDAQvuzYeCVhJoPYpdvGWoN893a77OkmOAZg9O7ZuAH8AMIUhXxtWgXfRNYFBWxrfcnFL1y+0Fp8IzBn/WS7QVulZZnPBvhXQ6UWkrsJ2wy2cg4xW8s/YNK4YHqeGOHAc+w4XeiGOGQZDp8oEFvl+Rjh4XBmdMl7gIUwub7TP5tCbljPvbTfEl5Ay4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyidJq+v+n3Z6/7kJqwS63hQF6BynlO3/DC/tVeXVRc=;
 b=Gql3lFCdE9HaI0/iC30/s0EMkaAT9Iw4MYOUAFPehFj2ApBYGqMwj1OCfJmznQ/sgkHOOUgy3gi+pNoVWZElGKNB++gHjGQbVeoNJfbh6cMg4dRK6stSpt31xuUBkCzGAenjHky7x4ygKsiTdxsVPPbxRIPze3rAxZoy6SW5DdE=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 03:07:31 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::e9) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.19 via Frontend Transport; Fri,
 17 Jan 2025 03:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 03:07:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 21:07:29 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 16 Jan 2025 21:07:17 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>, Lazar Lijo
 <Lijo.Lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Date: Fri, 17 Jan 2025 11:07:16 +0800
Message-ID: <20250117030716.3835090-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 31570ef1-d582-4b68-9e95-08dd36a4148a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KzWzcBXeBdR+QMrPyCHwOXtv/ENRqXdP90JLsQLrZd/REjCvpn7oDiGSm+dm?=
 =?us-ascii?Q?eO/FiuW71mB6GNdH0vXX7pCDwx1JHgLLitptnqQ86M+sUX2Oj4ApEKtG5WO/?=
 =?us-ascii?Q?KpZe/ITlTgEOSvb+Z5pdO6OLiHnljHzxQOuYzFJWk46zyF3MxRPc9j5J3Ovt?=
 =?us-ascii?Q?mj4eufQosDBADJvq6o/OzIs++prwQ77gPKq6treGQ/izrETecx2Rd929Y1xA?=
 =?us-ascii?Q?ZqXhaWJEBu6OAiDJv7N+XkmiFYSrqoDKxw6A3ED4GO0lYSf5PQ1h7apmEVuZ?=
 =?us-ascii?Q?6gR7hBiujpmfBcwpwdO3k/MtGVN8TJf5lVbwps+Tcb5KqgM2ZeCmbf8y78Ej?=
 =?us-ascii?Q?sscjkvV9ZH0cOLa9wG7ZVWRx5VC37SYtOXWmwf0s+f6i7PnKRobmVcVILZra?=
 =?us-ascii?Q?QopTT2y6rvp59wc83XnZySllIr83AIQZi0Mauo41+LIFYwt/ggd6OKrmi6NI?=
 =?us-ascii?Q?joyJByE3Nb94uYtEZ1nOTynJSKRigpaWHmp0cw3wAb9VU3xnVVcGri/JBQsZ?=
 =?us-ascii?Q?/rnI+rgyzZPTfsvHU8lr0htuhi48m5bgpRPFN7N0DWVJT/K9NYOPBX7felyK?=
 =?us-ascii?Q?UewJkVSso3Nj8gKj8raC8nYvSTvHD3Nsl1KZa4feqVEyIz0+RPnqJkAny45E?=
 =?us-ascii?Q?pyeCpQuVL0uOQdZljC4FwiFnAXb+tKaIKPHcUm1UW9BY/5HlYC/oXAOEVAo0?=
 =?us-ascii?Q?Y5K0mvnHujRLYnXgsbp/3eBJQW6QMdLKB7Yq1NY4cwzZ9fCeAF0/fwPjFHNU?=
 =?us-ascii?Q?bd0rcuYhcKUM/VL31xXt8EdDyD7l2DpkHaun4PbmLMFHBaMe2Eru4LZrZuCI?=
 =?us-ascii?Q?mho1W9sXaqLdGECfg7y3WuCq+hSGAsiIu04ycbLhSB77skmseOS0wimO8Oo/?=
 =?us-ascii?Q?8CeJhsl0dzkVaVsvcUJTI+VTAm3EGBggUzcBaZ6/Xu34VNF4Bm6kbf3FEUOI?=
 =?us-ascii?Q?A+diZJdrSOPMg5DM+/dtPBgAYsKnoi3IHuwrWxPy1fo1qJQnuUf1OCluB9Vd?=
 =?us-ascii?Q?SRFLSXQ3iWfSV9QYWYCV6Yyh9H4Zhd6b8KMyozRKPKJJlWgQbukY8Q5cs4Nc?=
 =?us-ascii?Q?l9GPAL1opWGr3uF7kKu6qO8Z4WIpsUG8GtMcsivC3ZQXDcWJYde1lvdsERwk?=
 =?us-ascii?Q?eplMp/Pp9Z1/mK4dukJ6n9NEw4qBhfThWKmc66XIuh3U8l7wxAV0kaZAtq40?=
 =?us-ascii?Q?cabW7BAVvss/jaa14tZpPC9HSt4sy9+2ko3leyV7L8rlJGwGTAk6F76InPPa?=
 =?us-ascii?Q?se/CPJRgtljb3tSNbaa+nF6N345L8RfvSsfp969rlXSFmqSLrOlOniQzva2s?=
 =?us-ascii?Q?u9o/I9YhGHUDBnfVu5JAPpTh4TCEo69qD0CBu9cvDl+QlLVX6P5Cux0tOOHz?=
 =?us-ascii?Q?6IZKmyLAdMnUj76RzRtrdkOfQc21Ud6K7ELREq2JI0fYvNxf6tz+H4b+wMnG?=
 =?us-ascii?Q?wldHxwXHEYNJ/pnim7HcsIVX/c1V9lBVii0wDl5gYITjTk2oTApQhobpX8Ya?=
 =?us-ascii?Q?2bAVVMI5zv9O2Wc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 03:07:30.2081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31570ef1-d582-4b68-9e95-08dd36a4148a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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

This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma`
to support multiple SMU programs with different firmware version thresholds.

V2: return -EOPNOTSUPP for unspported pmfw
V3: except IP_VERSION(13, 0, 12) which is not supported.

Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 35e2f0662fb5..591466e90f8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2746,12 +2746,23 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-
-	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
-	if ((adev->flags & AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
-	    smu->smc_fw_version < 0x00557900)
-		return 0;
+	uint32_t smu_program;
+
+	smu_program = (smu->smc_fw_version >> 24) & 0xff;
+	/* the message is only valid on SMU 13.0.6/13.0.14 with these pmfw and above */
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 12) ||
+		((smu_program == 0) && (smu->smc_fw_version < 0x00557900)) ||
+		((smu_program == 4) && (smu->smc_fw_version < 0x4557000)) ||
+		((smu_program == 5) && (smu->smc_fw_version < 0x5551200)) ||
+		((smu_program == 7) && (smu->smc_fw_version < 0x7550700))) {
+		dev_err(smu->adev->dev,
+		"ResetSDMA not supported: SMU program %u requires PMFW >= 0x%x\n"
+		"Current PMFW version: 0x%x\n", smu_program,
+		smu_program == 0 ? 0x00557900 : smu_program == 4 ? 0x4557000 :
+		smu_program == 5 ? 0x5551200 : smu_program == 7 ? 0x7550700 : 0,
+		smu->smc_fw_version);
+		return -EOPNOTSUPP;
+	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_ResetSDMA, inst_mask, NULL);
-- 
2.25.1

