Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6E4C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C8C10ECF3;
	Wed,  5 Aug 2026 06:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8cp+FR5";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7CC910ECF3
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMxOljDObFXb5Rnqq06ac5IbMqAFhxZQc72whBIu7ISoxlLTo+L8T5VnUy0C5NKkGoopJHidg5Mz4DAbcgeE7OU7zImoLDP+7j2PdlbzEEQj8eriSd1RcCqwHh/7TSX1R6eVC2It0qhCUCDapkhkMIr+7H0dE3lMqzAGDpUaS6CPtEsnPgWjljlHEuVMscqdLUwQAv4OIpiVXk4THESIslceeoNQWexbvdsM9JqhtZvzRKUV4ydVRK7OzLAduC2CuoT1FBKWnSLRBNWEtu0ESB0f5t4Bj66Hz4VmMDg0Tfc5qI8yMioORG9m/WLobM7L1FRENrAnYVeOpothJ83xzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU93FoOJzAT5+AlpkJmb0SOnaBS1o43lFx23LukGoi4=;
 b=TRSuuewsDpycL0io4d8iBrssri89L86zKAu31WdPlslnyP9pruAib5gRVsmUSp4T8L89eaduy802ROdrm7FvqJ/Vmn/tBiManCKQ3DI+wJbtQMVOFtS0GFlEQCCNzKjhxxY40PwOFpRiSbDTwKHN8WV9RzJxP4A6hifDa09dwCjtzEtRzmIPRwZ/bdSAHpsV0ojOO5xINBYZV3hjJQwTfSSI595RUSPHNBLAAHIWU8Pvseh0YQoHJ2UozNp9iaoL65kx7Os4aRp7x0jKOrPZjSRHsBPNnDo7NtCtqSxNJO0KE5ssGLZYDabid2znk6g7Pkx2LmAr2b0W6U3BgjBAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU93FoOJzAT5+AlpkJmb0SOnaBS1o43lFx23LukGoi4=;
 b=D8cp+FR5C+vfbPpvrnio0Z8BWFGMQLZOyIbnPvxrbQyXHHRiLFYVUU5T7cTP7GXvJZMQ31/RGuy22IJmdm3sTsQtF9AzA6k8z1JKAcuHxoCo61mmTs/0r6kH9vQvZ+A/QPOYzIGjLgBfUd+viV1Nt19sFxlkNqr8xf8UWJGkclU=
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 06:40:02 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::64) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:00 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:39:56 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 02/34] drm/amd/display: Fix crash in DCN5/6 calcs when GPUVM
 enabled
Date: Wed, 5 Aug 2026 14:36:14 +0800
Message-ID: <20260805063937.2145774-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 849d5a59-1c30-4958-7dba-08def2bc6019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JqmhDTIikdZkfCz/9en0z16yzwsVh6mUQDI+A7BmL1QN5pXUOafc9An1we/MDjQTM0lWYSAuzro6hSRFgM4c2DXWHgZrFEw9lDto/EtbvYI3y7/pMJUNi6ye+SY+UXQD2o5JgyUDyNSfocU3E8Up9mMZV/ALkdE/IoQRvdPJH9mCKRK4TdxFXjazgXKt3n478Ybgs1YVpbP+CNB/3Z8E9AH4rOQ75pU71c09Cb3soNlCJtjDoV9REBa3HkBkRdUkUwZohmRfTqF39ZY3P/+HVB8A8mC3Y86+JFSUh4edR8LPEA5pGQR10gTBTXfcwbfkMp6OHWObpMLJc+8iGE8Ak81Q3ugbtn9SlICxiuQoRuwkvL9ZwmLMJ/76qeeZmSI3qVg2luPEAYFbFAFAcmxkGqXZmpV5CdQSA4FbkYRiLi3EZ/qnwYcF/ugkCFIDkq9UAapr2p0ya3nqNZedCyAQYtMdzLdn5YgNHp2oA5cb9SnLAk9y+mqHPze0OmMDFwSEV1Kr+g4UpOJG0cXXrrmi36OX1sDu/zGd+PNrOlGv2oJpVfOTI8Sx4/fZMuuY/rOUIjhUmwqH9FSoP5A93SExfenBZ9tTP5UL0GZ98M4FWKQlMDtek2O8igpjlTTLXoHE1hdVITQE5Ojf43GsMytVhQvH7CgNNyF+h6r7GLaxN/5fwu1XTeUTnus1xSRQBMqvyrSfh/X0Vod1Vm8TbSydeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IzuKUd/ra/F4uz2mytqCdDBRymMjakEBaMZSIkSWosHiAc9qTMNyT7NUQ6CZVzPQ/8eyEtfq0XdquUZdJmBqfjrOS4imjfuW7qp0TqMLCU5zFwfCNPfjFeAxeYQ7yWY2z1RB8dpVY+PtXORMJxMMqLRFO3WIUF2cJdWjvgpqjF2dxwSnM+5xyWpeN/kuI04V3/L5UPMzacJEdFSjaAP1RDeKhGQfaJXyrMKVJAGdQ4157fllMDiD0N2oFu5cmb+RtTWb6fbb5mz9s8hAuL1aYjuK9W6FIp7P3fTJjy7ujkCIqFXrC65rjbU1yXLUuiN3664zE7DsL/BVEs01KLptiw8lGcdHE5On4yDokSEPWjU0n00jlNAHEe1UVNoBMrjOEumrxBLyktQ7IQmHpfr26eBVpMQU42CVIAaY3L9a/SOSpUgMPeJWMAeqltn4I7s3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:01.1900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849d5a59-1c30-4958-7dba-08def2bc6019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If vmpg_bytes is 0 and gpuvm is enabled then we divide by zero.

[How]
Take the same path as gpuvm disabled when vmpg_bytes is 0.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index 05a99c4f761b..321a29d289b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -2417,7 +2417,7 @@ void dcn5_calculate_tdlut_setting(
 	else
 		tdlut_footprint_bytes = tdlut_pitch_bytes;
 
-	if (!p->gpuvm_enable) {
+	if (!p->gpuvm_enable || vmpg_bytes == 0) {
 		tdlut_vmpg_per_frame = 0;
 		tdlut_pte_req_per_frame = 0;
 	} else {
-- 
2.43.0

