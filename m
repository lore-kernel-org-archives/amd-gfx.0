Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E69C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 14:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4214C10E417;
	Thu,  8 Jun 2023 14:54:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD5010E417
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 14:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx1WR8/q//jkpZGkoU7KROhnQWYMJ99e4R1m2PTCNqzPOMXYBdxu1XLH4k/8jGcGS41yQSqSCkQ/N5PX/7bsev3imI4EMe2L6gXUy+JVZji+5m31ZrNlRP0MAfwRndYXhFID1DShTgumLr9lDXyO8iakeF/x7CI9QdDp7o50a+iQq0ep+6jvpvYY6/ILmMEg4zF2kdOkQt3Fkbn+9G0vM5wkP6iVcC85owffc4vdpX7C6JLMWcVsoI9CfT+tqZIwfif7DBWAqhZRSOw6sT7zsbX5z2TZaSJtKyhjbF4PHlMq+6PNePu6XpWYGzcu9RmNl0S5Dnecq69qfxbRg+vy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sBJPPOiSVBaeEaYb5JuYIvm8hIsQe1TnYiWgf34AHU=;
 b=OGvWAw1h964ucTsnGt5v2kzWtl4fojpXuWzAsV3Fmbt2vgvXFhj5j6Lmqh3ZfKNnuKZjz/oNGFHa1pDNmGr4Eh52mFOfTpxphB/AWZy2aSYXsqbTs1WlC2aFo/pq7Bc30gA2QBypKr5vDLgW7q/7SSQefNnyLvE3sQpGwp6Rnd1lzKsSpDUb95zDzR2JVKs2r3k7O4XYWMHBcemOPOccLVZI29GAWkeMcZZQYoJgwEjt1rO/K0dMJQrPcLJ6lGIv4RLKY2NVy48EZKXE8zBoVlv65XArY6Ahc74dIGXz8xiHk9WQvvm1NF5XI3m9kgm94dP7UMHiJ8YTHLT82HC1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sBJPPOiSVBaeEaYb5JuYIvm8hIsQe1TnYiWgf34AHU=;
 b=1COAhJMy6VUuZEo/JENZTjUrlCf3Sqk2reMz+63usoBSlKQ/JOb9xjhHZgjQ4oBqInDc3c4PFEOcrmtlm1smEZR4BaD6EzYWODzWXRKSjDncqOBLH6Xi0FuAAzAArV9CHiaCno5m3MaJwfz72J8Kz/WxYl8/b9bVI+ViAJHTHNs=
Received: from MN2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:208:15e::25)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 14:54:32 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::c9) by MN2PR17CA0012.outlook.office365.com
 (2603:10b6:208:15e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Thu, 8 Jun 2023 14:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 8 Jun 2023 14:54:32 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 09:54:31 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1
Date: Thu, 8 Jun 2023 10:54:15 -0400
Message-ID: <20230608145415.825486-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce6dd0f-b173-436d-8e5f-08db683044c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUNpnw0n9/tN58GNAKztpgLTrLK4ExPrvpEoh9zN9Iry4nprsU5vrVQk5jti3hK3+wJgS5Av2avMfIzoNfDLswQ1ZKw6i2mZvJjjkw0vveb88ya/A90GbEcjPVug9QVtn/0ZRXA3Rm1lQm0C9q8ht59/sc2AQsc7+cdNH3INNN7S94NMnCvzD2DUJG6oQoo/HXnhQIqqmKWGP11FjEMdmoVkcleGkB4rvoutiBfboeUhWDuCu0U49rPxy3RjiwwU1Bz4lIORBsAIXeGtmiA7Lk8cewNZDZA+j0rZhm5sqvJ+iGfxFq1RHYprAUEpjspLM1+E4UemU1uxh9tEa9NKR/htG0jGsVEpTYOBp3HTEq2VlXyz0tI5ev5iB1x/uDZ5ws1uRjxigOHPh/l0bpnNAbf8/4D62moa6l7/L+wbImZjgbAyDWD74uwPKlBwf0/76FGB/0/4qzlEvkQz35Ai0ZCUhr4HwKqm+ENtGAsmpLAL0aO1MxFhSzdrhz/i1weTz9KfZ2/cXu4AP/N6QLp7De+E+H3blAjh94hNUMo+bF1lJ6N70a+J8TWRB1pzRiJ+d+jl6n+3mHP/+8JmzYg/os7Y0xSqOp8dRw/pByeD4Bk2iSJL+xvjPLpa5AJkPYJdsdr/Z7vnkMsYLWcJFcrQOVc1vWpMTeXNiN3qKFS3caycJbRjUyswRUOXUO9RpBexrn+9PXyNwyIKyCL+NpcRTVKcJ9tbgBxOlAZX75am9hyJMn+xxsqrnqK7pOJn63B7cxjcCo1hidSFhctN5E2H2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(26005)(1076003)(40480700001)(41300700001)(7696005)(336012)(426003)(6666004)(83380400001)(36860700001)(186003)(2616005)(16526019)(40460700003)(478600001)(70586007)(70206006)(6916009)(356005)(82740400003)(81166007)(316002)(4326008)(82310400005)(44832011)(5660300002)(8936002)(8676002)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 14:54:32.3858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce6dd0f-b173-436d-8e5f-08db683044c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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
Cc: Sonny Jiang <sonjiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonjiang@amd.com>

Only vcn0 can process AV1 codecx. In order to use both vcn0 and
vcn1 in h264/265 transcode to AV1 cases, set vcn0 sched score to 1
at initialization time.

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8d371faaa2b3..b48bb5212488 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -129,7 +129,11 @@ static int vcn_v4_0_sw_init(void *handle)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		atomic_set(&adev->vcn.inst[i].sched_score, 0);
+		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
+		if (i == 0)
+			atomic_set(&adev->vcn.inst[i].sched_score, 1);
+		else
+			atomic_set(&adev->vcn.inst[i].sched_score, 0);
 
 		/* VCN UNIFIED TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-- 
2.34.1

