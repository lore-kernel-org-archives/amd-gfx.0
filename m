Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC635ECAAD1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 15:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD9410E12A;
	Tue, 30 Aug 2022 15:24:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5B210E12A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 15:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcN9c/6PLJX+z+kjXbys32MKGxXB1Lr1E+sbLY+bte0//uIW3r8J+3AJ2h3BcvN8Kkk5FtyJles4WbMNH2bg3B60c4HogilaT6k4UFgSCis+30rwFNUdmab3C0EbflojSA0UWo5jJ/9/ye9oLdLnZ7T9zY2KwIrQgE2X1zXxRW3wMsYhrzs93vu1YbyGWWjMe7hnIlHJVOj2Ra3+W/Z/d6z09LMV4oEY6/TdXN1aX+7E1rJoV+9iXvorV894lUveRUnuPkc/HdYnBNVYF3o3wJHDa9PCJ1qCw+cl3YWxDZ1MAuBLSfhSjYljbKhnddH5BV6366gWM7bdWugjxU9v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1l5VBOxKclCkhXnQu+ChQNNYWyMf8sES6PxlNx3IkE=;
 b=gPgDHuRVTbgWWhCn2Lfgm+aJJJMeCE8yDkLVc82cmB4Uj79kDUTmqKvII4gsWt0CblBKMdYexhmzCu9/VmD3dpjbtt9u3aDjvLB/wGlt/lLiwckDNJaouJCiW30yoUPAVwaDysOJZ/U2tgsONLpORxX8qcIhlNsZy4O+zJFlJWOH4RWv00+19m4R3hC4x0xOGibxXipUwFTeXwv150GqKEpgBtXuVhezcJ/0IB/6nQrBTWIvMpKmOFmDGihQg5ETkndK4K1VbcpiDoNEa9YuGIkIeFWfilgmsxjVlBs9lqttlPBZx+Ntw5U3mnSPRKn+48wST/PUjQ4NJWUFrP3dXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1l5VBOxKclCkhXnQu+ChQNNYWyMf8sES6PxlNx3IkE=;
 b=TRfAT/J2612roOJ+AV0Tg0Ogrf/DUbPogCr9lmPQp69zHTDzjac4k9IJJLnKCV+LokGZJD8SO5KmcHPWmdC0EDCBvqNHRcdZ+ygSxY4Vwf1vZVc8W6rCqCDNhH/1fMxd7lUqmL1us9rAbrAAxgeVHm+iEqmHxAXaR0b+/TMIDZ4=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 15:24:00 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::70) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 15:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 30 Aug 2022 15:24:00 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 10:23:58 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA engine for
 SDMA 6.0.1
Date: Tue, 30 Aug 2022 23:23:35 +0800
Message-ID: <20220830152335.3539841-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d0ba31-4fed-4cb6-116c-08da8a9baa24
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziLcsbNiWAgWpyPeyAANQKFKyQmyZM5ZYA43pd5XaNckOtDXmfrJcn0QCXhaXY/7XjhZYOG5euOnv7vikasNZtl/ddICzOZv74ovdoTfRMFn9I/kWvq7+8Qi/IvM0TWG+O9+OmGInrX+gUTuod5Bq7b8XfyKTEODHedY8EPHYl0UEeVxjj34jQFk03fq+pdmonAlFGxQrF3PjGVgymD2BfAC+PhgQusLLb5dqDhJ0QUs9hMVXGZU2orIsy7u0/anRs/M8yzvHcuZPlmkRNyrmvG1EDFAoawkJWtqdxxvwzTBVG2vYNFaNlNq4clOQRUM7n4o4ZoIRXlBw7lhltVyiBkHM1b7Y3/UYPwOaHDbVCob2VZq9WS+/1fnayW/qEvPXNj9ZKCn41L2oybQruAMh4OE9AKf3NnFvLsLrhbq3g7A5M+jjkW1ZxUBL2XDAeS/N+ZvX+38JzJXgCC59Pbrdgpfa9itUMnY2KT7RMLofkw2ETJ4ZXTA+oMIfje70Kc+isitr/uq+Yh9tYYftLhwkmCP/wLSGwhpA35jl11L31GaQr+62zvxZTumgqNgTw6M3Dfi3icl9Qxm/XaNJLzXU7yOay+qAsPcMPKnETZsg37tJNrUbw7p2mmWN2tc/Xldf+k426gHRNtFIIJY1xiUXP3bj4OEWjOwNVZ5/EvFBipQdRUZi4aBFOHB6K1qK0duBYGBjw9nOIPrwdhHsWDGrEzKAHxTYVl1owMXrh/YOO5Bh6DloovlL0/7ktssiDowf5yFUfiSkfeGSmAl9iJvfnaiQsteKI8kfty3tpJL5iWbpHlBoPnDZbA9uCK/IsLF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(40470700004)(46966006)(70206006)(86362001)(82310400005)(478600001)(6666004)(7696005)(41300700001)(81166007)(26005)(40480700001)(82740400003)(16526019)(336012)(40460700003)(186003)(356005)(426003)(47076005)(1076003)(2616005)(36860700001)(54906003)(5660300002)(8936002)(4326008)(8676002)(2906002)(316002)(36756003)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 15:24:00.4775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d0ba31-4fed-4cb6-116c-08da8a9baa24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Jack.Xiao@amd.com,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

there is only one SDMA engine in SDMA 6.0.1, the sdma_hqd_mask has to be
zeroed for the 2nd engine, otherwise MES scheduler will consider 2nd
engine exists and map/unmap SDMA queues to the non-existent engine.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fe82b8b19a4e..f876fd62ab81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -185,6 +185,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
+	/* there is only one SDMA engine in SDMA 6.0.1, the sdma_hqd_mask
+	 * has to be zeroed for the 2nd engine, otherwise MES scheduler will
+	 * consider 2nd engine exists and map/unmap SDMA queues to the non-existent
+	 * engine.
+	 */
+	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(6, 0, 1))
+		adev->mes.sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES - 1] = 0;
+
 	r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs);
 	if (r) {
 		dev_err(adev->dev,
-- 
2.37.1

