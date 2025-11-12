Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079BECD3438
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9855310E79E;
	Wed, 12 Nov 2025 18:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2yFvPTM0";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E6A10E79E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8qaybS4hf8tbEgm6fuGOS9px7QCtJxDvhDWdR3Eu+vDTshVHYdCbJlqVlwq8LL7QSrJWRtzc8E6l4FYiDterP1j7IEEeDDQY5F8we//bwt6wlSUaTnQPpP5PY1CljL6L2JpszNS4iUTAl6k/xAofpEdIGXzVXkAg6h3N0gjpBlsl8Y4ks3Bh37IkPmRYRM7t13H0OprE9E1wiv2RDzVuPrgcHrqeuyWUk+wAozoSKEy6me57PJBcjuWcRix6moZC2lOUwrsc0ujd6ja9Cbwh4+cACqMRJkNTL+GbWDaZqwJaq5t4teE6JBLCmix1ZtL2Nk4Xd623nEuVam+B+rRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhkJGy0/qQpKzbOLQZX2bxY/3Hb8gFnS+OPbpGj1kqk=;
 b=NsIhLXESbNrI7lWeuQhowNRghgT0xr+2sU00cepRgvaMcqnaq2ajkYLfJEbXu7i4tFIo9L79jVXoo/ubZ1lhm29piTWmQqgnUNjZRZ6afF9U3gYDwLoqf8fGgmGCijHDkk/pyH9f4fonPhqvzUNSNx9hH24CQf/xhCB0Cp0QLQAJMQqoGGA27Yv/v1fzUvF9wqPhh0ar2mD4HceFSS2fUsG5P9vWr/+VYuT1j7MPklYtn1B7Pgd9sBe2lV4hwgzZn7f32OdSa8aRioIRlw9E9X8sXsa4X/ykEKsiCwe6Ks5yLBNJV52dXNxa1sPU9ZlMIIASI+yLgH9OAlRy59VTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhkJGy0/qQpKzbOLQZX2bxY/3Hb8gFnS+OPbpGj1kqk=;
 b=2yFvPTM0Sw0B8PyCNjVap/8OV1KA+2YeCZ/kGq0n5MJ3FaxJ0OTjRVIu2ErvVInlRtwsGWb8L7dCm1P8JbvE7qN2JlO5F4nG76PzZvfUzz9p4TZNs5c72H/4Wsy+2jmHMY1E7j9GGgmgblufKGUPVJt1jxc26Sqzy6SJjavcJHE=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:23:10 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::53) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 18:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:23:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:35 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:34 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Remove unused variable in Replay set
 version structure
