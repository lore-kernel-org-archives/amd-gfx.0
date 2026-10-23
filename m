Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84377606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dv3YzpvB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E68112A3B;
	Fri, 23 Oct 2026 09:09:05 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC7B112A3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plUKCOcZ9foB9YvVcUDXOBscfrs6vEnph3uiM68OlXbt8JfTMRAnxConOeUTmlz988FbBO0KrFCN1ai/02rOBLITgfjeHIxxP72x5mY0wcPrGaMIY0iiJNYRSDu6UMD8RQFTR9C913c4dewnkxMrD+js9/RhIN3WZLjbsXnKTY9yCCGjXGWzraiTGkFIsP8NNFZIptUBn5RRX84FotMj2WZ7FhDefi1SGoiY1/sJIeP/xl78zjavsSHMuENkzzE0YixIS7jQNrmSnQSqgHqXVHEhCwP8mb8CO5KDEAqI+p7B88AAuwUFP9op7VkU6y/dsKPMwutTO/C1sUGywaODlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2L6sGFSGPH000kJwngNZfCe7pIXtZ/bufyKJW5bfLY=;
 b=C/MQUuIGYLWO8UIxaDIDFv/Zq01WNsyeIknaJL0jwSPABzrPl23jVC4VjonQ6a08BCN8Xx0avT+1lJpL95qMI/PBF7s05GIGyQ0ZWvEyubhlyXW8ei5PLiCexq4vrperTlRdiqw/TyMqZwWKR7aZA5htgWEcxGoarjch9eo78wdrhGZkBZFRj83T+yBjARRJtbjv37m+QXpax6lXII4Ym/U2Vwb9ot2yUO0Az1p0yjy1vWUYMeY13NXIb+EUMFrqAgujRpqWuV58LJeptGgWtfuyC0PKO4Re6UNsYVZsMGvBGg5hb55vACp/xsqr4DQtje9g0bG37kImos2U47pbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2L6sGFSGPH000kJwngNZfCe7pIXtZ/bufyKJW5bfLY=;
 b=dv3YzpvBu9aRzJOLbRqwetpUJlkklMUsmWMW+eL7s4SpqBwfewfjBMSFs/Yj6pYxRqoiltveNIeM1XHD6MGy5hDOiF5T3pmXnuM+pDs/gJMmz3N/i3OXoS13KrhE5kDxi9fjY4RekW6HJtyUpq6E9Z/h838AyzAM8Y68Ku+DSUY=
Received: from MN0P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::24)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 23 Oct
 2026 09:08:53 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::8d) by MN0P223CA0027.outlook.office365.com
 (2603:10b6:208:52b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:08:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:53 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:50 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 07/13] drm/amdgpu/gfx12: set mqd->perfcount from mqd_prop
Date: Fri, 23 Oct 2026 17:08:39 +0800
Message-ID: <20261023090845.670581-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: cf43bd43-b518-4752-ebdc-08df30e54285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: c2OyVoK9VkVTVHvYFgwjxmyj+iGpBH8BjL8yHk4YGmGd7QqUY25+h5+Hf2IswxZzFOTmShVviXOFkuKkBMGzi0/jPImNOJdgcVmub+7I6IqcaQkr/kAzkkGM8DZUk7USOY5YXROcZfyK4YucZ8c6AxaZfoolFAR+usVZBTxndqJVBF0nsBpzuoiTlBrb+0U1D7y9pGQi/IsEaauFX2f47uBck81/6DngceVeHJccH8wMeIusoQCW/fspztmhdO2q2M91z2K5E9nIfVgrVpkkS0vg8N1bsqzVVSHxBOknZkuL/pVHuJglPvWuGGQ1H9SrZQLZxU4SlucTfQCorp4TcwhIcqC4d7MMFVdG20c3Pm5MAHzO84+3KL49lOQyhk63BQ10IIsU3BlcTXLNbYtWkcwiXXhDf6N/imGCRtwf0+qncGJ3O7p8Bg/KK8pTRz0OZBu6YS83vJ+OZek68aZcvxwprg/LouoIDmzs6cXC0LkEA/F2DI6hqcD68CrArdYe3ZbYHdoR86e+fTGc8G+f68QT4k3LnqvTlbYe2u2FZftE26gSgSDPA6gKrGfKU8cPB19roOJ7uOB5QJ3+r5MUcISRPDnbd+31YV+1C7BAaem0/gLIZM+ud72RANVghb0QDstsmSyarY6XfSqu6Uba31foTo3lYZoWhG+48g6ZDlISJfufxtbHSaoKAEisbcYeeigUBsptEoNAzOiH+v+hLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sFoNuO+6UwHCLwQeZG0/RraRaiNuyEp9hE2xC9q+Cwp1fiPAk+/1R4TKECKC8oiGgKAizhvIXqvEhQ6aRdGNvao5qsmbQnpCWueuY8ojK3K6Dg76zq0raq+IIMUawdwwPziP1rtPMTFe/3VBeT5Jc0P+1vljOJmYgpoqKEUcbk3GTsLaU/KmfHnyACo9yCGHRfUWYZ5MHpmPBuZvZkhjKh4XP6QATzzkhS+GP5EQlQiAj/Nd4LwSD+v1r2VugWdpZzuDyZ4oanqu/Llo7aa70OYhZMXc2vEroahwEujxYpJTE51dbm37wfd1Pur8gISYdk3S2xhHCo52DwapW1B8E4xgaXTl/K0M5/TjKfyOEaEv+jqyBVYMGXgYndQqXLZsQRkDZbI8yzszYjq5SP1IcEYYL3BfHtEkqaYoY6efHWEZ/7Ck00b6Hrfhb1/wHpT5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:53.1178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf43bd43-b518-4752-ebdc-08df30e54285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit sets GFX12 mqd->compute_perfcount_enable
from a given amdgpu_mqd_prop

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 398e9c463ec6..655b1784860d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3163,6 +3163,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
-- 
2.53.0

