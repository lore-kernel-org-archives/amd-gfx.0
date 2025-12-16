Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167FED5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBFB10E8D1;
	Tue, 16 Dec 2025 09:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ze2Rn397";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1E610E8D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWkFeMCagCnw6YWUt86cS72P/YlP2tIaqBWN4/UYgkqnWWFn5y7qJdfYnNTf1Ztu4q3FcDnzJa2czcDelwbm4/CdKs06FOnS+GpwenuU16CArC8WOBLOUGfdOTEsBcXLrI2LrZ4CLrr/V7C2rHs5i0FLTW5IXoKI8HzeNReZ1fTfxw+LpLmKYQSWPeaYqN86VmbewhGxt/r49wv8SHdbo3i1VgwzcFxix9lT4qx5voaHjaHcOc2F/5G+aW0lvRkJjJP52VA1B0hIJakHZ0GI9PtkdkYA3G9EC8Zb7AX0VTB9UkO1n+k8aCkoAY5AYddiXjpal21oI9BLq7apFxr68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q0VblERh9GoUlbx2Nf03rxmGArHFOAjgRngUohssmM=;
 b=wkDu51yaVV8E1aK8yYHL+KlONw5rgSgBEXQvFOK7vK9meui+QyAvfvDmjJjWWon+BC3RAy50nWjDOhJSysuvvMdI2XZf0v9jkCEUue3XzxwUm8POYEultBneXeb8gHmtgBwrH3oLD1Mr/tZlFfFIDN63m6rVqHsMSv5lMG0p24dIgLC7/b84OT2VyVgqZZv0X1vJ9q16Q6PjqFbfH5wIOJh8bcjZO41t9t5xfkmTgA97CT5YcMMTo39DFuWEn2qgHbDstvqnHlC265UVJ8r1GhPwbh8x4BYbBhBdY8JZZna+P69rtsgv7zmXhUnBwVhhdYAR9U/CIu1ueuq2JOI1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q0VblERh9GoUlbx2Nf03rxmGArHFOAjgRngUohssmM=;
 b=ze2Rn397jqyd9gnifbNf8YpLIWIwoFX6kEvB6lS9tzjv4Mg+U0EwdRTvFTkd5PmJx7RF5SPL0nu/nPJl3x1OKusB11+88il4uchV2+IzlDDsPF/evn0tN9umMLvTTm6+/kDOu0cB4Qqj8qc4qPrEBHluWOmND1AKTSGVLK9Ovqg=
Received: from SN7PR04CA0089.namprd04.prod.outlook.com (2603:10b6:806:121::34)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:58:33 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::c4) by SN7PR04CA0089.outlook.office365.com
 (2603:10b6:806:121::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:58:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:32 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:32 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:58:24 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 16/16] drm/amd/display: Promote DC to 3.2.364
