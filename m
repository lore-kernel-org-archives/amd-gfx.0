Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394EBC0015E
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 02:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FE610E053;
	Sat,  8 Jul 2023 02:26:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60A010E053
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 02:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLM7U4n4/5poMBGVNLJdYomgYv3kE8oevDP8P0j+VEEc7fg+FEWoKo+8g7ImKnLEoA7ZW74eg98y87d0clb6QDQsy6M8dB7uf59TVWcQ1+zi74USw+LWbd9MUJnNHoc90oOpfTB8L9sYzRqQjDJj5nO86STUuORjY4Vgbr2JhRaeCrolsaTpNAMKsTm+K5gRK0FuTQsipRsTQyBl6YRmhyeTS9kkQvgb77yvcnm7bDESt8C2WVBxz6cb8D7SqS3UCEWS6QRJ2wtaZ05P/tglFTLugUvaLUpDluukmSlPdUpihG0kter4HI7E0K7nlE5kq2/lhh9geHcu4774YcPETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvaV6HZrkKRcpoHIH4xJI+orj/kM4RvCKJl5YZJTrR0=;
 b=ZQhYTzzv+84HaBKDJM+d9RCN3BOEEhukS9Iul2RnFF6GQpFeztPCyDwVoaAv5MOlmzFHzjne5MBvixB3kkP3MUnL93B2jIhsVEKnuk0v0jblATTmUU9yiX2DC0sMiu1X5A8MoboX2BrVL90h55JudxvD8+W7euDMltKCzlSVlEMcA3MrMRcD6+Dn2XJpzgdoqBC4/SIXyDvWsziJN0DUaXexGZQHGw0QvU3qcmoxvvyea4VVZy0aN7u8xHdgs/JuhVLzRIq5kUOHjLBCSOTrZtfm995r876ohkF8owTUIMPwGHktpgT1K4Kxjr/KnQmVJrf/FoYc5yPBFzkekYweDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvaV6HZrkKRcpoHIH4xJI+orj/kM4RvCKJl5YZJTrR0=;
 b=UWPgXs+qOerHojfET/GfCk5OaspG6Cp94hCzgy7R9I6wHNK7JbYyibQqFxAz2CRy2DXPgR0p2CO7jDuhtguf8ypjyrfcXTJUeQbad9M2uTOiIc7OJVdp1EvUAwHdiyeb8XcJDSrPvtL09c4486Swub3hgp4iegOCzaRNQ/Com5o=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 02:26:32 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::cb) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Sat, 8 Jul 2023 02:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Sat, 8 Jul 2023 02:26:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 21:26:31 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Extend amdgpu_device_pcie_dynamic_switching_supported()
Date: Fri, 7 Jul 2023 21:26:07 -0500
Message-ID: <20230708022611.50512-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: f906fd5d-fbf4-4e12-065e-08db7f5abe87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4NQqTb7nxXBW2eLqXAnRSzaFPb6VgP3DK0pFw3HtDPvkVYgERXlnxfgPVurSJl7kjarGF+dI4SzXnzExYtKbhivbxl0kzMmrzQYfb1jtz4FK75vjAy4nnwvtDMwruICxCNdhiE6nQURi4cVy+MhKE/jT4xxWy/SQsP5I28uyJgrCIq0ifJlKUHEXFmfYuLEM/b+c1g//KYEqpOiLhYsKU7HpbYO0ZB/GTVMrleqo8iQKYHh+MtZnlJkWv2vPZMt+P2bMkFGE0bm3WwCIJOGbS97ZDytsyb+ngPDMEQnlY4p+7hBSgUf5qdgETWTBd/AVaFv2mwMrHmf9oLQc7SOL24ahyvYIzUEiDrIwOJYZu2wcoALjVTU93uKX4tAX7JLA6tRIGQ8dSGUX6Qz7d2R4IaqydZQ1amO2j0vi8sA2qlrG86hg4H2FeYQMXr0HQyqa+ibtyriGW1uDkObsZIw0B57Efo26mfnoHvkgeNCPO+U56QKdeKDMJMPHGMGN9O7tdquT26OHol9bdrdVMV5UW0yIne+BB/wcZZSNNYhVwkL6Bn5SeYfWtdK5NbZ8nk5ih1HLhMY83PkAOTU1AHSj3kPcS6PiIi2yGUPi322BVz3oihLcyspp6BKIdu2PQ0PDL2uJHClFtI+HOhpem4puNa2/lTMnQSwlpXkOH5pBZpFSw9SjwDRthu9TuDysjUsUwJtQ/qdu/RGyzugeXjekqp3WUL1aCLQl9vMpQ6DhV/9ZTFBbsT6JM63Q+3Dvh7+Rg9ev/eRoLFaLXcTF4A7Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(356005)(81166007)(6666004)(82740400003)(7696005)(1076003)(26005)(40480700001)(83380400001)(47076005)(426003)(336012)(36860700001)(2616005)(186003)(16526019)(36756003)(40460700003)(2906002)(316002)(4326008)(41300700001)(70586007)(70206006)(6916009)(44832011)(86362001)(5660300002)(8936002)(8676002)(54906003)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 02:26:32.2892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f906fd5d-fbf4-4e12-065e-08db7f5abe87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
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
Cc: Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_pcie_dynamic_switching_supported() currently only covers
SMU13. It sets up the pcietables so that effectively DPM can't change
speed or lane width dynamically on problematic hosts.

Earlier quirks to SMU11 did a similar solution by looking at specific
PCI IDs typically paired with problematic products.

Even earlier dGPUS used in Intel Alder Lake and Rocket lake adopted
similar solutions that would turn off DPM.

These all come down to the same fundmental problem; Intel hosts can't
handle these features. There is nothing to stop someone from taking a
Navi14 and putting it into Sapphire Rapids system and hitting the
same problem that was observed when it was placed into an Alder
Lake-S system.

Because of this; drop all the specific Intel model + AMD dGPU matching
across the driver and instead match ALL Intel hosts to do these
quirks of setting PCIe override parameters or turning off DPM.

If a new Intel host does work well with dynamic speed switching we
can later adjust amdgpu_device_pcie_dynamic_switching_supported() to
have a switch/case where we allow list those hosts, or enumerate all
the broken ones and disallow list them.

Mario Limonciello (4):
  drm/amd: Move helper for dynamic speed switch check out of smu13
  drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation
    with SMU13
  drm/amd: Use amdgpu_device_pcie_dynamic_switching_supported() for SMU7
  drm/amd: Drop amdgpu_device_aspm_support_quirk()

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 30 ++++---
 drivers/gpu/drm/amd/amdgpu/nv.c               |  5 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |  5 +-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 14 +--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 89 ++++---------------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 +----
 7 files changed, 49 insertions(+), 117 deletions(-)

-- 
2.34.1

