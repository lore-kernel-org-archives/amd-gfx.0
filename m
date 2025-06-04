Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0824C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C7810E7F2;
	Wed,  4 Jun 2025 19:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o9iE5a4b";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E0F10E7C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHi8GtFkZdBcNgdq3Mq1Gtxu0SKCu9PpyJ0CeNuIaB/HhyqIEfm+q6sd/XhNkRETzv4aDDk+wg2ggLWAwF8K57zPn0F5EVMfdW3KQv/XHfJ2df+REHDY39hrYq4oKxqNNWbouGmUQAAGIlzKl/QW6Hgtq6+MNLcZmrsyXLNL3JjUFkfYW5PWrNimAQLcBfe0z+7gXpgI+zST/k7xAc7FyXxJbp4R6x0VAc5wrNr+yYFi3ZUJVgTXHfjuXWamhPCurWQTeFvXQ+obk4KTOmbmEp5k51XKcwVtrIeLwkRjp1ppiXfEgJdj7KTgYvzYYGJ0m3IsdGVQpmEVjUIRML8fYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV+sNre4n7thFoDQYe0inqYkm4zDnLDH9k4Hj+PdNk4=;
 b=T32DH3jEKJ4T8vhj/hAUZ2dzQtD1w7dxDnfwDUK8UEhoTEeoFU8QiNmKFb+qbwm6qukl1prq8krhUTE4YNvK8CrC30K5AOvJI7k5cAswlP68fxcJRn0HB1eknSy60I2MuoIhSfzRT4QwmKGsUHxugIyMk+EpTRc0s0AwlU3L0yYNB8mXdZEbzFH9EL5FvJtw7ob3MZOaZGG4JBjdP65GgrZuVgKqLffQEZIvCWWOjnGB5/FYDSaU9hWu3Ns4hHMJL3L8buJGvaIiOTEQ1hSsFd+O82hVfTJuUtf8VKhB94cfphnhamwvec7E96R45U7UkpmST9X3pJJcEnetphoh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV+sNre4n7thFoDQYe0inqYkm4zDnLDH9k4Hj+PdNk4=;
 b=o9iE5a4btmamwjBo9mx77gEZGS0ap7yzkzb90C06o/eIWNxR60qxz8vmjBKGx5CxtKvsFTrxrRErbCG/ZRA4UJ5vlOrskbnN1xAGoUABbjKkM2pYfMJ0psg3Dp/VnRZTC83uNi8vUpTH7PhjeOWgEdqSfrcnBthuWwW/SRPP1QM=
Received: from CH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:32::8)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:39:37 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::7d) by CH0PR07CA0003.outlook.office365.com
 (2603:10b6:610:32::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Wed,
 4 Jun 2025 19:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:39:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:39:34 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 10/23] drm/amd/display: Update tmz_surface type to match
 register
