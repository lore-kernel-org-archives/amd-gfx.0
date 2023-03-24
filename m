Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE5C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 22:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C18910EC90;
	Fri, 24 Mar 2023 22:00:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914BF10E295
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 22:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6xoJLJDSlCMrg0P6wrxvREk1nHX4YYgaaWZVE1pLdFJcC43cCuoJZa+faB7V2G2y30G+yWfLfS6gTjY/YdCTwnfhTtWErRXGIpEe06uX4IKpXY+/XiR7He4AkmOdZ4W8tFxVDLcjzt6QuunsUvzYSHMpuiuAVcUMH28r8kpkZF7BhR/B66gcdRV7rdAYNAiQCUA3ZOxTSvXgEBymbsZ9XjvTdv4V0rn1woCqtAsduTJ9DHEX8vXzNrVbVLCMlIcBXo04CSnHHotdvUdgpfnzzOP+IUJucXVa895XYUbLPK0SX1fb1gdCQzMrzLHtrK9ZVEupIp5e+A30IASi4BqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr0z4iiLPG5BuD1hRzqoGI9c+YPNn2QtBOJzhxWigAg=;
 b=Ix0A8GgoNKUiV1pETI5XDizX6mZHUh9IJmgTEgrdgMZaejnp9Uc3Rb5G7xSrXCb1d9sh7JEFY8YXsKn76MCg8IcTo+eZx0jWhgu5ezqfWOyU3twDxaMRafN7wcvUdYJje4cAmtEQ5dCM9focfqW+hqNWcVq7UpU2SUqvMMCkHebFd27+bzYvaU0DtpqqgjQW4RH5DmKsqFc7J7yCvdSAxFzfJWP9UrPeinXLnSNBFjDfaetB9Vu1TFgSjE8XQ+xO5pabFwfEeiMmVEogckYYHRzY6NP5cT2W7hOGWLWrBcZJcjCLRTxNPxMLmino4154l1gp7RzJLg8/DnrdloJ89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr0z4iiLPG5BuD1hRzqoGI9c+YPNn2QtBOJzhxWigAg=;
 b=QdVm0cgA19526wUd3mDYbu050C7syjzlC6O8J4kkHmCXnxCFzMGJfCw72WKwRHQcUohxogElVmvoKvgnNxvfZohr2HfsMdt2GjmnvNd5GoRdBgrNTBJGM2CTAlT7vN1kbZPro6zQlNwvXqZ4z9xTXSKbYonfLKTKipupKeuEZz0=
Received: from MW4PR04CA0313.namprd04.prod.outlook.com (2603:10b6:303:82::18)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:00:06 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::6c) by MW4PR04CA0313.outlook.office365.com
 (2603:10b6:303:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 22:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 22:00:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 17:00:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] GMC 9.4.3 Support
Date: Fri, 24 Mar 2023 17:59:44 -0400
Message-ID: <20230324215949.2560463-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8e2b12-6fce-4e99-2ce3-08db2cb320cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hp0H8+sGKZkFRjH4lKInMmW/zwwyEqlATKV2ivYxyrU54hpT+hJ9KRGvWEZiv4DHIHTjmus0bWGbiIxBjEtB87l86Kkm5NMbSTO9UJHhnPrlhS0WTUdB3IQIiuRXHJuaXenkGP1yR90ZTAkbnPn/p8ctdzJ25ag3v6VTkWi1IV6TBrQ7kvoB7nMnQpmYKGmD+NYyGA75TCI3hXP8s44pj82dD+DVOZMrwQZqcBA0HeAlCaWI2iV20lh2nH3cApc4L5YgZYjWnywUDNSnuTKRduKiIiI1uksUSU8Ub7UW+CIMjMVVXBYg3pLDrjPWA1Lgv/lVhEO3KPKJrlIdhlphEBwXHXVMlpg7GhYpwnemXD/yRJlw4NfVxhwPj8LHBdokL/Z9V7CouuNx7q9T59UkVvguj4/G1BlwC08QFP4Tdz94OlSGPMliWt48bR1DPJ5xZlJYWmG0MAClhbRA4UO3n2Gx/CzjaVrffjGyE6Bn2N+IWfAzgsPLFRJAQ2iLBR4XoPBqkjYTThChQkUgvXVaFYBagK7kerRyU+8y7pQuDGUeQkzV47gq6hgvP+B10dLHXbGtXHAGZfUyGEzmelAC9dckOjTbIRaA6L9ay9g91Ecy43rjBI42PaJG0Uiu9O44SajM86ETIfA362rPolkk9FnEZHf+u3YQ6T5iuhcZTQ8RkeEH1fDQGXUuHo9o8wIkZGGVJ2ALZr0km6SwgNcrdZY2WKUXWGTFiDn3xhTxGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(70586007)(70206006)(40480700001)(2906002)(8676002)(36756003)(86362001)(36860700001)(316002)(356005)(47076005)(7696005)(478600001)(16526019)(186003)(40460700003)(81166007)(82310400005)(82740400003)(5660300002)(41300700001)(4326008)(6916009)(8936002)(336012)(426003)(6666004)(26005)(83380400001)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:00:06.2449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e2b12-6fce-4e99-2ce3-08db2cb320cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

Add GMC (Graphics Memory Controller) support for
GMC 9.4.3 which contains mmhub 1.8 and gfxhub
1.2.  Patches 1-3, 6 are register headers which
are too big for the mailing list.

Hawking Zhang (6):
  drm/amdgpu: add athub v1_8_0 ip headers
  drm/amdgpu: add osssys v4_4_2 ip headers
  drm/amdgpu: add gc v9_4_3 ip headers
  drm/amdgpu: add gmc ip block support for GC 9.4.3
  drm/amdgpu: add mmhub v1_8_0 ip headers
  drm/amdgpu: add GMC ip block for GC 9.4.3

Le Ma (3):
  drm/amdgpu: add gfxhub v1_2 support
  drm/amdgpu: add mmhub v1_8 support
  drm/amdgpu: initialize gfxhub v1_2 and mmhub v1_8 funcs

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      |   471 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h      |    29 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    24 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   477 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h       |    28 +
 .../asic_reg/athub/athub_1_8_0_offset.h       |   411 +
 .../asic_reg/athub/athub_1_8_0_sh_mask.h      |  1807 +
 .../amd/include/asic_reg/gc/gc_9_4_3_offset.h |  7258 ++++
 .../include/asic_reg/gc/gc_9_4_3_sh_mask.h    | 30535 ++++++++++++++++
 .../asic_reg/mmhub/mmhub_1_8_0_offset.h       |  3314 ++
 .../asic_reg/mmhub/mmhub_1_8_0_sh_mask.h      | 22315 +++++++++++
 .../asic_reg/oss/osssys_4_4_2_offset.h        |   263 +
 .../asic_reg/oss/osssys_4_4_2_sh_mask.h       |   995 +
 15 files changed, 67924 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_1_8_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_1_8_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_8_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_8_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_4_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_4_2_sh_mask.h

-- 
2.39.2

