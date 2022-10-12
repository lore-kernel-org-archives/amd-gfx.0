Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F16C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 09:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CF110E083;
	Wed, 12 Oct 2022 09:36:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF61F10E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 09:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFgVPqlaQSJbXK3Apm1ugzzNXQz/dn0hZItcC1qHKlIF9dvw+phcTxeTkwr0vLFF756AzMPB0tzmLyM1TJk4E3htRuh3b5VxmHYhsfuTjmir7X3hbhPrFh2rpYqBEcmLUjKOBl/JsUXVjZTGwnMxomAm4hx6LnFT7Y+JoAeOn6j9qf6ZPPG0u12sHLMPYKIjL3JFQAalqarqATDcf3Bpuu4ZEM/nuAtUDlwTstf5h5u/F6oc2kRLyoZxiJ1757DYeAxauPJ1OgAGdYLLkL8vuQQeIjUZLxX5DwWnG9B4bjkqDtYcR0jPGf/gRboIqKZGSYyaKFLzPLag7F9x3i/hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky7DfmdRvDwjuBmlpNYNk1CdImaorNkRb0KsiRT2JS4=;
 b=JanqHEt0KZ/hHWhy/ozU8d0g4BeW4jcwaLB4Su9npmKft0obAphYsOY8g1Apm96QiysJISkos0sOrwCi9uWmOvvGOsRR/iI5hEookNIVjxFvWncgmZYeA8aZ7tbHjpXTMUrwGIeqPCLN0Tk69+G8T66jFqZjGvgF/lHmUpmI2vr3wnJiwG4Bzf7pdwSMwo8VaEls24PfynoJlW57I/d9QD1ij/zVS3PY4v5C6vkvwMj7a1NYANRSjV351L2mHcTT17nrrLU0yexcqzrEWsviHLmmzDqmuML0IRulFJ9Z3zHZoZxpNP7eDPnQPErwNMXLOIaNGdMEoTj8hmpH+uigmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky7DfmdRvDwjuBmlpNYNk1CdImaorNkRb0KsiRT2JS4=;
 b=oPpgjJW7J1Eaw57yAS27p/jsMBlyZTIz8xgR8aOUXM59tiXbcQyhEQdhWcL83uT0q71L3Uq7K+jMvyPgKgvL+nrXjDw3GMR6dl4nlqKAVQi5i7oaP9vzS7SvMofP7zIdj8ErCF45d3my0PLlx+oBVaY7lGMGk8LCB28ITbSXK+o=
Received: from BN9PR03CA0780.namprd03.prod.outlook.com (2603:10b6:408:13a::35)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 09:36:19 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::a7) by BN9PR03CA0780.outlook.office365.com
 (2603:10b6:408:13a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Wed, 12 Oct 2022 09:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 09:36:19 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 04:36:17 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Init pm_attr_list when dpm is disabled
Date: Wed, 12 Oct 2022 17:36:08 +0800
Message-ID: <20221012093608.1496302-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d0b904-d453-433c-dba3-08daac3537a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DX7tRBId0L9slc0VHVr0HspLMh1O2oVCCbiUT+44HtI4n2chSOf7E5JozecMkmXObRtqUKHCGwDaxRa2kkeODQO2T0Q1hIr8b8Yo93oa1PhpUZ2DyOWcDoBfdBdQJG6KPUjhdopoSvGOBHVB2qXWrOQJ+dyaJM1ysHA/SHLCuCNEbZVVFu8uZT77SwNjESDQyeywJw52hLcdD8VPzw/oMsrz3WkO6ZEO7X+LfvzdnAk2qmvTT8Y1IoGgP5YcRk1ElZw2SLZaIRNWm0rkinhU9iOYHf5SBSiYYtzHhj8C1DFeAHVJNLn1/+y41ePhZN0oqJHzbIdNW9KXLZ3JuO0mjgIfIjRq1l5u2FOF9nEdtBvDbtWykFwwmFc2hpDABh3u0vNLVgwnxsrkq3TmMgu8xwLIwAw1XGH4QMpd8fKin0Fxw0J0yifRGNRYvPBRfpxU901cdDzLrZPnePhRuos3bF3Pg6kgfHalVE2qOgvhc57kXBBIaE03WDyHXRvYwSUBmpTSBgzvrG3+rmUWPjqlMq4ZIDgHXGz/8A5174n/UbKAGhFI/TaGG5QbGPBy5R7G0ULR5OQ/eTCYTXuSBz+Cvpc3DI0FD9SlfKfyYG2U1H4TeTPLfzHm+ZiN/jnbxycHBf5SOIQIZ0E+sE4iPIwaQCHDk7Zffj3k4S/BVVoy1CTQWw/tqo8sc95svBxweh0vgYNNiIud1Xs70qzeaZkv/0gLczuGJwcBZimB5CZdE2riK7o65UCiRVK4Uxindo54CR4//OsqGvsmw1XWX5plsQlFyzrsPYXu8qdWFgOambmP+NF7IVhh7de4IT7ogJl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(86362001)(41300700001)(5660300002)(2906002)(4326008)(8676002)(8936002)(82740400003)(40460700003)(70586007)(70206006)(356005)(81166007)(36860700001)(54906003)(47076005)(83380400001)(426003)(82310400005)(478600001)(2616005)(16526019)(336012)(1076003)(186003)(316002)(6666004)(26005)(6916009)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 09:36:19.2672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d0b904-d453-433c-dba3-08daac3537a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, jingwen.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
In SRIOV multi-vf, dpm is always disabled, and pm_attr_list won't
be initialized. There will be a NULL pointer call trace after
removing the dpm check condition in amdgpu_pm_sysfs_fini.
BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:amdgpu_device_attr_remove_groups+0x20/0x90 [amdgpu]
Call Trace:
  <TASK>
  amdgpu_pm_sysfs_fini+0x2f/0x40 [amdgpu]
  amdgpu_device_fini_hw+0xdf/0x290 [amdgpu]

[How]
List pm_attr_list should be initialized when dpm is disabled.

Fiexes:894483d76ada ("drm/amd/pm: Remove redundant check condition")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 948cc75376f8..236657eece47 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3362,11 +3362,11 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (adev->pm.sysfs_initialized)
 		return 0;
 
+	INIT_LIST_HEAD(&adev->pm.pm_attr_list);
+
 	if (adev->pm.dpm_enabled == 0)
 		return 0;
 
-	INIT_LIST_HEAD(&adev->pm.pm_attr_list);
-
 	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
 								   DRIVER_NAME, adev,
 								   hwmon_groups);
-- 
2.35.1

