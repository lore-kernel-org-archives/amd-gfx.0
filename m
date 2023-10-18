Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86604CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 11:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CD310E3D4;
	Wed, 18 Oct 2023 11:40:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF7710E3D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 11:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT/ggNkAHqFot5MGPvUbe+VYd5BsXbWDIpgyME7uCAfHo1UbB3aj9nk2IxE9NEi7EyOBYQ4Qz7aZJ9jqzu8mpeP7TE3jdgVZ+5mlxoSxtBXtbi739ySosx0qNHa85MrlG1F86GjgEFfhF/CB2emxn+BUJ7/qqsKN1iMA2D4pyd6vnKZK/f5+JPpAJhNN3yZi3GclS79MbReweTvVEXP7tWrkJnrCizwo2XGVNtmC1ox8DUUiOpg+aSbLjQiVtxF73vHXC2h8o4jr6TEwTr5lKQdanZmOwyjIpktX1LJRSSOY8M4uw4FSrBs+pvVqIWYZ2HDQXurpor5zbpzC3Y7UcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25KWuljzXVxrBgFZqnIQNeEa60nTlFz1nVKFhlYdFzQ=;
 b=YV+gEUybIIDrXgqUzex4QlKnbpImETxojnwHzGhWoEwrhU1pRGaeH1ReUxJVH3n0W4Oso6N6LZI0rj28eLfvyfdg81N7U7Y9egDJiObcUIjaS9jOeaX8FM4Gv7r0nKlzHofIay7f6jODxQfkxYeFjdqwMd7K3RafySKgRzMco1cU8nBaF0y6h+1i85MQNrbbKnx2wtfVfL5lnHBCfeJQTwK8F19yZFtp3O7hcwSlZ7VtQYWtlk1Www430C0yRePx/GT5QUTZwMFudz7s8hNp20sPZd4EYFAywgaOk3wkSscXLv5IGDe2nC5l0f9jmB4off1AYYaSZNuyJDcD38eEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25KWuljzXVxrBgFZqnIQNeEa60nTlFz1nVKFhlYdFzQ=;
 b=GlOFc5l4FJaS+X+XwX032duEFNKBX7Q1A29nZdpU9zBiXdBC6vyi26Lpn7l8VOOGkLbNB3n0WEAwmLqVDTtCSU65YowhGJMiGHkM6cA64NyQdtRze/uxxk8URVs49lQqqj9Q5SVElTbMXc7dSfhOjkOJcnyvlhzpSDBv3EuvMxw=
Received: from CH0P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::6)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 11:40:29 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::9f) by CH0P223CA0030.outlook.office365.com
 (2603:10b6:610:116::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 11:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 11:40:29 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 06:40:26 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: add set/get mca debug mode operations
Date: Wed, 18 Oct 2023 19:39:54 +0800
Message-ID: <20231018113957.20079-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231018113957.20079-1-tao.zhou1@amd.com>
References: <20231018113957.20079-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: b085ac30-ad36-4347-b28f-08dbcfcf0794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRjHfZKkx+asJhDz38g8+arwVi3MOK3H/2MiR312V96NofDX9x6duX8Bd78v+b6DVMjPQ/BoEslLUypwgcqmBz5PucPf2JYriqrZIuKNtz1zO2zoeAZj2bdjsSwAsN0dwSj5q8OaXOiVOTpd9fDxRjGNxPdDn07reWocJASoBTedzOorZznc9T+rvEUfZW1eDrxn/EKcQ6NiMtJhpyQgPzJ1rUZpjypzvfAWCuC10v4N/0RRlPWWgsET1v9DrXkYgNd3vi4kMFsrPxJsioMZ2NHCCKKWmr8cyLeXYGXgS2xNWG9jINP0Dq0J3LIruEks5/TItVFa+RWX3LRsnKdv1cNDo1WLbU1uHepZz0qwPrHPvaqJf32E5oytwvaWKh5BrQ0wOpeedUDVNd41a2ghesR25odCaC9cqaihOMt+dfx0f0vNK2UdYFgGpnap9bJ8SecfFB6JQutFIv+99I/d0+9zNNn+RPqdWhuCDXdPtMGtRDR4m73rKkzAUJHDPnTGve7OWWvNPOORCwnKEcChPgy8dyPu7HqqlOVUu8bitfDAQ1dZSCgu1oLEZDb4bLioTxnWP++yrZhI0xLwtgOfj3TqNn2qFaEiuKr6BoYjJfmmgROED7I+uPRp8G7n8ju6OC2KnsuFVZgMltxUDxtB6wo4Mk088YbD23Mo7AtMIcFVs7WAIg3jhVogPja92VmcTC9tkni1xssJTfHTyHIXYv7awk3FyMjpINNln3RqwHLdvRl19mAGPhookIPIqrHwewdhfkUbTeQ7lPZJGbZMOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(26005)(1076003)(6666004)(2616005)(426003)(7696005)(8936002)(16526019)(336012)(36860700001)(83380400001)(47076005)(5660300002)(41300700001)(4326008)(8676002)(316002)(2906002)(82740400003)(478600001)(6636002)(70206006)(70586007)(110136005)(86362001)(356005)(81166007)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:40:29.4641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b085ac30-ad36-4347-b28f-08dbcfcf0794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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

Record the debug mode status in RAS.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 335f5d8bc20b..0eb3dbd9d548 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3323,6 +3323,27 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (con)
+		con->is_mca_debug_mode = enable;
+}
+
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!con)
+		return false;
+
+	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+		return con->is_mca_debug_mode;
+	else
+		return true;
+}
 
 /* Register each ip ras block into amdgpu ras */
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 3f9ac0ab67e6..2fdfef62ee27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -434,6 +434,8 @@ struct amdgpu_ras {
 
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+	/* Record status of smu mca debug mode */
+	bool is_mca_debug_mode;
 
 	/* Record special requirements of gpu reset caller */
 	uint32_t  gpu_reset_flags;
@@ -768,6 +770,9 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
+void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 				struct amdgpu_ras_block_object *ras_block_obj);
 void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev);
-- 
2.35.1

