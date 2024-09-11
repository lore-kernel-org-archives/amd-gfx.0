Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C696EEE57C1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF9010EA5A;
	Wed, 11 Sep 2024 16:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fNmf2rZF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C65910EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqDOObGPT6I8AsUEwyZmRYbDOVcOrcqaT/JWFT0FQrZrOz1sw6XPvv42WbsFO3TjtloJNhh5lhNj9FtHPU93JE6rhfem/jWBCRotY7I0m9D5eDhDCxrrxPQ38gRJNFnoXiOVa7h5ocKht2WNjnwBpESWk49DhG5LHkZUUndjkK2qP12rN6YgRH9t3d9BuEsjteHRj+VAYMk7A8DFr525+oqSv0d24F53IlgxJfomkWbVCRH4XhzlruRPg70Jp4q6Owtv0vVpsC6LYbr7STmWgPrMoQQzqMQwsbl5coc2R+/qQkGctk3dP0CTD2UfHQMan+DAQ8G6BV9bTl98k1fqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWH8gzS6poTgvZtdOeXeoRjkHlwaXOK+xeWRLaV8kzc=;
 b=JPAOvzjUgaXRfnyxgaJaqcDcF6lq7GX5cY4F5aA7ZlSvhU/55ol+DWzZQBFTxkliBnq5f7yCKpIT7BNiOYdcXr5wsO4eAh/0Wvqxm8m6+DbdW0KkiZxPMpeEvO1A/hvPNvfYNCDVYuh3emQVwjaeGo2IObPcnv3BHMly6BwIkMBbeYbCAgi/t7tLA+iEji81dy+5ij51IgdrKQTTvqYeIfXUa/YPXviQjJAy3+kNF9M+WfnxBRopzm6MhB4jD02W1uWLL3fVQzzFZUjpQhAqMFVvvz1qAohX7shTuzL5nLXFuqImx/uacyzlpbAsvlGkPVW8iWMpli7Rto4iGww/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWH8gzS6poTgvZtdOeXeoRjkHlwaXOK+xeWRLaV8kzc=;
 b=fNmf2rZFL1R9KanR03SoPe6fz8uHrjuRYCnhWO16HMaG8v26t9rtSEvzhbtXsO1TbiGhlmLNcNploR/n5K6TimhDsZZ5xZy/C5qvxz3UyplrxraK77FN9+K2/InndH1HxWF97YvoVSz9+zvgJsA3BQXUAgxFEvSO0kTPTXjYHAo=
Received: from CH0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:610:b2::34)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 16:25:20 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::bf) by CH0PR13CA0059.outlook.office365.com
 (2603:10b6:610:b2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:25:20 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:25:17 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 16/23] drm/amd/display: Check null pointer before
 dereferencing se
