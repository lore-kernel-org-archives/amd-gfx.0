Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909EBCD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 19:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300FC10E8CE;
	Mon,  1 Jun 2026 19:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVy5tDy4";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A542D10E8CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 19:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTXn10mTYEM3BenoCCwdNFP3VRzVCe9N/NCVPrMvM5jS7tIDVEjnxqu19Sy9yTmhY2DoYMs3brEY+2HNRLBh5kgpTlQsx0I+Hg7Q/tXkiUb8yOBA6AyPd7dZZrPJeHSuRuCFsiCh9HYFca8A2nM0ayitdVad4/1CgdpPlY99k9gsXV1I28H3DFONazL+d72vlnEQUU5LoPvr109zt8MoFPIGgokQkcJnOwTe4bxq9vuqXshNHvjz4HU3DSnOd0Eif54XsBD80uWjB9CGY4AtFSKUW8zEnrGiNklY5H08WeA51HA5h0wtHmEubq3NJlLggjEmSsWZJBh/Ts137ybvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PUW5JavvxT9MktTXnC8ZYsr4wv+smDAHBREb772dqw=;
 b=aM4RE31PmWeI1XpZM6z0NNLqw+T/ZcWIlj9dzxp5dsphJIaRyZ8jK3WTkX3nnvi6iiyCKkag3GibVfx6m4Z2nfn6PF7SLxmjgA21bXS0bB+qq2XImCIdN5fM4RPRGL/gq5V20TR1u8VAYaDQcnijya13KBlgkHHoxT/yYeX+kOX8N2X5bMw57Fup+MYdjgLplnmjd2UfwpYNZjtr++8X5fo4jKAJyay09vAAANY0XwLvGfO5s3BtiuKB4ZEYmqKNAKYNnpoF3OsasyffqVfKDCwj5I2+n9cOTyRt8aYNnJledMMXIeG8dcSi+C0yDp2ZbbJ06W9hzvVKRzfa38aByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PUW5JavvxT9MktTXnC8ZYsr4wv+smDAHBREb772dqw=;
 b=VVy5tDy4yHGB9U9OXT1JG37KfKDmj5zkQdymEVW7XP2tKZfea/KeMty5mrPJo47kPRywnpenPxciOEYYE8Hc4ACzyVrhORkf1uLdUAbUzTaZqVJazslzS2x1aJxqKVucldeA5Mfh82yFZMa3YIbivxNKhGE04Z2fXr02CXt3BR8=
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:35:58 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::52) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 19:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 19:35:57 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 1 Jun 2026 14:35:57 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: Fix infinite loop parsing CRAT with zero subtype
 length
Date: Mon, 1 Jun 2026 15:35:45 -0400
Message-ID: <20260601193545.210335-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b18d68-4dbe-4225-98fb-08dec015011a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: t4BAifkpHjpCDSxO+BjNNHBxacyXl4Q94Zomu4JELUgRINUs/7ENSqJvKtts6h0M0pT0oQpMovnJvQEgrWcCKOzYliqEYsar+UxesQnCDdfLuFYNvix/blWGzOKbYToRh3FqKx7Zq5hQFmfxtVRtylNKTcS9Ra1K3eRufo3VnTWVRmdE5awFhW8JRS6jEaaXNsGGEgx7fluFHAmW414ZxgLrW+EpmJw38lq5aia7OABiXZnWpTvonJtkHzwO/hkWiQsPXO3AjaBOrVdKLTixrYgspmS3OclX8DvUIL7N6K2L1/EcYLXzyuiO30eCRK5Ip08vGNJzP1/wDlNLJYR58HyAtIuQoTZLaBtoazrSDA7+/CRoTjyC+FyDFFMCH6HiJZfZFNUw6tP5NhBo3g42JPSbL4mvLP4NNZsLtM07hecGBG8lflMv2OB728Mlz279hXD7STZcxmnJZ3Gymjtv+4I2jOioVBbip0GXP/YloWDQjt9/jlE1M6UWM7o9VlnzzclC3Qztz0f9KF264Ct7fOgc0bPf/PU3wfVuXLOL+FocQZ1ekg/ejgZ1/qMc0YYWh6BT4DIkaU1G4qRGnlGchP9JwutSF7tBA+PcOc1hsZDDNuLlSPZ9RBQC9zYQIgXG66qs5VwXBpFJbWaW2IQ6yhwIT6gTjkk3M7Y4ug98dRhG9SA/lScTQvFaBSmI6G2Lk6tQkTLc1egciqkWT9by4R9vySbmpauF8yXvIF4Gyzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZqPFHxnUkcgal8yW4i6EzoVTtnKn01ycJne6VEJdDkyZFCKwOux6XXsrtHE3LNvvDDeeBDF5wPJnfZ/SZ8NRlpHDgHRpy4QWBA/PveM6NinK+BKREX05YHzmnqUiZfaFzE6p/oml63FBBj07NJVbb3g3RUk4Hca5oB9UBE2ZBVDrgZXSrBpLNGcuFLtiX6d9qTIc6G0AyWVqC0beifPqDzZs1Eo6BvmX5BmLejMC3NUFqn20kJzg42E4XvKbY0cuB4qulqzMwRxvx/joGk58HrKRlA1V+UZGFHXRIALpMt5Q0U55ek7RcwWP//ZfSpTrQ/ftxOEmwFa471FenvP2IPjJwRkUYNP01fnk0DVPpRAd/GnVT0Us3iX4T2Y6vJ9yd4fqdTGGnHZGC+iw3wytfxQ2JqllEfyAZxFduvZLJxw3TpyD71t0I1Gty4hLXHaL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:35:57.7241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b18d68-4dbe-4225-98fb-08dec015011a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828
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

Malformed ACPI CRAT tables can advertise a zero or undersized subtype
length. The parser then fails to advance the cursor and loops forever
while the remaining image still looks large enough for a generic header.

Validate sub_type_hdr->length on each iteration before parsing or
advancing. Return -EINVAL and warn when length is zero or smaller than
the generic subtype header.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cf7b1b038d5f..cea1dc654125 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1404,6 +1404,14 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
 	while ((char *)sub_type_hdr + sizeof(struct crat_subtype_generic) <
 			((char *)crat_image) + image_len) {
+		if (!sub_type_hdr->length ||
+		    sub_type_hdr->length < sizeof(struct crat_subtype_generic)) {
+			pr_warn("Invalid CRAT subtype length %u\n",
+				sub_type_hdr->length);
+			ret = -EINVAL;
+			break;
+		}
+
 		if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
 			ret = kfd_parse_subtype(sub_type_hdr, device_list);
 			if (ret)
-- 
2.43.0

