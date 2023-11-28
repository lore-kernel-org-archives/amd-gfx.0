Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6592C07E98
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 05:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A4810E338;
	Wed, 29 Nov 2023 05:58:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADD410E068
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 05:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFrMvBSv8qM6YHX0bTkwAqmUaSil1jJf1pStMIuDoMIvboSFr+uq3K40UNyh5RjdVH/WZFsUey3QtMoo1Xsapr/wGvUH7u7bl1bgMyQu+M1/9WaeSEC46rS+lRS0nx4E1sALH5ATYYm7mzJrX4X0Oclg6RzZX8VTzI2fwIvDoEtHRHektIQzXASvnP6Ow+NrWLrK1zv9/Y2uJluhPfz1yMf3hupD0mi6KFefTcq4WVbuInJSTcqp3aI9Sk+rEwQ+mKNC0DDTXk+qdJzmuYO7xtsUBczNNpKEBcZEEbjPr5eIdrelxucSBKA05SvqPZJXPkZQwSl3ANZTpcyfkVKbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li92PJfWEAu+Iiv7NkolqiyQE1DLiSSZYg3GLt6NZ2c=;
 b=PJqULPyzg3XumnLhFWb9yaTVW2/mMyNISzTklJ20NmYPCZZrPLgKtTxUBkr4wUCi/gU1+aSQAvyiOZzGmg4VnxkF0MxqJ4ZO63lcTWqgA5CLh0PFY0ieZkTr3VoKpN/d57DTm1b1q/P0NUNftOo4sid/NzV1I8wPgp8TkEK62cqQIXncXNoIiVbSZHLTYroXJtczxYUBwWqLINf/qR9Ke5oDBZw5gfoNBeC/SoWTAgMsJVf8hAN4lmjxlbSDhUnp8HK9zmrxNhNCQ+rnsgm+s7kIldl3xj5ZUnGcwC2V468MgldWf/tZB8WiO3D1kRbgd9UXYK7JyNTvlVFpuoDiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li92PJfWEAu+Iiv7NkolqiyQE1DLiSSZYg3GLt6NZ2c=;
 b=kEuSf/PY7pk8NkTKTl4evHwa07Oj+0y/MWFNYXkSjP0E5uUhFxzMbnhl3W3h0qCQDffzWbGHYPei/dExaWJKIJrQztipMbOh0H3o/O1FDGxtnEgQ67dCDX5MRMyBJutdaBfEZI3UfJ6iIlcsHowBrRIhThTsX8nUNbr8Ct2/MkI=
Received: from BL0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:2d::36)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 05:58:27 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2d:cafe::7f) by BL0PR03CA0023.outlook.office365.com
 (2603:10b6:208:2d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 05:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 05:58:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 23:58:26 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Introduce new enum for BAMACO
Date: Tue, 28 Nov 2023 12:52:37 -0600
Message-ID: <20231128185238.187381-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128185238.187381-1-mario.limonciello@amd.com>
References: <20231128185238.187381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c9b713-5511-47bb-4fc7-08dbf0a03475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMTiAKmQLgHlFWM/ze1BN1pgB1iC779q44wg9CbG1Eye2PEQl9ObW4Xa5beSX7BRlWwheZu9JomcjOPA0uMan3AXKJn2W4cAMICw2TBcD6VZPuvUcHtbOO8xPSr898gq+hOY/6V4wgrhgpH37oyQs/vmXWXjLAlOjfqbnH3tMT9xlkhFUehQWHALdkvAfz5R22qrb8Wc3YvbahMIr4RnPsXUBFl5V8ZlksPkoYPM+gzJIzlJkwfidN+3shVVdN2x3auHW+A85wg47Rh1DtEPgye7t+cknFfmqrMKoAZ+7EXqstFw3BwCpIoU+8RB+A6cOwZLG00For2wm7aa0IcxAIcSxnLBci4L8XAjFKLx2jlpE9migW1dWSCwbZ5rtODCi144UjHYIR3hSCbAxaw7yC8Wvi9WTuD1XHTJKBqx4QMrf5gIoYphDY9Ce+ET5AJN9aHZukEPIV42M9s4ioFruxlmaYQ6/o+bPjn9GF/8KyUFLMnMFfIThUrRAqh3Nq4N4dks3UKn88MEAHCbcFuDqz8dt+pUI7zN+CLDPea1Pn8wXsf3QzB/fjVGQccuGkmXd/phkSd4kRNu9POjBhZTCV2aTa0Zc7mFJ31MtCWNnQj1ZiGXwv7ffp93oNRo5vBoRLnsoTX/bEpic2po3EEMKpXxdvRtlEt9AkchYlhkTbbSA/1VsVuWl1ua01BRlZUmaexh1o3ijxjd3H4kB6CDNfiMRDuaiZ43XZLqKBspiKxJ5ISo22Rbru40sKq9Vz3RV6L+K8oDSdUAYLtbMRDH7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(26005)(336012)(1076003)(426003)(6666004)(16526019)(47076005)(70206006)(83380400001)(7696005)(36860700001)(44832011)(5660300002)(2906002)(316002)(41300700001)(70586007)(6916009)(4326008)(8676002)(8936002)(54906003)(478600001)(81166007)(356005)(82740400003)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 05:58:26.8125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c9b713-5511-47bb-4fc7-08dbf0a03475
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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
Cc: Jun.Ma2@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than plumbing module parameter deep into IP declare BAMACO
runpm mode at amdgpu_driver_set_runtime_pm_mode() and then detect
this mode in consumers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c        | 2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 +++--
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 29381da08fd5..c6c87ab71d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -143,7 +143,7 @@ static void amdgpu_driver_set_runtime_pm_mode(struct amdgpu_device *adev)
 	case 2:
 		// TODO: adjust plumbing to be able to pull PP table to check MACO support as well
 		if (amdgpu_device_supports_baco(dev))
-			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
 		else
 			dev_err(adev->dev, "BAMACO is not supported on this ASIC\n");
 		return;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index d76b0a60db44..3434c31b434b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -50,6 +50,7 @@ enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_PX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
+	AMDGPU_RUNPM_BAMACO,
 };
 
 struct amdgpu_ps {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5a314d0316c1..64c8783b4118 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1597,7 +1597,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		case IP_VERSION(11, 0, 11):
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
-			if (amdgpu_runtime_pm == 2)
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_EnterBaco,
 								      D3HOT_BAMACO_SEQUENCE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3c595ac897d6..b77763d6c72f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2259,7 +2259,8 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      (smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+						      (smu_baco->maco_support &&
+						      adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
@@ -2288,7 +2289,7 @@ int smu_v13_0_baco_enter(struct smu_context *smu)
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+				(smu_baco->maco_support && adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
 	} else {
 		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
-- 
2.34.1

