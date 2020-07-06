Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC751C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BF520708
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zNd8KN9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BF520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09886E2E1;
	Mon,  6 Jul 2020 05:05:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAA36E0CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqZPfMUnqhCyQ4tGozPlOkRbfOIyrDa6ZPyBF5wwPNiHHEepLtOh63emOeezEk4AvYmzVo9VxxtBLuyVYVL0UmsjXEGLhudPPC5MBgy3ex8e3aKMpajc1apG6vRhoaTih5IaBmjWH6ofh82oOZhLKx/AoJA3g2jSQkBTD7w3n7YaSNntrx+R+b7Rn7l75IfTwgd/eYKH4BZh/S8nGX/UtU9b17+Knq+szsnTmt504P5+FZKZ538OWTozr4jQi7bsflLNkQlaLhjDNcLxoLAwWx6ZkNDFt7lmdSBtXCIBMj4bCq9Ek6ePzdgZLy3SVa/US0WxxaLWMqCyWxJ4H5KCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVjVwfNULT2RZAVuRML1wIqQCNM1mrfUbxbrfmdG1VQ=;
 b=cNbB3K59T06vLdJe2SkN67O8pYAucLw1lfq4rTioVIsSDC3H4DHEimhCIVbY7L5RiwZ6UL4jFVQTPJRY6LNKc8TlHwDJklND9u35Sc45LRwARpmmjbyWG8gRIjdRwcm8vO7pTEWIkfuqoIrqluGdeQ/7XWuMqndADojO/AAySDE3xaGWeN79KeHJB6t05CGfAJz48JR08y0wvFKbYFGcJkIU9d/I08jlJqsxVuNWpMUqkeDhyftjMVwFTvvOzUXUVeHs1eOGge+RollyqzH1sFA6HYxE4msjKScCzncsCMM31+F7a6SodLrDNFnuDUXBtHDCheJrjyq7k7BC2oQlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVjVwfNULT2RZAVuRML1wIqQCNM1mrfUbxbrfmdG1VQ=;
 b=zNd8KN9CClITmNRAtDaTHYtznvS6bW8okwLPwsNJmXobDsEF+uTdVJl1PHlO6PGzTqGpHxKjnylNgDzMQ2r2hdeO3Mrb5wRTcpUb8mWLKOxRPDzmwI+BvTTfoNk9WaZTYEBCJeyocvHd1NcoWWQiOZ7SjzNjAipUP0SLyiqQTzY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:05:36 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:05:36 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/12] drm/amdgpu: add register distance members into vmhub
 structure
