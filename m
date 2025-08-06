Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE92AC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 07:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A5A10E3B5;
	Wed,  6 Aug 2025 07:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWjcnaNm";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30CB10E3B5
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 07:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk00iJn5nC3Ie4hvtzZMYVkDVWM6j6Cgb87PRo3fCholw1jC8ljbbWuSojGcs1ixzCnL16VPkWexaYSxk5gfqheH2iYTULVOju4v1/Gri4soifJxKgjwppUwJIMJMG/uzy/r4ZgFJrpxmb7+a9PuEs+FddqzOazcz9GTxZBUzR1C7QuHE2dV+zVXxvyt+iHTfazOHIjJ+wJgZMGUNiQ5EHBhfaymzFLckx5j0HxI7idVWrjHCCwTZu5co9giP9AEjTGwqOVzGucfUvABcsBc5qeNuNqlCv7S5e0BvP1+xwE74RQm/v1GADUF9P13xBRud5JGNXZqinPpebkDyTfRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MolDF523g6/fOVTNS8n41A6LNEcgk3H1vwmfnor9eY=;
 b=PvDK/FdDu5tR/dNWjjMGjp8J44feytVwgK2dXYznqVgeHNjaqlU0XpC6ICmF0SMvMuLpKQXss4/HO6Q9isiJkNiAJe1iEdIMZaW2DLNVh/Gx2XaaDR8UNObfm7b2lG5C4iGoIbQuT1V/ZBl32+l1/um/7yO0YT20Evn/2HR43XFikwNOXaa/j9UqOzrBNMb9IbnG53EjCawLtyVytsuPY4i98FGusAXAOud2RoyjHUCdxqv+kq4AWwGMzPhYYAwBkftSpRdE1+I9HzXrqLfBaZhOzGTvMqU7YZEAAlw8VIb0YAqqVChAiT2/klRvWlgYbNNXNURUlwA3N0ZtyWoglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MolDF523g6/fOVTNS8n41A6LNEcgk3H1vwmfnor9eY=;
 b=NWjcnaNmb0tUGy4hNsJ+/H2uWE0/iGG68JxuTUhYIRYRTvPjReoxpj0phYdlqWWvyxXog6HDTLIj6nz4ZdzDL+mHoMWLV2eEOFzRuvxB5zJLM2cUHYtPx+KsFYFBJ203fiBWqMyJdN0fXnkXnOG2SmuMR2LZlwbABM50bXMXpo8=
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 07:19:11 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::22) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.18 via Frontend Transport; Wed,
 6 Aug 2025 07:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 07:19:10 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Aug 2025 02:19:06 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: Hold pg_lock before vcn power off
