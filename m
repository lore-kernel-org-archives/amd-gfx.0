Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4106C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63EA20760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y+1yUMOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63EA20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AF36EABC;
	Thu,  2 Jul 2020 09:47:39 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1EFD6EABC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cluTPvrrTwJ+yRxb9idl2+4lYht1MFuBMZyOPMkQHGMGa7TaelMn6BLEzI4dZl+BPmCbUjuMpAoGXtgghzR36daTVActwz4VMbvtY9y/Z8Q+4V/FIEV7y/x1IH0qMtjff+Obf5t+rPyh8G4cPGFJ2fq7mAFDdmTqWpCJyHXWrnMlILglkJtUl2L39GylbXofsYzz94SkdgIWr2znClkcaeYcKkDwt4Y45zEL5Q8v0rkojAZ5+fdn0wyV1MVHRvL09PcKQFzs+WmfFFBojC8onN5nrDxCRE3unCD2OwxpPliwI8GZx25EZ9khKeXTDY7+j4ZTrVOsHwFT2FckZnkv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVgI+cB2L+PVxJeJXfRzkMKp+GxhvrqBNgNathvXM5Y=;
 b=TlB5fnSGizkiILPZU759o/vOVX1W1cYZqudcTE/fzcn2Gr3F5IWHkWF8eaUuZ+/JAg6+D2Urs1eqjnT0b5TcJgLyGVqC4S0ff3Z3B9MW666X5TnzhW5sm76i+KIK5GB3QJHSx7FPGGGO/+t5Hev8IMa583K+gFKpOGkK3ZBtVlNRt5PhEmteX8MXAA9Rr/K7jVAbPGSZhmMUHAnoDTjtmXe9x+gIvlNdQtDjcOVTOgSQkH3zZ7smdkzxL6t+E0XOal6fWp7/3p/x2m421TorSyRR8+SbRQ69cCp0FLy9XwU9wWEPDbUeOfTrYBR3PZoai6hJGWAZf0EQiWziOqr1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVgI+cB2L+PVxJeJXfRzkMKp+GxhvrqBNgNathvXM5Y=;
 b=Y+1yUMOwXhbJcGJB57TGdW8kDbQt3P4YP7byGLW1MbUS3P+GBosNmLsVCvv98Wn+Iz0A6vmhK/XZzrocZZ6VxyP57xS9Ws7YrtleClX1LzYGHOS4oNLBIgA82BHZ6H0g4D9d0jV8OE3f+N4cUV/wE/OaOleVnz6CZ4MKQKZ4Y0A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:47:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:47:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/powerplay: put dpm frequency setting common code
 in smu_v11_0.c
