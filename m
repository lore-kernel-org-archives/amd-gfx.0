Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FD5C25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5245A10EDC7;
	Thu, 16 May 2024 19:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvz9I2zK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AC910EDBF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzHFhWx01W1B6RKvIpgXsi4Ddxylo8BvvkEfUPa2jKfhHecHTaVex+ts+r5/zbNK+ANWyy4D/W05NNXHcJy/QKZ8Ie/YGglEBJ2jXHzUZkKxMPH/7vsBcYqU7zCtGyMFUaDnxcCWe4mnOb0+TE4KuTFJRAE80WtO0JskhBJIOCaRdpq21FDPCLhS+sfrnZIHH8d4XRXcd3WCc7yosADS3aAFfn8o0m73h9PULa1mw8UyVAECFEz73I9HskvZ1CTLkIAnIL87m95loAjHjuTweak0oJj4Bz7KAp57Yr7lsfCzz8Of6P+6VIkPHPSmTRJ87696BYxkKPGIve7aqXkJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBuljfm59onc25TtmxUTfprlfPBwKNoSIygoivD+TT8=;
 b=PIoYAZ6gpa6mvaEknyci7OjHw4mdDdpZKwG9nqBBg0yNIgl9VmF4Rcbejsc+tJxHU/Gi4XiX9pDe+vPYCwAb3afdnOMK1vJ9SBO4QztJgNZH7j5bJcr+xa2m0+dFDCYGAl2zKvH5nvQOAJ9YdzuDPA97U2uRhGZ8uDFxTvxzs3+gLjLlf3OXuIIvgl7zpB2KJYva55oq9YOCnuqaVXWQ1t/L6O9mEvHUQvv6nR4BGSqWYqnDEN4fMDA09TKWXop2EfOewDW1ZXQ3wp4mYejdrxaGa3mjG1CY+VugQg8l3twEbTh7uk882/igFVxWLxyffIkgqUWGx3TdKu20uMHmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBuljfm59onc25TtmxUTfprlfPBwKNoSIygoivD+TT8=;
 b=vvz9I2zKiqjVUfZhTWITbXotarTHlQP+w5WU/TtrzCmsyeodYAr1ImY98e6mLKG6DEP18NhftMTRP2Dd0Gexvbuh76T/QGhJ65f5JUw+SWGr+5z/nwqPNeCQmam4027V/tyZs7D8SxKiJlsOmATgMII7op3IASMdJL/ZuVVS6WA=
Received: from BN9PR03CA0065.namprd03.prod.outlook.com (2603:10b6:408:fc::10)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:27:08 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::4d) by BN9PR03CA0065.outlook.office365.com
 (2603:10b6:408:fc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 19:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 18/24] drm/amd/display: fix a typo which causes an incorrect
 ODM combine setup
