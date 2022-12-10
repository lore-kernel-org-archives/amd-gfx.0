Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356D7C4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Dec 2022 09:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728BD10E0B9;
	Sat, 10 Dec 2022 09:24:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071DD10E0B9
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Dec 2022 09:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmA9RXjXuZg/dAz9sXBATOR84f4RH3chvfjZSrQR2ZTFHqhJweLPRYpihXrMGUKFR8bqDDj9ydojEPZHTnTPPl5F+JoTudWQTKxbb+MA/zF/y2RstAhGgxn8XEKEBvN6ApzwJqsXNh8WmrsQldqs8of6w8z3JYhKADsP+YgM2zaYPXDZxVQBK6nC8+o0sFbPhyjyL83wjqPQkqWUNlCfJNke98VWtVwAIsMR2MhAquQ+tUCwFYyVBwXFEm4emqha48Z907txlRWouJzANVNlfHP1eU2z88GdvBIMMXVTD5jyny4LgzHhRi/lF6l/2WbUNYNkGOu3sYqblA2v8n1QfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fujZf65/6k9HwsmbuUjV/yjc+4umssuL8cua9j5HjKE=;
 b=gbzyZLHRkI/Lpzzu7LDYj6oDHbKUiDJxWzkoxBu5eroordQW3ta4nXC0rKMkNah0dnSVF6z71Fvg+q8poSTbECl6otfuuvBB6BsB0UeFCLFPINVpSOHQpu5BuPdSAnme/7GSIDfnatzQci2JumHqK5P0iPcnKy60ZMiNTaW15nye3SQNSvrlkRxY03WrRiDdcLoarzmQ2HoijdqRKlf9wjA9j3wVemcK/QNn3Q7NEumDMKpsZYN/18Mw0GZ+PIv8rjTUIPGQZVbo8YqOI3LHoE171sVJRmSAnGswCu7YZgCUjX+FHqy2CGNjA/AqczMpusYypSVdDmVxspHtnQMdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fujZf65/6k9HwsmbuUjV/yjc+4umssuL8cua9j5HjKE=;
 b=LKoj3tIoeliMUmGpELrhi4jeqsxDOINX19zJnwkdtZMWP+QlSyA3s0Lm/W0tE77FdCGnipnqgJdx3oQi0Y1sR3LHO7U2G+DJa4IzXTvjYSC66JGuiIwML0kwagfclsE6WmJO4pdLXnaisBpo66sfvSJOGZJAXZ7l/b/DS/0VAno=
