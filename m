Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E30C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 08:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39B810F18C;
	Wed, 19 Oct 2022 08:13:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C79C10F18C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 08:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNselobiyhr5YFluEvdzz9QfsiSSGbtnz8oKLtR8sEeVoTk1hQHCJqppiSBDjDvT5oWrbccDbYKiWa7mYih7K8ymbR277KydVClk1sfkKe8mButnceXiC6i9mnppxzY7eqBiDZchq9Zq2syIDTgwUxnJxnEsO1Wi0cNHlNCI3O1+i8gHIctt9MzAPDE1tQ7Oomr/INHtjmyJykQ3aJb2NOD8iEv3hGKpu0urnqTtfqWkLrTVcmCxcjhlmW3q9YeVcOLEKGOw2kR90sAf1pUm/aeiNGqlhdczI6aYUWm+i/e1WmC1KuRacwqqe+Mc3IGsh+ALfGBhTsecqnEO8F0Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTLt03+1mJ5qY5eEhs1x3lzKvrdwqnMD8CKzXkeJwQY=;
 b=Y0wpMEO54pshZlCb/umdLJ+Bibi5fsEVacg16caEADYtB3Iv7C916b+ot5LDiq87WnBUcysJ1w41GCbi85yGH2R/FDal1G8+3DwA3wkhqx7HvZQHEXnf+/KH1czG6Mq7UJtu+iLQVjXPYilYYSeYgHxXhqlQR9x4FTCDnkTnIn0K38ubApyEzssLQTqvcn9b749IAg0OCWPZnPKNN4jnvhM3lWh5PRmxKrbbFJdoHzoY6ko2Ned6jK6RIJzf4AAyky56zZDkHU36PfdmqOuf78EbRnw0EYonKkREhbHJCLtG1Aw0uJ6zaqNLYY4btmbvd0nZxH/uov+bTaRTTTSL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTLt03+1mJ5qY5eEhs1x3lzKvrdwqnMD8CKzXkeJwQY=;
 b=i9sLKzpMluO8e3BYNdgkDBKFZTVM52Dy+mHXqYWDb3FdZP5asT4gL0C0V5lamW3L5q1pbsB5gKXK/YrS2MSOXFzt7jN7hLHDJIdx8SNfcvBfFBJbjR/KE9VggV218vXJ36A6ByyfdOhz9jNxHjP1TvaEopf4qcP3ePWpEPzXlQU=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.23; Wed, 19 Oct 2022 08:12:58 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::5b) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6 via Frontend
 Transport; Wed, 19 Oct 2022 08:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 08:12:58 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 03:12:33 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for UMC
 poison handler
Date: Wed, 19 Oct 2022 16:11:50 +0800
Message-ID: <20221019081150.31773-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019081150.31773-1-tao.zhou1@amd.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|DM4PR12MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b93a72-2531-4443-aeb7-08dab1a9bbe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEVDleC7j2DWBpufBtn7wq8znUaCp7QhHG63+HSJIRhs1AclmL5ICw0Ib05C4Z5yUvlpAUum1k4xTZIWs2n9r+lG3YPPMerJfwaKafHHMeWExFH9gVDSDDbb9OtiS4WZM9zgTNYAl0JloSKkmevjuuaWywWxq5sGgHgCHTfGzuOzrykeP8Jhnd4wVzvh7DnTR3Nk8H6wqO4MHolRQ17gCDr/L3JIHfNx9YODywVH7SFELhgtGEBBrpArTOD8YNG5dJjrMLDJnE5aOD07zFtakje0y+blmaZelz0XOo55eTZwG3r3bp6li1xqK8AlpobIka9l+XVH9mWFhFUybVs0CckT+ozfzZmjXduM4WLBG1toePW9/U4pGHf63vt5TtTGFbXX1A+Egj2Yp3mv+Vuz86QwM3TzXlx/dm2mqeMvkigUJlXXqCZbkdJYmCJTxckmF4XgV+LeaBlWd0FilR+lP4BpQYeHeulZQuECI3gDTUdIpXTkScbYPkTDosadjRnPGDVlJfzXLubiJxuVMbPCcPnqGe86D1Pls8axGTDr+UhbN5znQ2BPdxpaTO83teuUV495lFkknVAWSbEMb1aqqQZeQI4/s2xj57nCyt5XYVxt6E7Wx9cdwCGhFEO8nv/a7D8F93SBtvSVoS1vSp3x0XXh9ZwsE2oAOXO9U90xhC/F0MvCqiJCp8NtTwY3VSBjFcYNlj4gW/PRBcXimF8onsW6cOWVXcJzpkrX7AREdN6HMP3GMVJKkcLYKw2g+XXVAQGD4pg8sJUXUXPh2ZLzyAe2llH28MZ2Eq0bDYrFqFfexBbxgIRf2K1E+vHBE7S+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(70206006)(82310400005)(8676002)(40460700003)(41300700001)(36756003)(82740400003)(4326008)(70586007)(110136005)(7696005)(36860700001)(8936002)(316002)(2906002)(478600001)(83380400001)(16526019)(2616005)(26005)(6666004)(86362001)(1076003)(6636002)(47076005)(81166007)(426003)(186003)(336012)(40480700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 08:12:58.5481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b93a72-2531-4443-aeb7-08dab1a9bbe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
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
index dd1b1a612343..c040c9104521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -179,27 +179,23 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
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

