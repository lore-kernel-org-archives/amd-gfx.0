Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BD7C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9BE10E64D;
	Wed, 25 Jun 2025 04:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5WY45K+z";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF5810E652
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGpw+TlIK7IkafazpbL2qx/MY96AKR5I60SfMENNQrGzntMkixMr7eZv2Kot5dCVQQ3zeimWl1SVDzSDxaoszS+Lc8L/aQnwHL5IGF1CKne7Amtl7vCUa6fTklb/kKqBVoJsNMpkr/x4MjoVkaZMpo9o40qAZzqBuaQb2BKHGQBH+OCEaGX7EUUERpUaOQ8j+sR2vcLbf3Km+5UGhLy3s10pPFaCmH16IudnJ5yfurOcxnrHUiBk7MkZTi5HShnQK52PyzwXoc3IY7ZusKQpIzhhC9hraSBe9ijAJTDP61248cZO5vDUMjC/QcUDGxIrEk4ZPe09rSNglfjoToH9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vrh6A6A2DUDmgg5QNo3k+WJMwDpbin5zuybp/yR+VAg=;
 b=DAwtC28DgnQ7JN/glCIVCPofshL+avKdVB8LWw8Ro8o5C5MiWfuxjlyvcO4/DGvYTc/rUv51PrgF4UslXxn8VnF69H+YAij5N1xTWgc1yuYefyS2Se/upoXkxOB+aeZgwVptFU/HRS68ZI5sTb6jWi74ld8j+QZQUOKZFx/WE0ggwtRxsuHru3aTt1whLZHQEG5Hs9MC/STJM4UckSxD5OuNiGC29a0e6nvMSRyN0ldcPoD2DAj4Fvc5zi7nA3LFyns7fyIncLW9emQW7nrLYplnmfSxletz2hkHzF9aq5FnoBxWUtsGlUgmzHwfKkQI4B0/CbKWj8biFOB5kpcshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrh6A6A2DUDmgg5QNo3k+WJMwDpbin5zuybp/yR+VAg=;
 b=5WY45K+zGZCOh3UYr5tJPH28BvBj5BIWu33bkA5nzBd/EvsPhZwHGSwN6Vwh6Fn1djlbgw4cWn9tZ63RJkeEeSXVfTRs3ZUliB/T6YQ7CE9p3wJ/4O1XQ/t4h/0RmyIv5oXcBOZqV9GsO30M/gYK+rqtKkibL3IP2QTOHI2DCx0=
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 25 Jun
 2025 04:05:18 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::d4) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 04:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:16 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:13 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Peichen
 Huang" <PeiChen.Huang@amd.com>, Cruise Hung <cruise.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 01/11] drm/amd/display: add null check
