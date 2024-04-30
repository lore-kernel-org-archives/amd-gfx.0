Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F146C19F53
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 13:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080B610F583;
	Tue, 30 Apr 2024 13:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WGChJrmG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB13B10F3F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 13:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6NL9fkxHy+PJIFHguxa461eYtjFdda/Uzfifc6rwxTRw3/SQnatzglGqaFKVpC4JA4urBTuZo5qxZQf5CmyYxucJi0U3z5vhuL9ELSxnmK6Mlf9F1Gs+1NYQ3ES1neMpM5iDF68z0j1ewWuZTI69CwwoJclGsdqRmuX3N+yj77iW5Zxr02Xq305CbEqy8s1s9YacNDx1rd8ta/k+FOb+6HD1i3UlHVR9sLijGEeMXF+hAaR6BTG3JQScxCHk/UcZcZQciIttDYqHxXUSPT2lsmJKXly6TI4wa31LbgONBAWToyAM0OUEzXnaqwNshsP2GcUXXH32GRltqRvq4KlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nM/rU1fKEJlXUJTpUAfd7hm/adA0TDZDwIb7c9dcJY=;
 b=YcoCHm56Tzw07nBssXI37L5RDfMA4X2g4/AaM9phsLhjAEf21ZhUiN5ZWuY0/Zm3dWC1gecNEu79LlrqxRBPgmD4aFqccYJRcktGAjpC1Z8WdPRgH87gIeUlHlILohPob389q4rEnzKDnOiyoSJd9ELh5DVLKmhxMti2YPpS+UTTjCCD+CC9DCQQemeneotgfAqnyvFpFmzpGiGIQaj5djfjyjfIx9jbYfWy8hidCBbtQpdxoxDwoeP55G7wi1dVQVuzXSQ21LgZdef9IZzH5fufWpJJaDhhlSO5pPml9ft5q85SbS9jaySsOySriCU4C+GYkM4pXWQFxIBxpSjXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nM/rU1fKEJlXUJTpUAfd7hm/adA0TDZDwIb7c9dcJY=;
 b=WGChJrmGwXslBDDvUzCxjIn+1JmvPiTFxZZa9dBNarqpjjTVGR9gcww7P82GV2azPdT8qp96ygeYVxklbWb1RDpcVN+X2hDzjWIQFzbofDP0prbKStWzpz4Ee6Dl/tE6R08vK+OBDGB0wD1/z6kwrS/8SJ2IJGd2vUa2RU+/WU8=
Received: from MW4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:303:8f::24)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:43:12 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::6e) by MW4PR03CA0019.outlook.office365.com
 (2603:10b6:303:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 13:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 13:43:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 08:43:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 08:43:06 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 30 Apr 2024 08:43:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: Enable DCN410 init
Date: Tue, 30 Apr 2024 09:43:00 -0400
Message-ID: <20240430134301.18555-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 6990918a-60d1-4345-ca68-08dc691b7a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LBg/e7mcbXLkRDKO7nGVIxQTaCR6Lx6VFRx6enT1A3RJ1UWs593TpQ+IMpvY?=
 =?us-ascii?Q?w/hO7peignVPwt85iLxv31qoICcD4G1Q/RhXRjnhKM8vlAnrbXeqZmo5cLeg?=
 =?us-ascii?Q?hPQlu/0tOBophkXnvivk3Ar4GOfbJ8Flcrp4nAvBYiojHQWT3cAqQ9T9TMAT?=
 =?us-ascii?Q?18K3OLRiKx2BcNl2qfvRKYzBKiJw8pToVPe45BF5VY0IDd0qXDcXhlmu1QZc?=
 =?us-ascii?Q?gbnu7PJ9fOR2t+uVPhE9p3QHsZIFCYgpZBKw6fHZg8p/JEvpvOSXee/2yeQg?=
 =?us-ascii?Q?c0fE3zTVLAH4cZaAkXHf4/696cEIYJW6khag8tXp+/gfFbgGlw7vLiGRIwF8?=
 =?us-ascii?Q?YdclHAPcQM4/WPcxlQxdciZSMgBFMPsfKWbFxBDc3scql2PWIBGwdwgN6A3A?=
 =?us-ascii?Q?lnovlklBLZhalm4diUaC/8MWjkvFKT3pRYq2ewZFfJs6fTqL/H2oA3gWvJ07?=
 =?us-ascii?Q?TObl0Izm8MrDBpNU4YFCZ7VhOrvYtdKKe4gt0dzj+rcrTOwzESMQ2IQFtlMr?=
 =?us-ascii?Q?tMEGwth8CAYUiQyUI0s5Q7MOmeJE3K+bfBGaLM0L4Dljb9SRRJmWrcgvEtsJ?=
 =?us-ascii?Q?YyuasoIIjukhgKmsxXJ87i02Ew2SZRSCaENya47Px3+DnhLUvpm/Lr84YW7A?=
 =?us-ascii?Q?qazuIjBG/sRCH7zwXKd+Aai2D1X2JvoL9fJbiU4QUmZyixQGcY4tdgH3v33M?=
 =?us-ascii?Q?UZ6JzEUH5fwhB0oyaYje00dcSRSfEEZBTXF+9x72lAd73R6kJW9g/mODz+Kc?=
 =?us-ascii?Q?OnBmJ4Qy0NEPbwLSzcUST1N9l7ncGDJOe2HXeuv/oo+7rr0ffmtt8rwx9V6j?=
 =?us-ascii?Q?YYMx5iVaHvG9bRsTvNikiTYjXGqcKM/JveL+/6vVjNSfgU0Tmd4u+NRH3FpM?=
 =?us-ascii?Q?2Bwa4axNLJXgC+7g/oiF+B0CJr6MM+V9e5XlppzOI5Q1bfAbhUAocKcEHq/T?=
 =?us-ascii?Q?JmWWtDEIUJ0JxR97xTH8yZMks51a8rILeWaocb5I3glyTwcVJERNdRLClZtB?=
 =?us-ascii?Q?vvYlyDcSLXf6qkRV4hfWlq3BFp5Qf70kXIO83TkSIoMi9Z13Q5+Kp1wQy/Wh?=
 =?us-ascii?Q?Rhn3suOGxe0rTnbk/X8cFDlM+eyuxSvyrwhCPO1wRlPLfutumnDDJMYCWnGB?=
 =?us-ascii?Q?8wusCb/y6PehIJOxYpHrlJcBvI9fz/9/tEej+E5liU+/VKzIMOIyMzS9+FK1?=
 =?us-ascii?Q?23mQe0DrS2bKse84iDlTZHIxMI6ALpFffEaXm1oVaS5X06yD2LddTWFF1tOF?=
 =?us-ascii?Q?WWH8v81hsA+cT5uo/BEmj2R/HGBt4IqTvNh93OoiSj1sEWGUb1D9T4KQYVUA?=
 =?us-ascii?Q?s2bUSKRagr0t36nFHgmPN+7G/LT/9PFpFdDq0z2HAKHweWq1TGY9sl5EYEBg?=
 =?us-ascii?Q?YoSiwz0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:43:11.8171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6990918a-60d1-4345-ca68-08dc691b7a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
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

Enable initializing Display Manager for DCN410 IP

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2aad1ba0ab9d..d7f948e84e4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1965,6 +1965,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(4, 1, 0):
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
-- 
2.44.0

