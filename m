Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC249C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 04:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7A661209
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 04:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7A661209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102616E5B9;
	Tue, 18 May 2021 04:10:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752AB6E04A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 04:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlOQAzDTO3JRVhCBzSz3EFPfbYN5PdwkRswRtZAaOexKAQgwAXw/3Dmfa+JzVkeaYqF/Xj4CS7wwU8H+OvyBm0ojjLJFVvTUd6+cvepfOJi+cZevso4Ud5MvhtVceUEAr28JFzC8CJ8eERBXwRqoQi6z2C3qFP6xn5l9BwME5A5LFe8s7bit9SPca5DAxJ3t8UYF0zlfJp2lzuJ5yqGFN67JEtr7FNcDF9lSIcsSqlwgziFLpaz+v0v504Mg+VMl1KYJuuJpon8qR7k1SOQA39kGwAcdUkZ6yo6y/QayVu/HSetimI7DMaxfmZW6xEOhAmTU7V5unGfj3wTqvjXy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDO/Y6begsWRjM2L3idEAIaQZL4poJEvqrNefcXR72o=;
 b=TQrZTa72UWKo15txvpYnCuHBJVMRv0O8XF4tiE79ufikda6Y4ku7n/Aw0fgCl2JToTS2BXofMiVecCK7MU6VnM6EnWx4srz1Zc6wz3U0fdJFc3+qUBc6DOUcDyy6RrRX1YoQVr9/4bW8hp+GYDi2mcrbniDn/EpN4KPJp2ZPtJBHErj+l1hht0ZuqG/rtaZvKdLwPvx7Q9bO2oeq95KBKA5UUe5wSQSpK3DF/EaG2dJ3ywyLPJzQn+2KIpDNLcpy30T2F/PF2W1e39cJz8MWDgOs32lb5MxWXgOyq+1JkFZy+ZUZdnXW/MchkIylqBPxa+4d1w5fQNcbkGixc5i/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDO/Y6begsWRjM2L3idEAIaQZL4poJEvqrNefcXR72o=;
 b=lm0F+2qnDdKgRSy19kEeipnW083X0xSTFLTskREPXkH8iS7bkZKWy9+flMIUfOYVlRHrO5tG6XcE8EK+2lELzWKLXS40e4EbrkzRF37s2E5+xcsvGL92gJAKFt/IH0xreubWLs1CxneoSA4psjfPKgBjZX1jh6H/rNCqcmEI7ns=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 04:10:11 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 04:10:11 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/pm: Update metrics table
