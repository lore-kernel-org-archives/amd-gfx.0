Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0594C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 01:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481EC61026
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 01:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481EC61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0E46E041;
	Wed, 28 Apr 2021 01:43:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989A36E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 01:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHY2DsYwcUIlQijmw593otv4z3qWNPjIX3mbivGIDN+OsQCB/eDHlhcMieZcXz96D8AuuZXiZWtfBfyy6poH4Qx0+xxZ9+lEnpw0b2rg8arxnDvGe5rzyRUBms+BK7IJxcEpGdJg8Zfx+C6mzsiJ/Zfqv2WmNM3aarZoI42f+YBAatMNGMLfcGbvuVyrCRv4aGIG2tG5rEi3BAHVbVA4dRuQcqDm+ngLfFpwIJUDv7+nFXC6DD02MMDM3wf8BQqUh3WbswMkjstWAhQYMM1DbB2RBrMxqFgm9F9ymRa7qofV7iQXKiYw9Cx5xT55cXZriRrcaLLHOPFZLsJGvTiIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKPqqvRrfOGRhZL9+K45epGClittSZpKntXpo+MA5gE=;
 b=X014hUyKcMHlr4liIzibew5KdwQxEXBBSFY7H4NqWr9i5ShKEFJVUWpRtE4lSZBzhSt5YAuEXLjnA/5Nmq/EUTwXt9vTBbT3kFlkO3C0pZF3bZAttwrTXx23nbTKD8S24GPJD0e+Ld0UqRVnf6oAlznmOEEPS00y9PGtLuI58eQ1iQbsk8O8jijL6LtJWmKYfE9W93rzE0WnQq92jPThMoY0EUixoAHcSo27UW85KtQ635AOAYOVLj2kaN/99AvbMQqUTjAZSHymhucxkAsbAVFQcBHgjZ0SPjKkhOTJ5cF/aq7a3hWuKUM94qAngK0+YRKB18WEBanKIYVRlxFZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKPqqvRrfOGRhZL9+K45epGClittSZpKntXpo+MA5gE=;
 b=ZTJCSr8Su4wAuI+onelZyGkoH43CZvLVBXD3PnbdqOX87DtFvOB7tUI4YbpkjC/oBxvbCXgAB38pWTKr1xd3te2p6Ak/hEPKXDO12zw7bhDa+armWMtaBbxNxR0uoD9qYotqVq4kZHKB+vB20rP8+962ifdfEJ/aWuKjg542GSI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Wed, 28 Apr 2021 01:43:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 01:43:26 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: new gpu_metrics structure for pmfw attached
 timestamp
