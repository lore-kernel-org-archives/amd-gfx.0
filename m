Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C787C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 05:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AE410E13F;
	Thu, 18 Jan 2024 05:37:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7191110E136
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 05:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeDFEmPgl4tCFZui9BcY2pIxNtYZJA8M5ATkRHpyJl6zoeomQesAnzK7D07vxpbmvt6Hi2MSNyHpIrQErSS8qdl5bSXHKN5m3g1W6+P66zw6a5BS7hqRkjpJ1BTHaWpkUQD2DeZd1aZXEXla+IVGVgEusOUbdmeKDCDoeDC/xLZqDeIcsIRN/ktTjsJ/Bq34lQ4xp3/Eb/j3IDqp8ZXtumC2KFp3/gXobL+cID8PVGr0qvUhsmLTO5U2EwPCyiIbqX9xkMz2r8IGiANbmy+ncv37vl9B6QyCVYY1mhADyFwlmmtkMQEfX/cTZ3paJanyHz/Oo+HMH/EbjzZV0PHkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z67PiTQPFqggljZTNa0RGdL3wIT/fm1SmBMcZTC7vj0=;
 b=Do1sdjRJ7oJqUKZQCo1/7f4kthZKi3lAAPzDP2gyKXNOh6XM/CAVSLtLX5QrN8gvxpfxqOCKCJZg7DX4SYc2mHFHXm9SDhEgCovqS1hzj6Ro/mf1iFCyOnB7j0gYYA8FzRuQW2eRVBF7LmLkw9c4QP8KQ+8vLsa4C6skQWNkeSHyFnf3GCP9jnsWgbpKGi440mpgi5dWAvTs9JRGWskLTVBq5mdQn/627nk3Z3TitMjI0dg7F5q/Md1CF0CJuXcERTUMV/vy/AMVYB4pH9toE+PLKhpcAJFf9KcXAsvT8T9pVsqPM/cFPNUmwlGFfIyCmmfkyKV+5OSJ+9goPfmTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z67PiTQPFqggljZTNa0RGdL3wIT/fm1SmBMcZTC7vj0=;
 b=R0ZicfB5p3taV+d1g/+MbzDsyfQSDeymDKE+f9yxRggDIjJlDD95F23vXLiTUQLuXWmFFCzxF834pRT2EHH9hbMKRPKVGojOo0oYcfZweghgkw6PvBlUcgXpinwM8syKTc2gWi+u+pPi9UsxjBLKPYx1W0omy34iov5UyPJK8EA=
Received: from BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::15)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Thu, 18 Jan
 2024 05:37:34 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::6b) by BLAP220CA0010.outlook.office365.com
 (2603:10b6:208:32c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 05:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 05:37:33 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 23:37:31 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: enable amdgpu smu send message log
Date: Thu, 18 Jan 2024 13:37:11 +0800
Message-ID: <20240118053711.1975928-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0b84da-35e0-4fb8-b6ad-08dc17e79220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iX8oDqzGl7FJL4OCe4Dl0CDzaG7YtwnUCEAnnBTRXiF2o+0hDQAqfc46tva8YKWX7rjeMsRvcrxKfnR/74cCUabRbD5XtHWcOFHVyQ2fk00bajr8SWsskOPnPkwnfKam+HBW9o9HYr06o8XENdvLzbRrhtGZ1lX7babR9Hub0n46iIWc2CzD+po5N63HUyrrWp3OiOyE3cGQp/FEi0jPu3XhbvM3V0v5zVlQkl9PbPPZDA+5N1hrcYT1L4wcLxZt6RW0yu/Q8H5gWsN+Yhc9y1CEAb4CNhBiz4m6utulw/Rpv9VBDz4WRENZbnC7MFyTSxNapGLvvYZb2U6tZnI2ubgnIoYIbAEEYcmEr8jkkBhfFUEotDEEWnUjtWBLN/LicMTMuiC3f72WPBELdFeoX/g5bfe84vh2tx5qV/XLehtg+GmeCZX6YcDz7LuhFs2mB0XKAWS+7ahWIhDLeC0WA43ga9iyFK80TOi7DiYjEC3Q+UX3G2M2BikyJqMd4XkfuMPnCI0CMeGhB9rjjsmtK9cEv12o3QZEuwRsfOIaSVKI4sHn3cpC06cXq5v3PDsTRIvC0rbvsTEbU9xXWOVal1d/kTNXJln8nhdZ+lg4M8D2zN/Sq0qO2CpMwHWS4ZGCRcHXovkXpqG2NtMmW2R8KYCqJrVqNu1nC4j11W4ttGH72vvrLTNNFgbnjLIePsNqUpFJujDVRVb3uuTdQMkC6TuTEDxJl+o0bjPjM2JvbXWsPjNQrvf4l3mrlRoy3Zip6kEQgZwCUTZ/DwpqZ7yFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(5660300002)(6666004)(2906002)(70206006)(70586007)(54906003)(7696005)(4326008)(316002)(15650500001)(8676002)(8936002)(40460700003)(40480700001)(478600001)(6916009)(41300700001)(47076005)(83380400001)(81166007)(82740400003)(356005)(16526019)(336012)(426003)(26005)(1076003)(2616005)(36756003)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 05:37:33.5956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0b84da-35e0-4fb8-b6ad-08dc17e79220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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
Cc: lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

v1:
enable amdgpu smu driver message log.

v2:
add smu/pmfw response value into debug log.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 00cd615bbcdc..b8dbd4e25348 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -378,8 +378,15 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	res = __smu_cmn_reg2errno(smu, reg);
 	if (res != 0)
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-	if (read_arg)
+	if (read_arg) {
 		smu_cmn_read_arg(smu, read_arg);
+		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x,\
+			readval: 0x%08x\n",
+			smu_get_message_name(smu, msg), index, param, reg, *read_arg);
+	} else {
+		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
+			smu_get_message_name(smu, msg), index, param, reg);
+	}
 Out:
 	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
 		amdgpu_device_halt(adev);
-- 
2.34.1

