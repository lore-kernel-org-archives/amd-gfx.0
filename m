Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343E5C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7676A10E4AA;
	Wed, 14 Dec 2022 22:17:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7714C10E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly1qatI+131H+JP0ntho9fsbbmgo7cuY/2Tggt7wgySUa7PRkoZipas7N+quoJYcRMGk+hk5G1T/fckr11+mdTG+t78nlexc3Qpg4Fb2C53bl1frXd54iZcnW1VdrpRLDPsD41MmM2kF+CxJMkOn+O4Y9VGSdElIImwyq/UIilF4Mq2p5PgmVkfd/8JshNDmpdLKoFCYe814DEsnebBYe83BflXqkadHHXWvcMJVJjC+WV3UfySijNmhXO0hL06rcBhKtHJ+sDgdAY0gvNORsZHeDsJsMQLDhr5nAVwfTIXw0lG/jf7xOuBHruMofEOhfweS9oM2wIU3SrWTmeIAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixzw2GCSJeATjAB4bPufbAFHiLn8K+3AyRKawiHoa+E=;
 b=N5FhSO1Cldl3uEUCj6pOnIA2TOiyCUD7GskkbzgoLmHJIaSPFs6WOu1Hc9g6Lijo7wV+kZeXzGD7s175/+j91oapRqjYlECxI8a+fbDLRRwqi9ZjTXAp3OYhwtBTqq9t5ce6o75/LZGMyy5oKprDjKnZ6Gte169vyb7oyPbpouJ/0Jd/8PDfZBbfdj8hHv8Q+N+YFqU4Ov1T46G820yJxhx4cDffdoHMQZemTp1Y7hh77uSYdDgqTonYN8GWs6bkYeB/csDBtHxXLJ/BtjLLU5yarH7VGbhLbBeyhRSpzBjwj4Wj5B0BN4Ku7YjAamqIFV5HHeYgpOYekPUKQkKa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixzw2GCSJeATjAB4bPufbAFHiLn8K+3AyRKawiHoa+E=;
 b=OsRIZsqzy1r8pRvT2QsQTx1h7EMaL8KP0e990pfhhkvhi0HsvvZBHqOM08YrFjQE4VrHOdBAxkl9yZFx03yJfXMYj1mkGqvp0KiQ20DkLlrcW4sMq+ySwB4O+n0XirlU6vy6YB8HSsoqDSD5yBH1yuS6nStPAAYn53zaOe2lz9M=
Received: from DS7PR03CA0306.namprd03.prod.outlook.com (2603:10b6:8:2b::14) by
 DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 22:17:11 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::23) by DS7PR03CA0306.outlook.office365.com
 (2603:10b6:8:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 22:17:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 16:17:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] Improvde S0ix stability
Date: Wed, 14 Dec 2022 17:16:47 -0500
Message-ID: <20221214221654.1625194-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|DM6PR12MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e84a46b-a8e4-45a4-d23e-08dade20f295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQMIsnuLSuwPh+sHejxENMRZHSKJ0+CjWaMgidlbobP/c/HZ0ADmkhOc4ORNp9IlxjlvhYvM28J6bQNuG+utwyGL90P8ibK8/FvKtEaXjrPJdsH9bJp5JE1qEPgreDQe+YAtluRJOAXmwwofGtpITQ6f9wIjwekVN7D9QPdT4nzVQ3zSBhIDHGs9vbDrvZIKKH+bRraafdKa+6SxDpS/87w/yoJWUTuMB1naidr6i1+Ak9IRCPPlXBT/G/47o5Pus8/ULfKsgSdrL0HC9Kj8IbDpUSns3IMwwYYtQNaKyL/Vr13rquGGQM5xRDw4hnzSb/TRg3g82IlSXtqkHzzIkRr7DgUtz2vZKgWSNa6ZmRbpcw/QfJiKSaFMjObqLOjg3Jr4GWiFijQsRkg8XroLneoB/2uldMRLFvtNGaSMu5O1tTEgIzBLVBaWm6+Me2iY7YyqvbC0SAxccWcDKpVZLZWfzxAJCslPm75kukSXyAjhrxIaGpI7ujdMqjbzqU9L1C1g3VYK9XhcATm+fHJiqOiLqdQnGIFhXHUe2boRB4P1S6oWcdTMKqMVPOPRfuOWTWqkw/liQXqLAb6WP4vsJlZKZBNHwNMmzInnXVRpsIUiL8ylNhG7OXmIUgTVNYey5rIpnNvjfyauHM4DiEmS9xqAzJI2E3nwTCXt98tsrAFtEmOGJb92ifXK34xBbD6Lnx9bOkinyvmJe9BWklddJ3v3nORNPKwmMwtVOeCxWJkB9bDZOVM3y01xI2ga4mU0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(36756003)(6666004)(36860700001)(2616005)(336012)(7696005)(1076003)(16526019)(426003)(47076005)(86362001)(4744005)(2906002)(40480700001)(316002)(6916009)(478600001)(70586007)(40460700003)(41300700001)(26005)(186003)(70206006)(83380400001)(4326008)(8676002)(356005)(82740400003)(81166007)(8936002)(5660300002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:11.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e84a46b-a8e4-45a4-d23e-08dade20f295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
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

This series improves S0ix stability by avoiding touching
registers that should be handled as part of gfxoff.

Alex Deucher (7):
  drm/amdgpu/gmc9: don't touch gfxhub registers during S0ix
  drm/amdgpu/gmc10: don't touch gfxhub registers during S0ix
  drm/amdgpu/gmc11: don't touch gfxhub registers during S0ix
  drm/amdgpu: don't mess with SDMA clock or powergating in S0ix
  drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
  Revert "drm/amdgpu: disallow gfxoff until GC IP blocks complete s2idle
    resume"
  Revert "drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix"

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 26 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 26 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  8 ------
 5 files changed, 53 insertions(+), 45 deletions(-)

-- 
2.38.1

