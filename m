Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330BCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 11:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81B210F238;
	Wed, 20 Apr 2022 11:30:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D63810F238
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 11:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csnrQ/Pbm4gbzsCfeQYHXLAzLT6wmximOOxkrJpzrBFjfE/Q9DScS5IbLahclLhJ/nBrE85OKfeNVpDbyGBNeLw1cEOIwGiBD6rNmgmBnb2Vj9EJXASMxkhaWnylkGM5rUhgqQjymEWAi6hKb0ZrpiKrXSoawtbQimt/Hoe2m0frXa+JJz08QUG8EciT3f8/8aX5tV3c3C1/gSUW10ix/PpuCdiNrbpqn48dhdWdUwCyAV0nm5MDid/j777t+GjbZzokyPB0KeAusmQXP23Q5435zsSmIhEghrA+i3xnjqwz0koNtBiq/MobYHaqb+1BZy6aWEDQ+R9R6RHQqNhKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ynsuhon2zPANohH1IoDn2nprWcvuJZQ+4kb9msh3b68=;
 b=bG+BnKa4BT+jzfPup2kgJ2iC/gFO7qAVVNoK9AG1TIjYxU/rdz8T9Nptfq+XgkwlG8rLvBybxA69OZRudDRwIPU4DeUK8bxQZPoNkcPHd23lecmoWLtZlt3OouDBVWzKxiO5nD3MMlZQUuufI7FL6nnUlPEu8KBMm7c5TUJuev9j/duc7A7+CLaEUij5ca4pqOG0/ArAUYXGX/n8dwfszk4rCIJKaENVBuk19JNrwBQov/LOvLYCzNWa0UuuwsTUotjI8BW0XUHHcks8hWe2dUFKbOwVGO4GaD4UHgWLqgijaTuLUteKUSqPgoPCFhf/DLDkpjdTewzxB10SPb4DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynsuhon2zPANohH1IoDn2nprWcvuJZQ+4kb9msh3b68=;
 b=5R/B7MjsMkEOYrBRbDt+2mjy/DQxBYMMlQzpMLbYsyDzGQtjbJbU624BJ9KNmh1YbA4cLejM/mLhRk+KV4JGeW7Y6PdMDqt545MChuj0MB2d8WgP84UeaWawVAqmc4T4lqXOGLqggCMjFICtQZxOI2SEOP6MwkIwRvLnjhL0hyk=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 11:30:26 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ef) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 11:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 11:30:26 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 06:30:23 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Lijo.Lazar@amd.com>, <Mohammadzafar.Ziya@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
