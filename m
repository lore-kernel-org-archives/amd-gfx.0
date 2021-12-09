Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27748C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A370010E8F4;
	Thu,  9 Dec 2021 16:53:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABEB10E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 08:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drFlqSNaK1k9anpkknf3wUrpc5HS/7xcHPFxij/yd3WQPCzaYrcPq6ZI38EvVz1Es0cOMwIVIDWgSL2uYczw9LbVX97S8qnhAiDN6OBhWvWMRbOskuk3Sc+U2Zjvf1tdw0QTSgNUydwyU9mApxuemI+BSPI0FDakOKmP1RlzwER4fn6mkod6HvkPisIscPiDa87cWnC7LyLeQTb072gT3hQadsXi+Yi28Wde9cSZ+FDSWfC3BhwAkXPtlXgeg7t1yWTmvrSlGSaAEyxkNAKkP1tYuawvm+tZ4YzrntfH1s3HH2CnSMCQmRn4tH5X8gTmfLd2DMAzLoj3gzfGM/hjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFB5BlZ7UBm1cKC4SwXDSPYttCj+iJjClxWNjEvUe0s=;
 b=BHRp0aoaB+RXUmRzQ7u7sKdWtdGaM5ZGuzcjo2DiBS7lUuiflyUP8/Tik6oJTEZo6H929CGtstVaHMjObjQ6FM86BqSqLVbLS4zDi+gn09unCVVlyoo66JxW3567KVnbTVKDMTINM6LBiyKeJNgBM85y7f+DzWMZ+d2K3rsjcan8bocyIMXwmSsaUWH5RUhVQg8rlHmRiLHzWJMGLZDObic3Ykct9sROzg25o1RIKCNZjjRBQUGACrIAqOwUGFwUgk8qvMzvyoODHlNl+P6pdP9QMcA2iV93i63yl9h8j9AV8OI7X1yIyRsWivbytptViM434U2tidjrC6Owd0p+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFB5BlZ7UBm1cKC4SwXDSPYttCj+iJjClxWNjEvUe0s=;
 b=yeZdVvy0WxWVBGr8oRv4jvCJKab7D00DZAum7aF4F384XwR8GoWBqhjp47A3nMW5feoHjdlbE0cNwInvvlZgoNCoiRK4XkgzaIWlWp3zByiph2k88/mMP8wD3XAKAadHn2BdZ4N+i1PXLKnQ5WjTaXjwujEeix96eHmkRVMg6yg=
