Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28659C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EFC20674
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tQzsRrpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EFC20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D4B6E11B;
	Tue, 28 Jan 2020 19:56:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E7E6E11B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 19:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBRXJzsmBoVHMlC8w9u7NFuvWgul+PlnGXBi/04cWhcaZwRBq0lKuU9rJ5BTvPOB4L8JlFduXH88ykV1NQr5v2+9dnC1beDFIf1DFXxbYT68xQc9ElOmknDsJlF5XaYlJN0h6bfCAihBUPNqGSvrCJsY7UsKU4vJ/uYpqFzeX7LIgO3FqnYWGBPIrzgqCrMBPyblfyTRYGSxjqplpSRHJejqEJTz72FLLd7MyOWScQlDXU66rLMC/gJltNgZ9azyLsQ4y/xAKGuiP3PdYUKYDan5VKm+ESEYoIaJlIs1w4RGFvtaShUXzVYUBVEILqbncgT5PW4SHBH7VrkYu0QT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyiAVIa7wIkaNl2z/BECO1ddfGCNGLXuBOh0oRALK2U=;
 b=ocH6sO09g5p4t8kOppaeJ7Gdb+YpC9lTDjNyx2qciJpr7ZgXoNp7bGQliNS9HCE9/DgDUstkNPovxSzGmc0qedwCnZW1sDDOAJsb1PTYIJB34TnQ2b6tLTJi+i6zXPQn7EgQlsm1NAxsxNFUjeEEEFEGg2mOotdx970vLNs3BNM92kayUHIB6BAtHWrT1CotviWFkWwOYeBwJ67Wg04xVttJSzuJ2urjYsZ9+wvT78DnYeaiOQwhQR+nJDo4wuy/Ijgl/3iGZ4Srt3N6CbmYRozwt8CNBa6xlDUlq56HjN6zP98NLhZAq8V2oow6nLUJeU/VfYY/nqZOmHkzbI7gdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyiAVIa7wIkaNl2z/BECO1ddfGCNGLXuBOh0oRALK2U=;
 b=tQzsRrpxnVxItMmtLvOZ1Twsm15vAFRtqr/j0m1wtYT0F6JxY0so0TI5/8o24ixKaYBSV9mzimXUklI8huO9e8SCOminYBf390pxJY1oHcV/jRSbjqPjVlPTQ/LO+tqVDOAiTgoODXkBfCl+Mw6lRLPRE08qTosObR5s2WJZSrw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3038.namprd12.prod.outlook.com (20.178.242.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 19:55:57 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::dcae:63d1:58e3:4c4]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::dcae:63d1:58e3:4c4%6]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 19:55:56 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correct vram mgr node size calculation
Date: Tue, 28 Jan 2020 14:55:43 -0500
Message-Id: <20200128195543.8286-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::41) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Tue, 28 Jan 2020 19:55:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4370c985-54ec-4b89-8215-08d7a42c169d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3038:|MN2PR12MB3038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3038C05036FBF74F392E842BE60A0@MN2PR12MB3038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(478600001)(6486002)(6916009)(7696005)(36756003)(52116002)(66476007)(66556008)(66946007)(6666004)(16526019)(2616005)(956004)(26005)(186003)(86362001)(1076003)(8936002)(81166006)(5660300002)(4326008)(316002)(8676002)(2906002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3038;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kK/yJxdpUfZ1t8UWTDnee/+6uzktdI8N2FaTho3vsFMGMb/OwPhzc9FPdp+yjf4qoCuj1gPpnlyg+ENoXqOAi23MxHNU/ihFpJhq1ztfSi866tIKu7ElT1yE4Bl/L0xSuwvIov8nDUZCHpyq8TGQzEKdft4dpELej2+IhVgR/YcGR/6taE2NzHw+wGM1v+rr+pur8fjvLtrloLkuieQll5EbET2UN21yHkP6bTMiJqXSu1DMOXzx+4Q+FF8FDQLp6rO8weMyrwCU876fphOzlGXw2p8QvW+qhFCVIs7wLZFDdw45C8dqzPpaP1aKZwNFIPElZ3h/bodAwUoBd4EtywFtyxmEgsgtq1d3qrXoPGQHEA2fEOkyKnS4lcASjIEac6V3K3WtUBFt1VTFL1YaDmkzMpHx/Pph93NKJ2F3aDYE2BDLYgoGsH5LzZ6d4fBI
X-MS-Exchange-AntiSpam-MessageData: iiBuTlrWPF0AC2hLs+nxv9kY+3x/EGha4tqeyE2YkjPK5YAP277IGmPLvti3Zs7LbcD7TlbEo+VS0WvEhgdWRxpIkC24xmVJ+5t3+UFOekoZu1Ju+I+0FuTLZ8YXt2xyXqJsuWm+tntCPLLJ1seODA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4370c985-54ec-4b89-8215-08d7a42c169d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 19:55:56.7018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhe4UacZF5GdSID6+aZ++GAIIvFB7CnTKeVJGz4xCxbvSBCXsPDhvsZi0pVOzVpw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3038
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use pages_per_node instead of mem->num_pages to alloc vram, this will
increase the chance to get vram node after vram fragments.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 82a3299e53c0..67a454f4c37a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -369,7 +369,7 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
 
 	spin_lock(&mgr->lock);
 	for (i = 0; pages_left >= pages_per_node; ++i) {
-		unsigned long pages = rounddown_pow_of_two(pages_left);
+		unsigned long pages = rounddown_pow_of_two(pages_per_node);
 
 		r = drm_mm_insert_node_in_range(mm, &nodes[i], pages,
 						pages_per_node, 0,
@@ -383,15 +383,11 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
 		pages_left -= pages;
 	}
 
-	for (; pages_left; ++i) {
-		unsigned long pages = min(pages_left, pages_per_node);
+	if (pages_left) {
 		uint32_t alignment = mem->page_alignment;
 
-		if (pages == pages_per_node)
-			alignment = pages_per_node;
-
 		r = drm_mm_insert_node_in_range(mm, &nodes[i],
-						pages, alignment, 0,
+						pages_left, alignment, 0,
 						place->fpfn, lpfn,
 						mode);
 		if (unlikely(r))
@@ -399,7 +395,6 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
 
 		vis_usage += amdgpu_vram_mgr_vis_size(adev, &nodes[i]);
 		amdgpu_vram_mgr_virt_start(mem, &nodes[i]);
-		pages_left -= pages;
 	}
 	spin_unlock(&mgr->lock);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