Date: Mon,  6 Jul 2020 13:04:58 +0800
Message-Id: <20200706050509.714975-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
References: <20200706050509.714975-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd5bab3f-6b47-4fe0-06de-08d8216a3810
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470F69C7B87FEFC18545DC7EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:106;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b11zI9veZtyIqrjNTvu2VnUSVyysxDgNFuzVkUFiaE4CoClZoI/Y5jN5XCNxJ8Ta8W81FtQ4iH2nnO+5f/CCEZS4DQYtQvpEB8dj6/l1skOGxHjDlp+brgdnV320hPUqOzN2a4EusgIhr7BtMV9k/aXH5KfA6CuCW6v3zmaq4Zls6cAibMFX30ZW3DcRU7U3Z/FgAq/xd8kgsJhH6ahaRlo9xgwx4raZ/QhixbuONC168uIVkoBVghEFicOZbsYFLS4xxg/l9R2EGzGtueW4oVedANMjQVJOUcbcuznhwGW2kVANCwCF8INrRaq6NzVO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6q6OUOOkyAPnArfM6IULuxyNOYWQ9l7M2c54zeoATuq6il7oFy+57av+WWCVHmB8cCS426I0yfyLkRl7dEgBy6/M+KlZ0z/ZqrjuqtfIG0bcGZa4icasw1DHfZIxNUtQS3bAtRwHClVL5FzLLwi833oJKijw6PqQ9sqkEvn/DMPlHGgfzulZ3MD/XlHtcGI+fxeDhcJ7+6vqNsSLju47JkqXRpfANZhncQ9ifj1bNFeyMZY1b42+U3gY26qqc3ITTf8KH9DiNQmydmDfqN8Ins6vKbqwvn5ihojnZjp2Tjw3K9fdL8e9HyMJbwtlhK5+255c5eeRQ/R7tvyAD/Jba6uxBzkoHlNeGAYEd2IgaLrUq52KyToP9p7TuxT2KiAIs4Ff7MbgkPUZq1Ip2CpgYZvjSCDeJKfWY4JusQfkjBCtUiWGISJOJ9AOBQE2TN4WA3+1DX//oXMe8OfEXJdqAzj3H+v8mqe+vmO90zivVCm6ZaPiKlHeGt35sPNjU4yT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5bab3f-6b47-4fe0-06de-08d8216a3810
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:05:36.6378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Phwfq0nwZmYHxHbY/YAAqH3lw4PvBCFY+lmMk6G31c0Kyqh+nqexDBPqojp0xQRhQxY6Ycyah7NUG6a3m6Pjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <anzhong.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to abstract register distances between two continuous
context domains and invalidation engines. In different ip headers, these
distances may be differences.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 9 +++++++++
 7 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 2bd9423c1dab..acdb61cfa24c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -83,6 +83,15 @@ struct amdgpu_vmhub {
 	uint32_t	vm_context0_cntl;
 	uint32_t	vm_l2_pro_fault_status;
 	uint32_t	vm_l2_pro_fault_cntl;
+
+	/*
+	 * store the register distances between two continuous context domain
+	 * and invalidation engine.
+	 */
+	uint32_t	ctx_distance;
+	uint32_t	ctx_addr_distance; /* include LO32/HI32 */
+	uint32_t	eng_distance;
+	uint32_t	eng_addr_distance; /* include LO32/HI32 */
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 6682b843bafe..c51833fefc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -386,4 +386,11 @@ void gfxhub_v1_0_init(struct amdgpu_device *adev)
 		SOC15_REG_OFFSET(GC, 0, mmVM_L2_PROTECTION_FAULT_STATUS);
 	hub->vm_l2_pro_fault_cntl =
 		SOC15_REG_OFFSET(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL);
+
+	hub->ctx_distance = mmVM_CONTEXT1_CNTL - mmVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = mmVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = mmVM_INVALIDATE_ENG1_REQ - mmVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = mmVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 6939edfc5232..e4340b27d204 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -373,4 +373,12 @@ void gfxhub_v2_0_init(struct amdgpu_device *adev)
 		SOC15_REG_OFFSET(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS);
 	hub->vm_l2_pro_fault_cntl =
 		SOC15_REG_OFFSET(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
+
+	hub->ctx_distance = mmGCVM_CONTEXT1_CNTL - mmGCVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = mmGCVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = mmGCVM_INVALIDATE_ENG1_REQ -
+		mmGCVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = mmGCVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index fcc4c1912513..39c9c7856d0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -372,6 +372,14 @@ void gfxhub_v2_1_init(struct amdgpu_device *adev)
 		SOC15_REG_OFFSET(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS);
 	hub->vm_l2_pro_fault_cntl =
 		SOC15_REG_OFFSET(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
+
+	hub->ctx_distance = mmGCVM_CONTEXT1_CNTL - mmGCVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = mmGCVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = mmGCVM_INVALIDATE_ENG1_REQ -
+		mmGCVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = mmGCVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
 
 int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 405767208a4d..ec3a40dd52e5 100755
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -429,6 +429,12 @@ void mmhub_v1_0_init(struct amdgpu_device *adev)
 	hub->vm_l2_pro_fault_cntl =
 		SOC15_REG_OFFSET(MMHUB, 0, mmVM_L2_PROTECTION_FAULT_CNTL);
 
+	hub->ctx_distance = mmVM_CONTEXT1_CNTL - mmVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = mmVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = mmVM_INVALIDATE_ENG1_REQ - mmVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = mmVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
 
 static void mmhub_v1_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index af0866af63a5..9bfb77c42fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -365,6 +365,13 @@ void mmhub_v2_0_init(struct amdgpu_device *adev)
 	hub->vm_l2_pro_fault_cntl =
 		SOC15_REG_OFFSET(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL);
 
+	hub->ctx_distance = mmMMVM_CONTEXT1_CNTL - mmMMVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = mmMMVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = mmMMVM_INVALIDATE_ENG1_REQ -
+		mmMMVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = mmMMVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
 
 static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index c0e3efcb09bf..df2c316accde 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -534,6 +534,15 @@ void mmhub_v9_4_init(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(MMHUB, 0,
 				    mmVML2PF0_VM_L2_PROTECTION_FAULT_CNTL) +
 				    i * MMHUB_INSTANCE_REGISTER_OFFSET;
+
+		hub[i]->ctx_distance = mmVML2VC0_VM_CONTEXT1_CNTL -
+			mmVML2VC0_VM_CONTEXT0_CNTL;
+		hub[i]->ctx_addr_distance = mmVML2VC0_VM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+			mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+		hub[i]->eng_distance = mmVML2VC0_VM_INVALIDATE_ENG1_REQ -
+			mmVML2VC0_VM_INVALIDATE_ENG0_REQ;
+		hub[i]->eng_addr_distance = mmVML2VC0_VM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+			mmVML2VC0_VM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 	}
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
