Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB55C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012C66E05F;
	Wed,  8 Dec 2021 02:37:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282556E05F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7QBwAhkPa5uVDHFEM13hV5nQh5Xkt/7kx4LVXe1NHNWuGEhrAgMV5tvRg+cWEZnaxuNCcFkzp7vKSZToedzCaoaBP7z7xBSP0sBlzCAbpQBTDwq+aaILlmsjQNtGlsWaSZ/ejP9vXzRq7y5eQrsQljXBhgHy6orj64Uak7Htui7WOMudOgnOT2AM9ElKZ8FydfecJZ6PpxoCfq4C/GptCVTDsLIr302WGiYMPTTLcrwg7omesyQQao+ikl9omkooJBRJ/Ls2UqBPw+aRR2q3pkRhppUYmWoYR8J+Kyxqco4t0CAjzlzzYpquk2ukrjgIYKjxexGrt0smC2t016zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSOe61At48RxJQiC/blfl8tr2vt/B1pUtyTDdXkXzHA=;
 b=Eyt1P1P8NstH2zk1G8lCGxyKpPqwl/0IW2f1KlvIbMKB/PEuiuBDaeaweILT0kfpoo2yu44638NdGbABWDNd+V1G0SFPlVlTIlh+y4ppY+Wzvyo2wxvS/+NRpvIlRB3ahn5Z44Iw5fDg/jWDIUuI0/7eFt688zZIZklWvW+vMgf6c55Z+e0B5W5kHmXvYSXn9Elo57OQhZKDhXFuVjdmxzn5gIUEqIjwULdH5CJ4SPMdYZIxjq+yGB2hmy4OTSaa2Eo6kFgCR0n+UXXFRZBl1YCtMAV09XzfZpuBo0h0Bs1trdE98BhcOtdkE45yx0xN3OOM+KLDleNp4v2lhFNXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSOe61At48RxJQiC/blfl8tr2vt/B1pUtyTDdXkXzHA=;
 b=KSe6ocR3/w04ekbYbGxXqufKN7CrBtEGuofYl6OP8pcpZWExJj06DoyYyoldO4a+ejNVZ0nxE/e7Wd6z1qWFfVwEwegXgqQb/tT+lzKVHu4MC/6J1RqW2iTS6dVIWgdGo/GipAWaRnxEy981CUqR5pJA7rZ1w50H+PFhPdxN2yk=
Received: from MWHPR15CA0048.namprd15.prod.outlook.com (2603:10b6:300:ad::34)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 02:37:28 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::b0) by MWHPR15CA0048.outlook.office365.com
 (2603:10b6:300:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:28 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:25 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] Drop unneeded power related lock protections
Date: Wed, 8 Dec 2021 10:37:00 +0800
Message-ID: <20211208023707.1814122-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be647eb-c560-4eec-28ca-08d9b9f3ad32
X-MS-TrafficTypeDiagnostic: BN9PR12MB5050:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB505037A94AF9BC9231F01539E46F9@BN9PR12MB5050.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEkJghD5yYIVUjdDI+1msonA0ROk7fTdMcrYcBc1XjQ9AeChEKqgblBVRY4g8A5G1SwdNcyHgcAIQW8BozT6UbrpDz0eLFzBMyZHuJNOM86bwP+VOfFZQGw36KyFUIZ6pNn7KEwmPn6yf7oEpswPBbolMs9sYqtCTvMaJznLQeYjI/UskZAheUyBG2uF58q8PEOHnjQVihFo4ubJomeYMmN94VwDdbAbfQT6AU6o/+Yd74ehWNqYoRkfnHM0r30tv/TySXMYoZ2xmCuI7GSqzJDu1y5S2PxX5RFntqrZuGkULijJ7mdIs9EFFoyjjBfi0uW9XsAaaAXU2VEUaJ3Mlk3PEtEsgfg7dy2mdpp7Q1XrMBGWakBgxL58kLw1zPQud8Fkw4C1w2p2ZuckXywkod8Yfit4FQFvduOQEbDoH/jOHQLUAfpGJ9UmFQ21KjMVPtsF30GMvacIK3IBJ5Eh6G45WvK3IploZSZCo+IfWYVcs29zkcgG/viRS6Ui73D8F6mSlmYI12Tz+sv+QBofgmWZlKA0+ft1IZLY/SJ5VitSMKs6M15rmzYKvjD5oh35kRRNLVa7wFNpTk6Xz7zzh9klqDXeQZpLxAvYV60PONauNFDhsRItahxZ964rAX7P2kl9pjKdXzzie+GRfBCqo7veMpdCKo9zLCs52sN7SNhf0UVEauknakjo8zzwcOL4mvNK0pUnKng1EspdI2YcNxKsyda4o19dOkCeJkWA/kOMl0jdaDxlLi+eCpEs49azTlJ5DbbHBGSPB7hI3BrAX9KovgLYFblMI/YphFkCx0g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(4326008)(82310400004)(40460700001)(47076005)(6916009)(356005)(81166007)(44832011)(36860700001)(1076003)(16526019)(5660300002)(70206006)(336012)(8676002)(36756003)(426003)(8936002)(26005)(186003)(70586007)(7696005)(508600001)(2616005)(86362001)(316002)(6666004)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:28.1854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be647eb-c560-4eec-28ca-08d9b9f3ad32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As a follow-up for previous cleanup, those redundant lock protections
can be dropped now. As we already adopted an unified lock(adev->pm.mutex)
in amdgpu_dpm.c.

Evan Quan (7):
  drm/amd/pm: drop unneeded lock protection smu->mutex
  drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
  drm/amd/pm: drop unneeded smu->metrics_lock
  drm/amd/pm: drop unneeded smu->sensor_lock
  drm/amd/pm: drop unneeded smu_baco->mutex
  drm/amd/pm: drop unneeded feature->mutex
  drm/amd/pm: drop unneeded hwmgr->smu_lock

 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 282 ++-----------
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 375 ++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   7 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  18 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  14 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 116 ++----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  31 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  19 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  30 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  16 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  27 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  20 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  12 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  40 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 -
 16 files changed, 157 insertions(+), 855 deletions(-)

-- 
2.29.0

