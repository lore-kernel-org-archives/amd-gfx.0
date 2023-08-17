Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10E9C2FC0F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D3E10E1CE;
	Thu, 17 Aug 2023 18:15:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A76910E1CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cubhAVX1v1o4ra9ljGOwDbjtN5WOFXexjSjDB25dJK9M5kk3z2l3FOVZ5W8CmPm+AUl3RZBMlqrZ1PAV3vIBkpl+XQgbA1wl2vs6ZdWcmEA3+7NUNOTkeldaa9bmyXQM3nfUuosCWw4RwLf3I5hnXE970cUtIKEZ4z9925tvzNB5VQbAFCBt3UPa/PldJq96mTLoyYXFujdC5HnMncv4siId1Cuyq2VFSBSfIwZWvQypICOS4X7drQqp0WO+6zVSPcYQ+ZURwqwiylSbOjgtKOcLgx0Jc5jR6ajVkyoezqOTYJk5RokYCf/gpfQhcQ/Qgj/3LwgL2r+mAd81IgbD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5U6hyqAtxSKC0riTQyp2VnCjkqoJfmF/i36bnbiCCo=;
 b=NZgmfIIqMsvEFlMN8Zj5RsXo5Uat/nSrkv6fSsAJMhTdS/jsjwebFAq9ucEoily24u64ptImAsa9GJkzkEz1n0rBDSsK5n4pD+gWL+WFgvBl32wLNgsJ9depMWLZI4dIODN7oWEpcs0cF4IRqkCNQtwZEyC0WX1p0StQBfxRU+1NkmQmFSCINsgAB5eZCkl4EH+lpgVKXxteKopCsgbWwuMiiAhpZF79TaXw/F0bCcl962A6IIMF5pJ3WO+IIVbv+vDvkI93Nt9G7Su8154rK4BdSy2IW1JmDNxJO4AtUfbSLVFSL1wRXdlEntmWW/s0tgsvUZabLIH5FInLP7qhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5U6hyqAtxSKC0riTQyp2VnCjkqoJfmF/i36bnbiCCo=;
 b=SDl1BAUC7r+rPh6jjVTgPOaIzTKir7A4jif9BkKOj6HsXmdUmCyeC83jpIltiDm/jQQqHtN1XG5PNi2f5s5RC4wCW2SXW0JE4sXyFg9msp04eu9MclvnX5pXUH+i51N6pUL2DhI0/ipLCbAfh15MUhWmvvSorinWq994oA8wwSQ=
Received: from BN9PR03CA0683.namprd03.prod.outlook.com (2603:10b6:408:10e::28)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Thu, 17 Aug 2023 18:15:23 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::b8) by BN9PR03CA0683.outlook.office365.com
 (2603:10b6:408:10e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 18:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:15:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:15:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Update GMC 11 support
Date: Thu, 17 Aug 2023 14:15:07 -0400
Message-ID: <20230817181510.1544991-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 551fdc5d-b53a-4b28-42b5-08db9f4dec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShbD1Cb893yIvA+HXTLHm7U6jxo0kP/4GygkQb8GQx9F6njHwk0yxT+Y/ngL/7MmmwD3cAax7pCGam8U+zMooVon58ivI3GFiM8oJFMj9e10DA2OI4klE1XUo5rbqIzCnKeJrwmo1kA0iRfZZ4A2ZHZoMgrIzCc+bJoWdbpqOVcuPYhRxM6Cj0PdgL/fFi3mDKwYfuzA4MtEpHoKgwG/XTc5ul3DJVY0NcnDz7NF5I8CJ99QzscNfNJsoMJc+Hdlk2W8ba1T6u4iCZ/jIK97r8MOcK3KtfFj78F32pmL1eqAriGk9ShwpMk5iklFfpmYMtc3OGxEuCQP9mymKOM2OS3DATZSw/cshCCehlVmhJFpxPp2BablHHhztnYCGEoFnHi+bEua3cUIxdBbwv5QhJ0D+n9GGq8Avr88Rlt6Sykwx0/zeE9jiJOefgmF8qP5eCojRSa66zu7EkCQNcYXbfq/ltFNA1+tgwTLXB8+vdF3pRKbD1wWxZGOgmeYzsUo4trCCWy266LGrsBDEkt+4Az9NVIDNcq3jy9XMCU+5/DTGjxjU7MLdzFNB7fgrEWfbYl64yb/54Uh9olhgwIrYIw96w/ptdTQwLsZFIoWJev6O9FYBUR9YkxNNAxLXY3mWjMca79SH0RYqaB+LcVfa50WTk4yUe9l+pzZRAwrLKJU76OWp8KdWoF5ibFTp3LiNeDlNZtxWW6xPAtq3WTxQg4N68xJkrEXuKKNSMTU6gDFVG8WhZtjrWJzs6rokzo4VLfGgiQ6jcVPe0CsHo5hSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(316002)(82740400003)(356005)(81166007)(70206006)(70586007)(6916009)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(8936002)(4326008)(26005)(40460700003)(2906002)(83380400001)(16526019)(478600001)(40480700001)(336012)(426003)(86362001)(36756003)(6666004)(7696005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:15:23.1760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551fdc5d-b53a-4b28-42b5-08db9f4dec8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
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

Add support for gfxhub 11.5 and mmhub 3.3
support to the GMC (Graphics Memory Controller)
11 code.

The register headers in patch 1 are too
big for the mailing list.

Lang Yu (2):
  drm/amdgpu: add mmhub 3.3.0 headers
  drm/amdgpu: add mmhub 3.3.0 support

Prike Liang (1):
  drm/amdgpu: enable gmc11 for GC 11.5.0

benl (1):
  drm/amdgpu: add gfxhub 11.5.0 support

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c   |  517 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.h   |   29 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    8 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c       |  590 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.h       |   29 +
 .../asic_reg/mmhub/mmhub_3_3_0_offset.h       | 1395 ++++
 .../asic_reg/mmhub/mmhub_3_3_0_sh_mask.h      | 6722 +++++++++++++++++
 9 files changed, 9293 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_3_3_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_3_3_0_sh_mask.h

-- 
2.41.0

