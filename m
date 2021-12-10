Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61750C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 09:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE25610E3EA;
	Fri, 10 Dec 2021 09:38:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7050F10E3EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 09:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3eJtpm8QhtI9SbNKwlsLGP6LyCe4cBM/u2Y8hLakb59oKxKJnL+rB3I2Bo/wa6QS5gYiKI+2d4WV2ZnYCggXSmw4DcHkiUkwuU015K6nC4Y4DdI2miWWp9Q6CSEBSUICnbc4kOYfArmnLoWgmwlOQXJQSI5sUpP2oiK7oQBV78CwCUR/zlOD4o1FohQJMB8UCujmN7FaVmRMVAlbK7ATLa/Cg58RqjViw6sqYxwt2qbMtBKvUt64BRNTU53l0ye/1VfSIxg8PFKWGT6mDjglhY4kxJHxhGRF4vy73XFul5EiwCPx8bMFh2BLIxlr8BmhrkDa6ltV1AqKdgvVlv0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoObsoyBJav+9e39vHC44kppmgOInMhbip8UhyWSLms=;
 b=E0vrSQkcHvCiDJJBtDAVDizf5ZjZ6pSs+qOAeNYwZOOaA9OkNy1i529a4n2Rh7UoGHnZln5BQx7026BNARprfCCqe3grAOfHpjeuW1f+ZHSXnNhaf7FCS4lgfFBNr6RdFGtqsVBsd6U8F8tq0+yy7AT7uMRZlXR7c0kYuV1wcRMbNohSmWxRy/ycp0BvXHTMJ//u/4HzkYVArmuDy4/LB1GUcUedZaZ+tsGUE6WkKb1gp/KmvT2cwo8pZu1ZxxW599haAZ7gSL8LcWWkFEGjo/4sonTqTghZCurDy8oNobbWwC5ft9lcDoKE6yW0QKrYmoZbCzEBUAzo0ZmLm1c08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoObsoyBJav+9e39vHC44kppmgOInMhbip8UhyWSLms=;
 b=L16pVeX2kzbIbJzScdAMlaVPj4TK5GTYofTOq6bQ31ibnNnSldASnN5TNNYQyHdt7h0un3IxICIvDpWtzyQONwd1d/ueei+UyZW3QuwWl+aSrIRx9wyG2O9wg2E/BioVT5lJG0EBma8kVKi2WZZkaem6pPTw6CcDutx3x9judhw=
Received: from MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::15)
 by CH2PR12MB3669.namprd12.prod.outlook.com (2603:10b6:610:27::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 09:38:33 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::26) by MW4P223CA0010.outlook.office365.com
 (2603:10b6:303:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 09:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 09:38:33 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 03:38:30 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5] drm/amdgpu: add support for SMU debug option
Date: Fri, 10 Dec 2021 17:38:17 +0800
Message-ID: <20211210093817.144285-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af64f260-79ea-4a9d-825d-08d9bbc0d521
X-MS-TrafficTypeDiagnostic: CH2PR12MB3669:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB366908FA620D7345264664EAFB719@CH2PR12MB3669.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKEelUQzf8Ic7wAmqfKrs5G9+xvGwGz6wDxObtqIUhj273/Zdtt+pXRGkk2D78FKNfPFkNGXTQFx/DW+a8RzziqTg2Hr6wdA0CnhhGgnZza+U2OZqlEqijrk8llTqGitUdDAQLSokCWuMOd0jbQZ46LLnTM4F+D8Eo5wJ3/PADxNYziOyRkt1aDaQrCT6ZM/3FijVKNtsFbDZYCmGie5/b8qCS3X5XQMjY/vudfGx+vBnoNhTdgHTk9MCuzZx0pDAKxv/gBVlkC3cAFYXARk30iRR6v0vx4C4zpMekM0V/bc0pJjOZi6nKh+G46WZuH1aKEI0laEEQPSfQNjOpjT3vrS529PEe189O7EZ6Hv4JfnEUET5ddEbTMtoOAOi++51h02B8XsmDIcq2D1D9GnmB7db4CJhQZ5QjqatSr2Re8m9WLghI+Cmeyak9nik1In5EYmAkBRWPEK6fFvZcvIAgbWmOEYxiUhlJJDM0zSKwd9Ewgev332JlW76DoWunOUrKfqpmDh+kPBZeXaUE2dXyBAe/hJ4h7jNJjREWiCkUNF8ei8ladIHUn+B7SdB2cC02XNQmkSB5XA658DzNN0Ju0ZoRJta4yDmWuK+P8I6jVLTIgkBxZoGidbZn/FJ85/tklADbyJ3C3GbeTRuvE1vCEjycwnGm4VJ+4L03QjzSUyo1sSWFsNhe0wGq31rIm19pTx4MF5TnYheYnX7y0PZhVr/1njmpcV3QHmmLq5E6EiDpm1XJgoZZF0QF7tuPV23zwHd+UUvHd9MFmQyGmP/+0jlyG0X1d5H2eOqn7wdfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(316002)(6666004)(81166007)(336012)(36860700001)(1076003)(40460700001)(356005)(508600001)(26005)(36756003)(7696005)(186003)(2906002)(8676002)(16526019)(6916009)(70206006)(86362001)(8936002)(70586007)(83380400001)(5660300002)(47076005)(2616005)(4326008)(426003)(82310400004)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 09:38:33.1931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af64f260-79ea-4a9d-825d-08d9bbc0d521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3669
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU firmware expects the driver maintains error context
and doesn't interact with SMU any more when SMU errors
occurred. That will aid in debugging SMU firmware issues.

