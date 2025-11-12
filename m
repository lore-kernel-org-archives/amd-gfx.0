Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3A3CD3438
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB03610E798;
	Wed, 12 Nov 2025 18:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MDAD0Vrn";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9E210E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs2obwHZaaZg8TS8OKMZTnm4wzhR+J0qKa8heDOq8MG5+8wfoJmsfZv8SHfco0Zc7mXnlfRMKrg3y3L7+l6zMNkLOTShtEpO9jclvqL9WCcrcpUIygGPvvazQAhT5L8v6Km9YBThghJW6MtqOs2NhTL3gb/bWQmmg5TWTeth1hHMJtPo1dp4QrOzEjeyQQAQLPyYG1ijS1LM1nimw3F7/uOReXZSZSg144DEYxLq9nN5WDSRg0JdDfbjtpnT0yZfUPDQdZT/jq5lj+o2W8Kba8zsS9AIpwdPi6bIKwicsLmAEtMW8Vra5wdYd16N8v388awWe/tKUNHDTgN+8u0eOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seRg5QyMEPkHrNeHh+jZ3iDkQ5kj08DQpdOMNL+ViyQ=;
 b=mExQ7L7zM7IfobVrh0ecT3uEYOBiO+qVBNd5mN+z2vzX5l+lhgwL6Xwrs2ilHqcdHhK8kObMSDT4ASO+lUVu2qzUyEQxm6IkTLT5Z5vACz1xNVV4+736CrdLrzSWu/w+2DkdczAsarhpIoJOaBcghlT+Gic4GVOzMiiRNHcmrYvCSeMe1IYxHOYNQSTwz9Be5A/gHY1GTL9mAFOV9qk9fOitSCLPjaT4WO+yQU/qpc9tcH2ZF5tjj5OHISK/eQGtYSZKXtTwx+CZN38F7BYi+uhRIz6CuPqTZM4Nd2XecWosObB6olKIgGJWUkJzoX2fWuhewVtLZKNPAJOydHFFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seRg5QyMEPkHrNeHh+jZ3iDkQ5kj08DQpdOMNL+ViyQ=;
 b=MDAD0VrnMRqmsgxHsg274l4YVF2VPnaaSlwsiCZHc4+wdkNCGE+2W2HcmkwSFD549ZZwE8EuRzLJtuMg0tv5BtMMNoMre8hO9+aUZeAjh+ZOEd82Os0KmfHvIsPjzHr3ZNRCye1v4XpRG3bM75JzhxG1cFGDB2mhZEmftz894K4=
Received: from CY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:930:1e::14)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Wed, 12 Nov 2025 18:23:23 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::65) by CY5PR04CA0002.outlook.office365.com
 (2603:10b6:930:1e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 18:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:23:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:51 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:22:51 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:50 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 11/16] drm/amd/display: Clear the CUR_ENABLE register on DCN20
 on DPP5
