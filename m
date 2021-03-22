Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F49C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D28E61925
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D28E61925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1496F89B68;
	Mon, 22 Mar 2021 08:42:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E9889B68
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 08:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RonH0BCJmBFmrU2tVwODjWDDJHPeZsnZmGJx6dydIPJrOuoKYnZUQA7+1oHOo9T2ndxvmsHMwrx/qqRC57Oxlq11HrbP/YJwsGcwzl6ForKa1l21BJB3hsPFJN8YfWRS6LWWuvd4zcEAHsKMb/yqOb/R1cwgIcgyTWhYdSO9myNa35s5wauYCNd6mDm3swITWzYVDhU/VW05fCvs5YmjksAs7+j1eWVliRC7/elclhS5uGi/qV4KUMbYbhobQCNmIQxRs+Wqv3w3ZI1/0ZMAn7GbPOkitchmRF1uzuN6QhvLZw9d+64uUP1VScl3VFEj+xMvztrWZgF9AMkdy+YagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vePCLNMshlzSEg4+AyebHBEaxyzIKltVNF5W/TP31bA=;
 b=h0BK1uraU63gyfIeyo1XzBGHAowOL8FWQ91syqSUhBzUMiJwlv+1BnWHrk827+tnM+qypglF/v87djwHQmQ66rcHzNJpiAhVg2ju7patwpduqH1LwqU1xhswnQlgoYJkUmyqoMeiWyIOC8wSTNYkFs/c+mVJX+tk2e3ZO3YmiZQ/6WlummA38XnCxF5IbJ2E9ugECBN8v4uaC5Qdw0ku4uUM+UG9kAByruH2a6h8t4r8H55Aa8RyDQnauHwbqT+8C3X2R/80DP9+bpTvfaE5vLgiFG12aO157yrhcVL8EJgZ4rSzFH4ym4N3PqtdfANmveAO+A3eCIiYKQo5gVjC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vePCLNMshlzSEg4+AyebHBEaxyzIKltVNF5W/TP31bA=;
 b=vLV0EHwF1DuZISVXhiQ6N6cTSWVNZhzk0tT1ZV6WRvmFwFQe1jbIqp8J+rI6Dw2P8eZ/ApLDB70lHry4gR8B33a/5Gj3UzEgp/iJtuqpKmARhvdGbbkZqVUhIwHQj2/vQx1eYV7w51XU21vjdiU2AyqJr9RCiqURfqXlmyvaGU4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 08:42:51 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 08:42:51 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, lee.jones@linaro.org,
 harry.wentland@amd.com, alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com
