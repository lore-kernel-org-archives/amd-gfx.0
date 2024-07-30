Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78731C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AF1510E4CD;
	Tue, 30 Jul 2024 07:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TGLxgWqM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B5210E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/aGu62CXi6gHcIaANgfNo91XJ3E1AVpb47TInae6Ok9XcRyM+KcoQbua3ajNZ8Ix6ZDFFCXZwI3QT7OxoWnsXAHmbvZIkOPGOKbL1/P16O3ctmwe0yUSKTKN5xVgkaAa/JtEbkHXYSTrTdQZNwR9fSxkGwwQ7X/szltQ2yFdXU/M8bKhQmWoQg5yY5iYJi5naLlWjXb3HmeuqwiBRsSFX4dfb8FYEzKGEwW+HqhOO66TH3x1T/5DLhbw9zQkWZC+UpAMI3sJfLFMs1k49D4iCJo16DvZKQN2N/kQtDfVj0ftCfu5GigecMo74Fje2ArxXEy4Mc8mID5TC95s8DS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrcvolbTZ0JWiRGY9hRLARYQ6f3bWwndjpBtlOyihxM=;
 b=KLQEiPpvgQMgm8J7lglwuKz0ApfJl4LKfXo+P6W0QqhTkSTkPqrPe2MbX77agHVK/ugvbQqndPnygxneEI2m0qGbaRYD//XQfXYPZ5L8sdWOpvQIbFEvrEJgBozDEwBCM6nH7hLdgfYp8z5NqLdZtHhUZgTQdT4AU1xsnWVMm1xpc/kdcPR3ufBWkNOk4c5qw2MYBT2hj24AZPKPYbKaia61Td1XXhaJFK5QPHFzYtYtjr+jAU2270ZYqP1R6bqVr93S8+7NJIAJ3VjTJfXgldXukrqay/lb2xftoZ1+p5MmhB384cCKpOnZtMDCytJg3oIcGX2QOY7kS6O3AQNajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrcvolbTZ0JWiRGY9hRLARYQ6f3bWwndjpBtlOyihxM=;
 b=TGLxgWqMWTBq4AoAXxrVwO+wLlz9UJo2RjfhlWLWfxwsidEvoI9rqqHzd+S/DB/O3uNtrXPqqx+lPp2EbUUF6YsAVQEt91nksqvYh24vXNFlc+YAdInWr4+krFC4Yw0xwnn91Sz14RRTvbknG8OqI5EFLINxXbHoJhcvN7Uwa0c=
Received: from SA0PR11CA0113.namprd11.prod.outlook.com (2603:10b6:806:d1::28)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19; Tue, 30 Jul 2024 07:22:34 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::65) by SA0PR11CA0113.outlook.office365.com
 (2603:10b6:806:d1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:22:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:22:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:22:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:22:26 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 22/22] drm/amd/display: 3.2.295
