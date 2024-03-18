Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A2DC54E60
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 00:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600C310EC4E;
	Mon, 18 Mar 2024 00:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uhoLw23S";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBB710EC4E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 00:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4+efxch+SvrXFamQk5vlwtaas+124iiQOnXvF37prBiM1k92efQkf9qob428H97OW8tmhrxxUygNW4qqq1AIexkgLv9KPziMiANQIfVzL63yuL6eni2NPg9Psou4ZuVGYYslE/IXo1Mm1qXO8M9Av2TSV2/VTj6eDuWWtkohsiCdSbgSWHzJ/HQzoloK3XtE4bFoJXz29ioyoC7kvGBnO8XXekpuzoRX3J3G0zcSWtk5n+PO0QSB76dlrzzqhs4azTrggWMIGQCTsh+F73UoE36V3cUBiC4wrsjLMfTYjjKyY9HKlF+lUD6gbjFA2jJj5Hw6u/nNrd3lJxp/DVGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIBGrI7q2ZOhm0YarhUFPDKCHP+uzb4jSgChIZaR64w=;
 b=aHyYrfU0qoBegBjjL20hzzBHrEueX3O9mEouyY3uorsErSdLLQM5rt+9iYoHBJpx1LbmxoZZ7bExDny3Sp2Rzp3Yl3imbpWxdbSCFlTD2qm+Gc1vRrwDGR3i7K0ozi2oHnWSIrQGfzbSree5pbpGaWZW41O2jOIEVJ86SVH+jZaPU7cy9S4bMtRjV9l8wRNWz/8jrvh7RrvBse62u1YPXUZpHV8Skr7u+ySVGMWKzqfvv6dQyrqTHj6UmhUAzwtVExVXP9w6ntW0hRl1+KsqmeeQgtLEl2IYQNlq5iR8Fm5ga35vKEqPE5L/XqBtfyTkAJge5bXiMOd8zailVg9JCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIBGrI7q2ZOhm0YarhUFPDKCHP+uzb4jSgChIZaR64w=;
 b=uhoLw23SzxI7RuFb7lBE0dS5+fnaPv+0CkbB+K5yivzZrgBygYdlVrMOfjq3unc4HbDQ3UYO5yjmJwWHeToz8v/Z4F04/k3pVl/Ku87vNC/oxw4AiWU0eve30QRyEF+lvz6/aUsXMODQ3vHpjj4GTh7UBTkuiIctwRlRrtUQ7/M=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Mon, 18 Mar 2024 00:55:24 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::9b) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 18 Mar 2024 00:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 00:55:24 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 17 Mar
 2024 19:55:22 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>, "Yang
 Wang" <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: skip call ras_late_init if ras is not enabled
Date: Mon, 18 Mar 2024 08:55:03 +0800
Message-ID: <20240318005503.4173308-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c955dee-607a-4250-4471-08dc46e6183e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jel0L0ZgX12ZvfP7KQl4E6HMUy0iTK7F4SndJJZV+VNuytbN+fdjrsYfqbVRnp0Nm5Wz5DAVL9M0uTZKSsKvzGPUXy4LzTW55sItt7Pqed22nT01KUgTOeO9hh89goFpdmmWqRSZ3OTNQRUVxRHk5s/o5sBndCY/kwtDV0z74Z99UyfGaCiugSUIn1Rzfb//n4R3UmKjyv1gjCDxv6nZxMkkQ/96jt8O5vmEfA1LzJVV6cbD197y42RVR0Uro2NbSfly6wfY88ECx4Jli/zPFqiR3D6qHmPnanO7cfi4yrK2vSWCo7icwAYa2ZZCKzZ81D4pPwVCfWe/h0KnQep1HIRhOWq6+cWaluh/1evI5z5UdDl4ixxUX9ZBJ8NXk8ENeSTs34BmrHQI2P0zHzUrCr5D2txZlhacQZcbsoZfID+eRB1E6iGMpP+xd9wUo65HbeLB5pp/1I9cY4w+gCNICxA7/HfVt8yolTXR0M9i7zf4thCT6REHboYZ0MT/8t1ZHNM1kDtHio7fnf+camkHuQbZWPHfdGeVpFwNK2bc1lg/MORQ2DY3CMHSA0akTudLetgGCUwwE4YuvUbrTpaJ2HqOgGbkSoJ1HcNtaN5f0q5kebR9OEXa4UnuCLCXRrOv8skdH98wUueWgUrXUwQkxbGvTMPIRgwdlHIA9AXjcyGK5xF2eT03lMNV3k27sXXNxhHldgi2UvM7MoA0f415IGtwrBjzNI08Rfsexh7nBPJ1wmP3YO6vZ2lkaSELXMqp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 00:55:24.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c955dee-607a-4250-4471-08dc46e6183e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
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

skip call ras_late_init if ras is not enabled.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7d4a1bc30277..4ea35648fdfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3391,10 +3391,14 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 
 int amdgpu_ras_late_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_block_list *node, *tmp;
 	struct amdgpu_ras_block_object *obj;
 	int r;
 
+	if (!adev->ras_enabled || !con)
+		return 0;
+
 	/* Guest side doesn't need init ras feature */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
-- 
2.34.1

