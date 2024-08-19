Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E911C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 09:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B4E10E0A0;
	Mon, 19 Aug 2024 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b73H0NKq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519C510E0A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exrRtTd5uXocEvHnS7cpaIPe78wP37SCj/Wn901jUyd6EmB9QsUbkEn4eXW1E/z5/NNY6DZmkOuzNQt6Q+3pc7lQmlfvZ49iouzjQoaPi2wjFYpetnjMjk1wmWQAx0NGWn2NKiXYNeZgpDqjnmnP7cG4asvFEkFq6u+Qmr2WMeie6LW2gg7KiRU7A+uk6i6F5zEfaEDdV3yg87NM8VoLBxE6qYwX8Xd88gilmr0tGcxJRbkyus9AMFsi9QCXZpl+qsGxweRwlmM/4y07Yh+A2qEBTJ7kj62QAtYjkVmVSBm3GnBFh4nV0DXD7hKIP3ggEmlxKmE0lg5pjQHYPDRlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9gtV9X2A0d9IFKqfSMzzgKlFntlKk9Xx/MxZwb467k=;
 b=GAADG9OZbWhY0RIxYUUd3cl3971iuaJrhoFOOKY+EtSjxNhKkaCqLmAdn3zZNIU3CBiGiMd/eb8IIRmzul5Jv/G8JHrkgptKpCbhGMwj9KTG6lEbJci4Hq4iToum3OPda4kpqK5mqa0r7H2Qtkr5B2KDfALhar3TVbm6mbZwGR8Fsk6TpVpZp7HdpPhXvRVEo6CfHGw4xKl5OBFy8iOhqEnPSIZediDJnPbhSrbjTS334ON1URVbiUCEafradJw2+7Q6EXbEkKNAixobg3QmiovxT1sudsLnGo0hVGWeU47k40BlOHhuvzXmvj/f9Ayd7aK77Tw9haDawnRVANloTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9gtV9X2A0d9IFKqfSMzzgKlFntlKk9Xx/MxZwb467k=;
 b=b73H0NKqdrvoSYUFBMww6DC3i8uaLw/1xdehGGE4Xx7MYeA4cgyf1ZYUHl6ffJ8LuIR1mr56kf29XxnNfh7Ai/MjCWtGBGlbdHRp75IXKrkp6HRl0dbM1eldJSRdWx8P19mPodadaM5+8RkN9Ta3AbTF2Qwbx3raE5OnCDOCOJo=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 09:53:46 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::34) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 09:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 09:53:46 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 04:53:44 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 0/2]  Improve the dev coredump
