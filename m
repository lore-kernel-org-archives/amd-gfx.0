Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D0CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B590F2083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CDeeuiqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B590F2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD966E997;
	Fri, 31 Jul 2020 02:44:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4616E997
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8M7uVBX6uBZe3YpYW1CcOKizXL1Pi9fro2eh5pZAk/GQE0oIe72uh1hP8x4AF5lfNg3/C2UNH9I6lF5ICE5iwvtI7h/UXGFw/OrryUjFj3MqIF9moJDNif35qCGY8YvYVVwubZ9ntKWCaCZASRefBGH7NUqFTGS06o0qOhlqbPeuhxYjfFa+gHQ4csS0mNdP3yb3rJ32puvanTE4YEhLNPAXuufEo927dOU0qKlW3yKyvY4rfbdIXSSlXqcaLppKLCVEAAwNb+UDjJoc0Yo5mCFrj5hFCv5jKjLmJpQGZzjxqeLAZ47Tvp66r/cC/HDuLKSL5oHeq7uzhpCFqj4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPPLLIZ244wHi2IG8H/UU5NA0JAuNu3S1IoGh/lyB/g=;
 b=EgAXBEjNPElVQT6iG8zoeKhhECkNmEjUuu1u9lMbhdARRr8K4vlnIZcUknmCSBTNHO753I1OXnwV9XvV0BnpgjChzfY9/skRd+To9m4e7ZpYBcdelBjzvyBMnjI212Sg+5yHptexOLVskCXJ1RtMix7jkfNGi1LESl/HKtP1XTZYyGymfCKWqt2usqWMVNOc8kIv9YDwrsEx1wxIaDcrVfzAH2yG7flkpaErMtb5szOo0kf/7zvW+7Rf4Xuo3OrtnDfjPL7aeN9l2XUXar/eRA7vwYm7+b5UhEwV1rg1m5XQ0DSr0nRIqm78tY+8ODGnGujZf5+GUjDWL9whfrl/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPPLLIZ244wHi2IG8H/UU5NA0JAuNu3S1IoGh/lyB/g=;
 b=CDeeuiqgGYMqL98jjkQrAqeOTaLV3uVp6ANO7EqSz3QY80T6XBhicfhnwjtJAe7cRLxkbRy0cvn1b91dhjsC/sYmsJPexDU8R0vPpeFC2uiB/FvIKdQQs6mGNZT6ep/SHOvibrLpwLLS7RA1UB7KYmMXA57eEAlC6yT3Vx75WDs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/17] drm/amd/powerplay: add Sienna Cichlid support for gpu
 metrics export
