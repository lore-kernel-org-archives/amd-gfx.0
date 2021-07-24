Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39CC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF3960E95
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AF3960E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1427B6FE5F;
	Sat, 24 Jul 2021 04:11:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829F56FE5F
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzlfrCEzWOOVpmzZNUK4oPmCrhtZzdESXrM26a4+yg7ELhPkMd6XAMIzsTH30976RzdP3D3FpYLHkU4jAomGUfI927bZXIvXhofQKkHsl5alLsaH2bMIgh5N5Sncdyq2ZQPkzOrDtkRYhyag0SHLLP+dLEJwZJf80i0YNE+UjbFkF5SssjEhVSsAFxQ5AMzHctsqUOmvrLZLaAfhwOwptP4ZSwperTPmVrm0hzYrOp6QaLw07UfwLVpIlOUyEyUhk1cZ+k2e+KlNygGkyLP3HT/bZwq9/8vC8oVSKwMknDvX6RlXzoFHAgDlFV1JXuWOqBFNw0APnYO0BLcBl5Wj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zknIEELl2BtKxy3Sve8RbrM/w8ytVcOF4DKnC2C+0Xo=;
 b=Q73sDNlJnv/7mdvqGKnyvd948J7XpfqpWcIc9L1lusSRpUTW8BzC7nuXC9bBxcgqDQJNTAYxjjcIcj0YGxEnOq+ErAFx7P38g44PNIG66oOPBTkuPd1jymEsRqnXXRtt5TVQ1jXaxquK3w86se0Sot9c8FOr4fJxYZBo+rimWx8UHL1bWgtYEdjXatBr3X02kojSqfdh0MJAEDo1NUHdXqVCyQwkfD5W4duKD3dpRRunEFUP8ko9kc5YHG1sfBpA1aiuYzalMf66fKd9CyGnWekGoU13dGlGGy0IzDfa3yIO/45aqY18XHjuxUxT4YeFy9yrD+OYfsMsON+AqxHjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zknIEELl2BtKxy3Sve8RbrM/w8ytVcOF4DKnC2C+0Xo=;
 b=GRtwWJ3dsYRF8PKAYCRJp9cgGLf6kwRQIDElx3vMWyR+WD0arqfD2eT+oaZcJdzpNFBaKr5aFa5ZRL0PHWrjYMz9qpc8zfbERkN9whsMJ1yB1od4NwvNefeCbv5y2zcCsu3t+TQ2WTno8hlzdonZHo5okH3djwjWmAMQDufHNIY=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Sat, 24 Jul
 2021 04:11:38 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::7b) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:37 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:34 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Always wait for update lock status
Date: Sat, 24 Jul 2021 12:09:57 +0800
Message-ID: <20210724041001.3875757-11-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d26c41d8-367a-4ba1-b1a5-08d94e5921e8
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5473639BF3CCAC1B5F090EC497E69@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzo6BD0CLmJP38vaxisnlw4OcSOAPlRUh1zqLTylObDT+sNmqHeHm6MPNd9nC7mSXtMJRlr4HHTeQAjWBTSSRo0O630jCrOJgwikAurn8d7nNG76IAM+c0Fbx0MvzMD+pKhHpMRK4v/xHFQrZU3h+N5b20r7WQWXv5BO3qOMfkbFLA8uPtuof8K0eOP64CF+K0292ulNfr7t5tanhqipFiVsNPnHsI5wrOzyPj6zn3qRLqtr2f+8bpnkz5RixifQqds/0wMaICmC+jSwgXcQ05uwGDHMnll+MaK2F4WR7P2a1Y48D0pvO96TVeTxMPqdkdGxxQjM70xp6lIS2HYKJH/aHtVCdCp6NJYrJ9OAKqLIPGRQQtRHKEij81bPsobDZMCGxVCXbIWLk2NQcgrJZRo7I8CbBbNsArqBrX9MXuM1xF097ricLj1rrEV8Cp5IxaodiszkmQHrUPXPpyhMuaDXzVXh0xBJQOjWk9VLtSCWdFWiprEITniQJD0pRg99MctJbON/Y4QaMFV71WUZpxtHEGTHKUiDAP2TYkS7KZbsv6R8mOj7//d00b6XFON2v4Oa9nhmxC8iG3rWYPpjdL7i/adBS1FvW4dUwGnYBB9raKNGqaI2VnoChirzJGMB86QBtDfGo2Pc1eSGpC1Pe7BryMPvVIfEFGMQYkL69qyahr2FunFH/DyZQr+1t/DTJnqqyaK9g8gg0ZJHFlkvxbx4qs4/dkOeXa+w74C/Zz4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(2616005)(81166007)(8676002)(86362001)(4326008)(16526019)(26005)(82310400003)(6666004)(186003)(70586007)(70206006)(8936002)(336012)(83380400001)(5660300002)(478600001)(6916009)(36860700001)(426003)(44832011)(82740400003)(2906002)(36756003)(356005)(316002)(15650500001)(47076005)(54906003)(7696005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:37.7049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26c41d8-367a-4ba1-b1a5-08d94e5921e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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
Cc: Laktyushkin
 Dmytro <dmytro.laktyushkin@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Remove code that would skip wait for lock status for Diags
FPGA case

Reviewed-by: Laktyushkin Dmytro <dmytro.laktyushkin@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index f37e8254df21..089be7347591 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -109,11 +109,9 @@ void optc3_lock(struct timing_generator *optc)
 	REG_SET(OTG_MASTER_UPDATE_LOCK, 0,
 		OTG_MASTER_UPDATE_LOCK, 1);
 
-	/* Should be fast, status does not update on maximus */
-	if (optc->ctx->dce_environment != DCE_ENV_FPGA_MAXIMUS)
-		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
-				UPDATE_LOCK_STATUS, 1,
-				1, 10);
+	REG_WAIT(OTG_MASTER_UPDATE_LOCK,
+			UPDATE_LOCK_STATUS, 1,
+			1, 10);
 }
 
 void optc3_set_out_mux(struct timing_generator *optc, enum otg_out_mux_dest dest)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
