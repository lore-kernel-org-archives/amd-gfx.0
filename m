Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D2CC433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD86619E5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD86619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95A16EB7C;
	Thu, 25 Mar 2021 16:38:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACA96EB70
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRzqwtCTXk/M6CbKy/kIiApMW+g7iXLgQtD4KqI8Rojq48s6oKufBnko5/1UrSvQMCwuNQZxIL9rYcK/3vJqc3I0rqMmnbIFVvYCoJpzChpn0uT3WeWayPtBRYQdofLvMA7K9Cv9ZN1SO50s6OoDAcQzbf8Sl0fIZzNF/ZlC9AwnTKNaubXkSpsPXleQCym1ZnfIi9Khoo2C08NNeiNFjSqk+4jaWW+1EBrvsJDam86BYLHi55LHNpUTrNUytlACKbhpWAoNKEnfynNr7HQCizIZcts5Qd6in1WCvsO3a7oJ+QfBgQuUIfwNFoU04kfW5rGcm8CoofjJBEVK33sthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8imTiHsybd3X8d58gZBsN/aunvp8cBXJ1m66RrZUHA=;
 b=iqPhONWpF5nPey7BVCHfojSMNQfSSe0FgGKAwt+R64pPBF2uSyECUtNKjemNkXsN1vjf5Ev3NNp2iwIBVTSzH6hDQkI4aw8VDn9BFVEpspQpJVG1zq0gesm70NDt80E9yOv7r5Iz4Jvh8kEUR6tZ8DEqQd91lz9ER7r6SZ77K9wuIpHbSRAVZ7ppXGoe9JaJhRtlQTjv0NR/6dKlXYQgIC2QDZVc3xsWKNWPmeMUASfT+svMBa8ioKqJ/81HiEx7Ct/eXpq/LeyzPbaGSCkI5iPPsoMk+jEH4Jwkdvhasmm9rO8fTQeMn/twr5eHy/EfAi8l2XbWJdO39gtZlYR22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8imTiHsybd3X8d58gZBsN/aunvp8cBXJ1m66RrZUHA=;
 b=vtCpU2+ZNULD3g8axKuvPXaUpPhYV6HqM57xdAc0fLXZhrGMbLMA9+dcdVqU29OlMkd17hbsvceKA67BMuWLlgkVtNnIyr039biJpzbVzBrb+WMNwnhuZresiV9ooJnIDgRhGc+g9NGkjE3U93qYQe5HkEh/IZvZEkYXfqwFCYI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26; Thu, 25 Mar 2021 16:38:45 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 16:38:45 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: Macros for vram physical addr calculation
