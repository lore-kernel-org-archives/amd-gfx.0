Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175BEC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C425860F57
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C425860F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DC789D61;
	Fri, 13 Aug 2021 06:16:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D178589D61
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW2WjBMZOisCvwHz4/ckcdExHUDVSAK9hTkHYZvY1NucmlFkOCtctVmbMoq/jNTAAGMmjKOYYbSp2trnvGVwIbT8YZZ6TaSPND7YUIr3tfns9WpZsMeKARoC0/0iLLsjwu3/iq3T6Kt9tBE5b5YbvxPFuNJfCo1JY/c2LCvw6Swr9BdG9bQS6vFlzr7e9GtXOJNs+g2GLmK7207sKCMz5b7TBcIl0pSKbw/s8g0co6fzgUqD+OIrSQhbsixQmFkJqSMe6xLilnEv7i93njmPSlcwZfqzFm3z1TQ7aKqnw9aO4GK9dbGdep6n8xL7l1l6Z14dnXXtAG+J7vf4qK1Yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4spmR/HqQAtDVim+q7E+MLq3jSOaUz4HmSDjunJqgY=;
 b=XqhtuhAU/2gPZRlDEbijYGrhlXoAtkZ7tdycBwntrmSbgi2IMw620EKAmzqXMS2vwUhWRjQsgeWTOhoEtuqG75HJxcPCSZolRBRl3SA+LEadAiOZ1RPJDF6phAsxJ4HlQms/l6pg7wnoaFZvDWSYYEAQZguNUBC5n+yrtI/SYpCCi73TgnZB/QCIoEhxo4Tno20VTcSnyfVBvKcqJE6/ZAlXCpmHgnh0nBfTwPDGQpUH8Te7ROEiLJ4y4BQAToA1vkAiuyGWfyDtv1bpN+2mY3hlRGmztXVPrCa6IFX9YRgMZLEPZ0j0hAIGLrzQC+D4H3IdNuMAyuJc4uJSSlB8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4spmR/HqQAtDVim+q7E+MLq3jSOaUz4HmSDjunJqgY=;
 b=Zfaadygio5fMSr7KHmiQKEnYmz3/WlmYx5sByLJRWsfvg/knuX7zG6fFWFXbt73xXOE2GErXr448CJ0cGQu/q77fEkdvMCFI82zvH3Wos31IU/Ta6I0tXH3r1dKBN0pn4GfuyWpgub5G63FQzW/K0uhHZo4noH7PpgXEkIB8H4Y=
Received: from BN8PR16CA0033.namprd16.prod.outlook.com (2603:10b6:408:4c::46)
 by MN2PR12MB3342.namprd12.prod.outlook.com (2603:10b6:208:c3::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 06:15:58 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::8d) by BN8PR16CA0033.outlook.office365.com
 (2603:10b6:408:4c::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Fri, 13 Aug 2021 06:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 06:15:57 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:15:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 23:15:56 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:15:53 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 0/7] DC Patches Aug 13, 2021
Date: Fri, 13 Aug 2021 14:15:43 +0800
Message-ID: <20210813061550.3104690-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27fc33cf-e82a-499f-a123-08d95e21d0d4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3342:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3342CE37E59A117321138541FCFA9@MN2PR12MB3342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwEIxzlf1oQ0duR4b8Z9xUhx1moxJIejKHWCmpmrJoLqyS0XQf8WebQm9tgY1mDc/aKHa43BlVWRwMFpoad3TQ8XDHj0cQ4wY1q4DySuJ+K7IjxgEJWSpoisftCeOgUFHYP7+JBdmcbZQVZUafiuw37NdabK+2NkptzKB3drv6wbiujAFdYNWb0o1sRUpCNxa7PKHGbHM3hYR+LdYQRSHQhMiGqlohTAr9VRvPVCNs3mxKvHu2D+0Bbp4dfwZsmsjpIkl87GPIHnT0MtfnuERHgKvCzJ91v9HKDmSKVR8E/g2EpenuwPt3oPmm5U0iuCZiEI+Ys8gaTNcULhpRvDJyGWZQ8E3y8uo5NB73qz1rkOBG79SN69TvQrTFNzx9VFdd0I0iXWeemfsjExYmy9DnJodjfJt/P6tPyYagrrxVJZRMJEwT1N3OZQ9IlE/4rQb456fZWLZP7vWrPJMa8SPB8bPeYW3Eq+ExKZBKR8bf5OqjXw1vbqAVEweFq2CP0PiSeUzasfUnLKZShm2xGwrJ9FXgTHq0Q6CIkVu3pJV/SVnLvUXYRF4dBqZ/jov5eBvsEyqyoFb9M1no7F/8UBxxAkps98y3oyyYny1IMbxWsdZEvqfj0ILlyxDjl1aKTm9nMdhgSLC3OxR3JzPyjsqsG1iPB2gU5eEGLNLpIwB+qhIwiKKP4kRcGeSnkjXGQgVpT2ar1I8ScFkL5KX+FWtkjkBJ08C8xsGR+jVcTZ6e25QH1wXtpPwlUvkeqWxIusPAOFEQ+yi3GhjDfz3hRIaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(36840700001)(6666004)(356005)(47076005)(36860700001)(70206006)(70586007)(81166007)(6916009)(82740400003)(86362001)(8936002)(8676002)(4326008)(83380400001)(2906002)(54906003)(5660300002)(82310400003)(316002)(478600001)(426003)(2616005)(26005)(7696005)(1076003)(34020700004)(336012)(186003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:15:57.9743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc33cf-e82a-499f-a123-08d95e21d0d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Ensure DCN save init registers after VM setup
* Fix multi-display support for idle opt workqueue
* Use vblank control events for PSR enable/disable
* Create default dc_sink when fail reading EDID under MST

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.79

Aric Cyr (1):
  drm/amd/display: 3.2.149

Jake Wang (1):
  drm/amd/display: Ensure DCN save after VM setup

Nicholas Kazlauskas (3):
  drm/amd/display: Fix multi-display support for idle opt workqueue
  drm/amd/display: Use vblank control events for PSR enable/disable
  drm/amd/display: Guard vblank wq flush with DCN guards

Wayne Lin (1):
  drm/amd/display: Create dc_sink when EDID fail

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 112 +++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  23 ++--
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  23 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  12 ++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  19 ++-
 12 files changed, 148 insertions(+), 57 deletions(-)

-- 
2.25.1

