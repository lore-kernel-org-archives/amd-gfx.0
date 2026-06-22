Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC4FCDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D8410E57E;
	Mon, 22 Jun 2026 08:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XWpDVGU3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2563D10E57E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZQKObxLTVgJxTm2dX9kWKLllZwc+ZdY+7pbWzMtxzhNW3G1YUnp6Pzp/CkQpX90JO5D4lulOuC9KKMK71OrreClTbLXiJ8XLuCp5cYj8iqp/B8OCyW1tGC4Rtk4S27FX4qysl5syuJsqw+5elcywa2H8q/zTbVyFYqAwzlpCow0eFnEv/6ZKQRosLo4ajYgEk4moq9LN66RWx1GXe+kyvmDmWVMhYnZpD82CekGI9m2sikKnPR1kZOgsm19hcdz2Zc3hNeS1LVrqo7NzTYvvDzdXykb0+BpVLyvndJt1om1NqhV31j0zrO5iZlcIU0jSEESgfj+ZCu7tKWwMsJ66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU3oKxPmMpjeRYJ8yghRPeG+8cE68SiZxnxkGoCUx2M=;
 b=OiytpMP2nUFltzVnKxNcl40rvMSE/QUK97K4Xe1EPQDkpgf42CPr4+ykzsPetweC4VjPKxHqCJdvAXRLM6qyVNxyCxDcIOS6nxfjBLxncJ1TgdlJ+ObRFqBSqKj28f3+lZj6jmSBQLtBIsj6Phz29x2Snn0PAPPNk8Qu80+ACV3fYnFj3rGxZHoqNNYBrN5pz4LLYd5vvaJ7DXLk8wthsn5fHnxp5u4QYH3/Dsh5YxD5sIWCWsLtpsKmjg83BYqwc53xmOTDtUb7VapKx1rsqf2CbiZvhmCbmAp8JFM0NgKahNL8kGeLCmXcOnA43UtK20G8DrD6o+Ba/FE5gcC67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU3oKxPmMpjeRYJ8yghRPeG+8cE68SiZxnxkGoCUx2M=;
 b=XWpDVGU3RBhxOSJFHa3ZiQE3X7pLoz4DZE1Xr0T8ybNkDinSkqPC+uNR9HFPtm89zslyXTPFWeLx8tBeigbNd0uiso2IM9L16UzJmdTvQdeezqUVsDSPLZInzaDtl2LS9RZgezzSUexS3Lw+AGcPzAw1kENT53MJCzdWoidI1Gc=
Received: from DS7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:8:54::13) by
 PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 22 Jun 2026 08:46:30 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::96) by DS7PR06CA0046.outlook.office365.com
 (2603:10b6:8:54::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:30 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:28 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 41/48] drm/amd/pm: retire legacy smu ras driver framework
Date: Mon, 22 Jun 2026 16:44:43 +0800
Message-ID: <06ecb3d938729cd2a143b60961e14a0fee8e22f8.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 699c1569-7da5-4aa6-1fa6-08ded03ac14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WJzTcsuCKrvgwXs/r8eBPiy+cZHWdXl5mJx8baROhNaVtQQVFlpTUHJYmcQV/B79f9Fakc05TDNAzoAuYzgBic+1Cpt2tdeEY3E46dRbzGfqDj5TjWOMOLbXvYIcH8WeIrk+TZRCyPle34TGVa+LFTR4zEEXmmLMSrg55I67wiX9RQapfQENtdotMjl1YFF/wcYHe+bLBqgGtslAYz5ekgDQw5vHXHt1WomjZL2/YfMZjgni6bsVg27dj8Biq8wAVp1gtjSpTCrh+rydZC1+gameRUP9/3craZCy7qJf67jIZOsMokoyrqhOuwgePzg8NpK+szmSDU4ZC51T0vk0ZCvzW47ADwWdAgQpgc9wqukPC9oEbj5WBffKwGnTSzTqPq7431sdGMSdG/LBm3vlCE+wTtXYjr3dN4lnAEfKiMe7SQh4vUDtbH+hm0h37C8EV9S5UZHZB0UxKOmy6PbUfZ2MqRqQB7HYwefNIenCH3v+Tdg1dXJPSG6IQl0mP6i4eqTVhzUo9559jP4jgIEIQ7xX/H1NUrSol3BDQFOGnTiaFMfVtcHH/SnHWtWOSEUVI3Yneq9ktg7DpJDYuIMpRkgEuE9XXWKZaPbVkzyO7f+Y84iNaQjdxpwC2hM6lLCXrEZP03PeLNy6Agd/yfTvkmCGn68QEDdA7nXU8U8AyA5AHOktkaM0tPGba87Vyy5bHdnRpaSMce0bmzrhn7bGzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l3stR17fbCLezzwTc7FlW4/Dy+6TDvV2aCUOkDLvLSe4y7EKJ+LR4kuNmN076l0Uj5ahQ8c4N/VAnqTc6p/WT7AoFvcLU/SJ/gKUiKx5JTHXr+pRq1eSDOaXj5tznYGINAnFzKS83g3FdhHeT8gFFwTokRiHlGehaj24mKa2E/p2LEDmW0MwuSX1oRTx0Z+E0zJB9PjCgslg0uRbCoj0X1WXxidm3nAISJTsRYwyJloeQ1HWyVotr5lxaDTMOy/gnlljRjoItJxNSxsG/Ad9b451fb4Xq8fPU+rt05b1NU+4JmLazpXkMstLvcRMDm9tIz3uD3Nm00yfbacdf1UadYLjFr0EXhnMrRLTUnVAZZM01aD4Q0NW1mn1TdSJG/07b3jjwmPzmv5aHLnNWaBtnr9CgWLnvxFWasDMOMqE/BaSdrYCRwB2Tk6Ddp3dBP5g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:30.1995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699c1569-7da5-4aa6-1fa6-08ded03ac14c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
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