Date: Thu, 25 Mar 2021 11:38:35 -0500
Message-Id: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:38:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a41c43ec-4a33-4036-4e04-08d8efac74f6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2636A24C399D81987442A32380629@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAkPujYDf32zTqrZWKHAxU/4naa+Hfq3UT0zFqci0JdlWD9bLChV+0l0zHFJxtzq8V4baYKfuC/GvVU1y3/OqEgf83hfP324AxxCV1/0XUpYUPLD5Tcr5gFfDjmbbY11uT4yTbfmuNEAZfrHthCWaqX18TJYQSt3689ibhUbJBrNTmI826QgTy7s03TaXr4SYywQ0fg3zSYVGtCMBm4pgH1LKeeW3b60TGyskPWSfVtoKc/M0HN9fCknYtnT0HopFX3bdmcVKsdc6k+jnoXzBQkxnjXGMIqnkUpNcRAVkf+gLnzFcq7xAAsCRyagKpPFiCswf9gcCdLTiElWk2m1u4l3i+VZjhs1tsTjTSztZAIeHBK4tE1flyJhXLsxCLOc3xS1lRFZOMT9yaierMFzgPeHDUedxShIvVHOn4SX5hOfbRy/hHooZdEr9dyjz3yPtRo3lnIQ01JJZ7Se4IaLyj4lw0UK7UbN1gliav9cDzSBk7K7N459YfFNfu5LIDSPYpsJf9lKoJGs7ZP/NzN3ieXSOxue4JfliGjExn9BZpWelLddFGBnuXY0SdGhTxpNWQbdO09txhYlu5qJUrUDjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(8936002)(316002)(4326008)(478600001)(2906002)(86362001)(6666004)(6916009)(2616005)(8676002)(16526019)(7696005)(956004)(38100700001)(186003)(66476007)(52116002)(66556008)(36756003)(66946007)(5660300002)(6486002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vWs4dtovN7BO+xO+uvKVOcIeC110b7ZkqOui+YtOJJx+6LQxaGm+X0WTObqJ?=
 =?us-ascii?Q?z2XX2btywo5Ml5EWvrv48Nqvomo5yARs6kivdj/bQSJLd1ILon+vEOxz9SOk?=
 =?us-ascii?Q?VmfSKAlLxul4B212laqNio1NzG5llZXGoyFT79epuYm4bd8gOtMsW2QKM9yn?=
 =?us-ascii?Q?dCj91DDKqjHtT/QaTj1dmc3S9oHJYm0V9Gj1af4nkon0dphH21Xbx7cSvmgn?=
 =?us-ascii?Q?0ytcYHEXPLbiI0AAtaJI6vBL8TKPzQ5V0zAzlBkg+SIFtvxUW5+ausYCVtHm?=
 =?us-ascii?Q?hSpSJJGFVD47NYrmvbm7KpQKu3d5/lTvfSt/JzkQOBmrtnJIWvETs8xDz8vP?=
 =?us-ascii?Q?vUFM/42GwYwBFV5Rx6Yjp7CcXlmafWsnCp4foaxT2W8NkObIa4aO/Ib1TpsV?=
 =?us-ascii?Q?s74KUaLCou/PS8PsSm1ykKsIzfPqoXgqawyFkQk0go7ktEHdO+50/3YEiMeH?=
 =?us-ascii?Q?i3klXf6p4POtwm7euoUCDk30TIYvzNqvQX6GLbVgnXdDu1RBYx2UrollNAgg?=
 =?us-ascii?Q?gIv6SgjXinx2gM7nX18olSmig7H82zAcVGJai5xsTO6FjPj5BY43RRnMiqU+?=
 =?us-ascii?Q?1OH6ijgDCa/TlqG1zlv1faPnZqXzjizmar5YcXOfA9aBGQ0AK7N/qsy62Rfw?=
 =?us-ascii?Q?yS1WTdWF+EzQl1UaIIakZUWesG5AiP+C3Yjx0JdUY0nZ7uiPwypfx9fNkM9d?=
 =?us-ascii?Q?/+HpfuIMbPMTSuRGpGxPuExZ/lbjaMT7dvIzPHdr67+DyRDJiahpUyVWc1Xt?=
 =?us-ascii?Q?Js98xeVnu1SujFFQMIpUxqU6mmWx4FewcnmbFqQzPCZyi4oyU5HhpiaLZsVy?=
 =?us-ascii?Q?Qlj96/5V+viaelU9Ncn+iQzfGSvH7GIWDmzHq4IUQL9LarpcrYExJj1kYbbY?=
 =?us-ascii?Q?Y5Sl+R7CbFWO3YEp6QMHOp4oaF1fdUh9FgvtL9xKezOlXNwpYzKWDYls+YgT?=
 =?us-ascii?Q?QViUF+1nYnMWnnKruIUuEcXf+D1OH6m9GV8UMLv9+J2TehhpXTPnvVY9CMFG?=
 =?us-ascii?Q?GRDDmhd5s6NB6Wi9no0WqYl5l7e6tUE+AI2T7Jiskn1dOq4WrbaPrmFBWxmn?=
 =?us-ascii?Q?VrKhf9urU7F5gFn/XhepZI9GWUpFwMMR4WbKOnsEOp+b7odupW1hEA7IMsfu?=
 =?us-ascii?Q?XAg67j6rL5GpZQpMVPsiW4xwUCQPWrS1byrpf0mRVptBbQWPQSlqPjhVCHz3?=
 =?us-ascii?Q?ak3esEcxRVyG4/OmhMD1bXlEYsjkczW0DObm+RcD/4wkplWrYe4H8PMk62Eu?=
 =?us-ascii?Q?9FKnhQI7S6/yPqXBOYSBhmIjSNatUZhfxwooupypt7zZiwW6OA6m4ab2jJ5G?=
 =?us-ascii?Q?1zo2Oe4AukXqXclSA0QUHlE9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41c43ec-4a33-4036-4e04-08d8efac74f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:38:45.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXxUUhZzEkEe6MtbRUUk94iJA7j1xUGrC5ndtTHp3ObbJMV+b3DyDraSYDpnUEdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add one macro to calculate BO's GPU physical address.
And another one to calculate BO's CPU physical address.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 2ee8d1b..7cd9d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -283,6 +283,9 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
 #define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
 #define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
+#define amdgpu_gmc_gpu_va2pa(adev, va) (va - (adev)->gmc.vram_start + (adev)->vm_manager.vram_base_offset)
+#define amdgpu_gmc_gpu_pa(adev, bo) amdgpu_gmc_gpu_va2pa(adev, amdgpu_bo_gpu_offset(bo))
+#define amdgpu_gmc_cpu_pa(adev, bo) (amdgpu_bo_gpu_offset(bo) - (adev)->gmc.vram_start + (adev)->gmc.aper_base)
 
 /**
  * amdgpu_gmc_vram_full_visible - Check if full VRAM is visible through the BAR
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
