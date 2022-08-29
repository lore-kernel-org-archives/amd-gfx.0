Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4919ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C879410EF7F;
	Mon, 29 Aug 2022 21:16:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404B410EF7D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBe6TdHlbvD02H+fD3jqrngNKWhuLtW1tGM2eCxo1MfZjqHeoGy4uG3AFVKMpiTGc/XdMEON6ExCZtkeYzR3Tjt5Yb7zY5ScGlj679tWpcccbDEHbm4rKpKaangVCuxeqK3R/iuH0kxusVBY9hHN5QFrHCRhm7nbF68F5Qptxgtg9g8gTQWSmRXOlaqO1OnLLmkwV6e7rWhaHw95oGTaSo1Zef9c/7X3WQmaYa4pM/Fxp5rIyIdlMeSAB9yOvpZGXsjU4Cl06dfTBhMtOnwi9Tl0VeydVAa4MeMTHM/TT4Dzj72vg4TVXjbvoZqRvnVmyWWjF/uFq3RP2XUAkxmt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3fzyDkhOEPU4SGJnteHyHsrVxiRFZfqN4mUVRGL8Ak=;
 b=VQBHzyHpLsRkD3pratvMdp7M1jNIP+DBmRqSM1jcQV0g9Q3zhbbaeJ5ssnxu115tqt6wQh51q9iDS8mtpbvHhb8LGT4HlU8WF9+l7ydE6uYwb6nK8WDHVfPYxq4CLerQ1D108l/m+oVbaiuqBvKko54pgI5UJHEgZZcBh2k0tFFm1OvVrxKmjSOkOtu3SGvvo9yTfaiSF8joT3RdVQHE7Nzb2tV8pRmRQIIqMhRN6efcJ2rmgad6NsFZfW6YGsuJ0X6Y+nWITqVp6c3cgubjZyGbFXSihrYM52kDh/rgpem8ZiFBPlw78uxHngmo/svYyH1RoGZmMCWCQDKJ78YOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3fzyDkhOEPU4SGJnteHyHsrVxiRFZfqN4mUVRGL8Ak=;
 b=iGk7vXrolQGKoNvb+ryk9n3vR4NBL6u7/KRvGWsXZaNwdeE+93cbrPGN3Uo6k+qVaKEeHMHKs+T3KBDl0yiy97ZqWvQ7kr90HcS3f6YE9sEeRyrYnE0L4tL5P5sw/KPs2D0uLL1l7e4SsU7xt9DSsegw93zNLkKadEcyruA+TAg=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 21:16:29 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::71) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 21:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Mon, 29 Aug 2022 21:16:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:16:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Add support for GMC 11.0.3
Date: Mon, 29 Aug 2022 17:16:12 -0400
Message-ID: <20220829211615.1152396-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8d7888a-f866-4ee5-89de-08da8a03bdac
X-MS-TrafficTypeDiagnostic: BY5PR12MB4871:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKEIorxyir0fJt0PTUOYogZleE3bzIIS2CHyWtdgvYeRxPubKyspH8pIyWKoaVZbWWwB6eyc0OOoOYAlXZJvZ9WCpk6eQEmRs3xp+g8hk561+PRjBl0cX51mjIcFw8MHOZuYO8MLMfv+xUs/BSviLoVkj3Crv/cKaMANl1oYo7iOWq1ZBtqb6P8fveps92okdDyS5hDY5gCXY42uld6M2CxTOtjbkuTWYRZFRfuuBYc+po/BAdnuhN8IcKbEVYJsYEcdbS6rFtyMssH//RexccqVn+OHMji2UaA2SkYBzbJ6lMcYgaqeatcUM9zKMQESVlfqP0Eilu66XDz1aRF1amfTKk8Hxs+/ZiRSn4IKGuYfvrKAsQqa20968Cj4naV7ycLqLDLd7q7rh5CSe01xYEifs1IXS4m784Chvtl3aBZxHf8ZROPxgKDGmK7u/L4smLQxI6yi+hE12a5Eu26d7kPonRj97IbylZ+GbxpojpOBPk9+fizIXNI4eo4wBtrsVY32LG0SjwUONQ2J0HZSvAc6bQUflz+BXuNpslPr8W4RSU4K0K/r03+JJ+CAGieb/sQTpIeNA1bT5kz+vPaWC51vG2rB4KbRtSmeM1DHPdkQy1SE7cCKdRQPnV3VrrfeNIc+9lOUjhRUOlSMjrPQaFz0KbXPJXkSgqjtwyIBhQxo5XURkEJGZB1P8vRVuH2wnqWD1TMQYb8R/mdj+PHJ352NaS0NUAZrH3yG1Xl/n4LoCkdMwkBet8cyeIeXYQnC3a/sEYsnqPBLbcb27OnOmpXQYWuC1A4LYRg7MUuAIyU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(1076003)(36860700001)(186003)(16526019)(47076005)(2616005)(426003)(83380400001)(2906002)(6916009)(316002)(8676002)(4326008)(70206006)(5660300002)(70586007)(86362001)(26005)(7696005)(6666004)(478600001)(41300700001)(8936002)(81166007)(82310400005)(36756003)(40460700003)(336012)(40480700001)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:16:29.7145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d7888a-f866-4ee5-89de-08da8a03bdac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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

This set adds support for Graphics Memory Controller
v11.0.3.  Patch 1 contains new register headers and is
too big for the mailing list.

Frank Min (1):
  drm/amdgpu: add gc v11_0_3 ip headers

Hawking Zhang (2):
  drm/amdgpu: initialize gmc sw config for v11_0_3
  drm/amdgpu: add new ip block for GMC 11.0

Yang Wang (1):
  drm/amdgpu: add gfxhub_v3_0_3 support

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c    |   511 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.h    |    29 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    11 +-
 .../include/asic_reg/gc/gc_11_0_3_offset.h    | 12086 +++++
 .../include/asic_reg/gc/gc_11_0_3_sh_mask.h   | 44640 ++++++++++++++++
 7 files changed, 57278 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_sh_mask.h

-- 
2.37.1

