Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E43CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 16:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE9110E71C;
	Mon, 22 Jun 2026 16:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shEj8xPi";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF53F10E71C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 16:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnenpFoHfVHMg04Z0yPB+T6dS8vGSw4q+4jzDfAum6OykD5dMC+KqxDYAxyAdGhUB5UGOBxUIrOAiMqsSpuZyijfZ36BlcSH/XoZANM4TOMOgO0lbVYwGyIcBhyK0uEe/8GYwhsMxbCMNofsC0dvxlYu0OXwkKLY9TuyzbIAxqzGp3CzP/feF3iees3Q4hqHhElczG+VYMIhKYVOEsX2jSaw5Oczgo1bLEEEb3Kuw3BrM+BQC6OR652uiP1IxnM17rytuUkrhKauT3+cJ6OXbFtf4qdEWGHkP1wj8YEeTCztxKlNk6SpgHkh2+Rffni4aLp3URNYxP8aDIGaYq32tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIFNYEeT8qMx/jdSp9zzTDnDRHDYHPkQleQXLhTKoUI=;
 b=pLLJuLsHEyMChJyDG1xMnFI9g/5wBEz0iBMzi6sZFSR+xClNbogC8XFgIgRohC2j1hlXim7xF+HMMf1O8Jthnxnme8fgOZ09lsm3LDT8O7FiY3+KeM/g/rK09SFppebXMFwe0L1XV7WXe0yxLqtzCxPW3E0nqxHJ/7FaoYCkYgxQonVeCuXreszOkgjAfQVQtFcIO+91SI8b16i5V36+MXNgAFf/t1EWbrCqR7NcfwAHKGl3q2inIi3fYTCh91pfMliCYSX4u+eYTl9KlHrN/UhH44zFdXpLqWBrSx1Mxbjbnt2R6Zp93rQO9HBe2tIaybkK9OjF+E3qGr/4lLSBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIFNYEeT8qMx/jdSp9zzTDnDRHDYHPkQleQXLhTKoUI=;
 b=shEj8xPinNVIb+pnWzao+Tw8mA7AuJ6yzGucinJSfagUAEIUkxEgBulAPrWl9nlI1YtLLRW/Pl0Qu4lK2Ws0s5CTIMAp5zMWfonMe8b//SRdqvkKL7NEhxb6ZoW9oDQbTGIFyY/FthjRbtTfbrB/msDed9c/dbcYYv1Sep7GPgs=
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 16:19:52 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::96) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Mon,
 22 Jun 2026 16:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 16:19:51 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 11:19:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: don't free standalone ip_discovery sysfs in
 sysfs_fini