Date: Wed, 4 Jun 2025 12:43:21 -0600
Message-ID: <20250604193659.2462225-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d03bea-c023-4208-884e-08dda39f8a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8w52fnIvTDtGJaewnY0iJAVRjocR5Ns5YMqE/1jlqZFyUakpMlVZfEP86PLW?=
 =?us-ascii?Q?0A/ilHirBTVhtPw4yeiEpAUYzBy/ISUmCwTm0rMgArCLoQT40sK3XgR8HoQY?=
 =?us-ascii?Q?yD2yD+ATPmq7JmjVZHOk5RAdsSjfk69e256XkpgWnOnXqjunvrioB9vp88to?=
 =?us-ascii?Q?ut4zjOgpjlTd5yWdSR9vEjiD+MWWPHozGp0gEOr4LZBTo/yLU3IFcZT6H8Uk?=
 =?us-ascii?Q?C0zMomTrkh/UPyvgJHOmyeVgV1InhZW5fT90pwUy6p1M3iqN09RI5LCv7S/p?=
 =?us-ascii?Q?w/baWrIjuuO37PDjNkA2rK1nuHImJ+HRFvi7wgdzb/iMAoTJNktP1m3DOqS5?=
 =?us-ascii?Q?m4WvzEJYXbwlfJdzv7tpaEQp1YceZf7mi2ug0f76sV3Ek+t7DMK1O+HQ3EFW?=
 =?us-ascii?Q?+X13sgw4ViKpMD6L3ZDGd+BUCLmyYByvbQLSLiU1zpZRcAVm4E/FNspQ/Q4L?=
 =?us-ascii?Q?clSf/btN3i+28wy67GG8I91AXlOaDisH4qfUbBvZaKA8f71z3NERFk/zk882?=
 =?us-ascii?Q?k3pbQcniCdAi5piJHqDe8n4UyhKimzZrrXCQfsAxZgbmYU94uA8TD0OLVBmq?=
 =?us-ascii?Q?JdUW8LB4DJs0+dmk8NLQuP30+m2Wy9Q0l68dzBUS38zSZxyKD8zDnRc3A/Vr?=
 =?us-ascii?Q?niUrh6+xs/FcFEdj/ftheR79/rxo+wqhs88qFR6gX48j5ryO8b9yObuV1cvZ?=
 =?us-ascii?Q?JMO6giDWQporT03/c0Gl0h1kJO9sAH+0sBW+vCWcC4Vdaa5v8b9GA7s9hRxO?=
 =?us-ascii?Q?lp/Fb8w7+fMX1ill+JsmCglkhNqLlS71lVxL6w6d8j07yngBBveSz8SObXFK?=
 =?us-ascii?Q?JHnr6TW+o/f3LzqbZtL7UQgcqAkP8oNtQD6nTYHnRJrozNPndYWKNW0GfpyH?=
 =?us-ascii?Q?iFnQ/KTrN2ZWR3A7dORokXftkP6L7qZblXPKFVGHgoUV7Rr+6Q1ya4x4IyjV?=
 =?us-ascii?Q?785hlZyO1+ca7wGHdHROXrY9yjyEx7aqd9jNRFCbA5ry/RRvb1qoHQ+80Oin?=
 =?us-ascii?Q?odt2FMvHHMeZQQQjGHvCwRi3haCkumC/JQwJxmxiALBIbLmAm1I4lbwv+BOo?=
 =?us-ascii?Q?Pnu19Pq72jy4FIY9kztjH30Y5lnoIYWehJ/I0EC+zl84fZWaK1R7oeUqBGBQ?=
 =?us-ascii?Q?nsEq6oyMXI5wynQ4ZiYM/OYK0EmaC5W+gl4PlA426GCJYmXK4GZVhsUbO/yo?=
 =?us-ascii?Q?nXAxQmPQJCIEqLXPJ0byBNN4Yy8/vFMGzCND+4i+8cUXrI36znhG37gWhfNd?=
 =?us-ascii?Q?/AuWM3s7ScePGb6Esx38o6XJdgeqBX6doqgq1iTjfRqI8hw98YW/LwKZT1+d?=
 =?us-ascii?Q?NlX+Mj9YiN7XCO1uPAU1HcZcPbe79AEPPD8NySIlNbqqNVcjOPdt3w3Jqc2E?=
 =?us-ascii?Q?7SxaGsjMuy0jyyp6FNdIcZOOpe4ZI3l2DQ0qi6Fm6mP0P/rVNqfec8r9G3zC?=
 =?us-ascii?Q?CLWxwf+iQisSb4VbBFRxkmyqy/tJyG+itpzpE/aMrIUqVsRf7KHDgXgSIFnH?=
 =?us-ascii?Q?NOXtzu5loKWTUJdwOy7Nskh41VXZqYZJtCfw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:39:36.6816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d03bea-c023-4208-884e-08dda39f8a0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[WHAT]
Update tmz_surface's type to match register size

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index a0e99db61410..809fc696962d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -68,7 +68,7 @@ enum dc_plane_addr_type {
 
 struct dc_plane_address {
 	enum dc_plane_addr_type type;
-	bool tmz_surface;
+	uint8_t tmz_surface;
 	union {
 		struct{
 			PHYSICAL_ADDRESS_LOC addr;
-- 
2.43.0