Remove the legacy smu ras driver framework

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 -
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 -------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 ----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 -------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 -------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 -
 7 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 2608a248dbc7..dfbed18268af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -598,7 +598,6 @@ struct amdgpu_ras {
 
 	/* Disable/Enable uniras switch */
 	bool uniras_enabled;
-	const struct ras_smu_drv *ras_smu_drv;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f76ba6753551..c09c60ad3f38 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2110,10 +2110,3 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 
 	return ret;
 }
-
-const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev)
-{
-	void *pp_handle = adev->powerplay.pp_handle;
-
-	return smu_get_ras_smu_driver(pp_handle);
-}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index aa3f427819a0..c7ea29385682 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -612,6 +612,5 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
-const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d809487205a4..9908f3d78b93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2818,17 +2818,6 @@ const struct amdgpu_ip_block_version smu_v15_0_ip_block = {
 	.funcs = &smu_ip_funcs,
 };
 
-const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle)
-{
-	struct smu_context *smu = (struct smu_context *)handle;
-	const struct ras_smu_drv *tmp = NULL;
-	int ret;
-
-	ret = smu_get_ras_smu_drv(smu, &tmp);
-
-	return ret ? NULL : tmp;
-}
-
 static int smu_load_microcode(void *handle)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d76e0b005308..efa0b8ba07f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1647,13 +1647,6 @@ struct pptable_funcs {
 	 */
 	int (*ras_send_msg)(struct smu_context *smu,
 			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
-
-
-	/**
-	 * @get_ras_smu_drv: Get RAS smu driver interface
-	 * Return: ras_smu_drv *
-	 */
-	int (*get_ras_smu_drv)(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv);
 };
 
 typedef enum {
@@ -1995,7 +1988,6 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
-const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			    uint32_t param, uint32_t *readarg);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 966b2415d983..7c5e04a1cc94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3273,26 +3273,6 @@ static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
 			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
 }
 
-static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv)
-{
-	if (!ras_smu_drv)
-		return -EINVAL;
-
-	if (amdgpu_sriov_vf(smu->adev))
-		return -EOPNOTSUPP;
-
-	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
-	case IP_VERSION(13, 0, 12):
-		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
-		break;
-	default:
-		*ras_smu_drv = NULL;
-		break;
-	}
-
-	return 0;
-}
-
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.init_allowed_features = smu_v13_0_6_init_allowed_features,
@@ -3351,7 +3331,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.post_init = smu_v13_0_6_post_init,
 	.ras_send_msg = smu_v13_0_6_ras_send_msg,
-	.get_ras_smu_drv = smu_v13_0_6_get_ras_smu_drv,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 24848da90234..45e3758e9ed8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -98,7 +98,6 @@
 #define smu_is_asic_wbrf_supported(smu)			smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
 #define smu_enable_uclk_shadow(smu, enable)		smu_ppt_funcs(enable_uclk_shadow, 0, smu, enable)
 #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
-#define smu_get_ras_smu_drv(smu, ras_smu_drv)			smu_ppt_funcs(get_ras_smu_drv, -EOPNOTSUPP, smu, ras_smu_drv)
 
 #endif
 #endif
-- 
2.34.1

