Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFC3ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D294910EB96;
	Sat, 27 Aug 2022 02:53:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5A210EB95
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ86ho2a4Z8bbGDwSq3zWmvvSCbXfTnvz6ucs1vCfGyNaiojBMJvJU/WDBvGD7t5iexCbjieZ8/jFOT6RRymPY1M98Sieq4giS8KyUFnll52oVuUZRrg4UgKHNV+b7zme4PkYp4kNbD/hl0p1jVqN2+zZxO0Hb+a/GGD50co1iKs8aZEs7bC2ygOW8Qzg9LEAfCeuGuJv4WRgwvMSMsWga0fjGqOjkn8HShjqSQzXEb8/99Z3OOn2jkaUnq5PpEE8k3EaDNB+6TYdmEDmMwvFPyRXTuNTVize61Kz4G5FUJN3ulELw4E4Syk3Xb88/LS1NRwe9gHZce0/v9VOudIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lvzzwBZde6ZU5ykBoxhQh3eKLZceVDLq0NbTpe0WyU=;
 b=DXTb7xrTx20b9Zo9TvyXLvm8IK6zz5wNEeqT/VrRH4WMPGeYRR5Xnp/0MVxOZ/ZrIQeGlevLfmICb8EVGq5KHvHz3cZwZcTwFbOA98aT9YyCS4ICQHWqipx4w4eWO6fK1NVelC3pKdcqG7o2f/V9iaaY/+5f8k/xlPi83Bh3aidA42xyHAccZ+agbxyVmbo+TLFwkoozDXdQcM0oG2BWhBz+WcRMupDNm/hbcnneMGHu7i15glCm/hc7CsBLNnc0+zSniGHnrHz0W40YhsQEgsVA/3IV4De7/FfaA52b+RUNlM2i6cycHjuzxSGMJZyLwePDGJBT+zNTCcyGVobuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lvzzwBZde6ZU5ykBoxhQh3eKLZceVDLq0NbTpe0WyU=;
 b=j8AHIzfvmvBEULY+CiIgwRHvDnZscCz7yZoJFocT1ldgZy2XZKZirT/f4NVGG17Qjwxw1OVp6UUEW3+tqoYUlHIdV4rqfqArPGZLqje6fxr1UGq6zbc9Vw3WqgShE9cDklr/pgCZrG0Lz/al7iIlhUwWRFzBR2FEJW6pjvNvAWg=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by MN2PR12MB3231.namprd12.prod.outlook.com (2603:10b6:208:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:53:04 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::60) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:58 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:54
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/33] drm/amd/display: Fix check for stream and plane
Date: Sat, 27 Aug 2022 06:50:51 +0800
Message-ID: <20220826225053.1435588-32-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea1dcca9-be2d-4ee4-2d8d-08da87d74068
X-MS-TrafficTypeDiagnostic: MN2PR12MB3231:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlcfFOb8vpteqF0PvG6ryO+HL3XTMPV+xc4KJrVu0ut11m30SzBX/J0NywS6MpLzm59RXlrnqfD2lZCyh76M3tk5iMoMZByn7iTwVxY7ZdyGezHWT13BXrnWyvx+29uQUsG2c1lnU5AuHBKSm/90uZPw9d+ThNCLLWdH7EEfQwTQUZs8HpImjeqEbB4w/oA8Vpcn0YhyIDljfp5y2Y1VvOVx2k43jbwNOP5+fx7Pmxu+aaiO73zzmbV6twQyh1We+5PIYRICWmj/AimTT1IqaOH50x2/SFR/4bhG8gZOB2Q/g4O/ZuZ5niNaa11dsDDtIPdSf1Ivjv/jFchA2OH2ieaNhhZzodlhSm2s2q6wE2fF39YBM7XJY64bcJDqtgZEzFgRApMFXZKsLYF9yU9oQW1kAiPLm+HqTmGAmCqt3NJjy0EfdRXEWN1u9Yz+MSvj73dRwAgQy21QAvzLmKq1R/jp3sOPuaTMMA5M8/E36z1rq48COwbMdu2fj3ednp/t62j9CIlCq6UisXjdZ7uRd0/emXaGxZLa0tr6QzHfQMxTmw6IIYU8cGKWWalp5JVJh0Fm0zg9FMVHdyG0yWrfoIdyzr0U+fF5yP3iW3OJKWvZhEMr6i4GfPCQcmMNgCJDIswLYfIZ5LNuBY7Sr0Qrq5ZY4Bzq6GKlGk/YJr3jSv8sxWpTt3PSxK4dHCCQrHaRtHFTGLyJan0qtDVJsFVJ9NE5KYnLxP4qRqXPFm2czl7NuW4rzQq27/TfRuTVL1DiMdp/EkwUXBAgKr+MiRNYQtdeYOG4Dooq7o+oUOlihKoG2yIJv5Ig+4rv72K/pSOe0opkLdqdN3o2KCkCvpNFPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(81166007)(82740400003)(356005)(36860700001)(40480700001)(83380400001)(316002)(54906003)(70586007)(70206006)(4326008)(7696005)(2616005)(6666004)(4744005)(8676002)(2906002)(478600001)(41300700001)(5660300002)(186003)(86362001)(8936002)(26005)(40460700003)(47076005)(6916009)(426003)(336012)(1076003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:59.3696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1dcca9-be2d-4ee4-2d8d-08da87d74068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3231
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>

[WHY]
Function wasn't returning false when it had a no stream

[HOW]
Made it return false when it had no stream.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 955f52e6064d..ab918fe38f6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -144,7 +144,7 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (!pipe->stream)
-			continue;
+			return false;
 
 		if (!pipe->plane_state)
 			return false;
-- 
2.25.1

