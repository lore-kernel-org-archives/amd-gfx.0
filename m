Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B26C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D732510E46C;
	Tue, 28 Mar 2023 15:21:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55CB10E41A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBbmCFS5PaQhMWMoZlI+qw2+WgwCbx5MRcnIfjOEG9OgcwcGIUQZIxyygL3ntOVVku6UMinVYbkxcW18+j3kVF0q4KbGJ7CkdpMvJUT7cdaDp7cGBDFoZb9v4qU1GpaH1SLaLHU5kN0Kfz9KCNNlyTg048zXN/Tn8BsPn7AJcmtwuPihswzTqO/35y6kj2aXwLSx1e2YkYlI7ZBpd4SBl9nYJPWwkQYYpgprVtBXhfLj3/JuOZKQReppcRfej8nalakJiBgmMcgLQS96bPGCXQJvhGsEBcImd0tvl6aMbBH2LwMGwT0Mugs++qClFEslbVd4jDWfiiv/EkbWYFuoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftSw3CmKXOeytceGdvkxhqyJcWE5L+IwYly1WMUXUn8=;
 b=QuID1DBX5zk7qIf/hCXiHwaJGU03rjCmgF3nnBo7BGj3J1nYebRgPUi07pWYy1G4NnsGQLCCys5TXqf09JUtUFFcOhfvaJaZU1DZAXI05kd82ImlzA2Q+iH1kcHs1NRQPrzbAVjZlvH27XyWInfJVzGstU7HiQhy6oxOgC6HO/MgwIeX7cPjt5X+bHF/wqn2x6/PW70lacnBVrj7k+3EC40Ff4qb4MX373Eb0hd5uVJVWTUE1fK6Kj62lDRtx44SOZaBTk06ZOqyVFVm7g/qXGjr32us8KIgbiZltZIA8kL3rOu6du3qkbWaSrf8BToDNufSsw7gZvTS9U5+/me1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftSw3CmKXOeytceGdvkxhqyJcWE5L+IwYly1WMUXUn8=;
 b=RNj2eT2MfCTYXST5DdmKQbRHicXbKZq/i3TOCHjnSUHlhjWKYbK2CY+Rx6RrI+y5fsqzGUuTUcqBrY2qkOC456DW0dLrF4b4aH6hr1d0STnlmmPDcXcDM5TtZLFB9wZ0BdlE316aLFRYNKpSTcyk+oVU+cH1MIt2TXUYgpm04VU=
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (2603:10b6:5:1f4::47)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 15:21:01 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::f2) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.26 via Frontend Transport; Tue, 28 Mar 2023 15:21:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:20:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu/jpeg: update jpeg header to support multiple
 AIDs
Date: Tue, 28 Mar 2023 11:20:32 -0400
Message-ID: <20230328152036.1934902-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328152036.1934902-1-alexander.deucher@amd.com>
References: <20230328152036.1934902-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f29676-4e2d-4a20-92bf-08db2fa00a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFYh7Zbqiay7maebEcyvIFqC6dPKqyD/8IdkXpqlA4EVWeFZ9cJ8oyOyvv2cwDOG6aSfqqikQLfmFWUVlYZleufmmzNNGP5CMrFXQKDG9VzzDRL/HBkARmxqVkXKmEN0ENUl8Jyv8wlGVIG+usMkhzv7fRnMEFvTQOaUWRvLZbxM8sxAUmRU1af07D6esozjMLs4/e7ilYVkMerrXImfQRMd0O5p09L/MvTH98DaXnPBB0uEg6BuFdJ/Nov7lnVepZe8gQE7DuGd19ysKpbT6trA4evS7jXOPYE1Ke3E8nEcVyL4AZXPKmrCF2JI1TmCgBFOvpkb+zc8qOc68bMCu9NRRcKVgwGtFTEKjGSM2B5c7aN+vc+MDDTh44TZ8QeBT6vQPOXaH5AYqASjea5nYkU8tbDSlHPTbrlIPjDvmdn01f78VvWZZ2FFx50U+417OnPlHDaO9xSXTjA3OcOEzfXeR+QtDjDYsYSjSpR6fblIo68ZApCOBzg61UfQg/RFlPvZFNjTABZSAZzBnaKjLDIKL3iRuasKbSx7a4IeujtjPVMFKhr9Iy7lIHbGpmHWCjs/+o4w6bsuxIiqsmtrhTZPv3IcMFwPPGU9hNkstQEaduvlcDDcwgIkr4uFyCdwAHy0n4H4wZAw1HIg7CoBKWG5YpZ62e9AtBptqHTkXPoqbW8vxiESUwrzkIrIwyjSO+Cyvy9FGGoyfudDw4p+QQRGQyRj404Qeq0d8MSrsq4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(426003)(336012)(2616005)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(81166007)(40460700003)(82740400003)(478600001)(40480700001)(54906003)(7696005)(70586007)(2906002)(8676002)(6916009)(70206006)(4326008)(4744005)(16526019)(6666004)(82310400005)(186003)(316002)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:21:01.5225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f29676-4e2d-4a20-92bf-08db2fa00a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add aid_id in jpeg header to support multiple AIDs.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index cb6c127ab81d..5c200a508fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -40,6 +40,7 @@ struct amdgpu_jpeg_inst {
 	struct amdgpu_ring ring_dec[AMDGPU_MAX_JPEG_RINGS];
 	struct amdgpu_irq_src irq;
 	struct amdgpu_jpeg_reg external;
+	uint8_t aid_id;
 };
 
 struct amdgpu_jpeg_ras {
@@ -58,6 +59,7 @@ struct amdgpu_jpeg {
 	atomic_t total_submission_cnt;
 	struct ras_common_if	*ras_if;
 	struct amdgpu_jpeg_ras	*ras;
+	uint8_t num_inst_per_aid;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
-- 
2.39.2

