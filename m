Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DDCC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CED22283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N6OpLLL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CED22283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447286EDB4;
	Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE586EDC2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQzU5d92fLS0zFydVyXc1tUqr4dMQ2CrhLlyBcqGa8+HZxkDXEwQ0T3vcwWQeeq1tiy7evE1MsAsrthQfOoTDqSqJLEMAL8KcskvN4XgGtwGAaPSlfCSR5sUyfjsjFbOPC0QEL5kCMhr0djIfy4y5CqXWcJbmULvQY/brcn2aCd1NOE/TevnA/DN+HJU4UZgRzZoa+ib5grzTom/8mMSp+/deXeTZ1ynu/d/2BBe8160/BLO5iCAVEFe46+cX1jm53xiKPr1KsNQMvxPtmgF/GpAMxCZOriM8iDvr4lebCqGDDrK+6Yd4jtEvnDoeZ0BuMR4QS9QEQiYa41Oi90WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+pfgTk1mdO4pM2In8bQRlYlmlGp+jeLA5F9naZWLeo=;
 b=b+U1HOy5fnznX0jtT+ofS1kBmh14c9qvWmnFE21VsnKAkcip/abRXQ6JOc0RqdD8WPXVaVRbpaHAp9W0y73kU0bgLP2DoQNcdqxWjSfVm9iSk6MBXBpQgKuJ9p9huZwwWkbhIxSTFPOx2SS2QhafQGHAg7ss8Q90m2ZYGp4XgDNdZomDOrKzsX0h08D2d7RLuZkN7XbUaPggOp06AkMTe8WNkv8jIRpaMC5PbaBJBoJyBSNK3tZ2se+LQw7+MmuO5AFE3QSVfqxPimFWJkKUqMPv7FK0uTK7xa9pGRotz3S3xyXBNB6+7D7hHD6olFWbFhZnXMCeg1iiUNaZO/EEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+pfgTk1mdO4pM2In8bQRlYlmlGp+jeLA5F9naZWLeo=;
 b=N6OpLLL5fSr9esj2UshYAytcA+R6iNNIL6pZaLFBEHh/Ow4fUzDvYn7zTHw8Ed1CV57J9Mxo3WMK8sSv2eOesWe36Qa8w4SrTyo2dUL3laXKNp8R5RTQ/VAbRGkjxNLUGDXQQrz3uVSnUrRz11MrGHJ+85CtzfDTNfQ8fQImFNs=
Received: from DM5PR21CA0009.namprd21.prod.outlook.com (2603:10b6:3:ac::19) by
 MWHPR12MB1613.namprd12.prod.outlook.com (2603:10b6:301:11::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Wed, 21 Oct 2020 14:23:15 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::68) by DM5PR21CA0009.outlook.office365.com
 (2603:10b6:3:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.17 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:13 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/33] drm/amd/display: DCN2.1 Disable 48MHz Powerdown Debug
 Option
Date: Wed, 21 Oct 2020 10:22:36 -0400
Message-ID: <20201021142257.190969-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12aa9932-d169-4d6e-eb46-08d875ccd926
X-MS-TrafficTypeDiagnostic: MWHPR12MB1613:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1613568547AC428CF55CB23C8B1C0@MWHPR12MB1613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDKiYvgmwscGGevtbqyI7pYbYkXvDZaAUSnKMtknU5+FjvRlT9tYSglHIqzDO8Whi1wnHI92nEZtgDBD6bTvKAMX7Cf87Sf4RbZ9Z78Xcvn/JRbJnTl7wUF02JBN+E5AEALrbvQT63ARGOT9NCCG1up8bmHXO3BlI2rLgWbscVIPZXAO26oGv2AVYdSb1Ru91b6Oq9qYF6uzYmiciQCKKQCxkLzD1jkMOjGPvvMYWL3eMVFDzKlLN30DOSikYPhmLh6Pz+D4gyPFxvPiDwIgetDVcE9M8Jl4UPN1TVLVf9TK0gYq7DKs2Q/VBGtKRHXiPIWsS0DwMI59oW8z8jde596sR8gfMD5cMkI7zoXw2TKA4mfJGRhcX2Xyx+s4T2ObF7BER+z3UCjMFmy/54asjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(70586007)(70206006)(6916009)(2616005)(8936002)(86362001)(36756003)(186003)(83380400001)(47076004)(356005)(82740400003)(2906002)(44832011)(81166007)(82310400003)(336012)(7696005)(316002)(54906003)(8676002)(1076003)(478600001)(26005)(6666004)(5660300002)(4326008)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:14.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aa9932-d169-4d6e-eb46-08d875ccd926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1613
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
Currently disable 48mhz debug option only disables on boot.
Need to put option check in update_clocks as well to make it
affect more areas.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 2f8fee05547a..c42d2f4e81e8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -124,7 +124,7 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
 	 */
-	if (safe_to_lower) {
+	if (safe_to_lower && !dc->debug.disable_48mhz_pwrdwn) {
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
