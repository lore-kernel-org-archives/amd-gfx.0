Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D328CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 10:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F66810E981;
	Wed, 29 Dec 2021 10:38:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B174510E981
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 10:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh8vDV4wkYNeN4AxdU6U0/r1OELr4ZzeCfia/YlieNyTbYyE+7bQ2ZJp9QxLJORkgq6uiNR4/nXLD+d1ZhhwP3oU8hOo6SECM0jfQtKv8jPBwwYhX54yF1O7fZ9H9AuM0HQNGRx9rfBWkv5d6U9jFqdzraotcasOGHy1dL+FpYORhGk40EMNzFEaUas6EKN957tOjCrOeQlWzo4Svbncx91hmd41ttexo/Phv7dquWM1yjDMBXv+XdctunUop3GtfYVpJzEh/RZdfipCb5fKB4bwOFSqxb3cHqNeWV7xHPcy/YRdfauhDzSeG2iQ79h/IQIUrgLMXf3l874IUO+1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP97Muq1LPWuX4iXyw/LJ+VehmNvRa35YkzBNItk2W0=;
 b=oX4E4mTlLtrpWWxcjKKoXFGJoyPbvrlHC/VjxBA2wCCZJA1onwN/OJ10AQKSOgmrLwLnCBtkkGawz/t4Z3J5Pi3julqoey/XFL36wvfbr0lnHc7aVoeb2jArSQm+a6zfpvU9D3YCIjyKRFuPNMVEbgDH+P/67jQQUFkmTEGcti/d0wD4G7HiVLYgJ0fCtjOBjMfgxA8YjihHw8Zp3iwS/gCnHEa+RR39OJI4ZdWqbap8Nm2zDJOeb3SDYZUBGUC+fDkhxQOmprzE17pmXd75zg9IjmMu6MKslVwHc75VWV2lUlnIo+pyuoSjfLmnMJDGXiJEapGvcWC9rEpCeHBRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP97Muq1LPWuX4iXyw/LJ+VehmNvRa35YkzBNItk2W0=;
 b=N8q1I6zQZJh/XGlI+XVcpE/wmeA5VSxuOe6XgWorukgBwnFRNsU9Kjaa03ylJMXu9u/wAX4VkJvy8GEgD2tGZbNTwAHekubYq2RuMQdzz6T3+NSOKg+Blw0GEfYDATGWBc9w9iz3EEwfYnyXbgB6MhKUc5MLFaml/QlJK4XTymc=
