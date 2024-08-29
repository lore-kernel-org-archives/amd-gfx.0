Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAD3C83F16
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 13:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C546510E6A1;
	Thu, 29 Aug 2024 13:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x60js+rR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E41210E69E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 13:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtbMty5Np4qDqrs+cSaQJdByyNlYEQydKt/5M4r8m1lye7kcf8bxc5ovV2mnlH8LK0xQDDlIGtgs/t6Ztqe6+N/AdGbo0A42Fl51/SWlYLYH9XZUXrVJvLkVm+dxCdUOgkN/Vi01O+J0hEwTZhJK2rZwswRUAukL/S1zi0Mi+UFq7SiVx9kkMlKZLDLIE527tdnRuuObJV0XpXizvSUDOZuvgIr0M/VBVWNeoMqgN45nZ+Ko5xHUsH96QMeyUVc6JWA3605In/by93niyC1K9CfKKRmxq+Qz71e4WJ6fXF2k06ndZWjca85292pcTkJwrQzHQlGp/KNZ0/6XywY5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KKeErloJqiah8bNSq3cTCVVwjvdp6XYnhONQf+H2dY=;
 b=xFA/H6JIFitDfgVC2Km9EOOxD6u5L74eeJZSHr64SvG9UYxtBmwJu6da6LMti5mCsI3gh/Q4uABm6O+jxlh8MsJ1l2cF77YVzReZG4aE+ZBTqHQ0HzkFR1MI5z1tRpdFirwHgdvR0VifIK+xXff1JjJNZpFpIdD9BUMITqjo1BXk6izP/O/i+p+aDYDrPWYRoV1Zrv21B7Op6yg0mqPxnHyCym06dIEu+oCZopINddjaRWSgBVniFNHF7DmIVrtSu2n/Ydg6DP2YCLzmyzhGezcXLrBN5K6+qfbyWtMS2MQzNZq6FkqfqBlMogpFOhJTPQcaF2VspIiLBgRTzoP/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KKeErloJqiah8bNSq3cTCVVwjvdp6XYnhONQf+H2dY=;
 b=x60js+rRf3eooDM39Mju7cCOL9btTnRV/wctfwmbyl5QiWa3Ih7ji+YnvZoYNRpAkYpEurlH3ayNJ5/3XcvM6fYiiI2GUNU6n3sN2HaYGmPzK8sO9Kd44p5phwSoclmV4vICTGlG+5ejLTjBgZASLqAag/7/DZ4FmncgCO+bP0g=
