Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B51EC4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A05206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ufPL7ibi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A05206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F9C89EB7;
	Sun,  4 Oct 2020 17:20:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FF489EB7
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgKiCzbojGmh5Yz1ejoa+Fuf72CmiJKUPA0FVB1wnIUAzJYRkpAGaCmrIfYbNgp1AqFFS0/z5QFGEDawbxNr79N3bs3R2HjBPGm0nAgD77sylEFEHu5bvmOckAwDRZkB6Qh1vj3XswlFSw9NIwpz9fLUgtxEuiOAYfFUiTrYIf6xxqGClfDyAtIGvHD+HnwpNmDOjHoYpYojvSKmSJ+UQgr8JWYzS5gFNDYv51ldZVq1yjGHTcXcMY2A5iVz8wmlApROrY9SByVIh9Ovw5xSKzVESCrG5dKSKx6zKxnv6gqbREtHVLnfvnOMSKZM95+uqGBtDjM6yK4H+tLIndlrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqxmipUfaa4tguHfUNJcvgpFNR5DF8qJyCA+t+OA/D0=;
 b=oGqhC0+3YXHR2jfpcyOdsvxo5UlK65GK8t//Pl1tBWWnaJb9a37InW+UXsb42RbZbHAo+QVnZztN1CwInW2H2fvxRVC9M3XjF78Shc+jC061mTSen+fdx6BZm7I9NaPQi6KuLb1w6PVKTMZcYENG3RnzL2a/RX7G/1GdpR3KywuPoRYlTQNeSL5jSeZYzc9lkqolnz5cQ9Thiwnl0yeOsV1ZLpoRd9kP1o13xs+xTU7yuG8pJEy7FbFoPxrOlVdXSa3LTSimT4rrBusYsD3neWq8kUjjtP+ZP3EbCjpOYayvfed3K1t9siELs0krFybA/IpK7byCW2CaFdtbl61pTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqxmipUfaa4tguHfUNJcvgpFNR5DF8qJyCA+t+OA/D0=;
 b=ufPL7ibixKaaXYKuWDmqxz7MOj/AcVjwFEbVFraGjJTrZGNaFTIoqDPTbusSCt3KYcASDQ0Oqndwik9Kq0yuZ5G7YQ10h/e3rAXAdKs26/agvmToTKnqJAmyeU53fup5Jk0vnk/g+S2f+K8fHbTBB8p2DD6r7rFp9OPVGEs4jtE=
Received: from MWHPR22CA0067.namprd22.prod.outlook.com (2603:10b6:300:12a::29)
 by MN2PR12MB3389.namprd12.prod.outlook.com (2603:10b6:208:ca::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Sun, 4 Oct
 2020 17:20:41 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::95) by MWHPR22CA0067.outlook.office365.com
 (2603:10b6:300:12a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Sun, 4 Oct 2020 17:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:20:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:39 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:39 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:20:33 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/18] drm/amd/display: Avoid set zero in the requested clk
Date: Sun, 4 Oct 2020 13:18:13 -0400
Message-ID: <20201004171813.7819-19-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9b8cce-010f-4df9-f4d9-08d86889d187
X-MS-TrafficTypeDiagnostic: MN2PR12MB3389:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33893DEF5C9A43E2EBA9F474E50F0@MN2PR12MB3389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EVzd5oFWmNrzl2EDQ+AFEG28E8APTKbtXxy38kL+cKoUXYpHT/idFyBPrPOpDO1FK6g05TJ5wT+4xxLBhN1IH6iG0wlssEE4a+SyWgfniI6PS/IXIBIjj4BhoHnBII3NtdpPP74jFpnU6f+VsO0Gx6f0DAHlPKV1Mhb24k3/XvNp7IRj+OftJkrvtMi21U7gOna8oAUvl3kuHc6og4mKsuk4+nDv8tsTfgya0gsjCCzLv6Q78H0SzIhYv4emOl2Zl8pxOCYFXqEqwA+MyMKOraPGgmzU0AzDBj5D38qHoDbY9i+UZAvLhPMdJXNusfJ3ub/RLMOaDXfZmpn9B31OgHUUPVgG2Hs6fG/yNVPAtNQk/Kp3N9oEplGsgGd1du+qWtARW59EzQWUNjxt3lNjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(46966005)(82310400003)(2616005)(8676002)(82740400003)(426003)(5660300002)(478600001)(44832011)(6916009)(54906003)(186003)(336012)(70206006)(70586007)(316002)(6666004)(83380400001)(356005)(4326008)(86362001)(2906002)(81166007)(47076004)(26005)(1076003)(36756003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:20:40.6312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9b8cce-010f-4df9-f4d9-08d86889d187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3389
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why]
Sometimes CRTCs can be disabled due to display unplugging or temporarily
transition in the userspace; in these circumstances, DCE tries to set
the minimum clock threshold. When we have this situation, the function
bw_calcs is invoked with number_of_displays set to zero, making DCE set
dispclk_khz and sclk_khz to zero. For these reasons, we have seen some
ATOM bios errors that look like:

[drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than
5secs aborting
[drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck
executing EA8A (len 761, WS 0, PS 0) @ 0xEABA

[How]
This error happens due to an attempt to optimize the bandwidth using the
sclk, and the dispclk clock set to zero. Technically we handle this in
the function dce112_set_clock, but we are not considering the case that
this value is set to zero. This commit fixes this issue by ensuring that
we never set a minimum value below the minimum clock threshold.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index d031bd3d3072..807dca8f7d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -79,8 +79,7 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
 
 	/* Make sure requested clock isn't lower than minimum threshold*/
-	if (requested_clk_khz > 0)
-		requested_clk_khz = max(requested_clk_khz,
+	requested_clk_khz = max(requested_clk_khz,
 				clk_mgr_dce->base.dentist_vco_freq_khz / 62);
 
 	dce_clk_params.target_clock_frequency = requested_clk_khz;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
