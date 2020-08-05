Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3445EC433E3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBD52067C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rA6hA0ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBD52067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A062689EA6;
	Wed,  5 Aug 2020 09:38:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF4A89EA6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 09:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg4eFGwhekuMWLcVgAyDdwtIsDg49235Yl9TSqxqPF/A5WUsRjzwO5EgUeVMCnDd/zUeTEjtv6lh2Zf1Uv3erwCG7EVn53P3gWT5W5yJQdRxeuAgJuX/k53E8ZJ5vnMKDc+2fOnBNAzDR3mRqMGxmCKDu+kDiEbKGyUdYBfI/sOuXKtbjPOjI6T7JKzeg4dP8e18G9ahBV8ZfjBJUrZqFrIBOK044Xyj57qolzk6OvjAhucc8+WnAOEtMgmZpGMMYnGv9FrHc1qNjeQn8B2cQso46c3/MKMHiuGPgMr+AWDg2qHUGFrz5vHypfhNNINe2wboqUTG5gWSoeukHMfFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b14V+ChmO7U/B38s6SrFaVQVY632EuqMwGWZ3M4C7TQ=;
 b=GxVr1nI9fQ8WqX+S9TAALtK6VEJkdWc2X2fCZZTjkLBp1f9DjzTKuRe/itXf+iBj5fX8SstZgoYg1DZWOR08zY5ykgrVBCl2BRgxUNugP15EUV4uuMXNGnCZQ0TJDL/SHb/wdBPM1ceY6NTAwFZregeLuyePiEQdl0lcuAA9RpLGEA++rKEcqT1uYYdcvu5RIOYFijDkaytjtc43B12D9dbVy5oyZQyIdo9ubeCMDU77H2SIUOc/7ENGGgKLHeTDXKwHPkVltiEZaEFSCgrqijkZuhjxh7sHyv+tdHjjXAyt0Wt+3FFoTCEMAgmCAjgTeIfUwQLpBiZbF2Kyo8p2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b14V+ChmO7U/B38s6SrFaVQVY632EuqMwGWZ3M4C7TQ=;
 b=rA6hA0ck9FxUQBZXWgAm8CLRZ55V0TKz1qYwKPYSBZ3r/oOTNfanIPeMhOjDY5o20byvrQ6zx9oPbWw2QCkMD7jATngj905MQoJjr6IRcGUi/PRfiHbpoXDFKhDxSCcY2bFYdekQhjwgMViZgjnHoQU9TXEUNVyT/VtST3pfKUE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Wed, 5 Aug 2020 09:37:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 09:37:59 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: update swSMU VCN/JPEG PG logics
Date: Wed,  5 Aug 2020 17:37:20 +0800
Message-Id: <20200805093721.2955-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 09:37:57 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5a27afa-f914-4044-9508-08d839233d74
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135363A09397544E15FDA94DE44B0@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DepHx4CRxrBRWzze5GHQl0pAHL42RTJUvXzc6xLk7bSz0DS4I2mjHVBeawEIsLTVuwhcpua31GHq/UD0OnGiVGE6xKogP3IIusyyhjXJLq4Vbo8FMnmThJC3Q1hATYkG1EKGDijcvXKx5kMyWg6urXoUkuLPUCAC5oNjjRsVQivEEvcrF69bRYrZTqNU+Jy6vUpvlfkXxPsWVKjSXeveGFHqgh8hLkKFmsSKOuWDU7y0rmfKYDEaL7GKiCfX8h5+OIJX03NwQTieNUMc9z4m2jgLcFdfaaZ0N97uOxWAupYVxxlU+jiPDHFLtFel3Pmu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(478600001)(956004)(5660300002)(2906002)(26005)(54906003)(4326008)(44832011)(86362001)(8936002)(36756003)(6486002)(30864003)(8676002)(2616005)(52116002)(66476007)(16526019)(6916009)(66946007)(66556008)(7696005)(186003)(83380400001)(6666004)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: afiVfdABIOzug6F0uYHS4la6jEMim4iyB6Sm9akGo89fPALY9lhD9Jvy2D+H0f4XuT0U8b5w9ujIaOEnapw2C0nsuBV2pwqRQK81DR3GIFk9o+00Hgu9XZZUDFMIBqHm0JFrxD5kWm8ujdih+kKkkOv25KUV4uUBw4kCB4vVjBdn/KKFwhmgF+iVz94/rXYvQrnmS9ihAFaERpywlyFfrUXobnkO65IQpfX/Hf5GBZ8OjYutT7w3xuhY6Drmd7cyLRObNkfVg02AJl2U8OwSeWKuCX/f/KDkn1S8UE0f9KVKohdRj9Jlmn6RwXMRzkHzrJOcPvvnmtR4clNcU9EoSwo+BK3LP5j9z6czZOcLTew3hSyI8qmz8z49McieW3tf6mgemgpClk8ihBZqU6GX3MjVXeUWIHud5qjfumGnrOtiJABzMI3idowBXVB3P+DsL/l0gQ9hWaApw5SzTgqDF6mdEgINzJH8uosioExrbOCTbe7sf0DGHQXhLmm3XcAwi3iL6I3F4n9RgBy21aQz3nAzDwMLSVJ5tHCDhZn/G0GpLwex7Pn2pPZ7mccyYSYR3JhGrtX8/eI58nnCQiYR1ftETFvyPUKvosVY5rGhw6Kd89OQ6rDoh5B/Lz/cN/aGTaaszD7tI7KVymb3g5hh4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a27afa-f914-4044-9508-08d839233d74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 09:37:59.5201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbxrMpHNKsEAS0gLI88C5lRrGerWQ7SC8FdDhhSMubDTj9vci79Z+nWUxpavKVJL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: alexander.deucher@amd.com, Matt Coffin <mcoffin13@gmail.com>,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add lock protections and avoid unnecessary actions
if the PG state is already the same as required.

