Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35294C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC32A64E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC32A64E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D846EB3F;
	Wed, 24 Feb 2021 22:20:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACED6EB42
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apokB7S1dLm4eUlLCfD0HX/aDHyyyq7es3tYjKH1rqbxYrBiypbjJpVAVHqejIATpUU/v7WZlTdo+Tfg3wN6Z7DmM0PU6eqL7gyf8grifmECxFYRfILDYPJe8HVhiEnp/pvpbXprB2dVmCSIf9e3JxxsAvMc09VdWTFRN1938/+hDhCFEUjIDWKmporVm5UDKTw/oTLf7GzWlhVe8tkmhUWgHJC1lYEk4wJpPn7F4Tokhhi277muEy1EoYecPQsUf9k5x6oMgPxX6Ikkf1z2ZyGbcv3rqzQ3evrTwwGMHH3Ne03gUtDo/3/xttQl3N4Y/a+k4joRqkjAYvVnXHxFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEniAtCrthQec8QlhWRlTbJLHq4NCLnQuJKe58ZZj10=;
 b=Z/fCqD6gYK35DA14MoBa1x0ZAyhUWNHWhejoaOjH9YiZn62dU2SgSWG5UJuEYVd1qmeQqRjQzmbeFEOwNOCRe20Z+G2qfwT4cbuQlR8jluklkOjheIzX4Xsw24dAc3hdwrzFPxEMfoN3cT2BgfHmBIQhy0bamonJU2mEWpAjsUk6QXwd8TbsFgoe4GzJfUZ4a6/DIJZEh3anipF4OXHcMQihotYGEf78mF+WeWJx2LpZuBcOcV0LS46J3BTu1GMqpCCjJuRIqqUY5dvhH2w+Dp9hiceRZiXEp8vyk3rrKzrbq6DZiWY0jhmbhKStlDoc7776qvsY9h8fGh+LxJ4wOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEniAtCrthQec8QlhWRlTbJLHq4NCLnQuJKe58ZZj10=;
 b=RYDwI7S+zaQv3bS38T6OfnwdyIxai8oF0wbj0v29KzGFH0gbRuzpGNyA1NJuW4ghH3tfSaog5vK3XUvVdsMvnLj6E17muTa6vcRFzKgAj/lTmrebAgk+t/c7bXiWZ2R60g4R+iElfsgqE9SYJ42DxISfFRTLqj+SULjU5GQwfpg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 056/159] drm/amdgpu: switch to use reg distance member for
 mmhub v1_7
