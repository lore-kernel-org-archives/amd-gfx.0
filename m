Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A451AC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B8A206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="prBAqxNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B8A206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103D76E369;
	Thu,  9 Jan 2020 01:08:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932746E369
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 01:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKQfwyvcQZDl+VZf9AdlcXrpkvjSFiVNI+W5A4rxl/LUBKDAXzs1051oRJAujc8XsGrlowa9GkbfHZrJQuvb2SdwYA7Tum3thj2G+hD8oxPUbnd2Tr3nJ2udLiiuWw+5LaYSwyVRwsiA1S4b0K5diTQyWTJXLJjIfGvyPyoUQRrrKtumFM2/2cpPuK1yr6Wr3tPC0sSqaBCwS1ePgBQ3ZOuH5eTnbuR7zTw6ffaMwQhJN2Ozs3cpAaK/9AGrwdv4hPXHxv+fdgdFz0RXG5RJTLu8/wANBQNgnBGdvA1nrJmY523/l5UcosulM2IQPQC9wQ0TwQQG3+dCebpBBwsnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KibFionILQYCuuXu1tpqF/ZZAd3F0pE+qx6s12mThcY=;
 b=dWesBOBb3FeLOxBNd/ofrwMrxkICiQRbl9D0ZRm/+7NPCD/Lk7Zf7ui3JIReqs5uveo0gt0S2TNRUg6NJeKm4DGUIAG2zTEMsngr5KD+lwaRSNVYksbatTjR7PyrfjuFC1+Iamgu9vL6lcginivFJ0tiVWCbYyyEIeWBE1ECl/5//+TuqQ93YeL+m2nYZNXaZMn68maw/xMKrSR/v7AzICF5zgIpOUbi+oBXefa65giWuncVCp9WPqlf77ZIXWqUva6JmFqBhrXJM5VqpIRsFXo4Ir/4RijZLp+cj3R/4YOdYqbmwudBNQCQYz4h4/TlAOmkUXOyz/voPyjODs2NEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KibFionILQYCuuXu1tpqF/ZZAd3F0pE+qx6s12mThcY=;
 b=prBAqxNryIHJVKENoisZdef8C1nfKl1GbRvr8wdR+Q4W2gCkEurt5UJkaa7ynwWK64zz9yXBxYwChABoG5rg+pYhbDFHnnVRaeKZK8Ah/XrjhKXjKeKYLCSCMpr0Eb8UEKGDVZWhyo0P4R4n5zu5B0ySmdgBD/na8tXjF8mfI1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3224.namprd12.prod.outlook.com (20.179.93.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 01:08:02 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 01:08:01 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 Dennis.Li@amd.com
Subject: [PATCH 1/2] drm/amdgpu: add MCUMC_ADDRT0 offset to ip header file
Date: Thu,  9 Jan 2020 09:07:41 +0800
Message-Id: <20200109010742.30091-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0055.apcprd03.prod.outlook.com (2603:1096:202:17::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4 via Frontend Transport; Thu, 9 Jan 2020 01:07:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c39f51d-aa8d-4c8b-4419-08d794a05f90
X-MS-TrafficTypeDiagnostic: BYAPR12MB3224:|BYAPR12MB3224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3224492A0F0359D5F09F8F5FF1390@BYAPR12MB3224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(81166006)(316002)(81156014)(2906002)(36756003)(8936002)(6486002)(4326008)(1076003)(8676002)(6666004)(52116002)(478600001)(66556008)(44832011)(66946007)(26005)(956004)(16526019)(2616005)(86362001)(5660300002)(7696005)(186003)(19627235002)(66476007)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3224;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TkfmO63kpu5OoqEoooA5zeRgHV/TQTQjHGgkCCNC419ykx1SCaef64iM7jqfHREMTMJrqzl6zBoN3EeZfcqcdKh9LWu0aJ0v6aUOjGpA6qbUGyCdFopJH2Es1om8HEUxvhKWtf8Rlb2Ol9A561ASYe8azw58szwmY5FLgAR+IXAycljaDfIYYgSrIIKnJABbBFAUwpDAVb1Otgn7bWF7HfTerQeTKWJ5n2nwv7srEicXBnrcTg9Mcb+gW4GV1v9ksCY5v1AWmrmGOVY4KZhBhf+Q6viehY/a9mUFmQjTPkx72Mb6I9wdogdKjI7ww1UJ1Jy7qWHCAiO0/vMZWdA31qrX/f0gRcKJpHZFRwAJcWfZOBO7tyzri7fTFYhlF0PIOEvdhWYZgDx4imhQD9B7kzRMR4Jb+K7QYpdIHx15v31ulHVWQuN0Vd9UYYvIa7e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c39f51d-aa8d-4c8b-4419-08d794a05f90
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 01:08:01.6911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O28i1bAglB0QmAOkBQWv1L1VYUqok7qETPbeDzhztc1yWv1tYfYID/F5jX6PMB3eY943lYxxswiQZOaCUbSUEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3224
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Both are needed on vega20 and arcturus chip.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_1_offset.h | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_1_offset.h
index 043aa695d63f..0d6b594be775 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_1_offset.h
@@ -27,5 +27,7 @@
 #define mmUMCCH0_0_EccErrCnt_BASE_IDX                                                                  0
 #define mmMCA_UMC_UMC0_MCUMC_STATUST0                                                                  0x03c2
 #define mmMCA_UMC_UMC0_MCUMC_STATUST0_BASE_IDX                                                         0
+#define mmMCA_UMC_UMC0_MCUMC_ADDRT0                                                                    0x03c4
+#define mmMCA_UMC_UMC0_MCUMC_ADDRT0_BASE_IDX                                                           0
 
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h
index 03be415e9555..ce005c674a18 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h
@@ -27,5 +27,7 @@
 #define mmUMCCH0_0_EccErrCnt_ARCT_BASE_IDX                               1
 #define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT                               0x03c2
 #define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT_BASE_IDX                      1
+#define mmMCA_UMC_UMC0_MCUMC_ADDRT0_ARCT                                 0x03c4
+#define mmMCA_UMC_UMC0_MCUMC_ADDRT0_ARCT_BASE_IDX                        1
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
