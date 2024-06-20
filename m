Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0ECC2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9454410EB34;
	Thu, 20 Jun 2024 16:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgDLEbKs";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DC810EB21
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbKZM02XRyaPM0Ug4eb4XMppq6C7xJwxlVVelfMnewlHd9hcr1JJnRKWUUWkUr7si/BxPGeIej7pnKrjaWD/eQI7RloL8v5J5/SL9Y1bh44Kll/N/Xdg6E5bXkB9WKyjWXssp5nH37wYI+tDdmCVrxXaK7FY5/Sa0r+yoCo0U5ZP45qc7N3QV/cEjg2WAVIeIih6VR0l1r9V2PNsRYlziuRMOAp/Y50iLgD69j8FqwEPbkFH6Jfcwasg6HNR9qR3LxgPN3H021aH+apuA+p4j7hH1R2Z01j0PGpNuxnXw0GOw1cmOPz4CeG5HUzArwsoV6GvMovTXk/rbiGBSffIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRgBTeuvRup+tLnvUXVzUujDoJ8EioOb1a/Ecgn5tsY=;
 b=G5bn7eR/ZQZghFxaPdNKpC01CqwPqD5/vafFWJVx3HLQEjo0OaitaDWjV6Nrq8JE6ir687Phn9Ukeo4xQcOIQesgKntp++TtzQcMrMpdyYHDaVHftTn4WScF8+2tY/U4x4WuUomG0PqqdzqHtNBJNLfE/aRucDQmMe/7L0N0t6Zw/DdHbUbE4azgmvaU2qGxQUirQK7FUBu/AmO66Y0qvopbAnCdv8Cu1x0HQBHPCWJ2ztUH3DvxObG9NenDbACXnv2ofFPYaL8HODxMeDfxhZuuRNgU7x5XCUu5eWAN9GUPb74Gclrwte1oNsjoHJ3t0io6jKzA5EqLzPi+reiHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRgBTeuvRup+tLnvUXVzUujDoJ8EioOb1a/Ecgn5tsY=;
 b=lgDLEbKsXaXolp12aePaQvY9YGcTvIciN9VaDlXVOrhNt8F55QY1508f85RDI2H0VyoDeFqeWHl8fEVklX2zmjfGkbw0dKSULo/zZ8IYosyVe4BRdc0XjG0HdI/JG2PkTXQQNnKjOnAu1uSEGPM9WzCUsVzVK1Durqyxi8O2d7Q=
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:19:11 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::50) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:19:10 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:19:07 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 29/39] drm/amd/display: Remove a redundant check in
 authenticated_dp
