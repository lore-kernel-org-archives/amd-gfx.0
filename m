Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E24FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC3F10EAED;
	Tue, 28 Apr 2026 10:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gswaRp6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ECD310EAED
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4bjhCwcocGUI/3vkDhylLb7FlWlNuPDFKLSkiQ1UIK6XFWy4Nr2GVELeWJ62B37MQ8u7Vkxm3sV7YaWTJrf5pQn55QLWhOKqH4XFWanb04avKWeDapWSGI9KBcE0q18cr5JTJ/ftNXALg4dcfxAqtTdAJxBX8MkilglAyRk0iKw4LyEtpDTYBq4E6zux+UcJ/p+NYAjBJv9ETb8msN8E0XD7b7qipdYpwSkT85yBhlfrWSvNB/QZ+l1HXaQGMpmMveHjh53vrmA4zMSkpV2ppLv04sa2CVd/Y/3BpUGyKsyMoHgeg2tGL6P2smJ3wOW3INyPBcLBqDeHfbGw+sw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U45K3DHX8cXQTlPYh6hMdi3lyQqmJSkEBByOy02b7U=;
 b=hhM7sokxKcK5tCq72CwxvRxJmgPO2bDIKC2ocmGxCvhCCobiwaHzqSj9yk/3DXUvi4D0sL1MiYl2+7bAyDkXrrwvrdjc53DEQVj+0LVHuS3HXrdy0Py8H5ckIM8xc8nkC1Au3aq+GktVLOlcjgpd+lAFOy5tQMqCtOl2OEDBG0zjqrxQZ9gtrQGTraYoJJhc7iEPfIq5mNEQL2sdM8q9ywP2uCSVJbRQBy8Ag1NbB7T+i1FgF/xBAeCSgCOpYtDkNRkVlcP+4abDkTXc+7vCBw/RRdB2fGsrwfFteAywMnGzorW5jJ4zxCod3RMf0ZEARARF13GCm1Q1DDE2v4RAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U45K3DHX8cXQTlPYh6hMdi3lyQqmJSkEBByOy02b7U=;
 b=4gswaRp6Kp7wUXsVZms6nDWcJmodrmBak8iAyE1uFUI2vwRNu23f/FPIXImbnK144fkU49WEX/vNR9/I3SyCN++51UAqlXbEbtbxeDxzTNtHnt2yXaUcAv8KwG8OtRS9+pS5aAS+Itk4ALwxJAHpzvZlQEuV8Nn6K13V/eSigRc=
Received: from CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::21)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 10:03:04 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::1f) by CH0P221CA0039.outlook.office365.com
 (2603:10b6:610:11d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 10:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:02:55 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 04/11] drm/amdgpu/sdma6: register SDMA UMQ doorbell pool
Date: Tue, 28 Apr 2026 17:58:45 +0800
Message-ID: <20260428100239.1609179-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b557fe-31c1-42a8-c141-08dea50d5700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UZZ8S3EtRdiDVn8HBA+bm9dwjaocFO6x2PW1Co5xYHrBN4PZROiZMtB4eZ4qkNQKYYotdNrgRPb9Nd671eXvNLqiMR/03MwDqiav1gyWJ6MJL3t7i6TznF8KpemlTLVAe8ciBkmzDhpAG9XeRj6nBNAx9Yan45pUBXEZpueuWKfpyDpFrFMTRpU2dg5STT3XGFakc7XTXNAxyTeyokGdSt0dwqdcxDPs3EF2GSlK1B464VSUrkFkw1NY4NYGKpTW6rldq5kBcY9QtePOwwc7CVvxTcIzL/sJZggjMuVxBs+jwyppEJGaFmfgHdiTX+JuEkv6ZW8m+ao3uG7v5wkgQAukBjBLmxr5UGjeA+81ylY6QuOVS3LrEndiNCA3/venOFOcTpXFJBNsAMFntUJ5AyvYifA87Ke+F+4Z7oQ3nZSOqKvinzLHgF+eAH0fIUAGuQqGfUgaFRTlSh6MOnB4WT7U9grfPBS5xouvJlPairqVlgN5pCaQ5v4w+dzOBH4XcN+wpdjVjxaLFQWK3SFsCCDaSBGWSLb1QT/85PugqOq9pJTobAL8PJPl+h4KPupxMuCHXDZK0ls/WHPAr400EWP+jbXYYm9lDxzOr0S+wNQj9w+hS+xWh0kSYAKyxB4u24Uyj/xlEajXN3ZT9Do3jvUKtPJ8PD03Xr4JywFbmf1t4JiM2s/9knReHEfjQB8jXxfJ1OKD0cxwgBdsmg40ClDaKeQPhSCcr+/3O4qCL87wqtgWagZsg+X3VxkV/HdJgtHq/lNkyiZQJUiTV0qXjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /HNRk2ylUnIe5XL7cjoL+MN2GZUVxcWcDTF+STHTh4mbMgXzmCGLabOc7UMkjOmnrnvtaUQFKgXy190HBN3yF3ZT8wLIW0K/CqraVmuraaa6Z7G3LzgviicYhGnqu6ckX7RrZcLHqYIb41rbi5nVvsXCM+CSMZ79RX4tadHYoZ7/7c4saE78bkV9DFLS4RFIVOqEH9TsSjTL6e4ZlK988P8X+NXx4P2qSOK2aw1ueNUDZPShpzHNr8SKVJTUhU0Z04/4N9+W0dAZLK7QgEUPWEV8n8jvhpV2/Q5NdpECE3CQpB9K91WT4BGNSWikQ+abiJlBN9BMas/LIvVsuMTOddZl2flhBMEaf3tLqeWK7LdfaCWfCInG3Z/VuNsQhJkMWuKne+8jTRMQK/irDVHx51z1V4OP8lN7MiHgVkl5pfmrI5baP14dB6VgU6RRdmGp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:04.5567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b557fe-31c1-42a8-c141-08dea50d5700
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Call amdgpu_sdma_userq_doorbell_init() at sw_init time (gated on
userq_funcs[AMDGPU_HW_IP_DMA] being set so we only run on chips that
actually expose SDMA UMQs) and amdgpu_sdma_userq_doorbell_fini() at
sw_fini, so SDMA usermode queues get doorbells from the
firmware-managed NBIO routable window.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index de329b76a00c..02eeac3b2e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1426,6 +1426,14 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/*
+	 * Init the SDMA usermode-queue doorbell pool inside the firmware-
+	 * managed NBIO SDMA decode window so user SDMA UMQs get doorbells
+	 * that are actually routable to the SDMA back-end.
+	 */
+	if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
+		amdgpu_sdma_userq_doorbell_init(adev);
+
 	return r;
 }
 
@@ -1437,6 +1445,7 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_userq_doorbell_fini(adev);
 	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
-- 
2.49.0