Received: from MWHPR10CA0056.namprd10.prod.outlook.com (2603:10b6:300:2c::18)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 29 Dec
 2021 10:38:26 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::b5) by MWHPR10CA0056.outlook.office365.com
 (2603:10b6:300:2c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Wed, 29 Dec 2021 10:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 10:38:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 04:38:25 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 04:38:25 -0600
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Wed, 29 Dec 2021 04:38:24 -0600
From: James Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add dummy event6 for vega10
Date: Wed, 29 Dec 2021 18:38:04 +0800
Message-ID: <20211229103804.2159014-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a3b96a-8fd7-4ba4-0641-08d9cab758e2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4869:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB486950EB164051D40C8A0CFC85449@BY5PR12MB4869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tD8g6T0skk0VXe/IzPeRzokmZ/n/FuB9mp+SRLPuxNCsn18f7+t+rlkVc9z1KoLMxjLRKFmXfnWOe6KpCF0dRr/UuwvyY+UvnnHZUmuaaw6CM+o1yPi5iGNWH5Uhu9kuEbJu5Z6JP9zO9/QylXKRvCY6BcsKdchtyKZAQA+WBC+q3lhqgGCPtRBXIrmyOgyJlR7ehmxLAPth4REr1IvAWa4LlXDy45QAeXda6p3+tqPs9iYzXtLBaaKi10iK3cIISktWA4UKzAfqKVXDw2muvLBsisfiivkTV0QYKtEy+g0+/+5aK1yIojPOg+F1uyJA4J7+PtM4P11J6wN2/yyOlN0cxB7V0TmWcMDb9BX28ztZcUWWH4Vh9CoAmQ6ytNmj4BkBoONJ5GRjGdFAFEG6yyTZmSb2KeS6Gs9nldodRdgvBOQCugHyPnFRaoRrg6eAD525LGYtwcWasi1H9QgcoENW0QbYkg5lrUNQij7coQfyeOpVG5U06GmLHmNQJMMg117Zfq5wRqiq2HIxIJjzphA+ucFF8MLA7CXoSltM7plx5MlUeR8AKST6QxElF8vDS09FH3VnNi+47ptvGhHOYMcc5JxK2isjm/s6YACSl/et8h+UJAtufMCftG2e77fyvFKUqmCS48mxK9PrDPRwRgqnErT9SKJ1PIOuma65p50/7SgC1PpvWS1C/6BgIR9uNInoQ6gjk4FL3rG4OGPD03/Mx6lNaXIMfSSL7Va5Gi1uTLaZtiGB6HpKUKWAYe5RtnS5vlsX9lPHA2tOyX7z6BriJ+BtVc4B1AWISfWuijM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(5660300002)(336012)(40460700001)(26005)(86362001)(2616005)(82310400004)(7696005)(4326008)(36860700001)(508600001)(8936002)(8676002)(1076003)(426003)(81166007)(2906002)(36756003)(47076005)(70206006)(70586007)(6666004)(6916009)(186003)(356005)(83380400001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 10:38:26.6950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a3b96a-8fd7-4ba4-0641-08d9cab758e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
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
Cc: James Yao <yiqing.yao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Malicious mailbox event1 fails driver loading on vega10.
An dummy event6 prevent driver from taking response from malicious event1 as its own.

[how]
On vega10, send a mailbox event6 before sending event1.

Signed-off-by: James Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f8e574cc0e22..d9509c3482e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -727,6 +727,10 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			vi_set_virt_ops(adev);
 			break;
 		case CHIP_VEGA10:
+			soc15_set_virt_ops(adev);
+			/* send a dummy GPU_INIT_DATA request to host on vega10 */
+			amdgpu_virt_request_init_data(adev);
+			break;
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
 		case CHIP_ALDEBARAN:
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 0077e738db31..56da5ab82987 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -180,6 +180,11 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 				RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
 					mmBIF_BX_PF0_MAILBOX_MSGBUF_RCV_DW2));
 		}
+	} else if (req == IDH_REQ_GPU_INIT_DATA){
+		/* Dummy REQ_GPU_INIT_DATA handling */
+		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
+		/* version set to 0 since dummy */
+		adev->virt.req_init_data_ver = 0;	
 	}
 
 	return 0;
@@ -381,10 +386,16 @@ void xgpu_ai_mailbox_put_irq(struct amdgpu_device *adev)
 	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
 }
 
+static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
+{
+	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
 	.reset_gpu = xgpu_ai_request_reset,
 	.wait_reset = NULL,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
+	.req_init_data  = xgpu_ai_request_init_data,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index f9aa4d0bb638..fa7e13e0459e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -35,6 +35,7 @@ enum idh_request {
 	IDH_REQ_GPU_FINI_ACCESS,
 	IDH_REL_GPU_FINI_ACCESS,
 	IDH_REQ_GPU_RESET_ACCESS,
+	IDH_REQ_GPU_INIT_DATA,
 
 	IDH_LOG_VF_ERROR       = 200,
 	IDH_READY_TO_RESET 	= 201,
@@ -48,6 +49,7 @@ enum idh_event {
 	IDH_SUCCESS,
 	IDH_FAIL,
 	IDH_QUERY_ALIVE,
+	IDH_REQ_GPU_INIT_DATA_READY,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.25.1

