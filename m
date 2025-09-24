Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF40CCAC5B1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 16:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BCC10E76E;
	Wed, 24 Sep 2025 16:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4qYkwZ3";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F60B10E76E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 16:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDvCEYzD/apM+odhtdIbw9NN7cMWiHdXA9KdwyS8i7qxNxvrwWbb/zhfvk2FkoW6GAuLmn0LEjKveVhGH5TfKdUhoYtmqDUDhDuB6Ba3NoOsZVQpILXqBCyr9EdBF552R2qKUgm6dR2rl1w+SLggSKbp7gv4LVxeF0m0R+MaVdOrLky3GtUD4BXROX81CpbxZptmev11PMoSNyo0Lno37QiiLwpAikLXye2viMJjNNWL7/BjgYz83MuiZP+a2qEHecEeAM54NOUxvyFtCTd2VeVcqKIHoj9Ye1mor8CXpYqCxJjwZ86M22WrQzxEhNrOmvLlWHtdpZbQ27YYUGSXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yJjOmv/N/qpqSXwegwSCzw/UVr8TDe2qzH2e4ZPpww=;
 b=McAC/3TUNz3ZqtIw+v2hysmxiWaFTpZ3ttNSs8lZlE7eICHrY0sx4Z9MBEGcDvfbmoURYcE6n+mTY6MjrSeBOhX+ysLMMAIrqXENHlmU2AsJpoqUoU9piDIq6IsOQAxbCpHBB/wwbG9JsAswhO5Cj8CUk0/UV0/ZHHVsGlOjH4Zl1wTCNIvGJw3zj2P0iEPb1uExLkmQo6FSgpM/sMiSrkcqK79SotFbMpspoV5Pfx5PMzCQTu4nFgAVedfs2Y0rYYncNNpxrIQpCK11hoA3C2HSPAjv4fFRntPSYKCpOBvRpeEkWhkybEknRx/Bq1PmdEotuhxewlH/EkYAOpAA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yJjOmv/N/qpqSXwegwSCzw/UVr8TDe2qzH2e4ZPpww=;
 b=k4qYkwZ3z6IBbb5Q+F28+6Qpbi2ZP99QJKHhMKWAZsTfNvnI2e8F1u8lohh+JCscEuteJpbfr2a9VKypumAp6SzrXGdA379TIj+tR4J4YnGBBnvQiINXlRut5sD6TALqGpTXPZted5PrhK9HK+PYQAa9Skujn3XVEvr9GKnuSR8=
