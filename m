Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467C4C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 05:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6342E10E076;
	Wed, 26 Mar 2025 05:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QfsXDQwC";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A42710E076
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 05:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNWgLAx0Vnb3h1+O0LgHjmPMZ6JHFIYzwmhiclFZcgywL14OpESu5ayxgYHDuG/9DlkVJfsOyd3VIab4DmG4WoRH61Ag/475TLat4PR8igMR0xvzr+QKK/QFb8i2GqMuyquVJSJblYmvdPwTmFd5PMrRmJGQwGypXNW01HlFzQGNPMBRj1XPz+XWaUYcSVTXGhHsVtyq6zrTFtjBQlbFQSgg6CmEh53Yiw20w2qaLW5/Yk7NnvkiiBbWzk3YDU9eJ4edo3C8VFUeF4lumKvRTK7iqoQ2h2alMmD/elHigQy0Qu3wpPjx8I+BgskCIqhGVnbiOW8bRoWr2cfv3+IzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yIaX0soIQzERuyk9jqjpCJ/3x2uVeKsueE8xrK2i+g=;
 b=PXQHJR+Gh5xO5ZsicNbSLXGdnEmgKJEGhyQf0hdykbobeAm849tfbT12e1Pw0nRHQIsEWog6MdXdT+eUogjjZ9mIm40FdLbeBRpu7Tgb8rEIz2Cdun4GBm3/Htga+cYLu6C4O7lYuPYLz16KRTrX88gf4TUZCTcnLrLddLoZP9EA1O3u1OUoQaLIkGuhqAjOCmB9fHzUqmX4zKmxi/Y0Mcd0CSk1D5kjp9ovgYmu3ATkh3GDV6RrmEN7AJDgs9vjSNHgJpJnKXFDwqk68FHhGcUQNa8DdySpkMKUF8U62LdEW6jfKwJGDyG433qMO/Ne/BYJ+B2/58g5aWl4SdzPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yIaX0soIQzERuyk9jqjpCJ/3x2uVeKsueE8xrK2i+g=;
 b=QfsXDQwC5fROaAbdTmDfgl0It7q2nk/+UJ4D/6tTt/JhDElXk8ezjNTb5jF8mX+UOlO3ES4BIaaJr9FhTD2rtYyJuX5NE+ah1Kp0KycDv/zGyQblp5/SzbXKjTiUTTGlYj0Mi4ICQMZoaya+MvRG0Hi2qfCLWUlMiiM61RxNMAg=
Received: from BLAPR03CA0091.namprd03.prod.outlook.com (2603:10b6:208:32a::6)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 05:44:49 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::a5) by BLAPR03CA0091.outlook.office365.com
 (2603:10b6:208:32a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 05:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 05:44:49 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 00:44:47 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] Remove unnecessary firmware version check for gc v9_4_2
