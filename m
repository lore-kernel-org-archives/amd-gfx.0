Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1C6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EFD10F305;
	Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E693F10F498
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMHwuCIGffsigDWLiZzdcSeKoymKMGc5Yz6YdNwEIHRZ8XwrF290fDp81NYCLhA3lSN8EuFkC+Zilxv1JTWh5wyWM8HmfzKKRolMtChY6NJS3GOerdyzeR05fWyvfHF6F3eUBALnEOc6nmB4JjQ8JVCur4xuteVabckxU2oeuxe8CO93PwsqeeOEofmotFgHpaOIk3VGJjhzEuv+SJ3jtZNLayraA6jzC7G7S5ndL1t0gi9JRUA5FJtEkdOMNasdWFCrV93rZp7911OCBgw8M2GRInOcMx5HWy+R+C4TGPAJ95wqn/BsdxHAUe52iKvye4fQApyO6mBBNsxP7pZa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyz70IyLmlob5EU41/lRPoZiQLRTfEdD10pUwAQN0dc=;
 b=EjWe7b8kOC/AJYcRK6MVUag1p47fqQLu2jXSbUnJAyu7kFkWU8d/emvLT97vNBZMr4DJKwscI7K0jQrRzuYDeFkj2K9JfKFdsT46jwjb17ceujPatX12icB+OCiCSegTzOC08oGCDVsA+CvaE1FicY6eiJ8U2svdZRxHAfCPVUBHSrH5NyYVX+7o7RLsGPJ2WrxkEzU+7Ftpib0hQlIak4zZrX+tAhA13zOahElBeO2zRHXweZ7VNvZ/s9VxzgZQTX3XmlBnfXgM0NR/nhyszMZNEOpuF5YNVLxfaZ5GaPSY0JwlqbhY4BQmRanZ0Bzx4y8tgYW4xj4pWeK6VtOHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyz70IyLmlob5EU41/lRPoZiQLRTfEdD10pUwAQN0dc=;
 b=tKRGbxd7HdBX6Xjx1nYgAyWqn0cVNeUzk6NNP5z9CB+52tFnskQlTeZFDHdpVvZYZUa8CRFaFFsx25KfGxD+bjsHL+qEMwu3Q78uxaxOKtHpdcdqnVBmMYGkSJazswH56E8I2JyIDoBYu5FiYb7OmNjcg0pyjomR2Sch2IdSU8Y=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 MWHPR1201MB0144.namprd12.prod.outlook.com (2603:10b6:301:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:47:03 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::72) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 42/73] drm/amdgpu/mes: relocate status_fence slot allocation
Date: Fri, 29 Apr 2022 13:45:53 -0400
Message-ID: <20220429174624.459475-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52432dd9-6933-451a-b234-08da2a0844e5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0144:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0144BFC521ECFDDCA1727BF0F7FC9@MWHPR1201MB0144.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCR3dgnksd5oHFhf9YLPFXWFkj+v8aw29Rfdh6G2sNBI0nRrZ/9ZpnYMP7uJGh97rW+CtZgLs8MnEa2vxt7RgWBSgxIOJLi/MkOEDu7XETe26L+M8FJ6A7XvkJkFMCMdk+6cASOhEsJMfG7pst1w7/8Cc/sttNczOhb3lHUA9TIrjI3k6i5Np9X45QhqdosmzpZ3Sfd+K+vFA+dQcOCyMeFa/9r/wpXkkiJsFd2ahldJuuouoNfG7IRZNnc7nNfkkRsHb5KWML0Ln7Yk4IpwS2Mb8wG/QrY9FpnYezmfxQe1HXHrC9iLR7kUBUK/xAsNkNQ6q4qFZrEHcMk8PNtlnoG/XN5+gsixTNY2QoFO3+qQqcqY5VV4dtQQWCnOLYuGdFKBd+UMXa9oCe4gQRcEkUYz8vPeHZyIhKEfSakkrnY7Wy9Bh+dI78FgQN+4CaTay0gs/l/4VRt7A+y0uax5NFL1zBte7K1kETpDzBp7Gs+YSQagUKWRyiHkcrEF+PqqbN7EnI/h3R7R/TicLKxWZBMW2QJYu+f+ifwpfHbgwemfKyT/rcSZMFEzdI0Au0cmqkITBGUWpbNB1hh5FdwMCB7GPT44Qsd2KqS079WO6gQM9VXQmIDj8tyeVh+7YSQmabWiUqS3YYkA0OhqD1ItcMkL2/VfvbXPRwK3QvxwrR5Ui6iNVSgoDZESTSARtkIV2nD0gdmOgKfZ4GJcaUDFdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(8936002)(70586007)(70206006)(8676002)(356005)(81166007)(5660300002)(4326008)(26005)(1076003)(426003)(2906002)(82310400005)(7696005)(336012)(6666004)(186003)(2616005)(83380400001)(47076005)(16526019)(40460700003)(508600001)(6916009)(316002)(54906003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:02.9418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52432dd9-6933-451a-b234-08da2a0844e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0144
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Move the status_fence slot allocation from ip specific function
to general mes function.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 +++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 33 -------------------------
 2 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 90c400564540..a988c232b4a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -176,6 +176,17 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.sch_ctx_ptr =
 		(uint64_t *)&adev->wb.wb[adev->mes.sch_ctx_offs];
 
+	r = amdgpu_device_wb_get(adev, &adev->mes.query_status_fence_offs);
+	if (r) {
+		dev_err(adev->dev,
+			"(%d) query_status_fence_offs wb alloc failed\n", r);
+		return r;
+	}
+	adev->mes.query_status_fence_gpu_addr =
+		adev->wb.gpu_addr + (adev->mes.query_status_fence_offs * 4);
+	adev->mes.query_status_fence_ptr =
+		(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs];
+
 	r = amdgpu_mes_doorbell_init(adev);
 	if (r)
 		goto error;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index fecf3f26bf7c..d77242e0360e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -606,35 +606,6 @@ static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int mes_v10_1_allocate_mem_slots(struct amdgpu_device *adev)
-{
-	int r;
-
-	r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs);
-	if (r) {
-		dev_err(adev->dev,
-			"(%d) mes sch_ctx_offs wb alloc failed\n", r);
-		return r;
-	}
-	adev->mes.sch_ctx_gpu_addr =
-		adev->wb.gpu_addr + (adev->mes.sch_ctx_offs * 4);
-	adev->mes.sch_ctx_ptr =
-		(uint64_t *)&adev->wb.wb[adev->mes.sch_ctx_offs];
-
-	r = amdgpu_device_wb_get(adev, &adev->mes.query_status_fence_offs);
-	if (r) {
-		dev_err(adev->dev,
-			"(%d) query_status_fence_offs wb alloc failed\n", r);
-		return r;
-	}
-	adev->mes.query_status_fence_gpu_addr =
-		adev->wb.gpu_addr + (adev->mes.query_status_fence_offs * 4);
-	adev->mes.query_status_fence_ptr =
-		(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs];
-
-	return 0;
-}
-
 static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -991,10 +962,6 @@ static int mes_v10_1_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = mes_v10_1_allocate_mem_slots(adev);
-	if (r)
-		return r;
-
 	return 0;
 }
 
-- 
2.35.1

