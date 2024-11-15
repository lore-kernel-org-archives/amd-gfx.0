Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1920DD6DDDB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 08:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD52D10E3AC;
	Fri, 15 Nov 2024 08:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z4j/cP2w";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FC010E3AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 08:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAopNK6AQXaDxf+hpvSnLDiF+86STjjFikkYhL1l0hRF9HKQaT6aB6kAFHJiBcM3TbK1y+lNTEvjCdr/k0xRShXtIPhbkL9k7zPQnGcgYwt4s5c0MC78FCSjuWa6M/0MGRkM899aJUWk2fHkJrHlOPEIPGJSL4CcOdGwEEQmnH5811aZbLbCcxCv2oEI0fSv86UuVAtkjzL0aICBReEQw9ABSoTDXGD0eR2XHp+0+O836qPbDhUPkxQ7SaO6O2sI8wT3TC28f3itiyk/4QblKJddxhIcgODGQcuTtxuKn4+bPGWtPlsUblvT8utZgGbpZ7s017YtzkvoSGTHUazhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyqkgY4N5G/9nsj0H63H/Cl15KTP2LDNETec1Tmxb1g=;
 b=ZiYCvBdy1UsyDM+qOGZjuTeYBv75guvrv7tJqCNTsLPt8jwTjsoAjR42bEQh4ysGgeOWltFbqeoWdsMmZq1Jm6u/3CYGGgCJ1bRJh4EnSufmS/HfSyjD77/ZHXot1V4LBxnUwrhJx6sPOsQJtd7wMULUSdmxJQStCUcj4W8lliGDSbz/DQGmhHOwMNstY3zQOwnsS/jdMlWKqSoa9lDwlzJ7rnzkMhKppBNr/rz12sSQw3elLzXjPgNeqISlHNq350eaIuWgxhuhttwmieQ1Mk9kbpEE37YfH4HmEBKBvQsbRcmsyFG3FCu/DloHZwyBIZZGW0dLBztgKZBxcb7viQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyqkgY4N5G/9nsj0H63H/Cl15KTP2LDNETec1Tmxb1g=;
 b=z4j/cP2w5VdOjf7C5WmqKa6PjEG09nG4hn3jlBct6egvudQSADhi/jGDSxktClM1imP6un+Z/ju9+3UxBoQsweec0szDrs7tyBpAzaBQSRPsV/QxkmSNtz9JztXdrkmOV3wogmntlACg1tyZR8LlOMpzIszYA+NxBQJsAYeitgk=
