Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59D4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 03:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C6410ECA5;
	Fri, 18 Feb 2022 03:57:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E622410ECAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 03:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM8XZfGTDYSj77U9zKT8hlU55Q+qz+BlSvfIYySwmz+TsIo7vfnooyRrGj5/DVsemrm4yPu6yQSzsNengDE8kAlKygZmC7QHcT1tok+CDAvhf2ImMK0uk+czfuuZ+YMEargwgNeIHLsymivUj+BEisj+hzHo/y7U2kvS9Axb7WlP48CjOk8HxmEyasxfIYvmSfAXTm6t8g4NrD8liBZLpSPEWU/VnBcy0R1wdTHgvKIoNZ8wY78cc/UrhT1LEa6MzsSrRiNBd2YplXlebjorxzFojfmn4loGfxfMzihd7YUU7wmKyrmj3W6CvCk+QNm/8RSqc96BBXBSS/nIlvviKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYMnU9Spcj9x6leFIIaaML1/6Rd5ZPt3S7jMl0H9D78=;
 b=g919ppKDWPuCTRgYFFiOyh62xIQTxNOujBjVyX3V1plVHTEXyfXF7rRd4ETdPCUWmSrXuHnBYVOsqxQNhu8K7UhcOQT3cclHGkBGVT/KQf3d5YU4lkd24MMp050BOjAN38wdJVhQ2kmPHL+ZTSQUsfN4P9q6/aNerT8MuFEfjsY3uAIifhqg3uobMxDvy+8Nb/tjzIaFhQv3FbA3BuNXR7ALb7HhLnnO7Sv8Mtamcsd0egXYtiqHETBRdTmg4WjGBnJfehn6MLqfnfIczf1jxMmIpc7bdYbF0ANmQMn1U9vGrjFngNXOcLCl7qB72zQu7vv3ED8igtg0Gxym/2ohZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYMnU9Spcj9x6leFIIaaML1/6Rd5ZPt3S7jMl0H9D78=;
 b=eo/yozdTXLvVCXXhFHhfMBc42q3/XLi95ClmAnJhgZJ3bxzv5dedYeaKEQV0Wkn58cEfbPS4fp8NcdQyvXn3Klper11YYEkVZT22rR5bFMVLEeaTOE0ZpAqJIGWl8PBZBkcpNvzPQU1RjJH8ar/yTivGM+kVA5aZrm/q/UNUKPc=
Received: from BN6PR19CA0099.namprd19.prod.outlook.com (2603:10b6:404:a0::13)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 18 Feb
 2022 03:57:23 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::f8) by BN6PR19CA0099.outlook.office365.com
 (2603:10b6:404:a0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Fri, 18 Feb 2022 03:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 03:57:23 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 21:57:21 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: validate SMU feature enable message for getting
 feature enabled mask
Date: Fri, 18 Feb 2022 11:55:01 +0800
Message-ID: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da8b6039-ae56-42fb-c54c-08d9f292c518
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5049D93A26B6D8FF42E7E28DFB379@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkyBylp8qY+aHwCM2M6/vBLOwF72nUqOWxZSC9BbQ/1spQGhBH7p5jKdk7XgzrQ819lu2X4TT9YcanR7S0WNJB3G5+VEFsPZ5yi8Nku9p49tgUNIGs2nbBBm/DlqSax6PfrI1Gxd8zcQkpTiFQCn5uFjR/4hf6Bi4aUrLazKGWeHQnTy0apYi8L+wryu4o0oDbv8eTB89HPLvaH80U3gX05czGgzCOTg0WAaUjsvRran96p4vebQhrDAnp0GeUsjzQWkQHEVuVJ8eeV8k8NuW8d7ITZLpokoVtkEyKRXDfz7/aOeiXAR4DQj6ZV5Oco755wDPDr/hcPTQgRNVUDgrLq5VSlj0HnZi0N8iRPMkmRYljDDJeLnRFTsGoRXBK1+AIqGitB/q5WV4WbSpG1A0t6+5VYODtDP8/eCliyWoQxx4EL590fXmlyduArY5tkl/lMW1wL+4ji49K5qdefxvT3L0K9N9Ai7AxbmAmxlIerDgFYNCAtxQ8FRe6Xp3x02WSu7N0/oQ0O9cj5BVQnZs1zgJrmAcoYhxKmqgTbhgmd2zQfjxn55goH/z3rv8BNPkRaZ+g//4HkePc2SJqwniWSYT6vVy+KzKTC3URf0glx8SIh2eQ6Jiv/1kk72e5gFgsrzokZAA1TSniiwkm4x02Sy1in859EHxMTeLLuecQpMurbecF6XKhmNkdJiOVm4RTzmXPgCt2tq+Xb83JiqHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(26005)(8676002)(70586007)(6916009)(70206006)(2616005)(6666004)(86362001)(36860700001)(54906003)(508600001)(81166007)(356005)(316002)(336012)(83380400001)(47076005)(40460700003)(82310400004)(16526019)(426003)(4326008)(36756003)(8936002)(186003)(5660300002)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 03:57:23.4736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8b6039-ae56-42fb-c54c-08d9f292c518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Evan.Quan@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's always miss the SMU feature enabled checked in the NPI phase,
so let validate the SMU feature enable message directly rather than
add more and more MP1 version check.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 28 ++++++--------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f24111d28290..da1ac70ed455 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -552,10 +552,9 @@ bool smu_cmn_clk_dpm_is_enabled(struct smu_context *smu,
 int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint64_t *feature_mask)
 {
-	struct amdgpu_device *adev = smu->adev;
 	uint32_t *feature_mask_high;
 	uint32_t *feature_mask_low;
-	int ret = 0;
+	int ret = 0, index = 0;
 
 	if (!feature_mask)
 		return -EINVAL;
@@ -563,12 +562,10 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	feature_mask_low = &((uint32_t *)feature_mask)[0];
 	feature_mask_high = &((uint32_t *)feature_mask)[1];
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
-	/* For Vangogh and Yellow Carp */
-	case IP_VERSION(11, 5, 0):
-	case IP_VERSION(13, 0, 1):
-	case IP_VERSION(13, 0, 3):
-	case IP_VERSION(13, 0, 8):
+	index = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_MSG,
+						SMU_MSG_GetEnabledSmuFeatures);
+	if (index > 0) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_GetEnabledSmuFeatures,
 						      0,
@@ -580,19 +577,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 						      SMU_MSG_GetEnabledSmuFeatures,
 						      1,
 						      feature_mask_high);
-		break;
-	/*
-	 * For Cyan Skillfish and Renoir, there is no interface provided by PMFW
-	 * to retrieve the enabled features. So, we assume all features are enabled.
-	 * TODO: add other APU ASICs which suffer from the same issue here
-	 */
-	case IP_VERSION(11, 0, 8):
-	case IP_VERSION(12, 0, 0):
-	case IP_VERSION(12, 0, 1):
-		memset(feature_mask, 0xff, sizeof(*feature_mask));
-		break;
-	/* other dGPU ASICs */
-	default:
+	} else {
 		ret = smu_cmn_send_smc_msg(smu,
 					   SMU_MSG_GetEnabledSmuFeaturesHigh,
 					   feature_mask_high);
@@ -602,7 +587,6 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 		ret = smu_cmn_send_smc_msg(smu,
 					   SMU_MSG_GetEnabledSmuFeaturesLow,
 					   feature_mask_low);
-		break;
 	}
 
 	return ret;
-- 
2.17.1

