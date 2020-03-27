Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F571C2D0EC
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2658206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 13:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U5X66Jb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2658206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D836EA2C;
	Fri, 27 Mar 2020 13:44:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FB46EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs9cnC1KFv+ZG5A3H8XgSIP72XcB2eXU8rF/rizv+meeso9OPT9gxFAw0S9zkqGmj4xGEHEMd80MA3x8KObN09haRWHtuM0PMmH8qQetJ0kK+pOR8zteJDbsYlFOAOnK9Hd1P6wdFMjAAM6+9A5sewbvNy8Efc9ZkbZVgy7vrVQ3ccZFTxGKFRNG8qxGfVN2BrOV/AAJlGWQu4f8N34bVW3Sg+DYsaNRqLNidhbBtwz31fTI0qSJrI788ayC2CfaA9P08fW56LAXBCGJX7v6/Mj4vS7Um91cWZ1scZ0MpcuW8QE8fAGgjr6BbzTl/P5B2uH8rfn6wS3PHMZdXdd4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF076ZiAMU8G2XbIPdYzcwtZ4JJo41tc7oHtPLXkGp0=;
 b=OmbYM1f3+37LeYg4PLix34zRqtdwIuqGxYH0FaR1TTKA395IlzQ2ML4B/fimA04Q21ikN+WtFcneVP098zXXWnudPgqMZh0WsUE38JZtwUd4ItoTcbdgzkrwqTsl78ok/amwFAeVne0PBTDvzMUOuxfSs42ywjpUTdZRVbV546K+ZNwiAC13cFB/RcnxJl23081agRzsfOnjOVEVOBAOS2lsQ8Dqfe9FDWjjLMW1ZEPsWMGj8DXCvpCAp5Dss1jIz1bdSeCWZcjPhtYJxIhY2He4SrNiafuXoK4laQaKL4m4UAuku+gKANDslSQdV27ppsFWWnUPh05yT014z8Hydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF076ZiAMU8G2XbIPdYzcwtZ4JJo41tc7oHtPLXkGp0=;
 b=U5X66Jb/JYM0EkyxYVDUChsyqpqwGkcbbrX8cbVXX9b9XJWcC4yCKJCrvMHMpivguz5ne41U1xl4ivtFBWuoiAu0gPrFkJZw7oBn8Y597WHKko8MRUeBs+Ix0XhlnoaCIf29JXOOLfFVR1PZBqNz+GyVv/c+GRVL36vvhWMDwtk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) by
 DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 27 Mar 2020 13:44:36 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 13:44:36 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Include headers for PWR and SMUIO registers
