Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E1BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 08:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E5310EF0D;
	Tue, 18 Oct 2022 08:33:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1D310EEEE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 08:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxVlj4rJ9C2GuCZ21ZtjxP6pDZ6Jc+PcWrsqtx5HBo+E0hoxZg4FFNKMBVEqamgMQntI48aVVubox3jI5+ZgndGLOx0W/MjzggrUvQrAYw/l6/poNlsEo4Tp9qu7G4tuO6sZtg53RB+LR11wm5zRTRdvY1pzB6DMHh5Pbryu8hE/VsnKt67CnnAxTnGgaFqFgaQ+mPxNenQH0Xc6H/ZOOYa7iGu4tXhYg+FWdE8fIZgXA2x4d93pHjO4G662d3tvEtsOaouIBngpllmo7gx/6QcaSdNyzKxb43QcPFvjVhn5o9TyfK56Vociunq3HYGB/R8i6lk9rjzhIDxhYtV9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KUj5JVpPizX77eTIBUuWc7Apnz/6mbHq52uFhbyAUk=;
 b=Wl+PWM763bqQmMmP8lImJU57QEbHUZPD3S2wQ54vjSUBRGS8mbMAha+VkhL1xdRV+tkRZtMVloy/t+1/Uys4wojSqz/z9hTvsKPbC/HCmoicofcDa98bc6VlPNhXqx7bqE9Ch3i8e2teuCO6LSm7y0Uu7qAJKrSKS8oU2Gp7dLVvyaVGcEV6U533l0aKEmVzsIzKL/5LG+gAuoU9Iw5Kw9tYMMdpEG4z15kl3L1XRpYzuoQj2NeNBa0MuFR+CqFq39xKeOQODoefEqRO8QvTMoSbasMOxAo68Nf7g9OtSpE2Pee1VC/vjrlnGKK7NvsPe1hJlWd8fYwBXvePbfq//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KUj5JVpPizX77eTIBUuWc7Apnz/6mbHq52uFhbyAUk=;
 b=08T4x1E29kRPwdsrn7dG1Cc+ACjPIz0evoefaqyhM89oNlmW8VxLgWxgz2hNKB2ym91wWU7PSc+bn67AxAmxLRnNPLZuml5xtlOZqwjq0FAR/Z1yd/IBKvgIgv9PUcVMVAU+FMU3Uif8Svo70YIaW6+xPnnWnoHw6WZKAWt7emU=
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Tue, 18 Oct
 2022 08:33:38 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::50) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 08:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 08:33:38 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 03:32:47 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for UMC
 poison handler
Date: Tue, 18 Oct 2022 16:32:00 +0800
Message-ID: <20221018083200.15597-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018083200.15597-1-tao.zhou1@amd.com>
References: <20221018083200.15597-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c73032-3a5a-417b-1daa-08dab0e37478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmgyiCQrRC/b0xuxGc/rAVMm0DBm7okvOk9KRVJGxFeQtqfuDKo/6+xtsMH4C40hay5x1Jttl1tkdeoIrFUchs0RjF+5mRM3P83u7AufTRO+9XvHRrOBXQ+V371LxGsaUwGGd01v5Re2uiNm38o+q/bQQYDZTSfR9rRMBCCgHDbdB2gf9P3xt/9Rv8dCEZ1rYzsGWCJWUtZKUNQS++TuDS4FQ0TLs3Y6LqKSEe1f+AXkNwbeMMIu60C7dKJiHWKMfZz9cphm0GA0NNKCozzmN6wp68b7RMv1IDqCwG+1r8HhuGVPartvqRJ4AYMzeEGPksh9HUV69qHGp8mforr14WBIGuxBCW/qfZBriTq2taVLBmfxTdBg3JrNb7y52VHqxQMllhycWomAzBYoQTUK2ZfnA+yq9D6n6t4r2m9tBnyaCBJJh+c9jX0qr6RuaUeOspDRfjOCXmiYSJZ/4Jg8Q0BsAwOtLG9EPKwLDU0tC2cEIrIEeUra+tKrJyXRzMmYSY/GDBODbLt09rnv5JVCHuGLyjq9Aqbf5rwXNqtMEaw1MJrEyPh6T7dycPRAYcgRtmFTjRP3Qym28fPLSPD6W5t3YPolm/eR0vzzVAd32c/YiJ8D2kkXMjyhcRRq9564YofRSMF6ekb115Wc8alq9RdgtbMmO2J5rHoPgL2ojKivsm4mFPO/GPEVOa6L8WoHwttmfGiWYanYfMUVSBB9yn2zoRY/86V7JwibroRqSs03bZGgP0jpKCvpaZpThQ70z1nkPvRMNv/u5fjaDQbRtndyaWH/DP6Vcayt+KCxLXuwPH0abr442POrv/T3TUyj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(82740400003)(36860700001)(26005)(4326008)(7696005)(6666004)(82310400005)(8676002)(356005)(70206006)(70586007)(83380400001)(81166007)(316002)(6636002)(110136005)(40480700001)(16526019)(41300700001)(478600001)(86362001)(40460700003)(47076005)(2906002)(186003)(2616005)(426003)(336012)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:33:38.2877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c73032-3a5a-417b-1daa-08dab0e37478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code more simple.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 16 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h    |  4 +---
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0561812aa0a4..37db39ba8718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -753,9 +753,7 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
 
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bool reset)
 {
-	struct ras_err_data err_data = {0, 0, 0, NULL};
-
-	amdgpu_umc_poison_handler(adev, &err_data, reset);
+	amdgpu_umc_poison_handler(adev, reset);
 }
 
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 28463b47ce33..693bce07eb46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1561,7 +1561,6 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 {
 	bool poison_stat = false;
 	struct amdgpu_device *adev = obj->adev;
-	struct ras_err_data err_data = {0, 0, 0, NULL};
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
 
@@ -1584,7 +1583,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	}
 
 	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_poison_handler(adev, &err_data, false);
+		amdgpu_umc_poison_handler(adev, false);
 
 	if (block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 22995f371eae..481a8d69911e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -224,27 +224,23 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	return AMDGPU_RAS_SUCCESS;
 }
 
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-		void *ras_error_status,
-		bool reset)
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
+	struct ras_err_data err_data = {0, 0, 0, NULL};
 	int ret;
 
 	if (adev->gmc.xgmi.connected_to_cpu) {
-		ret = amdgpu_umc_poison_handler_mca(adev, ras_error_status, reset);
+		ret = amdgpu_umc_poison_handler_mca(adev, &err_data, reset);
 	} else {
-		struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 		struct ras_common_if head = {
 			.block = AMDGPU_RAS_BLOCK__UMC,
 		};
 		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
-		ret =
-			amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
-
+		ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
 		if (ret == AMDGPU_RAS_SUCCESS && obj) {
-			obj->err_data.ue_count += err_data->ue_count;
-			obj->err_data.ce_count += err_data->ce_count;
+			obj->err_data.ue_count += err_data.ue_count;
+			obj->err_data.ce_count += err_data.ce_count;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 659a10de29c9..a6951160f13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -83,9 +83,7 @@ struct amdgpu_umc {
 };
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-		void *ras_error_status,
-		bool reset);
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
-- 
2.35.1

