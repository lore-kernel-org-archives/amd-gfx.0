Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F2CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 17:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A690F10E101;
	Tue, 19 May 2026 17:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IejJUGQW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDD410E3BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 17:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls5lfwXOYgyJLoRhOM/H5JmJ5T5RzQn8t9P/pYAXtD+elGqdlnaoey4JUI+LI7CWMxoNMq+ryBuqrTZ+jD2UE+19rmyoz/Leoc+rlHwpp82LnmLdd7GTWOiAQ7G86cRmXIj45NB9b7WFad7qoGAnP0OPgdoPli7zEZ5QuyEZ6JLPXc96CvKtmYJ9ODwL7/DY8kyVYMbfrhM+2JvMZzw3sgZlYDySklGp0/RVfSdzGrNvBfCCjJwwl9HSOZw/NaXrNdbZ4YAppaFV+3XNJ7N7seWqW6J3ncVUcDynfQf7ol6Ob+ZOH8VhJKJpTG9ODRHhl7qTP+kt1ZgGjL1mSBtBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFYOcGEyytYKWk8XQNdqkF2b8my6cDyqOVbyY26H2RY=;
 b=kFM7OPwgbF/pA7g4XtPa+oCEjpnMtc0+MIwsf0G9Nw/GAL5YvIxQeSgDan3MQOokfzbhM9K5/Ev8fb1PSijugMzFzJ5gcOZTvCjs3H5NVG+VbrVAkE8kyVQ3n+x+XkDnTSIWqM5erYUhIRR5ouV4YU5NhMaNSv0cBI+UwKHPrByiZNo4iDbT4vI4W//GYjZBeGGCHngWiEUog6gJa9KawO3O1nNb3zmtbpsR1CzePA9ZW1PlWMr2UsCxgCDlgs5gfgg7gPisB0oAXfC8G5Nc5N4ZjpeJybAqxzIoyK4fJxPSMFB5wVYtTDotwXd6OvyM4SjtYKtA8lO0t+mZ9iTsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFYOcGEyytYKWk8XQNdqkF2b8my6cDyqOVbyY26H2RY=;
 b=IejJUGQWzovAGIZ8QdWih12YXY2R7bs5t7u37X80LD6ol/Ju8XipJsFk+ObIZK6Vq3/OhsGx7/g3Q/LyQFrb2dOkehR4/T2NTSnkNXao8Mzqj8c45LSq0icwRYZ4dJSlQZU+32KGeUW988Khz2ZZDHZ+j6KpLM2DkUQ5CkoR4EI=
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 19 May
 2026 17:21:11 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::99) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 17:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 17:21:11 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 19 May 2026 12:21:10 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix division by zero with invalid uvd dimensions
Date: Tue, 19 May 2026 13:20:51 -0400
Message-ID: <20260519172051.635126-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: c8942753-abe8-4e9e-dcb5-08deb5cb05b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vlE9NpFJyH3zfuzQ6efn+QCRVGz7o5swtBAeyHNBxgnlANWQgsw4PBH2fr4Qv3iKh3gRL9JIHUNjA8Kf6VXSzV9t8cnkQFrC9+wm7wr2kaQY78XniKxUCXWivVmjP7qV+yZEni3K5uMZPnlvZIRquLbnSODkiLC8ZWnMXi909/KwOHH/lVtHlCZMBTjeK2Pi6iLen4a5LsuxAVQDeyYedQPEgiSMhtbOaTMNvjERDMCQqdoPw+o+Z2LvRKHP/ZQjwej6jUVU/GmhTUpffmqBE/f4Drl7WUiKz2yCyAM9ah0lTVPUN4FsWePQZzQ4XDROAsBfI7fG2nHoRq7x2Ss+vg92g7a9Cebrecb/XZo3qcmBFOz3pUpN9ji7EnR0JG3fug2/94uI6tGkPsG4HT7Uk5LnqwBX/PRAFNzeGMCHzxPR20MqWr9sNKKJq3jOu7Dq0epzSYm/xVegrQ+3fT3mnlhuNBkK9sE3ijb28D1yi5RN0tkcS2jcmHUiQZHJGP2vt6k2wiEKdpKqDabanD4HBaZZmloGLXpzhmz/kB92KHLHeu2SY7AD78XC9dIYa/2pfprtr+ZIpINbK8jisHIBgJ8oftKzMJPcHuk2kkmPKilkWXL5VkpRUhl137dAwdNDHor8/AzNRh1qSG/fqPRnzpATQvO7rw6LIgtD3zSMDoFmze5Qpd/GhufmUrdPelm0r7nkETznLQwZoObF+4cP/q4IFHQ2HJqg6dzhnC4az7E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eesTejxXWeefxgTfyH8D6XnT+bAYdEEgY1ROQXQplCmzUYinkdIi03f5uVY8gDqrOGVSmIEnfdQtg5YxmBQ3qDueZkcQdflXkic06Vz6hW5aXJqAo9NNjb1MDnXwIcWt2QyJVMKK4tP/lH24QMMW/n+yq5HV2UyRRzYDDB3lxdGySyi9r3mBUH/GA5smIt5dA/aKNeTeApezTeLkKyxksNFU5elVRaukqf3IhxpHT27fsQuzXMjbd5OvYbA3lZ2037C9QqfYyWAUUGEvlVSeR/yvDfNYpe6id/HAP7NGgbgiZpMk8HRBRB3PmrA/bNWgZ7zmYzh7ALekQTRXNRrEQPGLZFGqb5zvIeXAwRrpHlbp2J+I2Vu5XRBLX6HAWIpk6bfweN705trCYgBxMweFcEyZYFfeOTjnLq/d42p6s3+T4LuSRFhUwG8aoPr113Xv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:21:11.1307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8942753-abe8-4e9e-dcb5-08deb5cb05b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

When width or height is less than 16, width_in_mb or height_in_mb
becomes 0, leading to fs_in_mb being 0. This causes a division by
zero when calculating num_dpb_buffer in H264 and H264 Perf decode
paths.

Add validation to reject frames with width < 16 or height < 16
before performing any calculations that depend on these values.

V2: Format change - move up all vaiable definitions.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 3a3bc0d370fa..707e9d9441ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -635,6 +635,13 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned int min_ctx_size = ~0;
 
+	/* Reject invalid dimensions to prevent division by zero */
+	if (width < 16 || height < 16) {
+		DRM_ERROR("Invalid UVD decoding dimensions (%dx%d)!\n",
+			  width, height);
+		return -EINVAL;
+	}
+
 	image_size = width * height;
 	image_size += image_size / 2;
 	image_size = ALIGN(image_size, 1024);
-- 
2.43.0

