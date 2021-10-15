Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76496C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4588B61040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4588B61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D768D6EDE0;
	Fri, 15 Oct 2021 18:44:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3DE6EDE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNFQrNJnLq8kprohpLutHX2BXjatEB6VKPcjDK/+t/5GNOuGppx5+KEAFCR1yjwtN6YLBUNsG7EPRtgdDa1D07wI2JUPJt3MetuvYmVXS0B5LoFCVboiGhUxOi7sgLVScT7rIx3XgQtZ2TKIkLsEdCzC4zp/ojOK+XhtuU2g86QtaGGNCokPL7a07/5lgy0hZN4oNDDW7Ghr33AKxuIwH8eYyuSolpLKE+1zRQ7L9XMp5uTIS5uged1bFyJ517x2uiueWArnh/MDI4OPYoOtQFtF2ZOM8HIv48GE87XGerys22uHH+7bR6qWLROfnxl3oKTBtNCTvdJFP+3+WYtNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfSPUkeZbkKG2b0hOxoFc3NfBsH7FBdEWz8wxG59Vp4=;
 b=GEqJHn8q35g4hUHJ6s+tXu7R/WrIGIFBX28xWZzsc3B870xdxW+y+an1f2gQZQWOrEigILJe2hwOo6Sc5aIH0TJgzlzBd5xqk0CQZeeMr13+SbSxBFwIF3xCwybJNdhQKPJwRL2jZJRA5nRUlhwyTodDnTzozuq71ErJDVeowLmnpw20rRI8I1a4QwqXoUzctq8/XIQYr5J7EzDIbVPgam8y8vmRI7uoPKoGHKeq7u/+mwaWVGj2sF8zLCxS7Mv2YFrFK20n6nXcFrryUJrJibkjzf1KXnJWpvmNDAWgsR+dATLsd7QaxSfL7l9NnDREU3IDOBTBLdGUZgj4mf6wlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfSPUkeZbkKG2b0hOxoFc3NfBsH7FBdEWz8wxG59Vp4=;
 b=Tk3fMxZJzp43h2fcfaaVSemTqHso4At45YsXx6uWd4nyA6qIWd6DUqNMoRWtpkJHq8OQhkWahrn3rt/mpa48IKDoaz5BPcSlVydfx+PlmPh8xZn/Wyz13fFcxZfPbJV+xy7/wLvDKPKm1NClMm9i0Ey9NiCmqeczTwtn1H3g+SE=
Received: from DS7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:8:54::7) by
 MN2PR12MB3069.namprd12.prod.outlook.com (2603:10b6:208:c4::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Fri, 15 Oct 2021 18:44:11 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::4b) by DS7PR06CA0039.outlook.office365.com
 (2603:10b6:8:54::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:10 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:06 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, Eric Yang
 <eric.yang2@amd.com>
Subject: [PATCH 19/27] drm/amd/display: Removed z10 save after dsc disable
Date: Fri, 15 Oct 2021 14:43:24 -0400
Message-ID: <20211015184332.221091-20-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 335e3e6a-ff3c-4a63-4111-08d9900bc720
X-MS-TrafficTypeDiagnostic: MN2PR12MB3069:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30695C40F9A5D28E479DB108F5B99@MN2PR12MB3069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ll3XDsZ4A0Imz4nNjt8ONo1tTQz5qEwfcsEa+OmyrGaJW61c1csVJW7S9g7YyjhRQN/Phe2FDNG45FKo4gFrsGriFsFIbed/+WT1KDDEm+sRonFxUAP8NCirpKF9fB2/B2e+MbK/dX3VimysRKRFby6hyIlB8ZqGwqtdOiwb4UjUwyY5+/6hKhHdJpf/736Mg1gzNYQAPnOOsdzVu6DVlIe2yCCXE/FvIrA+g0OLz631dhyKjBSlf8IqGqZF+tJtOt6LcRRjsJm78WTUqVhFwlWtLGmX9GkrfZGIO9pZqI7ooLG5skOWS/bjIWiKX3VZp9tFLb6cYo+lonnrqwvQdEKL3BJB7cqMWPIKseJ5OtBpcl12NE0n4dZfJKqD97GS2GJfUHGgrZmsaY21KlEBV2NMMrbX1Y/V/Ii+GynN+rkdXD/5SOKbu6/I2Qt++AuPmm/Zm3L+fPUG6+7JQkYidg9No1Oab93eqF642zwEEOypxNqJqJTnWNWrW37ZnzQDg0TgYKg76JJdqo6J2lgelcTllcpEQ+uf6LWa/rmiJr1vhz6L/gwMs3CsT69c4oWI/W92GgX/HvYRWVoCfdjSpmJE5PpNsq6htCQdTgWBOvKKsQ+/NjGSj7EuHUDFbidnuIHHyloWhlW+ZbFHUG7ewYIUeEveuBWut15yg3gTGXGy1nPBSnNkVPz+gewqbZsaiIT+NalDDHOclOJSl6nV+coeH5OyETrjxiABOjFZgkw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(44832011)(316002)(6666004)(82310400003)(54906003)(2906002)(70206006)(70586007)(86362001)(36860700001)(47076005)(4326008)(81166007)(83380400001)(4744005)(1076003)(26005)(8936002)(508600001)(36756003)(356005)(6916009)(426003)(2616005)(8676002)(186003)(5660300002)(16526019)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:10.8656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335e3e6a-ff3c-4a63-4111-08d9900bc720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Z10 save is done during PSR and bootup.
DSC disable does not need to save for Z10.

Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index fee385e37c9b..65f66687af4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -317,10 +317,6 @@ void dcn31_dsc_pg_control(
 		if (hws->ctx->dc->res_pool->dccg->funcs->disable_dsc && !power_on)
 			hws->ctx->dc->res_pool->dccg->funcs->disable_dsc(
 				hws->ctx->dc->res_pool->dccg, dsc_inst);
-
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		dc_z10_save_init(hws->ctx->dc);
-#endif
 	}
 
 }
-- 
2.25.1

