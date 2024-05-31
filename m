Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4702C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A41610E536;
	Fri, 31 May 2024 16:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B8FTmeSA";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732F110E50D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlQAsZ29NOPKRVANu/75uUG9JlW6ZwwCjrTfHyMNvgojq9eUxFQ/PXBw6phwJiVGaFbdZDDbxIzmMLk0XwrB0aEiXabB+PEcTNDcU1WqnEdAZOiKMnRAg00MxMYH8s4lYYbe+Nl4ymNCr1BSqZyN+69sd8PlBMXoj4Zd+OxgSnsbpjHyRXDG13PJ1LeerYbHscianHcL4N9N27fJzEL1H18yjfIwAEwiSp2IZeygx/VC1oU6pT398VW6PnnAL9fuoosC87s4I5Fc8U+JR4v46lMTt7ZKsfa60MuEIe+4tJdT5yB+6dH2X4ANRf0+UFPdRkvNYFGn7o33qI8FBF5BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8nE+rXXHf5Os1noKAJPhl+TSKbkS0n5sxSCvelX+BU=;
 b=NmMLogLZWB000pbT837yC3SVUj0KcuPluWLS26l22WhZAOrH4/g6R7Lj0Te3olW2nr/AvIqUcvtwRhP7qM3gGoC7CSpKmUzFDF86hLO2o+t1/OvPs9S/LxGNrJ9QgfhUT4u8/H6BHEvou29irdAXnBm7UBR5f4PGD3rOx2lIyzmnUaNj58lDHvvVjZ3KoZuPLxlZUf8OeKVKsgoUXaLsa8PpLtvQPMWfAc4GVWX67pSohYnt0MVw2IV/ye8h6Or9f61RhU3xeVZbeR5bClSdRCx//RxxDlha9B367aPt/1TzhpHZLs9k2uyOoWuP8gdR47xlNbomx05XG58FMbGtdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8nE+rXXHf5Os1noKAJPhl+TSKbkS0n5sxSCvelX+BU=;
 b=B8FTmeSAFSKlyH/1T2/rf4rkCURU5jPe8myCENxrHD8pUpt+UCKIG3fQsQvoY6TvV7uAzOuCZWyzYJyYm7m/v6NAIfNYItUpQ0tBVkQ72Rg2gRzVcYyNS9dVtiWt1Gin38FJVFYrmbTFeWcFH0Nbcglq71kIjS7xX12kYHwqOfY=
Received: from PH7PR10CA0005.namprd10.prod.outlook.com (2603:10b6:510:23d::11)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:52:44 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::ad) by PH7PR10CA0005.outlook.office365.com
 (2603:10b6:510:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:44 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:43 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 23/32] drm/amd/display: Add recovery timeout to FAMS2
