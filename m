Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B3C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BA4206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="epPyWKol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BA4206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CE26EB49;
	Fri,  6 Nov 2020 23:18:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848A26EB49
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK7dK9OVlJr3aUie5w+OI686ph3kVCXPr4uz1j6OmAgZYdOy7IGwXqsgAfIOKCGaAI+vWv/ghlw6NmkRmjc+d08XMXBnq4Ds4msJkVmQb5firZqqi5RYGPjyorWGm5E2rcAiQEXWU4fOIfXH8+UFs5ZNrtjoH46FeTZneCrwHUwlDgoa1o19OGjap1oXOHq6ywgqWjSgLK3vEp0hpLjv6kIKIvXlXbBxx2nPduEi0ZtQxrhRaSDFoZfwCiKvlkQnjkWmW34Y28JLZdj7I7OVBsbyYgj3JQY9x4vvqKLL4AD0WZI1SvrMFFXqIivVaK13i7v50b9PnzdbwrT24Tx7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjK887AhgtiqCq59tRnmKlneK0SoxZdq23ni7CHMUjE=;
 b=XERpU/EzUL48UJjGxj5S2X6uQj/+LOmYO6zqLAOnWnJ5wXYXsBQZfd0IF2z00C7i8qncLfdj9F3cPDDnksIhCaBPSDRqpjd1pxVE/z3RI885dyFDIhzl8YXFkqRAJTeNlfreIgaM/IHjogk+hZ8xacEzecAairgX5nVvaqgZuhYYhynZh0nqdS9X7rlnEEfyBzs+Q+Lw89lcUsW8SABYitU0BY8J3MdkHD4zaYY4PXkuaKzdHThmYPFa9hgfzEcANL8uYixaBTwFqrZcf2VmUJN/B8ZYjM/5RU1scwPpxC1Njd+6BagzQUellMvwv9l2jKC/pBTWxifwTTNLZGFf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjK887AhgtiqCq59tRnmKlneK0SoxZdq23ni7CHMUjE=;
 b=epPyWKolAweTgGnXcl+qpJ6AEQq28zKhnf+/KXUtpWTaG5K3kls5sJ+yVkWJL4Dw/WdDL+aaMmccEcKigDyF/sn6uodKXtFByupFljTK7+xPhNwYRdKaBT5ceae5K4yJjDuAQHpm8BQSCWTEO8KDSlzOJ3o0ZK04nve2miVX2f8=
Received: from BN6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:404:5f::33)
 by BN8PR12MB4593.namprd12.prod.outlook.com (2603:10b6:408:aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 23:18:42 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:5f:cafe::5d) by BN6PR02CA0047.outlook.office365.com
 (2603:10b6:404:5f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 6 Nov 2020 23:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:18:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:18:42 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:18:41 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:18:40 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches 11 09,2020
Date: Fri, 6 Nov 2020 18:16:56 -0500
Message-ID: <20201106231710.1290392-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2112f745-a838-420a-cc5a-08d882aa4d39
X-MS-TrafficTypeDiagnostic: BN8PR12MB4593:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4593C8A1D1C93E229D29E6D5F5ED0@BN8PR12MB4593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdUrc2xIbTp6omNt+jh6qp1em08Ad8acEwwbr6hY9yc+JWWBDrnweBIgPlIj14fOgClC5m358wv0A07vR9M5Ei52k3HbnWIEs9Ac0skg74YOmdPIWpkgzcSLx9qWdrxNmpmamSLngBoT3YbwO2vZx+nePk23DSiFV1inN9rCezaiTK3qtSp4fV9IF35awy2IaZaRlnXYSfiRaKJHp61LEKZedVSn9nKQSYL/cFO6UUN24zqqdRyhrH24Abm4nK2FZ5gFyNQHcPTKEaP8+pwckQseCGf6RgNJaYLM+s+2CFdQTeJd6UPn+LJ2d5UUvcvkc2AYYhWZ8TcUrRT/CbEpEtpiQXncwGzdYVSk+zIQ9ZQlrcUx6QHulBtKbACr2KoIUu/vSVYlvGxyou1EaEVw9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966005)(82310400003)(2616005)(70206006)(47076004)(7696005)(8676002)(26005)(356005)(82740400003)(2906002)(6666004)(4326008)(83380400001)(54906003)(81166007)(336012)(6916009)(8936002)(36756003)(186003)(70586007)(478600001)(86362001)(1076003)(5660300002)(426003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:18:42.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2112f745-a838-420a-cc5a-08d882aa4d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4593
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Bindu R <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
Alvin Lee (1):
  drm/amd/display: Check other planes for iflip only if GSL already
    enabled

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.41

Aric Cyr (2):
  drm/amd/display: Only wait for flip pending on immediate flips
  drm/amd/display: 3.2.111

Dmytro Laktyushkin (1):
  drm/amd/display: correct dml dsc bpc assignment

Eric Bernstein (1):
  drm/amd/display: Move common speakersToChannels definition to
    hw_shared.h

Isabel Zhang (2):
  drm/amd/display: Add fallback to prefetch mode 1 if 0 fails
  drm/amd/display: Prevent freesync power optimization during validation

Jing Zhou (1):
  drm/amd/display: force use sRGB for video TF is sRGB or BT709

Krunoslav Kovac (1):
  drm/amd/display: Engage PSR synchronously

Victor Lu (1):
  drm/amd/display: Explicitly disable cursor when disabling CRTC

Yongqiang Sun (3):
  drm/amd/display: update dpp dto phase and modulo.
  drm/amd/display: check actual clock value.
  drm/amd/display: cap dpp dto phase not more than modulo.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   6 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   5 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  15 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |   8 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  18 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  19 +++
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  24 ++--
 .../amd/display/dc/dce/dce_stream_encoder.c   |  82 -----------
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 111 +++++++++------
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  82 -----------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  35 ++---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  23 ++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   8 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c | 129 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h |  36 +++++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  60 +++++---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h |  83 -----------
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  10 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   3 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
 .../dc/dml/dcn21/display_mode_vba_21.c        |   2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  84 ++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 36 files changed, 510 insertions(+), 386 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h

-- 
2.25.1

Thanks,
Bindu R
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
