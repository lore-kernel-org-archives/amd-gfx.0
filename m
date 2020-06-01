Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB0C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282F5206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ShE+bQLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282F5206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807FD6E187;
	Mon,  1 Jun 2020 07:30:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41956E171
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0s6GBBPJxNIoA45wsQugvzJgbT7CMMyg6A3t+x28GGg+qVEZMxaGMHW/QtMvOAaqc++hk3ldTrTXzzbDs3JQloY8BUTSwXDY0pVMOPDy7rpKMQwf+hwP3vOYI7vdyA1prrGugd3qFHLc0BP9MdIi/YEKplhJzWr3/WOTQO8kJQTcruNa0ps56WDqCTgwdmwuIGGOInKqJnmbkxk42SR2R3mDHfuYxD4PZlj/nvv4Z1mq0eFgRggRlFCWAtons5NdYNf8IEzepn92dLBOF4qT6WI171vkGJLYKpDirs6PtuhrzC5TOk+sGawllrNXkf68zp2IFMGKbkI6ttTrmZ75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtPDLc8vg0tHLdrkaahpREPJdsW8Vo7VDX/goVUvFVU=;
 b=dj5UuWTZt70pREYlyCmnDmeskTDoKzdBlIjD2KmBMLQXoN3IwElUIaBYBu+W6SXWKGPDG6L7tU9qLB7ofhk55tz7DED3UJQGe/afidPVnH1dQyFHLw1eA73bDQnOoFGGd4QN/a51S2JiuL0fn0g6WOww13+3DdHKZ2pNvXn27T+PMd0yXyhMxMPpYp9LeexRQ1rOatvJr4KIMWwS/bJmPk/vGt7EI/SYACSznimVUySYMkJW5xl9GU0ec1nZmjhDD2PdcmTHZsTcuVT94xmY9WjTtrZSpveOPoaQ/qzb99FGdKw571fF+lYrU1i/8XQWCWP7JK11qeC9RgrAsY/X+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtPDLc8vg0tHLdrkaahpREPJdsW8Vo7VDX/goVUvFVU=;
 b=ShE+bQLSNBPEG4ToXWZgjLS5/0b39GuXMQVoHfaEj2srgDAHr2SgO+MKIuEOBwx0t3wxlZ2Ra2eOVkcwQSKiqZtUOauPW2vGMiTxrvXklL2vOYfES/c/Wdh68LMlp0GJ22if84pdLiyoJ5skFMCwgVxuRwXVvUs9KpiaSZ4JHpw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:30:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:30:41 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amd/powerplay: some cosmetic fixes
Date: Mon,  1 Jun 2020 15:29:56 +0800
Message-Id: <20200601073003.13044-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:30:40 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18510b48-38eb-4672-310d-08d805fdb051
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38038C356FE8DCBD2E0D7954E48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTAC2EWFy161VVJk6vt6eIO8ko1F4BLM5hVSVKa44JTIYXVRiGUnINjIRhcV46073ucmBagUBPCH4mV3+nCf/LygDwRrbXXxgXrOUwG9oovySc6rHY/NloqFnMcI3+ngH7siXdJGth96JawPkiUOS1yy0EAcfJuX8TyiuONcD3kvYltEJP3+H9lAoDTO6mmQmqmg1qVAiyLVGXq7iqwa3SUGzTLejA6RELt157nxSVHFn1SegvgovxXlgupxvJGyAp9LwrkqVnoAXdyahkb+mhMHJ83EkEMwl64zHHK8lbYfpAoddQDp4k293kjEWFzjPKTWhQlHtRCGEfP3MldDqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(6666004)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ygL2/pQZ3psrIfg32CyUiURbzAUE1RYG9Jp/q8dYxWHvZL954kpBmopm9esIM5013yhj1TZl4GN7NWrroAbI1cLLxoAoeMx2Vi5gWmqgjOV8BATnFv7o2OTfAh/PzNHzAkFr6TwlHiroTjcOsPZYqoo8q884TrW6C0Sp3Gw1jtyLj11fs4SxPiD0nmLTlnyPNO+fNvbtBMT0pM7QAH5So8RPEItaz93KhwB6IBnkdTIkETzprufnch2gwQPw6ce7VDbY4xWW99+Fj5z9zczYTX9WeunCZy9gLAGYXq/vA+uFjdNAlu1uVrKPjUr9MRAYMuK36h0aQpGx/aaztV0tq/+QOAx9oQJqY/6urF5QbFMYxwRZpysJx53hxvorNfyFOhlNSBhg7n7wVRWO4knJqsRyNd4lrMDUvc2vkYWHsJsGBC+Qv4NWD5hwICfKWZPklNZc1aCxFGCVHdQAntvnab4tKbsTILoiGY3+Vt90Cjk1gJXJm2SD7HwosvqKlWrB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18510b48-38eb-4672-310d-08d805fdb051
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:30:41.8219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJCimyByCT6PrDI70FvsETsMYb9VqxZHQbkhl1XPbgW22tmhjz07vn7WwJ3s33oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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