Date: Tue, 30 Jul 2024 15:18:43 +0800
Message-ID: <20240730071843.880430-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 950073d2-3bb2-4c4a-70ee-08dcb0686170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mpa9wCtXo0KDmqi799LUoGabgkl/pZgYndqkVwy6tWlBRm71yjhzbz+df8Sm?=
 =?us-ascii?Q?82AtyLs7ydkqNv+ZAkOnlvD3zCVJZix7Y/5/y9x7fkngN9G1ufqFfSNbc4Xl?=
 =?us-ascii?Q?NjZvVlPx12xVMNU+XXYSCr/8jq+rKqz2KzOnX6f3rnijMgE4Z6pXpoFFngT3?=
 =?us-ascii?Q?dqOB7s1jnoisDvVgVOLmjJgqRflDhvrm0K+0OLIkM5EInqW6xs7CYIc1oW6r?=
 =?us-ascii?Q?c81C82CPi8eaplpdBhqXUhchs7SSEr0UwyUG+nTiJQqANyLYntT0PW00SxNx?=
 =?us-ascii?Q?shMQZ5V0uFk2GzqsiOzQ0jGp4aFvsnR4mNZwkvYJGK/jITABapX8pqU7cEzw?=
 =?us-ascii?Q?fcbo1vSqwV54sFCoivbEiHF6GAcf+rkuI21GDrjOpMIB8bq0LFF8UorzgEgC?=
 =?us-ascii?Q?31CcoUmC4t+FfyQOu7EH0a3KIItoqmmmDWEkZjbvZQUPBBzmiUhm/9ynKaR4?=
 =?us-ascii?Q?bnBOVGUECagGsL+tw3fbLI3391Dbh2jxAi+4nR5Y7NDlsWgPkeIv+sbrxaz5?=
 =?us-ascii?Q?T8tQYbRD7TVoS1snH81DEyFTY8UmeeMG3GNJ2bKrfF3sI665q9W7Xf7AC/Rd?=
 =?us-ascii?Q?ykRUEYFbah8J6Ew8iNtbvS6+SZbmrqYwyjwRlFHexcDgsLwwvH0cnNARkgCC?=
 =?us-ascii?Q?BkjbyWmqcA00G1vxSEwI/4cRWJ/WhFhJYO+sMxM5yxpSi+Na8ECb3bs5eTkY?=
 =?us-ascii?Q?X5Lj8OAIxKNb/wcupEhK91bcqtIkVzePaJGPc4McMsZxUnqagUfoaJsC8+SC?=
 =?us-ascii?Q?zEg6f6zvYkumBa1ML1NHSd3VH8HDam9EBIM8LfjL47oa7c1AMpG36Qc4V3Di?=
 =?us-ascii?Q?qs62t4XMuQEdCZSQNaUTn6GQzAMx3t5KGFvrlbxiMgQWr+Z4LDHQKTGNiRZN?=
 =?us-ascii?Q?IVfO6CwdkVEojQcQjl0qBdsCxzpxblnnZ8i73yxNKgRx3sN5ESt1+r5ZB+9J?=
 =?us-ascii?Q?WNBl+QkGXGTWRxAONgmNRblFOX86m/11YmWqN5n/sDopIlkLqncKY+KobpiQ?=
 =?us-ascii?Q?36gzIWJ4GbYjmEGSVT7Uc7mmGtVcM2muMSc/dziM6xzWDVaeMO5JWe7cQVsQ?=
 =?us-ascii?Q?xUlCGEpvA6IoeD3c3vNZ5ddAd76gsMdxkVrx1t3Vp5RvYjBS2SUHVBbKbGJe?=
 =?us-ascii?Q?5r+YwErezsIC4T7alonE8XW5H/5XRQ+BmEoCfNo5/t6fZM54Nq4ur9NkfHae?=
 =?us-ascii?Q?1QD2tHdboVeF9XHU75rJJED/eA0NdWbeVew3y2iBPQcR6B41/few0ynVplPy?=
 =?us-ascii?Q?/bQSr06/ihujU9mVp6NAvc5MCrnF6SG4CJySTNGa2eu7u8gCu20gbYbjML/X?=
 =?us-ascii?Q?F5G8WFZ28hwuLFcQAp9rGJ+lcPN4qc0yAbLS3qO1rG8UhDyNkjT+lYK92qjk?=
 =?us-ascii?Q?tzTOqN4Wq6fY+fG5+GN9lP/5WKvUU6uwN8TuJ2QGBqmzYTmjjcMlUU6iEA3y?=
 =?us-ascii?Q?tl2RQpthtg/HyGhZBoEfBIL1yDQQjh27?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:22:33.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 950073d2-3bb2-4c4a-70ee-08dcb0686170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

This version brings along following fixes:

- Clean up some files style problems
- Program the DET segment when initializing pipes in dcn10_hwseq
- Fix overlay with pre-blend color processing
- Disable SubVP if Hardware Rotation is Used
- Fix few things in DML
- Re-enable panel replay feature
- Fix null pointer dereference under mst+dsc

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 49725f06a2d5..7873daf72608 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.294"
+#define DC_VER "3.2.295"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

