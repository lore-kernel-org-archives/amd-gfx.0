Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C1C54E71
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 14:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765FC10EDA9;
	Wed, 21 May 2025 14:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsHx6ZhL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCE510E96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 14:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5ijeaEeK2FNH6oUIaJbxqVuEMgXqnlm7edretk3njo0Nb5/9HTbtwe9/cgkqAhs4aNpd7dUVZPB5fiHq7sj3nO09SkL80BmXQZVpo44Dr3i8JD20ibI+st1qQ5cddixd7GWq8J66Mm1d7AvIuNZpbqIsoRFoXHGKps/fLWxtGGzi6gS8p+nqzAf4gtDjdkF2j2rNORlU/cP0DMuw0YBxjEy+NK3Pd+VElQUGNsiXnIIs2HXMp1yY/MRV5F4FSV6y5ltK/fHUVGKqiGETw5YAGU7fq6GnjcSEZuKGLuCgEtbKmAqftkYvAfivsclIb3C/gbHhOB7B+Xhho2IsVfORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZKtU4bBsNGpYrXaEEQdVv1v7369n3TH/JBuj+TH/kA=;
 b=ajZTV0jmM9A4eSbXTVo22TrzGYtH5KZYuReyia9cZgXGbvdZb1HgabrSrU+PxcJ10FLDYDmXBHWlqQ0IAmGTcaNJU82OGlD1rQL4z4xrOSKIxDU1BUAUJd8LBHDy1N+NedCrKtvG/Xa4MfyK3NCUZoOOlGMFk6jDa+K7lfEE3hnJV5K1FDYBV0xDbKxfX4WCes91WnADgHYShciV55+o6esjmQImrqzfilnYwGw4bXDbqyYk7JZjvc2Lm6vPogqdIBiPtUDcXI/SJJ1oyKATlqYmqjObyevd20itUPrDKNZ3RwU1mmQx2DjK5LqtzUr0KVelLxpDTxcQYqmfbNYzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZKtU4bBsNGpYrXaEEQdVv1v7369n3TH/JBuj+TH/kA=;
 b=vsHx6ZhLuDskFBDGZsJSAatJ/aD8cfOHRdTBGbA52Xka01gKydFp22X8aexEwAniV2yWCZBxLQDtNpP+M7Y5NbG/4jzf+0wts0eOZdu5uX6h7JngbxXJjRMOoJrqF+iovNh8lxkKhfbDDaTaiC/X2/EZrqFtD6BKYainAPLztKk=
Received: from SN6PR16CA0042.namprd16.prod.outlook.com (2603:10b6:805:ca::19)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 14:25:10 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::dd) by SN6PR16CA0042.outlook.office365.com
 (2603:10b6:805:ca::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 14:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 14:25:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 09:25:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 09:25:09 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 21 May 2025 09:25:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>, <alex.hung@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] Revert "drm/amd/display: [FW Promotion] Release 0.1.11.0"
