Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8B1C33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24E52082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BX6EIgVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24E52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F226FC45;
	Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA396FC3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQLI3uJAy5u1gs4uR8wjNFJjjn2p9HjuKn9lifgNNPD+rKCzf0+4pRvnhiTrPfTlIQdygjEhWu1rIjd9N4bFMHP0JD3Q5t4xoSmUbsBHgGJN8mQdmg6ZkvMrBvf4VnBT/ZQAurhsquoA2EcpMp5qcRxZuZvI90Ox8J58tzljxR/20ckuMokCpIwf+/FB67oE+ow4JdU+zyv6e398plsPUZ0SbDbTZhO4LysYnKMXFRoyyg/saGixTL4zc0QfZTDarUKRiMKxYJq/esY/1btddFLxucFNwsdUKSicoOosiXeXrOW5Wx5nmF4eksc43oIxurAoYDnw8TpgUXkK6GVrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stjaFa/fCccmhpYszs2udS4iclTd75z0ltTylwnmuKs=;
 b=HFUqW09N5SEdq4DRbEbQ+DQAvLdv+IdGmJM/QNVRlg0T4M/khUgFOiGwFaSzjyUina7Hf6FL0tUiJHuDONaqwShN9cMI9SfKYOUS5sj/XfYQUUue+4QFGrxU0XPh/VyM5gDwf/41yccdWQ31KdAaocZA5JkPgxqFZ3T5dmgK+S5gQ4jfHFLhCya0f7aHNdGRQjokmOMPrhU6c0m+IanYBE28lYCIOIqX1JG2N2E+Badxm4KX5jQ6V9garMWdaNikcg98tBrEg2Jx6e33OPCzu464QGv38sBdYOqLh29DW6TbxEm9aSraWLHztkI/+7nAVPXoTOpgYdlc6mA22bSoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stjaFa/fCccmhpYszs2udS4iclTd75z0ltTylwnmuKs=;
 b=BX6EIgVtss1Iwv6wX1Ut9WHyl0HCEbcWDS668a0OuDfs58YnnpAiXkuSVFO0zzIkSEF55kdNqjgb22eXPbVt+kHaBD0qMspw3c8zVSIGA+K+MuIwJ8DjS6e4LM4ocDdd5EoEU+lvXOsbCW30YIHBLESWV/T76I8RZu/vLcQTk+E=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by MN2PR12MB3342.namprd12.prod.outlook.com (2603:10b6:208:c3::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Fri, 31 Jan
 2020 22:17:16 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:12 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:12 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/33] drm/amd/display: Limit minimum DPPCLK to 100MHz.
Date: Fri, 31 Jan 2020 17:16:36 -0500
Message-ID: <20200131221643.10035-27-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(428003)(189003)(199004)(6666004)(426003)(478600001)(70206006)(70586007)(356004)(316002)(6916009)(54906003)(336012)(186003)(26005)(2906002)(7696005)(86362001)(8936002)(36756003)(4326008)(81166006)(8676002)(2616005)(81156014)(1076003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3342; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 516f181f-2aac-4b64-1e68-08d7a69b5467
X-MS-TrafficTypeDiagnostic: MN2PR12MB3342:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33424181856F5F8DDEB6DEDEF9070@MN2PR12MB3342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsCtegY9MdWq9YRt+6qe6bY3otIoYn3nrNfbYhtgTXBrjX/NuxYwg23TKkKT1S+hNumkFHrNlTaHkHVBtDiP11UUWzJeHJV3ibh042v6MFSX45TVikb7LJX9V4dhbIQBIgXjCEi7e8PVyJAUgPv19DrFBbIbHn/AIrKQsjpwsfpg2XKWnk0TClimliSvF3+2UhrDH04y5m/CAGr0VmNVbxSx7ktKXc0G5KlRNZ4ySBzppFtQme1oKIPJWaFB7TaMhlnBl0qcpTmU/fJ8DWTXl3IY7oPJb2E0i27Lj8jWlc6hpJkyujAzqrVE8oD66fpyyF7dhkJDlHgJcl6+Nn1Qtoyl1CyNBSQz0VMChQ+x/y0Bckn1HsUy9Dq1INnboWjBenMdR1E8aPMy8VXCrQa7e8KH+6V3dQZERuW5JByKZmx6qQKUNYuCHeTZHSoBnCse
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:16.1970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516f181f-2aac-4b64-1e68-08d7a69b5467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
Underflow is observed when plug in a 4K@60 monitor with
1366x768 eDP due to DPPCLK is too low.

[How]
Limit minimum DPPCLK to 100MHz.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 8ecb98c29eb9..5d82ec1f1ce5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -151,6 +151,12 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 		rn_vbios_smu_set_min_deep_sleep_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz);
 	}
 
+	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+		if (new_clocks->dppclk_khz < 100000)
+			new_clocks->dppclk_khz = 100000;
+	}
+
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
