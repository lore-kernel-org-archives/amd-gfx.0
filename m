Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F15C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2325A604D7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2325A604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E001C6E117;
	Thu, 29 Jul 2021 20:06:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18016E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1L/N3V9i76GK6kFsmIkh8bja8L0NS6iRmeCAsNV6ihlxlDrGmmVi71328YrPkDov8xphY6149ikrGwQp0z1swvdwSbvEurEfnVFsJLZNYzMOwGGvmhCyhubXA3pT02nhSgNxtvU9cagGRDSB9VSZRX0xa8LP2aIlT1t8oSaOiw2EvOLqQlfFDU+9fpRZsraihGXV6+DCjaocrq/E6XLZzKzmDlODbuNgKFbPB4gM3wSC9yXq0gbWUwJ6x2XnJ7JKl1cUMT5CGlK73g+N5kAAK8fbKpHzPc7CYCQZOg1LB+4bVWcMN3rJWwqQ4jzhG05K06cX2JaeU1wQTyRUMGkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8o7h5Cvtw46OmLGMGslFfGMLzGDKEvCj3Oisf9Jc3Y=;
 b=f4kTj/C5NLYmb62U+ufmPvh8ZN7aRsP4w+y3YZDd+jOCi6S01SPQziI5HkPPLG95LUpy91j8RKwadIUXM4NPZ6m8g3Z7IwnShzPXn67VT/fpF23g0WW2CT6PxSaNAfGzUEcJyqAJQRSqBZvhb5DEx+K923LE34/De4828sshPDHWq90j4RU136LZjNcK+13m24dbxq3HQAzkpnJNClKHbvpJKwh9zkbcB6s2P1XUiSuTwP61zI+lqaigG4yOGCnzowJrs8+VFnXe2//42yNBX4dEQCJhthuUudL+/6FaUMPkhQMWxHia45vOqPpYyzjkg2eDP/jVml3SSccMm8InQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8o7h5Cvtw46OmLGMGslFfGMLzGDKEvCj3Oisf9Jc3Y=;
 b=JhRDhLQ3UjtUqepuW8o5YJ5vrJs2SlbqSitGzfv6wMBFeUyQnq9PrNTQRfPl/wso/DlN7YJb4lgR6jiTU0FLW6CYPwvCz+ac+yBlQgktHrnnZUVP+ci3vSUhDMXE3vN/2eOnIRNpuIno8MCXMJ23Vq3RaNUWatvfBSQZ4jusg6k=
Received: from DM5PR06CA0025.namprd06.prod.outlook.com (2603:10b6:3:5d::11) by
 MN2PR12MB3197.namprd12.prod.outlook.com (2603:10b6:208:107::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 20:06:30 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::3e) by DM5PR06CA0025.outlook.office365.com
 (2603:10b6:3:5d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 20:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:06:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:06:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:06:29 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:06:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] DC Patches for August 2, 2021
Date: Thu, 29 Jul 2021 16:06:19 -0400
Message-ID: <20210729200628.1546438-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f71b7d-3698-4341-b6c4-08d952cc5b03
X-MS-TrafficTypeDiagnostic: MN2PR12MB3197:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31972B01668B070A3F81849C8BEB9@MN2PR12MB3197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUcL5APIZZRoOE3WnovNwn2d0XFZJ1FwtkMV3n/xvXQh7Rgsi7WY3sFFDfso1etI5OXbocACLQGL1LZLdMzsJAh5lMsgPZG3yuBN7jNk97gRrlqg8HntVjjdFz2OpG8rt4xAOQ5n3j28Ldh/2/sOG4Gz6tNRNARGEcjr98M5OvjAIuez7BP7vF80cBc5KG3yCWwPKjUCMMi0wR3OpFix2Jpl9TkiyfyiTU3YlwW68QMFUqEdLI4CgowDG8rZlgZy9XCeYTKr/1pYslxCDY7vLjaulLuq9RaEK205mcRk8ioY16V37cGKjP6V16xcJWDBogUjyLM4ljE/the912QTn+IH8cl1ax3X6beW/MLY/SucOP22Kj3Lt5ptgoOECjBU7svxSYbvvZV1foM0Mi5EnOw/jEu03OfmgMDjkTP/lRB/v1hjbD3+WiNP9DEeLDofCSUG8oGpo4jpB0Jt7KeAcdRW+OBIHltC+Wc5TynhtJ1qUILg7GFCTLXHjCj6dh4n0AgThjFE2pNz0IgZqZ5rRmQ2t1USGL7DWRIMHYbADvUlYVW9Np/guc4EnkhzL2pLss2jOwoIB6kTFhYJ1Jt/AOF2bPlX2ID1pEmqbzb2NusvjIp2GjmQvgicRaS9M48ajBC0gded9lIbng4VvOs3q8+2Ae8LalkDk17FRHAaYDppztlysuWZfCbGDPHRrHjU61O6l1I1rN0Lk9F/CDZt/PQ/EW6a0BP9VaMtWFc9O88=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(7696005)(8676002)(6666004)(4326008)(356005)(83380400001)(26005)(36860700001)(36756003)(2616005)(1076003)(6916009)(336012)(70206006)(54906003)(70586007)(44832011)(47076005)(82310400003)(2906002)(82740400003)(478600001)(316002)(8936002)(426003)(86362001)(81166007)(186003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:06:30.2372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f71b7d-3698-4341-b6c4-08d952cc5b03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3197
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

* DC version 3.2.147
* DMUB FW release 0.0.77
* LTTPR, MPO improvements
* General bug fixes and stability improvements

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.77

Aric Cyr (1):
  drm/amd/display: 3.2.147

Chung (1):
  drm/amd/display: Add check for validating unsupported ODM plus MPO
    case

Guo, Bing (2):
  drm/amd/display: Fix Dynamic bpp issue with 8K30 with Navi 1X
  drm/amd/display: Increase stutter watermark for dcn303

Jude Shih (1):
  drm/amd/display: Fix resetting DCN3.1 HW when resuming from S4

Qingqing Zhuo (1):
  drm/amd/display: workaround for hard hang on HPD on native DP

Roman Li (1):
  drm/amd/display: Remove redundant vblank workqueues in DM

Wesley Chalmers (1):
  drm/amd/display: Assume LTTPR interop for DCN31+

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++-----
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  4 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 21 ++-----------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 20 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c   |  4 ++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 16 ++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 ++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  8 ++++---
 11 files changed, 61 insertions(+), 35 deletions(-)

-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
