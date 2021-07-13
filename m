Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB45C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C586611C0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C586611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450606E03D;
	Tue, 13 Jul 2021 07:01:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA796E03D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ8wgl3foeigqEC2XC4szC9DqZSfqSat8G3nhKT07V1z0Vmvo6Jk7rvldRjJScQsreSskRkA0Vauy5KRWHDe8MgQpKj8rMbiErtvXhZP0/PMWF/YnALf+g+Vx8kLY0NqXZqpDjk7Z8rnrGCXWo6TX143qm/o75QKAmC6LXeADhnrkHqpLg7q4vfRBIZ3dW59uCFY1xwrS65t9ISwTJrYVyGXfrkRWuOmdlQaCdTu0NEIRlZTcjnZjySCcBswEbQjr6jK78EqP0gzZO6G3Dgc5D1CteAe3fjY2NDv00oYO9jfwHkQnwNfRinnODubm17LZUbUmEfICkX0imMQKAjt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ujawW5zEkx+BUNWs1LIJ/nab9U6OLA0WEOVAyBDQ+U=;
 b=E3oeQR8hkygN3VESGvLc9KKZ1eLyQJ7U/3JFJbqJ4gkH93uhzkZC/M2Dxq9b6ZBiuzRiE+rq2mkCMJ00mECG31FyvgFzmHp4pHGrPy1oTOv5xwY9fXYxeQmhWw6UncF1G+sLRnxmU8Lh8eWL7kuAnc5QBZYoOcPPldYiGOebhXm5xRYBzlDAZToSXPXtG2XTM1+oXDJSWpWRdDKEWYnnTvxTChAHDzm8JNhbMDj23YMqCbbUxipepGCUBxExzsEr7JwtdWsl90njPXmrFzwi4k4yPkKz9Gqf89reCmj2bfa+/056MQIghRl3ORfer5+btXbq4vb46Xru3cQiRnbmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ujawW5zEkx+BUNWs1LIJ/nab9U6OLA0WEOVAyBDQ+U=;
 b=V0ZW9qy2dmDa6CClIPtVaU7sTxNIQTW1Msn/NFTUdOe+adEhYY5ZfS+1ClF45Wrz+sgALupt5X8t12J1VjzgU3HLQuuM30qQFiCNvsBRRD04hW1iFEhjl+muNTwnsGGbayPFz71xT9c3PwffoIxtQNF6iws8x3CrF2Phz/EvCB0=
Received: from DM5PR19CA0070.namprd19.prod.outlook.com (2603:10b6:3:116::32)
 by MW2PR12MB2571.namprd12.prod.outlook.com (2603:10b6:907:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 07:01:14 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::8f) by DM5PR19CA0070.outlook.office365.com
 (2603:10b6:3:116::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 07:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 07:01:14 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 02:01:11 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Add waiting for response of mode-reset message
 for yellow carp
Date: Tue, 13 Jul 2021 15:00:57 +0800
Message-ID: <20210713070057.554024-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82faec49-c36f-49a4-51ce-08d945cc0152
X-MS-TrafficTypeDiagnostic: MW2PR12MB2571:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25711482B808C8D622458E1DF0149@MW2PR12MB2571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqNg8WmH0QbrxxONy+b286WTE0j4125X9IopxJqFO7g25asLruMgXCMJPFgcLSy1mX2KA9VWN5xc8SKT78LiqkQHIBq6GzKI696Ml968KlBDJYvLTZYz3i4fURfE8YUcW8qIRpYFsmC11IbrESamUfNAAzo2XkXclcImq4ryw+JSvrls2ReGQ4WphU7HZkhKviZVFexhd87i8i4w3TtVNgth9JMVZY8gvt/6dMZuVDoV+6s+JwmZF9cLbKQxkqMVm5rltutmle8mJ3jBFrLL5TG15JenCM0c/yTRWm2V0nRKwaSfzs2ebfNZsAGJtuP3b9r72qOzjEkp58q9Zli1TkN8Kjotss6QdLK9CxfAocZuyo37uWnJ0Khm9J2CpqRYdM4ipCLeOBk2ohB8yE6EidGb3/NK0oQNI2sBOeHyI+z7BlhiJXTDBdMd3OudjI5i2YmUKYLz4woaKziaPHCTuFO0jolufu9tay6vtQDUpZtK6HPZvNrR8eeaR/LD6UCQJmkJL1tOPOTrDxp8i+5UK95GrLJ/DUT6nMtNuIT6eKsOPywHj0OETV2AG5gD0IhiNbyi6RTZ4dye/9Go4sTUQP7UAcdCmuKiqRa+rFfcYyvLnNGewBdFyHo0QUE35vhP0uCup76y2rETnf5gppU9bCgpK7D0z9cmG9NVp97C4NGxznrjVSWCoA8mAwW/BRmAfqIVqFFYuKwdXQCkSqxO8K9sxELTsvKwOldhfs9uSgRb+g1VE1Mgcsje5EkDN+UwQHBIbY8pxb1ehWJYKTcknQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(356005)(36756003)(7696005)(426003)(70206006)(70586007)(54906003)(81166007)(186003)(16526019)(47076005)(44832011)(36860700001)(82310400003)(316002)(5660300002)(336012)(4326008)(26005)(6916009)(8936002)(15650500001)(478600001)(82740400003)(2616005)(6666004)(1076003)(86362001)(2906002)(8676002)(83380400001)(69900200002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 07:01:14.6403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82faec49-c36f-49a4-51ce-08d945cc0152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2571
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove mdelay process and use smu_cmn_send_smc_msg_with_param to send
mode-reset message to SMC.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index de92f713a911..0cfeb9fc7c03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -298,13 +298,9 @@ static int yellow_carp_mode_reset(struct smu_context *smu, int type)
 	if (index < 0)
 		return index == -EACCES ? 0 : index;
 
-	mutex_lock(&smu->message_lock);
-
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, type);
-
-	mutex_unlock(&smu->message_lock);
-
-	mdelay(10);
+	ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to mode reset!\n");
 
 	return ret;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
