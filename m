Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2DDC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 05:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F2310E1B1;
	Thu,  9 Nov 2023 05:26:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A949110E1B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 05:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHrWOKL6KmREswa4e7gD9o0IIowEeFotSk6IsHsUIvh48ZgxvIOJ2ToIRpkA423FfpTLK1kRXd/yI70mTXkLfLePSVlGAXVxa63fbKVy2TlyS7hp3t9u1HljyY54ZaREfnhMPLzUwizRg7neDw96S3+uFQ93eFJjLAcoTrMfBCSS1gYJ6C3Kzt1Pc2YbZ+5mhxKL31mBI+slDq4bzJQ1ejzy/OfgOQ1n4f4GFor68U4xAHdTA1ALPUWV2vLTtdsmCbOcldiDj0cZCLkra8r58hRZFSSAXekZ6nUQc9tnGyiG1AhHNObpBEzMPR37lj20EVZmR5yJxOVAy6Tz+cRxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+Ecw7YsxEvVnUPqlp61x2Fsgm+UO7lALFmr1r4yxDg=;
 b=gFbFCeyrUdCfoKxXR7XoKB2lUWTzxRL0cKWwOUL/bib7HIHRfb8XSPISzJdXlDCTEIksB2Rh/rDJc9U4nx9S4RWfzOWmP+kEtt78QmWxMAPNvgrw3g7LuDl4e+G+VahfJdl5Ei09d8G9lqyOjX/G8hPPVYe+/g677X15/iWPzYyQV2Bs9EjBNhKl06lq8zrwrKhJZTKCpPfTklCXbrc4AUaK3nS/sSPK5TWt1sKAbRDuL+aY/2i5c5FJR3uY2FvEwQGNxhFe86HQDUUqxJoPFvCNxpQ+JBnAKpsu8xDngGx8ol7omnmYvwRlcDm8l1TTpuu1LdhoubaIDg2348WZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+Ecw7YsxEvVnUPqlp61x2Fsgm+UO7lALFmr1r4yxDg=;
 b=VnDZazdMda7Gx0nIKVeWLpabTSlLtCA3r7LJWURUpexjTRVPSq5pBzXiI3ooeoXrZGtAkmRXdi259mh69BHw2MflVy/P/JLb29Ju2KyUloKcNsszmxckZ8ojQSayic8h5KCjqqBNBacDqaenLeAnxy6JVxL2/OloDZVFMTCGq64=
Received: from CY5PR15CA0081.namprd15.prod.outlook.com (2603:10b6:930:18::23)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 05:26:47 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::27) by CY5PR15CA0081.outlook.office365.com
 (2603:10b6:930:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Thu, 9 Nov 2023 05:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 05:26:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 23:26:44 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Move mca debug mode decision to ras
Date: Thu, 9 Nov 2023 10:56:29 +0530
Message-ID: <20231109052629.550827-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: b67cfe1d-e4e3-492a-06df-08dbe0e477f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QYNGgw6gRcKpo6rz9jM9x1/SPlZUM8WDVgapahjdm7Ifd21jzDwbHMrTFAHzvJJ3shgTvogzL2/HAZwHuecwGhorE1JSnJE4ZwLhC6JepLBk+Q2HsVV3o1ic7R+fpBPtZ07xMG1I8Hrvk0ZJiePyusSJsZ9GXB5LQsdk261qdlXFb2vsOG3LQxq5aqnvXvSAknvoj+R32SOucPuk0iOka4qYHPby8l9P+lma/CTt4FXAHCmOy3g+MxEysKWkwvZ6j4MSyi6BuEuFdCzAb2IyHCpidyFcJIfoKgLdMDAPrq9jGunEYFJerfiGgutp4e6DukuJsmm+AKNbZtAu+6AyfoW12ooQ/jNtk/V7rvrx9hkAKppYq5RnqoNqauWz5ioEDbmy6GSu5p15qEQb1/pJCSSURBnh3ZYlCwIGie0Jm78D2EZV2E0UPB6kWVrBroih6xYVDwG1GMo6D6vnJ/QSgtnfsO2Olqq4ctbhF2AidJVDGRoFK2wtP571SEcrIagwDosJJU80kZQqzPYy3uIHvE1KnGf64bPkKVpm8gKHfJB4NQyl4vb61owSL124Kl30oOaCpaxhJrepT0okzwL31euRUDc6lH0+Wxs4zEPG7RtwiVTc6Q2ZCfvie23B4jljqKodqijW0ZDM5DZ/aUSTRPN1A6N5H5zlXdUPi76qVtAnulqRfW44FBDRiMJ5v6D0+gSiAwZK6/uKmUobGwa9nTzGa8bxMZ76tTMq/Rix9Lm5mAnP72jlg2UFSC6jsOxS9DgvumgvJw5q5hK2wHnMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(46966006)(36840700001)(83380400001)(316002)(8936002)(426003)(336012)(40460700003)(6666004)(40480700001)(2906002)(36860700001)(47076005)(82740400003)(8676002)(356005)(54906003)(70586007)(70206006)(6916009)(478600001)(86362001)(4326008)(81166007)(36756003)(2616005)(7696005)(5660300002)(16526019)(41300700001)(26005)(44832011)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 05:26:47.1478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67cfe1d-e4e3-492a-06df-08dbe0e477f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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
Cc: Alexander.Deucher@amd.com, Tao.Zhou1@amd.com, kevinyang.wang@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Refactor code such that ras block decides the default mca debug mode,
and not swsmu block.

By default mca debug mode is set to true for now.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 12 ------------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 5a828c175e3a..cb51a46e8535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -218,7 +218,7 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 	int ret;
 
-	ret = amdgpu_mca_smu_set_debug_mode(adev, val ? true : false);
+	ret = amdgpu_ras_set_mca_debug_mode(adev, val ? true : false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b7fe5951b166..b2e9ed65a061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3120,6 +3120,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 			amdgpu_ras_block_late_init_default(adev, &obj->ras_comm);
 	}
 
+	amdgpu_ras_set_mca_debug_mode(adev, true);
+
 	return 0;
 }
 
@@ -3375,12 +3377,18 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	int ret;
 
-	if (con)
-		con->is_mca_debug_mode = enable;
+	if (con) {
+		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
+		if (!ret)
+			con->is_mca_debug_mode = enable;
+	}
+
+	return ret;
 }
 
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 665414c22ca9..e1e0fc66ea49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -767,7 +767,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
 
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cecd210397d6..404db2b0fb71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1524,7 +1524,6 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 	if (smu->smc_fw_version < 0x554800)
 		return 0;
 
-	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
 					       NULL);
@@ -2346,16 +2345,6 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_6_post_init(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
-		return smu_v13_0_6_mca_set_debug_mode(smu, true);
-
-	return 0;
-}
-
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -2945,7 +2934,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
-	.post_init = smu_v13_0_6_post_init,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

