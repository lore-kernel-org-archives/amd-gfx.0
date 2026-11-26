Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675A606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I5t/f1+2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C42112229;
	Thu, 26 Nov 2026 09:35:13 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F46112233
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMIqCD1S0RFQDXs6rQIqJXflD0l1aNFpd8Ht/cCnpYfgL5rph7NilSMmym2VebWdd2Qg6wESqwWLY9GdXvuQ2T8bzkM2YHGjvwomEL5wXaXLaybNfKMpdCpmb1DfG34Em1Hi3NCupVxWtq3GdwCT1XnwwzNioOBA40Qx/YSV20VF5qgL1XWr2xV3gHjLKS31iiVXnGbOV8FfpGMYjrLIlOmYJuGwrfQMH/eV9I+Ut+Wm55Ihu8TQCu5A4TNTq5mdYNCl8ZfUJAr1q5ryUIAy9y3nE0Ba0HalKWBsYLzdYPKydIwn15hpYk0nyP9MY0FdGPyPGQsyTODqe6mIksX0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9U1BRqw/vc7lDx8um5zUVwykkuN9xl2Gt70/UXBdXk=;
 b=aS3iTVFxR2aAXazIJuyrxI8vY+lTXtSsJS2VHj93JZhaxG7t744hBGZdtSoCTZAV/uDfApS1IIIDJ0vaeC1GcDD0gKsfgAgp9XdPfX0rpA6BgpOcGgSDrOckz/LVCOxMnyGuELJoBh4htWgRuUjOJMXrv9XeY6nMmJfIzgMnTdB+qxi2wD40/le1SfvuR4Ml8fUPa3CgcYTirdMkjGVhOr7jAc6ppn7oVdnQ0cE2+qaJ6hdQAJ6OHhBFj+Z2sRZQadX814tUfscc5WgQ7TWzZYQD1h1PVnPip1niAg+rxJXKkwVhqrKiSDAtc8buWbZNZ/3pxxFmS17mfSpYzTf+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9U1BRqw/vc7lDx8um5zUVwykkuN9xl2Gt70/UXBdXk=;
 b=I5t/f1+2S4jLAG24X1TyiwNqcJ5BMe9RIy9X0HEGZFQfP7PHI4eXQ9k5dSIfT92XWOWY+lBu+xwdvOCwTHW9V/9QQUv+5HA3Auw2CH/Ia6FeqafVBtjUV8Prq6vzyMaYpD7gLmAE47OPfSDdQNigbmp3Vmo8nLjF9inXaxyakE8=
Received: from DS7PR03CA0192.namprd03.prod.outlook.com (2603:10b6:5:3b6::17)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:59 +0000
Received: from CH7PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::99) by DS7PR03CA0192.outlook.office365.com
 (2603:10b6:5:3b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF00000017.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 26 Nov 2026 09:34:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:58 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:56 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 14/15] drm/amdgpu/gfx12: enable the gfx engine soft reset
Date: Thu, 26 Nov 2026 17:33:50 +0800
Message-ID: <20261126093417.192538-14-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000017:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea3ab68-8c14-4dda-4ae3-08df4ba089df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Di9vmwUwBYguHiCoh9HhBTkbLCM7DLMz0EznwHVZw2d9KYJXY5Y/Noxk3Ye3xdaAsCEJ05/hqJ0Yh15XtMSNPEylf/LpEROHTaO5rEDf4EwIEiIf6OQffJEpTufpMSXQUsBrGL8GdSvc8Xvf8tgDaZJLS0xZGgkbk9cXiskVZGej5zNX77PPq575GczwVvdIhWn07nYPC8M++IueEUPnDWKcbs63MFq8wmvoxLxFxARNJMmCk0WMhtQiX+3imgJOi4VQIDQ+/BgZvXC3xpRKv6HsYqrL3DSXCv/HuRF98iWeewQCFqO/HfxoZD41OS0FrJvOPEHvWTUUuC5hU+QZFQ8Yz7I/slCeQbTXFdSB3OQO0FO/PpG8cM+dUiHmm26FLulM+2sZJJb/HevpFg1yEu8dALIkQxVb+Awa/MXrA4uRXHAconqPZKtv0J2Kpn8XctTDGToiVEJlFQAeNUkwoFe+lh8wAJVsoXXywZZpKyfmkvpmBCN+KEY+AfmQ8Qow9OphzFp/V1buSlN31UxMUvYulGqwjhCy7fGNB8hY7B3O3OZ+661zsCN8yd8FPxxTF0ZNut2CnhR1XWp7vfYs9fEWkrKJrvAAXE4uAwMHCqt8YCfYkL1KifiwtzGF4Gz3n4X1aC1ZQd+wAqIM3dk8VMwm5HQQYmHdATUtoGwLIH3FMVVB5tdbv38D1/uauQmAZCjDcOs77Y3bL/AvkJ+wcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XsPXrSGvfR7UPKeJZrVB0207hOvIQWenCqqtptdfwFXVMObPlxR3IEivKfOcqplvGhKADR6csjMSzDInbjtJONdYY4fmz4rnbe0I1lFLz5w+5mkw6xIblnPeIwPiCYsoOgSYlJFDSwag63LhyrPdw9AvpQuE0GuhH9/7NWHzb0fH+DCIIB5YIihlMs398he5wOE03UBWHPX+zQ73P1bhei9iF91i60VAQn7dcoArE/xNC+WGqjOLLwoUMLS5QhSRMintJXV+dULvIwPjllSk7W6yYJmXvhuyCWSrqPUiflBLb8CZQbW2t7clYgSkEW0LjRA3e76cn44lTWgl7GKY8V6QlUEuLwKfHP16KmsWYybGULGC4YLdqdJlV5LDhDKEYx6jJ9E2fK57ByvLl/vemyaW3NM7xr6N/Kj1r+iQqm4aHdDDRSUsV7baGneu9vBD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:58.9319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea3ab68-8c14-4dda-4ae3-08df4ba089df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings with MES,
which the reset uses to map the kernel gfx queue again. Not on SR-IOV
VFs.

The kernel gfx queue and gfx user queue resets then fall back to a soft
reset of the gfx engine before a full reset.

v4: The soft_reset_engine() callback is set by the patch that adds it.
    No async gfx ring check: they are always used now.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8485d1aabf3b..4b947f9416c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1601,6 +1601,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	if (!amdgpu_sriov_vf(adev) && adev->enable_mes &&
+	    !adev->debug_disable_ip_block_soft_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
 		if (r) {
-- 
2.50.1