Date: Wed, 20 Apr 2022 19:30:07 +0800
Message-ID: <20220420113009.8062-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291a9f90-354f-411c-91be-08da22c12a54
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5294C9B7259A70D79FFE6C35B0F59@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXjNp+Yx+ZWrPBY/m9b8IB0XVbUvNPSwNLdLOHoNIaNXJw65Hr4HkIiuTe80FQv6cI318SWwq66oRWEYEPmkYUQHs1A5hLt+H5JMqKXM/2VwiRRsb0EWolL+00KaHSypLnasF7VkNaImDR9sB/c5Se/x+ffIivnD5eN/w+mm7HydzvMFKovpoZviCv7EvMiaGDYd8hB1a93hc/0FozIQM1OHOdE/QLmGosRspnB4pSPhcDM0IPa6u7128NCVeUpOiDW2jC01pRqz+xhtTPk5mlSoSBuQFuv6gMbbXhHFqFRdDCyuS8G3ouOKDgEIT3olNaVX9m0zQ9wM5sZc0WreNduG+sxaAV8vFdQn1+T5E2BGLyJsah4EGomU31uOMeH0tiXYtAVecSQOsDqX36dhnSTO5FwVCqltffE5FoZP+Cgwp3yWNOejF4DGEXobqZ55Rkz5kh/fw/gwwQFW9DkE1+x5L014Pvppo8kosUiA1pLXyIDLtq825krJMX9YrBZDSjCfnJyKR13oFx8ZIAoGxUCffYTDHA++WrrcPVG2C/78VrHvxbQN0o5yWz+7GOKLhRC6NVfVzs7UtUH5mYoNeAoR6ts/XH91dk6kSFbbnLwWfXWWkoqT5tIn6BUJdpDp6z4gK3H09RoQ469TepvzQdGF7yv7VAhREmUEu3Dyqdq/IXkj6VhFS1S2SZsjVDTsl1ZC+8B/PH4AZut5GTndWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6636002)(70586007)(6666004)(47076005)(336012)(316002)(86362001)(36860700001)(83380400001)(426003)(40460700003)(70206006)(186003)(16526019)(26005)(356005)(110136005)(508600001)(5660300002)(36756003)(4326008)(8936002)(2616005)(82310400005)(8676002)(1076003)(81166007)(7696005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:30:26.0251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291a9f90-354f-411c-91be-08da22c12a54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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

Prepare for the implementation of poison consumption handler.

v2: separate umc handler from poison creation.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 70 ++++++++++++++++---------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4bbed76b79c8..22477f76913a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,12 +1515,45 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 /* ras fs end */
 
 /* ih begin */
+static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
+				struct amdgpu_iv_entry *entry)
+{
+	dev_info(obj->adev->dev,
+		"Poison is created, no user action is needed.\n");
+}
+
+static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
+				struct amdgpu_iv_entry *entry)
+{
+	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	int ret;
+
+	if (!data->cb)
+		return;
+
+	/* Let IP handle its data, maybe we need get the output
+	 * from the callback to update the error type/count, etc
+	 */
+	ret = data->cb(obj->adev, &err_data, entry);
+	/* ue will trigger an interrupt, and in that case
+	 * we need do a reset to recovery the whole system.
+	 * But leave IP do that recovery, here we just dispatch
+	 * the error.
+	 */
+	if (ret == AMDGPU_RAS_SUCCESS) {
+		/* these counts could be left as 0 if
+		 * some blocks do not count error number
+		 */
+		obj->err_data.ue_count += err_data.ue_count;
+		obj->err_data.ce_count += err_data.ce_count;
+	}
+}
+
 static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 {
 	struct ras_ih_data *data = &obj->ih_data;
 	struct amdgpu_iv_entry entry;
-	int ret;
-	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	while (data->rptr != data->wptr) {
 		rmb();
@@ -1531,30 +1564,15 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 		data->rptr = (data->aligned_element_size +
 				data->rptr) % data->ring_size;
 
-		if (data->cb) {
-			if (amdgpu_ras_is_poison_mode_supported(obj->adev) &&
-			    obj->head.block == AMDGPU_RAS_BLOCK__UMC)
-				dev_info(obj->adev->dev,
-						"Poison is created, no user action is needed.\n");
-			else {
-				/* Let IP handle its data, maybe we need get the output
-				 * from the callback to udpate the error type/count, etc
-				 */
-				memset(&err_data, 0, sizeof(err_data));
-				ret = data->cb(obj->adev, &err_data, &entry);
-				/* ue will trigger an interrupt, and in that case
-				 * we need do a reset to recovery the whole system.
-				 * But leave IP do that recovery, here we just dispatch
-				 * the error.
-				 */
-				if (ret == AMDGPU_RAS_SUCCESS) {
-					/* these counts could be left as 0 if
-					 * some blocks do not count error number
-					 */
-					obj->err_data.ue_count += err_data.ue_count;
-					obj->err_data.ce_count += err_data.ce_count;
-				}
-			}
+		if (amdgpu_ras_is_poison_mode_supported(obj->adev)) {
+			if (obj->head.block == AMDGPU_RAS_BLOCK__UMC)
+				amdgpu_ras_interrupt_poison_creation_handler(obj, &entry);
+		} else {
+			if (obj->head.block == AMDGPU_RAS_BLOCK__UMC)
+				amdgpu_ras_interrupt_umc_handler(obj, &entry);
+			else
+				dev_warn(obj->adev->dev,
+					"No RAS interrupt handler for non-UMC block with poison disabled.\n");
 		}
 	}
 }
-- 
2.35.1

