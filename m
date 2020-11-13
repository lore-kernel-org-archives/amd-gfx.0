Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45318C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8052224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JseClLTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8052224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E3E6E83D;
	Fri, 13 Nov 2020 20:58:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126BC6E83B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbUjq/2nB5kigqovfNa+rcLCW3dnNkX0uh+nDcEspUdfw2M59/qauiFamhGzArotVu8l12LvPaOxnQxNHlc2An5nQdGIPt702f5rJ4GThcnylVnXgm2V1zOY3xKxk4OGV53mitfABbm5GuJwgazkYw640mVa6jPOnkSsJCUpR9AtPTAtwyJFyxySEs01jbhRu1or3qVUJ3rnwxXrs2nyCTj82tRYEknJjwNnWjnmExNJqgkndB9qeGyzMPBvuFQ1FzIrQpZxb/CHH5rdSn5L01Y7rEleOGO/G9canL2VoTsVIGkwXZs2/r0eyVBSEnYPXle5qWFAXNn8ZlJeAwM3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3toVYBo+LsSNlboeCkxvCfl5kTFerW+myB42EJcYM+A=;
 b=dQ4bFmIWXZm34rGHSTqXIJNmAG07lCBzgYUmg/nlp7Xj+xNj9dobmYHuTR+ohZcUbgBGFmp97P1OR7/PDX3W69vUY9aHQcENGIfjK1UNQ7D7wa0B5Om7cY377KrSInmA9TD8Hdo4R6g7kfXmCPDtObHpfR71zkg13gt9+puDd7G1BFTkLE6xmASWXWwMlF5YqwiloNfOyMRVsMIPku7+mLqo0WRGhLxyb4WBqw/2CgxPzUf2e8XUhYa6c+4KheWRk8uzrfFYewV9Gemxoo7pIRwcR+4LmAtLL+090bSXuBOICB+QD7Msb6iymCxtyjKvjQBgqlp6lFsgyl3rfEtXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3toVYBo+LsSNlboeCkxvCfl5kTFerW+myB42EJcYM+A=;
 b=JseClLTdZVlXxiBM4iIicfDowAZqk+sYTLBGgOmUOYEDrpimg9PbM7g8lzs9FriulQrslg/v89jRQoIizKCFQ+bxOLv+RP+SvzDWA2voNCKsUo9gMtceoEH9iFo1NFCRXKv0RuKydIzI1j9wuQOU34pUj3YiJZmaJfeCUqUPAu8=
Received: from DM5PR2201CA0022.namprd22.prod.outlook.com (2603:10b6:4:14::32)
 by DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 13 Nov
 2020 20:58:00 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::28) by DM5PR2201CA0022.outlook.office365.com
 (2603:10b6:4:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 13 Nov 2020 20:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:57:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:57 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:57 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:56 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/17] drm/amd/display: Handle Unknown Result for SMU Periodic
 Retraining on DCN2.1
Date: Fri, 13 Nov 2020 15:56:32 -0500
Message-ID: <20201113205645.640981-5-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58d4eae-1fb7-4b9e-6456-08d88816cd78
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-Microsoft-Antispam-PRVS: <DM5PR12MB135375C39F570549CB45FDF2F5E60@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2mpXjtS2dS9lh7aFtMISGy+PVBq/BQJK1iXcmO9en148vsMh8yj8v/rAHAqHvnOe9OBccWAqpm1GHCmG7jJDjIsLXV/uqpptOOqW8wPL5ZPkqugfiRzZFHCHEujkjikMyJZAJV7ZrFNwJQLIdgoWwLmAgWzxOM2M6HuwxYexd+CEcm4S4SbnioJHQh3Th+6ZHgEeA9RGDRtqQBsjSzRFMItNSDI2+19/tqnwmXNxsTzsfhL/qcMhkjDj1CjIwJy8evOxhKHjiWM70cVnpP35kdOlMy4Y8KxNaXPwGE3muYfFI+mxWcCICE0GDnVPkq+j0xpTpvzx/mTBkegO2sOHKdCgGkNMjPVRzgx0FcDVT8RpTGLo3J7JjBWLhbLDHYSveiL2yMPzxkNuU3rpY1iiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966005)(1076003)(4326008)(81166007)(5660300002)(47076004)(82740400003)(82310400003)(7696005)(6916009)(2906002)(6666004)(2616005)(356005)(36756003)(86362001)(54906003)(336012)(26005)(426003)(478600001)(316002)(70206006)(8676002)(8936002)(70586007)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:57:58.9822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d4eae-1fb7-4b9e-6456-08d88816cd78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
Currently if VBIOSSMC_Result_UnknownCmd is returned as result of smu msg
there is no way to know.  Put 1 in param so if 1 is returned, this unknown case is handled.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index ab2b9c61e565..11a7b583d561 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -247,5 +247,6 @@ int rn_vbios_smu_is_periodic_retraining_disabled(struct clk_mgr_internal *clk_mg
 	return rn_vbios_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_IsPeriodicRetrainingDisabled,
-			0);
+			1);	// if PMFW doesn't support this message, assume retraining is disabled
+				// so we only use most optimal watermark if we know retraining is enabled.
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
