Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461CFC761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C4910F359;
	Fri, 31 Mar 2023 22:46:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C5B10F343
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQZACbU7XktiYqCqWytKNEWf0pCkelEs4RZhwElULVFht7I/wggNWRTAmlx4H+2WCqHtLDBUtebtzHypxVMKrANGXHCnOMMQQuUtX0TYdHXio7JBplbfvkpmV86fJUVk6uH4xyxXr3AvudmBW1tGhGH8rd9jSZKcgBfzPT59WvFPEcwDqndkXZrMxghBiyFmTvVor4muOONhyAqRodwyMwSov87JECPzQUzDkhyjgSC1BdqNxwhZ+YGkY/HgSzqlZs4wutoRB5CRJGAErWmE8FwSgJILia8VF7UnC5T6qiF3HPVqRuGjRaq+u+Z3PlEHuI+HCwj+EimTKnoRr+0eCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEgmDvnLLLEoSaB4ntdevjrxuMPkxQt4itdaudPyVpg=;
 b=C6yYZ0xAvgQ1rLre4VtjI1dMhNFzUIygBakP1319yGSULthJI+h2MwNskP4meZX1rphIbNEGV+NM9LCq9aT5EYR42JRqexv0UJD+5UMs2GUWxzk4cq9QvcTVceZsFbprftI6v0kkr03d1n+nnYMbzkRceQNuLBX0E4YNVHS8lPiu0Pg+e/RD71a5GIyp+UgQJ+l14rmuhv0nUB9x+YTbP/1CbrWfKv/W/BnJslFyTE3+Xxa4QY60GtPE9gZXrd0bLxIjkd1tlr9/xEipaDJHeqZ6zG/rpBxnjcg5dZxkpjCnb/wde9gzGuuuBse+uObymZbVRmip2ZJMPFjoyE32jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEgmDvnLLLEoSaB4ntdevjrxuMPkxQt4itdaudPyVpg=;
 b=Esjhx4wNqJCSffDOrd45cCWFJRNG7oyV+OysaK+JBy8vWsYn/uESCO7NMSZzN06X8TfKciuoGpTLGSEqd6Qr1AnLfagRuz7JeHrErs27Hw+81CrDWweJ/PCQGyxM0mpDEK7lWsj9vqNHqjXZyW13MWHjL2uknj6r+i1fEOVhITU=
Received: from MW4PR04CA0182.namprd04.prod.outlook.com (2603:10b6:303:86::7)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 22:46:38 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::f4) by MW4PR04CA0182.outlook.office365.com
 (2603:10b6:303:86::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Fri, 31 Mar 2023 22:46:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:46:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Initialize mmhub v1_8 ras function
Date: Fri, 31 Mar 2023 18:46:15 -0400
Message-ID: <20230331224617.8961-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|DM4PR12MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cc2225-74cb-4177-e565-08db3239c95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShiBpwGBBuwQNJ9dBxCiNxyo5mfP1I+A17Jm/6RTUIBxfrWnLQvymB/sjvIWAViGBGLlG2U0MOhIRusnCXwt1tWpa8gjHDJWoe2t9ifmkY15HTwKkBwHJ31JFas2VmcE8sA5wj38OMgpyclK48CtVfywtUUbaLhzOvr5hK4PqjaxBCFvM0kWnsdi9vgObLsxB2CxvnIsCr421EL6NfzFVsRpvC65SnfRDq6PH2eRYFbKU3YoHXbVo0PquCNlNX5M7OixCSM+ZUKEWjGAQRMauzDi8V1J9I0RT5VPrJgEaSP+Pss2wYgXBhQEwVjjODz5W58W8IvF29YIp5UXEOAMU/PeIlBqDN7/jbCWHG+TKCVP0fcZfoq5P2l5/d7g+Waxl0aGwrF0llSj1QykOjdRaoNbHgGgHmPlyMdkuNEBvtfTwx9ppamGFWPZCEnvBF7pd6Q64EK6NnoXQaA8I1hEgNONEagzT1Hp2ud4NPQYPWaBCRMgsaMdMM55RlnvgRacz5zS8ffUCMXO1F3n9dCGn1DHw+4SU+rPqUTgQNKvyoUmarV3uok1Z2hmw+T6Ga19buL40bTwklsnYHwQy69OskRFXZUFvHOuklLKMTuJoZlIAvJDxNIsA1mTDgpCivxwZpMr3BnL6fBUA5OYcfHgKH8kgGE1vsmnOWDbz0vtCfMVGUn6xq3W0D51dcR48xo7p3CzMUCCYm0Hg3mIiPu47W0Qce6jVgl+453ISxOtmjM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(36756003)(6916009)(70206006)(81166007)(356005)(40460700003)(5660300002)(8936002)(86362001)(41300700001)(4326008)(70586007)(82310400005)(8676002)(40480700001)(82740400003)(426003)(36860700001)(2616005)(83380400001)(54906003)(6666004)(1076003)(2906002)(26005)(336012)(478600001)(7696005)(316002)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:46:37.4327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cc2225-74cb-4177-e565-08db3239c95c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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

Initialize mmhub v1_8 ras function.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7564c6b237eb..e1da98fcd637 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1401,6 +1401,9 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 		adev->mmhub.ras = &mmhub_v1_7_ras;
 		break;
+	case IP_VERSION(1, 8, 0):
+		adev->mmhub.ras = &mmhub_v1_8_ras;
+		break;
 	default:
 		/* mmhub ras is not available */
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 5c962dba8ece..29a31bd483cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -847,3 +847,16 @@ static void mmhub_v1_8_reset_ras_error_status(struct amdgpu_device *adev)
 	for_each_inst(i, inst_mask)
 		mmhub_v1_8_inst_reset_ras_err_status(adev, i);
 }
+
+static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
+	.query_ras_error_count = mmhub_v1_8_query_ras_error_count,
+	.reset_ras_error_count = mmhub_v1_8_reset_ras_error_count,
+	.query_ras_error_status = mmhub_v1_8_query_ras_error_status,
+	.reset_ras_error_status = mmhub_v1_8_reset_ras_error_status,
+};
+
+struct amdgpu_mmhub_ras mmhub_v1_8_ras = {
+	.ras_block = {
+		.hw_ops = &mmhub_v1_8_ras_hw_ops,
+	},
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h
index 0bb36200e4e5..126f0075ac50 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h
@@ -24,5 +24,6 @@
 #define __MMHUB_V1_8_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs;
+extern struct amdgpu_mmhub_ras mmhub_v1_8_ras;
 
 #endif
-- 
2.39.2

