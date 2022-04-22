Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B229BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 09:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D9510ECAA;
	Fri, 22 Apr 2022 09:47:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A7610ECA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 09:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK6ZO2cnTj92/GuYr469PrMLVRD8ZV5g8QgLgzsqDGrs2OQ64IeNPsfqQDvM5s4SDl7RpqC0uAGLTrUf/IA4nSXuqQtLMzxSNjE3CAcVaXglfzEOB+f8ViLknZZaKibYQ9NBalaCQbA/JjEoXYWr2kq7K1ouSBFVJlee9Q+fYoLHz+mJRg4mB6hVp+J9u+d0Eia7atfSYWw9HFE87BaNuUhkhKzEpiWf9IaBUlaxRA5t0RlVYi8hu810WB/MTv1P4Eq6x0xsq5/x/q69HZru1WaK+fywh3+A8FX4+alMvOXrLXwT4OLV7kwQH5R1b4Fqi09aCI1sWD2IYSF0WpUWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw98S26vBHyrCtlHTpyC3XFpuC1f2KTHbQGQ37aTWrE=;
 b=OqhWeB44ajyztCSwm2zU954TLambTYig5JFDTclUJr5iWCeGgPS6IzQ2SHtKXyVZcV0yKWgM7nLG7hF/8Y6xBndRChbvzkbq0eYaSMRS2WMKmNMlKE97+T/IqRbQR3/jkAe1M/2V4w2iEpX1c7T5c18ldLYCXlSmZGCdBH/v8ebBoNGjp5055lupmSQXXhP4Ngr+K7Vc7N/ACUsWIRXX2SFtobHoB8cz78YcTEjR3TWv1RmD5/Cp2I+Utu26SAdS9OE6Yu4sXEUWCBAeOrYsku4BaDuSB2T0tjaoqHC+7mt55l/pmXt0R4vFYprcpmmBR7+aGyiVZIwPfajg5+ugnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw98S26vBHyrCtlHTpyC3XFpuC1f2KTHbQGQ37aTWrE=;
 b=kfz6mjRH5j3ueFNPwjc1QMFAy0r45NSZBHpjtLAQjCUI/XbhCrU4vAiVOtMSgJuVmYMuFg693FxKsr5N5dwPokmIv54ISgm1yUCZvXxFoE965sJNGKYtbxwV5CGJIv/WUmkfzHs+Ol96uRrJRzrNqdp+gbo9ro60KTsuni7HIls=
Received: from DM6PR02CA0135.namprd02.prod.outlook.com (2603:10b6:5:1b4::37)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 09:47:44 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::6) by DM6PR02CA0135.outlook.office365.com
 (2603:10b6:5:1b4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 09:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 09:47:44 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 04:47:41 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, <lijo.lazar@amd.com>,
 <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: control baco sequence by driver on several
 SIENNA_CICHLID SKUs
Date: Fri, 22 Apr 2022 17:47:29 +0800
Message-ID: <20220422094729.2264-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0f4499d-fbac-410a-1423-08da244526a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4910:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49103110BD0864CF82917552F1F79@DM6PR12MB4910.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s+Ugzypx01AjL1TBlijk2r/jkSFC/HU8o5/AOYmqK0E+g2YyfitF3z8MMwljngWY29XNZbdcICWS8j2BCzE3A5GoHJL4nS+b/zMctQp2XzzZBB/RWzshfBGuaHhIsKaH/Trruhmjuj/1y28FgB7QpJa6kF0d1yrA/V9b5SKJkalJqDqacpKvmKK2UvNQ3TT3H/jyTUpWKgPli9F9FDwnjag38wHBuXbC6pCTe5LfvhvkL/uXPj4VZsbMI4Gch4BjwxxPJjsSPqHKZ0t7PA1+E0v/VuX3KFRzowWtJprJ1cz9gPvRtnapSjnL8wHEi5AGRFdUznxiGJ9AkcXz3mWL6vwqdIWsr2cxQ89EFMIhRJlnI2ulxMhIy8YkHHcjMOmKkcjgsIaguEAh95y2bYyONgpnzmRrjQXwVtNZIM9XN8DE5v4E7clOMrb2KpCmPJ25/iNZ2ZKrC4s7BtDV5+pWnpV6cE29+5bXvDV3hB6aiVCPaiGFNUzPaxYwwyhl9CCU9i3uqp/O0Q2DrCyTqptlqFPxmPVqyXX3HLliG9hT9CVOlmk+rz9jPBRHp4+mIIxWVQ7M//QDVU4U3+YRJ53mBkCmQzjEjZvj37mog1QdkMeEChryEG1s3GA5WT2Iz/BZyfcGQ9Utio2aRyFf176mKYq0wnWNoG70e3bqEttGzeutyMD5iC/PYYWt6rpB9bQOmP1BSg0OniMSj4boubFNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(81166007)(1076003)(44832011)(2616005)(70206006)(8676002)(356005)(82310400005)(316002)(16526019)(36860700001)(36756003)(6636002)(40460700003)(26005)(186003)(86362001)(83380400001)(110136005)(4326008)(336012)(8936002)(47076005)(7696005)(426003)(66574015)(5660300002)(2906002)(508600001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 09:47:44.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f4499d-fbac-410a-1423-08da244526a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a quirk to switch baco trigger sequence from armd3 sequence
to control by driver itself on several SKUs, otherwise, SMU will
fail to be resumed from runtime suspend. Will drop this after a
clean solution between kernel driver and SMU FW is available.

amdgpu 0000:63:00.0: amdgpu: GECC is enabled
amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command: SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <smu> failed -62
amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b7320ecf4934..494a42c253d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2246,11 +2246,25 @@ static int sienna_cichlid_run_btc(struct smu_context *smu)
 	return res;
 }
 
+static bool sienna_cichlid_baco_trigger_quirk(struct amdgpu_device *adev)
+{
+	/*
+	 * Add this quirk on several SKUs to control baco enter/exit by
+	 * driver instead of trigger baco via BACO_SEQ_BACO in armd3 sequence.
+	 */
+	if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision == 0x00)) ||
+	    ((adev->pdev->device == 0x73BF) && (adev->pdev->revision == 0xCF)))
+		return true;
+	else
+		return false;
+}
+
 static int sienna_cichlid_baco_enter(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev) &&
+	    !sienna_cichlid_baco_trigger_quirk(adev))
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
 	else
 		return smu_v11_0_baco_enter(smu);
@@ -2260,7 +2274,8 @@ static int sienna_cichlid_baco_exit(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev) &&
+	    !sienna_cichlid_baco_trigger_quirk(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		msleep(10);
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
-- 
2.17.1

