Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980EC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD32B610C7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD32B610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D33E6E50D;
	Thu, 15 Jul 2021 07:50:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FF26E50D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 07:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyhjNOrYCYRWByco1sWDQQFiCS8gXK9nPCM7L4qEd2IXkh0YTxwAWSRKU53oKmLw+3f9j3P8nP3bT0igzNwv6YS+uQpeKjV+KTn6DxCFDyMGfMAcQ5DHu9diqtYg0RqRbZtSItOCaaAbolesCXlzbb5E+4/7PH4V22lHgofUQGVD/LUqp0MV6gKFunkue52/Zq4IQvsyAAZD7lVtaSKjp9Ry7Rxsh3BEl1xwA/m188emGZO7xMBzDfYy6O2NJEzAy1qdgXvSt4afOEBAN7gtYv1IfBsuKZdnUdwm9iX/jrdr0L98zEQNpuZUUkrZn47EZBW0sr+HhT1YZuiIQxXwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMifE1nd/msP34rxxCGb0pNyICnDveFV8E1jW/hXCa0=;
 b=oWlA9+wSEJYA4Vqt2ZHZmj/sUUWoHUKglFwspJzLgreS7s/4lm/pHzvBpkG11Njhsup/yj/ucNw9CeABUs09UBTV9r8/a/0LEPlzLxXTO7ycAuCvGpfLu0Jdm495rXK5fYBp3g/I/L6Kh+zfPJkKnYJwzUGrQzypB5wCURLSB1lf4/iJPCU96NH8hc5f51PXQA2Y1JvSvAbCTObbbuVSmJ5BnWLHnc/eZ0/6YWxG/V7IpxFLGOTv9L9pywCidISLbX3+2LprEeUy2cUgembpsZ7HMs0GZzCgDcblejW99F/3IHMrV9O78quJ8UVqawSOHZ0Ah+sFJy4PXb+X1GocFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMifE1nd/msP34rxxCGb0pNyICnDveFV8E1jW/hXCa0=;
 b=t/u6eWr4SmwSt5BhJSR0jZ5UpWU4NbRKXTajRnTAbb1B8l1LF36r43ioqdAvn6uJ8jHlZEGYZ2XXsnzfRCBtvRP7F6pLsmdHcbnP9sQDV/MVSIezIIgGMtjnSVOmWlmGpnhlNaEDRvrj7GAweI/rvARWGmS+xtskLFPe2oOkjeE=
Received: from BN0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:408:e5::26)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 07:50:46 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::7b) by BN0PR02CA0051.outlook.office365.com
 (2603:10b6:408:e5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 07:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 07:50:45 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 02:50:43 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jiansong.chen@amd.com>,
 <jack.gui@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amd/pm: update DRIVE_IF_VERSION for beige_goby
Date: Thu, 15 Jul 2021 15:50:33 +0800
Message-ID: <20210715075033.1715-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 370bb1b3-027d-41cc-4148-08d94765411b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5071DE817A8F61FFF825DCC3B0129@DM4PR12MB5071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6om5VEdwG6DFSgxafsYd4o5tXc8LKZI9dsyF+IJgoz6xfBhpvlsUB34xTRYQZgd2p39DWXa6blY32e4FfrEfYieVhwdv9r/UYkxfKiPsH1c5uiunTJqlWjzYIrF3G6uU4S4ASgvQ2gdvOSkXlh4geK5jbdB27qB83UmglnLwlg46lPKVJqQlwU48tq+UyKSLepITeQoV793o3zC3PrURnKaHIhFfQFJgifdJ5BDBRwdhRhEpoKAe1V4L2FkfxxfjXvIIf4CNHz/G3Dif72YCH0o9gnogTk+toCNfngH83IAgHKnMI4VXMqJdcK0OwABOPxCVxrnhwH7+/D7jVOvKDjJ+t8lH5RkYCHswQXb90CC81F4G8rqw79KYulWuI2+Ng2MK5ngumU8SFSnLN/OfVY8r9f5nXSj+ckSnnE0tfhuNEX60ooQDNirfxC+LEmwFC2FjdseC3bFr60kKGEMdfUdFM1/Dtf+C5FV7Wd+XKiWpTM8g/d6Fp6CVdiIRNCZFX7poktkAwHSNAJColhWl7+lAymLIfH2LSrdE6DOYTEHHo1WO3ZrdIJJNsAWu51L+zg71tXW8bEADxASFOw7wWaaSgZAAdfIIh1eOsxxSVYaz2WWy819sPwSBgmph9tY7aJ+8nLOKWNkJO2YbtcY92uvDvwPd4BD0PTh9jORpQC/jNpimQxMGt43p/PCvzI9eqkYGIGIahv1BWWVHv8rGsssH77coKHYTJ5uGLhCEOM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(5660300002)(82740400003)(2906002)(356005)(4744005)(6666004)(83380400001)(47076005)(8936002)(316002)(1076003)(81166007)(15650500001)(70586007)(110136005)(70206006)(8676002)(2616005)(36860700001)(426003)(336012)(82310400003)(4326008)(36756003)(478600001)(6636002)(7696005)(16526019)(86362001)(26005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 07:50:45.6501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370bb1b3-027d-41cc-4148-08d94765411b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the version to 0xD for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index b89e7dca8906..385b2ea5379c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -34,7 +34,7 @@
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
-#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0x9
+#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0xD
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
