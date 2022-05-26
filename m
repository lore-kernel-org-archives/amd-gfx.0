Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78FBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 18:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C8610E4FB;
	Thu, 26 May 2022 18:02:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0B810E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 18:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg+PHOIh5U7YTnIEd1h/36brdx0Fp+1qXFWcdqFjBm+8HW3ZG+mf9NdWml63guYk+gWOD+E3JIGUfcXHNa+Ba7j7ud+c4zPcDLWFmHDCk+8ujCdvYS9EpE/YPxcoCG6DLSkqQz1zAQfCn9Pj6/TRL/ugtF1HtCyFLY5X3KV4Vypy+ipTVSnX5Q75f9rePXEY4k7ziMYqsxkPsN13OcGd9GQWtXXmeyX93+v3/JqOkkYrN7N5EqDzx3tOeUyiclpIPbsV7qoZ3KHUdeJwZ7Zcb6SPqt5AFIJaXyJQBY/aIbSaOy6M2lCPg0WY0C2ZWsF2IkK7xTPN2L1fXLlyfTu4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej9g/oWMEvI9iYidzFevDPYLscEjX7p/oeyHYy/U2g0=;
 b=hFzEc9qqsOV3FYGIoP8iC8bEqpXG2JAfxoI7LFhFSdqScJeCBPEvHY76uwUHWwW52S/oMXQE1jvSjsU7PRQSBEAQcE7ed3ywC8bc8Y2K0WZvKqabmlVUcb6rMU3hzGNlwwt2RWqz0FxIWxyId51PO4CfN96xyVuQr3MohYUlAgfE5D8wnsk+V2no/DrNPPjmzdUzvUnqDg+p6ubV2MrfMr7fIiuFlVO3allvZBCR+b6tmLpls1QzGgnQ1rITcsQ2q5AJ9koln48OQphbzVkMVJTMNKDaEJTtpno5YYyog0N104Sq3fBtl0U2uiS94cFQsARIyaMAlaNes4M7oN0cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej9g/oWMEvI9iYidzFevDPYLscEjX7p/oeyHYy/U2g0=;
 b=TAsmST/Yq+PaOj4SWdXLtRFGnh38elIElBKzlm/DBTK/PU9u4xkx6I3qYxMcNYMa/U5WPgYmXJVW7EFMxCdq/hB0j7oKHMB83qkqkPxiQiRAJKJlDiavCW9Uv+HQA6G6AUXZ2fOaCY/9bzY9trV6rzJje1ookFkfWrgPdaMZQC8=
Received: from BN6PR19CA0115.namprd19.prod.outlook.com (2603:10b6:404:a0::29)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 18:02:21 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::d9) by BN6PR19CA0115.outlook.office365.com
 (2603:10b6:404:a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 18:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 18:02:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:02:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix sdma doorbell issue on SDMA v6.0 and NBIO
 v7.7
Date: Thu, 26 May 2022 14:02:08 -0400
Message-ID: <20220526180208.3045014-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220526180208.3045014-1-alexander.deucher@amd.com>
References: <20220526180208.3045014-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 536f1739-096b-4a5d-a255-08da3f41e124
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4862C905C8BE05CCC1AA446BF7D99@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QS593EaCxCCJ7Zl1oj1yxkpwQk2t5mSzjtgEvJ9jcIEzkYNa4itcxGaiMQ/vnVtrW8I5CXkSkeU8WyaCTvYLqroPYJ/wVOAWJtMGccjuqcWtBlsMZPJa5xYVCl+1x1KchFbYUXK/9fMcVLEseEIheFhGWs8gpS2QjovriDpoCBT40S9S9GMST+/nVC407oBgIaZTGNt0Gq8oTorTdOWF64Ys7MV2fgbNMPI/HMCfC4FpnWXnobn+TfCVZl1a6pdLso7I8E0vF6iY55yMAXaXXk9UyXDgcbFdqzCorFLPY3szyLZ8YpO5hj1xeAAZqCW7kCUvsAKX+sR06gsiAtl5aPZjYa7ELBy85UDZrgE6ZlEFJanWXabCzDHu1rrG4E8hwnTyGPqop++pzgKvomWVzqqUapmyncAN6pjIb9V6GdJqT6569PNmH2zMjhfQ/L89e3D106jRHoEnfVjz2CyJfF+KnWE9cdEhczA/sqEJd6PaxkxwgKF69ovF9cq0EWfbGhtnOftyiDRKHtTh3JzAeQqXpTqnO3LkqnRCSIOlMdmBkxmwKvjpoysq2DaHVvGyEr52VQF1X5nfbMLGUzPpR5b9VWqOJXVNFEMRFefhJ0lQBFYuAsqSVRRXxE0xrfm68LdOy0MllcmDW1bKv8J+rpQDIzZiFghjkVtU3ZfFO9ZS60AgMB8gIFWaSu5vk8dGSKAdJ8Sr5V1dytqyOGaqtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(316002)(83380400001)(356005)(4326008)(5660300002)(81166007)(6916009)(36860700001)(54906003)(70206006)(70586007)(40460700003)(508600001)(82310400005)(36756003)(6666004)(86362001)(16526019)(2616005)(1076003)(47076005)(8936002)(26005)(7696005)(426003)(336012)(2906002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:02:20.8263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536f1739-096b-4a5d-a255-08da3f41e124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch will fix sdma doorbell issue on SDMA v6.0 and NBIO v7.7.0.
NBIO v7.7.0 uses a new reg function -- Common SDMA to allow a common
doorbell range for all SDMA queues, this is different to the old
NBIO version. This patch will add configuration for CSDMA and enable
SDMA doorbell function.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index cdc0c9779848..e786b825cea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -58,10 +58,16 @@ static void nbio_v7_7_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					  bool use_doorbell, int doorbell_index,
 					  int doorbell_size)
 {
-	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_SDMA0_DOORBELL_RANGE);
+	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_CSDMA_DOORBELL_RANGE);
 	u32 doorbell_range = RREG32_PCIE_PORT(reg);
 
 	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_CSDMA_DOORBELL_RANGE,
+					       OFFSET, doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_CSDMA_DOORBELL_RANGE,
+					       SIZE, doorbell_size);
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
 					       OFFSET, doorbell_index);
-- 
2.35.3

