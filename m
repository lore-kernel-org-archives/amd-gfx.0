Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470C4CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD08310E335;
	Mon, 15 Sep 2025 08:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1rdilEGa";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E5D10E335
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGbyvo1sMm/sHuzPBwhlPxUh3UnP+9n7TMhWLIhGLlOSuh9W/yiqDVu61pqXFuzkKP82YM2993Fnz3Vl7HH2Vm8LljBetYtp0UsJRdHMjZKpZIJ398ggsk+hzG4lrtm+9Tu0kJxUPENLcjiGadd8xzZRXhMaejYkhAKxL0IYYWTYNY3YNFqYd5L/veFSD9PluhJMXwn69RwFgS24vLCHE2RmA3stZq+cveA/xX+SrlQmJ2d8HZ8FzreBs5quEO344peiM2WYk70/fx57+2sLTi7GAlgjD/PNlabu+BhMNu6Q+t83FhRGAOBv1PcfAJnBqXIzxhoIbRrpSEPKEkqzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmlDiQa/sDkzVaRgjUzjipe2ckfmTOmsfYtSLcaz+sA=;
 b=P3axuyRI9BEdfWLgCem4c/ehT4D64hzJUQ7LjcedoAwJXGk7qearqx+tyuNC1OfI5l89Ja9LoEX/X8/J6cfpxIffCEwu2xh30yRibaLXkQ5rCJFFVLm6R7hEcu5oUt7vCHwfVc2wpVAZG46/BDGb+4l7ytgag0rWAsOyFbMLgLcuVGoZOXTm4RUYoTiBHWY5BNVxvOajWRk9xfSSAg7fyJ0TW8R+FxOLICc1xbBfWkP8o+e4cxm2oPBnv6jew71/XJ3zFKJ6lbf8SSm07VbX70yPV2exh7uGMHbelcwq8VpeC8a9DSMKNMM2wUkRRyjqId+SEFtoIrkf5wrJ6B1RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmlDiQa/sDkzVaRgjUzjipe2ckfmTOmsfYtSLcaz+sA=;
 b=1rdilEGazup+HsQMJ0LqioMhBVaYJ6AeopKOtPu90LjPbTZJezGJxnFx0+6XNYapxQ5+1TmnKVt9tvXWHUy8ATXn3ddzUrykyVTA1+D8kjxo3m/1EEPzU/B8Z36Dlk1LOzNAkzyn049uo/LsCRosXvDeDrGYligLeZRehkrQvH8=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 08:02:19 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::c9) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 08:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 08:02:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:02:01 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v4 5/7] drm/amd/pm: Add schema v1.1 for parition metrics