Date: Fri, 27 Mar 2020 09:44:28 -0400
Message-Id: <20200327134428.820160-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BN7PR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:408:34::39) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN7PR06CA0062.namprd06.prod.outlook.com (2603:10b6:408:34::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Fri, 27 Mar 2020 13:44:35 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94f95f33-a42e-498a-2afd-08d7d254fcf9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2357:|DM5PR12MB2357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23574426257F158367C3242FF7CC0@DM5PR12MB2357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(2616005)(956004)(1076003)(316002)(6916009)(8936002)(66946007)(66476007)(66556008)(36756003)(6666004)(86362001)(81156014)(81166006)(2906002)(8676002)(5660300002)(6486002)(7696005)(52116002)(186003)(16526019)(478600001)(4326008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2357;
 H:DM5PR12MB1674.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmp84etSzrUhsjsiRlPkfkUHSDEHbRtn60W6KwWGiMxBW3LqMoShxYH/w9GC/yX+n4JlCyierIbkzB2guL1G2WxhGUVTHFjDYtuPHPhzb2+8K3Jidz9RQoEdC1anTP1Mfv6lOgKU5cqn8GU/Wxm6VGbk9wHI4sD8TQnsR7BKEMFelHXLRSlr24oIUqeTfuIH6PFEHO4XEtFKmP6U8Uk79zXropFGYIjl8MzBF38QLK6guL7UaoV6P83hexKU3DBi6vZftQGzFSot23yNIuygq35CNAYyyk5Ngg/vHQsAV5sFQDzzXguO9KvRGVuZA/hx7eiNpEDcKPo8JJG6/3H7daAffhTz+dl1oyfjNvyzsEnsXXBVwQeFRvG9KH0IzDe3wNCUHKCdpIPYf0RmP6Gn5Ei+aBtj0qOjwPTzYFVr0u5os1jJNlKcVowIpw6wo756
X-MS-Exchange-AntiSpam-MessageData: 1VRBYmnQMZw4dsE3mZ8LkSLAPmKYTEH6bQlPD1p+LiD+M6eNQ+L1FrS3YNnKODIyB5WNLJ3eHAYmTni5YLTMPa+XZeo0jWZg8+LhNIjE9+XglmycHeK40QrRXqVgQ3t20jj1SfdhPkbQ6TK/6RDd7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f95f33-a42e-498a-2afd-08d7d254fcf9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 13:44:36.2906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTJZuuOcR2c0vxo/HiwWhtI0LWBNFkkGphmytKEsSrwDjJg1HQiRox0y5mvCLEIMsqjRE9Bn1Z53k5GnWSf00g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clean up the smu10, smu12, and gfx9 drivers to use headers for
registers instead of hardcoding in the C source files.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 10 +++-------
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  9 ++-------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c         | 12 +++++++-----
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7d98dc1d452e..619dc0f8071f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -50,18 +50,14 @@
 
 #include "gfx_v9_4.h"
 
+#include "asic_reg/pwr/pwr_10_0_offset.h"
+#include "asic_reg/pwr/pwr_10_0_sh_mask.h"
+
 #define GFX9_NUM_GFX_RINGS     1
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
 
-#define mmPWR_MISC_CNTL_STATUS					0x0183
-#define mmPWR_MISC_CNTL_STATUS_BASE_IDX				0
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT	0x0
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT		0x1
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK		0x00000001L
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK		0x00000006L
-
 #define mmGCEA_PROBE_MAP                        0x070c
 #define mmGCEA_PROBE_MAP_BASE_IDX               0
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 689072a312a7..69afdd24a0f0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -36,6 +36,8 @@
 #include "power_state.h"
 #include "soc15_common.h"
 #include "smu10.h"
+#include "asic_reg/pwr/pwr_10_0_offset.h"
+#include "asic_reg/pwr/pwr_10_0_sh_mask.h"
 
 #define SMU10_MAX_DEEPSLEEP_DIVIDER_ID     5
 #define SMU10_MINIMUM_ENGINE_CLOCK         800   /* 8Mhz, the low boundary of engine clock allowed on this chip */
@@ -43,13 +45,6 @@
 #define SMU10_DISPCLK_BYPASS_THRESHOLD     10000 /* 100Mhz */
 #define SMC_RAM_END                     0x40000
 
-#define mmPWR_MISC_CNTL_STATUS					0x0183
-#define mmPWR_MISC_CNTL_STATUS_BASE_IDX				0
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT	0x0
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT		0x1
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK		0x00000001L
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK		0x00000006L
-
 static const unsigned long SMU10_Magic = (unsigned long) PHM_Rv_Magic;
 
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 169ebdad87b8..4fc68d4600e0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -32,13 +32,15 @@
 
 #include "asic_reg/mp/mp_12_0_0_offset.h"
 #include "asic_reg/mp/mp_12_0_0_sh_mask.h"
+#include "asic_reg/smuio/smuio_12_0_0_offset.h"
+#include "asic_reg/smuio/smuio_12_0_0_sh_mask.h"
 
-#define smnMP1_FIRMWARE_FLAGS                                0x3010024
+// because some SMU12 based ASICs use older ip offset tables
+// we should undefine this register from the smuio12 header
+// to prevent confusion down the road
+#undef mmPWR_MISC_CNTL_STATUS
 
-#define mmSMUIO_GFX_MISC_CNTL                                0x00c8
-#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                       0
-#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK          0x00000006L
-#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT        0x1
+#define smnMP1_FIRMWARE_FLAGS                                0x3010024
 
 int smu_v12_0_send_msg_without_waiting(struct smu_context *smu,
 					      uint16_t msg)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
