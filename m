Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B115C98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD23710F6D3;
	Thu, 24 Sep 2026 17:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wznpzJ/w";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2018210F6D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/6UK2wBJ4+RQq7LMK2AMMYgB5RBdcnivpN7Ek/awxgUxUWPvm4N+fORokTkJ52Hn9+xCBNAT8YjYl8O3xYRYlSigFiFO2L4AAl2lRMapPZtYztogF3IBd3s1ytfGGgTn4Ioj31O3DdfnvoyWUEHhGXgw1oElm17SmdtS7n/oWwGj9r7vR/eGBccngvIDQstRzo06W3RMmDnQe6iR432oSYCBWcre0hSB1lOL+i4m4pt+jJfKIdObNDADrnRDDWuN7QCatl+DUt8tuzMq2El0e+omXniNoAfXye/AW5UyAM8GYuCNrSchmXz0rHN8zcgonLocO5iSNLInHS5XmBbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwyiJeiNSfQmucZD+woMRaNgmWeIecJKbDwHJDaQ8vs=;
 b=zRfaskHTE/Eqck9i1IYWA+4wEs0Q92B4BncIPJ6OyMnFCJ36DaB4cic6CfOVtWQshzWgibeQHyq2TZLRJTU3KDjROEanouTNPRZWqgjTTOWnhVcah2aTRnBY9yw1DmTf+F1qQOgiDxIPKKVQbyA9Z8QeRt6OT6yE5ZWqYgO42S3OL1K0IwCqIrD2f/iBTXIfwHBs8vEkXzQ6/gywsLV2a+kuKpqYaWVKqBTbr7UmXJc2mtl2oYc5GOOXD3HKFjXC1bETy7FL+utA/xIFzS2vqLHWjr9YRH7XWs2XakkXHRMLBq703k4JBVD3E+RgmRcJs7Lfblh1AacT/WKIER3e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwyiJeiNSfQmucZD+woMRaNgmWeIecJKbDwHJDaQ8vs=;
 b=wznpzJ/w5JZp/Qa71cZtkgwEhQQqfrdqFF2Rdb/L3yfZxYSza+tX+IF3f/tom1paExNNoVKN8FvI5DQWyT3eXy17ofqdY3Koq0ieudCUh/llQc4t46Rs3bE3ixPT3mmoFyq9w6VCFjE/LJsYc7LqYh2qJeuBVvvOpWu3uWXjrgA=
Received: from BN9PR03CA0243.namprd03.prod.outlook.com (2603:10b6:408:ff::8)
 by EA3PR12MB828978.namprd12.prod.outlook.com (2603:10b6:303:308::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:55:09 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::89) by BN9PR03CA0243.outlook.office365.com
 (2603:10b6:408:ff::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Thu,
 24 Sep 2026 17:55:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:55:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:55:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/ras: add support for nbio v7_10_0
Date: Thu, 24 Sep 2026 13:54:41 -0400
Message-ID: <20260924175443.636193-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924175443.636193-1-alexander.deucher@amd.com>
References: <20260924175443.636193-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|EA3PR12MB828978:EE_
X-MS-Office365-Filtering-Correlation-Id: ba225228-e187-45e2-1e1b-08df1a64f8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BVlSMmbkUfdIHH8R9LgBTbOxBwQ1/3EqzlhR9h3m9/HPHhYbN9/KFR5DtI/sIOkYvbDMOu321qo7Jdd3s9Z77qlM0fEFwCMjQLbS1byK2022LhCLIsie0w7s6hV66Kbl/ow3CotG9a5T79uoY5Eu6dd83C6mnpLmPOEdEidehIae6T522sP75Mr5Zq6KlURUxSM5ubFxCygQAVNbQxwGqfvMuDhHV+O+vjgNEHRtzVHvpPjEPfNo2NIrPW+2VGeR8X/8PDXmJhP4kj7hvc9TYzdz09l33MHdz4BG11MeRfW7RwbpwMHkRs/Y8Fm+LJrpcXNZUpkqOko5FhJBhHTXkkM9xbbv10tZkpCgX7GlV+zDWI2xFOwJReqNSFY5Z48OzgcTmSY3VF1EZ6QWNG5N3RWjDSKocRbvIoGglMgOqPSgwb0/Kf7WKvpJY75SWLYO6+6QF3waQI8jh98l5Hht2xWY0Ky+34kYpRzccPFJgAjMp9jk0wM05a3+vsxsOKLwTHwduvsk/A2ihIb0BbHaRblyDZtRsTReu5Tv2a5CkcIfJdL0TbNmc8eEM3iaUvFkhG7jeHeDLu9FvAna7AfZ9HDYzhL0uPkG/5vOyIQbCKUJR6pypkUpyvgrdlXRzadWfOirp18zFYivNv1E3QNMAfoKAJCfd60NQ6lpqiVKC+gEbNTsR7gSWjIJvOKBtrws7ltdwpuHy4BAJl5NMgZb5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nisbJ9Mt6ouav0WruNyJyCnULc022oCB7FaSiqRCYmt6jxDslyro0uSRzve/ypK/rkWiuBrjckfusGRv8zR0asLu/rTI79Qxf3YWqR/zs5bV2CJs2QtgWyoHvUvqPp9hbfHcAnmIwjyObaHzCLI3TOu/yenDknjuvNQQgvTo3nAk8OHdljYodJFitDldSHdE8OFpZrr1j0BGYokNz52F0Xh+vAA9mrONw7xpFSEAt+cMjRyvHFgrxiAmwGlYD9T/RTzx+rrO9lW6xllZyF84xUbtABH6zzolLuXarTCn1fpQIz2K2bjVd/9wD3sbk9tsnH/Gb20elvHB8mi+l4icWB/GahjHdS1GvxB6Xg3Tx+tEBfxRK60JrOD/cD/fx+en1f9PH9N4C32hdL6u/nj00shf8qJK5E38BVfdTnBLs8tLe9tKP0q1Vim7iUPAvRnt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:55:08.2421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba225228-e187-45e2-1e1b-08df1a64f8c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB828978
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

From: Gangliang Xie <ganglxie@amd.com>

add uniras support for nbio v7_10_0

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_nbio.c          | 3 +++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_nbio.c b/drivers/gpu/drm/amd/ras/core/ras_nbio.c
index ca543b2f36791..b69ddb16ed0f9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_nbio.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_nbio.c
@@ -36,6 +36,9 @@ static const struct ras_nbio_ip_func *ras_nbio_get_ip_funcs(
 	case IP_VERSION(6, 3, 2):
 		/* TBD for dGPU */
 		break;
+	case IP_VERSION(7, 10, 0):
+		/* TBD for dGPU */
+		break;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"NBIO ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 8633bd56401d2..701b696a7836a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -193,6 +193,9 @@ static int amdgpu_ras_mgr_init_nbio_config(struct amdgpu_device *adev,
 	case IP_VERSION(6, 3, 2):
 		//TBD for dGPU
 		break;
+	case IP_VERSION(7, 10, 0):
+		//TBD for dGPU
+		break;
 	default:
 		RAS_DEV_ERR(adev,
 			"The nbio(0x%x) ras config is not right!\n",
-- 
2.55.0