Date: Mon, 19 Aug 2024 17:53:29 +0800
Message-ID: <20240819095331.460721-1-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: ad70eec7-e032-43d7-6c1b-08dcc034d163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YvAvrtLEWm3lVY1FmaMJ5wvDzUFbtpLTQ/Sm3Wgnbxytut8ZHAr4oMEst7NW?=
 =?us-ascii?Q?BWJk1dLAGn0QNZcdPg6zPfgVXZGH03vJelyCwJfcHAMYXOzla/kddS9JeNLF?=
 =?us-ascii?Q?WtSrUqxHB805krRuR35N7hvJiypLCMNNtEotiyZSqrMKci8Tiop3sJC5jgjc?=
 =?us-ascii?Q?DzKxcjvtNhGuGxvLtNMsdiev2+b/uIB5yCUDSPcxjnJ6E6HERj1zLxtVy2mn?=
 =?us-ascii?Q?lyF0aJecbY9yO75mC6U1s9OI+zWfoXcKxX1ZosamtVSIwW1vyTUte/cb16xE?=
 =?us-ascii?Q?0jYpK6VsBaJyMh9NXIRimOMFqt/LOldrM3UBWrjB263/Y1k0Tv0qafAk1aJg?=
 =?us-ascii?Q?tKCmNDIHRFyXfm7F9J52xpgFSnKJjMJHkETD2RuQbdFbPY02jEASwtQufQAc?=
 =?us-ascii?Q?F3ZHScm58S3FzPO9Lit5rDrUDSI5xulndn+FnWin2Sacwf3zTJ5F6FvrJPJv?=
 =?us-ascii?Q?8QHwKbQxGOx5/PolVmwiPT1LJ9vA8Gqp46CKNIY9h7UlDa1kKOFw+/R0WJRf?=
 =?us-ascii?Q?IFfNkwaPoI03EOnu4Tu1sfp3lUbGc8G1Be4eH+DeY34LghnYeqJit5e2hSQw?=
 =?us-ascii?Q?ahLkqnIqD2MLmUijaH0JUisj3EJp7UNSZJS1c5ycYRFI4w+3TB3tYSnc+RdB?=
 =?us-ascii?Q?DazV4G5GWD3yJ2bGNGPRDEgEIpkMzI9HEldiqUmSI/rgsz0RfJYybLxKjVvI?=
 =?us-ascii?Q?yStsAAsKgKSkK2bej8yWo1PkN6n/koj/SK2uRMgzZrU10l/qd8RkF8HbFXym?=
 =?us-ascii?Q?MyA1E11LQnF476pZO2BODG7UORNmfVIHNvlnLtxV1ftGNc/RP++N3fqI3Aff?=
 =?us-ascii?Q?IObMqmSkQi8oebFmtPYM7CYEWlsehojRcMMF9tXR28GUCaD9VXw1vRzfDxGU?=
 =?us-ascii?Q?IMSIltiIKFw/Cyil7s0p95AdY+WV7cubob9JBTGf22j7yaxrbb8yCjnZZgYn?=
 =?us-ascii?Q?iz6C9ny57CXy2UMQVF5KWOK2XgGc2SOLA7cCg+w/6igNzugZ8gT96UtQXUyP?=
 =?us-ascii?Q?k2vIPNAVPwfLtdUuJgZTD/b1QtVNGwVaaTvaDraijt3kxSJYftPiBtGM0Vce?=
 =?us-ascii?Q?dcMhM9aKG7sbqPO/79/WdvGheXl4c4zUSWPiE7e7sIwmLtri7aaWh9UgZBQL?=
 =?us-ascii?Q?yyE4Si3h/QYyScmC2Z2mqtoSdOdWEnmAAqN+pLUuaaITATcm9uK9Xe4yXlTJ?=
 =?us-ascii?Q?xc6GsqtEnWeBQ4X8Lh1SwhgWcSDzMGksNNYS8oLYeeEpzalVtaURMWd1DPCY?=
 =?us-ascii?Q?7v3E+bHdYkxV5XQDIb/qUFa0XcOV4ftCPDwmLYBVXhBeScRQFfML0BFq4By8?=
 =?us-ascii?Q?SC4zsq18U/3Oo4MkjoWLaBucxFhBV0Gw6b5Mr/sg/2MeeyDh5swrrTbxnQCd?=
 =?us-ascii?Q?8F9ht0sgen/CIls/gWIuVjkWgLRdGflT6MoyKe/UqWbDMFkufLHLa5isb8Kf?=
 =?us-ascii?Q?c/BWVDpicMQHkHHobaZAyr4kwm4Wfjqp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 09:53:46.2616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad70eec7-e032-43d7-6c1b-08dcc034d163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

From: Trigger Huang <Trigger.Huang@amd.com>

The current dev coredump implementation sometimes cannot fully satisfy customer's requirements due to:
1, dev coredump is called in GPU reset function, so if GPU reset is disabled, the dev coredump is also disabled
2, When job timeout happened, the dump GPU status will be happened after a lot of operations, like soft_reset. The concern here is that the status is not so close to the real GPU's error status

The new solution will unconditionally call dev coredump immediately after a job timeout to get a closer representation of GPU's error status

Trigger Huang (2):
  drm/amdgpu: skip printing vram_lost if needed
  drm/amdgpu: Do core dump immediately when job tmo

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 20 +++---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  7 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 62 +++++++++++++++++++
 4 files changed, 77 insertions(+), 14 deletions(-)

-- 
2.34.1

