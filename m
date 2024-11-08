Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E69D5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A7010E0DD;
	Fri,  8 Nov 2024 11:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YvhgD+ca";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CBF10E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3wOeuR33OfFtdhjxQNzShb63IzhiCrmdok9KU7LeVd/1HQY7b4npsKBmE29uWOI1S8NxRji2H+8uZhzRZP6YXfCFeXRdwFdNF+FVUWNIVVAtl+w42ZbOewntPG8baGvLL15zHhXIRGxsa+hewoLcemddBD/yjjterkRFI++d8MK1PNMmLcvispjAeQH+PaHHKw84Rja+oEv3paGz2bEVRcFACtIiIF8PsIgkjjIV5OipT8vgjrVKTr28O+4pk6449q/Lqu6XMhJJddIcimxvJA4l56488WlYPWGOVJMXc7LXEDlISLvQVFBzLAmwEi8ts1nc61eCkpeEXjPuNztCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxzn9p4XbwfvNhjDL7ovHLUZYmNQlkhWCfD9g1sHCgE=;
 b=PUr54hgbNYDUXGkpGX3PCRZNCgSpO7MmceHmkDtnLg00ekQEuU9OAzEnJe5OzDDYpvjJAO9ry3DQCOsw+DZu858JOit9vFgjsAmY46TMtqp3Gcr/EjEwGpg3cWzPQLcu3V/GJK3uxgeaygbyvKp+9SiO0w6ynJzhI4j3vALpcIEC8YFJW33j1JhQe725SccEMQbN8x7S/ada0wHIqeJhwiP9OxAsxTxiMpT2tPekf2sixVwmdo1ZDbsmZQrrk/jQKaoC13RXrx7D30lOdZRDwfh0obdjUQBW3tAbrOtjDwbQSc5PjkFAu089lurYpxYxNJcaV0y40Mpayk5dIC0OYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxzn9p4XbwfvNhjDL7ovHLUZYmNQlkhWCfD9g1sHCgE=;
 b=YvhgD+caTh68E2qf7kns3pcvHVMlwahgO+W7/BlmOA510dx2ALfmtI3BNCZD/Weh+qerZ+PQGeHXOQgdwLNEKCKOzW/dQ1+RdLB5gVc1qRtGLBBybTpf+OPBlV/aFCsHDhK5HcDNVkbhVLFRrQpyBIMZzxLcC15JTTZGA8dPeG8=
Received: from BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 11:14:34 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::d8) by BL1PR13CA0201.outlook.office365.com
 (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:34 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:32 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 02/23] drm/amdgpu: do RAS init in NPS mode switch
