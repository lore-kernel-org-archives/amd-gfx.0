Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386E3C48297
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6FF10EE53;
	Mon, 12 Feb 2024 17:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKzrNiNf";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA9710EE6D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGIQgeQTzfqwW1TA5bx8KiJkLD8XBOybzMLBnfKHugt9TjTymcwq8ZigRuSvBXdDhw0yY3O2IapwldQht3pC+6H9SBPaqLqWIKpE7YcTtSaPs8Kr2SiBLi2RhcUOdLJLbPCPW1ozk/iokVUIBqsnJ7vttjsVKPsjM1/TOqOSI9rKM9gazhNLt0t970wevnKSUtQMii1w0iyOah6e6ufpWwWjsuKBf/0uM/D25FP7l+3KscJay3JcLQ7qE9AG2MMa3pyVAIv2ZrqlUWNAxeDWNXAS5pIFmfCktbdQQLAad4llywSfiTBTJeCZwolmG2EF7Rsnd9p4gIobzw2nll5hQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdWTgUTABpGYFf+m5QoCq1ZeHpPrx3/lNdy/KRxlOWU=;
 b=IOYriNU4OrV2sQ6vpdH2fHk5DNJDKSOrX4R3jCi9Ox9CJuM6oYOeRhVAhO7DkqOZe8yUA1mIBuPPa/iyHTdJCUySdJFfiP0PH5cCpu3vluZHxj00MaxfdAtoTP4uAXIDrWc2z0UCEplyM44tpLDA+HKi73sWS95FWbV0dQh0mMMAzQSlQ2Q4sLiQTIHOGconWPnvJ3097VxFSTyXTEAFvnCbXnkTJMX8usgqXT85j7dbxHUEJykWw5W1AWSHGb/JXrxmwGopYlbGDssr5TcOPlPIX0gs9Wxf96ntp5c80XZwyyGCMoOhd/1J/raiW/9nSqnVNl1W8n8ArTc9Cg6i1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdWTgUTABpGYFf+m5QoCq1ZeHpPrx3/lNdy/KRxlOWU=;
 b=yKzrNiNfW5T17NP9x+ShtlWsQ/5jLR9spCmZOGJHmUmEawRgNMVRpH0Ow2azNAJ/nhAu2MMItiyaWrCqV/vLO2VXZXsD84LKLO37O+QIHzrXEVWVjLM+zMTMml0z9iytdcKSUIdAg8LmuR1xIrY834izPeN3/5CDI+AgzpXgFrE=
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.18; Mon, 12 Feb 2024 17:59:08 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::8c) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/psp: set autoload support by default
Date: Mon, 12 Feb 2024 12:58:45 -0500
Message-ID: <20240212175849.433812-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 6587f5fe-3f06-48bd-39fe-08dc2bf44f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdPdfrKoJwCyrQVwXZWFp4dgFpZ3MxoEx9xtof/7Aqg65e9A4D8GWDbkNSofUvfDG3271lEvdbkJiqXOi0odC1mm/cIQBiN4IDkILyxEcvTJNBKddkqfejGSUuPUMIwTfNFJ3Rel06m2Xp6plVwaeFXZ8q5hK8qHC2SlDecDT7g6EoOgQnDdzX6n99YzkiKK6QE6QdzHC0BxEzlHhzcOC3+gWVls7HVhvgkDmuCDe761jQ1YmkFkbjP29FtQyksNOPyhtwbBG2/pMfTytvGK5RlMH9fehZ1kCqJer8j6U7Xs2kynKUsCBE9gyBHMlqXXN3NClW0XYa0RydZWSyQ3tzOVxbWk/d4soP8qXAH4YYF6dBoYSByHTQvs5lUrJAEc8RBXQed7LP0JxnLYCt+lUDxwpjYgeUX6rFOCQ9qxsRcKUOML9iQ+abWuB8LFeG6kEe1pr8XlKIvpWQqiALlH72yOgEfzIDO58Wre9G25OnJCnJkE6SlPFFb5AF6RfZHc93AKSQCsgFsmqtXH1CB0Wo4SWDhzCG7nt5hbKuevmfQExNUZvlxDqQn7we/C5YTLedOt7AiwzKQorQBpgs7N/+pENC6GkZCPoZIRawO0an8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(4326008)(41300700001)(5660300002)(8676002)(8936002)(356005)(82740400003)(86362001)(83380400001)(36756003)(6666004)(16526019)(316002)(54906003)(81166007)(1076003)(336012)(426003)(70206006)(70586007)(478600001)(6916009)(7696005)(26005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:08.1503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6587f5fe-3f06-48bd-39fe-08dc2bf44f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

From: Likun Gao <Likun.Gao@amd.com>

Set psp->autoload_supported to true by default,
as only a few version of ASIC not support autoload,
and the furture version of PSP should support this.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7e12c7b70418..5e1cd4a46ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -163,6 +163,8 @@ static int psp_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
 
+	psp->autoload_supported = true;
+
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(9, 0, 0):
 		psp_v3_1_set_psp_funcs(psp);
@@ -189,15 +191,16 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 		psp_v11_0_set_psp_funcs(psp);
-		psp->autoload_supported = true;
 		break;
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(12, 0, 1):
 		psp_v12_0_set_psp_funcs(psp);
+		psp->autoload_supported = false;
 		break;
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
 		psp_v13_0_set_psp_funcs(psp);
+		psp->autoload_supported = false;
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
@@ -206,29 +209,25 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
 		psp_v13_0_set_psp_funcs(psp);
-		psp->autoload_supported = true;
 		break;
 	case IP_VERSION(11, 0, 8):
 		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
 			psp_v11_0_8_set_psp_funcs(psp);
-			psp->autoload_supported = false;
 		}
+		psp->autoload_supported = false;
 		break;
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 10):
 		psp_v13_0_set_psp_funcs(psp);
-		psp->autoload_supported = true;
 		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
 		break;
 	case IP_VERSION(13, 0, 4):
 		psp_v13_0_4_set_psp_funcs(psp);
-		psp->autoload_supported = true;
 		break;
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
 		psp_v14_0_set_psp_funcs(psp);
-		psp->autoload_supported = true;
 		break;
 	default:
 		return -EINVAL;
-- 
2.42.0

