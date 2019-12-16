Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BF7C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 16:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D25B206EC
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J1dp3eB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D25B206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E57F6E05F;
	Mon, 16 Dec 2019 16:06:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3AF6E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 16:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkU16ocClZdpmHmKB5j0FOJhXx5/ker/IRsFxnDuMvDeSI/sLzvibf2ZW6v0kJtEVv8L7W0V+2yrHOkp7OEPxmP8K8jHqY4Z8iojo4uHRDwMrKKFlf97RTmQQxJPjL76sxuoE8vYI4TdKyN9boY1dLA/rbEjSIPr1Vk9henbqVy5ZDZWQ+q8FjGkw+yfLklzir+RBaLM98wFtFgy3BAq4k+i5yYDP7Sshk0DmrCTqvwPTssKSqfXx70ibvrtNYcB+5WIBu1Wbubk8kQFUwMiKm5BSoIBEuqGL36DtgRwNMEhb8ZEXOfH8LA7xw4kA1YR88k9d9didDhmKExAr7kl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QunNXEUstAAku89pG8eJJZ9u1MNv96YfeX/sR2UwwVM=;
 b=PmLH5LJfSrowrfRN9Ht6mxfncoKX04AG69TVeVXf4JLSHEuvIgxu4pHscdwKTvfZAZnHTHWVv1TzvpsOrOYY5ABCYlHAh/Oqh9tJ/A+6PiCfeaOGqdNaJUeZx3nHpfqKs8ckjSWcmn2gab/4ndwkMQeJ+q7iJ02ewHuKYCNMimMyqc9vc2IpNYIAFTL+3/6vACK8SJyHGQTjBspIzWFL2TKhL8GMFvIMaaWa8/THE3Fe9Wn1TLEIgFrA3nrxzZ2axtnbX0BZVbDrdhfFKp8cjahlae1gAa6f1q3tocVEK4ag3YUDvDpP9s2c3hw7i+OwYQ7RZJ2r/i9lGNhR9S2yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QunNXEUstAAku89pG8eJJZ9u1MNv96YfeX/sR2UwwVM=;
 b=J1dp3eB3T+oKS4U4QW+ifphz++FhKVrN/Pj2UzzegtaeNrbN9FL5o6LhO61N58OqBpW5TwgNmCR0BeH2HChFMNnYlU+yb59U3kpjw+k0lcz0LSMdzS9Iz6VrATD3xJlqHL1DUu1C4H0ncQRlJ1PC4eQCyJ3THaGUJPmfPXUVVOk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1340.namprd12.prod.outlook.com (10.168.238.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 16:06:01 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.021; Mon, 16 Dec 2019
 16:06:01 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: remove unnecessary included headers
Date: Mon, 16 Dec 2019 11:05:43 -0500
Message-Id: <20191216160543.13054-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::32) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bab687a-fd51-4f89-87e9-08d78241d82b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:|DM5PR12MB1340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1340BDA0D315C312BBF62C9EE5510@DM5PR12MB1340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(86362001)(4326008)(8676002)(52116002)(8936002)(6512007)(2616005)(2906002)(6506007)(81156014)(4744005)(66556008)(66946007)(66476007)(478600001)(5660300002)(36756003)(316002)(186003)(44832011)(1076003)(81166006)(26005)(6486002)(6666004)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1340;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90AEsoeSNj51VPaa9hhlfdDfSro2IUCwBa6OHEU1+ZJ50Rh77hgY8FCuDzAU1RTR7LlVfNzAYlgdzyeuXom43olRbdlTPX71svQsBQcGuWmqD0k8QaV80UHub26mG5bCLZS0y+s+r+y11pzQaYMeWW/KHaotrhwWJYRFhWBgWAdrGmndRZNXodoqAfnNqfCNTlfWssdJVAywp76HTqaGoiyNq+nqfeiIp9O+7PZNvdk6er1cFXQ8TNNF01T4spRPHxj3TaGaliVveT5Jg6mjs1uNI2iwIfskMG1TXP6eFNjEymPHFjJXJEOKfYpQO+HWzU4W0uD/4hONVyrrAlEFXEm+K49iKL3rMjoKyP3in5VKHH7Kl8KwF6vOKMCz9dYWnpB1oejDWm6kDp2zj08MmZ+7UyTEZygVm+ZUUXY70qIrQa+RSkTC2LM8WYs1RdQx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bab687a-fd51-4f89-87e9-08d78241d82b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 16:06:01.0379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v9OUKrVXhvgCnMfMhFP7L4jaK5Xv9msONefL8GyBPWUpP2ZLTRG/uRYLlp5tyLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Esp. VCN1.0 headers should not be here

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e522025430c7..371f55de42dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -25,19 +25,12 @@
  */
 
 #include <linux/firmware.h>
-#include <linux/module.h>
 #include <linux/pci.h>
 
-#include <drm/drm.h>
-
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_vcn.h"
 #include "soc15d.h"
-#include "soc15_common.h"
-
-#include "vcn/vcn_1_0_offset.h"
-#include "vcn/vcn_1_0_sh_mask.h"
 
 /* Firmware Names */
 #define FIRMWARE_RAVEN		"amdgpu/raven_vcn.bin"
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
