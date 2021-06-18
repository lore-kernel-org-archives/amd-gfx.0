Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB6C48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA27613BA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA27613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45A16E03F;
	Fri, 18 Jun 2021 17:35:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADAB6E03F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLmX1yaRp6MrFLSy0/VZpEW1iAGC+hF5r8M/N5/0hWnPwVRFNYF3fE7kcIx9HxCr0YedYufXoqFu8dGnBociGgVW0klgeU9SZGFbtEiMCDRq9IbWdJn+U09xW1zk7+7db7iqxbjlGVzR19/jCFw6jP1PSY2YaSJKK3nHP/NukPGNdpW6ZwgFsw2fvWhUz+g6+f8f+zQPxhEqXMhI3fdcCd1BnZFIIOQK9rM0QlQAjPqr3hSp6wyt00lFjIiqqHlui2F2FZR4l8L1YRmsNcXvE5wJXnl1b2j4zYTsN3ViKmZjUvzQwgqEhWIBinJ1+Czs109mvthO3PJAhBTQSHwVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6Ztic1wmGMtPx6jdz7R4+8rZiOipm1qLadgADkqtsU=;
 b=hL4OlBXWu0M2xfG3/5bqLr5/w1WA2ampPyVq6CdLYqFQJe7dhalfQHL8mZBvIyMLiZflTPaY8Gz5JmlyjT8pfecrvOBMFFTdP2Fms5Xq8JoQ4Nwdh0qj8UaxNl+fkzFXBX9SZC2dg9O1nlMjiA3LS6q+TO4+zAYJ0e9dJiowHL6AtMzcG9DA90JvEa2BxhsnZZcCim50Bs6w61nsscP6aKs8Cx9RsR8kbjGSRhqJrjgMPT7mDhB1nA617RHiqEqSnF+yaBgSvOKXMt1kOPxiWf+i6EUQ5Z4VLUEzzEyZjDvLTBPpqzTYZ2qy9DpzP7Tl7odCMic2FyCxWRh99jyiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6Ztic1wmGMtPx6jdz7R4+8rZiOipm1qLadgADkqtsU=;
 b=Ns5vouEw42v/RlF7lHHE1wcsZjYNM5oB2V3YMqVtRA5z9GAflIqLzrtP0HxNs0cVCokfFScc5Yj3GMmH4YbM/FwqYjZK3NHDW+GNk/5/OfJBEiEkn++Qef2x8zAJbAntpTKYNX1/exZTy1V8AS1ZrFiAT6NonJzBZQyAp1vyypc=
Received: from BN6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:404:121::30)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 17:35:27 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::6a) by BN6PR18CA0020.outlook.office365.com
 (2603:10b6:404:121::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:26 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:25 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] June, 21, 2021
Date: Fri, 18 Jun 2021 13:35:02 -0400
Message-ID: <20210618173514.430647-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7bdf43d-93c8-4402-eccd-08d9327f762f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302E92D6FB253E5D6123DDFF50D9@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBR3U6fXo+1+T8WsDMQwZCx5S7jV6FFF8wfg9vDw6+/jnSlGjc4S+4QC+XrCUSwFBU0dfmM9G8xuH0dM6NUSU724ScbMmTEEwi8/BT+5Z52mfq+OZfzcs+likk2uUvFNiGWqLJBcn8d7QFJHeL0BWkIPyN5GfFFd/p1zVBh2H0weZi1D9buNcf5B51cpCjq1xK3TWmoHB2COwaS6AjsU9BA8+3utHRDmHYF6+HCeiwsZCNZAxsTLvyHSjmB3X7e1o2AIxrsJV9NVRD53hjXldiVgGSAm2OTbpvd22gI5vzBrCpdwgEIAqO1ltgQVbAkeEJo/Jzf4e06cQSn0tbRzX1ZluwaL5aKc9j6AGYTrs5kFhL7v48V+X5bKLrdL4d/lpPZ9+GglYgIw7W4rNQHC2joPhpwYtOYKR3hU/Chjbiklv5oNYZP9XXNT2np1ZQqcCfRZTzh5AgldrdjekTpChn+P9K+q/JMO4gACO0QeCFwAAw4xa99Lfvz0OLK30yF57V1fDW7+RocUtr060FYdAVF5OqjYzmNb9CvaHCfLYkXqlNGRvNNrkMSB1kBd/TqO2SwOm3whfXJEuy9WLFNY+g3B1N3t/LoDSEFEZGXOdB97k9Xwm1vIDVP6V56hSudw0d28nx9zmMEac8kQ3BPBTlp5jSTBSVv6IeRkUUPOeVccQ12D6iSN72RJpPvQY/7w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(81166007)(70586007)(36756003)(8936002)(70206006)(6916009)(54906003)(26005)(2906002)(8676002)(82310400003)(2616005)(82740400003)(86362001)(356005)(336012)(426003)(36860700001)(6666004)(83380400001)(47076005)(4326008)(1076003)(186003)(7696005)(5660300002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:27.4293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bdf43d-93c8-4402-eccd-08d9327f762f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC 3.2.141
* Firmware release 0.0.71
* Improvements across LTTPR, edp initialization, DML calculations,
  VBIOS for dcn302 and dcn303 etc.

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.71

Aric Cyr (2):
  drm/amd/display: Multiplane cursor position incorrect when plane
    rotated
  drm/amd/display: 3.2.141
  This version brings along following fixes:
	- FW release 0.0.71.
	- get socBB from VBIOS for dcn302 and dcn303.
	- refclk from MICROSECOND_TIME_BASE_DIV HW register.
	- Clear lane settings after LTTPRs have been trained.
	- Clamp VStartup value at DML calculations.

Aurabindo Pillai (1):
  drm/amd/display: get socBB from VBIOS for dcn302 and dcn303

Charlene Liu (1):
  drm/amd/display: get refclk from MICROSECOND_TIME_BASE_DIV HW register

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Martin Tsai (1):
  drm/amd/display: Clear lane settings after LTTPRs have been trained

Nikola Cornij (1):
  drm/amd/display: Clamp VStartup value at DML calculations time

Roman Li (1):
  drm/amd/display: Delay PSR entry

Stylon Wang (1):
  drm/amd/display: Revert "Guard ASSR with internal display flag"

Wesley Chalmers (1):
  drm/amd/display: Fix incorrect variable name

ollogush (1):
  drm/amd/display: Fix edp_bootup_bl_level initialization issue

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  3 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 66 +++++---------
 .../drm/amd/display/dc/core/dc_link_dpcd.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   | 13 ++-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.h   |  3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 15 +++-
 .../amd/display/dc/dcn302/dcn302_resource.c   | 20 +++++
 .../amd/display/dc/dcn303/dcn303_resource.c   | 20 +++++
 .../dc/dml/dcn31/display_mode_vba_31.c        |  4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 90 ++++++++++++++++++-
 15 files changed, 197 insertions(+), 57 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
