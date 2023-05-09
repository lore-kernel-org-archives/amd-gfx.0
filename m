Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784E1C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1039510E42E;
	Tue,  9 May 2023 22:21:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77DD10E42C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdAZfuO9RjgIJX3QtfQnvRvS3a+pnV9wCkC6/cr+9kOWz7kc2rrdqRAmNqYr7Ggs9CQqMzp/F1YOjiSZRI9GLjhXz2QdmrRzSdB6epJra90Zrx+yJaYc1N3irYc7FE6SuSOeqR+Xj0/nEX8KNQ3iD/E+OmjfokK7mq0gfPHJwUoxNq5kJ2K0OJ4ncDjU8FrEVWsQ2B1/xX1mfHw7a5nW38yhg3hBskvWaAMShf6Wpr+dJnnalMRANwAmF9s6XP+/4/fJWFqr1T9shLIZRP94FkdZRcCo40JShCdzoRBv9RkjY9XjMTQdIp/m6uVbPhJf00/3TtBpDAo06X8geKLWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYMy49+3XLUxF6rVmo14b+JeoGXz8IiJh0kzNcM+nb0=;
 b=h+rxHPF0kK4F6MnSdZAwaCpwSEXnOKMmZBNzL0fFfQXsbFReElzwzVe5wMf1g/xmbj43EewyqKrJQnjzmCOu+Qylkz7f2Mut9TLXyRB7DjS5sMIaI3y3/zU6amzipuqStZpjfum2NgqXJXBlOzB4Qy8aw+4USxGdjJTaAB0Cv5OdvWu/TqKbjK4SSGaf4VPjQQVXFUDMndJQWpi4vp1NKrGutK5joqfV9O2lnXzLd05z3wzWdvwfqmx+Iw1ca2gqA6hHs1+vBquhvsUBWnQFfisFJE+vA7OWtJgau1WZpVDvcinQa6AL/6sbqmNGWi+F/6/rPS13f9FxRpknCDeTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYMy49+3XLUxF6rVmo14b+JeoGXz8IiJh0kzNcM+nb0=;
 b=1Rs12fX0ZXXIdolkIK8rqkqef2SFIyUXzZE2tdCssx8BLsLIxgU8NZCnRJia76LggREpjrz33mFNV61yfO/lHb7Xn7CBdUZqzqXYGm8aMuj8Z4fWPx0WDr7db13aQBceRJYsWWpQ9UvwbaAuZmBiijZKKdIT0kdnrlYhQXYPLLI=
Received: from BN1PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:e1::22)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:21:41 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::36) by BN1PR12CA0017.outlook.office365.com
 (2603:10b6:408:e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:21:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amdgpu: Initialize vcn v4_0_3 ras function
Date: Tue, 9 May 2023 18:21:21 -0400
Message-ID: <20230509222126.477847-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222126.477847-1-alexander.deucher@amd.com>
References: <20230509222126.477847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4dee62-ee1a-444f-ea46-08db50dbc38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zq4fck1AsnqDpk5hYn/sDnx00rZoNe3bGqbx9XLAU+FT7O0jI7wbTnHQHLPJhH/R/v9R0CnT/p0noQi0mxMt4M1LElW0YkoK+O1B77oLbkipGc//V63eM7DSuRRNlcF0nh6a+zwnGRAepURlsXo20m0ef9pkPOswLctq1oDIMVNugZrWPM+KdIZ7OKg1Umdhr1YcbGNGmwALRypzxyzVk2lqHVPIeCcbF3zfV8aBeVQaa/XRYwkO6srWiDhh/qq46c2BUkVfyjik+QiiRu/Zt2a0aBf4uZr96WAvI2gjU6Gl3eXFMJzUSjIqqLOzM9uhagc/Kt5taSrGEdAy+7FzB8I43TEMOfJuo4S74vDDPpmHkIy2X72zsuGcZtk77elHHr4d0iYl9QmfdetXlPWR3gHFe0hAeVYdHwTC0AhfKrGyl+bzrde+mJ+CSfa5rhhxM30pWjqmPirK+G82f9GhSI+eNLhMAmhs0cfVANxcTbTgo2wkyWznIoSojGWgMP8aUOqB809K68KVPtqV4iuAl21cGfa6m2XzBg/5kU9CIBEDBOhL/og1KKYWgLj0FUXOZhWTgJ0L9lDS+deC1NRU4L8ZHBYm7JAoDyrqcRi80TWiSrK+3k/bKg5KBTeig3sBZTXOigqcJq6c974V9k9Ukz1vwhgYZU2USJigzG9Hnr6L1LClmCUphv4RznF59+iq0w9aaTtv3csh9UqkkY5SJ9Kj7gsz18yIPwia+zy0hyQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(40460700003)(8936002)(5660300002)(478600001)(1076003)(7696005)(8676002)(26005)(40480700001)(186003)(2616005)(16526019)(426003)(47076005)(2906002)(336012)(83380400001)(316002)(41300700001)(70586007)(6916009)(54906003)(70206006)(6666004)(4326008)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:41.1309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4dee62-ee1a-444f-ea46-08db50dbc38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize vcn v4_0_3 ras function

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e8933039bcd6..7558095ecf6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -51,6 +51,7 @@ static int vcn_v4_0_3_set_powergating_state(void *handle,
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
+static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 
 /**
  * vcn_v4_0_3_early_init - set function pointers
@@ -68,6 +69,7 @@ static int vcn_v4_0_3_early_init(void *handle)
 
 	vcn_v4_0_3_set_unified_ring_funcs(adev);
 	vcn_v4_0_3_set_irq_funcs(adev);
+	vcn_v4_0_3_set_ras_funcs(adev);
 
 	return amdgpu_vcn_early_init(adev);
 }
@@ -130,6 +132,14 @@ static int vcn_v4_0_3_sw_init(void *handle)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
+		r = amdgpu_vcn_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize vcn ras block!\n");
+			return r;
+		}
+	}
+
 	return 0;
 }
 
@@ -1488,3 +1498,19 @@ static void vcn_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		vcn_v4_0_3_inst_reset_ras_error_count(adev, i);
 }
+
+static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
+	.query_ras_error_count = vcn_v4_0_3_query_ras_error_count,
+	.reset_ras_error_count = vcn_v4_0_3_reset_ras_error_count,
+};
+
+static struct amdgpu_vcn_ras vcn_v4_0_3_ras = {
+	.ras_block = {
+		.hw_ops = &vcn_v4_0_3_ras_hw_ops,
+	},
+};
+
+static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
+{
+	adev->vcn.ras = &vcn_v4_0_3_ras;
+}
-- 
2.40.1

