Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5469C103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB7110E82B;
	Wed, 18 Mar 2026 14:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="efaNTPpm";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B1E10E828
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrS6fbZF1gPR5C1Wwshee9urDW8LsFF+aEmOXJsJBS5s2xdoMRb8tG20UydRVc1t241SBdiYtDCxNrKJIrGKIY6Lxi5AOr580yAQjvWjauAtvfK3S8/rchSTLl9NLCKx0OLOJ1zuVzFYyM3ZP63LLT7XtdS+NyU3moFg0vb7J1D5oqea1TR+JKK2KWzkZLc5VhT2g/pVQ7Z8M7i7gNR8fBQ1mEXGqupwAPsjej0719sWWNIaunZk5NHCkIPM1V4IzWKkw3zgBBgjcZVSOZy/a4RdBbkkDSTOxX/IZyfXl+QFiDLD0MRTLfkRxSyvRYoc3+J7Qw1yz/2svZiA4GwcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUnMGQnVhx08d6rg5dKBWQP33RZXtSmRd7ESENEUKlg=;
 b=xIsIxzszeYwyXER7lAEAnfb3tPK8GADzC966tNEMq24PvPNo4fyd2IUlxRXlEZcHaXH0bdwKJq6vR0ucpYV1GZ3xbiDBeeD8Y8V2YHxRmRQ4HnhsedaRlrzpO/NpotfOeQeeBqL2U0qjrGID2dMhv3WCTwM+CX1k/u74DmGKXl/e99129uLCiU3NEkFMPi9+a5DgBDyKOY0o/VSMPCGrI6LNgQzJMTT8qFXGWELaGyBD5yv81ObZVAcfx2JCeoz28cVCAVYI4NM5CpY1JdS9H80AcImfmmxZGBEEa0O/VEvbMaPL/uOIuHQ5riZD5nbNqhsF6XAkAazTzQvZlilv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUnMGQnVhx08d6rg5dKBWQP33RZXtSmRd7ESENEUKlg=;
 b=efaNTPpmhL5HDojWZJMBn3MZ6C4K44GWgGqfN42TRfuig1h56pkJA4mLroiY8iGVaqMaTD2LrAGLyGap5epmDZPQJQPfLquxpQqF1gnYqRZvfwNrrRja/z6gxPpaGXXwk2GVt2H1KSTvb1tBsMfOOyCBseA24AMIg/ONMOXabvk=
Received: from BYAPR07CA0057.namprd07.prod.outlook.com (2603:10b6:a03:60::34)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:09:02 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::c) by BYAPR07CA0057.outlook.office365.com
 (2603:10b6:a03:60::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:09:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:08:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/16] drm/amdgpu/gfx12.1: align mqd settings with KFD
Date: Wed, 18 Mar 2026 10:08:29 -0400
Message-ID: <20260318140837.582776-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd4546c-de21-489d-9ee5-08de84f7e713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hA58+R8Pxa8u0JgzFxN1f4uEcQ7AYEFnzot+C+L9/dNAV9cIMvG2JKZjrMEiXta4otCGNjIpGecuHO7NSDJHiXy25DBfR1LhQTkL/LAY5QCNM9gw8rj2C9NDdTpNGZDeLI/rcga9ZxPst4E3tEURGeVYrmacrI2ZYZl5Lg1WX53eWosMnbKKtJm5myHH1GSkR8f7MFsMB2S3CYySfP0JcOhzz/fqXqLMaA0QRwWiKxTUnUl4uOZtM2j8V1X9C/M7S8UkjITDfgBcrtfbLolib7LSQ+WHWwAKxIiboZpI7LsFGKT2ZA58pNU/1JUHbCIu+vUHixFd56Lplj/wQkEYBSw0+ZHUx//bqTbUmlAkiKrUJeQTqsLcZtBu+Ryv0MxnlDmxTfhCAxxaVdrcpzG1bqv9VBbgptHYevuuv39AwIryIS/u5mX6hd2brHIU2qKPJ+gzMzlsSb+2VTIOdC+6knQ2rrJgITuF/oGkS69exDkOGKHD9A2ONViIA1t0hMRisc5La/CbGr2av7fezTyJxkyzjWs2M/kOdiznNKY4vdbq2HtZ/d9AtZMGBQktoufNVnE/vbDLpEmExC7qf76J3IlcfOIdGD4IMaAA8YTFxPNO+zI588S3uwqvOniRyAvnvaAtEflXaawJnMMob3IN4mOC1nWRmnK216EHZZT6wqc3CZBousasU7ch9LaZFA05kTs6/gio6bnNjGKnbpMgtowWjMlDdEVRk7bOFTwkAtzgDxJn/nSiLqiNeIM/CTfT12tfn+x+QesvTxUaNc9/rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vbnnqh4R214LGfQrSNo6xYIuStlPYMs1hC39YSRgCv/nE+poGTiBrOVq97SBf2nweFZ9DDeLBfe33iDeBZXBPR9T47nmbC9U7ZmS3ac1XBM20/32SEcIGughnSImKHwxv9J8+hT7mNa7f9cak7y98hdEPr458mHS+x0a2zW0UxciYAtVAEvh4T8udYZ+kn33zQ3lyNP+u3DXv7FSe7f+z5Y9ShqXrJpzBbmo3ksuQSTlJNbqSLewrB9LMRACqG65CxNY75YuY/LZjEF+TAjUzMFU2vPF0Bng6oCEJ5rqICkcNGfvcUfnEdO2QIU8xkhXJfnQRmO80PWrbvGxoU1PM7P6DC7lmU2RXgdjjqf9Tj0WG+nph2sx7Y4ArbNXwSq7OzIjn0YEUhy5NmVAFSeXYQWopQxUZxenFZd6ad+RddWW3LHGck0/13BWrPzSFU8z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:00.0642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd4546c-de21-489d-9ee5-08de84f7e713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index db49582a211f7..98dc6582b7aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2246,6 +2246,11 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_stride_size = prop->mqd_stride_size ? prop->mqd_stride_size :
 		AMDGPU_MQD_SIZE_ALIGN(adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size);
 
+	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
+
 	mqd->cp_hqd_active = prop->hqd_active;
 
 	return 0;
-- 
2.53.0

