Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994EBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C9810F5D8;
	Wed, 27 Apr 2022 15:28:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CC210F5D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYfaHXkEYNGHrod+QkDsP3ldeIQBIIYGv1G4jJVVuZ85TqnDHPcl2qKdM7i9DkUfzUKj0vM8qlkO7tr1ztvECCHQiRkM6vmbZCd1GjSYNqu3/2Z81nLNv+aNdhe/fzhAPgCFpML9GzP98tt+vCUARgdOVRJikzmkukyPJwY4TVy/Uw9Lznn2j5qiCLXV+TTZaJ7GwfvnyzdGeogophRwex972JH2AwPUZ/T9c6mJRhZT6liRM/jJTv7THZJxQwjvIZobhsFByy0r17ZLHs6LaFVVYZef+yMHhdi4iRG811nt4Zbt+bk1Ab4DEa512eL08GQRUwg79e4Fab8K40RSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhqjjrZn7Zvxb8T+dBXoDImlwhnHnaOH/QDRMzRA4ng=;
 b=CqoXVTjO0BODW2bL5mV2dLssI3IoI9eaLd6+bQlldBFZf/0fos08Jxh67wwgo5LF7R0CmRh1ZktRWyT8eb58euitofGYB7UHpDxEBG4Ao2ILymz8jqQCJIzO2sa3tNZ+6fTXdfS6CF4eVkDYpaT3NaUZc2bfUKXV/VkaNo5QjGH4WTzmQAVY65xaYeY1XXZJU4LBFRWous8N8B/YCVfgkI5mGx9/V+EDY7oOQkPkKjnSQfF3LGeSSVr31FpYKjWkFiQTRsAzIQFcLt20vFK6o4yT8jvsetkdCZ3yt4j6+yUJ8A0gYJVfvY+V4j0cIixjzCduv0DPmiFWxfaOz4tWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhqjjrZn7Zvxb8T+dBXoDImlwhnHnaOH/QDRMzRA4ng=;
 b=g5ONvNp9SAsW8BOQSI4zvZM3ZnDprYG2OHR/ERAYr+Kui/MwPm+ns1YJcDXc/3yWvLaP0BMEvg7kR4X9xOMYIxMBH5Yh2YrAM6TsTsVukM2z2spIQxvBcjrSoaCHRXAc/vq9isZEwP90wypT/NtZkvukCHSe+Q/DCBRN15R4A9w=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 15:28:07 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::2d) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 27 Apr 2022 15:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:28:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:28:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add SMUIO v13.0.6 support
Date: Wed, 27 Apr 2022 11:27:51 -0400
Message-ID: <20220427152753.3107794-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c820a77-d82c-46f7-d6bc-08da2862873d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5402:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54028743E0E25E2AC3E46128F7FA9@PH0PR12MB5402.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehAPoDmfZf/DHPHTH09DffI7NSgCLLUp3ZxiWYJXgFLpZC/NuRuuw45fO4hosWfKha3ihp6KbUVJC0PmYWcCVSUau9x2Gg0CIRfSNRp+4rWtj02XTrxb/NjbpVnO7n9DtQvbcY1YLGzZArprpokk5fZ9lampvNHJLTlNiNzjo0IxOCPt96qnMDAAZlx+CvlzBh7GXMvyKUU0EzacCEoDG4WgVGKlcmK/HfLwoqXHJTvRJTOgoxeatRD9P18wAw7Y62YxnDI22HWitRu5jaEyuIibmrKxxRE7QpUrYtUMZYhP57AUGmN3Znfl4rkju43XUh+/VRBanSVtq1Pi16Rk60apcvUhTVvYRz8ALqHcnh6lc2aclSxjMosLIIfTl5BoGRf1lTOQm6shqIMMWxJaRy1TkV1jcrn3vkezMTC9VlYOE3dH9esEqyE1ByADA4tT7Kbi4K6ARREJt6/x1YOmkBGKpGX3Fm/d87uDyikSC0LPWT1Cnd82Z0n/lp84rCEmm4K7UQlUmFTISUqEkVNGnwC0uwtf6Fr4BaFlxMX6WUN2IVaUHC5LM4FoQSDZsdgYpz7k4zujWMfYRZzCxdkpfHQY25cT1j16fNB7glFFa5SQBYXFnrDGN9aNN/VeG5Vmg0zINyvtEaJSFNvdAVla9IO4w82rxjm72mYVtUDiwAOAp50FSP0Ny6LECnYTC5l75FR/vbKj+G6XRw0iuiHWTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(26005)(83380400001)(356005)(81166007)(70586007)(6916009)(82310400005)(70206006)(6666004)(7696005)(316002)(86362001)(8676002)(4326008)(36860700001)(40460700003)(5660300002)(36756003)(426003)(1076003)(336012)(2616005)(8936002)(47076005)(16526019)(186003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:28:06.5510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c820a77-d82c-46f7-d6bc-08da2862873d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for System Management Unit IO (SMUIO) version 13.0.6.
This block handles VBIOS ROM access and other controls.  The first
patch adds register headers which are too large for the mailing list.

Hawking Zhang (3):
  drm/amdgpu: add smuio v13_0_6 ip headers v4
  drm/amdgpu: add smuio v13_0_6 support
  drm/amdgpu: init smuio v13_0_6 callbacks

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.c    |   41 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.h    |   30 +
 .../asic_reg/smuio/smuio_13_0_6_offset.h      |  517 ++++++++
 .../asic_reg/smuio/smuio_13_0_6_sh_mask.h     | 1178 +++++++++++++++++
 6 files changed, 1772 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_6_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_6_sh_mask.h

-- 
2.35.1

