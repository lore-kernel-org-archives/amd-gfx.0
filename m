Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E688C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D8F112C99;
	Mon, 29 Apr 2024 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brQPinIc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282FD112C79
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzCgaudPoN8Fi28SplzLzSlZmSn+q2c/1KyhIncnbLAps7ZCH9SA/uV20BzhIcOcK8CcJkF+l23xU3dJpbeO9PTJi8jv32+CoazNszCaLU63XYTwa76dIBVyacCVy0fjcXuQmMqe8jf/SDiWndftA+MJrlbmL/zXUr/w6FgKaIbj/ovFrAyrBP1WFH7wnBSu3QdSj6i5a9niAARHYTZFh/OM2jkqprbzxnlzo06ZrFHrUPRQNZY3NVQi8Bhcfs0P2KepXY26q2IbsXiLeCUL6NKAuyZjGFqCzr5onu03rLQoBAaqYduG9qF9BVxp5KwLesvij51mJYDyKJw5Ejw+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QplNO/tuVNzmFZKrfAHpD0eBn5JwLFXkAUiSVq2P5Dk=;
 b=NvAnxSgaIiCi98oRvSUpcaba36DOET3ntHHhN7ysFe4vNDCWn8bf3c5rtXCmwWjAGO+8Pd5ZLPR0XRSFCdgYRBd6zEUCbSOVGQi5AOjLYmXNIsSDcDMRcDzS0jYS4rJ0OaZflWBQ9qY/UochVp7oGhxRz9vslJId9pVnz19xd2zHFeV3fT2mkAU9n9cURbxC57735Ic7DkZwtfou45Fq8vMrByNl/blzdXLlbFvybynAVdvjZ/0FL/sLWOvk+3ljb0tegNLg8rkUEfv8U5HUuYVXRBpkD8bs1r/lE5T1mMFHCZJR67n4rameBnfMyVqF5iEEDYw1U1WzEcbHyNotMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QplNO/tuVNzmFZKrfAHpD0eBn5JwLFXkAUiSVq2P5Dk=;
 b=brQPinIcMJ78FvzYtJJT8Xq0QU7hqPV+E2U+cGp+GH6icJbxAcgrmBK9PpRbhdkG6VwtylG9tJl4E6slQWKIQ0ZzuOSqtavLwf4Ef47RwsVe0Do6z9NWEBpDTFuVarf+v466haZdBNzW8WCdSoGCOZd/Di79KxuDBjCYdtefSMY=
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:12 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a4) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 10/31] drm/amdgpu: enable mes v12 self test
Date: Mon, 29 Apr 2024 10:33:18 -0400
Message-ID: <20240429143339.3450256-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af7197c-9ae3-432b-e078-08dc6859703c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GliGelmvxe8ibwmo1W6YGK/yHakXpFN5iZKUgNiJ/mPYNGQak0x2wHneUa9Y?=
 =?us-ascii?Q?ssrTpkzYwjfEG6vpn8Myjxa2vaaLGufngkqXzQW8DpIDVlSmzl9TxwX75/ER?=
 =?us-ascii?Q?oo0jUfqV4PpgkKKdzaTPK9oXXAbBdlwbdRGtqxnFGbgYtwYPOzyPGkL6m8+M?=
 =?us-ascii?Q?qhtv6oXyazAyBoT2qzr5Vp8jJsuRg8Q9en/ZwbUnwwpH4bIhv/qAzrX8hcev?=
 =?us-ascii?Q?Uz9N5+XegyTAeI/muYTtm06y+humiGIX7BivWu6mo/iGHbmjAQCW6kTVPuYd?=
 =?us-ascii?Q?wyatwHv+V1HCY6QKnAJdp2Yo9VfdIcx833yqpUW2cBBr8FsssrKWbZcD7zML?=
 =?us-ascii?Q?QmdE7xxfomS+CYKqTTm6XHbY431Xcax65XUFr7stY6ICp0iCoRmhm/nB7uUO?=
 =?us-ascii?Q?0kFR2DvB+k93DAejxiIkZQrlebXSCOzdmMfma7ljWkzjbAEURxMGled6EogD?=
 =?us-ascii?Q?xHhQYrAXxvcuz5U4GtIkff6ASZhCyJ2InW0ITQp+t4gbHCvBI3s1ACul4hCI?=
 =?us-ascii?Q?RFY0vs6IPT6lCq1SYY7Nu4lltLejAifus+kKV20Z8U2sAFboO6yBzHi7dVzl?=
 =?us-ascii?Q?o2s2YnJMJEhZWFXfeIVxc0wvIO5qrmCe3QYcu5d8qXpUZ22VPYB2swZESBv8?=
 =?us-ascii?Q?OO6eAyxA1WIjOIOj7utnUd9t4VvFCVmltM7CBxA1exFWs57PRQZWGkungLpC?=
 =?us-ascii?Q?jGGXEJj0b816Jp/t3+3899zasIz0NSb7mX3Gn4LpCgNf+OArdxPMbws6zuOu?=
 =?us-ascii?Q?PL+AlXaqZzkrk6Zl/PaKAPfeefqlidijRLlantlGVMwtgzr1iuffOzP/euBZ?=
 =?us-ascii?Q?FmQivfJSxAw3elfVOUCm0YhMwTKwbSoU96hJ40xIPGcL6WGKbK54Oh1Qm843?=
 =?us-ascii?Q?H7S3M/zwBXEX/5GNLhNfX7Zpj4LSgnqMeA5p/7bJ7TX04wA138CP0fjrqG1g?=
 =?us-ascii?Q?gSYr0HTD2ejGEpoyS5fwCFhNayX0qXsbhAqU/rlZiEl78Q+Zr9KjmxhNkbsx?=
 =?us-ascii?Q?oOmlKLnm2blYNchMOZGviNC3UCBuj6xPWgvPmtU83/9ACIOhbXAbVH8tURQ4?=
 =?us-ascii?Q?n4PiGPc3FHmmO9n1l54K2W8vJuXec8GMN39E+mbeGT4Ar0HWFza/byxib/ly?=
 =?us-ascii?Q?q0XqlS2Cansobwiz8/tqFSUwFUOVJZFDFRLSojNTZR7cdpYfilZxJ93785Nr?=
 =?us-ascii?Q?B7GYErdYZ42de937d275/ryAaCQ53pnPWrGAFxc/Ec0wfYsmQBX7gTKoQa86?=
 =?us-ascii?Q?vLaSqVbYInfbbDtFLR7esNKyAcsbOrI3IA0XKtDgVO6XvZQNoIouO4ArEFbf?=
 =?us-ascii?Q?iDlchZEvII8JSP447THLjV2GSA07b1rFkzC9cFNDXvBqLOoK5el8j/Bw6kZD?=
 =?us-ascii?Q?H9wfWgNFJ3x5osCcZsIcECCY6eMO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:12.2933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af7197c-9ae3-432b-e078-08dc6859703c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

From: Jack Xiao <Jack.Xiao@amd.com>

1. fix available compute queue to use
2. enable mes v12 self test

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 02ce69e3d1ddc..ea06f8be133e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -156,7 +156,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
-		if (i >= 4)
+		if (i >= adev->gfx.mec.num_pipe_per_mec)
 			continue;
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index a9bf06ad0202b..d20bb78280b15 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1301,6 +1301,12 @@ static int mes_v12_0_early_init(void *handle)
 
 static int mes_v12_0_late_init(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
+	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend)
+		amdgpu_mes_self_test(adev);
+
 	return 0;
 }
 
-- 
2.44.0

