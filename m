Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE7C43460
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7266113D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7266113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217976E97D;
	Wed, 14 Apr 2021 23:35:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0D26E97C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 23:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtJbMzuufChiMtUD1/PqH8IMGDxT0NSaotsxW8ayV6FBya6Nlo05P0e8MhgeJ4Nfj9sqcak0BEw54xvlYKOVLM0gRZrOkgcTwiDSaZBcPMYYpHMGORUQuiC0KY98nsgu/GWfD6HSnNZxXD6uRhRKh8C84cs5D34UuDYC2Xhgvcq0fv6ud2/ANJHRDTMOPyaYc/t4xNCnPX6wgcO7J1e9IIrE+/jtm/pz4sd3Y8YPLUGlqIkkOx8BdT1ml/kaRvKIgpDDNJX5SIQDF8qPTofKptJTLGrQu4+7p3aMuh5icKBKv7Oih2eIanbU5bf+uimGw0t5v+aDv5ZtyqG30sEreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRV5rWpRYXgJBvbW2araBoq8yy11pqRSyCd2dE7GjSs=;
 b=OFVBrG6WAuzOhNtMgM4WJ0KcrppphUQ3zN6nnjgKZpXYdYwRu/uNifAgO5PduLnSB9VL5/VpB9i9jS9MJw9Xt8UTkr+oR0TT7su8AxFTTeGn4xa5Pn5UjW6V4iRnrID9e5riy+458hQMAHFfSYuXEXoYUKtPDdGdFtozOBJOS/ASlL5lfN8oITYKTa9TqWMgVPL2cHY3RaGYJt4EYDtPXIgjDt4CiCR1t8M6hx/hUASvaOq6NfgxoB0t4q3SUkrKgJUWkxteAkt8+9HBzZMVzCd6H7MNyYVk2nl/80lHWifa8qVDvp9hpHu+brteOc931GsMs5O3THkUVs6BzILkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRV5rWpRYXgJBvbW2araBoq8yy11pqRSyCd2dE7GjSs=;
 b=vhIJVXHNhOZqhv5OIGj+l/CnARJYYMwmPnsr2RDaBamh26Wya7y01O+hJmO4Y8vnI9R6zhRrUGk+aGXSir+/pcuym5WQtC5w3BobyQsZl8cszGC428rPxJVr4F/WXUjxWDp5ecP3/0xA9+tZjuQJjL8domM42DhX6JM+iqdypEE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 23:35:45 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.037; Wed, 14 Apr 2021
 23:35:44 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3
