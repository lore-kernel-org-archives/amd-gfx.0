Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF59C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5AB810E50A;
	Fri, 31 May 2024 16:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQZTv4oo";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E565C10E3AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC/HSp63ckXpr/SkB60i0/Sa+LWCOvYsA8hGW5V6YAnBLC9eeaegOl9437rjKy6oUEnT0vpbf3UsTvKgBC+ojml+0lQDm2FLbkgTN96Zx8SRlIhhSNETO0+53Zwtzd+Vm4edt43bbwUgHl7zxW1CbDxYzm0Gix59ijLVWG73xoOllK/TNEMbOP5fzNwPTlRdQSxl/R3POTCpzb7mB3DYydujiI2xwRKSZ0SGzhzDP7WIJY3Fx1qPeb3u0HyRFRJDoPQ/tHr9AQxJTKsu4Ick09+lCnsh3s38oxkKVzkTKrlKbbTarHuSwUZaqM/H98yCIYPTa8vafj4mEZgDxX56vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKTdQa4Grcm4fkcR18rSZS4BWV/dXlGsEpwqqWvzCSY=;
 b=OIkigPx0IyeSmmu3Wy9ewgdnBu4iYHOHZMmnWcZ1t0L+2hA7YCuqbRpOcPxNQNoWj48UsTXQ8cXeVcScKXLdzTINglWod/rnOUyyzjnAhdVAddtKR3JlQI2yL31fp+G3URtP2DRzgi3jtLzVNi1adu65kkCoQpO/+RNhMRyc2jxLNzZ6qQTyWHeumdcM/KiSS2l6XEzlk6rCSQIyEZVq11lURVmj6f7BFdemkuJuhw1Lyercwv6S2jQDvueutxtmTp5Eug01SXEWWZa5OldPB5JXbD0LPGUfenZO188HyoY+iq2quKAdgAoC532/pfxcVvauQy3gKjODVRlK0pEVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKTdQa4Grcm4fkcR18rSZS4BWV/dXlGsEpwqqWvzCSY=;
 b=IQZTv4ooHtqmV86bQMFQrU9A+4v23IYtV457eAvBbqamDZp/8mF45jfYPMTfwHOSpSgUKM7EWro2rn/u6I0RnkiahtwLVymD06wgKTIgfVIhiAQaTS63bD6mFj6gBGELAyrnUpjbAQnfkcWOO8GeX5avmctQs27JYuP9TQynYoA=
Received: from PH7PR10CA0020.namprd10.prod.outlook.com (2603:10b6:510:23d::18)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 16:52:42 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::4b) by PH7PR10CA0020.outlook.office365.com
 (2603:10b6:510:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:42 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:38 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Duncan Ma <duncan.ma@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 18/32] drm/amd/display: Add outbox notification support for
 HPD redetect
Date: Fri, 31 May 2024 12:51:31 -0400
Message-ID: <20240531165145.1874966-19-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5217f500-9f6a-471e-a8bf-08dc81921671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?06sAna+iLjsr8iPXsJi8jl3+18gczWomlQscDl9/FVqJLEOSDNtx1UVaNCA4?=
 =?us-ascii?Q?/YpLuaQUn4ur9eTrUAASNfTovCcFJ+kCD8eWiECKi6/JQZI+hyXwhrJ3sOEp?=
 =?us-ascii?Q?aj3eVmTos00a/2mrTPJvtQJmtEUNGtEVVp8Ng3bJ1laaLuHG6UViL+Cn2kl2?=
 =?us-ascii?Q?6K7HkiGlGzkK87xCN2X6WUXKNHHLqXTb6x0DzFeY6aKsdFn8it3X9OMK5mhc?=
 =?us-ascii?Q?zFZu4ApRny61++cgiTLEXzQKrwfNxKA1gDmr8P1B4qBcRQ7Gt5OOV8Y455bY?=
 =?us-ascii?Q?S8CzKuO9zwGcEuW2jC4bXu33igwTWyBYbrNwNxGI5aT51skGzz5vRQWI76Mo?=
 =?us-ascii?Q?jNlHN+ZbW2zzeC87N7PXiiMkyDR4skZB3F1gCH+GjQRK3ds1ZeI1tkqPhavy?=
 =?us-ascii?Q?huyVt9WwoZm6M1kDq5gcxJ9WyhLMfBLRIJXSTA5T+eQttHVOHuM+mKHhDf6a?=
 =?us-ascii?Q?rIuCgVK7XCjNdeOcVKgDyg7UZ+fZM+Dg1r9USA9dEqrZNtet/vmLT59xqUbm?=
 =?us-ascii?Q?+IISK3KAKz1nGl+zSgzqJsobCAcGBFE5U021VbpVUHliRDb4hn8sJIBPpSDG?=
 =?us-ascii?Q?dStr/X9X7GzzTe+Jr/478Wpp2VDPE4XgXILU76sK3jBVX/9dhHzzfbDb2BVq?=
 =?us-ascii?Q?tZH46hmRHONYK/igTNqsWgr+a1UXztwBVWTMPfkrGhnFbrtDZXZDHefNR2Td?=
 =?us-ascii?Q?bVepzS1d+ObkAotAhS0CSMlkxHh5JxhtbfoypXp4HMK3/SDeyWWYOywGpYU3?=
 =?us-ascii?Q?alVIM43b6CnznGoEZOXbfbWJ6DkB5YbcZpS+dn6tv0zRgEpgUqnjV6ZPfDmW?=
 =?us-ascii?Q?M7blMKCgzeUHLUjQr8svZFTVxahsWQPr49Sy9g+w/m4H2XE3Ymjlgbxdg2yR?=
 =?us-ascii?Q?PDXnyUE4qZKljxIGOLvE2aKFFYCSt0HsPjnxQIl5N1XhqNvhFfQEVjICI+iz?=
 =?us-ascii?Q?Q9zVErkrvVUxEDM3cM9KtjKRUf9+CSafIKPuYNvxDtml5EkSPYZoXsEhd5rw?=
 =?us-ascii?Q?By69mc7Rif6Hvsti8Fwd9CIywzYBh229wVpGWN5EB1h4dC3FpiaLXtPY2N58?=
 =?us-ascii?Q?CU6KxS8UjebgI5e6ZXObxbJVSxmVOMo51gs9761b0tCNvtdZJsruyLxWv7K4?=
 =?us-ascii?Q?eTzyN9aAgi/8ZvjBxef3xNio66uRD881w8ESsIq0CMtKoc41kYpPLHQHhGBe?=
 =?us-ascii?Q?vYG05XlxV4j/xX7NakO5jC0/eN3gLQT7DfGSrStdUh4XIUILKMRoJsX5hygu?=
 =?us-ascii?Q?q/wGcSJw+AyOgPYDgvmrmXAuohTKEJqvKA2ey0Luc8ydWbicr62E+4G9fcu9?=
 =?us-ascii?Q?wrbpo4vzhHhQHHi8VWfrHPrRFM4pFbQ00U+xBf3PH4UQK07r/6GJmxzsS32S?=
 =?us-ascii?Q?kDfcQfGZ1Bgud8HdQtieMDWCFRw/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:42.0429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5217f500-9f6a-471e-a8bf-08dc81921671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
