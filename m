Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56083E7C4E7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 17:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E931D10E3AA;
	Wed,  4 Oct 2023 17:19:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4665710E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 17:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REmFjXlqyGty0Yd0+inMQd+TdMFR9qDZkYqMyMRbHIwbFi6JH5C6Ls+yB1iXy8MeYrvj3KTbEUTbiJFlCIrwa9MP+WpuxNtSnXPHvJ6k8rzUAyhKwfQ6zhz3efJMzXNKSm6xFBGE6gJatUSnHmpu4rOtVp7fuNzLfnHs05dH5QssZb31OW53j8e4+Q5yl86cmr2zgGe5Edjd1t4JDkb72Q5BPfKH20EGypyf5gz1T62T4fGYykjQ0ekf+urwa8ZX3aZNcpbq0HuRIvftw6eSyOKs7HAG/yTXVKf69BgFrHrwiAKCa3JUV0hADRTFBuStwF+Yhu+bYGzv9MS+WQZ7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9foFqrj06dDbZ2Nzpxk2bWgS4T0dPtLALPGNqySO8s=;
 b=dj8XkF4sVCgT8+4Tbp213SbFVPPbqCJ7G8JZKjb3h4QxPOHBR6XbhlnVhN9mLrVKczx12IkWHj2ptqxtdMJ0DhiOPKuAgPmL5htXN7RnVgnLTVUHsazrN7iKX0Ml6VOqP0HM/RVTcom3ub8f+N7h48HPK7JD4JdZfDZsX0jtYsT34zfTpfYCFil8MUGOIdYqeo3sujQecL8pawJVTxGqFceJHEmzckEHJVRlzhp7OOmfi7Rw0swe+O6DDDyiStbsLhEyaBz4jwwM3s0TKmKCRM4Xx5BHSVAxynpyol4aoMY5EwRJW/uvtiLJVRQcHfzLqg70xK6nBvs5mmG4A6jgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9foFqrj06dDbZ2Nzpxk2bWgS4T0dPtLALPGNqySO8s=;
 b=mTVITWri1Lx91megXjtlR7YulkN8yJ/36/ahOATp9EatAXKNsX+Ex25khsjxaNN26uE8FTzi6LTCP6EpfMstI0mhQf1q/Wg1/Ur1LC2jeDveELvtGZ4rx9pGdkWjJlwnMCzoJ88D2YsTQl93KWE/CNvLTbLHVMGDM2T9359dJnM=
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 17:18:59 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::27) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 17:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 17:18:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 12:18:57 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 0/3] Better handle memory pressure at suspend
Date: Wed, 4 Oct 2023 12:18:35 -0500
Message-ID: <20231004171838.168215-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 70301326-28d3-4891-f30e-08dbc4fdff58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6DIXF5q/VkcittXkORnmvCLwf6nMcezCkSAX+o0rCUPLPy/sKumQpAYid0NR94rMtEl61NPfbrpjAEvyf/XHNz2BAIDP9oiwWYEfThNV/9wAaqu1O1kuqsCKK6oTv2R32aSQncYcRLS2FusJjPjWUsVLW6rwTfxpGm4Zq+hSoo+/EBik1g1ExJ+iXUM+p7y3C9T6+HqUkvYUPsCmQzmABwhXpG9rni4vU+olzus7+kU71UKPuMHL63aIYxV43Jd4IsJ/tTeaRKWNBElBaTWcLlUkt9jZaGe25D4dhDRJkt1fjO9oJpwqKGR/j0KwFrOiHFQoseuJkt5avWuHGbH3/EaPD+vCDARwY2ciVNFHcYYjgRluYovDFILDJKxFkd3HYIpwnZlFfJb8cfUCqkQA3rs9626VCjQILPwd0o33UWkK7X9OH8lqtG21thGX/fggp7S/5XuKa4uG8YOS50XJ4Fe0Q7XgNoOEOpfeddlJPCOBQpc2HqHgWdqvBqy9I6Qnm7qANbhJvTrEf9G3u8Loenkl1Xv4A+n5nYozPNX8Pb8Rg2pcr4dzqJsRn93uVmpK1Qe+0FAnIqF2cOGZAD3z7quDGU6wFlXInUKYLOGo+LOZCHQVOv51C0xVLAzez9L9amxX9NHKiKdXKLeycH8HNOYyGnXf1uS+skHa8aGKY5Gd7AxJnMoM+8ShmTVB7N4t8Y8oq2iVgsTCXoBPMBKQfF/levm0NGfxIW16ZDk4Coyh5at7RBCOKtji/LVCZhlsWKOquGEqqaSuh+rUwqOzNtgyQ7mLPNCHozivqLuiA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(8936002)(8676002)(26005)(336012)(83380400001)(16526019)(426003)(2616005)(4326008)(5660300002)(44832011)(7696005)(82740400003)(36860700001)(356005)(81166007)(47076005)(1076003)(478600001)(966005)(6666004)(316002)(70586007)(54906003)(40480700001)(41300700001)(70206006)(6916009)(15650500001)(86362001)(36756003)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:18:59.1284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70301326-28d3-4891-f30e-08dbc4fdff58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

At suspend time if there is memory pressure then dynamically allocating
memory will cause failures that don't clean up properly when trying
suspend a second time.

Move the bigger memory allocations into Linux PM prepare() callback and
drop allocations that aren't really needed in DC code.

v1: https://lore.kernel.org/amd-gfx/20230925143359.14932-1-mario.limonciello@amd.com/
v2: https://lore.kernel.org/amd-gfx/20231002224449.95565-1-mario.limonciello@amd.com/T/#mc800319a05df821cd1875234b09bf212e2e3282b
v3: https://lore.kernel.org/amd-gfx/20231003205437.123426-1-mario.limonciello@amd.com/T/#m00a49b75cd2638bf8a0ebd549d6a6010bfb7328b

v3->v4:
 * Combine patches 1/2
 * Drop adev->in_suspend references
v2->v3:
 * Handle adev->in_suspend in prepare() and complete()
 * Add missing scratch variable in dc_resource_state_destruct()
 * Revert error code propagation in same series
v1->v2:
 * Handle DC code too
 * Add prepare callback rather than moving symbol calls
Mario Limonciello (3):
  drm/amd: Evict resources during PM ops prepare() callback
  drm/amd/display: Destroy DC context while keeping DML
  drm/amd/display: make dc_set_power_state() return type `void` again

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 26 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  7 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 +++-------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 31 ++-----------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 7 files changed, 50 insertions(+), 46 deletions(-)

-- 
2.34.1

