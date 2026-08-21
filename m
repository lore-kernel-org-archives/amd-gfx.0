Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3627AC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7974510F37A;
	Fri, 21 Aug 2026 16:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iy4br6GE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B537110F379
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu016q6zgUFsv50Fb9chxLVkprsjaHEJ8e/3Lqy/qEJLeA9bbmR29Qpjyif6zEiesqFAjBHtZS9BURKOB+yMC5e9K8Y8PJ7izkBkl6u0gBZ6MXPVAxwGBqtAMXmpGPIbimKX25Tpebfcaxfxm5h7T+aK8Ca2x2NdOTtZ+3sAgaZxWW43mUXvBsjqFU76z3p3tN4y4i6MQdMXmgKVWFpMHUuqXUhozt74If95FQST/wWBdqMpvXU2pNFJUSSYSLGCRuIZBvwBSLbwMTUJjlBu1QzYnn7baNt+GDtb3DeDCUGVZYTxW8V30ObOowkeSY4mUvyv7/gPi4uxCYLRcG2ZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIWAbvpA0/tgPN/uEIhA8XfKYhuVDYgC5shuWv1CI/w=;
 b=caXk+qSaK6gJi9LddXdvE1YIa5DOSEbKvYj4f5y0EMWs+Pg0KwO8kRg/TWr3wrprb3SX1qIP9I4dE6CU5DlmDlGrlwIELf0nbVdV/wbOcFgaQ9PPem9HIiSMZqA5oZpzGOir0zVztgq+fS/+nERG3Y4geRcWzH34g+514FRz8lf6cbWRrc6OE0heXMTGASxSb3lZ2NdrQQUomnzSneK8P1QHZyA9u2r1sKx7YVGM6ifPt3Ya9dibOK3M+rgT9fDW01wjyb68kJaW+pJePYuzeqQveRm/7vlkeLOWYGvjELHCrJXDsjpF0wR635wfu888rlJvoRiWg3cCK/EEgB9NBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIWAbvpA0/tgPN/uEIhA8XfKYhuVDYgC5shuWv1CI/w=;
 b=iy4br6GEe+nNAkwkfzuYfOq99+yaC7YyQMBfMzaGkiN6Dfzgq9ZW7I98BmuJFd3Q+rX/Dd8qtnMg2+fXAsYE+BzkryA3pAUp5wi3j6crDR16oQpq7RqO4WdpUxIxqvoP50Cx2qWb4q0ceJkK3Pz4mxvNT0a1LdiSRFACmQD7ukQ=
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:14:18 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::ed) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 01/14] drm/amdgpu: add amdgpu_discovery_log_bad_signature
 helper
Date: Fri, 21 Aug 2026 12:13:48 -0400
Message-ID: <20260821161401.754042-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9852b4-a4f9-4d4b-f503-08deff9f406b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: dPn4Cz4RUBNmnfYS7uYaiLx20qTafNg0A74kvVcTl65uN8N2BoquyON7F/fNX0JrM05DVfj9KW9x6637Gp/de4wyydw7jvKhrAOSwLMrSZa9qR0yvEtfqldstPDUOrqNmcP08i+fFnaH7CVN/wz2lMV5DkGpMbI5ewqsXZmzYasKDZ/e7lWhZPnnZ12VvI8Weh7i7Ohjr3yUtj+XnbWwMVi8DUwKwnDEVtRL2sBDF7+1YqEiUEp8PKV2FEfm/gfq6lG1NzwjNpqW3UDwqldgSTFAO0mp/X0SZHiMi+gtwTdBPHjSWuYsTbjH4i4Pxsyon8wkonjaNqlI8tfuMGw8AXY1YBHs44UgOhU0NBe20bL1VAVEyeXsvSbhEG6HyJav/sWmNyB6QJefzCEHytft46b1aXsPKj8UUmKsaI/nYfvVkNIbaxMOrmMWfbXlC6Q1vyt9DIE6V/AY9jU1F6Qa0cBqZwdjOQsBMUhhkcM0sjxQGenKDaX745NowxwDxnSIKNxSfGWWdwt8gVKdibvlWWuq2+Cgnw0N16VCtmbGkQ4/j3SAkr0W344ER/5QApUmSWgbB/bmecFOybXkFojkWh+ClKldMhmLUjsxxiucDB/wghxRGMjtM6Ytz6pMV8azkBKE9fQkRcyNlzQtFemrEWAVF3QNdxPndHWJiJePnHMybnzDxWF1UhE8QS052PoHSUS0j1PL0/Luc4tak3n+FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xz3NG+tcjPNTBTDjoL5tvlLhsi+A0QyYF0ZicNa2M9+tm64qRIWFN/Y/upx/AYLcwbtvMngh9hhytSK/0fq/OrtCRQWNZWTJOsOOS7xR5Ih6jXch5sOAB8wCQm/Fte7Rw6nhg5re6ekWLNrVVEFKFBdSCwJzYuHq+TE23sT0Sic26V01WqrbTxltmVI2F5mlBbRsLBILkJjXx/Oal8w/Da4GCV4sdZtVu9+0Hk72EOZOyslRa1gTQdhTU06vgYMwf/Ex/Cp3vXwvbpRB9ZStqHDoHEiB2P//NvdRyAgGIb6AyjyyZJBXvZJu3Y3OfH1jrrrHZVoL3YXe/TcdeY0ErlrsRoKqVCLGbW4sVDIBtE+Cqa47AJI32Cbrj318gpZcY5ga5ynXtbDoPYdNswqVBuAvNuuC5CXsqGy0hQZrnI9AcXMRvwil+w6X3rYe2xi3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:17.3011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9852b4-a4f9-4d4b-f503-08deff9f406b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

From: Feifei Xu <Feifei.Xu@amd.com>

Add a helper that prints the actual vs expected signature for debugging
purpose.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 66315ce79fdcc..e7d40afac6432 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -701,6 +701,18 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void amdgpu_discovery_log_bad_signature(struct amdgpu_device *adev,
+					       uint8_t *discovery_bin,
+					       const char *fw_name)
+{
+	dev_err(adev->dev,
+		"get invalid ip discovery binary signature: got 0x%08x, expected 0x%08x (source=%s)\n",
+		le32_to_cpu(((struct binary_header *)discovery_bin)->binary_signature),
+		BINARY_SIGNATURE, fw_name ? "file" : "mem");
+	print_hex_dump(KERN_ERR, "ip_discovery head: ", DUMP_PREFIX_OFFSET,
+		       16, 1, discovery_bin, 64, false);
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
@@ -736,8 +748,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	/* check the ip discovery binary signature */
 	if (!amdgpu_discovery_verify_binary_signature(discovery_bin)) {
-		dev_err(adev->dev,
-			"get invalid ip discovery binary signature\n");
+		amdgpu_discovery_log_bad_signature(adev, discovery_bin, fw_name);
 		r = -EINVAL;
 		goto out;
 	}
-- 
2.55.0

