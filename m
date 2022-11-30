Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9906EC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17AE610E28F;
	Wed, 30 Nov 2022 06:39:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E0A10E291
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2LdBV0xz1fsF5QElWq3C0JPJvd7NOUJxgUqIlJtbnxEgajgRpZeb2gsg29djeFUU4jhUJ+O2zFpO6mgWY39Pp74KRfuGcrIbC9agqRYn5gvJCv/K1n10ocuMVfXtjW66upweGBnd9mj+qC1OJhJ/Ljowt2K7ThN7afBg3Xl5vsPvZx1z7abZtVpg4GXjGvnkPMzdoJEIoJle9sRXgIbH4V7TSvNuSeJkiEqFAczO4CcW2DQDyMKTaE/rQ5b8NSvt/723W78dkG+4v/aYBwNLTqgckpCHMmkPq+N8GfHNLzvZIjM5HQf7/2tc92Rwm9Pe/mwatN+o+RRImXrEzuCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n77xJ892JyTSnWqZ923eVhkK57qNgRC/rERrBcI8MPw=;
 b=UrW5x49CZjR7Mm68L0TcpPLidNyFiuRpfXwazU5qVPnwPtfKXbrPRQVXDsCm/eaKmcDScbRG1MpuiSWEuK8PIp00oYRSfiA60WN71U5L7OkKTIc/w4q4RGF5pv5WC2oqcku07bFosn4NftTlJ6cT6YnEvdgP+6tplRKPjTNa+F93UkckbZp5WRUr9JRG7/egVVWPt+Ijc05gcoBrlSrjANOGR5eG4kksofeAn+47jlBjtMmIUB1m4/0clM1LS7oK5mMwjQbDTgGUGVjIkGLrre/5ti0I/4nKMwdEYFkzNbzQfmfkCbK9VxBuC0D3eooI1+4tG6ZhzhRiJsRWq39ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n77xJ892JyTSnWqZ923eVhkK57qNgRC/rERrBcI8MPw=;
 b=mzrelhxVAZbmDEfwvnSi4Ti1HNDU0QiTK37LcVKFajJi01Qq3eQt/XxEdXy11GfOb7tb613JmOUZDfaWNhAzk3M1fPskCcDSk+Hs2Sp2i2afubpYvEzZCbX3dWSW6y4ffh55TcVXMgFpBlZro5vtm/XRR8X9XWVeh81SYa+7Ld4=
Received: from MW4PR02CA0004.namprd02.prod.outlook.com (2603:10b6:303:16d::19)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:35 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::84) by MW4PR02CA0004.outlook.office365.com
 (2603:10b6:303:16d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 06:39:34 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:14 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: prevent seamless boot on displays that
 don't have the preferred dig
Date: Wed, 30 Nov 2022 14:36:16 +0800
Message-ID: <20221130063627.2398341-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdc69ba-2d49-4328-2519-08dad29da534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Yb5t93STVrJCQjXOVpA5MZUeZmqEn5ZxhBOLCmrGNovbgqToTsYw7qMD8eIzwpsJcX0NWaBs2QICdahnM+AB/YAY9QBnORzAY+kRy01TqH/Mm78h20qx0lnF+sNaXQ8gN9sT1Ejy990kXml+MmXVRv1kelYhmr09HESRfbAtxBtnSGuzCsuTuCSPfIgn7DyhlXMpHcLDq03S64GAzSlDJIL6/H5+TXmRjkZVslgxeg6ffU/zbJj7cwSl5OsQQrXoyYCGl/tCjJB3ic9ppqedTivlusqns9Cb+g5cKsoPVOlSv9/XuXV4SriK1JTdO1c5A+Dzo5DQ5MgRiRFzZDiXlfaa4lCjlMxHHo6dmSTamzCdVTEwjfEciHEYUtUKp9/UtqHzJcZ52KetEP01ArzVhu9ep8iznzOAjW3HwfMNzDLArWrmxOYZ6eLa1JeERtHxOqHq/T72+F+iuVcGVVrTFrMCz63ntqITCkN+H7jZ0BJ4eKLJJcd01lrJjVBSIB2b7vCxOW/wgNZQBbTPmZD0bSzPBhWFU/tCDeaSxGLjXOmvk8x7RzR/Amu3hZiYQwgAsAYnTu9zOW8qpRISgo5wVRCtAKPwqJqtr6AqMsD0+Uw/LrBpe8kdA5PLrdy2pl7qc7TLsESp476P3SKX4p4G2tRKfBhaN7ETFDQGb18k4XUbb5XbOY/N4s1ZAtDBQaLTd2+jMbyGqjOFHGd+Fdu6jVY0wWsfMcv5LrU3HfHiy0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(478600001)(70586007)(7696005)(40480700001)(41300700001)(40460700003)(54906003)(82310400005)(2616005)(8676002)(336012)(1076003)(356005)(81166007)(4326008)(8936002)(36756003)(82740400003)(16526019)(26005)(5660300002)(86362001)(83380400001)(70206006)(186003)(316002)(44832011)(2906002)(47076005)(6916009)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:34.7984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdc69ba-2d49-4328-2519-08dad29da534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Seamless boot requires VBIOS to select dig matching to link order wise. A significant
amount of dal logic makes assumption we are using preferred dig for eDP and if this
isn't the case then seamless boot is not supported.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 87994ae0a397..486d18290b9f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1556,6 +1556,9 @@ bool dc_validate_boot_timing(const struct dc *dc,
 	if (tg_inst >= dc->res_pool->timing_generator_count)
 		return false;
 
+	if (tg_inst != link->link_enc->preferred_engine)
+		return false;
+
 	tg = dc->res_pool->timing_generators[tg_inst];
 
 	if (!tg->funcs->get_hw_timing)
-- 
2.25.1

