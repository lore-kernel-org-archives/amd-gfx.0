Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2918CC624D2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD40D10EA67;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q0cmMiJE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4524E10EA64
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E97J+jVZb1NRinBnfsH+mKRCP3Zj3wP1scQsGpRVv8QfwAqtZ7/8cDcKUfyceRAcbyq2I2SbLveKG48NjemuLFNEThvj4ZsiPRD/zJTJ6ckxRQJObWVf5/WvDwJgryl+sS51DPZzBZdA9WO9wae+eHkwdXdEaj/q2NVR+9TASMapnvFbPzxVv/f+dP5/dPh15YLuX1OuVdGtW2llpC3O/dBYif4vBbmPL+O5Ui1r/ncfwjVmUCVoIIqaFW/2Qv6xqFhXBgull2pLzf/KysiMCxvoqtPcV8aYdOWIwCCHxVl+fKEHrwvt8+hkXR/uv4RxoheuMHwiqoITHAxJhjqBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny/Eao3Jfy/fWcCrI8LWwEzQLcXqJWEWOG47NalaC0A=;
 b=TXVLaMaJTjRrXiYJoM1NumJS+mlCSY0r9WdUT7j/Y4APDBlzcZqB/9yTM67AM/P1uXVSOAw3BmuVuaHLzfaV587r9Ke4uAeB6AOmF6i4EOFGLNU09b4lUjhb7cCZt/NUkgvdDrZxMlCSMJEYrZzpcLSWUN9ZL45G4DCyzjij6bx/3l8VudNFMhfJscOpl9u8sfXkoMRz93gQx/qU9/Qep5JshDNOI6kkjfIyrD67GvqGOV9zNvNk/NIem1veGpLC16mk+TFlf0dumWqwBylrYxgI8tpnki8sFHcfHiO2ESJYFIfO9oPjrAtXLJJXsFp4EKsodpBX9793mnRMuqE6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny/Eao3Jfy/fWcCrI8LWwEzQLcXqJWEWOG47NalaC0A=;
 b=Q0cmMiJEVXgIHotif7qrUOjbD7+AwphUHlpmcsmI306yvpgHzOnRPVPHttV+f1NnyAYxxwuLqWCJyVLZXkGCiFXcFhC7vUPMLex98p2xtt/BhSufltpth5wCX5Y10+DsihnvQOs66DSb3Vfgb3VLSt8P+PiGkks9RVYU8UroJcs=
Received: from CH0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:610:75::9)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:51 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::28) by CH0PR04CA0094.outlook.office365.com
 (2603:10b6:610:75::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 53/95] drm/amdgpu: Cleanup imported UALink handles
