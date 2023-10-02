Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578D9E776D4
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 00:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA19710E107;
	Tue,  3 Oct 2023 00:25:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C669510E10E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 00:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moOhSS85/mVrpuBa8JHCzcTmHZbbm10E/FGrwvBm5igFStWRFzW0bAtOjRKBNCgEjHHh1OtbHtHW41nSC18kVGCpnhK8LYAvJKy/yaWuHhU/Aw8r9fMev6GbGABpng7rt4VdpU/19YqvpLmJAXqql/+ShWutDJvSBdkm1eb8UmvIoc64mKAthI8yZ2lr2o92E3zbs/2Sjl3HKkgbdwJbDWXWWCOV4eKlx3DPxmDgU+NisthmC/+7Ac+GvIGSpMimE+K42gekL+vulpfVycwDrpmuBLTau/SVgjgxra+MXOn+XGpZLEYNXcI9y9lhZvPjqE1nUOsaynHenBdVSIfljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLPzZYporJEwEvWGaHf7uiDYxecBMIdUTZ1YJGS58Ls=;
 b=U1iOpVjOy0TYpEBsNn/llMvBiMY+5LxyS1mm5wg+vD+uzL79oBrfN/AMcAxHjVq+nti3uYuKxTUsxaV8GUqr+PyNrjalgMp6UyVMDbX32YAZIh0Hos4CN2G6BXwQaZLZvZHvGuCgLbdilVM12hujwnfMs9/D8ssEgyxfGxd0LBaVQa7m00DdAkS/ZWxUG36y8tB9XvZT0/HBPLD6ytEIZP5m08//uFYo+M1HvncVvCyG1giFv3Xzm/0p9rb0oyLb5WHIXc8bzKm8FLevsZM8lVZ8Odh5X59BQkCLG0evqDtU1aimXDn1SrY6Cdgqd27OvAE5vnfu8UXQdGi94lXWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLPzZYporJEwEvWGaHf7uiDYxecBMIdUTZ1YJGS58Ls=;
 b=pi9Ow2NMrxQZorQdtMo8f2E6kMLExJWAPVJDwMfJBUC2OaTmGcgkgwpOws9jvwxyDnW0fkE+b0Ll9vapkI++2EBQehPAUft+jAijm80uiTCt1YdRzrvaDxOHKAUu3Fm+ydzrHkzyqwaugmyJobaIZJfBZpGOhHOGPrUdN5kImmM=
Received: from CY5PR22CA0005.namprd22.prod.outlook.com (2603:10b6:930:16::28)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 00:24:56 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::a) by CY5PR22CA0005.outlook.office365.com
 (2603:10b6:930:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 00:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 00:24:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 19:24:55 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Better handle memory pressure at suspend
Date: Mon, 2 Oct 2023 17:44:46 -0500
Message-ID: <20231002224449.95565-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 396c3bbd-5025-4988-886a-08dbc3a72bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pi7oh25sKiwlJJqpIH91aex1LAiK2hRiLfl2urD0xLmypyU2TolitU55iz0B+Pb/gGghBLdtAbeYtnh/DX0ECDBSjV537L0RHo5LBQyWKZOZ2tvlICWr/r5TMnw5nS46f+syhfg0z+DVLIplZnYPEnvdjeXoDhEG52F1o9Oryi8TlH93CAQt80m2E0Rv4fQ1qpQvJ1Vxbmif1UcgAOz66YGlu2pXQ5mHSoV7HdQ/q5BS7w2UrEJpRvpHkaKAPinX07T00oefobERMekjvYpZULzjgQ8nJNHj3BrM41WWiY0Tkq6gKd1i7kkQEorzzPIRqMOc9kPvPCRPkq81NhpgebMDgj0XunwFsNJVOaxyF3iX/z9Oc2Bl/7/yawqtrU0PHTU1k5W0EqYvGd2FNIE0PhyQMnbH+NDRBiSiG++4rzd7kP6EL14pepfe65mMN9p1+JhQz/i0+L4fnbcMYW1b5m0/8eVs35qxfHvPaTC2wLrljVRVdEEYy02NAia59YMDG+5xJyiFGk61BOLXCWHqN4A6+IaYGR+a1WfqPswuQ9OW+11TE+ojiUSY2m8ZTNeo62xwrsC69fX0BIOqg0X8WXpr3VkXU9lZfzaMBqZ999hfkimkpWCU2EUhbcB9tuhv7i0fV8d25T4yoC0SO7yDoiNa2xbKkVIRokvLeG0BYwLgqURlav1hFsqrjsV3tDFLAvL3Wh9W/VKO3Rhy3LPzncbGNA2ar+w05HCTVbu63BCqMotIdSjXLXYwRHLPAhbN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(966005)(478600001)(7696005)(6666004)(16526019)(426003)(2906002)(47076005)(2616005)(26005)(1076003)(336012)(15650500001)(316002)(83380400001)(6916009)(8676002)(41300700001)(54906003)(8936002)(4326008)(70206006)(5660300002)(44832011)(70586007)(36756003)(4744005)(86362001)(81166007)(36860700001)(356005)(82740400003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:24:56.2063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c3bbd-5025-4988-886a-08dbc3a72bb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

v1: https://patchwork.freedesktop.org/patch/559270/
v1->v2:
 * Handle DC code too
 * Add prepare callback rather than moving symbol calls

Mario Limonciello (3):
  drm/amd: Add support for prepare() callback
  drm/amd: Move evict resources suspend step to prepare()
  drm/amd/display: Destroy DC context while keeping DML

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 32 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  7 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 25 ---------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 11 +++++++
 5 files changed, 41 insertions(+), 35 deletions(-)

-- 
2.34.1