Subject: [PATCH] drm/amd/display: fix modprobe failure on vega series
Date: Mon, 22 Mar 2021 16:42:30 +0800
Message-Id: <20210322084230.24043-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0156.apcprd02.prod.outlook.com (2603:1096:201:1f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 08:42:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59698936-9e8e-4780-0bba-08d8ed0e7a3d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01846186DD41DF79F911F63FF1659@CY4PR1201MB0184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0NkxRCXUHaJY5607tEpJFZGOmIk4qyW8apHOlG5ylgxlXIgy0QUDvRVMsvFV/M+4Z61pjp5QDvfsVmkuvFbQHvyqnmZqVIkvbtRPG6zKSpWQfvENAvlVXJH92uBV22YMjSRl5ZS/KNL+z/wYpUrjQ5r+hpk90Kvblx9Y6YyqprUW6ephTXnEWJeMYWpPKDJh/va/6p4RKsSJ30URmbg+z5eTSkX/cRlYZgayViXwt+V/vMqpAfTmieAGBOg10f2I75du27lb/1ml/RWLySH2FvUR5ysQ5MvzYjPbzgJrt3Uqw9OchlfR8d4pjc4lL7TggIYd7m+xxrjddhkR0uaKK+wFtzNlmt3C3iX1taWCemrgH+8aWnenzTuALFyt3Jm7qXiM7mjLGCS/HvXv8kEmTKDnMv4xDsRl6q90UVilXOcNnTCMlEPecHzOUbIvzKVm41JRKRww0isOCk2kYg5CJ0un/f9Xmm4IFc2Zxx+Fn9NmDJY93MzP4zxUWxMdrezUWmdKDyY2OCh2iEticgvFP5ITs/EVp4qSOhHYPVJf371nK/UJFJhZlTy44LNfoizBfvOWLEmCBsKZt4AwAUwJS4H04+EonBeEY7Ac1TUUa2xXynDEDSTZBLyQHr3HlJOxxQEwsIqqzNaSI054UdZ/YIYtFe8yvH9QJWMM8lC7rE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(956004)(2906002)(8676002)(316002)(2616005)(6636002)(38100700001)(86362001)(478600001)(8936002)(6666004)(36756003)(7696005)(16526019)(186003)(52116002)(83380400001)(44832011)(1076003)(66946007)(5660300002)(66556008)(66476007)(26005)(4326008)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qMBPalqtoXAS99l0YMFNEDM9LUCSFOlAtYIsOukjCrV1gBg1ODI9VT7qs5If?=
 =?us-ascii?Q?8VuwJwYteVMZJ1Dytj5LxKKnS/sBecb+WCxk1rul7+s+PmOrECnbV7fc9J66?=
 =?us-ascii?Q?HiWWX6ggP565tMIj/8XSZcE+nFecIypUaRo31LToRggdBLuotJ8dnxlA5yWJ?=
 =?us-ascii?Q?aeZ8GE4Hc92c9U5+snND5xT3OU6TpZkd4krnmzatiRp+0r/PpNSof3LIxfTC?=
 =?us-ascii?Q?Sk+NAH0ORNm4ftHXbcEx7NgQD+QN4EIQ9yBGkOzkEWh11JgdVStsEbNFzkwD?=
 =?us-ascii?Q?ktKBvV6kNlsRp1ZULHKbOSTHisV1ROpk9sdSM9Vo+0uplf+nY9q/OvX9NdHb?=
 =?us-ascii?Q?pSRH7sX6C7UGw92SByWFa3GE8pMM/XmSrY5S1H3doE0ZJGuG7gXXnqz67SBe?=
 =?us-ascii?Q?wpzlTAKroxN/kWkBIfLqpPQ/MclTx5W+TymNi+jA+ZCJDin3z+bmIFiCkZ37?=
 =?us-ascii?Q?B5Hg5eyZCK1oVKaoYf1lzqFCNpQ0bkJXUqbW3VQyMqyDYsVIhXWvqNZ8Gyyq?=
 =?us-ascii?Q?oTdI2mi224q+NXCFuK2HgfysA3wun8YJ9RQy5bbm7Ig4XNm3ZPMCKRabkjfd?=
 =?us-ascii?Q?sysBQ5bslZ6DD1Vvb+X6Z48CoVmuFy6IVcMfYwAE5cc9xHj5Yl2vr/P+y2x5?=
 =?us-ascii?Q?5FnyZS/vO1FgClhuL70eHGaC9GSRm2hLxKxi6ZGCSZo/aVqvl23KL/+KC1HY?=
 =?us-ascii?Q?uQA9e1S0phqscKhyBgKsl1e7ltlsbTmG4BGgHWi8DMUwVV0e4fbBjxBGe3/3?=
 =?us-ascii?Q?is+YI+39ebUFvRsqnJHVcsRJrzYtKVQfCFC2mArXzeL6eVLLpwjU4nWXy9PW?=
 =?us-ascii?Q?Buwg2RbW77a+5jl08cpFkS8lC2h8lmwapswJBeYO2jAONps8rk8otwv/+ljL?=
 =?us-ascii?Q?kYGUjHQ/Rq4TEKOmfpcaVWs5ytLVKyIVLeJBxg+e4gNMT8SK5Wkk8tV4zhEQ?=
 =?us-ascii?Q?8NY1mhtDf5XR6ofAaGwychIi8i5PC5Cc0G5uNveJjCOvq3S1O7vXYlZtoXbl?=
 =?us-ascii?Q?sztK77ntLcMYkb8Xc5M7pogrSV53IPja/kBCjxvIDCzHg42myJtj/eDv1GNO?=
 =?us-ascii?Q?HMT+uPJV++UWqXXywxGnwPkyaAEq7iM9yDUDeSxSThp5y+ctML2vTd3mGtf/?=
 =?us-ascii?Q?958LP2LGKnqHu5d4+oOaQTc/dm5/RgtdajsR0Khd73JzSdl/tPJMpJdVEsDK?=
 =?us-ascii?Q?UNGC4wYfSnU1cXnCltOecPi1XwaihQlrJ+2vup5NePf/3O/2RZ/yaIVNeXVk?=
 =?us-ascii?Q?Mn0kb2j25/JVEJommJkeqm7dhBCQxbl4ou4I1SGVHADBaMygFfoBzOntITei?=
 =?us-ascii?Q?ju/UAafb/pFjh56I0KytEQ7A9+kY1OdMzEGQnpZmGJgFlQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59698936-9e8e-4780-0bba-08d8ed0e7a3d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 08:42:51.1190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR8feKXyS6bVgdKdNkfph+Yly32gUF+Bn2BHUAq5TReZlFgdNyiSfIWgiFoXvN80e4uSoL07/j33y5dtPjGVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: d88b34caee83 ("Remove some large variables from the stack")

[   41.232097] Call Trace:
[   41.232105]  kvasprintf+0x66/0xd0
[   41.232122]  kasprintf+0x49/0x70
[   41.232136]  __drm_crtc_init_with_planes+0x2e1/0x340 [drm]
[   41.232219]  ? create_object+0x263/0x3b0
[   41.232231]  drm_crtc_init_with_planes+0x46/0x60 [drm]
[   41.232303]  amdgpu_dm_init+0x69c/0x1750 [amdgpu]
[   41.232998]  ? phm_wait_for_register_unequal.part.1+0x58/0x90 [amdgpu]
[   41.233662]  ? smu9_wait_for_response+0x7d/0xa0 [amdgpu]
[   41.234294]  ? smu9_send_msg_to_smc_with_parameter+0x77/0xd0 [amdgpu]
[   41.234912]  ? smum_send_msg_to_smc_with_parameter+0x96/0x100 [amdgpu]
[   41.235520]  ? psm_set_states+0x5c/0x60 [amdgpu]
[   41.236165]  dm_hw_init+0x12/0x20 [amdgpu]
[   41.236834]  amdgpu_device_init+0x1402/0x1df0 [amdgpu]
[   41.237314]  amdgpu_driver_load_kms+0x65/0x320 [amdgpu]
[   41.237780]  amdgpu_pci_probe+0x150/0x250 [amdgpu]
[   41.238240]  local_pci_probe+0x47/0xa0
[   41.238253]  pci_device_probe+0x10b/0x1c0
[   41.238265]  really_probe+0xf5/0x4c0
[   41.238275]  driver_probe_device+0xe8/0x150
[   41.238284]  device_driver_attach+0x58/0x60
[   41.238293]  __driver_attach+0xa3/0x140
[   41.238301]  ? device_driver_attach+0x60/0x60
[   41.238309]  ? device_driver_attach+0x60/0x60
[   41.238317]  bus_for_each_dev+0x74/0xb0
[   41.238330]  ? kmem_cache_alloc_trace+0x31a/0x470
[   41.238341]  driver_attach+0x1e/0x20
[   41.238348]  bus_add_driver+0x14a/0x220
[   41.238357]  ? 0xffffffffc0f09000
[   41.238364]  driver_register+0x60/0x100
[   41.238373]  ? 0xffffffffc0f09000
[   41.238379]  __pci_register_driver+0x54/0x60
[   41.238389]  amdgpu_init+0x68/0x1000 [amdgpu]
[   41.238836]  do_one_initcall+0x48/0x1e0
[   41.238850]  ? kmem_cache_alloc_trace+0x31a/0x470
[   41.238862]  do_init_module+0x5f/0x224
[   41.238876]  load_module+0x266b/0x2ec0
[   41.238887]  ? security_kernel_post_read_file+0x5c/0x70
[   41.238905]  __do_sys_finit_module+0xc1/0x120
[   41.238913]  ? __do_sys_finit_module+0xc1/0x120
[   41.238924]  __x64_sys_finit_module+0x1a/0x20
[   41.238932]  do_syscall_64+0x37/0x80
[   41.238942]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 556ecfabc8d2..1244fcb0f446 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2051,11 +2051,11 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
 
 	enum bw_calcs_version version = bw_calcs_version_from_asic_id(asic_id);
 
-	dceip = kzalloc(sizeof(dceip), GFP_KERNEL);
+	dceip = kzalloc(sizeof(*dceip), GFP_KERNEL);
 	if (!dceip)
 		return;
 
-	vbios = kzalloc(sizeof(vbios), GFP_KERNEL);
+	vbios = kzalloc(sizeof(*vbios), GFP_KERNEL);
 	if (!vbios) {
 		kfree(dceip);
 		return;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