Date: Thu,  2 Jul 2020 17:47:02 +0800
Message-Id: <20200702094702.8223-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702094702.8223-1-evan.quan@amd.com>
References: <20200702094702.8223-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0051.apcprd04.prod.outlook.com (2603:1096:202:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 09:47:35 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff5c76ef-6e70-4d80-265f-08d81e6cf35b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021954A6145A623BE37BED39E46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlJTCIjA4dyAg+x1CgLAHdPSpjg62Lo+4YvZUhmggSz089ClM7T1w7GSJxYRbvywJqI7sjHjNJFpehNxtUlrQtyeN3So0MqUFbotU7MDIYWky2GXeT1I0nVqNYcJv10eigH+x6CMEppZMRO5JYyG/4MLaTZLo21u//sxXVYprWF2dRHBqaY/J6kK7aXIcewuwjqyhNrRbC4rSlWN5f8rYYzbgfoQpkiYRzfZs0NnMbM/Pdw+CWY2HeQ6l3kBvP/KON2Q3h+W8UF4jTVukitwkSSvQY0rgZJMrAI3zxtGPOc/UbTi8Z65nfEQstO3I4wReqvJXfrjZMYdmVUvHf5+gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(66476007)(66556008)(2906002)(66946007)(1076003)(44832011)(8936002)(4326008)(30864003)(6666004)(478600001)(26005)(186003)(16526019)(8676002)(7696005)(52116002)(5660300002)(83380400001)(6486002)(956004)(36756003)(316002)(86362001)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5d2bBOtcTpvRRgHELANqMSNpbWUXLvTCauqY5OLcPUhEeNcVQZrMjj/KG2snKrv8nf5gya3EkmlVHM9RDsVOMKLKiKqpmfHp4lmBqcbVUCjmXAcRrQxGxRhRHGce7pBCchtfcrPsTAEHNs/VwSONatQPRxT4jKQ0SN2n9W3PJsMNA13f9dXJJ9Sc+EXpYJLkILsdo7oyjW22eeMz2LIcrN9DnvOlrXm77WCCRoFFIg2sMvSAu/32MuWET79OrlprDs+Wsx2GCu1Aao285GqE9uQbz1EZ+FjU8Goyigt1kK5//HdF96mY69pzi1MyVmqYsbqEoDz3wC65R+z41CnORqwVV3/Q8IeEkNvFRfzlYQcM0HFq2Smk2PshbhbuZnkHk8Tx+/U8VAR33xs2K7YGLg2Nchs9XXGNkyVTt9mKAI6fAk4jdiJw7nr0bHaQ+ZYOn2iYxLz3GV7qvADKBZ3hK8JL+6L/8lrrT08234gmkUYrS5DWQQg16ksXX2u9N3ZQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5c76ef-6e70-4d80-265f-08d81e6cf35b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:47:36.5690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfbTP54w4pfpEj2SjBX+gk21mjwTckiKchXuyFjXQy6GIapra8BptkCKf/rLbDXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As designed the common code shared among all smu v11 ASCIs go to
smu_v11_0.c. This helps to maintain clear code layers.

Change-Id: I1f848eba0b6b56f8b5ef6f0888ee6955ba1d2070
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 65 --------------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  6 --
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 14 ++++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 38 +++++----
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 18 ++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 84 +++++++++++++++++++
 6 files changed, 129 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 95685bb9582a..6839faaab611 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -284,71 +284,6 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
-int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_type,
-			      uint16_t level, uint32_t *value)
-{
-	int ret = 0, clk_id = 0;
-	uint32_t param;
-
-	if (!value)
-		return -EINVAL;
-
-	if (!smu_clk_dpm_is_enabled(smu, clk_type))
-		return 0;
-
-	clk_id = smu_clk_get_index(smu, clk_type);
-	if (clk_id < 0)
-		return clk_id;
-
-	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
-
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmFreqByIndex,
-					  param, value);
-	if (ret)
-		return ret;
-
-	/* BIT31:  0 - Fine grained DPM, 1 - Dicrete DPM
-	 * now, we un-support it */
-	*value = *value & 0x7fffffff;
-
-	return ret;
-}
-
-int smu_get_dpm_level_count(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t *value)
-{
-	return smu_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
-}
-
-int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t *min_value, uint32_t *max_value)
-{
-	int ret = 0;
-	uint32_t level_count = 0;
-
-	if (!min_value && !max_value)
-		return -EINVAL;
-
-	if (min_value) {
-		/* by default, level 0 clock value as min value */
-		ret = smu_get_dpm_freq_by_index(smu, clk_type, 0, min_value);
-		if (ret)
-			return ret;
-	}
-
-	if (max_value) {
-		ret = smu_get_dpm_level_count(smu, clk_type, &level_count);
-		if (ret)
-			return ret;
-
-		ret = smu_get_dpm_freq_by_index(smu, clk_type, level_count - 1, max_value);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
 bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type)
 {
 	enum smu_feature_mask feature_id = 0;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ae16cc4c2b2d..66912884f093 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -715,16 +715,10 @@ int smu_switch_power_profile(struct smu_context *smu,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en);
 int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uint32_t *smu_version);
-int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_type,
-			      uint16_t level, uint32_t *value);
-int smu_get_dpm_level_count(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t *value);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
-int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t *min_value, uint32_t *max_value);
 enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 070f1f0f9926..3d746b75396e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -265,4 +265,18 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 int smu_v11_0_set_power_source(struct smu_context *smu,
 			       enum smu_power_src_type power_src);
 