Date: Wed, 25 Jun 2025 12:02:19 +0800
Message-ID: <20250625040420.886013-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 717d8fe6-3d61-45df-801b-08ddb39d7ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cwEH8VWa2/DfwUOgs38cpIGqMmwrwnxmDRrbWsk5lRW/nokwOk/COY9wkQ+e?=
 =?us-ascii?Q?MUB4yELJiEHnaLGlyH1txQto/eR7hVlAXmusF46wdRWEyA7UFjVB/AfQbv1i?=
 =?us-ascii?Q?Rn/Cz6ymcIC4atr77WtQMiipkpvMvPVl6UJAxFs1gRVR+SS9QpgyU6JonHxL?=
 =?us-ascii?Q?5ktF651pq0SCNL38WSGgxSCspuTqZ8c2YxQzWtYrxe2SHyjN1i2C0DRMIYLY?=
 =?us-ascii?Q?sG066fVqELdHHlampxtLlIr/1tyHOw1YksuaNIWjmYu8DPZ2WD296W0p59Zf?=
 =?us-ascii?Q?4VO5bE4Ohgjg94GPz2PCTd559Eh64o4QPM5uh0zweHCWC6LY3z76A+Y6i0KM?=
 =?us-ascii?Q?um4vQm56Z02PSvdGGeL1U9BbSrH1koH7taqpnDNi4Z8L2/Y4CH8fb8+FCGHz?=
 =?us-ascii?Q?A27BMfLGaCJls6Dlzqi5CZJfmfIZlHTDiILGqWHt5zSQIhZHAgcEcTsfoDPB?=
 =?us-ascii?Q?tCtcHeXx8VKXCtwJQABoF+HuWmIuwHJtdBX0pc1A2ppgoDByN0goeyHi2acn?=
 =?us-ascii?Q?TQpCfUYO2VbUqgJnTKtYJtWAftlY3MTHaTblrJMIE6Vzth01Eb3vTDDr4ife?=
 =?us-ascii?Q?oUyB2MDUSntUmx0z438bBr+QuSk84JhGn1p1dR+WPTaGOgJmSdg3ig389EEN?=
 =?us-ascii?Q?x6i8BUEtfUu9gjNs695q83s/I09S+IE+XkA9y2Y28RbWe5xJPb1VUBEOJ9Jp?=
 =?us-ascii?Q?XhRm0SLPqQND/AUqo0ku/xwlJ7R5K4Ot7wxAxJS61L0CYG5+g5H/Xg2G9uoy?=
 =?us-ascii?Q?mn8Odoy8SWWobl2J8O7EvFE2kXMXUHKRjCXt+XkFkYfPc6xdAjDGSzX4Xb8R?=
 =?us-ascii?Q?gPnxs8IG7k0ufEnuOdW45E+VtxsDXpsZapNqX1BSYmd03EyiVvZOuoBDCG7Q?=
 =?us-ascii?Q?fpr1ebIDdtFIY/zwIA8PGTmW/y2aQqltnzF9u7APvIQ/vJpGGAhLE4LSHbel?=
 =?us-ascii?Q?1seauPHDybobI+fdYk2ustAVXIsvfaTl2Tl1d156CNCV/a10giWHpOe2ktoO?=
 =?us-ascii?Q?Z9PsR72qAxgKh/wCwiOoFj/SM9fLac8/qmwzH6a4KMHyrfzCf3h0lI6WCJ0C?=
 =?us-ascii?Q?kSPy0Gxhb4ZM1JDrno9GZ20J0pg9EpxIf0i4hzO3/z75GbLURHqLAlZW3fPB?=
 =?us-ascii?Q?zT4dkvmfzxvJ8woGguSO4EbysaWq1GtE2/pqqOEe/n1Ayh6b2O3XtffeU+au?=
 =?us-ascii?Q?fIYf5+Vm3JnZjb9gIRyJKXaqVoNpyGjBlghUZqLdvWvs1hxqABfC7uyOyDVj?=
 =?us-ascii?Q?9P4mvvDqJmYgK3J1+iJIfsbAoCJcNq8nNQVKFVYLlHsmAheQ9CmZ+dcy3zL+?=
 =?us-ascii?Q?OVK3c7VFr+cOAD4Bute9cxlmSm3ul4n/qFS3xNR6MC6lekSVyYVC6nYEd+Ei?=
 =?us-ascii?Q?aS3Oj289OG/Xd2o+5mKu9Z7JLo1YrPA5pwPM83lfKZ65RuUzrypzdOGk/ex4?=
 =?us-ascii?Q?1U/LrNJb1LgCher0A8b1yZ0QGrquSBUBzprUDrqdfm3TNBPdBoMVoxIN3MeM?=
 =?us-ascii?Q?jen0U7c+qbqhssnXBX28dT2W/PSg1hjXsLHq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:17.4965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717d8fe6-3d61-45df-801b-08ddb39d7ed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
Prevents null pointer dereferences to enhance function robustness

[HOW]
Adds early null check and return false if invalid.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0146ad4e23c8..c744aa9d830f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6398,11 +6398,13 @@ unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context)
  */
 bool dc_get_host_router_index(const struct dc_link *link, unsigned int *host_router_index)
 {
-	struct dc *dc = link->ctx->dc;
+	struct dc *dc;
 
-	if (link->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
+	if (!link || !host_router_index || link->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
 		return false;
 
+	dc = link->ctx->dc;
+
 	if (link->link_index < dc->lowest_dpia_link_index)
 		return false;
 
-- 
2.43.0

