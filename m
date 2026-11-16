Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774E606A88A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w7anhWrY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCED10E323;
	Mon, 16 Nov 2026 19:11:02 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010000.outbound.protection.outlook.com
 [52.101.193.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDAC10E323
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaCUBB1nYv2i9QXj3nH8jdoLn8xPOxasnzUtYdxj39NRmrzoTDZw7h7Ev8bj6VI/7W63w6FESvmTZO9Px6H5Caxy1LV3j2b1t+TZgcexoT28rZkgdWpjHSXSof+tRerKWo7RJd07q9kCeC+hVyHUNdPB4NYBbOruNR7HYd2bA14usKYJ98BfGcMpEx7cnxqrVr9dk5yyjliVzPcsWlz2LeOZ2jXgd7GnsPC1xgiksaJfkfC9zWJZYtUeQVmm0dFu42ms5GnY/pZy5Ie/QHmhuFjhyrst8EENK557olYhUQ63cuGfg0A9w5/o2VkVqzeI+DEo1m5MWO4YIFpOfBDWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyIuO+l59Z6SN8mZ6mWO/XtoEl4A4+EkVxBIvWlPwhI=;
 b=VgBNDIOsgpzkveGI7aO3cueVoNKTWDLrRPhwlpnjSjZ8eTB0hYHy2WO3oGXFxZSflKPzGm5KV/vXhfZ4jFsNxXHsNjPwUdKKrIj9XpuNEb5dhIc8jxiV/o5v0iRB3P3pYsVH2Pk4T695AOhiKAipXM1emQ3t/z+2O6HoRAoFR7ankFzxTFcQyOgBfmbCPcOIn/rL4b7Y0kTumSPxQWYfCegQjCRPgsDStiuYpt6nW4cVxIjvuJOECC90GqIPdT3+Qe4G8N0btDqDVQCjIMg8vCNySH7oZtVUBw2W3MeAZMVBUkLjb8AFLTXGI2fUWqsI+EBCpSdOzX4eAnItk3CHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyIuO+l59Z6SN8mZ6mWO/XtoEl4A4+EkVxBIvWlPwhI=;
 b=w7anhWrYGDyl7MXU0EBNdFx/jVDqr7afcp8MoVtN3M2S4z+ICuf2x2dMTmu7dxWklJTJCV37SdEL9tpSH2Ojy6M0WLhPd/urdWasePv+DCk2iN/bgXsN1UfOmcj9XMIZT8WYW50Mdp/GrT3OxNi0lvs7eexJ9OE4/c/wTcLMeyQ=
Received: from BYAPR21CA0012.namprd21.prod.outlook.com (2603:10b6:a03:114::22)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 19:10:36 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::e) by BYAPR21CA0012.outlook.office365.com
 (2603:10b6:a03:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Mon, 16
 Nov 2026 19:10:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:10:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:10:35 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 13:10:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5 v2] drm/amdgpu/gfx9.4.3: program the RLC SPM in RLC resume
Date: Mon, 16 Nov 2026 14:10:22 -0500
Message-ID: <20261116191022.1955106-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 97366a81-3fea-4b2a-bc57-08df44154b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|11063799006|56012099006|10067099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: pXC2jzARXh/+H2dUJhd7Lds3pG9yUprv1dLXu/wltN7+8PpHA/6/Q9s6yiZBsqYjGlV9dfTaPaPG3Re2RIglXM2fD3w6ii63TejUrBL3U2nzNjUtf2zYgIdWL+DU/SQ8pyBowdvjgfmn9TncYqQT1KYITO0A0UX8lXgRwiZDUPG3bmZRAkinTwuR1xMrAT3vYyRiR3zQRDR4mKtOhy9ehsX6qobeKGvP/2oTyA4VnTZ658EYw/gkiU6JiO9N3o9OvboU50YK28TL7OqQPMbxwQJRJ1F8xIq+jZ72d5rqukupsQ02z8yVCPExUb5lVZpTv4hAgMVwKxgxItT2S1XQThHhycPhIb/KfJw/1n8n1WpAAmdjL4VGoMozH6/upXHaLoG/TSzP7y8p0z1RQ+ozbbUEE+QkQVvqDRmj8JcLVhxYouVwJFr4Bm9rRinN0X2MudQBlRbqh9BGE4QfYh7iFDVQEpnE/Uqxftl4nU+kgqIERisvOW3FEcJNMXXOVcuCqonD9pCjRbOkrB7lV+9eidSLj0T52wuoMqda/YMtoL1+aUxarW8pfJcDFHmAOd5csThjPSXckPWf8WRJIO8hCLZBiJt4B9OsDHWUTENEWoa2+uuNRPxsv+3/q7V9ynHCBOo/2qmuqauKi+SadX+2bJZmRnAruJuSFudSiFHsFSCK9qe+wuzOh6Woj2aXXIkVJESVMf5gJEemVY+x/PkP0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iGcViHmGSPREhmdKiB34aix9XtqgB+K3opIahYTiA8OYXtbpOZRN3xUeY745EVFqIxjLqbfFoYoNDmYtQ/TynBrBtk+mnUM74rPrduxkTEYBNqGfNcFAYWN4ootzIj+oV0bgiKaYan3H/A9bSyve5lAG5JQ1OJ4xYEfCOuJh26mkkapF27nYYjVpCfdHAnpEbvRvXuUw/692C/+1lr0xwpM6Bsw+Uinp7S6xFneFPope+m3PG+B21EMxrnZH6lvBolM2dHP4NfzuDSzo8cALW12LahEMfNFazgdDcSDrLqVWmq5rv8IshXwSQ3yArnKFyb6HiD2pkd7ke/NXMO0joZ/hRVHlgZUbvbUypjpIB0SsU2okG49M3xVujDtiowv2CeeMfLmkn+rBvR68Q+UggTJspWfVpNwyvPVPIAzgSPa9EF+l8iYI28A3WSeCk/bj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:10:35.4786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97366a81-3fea-4b2a-bc57-08df44154b23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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

The register needs to be reprogrammed after a suspend and resume
or a GPU reset so program it in rlc_resume rather than rlc_init.

v2: pass xcc_id when calling

Fixes: 7c0f7ee00c7d ("drm/amdgpu: add gc v9_4_3 rlc_funcs implementation")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index da031caa4e9e6..7b8ff043c99ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
-
 	return 0;
 }
 
@@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
 	gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, adev->vm_manager.spm_vmid);
+
 	return 0;
 }
 
-- 
2.56.1

