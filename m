Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA652C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B049861401
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B049861401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465D66E30F;
	Fri, 14 May 2021 21:01:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B636E301
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 21:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1tqdHXTbAPwn1xyBIRLxEX07zt1ZZx5yryxcjBqRyP16TSHZtOX7yWMSZBv68x6QUDKlLqi7t9z8zjaN+F/lsBi18OwZ2iZaUwnos0bGNfKr6WBnZUHDtB9xooZZHw7ktFgfa9YipyaQbKnE4jgEKjaFp2VywAGbeIhKCR6/KIGcPu1AHDq03rzbDa9rfTk8AmHnCP6gezu2hQJs9J0HIBLKjK/enHVG32+LIUh7nKszoqne072aI7DKP3Zx5d2GsBTIizcaESwsPwRy+l1PbcLgWDQMhuK73/yB4ZMO2vTQ2tSsi0ZQ1w4iS+JThHmDTsGntFX5Gr4lOAMu8KFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wba3OHRViMthzxM9WxQRX3/5pkkTVpCEw2Pb755UTM=;
 b=UgRNrLDZqO5l+2dt73PsGfY3ZaOESNbLfsr2WHWZWJpoC4yb6x+CYNSVkHUlU+k/02CTXj4a/DXhb0a7LTIWsp3bSYTUwA7Q93UmiZDURCPW0Nm46Bzo4S4CQFhasR7nJadY4AlbEoDYeLbYQZZPIzEud78VIkoz7xO31pnpXRIcfJdn1weSEZV/hmMU4nT5MEAyslMdG5dWl6fFMT2sHhZF5WKxKAVECZetcLodyu4TiyyQs8v9klOz1b6tSCaFHvT12hGWCtD9r13axB0Q+hHQPymDHSnYHtFjTw+L7otWENlEsCntloEU2AHLU/2RmhCtWg5d0nXmsZkp8elChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wba3OHRViMthzxM9WxQRX3/5pkkTVpCEw2Pb755UTM=;
 b=0QBIuq5Os0YoE91EUtUfvypg7KJYqcpQ7wvHnuzYzEZnRxOnrYJVYu59vQi1DXLfUeypBqBKJfPDboAGWSfO3LZfDUkq/9MlfR2mrE9ewRHzBF13jgw6C7Mawotl8QErXC0ysm53K8aXXxUHYMuVtJCe/bT9cTLNDQY7LGnKwl4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 21:01:48 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 21:01:48 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/pm: Update metrics table
