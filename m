Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6FBEBFD22
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 09:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB3C10E3A0;
	Mon, 13 Apr 2026 09:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lhJJKMBi";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9CB510E3A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 09:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALrKKHk4cN2FQZOPXcDb7LEVD9uDZWiQRddkHlyW/uAAMdv7m+DnEwLPdBrUgVWrctD6ZFe+Earost4hbxRqt0Np9LtpErxaiqazT91obHlxvsuElgBdf/ubU1vIxuvcV2Yx8k0tPh9gCX2i7GP7omurCDSCqcR6PF3fXK8CuMDHLXk36ueIx0nF5w+vR+pHx/Grl15zBoDDbQEZ9OSdl6LDt9rDPDgwJzOQ6CsN2l39jg44GJ8YcXFdlYwWZMqV+aW3oPUo9vPgwxodzRz+7oa1wh4+aOZodUlGTPsQgAwo4mkER4YCCmT2p5uxgASoZlE5WtMRmv4S156pLUPttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HabUKKLQoMrIW4bpNdBnWtgM1U7u5QiMVc7LOUiOUJU=;
 b=TK9TKBJfF2d3HpT1M72nDb6UOFtrSI6o7PUq6ZMiGuNDhRtcFzgbQYxYCnI7Omx4uHylS4BWYfF/6U75XKHFJLS2ws0HLFLNg9WTYYs0AgpZeAV5zH9SA7xW72IMS2GEufqv7cXY1BOiSLftvC0Yhd9H1OUHEI5YplKouLXUjWbJQWiJKbFCqikDTc4ZRnYeluUbYh29syGRFJXR/N4fiMwD5nwWEOEC8daPQakYgJ6HdcgNsbKOKkRGjlmkzf2wJ0wnFjhndL5agckOeJiy+mT/i3LjFj0q9PCeRD70eYXsvG4+eApHCFmuteqTjM8WpUlvZXBklukTP3pw2AXaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HabUKKLQoMrIW4bpNdBnWtgM1U7u5QiMVc7LOUiOUJU=;
 b=lhJJKMBiaq7YQbLJAn88bSar8cu2wmxKY4wmN/GtU/M81bk2oSpj9Aq0QJr4QllwwKd852RgVXExUrzUzvYo8t9KqzsQOx71WSVh5u76r7GJ2yn3bOsH0+OuLLPRWUYukZqL0Jzo5A3UWQPSL8hcJh3ngNVUfnNob6bYJBrjkDg=