Date: Wed, 28 Apr 2021 09:43:04 +0800
Message-Id: <20210428014305.1736511-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.16 via Frontend Transport; Wed, 28 Apr 2021 01:43:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 399d4ad0-cb34-4e45-4106-08d909e70429
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502C868BFB52D9FE5F3CC28E4409@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3EmlEE+Su6Z6yGMV3lbl2JvJLI+8ejSit1S8uOR4ZT3E164Rteb5NM8QhBZzV9q/ogrpnOLlvd37rtJxgY3aYuTgtpF615YqJR6w98/SVbjwqEBe+IevOCcMXzJs8McLcVsATPCy3jq5T0Lpt7UZFzoH9cdbG4JCzhuWzkQoBD4tXUO2RiISfh9KZq0mZ3pa0I5+mdjTybcLHtHgRIt8bG6TFSjulZBUkLRQ3dyV4jThinarDFx0gvZS7T9g06eP7vsYjZ3nChasXWzWOIsU1tOEyRpiqC2/Ls3yd3MX595f8ETnbKlBbPa4yUMM3nuDVNJ6EJystA8tXGpXsC/3PsGrRX1lufuKjQZNgbXiUqONuxCnEJsli2VzezaKMNuNQYY+UfTE1kZbpFfdqLMZRlUrH4yyOIcHd1eXBhsPJtZX9LXuPXi6EEcNZqOxSTCrRTo8lcI7ExrqUv7bohfAMcmUF4cIEaxwsDf1vgj0v55ZnJonQP44YlYMSj9z+2Ovu7LrxMBJ5rZ4td4Sonlf9YuFcVP60UE/XPDJo6Ww5uiQPGqZU7zxwghAkbv9tawuTzrSVnr/Xlj6KEao2GFKaSzPcGcRBK2WjWnESGYqQt0BxojXYq+gxn1/6TeLUR0Tr/93bIkvQUMRAiF9H1Dag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6916009)(316002)(44832011)(2906002)(478600001)(16526019)(5660300002)(26005)(8676002)(52116002)(7696005)(66946007)(66556008)(66476007)(36756003)(38100700002)(8936002)(1076003)(956004)(6486002)(83380400001)(186003)(4326008)(6666004)(38350700002)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/J6ML1wgb8yNn6JWuGUD/eH7BLUMYjYVZJFGqYJ0wl4qNQyPDOXdvB58e4D3?=
 =?us-ascii?Q?HeayilQxqZTLlER62hvad8s6Lg4grK7yNq7ABvoxQKt5S4nPJZ9NiuK1o4dX?=
 =?us-ascii?Q?TY7C7cpvldZcusVhfd2sNLEs96bbzMp1pXXe8aN/iSNsPgez+Bw0W3JNp0++?=
 =?us-ascii?Q?KrufXmqMoWO/u1XzXRb7YBHr6WNeEO9cXtyg7Vvo0nmQA+3MRT/2yoYlHS/e?=
 =?us-ascii?Q?wmXjDBAir7Oke78PSo3DyRljpR1jOZ1OCDxg8hBStyjICobhGdbCKezP2G7t?=
 =?us-ascii?Q?EZ1Q4O8ablCxH6V4DRgTKzL26wTEHn86iYP1eBmtWrQiCA8zs9WaK+6vOpyP?=
 =?us-ascii?Q?1CgV3eoF2SiEf7d1UdokmMd0H/lHjOYo0NKZhO9rHxR0nysF+d8YUyP2DJKy?=
 =?us-ascii?Q?/0r4sCC8uS45pyr3YTA6Kqh3GUgVY0ha42UKQxMIjKJY2wmJucfQU2azmBwX?=
 =?us-ascii?Q?PlDYQ+JToCzZcj4bCgoXwNsUIZZWfLXcC54u8UbDPwItde90WOBJDIRO+Rls?=
 =?us-ascii?Q?TDcgUzKWagPeZ13Bt/iwmj4LujcLVM2KFlgVfsAnYK7ujcdqvMn3ZIxR96jc?=
 =?us-ascii?Q?zy48XIGLyX++js8ZjXKkXsiZM+3M6N7+iCxD9Itr0DwHQG3sEXsRnY9gcE56?=
 =?us-ascii?Q?0FHHkXeDcQa22HRwrnzsjQnhyP7ua+mYPDOimKWSpnp88MSthAg2OhxI/m3M?=
 =?us-ascii?Q?KjDoNlLrDX9laNi5IwKqrlCl5uacphnvrOpzTC0dO3eoG9K+ex0TX/YF38Js?=
 =?us-ascii?Q?y50oU+MEK7+hNXz/ASjcBvmN9E57Cb1RPek40YuQi0cym7Yr6siJYSxJCRL0?=
 =?us-ascii?Q?a5wNSChI46iqFdDZp6W18Ul6F/jAwAnWdxIsb8Knwih8f8lONf4S9s5fkfwA?=
 =?us-ascii?Q?eobW/0jvTiLk272S+26NQcwc/AXykG4ZjHFkLpewxFhDuWKK8M5KgZXQYUoO?=
 =?us-ascii?Q?LZMScGxpBftfFytYcEjBTDehUT6bIHU4rKYaSW16OdY/V/6LIg42KtHtzoyK?=
 =?us-ascii?Q?v8TD7DDmm2LYu92KiQaS4N74X/AQWgj65WdLINNj6J6/RO8CETj4fRhEzS95?=
 =?us-ascii?Q?XSCyhHHduRc/56HiO7Fb1/0MGxzI15TfIM3j73jKZmrit3KYpA1mGVcmWwds?=
 =?us-ascii?Q?NxDzUWb3q2wuhR0meGbGKgxrPAPmEhkuPJvGtMcURCofJJHP3X9d9aiIA6j/?=
 =?us-ascii?Q?pE/R5lB4RTL4EqgGfhQW3sP18rMi6t5plSaT6YdnshOJEnwtRYvYGBy2hlFs?=
 =?us-ascii?Q?Ue8fryR2ExmE0Z96J4/wASNTPSgobg/FmUsh/U+i2QU2rIsiaODnOl6Q/0J5?=
 =?us-ascii?Q?2955GESKK9sJxTBN8YaIfhSy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399d4ad0-cb34-4e45-4106-08d909e70429
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 01:43:26.3682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xh//7JyOT1ayPM0n+/XHD8M43t7tDNf4woJ+C3wYMxG5LlNS3NE7nSwypLjkmuN/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Supported by some latest ASICs.

Change-Id: I0bb26df87d10f1b356b5b9bf008a1422a8fe60d9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 71018a5fb0b0..f6818dd84145 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -474,6 +474,68 @@ struct gpu_metrics_v1_1 {
 	uint16_t			temperature_hbm[NUM_HBM_INSTANCES];
 };
 
+struct gpu_metrics_v1_2 {
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
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
