Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B4AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2838410EBFA;
	Tue, 14 Dec 2021 03:58:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED01210EBFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXfQvdaaBLp/K9+DE4QMvAvKc1skAZoQxSG4hfTvpwCChFP99IkHO9wynyYffkxQJ5uBFlLV7QDhJKFZrhupX5D5kvHeCZT5VX2AdfWiHZJZkQLIjnJNkuqni7V9q7osedNp08NKQiDiUQ2wwnaS/hLU5SsALPDL6hZftXb8JL3fjpv25vUS0XzEMQ4JCAjwI/NQgGxEvK8B+uANCZHhvSmylni8Y01NoeR4fX/4zdqD7wIQYCnfNZRIaR0Ccaea1tSEvuroCeVIYxiqYd4lVlYCuXqldHHEoE1Sa9UNgzoyCiLbFI+tpMMHb+Wjs9+rHMMUkpEOsu1vl394v8yNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwNOfqUt8REaH6w8Fl5XiSJ42tlgaDMZHs7cKCFdzWo=;
 b=JNauKcQ+3C2WtpNeUfwd68QeKApOGOQ6LYJ8288LEUeErenbTlGT1fijAL1PDUGc5WLCCBbmuD1sGczwMA9O7zWcs2NmXWzbG5rHpFvD6+yPTKkmqgPnqtsj1Ti/Z6/G8kupjW/5fH1Ynttmiwr9RzdVaFwUjyiX/oXoqVISShvi3CoKNC4l6acJH9OftZDjjpuuoW1hBD+6E98kcixHXSOSuV67giMXpDaWyjVTalTZNhEXybCI92Ix4vtp/ojNn0A0oeTBI2mxTCUCdG40FHES61ovg6EKSB9l6bY3UUbX3Xpb3EI7RUmnCkmofXL+ndzxJ9lAjPzys2IpX6y8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwNOfqUt8REaH6w8Fl5XiSJ42tlgaDMZHs7cKCFdzWo=;
 b=IAo5vlwg6QxRz+qKVZ/Uu7y4u/r/NrpQ1iIDE14JacE7Vub7BoMHVt3pWiyyjj3H4HLzSPg8gWPoT8mpgAE7InE1VovyTdMjwQgOj5D7fLhgneDU+xRxIjstbhG6RFo/87BPKgPzwuAjf4OLl4El5swjcExM04yzW8OAN7Nsqqk=
Received: from DS7PR03CA0125.namprd03.prod.outlook.com (2603:10b6:5:3b4::10)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 03:58:39 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::86) by DS7PR03CA0125.outlook.office365.com
 (2603:10b6:5:3b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 03:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 03:58:39 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 21:58:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drivers/amd/pm: smu13: use local variable adev
Date: Mon, 13 Dec 2021 21:58:26 -0600
Message-ID: <20211214035826.14930-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b64f666-cfc2-417b-3e37-08d9beb60310
X-MS-TrafficTypeDiagnostic: MW3PR12MB4441:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44417D8F29DAB742AE05F8E3E2759@MW3PR12MB4441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:202;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFfWYxooefc3tj2yioLdpRNeu0qcL5rC+XJsQ0hRP+9ruTSiWiV3P72oTTU3hDN+MMwrfDlce9bLJWBDcWLzCcysRUEbZTXTWanHKa9RUgpu6d4b8ZaXGSg0H7oRS/fVPRi9jnXzyIGmel7CUl7v1KLWptZ2BaVeEo1l92BlaplrmUpgIGpC8MhnkMaGjVNNmBfRxI1mGoPoMp9Vx1FYt1oEHRAaYgH9bxX9m/dGcB+R5f7YnpgeyfCKFa4QMze4yD1hHkOZn1B/rZHRR2CmKoh/y9274uKjmpYtPY/5K8KLF/+/Z2cyAxzDpRbFN6UmuMbE8JgEHYKGzG355kMrOQ2QGU+Cn2dVhXnmfyuJOMmRFhaMZiFSCKOGLkMAc3NvRg52N2qiulRJC3szNP8bQSVXr5duliCX5Hjs3WjI4mh/hqXsmls/vMlx4/wjoR8iH1tWINurHDjDHGvorXjntfJPwlCbHqShotPXCARKKhMkc1qw2LLR/Zlih0MLtm5bE2UmK1EZG65D6xuNn5tiudOIYHgWgKB6vK3oVwQ4/j6U+QhMfSBgZfkUVENSypecTmz0ouI+PkchzWJFafBafVf3c1gNmQLyKX74c0UENbuUEkYdMuwysR8aa/ueBPx1uzj5cq3VWSzRk/wVX45O8Il8e/25eBhfNuhBXoB2gA6GeqzIhshOj1IKEQzhFmuhL/SQ9363AWrt6SD/3+hQTwwb9VJYOobkQVDlxc7MA6beGECvYPVZDtbxSKAvh4a5ROQVpjVqDKRUcaK6Qi/LWSUER949sdGD7RYXadQUebw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(86362001)(508600001)(4326008)(6666004)(70206006)(16526019)(47076005)(186003)(26005)(36756003)(44832011)(7696005)(356005)(5660300002)(8676002)(70586007)(81166007)(8936002)(2616005)(83380400001)(36860700001)(316002)(40460700001)(336012)(1076003)(54906003)(6916009)(82310400004)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 03:58:39.3478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b64f666-cfc2-417b-3e37-08d9beb60310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since this variable was made available by the previous commit, use
it to make function access cleaner.

Suggested-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 677a246212f9..bb3f6072ed30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -212,7 +212,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	if (smu->is_apu)
 		adev->pm.fw_version = smu_version;
 
-	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 		break;
@@ -221,8 +221,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
 	default:
-		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
-			smu->adev->ip_versions[MP1_HWIP][0]);
+		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
+			adev->ip_versions[MP1_HWIP][0]);
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_INV;
 		break;
 	}
@@ -236,11 +236,11 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			 "smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_warn(adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
-- 
2.25.1

