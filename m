Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF3AC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60B3221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YoIhTq5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60B3221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3450B6E069;
	Fri, 11 Sep 2020 16:27:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED86D6E069
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 16:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgMMiBUcLRSObbXAuYyHLn/iz+ec7F9lFxUHm/phGkWnnscAt5dR51QyUM1ij76cNfhGB5FJuDMdrXNWLGgna0tIeAaQaecEshuW4UZ73xfA0i8eO9giyeKk4lPsfbpZZzJVydzwsT/UJYJ0KrSqZZcFzZQgNcwLHW0ZCdBT59BCfW3MjXLZYNH4T9W4MYfVG8O7ZMFMSwefVf0GeqSyZ9P+3tBZ5wuhq4w4mfMvKYqTkxFSRuM7EUtzw60sXUWwDsU4OKBY5FrWgHlbnvVPDk7EzNeJWPSBxJeCF6l0w0uvywlzvN0bQJB1ngcVvLe9zxwfBlxJhVogoyAK1+KPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VSZEpNeS1+50Ia7bC+Ouqy9AF4JyJ9KCUJM9hlg7KQ=;
 b=FnsCManUd9vMwT9f9MK2SFXD+gBGCfexG6HoCg9z+XWn3HEDoZuotweaOrjQvzVBbh6Axx0v4SP2ouQ90ckrgB9Of0AL08ztiP3PLwCX4eKQRmb5Py4Ih72f0O07aijIsG/ZDpwSPpsTlc7vJtE/ud25UQi7vDjDgpWw/+aBhtbadkRIbgaaHofVtmagcj4l5TMYc667gLjK3X5aQ96nLzW72O57svTupS+9P1B1DUeTFXFGwxoDSre3Eo2A5a11F6HCWnpf+5RVdVJ2ghh99Rciw5MeKdkQNHT7WiEKlQh6njYVYpXOx72VGhtDI9Hoh5OW+is6Rhl92Nc0tLlWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VSZEpNeS1+50Ia7bC+Ouqy9AF4JyJ9KCUJM9hlg7KQ=;
 b=YoIhTq5Gd2wY19zrGLZXyLAg6G6C4cB7oW/DX3/p85f7dTV+5Qj+gppX3Mb7oSKeWvgjLLK4LetNPR7zPzbksGP9qD/192f5kdEWKtxnuDcc4G2JVytVRZXRXkPg+QdA5Ca4hooRXcynBjClvwp4+J0MVw7+i8InmU5kBhOTt7w=
Received: from DM6PR17CA0025.namprd17.prod.outlook.com (2603:10b6:5:1b3::38)
 by MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:27:11 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::98) by DM6PR17CA0025.outlook.office365.com
 (2603:10b6:5:1b3::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 16:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 16:27:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 11 Sep
 2020 11:27:10 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 11 Sep
 2020 11:27:09 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 11 Sep 2020 11:27:09 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Refactor DM IRQ handling
Date: Fri, 11 Sep 2020 12:27:06 -0400
Message-ID: <20200911162709.87720-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282bd2a2-724b-4c32-d1f9-08d8566f88b5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0093:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0093787DBDFE9BDE49ABAF918B240@MWHPR1201MB0093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9g0/A9SkIEF14wTq5pzyHhFI4uuY42PXOHLGvIaQHakG3kaoEqHZG71ewAnvAl/7SpS/MY8N4NHPL8q6/TwbcOcrMiQduz89Cz4Pl9N6YTcU5tQ0EUTNMA5CKIGBBjqcchCgM+xUlTRBU8TV5I5B1X+RxXe3HAklRdv5n1C4lOiHBwG+PX/obU8GJC1EehWWdzZfHSWQHhlwypmhtlBfOOggQt2MZRuYtJebxsGqbOvznRWiJrA9yOc8VgDu7OocyTPu+dA2wOdgaafaW3+rhALvW5hBxY22umtgxuD/LKdxRUAZ9eASWP5Eaw4/lumiXI4BkeAp2u4DI7R2dS3tt904zD0+IvM6KD8m8xXiLn5GrHCI+1TsVLzR5oRsACIEAUDJaw0KIJo4pHRfkHhDWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(26005)(6916009)(82310400003)(1076003)(8936002)(5660300002)(426003)(336012)(4326008)(86362001)(2906002)(36756003)(81166007)(7696005)(316002)(44832011)(47076004)(8676002)(478600001)(83380400001)(82740400003)(356005)(2616005)(6666004)(70206006)(186003)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:27:10.7051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282bd2a2-724b-4c32-d1f9-08d8566f88b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0093
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
Cc: nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changes in V2:
 * fix memory leak.

Interrupts are disabled too early in DM's atomic_commit() which can
cause issues in certain situations with non blocking commits timing
out on flip_done interrupt. The early disabling of interrupts were
necessary due to interrupts accessing crtc state directly. This
refactor removes direct access of crtc state from the irq handler
so that disabling of interrupts can be done later in commit_tail()

--

Aurabindo Pillai (3):
  drm/amdgpu: Move existing pflip fields into separate struct
  drm/amd/display: Refactor to prevent crtc state access in DM IRQ
    handler
  drm/amd/display: Move disable interrupt into commit tail

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 156 +++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  37 +++++
 4 files changed, 115 insertions(+), 83 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
