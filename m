Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615B9C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979A610E566;
	Fri,  9 Dec 2022 16:37:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA7C10E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLvfdQ05c3gNMxz6tiGoP+D6F1U0s7OJCE3uWyk5lP0d+wbtzfxtBQd8XezTqXKaryoOB0iADNxd6VNLwUm2ARmwXuTopJ1O5mLvqTIbGIC1AG8soQbZaJkY8shj7PYoeS6oqvAc4Gss42CBBdHiPzyYPt/GDMdTssn1YLAn/L1bYE9J3oQzNXsZBwH1+y7JQj9FvNpX5Jb2DMXlU28dszKlDjgheeWxVTq9QScNkMPErr8CgymqOA5ugDJnCPWEXJ7/pGLQoCAhQMBpBc8xA0IuIIAYJSIO6gTqvNf3Nto2stb9kM/gEmYkgk1XYTlVSgqsjcdZluTlWw9FddqWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXIxsPxjzXojtfNONZohPkPxrvL08Zpo+H4ZAradWec=;
 b=amPU8KVdLCnMwclr9wcP0ZK8c2xoA7i899lSOrwF6kDzbvnZ5ZWE7em/oBwy2cdIm5fZKrVfBjP4W26z2IAO9v89EhgH23HA2LNpeDxxEZUUcMBND/E3vKdbFbbMkD3fQl5Kr4hZR18JFDAhAmDW642pgn/sgsOPKh+PigkRi1M9fYYmxPFl0fBCwjTtbkQ6zhm/EIgPX5Z0Ew0dCqyRbmp5TzOopDqkV6TatI3Uldiog1yBfdyaF02Titg+34teYxciBSRMzbItM0SnID8UOfw3N9e7UwbamyO6b/cDgMwkAAYeAgpxGsM8Ks/fs9Rz7rgyGmOJYhPTjdlLW84v3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXIxsPxjzXojtfNONZohPkPxrvL08Zpo+H4ZAradWec=;
 b=dpvq71wRRMwyR6Mxo/yD3jTbzHmZNlxOW/5p+aRPJW1fc7BAGUrsCKBBo3crnIO+AOqV3khdl7r1IBpO6xn4rtQMyvWKglWIFpr4wKVDs5YGwjfXF7W6obvMucVEip97PxTzQIh09OZ9yDs8eJ7QeDUqKooWGZPm+zmOZ8F89Jo=
Received: from MW4PR04CA0382.namprd04.prod.outlook.com (2603:10b6:303:81::27)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:25 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::55) by MW4PR04CA0382.outlook.office365.com
 (2603:10b6:303:81::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:24 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:23 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/23] drm/amd/display: run subvp validation with supported
 vlevel
Date: Fri, 9 Dec 2022 11:36:32 -0500
Message-ID: <20221209163647.25704-9-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|CO6PR12MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: e70cd963-051c-4255-ddd1-08dada03a733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ugwCNB+2UALBfRNpuidu9f/BUEbol1BjUitVQIYakOdVN0aMPdVwxnhEc2hoqwEooU4ErutsdQaVhk8CMh+eP6NEgOL/YFpv4auVEg85MzSmCaUv4KdRPB0AU2Lqfjd8MnXHQlVUO8tmkf+9JxB/x3JOszUj0md3jaEc7dc46xJF7jdP4wHyfVb2QDm1aUTbY85HgpSsOAcltsUGatn79Qn1Gpoh/JD3tLHFZylWTvLtQDGcJOirf3IlbYFTTkRNr4SA7VizqOAs1AQou7FvzlSs1Wb5sNg7IM7O8d+Tq6ZF9krN4g/dsRE09d0lv43gXR6F7KxMciA1D0rWppSIVOo34ojvEWeaUL/43wLl3KdqRyWZPXcZVwKZgMKqFuAK3viJJW+qLbEViUqhREFq/ptDTEOlRj0A3bsw2FMKLAZES2oUUzbtjl3F8NFWJmSAhcXRD18uDKmoZloLwQvUZ9sFHGaZaQ0KHOvG/T0e8uZbGQ/C099h2e4NjjF3BRFhCtITAWpnYp1qmPD+Lb1/Ntt3gVJ1rU9r1jxbnrGpPAWLHVqxvbgmJLxDUAFkVdJV7/5qZYVboUdfIsgEqpyviubXVoOFKy520rKLRLLTZ713R7YRV3XpK0YBFNc/yC+VwrZNyoVGMqgq76z6sG+8dqkKUCEPgd2XoHt3sSGf2SwjA0EOCdRKPuiRztjeNd1rK2SY2sg0EY/yFsg5FPW/N+dm1Bgh5XpxnFuSx6DPIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(2906002)(40480700001)(40460700003)(336012)(70206006)(4326008)(8676002)(41300700001)(36756003)(70586007)(2616005)(82740400003)(316002)(356005)(26005)(6916009)(83380400001)(81166007)(82310400005)(186003)(5660300002)(426003)(47076005)(16526019)(1076003)(478600001)(8936002)(54906003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:24.9891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70cd963-051c-4255-ddd1-08dada03a733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY]
Subvp portion validation currently assumes that if vlevel provided does not
support pstate, then none will, and so subvp is not used.

[HOW]
After get vlevel, use lowest vlevel that supports pstate if it
exists, and use that for subvp validation.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a42ddb911e1d..ff5f3ef8be0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1169,6 +1169,16 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			pipes[0].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, *pipe_cnt, 0);
 			*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 
+			/* Check that vlevel requested supports pstate or not
+			 * if not, select the lowest vlevel that supports it
+			 */
+			for (i = *vlevel; i < context->bw_ctx.dml.soc.num_states; i++) {
+				if (vba->DRAMClockChangeSupport[i][vba->maxMpcComb] != dm_dram_clock_change_unsupported) {
+					*vlevel = i;
+					break;
+				}
+			}
+
 			if (*vlevel < context->bw_ctx.dml.soc.num_states &&
 			    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported
 			    && subvp_validate_static_schedulability(dc, context, *vlevel)) {
-- 
2.34.1

