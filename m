Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFB2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 13:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C98210E6D3;
	Wed, 23 Mar 2022 13:16:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC02310E6D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 13:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkq5HdV4/JF38X2hw21RZr6oSs/KotI0ytK3hT4ReujOheJYIV40cmQWxSkpZvCkxSKSxCbAubW+5Q565bzapMbL32xVtiSL5SMz2i5zPd2Sw1ROZmkNYTRt2raus7QLx1ZMsWRpWGopj50Qh2pmyn6SarSPsgnsYe5rt0ZsgEhP1Zx8OyQSvWLClASSmrIVjqusmkUUmONsTJsATf5y78TQkjWaw9h4nHjZeU5LeHeZrYi8kLoO+/jOMOvL8DyAfdB4t3H6CYhaabao7nw5SIa5dKiuRmS+G7LcMGAw6ZI6pRlUhnBdisW6lfuk258bzb7HlO/7Ilk1jEVbGpwWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXaAKstgVzQ1K6HjT0nvLorqA8NdVvocJwq1CY7/GCo=;
 b=WRc8z0PjkttRp2BZRTgZM/n2zxo10UdKtZMs6FiukHWpVUKitRFLWOscztON6bGUf92/W4w0zKdaK8mt8vFx7FRuAauhCdfZjBSyeOXfUWXptIM49Vh0tCULQfdfh0iM6fHq8Z6UoRrYArZfGyummMsgJrZzA2HlnJd6UQWIls3uh2xToLxAH5fYsjsyn0rybDZ1zmwFBlx+zTDjhfMQcpY78IMNCjpOb5U0xOWAF/HEdapYNvYVh7Be/AlUQLy+YmozwQfPwi45dho0XnumLR9iJ12ZWtuLhoD3WiL17uhDXM4SSIwNvDO6dlR2S+EoihzxATu42aNF7a2MfgzW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXaAKstgVzQ1K6HjT0nvLorqA8NdVvocJwq1CY7/GCo=;
 b=xeofTXonXiUYEEVxI9ThwH+4E9ux4JcN2uZJQ8QCYjpRBtwwVL8Gw52HmgL7TULvapswWvC5jnXOXXebptpYQpTDsRj65l7UGkQ5OxgGrDm11bnHuUqKUmcpzVF8/Oc1wtGUzE3VBN3jXvEtdlqN3yXnHUhktH8zuc3rbyh4eno=
Received: from DM5PR11CA0017.namprd11.prod.outlook.com (2603:10b6:3:115::27)
 by DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Wed, 23 Mar
 2022 13:16:34 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::35) by DM5PR11CA0017.outlook.office365.com
 (2603:10b6:3:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 13:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 13:16:34 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 08:16:31 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Sync up header and implementation to use the
 same parameter names
Date: Wed, 23 Mar 2022 21:16:19 +0800
Message-ID: <20220323131619.3901195-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eebc4fc7-5915-4dee-9590-08da0ccf5a9b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2469:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2469545527832B420BB9D43FBC189@DM5PR12MB2469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhK4UNi3t05jckIxkVV4qECNijcNBxbA/BbOsfYPBXrJ/tiKL5GZA38V7pRzpsOWLyeLuxrs8FyQ5ru4+9jpiNuW5vNSxA/46eVh+5XxzuD/BXLx4OOvwat/lT+i1A9pergLMBe8xiuvfIinffubOL2WhbZjDWhG0CXhPly/lv/DQ4z7r/JMtGFnF2Dfyu43wXJ+mvafMHb0qOfR9AM0CJVMvi6uESo/j5vTAmkOc2VTOSFrXXZoJ/wUv7p0fo7PahhG4hMaq1UKpUxwQR1yQR7/nvb4QK74TIwnirqY0eJDVGiN9lY7bl+tenNhkAtetCgJJEjePMKH1IXopeNWws2gN+Q3fH7RH3DuVWGy5uni1xIkHjPDUQi14REb4maBvaPPQ50Ag1lsiGcB4JqIugrsKi+WYyybmGZ9BVinNjvU1XdQLlkjNz+YNP/nFRXvswju6B6l1ksn/zVQRvKnqIPQEDr6N7xzoS2zZeGT0kXQFLto068FrJ1KyL4whaa+6BRvAlpZpHDjNFQoHdG/Ev6P+j7Ae6j4BWRfypTzJnLLQSsxOgDA/dZi8itSmFnqwPL0LaeQ1s0SRVU0ZISKKha6o2Vt3Xr6tBb3ujfVk9747eXJ2itVLMTwEzgWuqE3F1UHRv59c8OLMDVtNz2URHfIu3ywGJsZOserdNRVA9M5hS34KDpVTUbqJeDSJK0qUtpamGhH6OeK/eaFTj/5Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(36756003)(2906002)(8936002)(40460700003)(70206006)(70586007)(86362001)(36860700001)(4326008)(8676002)(16526019)(54906003)(47076005)(2616005)(356005)(1076003)(81166007)(6666004)(82310400004)(316002)(26005)(186003)(83380400001)(6916009)(508600001)(336012)(5660300002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 13:16:34.3005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebc4fc7-5915-4dee-9590-08da0ccf5a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sync up header and implementation to use the same parameter names
in function amdgpu_ring_init.
ring_size -> max_dw, prio -> hw_prio

v2:
- Modify the subject and commit message

Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Change-Id: Idea4931c57c57b86c17d8086d368f8aa4d013c6d
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 5320bb0883d8..317d80209e95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -300,8 +300,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
 void amdgpu_ring_undo(struct amdgpu_ring *ring);
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
-		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
-		     unsigned int irq_type, unsigned int prio,
+		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
+		     unsigned int irq_type, unsigned int hw_prio,
 		     atomic_t *sched_score);
 void amdgpu_ring_fini(struct amdgpu_ring *ring);
 void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
-- 
2.25.1

