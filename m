Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74DCC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 03:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E9E206E3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 03:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kbAxVNlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E9E206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC9289A8B;
	Wed, 11 Nov 2020 03:04:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BD389D6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 03:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKd9ZnL8NSxiav0SwHIIuupCJQU1wo5mRqZA3RImt04nito6ncgX5SZuwRNm296SO+tp5I6JW+z7nxIXinGfLmBPvKtgk2wMoTlKsJjNor1W/Q2LITVOUYspO1IcYd37KZu60z20Q6uCq0B2EKrasccraPibOTvxZHiAgin1u2bKjCopZ3TRwmVNac/3FOivHc+icXw90N5VrKHf1wKONtPEwXVQaD2YMzNlw5IOI3+eqVrqARSY7P975u6xF2347dfZgr6JrOwIcxFizMmKrsv9tnfoOoL2ScpFzlpxAFuH2EQzxRXteAej2mMtOOy93Ub9wqdUKuG3pNA9tyT5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eAcL/CRZe8rF40B0umYxm4VWccW0jzABTtwt58HyKs=;
 b=VmYtosn3TTxBo8TOEwITarqUv8zb2PUGfJNVtpCozd38t7uHcD8HPhkd5TsdzP6Sea+Lh05G+KX4DnP93WZO+cQuBgPwmDK9Lyapvt8r+KlCVzb5zl3XiAsFXEavG6h3pl2b7RvL3YKUEqngQu7mnd1UIKCJu8XSOf4gVwIWgkRRWHKnWUBWP9I32oJV6YPsag+qEm42neRdei/0Qs0s4RoHyu99MbLlVRmn5iJ56RAR5FzeANany7KARKv7gExTcQCJa6jP8Q68OSsVj+ntSfu6LL1XJnY4M+Xe5kLyg5jq83mjsmkt81rhfg9UybYREHYybmxIG8eAQwW2iwHgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eAcL/CRZe8rF40B0umYxm4VWccW0jzABTtwt58HyKs=;
 b=kbAxVNlffR/fsG6ffAU2ZMZ+xF53aE7a+4B5vgBNRr00ZXPsJweI/XTCTZ1Yh9HW24Jk8Qc3KuPMXW2VRZcwvANsFDAi6sWsluKk8TcjiQJnE5ajfSTUdfoHzG8aDIfbSEw73lvqLpIO/hxkr/HFy82FmX6ChnMIrEuKPfvfhaI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 03:04:41 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:04:41 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: add the interface to dump smu metrics table
 for vangogh
Date: Wed, 11 Nov 2020 11:04:17 +0800
Message-Id: <20201111030418.27296-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR04CA0056.apcprd04.prod.outlook.com (2603:1096:202:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 03:04:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82629933-56a9-42d9-77c6-08d885ee8853
X-MS-TrafficTypeDiagnostic: CY4PR12MB1382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB138207DB4A0FDA46C0ADDE31F1E80@CY4PR12MB1382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJpnorHFh1bf3hU8I8z6XSlvrEITnVa4PLyFu0ccCQv/eoRjiS3D08H5JmyPm2MztCc67F06dmNvr2b3vw5LkAGXTY/zCELQVZwWqymDGpkOFo6K9C+LC0QDxUQUh/se73XmXLEl8+zvRHUUSM2McYrMvbuadT6z6DkRmnPFGiXQoUmOJVdpYZejg0Jm6c6EwU7JZW3KayOEoj0mkNWJX/Bp9+LRdnJecxZVW3f1w1GBxRoZai6RGHmyQRZ4DTFFc+K43kFyyrEqp30Ueq2DjM6nJMI+DbjohRlCdbRSS9N4XsmLqJ3iYMJltLSiZ3XX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(4326008)(16526019)(66556008)(2906002)(6486002)(66476007)(36756003)(186003)(6916009)(8936002)(8676002)(478600001)(86362001)(52116002)(5660300002)(7696005)(316002)(26005)(66946007)(83380400001)(1076003)(6666004)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8Sf+L5JjcQvfLpY627nwOh7I9dgYJ6vqg1BAp/FPPH/STDP5LRM8JdkH9g8rPesK1AK70vla2Q02RunvLFigVZBKLLofp4RHURync5HDeXVWKvlfYuwW2YC6SsBr0T9a63HpUeK6T+qMGtldwvehBsPExn6zTbs+pu7bWGE29OD3nDRIKfexgBK3FhAVxO1docQqBzrXLvSWyZLE/ldKwET/+Y2+UMHTMyJAY9QMyvsB4HnbA+H9Kya65iH24qcQ7L5TOwZsVgRXFkCnSzJ38bbSP6bGZtl9QpB3lUpuyYaxGARBoI0zA3AzkNfi/srp89s0AaaLPDO6/uIBepuSJLWu7Nagjq8svQc8ukcj6fn2oUV2j/SxzfvJWVTQlX5rbQvcwi1Li0naVPHftkTGH+hWC3VtdEJBKT+Lh4V/NFGnZNYDFgJX0Sx6zVEatVNvauuGLAozciMJOgOl8maoOO2Nk4J3FOQXcenhREJIocJnRG0EYuSVS4brDMM3MHTwnKgKpgAjVKbvf4ZngcpECb6Cb2j5pbeY70U9l/ksmOaXqF5Tx+w6FJ/yyWP3LPWVfidluzqa5ibvLo7jG1sr8Xr3SRLEAEMDTSkn0WA5/88qyERWUbFZz5Pqq1UOoKMT6yZUXVrlbK8MubMzNf3usA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82629933-56a9-42d9-77c6-08d885ee8853
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 03:04:41.1726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLMQsryS04pRajEfgk0d29BpfCrI3L//I/5ARzf7U1l8WWdM0zllqd84maAsdRHJz6uaZQ8CfEGlpnaqPXncpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1382
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
Cc: alexander.deucher@amd.com, xinmei.huang@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add the interface to dump smu metrics table for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 52 +++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index dc06459af91c..5ad693312187 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -276,6 +276,8 @@ int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
 void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics);
 
+void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics);
+
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6b7d1335b46d..b880c72c322c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1999,6 +1999,18 @@ void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 }
 
+void smu_v11_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
+{
+	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
+
+	gpu_metrics->common_header.structure_size =
+				sizeof(struct gpu_metrics_v2_0);
+	gpu_metrics->common_header.format_revision = 2;
+	gpu_metrics->common_header.content_revision = 0;
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+}
+
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 83a1b0a04eb1..cbcbcd8514f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -584,6 +584,57 @@ static int vangogh_set_watermarks_table(struct smu_context *smu,
 	return 0;
 }
 
+static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
+				      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_0 *gpu_metrics =
+		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_v11_0_init_gpu_metrics_v2_0(gpu_metrics);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.CoreTemperature[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->temperature_l3[0] = metrics.L3Temperature[0];
+	gpu_metrics->temperature_l3[1] = metrics.L3Temperature[1];
+
+	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
+	gpu_metrics->average_mm_activity = metrics.UvdActivity;
+
+	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
+	gpu_metrics->average_cpu_power = metrics.Power[0];
+	gpu_metrics->average_soc_power = metrics.Power[1];
+	memcpy(&gpu_metrics->average_core_power[0],
+		&metrics.CorePower[0],
+		sizeof(uint16_t) * 8);
+
+	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.CoreFrequency[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
+	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_0);
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -607,6 +658,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gpu_metrics = vangogh_get_gpu_metrics,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
