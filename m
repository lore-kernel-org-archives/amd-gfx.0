Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0986CC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 22:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7A5610FF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 22:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB7A5610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C89888DAA;
	Fri, 20 Aug 2021 22:53:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7403B88DAA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 22:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8dl/sySzSPsRfhFOTDQZGs89oXJcYFOxLPpFaqSSrOmclza9WV90NORYv3FuxMIDlPXncSvRDzDxZqqNl7zlZy6q8/IX5R7yTAOTC+wfWN9V2KGCoy9lTgxGrhiYMs4eFyHpOS2qZ8b9dZ+BdEoO1xddUJ1cOE8OnEHE3OhtkKNawjfCoNMnMc3kBmRMWkC9LPoKV4jKfxQHfqlPY8y87owtccVuW4UHIXaB2Z4BDcIDzg7yxQI7aC8sb20BnVvtIBMeebJ5L3elHs4un8hk0i2TNmyv7nFAnNyd5Ru0NEbV7gUgl44sCWGOiZMDsH84yTrTuFDT1tceJtBH++9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o65kCewXAF8RL1upAeVixN0lszmeiIuU2F15U8CZmDM=;
 b=KMmUEq1t1fkPxBU/OkW6kxgQw16Io5aMSSKttU3JmZjT4/8mJhoVRJOfMkbYZCBEnF1DD8sge58S6RvhFb1+ckgdGKTtCPWUUUvit2RIhRpGlMrGEJVA4WwelkEbLvrRmNHCFcGDDW1ubM9mvrO1QW9tK0LZ4HIElDBgxrOkjkJLrB9NViMY0d4Rl6M5gh7cgMDQc52HIKcNQ3Lbekn6tC25WVVT2bHti9vIJpEPf6IYNHyutQVBSq+wBX4iIFnP1FQUOwieLlc0sV5qEL4/6K9ZZ6XTMY1xp7dGo+m4tr10/g8haRcp3CGoUzsUt5tVcTtxeb6FJYy/+2gJgOOfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o65kCewXAF8RL1upAeVixN0lszmeiIuU2F15U8CZmDM=;
 b=1kk+6UkiGaJdvHWYPxeIv0ugjHIabPSieYpWEpfRfMP6cIQ94mwFWIzWXaLVoE5wB9y3affxn4jwuFjVsG2h697QwAvhhbTttMU07N4V9L928/1p6kwY4DVcnk0UkqdlIPQ8EEdZtfgyXAd3EYOxwClnyq03+CJfGv+6onf5lfg=
Received: from BN6PR13CA0057.namprd13.prod.outlook.com (2603:10b6:404:11::19)
 by BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 22:53:48 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::35) by BN6PR13CA0057.outlook.office365.com
 (2603:10b6:404:11::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend
 Transport; Fri, 20 Aug 2021 22:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 22:53:48 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 17:53:46 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>
Subject: [PATCH 00/10] DC Patches Aug 23, 2021
Date: Fri, 20 Aug 2021 18:53:26 -0400
Message-ID: <20210820225336.1242120-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c861d31-bdb6-4213-097a-08d9642d5f13
X-MS-TrafficTypeDiagnostic: BL0PR12MB2403:
X-Microsoft-Antispam-PRVS: <BL0PR12MB240312206B27F20CDD3E43ADFBC19@BL0PR12MB2403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DY3nZQC2y8B92AN666Qns07meuSrrJzOQ8vlReTKKeS5NIgalBqBvof7sQwrc/Bh0OdPw6PQGUJXM1ISRug7j2fIboKZzSJT3wPzFuVAOGXJkgNwHv+X/PSpYgU6sjLMgZyEAksw8Zw0cW3CNHTtIzUCV/e1o6rZm9agIw8h5kbkg7K8V9IZzphzf32n2s3e8H/9icDCoVNr0q8X/gg78eHvWDGFeSz3o3D4Vhm/GZeZxqYZSM2Ul7zv1D+PAtGs62Tjrw4G8z8cwj792TICdlRbKaJMTnO6m0gRYa43PyirRB7mArQyBPFNuzTS3A92xD2NdPMk1WMcBqA65qVb72jLus0LildGbBVLQ4mX/IEWqkP4ktPegjDN9K9r2RIMQtYvbFPL/z3EbdG3BL3HzDGzu83EHJ883xnsqT1Ci4kSqGq1htBptY+0sCBR9QDcca+Sm8R+7OKF7+OtymBvOGxcGnBAmC7W70SrMIcxDA3Ajqke/OxX+hajkLc3NIHJ/wfqb3bfN8pRCVNWwOY+jTgxX0jYLppyNamfWP1kCrrrquaPjCRNcVCqIaNS2p9fmQGDnzobTxuEquwJUEDvgo8w7BnzMhA73sAwAj7L6JuOEgZLb/7NgEzUBCrQonNkfsDIGqNF/kpqjnQ+BwDikDvAW1Er3vFOWVlF7mZNAEKbyJSMjyK1RkUBqM1XmGs3ZX9iN6KBfdAyGqhhMdUrOAAHk28CvNkAXXbT28OZNKG1z81dBO8/TU/ZOIPFB7vO5xurNBSHBWDr7oQMu6zmaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(2616005)(54906003)(478600001)(44832011)(6916009)(82310400003)(316002)(36860700001)(1076003)(70206006)(8936002)(82740400003)(356005)(5660300002)(6666004)(36756003)(81166007)(2906002)(83380400001)(70586007)(4326008)(86362001)(16526019)(186003)(8676002)(26005)(336012)(47076005)(426003)(34020700004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 22:53:48.0585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c861d31-bdb6-4213-097a-08d9642d5f13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
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

  - DC version 3.2.150
  - FW promotion 0.0.80
  - Add missing ABM register offsets
  - Fix in swizzle mode mapping
  - Emulated sink support for freesync
  - Improvoments in max target bpp

---

Alvin Lee (1):
  drm/amd/display: Update swizzle mode enums

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.80

Aric Cyr (1):
  drm/amd/display: 3.2.150

Aurabindo Pillai (1):
  drm/amd/display: Add emulated sink support for updating FS

Josip Pavic (1):
  drm/amd/display: add missing ABM register offsets

Jude Shih (1):
  drm/amd/display: Support for DMUB HPD interrupt handling

Michael Strauss (1):
  drm/amd/display: Set min dcfclk if pipe count is 0

Roman Li (2):
  drm/amd/display: Use max target bpp override option
  drm/amd/display: Limit max DSC target bpp for specific monitors

Wyatt Wood (1):
  drm/amd/display: Initialize GSP1 SDP header

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 199 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  40 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  35 +++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  16 ++
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  10 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   7 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  65 +++++-
 .../amd/display/dc/dml/display_mode_enums.h   |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  29 ++-
 15 files changed, 382 insertions(+), 39 deletions(-)

-- 
2.25.1

