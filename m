Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B015C54EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B81D2070A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="exJzUSqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B81D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257046E55C;
	Tue, 24 Mar 2020 21:58:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1302B6E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 21:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggPL/MrZz+h0CTWJm2RgEj3jASKf/7RMQd5tuqfdFDs/T7Ru7PbkVEmZh+1Dnfh2hHU4jCzxXoxuxtWRZ4sSx/JiOfup4dAXQcyPfAILDGDIh312+zIoU1o4z8z+XeQFCpEvobfKnFhY8eeskUJ1xNk6YHsAE/TOfXhPrw5MwIHzB9xRwq5AR8IHoL2g4rTafgeFU29dC6bScCk59X39+LrDpxDHnWDbOduHl4mNCfG4mpptukwdMlBCZehACqvzu0xyWCmKdShItzRKweOS6Y+4ZGiIOjN6se525qdHJZouvMryt5bpQyV7za1AjdfGP2onifGqNTw+jnErSuWP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbk65qXa3tb6EpVYA1Axaipgfx5x7JeC0HBmCt0WnNA=;
 b=ZtrIHwP7/dCbAuAckr8nyswNadRbn6jYwRrNoRkCf+5w6SZhRfKAKHgUvj4tCDJTxp4LTWEZBxnRqVv1HJNzucgEROG3TQtFTwAwaxOWdMuDPJEMbGE+1LAucj6wvQZvPObsjwy/BRn5YJ3O02yhz3quylBQUdkdED0OoCCkVsrMt0GtbQz3c2QPDcJOWUkTGgIMsqyGwGjgS2H+gMlkmVXdG4vZLYKC1m2rbHxcvADF0GiLRO5O0jj/hTzeeOKSffa/wrLI8tgT2y4DaZmuPIVvwvgI3RvuJEDP+7e6upxxQccYX0BtoVDVoa6K1DKWzaRRQbaeynzsLuEYfVewGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbk65qXa3tb6EpVYA1Axaipgfx5x7JeC0HBmCt0WnNA=;
 b=exJzUSqHtlKf61SE8BOgCHZVzxVMQvTlOYWBNqETzqQXuqI1RfMgVZqLspFhgzv07wZC57d8R10hbaNZP7Oam5eDSSodYYSFfU4uDwNVwc1m+tdIcG3E4uzw2IUPt4pHL4hNsptQkYrXPyDzuIqFoygItXlJOvc1NJnlW6Gx0Dw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 21:58:10 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 21:58:10 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: replace ih ip block for vega20 and arcturus
Date: Tue, 24 Mar 2020 16:57:49 -0500
Message-Id: <20200324215749.29169-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324215749.29169-1-alex.sierra@amd.com>
References: <20200324215749.29169-1-alex.sierra@amd.com>
X-ClientProxiedBy: DM5PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:4:4a::21) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR1401CA0011.namprd14.prod.outlook.com (2603:10b6:4:4a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 21:58:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41a82b4a-aa3b-4aed-4f65-08d7d03e7156
X-MS-TrafficTypeDiagnostic: SA0PR12MB4544:|SA0PR12MB4544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4544636C25D18ADD76730C9CFDF10@SA0PR12MB4544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(44832011)(2906002)(2616005)(4326008)(6486002)(956004)(5660300002)(16526019)(186003)(66946007)(66556008)(66476007)(36756003)(26005)(52116002)(8676002)(8936002)(316002)(1076003)(7696005)(6666004)(81156014)(6916009)(86362001)(81166006)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4544;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJ2aa6SVx2MjSJOrVNd/p/FBElbk60PuVckU3W9gZDytzeSa+lfufouzmxW+FJNF+h31VlTcLrqpsEsWcdIyYUR1j/A+p6zgvXhlRQAnaSFFry/2HD3lPKqv2ReDV33+c4eBmBmvgjmyC4Sk0eP9qya9xyQ4iQeS69Q+Z9PlZOQhjpXLWdEVv6t7j7XTYJ2/aop4kwqp/ch4fBRJAWJnh6/drs++/mecpwWeQE0Gm2Ko3Jsbp6bEOUcA6mOaYtQmZQd7gXhl3xZQGeaI6vk8HIed/pq3e775jymc/+f6guwIubq+W1wUBiEN/bgtvlYSh1J/ZLKbkeIcFshbw1gjLXpIMQTJ2EcRlUMyj/+lc0kJ1WxBecBu9+tvzinr1mE5Sx0pXhGWHVEaLuyfHEBzj8RRJBMLeLBbP9b1YFjf9GVprBGLN4IMXGqS1Go6F4fZ
X-MS-Exchange-AntiSpam-MessageData: sGkG4rXasy9sn0nBaH0Vjf45eDpW8t+k4EZOHC5yK+s8rt/c4mUg39eUh8Xtx/Z9Wq/WFlltUHJ8PCDuoyi4IEz/BgonpWPGo3xmifm2fTdkMqo4fCCYHx6k3CtMdL14/0QGURL00ke0kvADQtMgxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a82b4a-aa3b-4aed-4f65-08d7d03e7156
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 21:58:10.6526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHL2iUkceCAtyQC0oTu84/iEIDT1xQxCp8gh5Nduw/ZKuXZFUj1SVgrcIy//BTbdS71DWp2rXyy9hJV2nyIAQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Vega20 and Arcturus asics use oss 5.0 version.

[How]
Replace ih ip block by navi10 for vega20 and arcturus.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index aaf02dbb03f7..a38b5a90cd1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -62,6 +62,7 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 #include "vega10_ih.h"
+#include "navi10_ih.h"
 #include "sdma_v4_0.h"
 #include "uvd_v7_0.h"
 #include "vce_v4_0.h"
@@ -732,9 +733,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 				else
 					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
 			}
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 				if (adev->asic_type == CHIP_VEGA20)
 					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
@@ -742,6 +741,10 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
 			}
 		}
+		if (adev->asic_type == CHIP_VEGA20)
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		else
+			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 		if (is_support_sw_smu(adev)) {
@@ -785,13 +788,11 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		if (amdgpu_sriov_vf(adev)) {
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		}
-
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
