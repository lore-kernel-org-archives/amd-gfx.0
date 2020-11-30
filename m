Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8359C64E7B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2595720709
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cy+zF/R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2595720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED3D89798;
	Mon, 30 Nov 2020 22:12:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AB189798
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 22:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cakHNVeXpuk/3tW1hCkp2/ajwEwfuXxT/pLDKmt3W2wx0R/cvmF4dJMbUHDsxrntJspNAU6o2iXTkodG96RT4N2bK7zAzC4DUdfJgoTGtDLjHq6EcRY3JzQ0kPcig+CUeyDTsT/ZDbkgw8K2k7MzsnH6Q3Blpz0SPJXy71T/tLihU/orZ6jtlr0rVV8iU4iTJYEBFa302J3FPF9j5jWrQCC0xZhhnX7BMV9TgKomlH3IZwuxcGhIpvwRk7WmLVcNm8b2d3rJUWTZcOBKmmgyBISaOph3b1h6IiZo8xLdcTE21XYGlOSG8Mf+zx53DdANGuR90wPA+nRr8FnnHQn9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyDAnqlBlOUeT5iowSWVVNuBwZi+T59aF4ybHBpPzIo=;
 b=aEx1GsPAbOBnnXfCqx/Ob+NeXowCRYaGqBDuyDHeFrTXV6P/rikNXQYlN1GC9g3d01aUMnWfAJqPDoRrF0iOdB79hg1NIqT1a3DHXy8P5cHzEDXzajXEx3ecZVf4oH+Hgl+T/WbiOWWIjZlyBKh8og8EWiX1acKhhnMDv1/zYVDgy3AVsyhtsDNZFkGaHK7FCR26ZFpNg9ecTXlP3H/5gZHPQZb06CmeRxvzxj+/hnBT37TsSxXVCJpU7xNGztWaGpJuS/p0NfsF1hLwtO3UcjaCMSY+G/snZ5Wx7LYwphOC/SJVeohFnNisG3vf21vof0S/CGRx6h6o+WpwLy0I7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyDAnqlBlOUeT5iowSWVVNuBwZi+T59aF4ybHBpPzIo=;
 b=cy+zF/R1vgT1pLYuJCUSAs/McozjYaKN5wF9HSYy/IDVzvB1siw3gR68iIv5njW+2vS9j4GUnjccWdEmT5XOooaevcZVv87zqlaADDlaEyf41f1o5418efctMfj3GPL3PahyXd1Dq+Tm3V3RWdFzTjki+YqZ3yeYzJpVqPedMBA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 30 Nov
 2020 22:12:42 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::d055:19dc:5b0f:ed56]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::d055:19dc:5b0f:ed56%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 22:12:42 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] tests/amdgpu: Fix a typo
