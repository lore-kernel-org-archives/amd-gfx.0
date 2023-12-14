Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267BCC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 03:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A845E10E098;
	Thu, 14 Dec 2023 03:19:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B21510E175
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 03:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvf+ikyF7jx3QMmNNWBIQxkU75lhKsC4CwyScS3rfB3U0I/0exHqzkjPmliHeu0rhPpcGp3SDci1IN2XfghJwXJD1MgemRin0BQBP7Zk630CyZQroqIZqUDXLXIdAQ/ZylI1YcbjII4IKYebjEWQGgYozwYWm3QCBAsJ5dAtiTBHTbI5h8CIaQgYXHmCWG9F8/nJvLuQLEkhpnxElfDg/mOBBilrNn0ZR1DesvAa9vwSMuYr6529Lr/BW0WjH7zjxEdg0y5EvMXAVLo8b/p+iegn+jjUojo79qMKjDsggMlL0sSxinRbOTiMu0JMV7LWXkpiPGhhB5EPmDnmY+4aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CXhYHY/Ui82guqc0lADBhdlGSNSxVvR/GkhAiCH6mY=;
 b=QZ7u1AgLIa63m233bbzmrn6R/i8bEu9VUWVsuPqC8ETdVql3RBxOZBzHoSWPF1mhtcqsPKYlmEG5vXuXNyzuZzNP+0X84Ju6eYbL4Mrwh5Q6QKYURcLoFUq8r+mq1hPBkHujUJkwuCoOupROjiUretABbJst6lVee7kPzD+ASRqZS5OOGlfa8rkdfhKvoj/NJb/i2z319tAqXxIwHy8Jcrn/ePY2Kj5dF+PCmQB9VnyzbAurnnFKif9eqLZkzCBRYMyivT/S63WxBtMm8zEOVd9bo7Wo52jBhN7ky4CSGVwS8AQEEF9HsxAi+elumCVl8M6jsdiXHB5Yeg1mVIJJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CXhYHY/Ui82guqc0lADBhdlGSNSxVvR/GkhAiCH6mY=;
 b=lbN7qltPmApOkp9ovQfPphmLKKw+9TsWwGsRvVaw9MOopPChpJcajx1PSKBXjU+6JrhUk47EPItsUoA8K3tRzE+xVAUhU/AfPOdbj9xvFkDW3+PlMGP1C7OM5za+tKkIDi0C0RU6f5cDqhhhCDMYjBpRLNN77z79Q8Z5Zq+LqXQ=
Received: from SA9PR10CA0016.namprd10.prod.outlook.com (2603:10b6:806:a7::21)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 03:19:51 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::44) by SA9PR10CA0016.outlook.office365.com
 (2603:10b6:806:a7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 03:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 03:19:50 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 21:19:49 -0600
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: only flush mes process context if mes support is
 there
Date: Wed, 13 Dec 2023 22:19:39 -0500
Message-ID: <20231214031939.93942-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: f58ffabe-288b-4304-df4a-08dbfc5388a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksP6USmAiSoDMAitsgp6oFRi5iNf18pGA2WxL9BEyAAqpeS3K8cNka1FrXEuScwK3swVTyJOFCRCLDOy2DZUhAUEAgBp6kYYmWFZ+ROrVjDAqHsBN+z6DT0Ay69TFI5cmjHo7CBbbTgY0HN6hpf3xQ6fAOOcj3s+5drDtZv2Ap75LkFNCb1nkQDjB2NlRJM2zZQllCP8iick74pv2Hcns9nSz5aqzYBxOQa6KVFeKTrel9ZNaEPyKoYeAR728XJjbBYELCUdiFV4PFuMb/ohkhe0xQ5HjVOrDL9qc/uX1Qvtk5UqGhBmjfNyckeBVA4wJ7F+3rwczqeo9HA6QI2s2cBuQ/POblJ+48KsbKKnH9+xCk4GtKLzSwAP3WGFtpZooRIiF2u4sATKamhQjkfaf6IpqXGbUok1HHLw2tXzDWKWRmVIdLxOZfwLt5gnWO8jH2kAkg/oK7BAu7zGzSZ0RShuoGOf/pzLLiArkmbD3yZuYUpDa0uHQtjzsRhyL8eJyd2Tu0vDJvfObFFD3zhbUvorRzKN5x+lnTFrjDxmyxGXZ2/SF05bfCcwGwDsdJODXW3/XishXWFl8t16RMWZOxpaNc1LPk5UukDGP+HjQdighx5cOmL/gLAtChSxDxzKBH7QVl6MdKJIrE9diNuGNtlAVUEhL4RbhxGapXQqM4+RP/HCWtsQoOLDiA5CxclMy0XjEhtIRk43YG/Q8ruhZeJytuePqWlsnbBEhAyXLrPsDB9OasZpcez1/OohL+6gzja4rzQRHYLhdCRKDWoYXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(40460700003)(336012)(16526019)(7696005)(83380400001)(2616005)(1076003)(47076005)(36860700001)(5660300002)(4326008)(8936002)(426003)(8676002)(41300700001)(6666004)(2906002)(478600001)(26005)(316002)(6916009)(54906003)(70206006)(70586007)(36756003)(86362001)(356005)(81166007)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:19:50.7398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58ffabe-288b-4304-df4a-08dbfc5388a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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
Cc: JinHuiEric.Huang@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix up on mes process context flush to prevent non-mes devices from
spamming error messages or running into undefined behaviour during
process termination.

Fixes: 73204d028eb5 ("drm/amdkfd: fix mes set shader debugger process management")
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8e55e78fce4e..43eff221eae5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -87,7 +87,8 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
-	amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
+	if (dev->kfd->shared_resources.enable_mes)
+		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
 	pdd->already_dequeued = true;
 }
 
-- 
2.34.1

