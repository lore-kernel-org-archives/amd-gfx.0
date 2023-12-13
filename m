Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F07CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A7E10E6F1;
	Wed, 13 Dec 2023 06:13:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C64310E6F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4uO82dmWHWTCBfefl6axTlKFSqehKsw4HXYhvx+XSu/4aUoSvmTGuCeMhrGQrVfg2K7f/rG7BwSqDJvl8oJvh7pTDeFAVpDsqn1GZpNy+yqwVbwL/mxkNJPqfHc5T1WdWjLBKSEipv2mF4/XBbPFR63T0wXCGMjT7v7zlfExKZ2773s05NNcs1umUG0QswxwLTdz2DKnZBc7oazTDl0gn3p0K9tZL0iI9ACbC33JX7uIunnuoc5mp+WW74j0YoyLdxfiIrESIbDxyHybe+GqCCGj1N+JiABVLCf5jwRjDBu9U2FXg9SZbl9IiO0ZKAF/GJ6DN8zN7Kz52bqo7mBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q19sJxttvxjmSKZIc9T9ekdiFnBmYSK46jCx1H8WbEY=;
 b=c1vDTavahVX8xEDoVio6+DQte2q+6TdiiF+a/+mlIdFzDtRQ/kKujlZPfAzz4ZX6LREkqu5yCuua4YVajCJObpAXiUm/v1lo/Q9sX4PiO0UbTENQdbNMxQc3w9qZhc4sRLbQicJcf2pD+xKFEHT2bI8s89RmWoK+4HakEiSC/t6V17q3g5KTU3BIVwpV/JFqnIUn67a1scWP1qJOlUnFXAyU3nXm6/Ghb9O5Jt+yCdHeizwXG8i+Dv4KsWfkBhoWvfTXBB9YG8+s3ktc25hSeRYXfq6dATx0Xe/Nib6UaleVOgrxF3kFYCFnpG10O/Po7V2zmQuSauLfqCRQZao7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q19sJxttvxjmSKZIc9T9ekdiFnBmYSK46jCx1H8WbEY=;
 b=4gXJk0glvMQaGWOFnMMwiVaKvfWNzWO33qnSaU1kuaztX8xjh7EO2KGdRMdXs/y4tr2Ao/J8VVJcSYQT1TZeXqYWWlPsCNA6ZQuMtg9jNgIz7IeOTeJ6HfJGrvSqyA5MbyeJifsGL7pB+DsZgiM4W68JqbAoZSwCxaFpOoigTYM=
Received: from SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::16)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:40 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::e2) by SJ0P220CA0025.outlook.office365.com
 (2603:10b6:a03:41b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:13:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:39 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:34 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/25] drm/amd/display: skip error logging when DMUB is
 inactive from S3
Date: Wed, 13 Dec 2023 14:12:10 +0800
Message-ID: <20231213061227.1750663-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7962d7b7-68e6-4d23-2404-08dbfba2a6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTGt2i9Usno34Tg8NOHXcNN22vU7yED4gRSf2POx8hd9N4JNsW0Hi/IFu/9SGRLy1HkKJFISXLLZgs26NxmpAX32WQaERDA97wxMgZRbbs+DWuKtfP9a9qnfaTsPfzZKBPm0JsfrigxxE8CNYkyB3OJfAmvAlrYdWLtemNOvFFm690LWxzysPJgJfQopi4zIanu5J3ay6xWNHjL2ti9cA08kxE3ldAC3fi7V2V68n5SI9GA29A3LpKV3d6FQLinFvxf6dzMgH2zMhcT495JIb3PQcjI4L4a3cKxihhGD2FMHtNbMr+BPdDuaV8JiWxTY2ltSE/nA8q0GOqYSyv1bqN0Uk4nVxg0AYFXSYwg1lAZ77+wg2E7Bk8QuEqn3tul0RVe6swl4Lc82WEmP9BPTjWvyMOVpWyJknNpEt0t//05JJpoJUBjYCzn4yCpXT/sqau581lY56FFOYitbXFemXXnqL5C3dqd/BkymchiQyXOx9+vJn75fShXJJoGRCqTgOJD21RftRMO/olenNb4fNiQxROdEnnkusVhHbxSmvobRib3i13ckjmb6WXXn5gDe2ZoW3+87zKrILM8r7PDIMKw8L0t1SniNHTJILZZS+odpdqZSA4DLPdRVk9aNJX562yKBHb2zBBO1FaayOdvUo8f+A5kyhq059eHDEy5xJy6xMNQbqmWC+yjHIb0IlfFnsczA/PRKnbuN5snVclBVZ7gJMHU6R+yXxAuzqbXpc6+saccaDMLtK0Q8fOWUz1u9O77t+GuiT0BD727s/nQ9bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(1076003)(2616005)(426003)(336012)(26005)(7696005)(6666004)(40460700003)(86362001)(82740400003)(81166007)(356005)(36756003)(5660300002)(8676002)(8936002)(4326008)(36860700001)(83380400001)(47076005)(54906003)(6916009)(70206006)(70586007)(41300700001)(2906002)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:40.5156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7962d7b7-68e6-4d23-2404-08dbfba2a6e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
On resume from S3, while DMUB is inactive, DMUB queue and execute
calls will not work.  Skip reporting errors in these scenarios

