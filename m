Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6231C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 03:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D03C619E8
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 03:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D03C619E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7366E95A;
	Wed, 24 Mar 2021 03:51:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B4B6E95A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 03:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4BVvYUq6uInjQdwA4PKfg2QVyPfJ3brpvDUedcHB4k/CSIsNlSwdL92lGk7Y3DYG3fDKnoIg1GlCLqr1s5x7nW0HR3rRpWSod+jc7XHD2feMTBZPha9BxaKmCFrTgPu4HZoKJN+7n1ypr7AA9pVdVnpnacJGuVcxU/ct86HNVZeqEMHdffTR8RaMn+7dgpPUdt7I86FwLP3SYgUX/QdW39loPa4QSP7xrWs5GcH6WlSWSkTX04WZr1x2vZFyo5OrlRoK3qT7bO0J4bU8YYLUYBk1tw91fCKLmrCj8L8b80YuyjYDM1EySZ35DhBY6Uu2WxMSZf6GweA8K3SlnWV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK/6V9VwTCNYZWJ9Qdwoaq+c/CvuO8nDUYju/W182Cw=;
 b=Ss7xmVpAWCV+tvDIH0ncWIv4MTOWT8V2puRBYR8GoAvRW1HVfe3M6THtcVfztxKAjyj9AJ/o9pHNciI4mqZIgiKaaA6pIder10X66V9EFeHTciEqI3RFC27dAY/qXkHbpE4SRiEotId+hCennDAxOA5Cq/0swzyhKOZBfFcF96tYJ2Auw0v3u555wbF6ysZ4W+42bRz2kqFzJWlsUahEwP6fNVGDhNoRavb8tlrB1l2eK3oum0k7dpJF9AdDmfWx4B6Bw4cRHyaPlkJvaCIRozTT0vaDGEXyl5nt2sde8j9+de9KfEassXwVXZGdI3nmF8TCJICuOHPDUy+dnCWC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK/6V9VwTCNYZWJ9Qdwoaq+c/CvuO8nDUYju/W182Cw=;
 b=bu2CbJGlnvB9h52JY3T2HkNxJrjIFLJYk7oZklj71kHAH4KuTJVjlb6wIek44zHyERqeOd0FxkVsRLIxctFXEOQ7Qnorm0Qrhf7LfMY5tfmZlQ0KLRSeCXN91D8MmLsqKsK0jVOwknNhrJL61uzCtIunMHdu4afz8VJfllzGWFM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 03:51:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 03:51:00 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: mark pcie link/speed arrays as const
