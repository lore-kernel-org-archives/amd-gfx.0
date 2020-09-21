Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DADFC43466
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 15:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999F722574
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 15:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ofA2ggCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999F722574
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585D06E503;
	Mon, 21 Sep 2020 15:55:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816A789ED6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 15:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaLc0JHimkyHz4x8GjnjuEvm/l79LUwC5b7b+Bqd2dE6SrZ1tQMayvwLrhcgwYbvV/Hhc4qoLrtAxcJwb32Ju2P7eltvJzg/79Vaqx0olGT6SUK0r6BmcL9cPbxEAwh1AVWqscgI/AjrIaqTRkT6ekaBj508liG59xN3yUxOoZ8g3PfC/OBD6w9AWpqpZ0JXEzqsu3ZbQjllUheMeX5Y+3Di9KbHDH6me/1ak/Ew3MSw4DWLcJXzHmLZFj+6L83cVgDMTjHL5q+Bz+ywvejCqWDpXyahayAddNVC0LAcYrYkjnULZFX0WmrvSrHI9nEw5ZKnVnwD9/Jm/LtRLrpndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVmJ1t35VBWaDCryaZmWULyrIsaThrbawKXmV7Bz/FM=;
 b=e2RyZUyuvi7/O7gG/w0Qe3i/tzmv7HhrcWYDIfHDHHqDJ/0pm+2v84A/IMH6XhN5hUomMLMFFkiiPkmkXmsTmuJcfyErPMzQzWUEjVJgSIhYTz1poN8CZuwmjvLU9dYFnY7eYqTIJJN0uKEF+adrgRf3FIMBzJcqYRhjCSTXvT8VHU/2XbyphKeAQylpzwsYJIIRCbFXFbcFFsLmzj44RnGFyZEghd3U6rPOOTXR+sdRyfhjnv4HmfJQCQFiNrQZ+xyX2GqO7tQzOx/r7trGkD0xY7fpnAVtHcuObQJbkjTJV3a9yES1a+vYhDNsS0S+xQfw0aRX7rvpqayEIh+7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVmJ1t35VBWaDCryaZmWULyrIsaThrbawKXmV7Bz/FM=;
 b=ofA2ggClzdWrp0n7zEK4dgwg9rZ8whWYuu5O/ebmZfzpD1FVsGz3Yd4OjOZy/3PG4rm9JhZVDwwjfuxdePTWYNdiB+G9uqeTGZZnZkC/3ouOzYNAdeoa3PRWcLogVTqb8l5B5Kz8jduVdltn6lvfERSQlWL3hXDEdqolnxVDl+k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 15:54:57 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046%7]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 15:54:57 +0000
From: Ryan Taylor <ryan.taylor@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] amdgpu: Add initial kernel documentation for the
 amd_ip_block_type structure