[How]
Add new return code during DMUB queue and execute calls when DMUB
is in S3 state. Skip logging errors in these scenarios

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 34 +++++++++++++------
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 +--
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1a4d615ccdec..eb6f5640f19a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -140,7 +140,10 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 
 		if (status == DMUB_STATUS_QUEUE_FULL) {
 			/* Execute and wait for queue to become empty again. */
-			dmub_srv_cmd_execute(dmub);
+			status = dmub_srv_cmd_execute(dmub);
+			if (status == DMUB_STATUS_POWER_STATE_D3)
+				return false;
+
 			dmub_srv_wait_for_idle(dmub, 100000);
 
 			/* Requeue the command. */
@@ -148,16 +151,20 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		}
 
 		if (status != DMUB_STATUS_OK) {
-			DC_ERROR("Error queueing DMUB command: status=%d\n", status);
-			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			if (status != DMUB_STATUS_POWER_STATE_D3) {
+				DC_ERROR("Error queueing DMUB command: status=%d\n", status);
+				dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			}
 			return false;
 		}
 	}
 
 	status = dmub_srv_cmd_execute(dmub);
 	if (status != DMUB_STATUS_OK) {
-		DC_ERROR("Error starting DMUB execution: status=%d\n", status);
-		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		if (status != DMUB_STATUS_POWER_STATE_D3) {
+			DC_ERROR("Error starting DMUB execution: status=%d\n", status);
+			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		}
 		return false;
 	}
 
@@ -218,7 +225,10 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 
 		if (status == DMUB_STATUS_QUEUE_FULL) {
 			/* Execute and wait for queue to become empty again. */
-			dmub_srv_cmd_execute(dmub);
+			status = dmub_srv_cmd_execute(dmub);
+			if (status == DMUB_STATUS_POWER_STATE_D3)
+				return false;
+
 			dmub_srv_wait_for_idle(dmub, 100000);
 
 			/* Requeue the command. */
@@ -226,16 +236,20 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 		}
 
 		if (status != DMUB_STATUS_OK) {
-			DC_ERROR("Error queueing DMUB command: status=%d\n", status);
-			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			if (status != DMUB_STATUS_POWER_STATE_D3) {
+				DC_ERROR("Error queueing DMUB command: status=%d\n", status);
+				dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			}
 			return false;
 		}
 	}
 
 	status = dmub_srv_cmd_execute(dmub);
 	if (status != DMUB_STATUS_OK) {
-		DC_ERROR("Error starting DMUB execution: status=%d\n", status);
-		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		if (status != DMUB_STATUS_POWER_STATE_D3) {
+			DC_ERROR("Error starting DMUB execution: status=%d\n", status);
+			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		}
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index d1a4ed6f5916..c78c9224ab60 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -86,6 +86,7 @@ enum dmub_status {
 	DMUB_STATUS_TIMEOUT,
 	DMUB_STATUS_INVALID,
 	DMUB_STATUS_HW_FAILURE,
+	DMUB_STATUS_POWER_STATE_D3
 };
 
 /* enum dmub_asic - dmub asic identifier */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 53ac1c66dd86..9ad738805320 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -768,7 +768,7 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
 		return DMUB_STATUS_INVALID;
 
 	if (dmub->power_state != DMUB_POWER_STATE_D0)
-		return DMUB_STATUS_INVALID;
+		return DMUB_STATUS_POWER_STATE_D3;
 
 	if (dmub->inbox1_rb.rptr > dmub->inbox1_rb.capacity ||
 	    dmub->inbox1_rb.wrpt > dmub->inbox1_rb.capacity) {
@@ -789,7 +789,7 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 		return DMUB_STATUS_INVALID;
 
 	if (dmub->power_state != DMUB_POWER_STATE_D0)
-		return DMUB_STATUS_INVALID;
+		return DMUB_STATUS_POWER_STATE_D3;
 
 	/**
 	 * Read back all the queued commands to ensure that they've
-- 
2.37.3