Received: from MW4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:303:16d::25)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 09:24:32 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::f2) by MW4PR02CA0026.outlook.office365.com
 (2603:10b6:303:16d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Sat, 10 Dec 2022 09:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Sat, 10 Dec 2022 09:24:32 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 10 Dec
 2022 03:24:30 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix an oops with GTT | VRAM allocation
Date: Sat, 10 Dec 2022 04:24:19 -0500
Message-ID: <20221210092419.16548-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f48bfe-6c71-4da5-de3d-08dada9058a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjaZBGCccM/GzkUIXO3OCMOJkHu88XlzkwUqpLh1M+ZFFgN2RFqXwLbNcRM+fIdZDcgTgygsVBgntrm9WA7obqbv/QzC7I8CHaoq1i+2tX7AAuNZcMrcyXjaiRQ3Vc4wpyJvuLY3QCWiSAasDg67SBSFcz9o4mzu4+uoPCnlkwjv4G7iDNhZyQ58mESzTqPu/MLl7sY2t99E+cG3U06lqSv8io7ka+fe2OJXN08dhnti6IY2ssQvJqc2Rsc3CJzqFmdpLYvMOYOwRSE+ZznqTCxy8hkYUKm2La/mNK9AWBUb7rGODOiFWx4LXhhSuFjBdxjDtydVOvWTbYu9U1Bksg45RWhBA1zrN7MsNyfAU6FfG5eBET4x+BUZzqaTFQm5NNS/l5XewfxosKIhQFjJ6f/dumyOnGRQvgwpHT/6Yrybs1Rgaj2VN9PFOTmmQ2/S9b3l8JPlZDh/A0pEvSbMkNsHvAMsVZLZ1NiyT/SBst590B0v92SSB6CIr4gAqOePTRNqPz4P3KqSmF4GXFXUt18e/SbOixFZ71VZ9+3Qd2HiLsgdyJLaFb+CDV4lLQfxacCMO/+6Bcj+XQoEi1+/lvS4DuKeHEUEwg2Fv8oclMnau78IEZkm6slKn8KxSHIgnWHW+tPjPYYzDJkXDniG1/QOqL1MUN7eE9o3BGMgAg6UIV7wDSyN3tu5fQ4SM0cPLHtVgcVw/Z2wSJNmyJt9lDxoqhAN/B0uOd9tH8bcau4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(478600001)(7696005)(2906002)(6666004)(426003)(66574015)(47076005)(82310400005)(36756003)(86362001)(40460700003)(26005)(44832011)(186003)(8936002)(5660300002)(40480700001)(356005)(81166007)(1076003)(82740400003)(2616005)(4326008)(36860700001)(41300700001)(336012)(83380400001)(54906003)(16526019)(70206006)(8676002)(6916009)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2022 09:24:32.2391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f48bfe-6c71-4da5-de3d-08dada9058a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a kernel oops in amdgpu_bo_validate_size() when we allow allocation with
GTT | VRAM domains set. The problem is that we try to dereference a non-existing
TTM resource manager of the wanted type, GTT. In this allocation both GTT and
VRAM are set. The call takes place in amdgpu_ttm_reserve_tmr() at line 1716.

Dec 10 01:12:41 localhost.localdomain kernel: RIP: 0010:amdgpu_bo_create+0x8c/0x4b0 [amdgpu]
Dec 10 01:12:41 localhost.localdomain kernel: Code: c7 44 24 34 00 00 00 00 a8 30 0f 84 e6 01 00 00 49 63 f5 49 c1 e4 0c 48 89 34 24 a8 02 0f 84 ad 01 00 00 48 8b 85 d0 55 00 00 <4c> 3b 60 10 0f 83 b5 01 00 00 81 7b 0c 87 02 00 00 0f 86 61 03 00
Dec 10 01:12:41 localhost.localdomain kernel: RSP: 0018:ffffc3b580ba7980 EFLAGS: 00010202
Dec 10 01:12:41 localhost.localdomain kernel: RAX: 0000000000000000 RBX: ffffc3b580ba7a00 RCX: 0000000000000001
Dec 10 01:12:41 localhost.localdomain kernel: RDX: ffff9fa481586200 RSI: ffffc3b580ba7a00 RDI: ffff9fa481580000
Dec 10 01:12:41 localhost.localdomain kernel: RBP: ffff9fa481580000 R08: ffff9fa481586210 R09: 0000000000000000
Dec 10 01:12:41 localhost.localdomain kernel: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000010000
Dec 10 01:12:41 localhost.localdomain kernel: R13: 0000000000000001 R14: ffff9fa481586210 R15: ffff9fa481586210
Dec 10 01:12:41 localhost.localdomain kernel: FS:  00007fc2505fbb40(0000) GS:ffff9fab4ed00000(0000) knlGS:0000000000000000
Dec 10 01:12:41 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 10 01:12:41 localhost.localdomain kernel: CR2: 0000000000000010 CR3: 0000000128934000 CR4: 00000000003506e0
Dec 10 01:12:41 localhost.localdomain kernel: Call Trace:
Dec 10 01:12:41 localhost.localdomain kernel:  <TASK>
Dec 10 01:12:41 localhost.localdomain kernel:  amdgpu_bo_create_reserved+0x15d/0x1b0 [amdgpu]
Dec 10 01:12:41 localhost.localdomain kernel:  amdgpu_bo_create_kernel_at+0x54/0x1c0 [amdgpu]
Dec 10 01:12:41 localhost.localdomain kernel:  amdgpu_ttm_init+0x1ad/0x470 [amdgpu]
...

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 
 	/*
 	 * If GTT is part of requested domains the check must succeed to
-	 * allow fall back to GTT
+	 * allow fall back to GTT.
+	 *
+	 * Note that allocations can request from either domain. For
+	 * this reason, check either in non-exclusive way, and if
+	 * neither satisfies, fail the validation.
 	 */
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
-		else
-			goto fail;
 	}
 
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
-		else
-			goto fail;
 	}
 
-
 	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
-	return true;
 
-fail:
 	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
 		  man->size);
 	return false;

base-commit: 3c4ee2dc869cba283b0c667708090aefbc09aacf
prerequisite-patch-id: 3d9ce4e1252cf76ced92d755740a8df4f073d440
prerequisite-patch-id: c37f8050f6b285983085f62cd65f99fce034a0fb
prerequisite-patch-id: eff248bd978d8510bab4c51b960b71dd6a542138
prerequisite-patch-id: 539ef7082989c2fe194803c5b8041b931009397c
-- 
2.39.0.rc2

