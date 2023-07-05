Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0AFC001DB
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 22:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C7910E3D0;
	Wed,  5 Jul 2023 22:59:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD55710E3CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 22:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2GQoXB0HXMsb2FOVyzetL/CckCO8rN6NR4b6pvbZxVHE+PNMvgyC6P4es4h4vTAYxGIUXv4NSQkD1mA+ZHSvrCqO+5XWw4wPKXvBAAjctOvKlhOIL3DWeNMYPsdOqftWZ5PlVq4bwqSRw4HeOSZbfANJE5HZsXKLNzgQVnvFS68j/7YNmROeDMNMVl0NoLLQ6i+PaNUVtD9VLBep/HG6UEsaHEJcajoiNrNazV6x7u8/VK5uK0IwU1s5VPK2JtdeRFfd6r3hFyXggdMH3irT847SF0FALVnMO9GBvmvoNcMHLcFCRzNNO1Hbt0RdukUAdpPkqqQ412AwtcBIg2BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4asMEMJG1jGcFnL2ByelZJc2hStWEV9Ydv1ZrLuBDsU=;
 b=Yd+yZVCggvXkO3vGW/4kwV+x1Td51zTimzzM3sMuihDBextJbiBs+ptA1fWm8CvLr2+TljgwMSmrQPn0TZ1DO9P4f/bQyvIvocxoQdjMBLLsoaijFhUT2BCYLacM73CYNaF3YO1I4OKt8M44u0/7ysfxvpzve1ro59qZ6JhyZDBmOJuj7EpXSaFhPuWmEaPkUpXnR0PGdyHZkO/MVtSJyVQV2HpFP0ysFcGLLc5M4nTt8PVNSVzqgvv3cpbjqnlhxCn+ZXaoqPUn7uq0Nm15SV7I9BE3mmZceYMhDwSALVmnzRpNW88vC09TU+xfkjP0OXqhnU9k8MLIWuGcGX2pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4asMEMJG1jGcFnL2ByelZJc2hStWEV9Ydv1ZrLuBDsU=;
 b=R9AheJAhaa0COfRL/b7eh7FdnNW3fLFjkysQ/5PetpJ9shIhteGhglS1T1eFxulZspcyvgLlEyJ8QV+XIFxLEXZF2QInbkCwaHO8Dp2ROpl8cAIkQiO9hCEPWiwo9dp3+rJ07I6h+ng/01XAQZkGAvG8ANgCdeorF7XrrzyR1tE=
Received: from MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:58:57 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::86) by MW3PR05CA0030.outlook.office365.com
 (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.11 via Frontend
 Transport; Wed, 5 Jul 2023 22:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 5 Jul 2023 22:58:57 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 5 Jul 2023 17:58:54 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdkfd: add xcc instance for debugger APIs
Date: Wed, 5 Jul 2023 18:56:53 -0400
Message-ID: <20230705225655.299335-4-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705225655.299335-1-jinhuieric.huang@amd.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 86477377-e395-4dd0-0f37-08db7dab69d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XshaU6O29m/9DFtWo5LhmnTJZwmLBO1PD+C2qetdrU8MYJ4WWX8GxdZr+7vPAx/oiy0EUbyd8VHN0ix7ITdBPUZ+BdkiVrlz1GVvpoujFfvMfCkSia/MR5FQ4TIXkdfhJBGsrNTFRn4e7XcnR4EdnTgKNGiiUiFJSyEFezMvDMLi9rY1v7HI/2ahFGRUBOqvhaUlsRnsf0n3pR2llpMwy6xRCxPK/dm1tY1RoQK1a40JsNWuM04sYnXc6VpNt9RrSXHGymnCkZK+cwyPLCn5UEAvsj0H9FNV44qpQhpOuJOUvIeykcjdCstMw/PR2jRpLYop3+teqO+q6dDinBR2IQI91tjo4lGC1pD8N7acwtViI325bi5MMe/GW+/4u7GJf0opR7fCQNXm2VM1GA5kmUungZbxANP/B4gCIV7OkIJt7YIU5y+B/Kqhi9Wd0Yp30WJmyKFy7ac4osBaJtDl3jXiwC3fNvmUocrQwLItqO5IxN+ZfSa6Zv6rRxCnqGb80QWT2WulXprdZne5GC+wVf/zEyWMzLqBUL21IPUkvEQ2xwvTTsa+0v+4289TqceZlFt85ANsx+Ki+It1k+lrUFq+bSqMuX/NcXPh2TjQCTo/VsvcdXxhanlxqwJc0zwku0czUnoIM/aMGasP0r/NwacMvroxU9CKDE2UISsgcOLcFCgmG1528VJpwKguxGgDSg1fZIjVNmkqfVYOOPpWNCbkZsdem3tOYEY4/+4kNZAuxO7Mo1txLitjQTQuCW3rFLOKjYWZfVx6IB8Yk4mPfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(186003)(82740400003)(478600001)(426003)(26005)(1076003)(86362001)(336012)(2616005)(316002)(81166007)(47076005)(83380400001)(356005)(54906003)(7696005)(36860700001)(6916009)(4326008)(70206006)(70586007)(5660300002)(8936002)(8676002)(40460700003)(30864003)(41300700001)(2906002)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 22:58:57.0010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86477377-e395-4dd0-0f37-08db7dab69d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since GFX9 GPU has multiple xcc instances, this is to
implement this change in KFD for debugger APIs.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c    |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c  | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h  | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c  |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h   | 13 +++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c              |  6 ++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c  |  3 ++-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h     | 12 ++++++++----
 11 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index f3f7e0437447..c7f88bfa1976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -126,7 +126,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst )
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -163,7 +164,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 }
 
 static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