Date: Wed, 26 Mar 2025 13:44:25 +0800
Message-ID: <20250326054425.796945-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ee86b8-3c97-4659-695f-08dd6c29529b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZwMFfVOADV9dTUtcFv6LkACqqP2/xBj+W3Z2+KdxdkNEJ5ZbmaUvNpD2YTsJ?=
 =?us-ascii?Q?rpvw9Q1PNO/UD7ADl57JnFuisU6tTuD/kb0GiQsoBABHZ1CUaPjD/9RwDmkV?=
 =?us-ascii?Q?URV+IrUuW65gPYe92SOgnHqzsQzT2yEtjACvFOw4+IcW9Ye78cbmSn0If3EN?=
 =?us-ascii?Q?bU7CSqSLAtr0NToSkDdaJuW7YrxVLj6oBxvOGJA8UFnSLo3XQsO1cikBfFTj?=
 =?us-ascii?Q?W3ClK6xuYltp6QgHeGShIwNUBDbFzPjEBjMZHEYMKJxfH6U6txmNmnJUj7Ti?=
 =?us-ascii?Q?k0D9CnArsg8wRsDvhheGwi4bG1duzELVsDR7L+ifXXO5H80a1eq8x9PSE8jT?=
 =?us-ascii?Q?QBVUW7gIlAzUKfgushZla3LppkMs++TqJDrwPrlnV06Atzu06wDR5OIuBuX8?=
 =?us-ascii?Q?o3myUYKwnhBBOAAGC3Y6gO8heEbEtnl8YRUPiTvijhEvEhD0VgLUep4gL2nE?=
 =?us-ascii?Q?9hnjgFZHWoUOoYYB2QtPMg/l7JsZS5inAhMxTS2Q9VGJW39zmIFPOSrDx1rp?=
 =?us-ascii?Q?KwYfcKwODE4nkDvVnA4NIF8vTQ6x0xnJzPtqY+bKMm3f9Yz3yfFKHjG7cX/3?=
 =?us-ascii?Q?YG65tcdDBRM+OLVbRSoOrt0C5tfY8UXRqsEhiosnMmui+2kkPMMSv0BXLpJC?=
 =?us-ascii?Q?7wdbxCaq0p5aVoebzCo0qN/XjrH/DRfOKnhHMDY8JqJhF9ttTfvFfEaa1KBG?=
 =?us-ascii?Q?C2QWwt3ZBqguY3paiaG2rwH4WdaA+t5EPpLJM//j/fMXvekebwN/RPKCQPPU?=
 =?us-ascii?Q?YhPFWWfui3nVJNcXeJdL5qfM9oe9LYcdFq5tgBawj45H9XBfIbOEv6IvGTjA?=
 =?us-ascii?Q?hViiAX0JB1ZubHGHYDBeY7KWIR9Xm4p98o30vJXCoKrmSENa7SFZeA6PvPc/?=
 =?us-ascii?Q?62XSj/O1ot8nBUR/zshN1BiMwwPYr/qYoDpVGZZ3IPwLcOewtNzdLmJOYBtp?=
 =?us-ascii?Q?lp4UKP8STp4oc/KVvnfLTRnGVIcXPBrvB8Kb1YMgfnAnaOyicfHNngJ9F6gQ?=
 =?us-ascii?Q?/iUxFHixC2Ev54rEwPaauqqz1cH5Bp62NQDZzV1CV+wZzS8eOrVp7Pt8R626?=
 =?us-ascii?Q?w3s5w2s5ZnSGEttwy6bPF3saKAgHTyF97X7N6IrD1T9EFce7ypVkyJukbTBd?=
 =?us-ascii?Q?hq6sfZJcnMbHkJUylo7OMKuIELN0oeh9F2wxG9Yvcdan6qhrZhnlyQnxc6Jn?=
 =?us-ascii?Q?4+61g5J76R4ZOrdcnbo227fX5F/sDN/6RdVwgVQBiC7Hm4ra2q+8MD/e1gdg?=
 =?us-ascii?Q?stGNaWORS8w3PEsWY9hZQ2669IV6kfXC2/TnfGObEvdyutsrL++5bLuHa7f9?=
 =?us-ascii?Q?jyHJTMo3UUx26I1LrumaoFgA1ptc51h27nKhLsmB3icX1F3GiolqJRsSy4sb?=
 =?us-ascii?Q?Jakn2haJEl4ojQzp2r7S1CChFR4DpNvXZabmtNQPgb/fuoxp/x4Y2vMEVA2N?=
 =?us-ascii?Q?jnam8j07z0YENDQPyGcXd4PmXmdadulM2Ni86GEHJ5bc14gU+2iF5lrmK76d?=
 =?us-ascii?Q?pxCfXQNv3h+LY7I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 05:44:49.1385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ee86b8-3c97-4659-695f-08dd6c29529b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679
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

GC v9_4_2 uses a new versioning scheme for CP firmware, making
the warning ("CP firmware version too old, please update!") irrelevant."

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5bf9d27d1ead9a..1a072362855315 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1269,6 +1269,7 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	adev->gfx.mec_fw_write_wait = false;
 
 	if ((amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 1)) &&
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2)) &&
 	    ((adev->gfx.mec_fw_version < 0x000001a5) ||
 	     (adev->gfx.mec_feature_version < 46) ||
 	     (adev->gfx.pfp_fw_version < 0x000000b7) ||
-- 
2.25.1

