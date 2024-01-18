Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2954C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 03:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E966A10E0ED;
	Thu, 18 Jan 2024 03:26:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9A210E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 03:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZOwnYExuNqsIukuctejnkF2L7wAEFaO+tX7LjQkOh6nDYrQ71NzhmdYo3qiz/qChQRv3C7EW38e6Fg3++/hehipAkDMk2+NZDS2OpzIlFQVLU1pe1EnUVhnJNlnKPiVUOSCwajr4PY7++luC/aOusN7CUrqkOXwHEWBK4l0Quc8ACP6FcFM/uzACYfVAynhQ7BQT73ghWyjsx0PKtH12bdd020IHN1D4MRDBggHEiBkQWLsUQAaSdd7MYCwuWRGBzmXnoWBxHqEwhxJf3lsdl7/HV1DZa9vQGLdL4LayZMQwOqxBbONj30LdDRH6nrO4RyIcW7esbssEkZkKF2uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQQ8KRjyMzd2X0lC5IiREW1eDj3Aqohci1oxKDoq4sI=;
 b=GiaELVMYivIl8WP8ZIZuIwW2eg/SAqrWtVEZszj0iFdWcT5f8z//WTkPzYLNaSeRyVFztR1R92lAi7U0KthHimTDwVTV1bJn01SkzGqjipOhlseS/fdKt7wPcKcmRaOjwmg3H6wyBlnT9Gv1UVOfsjDNs+E/TrhW+zHjnutrJv/zJU1Wbe/YpsR+zrvyrFQbMySUxZ2D7wghss4NWrErvzyk05oKsui2itizN5nzoAFMIWg9TGJPzwIUUmNnbd/wCmT6hWcPPDBkkq5WDz74UnxsF1IcBUSRnao+sAMGaE4mPteatkB9EjCPOcc8xawu/umIEtdO3VWnqwdm8o81jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQQ8KRjyMzd2X0lC5IiREW1eDj3Aqohci1oxKDoq4sI=;
 b=fbR2T2gkz1PSnYo0oixbClWvjWYHoYcErL8tfz7uFCAHzLcPvMAy4tPHfW+7ZVQBU3aynU+fvwS74gEFlG5+1dd72+tSbps5DZchSXzlEH4gssTMKEeN9mbYYEvW4/0TIJ8lHtpk0ZBDCjxFJobQuJq5Cj+bVBwLFF3vfWmaGo0=
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 03:26:04 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::13) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 03:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 03:26:04 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 21:26:01 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix ras features value calltrace
Date: Thu, 18 Jan 2024 11:25:32 +0800
Message-ID: <20240118032532.821661-3-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118032532.821661-1-Stanley.Yang@amd.com>
References: <20240118032532.821661-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: df6cefaa-987f-46bd-be30-08dc17d533b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WFCBHjcM/kgKcS3FYFrOo+T7UcIc4Nk4b0iaYvwjHGRWFZ9wdbrGvWKdDGGY40Tv/7U74SuYZYZlCXRfd31e6JSYYLDcthrn7jqTeIjw+zT2t/00FYWQ1OEZ8RoSMRNasyKJHdLjcaz0vXWZqxXusz9frKxUpeNFaqAXsGH3e4T0DUSzx7zHkKWDzpvPB2JXtyES3Gd+nw/imfmzGasojihtZX5rOCIKzEsU71gnJciJWZHd+u0f/4ZrL4enQiyJOmJpCpXW+KG8+HV+m/QwL36e9xvSyr+tzMAPHOoJFIFa9+B2Ph66GKmdWN11z2r/6qyd3F1MtpNM1yEOHA+f/JN+vjECXEH9hBSr7fSBa6PkUs6TjHSdiIs+yXVz+Z7vQOb77qynnF5zlOGEfNB1/iSTrLatS/ZfVT7ROGG1KJqL7OYaM0ZhLSf9yJ5gGzAaPIPJ/fVd5uQNCwLLTCTQoInhMUxBngy5vTpx35dJ2uiKtzRrONYxDJj31gflhvmuLCZ8UxCIPQRe6ANGWUZ62+KcMEpaVA8UtzxGK/dSf3R3Wh+FBYEU50PGS0iCcKA6COj90837eGvNuN9A4iVC5K/oEW4VDukBBBj4pRfDafZM5aHtRsZvOly4odhLNEyDLjKBF3Lx/Dh9WIV8MDYdLT3E9khPgUBjh4NhTpFjoN87AU/2FJyl016Xtt4i8WW1BvpUeHnbn1/rWAADpjDkPVA7E26eVdxZkLo7TM29RPfb6PJPC1RdS3ZQnuiTxDmbOENNxMfFC1tIGora+hRMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(83380400001)(316002)(70586007)(6916009)(54906003)(478600001)(6666004)(2616005)(70206006)(26005)(16526019)(7696005)(4326008)(426003)(8936002)(336012)(1076003)(8676002)(82740400003)(5660300002)(2906002)(356005)(81166007)(36756003)(36860700001)(86362001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 03:26:04.1448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6cefaa-987f-46bd-be30-08dc17d533b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The high three bits of ras features mask indicate socket
id, it should skip to check high three bits of ras features
mask before disable all ras features.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f35a74bf5265..c91d7d89a1e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2987,7 +2987,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	/* Packed socket_id to ras feature mask bits[31:29] */
 	if (adev->smuio.funcs &&
 	    adev->smuio.funcs->get_socket_id)
-		con->features |= ((adev->smuio.funcs->get_socket_id(adev)) << 29);
+		con->features |= ((adev->smuio.funcs->get_socket_id(adev)) <<
+				           AMDGPU_RAS_FEATURES_SOCKETID_SHIFT);
 
 	/* Get RAS schema for particular SOC */
 	con->schema = amdgpu_get_ras_schema(adev);
@@ -3193,7 +3194,7 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 
 	amdgpu_ras_disable_all_features(adev, 0);
 	/* Make sure all ras objects are disabled. */
-	if (con->features)
+	if (AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 1);
 }
 
@@ -3240,7 +3241,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 
 
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */
-	if (con->features)
+	if (AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 0);
 	amdgpu_ras_recovery_fini(adev);
 	return 0;
@@ -3273,9 +3274,9 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	amdgpu_ras_fs_fini(adev);
 	amdgpu_ras_interrupt_remove_all(adev);
 
-	WARN(con->features, "Feature mask is not cleared");
+	WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not cleared");
 
-	if (con->features)
+	if (AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 1);
 
 	cancel_delayed_work_sync(&con->ras_counte_delay_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 99d7da125c8a..33f7e5a972b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -52,6 +52,12 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_INST_MASK 0xfffff000
 #define AMDGPU_RAS_INST_SHIFT 0xc
 
+#define AMDGPU_RAS_FEATURES_SOCKETID_SHIFT 29
+#define AMDGPU_RAS_FEATURES_SOCKETID_MASK 0xe0000000
+
+/* The high three bits indicates socketid */
+#define AMDGPU_RAS_GET_FEATURES(val)  (val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK
+
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
 	AMDGPU_RAS_BLOCK__SDMA,
-- 
2.25.1

