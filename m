Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7712FC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F3410E712;
	Wed, 10 Jan 2024 08:39:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BA210E712
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 08:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0yq8XojuJ/kPkOSb+UvHUi2S0zM5R8As6xfy7u89UXuXqvG+0rP00FV0b9rmDQlxnkE83e0SJdMdepf6QSBi1JRsCbiQen1o4sYTBVhEul/hQBilteoYo9Fl7Otw1wLJN+S1234VIpat760sLquGVzEg8fNaMswZsluqo0m0k/PF6SBfwamWrOkWoWCaB5wxPgU5buQV2bLSaR4QX1OVXlmqkN8uNeDNIHu4OwjXuyyAlTEzQ0fHccnTdX1Y8maAHoZtuZYhIayiu+vGU/4ZTyGPKy34NRQjdUqT1BMAJhSzvvac+Zkp2jc27juwS4Tz9HSxfm/HiBsAOaCr+1Khg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TckZIQ7vnAIjGsinl3M/B9pC6o77S78Zj9An3fSPcus=;
 b=FhyMmSgdvUD5eyEtaNp7CjWvp8L1UMFGutzJt9lVldQ5UlFsZh4c/SZ9jo+0GGu0TCPteSZjzsmGniP/Atho4xpDcRXVb+AaV2+mqCr3cYruELatsXX0sUcayvh6hTieHU2EpG4OCcOn0icym73wgNFpfvHutSizQV+NT1VZ3gtxBAzfWqjpC/hqprmO0KIa5QUG5oGJMn6sCW4FpWT3lZAN0Z6TT02nflRQOK8JHcSL+g94rg3pXgl5+gCkQHRUgzuufpALVYoSZuUj4qEzurhMSRyiM847224nA0JrlCk1OPCs9GzUf+TjrTofLhAmCIXsgYzM/iTy+swgZeBA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TckZIQ7vnAIjGsinl3M/B9pC6o77S78Zj9An3fSPcus=;
 b=CbLFcWNFFq/yoTOIbOiJAnqOc39wd5ehb6iBOoPH4CuZtT0Spd1fsz17byirrTidqM3ZZjp4UtMBD6a+6FhuNlpAQAz+zPtaYmd1oIt2R2cwnwxzXxQ6g7edfxI6f5wR+EPp1EGRQ04yLQjkEzz+NeM5Lj1HTSISjgxiJ143WhU=
Received: from BYAPR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:40::15)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 08:39:28 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::39) by BYAPR04CA0002.outlook.office365.com
 (2603:10b6:a03:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 08:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 08:39:27 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 02:39:26 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Log deferred error separately
Date: Wed, 10 Jan 2024 16:38:55 +0800
Message-ID: <20240110083856.412858-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b97088-bdec-4cb6-2813-08dc11b7a832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bBEQFVXerAxdxMTmQvusi2L7Uf3Dqlie+pocuEC+RHPQVABZtHqyMf303SNkcBfKT6EltiY7QzDuvYyuu9yZFk3I96je5ycEzVJ5Fi+6MAjz00mAqS64D+hQF9AWHJNYJTlWvhBSuaeB8ljoRotGfQIJsWuWyB98/2xwm5zS8auv6D/PIovOOts7uaCrpdl1sz1eR0CW3rGHeaAJT3gTlYFus6ADodQKmATL+IKs9+uC7c68Ja9rgLdns9kP6UUUAiPoicPrnVQk/y2YLVLeXCjhqg3xhSeGfp89Z5NESd/xeYu1yfEMARMgnc1ctFXgMx6mVD5GcUb9MM5JP+PmZWoE03dx/+d4YgqbYcTkkSJOS1y92l0hxeZdui+0GgVy84Qx2IABgSnKMALs41xuEsL5WAJxkrAtVCw/IIKl7UzFvgFTgxgzsWaZtHNhFnqvpcCCvpRYDa+v9M0gWu2oHldnn5pP5SONvaKcwKf3fPYVy6fJBEjEtGyNUc7/9uNHg/P6/It+x7WDUsfwHRJkGRtB/ncXWl+RHN87SgyknZp5liSznNljjffWQJ0y9cpDYCX4Ura9KJS8J+rUrIBvdkXrDN+n2JUbY9i4toPvZkh9TUgRwmyTaLVqI4AJOqeCFYvoRgq61FORnclvwL4n/0SMWzq9I+CEJS11gn+SYucNnUkBZ2XaXLQLtaL7Xw1LESlfQsCOry35rrbJbcLBIfHrhWJtzzwqUGAtqViYKyBRjNYI0DifLw1PSUD9AJFrzBk7nlwVpMkMfMbrK0Rjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(426003)(1076003)(336012)(2616005)(26005)(30864003)(47076005)(36860700001)(16526019)(44832011)(4326008)(8936002)(8676002)(2906002)(6666004)(5660300002)(478600001)(7696005)(6916009)(70586007)(316002)(70206006)(41300700001)(81166007)(86362001)(36756003)(356005)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:39:27.7533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b97088-bdec-4cb6-2813-08dc11b7a832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Separate deferred error from UE and CE and log it
individually.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 116 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        |  60 ++++-----
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h        |   3 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   6 +-
 7 files changed, 142 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 59fafb8392e0ba..666fd8fa39ad5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -256,9 +256,14 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 		if (type == AMDGPU_MCA_ERROR_TYPE_UE)
 			amdgpu_ras_error_statistic_ue_count(err_data,
 				&mcm_info, &err_addr, (uint64_t)count);
-		else
-			amdgpu_ras_error_statistic_ce_count(err_data,
-				&mcm_info, &err_addr, (uint64_t)count);
+		else {
+			if (!!(MCA_REG__STATUS__DEFERRED(entry->regs[MCA_REG_IDX_STATUS])))
+				amdgpu_ras_error_statistic_de_count(err_data,
+					&mcm_info, &err_addr, (uint64_t)count);
+			else
+				amdgpu_ras_error_statistic_ce_count(err_data,
+					&mcm_info, &err_addr, (uint64_t)count);
+		}
 	}
 
 out_mca_release:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ded19182dc792a..94ba10b4184349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1036,7 +1036,8 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 					      struct ras_manager *ras_mgr,
 					      struct ras_err_data *err_data,
 					      const char *blk_name,