Received: from CYZPR11CA0012.namprd11.prod.outlook.com (2603:10b6:930:8d::25)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 16:16:49 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::83) by CYZPR11CA0012.outlook.office365.com
 (2603:10b6:930:8d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 16:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 16:16:47 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 09:16:43 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amd: Drop some common modes from
 amdgpu_connector_add_common_modes()
Date: Wed, 24 Sep 2025 11:16:23 -0500
Message-ID: <20250924161624.1975819-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924161624.1975819-1-mario.limonciello@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: ad46feb7-0e46-42af-b1b7-08ddfb85c2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dExob29oOEQvMyszWmZEU3RJdEdyTVFYTHJCampSYVNnUWdvZjUxNUJaMW13?=
 =?utf-8?B?YnhhVlpDM3NQeEhIRm02WFpNVVFwQW5CUlVYbmQ3MnBFemNybVA5OHl3M1VD?=
 =?utf-8?B?cDZRSWdDZy81aVV4UzcrV1NnT0dGVTFjcVF4cC9pNTkxZjRORjBGTGc5b0F4?=
 =?utf-8?B?WFlLRHdISmNyTWlkVDZUOWRuSVJldlZKUzJ5S0NxUmVWQWVUUmVVNy9EckJC?=
 =?utf-8?B?TWwvSC9zYUJzZDI5TjEraG50aWh4ZUgvZVp1T1lRNjUrMmRPRkZwRHJvZmNG?=
 =?utf-8?B?OTZlVmRwVUhHVVZGWDQ3YU5MZjhnS0IxSDBIZ1ZBbkNyeHRIQ28vNit3NGty?=
 =?utf-8?B?T1BKc0J3VmJFaVo5TGpYc2lrdGNJQWUwd2U3SDk4eUFNL0M3TzRrZzhtU0gz?=
 =?utf-8?B?ekFHdENWNUwrU1ptUERHYk1ybWZQNzRwUnY4dGFNQUZwSkwvM210WVp4SzJO?=
 =?utf-8?B?NTU3Z21tZWVmOHNxRVRBVk8zKzNYMFI2bDh4SUxnalkvbkIwU2FPOFdhVzV4?=
 =?utf-8?B?YVBZRjJCa2ZoeE56MnV6MUN1Sjh5Tm84YkhGZDJlendSejRpa25qL2RrNWRh?=
 =?utf-8?B?S3I1aG1pbEdTa2RKWnV5QXpUbnBNTUNLVXRVbGtwbGVtOXR1QmxicndTN0FO?=
 =?utf-8?B?eGwwSFZQUS8xTGQ3Z3RNSHcrVXVLVm1haitYeW83a1VoR3kxUU9KWlZFQlFH?=
 =?utf-8?B?S0hNZWFNdk1mcS9BSlVUdjZMTE92d1ROb0lMbHQrOElxZDNtUEt6bC9yUUdS?=
 =?utf-8?B?U3I1ZlVOZHJnTmh4dDlYNXA2NWFZd1hsV0pibCtLOUkyTFk0b3ZkOThrdnY5?=
 =?utf-8?B?emdHbUVyUjNycTNPYjdzZG9HZTluUGovNFFKZ2ovVmRhaE4vOEgrOHIvQ2ZR?=
 =?utf-8?B?UzVmZXl2TXpQWnRrNURzNFU0elpqMk9IbE1DaEs4ZjhkdW5ZWmNyT2pMWGxz?=
 =?utf-8?B?cENIQzhzL1Jmb0w4cnE5Sjc2Z2o5aS9wNzB4ek5jN3BhUmdRM244bXh5QXpi?=
 =?utf-8?B?djRWM2RtUGFRRjRlWDE1OXo3aDFvUGJkRi9mV2c3L0tQY3NYdzhSVzJUUU5I?=
 =?utf-8?B?VFRERzQ5dDlMcU02V0EyUFVxd241YjhUZmFLZWNKVjZ6cEMxYmhLVUV6NTZX?=
 =?utf-8?B?Z1BISUlCTHM1aHNxcGx0M3cralF6b3FYWUlkY3hzUDVQN1QxM04zSG85c3hw?=
 =?utf-8?B?UEROUzBhS1Y2MnEzQWpJQ2lGTzQwd08xT1FUNm1YK1J4MDcyYWlHLzFydWZK?=
 =?utf-8?B?ZkNWT2J1WmUxK2lGWWYyMUMrODZPREkwZGxNNWRjVSt1TGdSZVpBYitTQnA1?=
 =?utf-8?B?aHhrTlhETlVkQUJhcGZCbzY3N3dhcnZ1c21ZSFFaSjlrL25kU3U1bE43TTB0?=
 =?utf-8?B?VVJWS29EMXFQM05aRUdGQ2p2RFpqT09RL0ZrVUJHQS9zbHJ1a3JUeDUrN25F?=
 =?utf-8?B?ZHRJYm43RExjakQyRENJejlLWnBBVHArSzVjTEsrR0V2TVl5V3BGaGk3UElr?=
 =?utf-8?B?Nm1yR240YjNLcHdLejhUYm9aVWFYSlhhMEVYVjJ1Mi8yeFlabDY0bVhoR1Fo?=
 =?utf-8?B?aS81WE5za3A2dTdlMFlJL2x1ank4VUMwdDhOSjR1N0YzendqUDJaSElCRUJZ?=
 =?utf-8?B?UEJOTjlESExJeTNLUmgrMmdlYlgwRXV0NnFOR3VubnhaZkhKRVFIMVNtaW85?=
 =?utf-8?B?dHZUczl6TTdVcUF6VzNwMmp1WXZmbGxyUllvQy8xOExTUzUzQnRxK2UvVmN3?=
 =?utf-8?B?Y2xwU1J5dUxFVExmWVd4aWc4dC9UcTNENzdDUTFibU1hNitYbUIzQ20zZE9l?=
 =?utf-8?B?NkZCOFRtVWRVZmIzR2lsTDVENXlhb05OZUcxSGx3K1JlY1ovZ05RS0xuc3R2?=
 =?utf-8?B?SkZvQUZrQTl0TXdoZ1IrdFcrQWRsOXkvY1RHMW9Zb0lTbEMwaWs5b05hRDg4?=
 =?utf-8?B?eGRncTVETmJob3FjY3loZ3dqYWx4aGdhNEMrUk5ING9IS1h4cklpOTY1VmZ5?=
 =?utf-8?B?UmYwSTlCVktQekpYMCtYeVhsSExHU1FmTFhuTDJwOVVQay9NczBBQ1FjTHBy?=
 =?utf-8?Q?RWkMu+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:47.3420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad46feb7-0e46-42af-b1b7-08ddfb85c2d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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

[Why]
DC and non-DC codepaths have different sets of common modes that are
added for eDP and LVDS cases. This can cause different behaviors for
turning on DC on hardware that can support both.

[How]
Drop extra modes from amdgpu_connector_add_common_modes() not present
in amdgpu_dm_connector_add_common_modes().

Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index ba24a0eba2a4..8c085ed703dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -404,18 +404,12 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 		int h;
 	} common_modes[] = {
 		{ 640,  480},
-		{ 720,  480},
 		{ 800,  600},
-		{ 848,  480},
 		{1024,  768},
-		{1152,  768},
 		{1280,  720},
 		{1280,  800},
-		{1280,  854},
-		{1280,  960},
 		{1280, 1024},
 		{1440,  900},
-		{1400, 1050},
 		{1680, 1050},
 		{1600, 1200},
 		{1920, 1080},
-- 
2.51.0

