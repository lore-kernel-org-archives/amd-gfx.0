Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B88C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 19:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEC610EBA5;
	Thu,  8 Feb 2024 19:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKtGzFFf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AD910EB98
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 19:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUgxyJGdptledoWNIbvsaB5cyiJAvfF5DenT8rp/RE/yCiNhZvt9SoOKZYYuSiFtBW7zCnfw3xfqSTzNXOJHHlbDI+U01Hwn0zhKfcy0+2bY4UDC4RQSgvFXY+WDsRc4iKUB1afk8IK5W+x4ya2Gkj0A7nIpPaJrPJM97aB+ZtAzx15CVwesWHR5GqSGPoMF6mEXac76qevYCvtJ9pcdaFdz4pwfBIowPN6Nfyzlts9KnJtRU3B7Krh/jvc99XD+u5Kye/HIwu+kMuQHSQllmxyT5xEbPwv0EUV3xJscMoDTg+COXl7BLNcNI4cCCU/uuFX79653QiBvKjib6bzlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/HbemWiYimL72UYg5Cte7Vhnms6+HzwvlouCr6XQiw=;
 b=nLt1pRk4u3V+IIoFGnwVNL/+s0YC8WSbeDJ6mPysKHLFMGjKg42CTTkZsFrKiEaANttflBUU7bGBNa+HsMBb8GOpYOwp0ieXx08iBmttS87gvjv8dUlyRw8aOGPCdeFF+g0Z60ivQAcy44Ar6Wv7QZNqXfUvbX01TexF63RLgzTkz9Sl4AlxOqAgZgnVwQzGtuTZyry4tRpQ+Cs6WBQ5F0Mdy1PtK4l3KnjCKSnqHc2ujST9rHo6tGhXTWvTF7seP78m56ZQMKIrDYDPx1p1FS6deu1Nhco8V3vu9LCQNeL3VO6O6lH5qZPJA69KJW1TWtJpgq/wETIMmLQdYRb+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/HbemWiYimL72UYg5Cte7Vhnms6+HzwvlouCr6XQiw=;
 b=LKtGzFFfrBHrDvA7O6txl1x7nOIpcdpJtLwgbJdhzK64rZ1MWyikdhP+DukuIbZeY+x2EcaFh+bKdm/qhMeW0QRfubEVUdaLh37NP767Y5hWMR68K/JptF7gJFmfMlYyrZ+5qHrr7VxfB513ur70J5mS9mRpDr7lgo9qFU6V0/M=
Received: from MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 19:53:46 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::98) by MN2PR16CA0045.outlook.office365.com
 (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Thu, 8 Feb 2024 19:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 8 Feb 2024 19:53:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 13:53:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] VCN 5.0 Support
Date: Thu, 8 Feb 2024 14:53:27 -0500
Message-ID: <20240208195330.408853-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 751610d9-e827-47f3-2268-08dc28dfa96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MA42L13mvZhjERWWTiiowz6zEzDfCglcmCQfvh8+9eTZ786KtMs0/6MzQhNYOe3nx9fl0BBWSDnCVP1rtQ0/Xsd+BdnxpOrXvUBLwQ7OqWM+7Sar+diowAVg6MesSxUc8aBZpOopY8qZAlF5Cu7S53C+FoeDiFA/zQf3ucY5oVmDZjrs26293kfJAF/UQ1paHQL4Cy5AXp918tDt9IoMDfzNwkj9vQiskMzyJw/i+xxjEv9nNKd0GpmjZ+mX7hxxNMjpKD8kjTK4vSKF32m67KJZ4dlNFZD2ZbeX+EWuUPOc09XDRtk1Kq95Ph9eyRMkXcA1PNeQB+kyYpNsDET/qfUiEI+eJ2SMCHtwwtE2pvQlEfJvCn7I8svv1PocWHVoOvvuQgRxdOsVrbyO7t71TqTe34m44ITizRW0nCO1Ykv6qVdYOxn2DdmBYmECoONI2NX9jMR6AdvwDMpOmYV4khqmOjL0N4c8fITzPVvAfMg9c/3i7Uw6GMgAWhpcdaBwBc9KzKvgx8qefer2MT3raG8Nwu5yto4WYsC5Tnzdf5je5AOz/CG+byABfKJ6kR2QqJzfZ3wD6RTQx5awBNx+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(2906002)(36756003)(2616005)(6666004)(336012)(478600001)(8676002)(86362001)(70206006)(7696005)(316002)(4326008)(26005)(6916009)(5660300002)(426003)(16526019)(83380400001)(70586007)(1076003)(8936002)(82740400003)(81166007)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:53:46.4618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751610d9-e827-47f3-2268-08dc28dfa96d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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

This patch set adds support for VCN (Video Codec Next) 5.0.x.  VCN
is the multimedia codec IP in AMD SoCs.

Patch 1 adds new registers and is too large for the mailing list so
it has been omitted.

Hawking Zhang (1):
  drm/amdgpu: Add vcn v5_0_0 ip headers (v5)

Sonny Jiang (3):
  drm/amdgpu: add VCN_5_0_0 firmware support
  drm/amdgpu: add VCN_5_0_0 IP block support
  amdgpu/drm: Add vcn_v5_0_0_ip_block support

 drivers/gpu/drm/amd/amdgpu/Makefile           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   42 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 1339 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h       |   37 +
 .../include/asic_reg/vcn/vcn_5_0_0_offset.h   | 1672 ++++
 .../include/asic_reg/vcn/vcn_5_0_0_sh_mask.h  | 7627 +++++++++++++++++
 8 files changed, 10724 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h

-- 
2.42.0

