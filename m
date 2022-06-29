Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F13C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F395710FAFE;
	Wed, 29 Jun 2022 03:21:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D964710F95A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxLegp2MC2D+iYdr/QJhtBy8jZawyFdbbQbKJJGXncMb9qfyMvExfiICzEU7ocExjU2QUFnc1rNsvDRArWyXEgqS4q3/mZZ+E2Qi4lha2ZD4uyLWLMPtjZ2SMIt+ohjYed7TwZYp+reDRQbe4QBWfdG/fFO3V1l1Oab6WkZhrAcJ39BN9pE1RWIgiqaCBl33+c8ZRzqL39YAgN0g6T6eWfMIPsLHgKdTwMVmgER4Py9v62FTgoVtCe4VTEboDPjQVzBZfM/mzDkf2p+2cIUEq8CHDHJwieg0ZYG6qU0je4Fni/DgpiiEFlFI3cUTpHetiFNDYwiriekrCKeX3ileWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmbDr2M3bAfVXj0ZATQ0CBKfns9kqA5/g+/ivo7Vo9k=;
 b=PX3MBA6YporannPpZPULHoxF9a3tZARj1iEDWzD0c+Ti6Csfp/Pq/Jdq9WmHERXLXsLxo+FzmLtg/J+r5MmLHeODD8gnORxAiGHKQXGwXpkD8d5kwb8CHoYdnvWiD0TOswy2SeTdLVdOO8fLFkpjZSGWUSvZGZlDPYw34I0YoQouYIUfLHef1cAzmhRuQ2h4Q7Jg9pZ2dnD+tRgiLYnR7HMAYhHBYBVJbZ04Pvdx+jJntulFQFTT6QwLUYwBB4myUU45nVdX8Ngmx3zjBFlBs8j+u3WlBkkDerq3cvQLc5E/J7+jZ04A9cmvp90fyVrCF9PQI/46o34kRN/i8UO/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmbDr2M3bAfVXj0ZATQ0CBKfns9kqA5/g+/ivo7Vo9k=;
 b=zrqhvAGkP7TZbPk23+KbyD0qwQa9oHHNjOXOUAcZ/f/A6wqzEotc3Cb3foLMpbDs8nuddPNb1N7s8qRFS0NPS6ORbOJNfugzAIwL0vEtUBH5FJO1DDw4gWTMyo5g9Q7Xfs+5/y8BqywJRLfqpfxr/OAGbcwpp/r3U5Fr3a3vCt8=
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 03:21:38 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::8c) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 03:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:21:38 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:21:35 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu/mes: add mes ring test
Date: Wed, 29 Jun 2022 11:20:33 +0800
Message-ID: <20220629032034.2994328-6-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629032034.2994328-1-Jack.Xiao@amd.com>
References: <20220629032034.2994328-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 385d279b-d993-4add-d1b2-08da597e7ab4
X-MS-TrafficTypeDiagnostic: PH7PR12MB5736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82lM7WUM7Km1yLCK8kWi7EvQ+wamLtS2gZBw0KZ7JfUlIiWZTRUiEqon/tEkaWXiVOCWMuJtvuOmSMMRVS9eF3OF5wTLgkExtaVrqXNzjYWz5M15PugzY0jEOLMU3jXcg+1QRUfjQdaH/3unMc1Ob2FXoP6lQFVU8GfaZdbUji7bKzhyUou+4nUCKtMtTudxqqErXL7OYsShRZEUSAlKR07epuYO8fF4800w9QaNe8fftWvmglfnFkfjbuq190AiXlxBs6452LN20dwpLxhvLyL0DV4+Yv9lAXbEcv+tolsr29qigkSgcbgSB4IJdhsKhYPcDDvt30CU7uHTkUmrKVauwAGzD7oQR+t4DAEuh9wLLP4fqIaMbmPyoqQws7aazY92Hi2u15rEiLxrWqMYMSGmpJWSr/2dxPuQtBtNaj1FQJp1/RmzEXx4DkJjyFsTVw629szfQvi6Q0iM7jYHio27HXPOL89VZKfiVgEGfMf212qBM1QXfrcgLC4ryUh7gJQKjnsrQibOqjN3vI+dhqcwYBEyrS/9luBFWid4Brc0TYM+5/TtLcLB3NtiLfvBGMYeLmMEzp36o9dwsqcjqYmXkNHq0eHIf9tKp9h4x9ApaYTjgOljVx0Re7fAAlNIg1r+hUrRTCh95r7/sqHBkqXcxda4pko8lQoYcUho97JoM3JTKto6M412i0sU35fwVMAHvtPOjTW3cUOkQTz4qVmzf+vBC1fG5zjhKzjA/45Ox/IUxyvuVrC66ESuMcF6YDF+Tz15c/mfk68PSFQwgV4wWLRF9TfNu8lRhhXtHbtsE7+8Qb+BVH24EsazYIAKu2pPwPpWWS5mY50PRdbR9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(316002)(1076003)(5660300002)(6916009)(2906002)(82740400003)(336012)(36756003)(82310400005)(41300700001)(16526019)(356005)(86362001)(2616005)(186003)(40460700003)(7696005)(8676002)(426003)(70586007)(36860700001)(47076005)(4326008)(26005)(8936002)(81166007)(478600001)(70206006)(40480700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:21:38.4830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385d279b-d993-4add-d1b2-08da597e7ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use read/write register to test mes ring.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 36 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  6 +++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b6c2a5058b64..c18ea0bc00eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -926,6 +926,42 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 	return r;
 }
 
+int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev)
+{
+	uint32_t scratch;
+	uint32_t tmp = 0;
+	unsigned i;
+	int r = 0;
+
+	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	if (r) {
+		DRM_ERROR("amdgpu: mes failed to get scratch reg (%d).\n", r);
+		return r;
+	}
+
+	WREG32(scratch, 0xCAFEDEAD);
+
+	tmp = amdgpu_mes_rreg(adev, scratch);
+	if (tmp != 0xCAFEDEAD) {
+		DRM_ERROR("mes failed to read register\n");
+		goto error;
+	}
+
+	r = amdgpu_mes_wreg(adev, scratch, 0xDEADBEEF);
+	if (r)
+		goto error;
+
+	tmp = RREG32(scratch);
+	if (tmp != 0xDEADBEEF) {
+		DRM_ERROR("mes failed to write register\n");
+		r = -EIO;
+	}
+
+error:
+	amdgpu_gfx_scratch_free(adev, scratch);
+	return r;
+}
+
 static void
 amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 93b2ba817916..81610e3f3059 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -341,6 +341,7 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 				  uint32_t reg0, uint32_t reg1,
 				  uint32_t ref, uint32_t mask);
+int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev);
 
 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 			int queue_type, int idx,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 2a6c7a680c62..c4d085429d26 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1194,6 +1194,12 @@ static int mes_v11_0_hw_init(void *handle)
 		goto failure;
 	}
 
+	r = amdgpu_mes_ring_test_ring(adev);
+	if (r) {
+		DRM_ERROR("MES ring test failed\n");
+		goto failure;
+	}
+
 	/*
 	 * Disable KIQ ring usage from the driver once MES is enabled.
 	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
-- 
2.35.1

