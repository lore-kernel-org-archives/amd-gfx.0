Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AC606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kgzFwgGU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F6510F8B3;
	Wed, 11 Nov 2026 01:41:11 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012023.outbound.protection.outlook.com
 [40.107.200.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB85D10F8B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3+lAt9IbcfNztCBrwfml7M+eXqHf0N1LVNbwP+lTj9HRvIFBusq/pZx6KlNdUsuT97X4IDgimWwb53iMknw/9xe91hG3QP7EvLLqbVawriIqrnSD/Zg/ih0KEac2VAcPTVx+gXonu9kw+Wc9NSoq1eRQgJWY+kRjOt6M6VCKBO9Y9P+AsFAsDkNdjCiCXFkK4tXw9IegAaHfWE/2akrN/P8qyAQH9Yp+rjG5EBQE8opK/bUvrR5Rf2r1WzziqVCm0Ve8Qz0Y6RTfKCZgzi0k6GVAvewCHN+cBsMAbMaeu2+2YehTba8PX53V+bw+e5lE/Nyyq9c7CdGfW/wwaPywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4MjLBWQOzPc9LRgPzJYCZOGS8ZoRTdOAa3fzSMma/c=;
 b=zRRVGpUcIfS5Pq9DWGEZCPQvYk0eWX10MkvDIAJ67hET9hQQau4MOG2oHBImsj0OnpSgv5/riIBISk6QA9aslNmf2X+HAOcrnE8Ho13eOfmegg2zDVrW5ykDIPEd66ttK+Yrs+ceUsuuZluXKnwZhXpKfsV1N8wkv5+A4xzixVW109nOdep3qsMMiZxKjnGYGAJatXdc6aJ4pE6b4mF0lZYBLOEaKpJZ/zzuIHKq4gLaswT7d0pmnyicg2w3fCiLZK9yScb/AT5+6sYq2WBbCeLpXeWLsfyU+a5EIeJhLXzqbRDEnMUoQaD8WrjkD4VU89Qg2gGzMbeqzAzS810DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4MjLBWQOzPc9LRgPzJYCZOGS8ZoRTdOAa3fzSMma/c=;
 b=kgzFwgGUq9cOy839MCAL0k/OrUfa0z9o1nkdR/5La8ex4JjjVGQZGBmN5KbBmOiHjj+3qKwBqctv39nKxFI0qMLaN9LRQ9kI8K5SettjrB1k6Kz93iaWIdi5ASIxMazjmnCNuIr5W9g4EKHsPocbdY6LMRkUtV0+b1gd1CS9Xfg=
Received: from BN9PR03CA0469.namprd03.prod.outlook.com (2603:10b6:408:139::24)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 01:41:00 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::52) by BN9PR03CA0469.outlook.office365.com
 (2603:10b6:408:139::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:57 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:54 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>
Subject: [PATCH 09/74] drm/amd/display: Extend the IOMMU mismatch workaround
 to DCN42B
Date: Wed, 11 Nov 2026 09:28:15 +0800
Message-ID: <20261111014100.3596072-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: ddea42b4-088c-4f0b-558d-08df3f94d694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: tCvV3VBGZFO+3H9vzpWO1IBswn5SBq9fAiVi56IdtRHi1OLfvYK91b8IrOZh5MivjqaidhDfMl2w5jCrVudVQ59PkjttEIP7oxYuXaXjYoRqREEYL/Ph7c67vUxz2k9Xi7oKbgfYi7/g1c4+4G3ZCcLg8x+4/UNcdgB8D1q8iiHSXLjg3OfS5j0tlttp3V01E6IJRprFSWrZWgn2qBgSXwQl0LwdIowSYsL/7I6090VAE1xjpkz5VeRmLXxMRbd7m+GMvl/h9hovavEJPbrRXVD2o9PckToibwLcf7JkKwBIy/aqt5OYHxtDEfxfhReWwZLvwWbCBfjWoEEcND3HTjLXlb3JZ+eWn7Ako9FqWj9jkC6u3MoZSNwRpaNpgWvoPTz6sPBdFMiQchOGsxvDBDt2FPPcJdf5I8XoFCFNGS0IoplOGFWQ0TjdjzgH0yqXHWG2bmnVyhDZ0Ie+CrM0iYAt+cVVopDsc+EmwPKlJh0YoxGZlgzTPu+f7StZJAY0pktsZrZq+utlUYGip8mdel6A5XGPm8G45TL3ab0DO7FgsQFTv8++2Kg02ODzyhu/yCrSJOJVcrt+AFhwfzbLas8DlaQnpbGjGj0WfffU2psFkW0Yn84HQlvmQYmXOAZIRKp2GYwMzgiIs2JZ0MEfmGmK2Rbb8plEjcayRvKuVCFoHmE1zQc9ViKDtjh6y8Me99sh3BRY8UjpNYSvQ92d9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IO5A3JPKRXkAq5plKvrkRi+xiXuJe8rZ2Ky1uFmooEVfRGzG2CgCMmH9kwfgG7gA/L8mwmOPp/GQXty5fyZcN6MZr12mDkpCs3NqVltx/f/vugwQT4bLK+zRmHT4uYC5FRqG0pa1ASZy7aqKHbt6XDwfyVLyvmuah4ROdTZVkrs8XvqcLdKMi/vLk5kFyPwTADBEiJ6ZlI9TTWjl+/NS3OJweasHsyAR4K0jl9UMiqvOJ22pMVaULrGOiMCeSVKNjMseYhq78rC+fviclR/A4EtD1SV03/QaljIUDYRN5Uv3gLadl8mxEtkp0tGJDnoelziEccdqQP3ReiL/G2cd15sDkzO++eJFfTwtgNGyfSXvh/QtK0rgGv7r58Uzcr9TTFL9J5xFx2/zakTRG/OQwcL4L5wAjGZLI4icAGJNB0CP9TGjO2eeGWCMVvJBC8CI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:59.7221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddea42b4-088c-4f0b-558d-08df3f94d694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Charlene Liu <Charlene.Liu@amd.com>

Set iommu_mismatch_temp_wka to 0x7 in the DCN42B debug defaults.

Cc: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index cff4607f3658..784cce09b89b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -875,6 +875,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_deep_sleep_dcfclk_khz = 8000,
 	.replay_skip_crtc_disabled = true,
 	.psr_skip_crtc_disable = true,
+	.iommu_mismatch_temp_wka = 0x7,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

