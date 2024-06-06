Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B391C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B8810EB03;
	Thu,  6 Jun 2024 21:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5tKUmIK1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E09B10EB11
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1h0j4BhhS74I6p+RBcP0dMqISnYIXt1CVxO3iPhLRJfH1YEAFEBi4Kamsh+Js/leo/ZTOdgGZyKsfD+9hFyrSowq4pX7VxKsT/yuNa8m/iMXhQa2ploFGz6SEs7CepvgsZF1n0MJshkTOOIFhsfUwsV5AvHLIk1rnYfAOLmNO2+lrSBzWCxxxqF4zuM/VKTYPhmk44DjdXUse7Ui4+vRawVGaPRppWyx63kyq7EkLxMlpdf/itDzxyyd+g0xrqbsvDnvV4v+/Qse+J/AysQq1Rt7P/FigBxCQoqS+lVyuBz1DUp7Q2sSfMa74OXCyhgugSVjlt5vjTapMLIgnpE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfhmYm62PwxvQ8pbf5mQVTE/Y3QpbFisk+SIRBgb1Y4=;
 b=KUsIcU+hVzHpDVQbm672N9MIv/27FiaLdEvlU00q1BxF0gUMnOZxrlVzIAusnSOku5BCqbl2rZBIcOqEQmIX6cCLoJljXMXSTxXvVdOLHl0sr+zHX3Zg7kW/wojbfRZBnLNsV/nYX4NtOjYqZt7Vtu5nn9kl8qaHoIUSPhXhUKYK3XueAqmt2UiVj1K3TRTMWDHAGEqG6PQtICELzSmQ3Tgf3GupoLolK3A43koe3KVUloLM05oU1nKKzzAz9Ei1R4rgsAYKgU5br6RdkzaryhfqIvi7l7G2DJe2E66HNoZEuAN7CmTff50XhpY0Jjyl1MJYL2nAHdQZM+nNoMzsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfhmYm62PwxvQ8pbf5mQVTE/Y3QpbFisk+SIRBgb1Y4=;
 b=5tKUmIK1UlqkNrK41sjhCneZCsEKc9pXn62aE5VwrGRMHtY0AtpDA57kC2zHH+NFl4nGlYy2ufdrCAl9ekbrL1UNsYeBPyMz8NjCM+GGrKV5A0cKmhpGUj5TcU3rzpkecIRoX2ua3RaDHDYpGt3jc2EIrHBFO/IEdDWfrF1zreA=
Received: from MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:59:14 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::83) by MN2PR05CA0029.outlook.office365.com
 (2603:10b6:208:c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.9 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:13 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:11 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 65/67] drm/amd/display: 3.2.288
Date: Thu, 6 Jun 2024 17:56:30 -0400
Message-ID: <20240606215632.4061204-66-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 6def0338-c27a-4afd-30c3-08dc8673e6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cvs4QqubpUifK6dSDWZ7QEy8I1HhAYR4To1IaQU7ksTsbL67vvOpeeV3la+9?=
 =?us-ascii?Q?JWPzomGAvkOmnAnCLSSEx2EkvxbkAb4Z830KXHIwd3cU0h/W4kLN2MQHydab?=
 =?us-ascii?Q?dSsy24q9eBqvFQ1KEZYwLDaLqtYrrUWPptmFI/cRgSF5n75pccIspvrBo2BZ?=
 =?us-ascii?Q?WYc5cIU4h/yiNHKJSfKIcdu9+HlaBKtQwyHEj0wHRJeV7f1R4FI+a6cace4Q?=
 =?us-ascii?Q?zskSZnySBmL6zsD56LpABT4Y3qa5QCUk2Dslvx8UsNwFvZzaPT9XD38lPFEE?=
 =?us-ascii?Q?hPinwrUMJEJ1S2BlnVlebsNeJmj6APFVnBW7ucdjds6fdsfgUCqjorZ3zj4t?=
 =?us-ascii?Q?BMygf0AnFctwOsrb6qoqOMV5LUpMG6BV7W/Sm4Qla81MmU6LpdW/C4eoPDtc?=
 =?us-ascii?Q?+NZ8vPOAWkZigyK5SVFSY79AvpnuGvFGOlISlq605vjR0H6y4FfAD7t/bseq?=
 =?us-ascii?Q?7cAlJxZQK/YQb3TTo2hAI3gdH/nfv6h9On+0LIAhEYgcICuoOCnmeUVxxbmL?=
 =?us-ascii?Q?PGi8bHCTKC/o0lMGB/Ws4JcaR7A4j01z86gDQMXFSNsYG4MhqyDz/fAbqbJe?=
 =?us-ascii?Q?wqEtRUJ8AIhQIsVUa2dDe/wnPCJu3pLnJ1I/j4pj17H4ZtIAqDyMMj7/XyL1?=
 =?us-ascii?Q?Z98uesEArJXcAdU+RuDIhR8eUt8Pgh0CQkt56srTYLjwlP5PqvFK1ChNjSfM?=
 =?us-ascii?Q?3UfABDQ7nEeM4hM3SMyxufU0zlCdhHDJVzYFZKU6T5gXtJkk8Qj7Ii2mXnYe?=
 =?us-ascii?Q?/QHubgQzvfGXYxUhiB+2lsnaSdoiugdYaahsKD/IAECueqJzblCKBgDxarRj?=
 =?us-ascii?Q?J85WAbhMbHehaz7EHF0F7+K7mItkc8yCLYmdM5m9yHaHLePcjvu/GVQrptpu?=
 =?us-ascii?Q?9jgF0CVONbS46qEukPKPJaA+pw93MgFUC70WHEKDBn9AQY0smzPfCkG4opWH?=
 =?us-ascii?Q?yZDGEzi7g31T1ZCUQXynpn4PnMkT+CoibZGu8sq9A6CJZEXrLtt6G/x6EdPA?=
 =?us-ascii?Q?ZgRIFpBz9hT2eJemMgvBD1EJcwxQsHfvXyubzyL3orHU3m30NPIeGsOkQ/tt?=
 =?us-ascii?Q?yOutmqblMEVSuIAGnK47y4V7S4zX1+Z5qAYdVHNuVkaN/+GrKRjC5p3D2hC1?=
 =?us-ascii?Q?wXi1ARrQv8FpDbTLJeSS9we8AIF6OmWGufk1C7y3hsdMB5RGhNgjppPNr5kA?=
 =?us-ascii?Q?RIpKeTvxYrYCcQX0KmX10q3Q2qPDlpBRskJGfhiItZS9+yVib0B6Weh6rSux?=
 =?us-ascii?Q?aWsWGnCuVD6aaTXMh2c4jZLZPdcZnHSe74ohXHAuC3JYhTaBtVNjuxL5LNgo?=
 =?us-ascii?Q?p7x/qg+ZqyXxpGbqwiKATMPif6/UphxHOoeAWB7SnbovarSm96VVx6zo6Mqs?=
 =?us-ascii?Q?eGNsBQ/v5yWHC/hIWHhUKvN7fAA3rMM8mgfXJFeDeoxG150PFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:13.3463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6def0338-c27a-4afd-30c3-08dc8673e6f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
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

* FW Release 0.0.221.0
* Fixed missing targets in FAMS2
* Populate hardware_release hook for dcn401
* Disable DMCUB timeout for DCN35
* Move PRIMARY plane zpos higher
* Introduce overlay cursor mode
* Change dram_clock_latency for dcn35 and dcn351
* DCN401 cursor code update

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c97d9b9d5c17..35ca38ea2efa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.287"
+#define DC_VER "3.2.288"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

