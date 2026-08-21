Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC524C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58ECB10F4A3;
	Fri, 21 Aug 2026 19:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+r7l0Ki";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4BE10F494
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpca9HYzoxuIdmxcb28Y8ZjLab0gYKy1S2h5TS1AP16M4lxieP7KiJjTfVEuM5DbMqpQ7/CeKN0oVRPWrLfcbcKJqaHV6Dyqq1MsgRNY+Io0s1RQ/GKzGiIKwkPApt8x2Yz7k44e6rpaIWZZaE+AfFzBHVhULaPCX1QssMY1iwMQUF2WpHQw2uv2uSgpT2P7WbxH5IK9PEtlczBSBX62nuydKGqF5o5Vv2h8maHCjVoX6R3kC+GXJqRmmXejQuqudfN1e47wiBfvlFdzeJUxgSsWe1ALUj+yxZa+ltVEj+YbZA0j3gUFFkTEcYougI7GoJlUulRj7mp2gn0M3H9g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaYCyoZEqZtUG5j3HZb4WpZb8I+znz8D7zJ3M+TVwOI=;
 b=YyrNpBdX9VS3kwdSuETg2bZx9TzPZTcWMW8b8cMrhxuN4oMDYnKjQ8dESLdmsIb1Ti3EGa+bL755ktN3NzVv9fNMX9GbkigkHG6f6+vrWQ9sLBQdT93DVo61HxDcCyAL4AKiASD3GIKoSo6zDLjJ5TDe9iV8uSH5l0NMC7AvJcQpzpxfh5zUgBfbpb60qiL12v8q0FmaCCJbNdGsQ/W1Cd5/t0T3dI6z6tquH+gUpVQrkfEmXKAM2zOnHZh/4cebuLKJ4es041gvFtjaA7xF34H06dDRAPZYk14quqMnqEwcy0zVqAK9Bazw3ixEKyNBk8IaYQlnMJwev2oFmAG02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaYCyoZEqZtUG5j3HZb4WpZb8I+znz8D7zJ3M+TVwOI=;
 b=E+r7l0KiwJTwXEGZLj0x4/8D8eRaTYYpTCIPFiHyqtZCdAlFFzBhQAXGu/SaBki636CZa2j10kljkY7fpqxHFVnfuNteE3WJEGwa/zhtY3Si/5SPP1y8Y8rgO328Sd97/SYwzj31F9CK+Wenk++Bumfh1JDDJZDsf8NmMoeaihI=
Received: from CY5PR19CA0077.namprd19.prod.outlook.com (2603:10b6:930:69::26)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:54 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::51) by CY5PR19CA0077.outlook.office365.com
 (2603:10b6:930:69::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 58/95] drm/amdgpu: Handle local GPUs in UALink import
Date: Fri, 21 Aug 2026 15:34:21 -0400
Message-ID: <20260821193458.808626-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 08377515-7b16-43ba-c16b-08deffbb6a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fX3SUqdh49Htnf6wSQocLSjEmxq8Wu3HHICv0NU6HOnptd7ctIGsiqicBup+o3Ov03hp/xwnnxrj6WIDRlYBaRtv73ZPoQf2JM3QanjH+WXrKYOY/3oLXHp7tBYjP9NKf2D0Z90zsIrBwigCIibipkHdW4gykicpkN6yf3Rg5Gk2J5+fkK+7Hlt9M2uU09NagaY1xIIBuY1ZY3FpWimDgkwhj9IJloz/cxKHN9aL7y5Fj5RpFIeRTQ9dDYSiyNIYbhwS5+j9GdzxF2QxUbnx7Oa3BzqsLElg7YAlLVhx5sgk9N17RlWSa1Hf4der92P+UKOHrc4AyqrOb8lvS2VY452oB4nxhR0gwcUIy5Okggb2XGGBKMXect8GR2+bQ1efjzXIpQwViRDcoonmqsa++byXcinLi+XF9ckARlgXxIbYr53Tbx6eM2s6Y+kuOjfPyLbdAr9OxQ58R3Kp78f4owTxCbWksU6MltJFeELqC3CRxE8E95YyfaWUBZ4w3/AxpllYoKG6eLQUJQIf9TvKaKRYDLTPBRALjpPfk2t2hpp7FhbtWUthEnrB5sPIhtRF3mK7k6oteRwOuCbrs6BaSbkfP5eC6sEFoWpeLXQpdxEc/t/xOJopUUNHRlmfpOukmMY0/WTsTkyY4eED+66h72/Kf0+dB71jCXFePA2zVUaGkXjVEC7nFJsmugXOEtBO6t1HINyMN14hS351MYR0KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mc/Ywpov6zdgpyEmXZZl672pudiQJBGoekrkqXIqtsPg1YnODQJBO1IxGgzlSLFnWwnXd6XgDOXILET0e/tVW36qH6AQnGp1GQ3wYFNXa9jtnEYiThyZXOTuWn0/KO7wA3szgzQXbwsVvg9QwCA/L30SwuHkUDHw7In2pwEkoH+sdBA7mS9zlyNAIHjP1BLSDjL1Hqy0EPym/zaLzVaPjFgh5zf6CXSL0jawah51P9d3BNzhDoJF0YPqg+fFb4Qw8kdZipp1vOdAR7SXsAp5cEyEHsYBsW8zgTU/TiiimYGcxRAeWZFDxnKDiAJPoDkf8/gW3nEwGRu9Pgu2LCs3JUWYJlSP4EQ2VqDElZ0LxHHVKinTTpL/kep24h5k+FU1/+LpfJQ+IQ0dIEsZUfQ5nhAto3vFgg0+Nw012AhIoBL3g6V+Eb6kfpABQCtVOFu9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:53.9600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08377515-7b16-43ba-c16b-08deffbb6a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

