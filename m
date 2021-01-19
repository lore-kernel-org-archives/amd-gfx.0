Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A78C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1182C23107
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1182C23107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88D06E0F0;
	Tue, 19 Jan 2021 20:39:39 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750075.outbound.protection.outlook.com [40.107.75.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0870A6E0F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 20:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf098/wmeM0KVgHbUDbp0aEdpxr3OZ/Shuy1OAiUEtgl00T7zk5dFo3i/R1wvPYLrTupl1p5/z4HlhCNXF+xCPIoxNWLsXGuoLWbWTKrY6k9Om58DV7a3wGCDAK91xiObAKtOP55oXO452a12g1q8TpnS8jlJ36O4oEQExK9JcGRiL+6y65Kcow265rHdGgG+chDRpXpWnfVkDy+bmNr8uYszq7/sM5saJdEFx5wbLJ/PmeN1pnKu6KTMKXz9178+B/oQQc9WGPIIPTTG2YYVyqibtasy12YrbSqGD0zu+O1Ca0rOMk+kKVkYpsbKXi5HJ7fUPIVBkt5t+XsHdxkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ERDdARG0uGeOkNVXjNaPX1auGaPlgVjKnoQdlRmfsA=;
 b=kOLpv/JMKR0n8QVAvMLU418wrnbmRDm+a0/o+MPR0AAWMXwkKzQudD3oadGu5fkCvGbrQX0g8OiVSZJ+68WqFpB84446YXUF48f0srhLqGUeY0vFxK2hakvyG/UNjdhE+tHd5TnIEWnnn8woriG8CrkvKDTIkXcmBh9EzQr9Hz+GisZnAZVcpFKZeRg5y7YvhDWhDmFL0KrC+vK/g9Ajj7uVhlOqN5KxCbGuQ7v2Q6C/BziGkUVMqkHnD2rEpqSvEnPIJX8HCgVuuoIsmLJd4OaSbBmGlRomtcf5X5JSydqcF1yQr0itAwIb2gMd7gAcxJ1VSI/8GJ9Pn5FQLRD5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ERDdARG0uGeOkNVXjNaPX1auGaPlgVjKnoQdlRmfsA=;
 b=LGEmyoSP7Zu4pEITmd/ZalD5pUN50dVv7KNaZpp/kXCvk+MvOpXfxN6UsvCU270Lb2c+eMdIsFdrylsM8UjYYugrq2pxRIAC5ZRaqGU1abdwPGV+4Ym+1Peq8kixC2Ol500qdZwBoy7DQgJ2PKlpcHp8VFFtDLiWedR8UvfRi4M=
Received: from BN3PR03CA0094.namprd03.prod.outlook.com (2603:10b6:400:4::12)
 by BN8PR12MB3506.namprd12.prod.outlook.com (2603:10b6:408:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 20:39:35 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:400:4:cafe::96) by BN3PR03CA0094.outlook.office365.com
 (2603:10b6:400:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Tue, 19 Jan 2021 20:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Tue, 19 Jan 2021 20:39:34 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 14:39:34 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 19 Jan 2021 14:39:33 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 0/3] idle optimization patches (mall)
Date: Tue, 19 Jan 2021 15:38:07 -0500
Message-ID: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e522b3-784d-4892-7e80-08d8bcba54ba
X-MS-TrafficTypeDiagnostic: BN8PR12MB3506:
X-Microsoft-Antispam-PRVS: <BN8PR12MB350659590A4B9A431BB3B452F9A30@BN8PR12MB3506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpKeqiDyPoPsagazFvfvJhp9KPK2zzq0eW7sVbJPo9Qnowv1EmMWYImu6Go81CTYe2sD5GcD53UUbvS0InjJtla2koFeSixrQ7iUxYHkIn+ILPGgDTjO5EFu4+iY5gW54jyRPPFyvE/0I0rTCLKIGVjTiry5565H160uWbMVo/o6AhcXJSgR6ERthbBDw1tJcv4p43sf97dZ5d7P8BhKrdX0hPK3CZrMJkrUNi96/rpM9vKeu4+JGh0tL5uytXujaoog5Kd0voCB0wHbmw2H1xd795+kwZ87M9ZinwwgV3ebXBm+cGRtOw2N6tDJrOLtGMI3pmXi32asV+m3nXxHcxJtDrx4qG3iAx/N4tLr/O8Er37CoGVC/puOojkOt++K+/S3mX0+7xdnAKxtAKos4Vt+lgOp0PBc+/farPquVlD8rVV9ofOuMge21GfUzfwfUAKUxg4RPGVm6tw8KTLoFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39850400004)(376002)(46966006)(54906003)(7696005)(426003)(336012)(8936002)(8676002)(26005)(6636002)(478600001)(86362001)(70206006)(70586007)(316002)(2616005)(110136005)(4326008)(36756003)(356005)(82310400003)(5660300002)(81166007)(47076005)(2906002)(6666004)(82740400003)(1076003)(4744005)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 20:39:34.3932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e522b3-784d-4892-7e80-08d8bcba54ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3506
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is some missing mall code, this series updates the code.
-enable watermark programming
-dynamic cursor cache
-updates to mall eligibility check

Bhawanpreet Lakha (3):
  drm/amd/display: Enable programing of MALL watermarks
  drm/amd/display: Dynamic cursor cache size for MALL eligibility check
  drm/amd/display: Update dcn30_apply_idle_power_optimizations() code

 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  18 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 182 ++++++++++++++----
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   3 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   5 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +
 8 files changed, 171 insertions(+), 57 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
