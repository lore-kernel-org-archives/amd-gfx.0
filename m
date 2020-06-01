Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6783BC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E43206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UG3b7+xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E43206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CAE6E14B;
	Mon,  1 Jun 2020 07:30:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7A26E14B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf9xFdq/cvM8LMW47diJRlQtUQdaqwGdTba9S1PTALzpgPjU5dt3+RqpNP0WP0SFIN3a82rnXhMUO2kGV39WYgtEthwdqZY7fzra4IS9AtmaBdITOTmV3sLmWwSggGSWfI5t8t9xt5Ki0+1se+jGGLDHmxqNzxYT9OzWYxnSjH+zLu6IDGzrK2k3xJSxN3nxbt4xjcwQt1/DST9iyjhh9d9JLgtEimSHCvkdWKek88+NsPYOXUYe5sOAOIJxoP6j0w2nUE8GHxhSMRUWu3DBTgJa7v5wMZeUoADGKR4skrYOmRcgvAroLKzAa8QsNFS3frGeoujF5ahkBa92XCPCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/hSPg8Ef+o0o+vnsPqF+FvmITIdhuHbN4jeU/lon8M=;
 b=a53Oh0Lnyp845zFGyKtaCQTVeylgczT0bS1kJhZOZYY8HHnyPSU3cCjV7vkpOwo1tvr/oHqYu3CCk/NcoUSzRNxZkwCAgmQkkyHLFGYu+EiSWKaB7JSjNJEezKCYIFZrQwEaTGrrcWSJeRAxG1qdZBD1kEQrEJLJedV+W0GCrPH7mnFeCvMePrizNNIzgrCv/VNa1AVoom8SP1JmVXnrClaZb/oPh2SZBrzB4bTRKEguxogw9ZOAIKudAQxJMvylrWcJS0Xtknx+l2VXL8x4xd+qr2dHpdYI2cPNb7l8MVor90QgJinE32R86uUSMn8kBv1ZRTSHQzPuY/CuXWJPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/hSPg8Ef+o0o+vnsPqF+FvmITIdhuHbN4jeU/lon8M=;
 b=UG3b7+xSXYpHdplQe/C9DWlL3c3edrHdhHdvwok2gnPVtjZkI/EjaIz0NEOp+BElLEBB2jabqIuSyaPp0T83YCorEpxoDsMMD+SQwKkMX3rYU999a16Mu7atDKS2BTQQIIJoAmjIFkUO6Nzri4uEimYwQSq00hu1BWiwRY71/OA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:30:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:30:38 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amd/powerplay: drop unnecessary CHIP_ARCTURUS guard
Date: Mon,  1 Jun 2020 15:29:55 +0800
Message-Id: <20200601073003.13044-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:30:36 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 233f7a14-7bd7-43f6-cf0a-08d805fdae13
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803B90271F6F844647A4A3CE48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbIwGU4mxbyapQzve1UV5N2VNhBz5NxB2QyC68o2jkyBG92wKvV1h6efPyug2+Y00ANL7HQd2EU2ppUSzelPmceXSStNCeMSBXpdX29ykdsaAl7uQuLqOTv2OOogvFDuPQH5ZCQYmq9G0eZv2sSmvALe6F9V8cUsmeVFCsHQWpt7kF+YS8b7j7GKjmdpoEPeFGSEM4xwVKIRpf1QFfsj2qDWaTUZ0301NqpLt+Cbf5wbKCj88MJH1UpW35q53JHbozTNkX/rVNkxbC4RMmTZXrYP4cd0sYwuQI9CLLmpT/NIWqhZHw2ouhQvn9q4tM8td03yUF69IDs0j5hyS5BXMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(6666004)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oKtasRRdxBAxfV7WXTv//uUDr02O4z0CGCU7AGV2FRVs1phVMdUsnP3k6aU6RgPYmDz+XUXsBO4uSRVvwiobhUBpGXY4GV36yFy/ZcUChwB1HVtEsJnXNIdUkHOkYgjACbpGnEbUlQ2pfd6zNr4RHzM+cmKujtv1pbOHxIr/iKZn92zEGQ1Gh0PBcXVQIb6n8TZ7Q1bOUcCJ0pbZxSIvHqiha5pxRqbHD9Q5w2npMZ9ikwOGDtomvBYNGUyaVC7bPr8f3Na+J4EwRJT3GMi0g84jwwkip55+ZPPnbZanPEgQiKJfAzi4mOmudcJi4cZpNIYrzDE1a3NqNq2D1A9F5mGitdkWvNz12EMHuUZMCAhxc0aNaIhPoig0R/qmNPuUO/Rdk3bdAuAQ9T6/P2ETlENOjkbtBevdMKOwczeINAwgD/U/tENFHBbGZsQZIbJxzl1isZx/wSygjtDtmvIzZaw9VjnJtHxuBtVnk7sZcszefcBhrTl1RISmHCChIFQ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233f7a14-7bd7-43f6-cf0a-08d805fdae13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:30:38.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yWJoFqzUHnuFm7VNXRkqYrgaGF+AnITBOWfy1oGHpqK1miU0JTosZKE2Psc+OQ4
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

These APIs internally guard they will not break ARCTURUS.

Change-Id: Ib6775c1c8c5211ea45db6c3fb604a8279411ab37
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 38 +++++++++-----------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c |  8 ++---
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5294aa7cdde1..4998ea942760 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1049,11 +1049,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		return 0;
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS) {
-		ret = smu_init_display_count(smu, 0);
-		if (ret)
-			return ret;
-	}
+	ret = smu_init_display_count(smu, 0);
+	if (ret)
+		return ret;
 
 	if (initialize) {
 		/* get boot_values from vbios to set revision, gfxclk, and etc. */
@@ -1159,19 +1157,17 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		}
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS) {
-		ret = smu_notify_display_change(smu);
-		if (ret)
-			return ret;
+	ret = smu_notify_display_change(smu);
+	if (ret)
+		return ret;
 
-		/*
-		 * Set min deep sleep dce fclk with bootup value from vbios via
-		 * SetMinDeepSleepDcefclk MSG.
-		 */
-		ret = smu_set_min_dcef_deep_sleep(smu);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Set min deep sleep dce fclk with bootup value from vbios via
+	 * SetMinDeepSleepDcefclk MSG.
+	 */
+	ret = smu_set_min_dcef_deep_sleep(smu);
+	if (ret)
+		return ret;
 
 	/*
 	 * Set initialized values (get from vbios) to dpm tables context such as
@@ -1188,11 +1184,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 			return ret;
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS) {
-		ret = smu_override_pcie_parameters(smu);
-		if (ret)
-			return ret;
-	}
+	ret = smu_override_pcie_parameters(smu);
+	if (ret)
+		return ret;
 
 	ret = smu_set_default_od_settings(smu, initialize);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 302b7e9cb5ba..e856ad36ab01 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2429,16 +2429,16 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
-	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_min_dcef_deep_sleep = NULL,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
 	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
-	.init_display_count = smu_v11_0_init_display_count,
+	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
-	.notify_display_change = smu_v11_0_notify_display_change,
+	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
@@ -2462,7 +2462,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
-	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
+	.override_pcie_parameters = NULL,
 	.get_pptable_power_limit = arcturus_get_pptable_power_limit,
 	.set_df_cstate = arcturus_set_df_cstate,
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
