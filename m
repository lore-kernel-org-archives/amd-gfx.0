Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8316FD2D74
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE3110E2B0;
	Tue, 10 Mar 2026 13:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YMyE4QPV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675E010E2B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZMSiNZVBZxBzuiG7BD/hOHYeF2tquy+EbB+UpLIeTsOB8CeESXcB0gxVKMQf3udxN2ZGOEF6xZokC3AqCU/fOVRgQPclihavlSbtbwLcL0vzDEBdmHdkis6TJXqNX+lFRkNO3OGcVR/2pXNb6KTGVfoKMgo/7MikBDkpLkx7VwHlsA5YMFtTUmbDTgqy1ZfxhbmtDhSvSFJdEFOXTfF/JeuKnD+Su+n+AKE+GxjO5kudcp2hOLF6x5KYDyUQ0heVV3gkMvp7YKxphnUFSV2A9VQWHmRGZPc+vkAfv8Xv7W4WG6cEZjSC8HG8tjZyIWaIwBSP+dJeryHqHamaCGeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k189GOi9dAFuDIchpERZx1eGE+kaX+JaLX22e2bFecI=;
 b=CTwVHiOmOoNfWgWRiPMJEyly7M/ocZ+PcWum3fbrxz72Dfwm17EnyBhwPIoNL6hi6RXt2WVxD9dNtrPv+QLDWbByLk2zHBvGG4ZW2uOmeSkr5P7JpRfnz3RF0JIcRZropTC6w7Az3Om8hig6kdOss7CFoDGjGJp5KPulkd6HHs8E51B4zILDAtGiDJbjt57VZvUDUUVIViAEk2Yzz1Pf0wALeR4dxUqEe/jAiC3qwwE/22bv2ehdc9Z0VBECwh22fhldaaTiKzGzXcFo85/ba0Fb1+j0e2JiLsKwIHbfJJK597NSqAjiQ+0a22ph4Qk3FYfRYX4YdOA4oMK+HUgO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k189GOi9dAFuDIchpERZx1eGE+kaX+JaLX22e2bFecI=;
 b=YMyE4QPVwrDtnGF5jrGo1E/O/TzKUv8/nE/ZIddqM55kAgPf8cIFwJn5YLfEq1yx1zYkjnNmOX8567yuqVhfbnAPBY5kto3udD5BFfBYxgdR35z2D7BQ2b5lCAIn/x/9lE0nXnWF6fCGBC563+/Gvi1u+uenGFLNKYVkMeehJgg=
Received: from BYAPR08CA0063.namprd08.prod.outlook.com (2603:10b6:a03:117::40)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:22:25 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::51) by BYAPR08CA0063.outlook.office365.com
 (2603:10b6:a03:117::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Tue,
 10 Mar 2026 13:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:22:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 08:22:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 08:22:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/ras: Pass ras poison consumption message to sriov
 host
Date: Tue, 10 Mar 2026 09:22:11 -0400
Message-ID: <20260310132211.2867415-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310132211.2867415-1-alexander.deucher@amd.com>
References: <20260310132211.2867415-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5fbeb2-7514-4e9e-07f8-08de7ea811b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099002; 
X-Microsoft-Antispam-Message-Info: TImF3LM4AeT/ULkSufcwNNidsjxYtjbCZ0wzqi+EZS52c6ymFRDGU1vYwpEgb5BLpc49oJ7fspHeMiEIdV15mD2JRcgeV5sPxqnVyd1CsMHF3Lsi86wIfLQ4q1Pzxp0Z/kh4FK8/mjYBGHEm+8sejE8hKnNbAXzYUPq3Kvl0dW6Jr39gCooiNiO8e75fcghrEgERsVBa3wPOuRQNFZHhYIXqzZ0ckI6ksUhKsLHZZd9VZDpyKzBY7STPOc+V9MTlXSgDpFix7ifq8WzW5jVKASc6JLYXM7pn8MuzkvgLQ//yzFIyrzjsXgrs+Ns2Zw+dVT9Uz5cwxHHObhvCFN7NhQP49go3R5p2mW/IIRGoY7QODo1wxaS4NWI10MGLgrM/Ml1b6cOUG5jRzNGPvKp7usOcuYYWMWyM/GXnbsqjR1mqfVo2OklGNezgncJL8MPVY51oMv1IrYb7UHl16dWGbijjNsFmJKfemkWsEVi4eumVFUXw8Hyv1uFTlXt47obTr+K7eFunoU4D8xBtUJoEin6CbACQ7S3qYrzrGUIK15biXi5295eftmXgNHb9FNdVDijyzAX246aoyTX8e7VUv7pgPV4GibjL/K2yjhczWX7WlYF3nbH0w32y+DxLFDdDGISEbKN6rFjGPVTM1exE3Fp1yNyCZaZfF8PzsyV6jny0odSM0uorE7p/6yTMaaNwcW1FBOyeC48iNnS4TYh380XtnchDdI7EitSVdzAfuM4Nwzo7POdc/qXbgfOiTYuTe8NfryjB6VGel4P2xNdWSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ERT+Y3YQZ4iQaHHyVWUmq5exle5/NSAuHs1+u/E/8cyJv+ZcO1PCl/Y/Ac15U/jbDiP3vL27+6AlhWL6unGkWVl8gEwyub0UqleD6m7ZeXG6XwhKHEWIJoQqTDh0zDGNpyrsbd65mpkJdJt3CVakXuwuWQEuX+cpYi7seopEf0WyxIRk+LnAVg0uaCA1dPhShf4MsgFLkauIKVAhB8Xk9hSAsLOJ8f5hgBp++HmqDd7TUMJEHZr5iOLTd0y4WGmf6qmNw4inycJZdUGQ7b7G/xG16tVPxYE7CR8ylnk7ZmlPJ13RFTlgF9uon/ogYw9V51Xv9d4MA1wGUlyQKIOLGrwFb+4b3Pc/9Voq0bOTOpA0S+zwmskeAMOh/qudLVpoq6JHLUTS8WxVcp3R4A9Gb28RjeunKIWNncDidPjbFskO8zsMGCBleM366I9fFTFe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:22:24.8726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5fbeb2-7514-4e9e-07f8-08de7ea811b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Pass ras poison consumption message to sriov host.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
index 5782c007de71c..285d81a85a99d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
@@ -103,6 +103,16 @@ int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
 	if (!ih_info)
 		return -EINVAL;
 
+	if (amdgpu_sriov_vf(adev)) {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev, ih_info->block);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV for block[%d]!\n",
+				ih_info->block);
+		return 0;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.block = ih_info->block;
 	req.data = ih_info->data;
-- 
2.53.0

