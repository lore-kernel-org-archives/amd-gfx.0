Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB262C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 10:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A66E10E387;
	Wed,  7 Dec 2022 10:04:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F5C610E381
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 10:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTZy0FvEaDZUvLU42tj0CdG4RkXmXs2yoaaoeRV6UCm/uBjFxFLrBsbBFVp2GU10lzDSRiM9+85aaGLRW925CNYtiKL/u7PmozbgglIS+7wDv7eLbDwhINzzqDsn7Rv2u658OO1xTSnkYTDay5V5B9rTyzpngY+5QlY9aZ4VjopLCAzwszv8MLPLlulraMzhovVJd3UsrTNuuaxBZstUnmyXzgzLhwowdpBO/CW2iHrxz528MuSCOH4LH7dYY2eOBd07ZG+dNW1Af62m9ZvZYgDc9xGp2dtARCXrT6pGWwqmMX/bP2cSu/GNlDcihpXPnuvVxp8x/waxCOarTpOe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEgW+hoxEHvHDgkX2QxtsBqyR6KZWYmEjzkZWiOIypc=;
 b=P677YiCbxbxLdQVBJ76GpIMa9rBEs0B5dxvfXpA27L3FsYeSQoQk95Jfzb2rn2+OdgvXcZbqhj7dLpxnns73TCqiei4INfTefiKcJi6ko8H+HGY03EQ1NaKy+POuBSVAhGLpafxJKqOw0m1ZRnWPkYwhL8ZZKMgzOPj3q9FrfSZZAHUvtt5fUMQ6Bk8FVsr5yfVaZaFPlUD8oIg947cieh1Ik4qgl50eSPs4lBSOMobQk1OpUI2owtyZm52YsVoOKYa+wUyZ6XlDMxy8E44rzkSIKrKUrQCmWc9KAUdYVx3LAmloB8wwp4QlXm/IGZdZqtNBAw3wNstanygjukmxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEgW+hoxEHvHDgkX2QxtsBqyR6KZWYmEjzkZWiOIypc=;
 b=lnUHhQrszx6qTppEyWaolXCIQB5AoCbGlXmHRnWEzrI4gJfs1YJh354//J2qyKRPDnBKfCqYNBNYYuWkZuYpJVD5LdkoshEEELwiZuyLEry2W67Gw8ouob59xbQHRhiRn7MsDb3VH4wbsdtuHFsdV28nCdaPOwiFr+XHgkSIU0Q=
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 10:03:55 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::2b) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 10:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 10:03:55 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 04:03:53 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: add RAS poison consumption handler for NV
 SRIOV
Date: Wed, 7 Dec 2022 18:03:37 +0800
Message-ID: <20221207100341.15356-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207100341.15356-1-tao.zhou1@amd.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3257e64d-46db-4297-4e61-08dad83a5a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UQvhwijnPUlxhV54sm9dZ39kZcb9IgDiSjqSDCEODKSNxtiHpoAsNwstVLt/E3r5wBh3wDML8o+Hbt6K19aN+0g8iZnBSeCOjavRfP0eTCL4cCOkR7gSA5sv27KSsmRKepg4HzE3ZY4yK+Js92pJOYNSpOZunEhyWpMpYKLTr0fhzTn7RLQP/aQ36d7h/MyBzK/f/VeWFeymvoaxjEUAaLiTUQVFJrGR3Lj9ukElYmPYA9ERmU5QkCSr0r1MJ/08+ucYnarGkQ9EONmk1qrvKddhDNAhaT5wa2mRjZJi2+9uHI4Vgm8HDnCSePjbyU+xdefp+4F1G4OahGfnjwrpXSHVz8YnnZ0aDQZKL6J3pYxf26vGHqsYZ14SNxCVjsTGppvtnnSvbL8tCv5p86fYHUI+I8bHNuyMgOtrHkZNYOei2M5PmExQ9BfaHWV2Fi7yHFKE3pLmo11yX0kugFLx+D5c1ldEvC2za76ktXTYoe7NyWIFuyXMzLisGYlZnT7sPukkUe7+RtbfXPGEZu6VPxQLs+7onYTZ+Xkik6f1ZNQoGgFr7vw5krdqol9YyjLI0tKIHWZIsTRX/LwdOd8YrarKVILbb0qZXjKRmtJmVVS7n59atRfOS8/OT9sf41zBRk/VwMO3nWHqayXR2M1HdlNNqh1CNO7PtWf7wDR8ZHPJX1qu4uFzvzqhZfsh8agu4euJ1YvPTAId05ht4y4WBo7wJZekp/DvxIww1OJuUI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(316002)(110136005)(47076005)(6666004)(6636002)(36860700001)(2616005)(82310400005)(478600001)(8676002)(86362001)(70586007)(82740400003)(426003)(83380400001)(70206006)(4326008)(336012)(36756003)(1076003)(2906002)(40480700001)(8936002)(5660300002)(356005)(16526019)(41300700001)(40460700003)(7696005)(186003)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:03:55.5761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3257e64d-46db-4297-4e61-08dad83a5a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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

Send handling request to host.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e07757eea7ad..cae1aaa4ddb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -426,6 +426,11 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)
 	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
 }
 
+static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev)
+{
+	xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -433,4 +438,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.reset_gpu = xgpu_nv_request_reset,
 	.wait_reset = NULL,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
+	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 73887b0aa1d6..0331d9c1a09b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -39,6 +39,7 @@ enum idh_request {
 
 	IDH_LOG_VF_ERROR	= 200,
 	IDH_READY_TO_RESET 	= 201,
+	IDH_RAS_POISON		= 202,
 };
 
 enum idh_event {
-- 
2.35.1

