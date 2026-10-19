Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84C606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2ZqGbNru
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A630410EABF;
	Mon, 19 Oct 2026 19:07:18 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4068810EABF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 19:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTfdcfcJNUsoDcNQLRQ/4NeZZVWoGFON8U7FJ8Zm7DeBCcNihG7YPSGJQ33eNqX2A8eY3x7p0O2wIz73/3Vqh3pA2i6R4wOQsywtx0wCeMUloVvkvGpB+WU3javdZ8AoKpkyixi3SJCRsakTkLVELrnocC0mPJKz22PrLE1+EWMVRvMhW/pvf+09PooG0Pb0esoamsnRxibuBhVh3tyb4siX0qq05ZlcOTLuj/tWFAIXnWqvPq9GvPsrengtXDr+I5Z17EX0GObVMeU0pok1vJ41Rr9872txkkgNsWT6BCEhaVRTbWDfuHR5D0Pc2Mwiz8E3Q5J9/1+y5NaeWMnPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phHm8ZZpcG2/O2/5UZlF1uckc4Knuzvh63YPDGBNUPM=;
 b=UyG6IcWq29ZAfWw1F4wN803NEYe39ZlfsdMnsL97Hrv8IPkg6Miq1VIwf7gF4uu5XQ1ae+u/WD+dstDqRDziSjVIbIhjlO/LoMrnAW6ZwKvSq59ULYZC5LpFgkarGFHcwB1SVEXvVsonLlaqERUBxD7Fo5d5C5wlG9WFHJXD5yOEi+rjgIbKxmf+j25W2pWWV346PdrhK6zs0Efl1iowhMZPXq5u0vjIdd28AYb9ve7h/NmryzHJ7/8C8pL8uholFtJl2zNMEtjjaFmTeDZ42kXwUe3z+35eeuS1HUWD0b0oIeMH9ApWAswb52SocYuoIqvPxqrxnbPLXOZUuzRSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phHm8ZZpcG2/O2/5UZlF1uckc4Knuzvh63YPDGBNUPM=;
 b=2ZqGbNruXsqRfFm/G5mb7PUC+uxyIl6yAsPuLAlnn+rkndWWd0TuWJs/RdGqspiuEpf1ep2Q+10RR26A50ewNinx8KDC0MrBiUQFl6xQ6WiwHi/gL2CBHd8mih/UuL29FIG0QRBz7jFq8FV6/Iobh1MSB9UNyzLfAnicvTzKw94=
Received: from CH2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:610:51::36)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:07:08 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::7a) by CH2PR15CA0026.outlook.office365.com
 (2603:10b6:610:51::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 19:07:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:07:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:07:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:07:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/sdma6: don't access registers in MQD setup
Date: Mon, 19 Oct 2026 15:06:57 -0400
Message-ID: <20261019190659.2773961-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019190659.2773961-1-alexander.deucher@amd.com>
References: <20261019190659.2773961-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: cac2d78f-399e-4c95-969e-08df2e142c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: TCqDBH/ieBvIpU8lBBwAdaT5TqktTC9d/7DxMTUMI07SWRtL3KOEhwcUutSL6GYTQabYaB4HTFECnrvnXa6LEXadyihKedQejQkkLAPedVhU0JJMFwHM1KBlPKtOfupvMr4znCbMszEmB+UlQes25/SJIZ4gNcdXFflIs6kAE3NJXnjQBZp5qmpWLmjmQfk/3bIHKACnnbW0cj8kK6j5WxydpTZQuPtpuuIQC3JEBCYRnMXLt613LrJ1TsB2+fVXYRImgNVGCFPiiZ3Dklq7Ctx98JaJZU48YmYOUb9mVaoEKCIIRBjWFNDgNv1/YT4bxpPJoBuhK+A41wAcjrsFp0s5Mz/HZp5nbizxP0g2mhAW3P1guyg6aahgYDVlg9VffnjW9CDJEcLAL+32zRaevuFaWDcmooEzPw6bPMJpBm0uwfsYXXazyuidLp/DJxjfnh5DkP1o305SGFOpq/+fgSojw2KDIpcXPxsPfn+i3I729ziuwPwjLnQMq/fK6Wjucmk8dIaaajpzAzxcjpsSHrZIhcsbs6J9H4tsrFZoVGYy7dHntvlgDXCo8jm9wHa90ZnpRXmVoNOmLTuqKNfywYDpmNKdr8hoHnNWXU2r18S+zj+YCzqVgrLX3Y0Tdl9HrOibUj62rbQKSrtsmk1V1qKb5ZHVaTVoK9hXRx14/nlhD31+tsEa0ACWU8Z0HeLua5FmzQTDr0arG3JockgbPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5gZ8iv9UJ69SgOWHw2jRhSxmMi67AMbPiVaBi66rk5zpHaC6azdWiTr8vaK/Jyi+tSiLQZBDsaT1Nsdk/9z2n8VE8AOwPm27sycnRzGSHbtWsQJm4ggSXBbkimjlWlUt+lTpfF7mhn0iKYQOfW8ZXGjshccaPBji0GhUG38dlMaW1T5Y+uglZZ1C4PnyFGYUM7FU+QtzNzYwlxABZtuFcp5LsvUPztsJLzrMb97CYflSj7dsbABGaiYLQ4bTuejnCPAxPdlEMrQzw/A2Co0gvkWIATWi1bCZ6WNlBYSTgMBr2jgweeJkYIzD7+1mBAWIhlzxDHAAAc6TKQlT7CM0Vg1CTD3RcsHeHO64VuUkJsymi+aePUkwdUG7iwlWLjwZvPVOJNEzpmCkWHejbfLBi3on+6Y448NfkLWuG0u7K4nBwLKry3AmodietZJHkyUe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:07:08.3831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac2d78f-399e-4c95-969e-08df2e142c1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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

No need to read the register state from the hardware, just
program the settings explicitly.  This could also cause
problems when gfx is powered off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 7c8ddc4ff3ce5..e8684e4afc0e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -821,6 +821,7 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 {
 	struct v11_sdma_mqd *m = mqd;
 	uint64_t wb_gpu_addr;
+	u32 tmp;
 
 	m->sdmax_rlcx_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
@@ -839,8 +840,9 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, 0,
-							regSDMA0_QUEUE0_IB_CNTL));
+	tmp = REG_SET_FIELD(0, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	tmp = REG_SET_FIELD(tmp, SDMA0_QUEUE0_IB_CNTL, SWITCH_INSIDE_IB, 1);
+	m->sdmax_rlcx_ib_cntl = tmp;
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.56.0

