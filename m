Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FAAC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7D810E53A;
	Wed, 10 May 2023 21:24:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F155010E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBP6sp6xuMDcWhuwkKI/nquhwhvdWxLeACGmk6gDK6hZfQur9r0aBHQs21bObb4oyJhE6ke1hrTPhhBhq0dGw/6M+nG2lOOz6giQjUS47QQRPtdNrxRA/1tWgY1W5zLwCqnv8kLdJdrWfO5/Dgca2eW9LtCGG9/q68D9i5D6UJ56OQQE5tAfbFuWndNRkwzfv++lU6uLP69pEhhDt7W0dcVcu25HfbQ5iOhTFbgtu7JQx2qguyKww3gUP0isTpmUb1NcWyRPn/+FeT68815pocT40lJ+q89tC8YnqzgfLkSn/e+wLilHOhaWtqhbEbRTtIfHKOuiH8Kwb3aIwqwdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKA97U40cEb4bPoPlq195IaZFcf2g7GCWgi3w63VQfE=;
 b=XoDay6bBFjzUIkQ5jXWvNwAdLiUiRFDTD+fAXjPyeTG0ds2rycZ3NN9f7EAWsjOc0QkVOw8flBuAP3t8ef+/1slDrhU55KCI9zkYYySYfpUvpNgWf1PO598lEO8LUaAcpWILOCxpXAm3Tyg5kKN14VcNutVErakeGdA48zwqyXM6SHRg7Riq5B1X2ANWd+ISGQ7Nif8yG32QLDBAE14L1Sr4SAHk66ZU+ghmkdHp7OkG//yAeEqNmeRnqJrzMDQl26bwW8vTyHg3h/9pnfmUSyAOam4oiLddqjaYiOiJChTaN10xL45Wp7lVeINRhpwEJYtRSpAeyUHhuB/fo+B8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKA97U40cEb4bPoPlq195IaZFcf2g7GCWgi3w63VQfE=;
 b=TKgcA8GxFTj9T0Jb13GuRLC/DHnFkC1CLeBp0inKN9c7nyMVkCRwKqzB84ln/xjxIdvZZQhRrmYnxBqxCzZ08NPFdYagKxyFCTCqBRxGy7GOxcuzj/pbGidyYLQgf/2w3el0A2S0OGviGzKLhMFeWfWSETZBsgaKOgQllmt+jZc=
Received: from MW4PR03CA0088.namprd03.prod.outlook.com (2603:10b6:303:b6::33)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 21:23:52 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::1) by MW4PR03CA0088.outlook.office365.com
 (2603:10b6:303:b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/29] drm/amdgpu: keep amdgpu_ctx_mgr in ctx structure
Date: Wed, 10 May 2023 17:23:10 -0400
Message-ID: <20230510212333.2071373-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f193d61-2d6a-4d0c-de42-08db519cda6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlV9DBKtLAmawA+DoI5UpHLrJA38YJqVO9LdsGg/Wl237u4RiBBcdZFnaJIL8iDb+5ECQdwBQBypJIuceWqdCN956L0xE4dDVt/a7hLPQUH1l2HhNila8SeUclR7aNuIymdtOq1ke/wpL7Kr8GdkiRcZmuYQjN8oAlyqh53GckHlNOuxxVTJAqQJj3T6iyRDaZdi4AOcNtZ4qJ+DG4bLuizHF5bpbFhiKvmMX8skvA6MahFh6EsYPcgO67bOeOxhv2mfybQIZ6GQcU+GEIYtB8l1E9P3SFG6CkPf+faWJqY/hnwcm6mj4iULcXSh3uPYElrOlz3f+UTz4UEIlpYBBhP4AKmBhj/IPIhMakqHWT4qDqBs0QX+W7u5JCmXQF0TvvJqa33ZjVRAGduqW8dTQBGBKRNBD8qSsYMpa/KOgFhiTCf+mrF6omWGLY1hHZ5QWVdY1eDd8V9CcrdVnSlEqMnsxXSyfqHVcKkjTx+dzQBm//JOBTugTkkf9HRptyyPyDyqjxkNfJuVZWesgROzP7VqRJEXGWKtQzAldLS2FmJ/d1e5OOhp2CZ84gH63YOWulubtUMco8s4fhKGWPIcONIn3tAcrdIeh9XdxA1Pn9D7xZ7f1symhpL3NW9btruTCfsmkBst7oc8A3QTzqOB5pvQA5IA1FRD4bNrxfq36z/IVVVzaWjDALEGjING/x3U23/+uriLsQwCoO73qRis3RvtKhKIW+0pr47Xub638LH5/MLYKR9b1Sg/wTYrWsDqPIHWFgj3Q3BJZAuKvJ+sIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(47076005)(426003)(36860700001)(336012)(40460700003)(40480700001)(186003)(16526019)(82740400003)(6916009)(70586007)(81166007)(41300700001)(70206006)(5660300002)(8676002)(8936002)(356005)(316002)(4326008)(2906002)(1076003)(26005)(36756003)(478600001)(54906003)(86362001)(82310400005)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:52.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f193d61-2d6a-4d0c-de42-08db519cda6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Keep amdgpu_ctx_mgr in ctx structure to track fpriv.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e3d047663d61..06d68a08251a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -332,6 +332,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 	else
 		ctx->stable_pstate = current_stable_pstate;
 
+	ctx->ctx_mgr = &(fpriv->ctx_mgr);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 5fd79f94e2d0..85376baaa92f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -57,6 +57,7 @@ struct amdgpu_ctx {
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
 	uint32_t			stable_pstate;
+	struct amdgpu_ctx_mgr		*ctx_mgr;
 };
 
 struct amdgpu_ctx_mgr {
-- 
2.40.1