Received: from DM6PR05CA0037.namprd05.prod.outlook.com (2603:10b6:5:335::6) by
 CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Thu, 9 Dec 2021 08:50:25 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::d7) by DM6PR05CA0037.outlook.office365.com
 (2603:10b6:5:335::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.10 via Frontend
 Transport; Thu, 9 Dec 2021 08:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 08:50:25 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 02:50:23 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Date: Thu, 9 Dec 2021 16:49:14 +0800
Message-ID: <20211209084914.261889-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209084914.261889-1-lang.yu@amd.com>
References: <20211209084914.261889-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd3fe238-e03e-405b-cd7e-08d9baf0f18c
X-MS-TrafficTypeDiagnostic: CH2PR12MB5513:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5513E4FF5B5DC2EF6F7A42FFFB709@CH2PR12MB5513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrYlX/pf0esVlSnd+/E8+67vV+3C+n6sjg6vIsgCXSkxf2VSnky7XLV0NIycHLlJcB5D3f7R5nuVje5jNM0GB9vayNNfxbdhUC9YKYQ7DTzgQZUYG10ujHioKvbK/zv4stuqanNrWp1aCZ00Cbs8K7/J3F3BBLvXFgdc6vj6uk+HEKFIxDt0CyIgq0Iftdu/Vk1KzL7yyq8+qsdKvvkruQTb1i1sspZ2y3cYR3SlqPAKaqs1+vSrZvAzjd3Hllj+7uRWvEbHBA5jYLmEdQ/C5pLLGntGIl93HuRnUbro8Rt5hi4cf/JlkWhooZBlM+UQi/rRxJ+/h3rmT7XUYRFkXjQVP0C+4MNKyfdaWUr2hbQXu4as1wRWUJWuuq87gNZdO9pZB3kynZi5Th9aV2wndtgp3WcvJ1c+Ex/wevaVHvnmvsr5sfvxg+SbaaDkUZB0fNF3kjULVIPZYf3ToFeFNbwTu7wnGFzY5CGbSlseChOt3nbXPYAAFrIkC8mnB1B7TDC/YGNICQCsNDsAokYXYsn8FkyL26zzg8FuvGiR72v2ZWbmVY152DZqrsSsP/igSowuZCfQlUsyevy5o7qJLzU+n+pH3dRcFFHOjvOCOWtd2A+U/BcU3dx3E3iths/SvVMSDaIK9pj8w8H1w9oTv1LNN6r9/cpvpBJreeWwLu9hxt6lTP9FaL/egID4NG/BkN8fOnaJEVbW0XT6SK0ChctaNG03SAruawnSeK0puIJXD9oJjZPJ3mA6UYVZv65BYBLVNHldI8t6cRRIDK526R7nphtJLYDUb1QCe09gWN0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(81166007)(44832011)(36860700001)(86362001)(16526019)(5660300002)(356005)(47076005)(508600001)(4326008)(70206006)(36756003)(82310400004)(336012)(40460700001)(26005)(2906002)(6916009)(8936002)(8676002)(7696005)(426003)(2616005)(1076003)(6666004)(186003)(316002)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:50:25.5996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3fe238-e03e-405b-cd7e-08d9baf0f18c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU firmware guys expect the driver maintains error context
and doesn't interact with SMU any more when SMU errors occurred.
That will aid in debugging SMU firmware issues.

Add SMU debug option support for this request, it can be
enabled or disabled via amdgpu_smu_debug debugfs file.
When enabled, it brings hardware to a kind of halt state
so that no one can touch it any more in the envent of SMU
errors.

Currently, dirver interacts with SMU via sending messages.
And threre are three ways to sending messages to SMU.
Handle them respectively as following:

1, smu_cmn_send_smc_msg_with_param() for normal timeout cases

  Halt on any error.

2, smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
for longer timeout cases

  Halt on errors apart from ETIME. Otherwise this way won't work.

3, smu_cmn_send_msg_without_waiting() for no waiting cases

  Halt on errors apart from ETIME. Otherwise second way won't work.

After halting, use BUG() to explicitly notify users.

== Command Guide ==

1, enable SMU debug option

 # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

2, disable SMU debug option

 # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

v4:
 - Set to halt state instead of a simple hang.(Christian)

v3:
 - Use debugfs_create_bool().(Christian)
 - Put variable into smu_context struct.
 - Don't resend command when timeout.

v2:
 - Resend command when timeout.(Lijo)
 - Use debugfs file instead of module parameter.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  5 +++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 20 +++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..86cd888c7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	if (!debugfs_initialized())
 		return 0;
 
+	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
+				  &adev->smu.smu_debug_mode);
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index f738f7dc20c9..50dbf5594a9d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -569,6 +569,11 @@ struct smu_context
 	struct smu_user_dpm_profile user_dpm_profile;
 
 	struct stb_context stb_context;
+	/*
+	 * When enabled, it makes SMU errors fatal.
+	 * (0 = disabled (default), 1 = enabled)
+	 */
+	bool smu_debug_mode;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 048ca1673863..84016d22c075 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -272,6 +272,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res = 0;
 Out:
+	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
+		amdgpu_device_halt(smu->adev);
+		BUG();
+	}
+
 	return res;
 }
 
@@ -288,9 +293,17 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
 	u32 reg;
+	int res;
 
 	reg = __smu_cmn_poll_stat(smu);
-	return __smu_cmn_reg2errno(smu, reg);
+	res = __smu_cmn_reg2errno(smu, reg);
+
+	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
+		amdgpu_device_halt(smu->adev);
+		BUG();
+	}
+
+	return res;
 }
 
 /**
@@ -357,6 +370,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
+	if (unlikely(smu->smu_debug_mode) && res) {
+		amdgpu_device_halt(smu->adev);
+		BUG();
+	}
+
 	mutex_unlock(&smu->message_lock);
 	return res;
 }
-- 
2.25.1

