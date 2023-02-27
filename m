Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D12BC7EE2F
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 02:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8836A10E176;
	Mon, 27 Feb 2023 02:14:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086AB10E176
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 02:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2C6K5wt/zt8yozEVy7iVCG52SGVk/joRuGrVXKT/4dph7tR32hx6aZAhpwj0MTGEHeh4N9TYR55TcaGkBtccD+KqBxH/063N6EGQg+HK3ExBYbTqc5Km58appNPmibjahxjFdb8a6pqjmsX4zRkOWI9xDMBFGBee7h3fs6hBMlXlMH5fiJhpCummuTCcI+DjEDFPyl1Zn0pIB7iWRvRQZgSYUxoaO6C/ZbgScehce+9d7scJdXPk4GzPjwA1FLhiwqc956HzJz3hvvSmSqhYAfZhLCZgR87tWEIwEepRgK30lO+u7fXoMaiWhtENfS63Sdml+CpWNLKomlCV2OQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+Xs6fNMmqkAqDB7HWjQBI/i/Fv/n3RwoyW5uoXyiLU=;
 b=gJUuE8KagTPk/YHt5VEIPGD/pI4wTMprHj+Oq2XulIPsqF9YsNw7NPDDJaC4p6z+WjvqpGuuII5mv1Sza20aeJkb2JtY9nP1hhFJXyBM6pweHwKZ9atYyy6ZfKoElQS4Ztf3a8Ablejj14aBevDBkkMqJc/UHTQvdgiqK+o8BBVqgp2I0OVnh7+s6lfjFpvx9FDXAnyF13rX07SCHAMRAQLG4Yi5cw5tOgVc6rEbQl6vEiQVJQikgsRFPB3gtO4swWiVvcuMaONq4V9rXR8//h00nw83jOyQ1mlgUzTDmPK5tlQ5v9+lqONUkX4tjcrGno+ZvoyZDA8Y3cg5jyE3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+Xs6fNMmqkAqDB7HWjQBI/i/Fv/n3RwoyW5uoXyiLU=;
 b=U7naQFsdQiKLaT2FplAagwONEU4EXYgaWFhOmJ66kLwc/YmwJ+slSu/GSzBC62gpZgU/W6z+3V7biOVQKTqNDsHyxBEwUNeRAPmvkPoAF2zu2wSFVQqj1NFOanpmd2x6v42YtTMau0Rn6cEgD5JcXzsIMdwyEXyH36v8D8KVooM=
Received: from CY8PR12CA0007.namprd12.prod.outlook.com (2603:10b6:930:4e::9)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Mon, 27 Feb
 2023 02:14:04 +0000
