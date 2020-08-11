Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D7520772
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dy8abePD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D7520772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E966E0F4;
	Tue, 11 Aug 2020 06:27:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF6A6E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFARlVHvQv+B+a4rUtErW/JLo4HgUn2NFpXrnXtMFXtLjiTaNnnaPxiaY0IIgX1HLIbRyNqp/WS3gzZlMnGP5dhp+UMYkwN+Vpk3m9yqgdeyF1+pAtTy1/gUO/Y0TlEDkOztg3Gm28u6PBf8bxPfd6T4vhjfpuAiJPBygPAKVXU/j0TxOMRkbv1tNgmzQkNXLtofhUqj9Py9bMwG77a2yD+qA0cZwrvfoLpcF68W8NWs6KUPFmCz0IY5xwaRLBHdza7SUszzykTaP6SYdZTQytBDj9w4y/A9gN8QShp5F5pvgxYEFyeYSBT3ZdtC92u57wMT644Pjq3nTg1JvsUepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdeD0X18LnGkuWjafEfdivhW/NaHsGH9jXMgq0QfXAg=;
 b=AEFBlXzcp86UCsFAMGGlschZ+u8HlvlnsFshJvEMd04JnzvbGcIB0HMVOBWjyS/Ad1o5xaVNCKWUEgc3tWzwcPBiOkcT1768tGDlhJRaF3xriWuwReFsU8W4MM10wVf81oTSmbcHxoTg8nsyyAosyVQftiKFlO3/JPPrbwirGd+ebCHJixgulvg2uIz8ENQ0qS+ceAGvbF83jMuxNSojQJ2PIK/wFjkSlRUD7+L0JES49v03e6uT6SHdYCymnDm9Qkap75QkQP9Lb5Nn6CaaCpF4s3t/jozoPJEcU6wYRdSOqwoKbWaTm0mKn2qSBM7oaSVLHeIRCLcg53T3mjiiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdeD0X18LnGkuWjafEfdivhW/NaHsGH9jXMgq0QfXAg=;
 b=Dy8abePDs5r9dE4u1svFWiLDt7QVCJgWoAENq9alBonPIluXBdGbZ3GhEOnWMf4+2SdXE9Bo1IpICVwVWlbVgWWkG4ia/Wo3OjzSMXxBS41XVqg6/ny5SxPI08YeqfzXzPWHl/5jj7QMb5bZp+o3JVVrpjcgGzRDTXThBH2WnII=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 06:27:37 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 06:27:37 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix the wrong sdma instance query for renoir
Date: Tue, 11 Aug 2020 14:27:16 +0800
Message-Id: <20200811062716.2927620-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR04CA0065.apcprd04.prod.outlook.com (2603:1096:202:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 06:27:35 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82d51bff-52a4-4e62-242e-08d83dbfa3c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110BDC6EA9C212D15AB8389EC450@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X87LoD470yZlTMXGFNFFDnpGBrnTVL1nK7tkw4hafgtJpmZTnsHMAK4AXamrf0kQFjemQ+DmoFfeIRP9TRsSRlIdfXuNLo1kvQJrTyXk3fQMdVTYMt/xpRQqJEOume4MHAa8hypmhlSSQ13vDv+SFw0KXXcGpCeOS4xarGVBXj9GSgA1oXxY6x0M54J3hpKy/FpLVwIJEmXtD4cBxB8a+nQmOzyW7kRZs26Xhh2FCT0hc05Sox/cTsRjIhbUCj4F96nkek6uAEiLBWHh1iriP2yIfGOWkBP2uxJxqsVDM87cVyReRzQr4yPKf74ML/oz42qPOWjBcVVzw2Cwi42agA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(66556008)(2616005)(956004)(7696005)(52116002)(36756003)(316002)(1076003)(6666004)(66946007)(8936002)(54906003)(66476007)(5660300002)(4326008)(8676002)(26005)(2906002)(86362001)(6916009)(6486002)(186003)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pn+WCOpT5oENkTsQwIs2QNWA71/16iQWW3v24AscX9ahu437mIZlWRNLcBtwk/rLAIQuyGGLRaZblDMJOwRu1yho6ORpduABFxiyNEK09pIRXkvVlqJe35H6LCVi6BzBymNZePaCuKdFSRv27QwvqEFOUCCQJBPmgVU+98CUASiYdxN3hKMQviY3A6/I9b9gWdCG5/iDUPbWdpaWuP0sNy3/hgJuawvhn3s4ra9hnoGABKM+YATwKtCR/AnkVykfBU5DsqmCPpdFVKrN5Xb7FHgBz8JGrPmC8OMPZFIvVDsUJFMXvfmRLWwh/8nSh2JZ/uJhSYPTxkmqD/3gJWaPfZHiYdd05nr07QjVrJ8rYEoNjKwep6X1as/az4XciXAWJaX3GD4ipaVYaAqVpJ5t4nT+qGKBM26vBIsTL9GcrFBDI+81g3T+7DZDGNRPVR1qGOIiVnV/EoEfu3z0p7JWlJ8p1ZZTTQLptBUVht9N3YPzgzbxeuKeMQX7gc0gflQyyrEBUNA7xvWjHb0r9wb2AhZsOI/BFjRITH6Uz3jaxqkOL91rfYgif77fG+5H8AvsMrB1VdBsCTywtmAozx6eJHzoikbx9OaLAgfqDWsTCUi4bVkmV+e02eLvhBy/tKMkMacDIYRGRQTrtkBQKQcl+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d51bff-52a4-4e62-242e-08d83dbfa3c6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 06:27:37.1553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3TIU3+Zy295MKjIt5H/gfu7zHhLDYBeGK791Iz12bKES5AzqfY1RipS5pGouMmOTFgKma6PsIHuhEyuJnYT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Renoir only has one sdma instance, it will get failed once query the
sdma1 registers. So use switch-case instead of static register array.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 032d3c866280..23ccfe0ad5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -197,19 +197,32 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				unsigned int engine_id,
 				unsigned int queue_id)
 {
-	uint32_t sdma_engine_reg_base[2] = {
-		SOC15_REG_OFFSET(SDMA0, 0,
-				 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA1, 0,
-				 mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL
-	};
-	uint32_t retval = sdma_engine_reg_base[engine_id]
+	uint32_t sdma_engine_reg_base = 0;
+	uint32_t sdma_rlc_reg_offset;
+
+	switch (engine_id) {
+	default:
+		dev_warn(adev->dev,
+			 "Invalid sdma engine id (%d), using engine id 0\n",
+			 engine_id);
+		/* fall through */
+	case 0:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
+		break;
+	case 1:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
+				mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
+		break;
+	}
+
+	sdma_rlc_reg_offset = sdma_engine_reg_base
 		+ queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
 
 	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
-			queue_id, retval);
+		 queue_id, sdma_rlc_reg_offset);
 
-	return retval;
+	return sdma_rlc_reg_offset;
 }
 
 static inline struct v9_mqd *get_mqd(void *mqd)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
