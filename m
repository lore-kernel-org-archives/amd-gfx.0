Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00724C43333
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD16164ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD16164ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A056EB68;
	Wed, 24 Feb 2021 22:21:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B6F6EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKeCxqQau3bzhKcQVM/80ucttCjal/s+j4hxD53aWJoPglXEoa+lLwCcabSGhnN6nWuusweljb8V4iTUnuQCpzHpqceniOPyZ7NDArTofm69ipRnPtzutqthKdvoZkt+vxFXStrEHLOzSczJHmim4Mz+7k/FquAAk8RrEOxdQB2t56vOXId+iV7HADKeuEp+FsCPxSiVz2/CYEyClSre2HGW9Oidtj2ekzfMdo7IS46mh9Qdquu482GqxUi4psAklH5las/X3rjC2R5sarKy1sYCDfUmAe13eeVI7dAQQ32XXNamF0AgHwVVYRQc/qV/DmTi2hMuJXy/IdLHeuPl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnafkP8DE7r6KfYlxIZd4r1AwKEcYPYd1LOCcSU+TLs=;
 b=FNC0puQ/+ZLsjVbh+HXuLHZA00AFwvid2+r7MJ5pnwBcTbrMCnkPAcQ0jVOGYbFzlvqOdTV7flVjJIEzyPO+8L9+j3+euxXGAgSnk4/pI1Lh3ajuJFnjWTCmcaH1aHZCJtBLmDNjCVHx0+N5zYyfKsstZ1HzoDQjqxo2ago5OMS9UI7QCZd/ti6jqCcgKCdgfjNYam2QAKccCKx7pRv7VfkyjGhTBMRYbvt/rvl+QJaq5yQNFqGKbX96soSnMZbZWhuKVekVBVdnsCuUhtxMc+MaTAmHYEHCLxyyN6lO6YCVqCO4W+f0GMlJfkT3t+toWar5wmRrBqD9CQvezUi0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnafkP8DE7r6KfYlxIZd4r1AwKEcYPYd1LOCcSU+TLs=;
 b=UlXEVMZt99hRb8bn8hmyaLhcAElyPDtoXaKqS1U/5U17YhGjACCl/HV98h8nYnUFnnhiV8pOxV5HwV2RwOnB9SNgjI282wL5E7y+cQvUoXLYOFlhkzb+KbZ9GJACDpAbQEx2vzs+/pRh0ZB2dvv8k3W5z5DpUEcdypl2wFilI94=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 091/159] drm/amd/amdgpu: Add smu_pptable module parameter