Date: Mon, 17 May 2021 21:09:55 -0700
Message-Id: <20210518040957.23266-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 04:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 208733ff-b039-402d-b021-08d919b2d49e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4999BA93BF1B1197956ACBB0F42C9@BY5PR12MB4999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CK9xZXZRZv15tI0BZ/XLkvadKZWdis6uu6VQSylpFZ8RjAVKlnGBzLXFirf1sH6Qd4fsZshrAQXDiRSqXx74s5wRjE6JfjtXKXLIqvJkIpti799jZL30H2vcgn3DskN8y2edaOJT1O+lDBj2/CO5oZGvHq/BL74/gksUP01uTuxfZxC1XNaOsWC5VhUMBZcCD/Wvd0Ff/PvMPgNeUlzEDgMXF/IfDGwahnw8LTp1uSOacvV9rrYZJpZ4JaAGDqCMHRULipOTO6r/jYUAxs8YfJngO0o/KT/5w7ZXAEqVXimDSBEo+/jTvKemk3yFJWrlfC9Qlx7D9EelBCBu4jt30jwRFqmImYJCcpT716SkgnlN/CO5JkhvPGD883kg0CrRfhIk5rZFnahTAoq0Gpb4Y8uXX/cBGY2QLB6mF41+7R5/uEsy0KhzViItohzV8s+Ls5bhv86DA2C7s2W11MEdPN5tFazmZYO3MkMJJkQurVwVInPpGlbcrHj0Rm4GBvEyL83Y/B7KOMGN8Kmj/e4XyfQK6tztVyWoGbQ8GOL3dih5c+v9ERvHwAfGvetNCIQaJWb8DXQGBSSzMVY3ae3q/r84xnx4v9cIkkXCvVCtMbdwaHwh5Sz1EZL8eA9Ynw0ym5nENCsgib8Y7v6ZAnGoNfaTqV9s3+b8kPYUgdhnoto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(2906002)(38100700002)(478600001)(38350700002)(86362001)(956004)(7696005)(6486002)(2616005)(316002)(52116002)(8676002)(66476007)(1076003)(66556008)(4326008)(16526019)(6666004)(186003)(66946007)(26005)(5660300002)(83380400001)(6916009)(36756003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?f73INedQeR3t9tur0Dp3HeKZryAP5EPHnfLJgfoSQE6nulm0/MrmuLT+QA8B?=
 =?us-ascii?Q?lMWOzH1OMMAWGhm0FH0qcR8PzwjFejuefcF2Ejc7nunv1wSZXnr7XXvv5u+c?=
 =?us-ascii?Q?VdY1I1Vc/MZEHW7umm9GEib1xD5dRQS1MK7BqyVYKvs5Z8EpDe+CJjwMMJ9K?=
 =?us-ascii?Q?nHJaeZDdCJFNco4udrLPDGdKZRPTmw0k6Okf34+p42euZ0usZJWLD4NwzgDQ?=
 =?us-ascii?Q?BJDX9IMR7fZxk8asUq1PW3NKbeZiG6ZPHgfd1q70VPy7/xtrL1taUDW1RK0l?=
 =?us-ascii?Q?sHFtroLVeb/kc5pTttMROEKSiXeTAaBTjTtQ1WiPEviXSESejuxkCYfIj67E?=
 =?us-ascii?Q?T8rORo38epJjLgcUl2IdPYnws6sAb8FiQXg2etDDph/B8yqJb/Jf45PQ1yb5?=
 =?us-ascii?Q?P5zBLEgeaCSgRZEvm0gfdfQRUl6VhZA0AZGBSW/khmLk1sEEuGGBgCmMihIj?=
 =?us-ascii?Q?nNLkZ6Su5DuKZi5WqiEzpHUxKmoA6WtjwpexJ7hv8Q4O7ejKJuRSjx4v0gnO?=
 =?us-ascii?Q?MfoLnr/HngENnLYHnyJJ0DNVe1VBDoCgpGtQ4aQcvGqletc41HQFK8rcfMxS?=
 =?us-ascii?Q?MFL6HpowpIWhkidQoZFK7uDcaDNE0DzluyrvGCkuYS9PVwA/oUKRe+UnNiin?=
 =?us-ascii?Q?Chh8ve7tNxTT2xq1OUHy1zjQ3Krri7xLC5xcKAAa40v0UZ6FkyNaNSFCEdpj?=
 =?us-ascii?Q?ASTL+ytt9dJ6ZLN7mxvf7vHOlqo/7CE+tCn21GG0gbWgUAiDa88KHseAyJja?=
 =?us-ascii?Q?dUg1O9n2f2Evy/X/iwlEGcfAIrr8wefk1kRERSpzGlPYWRddWUfZJBqS1PM5?=
 =?us-ascii?Q?Xrcgz85deyRHeeJJxI5c/4GecTW2cS769ee6+4LsaE8R1x1LxPjZ30+lmYB6?=
 =?us-ascii?Q?GgJMqojqxsU1wKJXNC2Mdv3F3o4sRvHDWHpjgL5x9al9qBgv8Kg5pZflRZC8?=
 =?us-ascii?Q?mfOLmfNu0IMX36Kl+fI2GAkJdpF/GizDNj1bRM/qZwZUKh1RmXggL9fJl8tq?=
 =?us-ascii?Q?ygJsz+cHUiTgPZsDPj3w/RTZ4D3RVaGMbWSHnl/XXsgUd9pUmY+eE+YgN8NZ?=
 =?us-ascii?Q?8uza7NnhCeNHXrkLCwLPpzz3crB2XKJDRqM8PScsmm3HgLBqw/rocgCnvsyW?=
 =?us-ascii?Q?M7sf2L5QmFCn1OH6j5FsJ0HUg0vXRbdGAK7etnsOVrWnbrBwoRG05G+dDbsT?=
 =?us-ascii?Q?PLP3MR5938rwYffYgQuwXVF9h/xKzpxZM9dqP6iKG0HPT1lyaMW5jFggIyRN?=
 =?us-ascii?Q?xdYF+c+e7eK9Vv39NA72n8f9RQ0DRWda2ldBBgy0P8ZkA2u7PfP6U7yReS05?=
 =?us-ascii?Q?sGz2wE5/57hVWjfCBqqDQ6Nm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208733ff-b039-402d-b021-08d919b2d49e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 04:10:11.3457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USOJ+Uzke9O63z1SIZfnwaUOM+5bX/DKcWyJ0yxPzpv79OYJ31Qfi6KRDcEvGDvg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
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
