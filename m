Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C579CCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E79510E7C0;
	Thu, 20 Nov 2025 18:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t6oC6cKB";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6429210E7C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwMr8dzVdwL28EpjoCdtNQ5bfRq0XYYb5kUHUdt0B2t1n6eX/RIkZ3wxGvvjclFcUb4PP43cHD1gF78D5KU4DKTybtWW2useITmgWGTn3ZNbmgJPpLRb1Eyjtm2rH/8kM+t8E+ehYTrvs3WbWfzO9+SFMMPy1HFLvOMmdaZIHhrArIQ9iSvhMsMoZNC6p94WbXrG0tKAt7jz/IgdMH9jClLH0XH9h+XdPJYzPZVxQeYN/gW/sgkchwh2LaB9BBU2Z8UHTnTdks4WnehP04DjMgf8sEraImp2/gKRCPHsCZI0yR6PSFMbSKTMUrtVfW+Z0xzrya8SHimK2GOnrcCT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWzcNLydyAGVCkaWCtC4jMHszitEs2aYFwzX68qDfno=;
 b=e6c31lHYhiebImiidSz15XftgsRXj995apF6wJeze73uMgQynPcvkccTrE5d0+vjCn57uzQQ485tqw+4dH5KACXAWNGuBx+MdKXb4pbZu2wK2hwYebtbiIk16GnnKywJtgs/6MIOd/OeWE/IQflypgAG+RGhPdGVWB9ObrpQagrtIo2UlQ+uwt7bBIErHHqZZs5A0GVbHLoOSMavx9aPmOC5UGSkjfQLNHBGmJaiawg0eWERtszaJFcOmxh8u1Xm8A5QsIWR96UlsgoF/tbBDVE/vMKzaewS8qVd4+DM+VSUU/gj+uUJVLstc+a2WCDBUQgN0P08GSOSjP2dk7UKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWzcNLydyAGVCkaWCtC4jMHszitEs2aYFwzX68qDfno=;
 b=t6oC6cKBWH6/Bjcxf1gL9CAImPXIjnOBGqni5eUd+hOwHeyX1KcttWyZhDXK4eq4Q06H5SyiLiD1zb2otoiiHXmvBT70lD57PvuiJRlOA5yhqcuCzGgzbSDiXZ6k2+RDMwlWNZlX9zRugpIuTtmlTJkwcr3RfkKbxZav54wXCCY=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:22:25 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ae) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:22:23 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:22:20 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 22/26] drm/amd/display: Check ATOM_DEVICE_CRT2_SUPPORT in
 dc_load_detection
