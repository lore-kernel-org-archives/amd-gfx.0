Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C495ED39013
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522B210E67A;
	Wed, 14 Jan 2026 20:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J1dsYpJX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D88E10E67A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYFUy0VD0s3kSmEAsGCArFflJGCk660SNNTLPbSqoEpQiBzmESZAaZ+/ntBYkSwvvMg4b4CAF33YDHmNqyhBjSFRJD+Zg2iHtJXZksnyT2PqV3Q4XMlLV7F9NjHG1VhSLIrmlmYCcGF4kPiLd0LF017bKQxhjJREDkDOeBliXr28CjihCD/1MteTCgVvoaCMbDLsMIYT3SdxyXLBWgqdyjdvTr71KWXa8Wd9yTjUhidwRzFaIvmG9nsQD8FrjTxk2lDbzmHIfAk4sw/xL6a+buv0e25328epU8QhbYcLBE8MsuPaUBUxeZmdWF5bGpHOOxU0j2oGmKWUWJc7iM6WjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+zua5zmVM6568KVIOGmdpM7wgme7lBv+ot+HQqieiY=;
 b=mYc8ETTwv+XAR25/5XcjAFKbEiFMA5iZPrcDBRSq5o6s2PCWhTLn/tU+sr2dQV4I5O1SugDKhsuibI+tq5LIU/Xmz13yOdz9SwqbW8ukcgS5HLr2X1hSIaseNiTAP9SDQSDSiMhfa6qO1tTFvJC7AvXF4URNN965LlpE41VZs5OOAh2lwPLbWYCOtAqxkJWrp8SoI4UVQBlVtI2HZT/rytf1BX6BMPHFD7u9Dmt4X26s58zLMox5rIfVvAY1UHjwjUJj7CtqMasrWZzn8/lRzUfN9xxHNbpIxu4wWn+3a0Cy/aigwQ0wRkAxm0GxrKvjd9O/om1oE1np+2i+Kq5jTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+zua5zmVM6568KVIOGmdpM7wgme7lBv+ot+HQqieiY=;
 b=J1dsYpJXWbY2pPpDxl8vc0rOA/lvFYlO2leY1t0DNdP5xwdBwsqaqny0L5Eakqa/ECuHt8i0gNcSiThzootIOB7Q6RfPa8bNVKfp8ZIY4wBIi6pVcKxbcSLPs3N9OxYmHJQ9Qra+sjyV7k7awrwfdxN2GjfgYBA751gls0q2Q0I=
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 20:24:16 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::b2) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 20:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:15 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:14 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 14/14] drm/amd/display: Promote DC to 3.2.366
Date: Wed, 14 Jan 2026 15:21:55 -0500
Message-ID: <20260114202421.3654137-15-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 19039b53-94e7-4a22-a221-08de53aae35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?upolP4fZRfKdj1UMl23GkSyQy+m3lKAb9zowZxm9g99ELB/KM0BA9qlN+z1q?=
 =?us-ascii?Q?NKyuUb78unb7SLp/xaD6B9TzPMo+ApwAh4Xa7J8ybJ4eZWPmbjLD55WAt6ET?=
 =?us-ascii?Q?IcTE9YO5xG7mvyArJycOKDoRBLBWHesMLSic3JaVbyYjLjp7KrJfEexAv1B/?=
 =?us-ascii?Q?ecIonbyp8g4S8ZkOMcTFxh8AXgXGT2eTVKDTGS7fjFMYnRUekfbAc93YHW1g?=
 =?us-ascii?Q?PKBBFNBDwgAUp/Y1CTn3Jr1ARKObCZvvjsEz58FyfBDXuIKkUChAV+Qs9vJJ?=
 =?us-ascii?Q?ZglKHWIv5DbDRQw9eDvMvFqrDIsfYpHOplDNMdsyfvpZuc+T84YB71OOnJw7?=
 =?us-ascii?Q?Cj780RM6Xiae+rqOnsmoRxKxaVEl8qd9txp5y/HEnUx8gh9Nr6H0Tkr8iEAQ?=
 =?us-ascii?Q?yMG/Zbx+pZSQiArSLW/cUI04eUycf350f3YCf/dWWMJmUVEmFocwEjAO/JOh?=
 =?us-ascii?Q?4pWiVZrRQ4CSbRurTKJPerWHKwT+dSbB2/e1Q9JXfYtqmHF4Cs1RzlSxQvek?=
 =?us-ascii?Q?8ea/4ZXabvVnTaKxwUOkKjnYR32wHcKiBDGNXWBBIER/+ypWR8O1aUcGHNWt?=
 =?us-ascii?Q?BXouXwI4/FqEcZ8kZuT9uR9c/TyKefuxMqGtxxCupWgLJG0Nop8RbEczd9nR?=
 =?us-ascii?Q?NWrdBhB3o4mDNeWnhoYnn137elBmf/PC0CSOapfSV6vQOOPRQ3y/IJa3RU81?=
 =?us-ascii?Q?+2IFHhKsfu+HafYcDZXffa+6LtraLU/WDhjbNJ/smW+VfnJFud9fUju/nj/2?=
 =?us-ascii?Q?5pTFykVJcl3A63DY6gybW/+2lOEikfjA2qrhiU1qDQ+j0SIiYdepEOrMrSsJ?=
 =?us-ascii?Q?URfN+D6AnvSx3hQgxEp9vVzmo/O73XHiRW8iVPTnPxVFKB3KwsbbqUZgW/26?=
 =?us-ascii?Q?8iIBYQDutK3U7hLblmg9BOTmnahGXcKqJvvLr9BtIN8NSZN4HVjm+NI3HkmO?=
 =?us-ascii?Q?qaBtLFqIUR+MLRhTdmSYXxBkfSWxoGp1KvxyIcBOCjPAHuz7VyIfpyg69CjA?=
 =?us-ascii?Q?6BTmq+9xp7vUlEvNF6g2rw06l5SR2mXUbpbgM64LJqyJDilDU/Xv+3iRQxLv?=
 =?us-ascii?Q?NI8fVowEvGnW5J9jZSnw2N3sWbWL3Yy2RWSYSYXP8eam7FrrxJ8o5MiYVEu0?=
 =?us-ascii?Q?CrB0n0fzpfPa8DoQ08pSnCy3Tx0sU4W+8XPXphtgvdi39cpSCUOdONMZI+B2?=
 =?us-ascii?Q?AjODnK2+VPbbvegmp0lVzMA6pQUTpzKr8eIjoMaOCn2Y907Q7Wq6vXEWCrmA?=
 =?us-ascii?Q?2JOApxEATcjgkIvK9tAdQ+Ojr9yjBfTfvtzWKJII3rvObeXzaueP0pXgLJv1?=
 =?us-ascii?Q?RCPj+GvKyqpoasKbwcy3Qf2AZCAwJWvhychDHyfhwnBaIs6oAvJAmaJ0UzNo?=
 =?us-ascii?Q?lJDXRkjtUa55sdenx8EfuTa93L9r/FAVKXvoyxIVF+hIkASAWXraN+Rh1J0v?=
 =?us-ascii?Q?erYsW2do8mYgMk8AUimcoKtRuzMnZutFNGfezPRpR4GjI3vhjgbym0a6a1rg?=
 =?us-ascii?Q?KpUZcuvcKwe4Sj8VCQITryS2tO+lfbrEpPbg5tUk6xjVhkwsQeNVeoN4HE72?=
 =?us-ascii?Q?6hcVjRG5tgSPp7oRyj5776lUVifxmckzrJkn+l+GK+FCzGCay2bLdvhqJWfE?=
 =?us-ascii?Q?43Ui1a2iEKIjLfJo2OlVHH0SMPLIGjrYjwCx+06eT/4jTywpxQKXzuJsQ5no?=
 =?us-ascii?Q?oyZ9pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:15.6764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19039b53-94e7-4a22-a221-08de53aae35d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
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

 - Update memory QoS measurement interface.
 - Panel inst for monitors.
 - Disable FEC when powering down encoders.
 - Detect panel type from VSDB.
 - Check NULL before accessing a variable.
 - Initialize a default to phyd32clk.
 - Revert "init dispclk from bootup clock".
 - Add IPS residency info to debugfs.
 - Ensure link output is disabled in backend reset for PLL_ON.
 - Remove unused code.
 - Add DMU crash recovery callback to DM.
 - Remove coverity comments.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 15b90fac723a..ff15e5990ec0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.365"
+#define DC_VER "3.2.366"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.52.0

