Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AFDCCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2881010E6CC;
	Wed, 15 Oct 2025 02:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O9RionP7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFB110E6CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGjLIY+amF+D3SCLo+qUclUDF9rIaJmdjs4rjoKTn1xm3jDF4D34Ykrh/X+P0yVj9f7LPaF8n1D1QIJcmWxp+HXbGi+sU/egbR/vkSSnarRny+JQAWMxH5Vo60Hi9lDuLEla2SIvQq4GmQFnfyftopbLO1sDHck5aCRJNT4TTxqwlM9IVwqLbiGpHij/5ej3HMz8vmqRWotPKMTtatvGYjMDmND8LZ7UX8SPjPwPS6s72RycemH+nHyderDTvpTVDFuZa880YvprvVj6WO/LfK9e8MQJ9al0d44jYE3eRTPIESMaepU8IPbzeJJZabR8a9G8FfWJxPvBcTHrazmUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frahOvAICxxxT4YmyxbGypVOD3U+BUrn479P3c1Fi2Y=;
 b=BYqsDChr52QYrj04FEH+QYGV60DyenrS1icYgfSXu8KNNlw/Av4iVPJZmDUXhsRoRoSlEAER6hQftmVc1qCPRF20dsjlYaJ9O1sLRL3olzQ3LVJTMCmoCQecg1ezYCtzfiMtA2VGzGNUMbZl+JUtj+srZ9cDqROvup8F82fYu84WUbhT4rSRRzOgSOnGzzWz3skh9joThxFOKmckeZemK9uiFp1Tfzdpi8h8aWBlkHvjh8S/SHLFCdid7xiXAMonZ5WGbpcPmupU0wS3wKYabdx7vv2b4SOnJlRSw4ePJ9lOuvofZ87bdMom3kEOKwIk9sfY6sY8HHPmjeeuHSPFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frahOvAICxxxT4YmyxbGypVOD3U+BUrn479P3c1Fi2Y=;
 b=O9RionP7R2yzt2hrO9ijpFfAi34eZ1X7qqY4FLq0hIgDGATiC5xv3VSEL9kjdKXo9Hy7ZyWNKJTnQB1w6hIBavyglsD7bBe5LxjXsDbSjGcq53qv8DYepOEDBsskYQESb+1oRXjJTHNXW8oF89dz99QdZWdQS++ADMVnthoL8dI=
Received: from BLAPR05CA0037.namprd05.prod.outlook.com (2603:10b6:208:335::18)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 02:13:21 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::26) by BLAPR05CA0037.outlook.office365.com
 (2603:10b6:208:335::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 02:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:13:21 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 19:13:20 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v4] drm/amd: Check that VPE has reached DPM0 in idle handler
