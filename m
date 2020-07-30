Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1360EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D911022B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="unm4GRh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D911022B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969D16E84D;
	Thu, 30 Jul 2020 03:30:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA566E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFOat4TRaMWjGCaTfbjSkaKaKxwJI40Ok1pzqta6AE49Ka1j/HWve/1bW1aOo4BViw1aS0fxU3kHZCKMb1WX2bebdD7DfxpmTgurBjVmMhk/t6tcszEUzdUgDDtFTMcWeU6/VWuzUNrlKQCDZes9AoEqP6aVOdKAXBVoAE2+Ela7ftciox7fCR63lTjnjhcIJbfw0CrZgCGpm2n1VVXHUFbbJSjN2yJ+hnWDEJKZvH7BUytiO/UncPPZ2VGTaMMHBhi6Pq241m0l/MzrWLc/LSBYYLJEc2wqzJxv9tcfiu9hmb11I8SWRvaSA1dBOLa1bVids31R1FWiyz83KlUXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AxblzIaHTJ13+F7ErsoNsBshT4Gdzl9lvXLEdoiwEg=;
 b=V3jR3DZb8W53pEw2Lvdv+M8skIWUTdvTCIUj8jazryli4vdUzVLBVtDQz/bM+97jLAscqAWB8X+OH7aWVjo4SbkHFDmR8Noxm1ECSfylZVdi2VFeanrG/QSTmMGj50eHxRUTjA6XldTsp87RWaVK+32XdCHwYBrCnHuPHp6eKpKjfdS603o2X4bP5bv1sc2pIUmFme4Qc3Yk9b+Zn8AOOlXtGc09Ij+kDtq9Bd8iqPKfI9dBU6rjx97UifjT7Wa+GJSrWH1YFvy/L3a3POcymoEZo1Rgjfnx40UPMP/dY0PwrPhQDkZNUMyrahlXbn32UARkJdntxSMhNOcX1qgPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AxblzIaHTJ13+F7ErsoNsBshT4Gdzl9lvXLEdoiwEg=;
 b=unm4GRh1hiHCZns7cQZxjtDRAq9QLzInTMj5dhrhiG/ozSmuKgp1QR430ZxR7tgCyHth/4gCB52RvYk0i07n2uv6ew/rty+l+xLFw7ZaLtd9oLSQo+nLVbUzwMSr66DeFI23JhcdcFK0SmJzaEbzo7jtUWfHa6ZuLbdd6D2eO7Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:30:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:30:31 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amd/powerplay: add Navi1x support for gpu metrics
 export
Date: Thu, 30 Jul 2020 11:28:37 +0800
Message-Id: <20200730032839.2517-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730032839.2517-1-evan.quan@amd.com>
References: <20200730032839.2517-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:30:29 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80b83f50-f253-4209-bc5a-08d83438e957
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13550A8799E8B0F88AD7FB49E4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaYS4e4LmiTGAzO7fJ6tqjAiZlYkiaamYtUlVbqqrveQGoKwpztSxd6YYTqcNxwsrcC0zAStlaFS0ZjughYFd8CiS0YqKrDazn+Gz4CAlg6wXdcsnsJuulsBkwT9dk9mm4q0ukK7DUy7C7Q/q8NoeuCok2U4tjC7oLUZvdjpqiXjVcHqziPEEPbB5QysWTyXNr5DOJoBdk8Kh0yzuHy0d1KRZ110cgV1UCXAgkQtCu6hETpHVqRjLnq5O+QJuEBRTYbuHSGQhk/IqL8hjvLY0e5oKHkXI9VdE63LQlHORP+6sahVAmn/KrrpQZ7XFMWdvlJDBqpzMvcERgYn4ikiSHYRJJTOAWF+zQYDJV1rml418iW//622at21xFqY4y9l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6666004)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: X7kiqL1VLMHEJCRomNRywCgkh/1OqNXRXKD5+wq1GwKxkWDhEQL4A70l5eTiAC2IzxYrxrLer/JMSz/O59Gm+SjmcuyVYme/zM8nC3wD5FcEb8cM+Xs9vcVfHhGZo5rjqnfqewioJMwQlMBDb1z9L3AdRB5750iJWKeFLJBYN5d8ZoHGVAralKm8NHu3cYPiYfzGHmjZ7TSLJUS6sihqrp0NebzvYjpD3NZ71FcQUjOxVrlc9h3ib7NgrEFK7/3RpozRtUm5MLNM+L2XqiFSftZOZVD7V/YwCk++9n0Rx1heOGUF4WWeIO6yoUb7RPWBo0IPIFCwKdwK2/TTggIJi53cNOcBoDc2DHpYFZ4ruVMAiuXHICaL+ZZWW+m4/7szx0efjh5SJt0I1gEmk3iMEtEU10FAjYHHxbqqD6TRg6yqrLMTfd4feEf9yf1jpJD9q/XjWiwsXjJ4rvL718ZXPVTMYmemQcRLKTOz5CFBVsgZeOhxdZOonOmNdoE9cDU0iCUp6I+UM88WMopuOd8o2bt2pFY6tIVrRkEdS819/9yik/YQ3nKq9Vv00RPErijtLw3hp+CDicDaprcA604mNWUJVbvvTI/e9heMmGBfSzJhG09d3xRTAAVWB0G3lfNedGNm4rDX0bNBE1l0PCs4aA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b83f50-f253-4209-bc5a-08d83438e957
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:30:31.3227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGrIGjRcyN8E6n5sty2d/qTC4eBJLQlIN3U8jejX7d1lspjM/RGV1xpK2uBtW3H4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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

Add Navi1x gpu metrics export interface.

Change-Id: I9028fb925e70c36fb2a0b00968c462c0bbc822db
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 93 +++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index a34beb27849e..a4ab1ace38fe 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -482,14 +482,26 @@ static int navi10_tables_init(struct smu_context *smu)
 					   sizeof(SmuMetrics_NV12_t) :
 					   sizeof(SmuMetrics_t), GFP_KERNEL);
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
 
 static int navi10_get_smu_metrics_data(struct smu_context *smu,
@@ -2501,6 +2513,82 @@ static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter
 	i2c_del_adapter(control);
 }
 
+static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
+				      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_0 *gpu_metrics =
+		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	SmuMetrics_NV12_t nv12_metrics = { 0 };
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
+	if (adev->asic_type == CHIP_NAVI12)
+		memcpy(&nv12_metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
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
+
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+
+	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
+
+	if (adev->asic_type == CHIP_NAVI12) {
+		gpu_metrics->energy_accumulator = nv12_metrics.EnergyAccumulator;
+		gpu_metrics->average_vclk0_frequency = nv12_metrics.AverageVclkFrequency;
+		gpu_metrics->average_dclk0_frequency = nv12_metrics.AverageDclkFrequency;
+		gpu_metrics->average_mm_activity = nv12_metrics.VcnActivityPercentage;
+	}
+
+	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
+	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
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
 
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
@@ -2582,6 +2670,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = navi10_get_gpu_metrics,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
