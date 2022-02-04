Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7C7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222A810E509;
	Fri,  4 Feb 2022 18:44:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58C110E4E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+peIEkKnYrSYMEF4p+im5AZYDwFoHRPm6ZjjzO9Rnjl0/XglHeaFlHUlRXlwsD1Yjqb9MyUertTOMrtT8cJ/HsNmF3UzPrcUdPu9ev8lRuu+q6y44nNKqhjMa6pMzkETp23ywrqXMf2k8Xbua680zneiE3ckwD+JSnsSLlN/nd4fidoXGnkJjHqRhD0WE0F5sWsUCTPHnXlTUB+gYCVpMlWITPQyQlycDlx7zqcSWNDmbdkBSUD3+xqlOEseP0vUFwUfBcQo5R82Vlcs+LuFj6G3kVYAdyywqH49XP6fPtjQT7ZRhaYwSXzQ9lkeJIww0m80j4/K1DgK86uWkByiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPBdmjUDGhQSPASqFXtPTp5kk3fwoKc3mnQ340yAcgg=;
 b=cerTfEUJ8aMOuaAoXuqRZemlU2In8LGRsOX9Ex4n4mS8nIRKXmb6DrdfEngokzdUXhgsiaR6acsWtyy8Uzb3S60oxc1vWUSlpLHoIBLiNjUPNZHXwjZCq7+RlIkWAS/g1Dbg7mKXETmBc5/p5Pm6RlkOkyi8HvT7IJh21qPQRulqO4aUvluzCTMaKiQK3Sr9lRacZJia65imokmRirhW19/J9Ya3uFKmHNHs1E5hkzdaZOCR6paqrMTcUT6AvXFCNKUMUXsLawbZnDAxjdNNhy2jAr7Zjm0rSrpdGHd2EknvlSLBFs/Y/7uOhzg3/NmCKjVdF4uriy98TjW4ra2l/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPBdmjUDGhQSPASqFXtPTp5kk3fwoKc3mnQ340yAcgg=;
 b=TxO1P51S5xAu6BT/mb38RCRgWRC/v9KbaYivXKED4AKKrQELOduPApHoUOcSSZUrBIMbR9c/3muy9Skh1+X5ZEE3cku7xpeWxvA9coggQSyqUEP4FSfOQa8BQAnO+C342CHil5yZ6kG5zltPJIwWTWmApHWw/A7k4T7fHVULOfM=
Received: from MWHPR07CA0009.namprd07.prod.outlook.com (2603:10b6:300:116::19)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:44:09 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::ce) by MWHPR07CA0009.outlook.office365.com
 (2603:10b6:300:116::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:44:08 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 12:44:06 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] DC Patches Feb 7, 2022
Date: Fri, 4 Feb 2022 13:43:42 -0500
Message-ID: <20220204184355.91198-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5d7804-13d1-4892-0245-08d9e80e5457
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4381E71DE5AED6538F4F57EEFB299@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wrLqGVCRMOtI4jZlyuZHt9Te3/pdx0XDbAnQ3WjRv35FdjhWR23J8HCT/05I8AygnruOqy7cGJKGVSMBgsuj80kfv/zw4B6SAdq3HQIvN4jlMUpFD55HxpJLlJK33dwnphyjylhUWsIduDvqFBaLpI1VYbv+g2lAGLflW9nUjp56SnMjbKPXJZsDFCSh3NoALGgW3Di3scsKislwddLvRw3xDamj98cZ0gB7Avr6Tg+IDDRz3dTmwjKsakn37uwmosGcS3BIOm6KqeUtR0F6346+pw6UQ+4kVCRttN1MWAv3cTL0ugjJT/9GcgE2zPkMa6FqmHeXZkFwj0FHqZS2Pq1SQpWYfK5BqxEtsous0SNgQSYAGuxyiATyZkLg/uzkcaIDbz5EvwxUbm5DMmqq0b+gT+7V/vzVa0URIIgJ+tJ5CrMiyDcTS6uzNweil1ffvc/IHXRcXnWNBJ8YHsVcndvBkUXbHAjPN7gqAnPWNIzWovyyxAyaIPQRg8CFtKH0APQvD/c4Sc0uYk/2Wc0gdSoCvmHpN2/ROC0Doh/Be8NflYCIRdIe5arUUB1pL5bBBTVNm/ADZPajG0KkjusbFAyagptKLYA8Zii7mCZNZKgV8iKU+qow6P6ee4gMUPZm0AchkXVXGYSDNFC9yOD3mE+O5A5eWjSfRWyLt79yA5cRtEWjdfeNmzC4FQiB0eRq7EyLU2IPBsDCCrZ1bghPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(81166007)(356005)(5660300002)(2616005)(336012)(83380400001)(82310400004)(26005)(426003)(186003)(1076003)(16526019)(508600001)(40460700003)(316002)(8936002)(36860700001)(70206006)(70586007)(6666004)(6916009)(47076005)(4326008)(8676002)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:44:08.9779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5d7804-13d1-4892-0245-08d9e80e5457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
-fix for build failure uninitalized error
-Bug fix for DP2 using uncertified cable
-limit unbounded request to 5k
-fix DP LT sequence on EQ fail
-Bug fixes for S3/S4

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.103.0

Aric Cyr (1):
  drm/amd/display: 3.2.172

Dmytro Laktyushkin (2):
  drm/amd/display: limit unbounded requesting to 5k
  drm/amd/display: fix yellow carp wm clamping

Eric Bernstein (2):
  drm/amd/display: Fix for variable may be used uninitialized error
  drm/amd/display: remove static from optc31_set_drr

Guo, Bing (1):
  dc: do blocked MST topology discovery at resume from S3/S4

Ilya (1):
  drm/amd/display: Fix DP LT sequence on EQ fail

Martin Tsai (1):
  drm/amd/display: handle null link encoder

Nicholas Kazlauskas (1):
  drm/amd/display: Fix stream->link_enc unassigned during stream removal

Oliver Logush (1):
  drm/amd/display: Basic support with device ID

Paul Hsieh (1):
  drm/amd/display: change fastboot timing validation

Zhan Liu (1):
  drm/amd/display: keep eDP Vdd on when eDP stream is already enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 ++------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 27 +++++++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 11 +---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 61 ++++++++++---------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +-
 17 files changed, 104 insertions(+), 83 deletions(-)

-- 
2.25.1

