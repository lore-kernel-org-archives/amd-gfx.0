Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FCAC54FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C7B206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W6wzBXUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C7B206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFDF6E030;
	Wed, 25 Mar 2020 03:58:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FBC6E030
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdSIHEhB67wwQxUDZyBkoVsJC6/D+ctVjslwarZeT7HiTM2Esr+qJUnIrWfmWZxOjmBp56IhW7vcwzmWVdUxHkPpxsIwZjg3VZRqgWHklz0+O0rN1f3lFstrxAKdHhHP0zW8NYqypH7KuON+KdtNipLVeoKS2LYZ3n8VhCcENxFEexk3JhbG1vty3BDHIjZbd5+TZjr1COe4Ts5cDYl/W+C5eSlvB0zacAuUmPXJY/LsM9sQSM/zXjAOQwosupfTdqt+EA9+w+t83t8Gk6MbT+eMHJzM1AoFRJpYmRjbjpMgk3YQ2pPZa4ciBNBH/O7WwjuOq1Q0Lb/p1mbZRUcwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aOUyIddsp0knSU4NLkeFz+OgVMcaI3n6qzFG6i86mg=;
 b=mDvT2AGc4iB2Sj9qO6jgxzNqDMTZ8SKygQu7g5ENcsJVEV6fFV2H+hVHDc0Z7nao8/PGVQ0fhHAE139RITzJ4Zgz+WNFm5jEMfHQKYIHUbjrRG8vQOB6NLj+T8cauOE79IWikBJ48I+WdQSKTvGwkMrPnh6hMdRkCWYpwrchPj9WmA3050CFVkHB+5fowZfJ9P6gq/0tUssHZCUb/0YEkBk7J4hJR4eJGrh6eTIjSX4NZ0LL2zKV3BcIW9oPMTjjricrJE9x12NsgtJ6PseeQ/40NdFiXFVsc9opk0I2xaWj4BO2ALDwB6snKC5UynXp9SEdiK42A5t91kad5/eBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aOUyIddsp0knSU4NLkeFz+OgVMcaI3n6qzFG6i86mg=;
 b=W6wzBXUUSIsSrOiLRm1/U1LQYcJ6+U3EwpGqZ9fctMoojdVHSIzdJ0IcEbBUPwfbgqWs02pUFVeUH2Q6tOU/PEbYPVLBOzSmPcPvRSHjClVqa2TMIenPYq89MvWSwyb0TC7tr1IftILgahQ0f5tMPMjG0D3xpWK7mweWFeZLIxk=
Received: from BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) by
 SN1PR12MB2432.namprd12.prod.outlook.com (2603:10b6:802:29::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 03:58:48 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::d9) by BL0PR0102CA0021.outlook.office365.com
 (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Wed, 25 Mar 2020 03:58:48 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 03:58:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:46 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:46 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: cleanup idh event/req for NV headers
Date: Wed, 25 Mar 2020 11:58:36 +0800
Message-ID: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(428003)(46966005)(478600001)(6916009)(47076004)(7696005)(186003)(5660300002)(4326008)(26005)(2906002)(336012)(2616005)(36756003)(82740400003)(426003)(6666004)(86362001)(8936002)(356004)(316002)(70586007)(81166006)(81156014)(8676002)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2432; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dcf28ea-93b2-498d-b8ae-08d7d070d215
X-MS-TrafficTypeDiagnostic: SN1PR12MB2432:
X-Microsoft-Antispam-PRVS: <SN1PR12MB243284230B848E2B24F3ACCC84CE0@SN1PR12MB2432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHIYK7ouRDUZ2/VUF2EO/2X58swqQLnZmZhs1ofgO4L7KjrK/oKkPj4JTKyF+5h1oyMvDLo4x2eU8eetVUWp/36sh1fX3OYn48QHpTwOxm6EgXkZpWsUIFT3ZO5/n8oyNmGupT9il4hHQfrsOQUQzZj/HPb/F2Qiq1JFuf16104alUDWEDZ/5KlfSVXpbPn9LM06BpBOxCXj6ONzhb3tLpeMVlvKeXMVkwgOXy4FQbOBViCEIfZzjf1Xz1sDws3zcbuhdSM0bbnirEaqUeZfc7sx5pdNY1ItnQKXPAYcYOV3pG83UYd7UJonvqzvgrBMm5PlTTdb13t5hWZm83djb6/rEBaZlKmOemjZ2ztSWQaWcyEWiqKWxKNuoJBVa1YcAtnf8qSM65TxDIcPy/fmc7L0DIfk/sACdw83NKWcotTIbhONgCmXcmxzvJ7NW7Rw8226UMoQzXoxtsWJqszvKB9sS76wWUpoEHy4/VoFOFtGYTu9pvJx9Tz/yChF7/SozsA3HzZ6/CKqAzW25JpX+g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 03:58:47.5318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcf28ea-93b2-498d-b8ae-08d7d070d215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2432
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1) drop the headers from AI in mxgpu_nv.c, should refer to mxgpu_nv.h

2) the IDH_EVENT_MAX is not used and not aligned with host side
   so drop it
3) the IDH_TEXT_MESSAG was provided in host but not defined in guest

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c |  1 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.h |  3 ++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 37dbe0f..52a6975 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -46,7 +46,8 @@ enum idh_event {
 	IDH_SUCCESS,
 	IDH_FAIL,
 	IDH_QUERY_ALIVE,
-	IDH_EVENT_MAX
+
+	IDH_TEXT_MESSAGE = 255,
 };
 
 extern const struct amdgpu_virt_ops xgpu_ai_virt_ops;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 237fa5e..d9ce12c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -30,7 +30,6 @@
 #include "navi10_ih.h"
 #include "soc15_common.h"
 #include "mxgpu_nv.h"
-#include "mxgpu_ai.h"
 
 static void xgpu_nv_mailbox_send_ack(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 99b15f6..c80bbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -28,6 +28,28 @@
 #define NV_MAILBOX_POLL_MSG_TIMEDOUT	12000
 #define NV_MAILBOX_POLL_FLR_TIMEDOUT	500
 
+enum idh_request {
+	IDH_REQ_GPU_INIT_ACCESS = 1,
+	IDH_REL_GPU_INIT_ACCESS,
+	IDH_REQ_GPU_FINI_ACCESS,
+	IDH_REL_GPU_FINI_ACCESS,
+	IDH_REQ_GPU_RESET_ACCESS,
+
+	IDH_LOG_VF_ERROR       = 200,
+};
+
+enum idh_event {
+	IDH_CLR_MSG_BUF	= 0,
+	IDH_READY_TO_ACCESS_GPU,
+	IDH_FLR_NOTIFICATION,
+	IDH_FLR_NOTIFICATION_CMPL,
+	IDH_SUCCESS,
+	IDH_FAIL,
+	IDH_QUERY_ALIVE,
+
+	IDH_TEXT_MESSAGE = 255,
+};
+
 extern const struct amdgpu_virt_ops xgpu_nv_virt_ops;
 
 void xgpu_nv_mailbox_set_irq_funcs(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.h
index f13dc6c..713ee66 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.h
@@ -43,7 +43,8 @@ enum idh_event {
 	IDH_READY_TO_ACCESS_GPU,
 	IDH_FLR_NOTIFICATION,
 	IDH_FLR_NOTIFICATION_CMPL,
-	IDH_EVENT_MAX
+
+	IDH_TEXT_MESSAGE = 255
 };
 
 extern const struct amdgpu_virt_ops xgpu_vi_virt_ops;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