Date: Wed, 11 Sep 2024 10:20:58 -0600
Message-ID: <20240911162105.3567133-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7e4a82-d5db-429e-0b99-08dcd27e545d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X/sHWwRyUaEQA58ngGwsyJ2a8KJLU8ejAlODSphrGxvVJBAdATScLmS4uce5?=
 =?us-ascii?Q?LSVvFEno7VoLVWf1wGBbVha5rN4LfgbO6j34pwg5Q7B9AzG3NG2u6WTOKbSN?=
 =?us-ascii?Q?BKWyaGTpcLZ/rp2xwXqfFWICiBQIRu7fBZF/iKgLDH7ZaWC4MyHbIFnCCFqb?=
 =?us-ascii?Q?vHgZyHVZ1IrPdbhP6DfyckcUdpfigA26x0BRNi+MX9S5aF2fOQpnRaTNhY6z?=
 =?us-ascii?Q?zMubwd2F85b72gJBEwPZaWgzF+Exu/BJMX2tvki+2WWBHJns/rbZvpaymZmg?=
 =?us-ascii?Q?QrxKllV4F5IWYuhqlKMV/wdfiyWHnNnIrbRy3m2tH13ukq1ZqXm4JP0saWv3?=
 =?us-ascii?Q?gHzpz6ynhJFBkktyJ7fmxfDHh4kEmygb0WHMkCtNYeolv8vCLwv0jqbb1Qw8?=
 =?us-ascii?Q?IE0E4uk7trxhu5Cgp/MzbOq3WNTakD5QpmSxRdvGSZPi4v54Cqz2RxGTOIXt?=
 =?us-ascii?Q?Gx/+/9nuleC3oAtBOQr+wqzRJm1ghq0E8ueJBEHpmZmKdbF0M/epPVuSwgEy?=
 =?us-ascii?Q?MC1bUgJTJQwiEyXpI1Tasun8Hm1qyWYEf5Q/xYlijK6l93nL8uQK2JfVpqCG?=
 =?us-ascii?Q?OLwxpkr0+1NV9RrfoJppfUMEU7F5USEy1nbWgFl+Y4wBnmYyDsPG6zqT4VZ0?=
 =?us-ascii?Q?0zMLuZFSOMSv9sFrI67STqr4WMXojOTrm4VD09OWktpBTExXSG/Hu6yXT0TX?=
 =?us-ascii?Q?e7LZOHXY9SWmMUztNhj3ef1Sbkcx5bLDgZqalyf2IEdMWH2Dr0qC8697jgGK?=
 =?us-ascii?Q?ljXSP/7910kUPvatixgvpmEIHIzWpC0CV8tRVBZXH4nzxijrkOOESjt/FzJZ?=
 =?us-ascii?Q?Jed0XcJWk1Eizo5or/mmzBnLmc2dPcb2gG5D3XRSDq8jZrzba26Vy6rCLHLh?=
 =?us-ascii?Q?RfzYvzwuFoWzM+scJsIEUFDXsEMeGvznGKzRPV2w2Ni7ULMBXoqjkwwJeZFy?=
 =?us-ascii?Q?c0HdtKzkhiKdehzHXWLzpt4M/qvJHCVQPtNGi8ijKSdKKfJAY4Dql0JLA61r?=
 =?us-ascii?Q?C7pI9QlMg68ygr/cNd8rmxmHkioqmSaB7jos3cleZjuQx3+SunZBL9SC+itI?=
 =?us-ascii?Q?hFahJil5FPxodPsVGr6HVXwjXurNvfZkIzcQN96DDBCgmu56NTNm/6veyNn+?=
 =?us-ascii?Q?ptqaeyJ2rq86xfYOq/hNqEsqouHpIhzAyARcquc2PKsHwO7zKKbDPTdJe0zP?=
 =?us-ascii?Q?WhHGh6HOWB9f3TSOPaC6np4tkWJdmBBzTIn9yRyHQbPIcXn/uWqjYrNKJuup?=
 =?us-ascii?Q?V++/HjQndHMCWi1YX7IFv4Qmjl5Qb+q0xgpKJ4xb+hIDPN7Qirl61nhJvlG1?=
 =?us-ascii?Q?iTDXZ51VUgmNxLWAoxvyBvHEHc1Z7kDniEjcQwc+OEFHZV6UMrQXQa0MxGHQ?=
 =?us-ascii?Q?mXAeJerTvKWLY2rSpuxXuS0c+dUaPcsiw1mDLu6Li0ungN+BnumPEP7KL2jV?=
 =?us-ascii?Q?zvYeGUjkNFxZJ0j5FcaI3mUCqXs5yaVz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:25:20.1926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7e4a82-d5db-429e-0b99-08dcd27e545d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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

[WHAT & HOW]
se is null checked previously in the same function, indicating
it might be null; therefore, it must be checked when used again.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index eb7c7681bdd9..67812fbbb006 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1767,7 +1767,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
-		if (!se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format)
 			return false;
 
 		if (!se->funcs->dp_get_pixel_format(
-- 
2.34.1

