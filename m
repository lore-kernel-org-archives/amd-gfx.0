Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613C6C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 04:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1606520757
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 04:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1e+jSscP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1606520757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E016EB3F;
	Thu,  9 Apr 2020 04:13:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBB76EB3F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 04:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmRD8O4lEkFEB08yCcEWxGGOIFVRbR77lmNel6rI4XkWOX/xKBPXdE3CApqmFVFDfMgPHkx6V2Vq0Rc/X205C0/YsRro3A7NoAE62wP3Ok7FudMUQ8QuSD6YFF+wBjShZzgSnr05VMb5P2HbGMrNPxn7StxrZT6kXxM38JKykFmOqZUeb2Ehwgj6X/Tj0kIDcYCr/QeXzgsVxnW842rGqvz0PJ5kxhJWchRMHU+4lYMIBC3/IdsQq0zVga2mBQOKPuhDlhO/Lgh5QsOWa79pt3hEeLbyWlsZJwJLaYE6fODQDcDPSRaQeaN9BrXjGhO2wkBDwEVySC9SqkWKUY8cnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNl/Ys8weHd7LRPpcfypCVtxoENqmV7wd0e88IAON/0=;
 b=nhG5IZCQvwCBK4MkeH6Y0zqd7NC38xS74jTlU2A/3CPbewR+niXBwMsSzM39TT2dz6N+C+Yy92RVR5YB3vSGXGRWhYNuMeMhDAzimNOgKefEa+LvUXIsXGG4uZGAbTLTvGWLctVD3fEO8fnP7o77GAMt3i11lHCAVsPDTiYpg3bzAry/3VpFcHtxQtH3Yl22Z5ZYCMVqngYQH2CzP5a5y9kDFiA9F+33dC3xVUwVccEDybh9JS1zUUi++xkgnEQnawfnbFqWW6KvoucJsDP1Qbpw3jW/ptRI/mZWaiUynIzYVTgwQo1tFwCCyjJwvh0eaEu7n4McWMEtGfyN7jgD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNl/Ys8weHd7LRPpcfypCVtxoENqmV7wd0e88IAON/0=;
 b=1e+jSscP/HWltqsSxuH8fW1sSvNbm8/JWuRlVRohAJVXZw2z8h2hUsuN+kYVz/SubOv/STgl8N+h6g7Zx42OeXujpovioKqvgM1svgIwDgYSyMpLTiazyKhSpq3a5z1SMpXKc6k03a7U+F/fwlNrK+gSKFa/JZgPkNsiYjge1FQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Likun.Gao@amd.com; 
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 04:13:02 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09%8]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 04:13:02 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: change SH MEM alignment mode for gfx10"
Date: Thu,  9 Apr 2020 12:12:50 +0800
Message-Id: <1586405570-11485-1-git-send-email-likun.gao@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR02CA0178.apcprd02.prod.outlook.com (2603:1096:201:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 04:13:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e75ee2a1-8dfe-4274-4209-08d7dc3c4b6e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0136:|CY4PR1201MB0136:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01361D48D7FF4700CEA06378EFC10@CY4PR1201MB0136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(2906002)(66946007)(54906003)(16526019)(36756003)(4326008)(66556008)(4744005)(44832011)(7696005)(6916009)(186003)(2616005)(52116002)(956004)(316002)(66476007)(6486002)(478600001)(81156014)(5660300002)(8936002)(26005)(86362001)(81166007)(6666004)(8676002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/2VBDO5oMMW8yfkBSGNQ5ZvG3JUj5/c53JOBQO/Btvk9+hMuCJMMAdSUO/j+jlw3EmdOmDmRF8lVtzEK0+rj+d1ROg87ZCFbZ6EWdGyxUHA+fAXVe6yuHo8VDkj2ETOM+0yjqmgK6k2Bm5Fc3G9fPKa45Ot0eOKU+cROCAsdOlVeEf5YCFbVzGEKFNh9z2b+A0UuPWWTJM48vw5g587U3nq5Bkqy83VSLfM8ifP22UtVsTNJcLS+c7JDJexbeIUqfRPRpiyeeaBYFTxYLiEo38ct7tW6gVEETnpK/F/ZT6xXqoXdkOXdG2V4G+Oaaj6joAspdAYwuwx1JIwmpsAz0irHLMJRX5fMHeSxvNZOY2slIhhq5lV2HByTWATcMOD6EXI4Z5SCVy0J3ke61epN9h/fm5o3VPqzluHZRatRwU5fKZ32k2zkmS248C4KJB/
X-MS-Exchange-AntiSpam-MessageData: 0F+5uhvGJaGO93IC0ALg7vTz/l7IUXLSPrQmbiFmX/Mfr1hLNZvvOWMhbZHpwt9Vw6IR1aRlmLR7GDKVG2DkKBqFjCCPI+eP5y3d9+Fb8f0XVfIuNvL7hSrMlPLheXffBFqzW5pcJX6kb/vFFUUfzQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75ee2a1-8dfe-4274-4209-08d7dc3c4b6e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 04:13:02.2338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSEkJiKE7icYRjvchy7Q9mIpCPbQumjC6CnM5HPWkSr4R/3r7WgfJLhS4o6Mixf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0136
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

This reverts commit 8d2afe375f6ed9d84ddca234d49a53cf875f9042.
Revert the auto alignment mode set of SH MEM config, as it will result
to OCL Conformance Test fail.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 29c94bb..0a03e2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3015,7 +3015,7 @@ static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_2_nv12[] =
 
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
-	 (SH_MEM_ALIGNMENT_MODE_DWORD << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
+	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (SH_MEM_RETRY_MODE_ALL << SH_MEM_CONFIG__RETRY_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
