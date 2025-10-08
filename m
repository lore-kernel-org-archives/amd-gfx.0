Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E32CCD187
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F3510E8BB;
	Wed,  8 Oct 2025 18:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHy6yH5O";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD8010E8BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXyeqCF7ogZSl3w8YHG/8jfv7Qoftv0IE6lWIMfHHXQpCFQq+sFMRDJ69G+HrNQ4dxurnpDDzDy74SltueIiA2/33m27HIq8WMtb6ULQqTU22LcCQLvNm/elitAZ3N93G+B9/OhdMLZ01KtQV5/1wPlZfVNuP4REozYKj/2Jr27l/dmiN+InI0XEGjRXawqbUPEP7PhgrUPUkg9lcKEoMO5fuD/x/w+m1Mv9NFVBXXNZeFAvVQWpUtK3YYFvjJ6ns+/A4r9aJC/rl0D6No6wXVxoKpiNhBzR4LrvrCK3sSzEusywDjehGyIXX8ZeqB0mdxMb/Y83qoDYNJvVqkP+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SOjbG1oXhb7Kt9a3kIB9I7yocTcBKb43ii4rpwYqzk=;
 b=jok6J1jDQnhU+jQHolCL9E4iDKCqbI5LSzxbve5xMZymzprSBwkEAvJy8fnSwxx5BV5y/36EL4VteqsFAm+tnAh9ihHqlfR3FerQAtM+O6nq25X9bf/j55ugUgVS4FGDoPm61eOygnIzp/7e31NIw7o+xzxBg6WQ3Wse7Lu6KOQvsetQQ+acX7QSnSZAEywBslCWpXKrLlwMXVmJ3C3qPGskqfs7qETd0Yk8ynltSJae6L5DzNvjpcmymdgb3ErVlH7Ess0ndG+yVAcog9rVXU/gzvYegbPkIfu2N09X3rIEjBbP6rdqvqwJfjUjT6Zs9AHrZNqkhk+ogLwlTuYm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SOjbG1oXhb7Kt9a3kIB9I7yocTcBKb43ii4rpwYqzk=;
 b=CHy6yH5OQkHh0fFXF/qu/9VrfLo0M2Ekysvo5sh6G2VFFXpjcL+JA7uaomikvr/ENyk7cAlMxK8AL2mSCTxLh3/6or/kpaJNjjYlN/+KRjAzm43ig3xLiQn4pRbhEZCNfYMd8k1Js8uyIAtST4Ha+jkSKGlchX7Jz3Kwlh/xGEs=
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:07 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::b5) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:48 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:47 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:47 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/22] drm/amd/display: Update spacing in struct
Date: Wed, 8 Oct 2025 14:47:05 -0400
Message-ID: <20251008184839.78916-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd0a24e-8930-488c-c5b2-08de069b5c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n6i/70QfUW3KMvJ3lGiLdYVnOVryPQZSB1HS34ez3GPexDY04JuXJiV04T4e?=
 =?us-ascii?Q?GfMexYcVTQNGhRbZsScgYBL2QLxs16BICWMWqnjY2DVRLqLSCdO2OxUAA4Hf?=
 =?us-ascii?Q?aa+SA8ARt4cnrzokq0s2kigrLzS8qLLKqKo20AdbEcYjCoH3w5UsfL8b/9Ne?=
 =?us-ascii?Q?ItyYQ48dgfc3cD7wugGMBoxGlKOJ234R1Jrz5U7bcbL3GkRtuXc11RsQNGeS?=
 =?us-ascii?Q?6sgXCDA17Xnx7c7TENRfSD5xO5xfc87GGmAIODpSFoOvBfgJvzsLG2U51KoA?=
 =?us-ascii?Q?f+TPbL03TfOFlZtUkzj2r3MfaUUWGwA22+lq5SLBL05Nk04TyWxe3MkcKvA6?=
 =?us-ascii?Q?iQjz4zVFiOvS7XJ5qM9zb8kKqEcaCnHgnn/oIU/mpVgo3Hj67w54gHcmK8yP?=
 =?us-ascii?Q?x7zamdWroar4rrj9ksWwJypRuUKd1UbbwxEHjdNC8FBibvNICaC8hqFqqppw?=
 =?us-ascii?Q?HZ45NTG9Yld+IIVf+5wagdCj3LtrQzBG0eHRbloqaZAAaNmwE6Oodu8dhNZU?=
 =?us-ascii?Q?FNcsL2nHri50zH9+7HjwVlzL2fvBOrYE2KMumwlPYkQVjl72UH0Wgs096aEJ?=
 =?us-ascii?Q?13oGknk0nHu22G7TuqpVbt/DMS3+EsOaxreLZbBqo+L8aybc2qaoH76fQ8bd?=
 =?us-ascii?Q?uTLqwtRuPUNraQgPpY30vRol8uHdPd8qFONvOlS+gDDPnjgJlurWdcwN3QoQ?=
 =?us-ascii?Q?4ZlXdeSWatxZfFiv1W+nX7QkRfwKOfhMW+ZM7iLyQVpCLzf/TgroJudUQ9+e?=
 =?us-ascii?Q?ABHovatanQtdzmJiHo+AbBolKMPvJW8+N/kFZhoubeFNCVgqf5L7G4ldiEeV?=
 =?us-ascii?Q?lw1HflCfoXiRpaL7/oR9SBFyKQWg3z1h3a6NBR6pamWnKevHehkQZTv7Z6Zr?=
 =?us-ascii?Q?/yIWjpRCbojvW1U1U/Yp7ijmHwqU7alwlUk4aLSBb4AjF7lfoRmqvtsIVQIW?=
 =?us-ascii?Q?BsLOCttdK2+HUKKZBX5zrd5fC6oFkk7KihAr/yFFQlxguBFw1T3AG7eJZVzh?=
 =?us-ascii?Q?6iKvP9k/XcJ7xnopUB1U93G3aSfBblaHXyWVDJVk/TIQ9RfHoYcnMwN2uncq?=
 =?us-ascii?Q?yZ61IkqKCm7T5KaaKM3b5Hjv7DAi56GnEqZ/PFaAzmuMWFkqRA+rGKmGJ2WE?=
 =?us-ascii?Q?gcs3RZvQo5+y6n8aqhDT+MWO0mpdHm/IX798TZxVAUXJ7fFNesJRz5Kv7V3L?=
 =?us-ascii?Q?j6wV74wsRCpNFKlQvzsIgDtSRrlxPVRxqWDfNsTFthIiSLKF5tN3zpgYJKbd?=
 =?us-ascii?Q?KJ/menpsbfnax0yZ3tggcZ79KrE62NaenjMtEMnp/EqVEhwwX/LUGx1vqfUp?=
 =?us-ascii?Q?1RfufkWrgFhgwd263TMGQ1sb+2CIJ+PlcRKEF7Xlen2C8dffEP4k/3QUC00C?=
 =?us-ascii?Q?i2mv4MGctz+IUZY+NjJBldfftpjB42ZrgjGXV2OQwq3K6HpgGR3J18bUcMai?=
 =?us-ascii?Q?875wntYabjV1++oH2YA0rBg86jqTaadfA0lwAU7sR8rE6CqmdTc1MYmooUeb?=
 =?us-ascii?Q?BgDE+VoLzXLXedYZzLPDwjfxF8Y7uI/ITV3CfrhUmARmZKinfb7xdmCxvJo8?=
 =?us-ascii?Q?VQhA1j9GfgWvlKB1RVw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:06.5288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd0a24e-8930-488c-c5b2-08de069b5c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

From: Alvin Lee <Alvin.Lee2@amd.com>

Update spacing so that fields with longer name will
still be aligned correctly (new fields to be added).

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
index 081831230821..7ce2f417f86a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
@@ -57,9 +57,9 @@ struct cursor_attribute_cache_hubp {
 	} size;
 	union    reg_cursor_settings_cfg {
 		struct {
-			uint32_t     dst_y_offset: 8;
-			uint32_t chunk_hdl_adjust: 2;
-			uint32_t         reserved: 22;
+			uint32_t              dst_y_offset: 8;
+			uint32_t          chunk_hdl_adjust: 2;
+			uint32_t                  reserved: 22;
 		} bits;
 		uint32_t raw;
 	} settings;
-- 
2.51.0