Date: Tue, 14 Oct 2025 21:13:05 -0500
Message-ID: <20251015021305.624573-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 02947afa-e6a8-46e6-13e4-08de0b9069df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZAmc7KPLZ2AhJIO4Zu8MaHBxf5NaSSQK3j7HKTnz7ms5Bq1JbmxTLDEDNESo?=
 =?us-ascii?Q?RKWqMASoWCV0RtCsXxd8HmpSFnDQw3nblf/Fnk19XMn8P7p2JI4TvS3I9U4b?=
 =?us-ascii?Q?fu6UG9pRIM3EO/AnHVJvaqXvOzjzlNhVEpt7rmvI+BjQ9Q1mwfQ6OI1yNZxU?=
 =?us-ascii?Q?gy+8hBStCTAvp9fiKeTIUFrd81yUqFOAjwnMz1QUtcc8/fypxV0WH9XCB0Ww?=
 =?us-ascii?Q?MjjvU8Xo+mzO2utQTBuK9rqV5fw88GyqHKx3LPrJBzbN/eGljoTWL2tIfzYX?=
 =?us-ascii?Q?mIgywQDOHWP1+I8JUvDvj4YsycxRu38pw3OmPT9V60v+FGBNTT6IhAfgmjGS?=
 =?us-ascii?Q?dkQEtIyggh+5RJY9tOQFTggBbXApid7wQYwuUL6MaY30p62kxccGdTWmNCxA?=
 =?us-ascii?Q?kc3/jSESV3uQOf1mYanmW9tFbefo3uDlfCEcw8wrWkbenWAyZzVskTUs8xN9?=
 =?us-ascii?Q?ZFCiQktChXLwjVTR2su7lenZNRqVbPwz8sjPhyJqPFcl9JHuyR0WNrba8P8D?=
 =?us-ascii?Q?w+JsEUnB/fMIEJWxcOnVDdySl0wCcQ0K/D5vGpDGQoTiQ7HnWWLXPe5+QDHp?=
 =?us-ascii?Q?VeV6n6Vht1jMDcJ5CZ6TavbtFNcZYlln0jCuOc4vy9OtQn0KcCvAMaTf0caL?=
 =?us-ascii?Q?sYK5hxDXq6lPayXmE0c1pJbVx83JQm3KOd3Wv/dp4DCXRHGoKZpUt1kC1pLu?=
 =?us-ascii?Q?hsAmzo4rCDu2FsXmJHLJJ1dw5N37IKAJHlSi7kUAWjF1N9i+WK/qjUi3RgW7?=
 =?us-ascii?Q?T+EPpipPrsdNW6kkCwxwhTpmTVCacfVBo3mfF7VUTrd6Nc8QJbrud4iCE2Kn?=
 =?us-ascii?Q?NQwu1g7IEnwfY+I5tM0fFYBj0bstFn3WFcPrAjl6FIkm0oXOSnX/gX2AKypd?=
 =?us-ascii?Q?8sjuwSAaXpRAW9HcCHGCwqBTOOLvlLKitM/XuKil5EzLbrCNEEFv5TNEzvjF?=
 =?us-ascii?Q?4GSLLMo6an/vN1ccPhMbdFDtLxXgH/0NWdFHCKQMLm2tZh5X28cLll2eccUV?=
 =?us-ascii?Q?Atd9qDo8R4367CV9xImkVKWueDPv8kDq4LGYnHlfwV4HET4StttXB/NBr5uE?=
 =?us-ascii?Q?8HYxFHHH5LVebNa4ezrcVVMGqYKkJVCS1k8yq/QI/MMtGuxK2u4jFIKdQV5s?=
 =?us-ascii?Q?4ExR/qcvukYpwGB+fnMymL9yDaJp9vhl2lxONp/CNhBheqeTE14xYZX6ytJ2?=
 =?us-ascii?Q?1hcbl1e/cNDWYvpiDXWWIxs20Jwf1OLPUAVDDqHrayqlthy3P9tCbWlwBm20?=
 =?us-ascii?Q?MYYJPie3l8Hm89ZgBYx34CkwvedaoaZHNwBPx3t62QV4PrUvRJ/tQlwBtzZj?=
 =?us-ascii?Q?swx65klFZqkkilS60T6kEs3oBLxhoboUataiWEDW7CE16GuDBQkYiHi5E3of?=
 =?us-ascii?Q?G9uU/kO46OIWJgj9OMVbIPqrn8VmK3qPTTMIi0dw0tKm0TR3sXbynUvZuKPv?=
 =?us-ascii?Q?ukg2KcC+RuaXrssC59kDS4OmiA+cH9NyJWQEg1SW7sjBgpzubaQk3X0fmlWL?=
 =?us-ascii?Q?/AaUOwQZXTkR1+A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:13:21.2193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02947afa-e6a8-46e6-13e4-08de0b9069df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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

[Why]
Newer VPE microcode has functionality that will decrease DPM level
only when a workload has run for 2 or more seconds.  If VPE is turned
off before this DPM decrease, the SOC can get stuck with a higher
DPM level.

This can happen from amdgpu's ring buffer test because it's a short
quick workload for VPE and VPE is turned off after 1s.

[How]
In idle handler besides checking fences are drained check that VPE DPM
level is really is at DPM0. If not, schedule delayed work again until
it is.

Cc: Peyton.Lee@amd.com
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * only apply to Strix Halo (VPE 6.1.1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 31 ++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 474bfe36c0c2..95d0badeb479 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -322,6 +322,26 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+/*
+ * vpe_wait_dpm0: whether to reschedule idle work waiting for IP to reach DPM0
+ */
+static int vpe_wait_dpm0(struct amdgpu_device *adev)
+{
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
+	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
+	case IP_VERSION(6, 1, 1):
+		break;
+	default:
+		return 0;
+	}
+
+	return RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv));
+}
+
 static void vpe_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
@@ -329,11 +349,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
+	if (fences)
+		goto reschedule;
 
-	if (fences == 0)
+	if (!vpe_wait_dpm0(adev)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
-	else
-		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
+		return;
+	}
+
+reschedule:
+	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
 static int vpe_common_init(struct amdgpu_vpe *vpe)
-- 
2.51.0

