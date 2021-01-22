Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B8BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C6D22EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C6D22EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E282B89D8D;
	Fri, 22 Jan 2021 20:07:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C03E89CF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMJTLHvnrR1kiJLJxwhX6VwJXvVemGSMex7h5hHdLJgorCoHs/cCzach1FVjubay2wVJESnlhfsS47Q0bhFBhd3GIpBb3/kK2WBX6Txu3XxMzpmvW7sPkFqZUQs/yWa5DJodjbLe/m0g2Zu3Myabt5RLdHcopWIM4/g6hVAt5ZAvxRPey48U7Uf10c2mAyKpHrsk1wrQNqvY3UZy6YHPofGNQpRnQ9IFY6Adj4GeMt8MiN329F0YFB5QBOLcH+HsFaI13eAXvcFaj0fNyYmcSD540rh5NXqg44Ufr1XU39dmzHoDPpGkBBexfHycgMCKiIrW++bedh1gBjYgSBhn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNBiZRrxmuOzmCkSZ5qG7GqDA39n6XaZmIsNy7tu+YQ=;
 b=BgaLCH1bguukOGm8cSYAu6I159v+Jaf2asSdAFzGHGhj8ch0ZLMguDLAn6pUoHCxpf21jsAexA3ue4y6mpUNAcAL1oLaqdQohpuvFAXyEEKp+W00Cx4TWDIrUCFUgxlqZZhylUEqWi65brTKmsa+85h/osRbI/5xXeXKiE6SyLWgDHV4e7p11lihd45I7Dh0FvjC3UaRIhuXFYN8fn4M4N4JW5nBdXLynYv6l9rteO3VbUm0Dio/BH00mwaDyYCYJsXNN030hUK1C75oEVs4pcr7XMaNeop4800qw2SXNPt2kDx3lwSYbje6/5UZdCXfOQdXFKvaPKEnGf8ommUqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNBiZRrxmuOzmCkSZ5qG7GqDA39n6XaZmIsNy7tu+YQ=;
 b=xbCyXOVP4iLZiWHyhuBCKYYlFM5ldv651fUYiPhkenXl62zqdf477+HNVP15KtR22hOLnDqsNB4TO9EHsjR/VHmzyteK5t4Q/lPzdfJj209hGZSTeMCudY4/alWryXRn03RKldcpyb+uc+LxLcPUraAy3t9SXqNYQYZZ/v5rGog=
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by BN6PR12MB1698.namprd12.prod.outlook.com (2603:10b6:404:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 22 Jan
 2021 20:07:00 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::2b) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:06:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:06:58 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:06:57 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:06:57 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches Jan 22, 2021
Date: Fri, 22 Jan 2021 15:06:40 -0500
Message-ID: <20210122200652.197934-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a93749f3-1ff1-4aaf-4fe0-08d8bf114688
X-MS-TrafficTypeDiagnostic: BN6PR12MB1698:
X-Microsoft-Antispam-PRVS: <BN6PR12MB169873D29924799E6FB5C19BEBA00@BN6PR12MB1698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VStZE2FnO62AQdBx52DGBy/CEZg6ZdYeiSe0/XJSDCyK7a/4nnZp3lr5maHEiMpL/WG850EL6xFogrt2VKZkb8U6Ikh+OBUlA6Z/YSKWY/VlWR6UKKHhf0S4raUD+31p9/RZeQeIjvmSKB8sfkpardTpHT8pvSH7TWpZ1WLi7+3hr9MkdpiRoTluXZaqBPn+tmn+yEd19hoSwCUbEME5uIIXFNXd6Hz9NxiPlEM4A98JUsHkQs/zeYEh8I/58ukIOt3U845zPn95aWbAFHIU+fQnXnkCYtYgF5Gxb13Qevo+VO4e++slHkgjVPhWnzC1PlmByU0AFe8qkUbHLxsLCQTp6JWiTqqE/mgarolxLMPJ/6Zm7xNFTi2Omd8eaW9HeqOlL7Z/hsHXsiNMKntPNOX57vdbWH81TiUl1Q0ae7MoQGHjIzOtqUtY5jFnyGRbQRbKYfPXdWk0Es9oYmV0icXgCajWn+hPjLJOMNU4eM7fDCoG8K4okSajeQKKvTid
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(26005)(316002)(70586007)(4326008)(186003)(2616005)(356005)(336012)(81166007)(1076003)(8676002)(83380400001)(70206006)(6666004)(6916009)(8936002)(82740400003)(478600001)(36756003)(5660300002)(47076005)(86362001)(82310400003)(426003)(7696005)(54906003)(2906002)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:06:58.9993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93749f3-1ff1-4aaf-4fe0-08d8bf114688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1698
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fix display detection on HDMI ComboPHY
* FiX PWL backlight calculations
* Drop SOC bounding box hookup
* Fix DPCD values
* Reverted a change that caused memory leak after sleep(S3) state
  on 4K HDMI displays

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.49
  drm/amd/display: fix calculation for the pwl backlight curve

Aric Cyr (1):
  drm/amd/display: 3.2.120

Bhawanpreet Lakha (1):
  drm/amd/display: reuse current context instead of recreating one

Brendan Steve Leder (1):
  drm/amd/display: initialize i2c speed if not initialized in
    dcnxxx__resource.c

George Shen (1):
  drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL

Lewis Huang (1):
  drm/amd/display: Set power gated default to true in seamless boot pipe

Michael Strauss (1):
  drm/amd/display: Add null pointer check to is_dig_enabled func

Nicholas Kazlauskas (1):
  drm/amd/display: Drop SOC bounding box hookup in DM/DC

Stylon Wang (1):
  drm/amd/display: revert "drm/amd/display: Fix EDID parsing after
    resume from suspend"

Sung Lee (1):
  drm/amd/display: Add more Clock Sources to DCN2.1

Wenjing Liu (1):
  drm/amd/display: correct some hdcp variable naming

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  30 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   7 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  32 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 111 ------------------
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  10 ++
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 107 +----------------
 .../amd/display/dc/dcn301/dcn301_resource.c   | 107 +----------------
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   7 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   4 +-
 .../amd/display/modules/power/power_helpers.c |   2 +-
 19 files changed, 80 insertions(+), 381 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
