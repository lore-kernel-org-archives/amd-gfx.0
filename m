Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77504C0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 03:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2742810E733;
	Wed, 29 Jan 2025 03:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RF/iNbqV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552A510E733
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 03:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvPGND/x7huZZoKJWYK7bk7XJDmU2oORTaA/wI9rNy55njRSnxh7dnETiJX5GFYqwJz7dQVjQ+XHKFwW/q1IU9lCpxu+U5uJv/GjIMiUSJ94W3IL6fP82QepZL0ltoBH9+/CIadXv8KHp8wqoaq2NMPM/YSHm7JVxUqG1lGPAbxpm/eafWF3QUrG3rOJ7ba+fiQuaUu2eNOkUhbid5lyzcZYOv61O2unb85hi4U3V+Vev/jVojyypGdBFceZ9G+lLFo6FlDEJm9skhPQrjZfnp47iOLEdPPrFB2ERNsOXtgoUX6wjgngzJSzohdgGqdKZy5fXEYyhl51mZe7RLOkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXDBSYu5fuXQQqtHkIIdnnV7SfcylLDeoM8Fqo1kVEo=;
 b=OHGKpyPhONvFjAvQr/9iOVYu5Q/ZxGa8jF/vU46qHUe9d0oDElq369jfKXyEcEnSCoMHGGbjCdjXzbzNPGHTj+5nOg7/a3cmIpqTWCZdUiGIXHaxUUe2eTuJRLao2Bq6UuE+aHXs/Z76ys2n6ABKTk6AMAdXhGHBHm0VUwuDH12Ybmbn3/468t878TyFbhWarHilObjsC/JhSDkIjH0d0E4clTZgBUkluFZRInDknGSp7sV8ws45Vr0/2XvzuI9F7kP41HhBH5+Jdd2qebqnesj0P/do8KxlN8ONTL8c4hQTqe7mCqqUpFDyMCM5BTGCU3cFM082lbkE30iFx1grNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDBSYu5fuXQQqtHkIIdnnV7SfcylLDeoM8Fqo1kVEo=;
 b=RF/iNbqVaisZjgpXo2pPZU/rImPxj9hTHtLKVdbWbFTiQBr8+ukee+5Ku5xQsBnhIain9ZiIsMEzJ2cKij+3Jg7jVzNpdMJTx/UD+sfevhu6OxAGWJRooDbvDB/tcVufImmsjUeXEqKZ1wCrSrfNWYFb3Tl0GS5UpmQCOWmPSq8=
Received: from BY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:a03:1b8::27)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 03:07:10 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::21) by BY5PR17CA0014.outlook.office365.com
 (2603:10b6:a03:1b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Wed,
 29 Jan 2025 03:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 03:07:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 21:07:07 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 10/10] drm/amd/display: 3.2.319