HPD sense changes can occur during low power states and need to be
notified from firmware to driver. Upon notification the hotplug
redetection routines should execute.

[How]
Add Support in DMUB srv and DMUB srv stat for receiving these
notifications. DM can hook them up and process the HPD redetection
once received.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 24 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  6 +++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index cd51c91a822b..85dcf6b4fe92 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -137,6 +137,7 @@ enum dmub_notification_type {
 	DMUB_NOTIFICATION_HPD_IRQ,
 	DMUB_NOTIFICATION_SET_CONFIG_REPLY,
 	DMUB_NOTIFICATION_DPIA_NOTIFICATION,
+	DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
 	DMUB_NOTIFICATION_MAX
 };
 
@@ -560,6 +561,7 @@ struct dmub_notification {
 		 * DPIA notification command.
 		 */
 		struct dmub_rb_cmd_dpia_notification dpia_notification;
+		struct dmub_rb_cmd_hpd_sense_notify_data hpd_sense_notify;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4db4c5ad5169..7f08e95140ef 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1285,6 +1285,10 @@ enum dmub_out_cmd_type {
 	 * Command type used for USB4 DPIA notification
 	 */
 	DMUB_OUT_CMD__DPIA_NOTIFICATION = 5,
+	/**
+	 * Command type used for HPD redetect notification
+	 */
+	DMUB_OUT_CMD__HPD_SENSE_NOTIFY = 6,
 };
 
 /* DMUB_CMD__DPIA command sub-types. */
@@ -2468,6 +2472,22 @@ struct dmub_rb_cmd_query_hpd_state {
 	struct dmub_cmd_hpd_state_query_data data;
 };
 
+/**
+ * struct dmub_rb_cmd_hpd_sense_notify - HPD sense notification data.
+ */
+struct dmub_rb_cmd_hpd_sense_notify_data {
+	uint32_t old_hpd_sense_mask; /**< Old HPD sense mask */
+	uint32_t new_hpd_sense_mask; /**< New HPD sense mask */
+};
+
+/**
+ * struct dmub_rb_cmd_hpd_sense_notify - DMUB_OUT_CMD__HPD_SENSE_NOTIFY command.
+ */
+struct dmub_rb_cmd_hpd_sense_notify {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_rb_cmd_hpd_sense_notify_data data; /**< payload */
+};
+
 /*
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
@@ -5204,6 +5224,10 @@ union dmub_rb_out_cmd {
 	 * DPIA notification command.
 	 */
 	struct dmub_rb_cmd_dpia_notification dpia_notification;
+	/**
+	 * HPD sense notification command.
+	 */
+	struct dmub_rb_cmd_hpd_sense_notify hpd_sense_notify;
 };
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 74189102eaec..cce887cefc01 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -113,6 +113,12 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 				notify->result = DPIA_BW_ALLOC_CAPS_CHANGED;
 		}
 		break;
+	case DMUB_OUT_CMD__HPD_SENSE_NOTIFY:
+		notify->type = DMUB_NOTIFICATION_HPD_SENSE_NOTIFY;
+		dmub_memcpy(&notify->hpd_sense_notify,
+			    &cmd.hpd_sense_notify.data,
+			    sizeof(cmd.hpd_sense_notify.data));
+		break;
 	default:
 		notify->type = DMUB_NOTIFICATION_NO_DATA;
 		break;
-- 
2.34.1

