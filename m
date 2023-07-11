Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC8DEB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 14:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2444E10E3BA;
	Tue, 11 Jul 2023 14:28:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFF410E3B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 14:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXN5mXtRzYGgDLaQHSNpEXynrfpvWmbc0EUBe2XqWK6WysroPMj9VyenYvzpMYpqr/uBlq96Xfx3MjbAAT2rJSf5kisVj77RxBWMx8Z4949Y9jwzzH4FJoqsER79mZ6minwlIz0BWlBcpVaMS7fNQjYk1CQDh1BYskO46kgMJywXi8LV4lI8FpXf6lTgH0fcwi5nh4kPMOxotaUCHd6WcUC3h3Xen8BKHgdG8eVIdWcKyk+bTNDe2NuJmVBo9qqol4Osb+cyojnw3njJ6dKaK7LaER5J2uor6liYiAWL8RAoy/a5HugMvILQgvDwXEjpqNqiqYRQbD9eOPkkBAlUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIynoUfRwVWtCyBVwJvBNOzjG9lztuLl8xD99NkBktI=;
 b=Y1mpoOMfRnOntZnsUaDNdrUQ73/Bs7T+MEjHN797D8DdtfVsk86Z1s5AlxqXvyluEc2Y18Igo7TVJCcITJ1CAQzM8SYODpw9vvMaL/trP135ytx75EohhPtqRNW+GthR8CHHHVzBxaqzOoDQJDqg4bm81JmfH5tjyYkV0V1/vGCERTNw+ym2Kxeeyo56tzcoDCmk0x+uYA4ha9QXyKorfTYQqXoCxmukpCtOrhogSHq222B6qWDxZTiRaLbFoaaFaNoHEWF8KcJYiDcBwPBBMfMILyyUdEllaOLpcS5AjGGsVxuQc2tGLowuk5mtJzKCCq6n1JuFd0On6GKRKHthQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIynoUfRwVWtCyBVwJvBNOzjG9lztuLl8xD99NkBktI=;
 b=Gs4m6b0n7B7y+k1YzbPYMnBcGDlSLcCBNOddtKXuIEAKo1+UXXkifcSNa2Ui10eIYOFvUjAV+8QJ8rX/oo80HKwnkFhO2KY25+PDOsQrRSBSvFrIhEktib0wkeXpsOV57xtg66t5HR2tmL4mKAZn7TJhRxJTCe7eIauvTgai3oQ=