Date: Fri, 14 May 2021 14:01:34 -0700
Message-Id: <20210514210135.14079-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 21:01:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 893d894b-6681-42b4-24e8-08d9171b7cf6
X-MS-TrafficTypeDiagnostic: BYAPR12MB4695:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4695CB40A9C716AE34B26AA1F4509@BYAPR12MB4695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGXvvX29RqRZypiRQI1+DsTTs4r9aNvo7Wt/9wBeeHXJa0y6UtIDDFdcvEs2s3Oy7q9/DNNGHkkdXTQd9/F+5K5qUlDsyHWaulCW6TQ8bIKdsxoZj8bf8VFB8RzO1WW/DDkMXiQ0yNcWYZeZCAAa/Cu9vLVCHpgwDU9m/expDXOqnb7BPnj6SDvCJRdyOaupP9Rx2q52ibrRHas/mkrJUO2KHd0nRylBk0VEB9RpKvZvnPbPD4Y463LDodTGj8ILr7LyThJq2iTAnn355PxF+EIuSCkDRPUuADHJLk92sbRnX1OumyU4iMpMeffI2CP3lfIWcMT/RxKbXpbmTCzBb/06D4KyTr80v4RztzWSkyYtELZDA8F+Nk2U35QSLJ3UNggYga5M9HYt37ynPdX9R+TuNnb//CUZzUZOVkFzjQdkpvJxYdiuSs+Kg+dsD0aVi8g5ZLOCTBw/FJoCtkb4RyqYr+gQNxaUvabZzslodx7iW9+uhf3FMXKI/MeUdmatGTtbNFUY1piyKI2hB5YnR2FYi6ym/qssdphFCTJvwg+ioUna2kqtATwbf649OMQsfRpWPHyw5EQXxTts06gJF7QBm2FDRMOV19ZNsbixmLc0iSsUSvaPykdJdlhXREXnlpWAkPfmOaTPYdvvalT6sDmr5CPeV9qjas6zsKHNUjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(26005)(8676002)(16526019)(6666004)(2616005)(186003)(6916009)(5660300002)(478600001)(316002)(6486002)(1076003)(66556008)(38350700002)(8936002)(956004)(2906002)(7696005)(52116002)(83380400001)(36756003)(66946007)(66476007)(4326008)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bBvLdmX8ITmNxhzbafBNQewJk07wPWFPaPe3LrETv0jtDcES9VR9KjBCbPzp?=
 =?us-ascii?Q?X+qbZZiEuoGJNo2Jjv1d1mC078SkXAAHdvJwngATDSUaqFK3dkFARNYal8uE?=
 =?us-ascii?Q?AsefEIyCww+IpKhgyOOY3f4w0PBj9ho9ClzhOEdQpQMuMAP15x/6DSDmXo5R?=
 =?us-ascii?Q?em/3w0PF7N8uowzU9dcMMYDXOEFFS+iotYWG+N2WrW/QN80PobPuW4y5xghb?=
 =?us-ascii?Q?Kmj8K8jIFR/pPY/2mDWGG70EgJbctbUA7Uj8XfgdlSSPWuMCLI5WXi/n/mbY?=
 =?us-ascii?Q?2oHDokWfoK1a+OpO4A3ELPjflMBwUQgyTPwmLFDl1QbpOIF3IpnHQXMwdbsV?=
 =?us-ascii?Q?GHPEv24RgLBtxBOB0CPZWTdvzlbg7eHo9KGTQmlvXzdBZd0oYzIB0pP4V77r?=
 =?us-ascii?Q?acVm307eEHRxLzsEC0sr8tWK8qj4M+I7dGadsLBK699K6fWdPhy5bOMKERPB?=
 =?us-ascii?Q?tWfUQTtncOza7meYPaK6es0iaMf9kfQAT614TJDjc9Eupj0imW1gYCLl5r5p?=
 =?us-ascii?Q?hq+90rjPMFQuRx7A+LbC+E/EHPXB4JkXecYBW+NG31BYe/pxG4l+v74LYeog?=
 =?us-ascii?Q?14KTlnjrS298eKG9aULbYcvPDN0hqZp6ta8/Nq1tySuT4LzOhG3J9cRs4m2L?=
 =?us-ascii?Q?xvPcpDB2aICtIIiX9woPGb2Wwf7BKyr/w5kksZ8Vf8vNkMDqw2DT1bHHe1TF?=
 =?us-ascii?Q?j+GRvrLnRFjHXHsunoqC0zSBVGrpp5Aup5ues+N7dVg1JsCQyrioM7EQSTKf?=
 =?us-ascii?Q?zd2SgJIalB1/dkNrljyjLFT4MGTvX9FiN8ArOgBeZjkxwywU6Y2Fs65XbbRY?=
 =?us-ascii?Q?Ccb4u5nDnmeomdZklff0IAqUL/HzwFHsCwLoaHRnN8yNHmbmfnVFWrGaB3c0?=
 =?us-ascii?Q?2kb+gNMaw6vLLiCpr25JAtJ85F+6b1wX3GhDtWobnL8NRYGm1OOsAnYo1/3Z?=
 =?us-ascii?Q?gwvwc7WMARPaAwiwy4qH8102MnYXOKpeugQ4SQ1YAvsakS4zB6JHmDkptU9O?=
 =?us-ascii?Q?T2fUht6MXE0M27Hdogep0wcn0w/5cUVP3a8yb6pbaWOWMvuZTb0SkrV0gypW?=
 =?us-ascii?Q?6s92nOX6OQxpQmcTTTNkPz+VQRTKL03ALwC8ZlQCs3gvccXqA81vIdcQkaBB?=
 =?us-ascii?Q?vZkGJ/yeG6lmQoEaCVomma8eGpSq0TLfWDnO5z7l7lxAVR2sYBJCG9nnJdkx?=
 =?us-ascii?Q?x/1f7r+XHHu5RL5MbVqTFupy5vsfpxepOvUgIzXnf9ZL1WuURCbSaz6oso/e?=
 =?us-ascii?Q?Hfwf5xwi9iozQicHvuWoxATLWXogYPHwZxbJNg7jPgoXpQ5MR/CsFWMa8KxY?=
 =?us-ascii?Q?PPNQzf9dRbxTdrghLoJ5q/r8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893d894b-6681-42b4-24e8-08d9171b7cf6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 21:01:47.8767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylWHMdponkYizTRyWsp603yaVtMKjqRS205SwE/LDTIoyLdD2sDKrvTx9cnra/LX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

