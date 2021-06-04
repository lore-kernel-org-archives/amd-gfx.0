Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB3CC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 15:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7854561400
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 15:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7854561400
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8B66F60E;
	Fri,  4 Jun 2021 15:24:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A56D6E108
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 15:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km2qWreJHyE/eqVr/CC2AdhPq/ERwvPBf5wFgOVaBdec/ylPgFNN5WtLHceFyx83qUfg+oRNXHjOloBlwDel77NEqw7wcUGsoFD4OqvNexSwiJr9l6SS5uYJPjiDmaYvXHO08OZz/ru80M2I3zHgBV96tJFNn3/Mm9R3snr8PdnpMxpr0NtPilUS85lscra2aDHjx8pDwDZH+0nLFGzSnKVsOFVhNGBBfFrFUt/OqbSoHo2MRY+opKGg/raFCUmgY0mbgifxAS6BtVPsdPHqdaN92bViIB/oSrEpnuqqbbRBZQkxF9ztJcsA3Yctr6/BAWWiSLDJ6xtWzcaylgojHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jesK+Y4ZyWJV4kjz7JF4waAtDxlcAofFB59aq4vNBwM=;
 b=BmdcbKHtgmws/9UJDElCZGxbmpCfLda1ODayWuVuNhWcC4lyyye/wDIjYtvRps+FCe7ClBfvshb5c2LwuK5ZHKh9oTkkMTmBr7ExbiZY4KGP9J6qPrWMFi5j6qUYLQGGgtu0Yd+GYoU6aTzaYeVPK2rf77ek29daUUiywXE55s/F4ANnZfk3rcG3Q7d9aNCELslZuDlNGs1GZ0amfEnVhFtzMNyTnOSSWWj1EbsvdWjarCDgiU5CNHAN6+AmQrm1S8UBpvU4G0o4zYBnXtqAfyI0DS3uodRPiv2TQNlsu35jn9qNmn5KaJDuvnftG520KrWeIuZEDMIMRJA1Y/TH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jesK+Y4ZyWJV4kjz7JF4waAtDxlcAofFB59aq4vNBwM=;
 b=Lfio+umQY/J5XnYX7bzSYM13BUHtm4TZkvcFAlDYPcDdcB0x7KwZ5UK9lDnYLMkP3JYcGtRcc9l7ddEIGv1apmSXpox0yIFWMTkrA3i8U9kYBlfEdui3Ss3P4Pn8vQj7xl/uLlC4q3viQeRCokwJVmtQjEzLk7J/V9mJRYBHoSM=
Received: from CO2PR18CA0047.namprd18.prod.outlook.com (2603:10b6:104:2::15)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 15:24:47 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::50) by CO2PR18CA0047.outlook.office365.com
 (2603:10b6:104:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Fri, 4 Jun 2021 15:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 15:24:47 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 10:24:45 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <Alexander.Deucher@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Emily
 Deng" <Emily.Deng@amd.com>, Monk Liu <Monk.Liu@amd.com>, Peng Ju Zhou
 <PengJu.Zhou@amd.com>, Horace Chen <Horace.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Enable RLCG read/write interface for Sienna
 Cichlid
Date: Fri, 4 Jun 2021 11:24:31 -0400
Message-ID: <20210604152431.16015-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c0fbc77-b921-4b0f-7cdd-08d9276ce33d
X-MS-TrafficTypeDiagnostic: CH2PR12MB5515:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5515AD2C67F416BE38B20F85873B9@CH2PR12MB5515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7tG+XutFiX80U8FWM8iXyNXW6ddsz8k6KmC/pQmeXjs0lVJDgo3bKTe0juVhtJYOlV5I+VLB0CgihlQwUvzmGONdLDDXKS3k1851RNfXKWGalpHO/SC9eyy4rHxYs07UIsUfHwzQ8DVDPl3mFuz68lzYGeWSH2ISGbWfaSGerPjUtJ1we12qsa1AkifPqUxKaqbUfo/RiQd2XOJiMCvtRbqNoXylhhShpQH2Y563/MTK+i1YgLhm9aMnfFLUDhcwpm40cvHYorlmP4y4N3iMyxbjhX7XDeFVDj9D1wFi8v8cv2fl99rTnkr2fhvTcozbgfaGBnftJOLAj/mYKOcwfaTRxg23XDWdDvY5BgPUjKOi18Oio9m+9fLZamq6Kzg0wtL4GMFMBBnc4zjXDlAG/JKAbYnau2nLquZhuUe0qMjBL3xcq/p1wXjAWGQgPy4poItMteybgAr4idQFpSLc+D9MvHUzUmKUR6k1iH2r9JchF38BHDah2yyOy2EzcCEgn9YqNSjQbqiQzqkzarfrXRAOXPa6qjwZTYvrilZV4ZR/BHya8qHcJreMc/3q6/4CuvlZmYO5EzRhJdryzfn9+IBLXG50MkeE4b2DYqlMhi6dObGV5C7RAoeHM1efC3HYrv2AKrkhMZQi9nQUMq8fBvmavL4PiX1I64mXgHmoq0Xgq2ncPSu/dSg7jgxR6eK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(46966006)(4326008)(1076003)(4744005)(36860700001)(47076005)(7696005)(26005)(6636002)(70206006)(16526019)(186003)(110136005)(316002)(70586007)(54906003)(5660300002)(478600001)(82310400003)(8936002)(36756003)(8676002)(6666004)(356005)(81166007)(83380400001)(86362001)(82740400003)(2616005)(336012)(426003)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 15:24:47.0395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0fbc77-b921-4b0f-7cdd-08d9276ce33d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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
Cc: Davis Ming <Davis.Ming@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable this only for Sienna Cichild
since only Navi12 and Sienna Cichlid support SRIOV

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4a50c4e9aea0..29017b18470d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9217,7 +9217,6 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
-	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
@@ -9225,6 +9224,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs_sriov;
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