Date: Tue, 16 Dec 2025 17:56:16 +0800
Message-ID: <20251216095723.39018-17-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: fd175e3f-e9ee-4e82-b98a-08de3c89ac74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XB/x/XPPGnR0N3ta1iXs914/WwHa+VJ68dYUeHEMMfTu9tTdS/atcKkW4v9O?=
 =?us-ascii?Q?QTHTADxMjn4lPdzLZgyUvhkqkp+YKCUOOyX7c6z+969QOlHvfAtKZz+Yog+F?=
 =?us-ascii?Q?hY1M7pm1p5DQTIOjLOx+3pa2w8a5GlLudRSQ5Ooxf6YWhaNnRFrIK7eTqRTG?=
 =?us-ascii?Q?4UPV185ISivIcLTchBudhvU704U8cHZ5RTdX9tUiq7310KLKskZiMUz0i89V?=
 =?us-ascii?Q?Vyst8Sb8nVE1WqSI5WjjdeRX9xW9XtIRB+7GF64YaYIZj+cmJWLs2kBJehgG?=
 =?us-ascii?Q?iCgtYyZ+IKWEBd5RcLZzLhtkygMQ2CIEZh15nVPaSAebSvOdrd8YR5X39T6d?=
 =?us-ascii?Q?8WE2x8G3oOC+XF/0n1J4SX1HTaWKyK0+UUCGfl5aEMT+vxlDZcbZ/R/PBsvA?=
 =?us-ascii?Q?5rkdNpX8GMC797VWcemFxzv4JsYkVtCeH8Xio+ewqePdFJh7fRoSyr1LnzY+?=
 =?us-ascii?Q?XECGYHu62Xu8Tx7QkXrxQWBCTGGDbBqpV5tz5YuGyzptmp+vF8ZpjAIaNz4B?=
 =?us-ascii?Q?4tIUG/k0kfnmCEOUzOiKbeZPCKWQTX4jk4LUmrv+n85andV+XAchr82UmNDw?=
 =?us-ascii?Q?wmTLGJWLq025wlA8aE42Wd+go8UDSC+WC2vjB6Z9Ivf8wkRYF2E61qHlui4g?=
 =?us-ascii?Q?2tYMBtg282oPBTJwn5DCGDRf8rXKg8ANJnijbdrLeGiC6RcFJuQS92eMs/xa?=
 =?us-ascii?Q?dk85AXnKyUuYlvKwxklP2t8XdkTx/wfeaKiaDMw1tmmX0VBZdieTWMCpRhhb?=
 =?us-ascii?Q?rEin8o4x3QBEeGEY6QLV8eMYCcL/MAHXV9AHaAg7WtQX0hjpg6FK8QyPeZgJ?=
 =?us-ascii?Q?uACnLUe8Clvl0jlkNlAVkWYiDLm0Mn1pvpeWl+UuAiUpJBpAosAfe/AxinOM?=
 =?us-ascii?Q?AxH50eqVnOYG7SGvXxVvXVxNoLCtUFnQbcEsfXcz65HE5AF1ALqWzgExhr6Z?=
 =?us-ascii?Q?UYv6V8J6qDpLxvpY4+L4Ipjeqd/6A+CLGTK8cRVaJXXGqmZe8VBaKmx9KNGo?=
 =?us-ascii?Q?T2lqtY7b5MB0XmBBxCPtsUkkMELnElXHZaoJOjNOiCKjkhp19p7+B8RpZ/yP?=
 =?us-ascii?Q?9VyDN1tcjLf/xibgsLM+DmfSWVqL/tj+4o7S6K+8OpDvWjGosmhvIDWs9GbL?=
 =?us-ascii?Q?ZS3Fpd7I4LjhD6f8O9HYKwNJEn4Ebp9XGmD3pjRCW1xUxNOKu8Fk9rWl1N5w?=
 =?us-ascii?Q?gCi21XKK7qhTjZG1UWQzt+H2yGthiw58faE3PXsfZB7BHe23GMQi4i4GkTKr?=
 =?us-ascii?Q?pK/MbMW3F7QcnGEkUbNJdqn+71AvpfDEzHVSNkEr0vXTPP9iI1c3YDz5M4Gj?=
 =?us-ascii?Q?cZyktLA3v5z5Vt7e8Q/LdzmH5GAAyvjBpiDtaZAqeYrA5M98hK33p/z95KRP?=
 =?us-ascii?Q?bihvRNu+6d7VejONxLTPIAIUmWMNjMUX2tPdVMpuQqDuWr6ZKoRfP0tWfilL?=
 =?us-ascii?Q?NcJpXI0mLwIS4izL90DB2o9giVzr6vn5X0cbNF/Z1oZPK77vovtBTfBhpEuh?=
 =?us-ascii?Q?diGjsWAwKTZNAfs39UVjM4JYfZ28qIiTRKVNjXsn1J+jv/mZHPZia6ViGUGA?=
 =?us-ascii?Q?x9bEyMOVH5tMfL8il6o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:33.4111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd175e3f-e9ee-4e82-b98a-08de3c89ac74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Add frame skip feature support flag.
 - Add sink EDID data null check.
 - Update function name to link_detect_connection_type_analog.
 - Fix mismatched unlock for DMUB HW lock in HWSS fast path.
 - Fix P010, NV12, YUY2 scale down by four times failure.
 - Fix and reenable UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL.
 - Consolidate dmub fb info to a single struct.
 - Add new fields to fams2 config.
 - Update timing source enums.
 - Add signal type check for dcn401 get_phyd32clk_src.
 - Fix dsc eDP issue.
 - Remove unnecessary divider update flag.
 - Update dc_connection_dac_load to dc_connection_analog_load.
 - Check NULL before calling dac_load_detection.
 - Replace log macro for analog display detection.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6d8e6c3531f2..712daf09bc12 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.363"
+#define DC_VER "3.2.364"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

