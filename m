Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E455C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBA66128E
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECBA66128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1CB6ED17;
	Fri,  1 Oct 2021 14:37:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BAA6ED17
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErxdMzXfoJrg3/81u8F3V8f48Ld89RJc+08Na2+4CCF2R584h4T6vnKaIamkf9PPU9M6IvB3EKBTK6a3vEUHvSAFy/OUWp3WdDpX0sfrUZUzQBDqV9IrlGHtgmV5mMtcBJJRRXUkke87ykV7qV9idxpw1eAn3q1Z9lG92ldETt8D+d6fOEWXftnZ/DWPXyOHWMFZx3UCD8QXBgUv4NUYieYYFKwjBRq49y159hsY6jmy9x0iQXuUQU7tBNlr69k0BWBo8GvbgzZjzWD1BvxDotyXwKzQO/uZ2M4Uoldu+2Ba9vfDJvv5aBeCDpKLrEFgKugvC4RZOE8NEEspgz3JaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouTqajqVR0XTjFDE4S0G+hUZwnBLqjYDmPcMtEKqmMw=;
 b=R/fiK/0sBvAfzFIY7hg9hGdnSWY9pyKig8yjfx7nwySskBCNfZukWztfxzm9Cs9ByfJTOTO+AJNUM1z6BrUepXYWwIo5BeBKGSWV6OxL5+PQLyaJKaPEsjf9+9lCELZqYWPoAJY0w05Fv7eegtFU7jCRN7zZLSnCf/y0GFshn2qPR5ngQVIoWlvlgAISOpaVQfMzxbuoWYdT8t4T30fPwaTBw/OVLfEjBqEqkJioGoqH2iHjpAGSmS/iXn2X2LvqdeS+0AWeK5ykOWrJjPqelHs01+wlqNAH3LKRZoibPb5ebupg0z9YXJ4/V0ZFqJgsnFH610N2Mo6Jezm/q9Jx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouTqajqVR0XTjFDE4S0G+hUZwnBLqjYDmPcMtEKqmMw=;
 b=n1ugNhyA3tTqKKcUKdtKW2KFbZI+dL18xzE5bA+4rUPUZWOXSuCdJ217kKOW0AfVGVqw1SCUx/+t28vSFDhJm+gL2Zlx41Ohi3s3o0SMcc3zi1uGIUlOft1PSoc/LHEzAv0TjM4jrBbZLtyWHUf2d9KoLfvaNXfPokC0AvIO+cw=
Received: from BN0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:141::33)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 14:37:00 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::d5) by BN0PR07CA0024.outlook.office365.com
 (2603:10b6:408:141::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19 via Frontend
 Transport; Fri, 1 Oct 2021 14:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:36:59 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:36:55 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>
Subject: [PATCH 00/14] DC Patches October 1, 2021
Date: Fri, 1 Oct 2021 22:36:06 +0800
Message-ID: <20211001143620.192679-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82537909-dd77-4d52-2e40-08d984e8ed2b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4872:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4872BC0F6AC07E4FC4FAAFE397AB9@BY5PR12MB4872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9Yh3oDKS6hxzT5nhJ/GAxUFOpCdjQme32F4DVF9UyyWhQ5eH1vaq7n793xxzFh7+nK1YdlB+KHZ7pNL3lnG36aMNBhX6TLhjoIJqaINLeOTOT78jNShwD1HMlJR9K39F+KlkjIWgSssgPkAuX+O5RsQlABADCVKAkuEKlQSVRVJ9i0qFzVDpXgju089ozHI5t8oSxsVrT3DY96mgK9VnmriDlyb6k+6360g25irc06Y2orulavD/nDqXCwDrEZSt3FjBTtNuJjcHfHXdFHuXkOjjYzlmtmuDdMmUg6gMQJfiGvCRZ48T97bZ7Ygo1CObzT+uKeaXlBRAuwx+GMCdiJ3wW5Qxundx9ClrSboILWr9dmmR4S/IDb62p9LTMHJjR8zpwQ9ZpQq8Q89Or3Xe+0JM0xHuBzlekLPmsXEQchfX3XIeSFU9sQGwbINE7+aaXHjLl/3NIojt1ZGAvvGZBQqH3RqM+zddhMoZ5I3Ye8Gwnq2OXHTumKXi5nHE2wJ/f32h+LBifEQ77XyQWzXl4+dCE4ax7LmrqUo4U0kYC9IZpWxlbMPaf7yLexo+OYik8VM6a6wqw4PyRZQUNdj8c3+c8hJ6pjF11cqbAF8XVWfJB2mF8cVf+wfw7v/zMczhudvgJyXMlIjPSSARQB060ESgdrecMzJjvePt6E5mzYMmbO1kmnwU6ofFW4Y6eIy7JLHHFihC4AkyU0BrKn3EecTTKq+pGuDNclIF9raWZ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(6666004)(426003)(1076003)(5660300002)(7696005)(26005)(336012)(8676002)(2616005)(36756003)(54906003)(82310400003)(6916009)(8936002)(81166007)(70586007)(16526019)(508600001)(4326008)(83380400001)(36860700001)(356005)(186003)(2906002)(47076005)(86362001)(44832011)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:36:59.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82537909-dd77-4d52-2e40-08d984e8ed2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
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


This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- New firmware version
- Fix DMUB problems on stress test.
- Improve link training by skip overrride for preferred link
- Refinement of FPU code structure for DCN2
- Fix 3DLUT skipped programming
- Fix detection of 4 lane for DPALT
- Fix dcn3 failure due to dmcbu_abm not created
- Limit display scaling to up to 4k for DCN 3.1
- Add helper for blanking all dp displays



Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.87

Aric Cyr (2):
  drm/amd/display: Fix 3DLUT skipped programming
  drm/amd/display: 3.2.156

Charlene Liu (2):
  drm/amd/display: update irq_service and other required change part 2.
  drm/amd/display: dcn3 failed due to dmcbu_abm not created

George Shen (1):
  drm/amd/display: Skip override for preferred link settings during link
    training

Hansen (1):
  drm/amd/display: Fix detection of 4 lane for DPALT

Jake Wang (1):
  drm/amd/display: Added root clock optimization flags

Jimmy Kizito (1):
  drm/amd/display: Fix concurrent dynamic encoder assignment.

Leo (Hanghong) Ma (2):
  drm/amd/display: Add helper for blanking all dp displays
  drm/amd/display: Fix error in dmesg at boot

Nikola Cornij (1):
  drm/amd/display: Limit display scaling to up to 4k for DCN 3.1

Qingqing Zhuo (1):
  drm/amd/display: Re-arrange FPU code structure for dcn2x

Wyatt Wood (1):
  drm/amd/display: Prevent using DMUB rptr that is out-of-bounds

 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 45 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  6 ---
 drivers/gpu/drm/amd/display/dc/dc.h           | 21 ++++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  9 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 17 ++++---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++--------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 ++---------------
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 ++--------------
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 33 +++++++++++++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |  3 ++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 39 ++--------------
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  4 +-
 .../dml/{dcn2x/dcn2x.c => dcn20/dcn20_fpu.c}  |  2 +-
 .../dml/{dcn2x/dcn2x.h => dcn20/dcn20_fpu.h}  |  6 +--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 10 ++++-
 25 files changed, 156 insertions(+), 164 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/dml/{dcn2x/dcn2x.c => dcn20/dcn20_fpu.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/dml/{dcn2x/dcn2x.h => dcn20/dcn20_fpu.h} (94%)

-- 
2.25.1

