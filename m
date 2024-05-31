Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D935EC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B3310E2ED;
	Fri, 31 May 2024 16:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NTerCmAx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DCF10E4F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyb/Q6sUDDi16xYBht3q8FGVTKzcVmod9TTEBbBLwDozp/bSIDHwLJTjV6Nm4XVqgpmiu9BrJKBpjR49OhBlaszt8qDzvTVcP6Wa3zHCtg78d+ZdyioPDurIrpv2PwSqaaHLts10LbGIXkYoq+JF8pWRUsBpk6i2ADdaykYMa4tSYTKGZdD2KRt3tvDxDpk4DhjvOs8kr4WIUpIq99/O0xDxb/Y3d6WDEpBx6WLkct2a6cMJ10H05I+5kDMLiREcIh9a53Z4P6+Kb7TINsfIEZl59sKaRu6uZBx9CXCpRcKM2dRgPddwZisg/UFSIEG3y4kiO/K6wYheccx9WG1uiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhy+1SEv7Yi7b713TJCiN0fxA4TwUVWr6AdS4iIKKLY=;
 b=XRmzLxO9NBRLYDMOb6uAtLL5lDQ63ALSGaGTu2osYCcItbFK2pUCbxTFxfc8UJoMLbIbWFnePXER18ESaBpMQTbinwSd/irMnSX63KL7IUCAIOY5rq1SRUpU9/XPSW6V6zuN+aBhTyVgv4wneGDKFjjjF/O/DCmHggZs9XSyjPV+qRSVUi8o8c5SZaPtbv/MiDbnEWv6dvhwFt5TsuMKYSOJa2+nzTKlYB4edbF4wD4oOVu0Trjt5R1zGFaSHEo+XJFUPEGr2Z7o/YjJh8w3LBvwzYn+XgZHWV6o6tET8uCHVDr7QGswWZMUhyTm9HVg/1UCG8csisFHNYlHJgTNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhy+1SEv7Yi7b713TJCiN0fxA4TwUVWr6AdS4iIKKLY=;
 b=NTerCmAxZ7OPC9EQs0tvNr7DUp/VQJmAhIGvK/FEadSc9w/8jLhotWaqNmBR/IYkt/GkFA6i7lfJ7A1w2jWS9oZDoD30dVfGqAIizNUIeLyEPn+3AcY14ty1FGmfELHvlWpXEP27pbkYaWlhEzloCps3yVGhlMUosy53Odj7dfY=
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 16:52:46 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::20) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Fri, 31 May 2024 16:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:46 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:44 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Lewis Huang <lewis.huang@amd.com>, Duncan Ma
 <duncan.ma@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 25/32] drm/amd/display: Add monitor patch skip disable crtc
 during psr and ips1
