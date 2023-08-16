Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1C3C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E76610E2DD;
	Wed, 16 Aug 2023 06:19:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCADF10E2DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw5+wz3pXA8LzoLTjKt6OyYIFdcqDW1T+pBpNhyu75STj3Lur2t1SOOZXfo34OvKFqEO5yWt1pL3IrU0lpxFIyYEOEZVtBNRKzZpPCPsTxQQYMPPcqwcp6JNLYjGXQCv+T85TvtFOA3sgOlXiGFWm3/t/zhHEBNx/7CLy67Zp3jPTjn71y3uCrvs2yRzkBKq58hLwFCCbk3D5aAvddmeyMAz246/fW14uQdI4PO0330E4nP3d56EMKtY9TznUtCo6rRHuuaNY7KPb/f0bq4l9XIO4/xbmXXvqATq3U5FIygJvgDq4Zcetp/KyYtHPeyBCZheeuhaDRVMkCvrPaipfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3F/ZSGK/a7prl/8rgBk0WcTyIVfL4Fe4O1pbRt1Rpk=;
 b=GcP0pzhFyYxOZHK99f4/pGR7Niv4hFtttMGspK/RFQPl/Mqp3S/DuG2tbUmFD2fp0oshdxsMXWN2WJZt+RDFEMH5z6WBvhPlZlWA2jB8sI/hEh2/2NU8Ik7qezwS0tQ1XTnLafCI1ok7TGOaUo0pIHMnHpH5Myb9qHqdAX1l5ljYJ5MxQnb6XWkCjpj7rrhxNZENcIYGrIvGA5HCokl7XYEq9OMVzsbn+mDcOgAlzF6txRddLby34jlx/j0hvyyWTs3E7qdL5N56+sSRS/3M+J3sqzlORezSRQUAtJ+8n82vl01rR7h38YSGGLHKzz/dAM0I0MmDgM/E+eD5qOeE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3F/ZSGK/a7prl/8rgBk0WcTyIVfL4Fe4O1pbRt1Rpk=;
 b=EQeR7n/MU6Hp1SIMH4x1rsr2hNY9Edd6L4JOdHaAs1jits5Ub3O8e3ZHQQXwevP2sgIgJdzhnR3/D3ZJx3ARLvcmOA1V+mj9iXZ3ytF5XGlBsvjN+K9wLzX749DrixT3DKSJc4e68l9MIkN7ayZnDFAN17TX1ti3gL5LMx6wIZQ=
Received: from MW2PR2101CA0028.namprd21.prod.outlook.com (2603:10b6:302:1::41)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:19:26 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::eb) by MW2PR2101CA0028.outlook.office365.com
 (2603:10b6:302:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7 via Frontend
 Transport; Wed, 16 Aug 2023 06:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:19:26 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:19:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 0/3] Fixup some coccicheck warnings
Date: Wed, 16 Aug 2023 11:48:52 +0530
Message-ID: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: b941c7b3-ff5b-459a-5e33-08db9e20bdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5Qzme4vo4JRm9ABSpLQzV+pSlAkfiyb176CzxBbbj76kn15zN6l9EfjedfZsc4G5NNf+lDXf6GNXFon7kQ+bv2j9VbwDF2/ry1VZMj55dZz15kpqscF1ckY7jTV2rt0+9sKJXEpYFE7KbWbqff/6RY+Xgh9QD4okRYLw0G/vVyEDOTZm2OypUIrXJbD4jHVBQg0TOqGWnByoTmFs+g/uL7QLJdRyPvsdFjIq1dFyken6TMB/LsQ4DyYLIp/Gbk/ay9btDM46ZkhVhwms8AVE+gPcLxGS0qnVRXDiGLIqbLS5Kvg5Yn9nj+WQo/NiFWMLQVC0WC+jaGI4tyNUcGAXDsrlc7MdIzI6hRM8yjLAtebcIvp1C6kxxev6v7F6l8iwnxDFOouGTqsh96X0hC9nbP2qc5fYXkq/bFw3uK/JmNXDkmj2FMZhWUhOQ9/VvP9MK+x4+c3xYlnhkVLd1X11l4oNeN15fmweqGsz8im1n4GPdh5CLuM8H4+3udh0ZTCki7WZYVCLFepfbxfRCyhg8IZuu9vqfIlvfR4X+TByl+DddWw0cJkHARJz//zT0+39OWV6u2kEggkP7MNQvPqcX0t5cPre+J+1BjmEX0SxNZ+WoFhOrjpOomu0sHWKQoSTeSx9wp7+C5FVIbiTGteWtlT+ZfsgWrug8JajzpDEc8aS3eZKOvNHsj3YOqiID5bCihjjX29aM368HmtPwRY5Rgzmxudt1z2Cq511csP9IEUDmt8GzIOBqYsEs4N6jusqN/gI33srIxrYQEIGxB9UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(4744005)(2906002)(478600001)(16526019)(1076003)(336012)(426003)(26005)(110136005)(5660300002)(2616005)(83380400001)(6636002)(41300700001)(316002)(47076005)(44832011)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:19:26.1373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b941c7b3-ff5b-459a-5e33-08db9e20bdc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Srinivasan Shanmugam (3):
  drm/amd/display: Update ternary operator with min() in
    'do_aquire_global_lock'
  drm/amdgpu: Update ternary operator with max() in
    'amdgpu_fence_wait_polling'
  drm/amdgpu: Update ternary operator with min() in
    'amdgpu_ras_eeprom_init'

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

