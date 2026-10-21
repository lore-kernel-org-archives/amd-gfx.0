Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B02606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qvrmb5Cu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3E810FD6C;
	Wed, 21 Oct 2026 11:09:56 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2428410FD6D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzV4mBLtToqdZ4kkvVCcH2zhDPjVxs9k7HrUYIhOWxMK6mgrf0lLXQc1/r06pbOBRJfHB4h5PJLG9DSyUfhpZrZXsi9T9lU+WeYBFgANKsfoy7R0pQiBDu+ZnaFXfYqoxxksS2+gmKRo5HhP1csvyiw7I2O3cbEmc2WBRAxVBQa6Yzm4Pj4s8IhSXf6Ph2hY6KVWo5W7+TjXJQrwoDb2vhxNAX255r5+mTe23/+Sa+3xOOeOo4EEnN3a5wN0xTUz8h+YD8pSw/Wbvi0nk7Nf205kAN2P+E/TJb5dbnRok+WHs+oy+siqXCfx5ycX8cLDxIF5mhzh5lCBRCZeta9R+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKDFBWjl/FGXvEtUaL1l1nlRHtLAkdEFWEDKFzPFV9s=;
 b=shy9s+cKLItlOuEsWS6SdisCLXnStnL+dRevkcltBYXfTnmlGzMHG2TuXDAabMZuzZVRX2e1st3AqhtxiCE7g51y0w9Lvp9JeRsYzt7QOsRzLboePMtD5ofvHEsGkJVbTvMtvDKUEqP27nz+WEUJmBEDVnTqbREVrHXjCM4j5ad0/E4sbfcYNCs/vVAH3Cait3ylBmzTq5G2FQt60udjzP6bDub6anbb1HiYmLTjQ4TGSwciShUBxSGH61KSwhG+/oaz315m3YRFdgueSZeCn8bpmU+G0zjRcqC1X7vxWrVA94w0UYla17CLRrXxvblN9qEUCnkmodURmLLi2mid2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKDFBWjl/FGXvEtUaL1l1nlRHtLAkdEFWEDKFzPFV9s=;
 b=Qvrmb5CuJ9ehfW+DsiztfOsLoYMaIbCcerU7PKJRdT4Sv65xm7NA4omB5fGmsnppBnQwoS3yijPpdh2EnS+Sl5EKtz5PUlUtwXeTXdMt/q4Hzx00MXRlZuYtaiWf5b+73BAhDXJ8kXpUImgZim8v/EHYKNkGugJUfz9mS//wrlg=
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Wed, 21 Oct
 2026 11:09:44 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::c) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 11:09:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:43 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:41 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 10/12] drm/amdgpu: GFX12.1: set mqd->perfcount from mqd_prop
Date: Wed, 21 Oct 2026 19:10:01 +0800
Message-ID: <20261021111003.3371005-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: bb02f125-5848-4985-3ffb-08df2f63cf75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: BOfuRpGIDavamCZnklHtRxbJEab7h1ww4bFnh5H/pzff6iXhXpKuBsjBGxMzA0B/tRaDMfLqnLyAzoJ7QncpSE8qdE2gn0/egF3aPo5hdHCsNvl6Acr20c6+gxiHPYyBlOFZvqEFjQ9D2FShce2dBlEncet1VY9ejkBx4BolqzqkBZnUpGMbfGz2saGgv5Cy0XPJNi+z5h9Y4FTAbGV0yTSUVyRYdRwctTxqXbq13FbE8fmdunnjSzY+eLWwZwFbyZsmBlbIR3omQUU0l3jPmye0I8qhtaPU+CMH/Fu4nVn6+70nfNKj/O2XbBBNv+cq4mJAqYR5Z/uVPs9PaliHhhm/HSapsiW9l/XF6I0agCff66cXHIB8POxR4dFeYjFtjJruMXSzRVp6u2jZ5BG4hAIdqMmey4fqWAkGiDSBJqvKD/A1fMa9SMzJbE/PncX6o0ou5CPBOY0A4jXFeYR5ZWAUtHI1k2ARDkTx9XfHE3xtMa33+hu9ux00qbBmwBg5Fz6rW59XbTeVKtRXhpuEV2a1bSv8Rj0zzLVOLGiXcbKb+S/xlqPlTc7aT1zbEHJ1DvuVzLHn96SkyqfmDdvFZeeuPd2A+s9GHFnIXGcj+XxO2v7S5yO5LFAYmTJ47Fig0rAVZeoT9KtafnfsTMmKI8uD8a4Als7W/MB/W4mz29wtN9lD0wdHqFNoUDUjat1+uRXnuAYC833aZ3DbCqyfQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cl1MnVEiHsb1Au0X9LZsHhDs5nA58Rm1glP4cnOdxEkqGtqOgJDvPYJp+0SAnHLKvDKloc1ykabKDnb5WKNqKyKAESFf7KpPYxol1f8TDmsoTdsSOmyjsb1h/cO6wvj9oEEZs3J2YHNmPYcmA490byToc9CrSvoCXweuNCDCxvFfWAZzXhiFpSMNBi2xVv421XElIrzpScj2C9YiqCxeXLy/HIb1rTpDvpp8z673w0Idcvrg4EW/kYuOrJasEfJXs7+GwAibFq2re5nCdjJd8YkIe4gFyHHUDUzsb2PkCON/1ZjI3CloasnC+iFwe+cMdRNgblyRHd6fg26yYir4de7coTpiOlE0U6X1cHbxi1ozHv3R4U5W4F2BUzOhMugibADmamVRh5Z9JSgNi8H7W4I68yWqIISqWK9+bUAHLDoAG/lm3UojLVmbN/prExtu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:43.8305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb02f125-5848-4985-3ffb-08df2f63cf75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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

This commit implements amdgpu_mqd->set_mqd_perfcount
for GFX12.1, which helps setting mqd->compute_perfcount_enable
from amdgpu_mqd_prop->perfcount_enable.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b19a4956c222..ab70a77cfffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2170,6 +2170,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
@@ -2298,6 +2299,14 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static void gfx_v12_1_compute_mqd_set_perfcount(void *m,
+						struct amdgpu_mqd_prop *prop)
+{
+	struct v12_1_compute_mqd *mqd = m;
+
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
+}
+
 static int gfx_v12_1_xcc_kiq_init_register(struct amdgpu_ring *ring,
 					   int xcc_id)
 {
@@ -4041,6 +4050,8 @@ static void gfx_v12_1_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_1_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_1_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
+		gfx_v12_1_compute_mqd_set_perfcount;
 }
 
 static void gfx_v12_1_set_user_cu_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.53.0