Date: Thu, 16 May 2024 15:26:41 -0400
Message-ID: <20240516192647.1522729-19-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d7101f-c0f0-4475-7e7c-08dc75de2d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AgsVrsyANLf2QJ1trY0OZhxNsK1ifjHP+sXQQSMSQQk1+FZ247ngYcUQQxDw?=
 =?us-ascii?Q?zGe0RE/t8UEhLars+8nPOXgWEqC+XLH1KReSNkz7Akq8XGW0PV8oSwU8hIBS?=
 =?us-ascii?Q?MeIqYs6t3q5v7Iw1rkKguXkaOMGCRjJvBFjRbE6fJhiY+k1wkqfrRnhIPv5+?=
 =?us-ascii?Q?+gvjyBCN0kj09glFKJ8ioFssLsmSoHcD5mXVyj4G2LVWbkYq8CfBKU4TrRzm?=
 =?us-ascii?Q?qfyrpzHnHWLAdyLdZIP7jm4bVXYDcSmW/N8GBKcEazBrF4mbpmg6fhskcMJC?=
 =?us-ascii?Q?GS2wFSU3g8Na3sfair8N+f/stFLtNdG5Tc2+THk/I1VIJ/4t6MeDq/UGfFEx?=
 =?us-ascii?Q?RG0IBXCsmOTwxVKoXrD2OMxx291OKYsMRva2NjKDyEUQOijwVVkuPboHXv3r?=
 =?us-ascii?Q?UNifpx0EQbhOHgbJnECWSVzjXPV3qC6+0OspBcI4EssqrLUbfTuRm6oWxCPY?=
 =?us-ascii?Q?ENQoujPkJcth6ZJdqTlL4MJy41qe1bWG40Oh+9o4rDRFYO8STVqVmLHVGsVV?=
 =?us-ascii?Q?BP+q6Zqehp6zOawiiKb6ysjVltqWSGJlsdrF4kB4uXQn1qRG7r6m/8cI5n4+?=
 =?us-ascii?Q?+r9HRzR00igwiCgy+fRpN7TldNVbhlOtmqhZAkUKD470L/M8yy+Jf8sfqwcS?=
 =?us-ascii?Q?XzGCQhOjnjvZP79a+8jfjXdJrCeCP9Qnde6e07esDyuVkYdueDvU0VtaT1jV?=
 =?us-ascii?Q?/5GyWdV1LUH+Q+uC8jMwotPp/bjEsd+hgv5T6oXyY+9Zl5Ir4W43WcRXYZ0D?=
 =?us-ascii?Q?nQMjOytsdeYDEsTHOS3HKIi2cjw4Q2gOBd6GX+2XxhB3URTPEw33viGVXdI7?=
 =?us-ascii?Q?gd3wnl0BjFmHqdsj6czQqYWfz70Re7xsLHMEwzX1VqhGL+rVIeoNCNHom649?=
 =?us-ascii?Q?gRRq4V7/dytdjYrUq6oAyrjvrSziRx45K5CRLT4HwUB1KQqlh/721ZNIkRHy?=
 =?us-ascii?Q?lf9IyFYbT8wdlwDezHcgC84suysgEBqOKvXXV6Qf0IaB643+YhsAZERpUdU7?=
 =?us-ascii?Q?pXofTN3/2fK1FdlcJVde6ZClv+LWzLkbY1J3ehhnA4HQnJkhQX+2grfxJnOL?=
 =?us-ascii?Q?tJqR3Rzb3KwozerOGz+er3MIA3yFXz6YjzJaUEe9ze+n41bgRWkqstmULMRA?=
 =?us-ascii?Q?YWhNZge5WVcdl1JEVB+HoiXNd1w1GMNtI8n/PFYsmI/Mddhgkg2ajUdJNhOl?=
 =?us-ascii?Q?yf/CetkY5ot2wEmimInuFU8/tEt+7SjUPySxSnKpwUAV9Rbx07T87Jvy5E3e?=
 =?us-ascii?Q?o3gBmmvXvem/KZd1qzwS0HZtIYhcL4+C1kqa7QkWCz7B9hAC894XNiKCu3cH?=
 =?us-ascii?Q?Q47nq8fl8KAfPz6gj9rJaNWR5mqhdQEBem+6B5RlsBsV2HjYhFZP33GiTi5m?=
 =?us-ascii?Q?s+jpYJtKsO+FKzNRFejZ88b5BJwx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:07.9920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d7101f-c0f0-4475-7e7c-08dc75de2d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
A recent change for ODM combine refactor contains a typo which causes ODM
combine mode programmed incorrectly.

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index d085c9ff9d38..42c3c440ed89 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -854,7 +854,7 @@ enum dc_status dcn20_enable_stream_timing(
 
 	opp_cnt = resource_get_opp_heads_for_otg_master(pipe_ctx, &context->res_ctx, opp_heads);
 	for (i = 0; i < opp_cnt; i++)
-		opp_inst[opp_cnt] = opp_heads[i]->stream_res.opp->inst;
+		opp_inst[i] = opp_heads[i]->stream_res.opp->inst;
 
 	odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
 	last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
-- 
2.34.1

