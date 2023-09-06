Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63088EE14A5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 15:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B422010E1B1;
	Wed,  6 Sep 2023 15:36:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6326510E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 15:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNd6K/6Hk69uO9wKRYfG77BZcDOruvgh2/5W+CssY0KoHB6pt+7Ylb+cDlyeLchPsjJtwoiX6naverMNHRbqzfJ99Yvdq2YoeDgbFJLvZGZsGmpr9Gb7S5N48CjsiLruJGA6DLQ5EnNAtk0pnJd5/UMKNo2HM3LkZtmjcXQt0M+it0W7q943isJly/XvPPGRexsUDIWrRhss3Qkg69dd60yGzc8zdEjxq2jbPX6RVdM8yiq2ITxyYIPk17facKec2NNZZAp6CGwAhRXykjTe6MRJxDm/lZ9DpIvBq9fpMtOAIueFLCrpRgp89dhM9FBDXCGmqvE9Kq08otg9oLwfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMJxdiF4OHwrdYg2aIsjBbzDiMKucZ0T87EBUtJ/aBY=;
 b=NdEhhz81ywUBxa9HQr3g3/5I9AejExvHMVdldEILumX5IBPhE6wuS/B8AVJwcGzXASWqaplLn+DpPsgkcy2gjMGyVtu7fFJuhcuAKny4hjsp1qNIRd/H1ljbqVnyZASUpHEAtRZYKlhbNqB3MXucZB7uGC8xDztVhTkBGVm0cWXtyjeb3reEZ/aj5OceXcqi9UEpwiXsnSt4lCNuU5VrnZmmaKltazsyaiwaZv3gPHmawIyuwzA5w3vrs+a9Hazjo0vqICxEKII1MpaQ+f+xvizR47aEF+n+a5xynJQm6iARvUcssGvNU8S3rl4iN0LMK9oBhTmZun6+I9UqISXoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMJxdiF4OHwrdYg2aIsjBbzDiMKucZ0T87EBUtJ/aBY=;
 b=s8r982i0GVhvXuZbc83ndNzzCrzYjXqTO1IIlwWdMprajYzz+Tr3zEDTBKbxGP6iaJXQ1N7/H7FOLWM4TepHqtLzSunzdCukjSa0celLuEuKfLDNaXwj0ofZrWldXo1fTyU1bakCnBRL2SW+OfqPaw8DSD+7eqngcZOvnsdrQ+I=
Received: from CY8PR19CA0045.namprd19.prod.outlook.com (2603:10b6:930:6::15)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:36:37 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::e0) by CY8PR19CA0045.outlook.office365.com
 (2603:10b6:930:6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 15:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:36:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 10:36:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
Date: Wed, 6 Sep 2023 11:36:23 -0400
Message-ID: <20230906153623.507284-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 802cb58c-7466-4b11-7f1c-08dbaeef0eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70tjPhpo8idpbQdzEMwDER25LFEsdrWSaFYm3Xn7jPBZWDs+a0HvGPpt3BdSjW8VwlNGFVmMpeJanDzh+lUiciPmjHyq1DNZzyd7d791osYKiChgnCfvzupLR7WKRqldRRby60plmwIdFTLaHiQjiOgpxXcPphgNTTO95CZ9aqLXcoI2HeIgb/Z/WolLUf/cUdYd+dPOeup94N5dWzZ+93U1+ipDnnQQC6TIGApGutoiKUabOd6Trt3byB/kXF27aq5TJTxs+Ci6kiC0x3z2mzvfAEFFCSG4EM5p8JupoAJW9m2sHVO1QAkZBbenI6BjmbjzIa5elPohbiF5GLfAbOUJjacYa7AozfolkjX8LvmK2xyN08s9WqGyibwUVf46y0xcwWm2pSI75td+cZXkMbmXJ5a0UTKedytW6ZikaHYMLDSh9CKkGSDM+krr23B++IbXCZWBFqvv7nWN3QSSBZAAXhczNtSj00Nvwzw95OKy9GP/tvTQyKLPKJK9YznxVIiB1k+ZbH/cbfBZaQI//4la3pK0ygmw68iL2Rphjfn7BRY9x6iaBuk2TZGwHohbWDocjw07QLSgst3WEiqH41xipNeZWCuAP4dpaYx6GcpLOD23DwlG+z49uV4wMUtCWgDi1vptAjIGQaEsfDFju+6ivKVxCNDqLif6eExYAyDwZ+TKGejNkBY0Voqu0X/NVpDBuLE6swFOgHToSIY+Ll2BzP6djKDfTNZirp4jsAvub59GdVGCnmRWh9KlXhyGwIxSdEEF8qx8ifcDHMhutA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(7696005)(1076003)(2616005)(6666004)(86362001)(478600001)(26005)(47076005)(36860700001)(83380400001)(336012)(426003)(356005)(16526019)(81166007)(82740400003)(70586007)(8676002)(8936002)(5660300002)(4326008)(36756003)(6916009)(316002)(70206006)(41300700001)(40480700001)(4744005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:36:36.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 802cb58c-7466-4b11-7f1c-08dbaeef0eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This matches the behavior for soc15 and nv.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ef297b41623b..2ecc8c9a078b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -778,7 +778,7 @@ static int soc21_common_hw_init(void *handle)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
-- 
2.41.0

