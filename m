Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0145C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6DC113924;
	Wed, 24 Apr 2024 08:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UxUKqURR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCB311391D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgRlf2cZ7UqJ+lajXux6+fHaWIaaYh4Q3rumB4B4WL7Vt/Te4E5X8VYGeJzWdcKeqAqKYJR5aFfwQYDVwhwXGLgynYwMghvX5j495xKN+TsSh2g5czoxyq6LxiwWoakAZop1mgqYmFA0OecbSnRUjXm7Bv1BmvuC1qGzTeyaRlN6EePtOEisCseSm4eOYtkfEen9r3umLKdOmMBbgwgvAjU3RPI/naH75AESvy6e4atrtaTcOe0UDtwDHONO4DyanVkaF605ciY7ImYB+xRAoHsOHxLvdAYiNX0phuSQikimfSlhEapAP3yyDye16Fsg8vNr1MTQIF3wGBn8VET9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxV4RNOxgqcpfLpUG222sy+wQ2V8w+ZlqDCt30ErywI=;
 b=Q1F/t/gke1EYkRGIRzBqZTJ5P4AXCId9SJrWFruk1NUZ7f51Uu4gzyZKMtipAXmzLD0kV0zaP2DMtNcBzXwtW6tVhDpYzEITVSzwKWl5ZDtFz4lyKDmm2iPWMIryyO4Wzldt4lKZHEgQyXKfxDqitRJenmc+CEnTJkTket+AYvGVZBPJxyXA7yEOoj67ektvL2FcPegTQ6X5W9xlZKCDg0niSj0Ue6dhEXdkAffXYHIQWiz8KUPCnXc6sSJBG5eU0z25PhVK7w6Aiz3Jjq3ZO4In5XEW94SdArLjb1ExO9w5IehXS8/jBxyN86ltkQzT6u3ButR5H0XEwdjLdiwgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxV4RNOxgqcpfLpUG222sy+wQ2V8w+ZlqDCt30ErywI=;
 b=UxUKqURRuprtONAy8BvdMedksCp0QJu41gDB1Qy5nyoaOPSAyBlniL/SNk+f+hgEnHpXEMPLCx+P8pj3vK7cwm/dPJ+NiM/JzyI2frxZl47rmVTQtnkeAvn9Mc9skmEjpMY031pH2gP0exmPoZlwRiGQSzOcIT16ZjIv1/sfqJo=
Received: from DM6PR06CA0073.namprd06.prod.outlook.com (2603:10b6:5:336::6) by
 DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Wed, 24 Apr 2024 08:39:15 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::72) by DM6PR06CA0073.outlook.office365.com
 (2603:10b6:5:336::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:39:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:39:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:39:13 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:39:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/46] drm/amd/display: Do not return negative stream id for
 array
