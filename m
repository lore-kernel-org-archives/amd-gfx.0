Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2618C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 19:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E7810EAF8;
	Thu, 12 May 2022 19:17:26 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D6F10EAF8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 19:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIyB6PR55ZiHWeM0sn8Bqlm7/rkLcITsik0SOMJ5W5J7+XuohFeNQG0IDCxTtyghxNWCIZ1BAALs+xRVTKo8y0/vWPp7mIoA5XEdnOR6MlJoH39mAn5cw6lHtE/NZ2FSCKzB084HOWmS1e9Bq4Mkes4ZMarQECK1D3JeGSU0RJOg1Q/DJ1UVD1lrTbP3KPw2VHafKQKlVxbdj1c6HEHaLLH+nllC2mfp7MP3US4z70fTInCdyLEqEFppFYyQOiX1QYmIxt4BRgEq+4FQ2T6/j+GeKijvK9Fmdtz4mZBvqghAts90KPzivnwNY66hiM6qmByw2YSJmgjU8Q8o7abKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0rRPXphcp7gzEN2Prc5lrVselRNltWBNfjjz+6/bNw=;
 b=nr9B60Vmytypsehgx1MGJd/P6MLZmN4A3KwUHg2IT3W8LJtyq7uTtaNeo6b3ZOu/u1Eq/aR9gcBpOFtOOzTKaZMOx/pg0vPwDekDOP7ztNnbdYi0Ygi2XXf/XZZqPSEZRjZC74xedWcXHsVSF0uF1np9zUv/ckcxGfbXefQfAkcPmG6MiYUYb3GOO4VCfF46H8IYl9tqcMxMZSBGAqgCKtRt6ZDlpazevUraIy1rlGeD+1MAncd6O6Q49YKEGy0MQ1+d7DhQtWIZ4Cf7iXTRer6TIfGCMgWJWuqScSKKM1Li6JM/Hl/dAHn2U/SUuOUWVTsD/6L9h0iY9xq/igFBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0rRPXphcp7gzEN2Prc5lrVselRNltWBNfjjz+6/bNw=;
 b=yvhMQlBrT10aMAp+iBxr4Pw+u3z2EuWN+o07iXu/Bq1mQQpTlrmcAhV/PEE4UlsoWQKsYdcoxCwd473Vl2icvklolxnEuKsyaNunQy/jkE14K71o7FzVpZLQLCWHavkOysQ07UxqjQK0lg1h/2cX3xD7omHhH5g+ob+Tg5DhDJQ=
Received: from MW4PR04CA0123.namprd04.prod.outlook.com (2603:10b6:303:84::8)
 by DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 19:17:23 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ee) by MW4PR04CA0123.outlook.office365.com
 (2603:10b6:303:84::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 19:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 19:17:22 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 14:17:20 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix static checker warning on MES queue type
Date: Thu, 12 May 2022 15:16:32 -0400
Message-ID: <20220512191632.3975470-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f063ec30-3d4c-4bcc-fc49-08da344c0ad2
X-MS-TrafficTypeDiagnostic: DM6PR12MB5566:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5566E7EA6E9BEAA4A00660908ACB9@DM6PR12MB5566.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2kul71Juot2U/Z+jFJBLNXcwmHuIqzXO/LV+EUFuCtaYeGChvS3+McKpbh+DgzQgp2LuFCZETzzzNl60yTQdMQMNwf4vPrqOwC8dLiiLpyJigy+eZsLwv8HQGsoeYXCTYGot1VHsP5qlySpIi7F5v5rwVlSH5/qwUzFHzv+Cz2tUp5QHtJYb53VdbD9YXUDTIGCa89LXix2xnRKTes8zNToAWrdvEDn3rOV5gyoZ2b7XiHNQaQP9vWKUWI/Mh1G2QCboT91ujTF1NuYRqPj9Cz8/mfLfzVVbsyL7jzpYxHdApzRIqph9nz6O9beZbuxNtEjc8s5FJCKSgpQthpQv7wENlDzsZQ1CMvwBlCTtBdSMwkkpep5uapKYLT1QIBpBkkN/0AcvTbNVpEZ1455dfP7w62jCC9LlKIugi9prjLNYBz8q4Acq1HQiK147B+IGCPtJ6/RMxgGUqfIGiIIMaOSOhuFLa1Y8la56fRoNmaGpj4one1ej2inleXix6URVw5nzFXwPJw0OoC27Dsh7lPb6GWVYJ6RddCxrHtGwxzKUake5H68pXUoW8DXSvr/yPxVwBMScgHVipi61E2nIAA0fSKKenXUD9jh5NhRVQoAE0m+qjfem+mlzNcbq9N8fHrWnu5hpk6QDI0ak4bykyafDzvP9/0d9EB2zgasLeb18Q4sg7S9BwJBehg8ERH9KhK6x9us83fQuvbWo+AN7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(4326008)(2616005)(6666004)(70586007)(70206006)(356005)(36860700001)(1076003)(86362001)(316002)(47076005)(6916009)(336012)(508600001)(40460700003)(54906003)(16526019)(83380400001)(7696005)(81166007)(186003)(26005)(426003)(2906002)(8936002)(5660300002)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:17:22.8229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f063ec30-3d4c-4bcc-fc49-08da344c0ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, dan.carpenter@oracle.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

convert_to_mes_queue_type return can be negative, but
queue_input.queue_type is uint32_t. Put return in integer var and cast
to unsigned after negative check.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e9c9a3a67ab0..e1797657b04c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -176,7 +176,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
-	int r;
+	int r, queue_type;
 
 	if (dqm->is_hws_hang)
 		return -EIO;
@@ -201,12 +201,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
 
-	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
-	if (queue_input.queue_type < 0) {
+	queue_type = convert_to_mes_queue_type(q->properties.type);
+	if (queue_type < 0) {
 		pr_err("Queue type not supported with MES, queue:%d\n",
 				q->properties.type);
 		return -EINVAL;
 	}
+	queue_input.queue_type = (uint32_t)queue_type;
 
 	if (q->gws) {
 		queue_input.gws_base = 0;
-- 
2.25.1

