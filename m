Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB77C38145
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 05:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBAC10E432;
	Tue,  6 Sep 2022 05:46:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D479C10E432
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 05:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6qglwnQlzc6AdQ5zi/vy0Zr+IpFijNww6hwOUkWJx5tEhOHReX14NFZVE7Vh8pgWNB8HgRG6a7xvmiCc3b2CLwVcfFXTkLwjtG0AMaAtHQFyU5P7T/2JUVmLs6a852dqe8Dd5kn/MsXgoVQB1ylK/dtceZqssQJFv2VGwL267G8QKBqbraFlgzzSeRx0sl0SmmEmIYVBOEmAs7fRhuKzI5KqzE61RWFBxDVgP/OuVT9otg60in08Ldw/3hRb7RIdZk2iiDdFglN4A9AzQNLZ4/uy9jqftoOyf5EFov7i1c4GXNvow+q1JK+auoyNXiC6568CVu1PHpnVPS6fNgCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7uBHl0C+CvpYAGmNBXR/cX0nx5MSobYKOXgv6G79To=;
 b=Kcq5s2/d7OofvnwMgQ2vRWon4iiwhUMWDW/mcUInfjk8P/fAT3S6xaAk092ew6Mwao2OTs6/Ag4McM02C2H7MKUFlMyQtibfCDWEH7BIvK6UPw7aqgX5wyYA1aQdZmH+J457avhCvsubSgztMejIJGRe2Tk3kKJKl+rz52zbBpLyZRFoklEtK2ehG1OkdNhZEJ4z4eTEwNnrVc1D2GHtHL9WpovJREa8UIzQXB+w1wJ5cbFVYCC+zLAuCsM3JTxyo2Fr6QfiJkDM8WsHoNC+TjvMQ83cOz2rLsJYyQt6CQh4jV9y7+8P3oBkrNQUQEkzfMUH/qNQkB9kDAD2HQ/oAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7uBHl0C+CvpYAGmNBXR/cX0nx5MSobYKOXgv6G79To=;
 b=T9qoiOA8Q6q9ew66IBQxyAOY97MaHYq8h+PDvMihIkUh1G5lS6fsBnreH+aJLtWI3g3efmyBwjIcZVl29ZCi4hhYYS8hab5Fg3/2wipwWzUP8nDNrFE+1nzTkUJft1PsbRbd5k6ohs6XEMIh0L+MGBEYwLgCskOOWByiJ6e1+Zg=
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 05:46:25 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::aa) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Tue, 6 Sep 2022 05:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 05:46:25 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 00:46:23 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: print address in hex format rather than decimal
Date: Tue, 6 Sep 2022 13:46:07 +0800
Message-ID: <20220906054607.67959-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c4dae1-4b1b-4e20-1ee4-08da8fcb22f2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4037:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yj65KPei4w24h4OpFoq6tgEPQv0hz5SwApWdj4udR3sPNubwy5L+x1WcDy3KJpwL6eoSLvFWe5XwF/KzJz9QmJDgpmUvIhx1SSIamvazlA3YhBS3/qw4t2JdkMioPk7qJWdfBTWNtrJ/78qYd8otMaY/k+fXQPJejCaWuL8IyuNqk7PnO9ZfrlJCtMgEPkenD3kD2NhIdPAip4vPudSKuyYKo6BT4nSW0J1EuDFL9czrioSW9iWS2KrNiAc4cz82C4Sr2EiqGCkokxC/rfGou4ScVk3Psq5e/Qg6sKneYucE/l5wTyLNTbUqVW8J/+cN5Z90yWcTrAnb9YhTuYw/IsbFvo4BPyxRY6YDMjmib/Y6HNF4gaXJKqhU0OXvmH9U2Ts0sqPYXiGoS8jYSocMUtU0er3NX4YdM4R3N+uclCYeY+5kfRZUhS+vDIE4f9bZ4MGlPVrRT15hfAQVQvmYkJjPn0SmF9pjw2X6/xH898331cwJ703ysocxa+SHzpO2vmAuxyeEVeQsDKQN3z+otKbjCic9D5LgiEZm7iCX8N4mLoUmGISsvvMKBD57tuyUpZQooXgB7gAQlb8ayb05pUphfgu7H6KTywGkOnAh9Z57CerfIJr7OJZAygmW/p+Pg58W9qBc8G+fmuLhI4YM+KebqxnHj6PsnJehO3HutcAKohH04VZTX00aC/dCpsVHI7Pz5puypnliAqBKM4pGPozs8I9ZHaZMz+zTxuVpKXz61HZ9Tidi6HBcIopPKQlatlnTujp/AXzmBRXq8QIjLdZINzZD1h/kCjnkm+9a7TVyy3W33irNv3A/H3LmSCh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(478600001)(81166007)(82310400005)(356005)(40460700003)(82740400003)(4326008)(36860700001)(70586007)(70206006)(8676002)(54906003)(6916009)(316002)(26005)(2906002)(5660300002)(40480700001)(8936002)(4744005)(83380400001)(2616005)(1076003)(47076005)(426003)(7696005)(16526019)(6666004)(336012)(41300700001)(186003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:46:25.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c4dae1-4b1b-4e20-1ee4-08da8fcb22f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Addresses should be printed in hex format.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cbd593f7d553..2170db83e41d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1728,7 +1728,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
 
 	if (user_addr) {
-		pr_debug("creating userptr BO for user_addr = %llu\n", user_addr);
+		pr_debug("creating userptr BO for user_addr = %llx\n", user_addr);
 		ret = init_user_pages(*mem, user_addr, criu_resume);
 		if (ret)
 			goto allocate_init_user_pages_failed;
-- 
2.37.1

