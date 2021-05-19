Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF2BC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 17:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1A2610A2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 17:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1A2610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800DC6E0CB;
	Wed, 19 May 2021 17:39:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FDC6E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 17:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhslEBibP+1ueAu0aa45NcGqmi0503FvrMHyZb32ZqLATOB92OaDGTwSN6cOYd6PovMSz/Gsucq6pV37Xs6pBajDNWrUpNOELbG/J7dYEIxf2Rz00vCCBQEtwl1LYrnYXlxEbqbEXDlOuTVuU2jLqTkwZMtcMwHHzIn1HwpysR4tQeTwhg5I8UgEUhDkYyUX9WkO3SWBlXiKNGnGbjmyYp+1imGKy+G4A7RP/zPiSZDdG+CQ6mYVqIkOO6TjqDg7l+jGWw/fStFP8AZK4jAb1srnl0yHBUQ+z8K/shd1ZZ1Oh5RkxB+7Xd7WXqQIgmFPKnjOzZNijmGzvrajtZ/dyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osEqTZnQwKYNo1tixPQPHWd5gk7MLD6mTwUQlseE7q0=;
 b=a2kB0AoyF4kaH3RMgdQYmNccW6Mv8vOX76Q1VuqZbweTLfOWF5Ut30q65bMJbXpj1+L/FbFls4cslUG3X7OP6lJYo0T14hhX04q3Mw29ahKH6o8+kK/4b3ry+6kR1jFVBJdnvg0yuMtVESQ+Deb2JCxEAJBTZJxPr3UgaL5gfe84CeejpzQllM4UOY+axLAjaC+FeE0ayuy1n9Ul5CaKpLTKiiczeOV5wlbzCWvJTCruR+BI8NyvZ1OrBsNgkHmccNQJ/csCIncI2xabJt3brjsDDBBDpycezVGNE8M9wfYga1cxziEFDR6YYwORx5MvA7VP+4zWQkFm/osmqsqRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osEqTZnQwKYNo1tixPQPHWd5gk7MLD6mTwUQlseE7q0=;
 b=Q6/u0XTH68UrFgco3gfVPWNqwn+3nwG4R7+T0vTCndwFuqISf8UHh7nfEaT2yL2OVJphUSUQIChjF7OKjv3VMh+N4ag/58F3O4o91vP9H0hDxSgNOoRWruqZefGJax6w7zc6a1ZTK4MN6mcWZbhQq3DhGra2p5i8Dkztb6pt0zA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3063.namprd12.prod.outlook.com (2603:10b6:a03:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 17:39:16 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 17:39:16 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/pm: Update metrics table (v2)
Date: Wed, 19 May 2021 10:39:04 -0700
Message-Id: <20210519173906.32504-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Wed, 19 May 2021 17:39:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bb82098-4e30-40e6-531a-08d91aed0616
X-MS-TrafficTypeDiagnostic: BYAPR12MB3063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB306338CC9E7FEC25564A6C25F42B9@BYAPR12MB3063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOrdLLFlpQC58GLRRkZ6JJjB4zcLZk9XuizBZ4fn9Ctqh8tKkc6hGV6wlgwp+Q4udbURtl5jQNt0CKwhEYUW7J/42Jvixg+F3a6zoML7LD8JZVM2kI4RTIeM8J8iwhnCtMNmECOuCZ2WmIuv8a9VGitYY1j5PmXU/C+DY0VJYrAQsn/OIVWj7qZ7NnGpzsNlVMkaWvaoifqGzjnkasNddDVIY16iyMbObDWhmvE4jhFka70Of+hXD0z71/bHtlQUbyzcY8i28gMFaMAJ8jJrQ0p6rn0Ll18vfD1FOufOCcnGuwR2r/pVAbNbO0gHWLV5FpryGujpSUM1FC/blrm5T/qByuz33EgKqBwz2yk7hpKL/GIjGmcd5Vr7GOBuvmaD8xn2XDiePAOBfrvzBUhPCfwZ/xgJKPuyGbf1L/BaMAn9zV9CPkfSgFZSjaCX5RjJzoYfgQC0uzl4gRuH3AnaKKNbjGLr0qfTAz88hUodC9yEJJkHPd+JIQnxopt3Kdh3NkzdbBAof7wv81VEUQtymfTUBmGuiG/ZMLkSCo0y88V0nE2i8u9q4LH3DZRvhGfJval3NX4JusB6g1B9m45YJnjBAzquP1R9GwfOIqu+n8Dk4ph3/D/e9aMDOyRjLSSKl45s3c0HqOwYE9pzF0KEqO10e8Vkt87CtO7zW4kIMLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(4326008)(478600001)(8936002)(1076003)(8676002)(316002)(6916009)(6486002)(66946007)(5660300002)(86362001)(7696005)(26005)(186003)(2616005)(16526019)(52116002)(66556008)(66476007)(2906002)(38350700002)(36756003)(38100700002)(83380400001)(956004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XSlwiyjsgw5hnOR4MuruVcP/1IGk5NH6zGdUGuslIZ9VCrV78u3BZqrfz/kJ?=
 =?us-ascii?Q?BnuRnHbfyf1RoR6vVj6P0JzIsDSYYmI0jk5FMEOds0zS/nq0A9vH5QpG/lM1?=
 =?us-ascii?Q?YD6KLMfEZk7JBb4egqzlocscUAusOLc84CI2H3LIhPtkKKztYQwGHr0AchSV?=
 =?us-ascii?Q?4sX6ihybms+ILsnjjx2cw6SQFOaqKxRFAtj5/BJS9P4hTMZnX35NNKvgJNyR?=
 =?us-ascii?Q?vw3CG5hmk/DZBgRuW6tdjyQnONc0dPlXoe46nGnNYuiREyYKcmOUhPMvfU25?=
 =?us-ascii?Q?uNKqptu3fQJh2RJHHeKD2LMQVE6wHCuIHjjWk6vJ9EknIDahIzFZrocQofF6?=
 =?us-ascii?Q?DsKhr4KhhQzDUVKY3VcyjVEJoN4NkXl+u6fqoaUJtWyPSQ0pXfcnbMTfo169?=
 =?us-ascii?Q?9j/XyNGa3zkBZHZSfCDjlPZRUkFMeY4xUTFOsVW3S/5kDLe60O7/Jqmzs8wH?=
 =?us-ascii?Q?bqYCZT4n3QtXa1lAv+Hvf70FaAjLAd8ZUkbY6vBezDlu6r3dAqIvKCnnhbTU?=
 =?us-ascii?Q?lXC9BvAx6xPMXlVsjwTgspTMqlXC1n0teFD+gGEf3Ew9PN+LPmERmZDM0/Wu?=
 =?us-ascii?Q?bhzjCdWNMCoLsG7nohww2AKWhDcfoRQqdt+X3d2y7GrqDQ8YoPFT6qwxTCzq?=
 =?us-ascii?Q?uboKP1mmNkC3B4QFbGrogbmCpiNIUm0Uq2jjn5jtXPZAUD/vyUUtjvylVOMN?=
 =?us-ascii?Q?hxzw1BAW/PSd3CE1SnP//nQWAZUjSZGet4pbrR7jT/P6JD5HGWRLNK0lBvzh?=
 =?us-ascii?Q?qm15jBi1E2zt9t5hgcO1e4yIErYXvS2hIohigQkmVbZNoa4Cq2J1m71sY1R7?=
 =?us-ascii?Q?uiWjKfeL6wWGibjuDmaWD+eYqVtXXYxGxEVWnO4kDam3bsDoBbMPLHUxPZHQ?=
 =?us-ascii?Q?uXFu6Y7pDaD9s41X1ogm9G5XAF0lBI9pQQhA3aPLBFsPNnow8PSfRuNOX4IE?=
 =?us-ascii?Q?j5c0wcZeIQJiV+v8Vg9J6zcoLaLOsLSinjefmCqXQevufBKLZ3bcaaYkzVrQ?=
 =?us-ascii?Q?hPf+DMN/bbBSfOBxymuJr4QXi5GAE9ASRgNBz9Q4JlnNO5ANeI91UcIP8gw6?=
 =?us-ascii?Q?5rHg5QrOv8wQb+xoczFCTIVZsCgvzWO5XoxH6pWxm47NWqSPYacgKlyM8/5I?=
 =?us-ascii?Q?Wh2SToCFwuNtFpqd6XCJ1je1NaBVqIl0amKb71CgI8zgXR0V7Sy8GwTJUf60?=
 =?us-ascii?Q?ohjsbr9mowqhY9sWks63E/KX5TBj+zbawVIsqycNoe1/BQZyJXzmJ1HuUaxv?=
 =?us-ascii?Q?vVZXYC8QSeioK0pJFlNDc+b2+qnqnRWPOD2QWWINUgV2b8HQiXvQGbI6WhLk?=
 =?us-ascii?Q?c59S0SwfLx4aB4siyvpaWcVR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb82098-4e30-40e6-531a-08d91aed0616
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 17:39:16.3792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJwwwv9aOiWKPzGzwCVJwk4mGFOQ04+GxMUnVBTfbla0c69m/3KIdFJ1FxyTBjwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3063
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

v2: removed static dpm and frequency ranges from table

expand metrics table with voltages and frequency ranges

Signed-off-by: David M Nieto <david.nieto@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 69 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e2d13131a432..b1cd52a9d684 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -536,6 +536,75 @@ struct gpu_metrics_v1_2 {
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
+	uint16_t			padding1;
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