Date: Fri, 31 May 2024 12:51:38 -0400
Message-ID: <20240531165145.1874966-26-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ef0b82-5e8f-4610-0061-08dc819218f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CqwYJxT5xIs9qtFDSMbL4p9z2/BsS1JY6baBhK9vpNDAZM/+Vz3aOQWln1gv?=
 =?us-ascii?Q?KEd7b48ZAWbEhFqFbp3YOaCG+hnj87C+5oUeVTuyGU7rSD3G80gsvDgmOFX2?=
 =?us-ascii?Q?tsm8Clq0E3ma2i06FbxvIz4uVzwClwWdftsq85aJF2el5lbqtwkk4bgTF0FF?=
 =?us-ascii?Q?RXoRoDNC4j7NJU17USCJzgNhRD0C0PKbX+Z+Lu6E3oRIvDBXpINxJl5+Bxkq?=
 =?us-ascii?Q?dIpRCWKpvpKOrjLlAhqoK18s+3MyHw+pp+s+JNQsdtPQNGbTNtTldljGUa/+?=
 =?us-ascii?Q?Ora28AfcPXk6ZDG4fHzX6RyKGmwwdvyS9FLTpYvb9rLZnYXGap0wzrHsIWT8?=
 =?us-ascii?Q?DOJapkdmXjNDAPFJ7+8636cuBA9Mkk8qQcGYFo7m3m+PJDcZ1Czk7od1zEsr?=
 =?us-ascii?Q?6+UK6Kxuf6GesiPo4cd/5nq3Eh5PsgTTg5orwCRVLoqNMj3AzmuY5cbc/C8l?=
 =?us-ascii?Q?wY8WsgS0lajnmRgGt3ZqrG+68UiFesNRawxsisElwUvxj0sc8EGsZ2YjTTCc?=
 =?us-ascii?Q?n8DjhXkgQmcUIcv5qdD08D4TDZd39up0KtuA580e8q0t0FxDJLPx7iiEsQLh?=
 =?us-ascii?Q?j/7NZ2OGVZiuVfAxcPQOyUb3X08VmlMAjKPMAsYbOWHKW03/rZ0dt1ViawMV?=
 =?us-ascii?Q?MbFjz1lh+IvmQTDaZ/t5iH660LU1nWLxTHI7otZ7WgVmNvpjpEpcUV5JMTZh?=
 =?us-ascii?Q?xH6Px69iDnYVmKgPvoDqMhVa21ikETuYnwiZfR2G9MP8nFTxN0JXvu3uXkDK?=
 =?us-ascii?Q?nl7u0Z/srKi6SNh1J5/Js8ui9yeFIH3QaDiHmVydpnqCV3m7kUjhCq/o3Ckr?=
 =?us-ascii?Q?TcqR3jal2c4GEd8s+gaZ45cyYB3ixBckGkWzX+2QtUqfXptXnQT0tQOIOYUE?=
 =?us-ascii?Q?apxtNeaiX91gCYWDk1+Yi2CY3cl1LxO7CcwDnrY06UVTI2AU9IDAg7dh7Y3A?=
 =?us-ascii?Q?jePZPvSSHg0k2z2vYrWG+pJfr/O8wEwFCWPDjn/hIHRJNQRzLrl6+XjQTlnM?=
 =?us-ascii?Q?o9eK7CU0RiLSCfErMrPqEal0g+xa5yuBxvvadIzKh+dKfBex2n5lB0buijLb?=
 =?us-ascii?Q?9dIuWcPoE2AktWcBveZVQj65ClssJOLff6tBxNHTT9eFpIrL3RHbvf/C1I4m?=
 =?us-ascii?Q?sTiD1G2JjQoYsp7z41x6yBfCcZV8iu8VzMLzxRMYs9rhLw8ZaLcYDJS0IBw1?=
 =?us-ascii?Q?pUUoIqh22wuaVpvYiDbUAlrOBuihu7IwCkw1vTN6mEDKNC4S8jZoKEYnlAoY?=
 =?us-ascii?Q?nIOHYGwK+9Ju3zNGIHjfSuo5izVN3WOjuAeJXGJO0dq3P1HmFqc7s4kBfyRM?=
 =?us-ascii?Q?jwL7C4PdfMKN3gQSYE/Dxl3jI39/sbPKycLYTjeolV5AZ2jYyxXzScykYAzY?=
 =?us-ascii?Q?dSX+mhPxrEjOfsr3bPYYIJ8p2sAl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:46.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef0b82-5e8f-4610-0061-08dc819218f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
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

From: Lewis Huang <lewis.huang@amd.com>

[Why]
For some panel, it cannot handle pseudo vblank set by otg resync
when leave psr

[How]
The monitor patch will keep otg_on during enter IPS1.
And then we don't need to do otg resync when wake up.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h             | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 3 +++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4e5c63ddb312..56d4bec1be1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -304,6 +304,7 @@ struct dc_bug_wa {
 		uint8_t dcfclk : 1;
 		uint8_t dcfclk_ds: 1;
 	} clock_update_disable_mask;
+	bool skip_psr_ips_crtc_disable;
 	//Customer Specific WAs
 	uint32_t force_backlight_start_level;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4e6f7bf8a5b4..873993a6513c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1256,6 +1256,9 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 	cmd.idle_opt_notify_idle.cntl_data.driver_idle = allow_idle;
 
+	if (dc->work_arounds.skip_psr_ips_crtc_disable)
+		cmd.idle_opt_notify_idle.cntl_data.skip_otg_disable = true;
+
 	if (allow_idle) {
 		volatile struct dmub_shared_state_ips_driver *ips_driver =
 			&dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER].data.ips_driver;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 53ea4a57bd44..36c15ae43616 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1882,7 +1882,8 @@ struct dmub_rb_cmd_idle_opt_dcn_restore {
  */
 struct dmub_dcn_notify_idle_cntl_data {
 	uint8_t driver_idle;
-	uint8_t reserved[59];
+	uint8_t skip_otg_disable;
+	uint8_t reserved[58];
 };
 
 /**
-- 
2.34.1

