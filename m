Return-Path: <SRS0=lN0T=5U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2B8C2BA16
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Apr 2020 13:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E3E20659
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Apr 2020 13:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HwSbtKnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E3E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617C46E11E;
	Sat,  4 Apr 2020 13:51:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFE38923C
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Apr 2020 13:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d40xnAmMp9Bn3qB4nIVoD3eu3co0J1/fx2LMH/fNbbQB8tGYwsiZHuBZwsZMe8nzVURhfSlbdw+obREKGX2eCpdHChzjgvdllVsmGZ7Z8dgO+VhttvPiTNb62RObX9R6JwXl+tv8f23g/4G56g/+5nyLr4o7vA+79QKQyhfFeVFt1AT+tcxTf3jlxqPko/IQpGZpBT2qWYnLrvzInqMuLRmWdh6fEM5pl0cboMaNAGlY0+XUNs5tZoIIzdDlu4Mp25XrY/sVL9cEKv6I341Ri1Ub7q3yq1+adcTLGG9xKxHCYePSv5top2mWBGpKU9ibV3zWV5vs6Lk3dwaEk86RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48bmAHi4+KFeIOYRhu0dRUur0U0T58hU+gIaUBByDN4=;
 b=kjXr3vTmZaos4wKNg3b+JLFjfV1mR0++rk08zto+zlt2vQO6SoC4QtBFr6o8gKXjxkQY9RVu+5jNzXFTmRvUj8VQWotON5+daAA+2BsH2Yo/gXVoj1WXd5GjlZKDDxuv8qBDODU/wsNQv0osLdJvVskB5gH8/lx5vBRyFS2+/AJrLRkpGHeuLm58PuC7mfVB8v0YFxMoikpogIkGyZzTNjq8f4tAZSF5+cC5L6Lw45hbfvmpg1CGqPX2KW2YQnqqj0AycJLbrHjYSJ6+pdPWvLIDBoc+YoEi+qSApxkun34FA/y6Cv6lU5cE04amvsrUTTLEKJ5OeBvn5QrFT+BRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48bmAHi4+KFeIOYRhu0dRUur0U0T58hU+gIaUBByDN4=;
 b=HwSbtKnwVEP7r4OK2JW5NY8AZpcLi1Osyr4P0Vlx6XNrow+Aoelgo594nmbaJs9qxBm6Zqya3acoff3ikmra/NG7bdqTgf4x5dSqHkeSh4Br5Dv7AQJsgdJNCdCKgs2gc3rTiMgQ/3fEnH7tCnAAu74g7bjuSSIz3srnZwutH7Y=
Received: from DM5PR07CA0112.namprd07.prod.outlook.com (2603:10b6:4:ae::41) by
 MN2PR12MB3280.namprd12.prod.outlook.com (2603:10b6:208:ad::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17; Sat, 4 Apr 2020 13:51:44 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::19) by DM5PR07CA0112.outlook.office365.com
 (2603:10b6:4:ae::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sat, 4 Apr 2020 13:51:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Sat, 4 Apr 2020 13:51:43 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 4 Apr 2020
 08:51:43 -0500
Received: from yifan-AX370-Gaming-5.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sat, 4 Apr 2020 08:51:42 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix the broken logic in dc_link.c
Date: Sat, 4 Apr 2020 21:51:40 +0800
Message-ID: <20200404135140.24935-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(428003)(46966005)(86362001)(336012)(36756003)(4744005)(1076003)(8936002)(81156014)(478600001)(356004)(4326008)(6916009)(2906002)(8676002)(81166006)(7696005)(186003)(316002)(47076004)(70206006)(26005)(70586007)(82740400003)(5660300002)(426003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55b71efc-5b10-4e61-229a-08d7d89f4f74
X-MS-TrafficTypeDiagnostic: MN2PR12MB3280:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3280BCAE5CA1E2570FA7918AC1C40@MN2PR12MB3280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 03630A6A4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYTIOpVqsHIcy0i7G3ox5J7ooVWhFWEc68HPVys7TcEnotQpPSBcMu2Z2LSBnlGMyqwWN7DIDnO0oJKMSjrrKe3EAtuz239Idx/Engqkj9JY98uESLbv6oYfmN8Z6qlsd7jaioV4/OApgnP5WHIetVOdNQlLpsmRCOnc0E1nKQ0PUXXrtXU2i1TB5BcRX0PznO2gXrWnHg96G+YgDKsE1UE+MdivirwkhH2hV+VMkjaKRrlg05zkM+UW5TdjHNZpcrn8rVhauuJ1T2zvpDO7E6Q8ZxxWAxOy/jP+2wwjec317wtijbx/vecReIPo4lbNHhpSG5f8L+rAZiRAW4+wxPaA673j9goJ0FCQ9VB3rGiOMPiSJSZw3NNzk7C/4p0SX1SVmtdP0v3Rwesym+b3Q8smNLwFT6LCi9RZKEY+nQCFdf1f7plbzZEC6722ekLSsfnqu8UtMwQlo3tc9DBhhchVJuEib45ao7NNVjIvT3Q5c3pAqmUd7MYQhiUPFi45cdEcKaZ+57ilSXUFKLLo3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2020 13:51:43.9785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b71efc-5b10-4e61-229a-08d7d89f4f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3280
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: I8ea2eb01709878436fdab19e1267406afa95b232
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7e0d797d8973..ad9875e64872 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -422,8 +422,9 @@ static enum signal_type link_detect_sink(struct dc_link *link,
 	 */
 
 	/* PCIE detects the actual connector on add-on board */
-	if (link->link_id.id == CONNECTOR_ID_PCIE)
+	if (link->link_id.id == CONNECTOR_ID_PCIE) {
 		/* ZAZTODO implement PCIE add-on card detection */
+	}
 
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A: {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
