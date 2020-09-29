Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E4CC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 18:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA5120702
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 18:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aziVdydh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA5120702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D2D89DD2;
	Tue, 29 Sep 2020 18:00:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20D089DD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 18:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN9HzsqSoyFRX9KPkQFGwXDfEhP7iiiwRkkKm+lgJ3p9w3Z56S83F88tZ5oNQx2SwnBEtYfJFr2irv9LElz7VMGfqYb/jCAEBzwn9O9Z35oh6cjfwybCDlPKTmm0DwjAs84tglDB31t64Mw4gwqhyGr9CWHOn4OxWaRNAhEpMdZNnmBBliXoI7KVn9E7D1wxDQ+piBURBNBW7194p8zQpTdd3VSzY+WXhmSgkCZPLkLIxRebJFKYG/zcuxr2GvLerWmTQQ3JjaN9tr1vg84vD+BJIkWGm64IRk4YoKYfgwwqd0meJ4a/sKaxV5vwHL4tx1ASkkeld/8ntxClQN+aYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN2lurfwB6LERNGc6g8M0CwOpaqvuw7BBnGDZ9ZjRy0=;
 b=dEuUsVoXJAbYGZE+giGmb4K5ADooGN8mO2kVO1fyi1NZQKgekKV8u8A2xlCjtR7Tbw6+a83kyo3Ivv/G/RkMqZQOHjmoc0UoWFr2o+yR3JMxKZ6X5z0WkR9GTtkDE4Lrt26dkVmOv2PmwBAiLWp9VQuZgIJeO5PJyOMPpBECcYnZ2YHrp2CgVee0bBR+QgS21E+76lbSCmgO220pmySzMm3V1kcMk7CxODNVh5SoAMT+WFkngonUwSTiavVhNlRcMIuVhEP7drxZqtD4YC8FI6iLC/r8W1jWFB5MG3tlzvNaT+qbx2tLh7TgaDpbfZo7e7AlcXIU2SxcPVm38ocz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN2lurfwB6LERNGc6g8M0CwOpaqvuw7BBnGDZ9ZjRy0=;
 b=aziVdydhdEGcXlVDViFRMxqs5aP+L2edM3rpDRA1ge81GPJo3RbPMR2jbVFxvbPh5pLZp6Xtn2ELkFLoxMLQI5zvGI6X8+3f68Nlw1lcmSl0LRo/Nxs9AN7oZygvr9erdcais/8oCy0A/Bavy0qGc4uj0zDBRzZ3BwQwY2dykGg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2429.namprd12.prod.outlook.com (2603:10b6:802:26::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 29 Sep
 2020 18:00:12 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 18:00:12 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Date: Tue, 29 Sep 2020 12:59:57 -0500
Message-Id: <20200929175957.25855-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:3:d4::23) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 DM5PR05CA0013.namprd05.prod.outlook.com (2603:10b6:3:d4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3433.14 via Frontend Transport; Tue, 29 Sep 2020 18:00:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b21c4da-22d2-44fa-f4a7-08d864a182b7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2429654606A7DC5930A67ED1E3320@SN1PR12MB2429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Pm6B9xUqjqhfVwMpWDOkMhvrSm9ULEZm+f+BZQ9LC7GHVSJfhRes4srEAXpKVEFKP5U6FOcoxHtGnif3LDT5BXRbISUy/mctmJXrbm2X0TqBPegya6J5pf4seQbLUs7JH98n7rHC0OfNUVYBJwHLLej5Yte8HOCTtXJoHscRE7Gpe/hHMjD0WOzzPTXDImH/qOLcS9ZbJAMormqyk2XidgMPUcygSu/pKNuVLrAXT2WZ2wV6sMrYARnmagFlRsCfON6VSQKiR8KQ3KfZEz7uUgsWTKzykKGcXeSV/6R1lkFIiJk+rMs8pQ/4u8HEHcSiTBjboq01/36ZBWrUDUlTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(66556008)(66946007)(66476007)(6916009)(26005)(86362001)(52116002)(6486002)(6666004)(7696005)(316002)(2906002)(956004)(1076003)(5660300002)(186003)(16526019)(2616005)(478600001)(8936002)(36756003)(4326008)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: b59gMK6WFDiulXUXeW21gsHocjXELcdV6F8/RmDYd8nvzS+6yL/gNP313zgkjWmZy8AfgsbJu8zwn5w6PmrhQT38Gvm1qnkTyl3LHltjCs5e7m8DyZhKUjwUm+Rg2GhU4dLCGQvqAzBKIe+jvgTXpkQAoy8T23WEqpej0lLdAWoZ1BrFb1K1tVU7Eoe9wTe8ZkT0UtMIzsim0dQJ+5yIY2ehdHJTNGnJ8/cJBgEActgLSfh7kVWfJkKaYaqNHDIBjE59ENSFnItgphWrS3GlThMrhbYsYehJuoqfQoaKBRUFwZ9zgBL3IjIT3ndvQBkpbVISp9f3fZ2Osa2UsUsWXTBSuBEgtC4F9v6oC/OP5A6D6SnpBD3x02dDfQm9WZPZ+q5pTm/nd+fMM3SKNYNjoiwP1zaw4u72OP1WoH/YYoe0Wud2HeKeEyNz3hdRqjm9GjuJ6prSJskr3KKYrpZuv32Jy7IyQdUIzRAnQgZ/nlR1SVf5cYEbVSJeVxQH0pX63axWGfxFZUUH4VDg6hxcUTruJ8v+0cCk+M+6BPlJubv+Kbr8uqLJYOJGQ8J/mPUIefTm3C6Ox81ebqldFCFzNafS8x21ctIYwNOpcUlavf9X7W5oUEc7D2yKCNM0RouNYzh70pjEdys+AgjYIleJ8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b21c4da-22d2-44fa-f4a7-08d864a182b7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 18:00:12.0340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ioi0PoItXnAuJhaRx8GHODiy2q5LvdVvcxJMTh3LS1vakUeAm753bHUWOtRtIGJ478p4/dFEFX8sT/harvNSlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2429
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow user to know number of compute units (CU) that are in use at any
given moment.

[How]
Read registers of SQ that give number of waves that are in flight
of various queues. Use this information to determine number of CU's
in use.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 346d8288f6ab..6959aebae6d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -49,6 +49,7 @@
 #include "amdgpu_ras.h"
 
 #include "gfx_v9_4.h"
+#include "gfx_v9_0.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
@@ -788,7 +789,6 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
                                  struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
@@ -2397,7 +2397,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
 	/* TODO */
 }
 
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance)
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index 407472031daa..dfe8d4841f58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -26,4 +26,7 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance);
+
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