Received: from CY4PEPF0000C96B.namprd02.prod.outlook.com
 (2603:10b6:930:4e:cafe::b3) by CY8PR12CA0007.outlook.office365.com
 (2603:10b6:930:4e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28 via Frontend
 Transport; Mon, 27 Feb 2023 02:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96B.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 02:14:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Feb
 2023 20:14:04 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Feb
 2023 18:14:03 -0800
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Sun, 26 Feb 2023 20:13:57 -0600
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix ttm_bo calltrace warning in psp_hw_fini
Date: Mon, 27 Feb 2023 10:13:56 +0800
Message-ID: <20230227021356.881572-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96B:EE_|SA0PR12MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: 311a419d-f09d-472e-a57c-08db18684cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGWDwisOZp57awUn7i/VWgNCpVybuDtrEeAVQTLY5lcLm9+SeP72dPypd9c5q1orKJrpIX4cY13pSXIfbud+3YzFk1PVmJZ9WPArb4GJa7nqzHy/8NisRMc0jVVPbcmceeXd/Y+rM0zHDXC+Wwtm9jhGLndV5f523APtyZXcQXqoYX8zpLf2Y59i7mgZcGY9viXaatd9j/jKv/5Eyn+OIEWZJKIKx5Jg6s7pqyIlir0LI4sWhfMYE8IgizERTG0ZO2x/9mOgZJXRpmhG/bK/3ptVFaqfA4lvstub0HvNo1IZ9FohdTlLtSn74iYtfpPez9GahHXyHcBXLzdK6VOKcWHHH4OgtQOOVXH/uFfRucu9kzV2Qy03MkQG8v97RmSUmTLYa32cWMluWpvtWl8xzVaHphA3uAvHXAzqsBmP9jwuJfAsM25J+N7llOKDYqCfjPxyxpTftldTZzxf5HmyHS2nxpTi8UxLkSjLZJaXB5PLnJ/a/D2QTLuNLzxaUHAaa2hK+j0UbZHmmEkKneJvzoOBcFj0CNdV9QQG2EaORIPg3vbEr1HhU9bRD9RlA5F0WgE4lWuHX1EC8YZN+dur/KwMCwpEZLrvvkW/5eW+4oVZaQqzdGw2DyPRd7DCnq8syxMGJyrkDLr3iBFF5lt+tpB9fdftWMuwHbCqrPAxMCnOZIwwNf2CjAqvd79XcowoLioHytA0SjfTYHQSDFDuHTjoEg8h7fpbvLRvYIhA1M0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(82740400003)(2906002)(316002)(478600001)(83380400001)(36756003)(5660300002)(40460700003)(86362001)(8936002)(40480700001)(8676002)(4326008)(356005)(6916009)(70206006)(70586007)(81166007)(54906003)(41300700001)(36860700001)(336012)(82310400005)(2616005)(47076005)(426003)(186003)(26005)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 02:14:04.6240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a419d-f09d-472e-a57c-08db18684cce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
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
Cc: longlyao <Longlong.Yao@amd.com>, feifei.xu@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The call trace occurs when the amdgpu is removed after
the mode1 reset. During mode1 reset, from suspend to resume,
there is no need to reinitialize the ta firmware buffer
which caused the bo pin_count increase redundantly.

[  489.885525] Call Trace:
[  489.885525]  <TASK>
[  489.885526]  amdttm_bo_put+0x34/0x50 [amdttm]
[  489.885529]  amdgpu_bo_free_kernel+0xe8/0x130 [amdgpu]
[  489.885620]  psp_free_shared_bufs+0xb7/0x150 [amdgpu]
[  489.885720]  psp_hw_fini+0xce/0x170 [amdgpu]
[  489.885815]  amdgpu_device_fini_hw+0x2ff/0x413 [amdgpu]
[  489.885960]  ? blocking_notifier_chain_unregister+0x56/0xb0
[  489.885962]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu]
[  489.886049]  amdgpu_pci_remove+0x5a/0x140 [amdgpu]
[  489.886132]  ? __pm_runtime_resume+0x60/0x90
[  489.886134]  pci_device_remove+0x3e/0xb0
[  489.886135]  __device_release_driver+0x1ab/0x2a0
[  489.886137]  driver_detach+0xf3/0x140
[  489.886138]  bus_remove_driver+0x6c/0xf0
[  489.886140]  driver_unregister+0x31/0x60
[  489.886141]  pci_unregister_driver+0x40/0x90
[  489.886142]  amdgpu_exit+0x15/0x451 [amdgpu]

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Signed-off-by: longlyao <Longlong.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 15e601f09648..28fe6d941054 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1683,7 +1683,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	psp->hdcp_context.context.mem_context.shared_mem_size = PSP_HDCP_SHARED_MEM_SIZE;
 	psp->hdcp_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->hdcp_context.context.initialized) {
+	if (!psp->hdcp_context.context.mem_context.shared_buf) {
 		ret = psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context);
 		if (ret)
 			return ret;
@@ -1750,7 +1750,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	psp->dtm_context.context.mem_context.shared_mem_size = PSP_DTM_SHARED_MEM_SIZE;
 	psp->dtm_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->dtm_context.context.initialized) {
+	if (!psp->dtm_context.context.mem_context.shared_buf) {
 		ret = psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context);
 		if (ret)
 			return ret;
@@ -1818,7 +1818,7 @@ static int psp_rap_initialize(struct psp_context *psp)
 	psp->rap_context.context.mem_context.shared_mem_size = PSP_RAP_SHARED_MEM_SIZE;
 	psp->rap_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->rap_context.context.initialized) {
+	if (!psp->rap_context.context.mem_context.shared_buf) {
 		ret = psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context);
 		if (ret)
 			return ret;
-- 
2.34.1