expand metrics table with voltages and frequency ranges

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: I2a8d63d0abf613a616518c1d7caf9f5da693e920
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 99 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e2d13131a432..7e2b22a0c41c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -536,6 +536,105 @@ struct gpu_metrics_v1_2 {
 	uint64_t			firmware_timestamp;
 };
 
+struct gpu_metrics_v1_3 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature */
+	uint16_t			temperature_edge;
+	uint16_t			temperature_hotspot;
+	uint16_t			temperature_mem;
+	uint16_t			temperature_vrgfx;
+	uint16_t			temperature_vrsoc;
+	uint16_t			temperature_vrmem;
+
+	/* Utilization */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_umc_activity; // memory controller
+	uint16_t			average_mm_activity; // UVD or VCN
+
+	/* Power/Energy */
+	uint16_t			average_socket_power;
+	uint64_t			energy_accumulator;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_vclk0_frequency;
+	uint16_t			average_dclk0_frequency;
+	uint16_t			average_vclk1_frequency;
+	uint16_t			average_dclk1_frequency;
+
+	/* Current clocks */
+	uint16_t			current_gfxclk;
+	uint16_t			current_socclk;
+	uint16_t			current_uclk;
+	uint16_t			current_vclk0;
+	uint16_t			current_dclk0;
+	uint16_t			current_vclk1;
+	uint16_t			current_dclk1;
+
+	/* Throttle status */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			current_fan_speed;
+
+	/* Link width/speed */
+	uint16_t			pcie_link_width;
+	uint16_t			pcie_link_speed; // in 0.1 GT/s
+
+	uint16_t			padding;
+
+	uint32_t			gfx_activity_acc;
+	uint32_t			mem_activity_acc;
+
+	uint16_t			temperature_hbm[NUM_HBM_INSTANCES];
+
+	/* PMFW attached timestamp (10ns resolution) */
+	uint64_t			firmware_timestamp;
+
+	/* Voltage (mV) */
+	uint16_t			voltage_soc;
+	uint16_t			voltage_gfx;
+	uint16_t			voltage_mem;
+
+	/* DPM levels */
+	uint8_t				max_gfxclk_dpm;
+	uint16_t			max_gfxclk_frequency;
+	uint16_t			min_gfxclk_frequency;
+
+	uint8_t				max_socclk_dpm;
+	uint16_t			max_socclk_frequency;
+	uint16_t			min_socclk_frequency;
+
+	uint8_t				max_uclk_dpm;
+	uint16_t			max_uclk_frequency;
+	uint16_t			min_uclk_frequency;
+
+	uint8_t				max_vclk0_dpm;
+	uint16_t			max_vclk0_frequency;
+	uint16_t			min_vclk0_frequency;
+
+	uint8_t				max_dclk0_dpm;
+	uint16_t			max_dclk0_frequency;
+	uint16_t			min_dclk0_frequency;
+
+	uint8_t				max_vclk1_dpm;
+	uint16_t			max_vclk1_frequency;
+	uint16_t			min_vclk1_frequency;
+
+	uint8_t				max_dclk1_dpm;
+	uint16_t			max_dclk1_frequency;
+	uint16_t			min_dclk1_frequency;
+
+	/* Power Limit */
+	uint16_t			max_socket_power;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0934e5b3aa17..0ceb7329838c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -764,6 +764,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 2):
 		structure_size = sizeof(struct gpu_metrics_v1_2);
 		break;
+	case METRICS_VERSION(1, 3):
+		structure_size = sizeof(struct gpu_metrics_v1_3);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
