Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E54CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E454C10E4D9;
	Thu, 12 Oct 2023 13:14:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7796B10E4D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib0WFz5+f4g1m1em/hBWIBrjb8itjyKoM2kWRmMfQ/QwPJM8C9HV1XhHkT8THLxLNs/trkFVxA2nLt17T8vjJhsRBInnS2uBYm+66ln01yXEuAND5IcJqAITmwLLF4Nr+AeQg6iqLTGfGDjcMAtevAWHNyzqQLrI0cA/vFCGi9/9y29yEhL93hp6cDddJxCrA5ZfnJ6NLS4FGoap9p7rKV4Xh3rc8nFuTzV+JeqyijXgKSjagJ5DNXVXF5T2dRFY3cEsfjS0pn9WFKknsz83UvzhiduDaZBHc7q3/doSeVr4KKOKhvHxeQGPqKK+iVnIAkefX218s2/iGwldFXIuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5LqoHwxbdg3C22q8sw0inwG6Ohc2eDg85UiPSQsECQ=;
 b=PszshWTVfRpCtbP/Hp6SUtqcFCXGKmUEM9nYeQTL3ntv1J+epYFXsofHmucvlADSOIgVaONuLvAD3Asa7mf5gtfRBfsZTLftymcIWqtul0fvfftA9YROdKi6XnZjPIeOs1uC/CBd7BLf8echkVgWTQMt/MhstbDkEQ218CT+95KA1qCRcDsd1oQTGIkL2jT8ePgonVzLiBg4nyNYJTGv/doZby6HRvPCXgTwZVY9ZKKwFGpC1jR7u6FyA5EIRyN1Edi3lzeG4Nsy24w5SJ4db2Eh0NbcvZH0i5Ds+6Y2znt2sr+0DI8AoBrWqeExakkaRvkAtyCaMfEVHJJecwOpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5LqoHwxbdg3C22q8sw0inwG6Ohc2eDg85UiPSQsECQ=;
 b=bDtVtOgn7417SFKw3uPLAU7UqwrF9NjvlBUapCX+VsZTwFR0jAXiJoYtO759IWzzUelFdGgxrw1qqsNS08QoiHkzz2cuPjf7Gi3Fs25DxMFp1RO6ckWRhmtxpz1DLnYanii00527F59926dmiX/EQ7k6YjX44tBPSuOtuxyO5CE=
Received: from PH0PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:e::19)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:14:28 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::a2) by PH0PR07CA0044.outlook.office365.com
 (2603:10b6:510:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 13:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:14:28 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:14:26 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: add RAS error info support for mmhub_v1_8
Date: Thu, 12 Oct 2023 21:14:06 +0800
Message-ID: <20231012131406.61101-6-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012131406.61101-1-kevinyang.wang@amd.com>
References: <20231012131406.61101-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 34241f7d-722a-487a-9944-08dbcb2529f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWg+UU7Qmqht7FfQTUynWHzmxlQyubl+6wKx8anEanyiOkhd9f/9Fgq3S0heR6Z6HKIONINTPEpTfrCLD2DJX0EluZZdkMTruKJZk7ikMTEGSL/sA0ZOMhH5TO2vKR3SkYI7LymUmLiUTPeDKNrIsFgsz9Wx2UQz1Slh9PtxFDuk7qmySPf5BxNU4IG4ByXLJ4dkM17uRI9ZoFO6yn0yXFKRN2hNk5zjeTrR9EJbmv9JDyfS56KOkbssyraeNaJD+SPB7Qsko5R7lBrDjZln+QM5PeEqDDFAgbFxdZsEJF+wsMpql6gFMvAOAXHk9rdW6wX6LLyJhPpVOpSmpxqCntTUKZ2d/y+NoXvfh0IHrtDzlvB3aGQ0d2e4FDaEdiXRnk++4BlG7fo3zI12ziZgHQvrn5vuxVLSL+h/nm+BHuN65TB0rIul8K008wvS08yZ50XzZJ+7wJILYhjsNk6xKOfRpNBpKY+sqy2kv8XOvxWu4ZYHCKZwHH5yIFusL2xVrWS1fRl2fn9ena3nq7NGvWefIDwnVXxPQqXWZi+9VjkyKOk3QgTjs5uepiSd7VlG7VO6+1+YRQBdCN6M6AVDlpngfHXHiDJx+/AuiayyXuVt/+Uv02S40EzQGDGJLo4xWNAxxengNZOA7TFmnFDMS88COpLwuJgsisCNR/QeywndNI8VdeHGNqogO1iuIXkVSm3zCvKNtlsiSGOO0S4djjjGgPx7muEIlmkHNPC5qJv3PxBTsErDFcFUtEAKRIobpG6p1Czg6bhAHVaTSJxCcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(16526019)(26005)(47076005)(336012)(426003)(82740400003)(40480700001)(7696005)(6916009)(316002)(83380400001)(54906003)(70586007)(70206006)(36756003)(81166007)(2616005)(1076003)(356005)(86362001)(36860700001)(40460700003)(478600001)(2906002)(6666004)(5660300002)(4326008)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:14:28.0425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34241f7d-722a-487a-9944-08dbcb2529f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add RAS error info support for mmhub_v1_8.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 2c0419faf8d4..aa00483e7b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -626,6 +626,14 @@ static void mmhub_v1_8_inst_query_ras_error_count(struct amdgpu_device *adev,
 						  void *ras_err_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
+	unsigned long ue_count = 0, ce_count = 0;
+
+	/* NOTE: mmhub is converted by aid_mask and the range is 0-3,
+	 * which can be used as die ID directly */
+	struct amdgpu_smuio_mcm_config_info mcm_info = {
+		.socket_id = adev->smuio.funcs->get_socket_id(adev),
+		.die_id = mmhub_inst,
+	};
 
 	amdgpu_ras_inst_query_ras_error_count(adev,
 					mmhub_v1_8_ce_reg_list,
@@ -634,7 +642,7 @@ static void mmhub_v1_8_inst_query_ras_error_count(struct amdgpu_device *adev,
 					ARRAY_SIZE(mmhub_v1_8_ras_memory_list),
 					mmhub_inst,
 					AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE,
-					&err_data->ce_count);
+					&ce_count);
 	amdgpu_ras_inst_query_ras_error_count(adev,
 					mmhub_v1_8_ue_reg_list,
 					ARRAY_SIZE(mmhub_v1_8_ue_reg_list),
@@ -642,7 +650,10 @@ static void mmhub_v1_8_inst_query_ras_error_count(struct amdgpu_device *adev,
 					ARRAY_SIZE(mmhub_v1_8_ras_memory_list),
 					mmhub_inst,
 					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-					&err_data->ue_count);
+					&ue_count);
+
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }
 
 static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev,
-- 
2.34.1

