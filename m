Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E616EC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 01:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B1610E4D9;
	Wed, 29 Mar 2023 01:52:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA3A10E4D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 01:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt6hXupq1EEYKDU/Aab8j91Na62PUKIIhWDNfX5UaDvcsPKVt9Ga6Ft7rBF0FNFzw57HZZz/61WjDnKm4kf8c2kDtSBouezuWVZfmcYHgFfF04xrbjL9tpQq7zMBo41TNljkDpU0kIauwH/zfjddOEOC5DDAw8TYoOlNvcO2+wRL3t1ANFZg4SDqm454oGrxjpQiae8hljkMwyRRZrq4MJ4iusupcdxzYtlH58T3YhwUEaByCcl1LY7Gyms2NU/VsDdYTnXQ9qdqPb85ZmzzopVNuHk53A6zakCVkNGyJ/H9Kkyss/EGHMqb7wTUKn4iBBY2SHA5j5PmpDrcUG+Dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VGdH5EmvrhdUdlyz4w9fo1E/wVuZAU09xTH1bZScAw=;
 b=Z5uetDnDAI+7XVpWDljapNeDk/Gj1MEWfwrg2VKMCvRZcH/8oUwxDcIw4lRurO29B/6wrpZO2BvYqy9kGeX/HDNNRPa0+ZZRprOjipGBXAyjOm+kLfxjA901KIkj66SRvBTzbpSYmrnOtZCJ7tm82lyN9DGW1v/Bx4Cq4KW3CgjAnR16I5a2ljmJjIoSEVsp87Q87/AV5qQl/m3FcJd3xAbBwC961ulJRvNkahz9VJModwi5wlFh++fYK5ZKpweDXWZoIeK/WRhflVZezpPn6kt80tkqsUFgRhqeqCPik1cA/CWKt5To1AcyxJjBXn5Zcrp2NU5NHKL2vGQH4zcLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VGdH5EmvrhdUdlyz4w9fo1E/wVuZAU09xTH1bZScAw=;
 b=rDDHqXRF1VBNTTMLaTQQp8KnUyN1XQyXgcHNDOTMjhxi8FQ3bx9QBLFuVww1I7eGnVfAAezgRQvxVds0VJOIowK1fqqm1pEOkAvzZnckcJjzjXSMxK3HiWqwdZEr2lzJOeH3khTTI4QT5UanCxce2Bnkg+xw9O01Wr+UPBmQUMA=
Received: from BN8PR15CA0047.namprd15.prod.outlook.com (2603:10b6:408:80::24)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 01:51:55 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::36) by BN8PR15CA0047.outlook.office365.com
 (2603:10b6:408:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 01:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 01:51:55 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 20:51:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 18:51:54 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Mar 2023 20:51:50 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>,
 <bp@suse.de>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <kim.phillips@amd.com>, <tglx@linutronix.de>
Subject: [PATCH v3 0/2] send message to pmfw when SMT changes
Date: Wed, 29 Mar 2023 09:51:47 +0800
Message-ID: <20230329015149.870132-1-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|BN9PR12MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: c1772d4f-d41b-4b10-25a0-08db2ff82cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7DC+dAb27a4awa3WPgLDTIYSy6cUUZzCFXxMzehnf4GwPIFjBydKvZzwi6zG7/94qUW0k0UbM+0LVOu1pVvEE+csO0GFblVUdV6P7ojC69RnTFihl8Vo+YPM1heWy9HlI1TlwDASHD8GEkqVQ122ShPnLPhHOAQ6tK00AqhTWY5z7qg2H99V3jx3gs/4jy2JuatlRrlkevsbgIjnmjGzl5dNvreL7By7N/2Ex2ugt5rYQCnc+pRxtN+6DkihEDPGNSk5QhWwtAGNBH4YZ/kbD7KK/mKc/CFGOcvaaWl9PDfV7KRKhwk9lymaXhMz7s+vrttOnOGH7Wo603XjPLRFaAsJn3cdHuyQN896Tvt47Iv6lF1PiCWP2Cx/OA1h+r8qT5VFOh0U/S8AI1droB1OWJRFyceDfrZUa3BlwU29xhLqK4aQWijlPjGgl6gTqt//JGotFLGZAssyS871fcqWHklhCiGWCvzfmO+++LEAa1nT25g/6oA7XETrB42kesRWVmw+NCxwRckXQOS3E9vOPd7AFzpAQX17ykz6R97ZOD3Km7kW70CMLVBn8DFRX3T1D/3Iobqc9dCaYq5YOg/R/YaUi2WaD2sqIxntRKYQwYdzwP+44BMU8jRJqZVEJtJW+Dw9ma2UlsePZ3+PwfhL2WEzW8A1kR9c5zdnM2tb/G/2s0KpCVlY/4Ldm8JvxBh6GybUaER3nxaj3c1go4/VVEbJ25VCRS3PIKQZXgqX7MydIM0s0IrGcj9TVMojE6H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(478600001)(2906002)(15650500001)(36860700001)(7696005)(426003)(336012)(4744005)(1076003)(2616005)(921005)(356005)(54906003)(8936002)(110136005)(81166007)(5660300002)(6666004)(40460700003)(316002)(86362001)(82740400003)(186003)(82310400005)(40480700001)(26005)(47076005)(70586007)(41300700001)(8676002)(4326008)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 01:51:55.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1772d4f-d41b-4b10-25a0-08db2ff82cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
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
Cc: weiyuan2@amd.com, ying.li@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Wenyou Yang <WenYou.Yang@amd.com>,
 gpiccoli@igalia.com, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the CPU SMT changes on the fly, send the message to pmfw
to notify the SMT status changed.

Changes in v3
1./ Because it is only required for Vangogh, move registering notifier
to vangogh_ppt.c, then remove the patch 2, and the number of patches
decreased to 2.

Changes in v2:
1/. Embed the smt notifer callback into "struct smu_context" structure.
2/. Correct the PPSMC_Message_Count value.
3/. Improve several code styles and others.

Wenyou Yang (2):
  cpu/smt: add a notifier to notify the SMT changes
  drm/amd/pm: vangogh: send the SMT enable message to pmfw

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  5 +++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 43 +++++++++++++++++++
 include/linux/cpu.h                           |  5 +++
 kernel/cpu.c                                  | 10 ++++-
 7 files changed, 73 insertions(+), 3 deletions(-)

-- 
2.39.2