Date: Wed, 14 Apr 2021 19:35:32 -0400
Message-Id: <20210414233533.24012-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 23:35:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7ec74c1-0f6c-44b3-b614-08d8ff9e0632
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42657B9B112DD782D60B05EDFB4E9@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 883y7Pj6TxxnZ3jKzgzemySDXpBo9FLXGvxP/H3LxWUM2t12jTxA1SBGLDecPZC1B5IEOiYQMvH64inZ4VsCjA0RFD4EH72vQE8n6ueqJG3AGwpK+ICzLb5HdciRC5/6rsQXuDy1yIzvSm23W28+PUfWcl77K4EtUyR6NfgTpXnDw/T8Mqdz7boa7Cuq2WLAYBEsC0Fm3te3rFgcrxTza2bOG0CkoaKFSZE4OsGhNUwnhVf9Uu8rgZIOBVE4/+7aDUFUg6AUdg4KdUTcTnQZD5za+8Z0HvZrJHVtVRsl2MJuAdVw2oFvawEAWQY8qAveU3bxcnBmhMNHre4PiRSinqahi/XlORQQAkFBg0boUfvDrHq1yzOCl0brvLpxoRIWll8VjIWZbPSOwWE5KhIrLsx0omr22TKMmvXAkGIb4huascrdzA45YIDI7A2Nnndfs2ra2F6P8hVIDV3gJzAXpyftJQPxmCEZ6Nexlh3naelCKVPZ4jldDw48JtTuaEq/cMFRiQzsW/MD7wkL9lhJziTbJiU/YbgZY45Bkz3Z+FNNqJjo8rBzXVGdgKFOfaR/JIUBcGnQOrPWpIVGbKhd06MPtYopPs4Fya9szwe3p+e44x5qkK+aTh8PQv7QaDwzSbd6qdBx7SL6mAkzoZK1D1Y8n5xWOtYsHmtTTR5h5b+eszgxKUDToHFBNmpdtUdV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(66476007)(66946007)(38100700002)(66556008)(38350700002)(8936002)(186003)(6666004)(44832011)(16526019)(26005)(36756003)(8676002)(1076003)(2906002)(956004)(6512007)(2616005)(69590400012)(6486002)(6506007)(4326008)(6916009)(83380400001)(478600001)(316002)(52116002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9OiigIKx3ensGK6WGpzXOL+cf6TBoVVqok53dH2hsdXMXEciGv492/ebSuIy?=
 =?us-ascii?Q?gdjFnvUXl1+Coc5jBr+1qH389WYx+Iq4+TMl/u4eEkq1VpVfYoQFhCImlPVI?=
 =?us-ascii?Q?MAN2WHfSXVlRkMls7NQs6aAOUfe/moO/x7UArU/JX1EPzPUUEdvDEpkFfznA?=
 =?us-ascii?Q?dNefgVTXPvbupZhQLADGdSJeIMW3ScGMrF5FJVaMp34Ks3jIPYWNu9eO/dXB?=
 =?us-ascii?Q?QnmXsviejo3RN9ZBiF3uWnyZFYrDacXqZuw1G6c0ss9pXKn1gWdoK0ptArrj?=
 =?us-ascii?Q?HtP8wcP1pHgLLFd0a1CEBQ2qXBpSSUbKp8IugtbODnnxI9rmbe3Mdx0tJUq3?=
 =?us-ascii?Q?YQMgFrFRDm2sVyoRevhIkhBY5n2rI6z+wGKG9yLyrZtC4PJ5YvX98ISYL4q7?=
 =?us-ascii?Q?Blvq7WIckprt8hUVlJWLyTA/C83DuJDvr9Of7vJayYGXXNhr50BGKKQqtMh3?=
 =?us-ascii?Q?zyEiAmTQZTdNOiYUyKvcm0wNwZ1T+Tn1GHClP59qMTdruH0h/aI/5pDcd7X0?=
 =?us-ascii?Q?J76pB2xux/y4+xUy1+a80jpuMuoL7/LEB+QQecRzF3gLkQzBa5o7+JjA/Ey8?=
 =?us-ascii?Q?IHGohWbrCFvAPUmmkMCt91vEPjQRWxn8BZvjts1CN7cXuStYLkDP7TFPhAo6?=
 =?us-ascii?Q?kik+ml56fRlnmmIGzPhSjP6xY2Q7AW04erFTN9wVjxqF2WaJvtX5OtiepFUv?=
 =?us-ascii?Q?B+cBs520nO2XeUfaKWaW3IBCDQpkgejYweUiOwr7Qu0K4Pr6dCd77UqX0XO1?=
 =?us-ascii?Q?+38o33QNr325pMktx6v8T+QgRCjo3u2OK/LCD/9M38wpqOVWSHVE92TMJbwm?=
 =?us-ascii?Q?kfpILtQTIyizfwMNubAN2E0qmeArEctLsCktumd2xyHkijvKBs9ctT7TSvhu?=
 =?us-ascii?Q?ahm3b+1wfZLP2JgofM44eid4PGMUbnZ8/l5T4xcs3wF5zD5uW8GHRsiMVzn7?=
 =?us-ascii?Q?UDmahc3fwaFKk/TUClvgll92WTc3ahN8DqV7te5OHDyyQmHid4C6gQDynYIy?=
 =?us-ascii?Q?hTsspGdpOlc2GSmZ6Q2wt7i2dxjNTtxgCEh6FAqaqejG1eb6gjG0kMQlrNFp?=
 =?us-ascii?Q?gjQiT9namraPUKbc4XAtmmolRKA7OvhXhyRBAU4KgnzBoe3qTn/IFaCLmzwz?=
 =?us-ascii?Q?us4NsvYUBuSntYVv0Z8Xx9kSMI4keNgZRTm1Z+c6B3vkWLqjY8R4mP4h8u3A?=
 =?us-ascii?Q?SU1FxD845OymGw+jancZ+6HqwMAAmLJ01d/5Gpgikc7jl43Qh2It97Jq0pCq?=
 =?us-ascii?Q?A+ZyOPbltY8D+V57+j8I7feVLWXYL4KMc8maHP7xDp3BHsMnUpRdtcaPrTa/?=
 =?us-ascii?Q?2rDTYU3b+fNXplPKDa01qh2Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ec74c1-0f6c-44b3-b614-08d8ff9e0632
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 23:35:44.7966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4t8GD4GScCMBDruvbjgth4n8TJUgWwbV//pouVj+2NBJV6ZbYUej7b0o0dq3Vi7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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
Cc: markyacoub@chromium.org, Rodrigo.Siqueira@amd.com, daniel.wheeler@amd.com,
 bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Current list only includes modifiers where DCC_MAX_COMPRESSED_BLOCK
is set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B
is also supported and used by userspace.

[How]
Add AMD_FMT_MOD_DCC_BLOCK_64B to modifiers with DCC supported.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e29cb2e956db..c3cbc3d298e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4535,6 +4535,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
 	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
 	int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
 
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
 		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
 		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
@@ -4546,6 +4557,18 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
 		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
 		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
 
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
 		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
 		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