Received: from MW3PR06CA0003.namprd06.prod.outlook.com (2603:10b6:303:2a::8)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 14:28:25 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::3b) by MW3PR06CA0003.outlook.office365.com
 (2603:10b6:303:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 14:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 14:28:25 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 09:28:24 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable grace period for xcp instance
Date: Tue, 11 Jul 2023 10:28:07 -0400
Message-ID: <20230711142807.68327-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 891c940a-4eb6-4361-28aa-08db821b1644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yvHOqi0u7y7mpmJWq3xMb3WQWnYjrZVp7QErAW1wOWYyDIcJBY0vhirSmyIdW7i/RxMp5nrbUrVvE8GXOHkiROfoDM5MF899qQG6AeAjPMrb7j2BoTWE+3ARCk9SeWAmGPKhyia6Rjy7fFKrtQl1PumnFBfcja1QI9i302VL595jVKfOeR8/sMjjM4GGB54FRh9iTnJ4Xh4M45ts3fWhA3f43Va4ueMedUmDavCmTkXUUMO+tJY4OT8xsb70e6X0Z7AhgW5yHC/YmJyWm8VNqYkkMWKoyCH/CqK6jwzavtTMgStqIlOqKXa1tE+l0EWpCm/g7AovrCy2bcrw90KZ9FliXfqiWi5p2pq/W8HjTcbVg9Kkh2mFjtwhlRK/9WUam4Smn91qCTpF3rD6TWPbpsLm2SsvMnimRa+1Pl/B1PnW0tFNE0A827wpKW6Viktu3uF8ikQm/scSIcl/k5cV2WUbWFDT2QVILSj2E9wGBCPBuyiH4E6+npNaW/2QNvctxM+GEUtutMRRCotz1ztRglDqH/xnfiFqMkl+qYbOS0a9d6J8VwS2Z8rXPeRUut48kyIRWt5yy6s8B66TRDF3sJiAnetCiINRb0tUmaGwGobVdLPyh8MUo4n6ubtx8eMXZ0VHdQDmWyHV2g2KzIADFvuirBWXj0+o8lwfyJlotO5U1zSIsaGwaEmZAj4izQsM73AZa6yQRXDjAyyXe9qLqHqr1RKZx07Q2gWRCnJgLtxTotuUEwjcwYUwq927smAheI885O08gQ+5c4GSOSFsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(5660300002)(8936002)(8676002)(41300700001)(316002)(82310400005)(2906002)(70206006)(70586007)(6916009)(4326008)(81166007)(356005)(82740400003)(54906003)(83380400001)(6666004)(7696005)(478600001)(36860700001)(26005)(16526019)(186003)(2616005)(1076003)(47076005)(40460700003)(40480700001)(36756003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 14:28:25.0632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891c940a-4eb6-4361-28aa-08db821b1644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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

Read/write grace period from/to first xcc instance of
xcp in kfd node.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 ++++++++++++-------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  8 ++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 31cac1fd0d58..9000c4b778fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1619,10 +1619,14 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	init_sdma_bitmaps(dqm);
 
-	if (dqm->dev->kfd2kgd->get_iq_wait_times)
+	if (dqm->dev->kfd2kgd->get_iq_wait_times) {
+		u32 first_inst = dqm->dev->xcp->id *
+				 dqm->dev->adev->gfx.num_xcc_per_xcp;
 		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
-					&dqm->wait_times,
-					ffs(dqm->dev->xcc_mask) - 1);
+					&dqm->wait_times[first_inst],
+					first_inst);
+	}
+
 	return 0;
 }
 
@@ -1675,13 +1679,16 @@ static int start_cpsch(struct device_queue_manager *dqm)
 						grace_period);
 		if (retval)
 			pr_err("Setting grace timeout failed\n");
-		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
+		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info) {
+			u32 first_inst = dqm->dev->xcp->id *
+					 dqm->dev->adev->gfx.num_xcc_per_xcp;
 			/* Update dqm->wait_times maintained in software */
 			dqm->dev->kfd2kgd->build_grace_period_packet_info(
-					dqm->dev->adev,	dqm->wait_times,
+					dqm->dev->adev,	dqm->wait_times[first_inst],
 					grace_period, &reg_offset,
-					&dqm->wait_times,
-					ffs(dqm->dev->xcc_mask) - 1);
+					&dqm->wait_times[first_inst],
+					first_inst);
+		}
 	}
 
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 7dd4b177219d..45959c33b944 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -262,7 +262,7 @@ struct device_queue_manager {
 	/* used for GFX 9.4.3 only */
 	uint32_t		current_logical_xcc_start;
 
-	uint32_t		wait_times;
+	uint32_t		wait_times[MAX_XCP];
 
 	wait_queue_head_t	destroy_wait;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8fda16e6fee6..960404a6379b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -292,17 +292,19 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 	struct pm4_mec_write_data_mmio *packet;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
+	uint32_t first_inst = pm->dqm->dev->xcp->id *
+			      pm->dqm->dev->adev->gfx.num_xcc_per_xcp;
 
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
-			pm->dqm->wait_times,
+			pm->dqm->wait_times[first_inst],
 			grace_period,
 			&reg_offset,
 			&reg_data,
-			0);
+			first_inst);
 
 	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
-		reg_data = pm->dqm->wait_times;
+		reg_data = pm->dqm->wait_times[first_inst];
 
 	packet = (struct pm4_mec_write_data_mmio *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
-- 
2.34.1

