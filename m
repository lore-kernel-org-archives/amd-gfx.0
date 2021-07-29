Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5300C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A426054E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90A426054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A586EE46;
	Thu, 29 Jul 2021 20:34:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19186EE46
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tbk6SGvyX4HiYsMK+DJB5cpJYzGgpUVpNL0vKgKeVJrzhol3UyBhGFxuUDacwcqJRWam//NN7uBZsj3sxyHJgiVBBkCTuftb1veXvf8PvCZVVld5GdlptbwUIPcVNcwAGh4SN/lRUjlMVGY72LBh8nnVs0KLz+Jpyf7Ur/C5t70UcRY9qS8JQ4ptuKvQEtZ/eCzk+bBA1NyplusM9yyZ/eXdAUHW4oIvVnjxprf5Zlepair0Jjezx8X2fPqC6FYIw8OTVNZu0WwlkGM2T5CcuubZBAr6xXv7gBDo+0/A4Yx+cMb2Ujyl91sFHOB4uoDcn/z0NySkIOypfKQeK/oFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV5/wWO9xRtxS5CNkV1IoxJNuCchcchBzSqJSjR+83E=;
 b=PZF3OUW8XnaWKwQvdX9xU/MkrfoaDBmXkgPySusGD/BtbTgedD4K/DGzNjYrDxaH0VuFyyEAcCX40jLJbccq333pc/NVn8JZ/7U26BDwvTwmUUiwdmb7uVVG2RAUZMxg4fQxvChFHLtGQfXN5VI6XNX7QRBVx2sL4wp1PZbgtsjAhMuBoqCcu6yCYFYMopRNVL+e+xf0DtiBdFfoXkPE1WatYLBuleVCf6D+Yb4EyDjCf5Rgg0eMTs76fEf/KqgTh3jdeegVdkL6V+UYLqoZZOv3xm3BYyFSxZkyb80nTcOV6G9QmNmAEXx8QW1Ih3uzph5eAXt2ob1YKiQ8g0jBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV5/wWO9xRtxS5CNkV1IoxJNuCchcchBzSqJSjR+83E=;
 b=Otls3/7z8y7J+SjoH6B8FWj12cQ64fouiUlkAovRmJDeX/OcPbSNSWwgogHGRj4qKUiSPv7o5yO8+xehGWdwfjqlPRmpHDTU/1zJLtXIdeUoLpXuf5wDD+/hoOxGhA9h1ZilDnzXCZ8bXr/k0t+pna+QnQMwUwYPb/iTU08MYNE=
Received: from DS7PR03CA0147.namprd03.prod.outlook.com (2603:10b6:5:3b4::32)
 by CH2PR12MB5545.namprd12.prod.outlook.com (2603:10b6:610:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 20:33:59 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::43) by DS7PR03CA0147.outlook.office365.com
 (2603:10b6:5:3b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Thu, 29 Jul 2021 20:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:33:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:33:58 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:33:57 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] DC Patches for Aug 2, 2021
Date: Thu, 29 Jul 2021 16:33:48 -0400
Message-ID: <20210729203357.1562846-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce5ae47-551c-4f06-b672-08d952d0319d
X-MS-TrafficTypeDiagnostic: CH2PR12MB5545:
X-Microsoft-Antispam-PRVS: <CH2PR12MB55456B96CDF468FD882BE6668BEB9@CH2PR12MB5545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1Y8I+ok4g7ii1ppWAo8NaKjnZ0tj1bXL8vwSyltSkCbl8o1NXSNIu1km0gIOjcRYliX2PZu9LLm4BBXL4ljwKutb8rkO02gA51O7JNgPTgqN+Xrm2Iqtx+/+eTWKFD0ubm3fS/QPC7pV01+cqYUhpuD/vbTWAhKJwYZ2uThIKBLWPhDxe660c+mVJUo/QYXiEYZ7yCjkhMIatjoKtElhgCVD7s2hhpFFhqXDd9IiJ3L7n+CDYnlRF9q9PpBU5whDOfDY/IL/UWvehyPlmMq0/Ff4iLF/Jg9oEFyHY5v0BxQM6FC3hABZJWmMyCL1ROF0D5xNkCjJiBE2E32aMLQ/oe9rsj29TR39MYtwXMkIl5Vvm0ZQT7L08elPPtZE2oUz+P0oKhj2Cs5+ZtqVAT0xYec+dQG/EoJSmLKc2oPWZl296keWKj9jaK1bzeAT8XOnbatDBgxJXp9cTjhxPqHZxHRj4/XIXtQgONPW97v69XrGa0dOJMaAxo4EAJxZ6HiIpaoA25LHZkhFSjpdd269OE78YBOOG8WIiGnpRtMrs/YPkznyay2oZjMCmy7ON+wKmF1YIMrONkO3T8jcjvj+62GeRVpJ9Y+BZjvhV8QLYQswtLisPqDbH7skOOUiNRB+7uueKIItHPNoOzf+p3YFlVEqRD4YNcl4+AwqSEYadphyjsun0VCH4CSqcEpTqQa84l4VC6u1FS6E3mHvC6MxqL3wrEJlJObHmTOpje2mNY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39840400004)(136003)(346002)(46966006)(36840700001)(36756003)(356005)(47076005)(2906002)(54906003)(82310400003)(6666004)(26005)(186003)(478600001)(8676002)(7696005)(8936002)(1076003)(336012)(316002)(81166007)(83380400001)(2616005)(4326008)(426003)(70586007)(6916009)(44832011)(5660300002)(70206006)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:33:58.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce5ae47-551c-4f06-b672-08d952d0319d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5545
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

Its a small set of changes this week for DC. In summary, we have:

* DC version 3.2.147
* LTTPR, MPO Improvements
* General stability and bug fixes

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.77

Aric Cyr (1):
  drm/amd/display: 3.2.147

Guo, Bing (2):
  drm/amd/display: Fix Dynamic bpp issue with 8K30 with Navi 1X
  drm/amd/display: Increase stutter watermark for dcn303

Jaehyun Chung (1):
  drm/amd/display: Add check for validating unsupported ODM plus MPO
    case

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
