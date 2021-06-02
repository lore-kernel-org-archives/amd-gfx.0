Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573ECC47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1AA61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1AA61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313266EDB7;
	Wed,  2 Jun 2021 16:50:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496656EDB3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAKVl/MoUNlboqNoI51Tw0D8tCgeWS33ssgYLxQZ6tOym4qsUgpCBrkZqow4Vgl7EJ9AwPVTV/5ywZPK+P0uZtqZL6aBtGRvr/lWuqeA7eHncsxKHj8vmsoO0KTYUPs1a+iwSO768pVPxquQSmNnFwlh8a+gTCS+6R0eRo9BqOovoragFaLwEEMj51lIFqF9ZeWtIZ8u/JWOLa9/dRJP0vhU06p5BOWPt+oSvN7Abx/toFKI8+Ns60UHPGcc2A1vMGhTAbcDS9CVS5UoHlW0D+CDTAb0uSXcDQxKpyhr2Tlpxdgh5+jv/I1OroYFKA0xv825rsniiJXNt+MK8xA2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1XcSwEQlRi5JaSQ4gF6erR8l9JuetismY+WhRUnVkY=;
 b=fFwU2/ioSbkRdjuIpxgRIACRCyahlHRmyoSJw0X7YpfiWV5K/V3ryYwECPyeKuFPc6+aWsopOicrC5Rn0H7GEWzYTMgEKJHk1A08wNZOqHthjTG7nEyy7d5XlGsB5leyZvXQbS0TIgarnN6zZWhazPfcXvcy2teUROJS+/sce5NT0M+zpQvFuj5ksGpxIav3MV1FmFjfa4OuIq6yFld25ENFlFzs12Ac3WMOGP9p6ZRADgkjEYX0OV24L4Ovk70UvvcLg/G3tm43tgXZbmOT4bmJqUGeEaUQaZ+WBd40VBVOdy9M7sxlC5pRvntMsqlrKqByCskYoYMHvXxZGX8y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1XcSwEQlRi5JaSQ4gF6erR8l9JuetismY+WhRUnVkY=;
 b=Jr7bJfzkK9qSNZ4GPDv0jTICafYUkNOORhBCcSNxqIIXB1INqFrhNxUYEv8LU1lVIBB9FxEEvnFrDmImNFYfY1FVS3fpgavMDhp4PG4MmqmhgEt6MZeiWfnMW+9Aatuj6AYOG5K9dknbgwrvhUjWNJ2UTNoBL/yonYtWAQHFF1A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 16:50:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 49/89] drm/amd/pm: add read_sensor function for yellow carp
