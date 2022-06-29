Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63505CCA479
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4AD610FA17;
	Wed, 29 Jun 2022 03:21:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9021310F95A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpeGlH0AUMRCMtXV4oAgOJE3krIjsn5z4EH7Gixpt1WRta+earsIT9n1S9n7mgCSvk34wlfXizO6nD9aGkkDje9GlweV38fjv84JADPBzQ/t0Iz0M96/i89rPpT9ULsbQJRQ6+oqBiErfobvs/XKXBsUPHxpteRv1im8MCtCN0cIEEcA0NuPL3rc6n1KY5ZaEMMf1EamvyWwTFpUh+ME4nfUvydA5UBCG/9RIWx7kYEPhmhh2uU2L90ASXmJyKPn5CFO82kLd4twepngZY5GtDIetxVaE5+CdcgTBSYSjfX/c9zLWpG6hQZmEbjiXtkeD6F5C8tFG1fadIxjvbfEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJmEw8CtcLlH+gi0DuZDSFFavPQeNJFieNi1pbkTPjo=;
 b=PfD5jOSc/7hXUKPSlUAqzFo4XtPNlyRu004kgnM3CCHLCJ+V2BhQpO0mt3TpUibGmgD6uzDQf4dkCdyoyFsFmv5jr4+zmSFd1cZ59KpQ+pFc0QaBEjpVr95aYJu25FE1UHGRzeGkRG5eU74CIdbA41XhQxz/mxlgVfd6Dm5YDxXb7lkDps5VatCwZ4bntBBPPQreDCCcVRpOUJ0cDzx951oqUNQSkTYJW8z22zz12fFILpzujBNyR+3W/vmNz/vziN8QchlXamOhH9O+booT8kzwGKsYlN9gYCT8STTXRnpMdX763E8/kBQbBn1ZPr2HDLm+SGcxW4g4M0hbi3x9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJmEw8CtcLlH+gi0DuZDSFFavPQeNJFieNi1pbkTPjo=;
 b=oqYVNfEAAqkgDNj9g8ETO5E3z0zlhC0lPMk6RVd9EWHHDDv2wGcZv5gglwXt8ypqJYhDUdHBpRxwwtUGhM+bjbhS6OgTfsKB4TRl83SMs4zNPCgkRQbxacC6fSfkMNF7OftIKd1xC9p/Gdp2KtT1CFY8hujaMZuqDae3JO4+utg=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Wed, 29 Jun 2022 03:21:37 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::74) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 29 Jun 2022 03:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:21:37 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:21:32 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu/mes: add mes register access interface
