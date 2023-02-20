Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785A3C64EC7
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 20:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC3A10E782;
	Mon, 20 Feb 2023 20:16:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F2410E297
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 20:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPUXMX6/CGCj06nfJOU5br4VFWQZCBPCJcgDmLAOLiTTigwvoIvTRWr04FVACx0e7H09ms8vu9ntO03gC7KgDXcG2aP9aM8Tf2X8ZqpTQxu/yBJxNSmOOjaZpkd9POp5sqqAqLZGg8RWEvl18lVuSvFPFjaBuf9NXoBKyDZLPesPuuF0YNFejaqkQUEAUv4tTNq87WWo8kIVKAuOzFyhHKIHXOzvIMEylJt9MezuReI6Pmm5ZtKjCvmmbZ3PfFukoY1v8GRWfpgrgptT1+v2saYkCRTFzxPLcLF47sUjvsFQlJhN8Ux5BLYyE1A1XiU0xFjVAwrF34UUAJUCreMoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TsyuyrPJOesI4MJ1GqP5dyn4VCS32iC5teq03RVfuY=;
 b=KVBflZFmNm12rN95purpKhhC4DCyZSfxqUshxEmoI0Ka67zPC4SE5W/9NXj6b2y3/SVm2yDvts7b9LtVL4IE++h28aES2lmvJ1+h6hs87KyEGficnzlzXfHmickTBlVoBRIkv4hVUENZScRonWMaGkVE2qotAYPaLVrrmVYji1O4CYoj1+utqbVGDvkxoqGVV8GKRYINv45bfwAMI5+yKKikw0fTISEhdt0fhZbi1ymN5G+mtaHQQ510BHFui1TTVm7bbsRj5ZYhofoRfGvhBBFPxtehvOp5zFvyP/mpCtSeBUt/IMQK1lKlPzrYQhVkaadEAD7TUryAbc+yAMLIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TsyuyrPJOesI4MJ1GqP5dyn4VCS32iC5teq03RVfuY=;
 b=yCg4qphFoWOA06xG09CXc1IsEX4Qk1OpuLYFvuew7r8Mob/QI3AkW72/ZiYDcUZJBIaMfY6nkC8M8+OegOhalVi1eQ+3BI9Ex6Irj6Ua5BZfo3CU0w1efFGFEzzXnW/lEDstFTNYvEexK3e75PPRQFvCCQ37ZiU14/ljml8Z80s=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20; Mon, 20 Feb 2023 20:16:45 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::10) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 20:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Mon, 20 Feb 2023 20:16:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 14:16:42 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 0/3] Adjust suspend flow for dGPUs
Date: Mon, 20 Feb 2023 14:16:15 -0600
Message-ID: <20230220201618.25962-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 4936ae82-7c83-480c-0088-08db137f6359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oy87htf5Khls+yhL8T/oYT06tPHBb5fRTLNYBNvYNMEt07T3GV2iSPimyVCRq2XxFL5Zvc4Jaf5ZO1pYxv6OekHT0C166Xa2d5XJK6C1X5vabE2/x3iX2nK5zULjCOyvMo68Zr12ZqyTB+KXJGtdoJf8mMnWHaWq53KNchj7ocHFtqRDg92zRH+/2SEB2zsXB8L/09izK/mvTy9cXEwPZ97/0AoEDsMdTgeVZG5qxhQaCGyN208HbPA4QRT2SpXHtX/vR5msKI9iJ+CUiXfqMg8cyUJts2dN4b5GNsyhOZkqDIjz11KaPL7N9e6ucFI6NvgcwBKb9023iMmD2gQ7xSijKGT/dinotFBlzK4EEd58jRVXjdtRPu/Y4OG/83GKLRXya1RmioigQ9V2de9laSUgoYCiW+aQIl+0/agf9k0Utqt2o1IIvm6hiA4I+M/EOuSw1mh1XrGMcX6wD+UNiGS4607V9YABZMj/eTYurkIdit3Kv9euIfLv+DjeaVmTGY+4Us7OvlW3IX8D8YGQm+Pvf3OPqpRVN5SYb69FqQ8qxpXybHQA7ATlSj8KYJBZRhL4auSkwLlQZas/xackbVRoftsEkyWJwb6yRsVxx2ha9cV+TDPaTFp4nYhJlZqVnBARsKx0kQfgdyhzHYCXSelPbowJ5Wd6huCQR5lcu5dovD5rcYmb3n+OBy+dHlgGrWEw9yrt1GRSAEQbr3IJg7kTkVIbE1yKraWihcNxLSg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(7696005)(44832011)(336012)(4744005)(36860700001)(40460700003)(83380400001)(54906003)(316002)(36756003)(8676002)(4326008)(41300700001)(6916009)(40480700001)(47076005)(478600001)(426003)(70206006)(70586007)(6666004)(356005)(1076003)(186003)(26005)(2616005)(86362001)(16526019)(82740400003)(82310400005)(81166007)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 20:16:45.0202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4936ae82-7c83-480c-0088-08db137f6359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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
Cc: Peter Kopec <pekopec@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently when a dGPU supports BOCO and is runtime suspended when running
the prepare() callback, the rest of the suspend and resume will be skipped.
This skipping is due to "Smart prepare", "Smart suspend" and "Smart resume"
flags.

dGPUs that support BACO are normally suspended via PMFW and lack of video
or audio, but this policy doesn't apply to them.

Furthermore even if a dGPU is runtime suspended the system wide suspend
callbacks always wake them even if the power rails won't be cut.

This series adjust the flow around runtime suspend handling for dGPUs.

Mario Limonciello (3):
  drm/amd: Don't always set s3 for dGPUs in all sleep modes
  drm/amd: Allow dGPUs that support BACO to use smart suspend
  drm/amd: Use runtime suspend in lieu regular suspend on supported
    dGPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 17 ++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.34.1

