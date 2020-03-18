Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D8C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19E420752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="APSVSzE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19E420752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FF46E988;
	Wed, 18 Mar 2020 22:52:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2856E987
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WELaHTWxQPorUpd9L7draWZZUwtwZCKFx/vdoui5ZqeXhVvEK4Rnn2BXCj5DdPWId91C14ttrsl1/Q4EZpB1C28Qnds/dcujbwoTidJSFxtcPKXSTWr1xKvHrUSRLDDkGT7RTbSYsqGtuX7Gfb9zx32OGd4XMh7p8s0OPxp46pRuE+oVfRz+jkchwqh3zvaUhQhMXmxxFskJEjDJsT+3C/Hov4iCEC5iTERyLc54lS40Q1AXNjgyIqIs/Jex+ED4YzFaAmceZtm4m4Juis9pEpAZEfEdJ1DJu3ARV6wtrnKqzQ/HnaDBistllb9xiF6YOw04tjLou/pGYIotCUwdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkSzsYKPT2jEogXQgVQdMuMvo21G11occL+xDJjpGKI=;
 b=VAjdU3ZnfYwEQTmr0xeYp20ZN4b6+VKeuznAKI5ZJtqCmi30H9KBt7tPi7LeF+zk+c39rTvUPG6S0+m/oJvC0DpH71Ke2U0S+lF7rjDmOgmIrapvxfnzlYyfy/e94+M2kEVduYE/KUCzjGSjurZ27pE4DpSXLoOt6/ZN0gBa+hP6PIK3D10BSnP/ifzS7jUjtwsZMb7aqikzFHJ/aj9DNWmDLs0TgQ6Z0warb1/wdMaSI2PyhLsjOk2Fna8rNvVLA/r2jfrVxkiQwFiZxODo6+zgoDXqWoP3BMBMilbgfsLRGjWIBzH7Pd9ovFdE8ynOR35bixSVXrttBIrecRRDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkSzsYKPT2jEogXQgVQdMuMvo21G11occL+xDJjpGKI=;
 b=APSVSzE3d3RXNmyJT88t+0Jo6X/bPrkc6Wslm20k20wETrVg3J5tCCWMvbcRUVjnWwPEhia91JeEi3WUoGX1ND74NttkfP27c43oHQkqZwra5TZ+yQwQDv4nHjdi8zhMtuxr+sj684snPNO/sXgrJ6LaoueUvQff8lYRudwBgIU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 22:52:23 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:23 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amdgpu: replace ih ip reference for arcturus
Date: Wed, 18 Mar 2020 17:51:18 -0500
Message-Id: <20200318225118.10756-8-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318225118.10756-1-alex.sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a648b7e-6e00-44f3-3ebb-08d7cb8f05a0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:|SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4415E5B4747F5767EBE0348FFDF70@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(66476007)(66556008)(6486002)(81166006)(8676002)(44832011)(316002)(81156014)(956004)(2616005)(16526019)(26005)(186003)(8936002)(52116002)(86362001)(7696005)(66946007)(478600001)(2906002)(6916009)(1076003)(4326008)(6666004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4415;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAv9A08i3HVvi1YaxrdZ7fauTBAzz8sOCERSXnD7LFhJ2aGAac5Fn14CRbKROSQ8cZg+Bl6Z7Qgwqqf5OQfi+7gKTmEspRwp1Lr0qo3ADv+sH5zL3LYyFFfeSNO3wydJRPHVsZVX7+CQcEmBeWsD3TVmxc5A58fDN1jxxZRH4WRu/bUCC8Sl14ouwbyFURwJXKA+8MCkCTkUH++RaKC3X2ON0ao1iVHqUG6POl19ERLktwQ/5Psb2WGlMWuZg1Gi8GVejoqLUODJ0Xo2PbJuTqY58HaA6FiaXLdujjjQMDT51ghvl5QGQHQcYLQdXWR1YQWSmvp99NJBSIxukguiGgmhsVeK1I9/ACRYTRBovu8Cb1+zVJ6/2s3Bhs7uBr89HNv6QxNUydjdorc0l9UBEqdpUTHm25PCtsPi02kO/hCElYdMZimMc6F92XxF7q6R
X-MS-Exchange-AntiSpam-MessageData: BuQh2MsU2wDnOpxWU+TqlUxlv7DCYoI+WkjU/RXaYE8XF0AJaMaovIRm+VAtllPOcqkU/3fHNsGH3xSn+TvcNNugssyctLJiDpFv7IxHCX2rBd4AJz2EO0WM4sMZSyoPwWHCX4VWJTpwO0AQYPN0yw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a648b7e-6e00-44f3-3ebb-08d7cb8f05a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:23.2728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad/wiXpEFC679q1puuY8okWgyUC4UJV7t4eaD5R4SWD6wvmJu3BCO2aNJEgiFAJCydOQqPU+rkPLxRdBRLV3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
IH implementation for arcturus has been added.
This reference has to be replace it for Arcutus ih ip.

[How]
Replace arcturus ih ip reference.

Change-Id: I5a12b329146fa7883586bb10d22077046a977701
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a40499d51c93..c27760713aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -62,6 +62,7 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 #include "vega10_ih.h"
+#include "arcturus_ih.h"
 #include "sdma_v4_0.h"
 #include "uvd_v7_0.h"
 #include "vce_v4_0.h"
@@ -785,9 +786,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		if (amdgpu_sriov_vf(adev)) {
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &arcturus_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &arcturus_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