Date: Wed, 24 Feb 2021 17:17:51 -0500
Message-Id: <20210224221859.3068810-84-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da09ca07-8a19-461b-c08f-08d8d912614a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046F0B32F47863A0EEBBAEFF79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcTFcMu8huXVNLLnCj+zYPRzGwU+pEn2Qt68tzMbWKXhYrUgC2LVqnHfhyIqbzs2Upsoimy/5bRqOW9zYON6Hr/18sUjUtONvbx2rhrpFV+XUwWGHbrJ9Dr9oxcjCPHUFPQ8e6pK/Zzy4b4OTWIUhyEJ8kWMhsh/2eUVtJryz11/nkAnN2RmbOr4Mlq+uDMcQoiwxypY4DMGvBHjmPesYMySRaIlf7Y7pfE3V9bpDUnCXwMMJMZv9hDKT+vPUrMwWEGi19xYL80InWZ10e1JoG2nWvm31CTplfTbvpVWWxiya/KZfOkDDOWv8dyAGRMsVqJ4ZevmxtTCLm2lGwsVihudVc5G2GcQLyq/T4X3eZSrHe51N38TallEclQnTEa/HIAyhWt8cxz7fNpfr280cgKZUux7EOgOVHLmqIVaBsIotkQXvhnrpNl3PtZt6q2NBzuWm8VYxBaZm/2SzYeKI4M0t5JEOdOjx7Xf9sav+hH7c/nWNS5aCfKVhe4zSTiEppw/w+7O/vgHuXjzahdkkpaxcS2NkP02ZiIHf+KO0SVHbsKCzYZXi1mkMDYFEwAzlmEIgcFThx49mo4+Dyo2fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eOIsVlUyzwzhwuB+Ov4ASuI2dfpXgawuCqDyXQF38sKyqDtp5gKc/33QP4Vg?=
 =?us-ascii?Q?5p2UwBH5Ii1oejr7m8/HwRycJ+sfugSz8HsE+fcQ+lzLme9+C4gj26wfWuLj?=
 =?us-ascii?Q?gpsJwCVR6ZkEF0vCDgqRbe/wMQjrUmwP4EtBSsVbuIsQ+uM+2nk+afxUNWeI?=
 =?us-ascii?Q?6RVIPJmzeeD9nmdkvJy8ijGvmQRzkhzEvGh9sqJRG5cB0fpZGgROCMDqvUHN?=
 =?us-ascii?Q?2mfPvRM5dOod4/sU84m1q4Vlt2VwnGFgS788BAFtS7mU6K0ZUoU8DiLTQYtN?=
 =?us-ascii?Q?jh5BwrklRQzOBqf+wTHPb2aZow8itOa3RkgGrqzjGaRIU1xarplpM9hceQrC?=
 =?us-ascii?Q?C33CsWX/EgxL07Gxby76gMvv3P5SsK7deOtbL7f3AxpVTbOp5aYoFpniD5G8?=
 =?us-ascii?Q?F6FgX5H2FOPBzPvOL/HcRRpykTT/GmXb4T7SljQKKo+xqzSXtkxWOU8Dgd3n?=
 =?us-ascii?Q?OYEga2auPT5FRehFT15kQfdKiz0GVotO5PRU6SSrcEpSN3+p6si2jHPiI+fI?=
 =?us-ascii?Q?+PF7XPHuIzcU8dpDKdRsZ0SJz0/50tsqlKR0JosqrC0qD9Qi+R7FTlj7wiqe?=
 =?us-ascii?Q?lgS4g6PHV2KPo7OSSBEt1XLdtqwf0ar9OwJXrea3dRH5cuYlxDcCr/hjnM7a?=
 =?us-ascii?Q?56uXx0HXM7kWK2diBjY85He+Qz97q/cNVFr+6rC7Qwb/eJUcxJvR7ASJ9Ya5?=
 =?us-ascii?Q?vCfcNv4Z5+FY6U9Z7p4AnSKC6/q40Am60lND+Vvx5T/7+l6bHLSUJDa8CeZl?=
 =?us-ascii?Q?3BBMdViuIycfSEN2KZUAdX+jAKsmUlKryWMlQBaznB3j8trRMY/Dv1mlIe6W?=
 =?us-ascii?Q?ZrHrbYdg6Cc6b28rWQk1/Ll0BN6BWqpj8ZgVwsB089ON+IMjL3zE5AxG3D4D?=
 =?us-ascii?Q?Ok2j7Jsdkr7TQE4iPQlqCjH9uEyWSNSawhLtByy2ZPDTAfz6aI9YFJORhp1x?=
 =?us-ascii?Q?4ACBDRyCMJ8knfMkBSQsgfCja/R6bJHJBWHyunTuQgJ7EDxGs9FWsDJVCjf6?=
 =?us-ascii?Q?x+VsGdwCxRnQztV3ivRiBzjaEhiYkhi+lXOZnHkjV8C97eSjauHBYmy7XXej?=
 =?us-ascii?Q?2/DAp1XrvbL7fXoXB2KAla6rnA2EMVf22tbtnr4w1PvuIMHpkKBxv5SoN9lu?=
 =?us-ascii?Q?p8TCy7ntB7PR7Tln7M1BOER2sMbiv4uHhtAUXkl1ng74lv57kEjKOdv0vF7U?=
 =?us-ascii?Q?zBMqDT9O2agAzLVxa4KjUBjqSbjetxy0o+889LUX94/TA57KS2W6Ac6bs5RE?=
 =?us-ascii?Q?PkgYPZ1qqoRkWJJgc3OkYrkjUDnH+5ChQeQvQ+Mg5/av6pA5eNezmqx8Jdbk?=
 =?us-ascii?Q?ToQn009Hkke4qUkQZyz1D2SY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da09ca07-8a19-461b-c08f-08d8d912614a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:24.1138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzhW+MBy9RnSf8rR0LyuhTWlbuhIKUfUmXdZ9Kw4BbTkTS0Jew3QdpVBmlrhAwURgbipJL4p3iW3+g3tZY+fzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Temporarily add smu_pptable module parameter for aldebaran.This is used
to force soft PPTable use overriding any VBIOS PPTable.

Signed-off-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0b3913d2f568..361e84369b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -178,6 +178,7 @@ extern int amdgpu_compute_multipipe;
 extern int amdgpu_gpu_recovery;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
+extern int amdgpu_smu_pptable_id;
 extern uint amdgpu_dc_feature_mask;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dm_abm_level;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 652f3c6ed79f..1d7839dbbc33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -144,6 +144,7 @@ int amdgpu_compute_multipipe = -1;
 int amdgpu_gpu_recovery = -1; /* auto */
 int amdgpu_emu_mode;
 uint amdgpu_smu_memory_pool_size;
+int amdgpu_smu_pptable_id = -1;
 /*
  * FBC (bit 0) disabled by default
  * MULTI_MON_PP_MCLK_SWITCH (bit 1) enabled by default
@@ -810,6 +811,15 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
 module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 
+/**
+ * DOC: smu_pptable_id (int)
+ * Used to override pptable id. id = 0 use VBIOS pptable.
+ * id > 0 use the soft pptable with specicfied id.
+ */
+MODULE_PARM_DESC(smu_pptable_id,
+	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
+module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