Change-Id: I01400b84151d3ac6e3c8b0d7e264f9a68a9c2092
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Matt Coffin <mcoffin13@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 57 ++++++++++++++++++-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  4 --
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  6 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  8 ---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  8 ---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  9 ---
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 -
 7 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f3f50b5add99..1b64ca9ecccb 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -133,6 +133,56 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_dpm_set_vcn_enable(struct smu_context *smu,
+				  bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (!smu->ppt_funcs->dpm_set_vcn_enable)
+		return 0;
+
+	mutex_lock(&power_gate->vcn_gate_lock);
+
+	if (atomic_read(&power_gate->vcn_gated) ^ enable)
+		goto out;
+
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->vcn_gated, !enable);
+
+out:
+	mutex_unlock(&power_gate->vcn_gate_lock);
+
+	return ret;
+}
+
+static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
+				   bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (!smu->ppt_funcs->dpm_set_jpeg_enable)
+		return 0;
+
+	mutex_lock(&power_gate->jpeg_gate_lock);
+
+	if (atomic_read(&power_gate->jpeg_gated) ^ enable)
+		goto out;
+
+	ret = smu->ppt_funcs->dpm_set_jpeg_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->jpeg_gated, !enable);
+
+out:
+	mutex_unlock(&power_gate->jpeg_gate_lock);
+
+	return ret;
+}
+
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -650,6 +700,11 @@ static int smu_sw_init(void *handle)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
+	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
+	mutex_init(&smu->smu_power.power_gate.vcn_gate_lock);
+	mutex_init(&smu->smu_power.power_gate.jpeg_gate_lock);
+
 	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
@@ -1974,7 +2029,7 @@ int smu_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = smu->smu_power.power_gate.vcn_gated ? 0 : 1;
+		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0: 1;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index e3a2d7f0aba1..e59e6fb6f0a8 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1896,8 +1896,6 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 
 static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -1908,7 +1906,6 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 				return ret;
 			}
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 0);
@@ -1917,7 +1914,6 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 				return ret;
 			}
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ec2d2aa7f4ec..23c2279bd500 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -295,8 +295,10 @@ struct smu_dpm_context {
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
-	bool vcn_gated;
-	bool jpeg_gated;
+	atomic_t vcn_gated;
+	atomic_t jpeg_gated;
+	struct mutex vcn_gate_lock;
+	struct mutex jpeg_gate_lock;
 };
 
 struct smu_power_context {
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 8c45c472f7f2..82659b781f05 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -831,8 +831,6 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -842,14 +840,12 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
@@ -857,8 +853,6 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -867,14 +861,12 @@ static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownJpeg, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 4c1a506c3c17..8a8e6033f71f 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -479,8 +479,6 @@ static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context
 
 static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -490,14 +488,12 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
@@ -505,8 +501,6 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -515,14 +509,12 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 2566ae5df64b..bb756b4c284e 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -815,10 +815,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	struct amdgpu_device *adev = smu->adev;
-
 	int ret = 0;
 
 	if (enable) {
@@ -834,7 +831,6 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 					return ret;
 			}
 		}
-		power_gate->vcn_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
@@ -847,7 +843,6 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 					return ret;
 			}
 		}
-		power_gate->vcn_gated = true;
 	}
 
 	return ret;
@@ -855,8 +850,6 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 
 static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 {
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
 	if (enable) {
@@ -865,14 +858,12 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
-		power_gate->jpeg_gated = true;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index d0deaefd3feb..f1d8f247e589 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -77,8 +77,6 @@
 #define smu_get_dal_power_level(smu, clocks)				smu_ppt_funcs(get_dal_power_level, 0, smu, clocks)
 #define smu_get_perf_level(smu, designation, level)			smu_ppt_funcs(get_perf_level, 0, smu, designation, level)
 #define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_funcs(get_current_shallow_sleep_clocks, 0, smu, clocks)
-#define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_funcs(dpm_set_vcn_enable, 0, smu, enable)
-#define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
 #define smu_set_watermarks_table(smu, clock_ranges)			smu_ppt_funcs(set_watermarks_table, 0, smu, clock_ranges)
 #define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
 #define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