Date: Tue, 28 Jan 2025 20:04:49 -0700
Message-ID: <20250129030453.2129085-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129030453.2129085-1-alex.hung@amd.com>
References: <20250129030453.2129085-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4ba970-efc3-49b1-831d-08dd401205bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8u+xzQsbYS44IhDbKS1MaPigO5HxSrJTYHqxbrezCwcrF5XZL2hSnzWwYdZJ?=
 =?us-ascii?Q?aq6XeppiB4jkY68KVU07CLAs0Q0+3JtADqJPRhL9z2oBPzjNrWPVPtMCsmRA?=
 =?us-ascii?Q?ba2ZcjGMSm7YyjbSKlBua8VPCMVEDWpbt9GOecqj0ZBtoQ5IcUsg0DE2+Zsf?=
 =?us-ascii?Q?fYwUxmI7RLnvnXi6E7T7iseSWquA0saq/mwcSBA0uzvIjOB9JNr5lRndw1PL?=
 =?us-ascii?Q?iQ4Crp4qdDOEFvsLMuJxzVj1HYF7rzvl7EtiMyKN5GEM1MtGuEInbw1G0tDz?=
 =?us-ascii?Q?243adC+gFf4Oxk4AQmLE7PwsOCE8cFLcWT3to0ih43N9+vYH0nwnnIZUA/Oj?=
 =?us-ascii?Q?Og9VKRwEvnlnlvsa52jm5SvX3dAP+vxdxjYZIPc5tuKh/oZqtVs7n/Gh0JOh?=
 =?us-ascii?Q?m2nDkXeID6isWkly0+cKO8jAGXpf+IJ4cqLvWaP6SO35jM7sIg275lpZOgAz?=
 =?us-ascii?Q?p6QRnu38rA7BVlEZMTu2AxckgiW+KENOnzfJGLEvwhxoOMx6yGzfuN4+pB7Z?=
 =?us-ascii?Q?6EakWsmFhGsAjoPmtytdrQ3y2IMUVXwcvRf2x20msCX4z2GEBMXivxorbqPw?=
 =?us-ascii?Q?KFXnBXM0duHuvkxpdncgwSOq5GU7KYhGJT06wqM98T1vS9KDGFUQjcI0bllO?=
 =?us-ascii?Q?y6ScKwSULPXOSzorxSV8wxY9XihgNkr3yihVLrOm60/yNrX3bgj75YdQhnwc?=
 =?us-ascii?Q?GNewGSR3W9ay8vt5bB53Sh0rRx+/C1YLt1r5Fcb1Xi/BWERbDZ8qYC2zjs2B?=
 =?us-ascii?Q?sOxAK68yyeAWzHwa7PrwZ3+CUpA0L/EuTuQ9jF/4FfLNPtA0FabMX8w1q5iN?=
 =?us-ascii?Q?/mmpwKvf8hpFshiKjx9YqLKXALPXDGxEQsBkarItAH4aEnVrSh207gnypWtH?=
 =?us-ascii?Q?Eh1echgBpNcpQVe3wm8r08axeG+VrXffDNynrAqYsH0S+cvyAPa5btY0hvyE?=
 =?us-ascii?Q?ZiIPmb+Sou2jcn/2Q6cKAyrxDIBKGk3NTLAGJvIrl/Bn7LN9173Rdcp1ggNp?=
 =?us-ascii?Q?+7v1qMEwSxKZj0+zOzkqZtpTOa9V5OZX9uHOcVbTAwap2nKpTmbkr7oOqyXj?=
 =?us-ascii?Q?3JfsYJK3Y8YjSu1ioI26zMw+xv4pO7E0HfGw4B03EgrIkXptS/8ZcUYnAPP5?=
 =?us-ascii?Q?ViGkkfMNMo2cK1Z7oIDIa3SnSIpzb08OrG8ivMP9eFCnDA/2Z7KqOGMvIb53?=
 =?us-ascii?Q?irL5YkDW3Q995djpAmD7ZeYVk5k+hhtc0yGCkOCSJcEBFSA65Kwbzo3jIWRU?=
 =?us-ascii?Q?KjtE/dA7OSMqoRhj5gv48DnoWw3JhlUzZjcTfGBQj4MBm5hTM+XJCZM9YywH?=
 =?us-ascii?Q?C0lw9/eG4/UENBxyJf4y1SqPKLLu0AXVw45SQHg/26FTNCewa2G/DFpZ78oe?=
 =?us-ascii?Q?sbMpEtODbYoGbMlpx+FnpUebb4nKL7RHPeChwh110mi6MXS+xIe+jMaGxQ0v?=
 =?us-ascii?Q?dPCfzcMDJgI7KQBlCt9kw2AjzAMiF6zb3lKKGGIRAc0phu5zdDsEN7diYIAD?=
 =?us-ascii?Q?vEZUxxOt32eKlOs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 03:07:10.4679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4ba970-efc3-49b1-831d-08dd401205bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

From: Taimur Hassan <Syed.Hassan@amd.com>

- Move SPL to a new path
- Request HW cursor on DCN3.2 with SubVP
- Allow reuse of of DCN4x code
- Enable odm 4:1 when debug key is set
- Fix seamless boot sequence
- Support multiple options during psr entry.
- Revert "Exit idle optimizations before attempt to access PHY"
- Fix out-of-bound accesses
- Fixes for mcache programming in DML21

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9ac299fb1034..e5e4cb3d0a0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.318"
+#define DC_VER "3.2.319"
 
 #define MAX_SURFACES 4
 #define MAX_PLANES 6
-- 
2.43.0