Received: from DS7PR03CA0346.namprd03.prod.outlook.com (2603:10b6:8:55::9) by
 PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 13:18:06 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::cc) by DS7PR03CA0346.outlook.office365.com
 (2603:10b6:8:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 13:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 13:18:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 08:18:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Add missing kdoc entry for
 'bs_coeffs_updated' in dpp401_dscl_program_isharp
Date: Thu, 29 Aug 2024 18:47:45 +0530
Message-ID: <20240829131745.1828528-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1b16c6-4d24-4d04-99c5-08dcc82d048c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+B2u6uxlkRVj2jIMwZLKI1NdUXFCiebX2mWnyiUKVGHnXcTuW2odp64vxriP?=
 =?us-ascii?Q?HBxwr+dSXkyTCiBKwviPsjvrVI7mDI+41BK1NBIkwXVarb0UmZBuEGV7OjSG?=
 =?us-ascii?Q?sogpSglKbQOhEiExGBmIPrBQin5x/75mAkCjyudQuPFN7R61TIp72asc7ulK?=
 =?us-ascii?Q?JydT3Euxnr8V1wqu+zjJXV+znVXOVDenOvMMCJUxirLn6G8FDko4EFocM4cK?=
 =?us-ascii?Q?ZGKG/8q/8YauiPXXx9nmfNTr2bz16Bz1oHPuOHeO4VjwlPQ69w/hpbvnex64?=
 =?us-ascii?Q?DIO5QJrs4hZbgD7h9b4L3ldCHnvyCX5NCiToXBMp1dYKORuJZfdZrHEcrc9x?=
 =?us-ascii?Q?n6gDC3CGhSLEkMhbjtmB5zsPOtCUogW52h2DOOw3Jc0fY8GMTX+YY2+1u3Ud?=
 =?us-ascii?Q?239Bdzq7GEF+tyQAPh9Q+zYQCUQsChciIXhFpyJ5B2V32jlHXCE5VfRQhgDz?=
 =?us-ascii?Q?RKIKVJHwdlImp8npf6bGmTokTb3jXFYtBGZ5xrYo9fAhVvY+V8TFz272bmPX?=
 =?us-ascii?Q?IliJnrPXqUsameT0dHQbVzQ8zSswUpJcYBcwbDsFAgux/czIoTY11oY3H4aS?=
 =?us-ascii?Q?hMLdLRAux4KKW+EyJRM/g81QRC20LAo/Uet0z1Ua9s+kS7ntmZvjs/QGI09H?=
 =?us-ascii?Q?x2Zy86hRrHNOfT2nDZuu/Pq4eD77GTNEainZqgZ4BVpA3sPymmR+0TCdhiAk?=
 =?us-ascii?Q?380R/xg2gk60+199HHua0jbN4yQLugRJqQ9y5CuyFEJ+KSx5fNrZkHJHNsCg?=
 =?us-ascii?Q?Q/Mc+icNixpHqbYnsNKiYI2Wq9EWF/nydANLU/Fo8U32FJ0X7EgjP7NTVlRO?=
 =?us-ascii?Q?DpP5UrTCb3JIGmXlvveRr+ogahPBP2Nakg0S9Ikn4vg1ODkwZsPoR+8CU1Ej?=
 =?us-ascii?Q?NwWpbCyrwm92dbtKswIOaOMW2WkTD3dgdhZOYo/zs/DrPVykViZeL+kfuKuX?=
 =?us-ascii?Q?/vuxdup+r/+iE+TWNwUAmVNCHBxThuuSKEtn/vtT9W8rRfkamZk06n5cQTqv?=
 =?us-ascii?Q?bMEsZ3rxZaPS+H4bzenJD9GHsRHpt+s9S3SzDGvhCWh3waXdhTkjzJSgKU2V?=
 =?us-ascii?Q?dX9a6Twx67g9Ed+FMXEmllfs16RPui9mhe6BrI4dZlA0sD0fZTCJGO/aSIar?=
 =?us-ascii?Q?H6qLFTFnV10KIfoW1HbWMaluT1uZkqNBIF0YHF2kCHzuz5NSagfxWliNqfOG?=
 =?us-ascii?Q?jaWc3LxLCQ/kHu+BTW8ShHz7IQ96RawKvIAONqaiifdD3w5vPNPZejcjjzo2?=
 =?us-ascii?Q?35PAqyQgu80oFVZ9e/0YjnxUoyVIXDq42WSeHNeRJKvEqmV7byEBlAqNbkMh?=
 =?us-ascii?Q?F6jR9JA6VXwCDHQ+eUE75KCTAruNUTuPoIB3BlOo8d4IC0AjPp8+LCEiyR1Q?=
 =?us-ascii?Q?S/fO8uyuZC/d9tqkIkU1/rmyQd2gMqghpmHynT9oGKV32pnLCv7hw4I3fCTG?=
 =?us-ascii?Q?G8LbwoSARcjTSiuEzG+eqHr9+PH8YWg1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 13:18:05.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1b16c6-4d24-4d04-99c5-08dcc82d048c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

This commit addresses a missing kdoc for the 'bs_coeffs_updated'
parameter in the 'dpp401_dscl_program_isharp' function. The
'bs_coeffs_updated' is a flag indicating whether the Blur and Scale
Coefficients have been updated.

The 'dpp401_dscl_program_isharp' function is responsible for programming
the isharp, which includes setting the isharp filter, noise gain, and
blur and scale coefficients. If the 'bs_coeffs_updated' flag is set to
true, the function updates the blur and scale coefficients.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:961: warning: Function parameter or struct member 'bs_coeffs_updated' not described in 'dpp401_dscl_program_isharp'

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Tom Chung <chiahsuan.chung@amd.com>
---
v2:
Updated to "Blur and Scale Coefficients update flag" (Tom)

 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 703d7b51c6c2..4d8de1b8aa62 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
  *
  * @dpp_base: High level DPP struct
  * @scl_data: scalaer_data info
+ * @bs_coeffs_updated: Blur and Scale Coefficients update flag
  *
  * This is the primary function to program isharp
  *
-- 
2.34.1

