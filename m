Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1709606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=acUTXbgP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D10210E203;
	Wed, 21 Oct 2026 15:49:49 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF21B10E31E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 15:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoSR1qJz+rPqEW+SVzFlyi5kY0bxnLVOwEZiZHzOPYxf1KEh/pvxco45Ps/lLV6NooWiQErPYsRo0btFRB7wiV9ETtPh/6pA5mmA58WHkThYhatX/B8oYGujiMnMpWWZPYW2Emi07ho05eiVO/zmggZZ8tNxca3c59Z76LJxCI4qJ75mBrAooCRsOuhMmrWlaa1NFT1xwd3YBligKzxwQbyn3r4MKB5RtLR8lwo/bLI09ArMjYTJXB6xEu0SYIEzSq/bj2LW4E2dwDIf9ti1hQqU5W2x8T3cATGnyBK3rEIxPF2dyPDFIvt7PlbuuayXAMUMOIk5gKeU5504st4wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv5wBhGcnlu9oamaOf/jTkcqtMlc2m4lrFLAbP8aO3s=;
 b=hA3mLyIpFztmEUuTkJXJrK2gMO+TIJcwZbcwJ5sXQrG6mJmy70bKktXdAsrz6ijYMEaBz1zgmAb6xiL+9xhhrAhk398adO3U1ovGVa50xt8JFtlA9V5lgO8w8u2vQpFbqp13cZDiPHrgQak6Px1EK8Bsz74Ix84sgzHUq+YKuLFSthvHpSoiPBsrnb7QkPSnQShiFZWLNTBluo6T6Vzn3mR572ftX3OMZQIyGqk2R4ix5Us0R5Bo8xZLnSnOAihy5ylNFxsVpf9K+gEoNsGl5ToKjsbFvlOhWUWaPGy08KUX/QG3PsjqlKQ3OFJiGkxD9q8wQRGBvyhQ5uwUfJMnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv5wBhGcnlu9oamaOf/jTkcqtMlc2m4lrFLAbP8aO3s=;
 b=acUTXbgPxi8i/+1fU+RnxSAo+wiOsZmGedQSlJQRowLi2ZjDOxOwjZLM65w1NFb4mOliEcClEkqu398zYRoq9oXREmj6dKWlf0xUt3EroUIhJhNy63I89UeEqYxlaF3xnREMYFI2g4D+FtrmD4YDRdRHzpPExm0eEjMcDokT2uA=
Received: from DS7P220CA0123.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::19) by
 LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:49:39 +0000
Received: from CH3PEPF0002457E.namprd04.prod.outlook.com
 (2603:10b6:8:25f:cafe::6a) by DS7P220CA0123.outlook.office365.com
 (2603:10b6:8:25f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 15:49:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457E.mail.protection.outlook.com (10.167.252.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 15:49:38 +0000
Received: from jiahao-li-HP-Elite-SFF-805-G9-Desktop-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 10:49:38 -0500
From: Jiahao Li <Jiahao.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Jiahao Li <Jiahao.Li@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Use RSMU index and data pair in nbio_v6_3_2
 get_pcie_index/data_offset()
Date: Wed, 21 Oct 2026 11:48:56 -0400
Message-ID: <20261021154856.81767-1-Jiahao.Li@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457E:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 579ecd90-d00e-4e41-2a21-08df2f8aea22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: mOIXh4OXPDE1cNpqNOBwl/MhlelFESPtfcRekbzGw9eopbPFa+2kwuwJY0WNvhNWAyVlNuQ/08CHZ1O53PPessBiRX0hgO+yFG+T6uDaNaplkPhXZbmQ0U8i6mtHDFM+qRYwRso2VrNfq9pPB5PeAQtYp44FIaZA3tWJqi1PbkH+zAZkLp9ifZJPM6IA2BltKaDJ4FmOrYvPe1NUhG0TedGfHnSGWtF5bG/c9exykKx83RjpOmeG0MUis2I4HwhnMvPgxjkecG6/kHG2llrZIMRKnQ+YzrD1jJ05brP3CxEFkul2jNLQ9P/jc1mOfgRSSZinL3rDpX+yiixQWwhMV5G0a3c8VU4xa+dlfUnyaM6rewAa1UzCijT5cC9oaxSVsuvcRqvNc5Lu/SlUtHK+R3hgVCVnQn7iauObdHlZItpzNb1OoobWj1Ctfbs728yLVBfkiG25RSPk6CyzdQUXuZRFwIAgExMnOuwpmOBMyzXhKatqdZhWUMyXI2aJk+dy2YsZtk8LF5ohj+d7M4Xz3JREK0GLEicvFbu7gi+diZWNDq+xzV5RVgnc364YgZZ4xJHTmVCUXu12fKFNZdbzldmuNyj64LwRX3u9TXlnhaaeX1bSjpLCRlRxWET4d18/h7C2gq0V/KQY5DVmUQ2XP+x4kiMKdL8TMAdu1qRTP8WfYWy+enlKqTTgYr219Fz/0h6eneMlHIFoMK6cplT5lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4oVfG5HUfb2XEs8cedQSTOtN22L9sb2F2hpHxIqffYjqawOwL5xIVIfFxvVZnilyvPQFXxO94evq6nOtQU/bj5WczmMeJHRxUyVXRxgSrK8eJbGH22Kox9Nl8XusfSTj27OXb5d0q//WTlh8LhVwNDHEgzHZfZVLe58r0gQXMnZNrerJR41CkySILW+9eJ7FQlN6n9XsOVvHhYFv0SzMq9aWESSfQvwtft7mpYF/nmNurWajIXRHTVSYjUHHUN8j7NjnAjNbasus5h1Wv++OKdjLamLC974SHL2R8qHwVXUGPwLm1z7jC1Yy2t5Xl0Nx+RV6PcNyiKQFgYliqLXlw8LPEil8SYV2XgN9Yi6OfyOwbcITnUVEi6+6Zhd7+O4973C2s2L7Q1dXXuAip9B6AfQH4sw7m8HymGzdZBI0a8XIA6Obh7Ocm+iEozpNqN3e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:49:38.9420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579ecd90-d00e-4e41-2a21-08df2f8aea22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

Replace the pcie index and data registers with the RSMU
index and data registers at nbio_v6_3_2's
get_pcie_index/data_offset() function pointers

Register can be accessed from the vf driver via RSMU
during full-access time

Signed-off-by: Jiahao Li <Jiahao.Li@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
index 75477951353d..9a5ccc976e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -79,17 +79,17 @@ nbio_v6_3_2_doorbell_layout = {
 
 static u32 nbio_v6_3_2_get_pcie_index_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
 }
 
 static u32 nbio_v6_3_2_get_pcie_data_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA2);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
 }
 
 static u32 nbio_v6_3_2_get_pcie_index_hi_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2_HI);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX_HI);
 }
 
 static u32 nbio_v6_3_2_get_rev_id(struct amdgpu_device *adev)
-- 
2.43.0