Date: Wed, 12 Nov 2025 13:20:23 -0500
Message-ID: <20251112182212.559007-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: aebd8466-6ca6-447c-8d4c-08de22188597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q4MBjgBbR3KTydp2dcHph3Q3dkHSSQ/td5BRC+/JEXBgOhenxGYpH4EzZfY6?=
 =?us-ascii?Q?rTjD5yG56I8qwAifSzlom0YMqbJDjAC0Mk+eN1pdcMP837VfFkcJaJyhgYq0?=
 =?us-ascii?Q?QJV18sehaV7JgQSBl1GdYWEBlnUIZ8mEG1hssiMxQUW1Bk00wUOk8QJnxBpH?=
 =?us-ascii?Q?WCW3biws/dFLfowpC8wp38OWsAXpJhv2BZMfUDG8+VRmWTMH+3ihZ4fS8iSH?=
 =?us-ascii?Q?Ds8/Sw4xkyn/tY3jPw/lVWYhf/TuAkIvnTTqOx/3geZuh68+K/TBh90Yj5PF?=
 =?us-ascii?Q?A9kzUsd4QiLkDf82WzCWPyU4ZukJ4SWGXZuyyOP/+GdimVT2Av+w8JMEq41T?=
 =?us-ascii?Q?N3G7HS36ZQ6zUv7PbIP15UVJgVWDT2D5puEll4fr16uKTdZx8tcLAfZWgefG?=
 =?us-ascii?Q?GUaLy0I/IUCj899MiTpM5OHs3wH4tRyOaS48FM611sxc3zIvSjHwXHDo8T+r?=
 =?us-ascii?Q?7PK1n1EFlnA3a+dsmbkwiYQc0lI8swQRWXSs5uwzFdo7nfJF0bXNNZg8/7I5?=
 =?us-ascii?Q?PgIimzRo88Bc3FxjJGSJFhgQy1dN2rz2rAEyDoQusuSgkXe2Lxclb++Q49v0?=
 =?us-ascii?Q?S2/x/MC2z/Jb4R4WYf8GjE5IJRoMHiGZsgmU/aj3ATgs439TV/1enM/NXno7?=
 =?us-ascii?Q?XRH0ooxMyhrh7WC2e3Q+rOY7ZYWSSOo5+unrzB3sPqAO0/kL5S8EMzCvyyCf?=
 =?us-ascii?Q?BeC2W3go7T+UPay5tlSp4Zlf5zsBLUDSPGncZemDEYnzxJWmxZzSQCSf6beS?=
 =?us-ascii?Q?LEudxMEMCR+XiCat6LYbrrfAXTM8gNaG58z/7VTrTPWQ2oQ6tdnfrtk/+gGD?=
 =?us-ascii?Q?2ngQfr+45QiKMNKjh+vpp6IyRBc/hh0IiFhNV3cy3izUkwloGCtG92dGOtCF?=
 =?us-ascii?Q?IWxivbyCgHd0KHxDyYFcOPB4EC+aYQs+NcAWGWYETYOEJLcXNYorg4sZCu/I?=
 =?us-ascii?Q?Ca6e+gQqS7YWQiGIJWmHmjejfVhpENHaZMb4tLBOITWNprAIJeqUzMpFWWL+?=
 =?us-ascii?Q?CWE2Fb7bdEXDklzQ3lsXkYc3OUKXENEeWGDkYyqAgYF+fzo2HultBpDTkPY+?=
 =?us-ascii?Q?YJQK7HGIewkWM5HQyixst2BoUdLkLqNo/BWm//7C1CAlM0Zm1PpkEoAYQt+m?=
 =?us-ascii?Q?FwJJCsqVf8QpkxqICHrSTllepN9X21f4pYVORGS/RAUwvVAFVZPv878CqwPk?=
 =?us-ascii?Q?FODD2qe9SyWaoG+G8aLXqAn6EPSZPKwgeFlT+D4A2GsjsvgKLiu+NG1qNPGl?=
 =?us-ascii?Q?tLAoUGS0OKFrXrYohYdt3yfUB0//OhfjIUTSaI2u8mEww4CF8NZlg2zW4Jal?=
 =?us-ascii?Q?AZoygsBBLTKpk3BkqJgOYnt2cx9tdr3P2P/HyRpxxTpkBpLQMQIHbSj4eYp8?=
 =?us-ascii?Q?x+QgU9XKcddjAFrGu5Z9fDZMMZJpQRtbZ5ST+To1HEgTYDydNYsxqzqIT4Ek?=
 =?us-ascii?Q?NjI0exiLcRnsMfIQwv5+EC48It9osfAKP7XkuuXpFofN2VEdn+LSy4iziQzP?=
 =?us-ascii?Q?nHqagym0Nc5PMyHRwdGtz+K2kPOPMIDPgT6ZCeZvDT1+h9NbuyDr5f0YJMFZ?=
 =?us-ascii?Q?rNkfH5hFr9nzBgBk6l4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:23:04.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aebd8466-6ca6-447c-8d4c-08de22188597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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

From: Jack Chang <jack.chang@amd.com>

[Why]
Remove unused variable from the DMUB replay command.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Leon Huang  <Leon.Huang1@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 16cc3bf1b6d0..cf1372aaff6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -399,8 +399,6 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 			cmd_element->version_data.panel_inst;
 		cmd.replay_set_version.replay_set_version_data.version =
 			cmd_element->version_data.version;
-		cmd.replay_set_version.replay_set_version_data.cmd_version =
-			cmd_element->version_data.cmd_version;
 		break;
 	case Replay_Set_General_Cmd:
 		//Header
-- 
2.43.0