+int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
+				    enum smu_clk_type clk_type,
+				    uint16_t level,
+				    uint32_t *value);
+
+int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
+				  enum smu_clk_type clk_type,
+				  uint32_t *value);
+
+int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
+				  enum smu_clk_type clk_type,
+				  uint32_t *min_value,
+				  uint32_t *max_value);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d88b2f200d94..d96e8334b5e2 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -881,13 +881,13 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		ret = smu_get_dpm_level_count(smu, clk_type, &count);
+		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			return size;
 
 		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
-				ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &value);
+				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
 					return size;
 
@@ -895,10 +895,10 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 						cur_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
 			if (ret)
 				return size;
-			ret = smu_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
 			if (ret)
 				return size;
 
@@ -1058,11 +1058,11 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
 
-		ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
 			return size;
 
-		ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return size;
 
@@ -1110,7 +1110,7 @@ static int navi10_get_clock_by_type_with_latency(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-		ret = smu_get_dpm_level_count(smu, clk_type, &level_count);
+		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &level_count);
 		if (ret)
 			return ret;
 
@@ -1118,7 +1118,7 @@ static int navi10_get_clock_by_type_with_latency(struct smu_context *smu,
 		clocks->num_levels = level_count;
 
 		for (i = 0; i < level_count; i++) {
-			ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &freq);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &freq);
 			if (ret)
 				return ret;
 
@@ -1493,21 +1493,21 @@ static int navi10_get_profiling_clk_mask(struct smu_context *smu,
 			*mclk_mask = 0;
 	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
 		if(sclk_mask) {
-			ret = smu_get_dpm_level_count(smu, SMU_SCLK, &level_count);
+			ret = smu_v11_0_get_dpm_level_count(smu, SMU_SCLK, &level_count);
 			if (ret)
 				return ret;
 			*sclk_mask = level_count - 1;
 		}
 
 		if(mclk_mask) {
-			ret = smu_get_dpm_level_count(smu, SMU_MCLK, &level_count);
+			ret = smu_v11_0_get_dpm_level_count(smu, SMU_MCLK, &level_count);
 			if (ret)
 				return ret;
 			*mclk_mask = level_count - 1;
 		}
 
 		if(soc_mask) {
-			ret = smu_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
+			ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
 			if (ret)
 				return ret;
 			*soc_mask = level_count - 1;
@@ -1831,12 +1831,18 @@ static int navi10_set_peak_performance_level(struct smu_context *smu)
 		sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
 		break;
 	default:
-		ret = smu_get_dpm_level_range(smu, SMU_SCLK, NULL, &sclk_freq);
+		ret = smu_v11_0_get_dpm_level_range(smu,
+						    SMU_SCLK,
+						    NULL,
+						    &sclk_freq);
 		if (ret)
 			return ret;
 	}
 
-	ret = smu_get_dpm_level_range(smu, SMU_UCLK, NULL, &uclk_freq);
+	ret = smu_v11_0_get_dpm_level_range(smu,
+					    SMU_UCLK,
+					    NULL,
+					    &uclk_freq);
 	if (ret)
 		return ret;
 
@@ -2331,15 +2337,15 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	if (smu_version < 0x2A3200)
 		return 0;
 
-	ret = smu_get_dpm_level_count(smu, SMU_UCLK, &uclk_count);
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &uclk_count);
 	if (ret)
 		return ret;
 
-	ret = smu_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)0, &uclk_min);
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)0, &uclk_min);
 	if (ret)
 		return ret;
 
-	ret = smu_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)(uclk_count - 1), &uclk_max);
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)(uclk_count - 1), &uclk_max);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dfe192ce33ab..f2bbe56798d7 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -789,13 +789,13 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
 			amdgpu_gfx_off_ctrl(adev, false);
 
