Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A86DC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0655110EAF6;
	Thu,  6 Jun 2024 21:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="faBB7eyB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3770310EAF6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHeibvy0MS5NdIUz/nXaHEWIainKXQNPBJb6WS7mCw3Rn8CrAx7aZf20OnvbfYA/BkDRTcUGMjv3vEW2IF/kpRXH2L1XiARLbrz7q7/wHzvwYDtYhhRf/lE18hkj4Ie8//u1eenSOhsrUpE313xKz+bLWhdQcSJoDtBlmDcwhkbLgo5pbCD3zpT53zjb21sEH+BnqLp2tfvBcCdw/YxuE7DhoWbKy7pQq3yIdwcSHGbnCxy8aQrMW0LQgOVSrT3AVwzguE1NAczDDcQQ5EyFPMhJWfoFMWzt6KupwQOw/z4JX8amz487pLtN2daDmepsoaewv/+Y7UM9WuPymsbXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/vUT+VW0+IY9OkbLelrifhaiZvdx+iYfwi+tr9qik0=;
 b=TBDkTYaoMTj6FfDZrhkA/ocu8YtocFQoUOfyaCxMhgAsSwso1OgioBHdhDbcUB//mTEEvfo2WCCssUTS0gqDlIzhMyskbHJOG6f2L1o2LsmYL+Z0aaO4KA9i1opUPdjE2TFpx+Y57djEI7G+acy39jQ/nCGZsg+jXs9LPHxA6bnxnVurZhzNisqSphcVyKHOugZ+f11fLSDYSd1E8KlkVfFyn9gZ64sVD1jRqDpjiMDNsfnUKZfWu5KA6u+TXixTIGa0hYjCR9pwF8toW2kN5+N0gdfH8Qvr9Wj8+HwroDz8AgIymqfWGq6GJarJeCLoRqBhH61nKeNibWgATsIMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/vUT+VW0+IY9OkbLelrifhaiZvdx+iYfwi+tr9qik0=;
 b=faBB7eyBPMAaNk0szr58AmCrBS6AsU/JdZAd7fVwEPsIpXeo36+l3BmGk1BEmySeVcebuH7cHrDAJx4CZIqs/mzvX36hTJ08aLUxbElbCX7DU16aklg1vfEw23T81lYpehUEvvBPQjt14hP31mGSHulCgjRH5SD6zADsO768hX8=
