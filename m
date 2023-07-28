Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54922EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 06:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6751B10E65B;
	Fri, 28 Jul 2023 06:49:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5230410E653
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 06:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNsmDVtutEqWZk5uUpO004Od7mAMQGGLzJyeG3XO2W6HYjdX7eqv08hxilIfgfalg/JQ/nMpdLEyTfpDaKTCBQShEov5XGn1R7Gxr4Fh1+X/QGDmcXmj+ZY5bKXUKWIVjiGh7N/reRkBp3ID0vv6RX9WhgCJAv/NSxElj7gaslFazV8ZvM6wNiQtK8sVwpA+8NfQ4t5dbtKAeM/BbH4uHazuqfSzF4bPfLBbry32I0iWFt1fVGdG7Ap/EbksStD6sUf4sbuABkvTd/SmhTOiZ/zAfo+82QEPTYH0HSxbMUo3OKD0UYvDYKMuCY4iprNxC5Rxtosc2YrDGTTeXtJ59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSKJRmbCt4BHnyUJJZR4xH32JPQQzif5pNkcNi96ym4=;
 b=V1bGNxbmMi6igmLcG6k/jXrVasaL4rz8wqUivFxfSvwYruqncNLnPjgL3HXsrqZXRp0zUfRvrFVRrehrz5OxsOJ6Pv72GyJ2z9rJ198o/OHnFyTETe42gzhGq4JsatKdrOcPJz7p5qXVf10Q30PFNQt5dQLhDp7ZT0sz8xoGhHsvPmXjXgPSpWGEb6AxBFY2tlKGxn3SqsZ4mXBRdEY6I7fTt+MeH1hiPrNpJYFm/+osZjvPhwVmnbKQDFEE0pHfMLHoLoJNMP+Dn6YC+FjfWGOkmytjH5anLkMe9P5bumFK5ACJ6a2btGIg2dvd3/1308KzeYJKa4ImJSq68g+NCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSKJRmbCt4BHnyUJJZR4xH32JPQQzif5pNkcNi96ym4=;
 b=a3a9SQ68fHYub/TPcN1RxA8zXkYrzwoYfF7NrZD778hsEtCxsc3oB3CmPenU71CPtB/VSfnS6UPyQUC3vVErARLZrPkjPWtZdtfClccpcv4EYHSHmIV8uBoCDZNlY72foHYTfaHMdSjxQnahfjYOALEk6/FCf5VgTRu17/wDSmk=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:49:47 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::22) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Fri, 28 Jul 2023 06:49:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:49:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Use nbio callback for nv and soc21
Date: Fri, 28 Jul 2023 12:19:12 +0530
Message-ID: <20230728064912.3652140-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728064912.3652140-1-lijo.lazar@amd.com>
References: <20230728064912.3652140-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: bdea54f5-01ea-4e03-edd2-08db8f36d52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0dyZFqV6sSn0mWeO8tIZb9qEgghgzBowyhjTaXUCohY+0LqMRKGXGWLRvQDhxjoaTcauH32+70XrjCpvz8AqdzX1o2hHZJq8USR+VZSnRotpVCmUkO23z9vOhuciORpyvctxJYjeGvqOQDiaghnonEm9zrkeXkZxGEyM0xkRfx2EDx2OZG/JsUCSghQzqhwMAAfb/XICFjaHbYKykjN5iRvk0ObQD86xpTNOCUfVgR8BSRZs8PNVmpuaBgnwG5jg8CCbeBVIRsVxMCUEN+wDpJX5KqMaXECcP9rH6w38WRSVinO7xwE7HwvikbXjkhkjJaQz5asvWxw9PkAld/jJoT/laNfxRXcumMA19irx+kpCzfzr99R0En6ynPRjR1HaENyWbOFr4qjTGCCP9FmnZuOZbVp7cfTyBiOOuv/fhzic1TZndaCbaZBb8Dq+ZroAHUXH4YFeHnvn+/jiB+6RG0Ip/63liTazsmldXz1oriC3CLsxzuSpu4EJbs3RyZLRNQgxmarP5sem2TUpziumhYXizqeXr5je+ug+xAkkhblkF2Dxxa5JtrYfFnm+mRm2nKESKx1JuT3ZW2BMo4cU7eChgLsHu1RzW7ShR8SlfJl1XC+b7QlosL3Wzo2ErL91Xn/P+Ez0Ao8X/+9qeug3nH56B0/3ByaKeudMI7GRzMDgzzfHi8gW+gTd0ajgUDYIQ3UcquhApav2mNvsGn3GdzlLJ69Sg4+ApMSgZCbN2fFj8PKT0qqCmdlurkgF1vO6h3C55vapmuH3J/waHFTcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(2616005)(40480700001)(47076005)(426003)(83380400001)(356005)(86362001)(81166007)(36860700001)(82740400003)(36756003)(5660300002)(44832011)(316002)(40460700003)(4326008)(6916009)(41300700001)(8676002)(8936002)(6666004)(186003)(70206006)(336012)(16526019)(70586007)(26005)(478600001)(54906003)(7696005)(1076003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:49:46.9486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdea54f5-01ea-4e03-edd2-08db8f36d52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the new ascis to follow nbio callback method to get pcie replay
count.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 12 +-----------
 drivers/gpu/drm/amd/amdgpu/soc21.c | 12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 51523b27a186..7f1a17c79abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -572,16 +572,6 @@ static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 	return false;
 }
 
-static uint64_t nv_get_pcie_replay_count(struct amdgpu_device *adev)
-{
-
-	/* TODO
-	 * dummy implement for pcie_replay_count sysfs interface
-	 * */
-
-	return 0;
-}
-
 static void nv_init_doorbell_index(struct amdgpu_device *adev)
 {
 	adev->doorbell_index.kiq = AMDGPU_NAVI10_DOORBELL_KIQ;
@@ -656,7 +646,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.init_doorbell_index = &nv_init_doorbell_index,
 	.need_full_reset = &nv_need_full_reset,
 	.need_reset_on_init = &nv_need_reset_on_init,
-	.get_pcie_replay_count = &nv_get_pcie_replay_count,
+	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
 	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e5e5d68a4d70..60f219de8332 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -484,16 +484,6 @@ static bool soc21_need_reset_on_init(struct amdgpu_device *adev)
 	return false;
 }
 
-static uint64_t soc21_get_pcie_replay_count(struct amdgpu_device *adev)
-{
-
-	/* TODO
-	 * dummy implement for pcie_replay_count sysfs interface
-	 * */
-
-	return 0;
-}
-
 static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 {
 	adev->doorbell_index.kiq = AMDGPU_NAVI10_DOORBELL_KIQ;
@@ -561,7 +551,7 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs =
 	.init_doorbell_index = &soc21_init_doorbell_index,
 	.need_full_reset = &soc21_need_full_reset,
 	.need_reset_on_init = &soc21_need_reset_on_init,
-	.get_pcie_replay_count = &soc21_get_pcie_replay_count,
+	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
 	.pre_asic_init = &soc21_pre_asic_init,
 	.query_video_codecs = &soc21_query_video_codecs,
-- 
2.25.1

