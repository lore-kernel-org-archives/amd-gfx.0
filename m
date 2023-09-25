Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC33CE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 14:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA0910E16A;
	Mon, 25 Sep 2023 14:44:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940CD10E16A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 14:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj63SeAmVRir7v6XAm5gk/BaJH92TCHLYII4HqpglkG07CBr7X3bAphe0SDVFZMpGsOX7sz0a2mYkMDE20sGS+VMYkQ6pCv5GQE1wS8ElmYp1SCRCah77i75+3B71A2kG4uINkvATrDNetm+1igcoDSTQk2fXCWoh6//MfMC5fqGGQ49i6vSPJk//l+X/CmpO0Yo4SFBS2Wq8p5B7EBqxJUnL8lQ7YbFUAgHRMduZKLSIZhguyfSeh1LWHzWyDTaaoNs/sy77v4LPmAXCxAWLsJ01APzT6j2nYMgi42rQKFw3Kv8jSK0DXX8f/SwI5vpd6Pd0UgNIcERRTtjklmu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+CammJ6ujlM8ranzQWvtImowA+CeVT9RPBNet3iIUc=;
 b=WeBx4pJ10fqFVWXwdT3gH7uDd/fSGM4cr+lcm4jWbqmFb49l5E12EzVp3X+lyAjoaIAgmQSw3upjYZ+jwCoUByAJUXmDgWKNtJbhjVzlUr2yv/HI8AMFBouRc6FY2vCGxCRsqcicx/xCYk/1Ni8xZ8FrUAwf5cQlSKO7A2bpxwAme+cfFgEYuBfx3pTa4FYcDxcxPxtT7xF3tquJiWwNGx/6JWo+tvufOHmfH5RDWhJlCfSvh3Uk6tZCuI+oal67EbhNNPyXSiFUXuxgHdJmL/i8rFXVR/2sXJ4kRY+Qr0RjwZbAg6lEITFeOwBNgZ4jekF96VieV8hWLBJjiPaWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+CammJ6ujlM8ranzQWvtImowA+CeVT9RPBNet3iIUc=;
 b=Pfba7BVUf1u7Ajf8LMIHwc5/N9g+EPaYC/TWKCHw14+6kOzhKQGbmn0u+3+KwO2eQUaN0RbsVxN/WdzCAAX/SXzJMg5JmofH6KErSydexw6Ero8bJ2aCjvAKORHUEf/ZZatmEKSEPj23GA8oDRHsVHXIRHjdLM9XksIVauvPCJs=
Received: from SN7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::6)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 14:44:42 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::10) by SN7P222CA0021.outlook.office365.com
 (2603:10b6:806:124::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 14:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 25 Sep 2023 14:44:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 09:44:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: apply state adjust rules to some additional
 HAINAN vairants
Date: Mon, 25 Sep 2023 10:44:07 -0400
Message-ID: <20230925144407.972554-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925144407.972554-1-alexander.deucher@amd.com>
References: <20230925144407.972554-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c46790-8e52-489b-bddb-08dbbdd5f407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfH8FbAPYSgBdvrkBOhR4n3w6QtZbOtMu54jzVL3scfcza3eAsiAjlU+AtS/6eEd5Nm8nRTQGRjHObFPmAriiBKTKuAjeUwjS0j8HOIjwB+aD3AuHRqypoE3Jr5a4dpQkAF7EWgTg0BXbfrZYedjL6Ui6ZKDMM6XbyFND0TDRSHuYVC+KjvxMcUNAmkXrmZmJhDB7O0/hqEPabJJ021HnuPsyEG0EBBy2505K8Jtvu4vmiuS6spilZgZBUhQsB+CTtUo0B6xmeGPjUC2ZUS7pg58FmJKN+VqaMj7VMnflD6bLrMiToz5X4qlHk9wLJmClBbRuK8JkhDvFqwuHwPXztmSfYa5IAgMqUEnNvnEmyBTy2+n2PGX4BNp4nptsfIgkrArr3U7VT7MD2B0pJHRZav7/p+H70cQxVXqgb9bVHmUSXw2w3+txWbzQ1q30rEVO6LL24IrGeL87ziKnsDoYEjyNAQ+11Zqc0Pfr156zusauTq3ejs9Hd80noXMeoTOKyyECmcOhkR5MD3GPXAC3WE89j3CIlruqKprCMMMLZuoJzQmoj3mhsNtR9TT70pPEYbfyt570jFp1F8Hj9svwacrRZ0n6Esu8wqCvfQPLcTwKHw3EOVhBgSnRFgaOdbiU6L7Hrf+wPbt5c5RQltyWTMrEGqLmSf/k+27/Fdkpv3pM83VMBNAnw7BgKF4dTfG2T9Nsr5GUTXzhHhl9BF2e/FXG+LTeqgcOszMgliV/M7FWih8VXhUM5ZcXxL0+mdF4t1YvpXi1Gys0QNflPue7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(316002)(41300700001)(4744005)(70586007)(70206006)(6916009)(8676002)(40480700001)(8936002)(2906002)(4326008)(478600001)(26005)(40460700003)(6666004)(36860700001)(5660300002)(47076005)(7696005)(83380400001)(16526019)(36756003)(336012)(426003)(966005)(1076003)(2616005)(86362001)(82740400003)(356005)(81166007)(80423002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:44:42.2263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c46790-8e52-489b-bddb-08dbbdd5f407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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

They need a similar workaround.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 02e69ccff3ba..b9a60851d799 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3435,9 +3435,11 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	if (adev->asic_type == CHIP_HAINAN) {
 		if ((adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6660) ||
 		    (adev->pdev->device == 0x6664) ||
 		    (adev->pdev->device == 0x6665) ||
-		    (adev->pdev->device == 0x6667)) {
+		    (adev->pdev->device == 0x6667) ||
+		    (adev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((adev->pdev->revision == 0xC3) ||
-- 
2.41.0

