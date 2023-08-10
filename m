Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02813C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 19:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D28210E5B8;
	Thu, 10 Aug 2023 19:03:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B4B10E5B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 19:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSMrtDKY2GL23gaF+wiWw187kWX63BPnzE6+7AAbdyYa6BwZfq86iMpo/61YwmkYIvmp3Kws2JzMGI6tf3q78CWM5SwsDm33yBKz8IokHCKKqizIOEkD3jz1lD2F2P7LS2GMydt+GXr09cQNGPZlrqAGBYNdvnDvHvYjTEATt8nzDf7gDGcmqFERnuqdsXAtj5e+SwkgOyyOvbViW9iwfr7GvAZK93t67ivuqdhmbvGsQVtHsKqK0LgrPN6ACN7iJBMvD6KFjp1uaKXtKQw304aEYA1Eif1kOUuVq3ePfXYp/BSxDxanJxrmBTcNKfam88moivmjtlBJr/P6gS1YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDN8fKZg2VbT3E9xRgyOX5vc9/BBXZ7tS3DEc4D89gs=;
 b=OU0n/div6ogfkeZaxKlne6vP+nVnGx7u/NTDyoU19FpsbIWdJyNZr5pfZP0JhsRtJW2rf0oWICBJpYa7DToMneRm6uMmSv8aeNaY+ffVH0gUpJEbWfNC5gQnscKfmXLjuXvUCOOm0QettsHS2krobVaQsGNHK4GGJuExjVKU4Udmd5nMYdJaWf6dVBmN4fKwIeyse7zhw/ke/39xqM9O32DUYRojYqR5iTXyGMIul/rHGsYvth5jT4GvCSBSmUnpXTX764y/b8fEk5qz+YtULdc/RXxplhgruq+DrWqUPLxteM/fmkLT5F5JFw4Y54ms2yaxNp8J8qvAR12TOuzEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDN8fKZg2VbT3E9xRgyOX5vc9/BBXZ7tS3DEc4D89gs=;
 b=YnOS7rtaVShK1yGcUsB4MAMcfFYxSjjCd4lsIM9Xdd8Iom5JF/LiRoTvhvc4pHCDxZmXBZ9cF25W0skMcTwhrwGzA3hYBvHnSon2EbTtA2048nGgoxsJhNN647z81h4BgqFeoAmowAj+edBw7/gm/6fRVuq2puTda0ApB+xJ5OU=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:03:28 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::bb) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 19:03:28 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 14:03:27 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix double assign skip process context clear
Date: Thu, 10 Aug 2023 15:03:17 -0400
Message-ID: <20230810190317.3819769-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 65052e8b-d317-419a-a7da-08db99d47b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KE+JTIKHi3vn/pykCUuxMmhBeX72jD2OvcG4LF3We/rZRIjvx+Fqq70DPkh4CfbwmUUcMHI1GOY26p0K3fFIkAYSAuf74Swv5jlsXEyqP75KXRFXrhwcEqMuLayBefYj8dx9Oq6oOs+g2Vbub8R56ET2U0hA62gqZat54EB4lZlm6D6qlvEPtvO+ADleOYustfIvaYFIdU3hAzs7e8gOAOC22piFBquAQOQnai7wzVcEhi1DVRjJQ/rpf1v5VExzy8eSkuCY2ZhRcPLoRNyjDJAJgmMojKI3VtEG/6ofxS5rqkwRC+VLj4OEoZ9aK+5dH1deMd6bTMLJ5Rr/BOLK4AkJrzXEa0HxU7rM1Zb93M+B2TUXl53pPThxL1evWYiCEjOjcpbDmpe9tlzOuYge0hIpwl6CcxaV5hky050v1H9HzoHnRd2oSHqKFo6WSpV+JOkC6QW6anBpu76khIUkXRdn2Em8U7tg8fLqjXTjEJaXLIJ5N21WcmkqYFx66UZ3RgHzcphYQOpobDMn2oq/nZhNRkZY+wY5dwVe52tdra5PgKfJPd+OpM15qhuB6nL7Dg6xmA72SpBqP889xEEej6xzrd0+VFFm/7llf9c9jYc/BIvazorlqysYdRYxQrbm0EMjufZOhus4QXg3gfA2XhJAxlD7kUGtEXfJbe4bk06lnaJvdV/MbjA7HK6UnNj/sPtMAqULNUftqWSgPpIX+CM48tXogMu5A31+iuKcesIZZOa6o7tNXzKz3A7EfB6k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(1800799006)(186006)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(54906003)(40480700001)(4326008)(70206006)(6916009)(70586007)(6666004)(316002)(478600001)(7696005)(40460700003)(8936002)(8676002)(5660300002)(26005)(1076003)(41300700001)(82740400003)(86362001)(336012)(16526019)(44832011)(36756003)(47076005)(36860700001)(4744005)(356005)(2616005)(81166007)(83380400001)(2906002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:03:28.3069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65052e8b-d317-419a-a7da-08db99d47b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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
Cc: JinHuiEric.Huang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant assignment when skipping process ctx clear.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index aa5091f18681..89c2bfcb36ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -227,7 +227,6 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
 	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
-	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
 	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
 					     kfd_dbg_has_ttmps_always_setup(q->device);
 
-- 
2.25.1

