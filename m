Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4834BC982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB51310E48F;
	Mon, 21 Sep 2026 07:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r9HgXG/6";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED7B10E48F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn5ZFBcylC7TCemp5ILRH7XiiY29pYpN63yQC3Q0JXVN259wFl7cMc5PUxVaTix16EJ8HNbqYBdQUBd2hARigVczDLvjc259qf2kafLvHWDZZRzhZIedDQSNlgi5VuLY1ptsOdGLZ409HGd2AzAr1DTn0asRX7UT7YalRvb+fT8AAHBmXF5kru/M91Qiybw4yvAumln930Hi0DuyjbtRpgUvYABG4LDMvtzaXPCLYJNBv+g8CrrlRJr30P1rAuq0yDv8d9bi9U76a2GNoQx5e3BTTs8fTGQphWbt90kyhrtLY0qDbRungnyHrWFflAJ86BXmT/3HXghve6U49NGihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFf7lM9OX+536PfkGKbz3klDRdUAfpRc6UEkwu5eVwA=;
 b=obdBMpjkq4F+HT0Ob5kjfoZ/TDZS5JjFsZt4bV1Y4NZnbiKZPGWeIgLSGPJUMAfkZPJOk/hIUW5Tk/LLU97dJFfP87C3FnUz+3roETgxMe4w9YAhytZoi3XejV4m3BoPW1przjNim+YAb0Syy8N8TP46ALrbajev8uV2GfNLqqi9Ri2S8bQSC0STS30ylr0zTfNs98zxILektmcjzD6IJmiDWc1k4gpTUPfuB7El26HJA7hlq2eN8amvYXd4VudOti9Wug4uZb+hQy/GyaddLvmvbHjBAo4lubZv+yb2DYcdW29KKHNexNak2jBxav9TEO9ffNgJUEr3G6AyKzS7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFf7lM9OX+536PfkGKbz3klDRdUAfpRc6UEkwu5eVwA=;
 b=r9HgXG/6ctQ0GML4fEkJ6h2fjeQ3l8LwyAIA0L7rtbKT9EmMLdkmirpflda6HbxJ82natJHkeaWGyKh2U+0+rIAwCgee7JhPYwJSNxJ3pnjwvg6vTN5wJMbGBSA1eClYdqGlka/dvCvH91+8lxJUaQFLMEf/IZdC6aXgPC2eJuI=
Received: from BN9PR03CA0149.namprd03.prod.outlook.com (2603:10b6:408:fe::34)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 07:53:48 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::12) by BN9PR03CA0149.outlook.office365.com
 (2603:10b6:408:fe::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:47 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:45 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 09/21] drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
Date: Mon, 21 Sep 2026 15:51:16 +0800
Message-ID: <20260921075326.2409021-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: a9140698-72ab-442c-d117-08df17b57807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kDU9j31tMa1mVVhS/qB1eNmBbEbJFSM+Uk381t3n1aGDvbCz1j4Y+rCi0kNj5Uz4pVOkn2EQKZMCyUpifn8/W8wNFatwc4RkK1TKhCnxzpQ0iv4XOM/gLBxmwkn1hlYfv08J92qvXM/tLi3Mn3D8ZBwLIlDHXgnQaBhsIAbX52GuMUX1LNaOGJttx5Vc26C5dlg8GmNXdr3VZp+rWYNgj6Bz9csTIER0LgzTc2Js0K3XwBEdFizK9wUYdg2NSoB4ZzqhgM4Ed76dxqWM9ZRvCr070LnkWhXUez9OrPqoSMa452/qrvVnUclgnxVlMNZiAPT/CjuYNM/sIfaZerRgC1QYeDlG5CbmqdzteRw05ZLI8yj2MK4HR0X3eIH4MfRPHzSObVa4nWFR5IK1PRzHPTw0YSH/8Ft8LYPjnbxiWHrWAC3T9qtYfovGKJ6G8dc4wZ6f2VRarHNV5ba/ybDcIoxNystDFcZ65GFXA+LQFJOcimd2OcU1/GRgUoCgBnvQ8CPXYBcKzvbPnHgi4Mtv2ghwg1JAvJlT1Yt4HRr2prAHDNnGwsEmYAAYEUQlUeM2pvJ5lccNl+d/vwHX50FwpzyQCVYOiTuTB/4yQmfd9LiO2dwg9Y6r+++z6q0VH95e2/avL6UoaDYgKtSskfJjWNgJ5nwKnMX5kR9L1ahaNXjSB59FMEsRL9HvdDeUr3IOnl8Ee8osWtKcfaYmphWjHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z17cctZVcCMfzkq+/wYudVl/XenUDjp+MRnDQoG+d1tw2so87oWk+09quSG3BDprmcLTIc+QOepB44stTq68hqCnG7obwUr2Jmptq6uMeO3HorRhb7Ta4XIGRel+00+rQWRGHVMdyaSlbu7F7svOCtI3ySdqn5Ax6xxOWY6GekO8vEk2+IzgFZFudY2N6IbfBb3SkUfSySQxxKX7bthm1IZiNfY1kSRmYl9oD+QcTWfw39X7tt1WIb0yDt/Q4mZbTiy+Rm8pNfWz3OnDn0biqVNu/wWoZSE19i8EVSDxVZNJ+u3HNPym340b8QObfVJb/+0Qn4MqS7WiVh7x3/9+8DDK8YklG5CZriA8JQLA2XtPcNXS+ju82/DyZHZb1zg8u3ZKS174AknhtqwBhtVDmi+2DRpdesxBQc9s+SvKdSxG9biXC1UN5BBtD3icZ+FL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:47.9778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9140698-72ab-442c-d117-08df17b57807
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set KMD_QUEUE in the GFX MQD and kernel ring control registers so CP
preserves kernel IB VMIDs instead of replacing them with the queue VMID.
Use prop->kernel_queue to distinguish kernel and user MQDs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 96aacaf2fc27..c559b355eb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2776,6 +2776,7 @@ static int gfx_v12_0_cp_gfx_resume(struct amdgpu_device *adev)
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, KMD_QUEUE, 1);
 	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
 
 	/* Initialize the ring buffer's write pointers */
@@ -3068,6 +3069,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, KMD_QUEUE, prop->kernel_queue);
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
 #endif
-- 
2.49.0