Date: Tue, 23 Mar 2021 23:50:46 -0400
Message-Id: <20210324035046.1989871-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: MN2PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:208:134::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:208:134::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Wed, 24 Mar 2021 03:51:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4038b018-acb7-4662-8ce5-08d8ee780a04
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36614622B31A086303FE3EC1F7639@MN2PR12MB3661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXOGTVLv8vNE7I2SS1nAVHPfPlqEOa1LdGlYcaFdEWd3QgkJV80WeLUvsY0pbfJp2iRTfcV5JeYlo+y+UZNAdGAYm+7GoLwrdA/0CDBZU1YNm1H9A1h8FSpCuQfdCiT1FeSg9HhaOW95y/sSOE5TJVf4QARQDMrTOq7HVLuqsf3Y509PxKla8Q9DZVsxhkEmL0lP/5zXq5Nmo4xqtCFodCP97OGGh/lY163XNk+KYRRfP2rO50jvxNpby58dfs7+fNkOnK/UUfC9sDTC8riyao0c6R1xBRr1u1P4HED81/GbWTyQ6HuudXZ6hjF2MkdI0ezgLNzZUGjcVRODWSg1Pib8jwfXGVZospfQZCxs92g37ftuezNnyASOE5sX/tTMozm8Vk7SRBOGOsjyeDF3naVghkIgxhear8DYpvuhajJ+Mx0/7raW+xEirutM+7/8cZ4cJ15BVMc8REuAOT7tTbfF9sk5WHIOKMShuPjSb/L44SFXsQ8iSIAL+gwBtR9bFWTBKGhF3xwyeIzuogOcngC6X49zqx1jRFxgI2eX9cTqanf0QxUZ/eiX4CnmCrCV/wP3fFZSg84LTYT+WlFcof8qCBsWTstNYcctUizNR2YFCTAli2s1hj0Aq7JuCxuiH/XzIbKI//ziB7Ih8eoDeJbVlLA83tW8x+SuQzKqykk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(8676002)(6486002)(86362001)(478600001)(83380400001)(6916009)(316002)(54906003)(52116002)(36756003)(8936002)(7696005)(1076003)(2906002)(66556008)(4326008)(38100700001)(6666004)(16526019)(26005)(186003)(5660300002)(956004)(66946007)(2616005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GZ+XKxt1VdcYiJGhIw2TBuIkA0CA05gHeEb0mU+uAIOPSCXbwJWNSBpcuhdN?=
 =?us-ascii?Q?r+Bu7k+n+j1XsDFsJBifhLrnqEOfOvDPbaINc0gULBjefSsaXh1njCgVP+dD?=
 =?us-ascii?Q?BKsuNsbtWuPBDRP8W4ZrCwFGhnUpQHWmfP0yHnIJOcVRPjPOFIqFvQKe8hkO?=
 =?us-ascii?Q?eRJYmVdH8cgh7VQ9L53G87qvUGk+HUJ/46Rf8p2nkECNL18xrfB2rsgBBJKB?=
 =?us-ascii?Q?V6cqWaEXj0Q4t+YXIZzXC47FKYthQ+8UmXJ60ax4rUfe1rDrwgOdRPFZS+ZU?=
 =?us-ascii?Q?v0iImLTlQ7xJOFWOr2n1s2X/Iyqw4tu8yEL00e6aghyGj7nO3aguoCBBRhxS?=
 =?us-ascii?Q?+fyN6t8ypAkVxNXKxgCz8lG6J2h7DZzE3ej3uasmcybQ/p3dtRQmAWDcM8CJ?=
 =?us-ascii?Q?h1npSoQoSsI1JEfYsAfJxW8tImmIMbrm0oDSixjTMQl6C1IjNiSlHKUJnQQ/?=
 =?us-ascii?Q?pOi0dnImk/CcPS0ER/+c6hJ3E6fCC30obyNj5Gqk+ZRpDFd4JZJDQfB0qv11?=
 =?us-ascii?Q?npwpsa+XQtUsAYFJumI3LUZm88wVO2f9SejsHWIbX6gHob1RKou0wmCeG7dZ?=
 =?us-ascii?Q?QBi+AkkMSirc0Lb7eQHBLSBGHyDQBZgMD/1db1r+aJW2MGNwFS20goBqipFy?=
 =?us-ascii?Q?eMoGVphAbm2kgfEdG8dl14cx6+ZpO3EqyudMvefb0+jeN+EV1KYa0frjIhbY?=
 =?us-ascii?Q?BGuFZFW3oh4iorkW0R7i6p+Q7QBAB0jXEJIVbr1/DdBYlJUXDEtVikUUFt4k?=
 =?us-ascii?Q?GEeDtZRqAJwou5UITerGrSPuLwurwsA3/SgApfLEZCWvrU5yflEz71ukva9Y?=
 =?us-ascii?Q?4GIoxLMvnMvCP1JeFNeQjsWetqOvsX/0AifZIVkwPx9hbG8cAcP5mSALZqca?=
 =?us-ascii?Q?xR0T6RHvKDPmYq5o4zAg86iLNrU7FNSxCI0RmhkcAfKrcOg3gtgZE/I1KDz8?=
 =?us-ascii?Q?fkp+jvCi14Xqu92ln+mw4ghyK+yKna3MpmRiOPiVfAOEto0U9RAwIEpefe91?=
 =?us-ascii?Q?F2F3NNNW0eZE3jjp0/9JU4rDBTw9mnysrXNNKAmlAsjjSx3ONk0htO+GITLM?=
 =?us-ascii?Q?sqxHtDpk5JDXG2f9AFzd3QUBROndJoOCstPlOjOUt7hcWdL1biFAEZlvIPLC?=
 =?us-ascii?Q?TcFAxNppbqRsGxOkzNTp5MP72NqSUE1wrZxPnPBb0tzcRWguL0dF0Tj5J9g3?=
 =?us-ascii?Q?7bg9Cs4JoGG1ZLNTP21n2hpkPD3ytuSS/FcnfZZzLBYHy773gl21NQtviUl9?=
 =?us-ascii?Q?x82lKTM4rEboit5iIr1UsRQZCP/DSgedwxhp+7c5h8HjkI8CssBQWLdazLgs?=
 =?us-ascii?Q?cRFQfJaoKdU9XWB8ZDukseh8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4038b018-acb7-4662-8ce5-08d8ee780a04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 03:51:00.6781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gne5mxeCNhu3vWg5B2u0xcfkCB4WwEoBPRUu3hhej4Pe/UJSm1ZQupBHIsyVsf2sCFgbghRruO9MT38TRZ/qDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3661
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

They are read only.

Noticed-by: Dave Airlie <airlied@linux.ie>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c        | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index ad4db2edf1fb..d5182bbaa598 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -61,8 +61,8 @@
 #define LINK_WIDTH_MAX			6
 #define LINK_SPEED_MAX			3
 
-static __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};
+static const __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};
 
 static const
 struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index b6d7b7b224a9..1a097e608808 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -52,8 +52,8 @@
 
 #define LINK_WIDTH_MAX				6
 #define LINK_SPEED_MAX				3
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const int link_speed[] = {25, 50, 80, 160};
 
 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 213c9c6b4462..d3177a534fdf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -57,8 +57,8 @@
 
 #define LINK_WIDTH_MAX				6
 #define LINK_SPEED_MAX				3
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const int link_speed[] = {25, 50, 80, 160};
 
 static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bd3a9c89dc44..2e296cb3bb04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -72,8 +72,8 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
 
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static const int link_speed[] = {25, 50, 80, 160};
 
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