Date: Mon, 21 Sep 2020 08:54:42 -0700
Message-Id: <20200921155442.7189-1-ryan.taylor@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: BYAPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::37) To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Desktop.attlocal.net (2600:1700:9260:7260::17) by
 BYAPR06CA0024.namprd06.prod.outlook.com (2603:10b6:a03:d4::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Mon, 21 Sep 2020 15:54:57 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2600:1700:9260:7260::17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13087248-0317-4442-4413-08d85e46b078
X-MS-TrafficTypeDiagnostic: BY5PR12MB4227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4227DA98E81BA3EED7A31CE4EA3A0@BY5PR12MB4227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avRJ0gkDL4XZbvQl6DXNRKHdagWrBgWdUB/hws7MsycPWrbSJHqGEvlldnh5LvoPPFRHi5Z398jogq7BJgi5AdmXuRDqbKXxdc5K6vtWv4yr4TH3g4p2LAz9HKTau0n+jQvSxylFPPyAAvkbtVN/U02li/dw5xFTlQkHZIus8pFHPDJoMHbVIizNEH6xm+G3B47yyjaM38+0Ch271ewME1o4nz0m9bWAr/utnXy/QagGHGGOkNeBmGrl4JzrP6Lgi4QatfmjsN1hfRmS3fIhERYc6CGQeuSy7ZaoFpJupvO8Ztma2+vFr0Axcq69FRIVyPj8wgQDuDzdvpyxAAPr1wVoPDwvdgFQx9Px18my8pr2ZEfh5zA4HFc3jYp0L/Xj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(316002)(86362001)(52116002)(36756003)(1076003)(6916009)(6506007)(83380400001)(478600001)(5660300002)(2906002)(6512007)(6666004)(66556008)(2616005)(6486002)(8936002)(8676002)(54906003)(66476007)(186003)(66946007)(44832011)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TUiWrtrhmPNpKhr4/b3Pj3+EnwUDo4Qt0wNNo5BnZPgJkNxxAVpCuXYpjLgQMD68vsWovW7Xn/VT6wm+XtgtbB3GQYCy7NF+bZ8Vy6/OFMm4cpxNSw3TqugTadigsMI9VaB866opvWExEFfukEf7LEvDq8B23I6nU/kk4MRzjRLny7RUzwvGQRB/exuekToSklZ/oqlZyPw/0zzM3zcM7jIJ7c7SV6FARFfzuNWCs3k8FCsup1NB00Ibp4Z8mdLM9QSmZaR+rZga1hKmxNKQQQQ8mYdamOi93mhBqQyl6VIze1YSeScjdc29gXttAN81al/e82v6KJ0rExjOcGpJgsuSlTSLs4gN2S0d328ROaiMgI1P2tQq2B4ZcqP0lp0N7QmMJ2nDpO5hiArM1nO3sb+zG0f+6xeehEgEMlp0XJ/1KI8IxzepSWhgE0F0I/jPv7qj3N52XsmXxn/MU2CnUVDUVD9CKsYpogemlDpAT+3F1I7TG25JXbb9X2DROaKtRqSfys4zfjn0Dxcw/25UlIbuW+qzzpBnljDCog1u8M6cS7gkcEmYojO11L44hJNGOhHEbK+vcdz5B0xuotVvl1wjAdjuZcl6p3puI5p5KjOffeF9shoxWP7hxF/jXAQH5zna6WIi0iJ/6l3HegRVHSKUc04bytGKgOxGzFXXlfY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13087248-0317-4442-4413-08d85e46b078
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 15:54:57.6557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk5BBaD7zcvE3v5a9BjborLatJ0MaqIfFfw5MTY1wV4um38aSCnALeEFExS+wxxRwHg/Dhj2JLt07kznvifCBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ryan Taylor <ryan.taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ryan Taylor <Ryan.Taylor@amd.com>

Added IP block section to amdgpu.rst.
Added more documentation to amd_ip_funcs.
Created documentation for amd_ip_block_type.

v2: Provides a more detailed DOC section on IP blocks.
v3: Clarifies the IP block list. Adds info on IP block enumeration.

Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu.rst             |  9 +++
 drivers/gpu/drm/amd/include/amd_shared.h | 87 +++++++++++++++++-------
 2 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 29ca5f5feb35..57047dcb8d19 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -70,6 +70,15 @@ Interrupt Handling
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
    :internal:
 
+IP Blocks
+------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
+   :doc: IP Blocks
+
+.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
+   :identifiers: amd_ip_block_type amd_ip_funcs
+
 AMDGPU XGMI Support
 ===================
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e98c84ef206f..6b8a40051f41 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -47,6 +47,40 @@ enum amd_apu_flags {
 	AMD_APU_IS_RENOIR = 0x00000008UL,
 };
 
+/**
+* DOC: IP Blocks
+*
+* GPUs are composed of IP (intellectual property) blocks. These
+* IP blocks provide various functionalities: display, graphics,
+* video decode, etc. The IP blocks that comprise a particular GPU
+* are listed in the GPU's respective SoC file. amdgpu_device.c
+* acquires the list of IP blocks for the GPU in use on initialization.
+* It can then operate on this list to perform standard driver operations
+* such as: init, fini, suspend, resume, etc.
+* 
+*
+* IP block implementations are named using the following convention:
+* <functionality>_v<version> (E.g.: gfx_v6_0).
+*/
+
+/**
+* enum amd_ip_block_type - Used to classify IP blocks by functionality.
+*
+* @AMD_IP_BLOCK_TYPE_COMMON: GPU Family
+* @AMD_IP_BLOCK_TYPE_GMC: Graphics Memory Controller
+* @AMD_IP_BLOCK_TYPE_IH: Interrupt Handler
+* @AMD_IP_BLOCK_TYPE_SMC: System Management Controller
+* @AMD_IP_BLOCK_TYPE_PSP: Platform Security Processor
+* @AMD_IP_BLOCK_TYPE_DCE: Display and Compositing Engine
+* @AMD_IP_BLOCK_TYPE_GFX: Graphics and Compute Engine
+* @AMD_IP_BLOCK_TYPE_SDMA: System DMA Engine
+* @AMD_IP_BLOCK_TYPE_UVD: Unified Video Decoder
+* @AMD_IP_BLOCK_TYPE_VCE: Video Compression Engine
+* @AMD_IP_BLOCK_TYPE_ACP: Audio Co-Processor
+* @AMD_IP_BLOCK_TYPE_VCN: Video Core/Codec Next
+* @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
+* @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
+*/
 enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_COMMON,
 	AMD_IP_BLOCK_TYPE_GMC,
@@ -165,56 +199,59 @@ enum DC_DEBUG_MASK {
 };
 
 enum amd_dpm_forced_level;
+
 /**
  * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
+ * @name: Name of IP block
+ * @early_init: sets up early driver state (pre sw_init),
+ *              does not configure hw - Optional
+ * @late_init: sets up late driver/hw state (post hw_init) - Optional
+ * @sw_init: sets up driver state, does not configure hw
+ * @sw_fini: tears down driver state, does not configure hw
+ * @hw_init: sets up the hw state
+ * @hw_fini: tears down the hw state
+ * @late_fini: final cleanup
+ * @suspend: handles IP specific hw/sw changes for suspend
+ * @resume: handles IP specific hw/sw changes for resume
+ * @is_idle: returns current IP block idle status
+ * @wait_for_idle: poll for idle
+ * @check_soft_reset: check soft reset the IP block
+ * @pre_soft_reset: pre soft reset the IP block
+ * @soft_reset: soft reset the IP block
+ * @post_soft_reset: post soft reset the IP block
+ * @set_clockgating_state: enable/disable cg for the IP block
+ * @set_powergating_state: enable/disable pg for the IP block
+ * @get_clockgating_state: get current clockgating status
+ * @enable_umd_pstate: enable UMD powerstate
+ *
+ * These hooks provide an interface for controlling the operational state
+ * of IP blocks. After acquiring a list of IP blocks for the GPU in use,
+ * the driver can make chip-wide state changes by walking this list and
+ * making calls to hooks from each IP block. This list is ordered to ensure
+ * that the driver initializes the IP blocks in a safe sequence.
  */
 struct amd_ip_funcs {
-	/** @name: Name of IP block */
 	char *name;
-	/**
-	 * @early_init:
-	 *
-	 * sets up early driver state (pre sw_init),
-	 * does not configure hw - Optional
-	 */
 	int (*early_init)(void *handle);
-	/** @late_init: sets up late driver/hw state (post hw_init) - Optional */
 	int (*late_init)(void *handle);
-	/** @sw_init: sets up driver state, does not configure hw */
 	int (*sw_init)(void *handle);
-	/** @sw_fini: tears down driver state, does not configure hw */
 	int (*sw_fini)(void *handle);
-	/** @hw_init: sets up the hw state */
 	int (*hw_init)(void *handle);
-	/** @hw_fini: tears down the hw state */
 	int (*hw_fini)(void *handle);
-	/** @late_fini: final cleanup */
 	void (*late_fini)(void *handle);
-	/** @suspend: handles IP specific hw/sw changes for suspend */
 	int (*suspend)(void *handle);
-	/** @resume: handles IP specific hw/sw changes for resume */
 	int (*resume)(void *handle);
-	/** @is_idle: returns current IP block idle status */
 	bool (*is_idle)(void *handle);
-	/** @wait_for_idle: poll for idle */
 	int (*wait_for_idle)(void *handle);
-	/** @check_soft_reset: check soft reset the IP block */
 	bool (*check_soft_reset)(void *handle);
-	/** @pre_soft_reset: pre soft reset the IP block */
 	int (*pre_soft_reset)(void *handle);
-	/** @soft_reset: soft reset the IP block */
 	int (*soft_reset)(void *handle);
-	/** @post_soft_reset: post soft reset the IP block */
 	int (*post_soft_reset)(void *handle);
-	/** @set_clockgating_state: enable/disable cg for the IP block */
 	int (*set_clockgating_state)(void *handle,
 				     enum amd_clockgating_state state);
-	/** @set_powergating_state: enable/disable pg for the IP block */
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
-	/** @get_clockgating_state: get current clockgating status */
 	void (*get_clockgating_state)(void *handle, u32 *flags);
-	/** @enable_umd_pstate: enable UMD powerstate */
 	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
 };
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