Date: Fri, 8 Nov 2024 19:14:02 +0800
Message-ID: <20241108111423.60169-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: db568f79-292c-4342-689f-08dcffe6867e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yy6sRtOmg7YpTPeOjAbOEui2HV9bkhp8n/WoY7wJnUBMpaMAEPb4rPGkwD8y?=
 =?us-ascii?Q?hDSGXV6ktap0lg7xgk0QZZDXB+6wl91T5p9O/LqFk9ULYEZOsPKN4ebsBvs3?=
 =?us-ascii?Q?L207bsq3kKExSGVJMo8F3BrWmvRztpSU0tUj617pyAiJO1zsD6QjJgDebPsV?=
 =?us-ascii?Q?8ccHB16HxE88TtWez6t0tslHPNDn69t6OZJR3CRE9NGYnU2+8jsJEsB5JBRD?=
 =?us-ascii?Q?O8rTKKBQeZbMI0xBuQGvSmhGkBcVtlBA9BPUpRDLnPt2Y66FoUxOEns6qtmn?=
 =?us-ascii?Q?qJsMRsfgJNJXhc5bVuyWjslt0qUwofI9bphMOd3Uu+inm716eZaIc5TTyThB?=
 =?us-ascii?Q?YkUREE0Rpq6eME/Vbf6mWEp0jp/ixyuv82xopVXzOmibNfT5I0Wtlv6QBYtp?=
 =?us-ascii?Q?iniDtsjKw/umFpVe86CCsypPg903u9JevCWr+wbHROy71JOMyX/g4oRGMPcA?=
 =?us-ascii?Q?+D2Jq0XTFZ3nh07eHonCKWAUQnVMkJnm9Xm73dqW7wHYy646cp7vkFVkfPRo?=
 =?us-ascii?Q?MWArBw47xQADFCFMoxottOSlmte2hCeGbv/SNt7El/b8hJaOM+AS7TntT2FR?=
 =?us-ascii?Q?c8WgcEBEovWPaF/EKsYjpcoiVT5bd0EsdeVXmQiO7Ttu66oOzeXBXWe1/jPC?=
 =?us-ascii?Q?pPk9WeeAkwlLJOghgbPUc9RrdLg/PpPximQ6LRi87jGjYzpacMjHIf+vaTj1?=
 =?us-ascii?Q?2VfWKMiXltXtkPPa0N0sh1qux8RZVRSDr7abCEEmDZELc2Uva2j/qXhJ3RDI?=
 =?us-ascii?Q?NgKbdfS82mRYrP1xXxVfPjh/1lRkCbZLhNKti4iNLy/TRlN8F5XB7RwroxSj?=
 =?us-ascii?Q?lNRhDJkTFLvPjHlNjiRMLXBgkCWCarVUw26uukSuROOUfxIaBZCzEBqOS6pu?=
 =?us-ascii?Q?cS5ULLf3XAC9S/4ppW2eAIWFdjY6dsHpHkGLKG9Nsh3YaCFkeIEb21dXAUim?=
 =?us-ascii?Q?02nL/fZZ7ksaipkvvVCNlwI/ZhZXt6BMmkWaZCsOnWsmX7K9y0M8rBYwd/rp?=
 =?us-ascii?Q?It4+7V9Mm7z8uRPryrARjPFj/KwcMV3fX56a1LVXJ7c9PM0inRxeh6stj1wj?=
 =?us-ascii?Q?zeCtIiYMp8vrlxP3hxa2Z+rQ9qrbdM9SN4TnpthuibONoVxvlttRavpSe/m8?=
 =?us-ascii?Q?v6868jib4z0v4xwDypctvz6tEKlm62j6/a2nrZVlXIO9BkDIrt0wGdaVjrFk?=
 =?us-ascii?Q?+u9WpB7Ijom1ex5gNo4rOYkm94MVdMzHQjPXrY9V382cDC4j3jJKBWlocDQO?=
 =?us-ascii?Q?EDToWwWXZP8t3lsIIRk0zNNy+bfgBdXuglroUkThJUFTzIadR1uhQ1pgaMcM?=
 =?us-ascii?Q?HwS7+HtJrN1MrSxFa+TGvC3Padndd6YC/6xw4khG3NggHG/8vH1ITMAZO3A1?=
 =?us-ascii?Q?3hd5/XZY3MtwUiwIOCL19kTtQvXyrie8J3MCxdbu7xkKn47soA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:34.3135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db568f79-292c-4342-689f-08dcffe6867e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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

NPS mode switch will call gpu reset, but this is different from normal
reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d69fcbb28b0e..635f020f8d9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3293,7 +3293,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	if (!amdgpu_in_reset(adev))
+	if (!amdgpu_in_reset(adev) || amdgpu_in_nps_switch(adev))
 		amdgpu_ras_set_error_query_ready(adev, true);
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index de1a55ae1d78..cbecf2380b51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1253,7 +1253,8 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 	struct ras_manager *obj;
 
 	/* in resume phase, no need to create aca fs node */
-	if (adev->in_suspend || amdgpu_in_reset(adev))
+	if (adev->in_suspend ||
+	    (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev)))
 		return 0;
 
 	obj = get_ras_manager(adev, blk);
@@ -3780,7 +3781,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 
 	r = amdgpu_ras_feature_enable_on_boot(adev, ras_block, 1);
 	if (r) {
-		if (adev->in_suspend || amdgpu_in_reset(adev)) {
+		if (adev->in_suspend ||
+		    (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev))) {
 			/* in resume phase, if fail to enable ras,
 			 * clean up all ras fs nodes, and disable ras */
 			goto cleanup;
@@ -3792,7 +3794,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	amdgpu_persistent_edc_harvesting(adev, ras_block);
 
 	/* in resume phase, no need to create ras fs node */
-	if (adev->in_suspend || amdgpu_in_reset(adev))
+	if (adev->in_suspend ||
+	    (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev)))
 		return 0;
 
 	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
@@ -3922,7 +3925,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	amdgpu_ras_event_mgr_init(adev);
 
 	if (amdgpu_ras_aca_is_supported(adev)) {
-		if (amdgpu_in_reset(adev)) {
+		if (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev)) {
 			if (amdgpu_aca_is_enabled(adev))
 				r = amdgpu_aca_reset(adev);
 			else
-- 
2.34.1