Date: Wed, 21 May 2025 10:25:08 -0400
Message-ID: <20250521142508.1868414-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 688ef623-3e32-4a71-4e71-08dd98734a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f9tluqGSgta75qDAjpN0ZPntr3Uv9MSu45h/UBpUA2b7sIcUH6LJgSW5mg5F?=
 =?us-ascii?Q?sGKK2JdHXnf13xB6Rfp/OIfCJoTgonaJRLU1E0+zN8PTyFE2UAVo6rcfwD2L?=
 =?us-ascii?Q?cm9F0v30zX+jwcu2SDIXtRroIvpaHRf3v7aw+Zwh7qsjUo5ii2QA5uKHgeF8?=
 =?us-ascii?Q?OKUB6j4kXawWJMrurR8CIEZlmFgYTYu3m3lbjIj0uv+9EJtdnkjmLoQcjHHE?=
 =?us-ascii?Q?GPEI6FWoezS8DmJulA+jRB06dt7SPWMz65SFP/m0ieIDSExfGrt6eK7Do9Zs?=
 =?us-ascii?Q?yXGO5KTCZ5+qHoPNby95t5LdCin0MuXmkpC+3yc6lHia1GyleGYHFX5/cTCb?=
 =?us-ascii?Q?HZknx6E6gxcPOPRSCvAxrzHNkVUpzSiqWbcQjQk/rwqiEomEy2OPoBwpUzEv?=
 =?us-ascii?Q?f1QbfCzK3Ti4gE0Eb/Ww504rM8L/aRHEZ9kMm2vQzwUZPforPjCxNbppez0o?=
 =?us-ascii?Q?PwDM8kMxEpQfN82V+gAl8MowRTrTOKGPlMhGRlzf55tERWJYGr6amYG7SocH?=
 =?us-ascii?Q?YlwFqhWZrscDWNztd1KOO2ited0KjuLpcpuISMvGAVBJD/veZnEk8kCAiTSt?=
 =?us-ascii?Q?ARxzZR+i07HlygajQqkv6VCTN6+83k86HmUqFw9LlIb/AtthfWU5YEfUuAo6?=
 =?us-ascii?Q?25sZqkz7W84Lk+aKH4pnLRt4crALRFpS7kdS7RMF6ylCSb3wh2FGfuDuxTW5?=
 =?us-ascii?Q?2Zi2Kd66zsUkQ+gPss8Kl9YOmkVycC367ZgfNoZ05mjblC6p4YqBTtNE4Vjr?=
 =?us-ascii?Q?Vjagf/6bzz/XhIoDUUQPUVFQFiaARfXtnYB2GCcUKQ4bKJVvDMsVxfk/Jjjv?=
 =?us-ascii?Q?IXq1zWUW+46TIwe2zgz83d7EhGlU6F9k4MKW9BBt++xlJOSMuy8qVkH0rTDa?=
 =?us-ascii?Q?ROe0Y6hbZEcIZyo2VXGFp1YxgqugHMFtD76aSeRhjlRMIBmp14haa304P/Zk?=
 =?us-ascii?Q?+YKxnyj1xiWlEYvOcDaRG1hvN0RmGotyHrO6dfBSGgjU3D5TY1foVFUHJ0vK?=
 =?us-ascii?Q?aYJKZlL/iNlz5XAcP0Bl2eRAuis5iSUilExK8avkR+NHiyjXBiwePO4+txb9?=
 =?us-ascii?Q?G2wQiNLQ7QgyM03vVTCxuJcuOBBNqP731LBl9E5c4J2KpSHSemCs7JxXQ5TB?=
 =?us-ascii?Q?8nya0TXPysniHIy9aZmxjM9FQsi8Np1UXm76H4Bj1fNjdzTiIDXfPshIQHxX?=
 =?us-ascii?Q?NTokzs6NiA73t2bhLuoUPN+FNKGHKZ96rdYK4pEh6JbvlcpaWWQCXkxxPjD9?=
 =?us-ascii?Q?Ugm4qexioY0euaiwT/FMpBST/3KkAGp3CUykLO6OQF+1WOG7sKj1VZAUdPj2?=
 =?us-ascii?Q?3k+UGLwqVkobzh5M9cZ3wH3Yiy7ru4eEuYjaLZ3RTZsdr5dpNTG3KMAfUFHy?=
 =?us-ascii?Q?Rv2GLv6V0/bci+fD2FuGQKdNU/KqemDodp+EWShZKgli9er+4ngRHCkfntrE?=
 =?us-ascii?Q?uN/nHr0X7ncz1DXmoHzkK+Qx8G49xF9aT5eAHBOsx+b9R2gIHAjR+Gw5O1iZ?=
 =?us-ascii?Q?iYPGXN+NDwoK0R1p76dGjlSUdaW9COoQ61PG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:25:09.5780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688ef623-3e32-4a71-4e71-08dd98734a91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

This reverts commit 572193a6e3a842204757a6fa2944125811b29f70 since it
introduces incompatbility with older firmware

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 34 ++-----------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 57fa05bddb45..b66bd10cdc9b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2139,11 +2139,6 @@ union dmub_cmd_fams2_config {
 	} stream_v1; //v1
 };
 
-struct dmub_fams2_config_v2 {
-	struct dmub_cmd_fams2_global_config global;
-	struct dmub_fams2_stream_static_state_v1 stream_v1[DMUB_MAX_STREAMS]; //v1
-};
-
 /**
  * DMUB rb command definition for FAMS2 (merged SubVP, FPO, Legacy)
  */
@@ -2152,22 +2147,6 @@ struct dmub_rb_cmd_fams2 {
 	union dmub_cmd_fams2_config config;
 };
 
-/**
- * Indirect buffer descriptor
- */
-struct dmub_ib_data {
-	union dmub_addr src; // location of indirect buffer in memory
-	uint16_t size; // indirect buffer size in bytes
-};
-
-/**
- * DMUB rb command definition for commands passed over indirect buffer
- */
-struct dmub_rb_cmd_ib {
-	struct dmub_cmd_header header;
-	struct dmub_ib_data ib_data;
-};
-
 /**
  * enum dmub_cmd_idle_opt_type - Idle optimization command type.
  */
@@ -2191,11 +2170,6 @@ enum dmub_cmd_idle_opt_type {
 	 * DCN hardware notify power state.
 	 */
 	DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE = 3,
-
-	/**
-	 * DCN notify to release HW.
-	 */
-	 DMUB_CMD__IDLE_OPT_RELEASE_HW = 4,
 };
 
 /**
@@ -2957,9 +2931,8 @@ enum dmub_cmd_fams_type {
 	 */
 	DMUB_CMD__FAMS_SET_MANUAL_TRIGGER = 3,
 	DMUB_CMD__FAMS2_CONFIG = 4,
-	DMUB_CMD__FAMS2_IB_CONFIG = 5,
-	DMUB_CMD__FAMS2_DRR_UPDATE = 6,
-	DMUB_CMD__FAMS2_FLIP = 7,
+	DMUB_CMD__FAMS2_DRR_UPDATE = 5,
+	DMUB_CMD__FAMS2_FLIP = 6,
 };
 
 /**
@@ -5953,11 +5926,8 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
 	 */
 	struct dmub_rb_cmd_assr_enable assr_enable;
-
 	struct dmub_rb_cmd_fams2 fams2_config;
 
-	struct dmub_rb_cmd_ib ib_fams2_config;
-
 	struct dmub_rb_cmd_fams2_drr_update fams2_drr_update;
 
 	struct dmub_rb_cmd_fams2_flip fams2_flip;
-- 
2.49.0