Date: Wed, 29 Jun 2022 11:20:31 +0800
Message-ID: <20220629032034.2994328-4-Jack.Xiao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1fdc953-9fae-42b2-f192-08da597e79ee
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndS2VZbLuOGToF4qU9ANJD6oYWcjV4qy+YJPGzkmudfjmf8lKkF89ghRZyj5XqzFHXGOwqqh4vXdwdixyxi1V8vS9Xic22UM+BWnogK7Wj0kasufGZL71c4eaG4kNdkmc+UBj9C5gPGZhG09cRx4q5AjofFUjxsuYrAp4cvwmLqxIifGE+9nMs2CAr3hWdlId+fp3B+8cDK3Uxc55yHaUPZlS8/A9P810F7ykZsX4RpXaMAq6Th/4D1HEW6R0geVeDCIOBe+zdHPX1Ew2hK+GL/5rceHbZpSa9/ELf8udi/+vE9NlpSOu62jzFzD1eeUy8ws99IAZcRehRbquHqsNbFxivfBTKOuvc3vqC71Nb9W1Z+n1nIJVFg9x0e9TrWpMxvLrLNpu5lJdtVLEGweimw8dVr2tei8YIsZUbWrKDS/rUK+3Ou7AjunjVGMSyC/g0DgReX/8PXzBSHrDoZSs9owmhPl7b34ADYduzUwfvPQf7aj5rQRNvHo1wE6m+c9lmJiAfv7csSQ0OVtmUvRR/rGgjm+23kFtV4nygRoUtXS2iASw95R3c3TJnw8eMdBDY2kmRu/s/7gvPpXyM36bwlXgzubJvsVu14Da8fdCWIyDhhfD0ufLuJL2Kuq4fK5sqp9WtQNj7+MpXeplfXud94tASwLB6348HqD2sx8Oi7tE4Ls2e2k49eUk4qQ1limw86ZeQG/Xmy/X+OTv6S36Q/RBmrQk8444PKTwt/WL3/F8kpyifzD+MPc+hlRpKpVcaSIbILuOUdjN4LdMcG+9ulNQEgXgw5B/djP6JvTBPAkrhEHhlswC48hgEft1HemQNfc3PfhTjt1uykPgIP3bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(478600001)(40460700003)(8936002)(70206006)(316002)(4326008)(2906002)(5660300002)(40480700001)(86362001)(36860700001)(2616005)(47076005)(70586007)(1076003)(83380400001)(16526019)(426003)(186003)(6916009)(8676002)(336012)(82740400003)(81166007)(26005)(356005)(41300700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:21:37.1862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fdc953-9fae-42b2-f192-08da597e79ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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

Add mes register access routines:
1. read register
2. write register
3. wait register
4. write and wait register

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 132 +++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2e86baa32c55..b6c2a5058b64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -189,15 +189,29 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	r = amdgpu_device_wb_get(adev, &adev->mes.query_status_fence_offs);
 	if (r) {
+		amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 		dev_err(adev->dev,
 			"(%d) query_status_fence_offs wb alloc failed\n", r);
-		return r;
+		goto error_ids;
 	}
 	adev->mes.query_status_fence_gpu_addr =
 		adev->wb.gpu_addr + (adev->mes.query_status_fence_offs * 4);
 	adev->mes.query_status_fence_ptr =
 		(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs];
 
+	r = amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
+	if (r) {
+		amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
+		amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
+		dev_err(adev->dev,
+			"(%d) read_val_offs alloc failed\n", r);
+		goto error_ids;
+	}
+	adev->mes.read_val_gpu_addr =
+		adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
+	adev->mes.read_val_ptr =
+		(uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
+
 	r = amdgpu_mes_doorbell_init(adev);
 	if (r)
 		goto error;
@@ -206,6 +220,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 error:
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
+	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
+	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 error_ids:
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -218,6 +234,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
+	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
+	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -796,6 +814,118 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
+{
+	struct mes_misc_op_input op_input;
+	int r, val = 0;
+
+	amdgpu_mes_lock(&adev->mes);
+
+	op_input.op = MES_MISC_OP_READ_REG;
+	op_input.read_reg.reg_offset = reg;
+	op_input.read_reg.buffer_addr = adev->mes.read_val_gpu_addr;
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes rreg is not supported!\n");
+		goto error;
+	}
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		DRM_ERROR("failed to read reg (0x%x)\n", reg);
+	else
+		val = *(adev->mes.read_val_ptr);
+
+error:
+	amdgpu_mes_unlock(&adev->mes);
+	return val;
+}
+
+int amdgpu_mes_wreg(struct amdgpu_device *adev,
+		    uint32_t reg, uint32_t val)
+{
+	struct mes_misc_op_input op_input;
+	int r;
+
+	amdgpu_mes_lock(&adev->mes);
+
+	op_input.op = MES_MISC_OP_WRITE_REG;
+	op_input.write_reg.reg_offset = reg;
+	op_input.write_reg.reg_value = val;
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes wreg is not supported!\n");
+		r = -EINVAL;
+		goto error;
+	}
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		DRM_ERROR("failed to write reg (0x%x)\n", reg);
+
+error:
+	amdgpu_mes_unlock(&adev->mes);
+	return r;
+}
+
+int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
+				  uint32_t reg0, uint32_t reg1,
+				  uint32_t ref, uint32_t mask)
+{
+	struct mes_misc_op_input op_input;
+	int r;
+
+	amdgpu_mes_lock(&adev->mes);
+
+	op_input.op = MES_MISC_OP_WRM_REG_WR_WAIT;
+	op_input.wrm_reg.reg0 = reg0;
+	op_input.wrm_reg.reg1 = reg1;
+	op_input.wrm_reg.ref = ref;
+	op_input.wrm_reg.mask = mask;
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes reg_write_reg_wait is not supported!\n");
+		r = -EINVAL;
+		goto error;
+	}
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		DRM_ERROR("failed to reg_write_reg_wait\n");
+
+error:
+	amdgpu_mes_unlock(&adev->mes);
+	return r;
+}
+
+int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
+			uint32_t val, uint32_t mask)
+{
+	struct mes_misc_op_input op_input;
+	int r;
+
+	amdgpu_mes_lock(&adev->mes);
+
+	op_input.op = MES_MISC_OP_WRM_REG_WAIT;
+	op_input.wrm_reg.reg0 = reg;
+	op_input.wrm_reg.ref = val;
+	op_input.wrm_reg.mask = mask;
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes reg wait is not supported!\n");
+		r = -EINVAL;
+		goto error;
+	}
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		DRM_ERROR("failed to reg_write_reg_wait\n");
+
+error:
+	amdgpu_mes_unlock(&adev->mes);
+	return r;
+}
+
 static void
 amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring,
-- 
2.35.1