-						      uint32_t watch_id)
+						      uint32_t watch_id,
+						      uint32_t inst)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 3299e268f234..c0546db91579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -454,7 +454,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 				uint32_t watch_address_mask,
 				uint32_t watch_id,
 				uint32_t watch_mode,
-				uint32_t debug_vmid)
+				uint32_t debug_vmid,
+				uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -491,7 +492,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 }
 
 static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device *adev,
-				uint32_t watch_id)
+				uint32_t watch_id,
+				uint32_t inst)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8ad7a7779e14..04daa8f9456b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -942,7 +943,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 }
 
 uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id)
+					uint32_t watch_id,
+					uint32_t inst)
 {
 	uint32_t watch_address_cntl;
 
@@ -968,7 +970,8 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
  *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
  */
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
-					uint32_t *wait_times)
+					uint32_t *wait_times,
+					uint32_t inst)
 
 {
 	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
@@ -978,7 +981,8 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 						uint32_t wait_times,
 						uint32_t grace_period,
 						uint32_t *reg_offset,
-						uint32_t *reg_data)
+						uint32_t *reg_data,
+						uint32_t inst)
 {
 	*reg_data = wait_times;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index e6b70196071a..ebe92c55ceed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -44,12 +44,17 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id);
-void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
+					uint32_t watch_id,
+					uint32_t inst);
+void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
+				uint32_t *wait_times,
+				uint32_t inst);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data);
+					       uint32_t *reg_data,
+					       uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 91c3574ebed3..d5d0ca6a14d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -780,7 +781,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 }
 
 static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
-						uint32_t watch_id)
+						uint32_t watch_id,
+						uint32_t inst)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51d93fb13ea3..8164c499aeb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -878,7 +879,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 }
 
 uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id)
+					uint32_t watch_id,
+					uint32_t inst)
 {
 	uint32_t watch_address_cntl;
 
@@ -903,7 +905,8 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
  *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
  */
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
-					uint32_t *wait_times)
+					uint32_t *wait_times,
+					uint32_t inst)
 
 {
 	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
@@ -1100,7 +1103,8 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 		uint32_t wait_times,
 		uint32_t grace_period,
 		uint32_t *reg_offset,
-		uint32_t *reg_data)
+		uint32_t *reg_data,
+		uint32_t inst)
 {
 	*reg_data = wait_times;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 5f54bff0db49..b3832ee79064 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -89,12 +89,17 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id);
-void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
+					uint32_t watch_id,
+					uint32_t inst);
+void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
+				uint32_t *wait_times,
+				uint32_t inst);
 void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data);
+					       uint32_t *reg_data,
+					       uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index fff3ccc04fa9..dcc49183364b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -427,7 +427,8 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
 							pdd->dev->adev,
-							watch_id);
+							watch_id,
+							0);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
@@ -466,7 +467,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
-				pdd->dev->vm_info.last_vmid_kfd);
+				pdd->dev->vm_info.last_vmid_kfd,
+				0);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f515cb8f30ca..a2bff3f01359 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1621,7 +1621,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	if (dqm->dev->kfd2kgd->get_iq_wait_times)
 		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
-					&dqm->wait_times);
+					&dqm->wait_times, 0);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 29a2d0499b67..8fda16e6fee6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -298,7 +298,8 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 			pm->dqm->wait_times,
 			grace_period,
 			&reg_offset,
-			&reg_data);
+			&reg_data,
+			0);
 
 	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
 		reg_data = pm->dqm->wait_times;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index d0df3381539f..006a9d6214e9 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -315,16 +315,20 @@ struct kfd2kgd_calls {
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 	uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
-			uint32_t watch_id);
+			uint32_t watch_id,
+			uint32_t inst);
 	void (*get_iq_wait_times)(struct amdgpu_device *adev,
-			uint32_t *wait_times);
+			uint32_t *wait_times,
+			uint32_t inst);
 	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
 			uint32_t wait_times,
 			uint32_t grace_period,
 			uint32_t *reg_offset,
-			uint32_t *reg_data);
+			uint32_t *reg_data,
+			uint32_t inst);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
 			int *wave_cnt, int *max_waves_per_cu, uint32_t inst);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
-- 
2.34.1