Date: Thu, 20 Nov 2025 11:03:18 -0700
Message-ID: <20251120181527.317107-23-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ebc467-1cd2-403a-e895-08de2861c025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fv91jVf8BrzJyMi4Nrpty/aA2v090xzC9zOe9ogvT6d5O9rL4py0hQIWxh8h?=
 =?us-ascii?Q?nyDq97prvMdBCnMEaXV5gLjs/1uN3VmG6VDGu0vvAJAXBaZaZQdnVjzwQO+j?=
 =?us-ascii?Q?PC2/MxkD2jQ+/YL33DJiSvYCNWJ9uNfF8B7XAgojOglXnEz77ovdBMBS43VC?=
 =?us-ascii?Q?BdTD4dyCQbjduPUJGdL3ikrFtb70KhK4+NKz9XdlC4OsJoJg0BYfm113nBWM?=
 =?us-ascii?Q?8R7uWwuuog9wSgrQsdGoDlX69RNfCZOdFUwuw4apAKR8KvZ2mvtnOhfuQZme?=
 =?us-ascii?Q?XZXq+tpMKml1qyH8AQgkI1wkXIyE9qDRBBx3Cz7b1Jdzc6FdDUpSs192kaYv?=
 =?us-ascii?Q?ypTFIv55XYYr8pscFTuyvlUfT6I/XzHbU0B+H7O5xZBLBYtsPTeNuvyAFBgV?=
 =?us-ascii?Q?h4j0zxXQ0OtG84I0QW9Hh6WLheFHSkKs5cJSPSbIjhPZygMA/r7rplGAZ9yG?=
 =?us-ascii?Q?o9ukmAn6C8iXtfscmG1bd7ZsUKch7RDBZxZcccT6t4Uny8DEOQEyXsvTMdAN?=
 =?us-ascii?Q?0dWZDb65vkCYD6dITxhQ8AqXmxzW8QX7zoAWZGJkPrPXihhsLwBNvOZB5kpv?=
 =?us-ascii?Q?CKevmmo//LET1wfgn7asWJO4dDJ3Fd/9ZiPIpPzbVM0fcf8tSSoHe29dS+QC?=
 =?us-ascii?Q?JGNFlpbg/3M/W8yiVwLLCUuRPYX6CbCByMtpBBX+vx8LXhx1KkUvtZ8VYgD4?=
 =?us-ascii?Q?XBYNDC4Tr3vk1tM6/xbDzgjGYl5CYbuZzC+aDXcWI3lbncAsuiOgD1sS/+2W?=
 =?us-ascii?Q?TBM705O28V2BQp6WPyFHkYshi+SBBhxcmI8+pfIdLPopeJj8a7Ca/Dsoy//1?=
 =?us-ascii?Q?2RsxEdxd1M7fpvWOcyeyFkLYVKHolSW8EuhlWtnGriCcB+lzSTgVsw1Nu8Le?=
 =?us-ascii?Q?Y3IBa1B7GvLwYfP2H+hxWutuiRWyBoF0dO/WPxpKTJz6Uv23+a9xEDD5J05/?=
 =?us-ascii?Q?jIyM6vZMbrObQCBmYHZia2Wy2ONNssXvn6uIV3IxBCvMbC2gY8hZjGsECml4?=
 =?us-ascii?Q?MQrc03VQUG32t0tmXTGHiaQg+WR1G0T3JrbND8Xxfmpxr74whSTh4oqcec8M?=
 =?us-ascii?Q?aDRGd03R+8Xt5mbGGDwkFQAe4Qw1PvqR1RxEi7bpbAGdYfIB3TaGL0A3xmi/?=
 =?us-ascii?Q?OPeNqzAjv+ODhP84hODFDhQvdi6PILqSffYQRQg5ugqvPGaEseH6yjg2FDUx?=
 =?us-ascii?Q?Bas89y1Vf4YvhthjOjU9ZXde5Mt3Fu/YVCe2U65NsXq1PhtI7QDYwELt8Ps+?=
 =?us-ascii?Q?GY2f3g8PwOwymnFg/9zGzmbAfeaS70Ok0YiStNxt/anZly58iARF4m8L9J6c?=
 =?us-ascii?Q?7wj2gSQ5cq7dyH48IpNH4PE54fRm1fk2t9v/UfBzztSKm51Rfd1SIHTE86wL?=
 =?us-ascii?Q?n+GT296JzrgH4MBrFdPhK7bpMUWr5nWfn3jotEH7WDNFbEtK6jA63ZPLlOHa?=
 =?us-ascii?Q?N8hkn98/qZsiFDXG4+zpxkpTZ6Keng9wSE1N1gs66uoaxeqjuMDPZdSKdlNg?=
 =?us-ascii?Q?Vgyyo6Rm1O0pf9iuWli/BqhtkKBOcUcAk1FbA/qmZTj+MInL3icjem04ZvFp?=
 =?us-ascii?Q?Q0z2Pf3MZi9HFDWJGZQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:22:23.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ebc467-1cd2-403a-e895-08de2861c025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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

From: Ivan Lipski <ivan.lipski@amd.com>

[WHY & HOW]
Fix the typo of the else-if condition from ATOM_DEVICE_CRT1_SUPPORT to
ATOM_DEVICE_CRT2_SUPPORT.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 4120d6c4c5e4..d1471f34e419 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -805,7 +805,7 @@ static enum bp_result bios_parser_dac_load_detection(
 
 	if (bp_params.device_id == ATOM_DEVICE_CRT1_SUPPORT)
 		device_id_mask = ATOM_S0_CRT1_MASK;
-	else if (bp_params.device_id == ATOM_DEVICE_CRT1_SUPPORT)
+	else if (bp_params.device_id == ATOM_DEVICE_CRT2_SUPPORT)
 		device_id_mask = ATOM_S0_CRT2_MASK;
 	else
 		return BP_RESULT_UNSUPPORTED;
-- 
2.43.0

