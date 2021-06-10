Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A4FC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99C6611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99C6611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1416ED99;
	Thu, 10 Jun 2021 16:29:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D1A6ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiBUlxbRG8AIOFBuP8vimfZf2F7O2/YrRLFP4skIcUqZaJ0SYDuD0mCxWuCc0aL5WIWo6hm9/3xP809NaDRzwvHQq0AdOFSIjaQ5VUumjNlEwv7kmEnWPXHdiTh4bCE4R+Er7lUlzW65g3dxKfapWqBNyCGfmAY4frHdnosINyd15xlDYkD7u4cP9bAcASHhp9dgcn1hUCVhuJzkVN6cETLpjltpZmdA76iD3cmWVXFWbJJlOklixk4A3xBwJ2x9GT856DtMRQ6a5Q6DEOT9WE+VhlB8wiQEHGaoxhkqzVOO8A7q9B93QrDqdHsc5Hg73DWfHjJXvl6Yv7Zu74wbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eim2zMxQr5TLteuaHHlAi6VPcBgCL1cuaQ0SYFqqKA=;
 b=LgJxRF+Ln1srVNjHx+VAXl0aMepIGPg+g1Kgo3/jf7Pb+X0QSybAp0XIjyZf4zPJ1gB1L4xTlaR8Uj82hEoTZ+O7t22ina3Z/cbFe+0GxqT9ldaaFhoLKLWIa9I58Zdh6vGqoOTvIA/XyVbm6GAIsKp+1yOye/MYX2iGYlQ4PWR9hC0ZaXMAtP352SnhoR1crVdpOv//pUTCCPaZu9TIg49qCm4XHUfvZftibHmjYX+xQx52tY8gZ9TNJ3+b6fw7KnRmcKEHjK+TyMS0iY93clNPvQsd5PzbfnsOQlOyOfnLz3Lv8UWExivbItYhYSwhepf63Fq8SmwsDohRhupWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eim2zMxQr5TLteuaHHlAi6VPcBgCL1cuaQ0SYFqqKA=;
 b=gnDalBmzC3ffQVxqv/LaADji26IMjjUSpTZLUqbPzosDP0AJs87GqmoPbyOqR7xpAAHy+1nT/cuQZ/rK8kGwYjh9q8DP9dfI2KvXP6Hrz0FtiMMIy9NHehisn2iVvKjPu4H/XjJQ4TKFHuH9csHDgmCIE/2slmRxgH3yhZ5dLtE=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by MW2PR12MB2491.namprd12.prod.outlook.com (2603:10b6:907:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 16:29:34 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::2f) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:30 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:29 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/24] drm/amd/display: Set LTTPR Transparent Mode after read
 link cap
Date: Thu, 10 Jun 2021 12:28:28 -0400
Message-ID: <20210610162838.287723-15-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 572e8599-7c80-4694-3796-08d92c2cee89
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491A58C20645C1C03C4C93FEB359@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3+p+ESVkvpyD4I5RWnuOMpNEtEE5Whuk0HwWT9l+iYtFQs8C8RSrYXWNm0coO0lXQ7z6k905/jSN/qp7fJ6vhM39Ia9rh+StuS7/MT9FLCTjUYfDpMeswJyBcdF1/li7jEMMwahVGzrGPq4M8cl8iyC/8iXs82Ymu6WGJXlzFocCH616i0YIHwbzjZJpn7DJBJXa152qc93xRjMU2z0O0WGqouDn2XpZWoY4vG67bE1UHBnafXbB7WuTCh/lgQAsX8rshBdRZWwNH8OVwYsOidrPwMgqXsgEVoglhi0D9vAyK9N37ZdqA1TDcnm6MK7rFXTAro2JbqID1WfcyRkiBcNgfkH/P7BcFkqyOQoJ4L+oIQ+YT3ZAVVigpUSFbl+jZVh3fsqcoT63QIH2RkafqQxQLmLIG2szAop9sYx6MLozh99If8R41AkxUOzZamiBYaN9h9gNGscJGLvmildOe136HTCe+Hw7YUEaSysJbRdCw8P9CY+3oLw6+OQFqxiSipe+aJMyWYsYfTbQ6MbtqBdgn+hwksYLhonx7/xjFfZDGGS/zY4bevSJoK/hAYFfrcR7pvvz3IwhSV4yrVjsXAhdUcdWNE89TePcsb8Jdzxh0xMs+yBUYQ3/lxxUrnpJ062jOCwqX1tfR6LQmYQg/a+5fFWj/aqDnqHb2kSw6du5QImz1rTZ+j2XzX0105n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(47076005)(4326008)(83380400001)(186003)(5660300002)(316002)(426003)(26005)(356005)(6916009)(86362001)(478600001)(70206006)(36860700001)(2906002)(8936002)(82740400003)(82310400003)(36756003)(2616005)(7696005)(336012)(70586007)(8676002)(81166007)(54906003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:34.0240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e8599-7c80-4694-3796-08d92c2cee89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
SCR for DP 2.0 Spec states that a DPTX shall put LTTPRs into Transparent
mode after reading LTTPR Capability registers on HPD.

The wording of the SCR is somewhat ambiguous as to whether
Transparent mode must be set explicity, or is implicitly set on LTTPR
capability read. Explicitly setting Transparent mode after LTTPR
capability read should cover all
cases.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 38fabaff51ea..586f05a6cd77 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3705,9 +3705,10 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
 				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
-		if (is_lttpr_present)
+		if (is_lttpr_present) {
 			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
-		else
+			configure_lttpr_mode_transparent(link);
+		} else
 			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 	}
 	return is_lttpr_present;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
