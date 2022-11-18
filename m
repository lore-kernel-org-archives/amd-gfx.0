Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C924EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 01:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B7310E6D6;
	Fri, 18 Nov 2022 01:06:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B12710E6E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 01:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W51f+XUaaGBhvm31zGlV5Qle3lemCHKNTnhyqs+I3tG4rLvUS9o7fUXG2QCIP1iwuD2ISWH53r049ZezunvJ8MPJiRmDhJAtJXWqIqrf+v7NTzXfNJc1gZ7DSA5I2NKlb5E8gvpcI7HlekCdYA6O9beokpl1Lvdvyaq6vyisp1YPBIlK8JUB6su3ynXDc/p9P8bjKrK6QQydfXVsYzsudhJnI/J9yYZpN9Q+syBSM9MUqG/sr6fHQiwmysozQA8MJqvQXNOsC9R75A/z18WgTAvalQS6gu1GhnJNkmDglzsr0IiGWMZApIDfTxNetPGZf2e7xRz9QG/aZ7oVPeA0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blCrxKE17osDshlmAIjte5TLZIuFowgS4/HBNUTZeqM=;
 b=UxAeznrM1ZogN8s+BwFWWSEilDh2Vlyt5dXi9mwIkYOfrvt6KoBMm+4vOi/QSTiW0sEhzipWAfTkqMzUEwjve8dYqH7Ghf3UsCYI0cc+wBrB2OmL6S3wtBW47jKz2KVroz1PvV6mgmoaQbWixzXYwrfleIUVDeBnuMeyVzlER9CqpqPvxNmP5FT++yZ1OV9pqeh0Dlyia+/n339lFfa7dr8ziG8vuw7rnansJBxvTvBO1F+s+VxC3xLcPQQdx4MYUIRh8IPmRN3zLoHRMktjvo0xqNwCCiTkUNuea5WVh3r7KLteqAEFy/2w/wnlnZ+L9sciCfLP0DMHEYL7pFryag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blCrxKE17osDshlmAIjte5TLZIuFowgS4/HBNUTZeqM=;
 b=Il/O6M0ZSias5m9p3yKMPxYogW1F4FwqGQWh3JmgBtqi3wrWt/nmqJxPAOHnl9njzE2z7HMQHo0UL3bSh/FY21B4BDOWdTvfhB6rlog5YUNVpRh0OJs30n28SmRBqOdnotCuyO1IZFWsj8z1xTpVNoykU5moyfXFyhchSw5mewA=
Received: from BN0PR04CA0190.namprd04.prod.outlook.com (2603:10b6:408:e9::15)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 01:06:42 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::79) by BN0PR04CA0190.outlook.office365.com
 (2603:10b6:408:e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 01:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 01:06:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 19:06:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 17:06:06 -0800
Received: from bob-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 17 Nov 2022 19:06:05 -0600
From: bobzhou <bobzhou2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix compilation issue with legacy gcc
Date: Fri, 18 Nov 2022 09:06:04 +0800
Message-ID: <20221118010604.34711-1-bobzhou2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddbd84a-e57d-476b-56ff-08dac90127b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Md8TSDAoQXfoytcpOsR5rd2eO80R58JvnFmGz/woTzTIMeL3sKUvnPZA6Hfa2/6JlIcKlPf7umSGzeoufMEeemFkI+tdsrrVMvZ565p6TdQySkB79Plhsf6IBXvxKArWATI5GPPQ2W076jEFMnO3rQzqy6woRpwPh8Tei8/+0DEJuOseYfYC5oApoShFg27btP8HG3zUL/+N/I3IKjae73XbIJ3hD5OipY4c0+XqM6rRteDZy4kIeTFgX3hehJNDRqHhm5iIAkLQ9UN9a1xC6jDB2ak73mvRvuhw+WygOVQanGLwCx0xMaE3it4grXUJxuLVP2HcTyMIs6H6XlFFPxP+HnkBm3zu3t5upG2uk1IG1kw0rOKDcGhE9aFiM7izTMH2ttWbjQDuPaXc8JPvhI8mDDlUMLvSSVKQMPEv+jsKgjYrzWSGnIqDPxT34V2qNV5aPKY2eLlMiKle0OnCFbrHxT3UjmTx/ua8QoGVeUN0cNumrLaN/9t+wd7IZKxe0VcMIP4IK6oxCx6CsRt2adzSH4DfHLWKTsU0xd8362aiySvA1sqRWo/mrtMX7VVnFntyg9iMxdbvsz5OtLI5+623NsMa/oUx9wuhAEkx1XQxu4/MNWevFHPDV/aE1dk8wcSY/roquegLrMXADhVUJE+fhzNxloZVYAOO2D8dYNSt3EGrHIFXp1KzfApPYjw/0g7P3+upP2yZeaaEyYLbh5fQ96B8kh0FpWt0qMlEjaM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(82310400005)(36756003)(316002)(6916009)(26005)(54906003)(1076003)(47076005)(36860700001)(336012)(7696005)(41300700001)(478600001)(426003)(70586007)(2906002)(4326008)(8676002)(81166007)(70206006)(2616005)(356005)(83380400001)(82740400003)(186003)(8936002)(5660300002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 01:06:42.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddbd84a-e57d-476b-56ff-08dac90127b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462
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
Cc: Bob zhou <bobzhou2@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bob zhou <bobzhou2@amd.com>

    This patch is used to fix following compilation issue with legacy gcc

    error: ‘for’ loop initial declarations are only allowed in C99 mode
	for (int i = flag_vlevel; i < context->bw_ctx.dml.soc.num_states; i++) {

Signed-off-by: Bob zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7e64ea6a0973..97c15c4d2805 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1761,6 +1761,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 	if (repopulate_pipes) {
 		int flag_max_mpc_comb = vba->maxMpcComb;
 		int flag_vlevel = vlevel;
+		int i;
 
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
@@ -1779,7 +1780,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				flag_max_mpc_comb != context->bw_ctx.dml.vba.maxMpcComb) {
 			/* check the context constructed with pipe split flags is still valid*/
 			bool flags_valid = false;
-			for (int i = flag_vlevel; i < context->bw_ctx.dml.soc.num_states; i++) {
+			for (i = flag_vlevel; i < context->bw_ctx.dml.soc.num_states; i++) {
 				if (vba->ModeSupport[i][flag_max_mpc_comb]) {
 					vba->maxMpcComb = flag_max_mpc_comb;
 					vba->VoltageLevel = i;
-- 
2.25.1