When the remote GPU is part of the local_accels array (same physical
pod), bypass the HELLO/NPA-REQ messaging protocol and directly look up
the exported BO in the peer's exporter xarray. Export it as a DMA-buf
and return the fd to user-space without creating an importer xarray
entry.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 57332243ea027..cd9ee0484f9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -28,6 +28,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_dma_buf.h"
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
@@ -610,6 +611,22 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
 	return NULL;
 }
 
+static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
+					 u32 accel_id)
+{
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	unsigned int i;
+
+	if (!info)
+		return false;
+
+	for (i = 0; i < info->n_local_accels; i++) {
+		if (info->local_accels[i] == accel_id)
+			return true;
+	}
+	return false;
+}
+
 static bool check_local_vpod_integrity(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_info *info = adev->ualink.info;
@@ -3055,6 +3072,55 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_ualink_local_import(struct amdgpu_device *adev,
+				      u32 remote_acc_id,
+				      struct amdgpu_ualink_handle *handle,
+				      int *fd_out)
+{
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	struct amdgpu_device *peer_adev;
+	int fd;
+
+	mutex_lock(&mgpu_info.mutex);
+	peer_adev = find_peer_adev(remote_acc_id);
+	mutex_unlock(&mgpu_info.mutex);
+	if (!peer_adev) {
+		dev_err(adev->dev,
+			"IMPORT LOCAL: peer adev not found for AccId:%u\n",
+			remote_acc_id);
+		return -ENODEV;
+	}
+
+	xa_lock(&peer_adev->ualink.exp_xa);
+	exp_xa_node = xa_load(&peer_adev->ualink.exp_xa, handle->handle_lo);
+	if (!exp_xa_node ||
+	    exp_xa_node->handle.handle_hi != handle->handle_hi ||
+	    !amdgpu_ualink_exp_xa_entry_get(exp_xa_node)) {
+		xa_unlock(&peer_adev->ualink.exp_xa);
+		dev_err(adev->dev,
+			"IMPORT LOCAL: handle:%llx:%llx not found in peer exp_xa\n",
+			handle->handle_hi, handle->handle_lo);
+		return -EINVAL;
+	}
+	xa_unlock(&peer_adev->ualink.exp_xa);
+
+	get_dma_buf(exp_xa_node->dmabuf);
+	/* Get a new fd for the DMABuf */
+	fd = dma_buf_fd(exp_xa_node->dmabuf, O_CLOEXEC | O_RDWR);
+	if (fd < 0) {
+		dev_err(adev->dev,
+			"IMPORT LOCAL: dma-buf fd failed handle:%llx:%llx\n",
+			handle->handle_hi, handle->handle_lo);
+		dma_buf_put(exp_xa_node->dmabuf);
+		amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+		return fd;
+	}
+
+	amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+	*fd_out = fd;
+	return 0;
+}
+
 int amdgpu_ualink_import_handle(struct drm_device *dev,
 				const struct amdgpu_ualink_handle *ualink_handle,
 				int *fd_out)
@@ -3074,6 +3140,10 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 		return -EINVAL;
 	}
 
+	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
+		return amdgpu_ualink_local_import(adev, remote_acc_id,
+						  &handle, fd_out);
+
 	xa_lock(&adev->ualink.imp_xa);
 	imp_xa_node = xa_load(&adev->ualink.imp_xa, handle.handle_lo);
 
-- 
2.55.0