Received: from CY5PR15CA0090.namprd15.prod.outlook.com (2603:10b6:930:18::8)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Mon, 13 Apr
 2026 09:29:04 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::f3) by CY5PR15CA0090.outlook.office365.com
 (2603:10b6:930:18::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Mon,
 13 Apr 2026 09:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 09:29:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 04:29:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix mode2 reset ACK wait and error handling on
 aldebaran
Date: Mon, 13 Apr 2026 14:58:47 +0530
Message-ID: <20260413092847.2324099-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 47da9409-124f-41eb-2b00-08de993f1a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UqxWun9bYrCnWl+Gb5Xl8qkYQKfxXji+lhtExvsVpSU8Wc81uwl8qtrmPMPd1dNQjdpQ4Tv91kfSp6Fs9TfuCKmIdM1iNSMKVb0cwn0Nj/F8PGbb4kjxpgRx1+fBBnncZfL5+LzXy60RV8j7uoXro5COUsL+U4qbg6vVd/MyTONuf4rHNedvhN6CF85TpILmRSgcKDLzFQ6DDyxNFQIOThISi6cMPg7c6Xt0xYnApBt7yoqSFADxv6GK0IO3pnjRX7BNkMKAK0l2IpNUgwnBdumyiCgCIUz7wgN5eN8ITwrVM+0UcOcF0hdJ23yQcFfqdLEzZHeH97cgBd7uHeq2fHPGA31JADXPVEYh5Fus0Jy/3rCM0gf4pJYlSCOdw2t+GEWFAEt+XaEOuMpuU45c887/D/wN91xd1SGpVJupbmQF5xpSO2c6CLt9LyOmAcoab84qEkq3AFIp37RHNniMJCRM1k2jW9qvbt0wNdrYmHplEpkAmgJSQAv3Qt7Hdx7dhEQvPjCVpDfeNj0Z33LAVlaIC5PXZOm6MiU1MOn6oLQaXNRxkwB/4ztsv/kpa3pMkNbsOxeC3AWZZM9L2iVXF9VDc1j5MLKZBzO9wzh1mbMKWDdi3AhgRxzAVtNrpmmXQo+RmNuelOeykhPYSaA5FNLX66s7z1+qFPSf8EzMfUGj/Bi1aZzY+YOShaqLNC/sPVDak08PZZimggX7kgeSk3+H0BHn1P6UWbQUi158laT1azs3V/dsMgt51TOZepr95JR6VgUhj/YDvwGCbXj7Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9AhoA/IjjdI4RtgOz9CraDAizae1KIOtXdlo1dU+sRYnfX/6EgN5vId/n4gp4h/20XJcurDGqv4Z0b8yjUoT75B37UW7zCrbWc+dXm9J3qXyaHYjctjtR+rW0X7/Nd5v+i4wtGkxZLmwHobXENZP7BNTuv4mIAZ8kX3igW5lJ0Wt5o6bV9lbfdbNuw7RqAiW5jl9dPuI/hvQBUvC8d9/17cmz+m9zYhE4bQGKZcjy/fueJUqCSFuHsAtY7soQhtf1+zU1TTGloTIoI2rx47wK8gCsNUq7Hm/imJ0BOVelKVs9IQpt6U0DAGUrrUlzfyEjnjVQpcJzNW5E2MuxeJEnTBS9VM45c+XdDjPQNvcwbBqOzaqPQ/dUksF+ctRP1h3Ssoy8hqF/LS6fn8iq/sp3GykovYMHyKTVVTX2X4wx34+W4Wcc9NBz8LO89McZ78T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 09:29:03.3339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47da9409-124f-41eb-2b00-08de993f1a2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aldebaran_mode2_reset() sends a mode2 reset message and waits for the
SMU to acknowledge it.

But the current code has two problems.

First, the wait loop checks for ret == -ETIME, but ret is 0 after a
successful async send. Because of that, the loop is skipped and the code
does not actually wait for the reset acknowledgment.

Second, when an unexpected response is received, the code prints an
error but does not always set an error code. This can make the function
return success even after a failure.

Fix this by initializing ret to -ETIME before entering the wait loop so
the polling runs correctly. Also set proper error codes for failure
cases.

This makes the function correctly wait for ACK and return proper error
values.

Fixes: e42569d02acb ("drm/amd/pm: Modify mode2 msg sequence on aldebaran")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Feifei Xu <Feifei.Xu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 259e5a13c1bd..c9e0648390c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1847,6 +1847,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 		amdgpu_device_load_pci_state(adev->pdev);
 
 		dev_dbg(adev->dev, "wait for reset ack\n");
+		ret = -ETIME;
 		while (ret == -ETIME && timeout)  {
 			ret = smu_msg_wait_response(ctl, 0);
 			/* Wait a bit more time for getting ACK */
@@ -1859,6 +1860,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 			if (ret != 1) {
 				dev_err(adev->dev, "failed to send mode2 message \tparam: 0x%08x response %#x\n",
 						SMU_RESET_MODE_2, ret);
+				if (!ret)
+					ret = -EIO;
 				goto out;
 			}
 		}
@@ -1866,6 +1869,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	} else {
 		dev_err(adev->dev, "smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n",
 				smu->smc_fw_version);
+		ret = -EOPNOTSUPP;
 	}
 
 	if (ret == 1)
-- 
2.34.1