Received: from SN6PR16CA0063.namprd16.prod.outlook.com (2603:10b6:805:ca::40)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 08:03:52 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::d3) by SN6PR16CA0063.outlook.office365.com
 (2603:10b6:805:ca::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 08:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 08:03:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 02:03:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Check whether in reset recovery state
Date: Fri, 15 Nov 2024 13:33:32 +0530
Message-ID: <20241115080332.3373091-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241115080332.3373091-1-lijo.lazar@amd.com>
References: <20241115080332.3373091-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b5f09c-8a1c-4440-15cc-08dd054c0b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RqZDvGPzprOD93rerF6u0DbmorTZxKZ2VRLCHdaQ2Hz7wCGPi+vqlNayQIun?=
 =?us-ascii?Q?qmyEAekTnics3eYVWWadUXWSlvlvsChzDF3IfZwlVqKrGOMPF2GEcndH6r8v?=
 =?us-ascii?Q?b9PnB0mB13PZv8U/L0kezTl1kEQ7qWg8L1MMMr9W3oJdVQL+EJcSdWPAUEzy?=
 =?us-ascii?Q?bDrhqY/UL8jeWVwiC/dvjBGK8QwXR2MEiJHj1z8/eZSq8vAB/8ujafuICDc1?=
 =?us-ascii?Q?WAWCQ5fTT0xjpIeC1IfAsRRF35eD4JFODTOA3IzOkoNQZVSFN/vaNHXFXqda?=
 =?us-ascii?Q?/VbSfgmC7uQFm2I410trqJJ3QSyFXTwCg7xTSHubaYcLw6tBVrisx+XDH5L6?=
 =?us-ascii?Q?/dz5fMM3eP5e82zDiQRkzax5IAOC6xCd10Ntu0NS3QVby/hUUgTRFQtIe5MY?=
 =?us-ascii?Q?apd/hBo3sF+hNjX2sdbPs84rqMBeuZVwXzm6knFgKH18y344k1Y3na61upmo?=
 =?us-ascii?Q?O0oiVOvDbxxRxvJjEzWVjsLUj4+CgMCHVWSNU6qSSd49l369y9EPMfkm4djY?=
 =?us-ascii?Q?fyK2+jAHRAGVU0UFy+Mj3TUFgg2Edu0AuUBm7HZNcPdSXCrwMKoweFL3vPEA?=
 =?us-ascii?Q?ZBY5QexBlnosiEbhlvs0ILr9xzWBHw4WqpD9dWvsz214xp2OXWuB8qB5Td3O?=
 =?us-ascii?Q?wUaQBuSynem8hDDYf8LDn4h2XHuMRbuqJC0PBdpuZ7MbC6sP6+iUqstJCUKz?=
 =?us-ascii?Q?+OKA9Q1vmY4oeGexD8GrNrJEEvTnuReRc52G4rL1AGa9VjOMaipYZgRuu8IG?=
 =?us-ascii?Q?kdAyY67XX3FxkUQdLtBwwqCpDg+t4SVUlmKB5EGKugHWT/9D0BJBYeGm3GT+?=
 =?us-ascii?Q?etXKHyAcr+FkoY3XM3HlBUj7P9JEYEl5TJkwFhNCk2A4AwJHQccteCsNPtoa?=
 =?us-ascii?Q?QZSNtpA0tku7WI1PthMIWNFh4VBEXVBuYSTbQpudHePdaJ56gzJurdXwqUki?=
 =?us-ascii?Q?TQz/dZdy/TWmBGoKEJj9PBOtIuK2Iy/oJwPWa4B3yIMj3WLEB37etuK+nLiy?=
 =?us-ascii?Q?HYNYa875IapZl01kJ25agNqHFvPRJUXjIg5xm36STmfRwHGjzfYamGoS89hF?=
 =?us-ascii?Q?DysG1TP8FpszHetrvxa4FTZV3zoCTvqgN8DZA0228Zjl7W+V4uI7Wxor+yba?=
 =?us-ascii?Q?CUZDyoUhI3mKtqLHJDsSvA6lWspPf+rnlMDkNwcpyRSOC0nCidoWjlGYSEpd?=
 =?us-ascii?Q?pOJxWloQ892YAlF7hXzUb6mYFCcVfgkDtwWnfLbz51YwzPcFl3LdeILcLdiZ?=
 =?us-ascii?Q?3Dzv9lgKUJl4YJ0DrjojyxMQ2BluUI5YhLg4gCbtTwNm/5bOfc00RtsQtV+/?=
 =?us-ascii?Q?7fkSrzNLrHMLiFBwn7VKF7WFmXRnp/Mw0ySgeXiJpJZVdi/hKAXoGNAXk9tO?=
 =?us-ascii?Q?eXnupKtaqzA+MZHYAY/gNssiVM3MC0yMgbFalPXoie1R2gbQEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:03:52.3129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b5f09c-8a1c-4440-15cc-08dd054c0b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

Some in_reset checks are infact checking whether the state is
reinitialization after reset. Replace with reset_in_recovery calls to
identify that it's really checking for recovery stage after reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 415c469c2d80..21effe720fae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3285,7 +3285,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	if (!amdgpu_in_reset(adev))
+	if (!amdgpu_reset_in_recovery(adev))
 		amdgpu_ras_set_error_query_ready(adev, true);
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e31b12144577..903cf7957d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1298,7 +1298,7 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 	struct ras_manager *obj;
 
 	/* in resume phase, no need to create aca fs node */
-	if (adev->in_suspend || amdgpu_in_reset(adev))
+	if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
 		return 0;
 
 	obj = get_ras_manager(adev, blk);
@@ -3621,7 +3621,7 @@ static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev)
 	ras->event_mgr = hive ? &hive->event_mgr : &ras->__event_mgr;
 
 	/* init event manager with node 0 on xgmi system */
-	if (!amdgpu_in_reset(adev)) {
+	if (!amdgpu_reset_in_recovery(adev)) {
 		if (!hive || adev->gmc.xgmi.node_id == 0)
 			ras_event_mgr_init(ras->event_mgr);
 	}
@@ -3836,7 +3836,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 
 	r = amdgpu_ras_feature_enable_on_boot(adev, ras_block, 1);
 	if (r) {
-		if (adev->in_suspend || amdgpu_in_reset(adev)) {
+		if (adev->in_suspend || amdgpu_reset_in_recovery(adev)) {
 			/* in resume phase, if fail to enable ras,
 			 * clean up all ras fs nodes, and disable ras */
 			goto cleanup;
@@ -3848,7 +3848,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	amdgpu_persistent_edc_harvesting(adev, ras_block);
 
 	/* in resume phase, no need to create ras fs node */
-	if (adev->in_suspend || amdgpu_in_reset(adev))
+	if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
 		return 0;
 
 	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
@@ -3978,7 +3978,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	amdgpu_ras_event_mgr_init(adev);
 
 	if (amdgpu_ras_aca_is_supported(adev)) {
-		if (amdgpu_in_reset(adev)) {
+		if (amdgpu_reset_in_recovery(adev)) {
 			if (amdgpu_aca_is_enabled(adev))
 				r = amdgpu_aca_reset(adev);
 			else
-- 
2.25.1

