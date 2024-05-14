Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D1DC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197DB10E463;
	Tue, 14 May 2024 08:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0IdXHWIG";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E3D10E498
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/xs/WLINOCauNh9jFdcccI/GccMIbfJ/W6R/LopmASz8QF64RtxtCWFPw/Z43FVuNNoq6Pe1rF4UZDyoGT/FyPwia6/3y8OdWZErfWijeGjhD7OjauLCuOXkBCgXGIcEz4eJcCodoHeQjDe46t0SL9SrCGjcQSdzXaCcReA5SrfXOEythqg/75VEHDrXtwoLMt5w7MZIsRPGRSkF8ffg51aEbQaFDv8UQr/235K49R8AqdwKtzNnP5K+Z3ejS++OF91QDo/e13J3130v8xVF/fsYeZw8shOeMS2EiAUKso5ykJeTcu8qQ8P9/gE/9Up6euo9jxwG6H+7Kr1SuvHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+U6fL062Ja493upHOfaSqz1nb3eqEMpCUL+f8me2io=;
 b=IdkVgGTPVDJ8uzhlxXZfpnXtgNmHTwLpnk4pR1shXN9YUm5OUo82fO7vcK11Bvx1C2BTn2hiaRkYxlOfd4+IJUl6m0UJmKM7uRC4BeGgP5JG7C8sS80ET9/uSAZJ+0M9XS7pJ+PZas+BOUc+hLdMMvgkzkcU3rccuSp7O9febNPEH38x70beTt7tt3INrgYKfE8dWotQZiVOMEYaFA4UCHUJ7fSSp7/obgtJ1kaF9tEK/7I4mtyFjFNNp0BJI4CDf5m4Iu5vsMh12yUuNF0uqqZe8k0HWs+w71zJPzC75xOrrUbi35+hrXz/tYyJ+4j5mbY4L9PUkb3edqcjQ9xUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+U6fL062Ja493upHOfaSqz1nb3eqEMpCUL+f8me2io=;
 b=0IdXHWIGcblpwuJSCeRopscE5yqFUX0VJ6HJQZQG/8uk8bqrsyvpT8w4JBpwkTWsPioRy4ZJiuf/TwFm15G0OUarPXD/O1LW4QNOxHmAddJpgt0Znbj1cepgdAtCEqsc2UfUZCakex5xU/smpxk4E80vCEd+1AA+NoPFU7VIWKI=
