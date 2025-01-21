Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF84AC02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB2810E639;
	Tue, 21 Jan 2025 19:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nFCdFhLS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6738E10E63D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU/n3h9EwXhYMVJmVzCcVENeD0Rz72/tS+RRlAChZa/2NSPz/ZmDjsy+IEmT0BPuZpnDysSTfhVXQgZBbOFmmsdanW6rUDrHTtfsSZZLmPS2yXFeTJchspAsWlWpVFAP01KQWQSk+yz9DbYxkXjAmz5zGUxktFS8MdTGX6rpG3migXWjV2CA909FioH0PkXHiCNJsH047mvu+3M1T/MjONZU9eZBEQCO6Z13yk7eogGOlwEbbBeoZKsBA2iGOAiEACny0nOfnF2wNPSfMVkltx9f6/szQw24WcM7R+Rnd9v81o0ZZ+GkPg3jLkCh1ukkkY6V0YZQMZPkG+nPBAASeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8JdWKIEBQLaweJehKmPYPIRdcQarKXVXSHqRtA3fRk=;
 b=OVPcsRvRSkEeh0V6i/KR7LlaJNrmdtPV5Ue4IT1qHeRzL/y1VTIUW0lT5HRxuDtBjhAvjjsAnH14owZm082bJMqyODtZrdv4dIQTuYMtdXbD5Y4JQM8h2HxLI/og0dIxg7trnl3lTezoiUny8UhHjaklJhfUIH0mzUqo0aOV/yGFLbXd3kxRXY/EooSAXYMR7xumIIsfhJFwnywMg/KZGwcZehcwnZmOGj3EPci2ONTiuMhKOkoLemK16bwiV8b+/yMYW3pttyobunxlXUnuMfSqt7tKX8TRHlOyG5dPvdN1oHerYkeeVhIuRl/+4/Ph7cpyevKTsT12HjFqOkhWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8JdWKIEBQLaweJehKmPYPIRdcQarKXVXSHqRtA3fRk=;
 b=nFCdFhLSb8DnE9LfXOXPzo/C22bBBuskVk4RK2o3daY6UbFEYQK/uuAjbM6yKB3WWK3W2Pg+zcx14mYF/4hZu9NxNqa4dzVdNPh86FLJ/lQEOLbuCty0uqxwPUgnoiacYsCQYO8RemFHn5ygeDlPezkOdx3wHL1CvDB81ipkza0=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Tue, 21 Jan
 2025 19:40:12 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::d2) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 19:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:12 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:08 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 09/14] drm/amd/display: Fix potential NULL dereference