-					      bool is_ue)
+					      bool is_ue,
+					      bool is_de)
 {
 	struct amdgpu_smuio_mcm_config_info *mcm_info;
 	struct ras_err_node *err_node;
@@ -1065,25 +1066,50 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 		}
 
 	} else {
-		for_each_ras_error(err_node, err_data) {
-			err_info = &err_node->err_info;
-			mcm_info = &err_info->mcm_info;
-			if (err_info->ce_count) {
+		if (is_de) {
+			for_each_ras_error(err_node, err_data) {
+				err_info = &err_node->err_info;
+				mcm_info = &err_info->mcm_info;
+				if (err_info->de_count) {
+					dev_info(adev->dev, "socket: %d, die: %d, "
+						"%lld new deferred hardware errors detected in %s block\n",
+						mcm_info->socket_id,
+						mcm_info->die_id,
+						err_info->de_count,
+						blk_name);
+				}
+			}
+
+			for_each_ras_error(err_node, &ras_mgr->err_data) {
+				err_info = &err_node->err_info;
+				mcm_info = &err_info->mcm_info;
 				dev_info(adev->dev, "socket: %d, die: %d, "
-					 "%lld new correctable hardware errors detected in %s block\n",
-					 mcm_info->socket_id,
-					 mcm_info->die_id,
-					 err_info->ce_count,
-					 blk_name);
+					"%lld deferred hardware errors detected in total in %s block\n",
+					mcm_info->socket_id, mcm_info->die_id,
+					err_info->de_count, blk_name);
+			}
+		} else {
+			for_each_ras_error(err_node, err_data) {
+				err_info = &err_node->err_info;
+				mcm_info = &err_info->mcm_info;
+				if (err_info->ce_count) {
+					dev_info(adev->dev, "socket: %d, die: %d, "
+						"%lld new correctable hardware errors detected in %s block\n",
+						mcm_info->socket_id,
+						mcm_info->die_id,
+						err_info->ce_count,
+						blk_name);
+				}
 			}
-		}
 
-		for_each_ras_error(err_node, &ras_mgr->err_data) {
-			err_info = &err_node->err_info;
-			mcm_info = &err_info->mcm_info;
-			dev_info(adev->dev, "socket: %d, die: %d, "
-				 "%lld correctable hardware errors detected in total in %s block\n",
-				 mcm_info->socket_id, mcm_info->die_id, err_info->ce_count, blk_name);
+			for_each_ras_error(err_node, &ras_mgr->err_data) {
+				err_info = &err_node->err_info;
+				mcm_info = &err_info->mcm_info;
+				dev_info(adev->dev, "socket: %d, die: %d, "
+					"%lld correctable hardware errors detected in total in %s block\n",
+					mcm_info->socket_id, mcm_info->die_id,
+					err_info->ce_count, blk_name);
+			}
 		}
 	}
 }
@@ -1102,7 +1128,8 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 
 	if (err_data->ce_count) {
 		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, blk_name, false);
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data,
+							  blk_name, false, false);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
@@ -1124,7 +1151,8 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 
 	if (err_data->ue_count) {
 		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, blk_name, true);
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data,
+							  blk_name, true, false);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
@@ -1144,6 +1172,28 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 		}
 	}
 
