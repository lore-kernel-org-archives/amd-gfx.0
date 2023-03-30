Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACC4C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB80B10ED3C;
	Thu, 30 Mar 2023 08:58:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF01010ED3C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYba93JhjOlCZy9qRLtdJgULt8oRf+5MC03hwKDoWJZXYwiihmCMEcFXxcK4b3jw0UaJ2dnVvRTST3SxTzcU8yMut4/ostZ4QaGWQ4ILNPGq/mDt7NiQSnFc/BmwHCCwlbqfs8Il6UgvLPoiaJ596GGa0N0vPJb+WAlctXA5qmSKGMckN+TsexrGqbN68nXZnf+wrBy2yMXBDb/2B+dQ1tKdEYxkSVtUqP+xpg2KA2DgoHoWJ6rt5t2Z2BF3VavP0IqRM95Eug9UsUv/LSngMN+rdV7Ii/5VVSIuycs3/vf09RjCmBfCGG0md6jIlm7R1A/xaA9qSF8gzJCPVBzW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yMlbXDWv212Ai4jFJMivYdJxSkW/wtrjbDAapT9Xfo=;
 b=F87tAJSLhh0Ly7ENYK9ywFma4mqY/3kVSjHkARBSQw3P1uYe9HRc/p/VpiIyPGjRSUWB7apcRVfY0e+uIq8Ty+d9/337LeyodfZY3lyfHEvHAJXQmuV0YpMRIGjvumcONrc7QyCGYN6X/y3LJKKhvlEtMXj+w7/LqaiNuqe+StzVk1ACcw1C4HZcMeP7zyN3LtZy8Ostx7dwG/7radHby2uk48eHqTB1iFnWe8Ry1B1rkHKeFJPt+eRK66uWa1Htfks2LEe6UwnOkbdeHzGOMmjkrVbx8CRZiV0NrouypqticEnRBpWbNekNrHeg/61EGSKGmzmHezEfMiKHXPgvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yMlbXDWv212Ai4jFJMivYdJxSkW/wtrjbDAapT9Xfo=;
 b=P9xbuAIfPB9fuGeKiGUjm5HQ1DBW3nPAvyZ6g53H7qnyGvhADEi/pUuJfzyjs2wrscAw5ufuFivJUNrizdxTSo3zJ+jfZbhcjZbLXAzp5s6jc5q27/UHpd+0rR+K8sSp6FhNqfYHQX1Sp19S9KfRoioHd/8+JiQr4u2hfqTtEM4=
Received: from MW4PR04CA0058.namprd04.prod.outlook.com (2603:10b6:303:6a::33)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 08:58:12 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::f1) by MW4PR04CA0058.outlook.office365.com
 (2603:10b6:303:6a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 08:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Thu, 30 Mar 2023 08:58:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:58:07 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/10] DC Patches Apr 3rd, 2023
Date: Thu, 30 Mar 2023 04:57:10 -0400
Message-ID: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 40719407-ed7f-436d-d0dc-08db30fce42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3glwROtMHJCAlHf2roaykC9kik8N0QVTPPbYh3SWSnbNnmdDNIKTiYEnf6+9bDhvg/wacp4hl7/kYONk6q/KUbn1fRbKPT/69oWt2QSaG4126Og1yhh+fAxWCEr+5UE2IdKxsWzlFpWLN8t021DrmKvRqau08lw8nm7ndv2+p84W6XvvDVweLaX9jWk4z5wZBmLSKkm4u9fB6nwr4aKFbrw6J7z+SnmKv/VtXk+paafwHyWzhF51snlwfpdXiu0lBfI/4QTCRNbkto5VYnW32NLY7lKn7+a5/qKSuCF3L5heexdsh78KrhFdfIj5vTcs4BweTy1zO0KVcYey7qzCAf4vkvSJKdtS9MGV7Jk8bgNvLaJEhA7zziyI3h7x83g+m9B1oUmwPWbTVZYhYjqWPUlSlpUWvhjqUiLsFkKTQ5wgX8D4m7gCROtrjOdz+Nuh0OAYyt3wKNvb80XJ1vea8QRNNyz0FbVmU4Yrreqt5gbjoiys5g4GQsQt/PJVMs85GsE1WFm//tk0WOGsE7XTwptk79/n2IuQM9PcZhHThWr1ITwQQCEo+jvAK/ax42QXS5fz0JNMkf84kuAwy31tmwgc5w5FllVqNwaTyMXpVbt588BzcQ4UFas0qjbdo2AzjIdt0Elga8EuEja45mxF2Xa8Y6c4D/HC665KnhA0KPMbIZ1qKCWxtd+INpU0HAY6EgDm+Rhp5EGd+jD1EWhwjPqbEOKzOadzgvZajo31Gc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(2906002)(8936002)(86362001)(41300700001)(70586007)(8676002)(4326008)(6916009)(70206006)(36756003)(316002)(47076005)(6666004)(478600001)(54906003)(1076003)(26005)(5660300002)(82310400005)(40480700001)(186003)(16526019)(2616005)(426003)(83380400001)(336012)(36860700001)(356005)(81166007)(40460700003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:58:11.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40719407-ed7f-436d-d0dc-08db30fce42f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- FW Release 0.0.161.0
- Improvements on FPO/FAMS
- Correction to DML calculation
- Fix to multiple clock related issues

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Clear FAMS flag if FAMS doesn't reduce vlevel
  drm/amd/display: Add FPO + VActive support
  drm/amd/display: On clock init, maintain DISPCLK freq

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.161.0

Aric Cyr (1):
  drm/amd/display: 3.2.230

Charlene Liu (1):
  drm/amd/display: add dscclk instance offset check

Hamza Mahfooz (1):
  drm/amd/display: prep work for root clock optimization enablement for
    DCN314

Michael Strauss (1):
  drm/amd/display: Improve robustness of FIXED_VS link training at DP1
    rates

Paul Hsieh (1):
  drm/amd/display: Correct DML calculation to follow HW SPEC

Zhikai Zhai (1):
  drm/amd/display: add scaler control for dcn32

 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  18 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  20 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   8 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  18 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  28 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |  10 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  26 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   3 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 156 ++++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   2 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  85 +++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   4 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   8 +-
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    | 378 +++++++++++++++++-
 .../link_dp_training_fixed_vs_pe_retimer.h    |   5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  28 +-
 25 files changed, 807 insertions(+), 19 deletions(-)

-- 
2.34.1

