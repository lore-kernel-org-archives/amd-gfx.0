Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9C7C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 05:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C105010E134;
	Wed, 29 Nov 2023 05:58:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AC910E068
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 05:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua7xuxM5ftvGUmf+mzKCn0ok/i8P2fA8D9sPayXglktWTMA8Nuv8bJX+P6gZY/SnhdxqHGUeUh4GV3MomyVQDCExmW7GxZnkXq+hjD1TO5dijKbAnechvViucp+m8RfdMpC7IN7uridyWTHbMaS2frSVMOE0lDjEgtAwsq5SJYRdEtXkeHoOJj5rsnwZW2xrKsOzY1nNJjatV9KLwz7pJswJ/qJj4tu9pUpnowIotLnEYHwNPDNi/ayerGk/p4iTY3Vq+hHXUsahbpA9Xkm+94Ha2J/GEXmN4CfRkKaG62wNLIi/1gGM3WqCvg7WxCEei3NC0BJdf/3KwbLcF4p8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzHnGLQ80srrX6dTm7j56NUyD4ykkmgjfhLqDodrrGU=;
 b=bFvngGvk54LQMqtlpEFSPMGaQNqyxVaNW6P7NnO1NLVDrMu3SVJNjetNmXt2Sco63rA8CzZWyR5H9L7OCua84WaIuIJ9ifNCT8TbunpTmHXPqETk4Uzc2mkTtfnqBrqBqmkI3lmGMESbr+SSNHlemsH6myF+emo2vPVpg+YW8U3Eul7JRwsyIaI54zzmHGiMAbQ6SE7mn6g9hkBpMjc16m6CmQ5pDNAUaz6yPEZS39toWDNNzf7+bYvlB3rXgrCvClVqBRc6AQAEMxVcRyTdWfqSsFU4lJJJUtO4+Ko8f4IQQFpWMbrKfphONTeyUYxyi8CNU5WQPlU7XuynN+4Nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzHnGLQ80srrX6dTm7j56NUyD4ykkmgjfhLqDodrrGU=;
 b=EyHargYQJDNVS+cRSFOYiS/Vdbg4GQvr9/s5t+kN6SjttTmvWt9/I5JCXDqy49Ce/kBRp7PY130Pn+7oVQN9HvYxgWFvkn0oIOWj5P1tbtyOq4a40r8t6r4QI1B3l+ytq4WyZGXRaCdKoGu/IcQIgiAcu0w5WOahR6o1L5wMUgI=
Received: from BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::19)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 05:58:26 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::ea) by BLAP220CA0014.outlook.office365.com
 (2603:10b6:208:32c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 05:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 05:58:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 23:58:25 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Obey amdgpu.runpm even on BOCO systems
Date: Tue, 28 Nov 2023 12:52:35 -0600
Message-ID: <20231128185238.187381-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 25eff1a3-79a8-4db7-366f-08dbf0a033d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/52VG/A7z0KQXkeUv5B4N+LMluwP1aZqNx30NCgFa3TzGY5uLh6lVbW+jKurlF4aPK/4Tk7D2AUHg5n6t6Bv5LWIg6/I8pk/V+TNeXyFxxmHV17HveMkXKUJ1U2bHIQeHRSrZt71mskBHLeqEqI6k8eLn7CS0JFioEkA3GDmBBvhgeZtoaVa3FmMeGWR2C9aBBU0mgJIMdASzO3hF65gk4cSFov1Np6K0s/fVcxSJ6AnZBDJ/4ntMNbJDRFNhn2EquSicYf7AMer8wdNLVmFl+y51nMiE6BRg03E6dNhQ+P0PxS6pbk9iDz9FXrBUUKmB8FNoOhlglmMcwwvASXxa7MfZHw6gUYE1POZ+sE9TNPivXawRhHSAXdtbby67LLtQwvVVoprMxBlPLTknxehu9ujxEZPe6yeaVWtMOw3V1S8YTN4Bl9zepIPyN+Swa0a9LnOlH2r0TAy4tF8fJ2kjFAspms9PoeD92Z1iOf0E7leTv4vdlExx6zjusj+XmYtqy9zwhNxT5Y1QVuBRUrTazuYzRYMWN6zKmZecwQWPEkT4N/WMPdDNvL9PRsvGopKOjtnq8ljFQiT5aPRjGXW1A9fk5LDyrkJe2fZZSreXS/vJr67ZCmv5nHeY9DzGA1JQXK32rm3990kB9wZxwpegnHtSFKUaPhBEc0T87jf85Nz9/Pc0boEEoRkTBKdoLqtC0DiffNUpXXhYUKlYeNSXJy3YPjq6hp2x6MdZdA9exdkpv0QkrRMh1hO0cWjucznuOuyLBKGF+3IW5JEUxqsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(5660300002)(4744005)(44832011)(40480700001)(41300700001)(8936002)(4326008)(8676002)(2906002)(316002)(6916009)(54906003)(70586007)(70206006)(40460700003)(47076005)(36860700001)(36756003)(2616005)(1076003)(478600001)(81166007)(7696005)(426003)(26005)(336012)(6666004)(16526019)(356005)(83380400001)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 05:58:25.7592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25eff1a3-79a8-4db7-366f-08dbf0a033d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Cc: Jun.Ma2@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I've found that on a system that supports BOCO when I try to override
it that it still uses BOCO.  This is because module parameter use is
intermingled with automatic detection.

This series moves automatic detection after module parameter use
and makes all callers obey the result.

Mario Limonciello (3):
  drm/amd: Fix handling of amdgpu.runpm on systems with BOCO
  drm/amd: Introduce new enum for BAMACO
  drm/amd: Drop calls for checking "support" for BACO/BOCO/PX

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 34 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 80 +++++++++++--------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +-
 7 files changed, 77 insertions(+), 55 deletions(-)

-- 
2.34.1

