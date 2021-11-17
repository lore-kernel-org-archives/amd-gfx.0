Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F04C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 18:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18E660F8F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 18:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E18E660F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D51D6E83C;
	Wed, 17 Nov 2021 18:56:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0906E83C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 18:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afjhwwv4WNxqpAJLRxrEyeGVMWYWOtSnmXJCbrN/WPx5MqsOTGu4y/YRhdIiAvdkzWg+m9nQk1pjvNS/cWpO8k/gAroxRlvgJnxHec6g7aDDuIVHSE7AJ8X5hUy/vMcIhL4rVI7OMz/DVHNCCOfTe/mVuElCUs4sNvXtb/YbNXLuZwpQb4OOYJg98TjB3L17D1V2Gq9/4KwWNrCbxRPqWOdw+185fnNmMDqvOSUeacIA9jrm4oaSkugWscNyG/OFsyWbkPnlnRS2iBS2ZAK+f7GfggRmg22cWtLOWR7w/amHLgeZEecBVDgHcmHOeonuelzOn30PBMWj2wxIQRyc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYq+GLtjZ0a633yLmnyEJXkoDmvB15KS6iwRuSWTmZA=;
 b=MGVgInO7reZoTh6hV9Bw9ltycuVsn4XxvlLJeSJIpokGnlxL/rrAyY72fvhIoU8fvbednXgxuyFEi526cwRtASrpAHPKL49wewO1O5JRYBIJ0925G0qkqhgIizbwyNLkY3dTr23ynWcBhCRmxeIE4BXkPNpxqWjEZQcg5MKht7ND82V1YxUxoIKw0k33fhUY23lupYSxhfxc1gOCc+pXmLtdgsFIgUV21iykrMBQHeAp4+1cwrXmJqBLeAj3aBRMGlpZEy+S79Dqp63R8nF7VO8jxTTdBOt2P7wxIAkcQ2+2vR22JLJvRS8eP2DfZDE1AKSoH9SG03IQMbay0e8OXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYq+GLtjZ0a633yLmnyEJXkoDmvB15KS6iwRuSWTmZA=;
 b=puJiAD3AQJXiGD/x8IvD188VCkDeWR3S30hjagUArVe2cz8rd/Zlx6V3IhiNhfVWAKK7mO77Dv4oI1pEnxqOGvKM/+J26SyiDQM1O/QPl6AKUin04jNDKIiyp7qT8BZYyXM43ULD6MmDMFsEX3WiShlnHE3QFbvdd5NBBhLRKn8=
Received: from MWHPR04CA0051.namprd04.prod.outlook.com (2603:10b6:300:6c::13)
 by MWHPR12MB1808.namprd12.prod.outlook.com (2603:10b6:300:114::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Wed, 17 Nov
 2021 18:56:00 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::ee) by MWHPR04CA0051.outlook.office365.com
 (2603:10b6:300:6c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 18:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 17 Nov 2021 18:55:57 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 12:55:56 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Add debug prints
Date: Wed, 17 Nov 2021 13:55:11 -0500
Message-ID: <20211117185512.102807-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab7a7855-752f-42d5-3639-08d9a9fbe40a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1808:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1808E2F65582998342F13DBF999A9@MWHPR12MB1808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFYW16OQc6lL+2b5v8syWRV4J3s3Ag7lrmQaPhl81qZNTmLJnOcd4W1LxUX6Ib3D2UxYGGjXRLlyzC3AFF6NZYEZTlHThipnc/lAML/ZHcp8NZrl3HA2sWvN0962WdNSVRm37lu8R5dospIAl1KJoutVAKqK5QH5sWv9Fmfs4l+dCGuUE0wz4E+2ysPyknzpuwfqh30byrrp370uZflJgSJ3o9DDmlYub74h3K/HE7eVKhatL1YHTCgxkcu+4muY6ePljKklA91I/bh90IrSwv0pSOFl8SBJq6QkjpIi+MHY2b6bfZj1JJq6p2IfCZhX63NsblzhKuGcGzbW/2ANRxRifSDfbDKOcDZjjp4G+5127pNIywREfhg+NCIjoYT/ftLIAp6NfeLkBfOMlHMhOSh7BFTKxxbXKYEsy+wD3qgqZBLkU006Z4jvBWHlx12SKQI3XeKAeS+4yinVKCnGxd/q+SHKTtmX1goBIm6hmxNXyQSaY3t9fHst87mnuV3tvPL1ZMgVaGk3CL2WzGlPJwGcu6QCRnJGiE/E3RiOyK4zPx+1fsebMX0+8ZQz0Na/P+x/We4oH8QlM5OED9ZRhnuk5aBnnLJtKxqU1n0o5l/hdqkXGsUrBk2FmG1CERG5fkqo/WvPPCKOcdN6nfsD5yrrKsTe1Pqz5xU/1Puuird9gIUeIjlR7Z9NAZs1ebWHiyAZ7/ZhINiIDqxiOaAtmQ+3TmMwBbMzjU4kAj0NWrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(426003)(336012)(81166007)(54906003)(6916009)(36756003)(4326008)(44832011)(2616005)(316002)(86362001)(8936002)(1076003)(8676002)(47076005)(83380400001)(7696005)(2906002)(5660300002)(66574015)(36860700001)(356005)(16526019)(70206006)(6666004)(508600001)(26005)(186003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 18:55:57.5816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7a7855-752f-42d5-3639-08d9a9fbe40a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1808
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add prints where there are none and none are printed in the callee.

Add a print in sienna_cichlid_run_btc() to help debug and to mirror other
platforms, as no print is present in the caller, smu_smc_hw_setup().

Remove the word "previous" from comment and print to make it shorter and
avoid confusion in various prints.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 8 +++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 +++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 01168b8955bff3..67cc6fb4f422f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1153,6 +1153,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 0, 12):
 			ret = smu_system_features_control(smu, true);
+			if (ret)
+				dev_err(adev->dev, "Failed system features control!\n");
 			break;
 		default:
 			break;
@@ -1277,8 +1279,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	}
 
 	ret = smu_notify_display_change(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to notify display change!\n");
 		return ret;
+	}
 
 	/*
 	 * Set min deep sleep dce fclk with bootup value from vbios via
@@ -1286,8 +1290,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 */
 	ret = smu_set_min_dcef_deep_sleep(smu,
 					  smu->smu_table.boot_values.dcefclk / 100);
-	if (ret)
-		return ret;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b0bb389185d51c..f3522320df7e58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2135,7 +2135,13 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 
 static int sienna_cichlid_run_btc(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	int res;
+
+	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	if (res)
+		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
+
+	return res;
 }
 
 static int sienna_cichlid_baco_enter(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index ea6f50c08c5f3b..f9a42a07eeaebf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -97,7 +97,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
  * smu: a pointer to SMU context
  *
  * Returns the status of the SMU, which could be,
- *    0, the SMU is busy with your previous command;
+ *    0, the SMU is busy with your command;
  *    1, execution status: success, execution result: success;
  * 0xFF, execution status: success, execution result: failure;
  * 0xFE, unknown command;
@@ -143,7 +143,7 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 		u32 msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
 		u32 prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
+				    "SMU: I'm not done with your command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
 				    msg_idx, prm);
 	}
 		break;

base-commit: ae2faedcc13fa5ee109ceb9e8cc05d759ad57980
-- 
2.34.0

