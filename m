Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE744C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A164320715
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yIITocQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A164320715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DE56E320;
	Mon,  6 Jul 2020 05:06:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF766E320
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPPbIrtjY+436OBM67jGsf8x5n9A8WQGV05pK+lxV+hyw+JZG/RQuQwYb1NFg+UCqx4j6yzUOG5zI/wWX8MR7HqnewCtwYSjCBgP78immg1ZxD5ldE1o4eXLhyw3jwok5m2PozPGP5r1o4K9trSqFqaC3Kaj7gAfD78GZo1DpXVh2KmeFRvMDmMDkmGaE/4T0gKjYsvxGbmFT4ufqA+tHWPRt3bOb7n2NMsmFEGkQjCn6BIJy/7XAyoluKMf4X48DNPqRWWFEsP7myQFYQBYFPDtsUBwArLJBN83eycYeucil9ZF4WEUUAbxAErqYSMRQNPJZ6QxigFcaFh8k3DpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJHDJpOID7nOKXL/OgltGIe3xX6EDNeADpm7RLirWYg=;
 b=flPWI7OT1sf3N4niJmgfsxXi42JXwTAHgL2p9e6hzAvVDO50CkMEZU3E3HgL1/eV5i4y1XVixzcIDpYX51fGDJtJ0zHQcQYQDQ/YkvU7EZgM7kCeUwXVSWb8cI4NuM1QTreN2fIeVmrDj/MJhsu3spMoO0Qsdd3YYvGTLg/Vtdj8MQljGkuU8HSslzT77ddmZ5BtzzRVNLRN32yCBsQlPqQIzd8u9Bn96qYlKRin58dmu69zQVADtUv+ZcB2EuT3Zu+R+0glQ2uzDrm4vYlTdXg6ww30JmHco2MUd1QgqMRP+OrNvW/E94qfluE3Dn7bTxWNHs9+eOmoMxzeEYUykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJHDJpOID7nOKXL/OgltGIe3xX6EDNeADpm7RLirWYg=;
 b=yIITocQO48d3thnWCa6w3FoBaApL2iyxJ2FVYqZiznaKtcFQbfNu2nNeyO5habitqw9YGc9S1oZYl57OYHk0B6rS42sNjcmSrOqYUTYcknh+jVHZPRmdGjZWak2/lMpq+5t8ixTRBRNnWyfB2LP0+c2BK55tXioZjH6d/4JfkvU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:06:10 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:06:10 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/12] drm/amdgpu: use register distance member instead of
 hardcode in mmhub v2
Date: Mon,  6 Jul 2020 13:05:08 +0800
Message-Id: <20200706050509.714975-12-ray.huang@amd.com>
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
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:06:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 010c31ed-a8bf-472c-d84b-08d8216a4c19
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470AAF03456878AF4E0A877EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gH4prCbLhIsXr2XvplJY+DuhFWFNViI6rj/2+uG9hmHUSNRUkwNL/TVugFxqC9MIKKWC9uR2hGnYxUc1VCoWHUJCYGrxUZ9C2qHpESIkgDyhLjAEdzWCxkve4Kild8nl5rh+x39IVKc4fE7vcdr+hsTsiDdpfV3Pa/bRCY7trORigD/8NtT/vHVDuGUAl+Dnr6H2aaH36owEzA42tnUqxUJdWgLYQ1jCDwbmR9s5QRNZAbD1XEUU5tTSSWm5BRg9WcJeSeoIzSmQIItFFOYFMrbYNYjkEvl+oAPb0RN3IlwXDM6eDxI7a2qfqe6Kok+v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9+d1BXA9dvsjnlt6PYBUBkbd39jkZLnJi/dg6KULPlXk17klndQoUs6IPw3pwGWnCqZtFZa5AIrbGdAezBSutkTkXvc0IMkVzgQE9xWrG052XTf3h2rPS9lLVODLe9u/5XUiNlb+oXrLjMWIn1/E98JNaOHYhtMhFouCPy+WWql3BwhHNP4B6JN1rJBi1qCaKv7deqB0AAyXvHkbzMgi580XJWrBrmpukumVLnVeCeo14eEoUkAu8VY+oqSeoYc5upzXzit3RIBLKqfFoUPAA5dyslPZ+cJxupOGW1vLqPC/H8Jq/MigMjnREG0/cMgRx27iZ7mII27xYXjlWuQABVXIwoWov6bhIqDWJgjzw/5OpD4OT8DUSkso3YOsvg+mp05u7XeHAVe5tGK/ZRno952EYCbbbfRGXqqyeQ+ncM65EZqbj5EPWZzWw6z2T+qn7J4e7TnqNlaKZ3EdMBYIIyXdpjqQGCTwL9CYzJ9+M5ETEOmOSbsRBBOEbvYfCyx5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010c31ed-a8bf-472c-d84b-08d8216a4c19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:06:10.2236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG8fMF6gzrGQHVreJquzYDjuFhWsHQZ0Sxn6J4AgbRoiahoOB0/csiBDmxf3mLrTOH7N0ykwg5O88Sn3gwURHw==
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

This patch updates to use register distance member instead of hardcode
in mmhub v2.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 39 +++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 9bfb77c42fa4..d820fa02e6e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -39,15 +39,15 @@
 void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	/* two registers distance between mmMMVM_CONTEXT0_* to mmMMVM_CONTEXT1_* */
-	int offset = mmMMVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
-			- mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-			offset * vmid, lower_32_bits(page_table_base));
+			    hub->ctx_addr_distance * vmid,
+			    lower_32_bits(page_table_base));
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-			offset * vmid, upper_32_bits(page_table_base));
+			    hub->ctx_addr_distance * vmid,
+			    upper_32_bits(page_table_base));
 }
 
 static void mmhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
@@ -209,6 +209,7 @@ static void mmhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	int i;
 	uint32_t tmp;
 
@@ -239,25 +240,31 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !amdgpu_noretry);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i, tmp);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32, i*2, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32, i*2, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32, i*2,
-			lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32, i*2,
-			upper_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
 }
 
 static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-				    2 * i, 0xffffffff);
+				    i * hub->eng_addr_distance, 0xffffffff);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-				    2 * i, 0x1f);
+				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
 
@@ -279,12 +286,14 @@ int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
 
 void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	u32 tmp;
 	u32 i;
 
 	/* Disable all tables */
 	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_CNTL, i, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
 	tmp = RREG32_SOC15(MMHUB, 0, mmMMMC_VM_MX_L1_TLB_CNTL);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