Date: Fri, 31 Jul 2020 10:43:06 +0800
Message-Id: <20200731024316.28324-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:05 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5484cbd7-d7ee-488d-5759-08d834fb9874
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435E18501DF3CBEAEFA4F52E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpgLIHx0SyTWRxbW0HI1MnwN3w+zPl6S9fohlkss+XFgmGb5XxcEB9VRq9MD3IodUXl40OF5qydGiNS3TGyL1iLKk0HMGDi7xvej25wbpjRex/HFnwVTbIA6ykqr4x5GujWnR9mn3mTF3H7aMgCs7AudSEL+0a7eWkuRq81mUhMARbiqV0Tp6hNx4t74s3hHPVEP2SPs4Oz+FAlwVkBg+J9YLD+CEzA+1mkuNKHByclMq6X7JR5fnZ/y8rGu3c0I945CgueA5enB9rkxioxZJW6CnB409XEzuAJjEMGJdRbIk1A7EIRUXO0+TSxhLHPS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jszxgZyzdG17n6OMxvmc5kjX1m5Mf4RiHmQxlrffCWi0FozwK5PxsetJOFnNTH0/7p1wFwU/1YMlDdHF+5VrS5mvasgUjqEteKAqHjQjQugHWgXFTv+EPSPYAufnV7Hz3Ef8iEUq48hhu+9FuUSaQpV7SqCUjDQ/rLEDx6SYWRk9VYk/fSn5N5m78BscNW2MrKLAkgu73ZVlVJ18wqqivX7ZFVhRHw4ps1nwduci6bR6m0OG576xqemdCuXHRNYXSM7zlQAl0tCgEf+EgonAfFIrxynoYQNIlkvIwQQcDwvN8DWO6ppUm4ZJS36/26c+RQEfrA51YPSfpcbiwGGOMoBeE/nLAaro/bui0Rp8JzUhZqKTRLq0o2oRTPdlv7HmEPuUj3kHKWlExfvkLiyJZUecgJQxacZin87a+kNVmSYk4iKAWblv7Xv2z4thbQf9/Puvnqvv9JVJtQppb2TX4Gifh5MD0iAFvYt2t79IHIZrMpmLVJioQ2lF+/bi1l5dgFxGr2jt51tVdq5M8IEps3CSzWcwOkypxpNe0oG7yuzCMBtVV4LVfijMRnMNuDGA/6Rvuj+s9hFQmCEoXa7sHTqVp70wTQ9pfH993iTXffPp+oDvYSuUMsaPMps0zgKhfX0NBb4lMz8T7XGLdj5Vgw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5484cbd7-d7ee-488d-5759-08d834fb9874
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:07.3631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyFTWWQSfiiMvsVd+OgSOIQGvmFng720teEaKVlvvvY3jgh7xyeRRi8Y5JmHM9fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add Sienna Cichlid gpu metrics export interface.

Change-Id: I89e6a4415fe467e7e4aaabe07d9e8cee379caa25
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 91 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c15496aea50f..345b8571f716 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -385,14 +385,26 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
-		return -ENOMEM;
+		goto err0_out;
 	smu_table->metrics_time = 0;
 
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err1_out;
+
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
 	if (!smu_table->watermarks_table)
-		return -ENOMEM;
+		goto err2_out;
 
 	return 0;
+
+err2_out:
+	kfree(smu_table->gpu_metrics_table);
+err1_out:
+	kfree(smu_table->metrics_table);
+err0_out:
+	return -ENOMEM;
 }
 
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
@@ -2663,6 +2675,80 @@ static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, struct i2c_
 	i2c_del_adapter(control);
 }
 
+static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
+					      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_0 *gpu_metrics =
+		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_SMU_METRICS,
+				   0,
+				   smu_table->metrics_table,
+				   false);
+	if (ret) {
+		dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+	smu_table->metrics_time = jiffies;
+
+	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
+
+	mutex_unlock(&smu->metrics_lock);
+
+	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+
+	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
+	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
+	gpu_metrics->temperature_mem = metrics.TemperatureMem;
+	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
+	gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
+	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem0;
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
+	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
+
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+
+	if (metrics.AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPostDs;
+	else
+		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPreDs;
+	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequencyPostDs;
+	gpu_metrics->average_vclk0_frequency = metrics.AverageVclk0Frequency;
+	gpu_metrics->average_dclk0_frequency = metrics.AverageDclk0Frequency;
+	gpu_metrics->average_vclk1_frequency = metrics.AverageVclk1Frequency;
+	gpu_metrics->average_dclk1_frequency = metrics.AverageDclk1Frequency;
+
+	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK_0];
+	gpu_metrics->current_vclk1 = metrics.CurrClock[PPCLK_VCLK_1];
+	gpu_metrics->current_dclk1 = metrics.CurrClock[PPCLK_DCLK_1];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
+
+	gpu_metrics->pcie_link_width =
+			smu_v11_0_get_current_pcie_link_width(smu);
+	gpu_metrics->pcie_link_speed =
+			smu_v11_0_get_current_pcie_link_speed(smu);
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_0);
+}
 
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
@@ -2740,6 +2826,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
