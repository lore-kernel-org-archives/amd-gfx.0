Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6207910F9943
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 14:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E0A10E683;
	Wed,  8 Apr 2026 14:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yZ9rFwYm";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0809010E684
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 14:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOv2HuC4ZkuWrAe3Ikipd8fJf0zvFiSCfQuSr19cfgtQBiUt1DWBRkBjlNcEUlDz6Zk6xRjt+ZUoT4/igN8R34lqRdTIPhrijyMU5lAZreYh46bHCPBEZ7gEsilRRbAMHSSt0zeNaL9y+C/VgRoDrYodcWPZ24wP+2fjgAdqC7JGqAGDIwMlgmlxNQWD/UBld14NHYIGetMi33GOBN2hHv9eEwMJUgSlrwfyPHG/yoLpPiVN1kt48mJFDkzfKmWCU7WkCUZZdi+9H5bb50K5fCm+4QJ2sZ0aITLbhCGwCrIp/rnVBgduKjubfz2JutmGxciM8wEae+0GPy7J1eV7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KncTpuPJVB27hN0JvNJtqwl7fYs6O9wKW+K7ZIRRfx8=;
 b=fQmWqp0xDVklFU37nCjLPz1QbeVLQb1wyXj7OSnoNpuBhVLnfDl5oEBt41xySj2uiZm1WmAJdg07OECwgW34WjIgGHZJrVfN0E8l53+uXZU+Xr1vxXwJKjk7gVXylrDobzAs7TluieOFG6IwrJVUJakQA+cK5TDYesFavy9QzXCQgIVpiwEkJlwlZ8tbHXhAS7b1SUUGMNDBrhop6IUbayDfEV8yADsrPlA8n/ruN3QDc95AhkHRSysiF844xQ6ttGOrl75h919ANt63OegYrhpgTlY2mA5MoFKvHKrwQ45cS+t7vg3YKD7jF7Q/uctDQRVPVMXzCpNC1y21tGeBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KncTpuPJVB27hN0JvNJtqwl7fYs6O9wKW+K7ZIRRfx8=;
 b=yZ9rFwYm3tOMSTPlqsOqxoEQkwQU/uUuMWnTHsHMxpj/QvZjEEYEXOLvh4kJ3WDHghobSctK5lIc1XR7Z0rQDBe28/e6xjGRVxhH4WWpiDJNhfVec8ni62AUjq3RPhhTI6NSkq/Zludln0FnhsSbwww88yM+0BOuA8v/9MShTEo=
Received: from CH0PR03CA0305.namprd03.prod.outlook.com (2603:10b6:610:118::7)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 14:17:39 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::25) by CH0PR03CA0305.outlook.office365.com
 (2603:10b6:610:118::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 14:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 14:17:39 +0000
Received: from MKMEKURZING01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 09:17:34 -0500
From: Erik Kurzinger <ekurzing@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Erik Kurzinger
 <ekurzing@amd.com>
Subject: [PATCH] drm/amdgpu: remove old amdgpu_vm_debug declaration
Date: Wed, 8 Apr 2026 10:17:19 -0400
Message-ID: <20260408141720.1845-1-ekurzing@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a60d87-d8b2-48f2-b038-08de95799726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: amymuLbOKPReid/9ASTNfTrrUSUlGgYVxmogCDinz3+AHMD5Kb9ytGG0W6lgTvnoXhjgeAbi6A1QlSI6fCSLbgqH0r5maZKgeuaXP7qAsIQvI65WiTvYqpF0Ht4ZdqcDdvzx01zkM9uX/iF9xYTDTTrbI4Lv6kD+U1DQAe3P1ipBoBvCIXTg7SVIPtvqi/iVXbrsKBCYEMP3XC0slfimHMjue7lvkY2GqXzqaOg1v5Q2l/IFBwlO2pOSnLLCNj0qDeZtJ6H36DennSWVVZohzeygyMb+5QmH+gNnyoIr1EI4AWZjuNXjG8Y0TzlH6VcMRKapn86ao3/ONpalVjPSEP9EZvIbu9m2oP3ClWdKp2gSjo+ONsj5M314KtIiOhU/mDGL47vH88LV8Exc6ad5vLSWWRWeQEj5v3G/W5leBBZyv/yvZaG3oMkL2CO842OYB9DdLLoiORugaNKo/FIxvm7JLvAS5SD42HYd8j6uwxBg7iHS18TsjNd5C3fNAHQXY1SOIHFAp+RYeihuIlQtwlW+pubs8sZl8Nvdz/5PEHTbgfXy5htoAWo++pgVDReVKCVtL4pxsZvXCbfLbu6zAoLZcuUReVthPOceH7fTgnlmyG7dRw4qsYy1itD1GS5ty7MthjKd2zJmncE+teZ2YT/aD67oCpLsFHsQYG5PLR4KB17TaxlsKNwe8nd5RIS5o0Fls4jTIZ4lwhhihDNrs41GjnLykKtS47p7etlB7N5vtJM1Zt5zHLXGye6VOwjmXG//z5sBTe5jQtOqO9b5vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yrTb74OEJQTG/vFR6F0oLor4/vFzQeuT2dz6yXUBPJDDwCdcVBbdIAXX2kbK0c8OREi8uHs2AHB3Q71w16a0HynjR+y3mxZRpjJ/Me0iJks1JLPQg2Buy4Z3zoWosYDVRyIs42BkL3eFjqOI0cCbGeSi69LtmpOEcYMwojtCTk8ZhXer8+DnqSlrEDq+Ro+ApqqgHoyW8VgSgMNXkIOEFmURgeWYQOCF+jTkxf+bPeTinoNZ8BfizO04QAivg2grAsth3cERsZlxu1KIIxpxQy+7zxe2zY2YMJUwBh2Ewb+AGJp3DwjNArlqoAhHEKHwyGn7jEsPN4Mm0zgeHbMsQC+ddS/OvJjidU/SazNqK1dMIgOd+iMM4VZ0arkxyCoWARrTlhR3Xgwom23AeRIRAwvsAz9CoKkTXDPMKTNKQPK27wKzVI8ka0dum3f196yb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:17:39.2426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a60d87-d8b2-48f2-b038-08de95799726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

Commit 887db1e49a73 ("drm/amdgpu: Merge debug module parameters") merged
the old vm_debug option into debug_mask but left a stray declaration.
This change removes it.

Signed-off-by: Erik Kurzinger <ekurzing@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 49e7881750fa..727e0a95bc86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -181,7 +181,6 @@ extern int amdgpu_vm_size;
 extern int amdgpu_vm_block_size;
 extern int amdgpu_vm_fragment_size;
 extern int amdgpu_vm_fault_stop;
-extern int amdgpu_vm_debug;
 extern int amdgpu_vm_update_mode;
 extern int amdgpu_exp_hw_support;
 extern int amdgpu_dc;
-- 
2.53.0