+	if (err_data->de_count) {
+		if (err_data_has_source_info(err_data)) {
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data,
+							  blk_name, false, true);
+		} else if (!adev->aid_mask &&
+			   adev->smuio.funcs &&
+			   adev->smuio.funcs->get_socket_id &&
+			   adev->smuio.funcs->get_die_id) {
+			dev_info(adev->dev, "socket: %d, die: %d "
+				 "%ld deferred hardware errors "
+				 "detected in %s block\n",
+				 adev->smuio.funcs->get_socket_id(adev),
+				 adev->smuio.funcs->get_die_id(adev),
+				 ras_mgr->err_data.de_count,
+				 blk_name);
+		} else {
+			dev_info(adev->dev, "%ld deferred hardware errors "
+				 "detected in %s block\n",
+				 ras_mgr->err_data.de_count,
+				 blk_name);
+		}
+	}
 }
 
 static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, struct ras_err_data *err_data)
@@ -1154,7 +1204,8 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 	if (err_data_has_source_info(err_data)) {
 		for_each_ras_error(err_node, err_data) {
 			err_info = &err_node->err_info;
-
+			amdgpu_ras_error_statistic_de_count(&obj->err_data,
+					&err_info->mcm_info, NULL, err_info->de_count);
 			amdgpu_ras_error_statistic_ce_count(&obj->err_data,
 					&err_info->mcm_info, NULL, err_info->ce_count);
 			amdgpu_ras_error_statistic_ue_count(&obj->err_data,
@@ -1164,6 +1215,7 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 		/* for legacy asic path which doesn't has error source info */
 		obj->err_data.ue_count += err_data->ue_count;
 		obj->err_data.ce_count += err_data->ce_count;
+		obj->err_data.de_count += err_data->de_count;
 	}
 }
 
@@ -1239,6 +1291,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 
 	info->ue_count = obj->err_data.ue_count;
 	info->ce_count = obj->err_data.ce_count;
+	info->de_count = obj->err_data.de_count;
 
 	amdgpu_ras_error_generate_report(adev, info, &err_data);
 
@@ -1951,6 +2004,7 @@ static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
 		 */
 		obj->err_data.ue_count += err_data.ue_count;
 		obj->err_data.ce_count += err_data.ce_count;
+		obj->err_data.de_count += err_data.de_count;
 	}
 
 	amdgpu_ras_error_data_fini(&err_data);
@@ -3782,6 +3836,28 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 	return 0;
 }
 
+int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
+		struct amdgpu_smuio_mcm_config_info *mcm_info,
+		struct ras_err_addr *err_addr, u64 count)
+{
+	struct ras_err_info *err_info;
+
+	if (!err_data || !mcm_info)
+		return -EINVAL;
+
+	if (!count)
+		return 0;
+
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info, err_addr);
+	if (!err_info)
+		return -EINVAL;
+
+	err_info->de_count += count;
+	err_data->de_count += count;
+
+	return 0;
+}
+
 #define mmMP0_SMN_C2PMSG_92	0x1609C
 #define mmMP0_SMN_C2PMSG_126	0x160BE
 static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 9edc3909f17d7a..fae53d87578bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -476,6 +476,7 @@ struct ras_err_info {
 	struct amdgpu_smuio_mcm_config_info mcm_info;
 	u64 ce_count;
 	u64 ue_count;
+	u64 de_count;
 	struct ras_err_addr err_addr;
 };
 
@@ -487,6 +488,7 @@ struct ras_err_node {
 struct ras_err_data {
 	unsigned long ue_count;
 	unsigned long ce_count;
+	unsigned long de_count;
 	unsigned long err_addr_cnt;
 	struct eeprom_table_record *err_addr;
 	u32 err_list_count;
@@ -562,6 +564,7 @@ struct ras_query_if {
 	struct ras_common_if head;
 	unsigned long ue_count;
 	unsigned long ce_count;
+	unsigned long de_count;
 };
 
 struct ras_inject_if {
@@ -833,5 +836,8 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 		struct amdgpu_smuio_mcm_config_info *mcm_info,
 		struct ras_err_addr *err_addr, u64 count);
+int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
+		struct amdgpu_smuio_mcm_config_info *mcm_info,
+		struct ras_err_addr *err_addr, u64 count);
 void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index d65e21914d8c4a..848df7acdd3210 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -210,6 +210,7 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 		if (ret == AMDGPU_RAS_SUCCESS && obj) {
 			obj->err_data.ue_count += err_data.ue_count;
 			obj->err_data.ce_count += err_data.ce_count;
+			obj->err_data.de_count += err_data.de_count;
 		}
 
 		amdgpu_ras_error_data_fini(&err_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 7458a218e89db1..7cabdcaf0f7e3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -89,12 +89,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 		umc_v12_0_reset_error_count_per_channel, NULL);
 }
 
+bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
+{
+	return (amdgpu_ras_is_poison_mode_supported(adev) &&
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1));
+}
+
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
-	if (amdgpu_ras_is_poison_mode_supported(adev) &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1))
-		return true;
+	if (umc_v12_0_is_deferred_error(adev, mc_umc_status))
+		return false;
 
 	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
@@ -104,9 +109,7 @@ bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_um
 
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
-	if (amdgpu_ras_is_poison_mode_supported(adev) &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1))
+	if (umc_v12_0_is_deferred_error(adev, mc_umc_status))
 		return false;
 
 	return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
@@ -119,29 +122,10 @@ bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_
 		!(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));
 }
 
-static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *adev,
+static void umc_v12_0_query_error_count_per_type(struct amdgpu_device *adev,
 						   uint64_t umc_reg_offset,
-						   unsigned long *error_count)
-{
-	uint64_t mc_umc_status;
-	uint64_t mc_umc_status_addr;
-
-	mc_umc_status_addr =
-		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
-
-	/* Rely on MCUMC_STATUS for correctable error counter
-	 * MCUMC_STATUS is a 64 bit register
-	 */
-	mc_umc_status =
-		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
-
-	if (umc_v12_0_is_correctable_error(adev, mc_umc_status))
-		*error_count += 1;
-}
-
-static void umc_v12_0_query_uncorrectable_error_count(struct amdgpu_device *adev,
-						      uint64_t umc_reg_offset,
-						      unsigned long *error_count)
+						   unsigned long *error_count,
+						   check_error_type_func error_type_func)
 {
 	uint64_t mc_umc_status;
 	uint64_t mc_umc_status_addr;
@@ -149,11 +133,11 @@ static void umc_v12_0_query_uncorrectable_error_count(struct amdgpu_device *adev
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
 
-	/* Check the MCUMC_STATUS. */
+	/* Check MCUMC_STATUS */
 	mc_umc_status =
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
 
-	if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status))
+	if (error_type_func(adev, mc_umc_status))
 		*error_count += 1;
 }
 
@@ -162,7 +146,7 @@ static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
 					uint32_t ch_inst, void *data)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)data;
-	unsigned long ue_count = 0, ce_count = 0;
+	unsigned long ue_count = 0, ce_count = 0, de_count = 0;
 
 	/* NOTE: node_inst is converted by adev->umc.active_mask and the range is [0-3],
 	 * which can be used as die ID directly */
@@ -174,11 +158,16 @@ static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
 	uint64_t umc_reg_offset =
 		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
 
-	umc_v12_0_query_correctable_error_count(adev, umc_reg_offset, &ce_count);
-	umc_v12_0_query_uncorrectable_error_count(adev, umc_reg_offset, &ue_count);
+	umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
+					    &ce_count, umc_v12_0_is_correctable_error);
+	umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
+					    &ue_count, umc_v12_0_is_uncorrectable_error);
+	umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
+					    &de_count, umc_v12_0_is_deferred_error);
 
 	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
 	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_count);
+	amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, NULL, de_count);
 
 	return 0;
 }
@@ -392,7 +381,8 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 		if (!mc_umc_status)
 			continue;
 
-		if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)) {
+		if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) ||
+		    umc_v12_0_is_deferred_error(adev, mc_umc_status)) {
 			uint64_t mca_addr, err_addr, mca_ipid;
 			uint32_t InstanceIdLo;
 			struct amdgpu_smuio_mcm_config_info *mcm_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index e8de3a92251a2c..5973bfb14fceec 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -121,9 +121,12 @@
 			(((_ipid_lo) >> 12) & 0xF))
 #define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
 
+bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 
+typedef bool (*check_error_type_func)(struct amdgpu_device *adev, uint64_t mc_umc_status);
+
 extern const uint32_t
 	umc_v12_0_channel_idx_tbl[]
 			[UMC_V12_0_UMC_INSTANCE_NUM]
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2cb4..f13f957c8ac195 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2553,9 +2553,9 @@ static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 		return 0;
 	}
 
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(adev, status0))
-		*count = 1;
-	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && umc_v12_0_is_correctable_error(adev, status0))
+	if ((type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(adev, status0)) ||
+	    (type == AMDGPU_MCA_ERROR_TYPE_CE && (umc_v12_0_is_correctable_error(adev, status0) ||
+	     umc_v12_0_is_deferred_error(adev, status0))))
 		*count = 1;
 
 	return 0;
-- 
2.25.1

