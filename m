Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B17EC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E3210E95D;
	Thu, 18 Apr 2024 03:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AhmY9hAf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAD610E95D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHTnbyxv2Jbm/poEwWtcCnebqLZWh3RixEKGBMDLsCoBxjZUBNt0BVi/0M2Jdq4SNT5wR/IASFiec8BiWwzx9/Td0zNFRsbybfQXvSzY+XLmAjUMvPVlND3UTQMuZrXfxz9++WtjNDBBzNddgPoOEvXwj9aim6paUdYA45FwN7RNXyYhR11zLVyY+Ilmrk7RLRVwT2+UTsPLoTqMxAMUOwoce1w+ZDSOJ2kfaz8NQiMQDQuzMclfSq84k4mmWoR7vFhg2oOC1/REqoNN1L6vtfXGx8/udx33Wktd2HmkW7CD1Q/JVIK+8xHd5p+S6ceeDj3kVEAiBizVQQRBcYzucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB2MZyr5IGAZI18aYuySx5jv8UHBugX0e3ugTMSlCwQ=;
 b=n8J2oPH7AO+AgbpAHhg59a3NxBwlDYNIXxisYd2DTFAaPW54s7KoIhofTsGhlNMnEu03klJvPBt5k4YyuHjY8wpjMVnjUJMREK/Kczd1j1s3FjB7f+MxfP7jjLZBqaFppzNmKt9LkG3+9O9ePT4e5dOnf7WLrJ7SL7j+rwBeBS9LJP0HqwRQ9zs1n/BHoKM51sKtt6ko9lQ5QKQ5xXM7CKNH2uZuDnCr342nLR+88mmS0hXshy+HP4uXzyMpPABllPbaoWl5bLscpmvlRyOKlE07YHL8G7NIpjGWZS0i0nbypYOeMukh7ZyG8WF+Hu6hbyDFJr+XpSSw76n4mNNsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB2MZyr5IGAZI18aYuySx5jv8UHBugX0e3ugTMSlCwQ=;
 b=AhmY9hAfpLEF5ke7+u75Td7ZKnNxqgAEFJIqwxR493IFKu+jLmiXqAcJZHJYYqqUQaEvIx1cGmXc4IvDhDZV3CciVUqW7PEiNzYPpF1rqUwMr1hs44syvcCwdI7baLIwdJ5flQ5tWFgTYqDbB1E5xKJ0Drcgymyb9EaueiTQWk0=
Received: from MN2PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:c0::36)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:02:19 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::4a) by MN2PR05CA0023.outlook.office365.com
 (2603:10b6:208:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 03:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:02:19 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:59 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 12/15] drm/amdgpu: add poison consumption handler
Date: Thu, 18 Apr 2024 10:58:33 +0800
Message-ID: <20240418025836.170106-12-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 158b0aac-ba49-4a55-49fa-08dc5f53f645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJKSUz945itaKc/CUZ2UFAgG0xaPSlE/MxVfF17DAhEvUdc+/e/snObbd8d86ngsZI2h5ionwr1WZStqd60p0SUxyVk0ShpJohzBHhrsp3ES8gla/bfGJm2sVuh4+twBNNsF5iQcmRa5iK85SfZCSz0Nl4q7PXqMAo7H2tbdpnKbLYSyQNQBFgTZBRuA/uY3HRAyoss5Ue2S6GGSonbaaAJvUVLzpfaydphy9LUjQB91O+cyEwZ/pFJ8Xt+2mnO62dBEDDXZ7MbZxVZpCNNqxCaK7uk17Ti85vBIG7nDpw/+pEbq0s0DdrifM0CJYkvTG9xz/+MKCeBG8fs+PlH2WwxtLyITschXWGaZQYp0XUPLItnkdjUN7b14o6wXcL15rnvC+EvxTdZIpnS/qK9Z17KeEsfT1sxZsez9JEmqsQ95tqAkHl2WVGumb3jkP535uOwfbS2u0lkzEcMA6c6IYNMP+oumhFXFpBRnyN2hZzfU/kEMbnkKARZU8ulsfZvkI41JQ5EycVGnA8PRGERujjlSpSvz30T62oG/g5oDtl8FyYokn7H0m96QEVCEnD+BbHFEbebClWXL7ReS6XGPhRIyCrwu/zj7d1f7wj5zRA+X9JVX5OiMS6XKrVy/em+k54MMLNCL10g8Vw8VAEeOjCbLSHeK/3Z9T6faoR/sBbaBe/7p13fhQPADJk1FdEtDaABwHK5/FgjLP4GjIug2jeHB1c+JuO03Ts2qayrO+r1lPgWKa53gic9tMVLdkeSM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:02:19.6865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158b0aac-ba49-4a55-49fa-08dc5f53f645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add poison consumption handler.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 ++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c1f146d3e28d..3f34b3abbd79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2838,12 +2838,35 @@ static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 		schedule_delayed_work(&con->page_retirement_dwork, 0);
 }
 
+static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
+			struct ras_poison_msg *poison_msg)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	uint32_t reset = poison_msg->reset;
+	uint16_t pasid = poison_msg->pasid;
+
+	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+
+	if (poison_msg->pasid_fn)
+		poison_msg->pasid_fn(adev, pasid, poison_msg->data);
+
+	if (reset) {
+		cancel_delayed_work_sync(&con->page_retirement_dwork);
+
+		con->gpu_reset_flags |= reset;
+		amdgpu_ras_reset_gpu(adev);
+	}
+
+	return 0;
+}
+
 static int amdgpu_ras_page_retirement_thread(void *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)param;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_poison_msg poison_msg;
 	enum amdgpu_ras_block ras_block;
+	bool poison_creation_is_handled = false;
 
 	while (!kthread_should_stop()) {
 
@@ -2864,12 +2887,24 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		dev_info(adev->dev, "Start processing ras block %s(%d)\n",
 				ras_block_str(ras_block), ras_block);
 
-		if (ras_block == AMDGPU_RAS_BLOCK__UMC)
+		if (ras_block == AMDGPU_RAS_BLOCK__UMC) {
 			amdgpu_ras_poison_creation_handler(adev,
 				MAX_UMC_POISON_POLLING_TIME_ASYNC);
-		else
-			amdgpu_umc_bad_page_polling_timeout(adev,
-				false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+			poison_creation_is_handled = true;
+		} else {
+			/* poison_creation_is_handled:
+			 *   false: no poison creation interrupt, but it has poison
+			 *          consumption interrupt.
+			 *   true: It has poison creation interrupt at the beginning,
+			 *         but it has no poison creation interrupt later.
+			 */
+			amdgpu_ras_poison_creation_handler(adev,
+					poison_creation_is_handled ?
+					0 : MAX_UMC_POISON_POLLING_TIME_ASYNC);
+
+			amdgpu_ras_poison_consumption_handler(adev, &poison_msg);
+			poison_creation_is_handled = false;
+		}
 	}
 
 	return 0;
-- 
2.34.1

