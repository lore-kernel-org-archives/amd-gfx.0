Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4EFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 15:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD99112BBC;
	Wed, 22 Jun 2022 15:36:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96209112BBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 15:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjODVKybLzWi/mA+X2plEHdW+lMQjjV1Dp7Se2UNVEKU9oJcIC6ZhEbUK82Iy+1n2OcwJ7STB+tRpYt147lTQL7K0CqEjX8r6bct5Mq/TzX8dAdQ48tdHnyuADzZt6e6xPHsPLmgGwzGBJp26jWq+WSpn78j6haIU3Wx6QXYhAhTRZjk2qPMsSyZV0gQhBlzuL0W9IYWdHMZkaCvUT3I99IXAmv0aZR3p6SpsOOa+cEN8yVq5m5vQGJin/0jdxfhTA2jgZrltYl6443mGOVqauroF7o8LPcXrFB+eL+B2vEbfsonoSv/97paQpkRoqAN8olGxE9+CCT8xZ3hvhnJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og55HezQBtfyb9hTrmbyoDLbHSsRCTtzGs0Z2xBGhV4=;
 b=n8D5xK9Kv2VlvVEaIaa9KhA/iID/4QNxxztHpXhJct4pHqqEDWTQHgEeVcsgqfIZepP4b/69VeC8nCj3NNIAScy3LS1+rqomWOsirhcg/nHbPl2BvlqqDhiS/+QLINWKKM9XoiQHpk6ufupHD+DnOhc8nMymVSHQyBNdHiPgAxPiDrJ/8aimP5Fkl/f3oqAlWFCNs4C0fpQeKNq4gTplBapAr2eMejN0fdXP3XemreaGZQTXnwN8z76HCmyu3Ip3+rh+y1gPVkwfCGLsSTPUUna4R/PuiZvpQrBbkZyKZNX5G4aLIK5Abne2mOeUPi03Fxg65QsmYZDyrLorNbkPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og55HezQBtfyb9hTrmbyoDLbHSsRCTtzGs0Z2xBGhV4=;
 b=emhEloXuUZpFRzKRsr+ERdenxeQRBbTW2OqGv+WSommEMQR2nUXSl9c5a9MfdgX2zwCHakYpihnsNMVh/OgJSfT+EHj4LStmUP+31LFcnLvraDoU8ITFkvy+2BeltrjIMKvVXHne1xWMT4fu0BYvrdJbVzQ9TbHPJQJMiLQLIrc=
Received: from DM6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:5:177::18)
 by BN8PR12MB3251.namprd12.prod.outlook.com (2603:10b6:408:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 15:36:17 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::a7) by DM6PR02CA0041.outlook.office365.com
 (2603:10b6:5:177::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19 via Frontend
 Transport; Wed, 22 Jun 2022 15:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 15:36:16 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 10:36:15 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions
Date: Wed, 22 Jun 2022 11:35:32 -0400
Message-ID: <20220622153534.173993-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd101362-551a-43c7-e081-08da5464f26e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3251:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3251C6B9AF06DE3670B41C298AB29@BN8PR12MB3251.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2ZpKNyUIWhcfCaQ8TSZFA9PpjRUgGoNPMoC2jd4YF5QFc29d/V6n3C9FAdhpJvYzeMXQokdkxZPPh/06pWhibB3f2huwFuYLrDD/MRKP5jxysj1DtnBp95AyNRHVNrHSwAiwiuvkh1TGF64UdapntkL9yXU1305Jje0YPWDSlQ+bGVGtJslWvHIY3ZI5H7j07Wsarlvd//bSNat3SD/q0f/B5OEgbrkmIsLGPd/n91uCckFFnb/JsJyHgwKD231clSYIx0+5IprgYZlOU7k9I6HRVCS+8iLKZZpYodau4nnLdGICtoRI6HeCFw+HK+sguB9L3Q3axcBCWOkyxCBnOIJr4vBiR5CB+184tKAgfTqyh6v/jGWrGJMe4jZFWHu5fvP2V5DjoWpSonLKqts762wVgOFRqBi7EpDpqbYTYxtn58KA1LNgkxFbwHSv2vsNy3XC5MZzpY8FWwaXFi61FNQVhjra7fTY5xjzyI9JhnI5luK57QgVO1pYReWW/zDUbW7c8qb/ysBHVQlln/oUcJe465EfQ1XYB3jn1OckILR6iP/idaeysJzYxC5Wm9Wi97GW7j+xBxiMHzDBdSLAPOaT/vAuz5gdwJTND9HrFcvEaIT2MQlbOnF4ADwNBYhtXIoGqRO8oX0b29+YvlAZnp5aEm1rYjehwdqtB7qMi7KSAvaGxHtS4kVZILLOc7kYW9XePVKVr8yLm/P9slID/Oj7XoNcaSsN6eStKw3zvPVQsLREu5iraeaiKVv/v4bDqs/3GTB/ABKoSWitKokELY8CTS/MzsWt/CrEg8b4Ao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(7696005)(2906002)(86362001)(8936002)(83380400001)(8676002)(6666004)(5660300002)(36860700001)(478600001)(186003)(1076003)(356005)(26005)(40480700001)(81166007)(70586007)(426003)(2616005)(41300700001)(82740400003)(4326008)(40460700003)(316002)(54906003)(16526019)(36756003)(70206006)(47076005)(82310400005)(6916009)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:36:16.6224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd101362-551a-43c7-e081-08da5464f26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3251
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Store MES scheduler and MES KIQ version numbers in amdgpu_mes for GFX11.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 19963be9e61a..be4b51a5b5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -64,6 +64,9 @@ struct amdgpu_mes {
 
 	spinlock_t                      queue_id_lock;
 
+	uint32_t			sched_version;
+	uint32_t			kiq_version;
+
 	uint32_t                        total_max_queue;
 	uint32_t                        doorbell_id_offset;
 	uint32_t                        max_doorbell_slices;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 7eee004cf3ce..ead1860744d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -858,6 +858,18 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 		mes_v11_0_queue_init_register(ring);
 	}
 
+	/* get MES scheduler/KIQ versions */
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, pipe, 0, 0);
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
 	return 0;
 }
 
-- 
2.25.1