Date: Wed, 24 Feb 2021 17:17:16 -0500
Message-Id: <20210224221859.3068810-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e0ce2b6-50f9-4f13-7f8b-08d8d9125256
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41753E5F4EC21D4E257574DDF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ngko90f2+XHU4t2BgfkYdwrCLevKZGIB+gWPTwzDBG9pJgKtfIfVcw6ytwPzHzflJj+DUzVaGKY3lrPT/CWn1cx98OLJuAHLuMwJcPDiPjw5yx9gXmzG6Zc8Fhc+Fd60N8BUBywaOz5FQGBJCeV0ddC8uPAsDntKciljvsVliHojj9GzDwZxGf6bjs8EGmBYuqnhH9+1URcNtovf9brU6vSyCS23xTqcFeFOdDwifReMrq4pNCGWOqmmMiMtRHk/nX2OnCplpYK17mKnxk8Vqy28vP+F6qzIpj1J8A357/Ij8F1HHxponALcBTdxyuQii6AthWf/VsVUAk4/l1dZHiZK9bkGSlpZCp9u/OotcdGdTQ/WqZuOvo7z74KrrLvDkcgkN5whs2RoHWp/eTNdEdE61xezMRSN7q9lmf+ZaZSi2yKXjxTEaI6fnwpEnZLopuZxTLZV1JQKkQQ+gT3WgyPxRk3vfNwZIrYPUdu7t6WfOgk0+u/r4Z5vwy+o/3DDFWqDjY/quaLpr3vM2Tm5OP+GHBImnaeuKyRGK0WRePfudXuZefXKJcnRHxQ5432N93uAYWUlyp+QKnYz88Dsow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0vCzYovz70TYl5wwRO8qxtxAW9YEsrAHJbvvIJhfMb28CZvXDHe+zx7yhNVA?=
 =?us-ascii?Q?rOV5+8gp95vCX0qGyu1jg3cSgJ11EbjOgRuVbz5uIhjiCfRYqBDtVcYPUNty?=
 =?us-ascii?Q?knnqpHQ5RRWYt/fO90dYQPmJTZMmLW/4405GA6V4uUtYI+hYrnvrMyJXNMIj?=
 =?us-ascii?Q?cpEn6hUpajD5MmksqDy9NCV6MFfQfKRUBCD8hg8onZXzPO2QO+LeQaYdl0gT?=
 =?us-ascii?Q?fZPrDT13HaTwzHoGq0XROM6NL9/Eh+MaYvFDreBsRCCEHNXmXQas4SBEhwdA?=
 =?us-ascii?Q?0YiYpybjBbJGhHyNFsqvMudNTudE3ZzBZ9wN7FL7uVI3jBnTMNdX8brcEMmH?=
 =?us-ascii?Q?C9/FkC8jStZ8YG+Px+BEsXKRPZ5HJVtNBy0fIR54U/nQ4hvFuTa2n+PKkjMy?=
 =?us-ascii?Q?Pc+nXBk5lj1UoTu4oz7KcQufY3N4zCjFUfmbOC1AQ1ZXzPABU0TWuaqHspAZ?=
 =?us-ascii?Q?fFrNGDYSAhhkojpU3HqnYYHr6kPenXwgWsaehyFCczuGLDVEREWHZqe6GeuG?=
 =?us-ascii?Q?kmuApkHC7cyiwTaMSBzw5iECfo9XjrFQQGrWgcdv1P5BBqTPMJvofczjPw7W?=
 =?us-ascii?Q?n5YA+bDDp5dGxt0p3Q7RhWR6PxpjLZfy4hfsdSOS8g0SSGGporKiirrrxHQx?=
 =?us-ascii?Q?304tpsNAN+IiITMdsWyJ3/9d/mKBXTelXwQV797v8OO5ANDOVTwD5g3mTu2Q?=
 =?us-ascii?Q?kArQ3Wwj5CZn21fPHVlRUGPj/Y/UvFhWB3gDR5PxaHk5hEUL8bBk7OAT8rmQ?=
 =?us-ascii?Q?YS7QtTe8Ffp10RNhbhQ9F+1rLpxSt8FJtF5WnYulpYXzcrB+w00gYzMBmo96?=
 =?us-ascii?Q?1RAgOwwd5h+gO+lhe6hiiJwQeN19hyvVzUg7cv/oUG0bKHTCjh6P9wDsxRWk?=
 =?us-ascii?Q?zHAejBiT/yPyOzMX/+GSKeSYw79JQMJRdYq5gHa5cuypBPadRhM6/nLC15Mi?=
 =?us-ascii?Q?JT8/4v8oC3PVqT+Jv2Jd1aL++dm3CtQ9JpeVYIvLjseKRvCWjVP1HWyJD592?=
 =?us-ascii?Q?KGmTul7I2p9Xo973IRnfmiLJH3uA+/xxp1kz82uHPTSZsBGzZMShOn6ZkJ9w?=
 =?us-ascii?Q?ajQnSCcE64SdRr4UA3B7qkEvcpDW6yJSne0UR9p3qLhTMCaTOz6MSi4uOIdQ?=
 =?us-ascii?Q?Q0+wThPITSLg0bO+cS1GRH/tMjJfjbpwsmVmM04h0WY4XJm4FOR4o6admaIf?=
 =?us-ascii?Q?KnedsgB1o8I7IjiOdoL846EQi/W1GX5PAY8WBgSFMwdrNw+Mc2xMtvHr1FOn?=
 =?us-ascii?Q?ILuUbsbjkgKnsxpUNM3f3fnrVGd9tnYrtpBsUfALikine2EPpeJ1ttVs4zGg?=
 =?us-ascii?Q?JnhGEaRrt6Qr3mpM0ew7fFcu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0ce2b6-50f9-4f13-7f8b-08d8d9125256
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:58.9483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9FN2jAggXUqW+B4ciKAS9TtQmByfZEuGYpJaSW5/VybEGc2+e+pv8UvPO8+bVe1jIQXichxAma+uJiAL10qCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

switch to use register distance member for mmhub v1_7
instead of hardcode

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 44 ++++++++++++++++---------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index bf339063008c..a58e03802c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -56,15 +56,13 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	/* two registers distance between regVM_CONTEXT0_* to regVM_CONTEXT1_* */
-	int offset = regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
-			- regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-			offset * vmid, lower_32_bits(page_table_base));
+			hub->ctx_addr_distance * vmid, lower_32_bits(page_table_base));
 
 	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-			offset * vmid, upper_32_bits(page_table_base));
+			hub->ctx_addr_distance * vmid, upper_32_bits(page_table_base));
 }
 
 static void mmhub_v1_7_init_gart_aperture_regs(struct amdgpu_device *adev)
@@ -222,6 +220,7 @@ static void mmhub_v1_7_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i;
@@ -260,25 +259,31 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !amdgpu_noretry);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i, tmp);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32, i*2, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32, i*2, 0);
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32, i*2,
-			lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32, i*2,
-			upper_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
 }
 
 static void mmhub_v1_7_program_invalidation(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-				    2 * i, 0xffffffff);
+				    i * hub->eng_addr_distance, 0xffffffff);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-				    2 * i, 0x1f);
+				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
 
@@ -312,12 +317,14 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 
 static void mmhub_v1_7_gart_disable(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	u32 tmp;
 	u32 i;
 
 	/* Disable all tables */
 	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL, i, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
 	tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
@@ -406,6 +413,13 @@ static void mmhub_v1_7_init(struct amdgpu_device *adev)
 	hub->vm_l2_pro_fault_cntl =
 		SOC15_REG_OFFSET(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL);
 
+	hub->ctx_distance = regVM_CONTEXT1_CNTL - regVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = regVM_INVALIDATE_ENG1_REQ - regVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
 }
 
 static void mmhub_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