Date: Mon, 31 Aug 2026 14:27:12 -0400
Message-ID: <20260831182754.1089811-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 9431cf41-35a2-4a2f-8dde-08df078db4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OOthVPvlq3lyV2y+lAfKHVG5jaYGNGKbW00l3UFxRzhrcha2B0LjwB1a5qpm3B6zKxqykje0YpesXYYNcuwtyK+F9tfZNMjLdVybVI/urPG3RUSvJ1jW8oa6wdfO39Z0kwWnqTXCHep8U7q0/2zjWcunrSy+sJ8Vdj8DlexhfzJu7cg7GwGatzfX4gEn178EOWXPWX+DgXkt+f5GMvACf1HhCdAM4r5tjNWe53XG2GUToiVrwpDIwFqPr9Rs32hcJ+6tcc9O0IllwNRVcWP2cWsHuPu1db1BTCY0qA6wx+KHDuG+IHQ+wa6NLoVXygF9aXd0XRh1tfNgyszpG3n26v1cGIotDAD1eicqCBKMtt++0IcAGMVl2mOiHvCP994gnEMDXLJAsG+jokka3yH7ahktmZlwsSAQUSzPBZ7E9lj8kvQrPVba/KqeLhXEYyXGC8bL2orIQKFo/zvlP2y8tHvdfjaz3t3qdOFiCEqrsRnstVUm8VLq4XqAtatHReM6YakI7mx62FonZY4WxAnynQlGTwxT5qhpyp9nYfDrMUmZvA/AMCTZcuPsKVDnwyt1hul0i8eLmjKgiWzBl619qA470IH+zOfQxq8fBeF8mucpAKAWsxmlFIeQJu+31IZP4baeDpARAJ22y+CKRT1bCMoVmUivriqY8vlagAp0a3aXW9JQHzJSNlIJrkPyfM608mZFVXtc+5CFhOZqFAcDGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: esyLwr2uOaMYfS3x5aWnZsK+uePLAgK/je7cbsgXE1vIhdBBLIKCKyPSbUGT8iemBYR2jdz5RPNBD6yy/MU1VjZhCqjOmVcFmHCu8bENmAcNtTIYv4IF1SAefBLnKfornwYTpuLsMbdH0rpJeXpooH42mMrsbXqXtAN+FK4Njk23+PgLooBIQXxULgLWThjP2HIs1/BY+QrrJeZ28IoUesgTSklsXnPbeqvz+MJ4mtitovvYtWup7/6Mf3NQ1JwL1GDcNOs/8lU3xpwfQZ0t7pVdHsg4tQOj7cDi5vrDmO/peO1pDgQAEvq2G+yQeBgmh1X1Cvut8G12EmhHlwWsXLVmiWz1PCSuCeSgmGkFWPozZcHdrpJXKApfVn9iHO8cYM9Gm2OI8XPCz1LkJqP05gvk2YnTYpOYngSXyHnK4/7AjaKRye+KNzQnwPXZJmZ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:51.2048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9431cf41-35a2-4a2f-8dde-08df078db4a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add implementation for cleaning up ualink handles imported
on the importer GPU and the corresponding xarray entries.
This includes cleaning up the NPA BO dmabuf and freeing the
NPA BO.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d87b66d1d51d3..9ece8c71c0627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1283,6 +1283,37 @@ static void amdgpu_ualink_cleanup_exp_xa_node(struct kref *ref)
 
 static void amdgpu_ualink_cleanup_imp_xa_node(struct kref *ref)
 {
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	struct amdgpu_device *adev;
+
+	imp_xa_node = container_of(ref, struct amdgpu_ualink_imp_xa_node,
+				   refcount);
+	adev = imp_xa_node->adev;
+
+	dev_dbg(adev->dev, "IMP-CLEANUP: Remove entry from XA for handle:%llx:%llx\n",
+		imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo);
+
+	/* Remove node from the Xarray */
+	if (!xa_erase(&adev->ualink.imp_xa, imp_xa_node->handle.handle_lo))
+		dev_err(adev->dev, "IMP-CLEANUP: Failed to find entry in XA for handle:%llx:%llx\n",
+			imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo);
+
+	if (imp_xa_node->npa_addr && imp_xa_node->size && imp_xa_node->dmabuf) {
+		dev_dbg(adev->dev,
+			"IMP-CLEANUP: dmabuf free for NPA:%llx handle:%llx:%llx, fc:%lu\n",
+			imp_xa_node->npa_addr, imp_xa_node->handle.handle_hi,
+			imp_xa_node->handle.handle_lo,
+			file_count(imp_xa_node->dmabuf->file));
+		dma_buf_put(imp_xa_node->dmabuf);
+		drm_gem_handle_delete(adev->ualink.client.file,
+				      imp_xa_node->gem_handle);
+
+	}
+
+	dev_dbg(adev->dev, "IMP-CLEANUP: Freeing XA entry for handle:%llx:%llx\n",
+		imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo);
+
+	kfree(imp_xa_node);
 }
 
 static int amdgpu_ualink_exp_xa_entry_get(struct amdgpu_ualink_exp_xa_node *exp_xa_node)
-- 
2.55.0

