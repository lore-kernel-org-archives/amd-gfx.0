Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128D606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z2j6UHnV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0265410FFB8;
	Thu,  5 Nov 2026 00:04:58 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2005410FFB8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 00:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHjcEC9If8jkELYvV/KBceTwsBonI+Uf9BRhwTULPtbA9qfxy6EbHmUN0Ob+eH8oDQrT3EsXnj3KzgMI5eKuF/MSXpYsfov14ap0FNOPEA6wGXz6KMZ9j7afrYIIC+lmSYSOzuQvgTaCcaY8Tj+hHpk201XLVx3jW6KYx/YYnWxJU8F7d7tXnAZM6wYPEIVWoZ1eBlCKQp7o6phTkwmVQ8F4aGOgoBt26LuPmZl55hQ1PjbPLs3AA4iyK9wFHjdy2CelarGKcpDBJvbrD35bNQ+YeiTfBIMnwozKSiTx77PxWwuidU/8tEvL/ZJzouuDDOP39G4ypMNGHHXR1xOTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEZH2hdkhMUtxGyP+FI8cRHz2KBUriAXy9IbmL4uFTA=;
 b=tWnT0m8t44fludxxkHZHLvXuawIqpQkaTd+eSAZAb2kRMZUNrnetjg4Dqg6JZX0dBl3FJHQYAEC59OPQiLFZz36X3g65yDHDgdyclntxuWkPbeHbk7cNL4F9mWzFdSZB16V63EVRY7LAxf7cyAKMGhGrcky68xvO6BdjS6bW6FaViMK+lf89NIlZrKlhJJlGJds+4ZOpZx3t15lx6UpOWXQH3qco7WdYZ2ohUUd31Zig3Ili4I2tbv+HwuEQZ6IQpjrj36uAgitMW6L0LFCShr86K6/nxqUf9tPFdOuSDKkymv6MYDoq17iG1yCq8SfRxaNznTBX9JqTxZ7RxUoCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEZH2hdkhMUtxGyP+FI8cRHz2KBUriAXy9IbmL4uFTA=;
 b=Z2j6UHnVvFphTuO7jynggM1iBr1GjeUQDq+8JUTGfVSJj7MrkaCeN+iaqV2NmDfR+5gkpHHB9eL8A81gLaM5wMDWPQoiMtrHixYHSludKCPOjj4TPTFUeViKc6ppGoNlg6Cpt6fgCLRslPYWfJv+92VEq1BZ00SW/mqluyEsJqw=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by AT6PR12MB174769.namprd12.prod.outlook.com (2603:10b6:170:116::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 00:04:49 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::a0) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 00:04:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 00:04:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:48 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:48 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 18:04:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <frank.min@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Kevin Wang <kevin.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: enable ifwi upload support on psp 15.0.3
Date: Wed, 4 Nov 2026 19:04:39 -0500
Message-ID: <20261105000441.3850131-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105000441.3850131-1-alexander.deucher@amd.com>
References: <20261105000441.3850131-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|AT6PR12MB174769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b617db9-5edb-4581-89e4-08df3ad06845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|261009223027099003|11063799006|261021121427099003|56012099006|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nknN1k8RLb67s1bBUn67L3vhl8MY+Yt8I5Ll4kDOKrdeZpLHwrBgr56UxTH9vkBzf+lXRbxnct0nkKm6sXI1pxgo7NHbtfl8tiQrf/hNkHv6fr8ulgRuOiRXv2g8NfkQ1fF0u1RMjpoi+lBiFY+vgnQkONTTsWJK3sgeP8sYmvpNRctLE3GpQXy+o17uJTG4iBCFdbbaZ6KbDTwgqhYEfv40VO7Mlaun8ECYJjyX+0Hs/2/BGEv2oHwyhn+zHg2IIbR1h6k/2blPFMGjNxX7X54sXxxpV3k7huGF15wDkSqPd/tZFNzk6H3IrQUFMTR6PyKxot4LnG+FHwiRsrrUDDqyYjni3TpuqdESwVmyt0lx2i5LeBxfK53iwq+D2Pthgul9WMm9uqEM5S/KujYWdMC3qI6l6hpbwwRH15MHK1JLfOsxOZ6LswbUcIoTMow+T7tFiZd4FkxkG79elAggBn5P0jkNPaxyfnMa2S4nrb1dlJwN2c3PaLo/+l08PsDRrZiGuSTi8ltVTEmWYXgMB96vtnbczD6ELQCliNIaztZBMs9XkzsesE0X9hl5/ukd+ED8nRlN6TZmqxQyZ40CiZGQOcTYBfUmSy0muMD+fdEcO/UYktbx8wGIC42wV9MBuJHRvWiD+HFgoF3dTIJiYJclI2xT1SyO6KU425BuyrD/04bXBl+RyA1JMtHzLM7eSpmQPLqzHh59QkeaTw14hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(261009223027099003)(11063799006)(261021121427099003)(56012099006)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /0UsV5qAZ7w3HhNuOwKi/VMwxNXBWAr5qckCyIbQ7vqxCm0gqzB/iCI/GblNC1XS5rbppNVXURnpsgHI5L85A1TMOmJwewnNKbCU+13RjPD1sx5YSPgmT67F6Tx5x6mD1W2BoO3SKs2SKDbBoRXm09o/rBfoVLSmX5L8C0/suD+jetgPH8GwsX9os2PWQqPQ5T02dcxNVsAj2IBdsWWbEWwopIbYnNPSvVXNAO4QApiqwdO4e0kcKw1RTEKSparH7QndBFpr0oB0UOgfmYyZzlHhs3VYLxSU+LdBx4y6iciSoyPBPSoX3YXv7OD6TQUOSSJz/pMJHY9kxzuFMG9eIK6zj5DBgyFghrvP1VBaaqR2PLvtw38hYppLDHkFKI/LtOo1ilfQIaMbJf3CC0vgpPUDiMmgaJo9iuQolyAYDyWXdMBZE3VoEXaFnSqxizk6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:04:48.6177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b617db9-5edb-4581-89e4-08df3ad06845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB174769
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

From: Kevin Wang <kevin.wang@amd.com>

enable the psp ifwi upload sysfs node on psp 15.0.3.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c0ed3e24b6840..f2542b6583b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -289,6 +289,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp->boot_time_tmr = false;
 		break;
 	case IP_VERSION(15, 0, 3):
+		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
 		psp_v15_0_3_set_psp_funcs(psp);
 		break;
 	case IP_VERSION(15, 0, 8):
-- 
2.56.0

