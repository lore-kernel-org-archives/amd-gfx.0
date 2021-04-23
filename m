Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC9BC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83A161425
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83A161425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7B16EB2A;
	Fri, 23 Apr 2021 02:40:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9346EB2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8FOgzCvbHeUJSrzUYuh/Z0MMJKwv+h0qg4dCKvMGZkXqCx8C6EzBA+MI4Iim5A9qVm4WTewvrT6hvxWjHBi4sx/6a7kKv6pfwtACQO+TbmpRxipbg01zS5vqdAJf21Pz5xGhiivEYhqer8fUpGMKXdYtd+AzJgEXgu7/Dg3XLutDj7Io+Gwk+LGqM0oSl2mQ6UI2dKJvMPI79KnIieHzCjWTWO2/EvfI620JLcmaxBagDQnC7XUkVm8kOv9kNzQFtqljrWhJ3VKK4BLYLvCzhWr7WhDNwx8MtMckpsdsh1kEMJS87YqTsqZx/n6xN3kGjmSXs+TRChD/AfxWlmbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mND6rHEt0Nb4c/n3VbevN0ohzOjwbVGWB7Bh1dC7gCE=;
 b=nuIWFD6KSh/4NWvx04K9wxQrj2AGzogIK70GzkxMsnxcT0I76u6z1NNrjbzT0n/sDWr6YzI93PXqkQsrxm9LJkiTqVh9pIwsKkIiLitdYKiLszf1SsUpZiIJhbdg9GquQ152EzpLHOuG2xIsjlIJ4qdu38w6j/HPrbx7JT+s8LbFRu7xdbEvrkN+taIPlyX41XnhkHrbPY352mdO/vATYQf9vLDmME0AA+saI30GAbgtt1PtEVzjvcGJo0R5MrHLaMhBSx2a6KzC+uBirlS0ToE7aJfSTQxjkYGmDk0C88YfPXmGLgaOPnCbj4JuF/4sQ7eqn1ETKCIapzr98DJVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mND6rHEt0Nb4c/n3VbevN0ohzOjwbVGWB7Bh1dC7gCE=;
 b=WTw/VI+I/ZEJjbk5X9kPAaUSTZ8ke+zhiLZDJUMRwvRTm1XPetIpxuGLJUrsUd5AaMGn0c/AqnrdEX2msnJ1AMdTQ41pKt8nPXcNHg+068EnQDOIb2Mlak2FI4fVljB0dotW2PeD0HSJhIj++CqxJHxDujPTxibERDygKEE/qZU=
Received: from MW4PR04CA0316.namprd04.prod.outlook.com (2603:10b6:303:82::21)
 by BYAPR12MB3398.namprd12.prod.outlook.com (2603:10b6:a03:aa::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 02:40:28 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::10) by MW4PR04CA0316.outlook.office365.com
 (2603:10b6:303:82::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:26 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:23 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Clear MASTER_UPDATE_LOCK_DB_EN when
 disable doublebuffer lock
Date: Fri, 23 Apr 2021 10:37:08 +0800
Message-ID: <20210423023714.22044-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074f0d16-f6b0-4f74-5a62-08d906012778
X-MS-TrafficTypeDiagnostic: BYAPR12MB3398:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33988D49FF6456EFC6246482FC459@BYAPR12MB3398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xMAMv9/wgzY/SD/sUJ4cfZHM/gkp83i2jEy61Olyl42oV1xcssTeEAf2flPnjIUg3ImbE060FqCZO/wJyFZ3ibxAQnK3j2Dhsr3aBjlKBIUxwuhkQtXI9GyWIskfWmdvVyN1D/JzY4EabaWbF+ZEZe4hptJMdldAvSSpUd/Rlbqmtf1tjTdB4TgSmC117UGQIlpbtMnQLaM0DgK/KZFdPOLjYrG2O/Pa+SKgFf9SADIo7GlYYEy7knYQYhT31bQIB2LnkcU1nWnHtrMcwyH8v6gPLp2XS67jhTaNmlrlB82ARuVcRoHwOXAM6ITJWFXy6nYXnYyCB1qe+w3zQcEVRihTDa/4bifnXoEnDU9z/uoRnAqFmi6yD5AIeVpO6ueMTsCotXndin+xaegT57V7pJNDlVhMbncooZwJ2rVptRCagkyvBCkntfMVTg6BI9vS6xEU0NonYoNhTUITUikTNienIaDom2HaNvfdshXEnNoMaORI/ahFVUfeQbLt0DZNSVc9Yfe8CCGyZeq0ySdOGPlWIZJVAl2948oCz0oqpil662wSw6WcZwC6dpgvh3sVK0r9ntGcHqR86zzwfCzhT8siYVRW0ZuH6lsw323KP/+jlPWMU0wjwolooOUCXt+CX10g9e6FFtXuIwtSTmRCyMDsOXyjDOksOmP9yiKAO4qSwF505oMSuHGh7ieEQIq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(5660300002)(316002)(6666004)(1076003)(81166007)(36756003)(2906002)(7696005)(2616005)(54906003)(356005)(70206006)(83380400001)(426003)(26005)(82740400003)(36860700001)(8936002)(82310400003)(8676002)(4326008)(86362001)(336012)(47076005)(70586007)(478600001)(186003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:27.5019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074f0d16-f6b0-4f74-5a62-08d906012778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Robin Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <robin.chen@amd.com>

[Why]
It seems there's a typo to set MASTER_UPDATE_LOCK_DB_EN when disable
doublebuffer lock.

[How]
Clear MASTER_UPDATE_LOCK_DB_EN when disable doublebuffer lock

Signed-off-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 8980c90b2277..ac478bdcfb2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -97,7 +97,7 @@ void optc3_lock_doublebuffer_disable(struct timing_generator *optc)
 		MASTER_UPDATE_LOCK_DB_END_Y, 0);
 
 	REG_UPDATE(OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, 0);
-	REG_UPDATE(OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_EN, 1);
+	REG_UPDATE(OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_EN, 0);
 }
 
 void optc3_lock(struct timing_generator *optc)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
