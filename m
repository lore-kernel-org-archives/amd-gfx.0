Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB90B61073
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB90B61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472116EDCE;
	Fri, 15 Oct 2021 18:44:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5745D6EDCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqPKZ7jE2GZbJJSz/3SSPsDc58mANG8pC9V05yku9p6t0LArudlqurvQFsDrxeAgJj4XsOk5LOFsacqeDfw/IKWR4eKRc7ECkP09xTadrXpFd9O6k1bl6GrGXGHILdcwWDwUeITFXrwajCKzLGP8eqr7MNiwKP7VlnFAOU07NKTsYNAYWfouaiYwYhkkW9+jBVhndLqPt0cu2mKX0FYO4WHfTwVp5R5HwCjEuUIeDzypnhzVhDmMlm+JIJTVkCdUywQjdUR6aCeQ7MNM0zKTyiS0RYMbOOoeLQ3K3XHQrkc7RSeWwCNXqqpzHrbqfxrfNYPYUtXddr5ppEP0d64Ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4FfV68Jri9hxHoS4KBthZj6h32wFkvz2b/1KfFZi/Y=;
 b=dciaWqYNNOaJlANthv4pW4g3t+mo+W3oSiOWljVENYkq5j/Edyx9yeB9nT6inO/jCjdBe5ND5WA8OvsjM0IF64pApaF1wvXIPsouHEzVrg6PYp1Q2Larci6HuIQb5Swc6QmBYWt+I6Pn5iYa4U8b1HPORrwYFqlEOg7c0FSL2hPLmVAsiiMFl/m6c2TeKn+DwUl9JThiJZ8O67g+p8BuXNJdR7zu0NEmPluVY/mW46kjGvnTybL1m8gs9Cj5DLNPOlrZGOcD2KDD8zG4l+arbjVqLwvN9TCenfDPGOS9O/vgR8Xdoh75rcTi5xgPZuy6xvdylabQy+6c+5ZWqUnVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4FfV68Jri9hxHoS4KBthZj6h32wFkvz2b/1KfFZi/Y=;
 b=EzrKcCFNE9MGZfuiRz5DhewEt3X2NZzLnaMSslboi2jOEE4bXH117+4y9aAnRFyM9UgPD1JpN1BwMORsG1Z9neLurve2RvbD7vo2lWJ1eWhpuv/TOIwW0A2tDrI7Ska/0h2jCof+lMeFCMDbnwrTNwifJLPt1XcUJna7kZDxCGs=
Received: from DM6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:5:80::14) by
 CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:01 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::c8) by DM6PR08CA0001.outlook.office365.com
 (2603:10b6:5:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:01 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:59 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wyatt Wood <Wyatt.Wood@amd.com>
Subject: [PATCH 13/27] drm/amd/display: Add missing PSR state
Date: Fri, 15 Oct 2021 14:43:18 -0400
Message-ID: <20211015184332.221091-14-agustin.gutierrez@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ff3a2255-7056-491d-60d2-08d9900bc184
X-MS-TrafficTypeDiagnostic: CY4PR12MB1494:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1494C63A05F3348EC769A521F5B99@CY4PR12MB1494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rLspu/vXdE8PvT5ljnxBPVaGRdg05eQL/5UrJaR6h6LtmD59uCM2mj2jUCZDa8PvbFLePJMa9txA/sOmFiG78yN2e5j+RnVAWopgvQtJD3X9sGvlVR5teUFUDx6d6P6W8hkNuCclRmp8q4qRVAE3BGnqEpXIjtx8tewG0SbjCLodVnsz11iaL1EC+X2Ne7bp5/EDroZsYA2oKu1W8oFWTuFLEepqgdilWKDKk3z75ULG/6f9oZYUNKzUmJcOM7jfspHjTuttq05+653xhsrA8rrOVw4WQzfJymgd27x4quZ23t5PmITrOy3dFvgaNtOBUD64rOPXjrMJWnpTSSPlvA6QRhkylG59zu0IZVQFPyLTUHDAFCO2C+XMNQWM3x1VVLQO3nwqSCJ1GU94iTOQB5kr07UBHA78Fv7OhcXVR8wBEBWRudAOzI03XpxSgdK2tLvR9ZcnM3Tt7gcTm43Lz0Hqd5fPolQsqysgjz3kQUetnQWs8GVdOSrq+EBk/V9aQVukE0s5cvcrwe3ub3EeD2HEZhP8SJc4xxbDpw1JEx9gcMy9O5cGARukoLkL52v+kfdu+J7GESdl5SXO4Pt4tnP8zA4073Ov3hL0K84zAVhSqrO1SrNZ3Qoh3Vu/+Mglq11FWsz+4oH+e9h4QwL9Vf4R3MzQx1fjOmb/xXgFZVhOCt9mSox1iwUSgefJNIyx4APbdiiZ5XuELziLsc+l87fJB83z/IIVTN2ykQ1lfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(44832011)(82310400003)(1076003)(426003)(47076005)(81166007)(356005)(336012)(36860700001)(2616005)(54906003)(70586007)(6666004)(5660300002)(86362001)(16526019)(186003)(4326008)(26005)(316002)(70206006)(8676002)(2906002)(8936002)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:01.4545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3a2255-7056-491d-60d2-08d9900bc184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1494
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

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
PSR_STATE2b was introduced on DMCUB side, but not on the driver side,
which caused convert_psr_state helper function to return
PSR_STATE_INVALID. That caused visual lagging during state transition.

[how]
Add PSR_STATE2b to dc_psr_state and convert_psr_state

Reviewed-by: Wyatt Wood <Wyatt.Wood@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 15c353c389d8..388457ffc0a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -653,6 +653,7 @@ enum dc_psr_state {
 	PSR_STATE1a,
 	PSR_STATE2,
 	PSR_STATE2a,
+	PSR_STATE2b,
 	PSR_STATE3,
 	PSR_STATE3Init,
 	PSR_STATE4,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index aa8403bc4c83..05d96ca80512 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -50,6 +50,8 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 		state = PSR_STATE2;
 	else if (raw_state == 0x21)
 		state = PSR_STATE2a;
+	else if (raw_state == 0x22)
+		state = PSR_STATE2b;
 	else if (raw_state == 0x30)
 		state = PSR_STATE3;
 	else if (raw_state == 0x31)
-- 
2.25.1

