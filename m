Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E7606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E2qVLsEB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169B810E0F5;
	Thu, 29 Oct 2026 07:23:28 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0633E10E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 07:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldIpddX5/2SOBLvYXe3Rok9IfL2dmbjHyDloCxGJZKt9ShjFQVIo1Z42y5RSTEkS4nSsz4wv0nLU3IGHI0VBmjwfgyspJwwlN5rhGU3ZgiDc6xhCEZhIkebj7+DNChHAnEhyIA+nLIYvbKC2iUIKjie8CqkHGghCxZS+fqdWjkEvrgG84trycm/qckKAfj4A8eyiy2eI5fYbxt72rWc9SKssx/3H1QoNGkrWT2hAJ7d+qOx8BB4WbbC2b2Vq/0K+1vYFcx7HQOzSXBXuh9GQBECRXO/owxE1W4n/qIXv4M5QJI3V5mkLOTiV70ukjka8BBMZjllqiYhtvUyVOtcdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DaohGEXyyIbjTia8235dL0489lf2zje9gAD13vpDSU=;
 b=LHaE3jZQxfbELHIhgVahHDZgF1sE6x5uWsXxaD8o7wO2zTZMfGFyePF/ofyIO8Gd0cqHvdcejje7eXHHEhgTiJzhgLIEk94AvVii+/7bExXkBnnEPDTftUu3LiMH6zQe8UOMr6oAPa7kR0Of/zJ1/62463XcmNeECedsPgOnZRnCTqtsByRArxqEYqGsO5CNu7su4gw0Hqh5Ut2gWJlGjDb5e70Kv6fnRjAxmqPb/53L1umuaGC40eu5EgYdMKPXvwuda5VQNQNL+Az13QpGdAjgZ2DT3tRf6/wfIDp9JHbCynJAQw2W13ZsmD6sJForw4Pfanr61GaKS91zS83+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DaohGEXyyIbjTia8235dL0489lf2zje9gAD13vpDSU=;
 b=E2qVLsEBC8t4kw7UMWqN5ZNkey1kNFLHoKNJcfEEibYeVee65Tta/hNBbavooxvKyLKhhlzv831lClQKmcWElh0jXn0xyMzb84it8eakzOCvTHiy488f/K3YmbA1+KVIcW4RFqgxrz8v2XGl2TLT94VIHFUSTRI8d3vYwai5/LM=
Received: from PH7P220CA0125.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::18)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 29 Oct
 2026 07:23:17 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::8) by PH7P220CA0125.outlook.office365.com
 (2603:10b6:510:327::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 07:23:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 07:23:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 02:23:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add missing firmware declarations
Date: Thu, 29 Oct 2026 12:52:50 +0530
Message-ID: <20261029072250.362965-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af19b57-2d6c-49e5-9c25-08df358d804e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|261021121427099003|18002099003|10067099003|11063799006|261009223027099003|261022075727099003|56012099006;
X-Microsoft-Antispam-Message-Info: TJ5st2JakEGbrj3LbXBA3pPsZPs3sWq3mXXG4mUI70yALVlk8LLcoij1EljZrPaPVmkG/t4AOyzRr6LaVfFyNdFfs2/4RCSaGhVD5tnxl17dLwJmTFae4jg9Py/9uLJXRCDqUPAkSJFNVEZH4z07gsAhLJ3dkeGNBAgnJlB0UiKR1jHYs8M/BE8GZ7RzdePH39DE9mK2nSOorInllCOYvKNNlw+ZxQqmUaLK+rvqyzTWlan6wxu4QkXBeO28DlO8ZvhA5ZSTwHuoQBKcgD3PmwIF9hk1fRBwf4dOF5XDSfI/BbglcfcAPC+x7E1wnDPe38MtrnzS5QhBFat+Jakp5njhcVdSQUYQZZzbzJN9ERnZPeqCiCDqZc2KRF+/t/3rnvuZVPZ0+IcMviv39q3vpQc2rTFx74Y/gFB+g237SqsPXjsMt7K4MZx+bNHRYMtmvTFMw8tj5N46R4HpJHqyowOjIscLEytHxtJvgfIZjn79MDNZ+5Rb6UC+KZZ0p7Vl6Cr5diR6Cu3e6OSyefHMUEbSceoRnY7YoRKgjTnv6hjT18B+0cBbQVgwCoY432X4ZnziiJyWmD1y5A6gnajZMoBlEa5BvAMCl3ZserCnhdiN+V63vmC4VfMSYZHWU8njQfAnNpOFWLG65VF7TqfKQ8MWKvTy+ckdsFJ0XtE3fGmlVr0a/iNrMBK8vvGSNtjEZRjhAePiCU8W+EcS0ToJ0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(261021121427099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(261022075727099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jAQ6Mun+vbBLcSsB6+BUUIDwca3R5mmjwT2jbwMhau2XnyvghsGfFdxQP6Z+bbUp08n8rIYu27KNZd1dJ5WeWx3B7EQsjJfsDvmIZvQCB5OyivpQB6ewp8r5f1Hh6zDVFBNJauI2X45GzuQV5QOYGObwg8xxUtxBRBYQQ6KQhKKWqFPymcv9mvvYwnWekuU+RHxuNCsIs2/1L2XAWHqixWyqc7xiJDSsRt+ufu2QLRySog/RxJdUuJAIbkWgoj4yurr+T62bdJu/BJT0jhEgWv5Jtsqi9os2IT6Onugp9Jp7jmNR+yzVdsRbuHRwF4EZwJaRXnmj3A58xz515e20L6CJT1c5UvvZj8Z57Rv7DGVpgvurIOySuI1ls9nyS348SKMSzua6CB91sOv00HDQZ4ySsmyV47rNDwNRpVxvvO69cV3VEYxaQD5bUsn2tSJh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:23:16.8410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af19b57-2d6c-49e5-9c25-08df358d804e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
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

Add missing MODULE_FIRMWARE declarations for gc_9_5_0_sjt_mec.bin,
psp_13_0_6_cap.bin and psp_13_0_10_cap.bin. It is required for including
them in initramfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d66c7901783e..da031caa4e9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -49,6 +49,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_5_0_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_sjt_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_5_0_sjt_mec.bin");
 
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index f9a3fbfc0634..87057f511845 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -49,10 +49,12 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_10_cap.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_6_cap.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_12_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_12_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_sos.bin");
-- 
2.49.0

