Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094BAC5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E7110E59E;
	Mon, 24 Aug 2026 22:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mF5rUCcW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E7C10E59B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR1xm9rRoBg7Dl4N6z7Nciw0YFCdWNZl4ISgeUMWLAICpYrbjH49dOp0W90r14iE/PJTcMITpD57M9CHKEXa1GRoz2X/ZbTFCvEMuQvnmAwOx6Ugy+weHpvCIqVTBB0fAz+LI6HiIb/3m4jItpPCW3iihTkjcgJSjxE3VaNddhCMoQIa1dfcpH9cwLIAAoGuDWbpI3Dk+/n5LGRkw2CBxtyyVMlN/gxBHavMH8afxmKOalmT9vNCLIdB+FOtBQqKmDinv9fjAZHlzb+jxXtV7h6d/X9ftWLWFMYGolKhzpoxToF+UiqjjuUxNPDZvlWpakAvR5vNkYuDBmm8KjuKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDShDBroQFSutHCtU4+tU7bqcY0hHQdMb0BJ3fS+jmo=;
 b=rR4x05O8oCPE3stomoC5w9eDIJrMyk5ixmSyWyY+eSlwB9ZrZGgKh5BKK46VgxY6eX48jxXZ80RSNP9SmzH1Xlscwu5bF4ScwAHxGTop3YSbTtjdS6rC422BjcDSO4e0dwpMpQlh3SzjBA0aE3o5J1snDKZh3gRqjLrcO0KlcRW3Q/k9wfsrRUEXwZvSIy2N4k3S8MOPfd4GjJSueRH02PmGvEEyVeMQHCpyVI30E6yq0+tRinLp/aJpL4pWQMvMXZJ/BhrKAAJtSn3BdJEXOfrib8Cy2ddsYCYCp85GGV6lV5Rkl+o4e9WAL74QsEK2DaGIUyOrJm1/szgayUoziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDShDBroQFSutHCtU4+tU7bqcY0hHQdMb0BJ3fS+jmo=;
 b=mF5rUCcWuLWRzLhbgQpVZcjPeNFGaGxE/DnQIJ3bNESTqteK6wTurqy7/eOv0teFxWOkiQC1MLUfLN/l+HeUwkVN7U/wJ6tRZ5AFSyLOWU343FUQz606hIqwkaGvO5R/oiD6tmyvmg7X9UpgkTEwD38sRUOcAzW7NjRMcxy6EZg=
Received: from MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:07 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::53) by MN2PR16CA0064.outlook.office365.com
 (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/30] drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
Date: Mon, 24 Aug 2026 18:13:25 -0400
Message-ID: <20260824221352.1793542-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: e42f100f-6424-4357-d414-08df022d03e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kPIrlZpxlju7meqHqg/zv+oryyk68GiRKJqzh+sqoM2v3OirWkfW/KUZSo2rFbkQWl170vRD02Q2iqBGF4Gru/6vHIw1F+s0+SoLieuTJv2GPCwiR7W6b6vbJUaSa/lC0DAn4E+q85eWsXzN6/xrJRkoHERZlHfVnk8utTrNAIjY6yYLop7i/kM030TmmW5HpPrqh8HJdc67qZ8gACDOEJetZSjIkK6R2iFpBLtch/TuIjPSRMsPPwv3lPLa2t5CePoXMxhCPeA5dTZNQ1DBtSI9E9jaCNWWVm4dEJCnR3TqNYzEb90Z3HWmUJxF10Ait0f3nvZ4fT/ELxmNOtPbONDl1gLbOygJLxS1OMkj0XxItmqI+w6Tq0orod18gNJ0lOEJKs7sU/MZg8rQfURNjkYoAHm6DIMyhj8u5XiShpdzL8nJWUP/I3kVE5S9L7wBW9CQ36e/hRzDmLTxAJA+Fa6Kec9bbCoN5Qd9zi+IS5gwb/uGPcb22Q7TDSUo3UoKubuOaeoN3EAlawylJFmmDxEysrkWqc4JL0YA8JIVun+0b1cgNfFeC6WAsuBiBhex5mZUEGvG7qwluFckGdqHl2NverPyblyF1YCrePdsX+C00PZTnj9uNhKxRbkEMo2IGaJ0Llxjy4sjd5biHJsjv4pG0zv4U35sjBxtA9vu2ASAvI28e/vzPknUf1c+SnxV3toDxJUcKEHpWBoGjkz+Ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qkfelSRRcEmPRMwbQsXM0SGIX7GN5Hnl9SX4wR+Y2mbPk2MHztjTOvlFiBS+15bwktlyJuxwu7Rr2Ioyz6+YlGP+byfKTTYNUvY3LLLxAZ0Bk3KI+VTv2s3xIafvSG4ScObbTUM6NvZML0kAt0E32SMImIZ4mJg9QnmZaqCF1dRsgu8GmN61khUPKgJX87+c9aODMfxUTyDokhV3nhfgeJylWX9bCyw/4XurYyeU0EhZcxIc+bYoQzo6tIXwmE16xRxXaXz9/1XmJVdiKsxSIbeDKqGPpBFKZtsCbraxT5VlA6ugoVsqQLvIjWT1AAi+8pAbianDhBBW6K8BCiNjcPbYx8ZwEjaCvOYraxxbwFdbr2txg1lLQnF58PHd4kCafBnWoIoOni3gL0qoiXNTNH7MeJOAp2o3JPQDJuOJgPDUvB0n/zlnZLF+/ylZQfRb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:07.1716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e42f100f-6424-4357-d414-08df022d03e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f454aff831b03..41ebc6ae182cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -253,6 +253,10 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -306,6 +310,9 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (i >= adev->usec_timeout)
 		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
 }
-- 
2.55.0