Date: Wed, 6 Aug 2025 12:46:55 +0530
Message-ID: <20250806071655.4160679-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806071655.4160679-1-sathishkumar.sundararaju@amd.com>
References: <20250806071655.4160679-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: f5350cf8-cd33-4c0d-1ca1-08ddd4b98a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODhBV2pBa0hnL0lRTWNONkwxTEN2aUI1RWR0TzBVM0FEUE95dGhsSEd2bC8w?=
 =?utf-8?B?SlB2VThIK3cwcFJpL2VqTVhhZ3hjU3FmNzlYNVNuak8zYXp5WjJJVW5pWnVJ?=
 =?utf-8?B?VVlyZjVzMjRRQk1RdjAvSWZQaG9EbjlXVzJ6L2JUblBuNlkvVXgyOU9XYlFO?=
 =?utf-8?B?cVlaVTAwbzJVbHRMRFE5MUpTd3RHSWdiL0xxR3o2UHQwa3A5Y1V2QjJXaEhZ?=
 =?utf-8?B?VFBGMHVRUXUvYi9ZcXRUc05zUFZMblh0RFRHN1BObGdGQXhWU1FpVUViZTgz?=
 =?utf-8?B?eFo4Y2RIV041Zm5uMHdTVkpDbTVqeU9JdFpQcFh5RVRyWktkTi91YTRmK2lS?=
 =?utf-8?B?U3V0d25xRW9WUDJSZEx0NTJZRUpPTnVqRGlIMnpLSDNlUFlGTUhzSTQyM1VZ?=
 =?utf-8?B?bWNNaEczTkhYV1lzTTRPVDljaE5keXRXQjBpV0hlNldEa2loVzBHOTVzVm8r?=
 =?utf-8?B?MDNBMEszRmxCY0tab1BpMXdONkZvdVZEbWNuMEJ1dUVoUVNaTk0zN2RRcWVv?=
 =?utf-8?B?dkI2VTVWSStGblJNUU9veVhNOTZicERDdXJVcXF5Qk45dU50MTE1cUZ5Tk0y?=
 =?utf-8?B?TWdQYlNlOC81S24zNHVDTUQyWitIU25xUXF2STVGVUNJZ3JZTDZ4SXlLb2Fy?=
 =?utf-8?B?bkthay9lbzhIMndpUGFOVVVzZUlrYzhqcU5ROEZCL3hHZVBHcjBmMmpjUVZG?=
 =?utf-8?B?czhsWG1Zc1dvYU1IT1IzclN6ZlVyVDNUa3NWSTZLa3hBYzR5QjJjT0hCMW1M?=
 =?utf-8?B?U0JoV1lHakRWdDB4QUVDY01FODQ4cWtFdXB5THpEMDdXbENlSHByZGwxcndQ?=
 =?utf-8?B?VjlOdSsrVjVJek1CcTA1SDc1OEFyYkZDWW5LOHFTNmNla2lkQ0JjU0JBSmNo?=
 =?utf-8?B?Njg5aXNVZHBncFY4OERoRk1wbXFmdXU1bVBkZ2ZYcWZ3dVdmMTd5cTRDdjhi?=
 =?utf-8?B?anl2emNBNHVwTjNPUzdpajlDMDBqZG9DaWpDVEFiZGpYTS9ZZmpraEl0NUtm?=
 =?utf-8?B?cE9pcWFPNytFcEhKdGlZems5Q01tWkFOeG4rNGptOXNCSTl4ZDdFNmdubkF1?=
 =?utf-8?B?cEduclJnMVBLb2R0cklEOFV3RkMvdkVKbUF5YVkyNHFxd2ZuWEo1UmUrVzBh?=
 =?utf-8?B?YXZicFBMMzBGWkFLeUVqZ01PUHp1MTIvWVQxeVl4LzJtYnRIcWg0QlcxQVls?=
 =?utf-8?B?emg4Q0E4RXpqMHVkYjBaK3Y5aFNlWUthUFhjSFR6N1FORFFpREFqWFVxZkw3?=
 =?utf-8?B?K1ErNW0vU3loZEgzYUJsQ2FGR1JxVUNyMS95aXcrZ1ZhUGlRams5eVFWQUY1?=
 =?utf-8?B?M2JQdlNIWkpFV1VUOE1VN2R5VFBDajNKUVVQTDNtT255amtRcHhzc2FpdmtJ?=
 =?utf-8?B?WVFoZkpoNklucHV5TWNTV3RBelYzMWhTL0pBdmw3VVZqcGhBKzg4LytBQlkv?=
 =?utf-8?B?V3B6cFZTRlduRzFOZ1FGaUlPNUlENTNid0M4ZHMxUy8weTMxWXdwYk5vZmRv?=
 =?utf-8?B?all1Y09sc0ZvL0Fqd0tRMEl4OE45b1NjL1NuT1EwRGhBdW55OEIrclBRTUU4?=
 =?utf-8?B?M3VSODdTcWp5RzZDbHNUZml3RzdXcng0SDVkMDNLR1VKc3dUUnRpRlRkdFcv?=
 =?utf-8?B?Sy9FUTdwNHhXd2ZhMEdVSmZnbC9xRlRDZG04ZkdMamUrd0lFbHZ5MDZ3RnFK?=
 =?utf-8?B?RDVTR2t3SHlsalJVSmpGUGZlT09qLzlJVGJ5NEp2NGpsYm5VOERJeC9BQjB4?=
 =?utf-8?B?TUpIaWF4N3I2NjF3V09mMzhIWFJzN1RsU2VPOEpNNmpsWU9BMGtQTTdOcGgx?=
 =?utf-8?B?bUZCeTJIZU5ORE1pVTczSWZ2RENQYTdYT2xMNzBReGI1clhVTXU5dWJNVDEz?=
 =?utf-8?B?T2t4ZzhneEliTnlTUFFIOFJkKy9VVnpIVVVSM0dGalFSRjZGYVdFV2g0cFJY?=
 =?utf-8?B?Z0REM0RHVmhiTFZWK2JrZElWL3E0SUh6VzBXVlBhcTJnVjh1V2lqUDVtVDdD?=
 =?utf-8?B?UmJ6MU9sZy9qWkM5MGs5aDdOWmV3a0d5ekI0WVdJVmRhNmVRVkQ4NnVSdWFl?=
 =?utf-8?Q?R0r/d1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:19:10.4761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5350cf8-cd33-4c0d-1ca1-08ddd4b98a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
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

Acquire vcn_pg_lock before changes to vcn power state
and release it after power off in idle work handler.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b497a6714138..e965b624efdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -443,7 +443,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fences += fence[i];
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
+		mutex_lock(&vcn_inst->vcn_pg_lock);
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
+		mutex_unlock(&vcn_inst->vcn_pg_lock);
 		mutex_lock(&adev->vcn.workload_profile_mutex);
 		if (adev->vcn.workload_profile_active) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-- 
2.48.1