Date: Mon, 22 Jun 2026 09:19:14 -0700
Message-ID: <20260622161914.1648195-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: f2771f3e-02ae-430d-c201-08ded07a1653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: IEkIBllt1kZYfybGFPbKc66fPCKxDkW0Gkkgecg4mcDYzNd4UguJfPUkFkQj2ASVv3alBuA+4oHzp9qwUobzSx0oIa4kwL8SghPUpsNfXJeXQTF4y11nOgRfB7ygJpqdH2rLKrRoQYdZMTLBDoaTfMuPilkEvJDfCVsr2Eoou1oYVamsMldZoW7A/QkuE1sEz6bO6mDvSQJWcKs0uEplTM1mqHgR+MOTR5+Cw+qCt+MemedRAZPB/UmZzdoU0mV9KCa4SuhWdSOZeEG/unMC7w6Goz5t5HlrQN5lNPLuAJiQpv0GMehzbko/qvWmE+EEwwEcRCl/jM+2JCCMcan+36LdfY1Mxhetw6aOgYoThLPn9ayh2ssrrA7JLh5IXYMk2oNW2EBp5oyxivFvu1gDEqh5XSQ0oulseAC46rTq0c/Vg1pITqm9zAGOb3AhVdSmUIoaMeHz8RzRc46QtfewzuPJrVKdrL8Ocseahv6O1SA6Ns6woa3q97LTqTYpxFonqNPtsWRDOzkzFuf65UjaA43zgttau/ANSEkyOJAVnHYkyXo+osaLNUIvkX9L8IZlKVXo5yBIiSkMxHt4LB4/wg3MYdnRRw5zktJ4Bw+48f8qCue3Pd9rTtRPIDER9kKQHu0vhAUpMC6mRBLrqPvOAwrUkYxdjfeIecTIgDpZ1geBaFUlFF6L8hYw8q8m/dJZaqtSGCL23icjFL6RXW0Obw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CFf+xQz3i23uOrdVHhqnZmoYTwznY0exgzbOnA2WYlg0/tWWfE8mpb7X6Ak25WGQ++PcEZqw6LogOP8WyGi13xcDY/onv1YEJWpRx8uOhQ5wBmj+UWvgFoXvKjtjLTG34ldwVKLPm/mys316sM0BXy0jhkeJkXiUBV2djq08lV/ciDV9fPgbOxwaHdQIFgOg9iwKve6RZWBEQgfakVXucIACsaFTmJ57ugoub2u9Dk54jvC97DgewR7Ht/7wCzmhY8dj+oyz0eP7dKicZ9NIA5s9WXXPLPyP/ciLsWzuERc+B1Ki6jhcY354RPZxeDU5NwGgrcy2z9PiOlHKPbAzroJ/kAb/mhs1d9dVB6jEE19BMduFW5lgcFyw9cEYk8yde57j/VDh4bJaTjjiwRNZFelJ7X+ZdYwTIohk2Dobj1F9MioOi+ZRUhr8DCtnN3kL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:19:51.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2771f3e-02ae-430d-c201-08ded07a1653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
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

The standalone_mode ip_discovery sysfs hierarchy is tied to the PCI
device lifetime and tracked in early_ip_discovery_list. It is torn down
only by amdgpu_discovery_sysfs_early_fini() on driver unbind, which is
why amdgpu_discovery_fini() already guards its teardown with
!standalone_mode.

Commit 7779863780dc ("drm/amdgpu: clean up discovery and preempt sysfs
entries on shutdown") added an unconditional amdgpu_discovery_sysfs_fini()
call in amdgpu_device_sys_interface_fini(), which runs during
amdgpu_device_fini_hw() on every unbind/reload. On reload this freed the
PCI-device-owned ip_top via kobject_put()->ip_disc_release()->kfree(),
leaving a dangling pointer in early_ip_discovery_list. The subsequent
amdgpu_discovery_sysfs_early_fini() then dereferenced and put the freed
object, causing a use-after-free and double-free, and prematurely
destroyed the sysfs that was meant to persist across reloads.

Make amdgpu_discovery_sysfs_fini() skip standalone_mode objects so the
invariant is centralized at the teardown site and the new call site
cannot free the PCI-device-owned ip_top. Teardown of standalone sysfs
remains the sole responsibility of amdgpu_discovery_sysfs_early_fini().

Fixes: 7779863780dc ("drm/amdgpu: clean up discovery and preempt sysfs entries on shutdown")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a229fe9d043bc..029931f4e6ed1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1490,6 +1490,15 @@ void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 	if (!ip_top)
 		return;
 
+	/*
+	 * In standalone mode the sysfs hierarchy is tied to the PCI device
+	 * lifetime and is torn down by amdgpu_discovery_sysfs_early_fini().
+	 * Freeing it here would leave a dangling pointer in the early
+	 * discovery list, causing a use-after-free on driver unbind.
+	 */
+	if (ip_top->standalone_mode)
+		return;
+
 	adev->discovery.ip_top = NULL;
 	die_kset = &ip_top->die_kset;
 	spin_lock(&die_kset->list_lock);
-- 
2.43.0

