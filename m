Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F8EC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 07:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B83221FD
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 07:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GzCt3JC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B83221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7BD6E122;
	Tue, 17 Nov 2020 07:33:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC9C6E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 07:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwZE9x91owKcSmrUGVZNbZc8QwX1jVfvD6ibNmT4KnqiNkCh41OD66POQXV44vhveAefFlxrgNDT//S/HY2JCxzAp7w+na/THGxt9p+W5Vn/M/Gg2XF/MUqEPGandSr82yzvsoC8tmTz52CTK8rpdINU+Z2cnTp1WRGXdroEExgkMXpDi6x9zpP9tz09aLv0mEX1i7H0bBYoMXg2/TgfPBRaCDtMoJpRWNZPtufgITHsJ2+5ixVrc3PiZluR87ahH/f9mjh2Dr9v5uD3sT/hNfg6L91QyYmjNIBt9LIGL2Zdqzj1Bn/GGdGdV7sdZxLfSGClvmKkA4BHsuRGlsGrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1IFitAX7s3tSS24NC9Hz0XPYT+hUGMnC38wS7F65IQ=;
 b=B2xhfDIQZUz3bkQP06JjWJHkH7GFlPeTrUSNjiLWQIQTyprBy71CBD12ak0rcglkohsEcxwnhlftMtxqmZQO6zh+LOPStkPxoA9PbcnVCG/sWD3cbNPpDS4edL3KZpPo4r3CX4qpTSEkKI+F628yJnYVeplj2N0OqyM8dp/hPY81n7Vo7b6clC8iRVHP08nGCrf9Sh8Nk00A67Sm8nwkthN3+h6xpwjXbhg8p0FNIRx3PqVjff5l8sm7M7PS7VyWBVO+b0ReeB5CkqJTdDf1KdOONSjhsMp7MDwaBqckUIL9ONanyKjvf3cIt6wHbtAx5IxX9701knOJ2OVMTNypbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1IFitAX7s3tSS24NC9Hz0XPYT+hUGMnC38wS7F65IQ=;
 b=GzCt3JC0qANTYZ2w9zLxlcHD2WyAwrdTH2Rm3jE1ZS87jvhQ/ImXy9iZ66hk1HYimIKe3C7zXKDG4A5j8tXv2Vy7ouewpZG3QmW+0bnNtonirYqO/UctEVeZ7iKCL0FeIEliShCOCajherlTa0WbhwEGiEtAb/nQmWqGcgJXjKY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB4613.namprd12.prod.outlook.com (2603:10b6:a03:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 07:33:06 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 07:33:06 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: support runtime PPTable update for
 dimgrey_cavefish
Date: Tue, 17 Nov 2020 15:32:40 +0800
Message-Id: <20201117073240.10777-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HK0PR01CA0064.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Tue, 17 Nov 2020 07:33:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6a0f539-28d7-4c42-d972-08d88acb062b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB46135EAF30BEDF0DB289027DB0E20@BYAPR12MB4613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MQQaGhVdlYTBDBlfRp8UG2lm2t3qX/jie/eVuGH9klfhS04NASbhjkczP3hOjzXTAvY35QVTCWZxXwLTwtDxJ7JJIX9NUlPq18Oj1pSiUaqoVDtENcPTp0JYwdpRCjMosTjrrTS45KhZkNnHo/1niFo4zJqg0bFe7HElAHUqYQG/bRa1IppNVk5eH7lFypSgeLssmx1tYGYfS/cou246OFeOG1MRmqKjmAzkJd/JkpEyKTQ9WLyJ6ivOu7VI4xZ9wJT35cxdqSr47xF/IpZb7TwB7IYLfcKtPLq22g1aUv3JzSczWAPAvh5kLIbAE7aCdu7nuUg79xu1DT1QMUf8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(8676002)(8936002)(2616005)(956004)(4744005)(16526019)(4326008)(5660300002)(36756003)(66476007)(66946007)(1076003)(86362001)(6666004)(316002)(66556008)(2906002)(186003)(52116002)(478600001)(83380400001)(6486002)(7696005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OAkbfPfdAp5wPKhANuApFqm/LZjZPaGUlEX6WzWIPnDbKSJ3iZPipUq90H9redDHXaSRz9lT5FA0zy8fIrhwHRTHpBaiRuMOaZb4m43DUomKI2i6g3VuXCGwqF3v0TwgdxfPTFQmDpIh3sNEFD8wMByJkJfLdVtS8HzqY1g5kW9zlBfhvHJB4pc/oPW0LQcySOPQb1ExRHowaUU+rjxAQnY8ucmxMTRfFLtRAp1Qg2HzjbwF5VRui1txbabKVGkE7CDK1cXxeDkrGdvWpqgxZskBBjK8UUHDCdT1z+NRjTN+L6dqTodg/zkQ+AL9pn3Ezb8sv49nfOnuAW7cHbjrurHTKyry6rpBpDfNbV2e0bRd/tnctU2n2SJl89aONvW1jw8iqhhNn190RP8VySY30fUXUmKTzj4pZAMe7cHMFE4JC6k1xDJCB4JQ5UDcAURojKrn/GGAJSvdPqQ8iCdmKLA7M/onsUANVK4wLA2opMZeFmpY4VN+Dul7J947OpfviX1MvMcIRP0aWTydHEAHzAro8QgMmedUk7+YRFERwr0SKQYvrIpwZWo6MdMaDcO9Ebm56MNpTNJFbN++83UuEAKRL6hlv8HXCh/HkykQ4L1pFNJjozHZrvG2rzU4SOYcKYIlEBRGofZ/M+qWqFAQhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a0f539-28d7-4c42-d972-08d88acb062b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 07:33:06.2354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CVNCQToxNA4VhaJBzQaWzDaQugMBFt2trU91xQYXl3rSig9Zel7QJFW4rVRGaw8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4613
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

There is no need to reset DPM for PPTable uploading on
dimgrey_cavefish and PMFW can handle it, same as navy_flounder.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1904df5a3e20..8e3e7a5bbffe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1183,7 +1183,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_NAVY_FLOUNDER))
+	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
 		return 0;
 
 	/*
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
