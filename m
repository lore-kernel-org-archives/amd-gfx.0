Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04053C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A4961425
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A4961425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E8E6EA76;
	Fri, 23 Apr 2021 02:39:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673DD6EA76
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnO/Gu/npbFhdixn49n5M4135dZSDO3YuTk533i9eSvATgyxOYAkCJN0mcotwIqySZcPo3twKhksx27ij1zTogDb1L+r5BFS1/m5FI4qe/2mxCdfkJV33o/HOQFE4LFcwernOaA1gI0+9QZTi4cQ/rl6UISI/PjJclpDRCWWHw1vjuv91dTA5YpwrdMeCtERHOTltcvwHCLzap8VLKEmF6PDWd3AwEWVqm7k4fG3bB3P9S6JPcE4snU/rQgyIKuRL1ryGLx0I7WPDw9xryuMhaIhW8DJsWE/U69n2GJLRvdCurXP4BNZqgi+VMJUd/u9/atyWONzlgirql85dAZlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOyD2mTdJxKqTCeRs6ZShxvgHjyfqoQhWMKvPmwdrYw=;
 b=m2YdC/F3tQGINNXh/+yTdvA8YF12F7c5VkRyovr75Y9XRd4ohGOmof+ksrJwA688j8dVg+WRSCOBZtLPLJY6M4QlCFfOZbHusFNxTNALgTZ64Q1QYuvO7Wahw3QnvHOlAE+FbrB2jkBxcQPaR1bW5BpdNLkzawidhcuR+akL+yKrq7cPUZxX5mEiVoxCAkx2ZsFvTVr/OG7giXwBxtPeflC36YNEHt+jmqcAz5t8jkLGi0iJ3kocfvYA6QY8Y2tSiFinsF5KxhAenwl2PaCRd8J+1mVmcwfmE6pId2UKYpOiTlyUyit6j19LlshpjN1b86AsWu0rhupdz7PF1LObDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOyD2mTdJxKqTCeRs6ZShxvgHjyfqoQhWMKvPmwdrYw=;
 b=H8ZQGKRyyfMEPZf/VEPMebbiTQ07o6cDSwU73wNxOnxOPg4QyfzS2Wj+gGT7sh6NQ50S41pdIAkWJMeZB1jT9SrvqJrOF2qrDXb+NEqykGTENP+tE8VzdD3Ts8ShQ6jGf27s/q4DRw6eRPSO9DWhkkUz7lgWNvJ/vNmv2tSE1hM=
Received: from MWHPR1601CA0010.namprd16.prod.outlook.com
 (2603:10b6:300:da::20) by DM5PR12MB2536.namprd12.prod.outlook.com
 (2603:10b6:4:b3::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 02:39:46 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::a4) by MWHPR1601CA0010.outlook.office365.com
 (2603:10b6:300:da::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 02:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:39:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:39:45 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:39:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Add new case to get spread spectrum
 info
Date: Fri, 23 Apr 2021 10:36:59 +0800
Message-ID: <20210423023714.22044-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 717a52db-fef5-4150-9723-08d906010ee9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2536:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2536798F18460D8B8AC92942FC459@DM5PR12MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roTGn/JJ03z25YBDbxjy8ZYLvH41UcSShVXhDCX2Qpb5uig5l4b8KeIYUkQDQMweNOTPkWru7ggew9+sgyLCbhawxIGwf2Iv8FWFqbgIjBJWZq5nDpptwwYUJMzugvyYtjNdGj6HFUkF6vOPjvpSmgze5v1GXkV1vFdLZYukMUj4NkUvnQMKboHb1jP2z0E3H+x0WEEduscS4OukvZL+bdRVkeoNXZRFho0t6ARuM1i2JIrgpRG927uW3Cap6NNnK/V8dFzZqYJ4YBXMfD0l6DXmQGWZUoSS4D3KCmjjQwJGobJhAKsgullA7mBMTir98rO1pNKCjE9N9PpFLdL+N9sRTjt4euGWvnZC62XA2Mf0rSbBafWnlY06R0Gdh16hB+/FYaL7c2eUioTSYdyT5jvyUYLnmCw+LtbCR9FxxFVB+EUNEYszGCPkboMyBrfybD0waDdh93krRPT4QYnQ394St7QE9Iek4r66TDyVBK9gZIndx0f33BnhupGLxS2EqUiGtgIN2ALX8zXwbB2iKVbsIgPIM3zfW0cdHWfJ51osC5PbrVSNwI6dfW9eni5Np24PQmb4L4i2ni2sLNkUT6ZRaA0iJeQO9DpBidv6F9Srd9XDBoCETVYfUdW5lyqBn6lxr06Bzj4c12nj2CFFV+A090a1C7o782Y4drX4G+m5eg6JW7tgKnIUDCjDk7SB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(6666004)(426003)(186003)(70586007)(36756003)(316002)(26005)(81166007)(4326008)(86362001)(82740400003)(2906002)(2616005)(70206006)(336012)(1076003)(36860700001)(47076005)(356005)(54906003)(8936002)(5660300002)(82310400003)(4744005)(7696005)(8676002)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:39:46.2880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717a52db-fef5-4150-9723-08d906010ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
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
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
New minor revision needs to be handled

[HOW]
Add switch case and assert to catch missing switch cases in the future

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index d79f4fe06c47..49126a0f66af 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -836,8 +836,10 @@ static enum bp_result bios_parser_get_spread_spectrum_info(
 			return get_ss_info_v4_1(bp, signal, index, ss_info);
 		case 2:
 		case 3:
+		case 4:
 			return get_ss_info_v4_2(bp, signal, index, ss_info);
 		default:
+			ASSERT(0);
 			break;
 		}
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