Date: Wed, 12 Nov 2025 13:20:29 -0500
Message-ID: <20251112182212.559007-12-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaa24ca-569d-4b7f-eb14-08de221890ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y0ZOdfw5eL5KiwjVX8gPKatGsfuK/M6QJb5XdCWRrYqx+4BoqhxRhbsc6sEH?=
 =?us-ascii?Q?eEeIjljXijSvwW5QwFPzbFgosPHnEnYbrH4AWisctlaXvmdkzG0bzwN8J3uN?=
 =?us-ascii?Q?Fn3MytH2YI2x+S7IHNn7se3c9/LC4RiUj0zj9ltbUMwlT4P8ki+tk9elhf6k?=
 =?us-ascii?Q?ztjWR9sdgkeQwahNhi6DC/btuwXv9ctp5ve6wN2FfIaCQSNBK0+HoIXl+vKv?=
 =?us-ascii?Q?ZU/s/Fnq+rEpvyhKOp3OGwHsXTzVYeiACGtlw4STyxy/O5GwffIc9zkX//RO?=
 =?us-ascii?Q?UIUi7Fb9ngGoXo/1ELo3OE03shzvPZTvH6KJqslzcj0s8wJ3KHkYx2K9Ex7J?=
 =?us-ascii?Q?doIKdTeNifWvq5W3NfoA03DUVYwPVmC0plyuRY80APlVSylE+FkZocRIZXx/?=
 =?us-ascii?Q?wkN7XrCUg8CxVD+T75T0jfuhv/M6GfuZlazdtY7S9eepChUc6GHxf/dDUL8t?=
 =?us-ascii?Q?pnN2dl+F9jSiC8J/Gi0n7A50cfXdVHoiHbIlKAA8OHWBonDbIMo0ttRlijk7?=
 =?us-ascii?Q?D3Y8cU1LPbmErszS5ZMzw/WntvtzXJLCoJUTxmCBpmvBZgAHuha5dThNznDr?=
 =?us-ascii?Q?sSq4DICnFMFK/IkViG1tpE6xPNOQdD0hKJF3pZ/vtB/+X11caBCO87+Ygck9?=
 =?us-ascii?Q?QDAj8dUo9Yg5P6m7Lz2pfmix+0hqb5DGDLMICTWq+GFtv0BtRnXp7kH7IuaX?=
 =?us-ascii?Q?4g3Le2L5gIm2oX1ip6aekR9+/gOtuhyDzeRRhk5liv0ZYDdOeJvrODnYxvxq?=
 =?us-ascii?Q?SBgVwMdILJ35xAdqq9Cx97Inj6wpUb19kHRInV3rpfpKNw/N0QC4GoeuG8oI?=
 =?us-ascii?Q?Rk6xssuamUM0//l1ViSDSYyVY/nFetAhHzaA32LcrmOX+UvmlDi5ovZMXFl0?=
 =?us-ascii?Q?z96tq4s1Ez3V+eV04cePN7Yewh4q/G4cTI83kRKIhEZQDLymAdLa//kM7ezf?=
 =?us-ascii?Q?LhhpExuFXmwWA2U0ACRQHTKAqjOdeEJ84Lx5qPTeMex033eFoAs5jrLZbETs?=
 =?us-ascii?Q?TTK6nNwTr75mI/DY+0Hs6+hsWYfyEjufMiegerMoLXyIzTPzJ4m5Jg+EWVoa?=
 =?us-ascii?Q?o32tV+TomARoovxTXSvVYr6XUSQbI4soJddzHHU9xM1J2vAcsh28bHX1ba6s?=
 =?us-ascii?Q?A/RUx3Okl0rI+PYNM+mIQAXIJeGPh/9V3ldfw59TlGT1A3PkwMr884bBTIjk?=
 =?us-ascii?Q?9smfFYUMCZyLfDdOWoNFLBWaak885g2eN2nK7r+joDCjjL6RVbu8rNDBte6l?=
 =?us-ascii?Q?RSvUizExY4GiWfpZxXCuzXrkBT596Jfy9IBeUquvnWQ0Jr8iitZbu1AkTWPB?=
 =?us-ascii?Q?qY+8pp4g4k/ywnWJNCtbS3FyRjWiSNo/vjxcEUqispXOC3i2mZ2AYPd9vU96?=
 =?us-ascii?Q?37RWgPfFlPmbA6bAXiv8W5oap2t7bSzlzvX8hTG5zm48ldWoHAO5o9RIxI15?=
 =?us-ascii?Q?qWMg7oDDaJsS3shGWFMzReiARxHEXGdX1EP6RuZ1j9g46AkyjaCTrLumERs2?=
 =?us-ascii?Q?4ZjnU6MgME4tJepxVsOXzASXffcpEQuLEm0H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:23:23.4195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaa24ca-569d-4b7f-eb14-08de221890ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

[Why]
On DCN20 & DCN30, the 6th DPP's & HUBP's are powered on permanently and
cannot be power gated. Thus, when dpp_reset() is invoked for the DPP5,
while it's still powered on, the cached cursor_state
(dpp_base->pos.cur0_ctl.bits.cur0_enable)
and the actual state (CUR0_ENABLE) bit are unsycned. This can cause a
double cursor in full screen with non-native scaling.

[How]
Force disable cursor on DPP5 on plane powerdown for ASICs w/ 6 DPPs/HUBPs.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4673
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 6bd905905984..1460d3fc7115 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -614,6 +614,14 @@ void dcn20_dpp_pg_control(
 		 *		DOMAIN11_PGFSM_PWR_STATUS, pwr_status,
 		 * 		1, 1000);
 		 */
+
+		/* Force disable cursor on plane powerdown on DPP 5 using dpp_force_disable_cursor */
+		if (!power_on) {
+			struct dpp *dpp5 = hws->ctx->dc->res_pool->dpps[dpp_inst];
+			if (dpp5 && dpp5->funcs->dpp_force_disable_cursor)
+				dpp5->funcs->dpp_force_disable_cursor(dpp5);
+		}
+
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
-- 
2.43.0