Date: Mon, 30 Nov 2020 17:12:27 -0500
Message-Id: <20201130221227.84747-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.29.2.404.ge67fbf927d
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: CH0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:610:b1::19) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 CH0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:610:b1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.9 via Frontend Transport; Mon, 30 Nov 2020 22:12:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8f4ea73-71dd-45a3-15dc-08d8957d0e6b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23603110F7237E32C54B473B99F50@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ou/4phUgQFe5JKo0XPiMN9y99G9yiKFonkcf4grmXeZc7OuIyZ+aMg9lMmtygKTy9+NQFzDH0mH02jYasulj55M71eZm/O1ftXG/7s6okqChM8amG7SIFdUyv2cgY6MbUAarK/tB9Q3i0K3zSPh9BvX/5JMaLvq87JZTd1U1TC+j/afUq9hD3X/eT4MkxUDI7JYjcEFE6xygpIcVcp1+Iqu8UQ+kG3mB+gDTuhR8KYPnSLsUIAEFrAyKvupM1GxtpL3Q0d+vNSeH3gvFYOrDQtn2Lzw+KPVbgkzxwpAJMe2qStXAetFrz//XYynrzQz8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(86362001)(4744005)(7696005)(44832011)(6916009)(6666004)(52116002)(1076003)(83380400001)(316002)(36756003)(186003)(5660300002)(8936002)(16526019)(2616005)(66556008)(26005)(54906003)(66476007)(8676002)(4326008)(2906002)(956004)(66946007)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?189JJumgLDMiTgNsQFBHahxT4aQ+bbEqsmuX/vccc08j6OROGl3jN6See+c2?=
 =?us-ascii?Q?7/n9ou8n1Cwf0ibmkJgb5BuwaN8/gOu9jo7V0awAoCqhA6u3QRmOoA0gyXj6?=
 =?us-ascii?Q?ji2ru6zbS+nBrUwbXXDnT8ZJHqYwGmR72qID/wG78eOWHZYVXZlLKk4VJK96?=
 =?us-ascii?Q?pMhfYj8VAuo4jyFIT22/Mrb3VmgKGrU8HQSA53R9Zm8qP1dOIZ9UzFZsg4Ow?=
 =?us-ascii?Q?Wj9rCke9qU5a9wRF+fUnBcHRmrjZMW8MjHj1U5ZAb9VnSPp0Dm89qkWv265B?=
 =?us-ascii?Q?ztuQPqfxsFKKun0CR8BFQQ0L5vaxCR5B2U8Zz0l1DHhY1XawkV0anvXnGPd8?=
 =?us-ascii?Q?u8SAaPdZtfxK3m3s+NtsbbdBOmcZNQLJLvnGw6veVxW+stSZimqnyf51L3wR?=
 =?us-ascii?Q?uwVuQRn/P9bBcROycj5CKywtQnOq4EKvTED+2ttag7z4/EGFjsms/H63O+UU?=
 =?us-ascii?Q?D1vNSTNfgiQKyrR1O3Ku2om8BS3tLHDf2JTLljX/mL50n7Bg3/LR0hqVC+mH?=
 =?us-ascii?Q?0m+nKLk3ssY47sOOL0DUvCUG1/4M6AajB1zJpyY6MnKazICxALlN5+u92/4w?=
 =?us-ascii?Q?QMveSv6MlXBwPeYXp0KDr+IiYJdgVv1xCJeC6jM86wHoLUvQCKjcyLU+BX/s?=
 =?us-ascii?Q?YN/fL7uhBMt2HhFZrvCn6z3wIpk+pg9OP8iS4TtThna4xQDZAgIpq/ao6/aF?=
 =?us-ascii?Q?5CJ7RKGZlQ+Z70vBCNUt6DEWPul/z1grUAW1Ql4Y2hC1kwCjmZXVfYD1jLb7?=
 =?us-ascii?Q?Tl5O846QW/mhufi8kZeBlDfNZt48maXY+7pBf2SQ97qAd11kPa+c76nA+/4/?=
 =?us-ascii?Q?vXE/UOmRfsKTsm7ADnSB5CPsoqwNkWASUh1Mvj7E/zP3S4qbDV9GpNQqdji7?=
 =?us-ascii?Q?fsksPjq7VYuhCMVgnnBxQqsrRLvXvepDkbdusHJ+RxBzbrmNeMDW2E/akS+G?=
 =?us-ascii?Q?kM9AiCDLhu7BYp8Sr/aS0MnBK2QN5eko1A+FzlVobSeSPAE4tl1PvRBE9tGD?=
 =?us-ascii?Q?SZEU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f4ea73-71dd-45a3-15dc-08d8957d0e6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 22:12:42.0033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppdHRcJeiYbcJUtM/SL2eoAF9GAuVzEIDpVIuWU5+lRpjMlDKro4PXKq5XXRwGKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a typo: "TZM" --> "TMZ"

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 tests/amdgpu/security_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/amdgpu/security_tests.c b/tests/amdgpu/security_tests.c
index 9b39e167..351eac82 100644
--- a/tests/amdgpu/security_tests.c
+++ b/tests/amdgpu/security_tests.c
@@ -172,7 +172,7 @@ static void amdgpu_sdma_nop(uint32_t *packet, uint32_t nop_count)
 }
 
 /**
- * amdgpu_bo_lcopy -- linear copy with TZM set, using sDMA
+ * amdgpu_bo_lcopy -- linear copy with TMZ set, using sDMA
  * @dev: AMDGPU device to which both buffer objects belong to
  * @dst: destination buffer object
  * @src: source buffer object
-- 
2.29.2.404.ge67fbf927d

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
