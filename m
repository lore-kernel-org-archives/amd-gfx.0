Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC18C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA9B10E6D1;
	Thu, 25 May 2023 16:52:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70AA10E6D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noaoBaXulH9RAIFG7vdXLo0kilVRHLftxhaQRs+psz8bejdKs/Cj2VaPHN8Rocvm1F5T78y3QPoCsFwgRCdwqOb7qmxf+PkN3F3w8UBv91/Zqe//xdcEM+Mjt4t/IoQtniFbExRiRwp+4SQBdfyyKjcIqNHuY8IGUxScKYxZMwCMjwpqFhWTr/TthQ7qyV2qsRasEzZPwtXljKm7IbAVulMrO2uDRbD0MhJRC74/X/Jc5nYoA1Nu4xOQxHM3cT36bfxRrN+qsGMYBz/6ALZ5KUjxq8HjNM8xdb9cBShyKHRvPMv7sAZcfx8KQyCHV0G+sCYhkf8CEnKzMyEGKrtUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbXJlapMkbpZW7ARCRAqEPxy7qQDYW7UYEo5AcS+M2Y=;
 b=mP3IlU0cSltdpMLZT2UaiG/HMLLwDMi1TuTItTH9AWj2n8esiDXA1MmcfO+8Fo3L8zlRiI3YBxWwGF4oo8+2k6INR/YAW/KulclOEQ04W9mSz3DPnO/wqgEzqIeEgBgublQyirjbtnIE4c560tHP/imFMLyGlt9eAQ9V3GPuUJBGz1cpMBqOYl78v6XCveqb+grf+i3tT+MPVv5nTGoImZ5b/JilpDOW37GGOiutnybn1hx47iuPF0loAGHtgu8Yh/oPMugn4C1kZ9nNWR7tTkumB0Uy9zqQw5SrtVjFnaG48gJbS3pLeurV2zibGRl/i/7kp9TDdD/6b9yiY+cVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbXJlapMkbpZW7ARCRAqEPxy7qQDYW7UYEo5AcS+M2Y=;
 b=ZSUWhYYgili4OQPuRTkCy9P6mfstgkrcXnZb1FUD4PN7AzM66JhjvjdIZz3LcbWiOdH6tRUElyti/+v3kGJJjF6UwdmMbXRbSXJiA0gmEg7rDQ1z4SySNcLSFZZ2ses4FRuElZQDg84DIussw0jUaRLBi8dt/Ez0u6oRbGuO200=
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 16:52:40 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::33) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 16:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 16:52:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 11:52:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add GPU page fault query interface
Date: Thu, 25 May 2023 12:52:16 -0400
Message-ID: <20230525165219.544671-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5b178f-1f41-459b-2252-08db5d40738b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3j0OfPA/HA1D/vSfARe5Ti8TM64bvtFV5RhdV515ej4PiuKbf+ZxWiQVz2oVKtyEknzPRKvnGfYoDMmL+WoMtJWcCvHABrnAm2CCg1k7RgvnWR6Bku4fy3ZqlH683NMaSxNi/7h+39W3MexzHJKPTip8rWwOZAB1cYlAKr+X0q1ZduwZPB9XbPdiFzIjrK65TvH4540jlOkjdfv/Za3jmkMM1K6fX10XjbpLmJHMOqz3Fs03Z0+41LEfj0F08BQ6YHIqp2KqYeWcZjGqS6zwA69GU7Dnqk0j2qU70XI3xcAbXL469dQAIWyUYWRt5k+qvQ5YlcBnXn1jH5285ksMfzwakievB9WaE1Aw0ESeYYIQeM6jjGSvtShGJqvDqiiRmAkV/Mrd/3QkKmZZK5YibvRXgomldBaYBWx28718C5R8BoX8BP1ERPC6gSGzcvNCakNKhx2Ay1mIboCcRH7453aF+nArshJx5PMSLGh2AR3Xy26KVbRHgNOjpjz7Gcx/hetjDENIeLL/BVVnMg4xULfbwoFdpRDbo/tT4A2lMf3NmcM9iHkNpsMEF+KpHN4VPf2oFyX9exzGKGHJQtGq7TWsysjYWxz8XhfPGQwRIRb6Nj2D9rqKXCk4vDkV6Ume/+H9+Uhjy5tO2SpeE09vOYSUyetVt1j8aIAVS6FeYHxs6dyj5BW62yZLmiu8JlikisiqJ3KiHV3Cv5aJpaqkt1FJrX7EcEMEwYvo8uGpc8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(54906003)(82310400005)(7696005)(966005)(478600001)(316002)(86362001)(70586007)(6916009)(4326008)(41300700001)(70206006)(6666004)(5660300002)(8676002)(8936002)(1076003)(2906002)(81166007)(26005)(40460700003)(82740400003)(356005)(186003)(16526019)(426003)(336012)(40480700001)(83380400001)(2616005)(36756003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:52:40.0376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5b178f-1f41-459b-2252-08db5d40738b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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
Cc: Alex Deucher <alexander.deucher@amd.com>, samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set adds support for an application to query GPU
page faults.  It's useful for debugging and there are
vulkan extensions that could make use of this.  Preliminary
user space code which uses this can be found here:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/298

Note, that I made a small change to the vmhub definition to
decouple it from how the kernel tracks vmhubs so that we have
a consistent user view even if we decide to add more vmhubs
like we recently did for gfx 9.4.3.

I've also pushed the changed to:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/gpu_fault_info_ioctl


Alex Deucher (3):
  drm/amdgpu: add cached GPU fault structure to vm struct
  drm/amdgpu: cache gpuvm fault information for gmc7+
  drm/amdgpu: add new INFO ioctl query for the last GPU page fault

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 45 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 +++---
 include/uapi/drm/amdgpu_drm.h           | 16 +++++++++
 10 files changed, 126 insertions(+), 8 deletions(-)

-- 
2.40.1

