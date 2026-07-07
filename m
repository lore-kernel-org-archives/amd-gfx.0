Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67037C44502
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93B510EE21;
	Tue,  7 Jul 2026 15:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2INH7ft";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710DA10EE09
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xkcp4PQcF+fi7Wt/nb+C6WbrQkkITzHDpmHtB3y/JbqwdGa5TODOlORD+ocHLn8Day5CnkQjRHknjwuFIouLKW/FaWyqpEo6DWGnj5GalF6i5ykpKAMLLsdTIdcEvHrGDsRqcSqURx82kxPe5lbN8ilmGjJ80M9lu2PS/Qcy0z80bKtaYpldUHrvAPCtTlo2rnx1HXqypfAXfeRj6WSRY1oVKwB1hNNZ4a/n3iU+JIMO0XcqlWs7mleOvh5zWVbSmyPlHXT59D6x14Ny2eySB+2Iblp+ROWdyMjekUsDtnIDB5t+bnBLqqiVXWUtvHkSaCKwC2EG6h5EPhRg2Q/dKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApLXCMtRRrfJuq26TiZwnHUiiuPFpJWqenrGeOp3a5A=;
 b=CG61P4GjFYaowRxrkulRbr2S4llepPDTcIrEDEiq5IPUsRcA14reG2ekDA/u1yNoK6tRVn/GConSRAInMEMDW+ewRGiaaAoI3vriE33hsPULzfZ9kFLlkKzjIR9ePTuR3Jict6wbfDtGKBI7U3DMzgnNEpECwAbBGk6u6eRxRoESvfn36p8YZb57FwfUympinleUcb3jwEiiYMrfMNDidBaFllHd52diM5UvnIQJ3V30VJX0GTMvK0WQwnmQpy+0LQuZf+9z7xESK6Euzl1RWq1VF8ZnEkCj1JrfPnaRfMQOS2HpchWz2amQJAGAtNX56ARzKn8KNHdsM8ZlDp5LfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApLXCMtRRrfJuq26TiZwnHUiiuPFpJWqenrGeOp3a5A=;
 b=B2INH7ftQOdVWWFxpk4r5YYC5MOktbGorPEiLSk0cy1AYO3iJbmAXcZ4RNWGa2cJmri5fysTVn7zR6pzlrviX9Apm5X0Xh/a2OVXNCPmNHHKxZ9x8x3ayfzzn6e1NHjBvcmI9O/g6A9R2oLVNXKxNMjXq1xxp3HJZCsooOKGt24=
Received: from BL1PR13CA0078.namprd13.prod.outlook.com (2603:10b6:208:2b8::23)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Tue, 7 Jul
 2026 15:42:20 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::5c) by BL1PR13CA0078.outlook.office365.com
 (2603:10b6:208:2b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/30] drm/amdgpu/sdma3.0: replace BUG() with an error
Date: Tue, 7 Jul 2026 11:41:43 -0400
Message-ID: <20260707154203.2603209-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e97647-a1bb-4190-63f1-08dedc3e54ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: pPpkRidbZy6qYiUy9xFr+rtUzQeFHaqUS0cnYbjIRVCKeA5GfV1YC78cmVmcY4PnqAjR2AeFrzZch4lblFa3xMj6XRv/7+GjXzFAFqCt25zPwsw15HAEBRdS68UpBBgO2leKwwiI2AEhv/jFaA85e1zTrue2pRKBhv3uHCt+ufu2fAjUTEWd5n1OK55WfzKz1K2vx5HgfSeSPXKSVstblp0KpYbu2b6Wy6LQYG6DFKMiaXMbKN7kO34tsc9dP8i32BK4t9goDQnt/u3akEPQ2S9dllh/tSaC/XzwFEO7m2e+BQCibwHgamt+UgIkP/9VMGaoCmke+aROtziHnZdayIXBHkXLw3Gnb6se5V0EnuLXvZP0fe7Ez9U1sJ3Sy+IeQQS4KHtJQNUVCUaK27j1iIzAVVgjJpy7xHMS6hBnHCAoNxzLamapI4b0LoE/KhL8cMlUAjivIaB8bk/NLdfjpJjXo+9ToiPuMkDid6/CQyEGbIbn6FEhqMaF62FD6b73Ll+HHksazFUS9QkQzodU0CoevgKiUskDxX2aZ2sIlfPhVuJ1upS81FEqoJ7zEMXPDgyDyGufsxQ8YtAFfUbIn9Av1xrJW0k/ZEtCxJHEPyQwtHVArVyl10JsSqK0cMnBoLI0UwnLBX9ykTGxxVmnUOy1QVUYLGZC+QXTGW98oVuwN+vwyMpVDYKAKopsiOfI3f2LLITxmulDYiX/U6Cc6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZJe9socbffqhQVLOiELLgOKl21dzk9EwGwXeyrkbHunbhoK9m0oyrcL8vJ9Q9Mg2fmgrPvA+nbcoCNX0D+8L73IlQHmrXmqqz125WfCvcucqlaVVv6CjSBoZ1MzeiBt5zy3HWuaCKBAqmjaahPS2ARhk5HyQIGGyDlEJ6XdTKxE+ZVh60u0YwPvLN1SXsocIL0k93IlZ4/LjB0KMckqx8JHMEUxcXY9jxzPSbiWZjLSlVz1DfIVxNLktl8CCEx3uT3kH1DxojtBTkkZQ5MsJpMGzLj49IujBa2eqBZhMtxlnN6nadFF3USdWXicTv8TVv3FAEIMv+mWN2EkrZZhKrf3fLs3FFbknEGTHh1H84B+6EKLBVqvgHzaM5hQpajilbcLkYxSl6tJriSRZff9GgXnVgMpuwAN0paY8y/0ovuIILs83edy6BcDDXXIHtQOl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:20.3495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e97647-a1bb-4190-63f1-08dedc3e54ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 8ac1c9dae72e7..05cce4bde73eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -298,7 +298,8 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_STONEY:
 		chip_name = "stoney";
 		break;
-	default: BUG();
+	default:
+		return -EINVAL;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-- 
2.55.0

