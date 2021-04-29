Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA9EC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB1261445
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB1261445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0911E6EC83;
	Thu, 29 Apr 2021 06:23:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2D26EC81
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnhFMn0yJUWWTlIcIAxQSU+bJHiAcG2dhN+yQLdWAjpLwXbNSD9AM/ettYIDLaRi7hl6JpOx6l7PdvD9m2nYa4ngoZ29A0T5o6LPWSmHVgH0L4eGzGgcC5DGxTbp38AVBa9dJVxrpMU93xKqfOkUjkZwZ2XR0Ur3MmQ6HXQQOb2Tr9pJe2YbqJ6DXIueLXgY8ncJM22XbU1NiWUh/KbxPERMrpj7bxIhgbL5XmD4qBaMMzfJmfRB5hV7Vwkna+WFmy2rGsIbFAoDw6/DPDKZb2QCLqpo8Y5L6fv8LfJ9S3MOfds3oe3DY2mABQdQF7i8K4cHs9L9eCSmVsy9KFrjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XktTdeHjChPRGzPWtzHxL38tRmDxzbyuYaOgU/KbnBM=;
 b=QQkhwaL0eyaBD+4p/gYaxKHTXF4rgyfhZr8uAHoP/94515r4ROHmVaq7e8BD2gRVBmjEgKC1e5s680iUO/P7Rbk+36QT/vvbUFj6/Qjeh06KoBwFFSV3jTcVwP0SqW/j7XMpTekPtaJCssX9wGpsvO7wLYziaBduTYSQEBIVavv7ohBQrukFW9obhfWeF8qjszpzkhchsJFkaTDtkb6dNPhPwWL28oMLyf/DSBkCDYeDxqkFDV+TeMLQf6Gc31fIc6eSFH3w77qrjYIHhBUQ1AiLu8rQPEuK7sLoBpOqWiUcT+mV+cys2lMGoR6py0GsRPiQH4ORm4wyzM8CLvOfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XktTdeHjChPRGzPWtzHxL38tRmDxzbyuYaOgU/KbnBM=;
 b=gJlS2IJTB6KejjDJCRWK70b3/F/gkbRINHdLjtwKxQ80ubKsKdobjzhUOjVzRwdokGK0D7O4+D7/qlBYNomPHN10ues4ePVEh2lO2u81UpG2vAPF0rxOtwoUYzNaCY5KeyIUAhDaveRWXII44TIetqeysMzMLLmjLADyUR/xH+E=
Received: from BN9PR03CA0200.namprd03.prod.outlook.com (2603:10b6:408:f9::25)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 06:23:13 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::9c) by BN9PR03CA0200.outlook.office365.com
 (2603:10b6:408:f9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 06:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 06:23:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:23:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:23:12 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 01:23:11 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Rename the flags to to eliminate ambiguity
Date: Thu, 29 Apr 2021 14:23:01 +0800
Message-ID: <20210429062301.23560-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a04c6f2-5810-47ce-e5e8-08d90ad7443d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5137:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51371F9F2F84993E250AF019F85F9@CH0PR12MB5137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaMJjqzl5hIcEWJWbt74LUscjcdM44hx6KgMAq4r7uWLElOBDDlo5BPFl+LpDPevSQp2Qyap3ROdAECFTMdDIX/C4ORrfwDKA07zh+4R8b6irYh/8qpdReMa6/5lsKUsyvPtjBOHfQ+uOBkP2FHNTP13pu3r9tmhpZE7NaMv6Y7ARGiVBO4OGbp6/aGlgikHtgUE/LFFTJBdGz8vNc5rDqujrqSrpV/6BsjyMzrM8rlGblbjs8e3hE/J43u6Q8JcXoMq6zW7M9KPEXMeteqccSbfyjmVxfC/+MEYSNiyIDFs6nla9bROfSGINFe0vmzoKhyj7aaL4OP/9+lF+as8gGckXFHHxNpP4OI7eCweTGucqJxstYh06r7MllM1HczVhqBBHnsuPEABZQlKkRDqE2aHoZUJX+ULxqqss2tUkhTYi2oK3Wpl9rxXuM/1ITICtkjQXGS/7w8pDwxJutwWGtLy/cxpwhWBzdHtFNnex1m9+oYqrN7p/SPRZIbE8FVpUGg2ZRccob6jzb8Bb3ytEXlcPnt/EcE6xrCzurAo/8dYUUGzZIOaUblvx3jqx+DyEIAR4G1Q3Udv0j5NHY1nZ2OXH7yP4szj+KSks7dozNIKL9JzSPbJR349J7I7dcgLV2pPfw7vltEgVtcE2Oy+vTpnjJcdMREw2jTL00V57H4j1U7YyMcvIWJkyLEgBMdb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(36860700001)(83380400001)(356005)(336012)(426003)(47076005)(70206006)(5660300002)(8936002)(7696005)(478600001)(86362001)(4326008)(36756003)(186003)(82310400003)(6666004)(81166007)(4744005)(6916009)(2616005)(2906002)(8676002)(1076003)(26005)(82740400003)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:23:12.8369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a04c6f2-5810-47ce-e5e8-08d90ad7443d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The flags vf_reg_access_* may cause confusion,
rename the flags to make it more clear.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 1a8f6d4baab2..befd0b4b7bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -98,9 +98,9 @@ union amd_sriov_msg_feature_flags {
 
 union amd_sriov_reg_access_flags {
 	struct {
-		uint32_t vf_reg_access_ih    : 1;
-		uint32_t vf_reg_access_mmhub : 1;
-		uint32_t vf_reg_access_gc    : 1;
+		uint32_t vf_reg_psp_access_ih    : 1;
+		uint32_t vf_reg_rlc_access_mmhub : 1;
+		uint32_t vf_reg_rlc_access_gc    : 1;
 		uint32_t reserved            : 29;
 	} flags;
 	uint32_t all;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