Date: Thu, 20 Jun 2024 10:11:35 -0600
Message-ID: <20240620161145.2489774-30-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: b432f4b0-65ee-41c0-9fce-08dc9144b7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Td4ETIGofFlb4KEGd95IVD3OzxeoDDvprWcYzl8Up6B3F8g0N24fiISgAbrz?=
 =?us-ascii?Q?TL6Kr6v4kQb2lsRMv4A1uRcNnHI4jfBVZRBbW+Wij/Cnuq6qJm7CG40GzpLP?=
 =?us-ascii?Q?+Iyay2aqQ2YkMBnhRTW6art7dsUsWpSRAc9oz1F8oMnRXbLM9LcuVGytR/IM?=
 =?us-ascii?Q?32Y9Q+NwoyOfLclMuCpUw7CC+J8kWKTgW8DHwvH+6P6HifnCS4u5BxM3ZKzm?=
 =?us-ascii?Q?K1pm6mEcNT4w1Qjuls9RfD3xLHMxm8st095TEfA/ykLg9trTEjNtXXET9MAA?=
 =?us-ascii?Q?N+QCxZRUlGpu3xW30Hg3W5q7VokAr/GMgPESpZHuDfMrraKQBs3O/UmyQS9Z?=
 =?us-ascii?Q?249Ywbb1NcMQtDDkOI7AT9M0rNyiBkXQ9JURvC9uy4u3VkZB0g+dVAOwiLm1?=
 =?us-ascii?Q?4dgTB6UlpVJUXzFGMyVz0GqHTIgk/IiwoYLFtU03t8mSTSaPnxhDRDc2Sk6z?=
 =?us-ascii?Q?l8JMk+iPQLiy4v1Y6EZ6naWIBGpxGIjVbAWpHx+syOZx72a0itOIU24Uk/M4?=
 =?us-ascii?Q?8nCwyghQYdzcm1EvjQKXOfTJzOlCYGjYPj6R0XANdRFRwKOdiwhVzbKR7gK6?=
 =?us-ascii?Q?EaK9cleKIne8JTRrl9fMbSjJJBS0/M46HgTSw8S+59GIyjvsGgVFs4maQavJ?=
 =?us-ascii?Q?PmDFIozIzPrWNof8rhzQpVMN3y0GxpIISBJunwKUzB5GHspZCHlo6czAkoFZ?=
 =?us-ascii?Q?Hsi/qRWZ9Prr4dN8Hh7R0smFneXKuPn9iE3m3RZOmhxeBD83KZboqVPYRp/Y?=
 =?us-ascii?Q?20CiLwhclBCXmxidOhGRBX5/noXUajdhOHhhOmSORJnNNjpb3XVtlqPfvGSZ?=
 =?us-ascii?Q?AOLD7MS/jDUVuL0nZjofA/AYD52cy7xZi1sk/GOTZ8YRXAYXU6og/0uqukNV?=
 =?us-ascii?Q?wXJYeKAiWbmb3RCCWeym7TU6OwK+Up5QvZAOWqv9aHz1JfL79WJLWHYF98Bi?=
 =?us-ascii?Q?5bKvaEF4J6rFm3vFB5m1fz5urvKXQCc6GndPHlT6fS2/IrQR3k37Z+jp0Zeg?=
 =?us-ascii?Q?tqIvb2Zum++vveF6KRZEFLjkHBu0XCX6t3oR2Fqxgl7FsCbaUy37ZKPs9Hzl?=
 =?us-ascii?Q?w9prfQGzSItzRjYYtT6rxAMGcUNIYy5F9xahcV6xb7Btb4fvvhlbb4D8j02P?=
 =?us-ascii?Q?GJC8e8UtCmmro+easTdvbF1K6AihdS/CW3BeGhTrU3/bW3peOgJRlVsUaxtv?=
 =?us-ascii?Q?qKPM/OycMqVBuKf64yQ6MpeYOENfZFRLhUgMhxgAC4pqULHB8Umckri8bp7r?=
 =?us-ascii?Q?Os3PxagJ4XiXjnLSvrIK8uiG8knfh554OO99O8w1vet7FUy+Sjy2gZivvGbG?=
 =?us-ascii?Q?n+2vvdk7rpgDCvNUcew+YdGWeuPONzZoMEVsoUXC26ZTapV68lRzbfFvi/6Z?=
 =?us-ascii?Q?jIw1BFhHISWJ9FG/3kXfTv/3MNU9iLWeZh52tF6aokLJrzwP2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:19:10.3391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b432f4b0-65ee-41c0-9fce-08dc9144b7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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

[WHY]
mod_hdcp_execute_and_set returns (*status == MOD_HDCP_STATUS_SUCCESS).
When it return 0, it is guaranteed that status == MOD_HDCP_STATUS_SUCCESS
will be evaluated as false. Since now we are using goto out already, all 3
if (status == MOD_HDCP_STATUS_SUCCESS) clauses are guaranteed to enter.
Therefore we are removing the if statements due to redundancy.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../display/modules/hdcp/hdcp1_execution.c    | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index d77836cef563..1e495e884484 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -432,21 +432,18 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
-	if (status == MOD_HDCP_STATUS_SUCCESS)
-		if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
-				&input->bstatus_read, &status,
-				hdcp, "bstatus_read"))
-			goto out;
-	if (status == MOD_HDCP_STATUS_SUCCESS)
-		if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
-				&input->link_integrity_check, &status,
-				hdcp, "link_integrity_check"))
-			goto out;
-	if (status == MOD_HDCP_STATUS_SUCCESS)
-		if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
-				&input->reauth_request_check, &status,
-				hdcp, "reauth_request_check"))
-			goto out;
+	if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
+			&input->bstatus_read, &status,
+			hdcp, "bstatus_read"))
+		goto out;
+	if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
+			&input->link_integrity_check, &status,
+			hdcp, "link_integrity_check"))
+		goto out;
+	if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
+			&input->reauth_request_check, &status,
+			hdcp, "reauth_request_check"))
+		goto out;
 out:
 	return status;
 }
-- 
2.34.1