Date: Mon, 15 Sep 2025 13:26:34 +0530
Message-ID: <20250915080123.3024297-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915080123.3024297-1-lijo.lazar@amd.com>
References: <20250915080123.3024297-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: a653cc77-747c-4934-deff-08ddf42e3133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?StY3PCUYcFrJfuBE/lOn4DIA/rNuGBW4S7J1ooGsOYOP4OcqOWsvUYaHosRo?=
 =?us-ascii?Q?GS1ZpGY6mB812qmb49FhFnUIQasqrIC3XjvSy623YCV15qCPYIBDnwS2A+XN?=
 =?us-ascii?Q?IbXGwPI59DN6GHPwy9FP+xp/gVILxQz2Alml6sutEapOAynA7MrDxGw7tRcI?=
 =?us-ascii?Q?czTUz1sVjhTxIxFr6BtpQ0Q7oj3WqS8qjPaZvv5un3W10Hj9dbjJbDy5GT5A?=
 =?us-ascii?Q?LjSY9srS487O/0V0B+FXS+awalrHyNLhkH/1uFi0EYZXP3OBdmF2bY0ZK0JP?=
 =?us-ascii?Q?t4Xx8UtqSKOyMT5JJ1FVP38x9Qa48eGsffAAwZnh5A2IrhIkZH2GJybktkFH?=
 =?us-ascii?Q?spT6tbskdU3P339dgrB+l6CU6AmuHC6cEIhDp0Mmx8iqDuIkXRUwA80Sfyjt?=
 =?us-ascii?Q?607KJLIka+2SVnMv3fS+vovz42bssvYcPlu1fO6x0Dr1tgiO7DfpEVEXu7/B?=
 =?us-ascii?Q?fPJxD5cvfYSZ2IwOOKYfHcaZl/rBGdiHzOxRNyBoOIaj0V1koF5EHezbDf72?=
 =?us-ascii?Q?XoyM/E8dQkjr9HobEb4Ie5qXLKOdTAuwuF+W22q5e7crHfUpHcqdBMoFeIjv?=
 =?us-ascii?Q?ZA/Px2Qgk5kAzJx5b8q9aZ5ojOhU1y8RocdZJ7u7hg2j8OjagD9Yk/IB99wB?=
 =?us-ascii?Q?rurd3KLlBfHmD20TqHsLjRtqWA28Y8bNR6Wr8ggzCLThHlF7h999CnP4zbXi?=
 =?us-ascii?Q?zE96bGZ++VkSNEjrTVbVbFHfYavF6JQfzv6i5aiWLdpBVSr4+DaSPjYGvl75?=
 =?us-ascii?Q?jk6TsHRNd/AjyUg7FImxFcClWkme+Z3KuRyhT47hoy2yKOh1PWUaDdhyWCzS?=
 =?us-ascii?Q?7ER0SmyaURYeNpQ+NtIFf4jaH3gfGF1Mkj+LnnV38pMNey5x0gfHb4TsCyG3?=
 =?us-ascii?Q?16SCUkOcRU3UGsieONtAHp1IjykLzQUR+Ur11/Al9d7xAU9I9vF9p3crfR0T?=
 =?us-ascii?Q?zaX8QfDGC7gWsUqbP4k71OoJ8WlX7A4F/sbGe2fSzdiQf6Qgf2sXbd5QknuX?=
 =?us-ascii?Q?f99EstVbyeIU3Ciy8lgzT6X6NJIQ6/82snguA1UxZdc1bSsvT3cnRTYkrFvq?=
 =?us-ascii?Q?9zDPeOrgv4p5AKn3DTvQq04q2UFkHmaJqy4jAb7faGlLxZ1AwasMD7jDLljY?=
 =?us-ascii?Q?pJRESNkud/SlCcN17CtWfrjCO8F/baof3fh4xc23rXnk3owVrEfve8YDq+Pn?=
 =?us-ascii?Q?A4diYuTLJceQD0FrDuVWOIg8iKwnlB14xU3yqN+gy4Y179F1nUVYtwCi7nuh?=
 =?us-ascii?Q?ROMKmWxa2DF2U3jC5JMSaYjpldjebNoAPHtPPdBHSVuYpD5FOD9spFtbeFdK?=
 =?us-ascii?Q?F+lRqfyscramAgmQuIOqPVgNxkQlXP6HgYZ1krGf2+ThbTzeOkU1dumUh7qL?=
 =?us-ascii?Q?SciBKgu9FXsYj5DrTFmW1zw5kNMUsgK9v8lpElmbTJrBS4NWDeb7m9uckqRR?=
 =?us-ascii?Q?T2P8jG7UhN0t/uDPGiPqhiUBsll9K0ReQPpROm0tY3JRCMaSifFhU0ZbJSW1?=
 =?us-ascii?Q?B+UdRMUtcUx3U/Csvu8l6GpFvPU0AQZJTYaV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:02:18.5907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a653cc77-747c-4934-deff-08ddf42e3133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use a schema similar to gpu metrics v1.9 for partition metrics also. It
will have field type encoded followed by the field value(s). The
attribute ids used will be shared with gpu metrics. The structure
definition is only to distinguish between gpu metrics and partition
metrics though both gpu metrics v1.9 and partition metrics v1.1 follow
the same definition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index c98525b85d59..55c518194933 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1816,4 +1816,10 @@ struct amdgpu_partition_metrics_v1_0 {
 	uint64_t gfx_below_host_limit_total_acc[MAX_XCC];
 };
 
+struct amdgpu_partition_metrics_v1_1 {
+	struct metrics_table_header common_header;
+	int attr_count;
+	struct gpu_metrics_attr metrics_attrs[];
+};
+
 #endif
-- 
2.49.0

