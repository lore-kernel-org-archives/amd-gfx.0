Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3814DC7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 02:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFB410E631;
	Fri,  9 Jun 2023 02:32:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD25810E095
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 02:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRbgJgMpvkBxSBV7HVIpnnjBgQ0UGwecCcz9Dkhd7RPlzVtGAlxlH1Syn4cwl3WxdI0qoSR9WjSZXlUHYfyW7K+PZgpJIOMTtBsjqRBNo1S4PWpOXPhn8z2mi9eBP6540sCcIlf0kmi2MkKYR6YWWaIVjIYJatdXjCCsTHz+Mzvh8d61clYrcc3iwtu5lemWoq9mMBqBCPaKkEk3bZuXkqbBGP2yG+/gvzvMfE+mvKKJVB1q15eCJDoHcMOopzmnHmgIQxzO2tFB0VVc89H5j6afBj1G/zVCEMapq+ZGa8wseIjaxFc5LLSslRI8kwrKBTw+SvGl4MV2B8XuspIlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9CfOdts+xIFydZFBmcXWTdMxDHus76tBjqR36lYLIg=;
 b=nIjV59RxYRHTYpLPg/9iUEBaT/nWMjiD8WZ8CIQo3oH/4ZmL82nHssx3Ih4kqtuYyPk0eyNXEr2DAUL9BbiuUCe3Bvb3VvuNvxwSowVUK8UowxsdxqSvgLN2P36xgbBwsbjXn4E1hGwoYlCns0g4A1f7SoyV7mUV2HMsOu8VWYGGaoVN7gKtyyGady3a6bQiiZDUqCxpGxOQhmgZDlZM27B1bHaQ7A4z7XT3ZYerJcwbyiHpjjl6iOj1aAE6iELyZNwLy3dTcRpMCadpk6qjb9m3PkepjEr1uBASX4lYUw6eS1Q6uy/iNIqJgGZK54X5unNE/KleNRi1UNCfRXvLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9CfOdts+xIFydZFBmcXWTdMxDHus76tBjqR36lYLIg=;
 b=HwylO3zO5MsjU9YlpyXTDGKUhX0gefv7nmg7R83JIufJCkOXMU3IJ29gbegPDY3ZvEa6Kul5ych6P15AtBDZ7p9Swd5Vm7yr6wcWgJI6780Kh47SveWakpGOUZmR1CY+F9Mx/6NySaHkZ4LX8VSJrdgc22RbJQFYKi6C5noYBQc=
Received: from CY8PR19CA0028.namprd19.prod.outlook.com (2603:10b6:930:6::6) by
 DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 02:32:38 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::ec) by CY8PR19CA0028.outlook.office365.com
 (2603:10b6:930:6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 02:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 02:32:38 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 21:32:33 -0500
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: To enable traps for GC_11_0_4 and up
Date: Fri, 9 Jun 2023 10:31:26 +0800
Message-ID: <20230609023126.197544-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a690cc-64cd-4655-d550-08db6891ca9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YspNg82tCHdGfBiNCDf+nhcC6JdPCCkaaHabszd8uKfCA2rhABtAb3+RH442Kk+kpfNhvfwNqpmEr5USRuto9swsSk1Qdrf2HTmIQ///6EJOVTzYjwbchvXX3G2CMXg9gGxiw9HRbA7IJCHVIb6XrC2cTOhuK2i70WO1PQWb/jBfN8K68mycs+cEdTEvY2wfc2mdPniD0d2mMDbR4wIrnOAQxAlV1l/zrl/UJfMv7XE5wUygUHrADI4cJpWAW8wwHBQDbD7azDpobS8bTxB7ntKlNAXTm7e4Z0itXI4zdQVaWpzZcqvHrrPbNVFpMTYHIQZVTG0qNbVUcY8DmcAiG80MXYd8haeVKQEB4qanh+jO76a5Vy4XL+J9dOYpCTtDS1uCRhqOVj5uK0wsRFW/WGBzbS1z4Oy23kXMPu+s2d2DHugxKgZWkkn+QhnpwKDNAblEbZou6v+4Zf/kt8XgoVQR8LdWGc2kMWtVTU8fUqZ4RONH9CjKmEDqZDZVG0j/evETVTCFFcm14qp6uvw+O7Xgs4c1rkIPsL+Mtb3ua5HRKwsI7HL55Gw5z+nsQtk4VMY2M7oIy11Dg5OVuWrfr95IFW70oTuX/Ksz90YxTOyzQMIz4RlhJE+yyVoN3PohEOfk2QNRO8QpqCIDEVe4hSRBqGF9siCDihYY04gY3Q+kzEc86MNTfw8CNqiExh7JtG9nVuOqVhbCGWO89bQsVSp+JootjAqOzN5+XiLs8E9HBPGv/H5Ffm/TwU/fcj77cmaXWgFppdfVJ/EyZKHfggWh4NaJHyFZ8DSWSn0In1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(2616005)(1076003)(41300700001)(336012)(7696005)(426003)(6666004)(36860700001)(47076005)(16526019)(26005)(83380400001)(186003)(40460700003)(478600001)(40480700001)(54906003)(81166007)(70206006)(356005)(4326008)(82740400003)(316002)(82310400005)(70586007)(8676002)(6916009)(8936002)(2906002)(5660300002)(86362001)(36756003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:32:38.0876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a690cc-64cd-4655-d550-08db6891ca9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

Flag trap_en should be enabled for trap handler.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d6b15493fffd..8a39a9e0ed5a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -227,7 +227,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
 	queue_input.trap_en = KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
-			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0);
+			      KFD_GC_VERSION(q->device) > IP_VERSION(11, 0, 3);
 	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
@@ -1807,7 +1807,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	q->properties.is_evicted = !!qpd->evicted;
 	q->properties.is_dbg_wa = qpd->pqm->process->debug_trap_enabled &&
 			KFD_GC_VERSION(q->device) >= IP_VERSION(11, 0, 0) &&
-			KFD_GC_VERSION(q->device) < IP_VERSION(12, 0, 0);
+			KFD_GC_VERSION(q->device) <= IP_VERSION(11, 0, 3);
 
 	if (qd)
 		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
-- 
2.40.1

