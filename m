Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF0CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 04:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A1310E051;
	Tue, 17 Oct 2023 04:28:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3718710E051
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 04:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf0zTPdjJAK7AbtCdwRddRUe4JQ236FG1KgyAaItgdZwCDkSvXkl4imOqHE8NNGdP+CZEA2eAeCQg6RvYtCfi7ogT/5Iezd2Iu6f4ApZ0VTvSojJ8XiDuJQwfmwN5Xb489BB6k8dGMtVQeRyOrAJrYIEwX3K52jaWBMv8Uf/2oYTKgJxyCid/o2zCr5aC5S7CISJ6nLJHqq4JIebL19tWBedXoEPoLbbnhXtcD6ZfwQ1j5wA6MRt4rVUBQ9mNPLoitNOEvb157YgatyCnvR057MkGso/XKAYFnkaHjIoKkFff9WNfR1HRxcnWJ537us1w6bWL2NAj6cWqZom1gddPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVCWZUJ6O6J03ym13Xd16cOlO6XO9xSwmGoJeY1KkV4=;
 b=c7u4oaK0jgN8bhW3FUqzIGqB/O1bXH5MUDNZj7DUDqaUi1DX8zaIRj3V0aER9OeyitfvE5el9Zzjstu7wQMGVHgBerodOQUiMwo3jLfKFVz7CthTmdXwVZTg8JjmP6i/v8cqoC1MUKwKrV+qPZ/zWWdD5brrVQz8kcAJy2GAdz0FO5splNEsxNcCNSol1TiPj61CUx554/VFm79930CoDWlVWvzuVlgLtHfiiJsUJaBa+0XkNYF8mCzCeR+uHiSpNRzeIdjfYwwxB3+D8hESQG8k0sei4hHMqqLUZp0ZF57v5Vmdi5p5opyUq/fWyqg7K4nuJwd4hrksLXp1UntqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVCWZUJ6O6J03ym13Xd16cOlO6XO9xSwmGoJeY1KkV4=;
 b=bPNk4aqUR1Vvo8f/Azfw2sWrjoReNcbFCFW+JMewOdl+emhyV9Snx2q0bdlf0u6t8xLNfMY0y/owDk/jZvLJM++kQw2aOZQrG3COQSzH47D0zd5g32rGDPgdznvuCpP2KVdhMy8n80fbuktwRh9DK/cxCVcc2sJCzSo+NNxGJv4=
Received: from CY5PR15CA0068.namprd15.prod.outlook.com (2603:10b6:930:18::31)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 04:28:27 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com (2603:10b6:930:18::4)
 by CY5PR15CA0068.outlook.office365.com (2603:10b6:930:18::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35 via Frontend Transport; Tue, 17 Oct 2023 04:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 04:28:26 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 23:28:23 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu : Add hive ras recovery check
Date: Tue, 17 Oct 2023 12:28:09 +0800
Message-ID: <20231017042810.15675-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM8PR12MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e42592-3b78-43e6-9672-08dbcec98207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ka07qKYjx5ZXzPkudwn1sJpQWWEABsf9ExVprQM/hliw8B9/t2En6kG73mTtcdzUKmIzu2KASeRsif4cggv6kmxXQouxcx1A6hOo7l7ybGFDTcvCJCH1I3Xs+wIVacjWFJvy00VtVubzJh59mM6hgKSIn0y3On3b+k5sagESdtUgNiA43Db1SSpiGdZTX3jBgKMZwixVcRGTCbfYfLostcq7p5e4mxx3pWBWq5c4jt+8YErdm4UXyO6hm0SNEfsr+CnER2WKy4NGy5ko2cANHW30LFO6ONTZAkY8ALETKx5bqb2zDk2rOlm9vmRvfjpFzzI65wjDOzYItNQxJ+/j6Kh+GrjT/cSyEnVO0aCqGnKWMs68g62lGE+ZvYaCLoyE6N2FkicVnPDLK2ArfCDcBItu1BeNGdf9a2C6sKQuHWgW4RbWKWDI8qEbHLFDW/hXuW6teszGY5UeTyb/iKBWJq0WJLmyvKj4p9BhNBiQ2WQVydIGzTNBIsc53/z3ouVD1jmT+HHAP0M/DW2/mvrSYpYB+mQY3p9HXi5qxHy4SlSVHevScmBvBrAGgPQp2VrBbas9D7kjaSV3seurP8YL8t44Am7r0e/qv29cTSMByWbhFAtUBvl0OK/0FUGUUdhTndYIQW7zk0S/Quhe5sUh+ZcKRJL/MbU0AU6Ebq26axc1zmOWnMvQUZ1o6S34Wx6l2ShVh+fw/wC6IxS14m7ZijSFDRjlDVxnZXxYjNTuNTEJVgHW+fWNAfQjWFWkrJWT6K8mQtgI+GBw4zWP7pwqRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(6666004)(6916009)(70206006)(70586007)(478600001)(54906003)(1076003)(16526019)(26005)(426003)(2616005)(7696005)(336012)(316002)(41300700001)(4326008)(2906002)(8936002)(8676002)(5660300002)(36756003)(44832011)(81166007)(86362001)(36860700001)(83380400001)(47076005)(356005)(82740400003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 04:28:26.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e42592-3b78-43e6-9672-08dbcec98207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Cc: tao.zhou1@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, le.ma@amd.com,
 stanley.yang@amd.com, shiwu.zhang@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add hive ras recovery check and propagate fatal
error to aids of all sockets in the hive

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c              |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h             |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 10 +++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5fb57419ef77..029871bfe714 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2061,9 +2061,11 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
+	if (hive)
+		atomic_set(&hive->ras_recovery, 1);
 	if (!ras->disable_ras_err_cnt_harvest) {
-		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 		/* Build list of devices to query RAS related errors */
 		if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -2080,7 +2082,6 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 			amdgpu_ras_log_on_err_counter(remote_adev);
 		}
 
-		amdgpu_put_xgmi_hive(hive);
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev)) {
@@ -2115,6 +2116,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
 	atomic_set(&ras->in_recovery, 0);
+	if (hive) {
+		atomic_set(&hive->ras_recovery, 0);
+		amdgpu_put_xgmi_hive(hive);
+	}
 }
 
 /* alloc/realloc bps array */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 86fbf56938f4..6cab882e8061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -44,6 +44,7 @@ struct amdgpu_hive_info {
 
 	struct amdgpu_reset_domain *reset_domain;
 	uint32_t device_remove_count;
+	atomic_t ras_recovery;
 };
 
 struct amdgpu_pcs_ras_field {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..29bb2a3a3cb1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2184,13 +2184,21 @@ static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 	struct amdgpu_ras *ras;
 	u32 fatal_err, param;
 	int ret = 0;
+	struct amdgpu_hive_info *hive = NULL;
+	u32 hive_ras_recovery = 0;
 
+	hive = amdgpu_get_xgmi_hive(adev);
 	ras = amdgpu_ras_get_context(adev);
 	fatal_err = 0;
 	param = SMU_RESET_MODE_1;
 
+	if (hive) {
+		hive_ras_recovery = atomic_read(&hive->ras_recovery);
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	/* fatal error triggered by ras, PMFW supports the flag */
-	if (ras && atomic_read(&ras->in_recovery))
+	if (ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
 		fatal_err = 1;
 
 	param |= (fatal_err << 16);
-- 
2.42.0

