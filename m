Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E732FC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 13:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2954710E343;
	Wed, 20 Dec 2023 13:19:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E15B10E343
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 13:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OimoM+MWZTf7aAA438msTT5DTU8PAzMCNxNdjthCcbjqxNcFKmvl3JiTAhhnpePy7zk6IFn29avQYTtIJlryMYoMBhK6UxEp9vwu5u9w51nw96Dp3xvn4qKbc8WOzO0YleJNomhvMwK19/qplUTeV8mrp3vlVG+omDT9iCN/9XTpr/avQZA6FJvUr40pp1x+FbcssEt2fZ53vbXHbOZOVn7UlzND2tbgXw7jZPoVEluGA9M2tyjGmEAFbwZ22lilJnXP93rXj61X8qMa6G8gSc803Lpgih7P3zpb6smauhgsljbFWMsSPOGt1FtXp+OOXbH5dLwypA4RMewuG85tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1212PEHuySZxD+b6ZyA2on6kQbCRaOHPo7s+SxlHuKQ=;
 b=UqDhu0LSlVjo07s5OhBjKl5ipg/P61kyQeRGxvbF2TIMVzPwdCdFQqp4kESONeayhSX8cwowolFPBakPNabyXquKK5YF0vgZ85Ws1kMdgjcpZgfyfQKvLZamHoBzPiNXUZCyG0ivxAgPLqaWOyNRyJZyuWfPLAYgW/aULxKEy7KOi4Pe/BjpU1m2Q/6A/c6IVVRANL4RcXRV3z28/6MAojrhoxfN/kHI7qZ41g0V8ifaiSIGA3ct0lMMlbEi8VNibPuOF6jVrtwg70wNRt9PoI7zBlQJorlMnNDJz6FfvsBS2l2zRAHLzypXQGaUB2u5iU8USEFl2ONqolRFKzY+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1212PEHuySZxD+b6ZyA2on6kQbCRaOHPo7s+SxlHuKQ=;
 b=1ir02omLSA03ErRLOwKTIY5JlmILZGQitntJFsBAiqkgiAFsRdWXTlmWDZyeORoZ16AQscw01wVa4kXXZ6t/uH93bn/yXIckJnhbfznk63BGPvv7OcOXJeNtMCdLcY2kPlTA7jDfjRZe7j9g31Z6R5nY49VT0AaVX61Zwod+3BI=
Received: from SJ0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:a03:39c::27)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 13:19:08 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::53) by SJ0PR03CA0352.outlook.office365.com
 (2603:10b6:a03:39c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 13:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 13:19:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 07:18:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unreachable code in amdgpu/atom.c
Date: Wed, 20 Dec 2023 18:48:29 +0530
Message-ID: <20231220131829.921904-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|BN9PR12MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 479a0fe6-b0ab-4003-720f-08dc015e3f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+Avtkb5NPD91OmpT97Msl15SfPQP71XZDVWeRZmnR6aeHQ7LtoVlD43j7dKgEW4NyUlrd3pJC5TI0fiKIQZ4eejDMNaFfeDVgCSJobPaSrgZ4boVLdDOp8Crcb5u5O6H8MWjxMNnpBUZPVbtBT8c5rZLLMWhaXn64pkrUiPVMiq3AEeza3pulxoVlFRJ6JWzTdaYGs/C5/0Jt7JgBp9lVKmEvwgyBP6BEGiqtwTuX42ETD5uOH7+V/boZSWlHVwCaOKpq2uWpNqxGgvA2m3/cwel49i0M5G4udlqbfWLcZ/1zFVTs4koa7gg2NTUl7QxIKPnZtVPnJDvGoNhfk9IJyH6zuolmIPceacp9u/s4LMEq2wRnL6o1oKLx/E7u/JihY/N/BoHziJQawWam5qPGHaxgnTJD8KgDAR83J8j5aESizEOLzuNUfwmCBk5ldz8YBV1PFPIBlCGtbebxESnW75ZDZOYh6ceE22IApsH5ZeqaLV+6cR5tj8LZqyxlnv+xpTF+uc2D9UCP4UDq4rhbJ/VosfserorYQWjorclKlyY2OxoXRl6fHPibRkfGHsmGpqsEFBnGbVd8cAnFKPUK/NgeD583etzp3TzKqISi3FhJg4IYNHmQZzLBuQR3dwB9YQhpIC56/5xG4ZLeZ5Mbp/NHEgOOCTjOHBdkw5D0mOLZa7Zu2Bne0TnBsi6kVBpoL20jBx6dZYUzlbgR102U2+UFsP2/IMCxfPQQo4zf4fsT3eb4lTgjvpVKh2XiHWDNlmCfkBeEjJtfJzRGr9/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(2616005)(40460700003)(86362001)(7696005)(6666004)(1076003)(478600001)(426003)(336012)(26005)(16526019)(6636002)(316002)(54906003)(44832011)(70586007)(70206006)(110136005)(83380400001)(36860700001)(356005)(81166007)(82740400003)(47076005)(36756003)(5660300002)(2906002)(8676002)(8936002)(4326008)(41300700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:19:07.4957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479a0fe6-b0ab-4003-720f-08dc015e3f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
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

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:316 atom_get_src_int() warn: ignoring unreachable code.
drivers/gpu/drm/amd/amdgpu/atom.c:398 atom_skip_src_int() warn: ignoring unreachable code.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 2c221000782c..6ab1a5dca9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -313,7 +313,8 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		return 0;
+		val = 0;
+		break;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
@@ -395,7 +396,6 @@ static void atom_skip_src_int(atom_exec_context *ctx, uint8_t attr, int *ptr)
 			(*ptr)++;
 			return;
 		}
-		return;
 	}
 }
 
-- 
2.34.1

