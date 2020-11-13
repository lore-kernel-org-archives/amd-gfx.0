Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9AAC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 08:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53672206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 08:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0djJGwUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53672206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A189E6E3C1;
	Fri, 13 Nov 2020 08:51:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157D36E3C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 08:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeQcq+O2Ha8T6ETb0Fbom9E6MrcAUs04C9CEeTa5UtUKeGXoHx4aOaoByPYYYLnvFE1scmqT4A7cNzklW5Hkg2ye+yErC70g9fAUWmRJp6zpcM+2Ym1EAUpJUyUo7n0xf8ZOhLoAo1vj1IslkCiBgOTP32XqOXAr/WOVzu4ICpOS2kNmEwWWLrxB6PF8a5hdnKsHWb+ffF+fo2CVCsO+vFtCRvhK0ikbZJkQipADRaFAZvVqSf/IaJgGlBFgB1Og2uED20MBNRFcPHLLco8SB839zN5mFLwSlZXtXac1J/Xct2viuqVJitUN5PnwBnpyaS/MbFumv3qXdS4U2I9NvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+hC7M/6s1ias5ua2Q8P8VSLXcnpUHIWag7xEluifKo=;
 b=CTZXeRG/sOsr5jvLONtn5LR45F/6T9C51i6qgHCbhW1PQfwdveZpOeSiz6VNbUVVwF9DlJZYiNHqdDUiJ0EDFLDnYE+Xwm5spj5sLqeuKZPmaqkv6ULddGJcM2AA/Et95LtB4x3gJUNFauOoBbjhVTpa5rtsEXpjRiRucv0leE9W6PFXGkAahg4HLU73YEBW0+DqX15ceI/BEWQyQ9UR3V1H051XbMzg6XRDXk4g3Olxd6scnM4iMgcCio1P0UdhzjPmiKCTnCyZfIVv6EkEkwiTMWaS10mFLP5BaP5qJgansbcsCnvc5SS93lv7TSJrYjG9saUwSCPqecMszYPL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+hC7M/6s1ias5ua2Q8P8VSLXcnpUHIWag7xEluifKo=;
 b=0djJGwUMh7A74Ood8J0ygkoE0ammZVNPBr6qQu2f0bW7RXQPSxOkYY0KCNn0AZtY1v9rkaDKOkOBVBqWcfoVAf02txxLv0tQE/QazGGt2GMC1uRaL2HZs9O0mPDwcGxk4i85bptu6F4gwHi3f/LCW46wuTof6HLH9KZYArqfCbo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 13 Nov
 2020 08:51:07 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 08:51:07 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Date: Fri, 13 Nov 2020 16:50:52 +0800
Message-Id: <20201113085052.11234-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Fri, 13 Nov 2020 08:51:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1bc83609-c5cc-4a02-08e3-08d887b1428b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB39564F38285536B72DF09E22B0E60@BY5PR12MB3956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+dSVJGacSPqzyM4PJKeCtvEAiAOHo4EzybPOrV0Dr8BSVguWYG4bYD1wqTq9vpKcXYr5GnR0pOFLSwpUyPIIXvR+nXrhdL6a5IO0fuFkI99iplUQNfQZjlj3kYCm29EBGsFTrQhq2906CJyvP4mNaQ6FlAlrOwlbHRT5cQeMd68IPYadpORY+nnRiFyGMY5kJvrcUepWTV85z15ph+2mWkfd/oUCMAutE7KgGC3Yl3esp5j+KHqmge9J7boePjpj2vSUal+7qibOh8VwvFHuLnA+rffHO602o+hlasW2Kqts2erU+CegBh3WXYZgo44cwAQb0MG75yVv5jwhqoeTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(8936002)(66556008)(66476007)(16526019)(8676002)(4326008)(5660300002)(7696005)(26005)(86362001)(6486002)(52116002)(2616005)(956004)(4744005)(186003)(83380400001)(66946007)(1076003)(2906002)(478600001)(316002)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xIdaoVA++QQMNo4F9x9TCW5i1yf7vyMgM4nDW7Mx1uhr3qlzPQRc9dASmnbvBoow2M5fkv1LHiGquPEYbug8/hOL+ZdFWoa5nz5qsOtjhgZDbk7QNHCgen6Q6Y5jp0rBaBrl2eqPC+lAlnxBsFjuiJ6Ws8mtO337wz/JfOYYZvN0r4je6fTi0NyK3rGFBcUmT0bbT0IesurB0aTf4+jWIu3J/xKuV7lJYA+m07Zci0BiCawIErbYiOy4n53iTQnUbxgjMw1YiM6IDXfGOOkDRI40gGnGfzcVMa7e2dASlVvcMoWrN7L2PQK+uMl7s2L4BfcOhMyXgFO+cHxDbHVhKYHIs+arHkL97MKs8tGwfjj7WNz/PzC/QxKwwWWeR/fmku6effFncRwICuBKfFGfTmaoH57iEj8PiDptI2qh7SQfqUp3vzh4b3D6vwlcRSEt6waD4vtnLH1KRH2ghu+3lwSImzn1moPItRoOUaRaQ4t5h+Xz4eQs39MZaD+X7d2g9Q1xoJCYS3te0Dnp9MG7eNGEJnRqg/Ypyfd3po+1JIGttYbWywy5J5UwzhYiDsGtCp8lUFH51rq8n5awsP8NPu4P36l7u6Ol0TqC2BR8yY80711uG7PrBcuV/YjgLZRMns5uNzs3Pcwh/7qcPQJf/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc83609-c5cc-4a02-08e3-08d887b1428b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 08:51:07.1462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9hPC4PLgaacjafx3TkUwBE12Qd90qD1oXDL+CSEwjw7fWZpDgKjZj4jbVs0vlWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
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

Per PMFW 59.13.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 5ad693312187..41bc919dc9f4 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3A
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xB
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