Date: Wed,  2 Jun 2021 12:48:28 -0400
Message-Id: <20210602164908.2848791-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47adb2b6-a645-41f0-d7e9-08d925e67733
X-MS-TrafficTypeDiagnostic: MN2PR12MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4487E11EA2414767DAACFE45F73D9@MN2PR12MB4487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5ozGitaanhNc1y0TxySFYsroHHi0senHJ4gHpdZVaaN7qYNEzJxj9HVRNDfm40JbRd9yqtJEMo1Ao9qFT3CkVrq5NMt+CW8R3xlx7SPnihxCCWKvo8NSWMiF5UoYVtKHkN6G67KwSqDx4KOk8CkgUPFvVZoIL1BZ7J59QtR8AouM4EBLW0kUUB3d3m9JbZpdTyHAeu6RuHb4WQW0bet1+fbY8aWBKIoXau4J6hMX68IZM5mNY1pkrhADEdX3MAb7vDpQDeNOSRS4u2oXZYGd3TGRMzpFTKgM42UEdAY6L4LQykKQE9cxRMtWRP4Df1igRAEgSPmstxoUBFB2b4rCvbFFwPYp2udjbXYYVfMZa5WhCb0tAsGJAXrMCBzlJTYlr/YKFQdiJH3IbIo1lo3I+WuD3YKveaAsuU0YVKeE1/TdXTvRMaC49BB2AUOm0ol6lOje8tbCfCWeFWAw/5c9sDZ4h8ajt5DCbQJQQV/8BQE2UL3Nr2zPvf0j9Bg/+dyQBRgwsqnQ/dN6OtrqOevAwJpCE9fmI4Ivb5/uCvwq1ZyRlHhmfZs90s5/gtWdfUWxW+RgQf8Gb3+ey4psTZuieor3Kg2M0WxWUp+bSnA59/115PYpTmOKGww+Fgr5urFq3hcEh3ThIND9yJfRgFtbP32NRq/RTwzKy+fzNxg9Wihl4d4iOSBEPoo/0F+KfDn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(54906003)(1076003)(8676002)(478600001)(6916009)(6506007)(2906002)(38350700002)(8936002)(316002)(6666004)(36756003)(66476007)(52116002)(16526019)(186003)(26005)(83380400001)(5660300002)(6512007)(6486002)(4326008)(956004)(2616005)(66556008)(38100700002)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oPuThAgysPmBjLAjS2M1BWo4/fFsahXpKoN0rDNI0UUKpu4Ps3iyTASZx8Hc?=
 =?us-ascii?Q?/OgMsbgKl1AFkn33ay300nOAuw17dwxfOuEeBZ/ADiFWmbfbVZKz/c6j/Jbv?=
 =?us-ascii?Q?kwdoMFSBEIyG0hrMorIxBFREhIIhX8yN1sY8gV/UAKWXw9pNvpp6zCpzfjm7?=
 =?us-ascii?Q?AjBQ7aY2/BoUsGyAEIY9M6ab6j5aMVWTPL9balvrmhROnWZ5MvSpp4zq60zl?=
 =?us-ascii?Q?vNDKt4RGWe/hAPKemjNzKHJWPPe14pCdQDa3/8vJMrSgI5b60GO9i264hxMh?=
 =?us-ascii?Q?5P4TaiSrxfJgGWlSLIlJIfO4ns8feoKFvpGAtrQKy2q8yMrJqlEYOw6GfGAg?=
 =?us-ascii?Q?C0bbV/fT5HLRicJWStn04i8lqL2bYbgmRtYVBNf/vPWJgViiExkh0fXCxLvK?=
 =?us-ascii?Q?nj325l3OTCvTf5msXuocb8z3TEYTuEfVWdACiaCZsyloZbtuqq2uMLAnsN7a?=
 =?us-ascii?Q?AAHSKx2xI4cWED8h27T/FIG07pkijk4158zU0hHLEi93nOSgVPG75vBbWcEz?=
 =?us-ascii?Q?+45JbvbagLi2ZmgJpGS5c7ccdXGBb1fnHQjFgGWkTJjeKcI7ijXeNWme7qvd?=
 =?us-ascii?Q?GDghw1mw8DdRhqYIZ4a1E5elETfPOcnKydEuaCX6SwgzBnmLBjG9XZ61u7MX?=
 =?us-ascii?Q?gVxHO1SgJrV/j3dwzUt9Hh4+hR34LarSbQ/n+XPC8PuCpiCi/Tfk6QukusuG?=
 =?us-ascii?Q?Gb4BlBCx9XoU/bmaBMzkZOUfI/z7IA7y8qyrlCFZAe6Wu3vNjCySGAFPm1LY?=
 =?us-ascii?Q?oRi5IeIPkF0dAMy1GTM75CAo+qU7a+1K2N4yMfHvlTLQdKEjWU1A3eJGiNb1?=
 =?us-ascii?Q?1uRTqSh5cU+FXfzyAC/btg3A7aEcZRy8c7PZsLOaFkK0SYX17pBldiScCxB/?=
 =?us-ascii?Q?gKLzHnT8l3k5s36BXEeb9bjA1yAgQ5wExvDF6BSbTEr3Sbl4rL9+PqCnoJ4C?=
 =?us-ascii?Q?jHb00IBQs7FKjFp233ymt3ZTJJ5QRgMV5rSAfK0nGg3nx8JwLUltO7guX6Du?=
 =?us-ascii?Q?F1G75r9+s+Q3ws0aKl7qoFIZ58mNRBwnmea/TdRjkkQEal59f8sR33nwgRUJ?=
 =?us-ascii?Q?GNWqq6fmCtUDZ4QthBK6tqJ+BCdjU+MVGPe+DQXtO/gYPKPDeclNNj96ZMlp?=
 =?us-ascii?Q?BgQ2CSW/q+0NZRLST0whY6hcU3OrCw3l6x6c71zb22OgTvELFXkaMX/sqfxV?=
 =?us-ascii?Q?9HC9DzsYqvz0ZX2z5YiZpXXeAFX+2U+5zWw/a2OfnnJYm/xMmOLHfuYkJ4p/?=
 =?us-ascii?Q?Xm6xf3QvEUduEbSHt3k7S1PC8Y2KRtVPM7pvpWIXIrQ8bNJar+xmSR3nxlbK?=
 =?us-ascii?Q?f0HpsdJuhceWdanZvXqA4qMB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47adb2b6-a645-41f0-d7e9-08d925e67733
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:02.4049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf5H6V4AarRKlprFWgjcdCK4XdkTJxwgOAMSJYRzsl9AA08v4vke0Qun0JNsBOhMIquzGF5KQsoOmzOJqTBYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Add callback function read_sensor for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 8cc0f8c28263..373abe8376c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -183,6 +183,145 @@ static int yellow_carp_post_smu_init(struct smu_context *smu)
 	return ret;
 }
 
+static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
+							MetricsMember_t member,
+							uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+
+	switch (member) {
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->GfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->SocclkFrequency;
+		break;
+	case METRICS_AVERAGE_VCLK:
+		*value = metrics->VclkFrequency;
+		break;
+	case METRICS_AVERAGE_DCLK:
+		*value = metrics->DclkFrequency;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->MemclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->GfxActivity / 100;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->UvdActivity;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = (metrics->CurrentSocketPower << 8) / 1000;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->GfxTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->SocTemperature / 100 *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = metrics->ThrottlerStatus;
+		break;
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = metrics->Voltage[0];
+		break;
+	case METRICS_VOLTAGE_VDDSOC:
+		*value = metrics->Voltage[1];
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
+
+static int yellow_carp_read_sensor(struct smu_context *smu,
+					enum amd_pp_sensors sensor,
+					void *data, uint32_t *size)
+{
+	int ret = 0;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	mutex_lock(&smu->sensor_lock);
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_GFXACTIVITY,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_POWER:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_SOCKETPOWER,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_TEMPERATURE_EDGE,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_TEMPERATURE_HOTSPOT,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_UCLK,
+								(uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_AVERAGE_GFXCLK,
+								(uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_VOLTAGE_VDDGFX,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDNB:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+								METRICS_VOLTAGE_VDDSOC,
+								(uint32_t *)data);
+		*size = 4;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+	mutex_unlock(&smu->sensor_lock);
+
+	return ret;
+}
+
 static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.check_fw_status = smu_v13_0_1_check_fw_status,
 	.check_fw_version = smu_v13_0_1_check_fw_version,
@@ -193,6 +332,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.dpm_set_vcn_enable = yellow_carp_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = yellow_carp_dpm_set_jpeg_enable,
 	.set_default_dpm_table = smu_v13_0_1_set_default_dpm_tables,
+	.read_sensor = yellow_carp_read_sensor,
 	.is_dpm_running = yellow_carp_is_dpm_running,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