-		ret = smu_get_dpm_level_count(smu, clk_type, &count);
+		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			goto print_clk_out;
 
 		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
-				ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &value);
+				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
 					goto print_clk_out;
 
@@ -803,10 +803,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 						cur_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
 			if (ret)
 				goto print_clk_out;
-			ret = smu_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
 			if (ret)
 				goto print_clk_out;
 
@@ -901,11 +901,11 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
 
-		ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
 			goto forec_level_out;
 
-		ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			goto forec_level_out;
 
@@ -1312,7 +1312,7 @@ static int sienna_cichlid_get_profiling_clk_mask(struct smu_context *smu,
 	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
 		if(sclk_mask) {
 			amdgpu_gfx_off_ctrl(adev, false);
-			ret = smu_get_dpm_level_count(smu, SMU_SCLK, &level_count);
+			ret = smu_v11_0_get_dpm_level_count(smu, SMU_SCLK, &level_count);
 			amdgpu_gfx_off_ctrl(adev, true);
 			if (ret)
 				return ret;
@@ -1320,14 +1320,14 @@ static int sienna_cichlid_get_profiling_clk_mask(struct smu_context *smu,
 		}
 
 		if(mclk_mask) {
-			ret = smu_get_dpm_level_count(smu, SMU_MCLK, &level_count);
+			ret = smu_v11_0_get_dpm_level_count(smu, SMU_MCLK, &level_count);
 			if (ret)
 				return ret;
 			*mclk_mask = level_count - 1;
 		}
 
 		if(soc_mask) {
-			ret = smu_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
+			ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
 			if (ret)
 				return ret;
 			*soc_mask = level_count - 1;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 6c8b4230cbe2..03be59492af1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1905,3 +1905,87 @@ int smu_v11_0_set_power_source(struct smu_context *smu,
 					NULL);
 }
 
+int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
+				    enum smu_clk_type clk_type,
+				    uint16_t level,
+				    uint32_t *value)
+{
+	int ret = 0, clk_id = 0;
+	uint32_t param;
+
+	if (!value)
+		return -EINVAL;
+
+	if (!smu_clk_dpm_is_enabled(smu, clk_type))
+		return 0;
+
+	clk_id = smu_clk_get_index(smu, clk_type);
+	if (clk_id < 0)
+		return clk_id;
+
+	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
+
+	ret = smu_send_smc_msg_with_param(smu,
+					  SMU_MSG_GetDpmFreqByIndex,
+					  param,
+					  value);
+	if (ret)
+		return ret;
+
+	/*
+	 * BIT31:  0 - Fine grained DPM, 1 - Dicrete DPM
+	 * now, we un-support it
+	 */
+	*value = *value & 0x7fffffff;
+
+	return ret;
+}
+
+int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
+				  enum smu_clk_type clk_type,
+				  uint32_t *value)
+{
+	return smu_v11_0_get_dpm_freq_by_index(smu,
+					       clk_type,
+					       0xff,
+					       value);
+}
+
+int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
+				  enum smu_clk_type clk_type,
+				  uint32_t *min_value,
+				  uint32_t *max_value)
+{
+	uint32_t level_count = 0;
+	int ret = 0;
+
+	if (!min_value && !max_value)
+		return -EINVAL;
+
+	if (min_value) {
+		/* by default, level 0 clock value as min value */
+		ret = smu_v11_0_get_dpm_freq_by_index(smu,
+						      clk_type,
+						      0,
+						      min_value);
+		if (ret)
+			return ret;
+	}
+
+	if (max_value) {
+		ret = smu_v11_0_get_dpm_level_count(smu,
+						    clk_type,
+						    &level_count);
+		if (ret)
+			return ret;
+
+		ret = smu_v11_0_get_dpm_freq_by_index(smu,
+						      clk_type,
+						      level_count - 1,
+						      max_value);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
