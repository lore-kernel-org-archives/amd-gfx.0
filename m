Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73074D2E010
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AFD10E72C;
	Wed, 23 Oct 2024 04:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ueGmDY7Z";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D5B10E721
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFNpY0n3I92jqU7eHVqHwOrU+mh54BimnA0qJno5Yb0k+VqWlh3arEkfETS6Fqrek8IH0C8vvaOsde7akS9pQ9gt+ww/hssqqpoQZDRU3p1egseqaZ3PpIXmAkgykYHQQ0iV68sz8QyIAAz1VbFDSbG94ikIPXK3jq73zLj67TdZBCxM6b1VwCgqwKajVqWWKjME4srJM7+XwhGdK2VcGJ4T0fl2jNhnEV+O+d1g+oYr7cGqWP4yYx4u+mu595NEmI5Vz21g1jxByVmh7m3oEF8/Eg14UkszqdLalXgXEPGdv9UxnSoQ0isHUNk9t+X3Kh9A1NHe5axD+FMRrUpbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPr1iUG6o3QVJg63VRn0TiLKiet+wXLQpSxMAGQ+t1U=;
 b=pM9waeyKOERPExHEVhcdKPKX6JEz9dsrrRBu/TlQKQ/o1eeAhEPqtPiqisnCLtdoUX7w9uBX+VuXpHMBpWfvORM2bwJmOzK8RlrWBytVveEY24/7J0FX+qk86g4DxsoKy5Yv0ucQm3GFukahTwhZhwU5ekT/nn6e8+fR43lrZctt6gZbRwQqKuTSc8cOvVNmoB7iE16K63JA9UMXpIuNusEpi7S8UcMNbwuUN1uksNUJzwhaPBXFu2olhEGlHqjvfT2+y3Ou2oKi/iJWQPzhqEshr74SMFr6rPeUgi9AMVSnHZhHyGJc5KN0fGOHsS2jTEKfnxi95vIkgb6E9GZc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPr1iUG6o3QVJg63VRn0TiLKiet+wXLQpSxMAGQ+t1U=;
 b=ueGmDY7ZREil/ZlKA/j3Ptx7T0cYaamdECfepIe5hwCZku6NFNv9KJb7q08zNQp4rPl0eHiJaLkprll3ZJGKeLKjeC581Ah3D0OdErzO0NcA4gxJPfeggwy96vu8ycW+rRUV4SyZFTKrBLIZu1lD7a5yotY6ZiBD0CEUmLFc7Iw=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 04:55:10 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::16) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 04:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:55:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:55:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:55:08 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:55:05 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 16/16] drm/amd/display: 3.2.307
Date: Wed, 23 Oct 2024 12:53:36 +0800
Message-ID: <20241023045336.1557443-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bcbd8f-c709-4f86-4b36-08dcf31edf0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ySk9eETEU8fXAxQS8nUBnvTudrb8lMQ7vuEsREORcM0ns4J3wZ1XkDR9+RWI?=
 =?us-ascii?Q?+HWkJOFzDbmr7Ro+JWiAhMzwpQ5vDaaPulgA7YtVrogTCYnBafB6IBlW2Fwf?=
 =?us-ascii?Q?/2WyYlVeW0ghnMRiyj81vCzzR3KNhlfuc7Z35J27jqf5jgvvQJztVNtoNl/n?=
 =?us-ascii?Q?s9TNKW6rYWY+SKbBjGV5SBBVi+toiAJqxt57nAZ+OO5AUppY8UKjKnxH6QJt?=
 =?us-ascii?Q?WJh5pRSfpyl562ZZkzs+xiTHvr6deYYZ8vCCPDZYPZu/7yGV2FtLIdQO1B1V?=
 =?us-ascii?Q?Fq4liS3d6Jr67Xz+Zmke33z9RulmEnaNhpp9zPWTYTsBQ2QpNsrOMlfufCYk?=
 =?us-ascii?Q?lB4vnDAu1EGGnIFVbj0LB7EpsoXb/j36X31kDjyIUZ/KChaIIIkg4v6HijdC?=
 =?us-ascii?Q?6PA6SvRBjhCyNaS7tGylAY2ASejDt0E1/NKZ+XBpto8SpHG/dtS/k4/rjmrw?=
 =?us-ascii?Q?CdtIo9ro+/yudFNRNyC9FeiDybxcYmhihqX7VkgG11DtLVDjefST5sEkcaFC?=
 =?us-ascii?Q?EvGyErvH0ZxtNw5I4YOH9egNeBPEQpvnFxYkvxRIpSKbh6W5VxhVzWEZSf7p?=
 =?us-ascii?Q?kWACmGln2gY7oXoyBlsYn8idcFPykvlQvkv+wKIGMrc5wtc+PaWH5wqklLCZ?=
 =?us-ascii?Q?wWsuRxoBdjJZfP0uSrHojagrRbMadgpPOWEmH2+vxDRQ1cfMN2O60eNicP+q?=
 =?us-ascii?Q?nc2vmtJ237ayyJu1DHjz+KO7hF0Em6EhzCHGbrzhXhcfc01626q3ZD4vvf+2?=
 =?us-ascii?Q?xTGXLlusk6X5vgcWDML0kZw5DP4+RcEECuWaqc8WHh6RknevdOI8D/xI3CgH?=
 =?us-ascii?Q?ungtBFoj0+CGtmSFFj61Ivc1mBO5k/q9NAAOZKdchrHsPlY6V+Cl7S3k00lV?=
 =?us-ascii?Q?eKCXumMsLfy4em79DimeAvVpqNC0ntClR6H0X/iyzRPmTPP4+HircLo+EEYr?=
 =?us-ascii?Q?6WuTW+H6Xo5r5AgOFNKBWoe32ip5zphemBnT+PKG0plYM42NBvhvj8vxg5hY?=
 =?us-ascii?Q?DvRtCroe8eMYG/Xa5B9C/4qdfUHp64FN1XaskanlRQFYNl/H+oHmV8y2P1qM?=
 =?us-ascii?Q?DkW2ftQypkUHuigdKuVK3R4YF6cE1qUsdG/God9QQkFMVC6RX4eYeWuksp59?=
 =?us-ascii?Q?mH+YyK6/tGoJbm6CQoVqeDGFQUrwKCRfPF2PgY6qDQhNBn0hKjhzf163+1gQ?=
 =?us-ascii?Q?83SqVx1/SRiZ6B6iGm1DvN4jJK/2zfUgxL4JuiDJVkokG7u1cSmaXIBVpOcF?=
 =?us-ascii?Q?TeVO4tsyKmKUikUrX+QcbGamvkARBRypX/iVLZu6FkMNycy51UXAQs3bLjLs?=
 =?us-ascii?Q?51lhuPCjkDH+zB/ASHL/6INGj8Zn2PzE34/5H5zYew5QNyml+Jcqim827BHe?=
 =?us-ascii?Q?ObSmccc9bDZ4dNiHwyxZwbc8e3TsHXl+SjqpF6BopNB21230DQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:55:09.4964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bcbd8f-c709-4f86-4b36-08dcf31edf0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix polling DSC registers during S0i3
- Fix idle optimizations entry log
- Change MPC Tree visual confirm colours
- Fix underflow when playing 8K video in full screen mode
- Optimize power up sequence for specific OLED

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 412cdb01a61a..72adbab589f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.306"
+#define DC_VER "3.2.307"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