Received: from BLAPR03CA0148.namprd03.prod.outlook.com (2603:10b6:208:32e::33)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:58:42 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::7e) by BLAPR03CA0148.outlook.office365.com
 (2603:10b6:208:32e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 21:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:58:42 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:58:40 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Zaeem
 Mohamed" <zaeem.mohamed@amd.com>
Subject: [PATCH 47/67] drm/amd/display: Check otg_master pointer before use it
Date: Thu, 6 Jun 2024 17:56:12 -0400
Message-ID: <20240606215632.4061204-48-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad065e6-f514-4411-285d-08dc8673d44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hwu4U/pPu7QMF2rGeZlERFdce2ksDpueEbW0WtV4qD01VkKV2CW+Zi1yZPyu?=
 =?us-ascii?Q?EOS+mpivHF/2/MqS1NZfxqcv94i26AAbhwCf0zPYl7C0+vILM4/kqsKGV5xv?=
 =?us-ascii?Q?aVZGdJiwmjLcLTwOlRSp+ufGZLtvXO4tYJdzqxStBDs11rcwmTr4Xl2s+CH5?=
 =?us-ascii?Q?+sJ/zvNEGX2T09jjvzFl4fsJyljAaoU6RuX/KdARuqTpipszYdMzURk7a/hT?=
 =?us-ascii?Q?/uAH1cstDAwYJrPf3Q11ANuQXLADZoLIT6NxG6DAuH+QCmFKUrZ4m10b/XiZ?=
 =?us-ascii?Q?bYorPrdRAeF2Gwr5ztEXZyaNYXZM2XTWGCKOue/P66O7vQxibIurOQnc2rY+?=
 =?us-ascii?Q?R3b0KhsRD0u6oDWbS1UlYAW8tkApeMXBVH5rZec1CBe8GptiKPLusRo0J7Vc?=
 =?us-ascii?Q?UlmVZbnD/2HcxZprZd5naRRGZWCi04r6Q7OVdpdA6FzSQuIgGiwunC2+WxhG?=
 =?us-ascii?Q?4C8ykZXAPf6LmMWIcbpu6I9JsFeSdLhO28RzKGyHNcjQuJXsu4rC5/Vp8pbH?=
 =?us-ascii?Q?luw/GUgG6BI/jm/E9SlsyRijZmXCO1grK1X/q8aeABjphP50bk7bxT8gUPpV?=
 =?us-ascii?Q?UfBcinzo5ecrZAY7geBc2nueFclWyw97FSIpZsjQKa6RsgSpgohHYnLzdfbY?=
 =?us-ascii?Q?KSHEezIFXSrnplpVXAM8JzGwMpa7+S+jkoVLbPt0g9ErMQVMhPBOGqE/pKDC?=
 =?us-ascii?Q?BYQ2F1LbD2CUKi9Gdjzk2jfD0e5QfH53kVOuJSa4+9qAhc52mushmIuqm7Z9?=
 =?us-ascii?Q?rLYymFfvtJM33DciWxYgANb8VVRYiRq59kYgHiZt4RdVGIny3nzfGl65mhbB?=
 =?us-ascii?Q?GCx6cSJXfmFpx1O5gk0Ilp1PJXL3jfUI6mTm+d6KbJuDw58IHZ3m2sgnrSe9?=
 =?us-ascii?Q?oa4DVk9js4oZwmhWekn1L+h+8IdL1R06X5F3oG/2sb5m3qSVuCi+1jloDVug?=
 =?us-ascii?Q?OYukmOvtwquJvZC5l/mTT00yw22RI4tXpHhFXIoXwc1wAW55u3fQUf2lPeo1?=
 =?us-ascii?Q?bHaukTgNjHNLx+nqY1ofb/t89O7Ppyd3mxKj7JhM2uiGM3PP9sFQ+jtu5aMX?=
 =?us-ascii?Q?ycbjPHKV3ptomOKlIwCnEsPLn30Csmw8b4rwV+FYvWM0urDPACEzAuQlnyQ9?=
 =?us-ascii?Q?FZXek3br8neZDC3K9GV+5cwpazkd3gfk9he4RakoEHfWXNXwTdC7AYw/0+Ki?=
 =?us-ascii?Q?IcpfHa421QXn6LZ6vYXKMR0QpQjUzW9PfOS34hZSt96C7Fq6MG6l8Pv+ihDf?=
 =?us-ascii?Q?bhnD3Zg5bKPG36Ken5gmF023O9dkNEUxemyp1t36UfR1znNMi+dulEclPnpw?=
 =?us-ascii?Q?bLpXdjhErUI7KsXaIXvosa/fmTcCX5uNgvX7aAcEpZsOnktxVkLjMamuDDBC?=
 =?us-ascii?Q?TMQwM34Yn8q88zbLrKQULtJQQxKIBdrPG3Q82wRKMMpymHismg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:58:42.0173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad065e6-f514-4411-285d-08dc8673d44d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

Coverity highlighted that the parameter otg_master is referenced before
the if condition that validates it, which means that the code might have
some attempt to access a null pointer. This commit addresses this issue
by moving the pointer verification to the beginning of the function and
initializing all the values right after it.

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7894d3e52a27..e047ea4ff3aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2077,15 +2077,23 @@ int resource_get_odm_slice_index(const struct pipe_ctx *pipe_ctx)
 int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 		bool is_last_segment)
 {
-	const struct dc_crtc_timing *timing = &otg_master->stream->timing;
-	int count = resource_get_odm_slice_count(otg_master);
-	int h_active = timing->h_addressable +
-			timing->h_border_left +
-			timing->h_border_right;
-	int width = h_active / count;
+	const struct dc_crtc_timing *timing;
+	int count;
+	int h_active;
+	int width;
 	bool two_pixel_alignment_required = false;
 
-	if (otg_master && otg_master->stream_res.tg && otg_master->stream)
+	if (!otg_master || !otg_master->stream)
+		return 0;
+
+	timing = &otg_master->stream->timing;
+	count = resource_get_odm_slice_count(otg_master);
+	h_active = timing->h_addressable +
+		   timing->h_border_left +
+		   timing->h_border_right;
+	width = h_active / count;
+
+	if (otg_master->stream_res.tg && otg_master->stream)
 		two_pixel_alignment_required = otg_master->stream_res.tg->funcs->is_two_pixels_per_container(timing);
 
 	if ((width % 2) && two_pixel_alignment_required)
-- 
2.34.1

