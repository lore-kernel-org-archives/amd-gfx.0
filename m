Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28641EFCE4D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B785F10EAD7;
	Wed,  4 Mar 2026 22:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wXObgIpK";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF9110EAD4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6EXYOcsByMsXXTyyAX1Nup6wBI8Bymyl4Od2yuN/Hd26RrWF1zeUU5G24vrklrInievNrLjXLZUGWXJ8Jhoa3CX5cXVN1INzL1ERqaGkJuWsUVQd/rVxorMt1VAqH9Oa6wSY17DHYviepE6woziiO0xsPK5+IXniLLbnjo59fzxhqF0Uu9S66rRScI6qyyUtR5khDvKcy9sIRw1Xn41cqlhTJiubbh9nef5A3+mnBLV+rJOKguHzUgw9PLjhuVXEbNfmPtJ4ZSNeGt2sT+IWCzU9cbQ/VN/0puNbe8BUlDU6V9CmCIWGhYJgUpFIiY26QBJD8OH6+iTWN65wuYOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euyrnzokgaxjdGuZfw4cmRN8fzczNhEvuK/W9DbW1fc=;
 b=IYIFZ0uOsWR5nNV1Rb8jT1w/ccEWRGBOE/moVbB6wwk/9A/JwdCNthN0ex913SqKhohF5e4qUhl7FaDgfJVk9IhjiWFqtuh5WOBn7dfI6xOcH5Th1e9wxkKVRs4Q7+t0J8kU8tFlffo+fvDmpsk40+wumQ+Y9ApyA48CoyOOhrDX+KUfXUtglV3zyS6FM02DyqmJagsX26nPsd0fzsVdXTqVLCe3ZCBie1zvy8z7HGlXIIZVCFmZ8wdZbckioyx/WDFGB77pmo6z40TMctfl9/VrBgYBqUiezkXFTZZDkCUys/ROoHERFhl84T9wIWRAlAix/5Azc1RGubdw5ynA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euyrnzokgaxjdGuZfw4cmRN8fzczNhEvuK/W9DbW1fc=;
 b=wXObgIpKLYW3S1xNHWz6+511YITPOEMw9aVIH3NK5PW33/WPFO+eJeoqikpA33ocroEOuxtNvsX6byGHtxLkMUfEwfNyS1h+4MXkcF/olfL8ED9ybsVFnuiX0piQ+UQ8Zri6WR12h+I4fzI15YahldU6ygjxiVFgK2VqBSGr8tY=
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 22:28:49 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::93) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 22:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:28:49 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:28:43 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <benjamin.welton@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [RFC PATCH 5/5] drm/amdgpu/gfx12.1: add compute performance count
 control
Date: Wed, 4 Mar 2026 17:28:29 -0500
Message-ID: <20260304222829.3688601-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304222829.3688601-1-James.Zhu@amd.com>
References: <20260304222829.3688601-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dfa758-3228-4034-6987-08de7a3d684a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: s/++u+PvMGKnOl5S7KVtjhz4bF6sg8clPVtJfDcOE46SdgFCUSo0KBiX2YXyOrWEfs5acsatxshVN27SxMiE7RpFnZ0JkGdKCXxCpY/NzXjprtOCGD+6m1HnZ71Xtz3aUJU+Sc/DaUxNNh86br/i0g8zrpmNrajTgguUdY+3IicSElcCLTu6vntyA/k2yEaiOUiZRBcziVoeaaS1jO5fTw4KbH1pOHDjJyeVURKZE2vdbSuxwaszDKb78ZYOGuLkJbPmcDqqjJoKwrrQL0j9lSeWv6me783lVdAcvTCV4oicv2QxWVPacdgOPg1WOKtlhUJyB3+ZRHNnLCke5ZIgbCllD9MnqxJoAmG91AmY7QCbvVDAkltvpEWZ/ASAxnIEeY8Tfg7C82okn5PwgzWOOvWMusVLr20YaAh/hC2OIn+kFZiF3JG0Zfeds+7Q3J9PrycChUHoiX70yWfMv2L4Ok9YVMdzBERzFaLF/4iD8l6B/Kkz+GKBNdhnIeDd+6Fl6dtQ1bXVSU2jKh00ZRwjOzfNZ0UUG9XNLS8BR7OOMpDjFNG/eLRBh9s21rQ8GIWV7oWicq9jiuTQllqfpRyo/4SvsOm7B5ChxSbDUIo3pYLLotDgLdXM5VmOxQdOdKDLLhvsjwFfewlAChlzYXXf8y2lqFw1psHJs7lWLBeZTvZsmTda70ekYQkKL72SsKi+vHspRqJeTbZClKjEc8PViT0zHxNRyTpS7hyxcAnbtf3qGCUuJ+7Cy/ENL/mpWT+6sZkVJn0VB1FKZoGHo3XYxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S38JRqhFFjRz38KJRnl7E/ucgzCTbFt3xI/qVoLxH1soYwy/eBb6QCC4y+wltVJtWgtz2NP8GcJgDOw0TFN9WO7OvAhrDACKK18mAa+8mY9EB/TR8bTAB67jKf+1OJ4sLwi16HVxyMdEvS+3nL3G0R0yauvJrFhAZABSwV/nUqRHix/tiJIyIM2mSbn4PAMj34t9SvIeoU8YD0Ob5FzKHey+hmdnlU8eSFb0KNOkJODdJ/Vzm97AWIlXERTOmNmgGLW1hx1mMvk+0vQJ2YVcPQWcnkfkIMzcSPZ2gXtMV11q0RABW1/A56kXfeun0PfIK2nQ0g8EVejUDrvNhJC4l98vjd0oWk1iffLrVMRvcTlqhDBIPti0MfjIlnP9QQwSrkOJNIxOcppbKIg633ugARs4FiLcO3sOyIW4q8AKK9f65o4wRaU1OpQ2lmviVMum
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:28:49.3153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dfa758-3228-4034-6987-08de7a3d684a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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

through amdgpu IOCTL AMDGPU_USERQ/AMDGPU_USERQ_OP_MODIFY.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index eb9725ae1607..faedaa3aa5f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2240,6 +2240,9 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->cp_hqd_active = prop->hqd_active;
 
+	mqd->compute_perfcount_enable =
+		(prop->cu_flags == AMDGPU_UPDATE_FLAG_PERFCOUNT_ENABLE) ? 1 : 0;
+
 	return 0;
 }
 
-- 
2.34.1