Received: from SJ0PR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:332::20)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:36:45 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::28) by SJ0PR05CA0075.outlook.office365.com
 (2603:10b6:a03:332::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.24 via Frontend
 Transport; Tue, 14 May 2024 08:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 08:36:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 03:36:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Le.Ma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Le Ma
 <le.ma@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Fix memory range calculation
Date: Tue, 14 May 2024 14:06:24 +0530
Message-ID: <20240514083626.378626-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 6228e077-56e8-4aee-24be-08dc73f0fc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXEzL0oxak1WeVpUK1kzZElTeW1ZYUlLTHdLNDBRcitSY01MTFo4blZkN2NQ?=
 =?utf-8?B?cmx6R1NBVTN3QldvWWJwNUczVm9vanFzRThrSG5IQW91L3lXSkIwZFV2OEh1?=
 =?utf-8?B?YlAyalBlbk92Vno4ZElKSDJsVGpQYSsva2YxTW5MMC9vbCs4dXdmaFpvdzdP?=
 =?utf-8?B?OC9paE51RkQyYnA2VFFvUldpUk5jd1FvWGk1YTVxbmJVRTJudy9Vdm5NZjhF?=
 =?utf-8?B?cmM5NGYydGNqbDY3ZHF3YVVEaWJXb1MyWVBhWHVrWi9EWExMUVNiaTVNMTcy?=
 =?utf-8?B?NDFnL25CcHd4UXF4cW1hOXJxYWtoeWRRbGFSSWU4SGdZczh0NFAyaXZaYklw?=
 =?utf-8?B?Y0hkMTdYWDdwMDlxSk5obFRUTFNYSUpWN0pRcitvUDVhN3ViYnVCcUtVckhX?=
 =?utf-8?B?anh3MVpBMTd4WG9hTWhYZTQ3SVczSWhUdC9KS2YxaDBJajU5ZFpHZ0hrYkdD?=
 =?utf-8?B?d25ZOEFkVEd4QWhjOUQyd3NTZUtidmVXbVdNV251NTk5QjVEb3ZDRG5ndlgz?=
 =?utf-8?B?dHp3MVZpaHhPTkdwNkQwOEtveVNIbTdnWW9XSHI4ODVtKzdGUFppcFR1blkw?=
 =?utf-8?B?Q0Q1bFFDbGJ5bDJzaUkwaGlLN3MwT1oxRkJvY2RodzEwTUdsUFF4R2c4RVh2?=
 =?utf-8?B?VzE1NXNZcU5WREdOMDgzaiswY3loTUVNQ09ZRERZOWc0T3M0My9mUHFyMkp5?=
 =?utf-8?B?N2w1bTZJS2lnQXU4SC90cEhMazdKakMvbmNlTGFXNktWeERXWmFpZDdiRk9r?=
 =?utf-8?B?VGRVZ3V2QllQTkxIa2RrWHpJQ211ekx0KytGS05XZkRNZWlodjEyVFRjdi85?=
 =?utf-8?B?SkpZYlVucVVGUnF5SlY2WEJVd2Y3K1h5MHlUVXBpbEtMMXcrQmxHL1Q1Z3hO?=
 =?utf-8?B?bTdOc2RRS1Z6Z2N1OWRZV3ErSDk3S3hGYnpCU0ttUC9qdE8vOXhYeGJJc1Fn?=
 =?utf-8?B?bWN0eFBNUmZIdUFlY2Rpc1d4TmF5Uk0wUXpuTFVic3Nwd3hYeHk1Um1KUFNN?=
 =?utf-8?B?eE9FWndiNkF1VGw1VFhCeUVWUU5PMDlJTEtQenF0Y3dpR0dMRVpCdnNURWZy?=
 =?utf-8?B?U0tzOGUyVUgzaTNva3V0ZXg5dzhVQUVFQUhwZDhsQTlCZTRYNjd3UXhXNEdO?=
 =?utf-8?B?L2xwbFVSVy9MUVJ6aTRReVAxalh6alBtZWx1cVFYTzdUM1dRVkJZVVlCY05x?=
 =?utf-8?B?TWdQcjQ4cElFVGJrTG1uSWhEejRpaWFYNzFsdjFYMGkvVlRGZGQwTzUxNnAz?=
 =?utf-8?B?NWJhVWtZTGprdlE1K240c2Y4djYrREtQZ0ZlYTIwQzZ3d01RcW50dXdKZ2Jo?=
 =?utf-8?B?a2VuQklGT1V4YktSYmN3MDZ0c1JpTm1mOTFOeCtoQWIzaFZCMVFoNHZxZXpY?=
 =?utf-8?B?aS9neFZRdlVkM2k0WmhDN0pubzVFNE5tM3lEREM2VW9TL29TQmxMaVBiTVZj?=
 =?utf-8?B?QVB0VjdEdDZrR3dCb0JGRDFNVXIrcmdPWSthdFdydm15TDBKMHZtRVY4ZEJI?=
 =?utf-8?B?ZWRQbmRIVnpBQzkyUnpNcWQ3QTd1RWFKK3dYYmNVMGdpZkk1cmNRNVE0UGg2?=
 =?utf-8?B?ZENBaEUzMXVQVU9abFBUNzRmcWpWV21DRGJ1azVKRFQwTkNYYmxic3FqN1A2?=
 =?utf-8?B?NDdCc3lqbWdVdThZSzlwNDFYSEdhb05hdmxyV1V4RVIwMzFLbndydWgra1Rl?=
 =?utf-8?B?M3daT1Z3RDN5WEFKcWVJUEFtbWVuNmpBOEc2Nm4wbHdQR2s5ZFBvN1gzUHdN?=
 =?utf-8?B?MDlxZUluTnJ1RVVudG9nc3IwcDNoZHFKYnY0clhKMUFGYnc3M2IrdmozYnMx?=
 =?utf-8?B?MnV5WEFRamZIY2FoL1VLbHU2d043VWlwSDFWYmltRGxTRldPMHg2dTliaEJt?=
 =?utf-8?Q?uBUt7IDeOsXY9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:36:43.6693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228e077-56e8-4aee-24be-08dc73f0fc1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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

Consider the 16M reserved region also before range calculation for GMC
9.4.3 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>

Fixes: a433f1f59484 ("drm/amdgpu: Initialize memory ranges for GC 9.4.3")
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 671a6766df5b..7c4e2adae7b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1918,7 +1918,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		break;
 	}
 
-	size = adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+	size = (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHIFT;
 	size /= adev->gmc.num_mem_partitions;
 
 	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
-- 
2.25.1