Date: Tue, 21 Jan 2025 14:39:14 -0500
Message-ID: <20250121193919.3342348-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: e1722325-dfda-4089-cc29-08dd3a536bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tPEHO/qRSNzxudNgj7O8YiQYADwKoxiGRTn/x5oyPdw+BO8X/UC5+z25fxjc?=
 =?us-ascii?Q?gI6qvKnBc9/mV/zWdESf8dlU2+PHfZGB1VDPI9Z7f6F+X3CKH+uoDMSjcN7Y?=
 =?us-ascii?Q?x7edhSDWpF5y/yefHj1n22XF9jkczjC07PR10WYcGMh8RgaY1UJsy0UE250q?=
 =?us-ascii?Q?BJGupHrXDIjpjEsiN8Jn98LeusEi7wnTXmpXAMJsOYOXZSc4rPhI2HjfIieX?=
 =?us-ascii?Q?F5ndMCNLYMft0JZFFh1kscKGiPrt8Pzxsj18TECRx3uIfLZTyTyNzfkNQ4HZ?=
 =?us-ascii?Q?o2AHBe/F8Dxn51DNiONbNqZ1C4ORQtG8cj8vidN/1tPNnAwMhoZI9gT9o8/z?=
 =?us-ascii?Q?kycp+OjOLAucE8P565qN256u/SefKUkGKq7N80dGZtF9tKTV225W5f765bij?=
 =?us-ascii?Q?3yPv9BSeJ6Ojxh96jey7nBJ/sXCJ9Y0to/eCcXdv67PGEQMejxxQYE4qhhdP?=
 =?us-ascii?Q?c3oBz881L20cWtWxQFDzSbWImFfwl+M5u1eK5cWVZLFjC6KIlC+X7WyDcYWs?=
 =?us-ascii?Q?wF8iJmBCqMf5l44wfiFxzOiOAdhMUBl+mn7CUHVRs1ZnI0wvTA5/z3VZAn3R?=
 =?us-ascii?Q?WmT7+GSk7vJb8JXRFHxLvNvRDks7QY9O2MK8hsJCgfPs0aBGWAxHzgFhsSCA?=
 =?us-ascii?Q?hX44ngf7kEAb9KgFsk71a6O80i0DGYSpDSs73HCbAK2g+LH+Vs3IbcsBWcXi?=
 =?us-ascii?Q?BgJ4ba0/ziT1k9IOmNi5dCF1mWmJ3N0ylfBpPd22M5pVuUASHlgAApjulrbO?=
 =?us-ascii?Q?j0HxAvXrUC+XPnFkQcaX9jXvcefMONW1tym1EONFu4AhI5eLdEOO9yb3lv/Y?=
 =?us-ascii?Q?7a76FE8p96fSdJbChQALlP3ddfoMH36uyrwGUlscN4wanlk7uw+u2ZhZDmo5?=
 =?us-ascii?Q?cXBdEwgvjONpPRIOFIAx9Dy2w6S62DZ8v8aNtjDObRWymIO5+hiqRZJ2+FW7?=
 =?us-ascii?Q?5EjlA4MjUvRIRBuJdeUpWbmd4UIG2ps2Na070cRbzEFo75M0sc4GItZqA18L?=
 =?us-ascii?Q?tdOAHHj1L17R/TxhRcpXfN1MErs0YsEtGsFNGslwHyvOu/1RnejADo1hA2Sf?=
 =?us-ascii?Q?APc+2OlAhNYOJk3eUPz4Azr3Ej2kVaHpWFJtwppAwWzgtFLzTRfDGwuoK9E4?=
 =?us-ascii?Q?9Z4Qyl5RkodrV8Kuxe+SO5ysVxvjZ4iR1MeLoMlOOxDeJnbEN1LgDNibjq4C?=
 =?us-ascii?Q?P1lNsHd7jnfgjka+qrHcB6WkvwliwZg5WpVSKYdMzZ0ZsNtwx7ZHXcrUAx+S?=
 =?us-ascii?Q?bqv+Xwx4zhDPqimMmiojnxAMYIqqf5KaB9qzL8hnCR/TABfMXGQOMYJ4YMia?=
 =?us-ascii?Q?SKLwe1YG7aZQ36vqCpCpKXusI2CSbM2lKYi6yxAnQcgSgs/ksBdGWuJCavvq?=
 =?us-ascii?Q?medtrm8OJj4nZMuxKNYyj7zCR0J2OK3fIKZ8Y0J2TyUQ/+ELwvB/lCiopMKC?=
 =?us-ascii?Q?H2AcCWveoCK7C0GhEmHJAHNyQvWzZ+kENQ11h5aVZWGNKji9hW3c6A6FfnjX?=
 =?us-ascii?Q?e1PfU4rA0Ng7Mvw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:12.1789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1722325-dfda-4089-cc29-08dd3a536bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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

From: Wayne Lin <Wayne.Lin@amd.com>

Fix NULL_RETURNS error caught by Coverity.
=> firmware_info32 might be NULL. Check it before dereference.

Fixes: 352f9a9451ec ("drm/amd/display/dc: add support for oem i2c in atom_firmware_info_v3_1")

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 1d2c6019efac..d967065eea47 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1792,7 +1792,7 @@ static enum bp_result get_firmware_info_v3_1(
 	dce_info = GET_IMAGE(struct atom_display_controller_info_v4_1,
 			DATA_TABLES(dce_info));
 
-	if (!firmware_info || !dce_info)
+	if (!firmware_info || !firmware_info32 || !dce_info)
 		return BP_RESULT_BADBIOSTABLE;
 
 	memset(info, 0, sizeof(*info));
-- 
2.34.1

