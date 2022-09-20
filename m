Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E22C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 14:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C2310E1D0;
	Tue, 20 Sep 2022 14:30:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB8910E1D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 14:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrA38qJXdnRCPNay+FFDhkyL/W/nuJh/uO+kmug/HV445feS6RsNJ04tKo4p98atFeY+ppqeMncaF/AfKg3Sp0KLrxPoEFWfwSpa+fFgShwBvrbccMSsXJNeDXdZVdO7U/EJuKhuJnpGQgNgFWzoxCLMieHPgAsOrrExy1FWPUxjiUzrE21xcihiMP0Y0JrenibpAgbFp0c3GdtQUGu3ywE0C+WIwZFZjdclijlfOtO+tbSSNYHbxyixxmL7ChOuB46ouwStXIfyQbLaVfr5zlQO/ntMRJbfGc8PGjVlgX3PoyGJqpxkxShM3aeyxLMJkz9kiZAzwchlquD/PWeMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mlm3894eeeMTJVddnCK9ihXYyrvYShL1YuGDiN8OKZg=;
 b=j9QABqoZJwAtROo30gIBs863mvhT7IaRRGmtMycrK7nqU6/Blpqb9ILl6fPleKXXYkUQvCCu0PKtBqBDWcAA7WkAPvVlGjBF0V8ejX2NlTnCypO8OhnzqVgU7o0YnHS2fVSdKS0E8bQxiLt6fyPSqXzVGjGSvnUsL01vy78Bmyc34QTyZ3zNQ2cLSQgh/9Edm1L8mM8we/qiHgk/fxflx2zhOl3Fbc07c53VcwhQCZntFHNt/J2ElnQhXDPmFMCCzbZy9dE8bLt4l7CcPND/Xy+T27OgKKK6mx86/x/X1c3N5hZ7UTD38gZkU8TcLCdqNHCf6q/2N9eEx66E8SxNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlm3894eeeMTJVddnCK9ihXYyrvYShL1YuGDiN8OKZg=;
 b=gmrBCGuqSUUda4pM6VerHg2U7IhVhm4XtBI09xCBQEGh8eN+VJgTDKLz/MUma9p+kRiw2CofPljJAcK8M4F3udSOPsu1kxQiSc1lNKzYwPhkee2Y8GEqM8IKOQZ/aCMIsjuGfk7dU/3WG0WMUBqkDjuWTjdFaY8HyPIBGuP4X6I=
Received: from SJ0PR13CA0194.namprd13.prod.outlook.com (2603:10b6:a03:2c3::19)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 14:30:08 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::93) by SJ0PR13CA0194.outlook.office365.com
 (2603:10b6:a03:2c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 14:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Tue, 20 Sep 2022 14:30:07 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 09:30:04 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: pass queue size and is_aql_queue to MES
Date: Tue, 20 Sep 2022 10:29:35 -0400
Message-ID: <20220920142935.215819-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: be6513d5-01ca-46ed-602b-08da9b149dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPtJX+bRgT36O3eqQ8Q058Uktm0fv6KauSQLnnZs2ZL+6DJ//Jd0wTdnj0EHO9sUqGGDAnL5I4BSZBn0OQTaLGAKVDYSr+hiSe/2dHR++L0dp2d/k+GuOtq3pXfEwtniJ5vvbknytOJFVrpJC52EG6lIFAjmTsnLXR/UrJqYjMVVF55iTOehu4jcV9qRE07hHzJEbNzvzmdtpn39g4nLPAxyF5YCxaa4N4hc3PckmsBBgsy+Sbb4u+RThwPnAH+7SNdOcO5ykAEZShu+Gbh3aWqPDebk//aNN6UmHTupZxRnfAIrYiLJKcOzFdyheSky7s5J4r+r63EYtsWSiYqPJhEbCJY4czTqiQ/e1rDyNEZw/xToLd9mGSFTx+BS+y/SK7kKKh3VOhbX9bh0zV/HkqX+VBHE7gqMW8khT95iP3TgPjn7/jIi8YOZwvfARQswAZin5lEISRugpltBtPEBxQdyitlnj4cRampwFKC/YBOXos71Xj7qmonfr/gM3v1HHD/8W4Mk5/CGdbml/5xj6GFNvXTiPlGQDN490tGoT8d1RKUstkT5tRBWaCx3iOyf4yZN4NAXvFi2oW5k4JpTDna1Tk0x7B+UWn/ohXEW9NvTrqtjf+TYDF54augyuvDGCxPNsgSu/w1AvwYAvQywKO1e+RpQSuajY6mOvqF4Mi2eXzanDj0IRNB2Ap4MIROwwK5AI+ksY6bW5P/TSJDlkzHf3pEkCy343nlbWovXQmSf9KZJ5Yu54eR/xLTCKMY/ON0tnFbPZWlx7ApaUglV8xg43tcNJ6DcZ7CLFOAYw5pXu87N/XQUF7WZVB9Gj0G/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(356005)(6666004)(26005)(81166007)(7696005)(316002)(54906003)(6916009)(478600001)(40460700003)(36860700001)(86362001)(16526019)(336012)(47076005)(426003)(2616005)(40480700001)(1076003)(186003)(83380400001)(82740400003)(5660300002)(8936002)(2906002)(8676002)(4326008)(36756003)(70586007)(70206006)(41300700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:30:07.5636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6513d5-01ca-46ed-602b-08da9b149dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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
Cc: Jack.Xiao@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update mes_v11_api_def.h add_queue API with is_aql_queue parameter. Also
re-use gds_size for the queue size (unused for KFD). MES requires the
queue size in order to compute the actual wptr offset within the queue
RB since it increases monotonically for AQL queues.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h         | 3 ++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7b46f6bf4187..ad980f4b66e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -222,6 +222,8 @@ struct mes_add_queue_input {
 	uint64_t	tba_addr;
 	uint64_t	tma_addr;
 	uint32_t	is_kfd_process;
+	uint32_t	is_aql_queue;
+	uint32_t	queue_size;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b64cd46a159a..5581e03fc956 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -187,6 +187,10 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
 	mes_add_queue_pkt.trap_en = 1;
 
+	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
+	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
+	mes_add_queue_pkt.gds_size = input->queue_size;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e83725a28106..8644b212cf4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -205,6 +205,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	}
 
 	queue_input.is_kfd_process = 1;
+	queue_input.is_aql_queue = q->properties.format;
+	queue_input.queue_size = q->properties.queue_size >> 2;
 
 	queue_input.paging = false;
 	queue_input.tba_addr = qpd->tba_addr;
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 50bfa513cb35..7e85cdc5bd34 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -269,7 +269,8 @@ union MESAPI__ADD_QUEUE {
 			uint32_t map_kiq_utility_queue  : 1;
 			uint32_t is_kfd_process		: 1;
 			uint32_t trap_en		: 1;
-			uint32_t reserved		: 21;
+			uint32_t is_aql_queue		: 1;
+			uint32_t reserved		: 20;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
-- 
2.25.1