Date: Fri, 31 May 2024 12:51:36 -0400
Message-ID: <20240531165145.1874966-24-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ac774c-bf80-4242-f977-08dc819217e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gFuI9N/GprmnFxfQFY4lFea4MQji9pGKcgZsVmOGEaIZnd+kWMQr+HUBY2Nx?=
 =?us-ascii?Q?s1C1GIQ/LfLcUMYP3dRq7JJbUd5XWsGiWzwzNSljt2qhlZ7OvQtED9Hs7CUe?=
 =?us-ascii?Q?Wub4H4FPgWH3j28X2DAAYRUH41XXPOb4Xm6xBw4NPIYt6/w3jIcbtp8PlzCC?=
 =?us-ascii?Q?LeBVhczBBIosPJ0NCKj7RjTptUucDeYceI3A/npQIuvAFZ/IEvr7doPl6z9I?=
 =?us-ascii?Q?DmyQF8l6Jh1k0rKrzJkd408cfG6t8WJD518Ggy61vQSXOhbddzGJb1YPjMsT?=
 =?us-ascii?Q?p13PUktEVVDb0p6IRYoaMHGzlvOcM7TzAUQFF6nmEgKzcQOy6ZLXOmTyrdcn?=
 =?us-ascii?Q?Fjwi0d0+Qf0spZxP7tbycnpRZGu3bgJ5roZ2LIHDwPjVXVCxcEvE0M9VZI7x?=
 =?us-ascii?Q?8gbvf53n0KgtffVvbWzqOwjYO3FJbBJ8NolkAdht3h3iuDIEVqiTmJ3cmS3f?=
 =?us-ascii?Q?4lhLmRmXAf+SAFw5XAXa7IDTKxVkcD4RzoMNi6D4wCI8rFJy/t4cddEbkt87?=
 =?us-ascii?Q?mw7y80MapSkZCD0EzqzXkN3goWJxNK9uxMJKZzi+JrmTRskP68DfX9/uoT6P?=
 =?us-ascii?Q?JbLo9RPlZdTzGxGUKry5l8ZwRxtUIR5qaR0EyYMoD3gvpY6LqXUw2uenW4ir?=
 =?us-ascii?Q?PwSbd9FBsqMI0dX49eILQ4atRBYelvGKjy4oVzWFscWFetnKPcwjfQUKqKg1?=
 =?us-ascii?Q?IdHAzJpPsvOYl8tK0PtJe+f5l2zRI2MEMoGbkVeeexVa88Er4TwoFroBBvoN?=
 =?us-ascii?Q?fUSoLC/ks8vtBIxIveSB8vmorp2yluM2wjco/XM87KjQD3sH3X42ZDIE4f3M?=
 =?us-ascii?Q?lHcLQpeir4IUx9xzjiMgAPxuTR0KYMuLmP28GW+lxlLpv3ASFiiCOPCs7C7L?=
 =?us-ascii?Q?wjmEe3krzYp77LBbkc+JPA8+patBphSjKhhrKU9/esU56yzffYUzo1C26n4u?=
 =?us-ascii?Q?tMMYlX5IaYllU95rNI5bHfMpXkT/ituGKIXXNnwMliUqsJ5hII7Sq+0WtSdy?=
 =?us-ascii?Q?DYFlGOJF1UK+IWymaruzQbTIY4F7iZukTaKjoNDjg0bXyhS/0lnd3EoMC8NE?=
 =?us-ascii?Q?gEfrJhcily5VlmPb9rtGLPw9oEwQWi3YOEY27oxGNCMgcg5E/QxJS3SZN+Y7?=
 =?us-ascii?Q?IUvYP73xnD046WZVe2kL1PD1n5shcY+DZ3II0OC7YtlwCLJFV+TqNsJASSIH?=
 =?us-ascii?Q?/vPO/csJdB48UxfE0qc63oiwsgYWJiTAUgXjGJTKLSJrY/dxzV273lsCHfv0?=
 =?us-ascii?Q?Dfd+Af3zLI/dP7+p2216OnwZgf8BtPdYbSJKLo71bDSkWh8lqkfUlMEn9uDA?=
 =?us-ascii?Q?5EvHEnHxEKPrFei/cYRDxYUjMJ2y/oc3MGroqRo/2tqhKQn3BNk+48p5WBPW?=
 =?us-ascii?Q?ApmdHg8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:44.4961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ac774c-bf80-4242-f977-08dc819217e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Add 5ms timeout to trigger recovery and force allow P-State in DMUB.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0e70b95573ae..4e6f7bf8a5b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1653,6 +1653,7 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 	/* send global configuration parameters */
 	global_cmd->config.global.max_allow_delay_us = 100 * 1000; //100ms
 	global_cmd->config.global.lock_wait_time_us = 5000; //5ms
+	global_cmd->config.global.recovery_timeout_us = 5000; //5ms
 
 	/* copy static feature configuration */
 	global_cmd->config.global.features.all = dc->debug.fams2_config.all;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d4d046ac82a4..53ea4a57bd44 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1833,6 +1833,7 @@ struct dmub_cmd_fams2_global_config {
 	uint32_t lock_wait_time_us; // time to forecast acquisition of lock
 	uint32_t num_streams;
 	union dmub_fams2_global_feature_config features;
+	uint32_t recovery_timeout_us;
 	uint8_t pad[3];
 };
 
-- 
2.34.1