Add SMU debug option support for this request, it can be
enabled or disabled via amdgpu_smu_debug debugfs file.
Use a 32-bit mask to indicate corresponding debug mode.
Currently, only one mode-SMU FW debug mode. When enabled,
it brings hardware to a kind of halt state so that no one
can touch it any more in the envent of SMU errors.

The dirver interacts with SMU via sending messages. And
threre are three ways to sending messages to SMU in current
implementation. Handle them respectively as following:

1, smu_cmn_send_smc_msg_with_param() for normal timeout cases

  Halt on any error.

2, smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
for longer timeout cases

  Halt on errors apart from ETIME. Otherwise this way won't work.
  Let the user handle ETIME error in such a case.

3, smu_cmn_send_msg_without_waiting() for no waiting cases

  Halt on errors apart from ETIME. Otherwise second way won't work.

== Command Guide ==

1, enable SMU FW debug

 # echo 0x1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

2, disable SMU FW debug

 # echo 0x0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

v5:
 - Use bit mask to allow more debug features.(Evan)
 - Use WRAN() instead of BUG().(Evan)

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
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 22 ++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..9dfccb20fedd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	if (!debugfs_initialized())
 		return 0;
 
+	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
+			   &adev->smu.smu_debug_mask);
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index f738f7dc20c9..b24be7c8e2ef 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -569,6 +569,12 @@ struct smu_context
 	struct smu_user_dpm_profile user_dpm_profile;
 
 	struct stb_context stb_context;
+
+	#define DEBUG_FW_MASK		0x1
+	/*
+	 * 0 = disabled (default), otherwise enable corresponding debug mode
+	 */
+	uint32_t smu_debug_mask;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 048ca1673863..0f807688ab52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -272,6 +272,12 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res = 0;
 Out:
+	if (unlikely(smu->smu_debug_mask & DEBUG_FW_MASK) &&
+	    res && (res != -ETIME)) {
+		amdgpu_device_halt(smu->adev);
+		WARN_ON(1);
+	}
+
 	return res;
 }
 
@@ -288,9 +294,18 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
 	u32 reg;
+	int res;
 
 	reg = __smu_cmn_poll_stat(smu);
-	return __smu_cmn_reg2errno(smu, reg);
+	res = __smu_cmn_reg2errno(smu, reg);
+
+	if (unlikely(smu->smu_debug_mask & DEBUG_FW_MASK) &&
+	    res && (res != -ETIME)) {
+		amdgpu_device_halt(smu->adev);
+		WARN_ON(1);
+	}
+
+	return res;
 }
 
 /**
@@ -357,6 +372,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
+	if (unlikely(smu->smu_debug_mask & DEBUG_FW_MASK) && res) {
+		amdgpu_device_halt(smu->adev);
+		WARN_ON(1);
+	}
+
 	mutex_unlock(&smu->message_lock);
 	return res;
 }
-- 
2.25.1

