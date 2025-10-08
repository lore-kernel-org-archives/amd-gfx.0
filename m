Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF49CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E014110E8CC;
	Wed,  8 Oct 2025 19:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyvAs7ix";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2BB10E8CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q88i/4psJkzxd04gvP/n6PkH9n9kGV5nSdlxSo111BjPgY7FCcQkDLQkxTs8hqFJ/HJP69+Ie7bTGUShExk+ahtVT+0VWAhldyTAjruA2zfyHw28SKMj4HBNzrx7fJmOmbSS81ruZzH9XwptJgw1kqV2SwEyiB0K/zzFdp9FmRU2IsUL6SFJOupHsXR5uYrD4xCcfUe5Io7UhfxlquDAo+HqD9vTUGfNpctDcRV7GT5GmfzEpbpVkpHEEg1B3gZ5/XEAbGsHEbXi5VPauyTaDHuYMgRnpxFh47IKjy1ErASwEoVAPuWNweLNRSf2QdkO1iEm0IykTm0G48oFy5dPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR3O/E2GCoXeNvCy19q3C3xBXgFLaFB33yKWfQD8kGE=;
 b=tMMFq4Rk5NVHeAVFqgJjmYk9LreNlo/nGWNRC7P+LalKYgAolm+SaKsWcVqGkA1M4FfQvtasmnwYD+GXC7pdsm7Lw0YrYLgwoL8FvOXn5f7xdv8BLOYTNYMBsfVQgzrjjn8VwPj86I+VyES6gNSkhuIfIbOBivG5eCdHbAstAlQ+by7lS9wvBWYdAx3l51By88XgGw2n7TK/NDnk8aVfqDeRsoyT+DaEry730RVmAQ8Q3wVSOq70P9CaaJ2745HNmYiMAe0W8vDq6DZVC4J/e2Soa2bWu30zAJUjsxHIWwnBQJF3jx4mnyvOqFiCCST8YK59dTJ8tPaeVrrBM7eIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR3O/E2GCoXeNvCy19q3C3xBXgFLaFB33yKWfQD8kGE=;
 b=LyvAs7ixMD6z2ndaFfcwtCFE/wIuGScs6T3QN9hi5T1uMLPUnqTfcVDtSJ3MqLf7bBdo/8ns7/jCABJXNSdURhMeBnRLL0ZReyJ94bHTmYocDwBb/ZEUdnglYV+DuI6X42SFHTLc5vcvXDtmuuKVnqLsJw0rHINRxBvvC3gKDcw=
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:12:21 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:fd:cafe::c7) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 19:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:12:20 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 12:12:12 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH v4 0/6] Adjustment to power limit setting
Date: Wed, 8 Oct 2025 14:11:47 -0500
Message-ID: <20251008191153.3145554-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a765692-caf5-4b6a-cc73-08de069e9b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eSyPS0jZHQHo3HTvI3kPWM0h3FuZQKFyAUxD5vrbz/A0iRek7my0frm8RDvK?=
 =?us-ascii?Q?9buxfJ6JOpmV7kyJ3nZYkLJk/lLfVOvE7DB6/pnj3kPVNHAE4eAERgNDgwSn?=
 =?us-ascii?Q?tCDlWQ+iXH+xHKgv+8vKop1kPFNO2ODFYK58QluB3Skjl5dYlBiiQIkp9pA1?=
 =?us-ascii?Q?ymAe8q3MFfTx0gAIdKccd/iLf2933b4b/TvK4hbBheKATltumC1G4c8ldQEv?=
 =?us-ascii?Q?7ZlVckpUNC5UZ+htW9rW+6llsnQyPPiDeO/F1Ss397yoMy31uGg2cUH1SpO9?=
 =?us-ascii?Q?d+rgnkbN3q4JdvnYGsbSTgAHaumy8ybQorY6Ccf0B1W9RM4Rt+twn4eUetAO?=
 =?us-ascii?Q?lQezaBiX4/VJXtv7iFr+Zdv5/W3DLx4mk7MaE9xT9ypvv1xcugSuFKMaroIC?=
 =?us-ascii?Q?Ux/pOAvZm6ONYOpugJI/ZAhPW7xnOp5lpWJSw9nn9hHxYMZKUTIMSDZ4qnCF?=
 =?us-ascii?Q?Ewn+h0OuqOEWoXyvP2dLGgOI1GAIk6wGy/+/BQNlUfKlccsBiTmxpQilZvik?=
 =?us-ascii?Q?RAXQbDT/EsDMU7etxpYGrR43O6D0zPojc81av20We01LcmsDjDlc/gVUwvsi?=
 =?us-ascii?Q?u9Fdt3pzPig7fXTguHbBQhGw5lGypXNNHjFlTBLIRG/GVEQSxOCtr8gU/uKE?=
 =?us-ascii?Q?NwFMiv9h58H9NfWGyCLUtXuT0qtoufnmUK18dVQGBpJX93HCCJlMg1PUH6bj?=
 =?us-ascii?Q?Ml4khaozXELN7riCLyWaAu26fmsMMi/WTHF3QBSLaONMP/TNgklq3oXDHkeD?=
 =?us-ascii?Q?6ylt9PAEoqKlBy8dlbnE0ZFBdnLNTw9ryu32Db0XhKcbAw7C5EBYGaXkiAs8?=
 =?us-ascii?Q?lEO2pYd+BSRsy68eU69EVtfQCTTMLVSEovlH8dgjsPN2rEzT+syAC8+2rGwF?=
 =?us-ascii?Q?0FVst6CPY10eE/dUx1RJQca+4jVpwcNyfRr5KXq+GMTKHgLtUEmqVfNYAge7?=
 =?us-ascii?Q?e/216Tzhpj9A6TyC53SFjQdlFraN0khGzGZtHl/ubStiNeDJvDHYOvUiy+WT?=
 =?us-ascii?Q?Fir0t8DSTjxp5+b/CBrOPuTuMTeOgBlT85870xEe60AHNXuZRDjx2vFeGhtN?=
 =?us-ascii?Q?gpC+Ff+GFBGOlJs+koDSQwVXUkmkkxhONzh2/14TVDEpE91t427Y37ttP/9u?=
 =?us-ascii?Q?pv9r/9ooHreaKkh81P21x4MB8GJdwv+9ypUgvxUCNnwDOx0HxxyJ+O26aAhq?=
 =?us-ascii?Q?TqlO5K5lZF4nWlqfPi5H81z5Plc6YtPuazv/9iP7vMDyvNhcLCq9PuujOorF?=
 =?us-ascii?Q?Pzz7nsfRwuBPmn9wBBMKe+XYkdnr3w7Yjgu3b4B1CRe5ZhYVZeh+4X/knyWA?=
 =?us-ascii?Q?l+ZP2S42UKZjn0PC5dkg9vjEqUmsqzSKqwWX3FmYV7dGle9aDCx7CqR+QORd?=
 =?us-ascii?Q?FXrD3lK12b6Dlc9apyTpAcI99xrzmsDnHu1waYnnyuqViIb1268g0dADQZfB?=
 =?us-ascii?Q?Qw3vmoyX0/qMr8sKrTRT6msTCVw647bgqnKKg3uqxFhjCEAzYRFJZ/Q6gzY+?=
 =?us-ascii?Q?GdbcmBwTif69yL/XwXfw4JNc5hoBH7avsPvBK4xRCaZ+jLHFYWmmlfl2H/6v?=
 =?us-ascii?Q?NYvepY3pWE9JXLne3p8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:12:20.9335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a765692-caf5-4b6a-cc73-08de069e9b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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

Ljo pointed out to me that
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")

both should be unnecessary because smu_restore_dpm_user_profile() already
restores them.  However in looking at the code there is a case that isn't
properly restored - the FAST PPT limits supported by Van Gogh. The nuance
isn't immediately obvious because the limit variable is overloaded with
limit type.

This series attempts to address that issue by passing limit type around
and saving/restoring both types.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Mario Limonciello (6):
  drm/amd: Remove some unncessary header includes
  drm/amd: Stop overloading power limit with limit type
  drm/amd: Remove second call to set_power_limit()
  drm/amd: Save and restore all limit types
  drm/amd: Drop calls to restore power limit and clock from smu_resume()
  drm/amd: Adjust whitespace for vangogh_ppt

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 60 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 ++--
 8 files changed, 38 insertions(+), 53 deletions(-)

-- 
2.51.0