To make code more clean and readable by moving ASIC
specific code to its own file, more code sharing and
dropping unused code.

Change-Id: I6b299f9e98c7678b48281cbed9beb17b644bb4cc
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 213 ++++++++-------------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  19 ++
 2 files changed, 102 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4998ea942760..b4f108cb52fa 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -817,22 +817,10 @@ int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
 	return 0;
 }
 
-static int smu_initialize_pptable(struct smu_context *smu)
-{
-	/* TODO */
-	return 0;
-}
-
 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
 	int ret;
 
-	ret = smu_initialize_pptable(smu);
-	if (ret) {
-		pr_err("Failed to init smu_initialize_pptable!\n");
-		return ret;
-	}
-
 	/**
 	 * Create smu_table structure, and init smc tables such as
 	 * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
@@ -860,6 +848,12 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
 {
 	int ret;
 
+	ret = smu_fini_power(smu);
+	if (ret) {
+		pr_err("Failed to init smu_fini_power!\n");
+		return ret;
+	}
+
 	ret = smu_fini_smc_tables(smu);
 	if (ret) {
 		pr_err("Failed to smu_fini_smc_tables!\n");
@@ -950,12 +944,6 @@ static int smu_sw_fini(void *handle)
 		return ret;
 	}
 
-	ret = smu_fini_power(smu);
-	if (ret) {
-		pr_err("Failed to init smu_fini_power!\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -1125,36 +1113,22 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	if (adev->asic_type == CHIP_NAVI10) {
-		if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
-						      adev->pdev->revision == 0xc3 ||
-						      adev->pdev->revision == 0xca ||
-						      adev->pdev->revision == 0xcb)) ||
-		    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
-						      adev->pdev->revision == 0xf4 ||
-						      adev->pdev->revision == 0xf5 ||
-						      adev->pdev->revision == 0xf6))) {
-			ret = smu_disable_umc_cdr_12gbps_workaround(smu);
-			if (ret) {
-				pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
-				return ret;
-			}
-		}
+	ret = smu_disable_umc_cdr_12gbps_workaround(smu);
+	if (ret) {
+		pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
+		return ret;
 	}
 
-	if (smu->ppt_funcs->set_power_source) {
-		/*
-		 * For Navi1X, manually switch it to AC mode as PMFW
-		 * may boot it with DC mode.
-		 */
-		if (adev->pm.ac_power)
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
-		else
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
-		if (ret) {
-			pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
-			return ret;
-		}
+	/*
+	 * For Navi1X, manually switch it to AC mode as PMFW
+	 * may boot it with DC mode.
+	 */
+	ret = smu_set_power_source(smu,
+				   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
+				   SMU_POWER_SOURCE_DC);
+	if (ret) {
+		pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+		return ret;
 	}
 
 	ret = smu_notify_display_change(smu);
@@ -1362,9 +1336,65 @@ static int smu_hw_init(void *handle)
 	return ret;
 }
 
-static int smu_stop_dpms(struct smu_context *smu)
+static int smu_disable_dpms(struct smu_context *smu)
 {
-	return smu_system_features_control(smu, false);
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	bool use_baco = !smu->is_apu &&
+		((adev->in_gpu_reset &&
+		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
+		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
+
+	/*
+	 * For custom pptable uploading, skip the DPM features
+	 * disable process on Navi1x ASICs.
+	 *   - As the gfx related features are under control of
+	 *     RLC on those ASICs. RLC reinitialization will be
+	 *     needed to reenable them. That will cost much more
+	 *     efforts.
+	 *
+	 *   - SMU firmware can handle the DPM reenablement
+	 *     properly.
+	 */
+	if (smu->uploading_custom_pp_table &&
+	    (adev->asic_type >= CHIP_NAVI10) &&
+	    (adev->asic_type <= CHIP_NAVI12))
+		return 0;
+
+	/*
+	 * Disable all enabled SMU features.
+	 * This should be handled in SMU FW, as a backup
+	 * driver can issue call to SMU FW until sequence
+	 * in SMU FW is operational.
+	 */
+	ret = smu_system_features_control(smu, false);
+	if (ret) {
+		pr_err("Failed to disable smu features.\n");
+		return ret;
+	}
+
+	/*
+	 * For baco, need to leave BACO feature enabled
+	 *
+	 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
+	 * is supported.
+	 *
+	 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
+	 * always return false as the 'smu_system_features_control(smu, false)'
+	 * was just issued above which disabled all SMU features.
+	 *
+	 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
+	 * now for the checking.
+	 */
+	if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
+		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
+		if (ret) {
+			pr_warn("set BACO feature enabled failed, return %d\n", ret);
+			return ret;
+		}
+	}
+
+	return ret;
 }
 
 static int smu_hw_fini(void *handle)
@@ -1396,25 +1426,10 @@ static int smu_hw_fini(void *handle)
 		return ret;
 	}
 
