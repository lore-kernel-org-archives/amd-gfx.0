Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C4C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B8C10EA6C;
	Mon, 31 Aug 2026 18:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5khPlOrV";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E768510EA21
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqGpPAYcLTDxA60rxps07RIBrAQoPSmqowLpPjgqHsXBUJpzoMvgyy2xhDnJrGliPIvH47zOe4G4VjIVgxBOX9bTJ4wZBJEN21q9di6qzZOA8es1jPS+2Dk1CjdHlMRn8kcFf1HuFR004YsW7N2HHTzk1JpNApVq/t2zaOkmK/mXBy/IqPQC2HmRZ3r3Zd9hiTkHJoQfpYR4JU6Mac74kOrAvocV3iEE9T0ib7DCSrEb8i4yVc3KCJGLmS+N9N2JOCTa4ONO53WMhxN1s407Si/eUCnQ7ayhwdmSIImfRRLn4yzM1IPDj9CA1hDVYiMOx4Xzp+nUFCCVyKTjTNCToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLJ7Cfp8jComH3hH5KskiI3en99TSUe9sruFGmzE49k=;
 b=UEdfKh/3U9OaIUsa39J/79UYGrT0MqJGIMTxb01HvPXWp2Byl2ci6Udeba9k67TP0g1xxwI25PifDncruG+Oq284hfrcfkYuBuR+PLZfLAQ69OI0XDQ60tnn7oMQE64bIQQsIt6/jshptU592WamyICGfxaZlCLnC69Sl8WHRTooVgu+4H6cNiHF1C1Ku2pcjMmBq5AwsaI15rg0IHxR4RwUOgPEmFgW5Ravs/k5KeivDpIV6Jyi+Ty6LSz9REfYiPAqhc3rETihNBac6BiGd/tIM8xBunlAZzAI4wxP3x4j86WjKVYozYuzaHWS/HfE+poWMyDhrKTiDRPyoryP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLJ7Cfp8jComH3hH5KskiI3en99TSUe9sruFGmzE49k=;
 b=5khPlOrVG9BC/d20oz7qKIyrtqW91WNJ8mzgoedVxI2mOvkg1UehSCG/yLjxyPbQYsQ3x4WfXW0SVnQDPmAlWmRFm6Pee8/TTmHyN/+US+7oaUlyDcq5VazGo6Sb8BwiQFsWfHzybyQlsc73GONQIRs4CpXwi021I6gpJ43mhHU=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 18:28:58 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::a3) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 65/95] drm/amdgpu: initialize UALink importer node list head
Date: Mon, 31 Aug 2026 14:27:24 -0400
Message-ID: <20260831182754.1089811-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a7f9ce-3ac9-4f27-795d-08df078db8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ssOd0Ekme2S8ZQniZtfJNUPFugpBR62tAgipRF3j1MU1VdS8J3jfy65TTfuOdAkDIsHqGTqkbutt/iqfkmL6xoRiMqtsp+b/6JBShC5D+GtG7nb2QYtMMA50XMSBCY+pIFvxW2o5Cyirz0L6u3tpWXUOA67TgQo0qX6S5SeQSj6yaFCFB89h9MwTKJ4E1jW753XFMTwYhRD7lFGzS5MkZni2ccJvUn6jaXWzM/oA4Ev3Qljz/8wvDRRUhLRgB3pKmUDvDlk8UaJbdv8wMYxSIlxLye9bb26m9ocAO4PrYf0bQtv+n4yQ2qSMTQodDkhei6KAiWRKPnjjqP0i379DmgYIvHOQ3Rf3zDjlGgPeVKTw763Mjd6sZ1xt4RFNGTsGHHRdgfXes/G+TdyzHYrmG2xQvUUksZH1jT9E0vM9sL7Bu+yJ+0+e8MtACDBkPxQX3SBPGoID5NRIr5ndzeyr3fORIwc/WVbR9aKR68GYyUgS9mtTjUMA1eo5/5RAbTZyyQ0zT9Iku5nC7i22B6mfbaMbxqbMwCE8LXHQ194OATOX4wwmTWO+b9F/EvUl7UFlER2oGBLmtlrsgmNiclQbDgvvGI896uwLGYKzXi2hp3kRxJqPLr8kgJCyquuxClDpCmhXc+ZPlYRmc8F/Jht74QJBYsWzkfvV14zOXRVJDDu/cJvAuWJj1JwhO8UlZwEux8+Y+XjfHOu8E1FDb93muQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JvGxm8pDfC7/UyBG24S+XJiPUaVDm0HD5RNk5zx3hbB+YSAw4PdY4CKsw7VCl3B7YZHxVCy3iM/n8IzhkbNqs+GUQnu9vnYRyLOczREWIgZCu8UnUpZXzLFC/vRDgQpJiDefeFc/6KSODgkrDzzTScWdZFbNemYUHX9QcwsCvvzNFf3TNH3FVFVaupLNVIhyUg8hUWjutKf9ARGdPo45Tjk4FCjKJki85RIrDyAGdksxZ16NNr3Ubxd43C94r2VtrUZcseRuy8RrSJBuekeJNVsrfBuoct+iI8lg2VJpu4O6Ea0+EoNfuGtR7LGEtvc50+pKFDkD3i30iAs99aPLndcFczEtd9FsTVUjnADuaageYh3BJYNEhGB4avMNlVeGoU7nO/535kvO+dCu+Z4NsILlehhx4zO4fB8SKpUIEC/rw6yHpH2rQMdb4z1jQhQg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:58.4950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a7f9ce-3ac9-4f27-795d-08df078db8fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

From: Mukul Joshi <mukul.joshi@amd.com>

Initialize the list head at node creation so list_del_init() is safe
on a node that has not yet been added to imp_handles_list.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ea89187750126..451c3437f5bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3263,6 +3263,7 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 		imp_xa_node->node_state = AMDGPU_UALINK_NODE_NOT_READY;
 		imp_xa_node->handle = handle;
 		init_completion(&imp_xa_node->npa_done);
+		INIT_LIST_HEAD(&imp_xa_node->list);
 		kref_init(&imp_xa_node->refcount);
 
 		/* Take an extra reference to store in the Xarray. The error
-- 
2.55.0