Date: Wed, 24 Apr 2024 16:31:24 +0800
Message-ID: <20240424083202.2647227-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: a75c756f-7447-49d7-1552-08dc643a05eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rusHNsuBDqa8ykJgAzb7jeNAX1bzPreG+c0UHJ+w6r9nCILovUmqBm5Zsc8c?=
 =?us-ascii?Q?IP2zHKEsxtzRWlncRsAfKCiPOltBZjSNvP5fpTBBUZLVh6qVN0LzKhCUrleW?=
 =?us-ascii?Q?BUsbUf9s4V/MlLcT8p4gDC8TYrp8aHBVyqeoZvjTukg7c1YgwlMy2r7eMxj0?=
 =?us-ascii?Q?NRmRLmuoxZGPt5Nj9UpMwQA9/7Y8nbhQKSunrXmfDhvHWjgXmyzy6OyKVrq5?=
 =?us-ascii?Q?Dv3q1MtAOAgQXF0nSuO8J0thIdgZv5vQM11fIMNgi+559UWh9gByUmjgoDCA?=
 =?us-ascii?Q?bIMhR1CxyK2Lx8lrxOTInP+IceO8mn3E4bnNh7XAufp8/v3GIAZr1g1qOYNB?=
 =?us-ascii?Q?qvTHBmI6I/ASLhrxLd4VYy3wbK3k9zd+DeTLeBsSnujgwtkpg78zJoqTKj7C?=
 =?us-ascii?Q?/HdcGTkdQALU+8K+bCdjJ6/C6vqPmbBUm1jgH92z3eprojn0crFPAxHVaN37?=
 =?us-ascii?Q?6hXOqvxKV8fIzcVm2UWKPXmz4WuUx4ccuOba3aopDVAr8E2eUkYnALxQiwH8?=
 =?us-ascii?Q?jKGjVTQDs5nOJzVXv26/oxNtfFAL2uiotDv2XSHA3npIQvAW1BthS8FcnaAR?=
 =?us-ascii?Q?VpCcTxnKOjZ54Qd7q5qmlfClbzthQf8yX5z0ETzq+ueonnKpExIdWnv02Ipv?=
 =?us-ascii?Q?ZRThJ8LGG/7BfH/zefLku7c1jPQUXPyZi6NlOO+MszMX1VxHuV8GAvC0OgW8?=
 =?us-ascii?Q?FvJocNtVFzVgZsPDs0jpPxcghep8+6BPVWOtTRkSywpHPi9TEyb8YS7RsQPp?=
 =?us-ascii?Q?h4G8QfZ6MdmSQt2YsZfuj2LbcIEG8F0ZuKFMV7HVfyPrEvOvvdlJ0h4WWJwR?=
 =?us-ascii?Q?Qiv0khO8M/zjxGEEPMJIsLeeCNGT/eAYyBwltOKKayF5/iaJhn/0s+zSYY21?=
 =?us-ascii?Q?HM563OYjE5zBkkfQtgeYsgRLxWtJWgYCpM1Q2ykgwHyhZK5V9VX9jI3KsphI?=
 =?us-ascii?Q?AB6shw3fvn/oomkCCMO6ePpkiJ28S48o5j+YJh8E2qlVJkKi2P1I+QY4voJ/?=
 =?us-ascii?Q?GGM+Fj+dG4lHujY7DaQVhFWQCCfe6Ok4MVRgO2I4rCpwuFNppnRXCTVaK1w6?=
 =?us-ascii?Q?fxm5UOypPdsmE5aiXampycBuPhoyasEJm80N5Wi9iCUlzMv6pi5sfcFQmYoH?=
 =?us-ascii?Q?tfiFJSbzUPe+/9rEDUdXpuLzjzjLSklivRObSR3/uBh497linW7TTYaP4q5+?=
 =?us-ascii?Q?ju857XqXFRa6bZgwVJ7NXPJK6oJfg5id+UKIlAWmHzEe1rZ4nK1gGUgc/BvH?=
 =?us-ascii?Q?gitnSQFuWBmCjEHZyvhTMb1rjryLeX2E+J7vKkIy+SN76jF2kfuilo8TreXG?=
 =?us-ascii?Q?jDw42/Lr2u7Ca4oWOGS6hQXxXkqSB/Cc4Xqsi0k0Y+nTQJKQX6DdRTVAFGjD?=
 =?us-ascii?Q?puwyi1s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:39:14.8847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75c756f-7447-49d7-1552-08dc643a05eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
resource_stream_to_stream_idx returns an array index and it return -1
when not found; however, -1 is not a valid array index number.

[HOW]
When this happens, call ASSERT(), and return a zero instead.

This fixes an OVERRUN and an NEGATIVE_RETURNS issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 93f05e2080f4..25c64fdcfa44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2282,6 +2282,13 @@ static int resource_stream_to_stream_idx(struct dc_state *state,
 			stream_idx = i;
 			break;
 		}
+
+	/* never return negative array index */
+	if (stream_idx == -1) {
+		ASSERT(0);
+		return 0;
+	}
+
 	return stream_idx;
 }
 
-- 
2.37.3