-	/*
-	 * For custom pptable uploading, skip the DPM features
-	 * disable process on Navi1x ASICs.
-	 *   - As the gfx related features are under control of
-	 *     RLC on those ASICs. RLC reinitialization will be
-	 *     needed to reenable them. That will cost much more
-	 *     efforts.
-	 *
-	 *   - SMU firmware can handle the DPM reenablement
-	 *     properly.
-	 */
-	if (!smu->uploading_custom_pp_table ||
-			!((adev->asic_type >= CHIP_NAVI10) &&
-				(adev->asic_type <= CHIP_NAVI12))) {
-		ret = smu_stop_dpms(smu);
-		if (ret) {
-			pr_warn("Fail to stop Dpms!\n");
-			return ret;
-		}
+	ret = smu_disable_dpms(smu);
+	if (ret) {
+		pr_warn("Fail to stop Dpms!\n");
+		return ret;
 	}
 
 	kfree(table_context->driver_pptable);
@@ -1453,68 +1468,6 @@ int smu_reset(struct smu_context *smu)
 	return ret;
 }
 
-static int smu_disable_dpm(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
-	int ret = 0;
-	bool use_baco = !smu->is_apu &&
-		((adev->in_gpu_reset &&
-		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
-
-	ret = smu_get_smc_version(smu, NULL, &smu_version);
-	if (ret) {
-		pr_err("Failed to get smu version.\n");
-		return ret;
-	}
-
-	/*
-	 * Disable all enabled SMU features.
-	 * This should be handled in SMU FW, as a backup
-	 * driver can issue call to SMU FW until sequence
-	 * in SMU FW is operational.
-	 */
-	ret = smu_system_features_control(smu, false);
-	if (ret) {
-		pr_err("Failed to disable smu features.\n");
-		return ret;
-	}
-
-	/*
-	 * Arcturus does not have BACO bit in disable feature mask.
-	 * Enablement of BACO bit on Arcturus should be skipped.
-	 */
-	if (adev->asic_type == CHIP_ARCTURUS) {
-		if (use_baco && (smu_version > 0x360e00))
-			return 0;
-	}
-
-	/* For baco, need to leave BACO feature enabled */
-	if (use_baco) {
-		/*
-		 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
-		 * is supported.
-		 *
-		 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
-		 * always return false as the 'smu_system_features_control(smu, false)'
-		 * was just issued above which disabled all SMU features.
-		 *
-		 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
-		 * now for the checking.
-		 */
-		if (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0) {
-			ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-			if (ret) {
-				pr_warn("set BACO feature enabled failed, return %d\n", ret);
-				return ret;
-			}
-		}
-	}
-
-	return ret;
-}
-
 static int smu_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1537,7 +1490,7 @@ static int smu_suspend(void *handle)
 		return ret;
 	}
 
-	ret = smu_disable_dpm(smu);
+	ret = smu_disable_dpms(smu);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 68142f6798c6..652728f18271 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2209,12 +2209,31 @@ static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
 	return result;
 }
 
+static inline bool navi10_need_umc_cdr_12gbps_workaround(struct amdgpu_device *adev)
+{
+	if (adev->asic_type != CHIP_NAVI10)
+		return false;
+
+	if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
+	     adev->pdev->revision == 0xc3 || adev->pdev->revision == 0xca ||
+	     adev->pdev->revision == 0xcb)) ||
+	    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
+	     adev->pdev->revision == 0xf4 || adev->pdev->revision == 0xf5 ||
+	     adev->pdev->revision == 0xf6)))
+		return true;
+	else
+		return false;
+}
+
 static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 {
 	uint32_t uclk_count, uclk_min, uclk_max;
 	uint32_t smu_version;
 	int ret = 0;
 
+	if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
+		return 0;
+
 	ret = smu_get_smc_version(smu, NULL, &smu_version);
 	if (ret)
 		return ret;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
