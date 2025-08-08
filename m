Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620E5C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AB610E4BB;
	Fri,  8 Aug 2025 06:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SzidoItz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D89610E4BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/Jn/kzfc4Qb8uyLlVGot1wc0aTkPpAiGkA0f/ED5DwpSA0rKxJpsfMIUhE/aaGF6RzUhBYykFz9wwvXFHiikee1cKOzWeJgtPduE1/kONtAeZKD7QmCiqIcSonhRjuE5Uq/Ov3yUEnw18bqrUWF7vpit6F2cxNFC76m1TwSnVjhoRLAfDXJ/+LVTYY5zfMlcvyx1bnThkam0zFgXfsVX6lpKQLuw0KQgVchaDh2fDHE3LoSkbtClPeD54POX+iTI0KGQqXb6Kju+FnnjX6/7xhLDAQmGGmIARkkziHXxytqsADQ5sTssjzc6ddM3yhtXD6AYwucZk0jdNb0YxaNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=T0iXvVItx/lZoM0mRuP37/Cja/dJIEjauG/F7nVkJsReV8EuRYOBCUkPwvEPtIbBSr4bQ0ZeSRmFHkJ9qBduBLOG9W0qIOXZCslbQfJF1dIs5pJYSN53gPfsPB69s6vuENCxKNIFI6XBssgTCZykF5dBWdeTZz4FU0BHU8J9M8V5wo1C/yliKGPRJLvV3vdh3NTOw6gJdSghdFmfXqhQV64IDO4e4r7ZvgdBruNY0b/Q5cUd8FiR0byx8rfO2njk+wT3V+VILTnbZpW4Y+hepFrtsK+lJjxInE8bvnVmJ+qyyniKUmXaOtImJuo4E7vjYSPJ3HI+uFAhhYM4aFddfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=SzidoItzjZWLrK+b9OInLu0juVVgINb+x13rQMeDNPQ/zivA5RnT4kU8mrIdmjl5m5FIkmeObJ94VDn5GX66svSQUwQog0Td5vaDbGOKfzymS8J1AycBxKO6qQku95zpeLYv2cJD+L/lh0wOppoVFoCzNB4C2WjOjPX0C4XlH/w=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 06:29:31 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::bb) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 06:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:29 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:26 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v8 01/14] drm/amdgpu: validate userq input args
Date: Fri, 8 Aug 2025 14:28:57 +0800
Message-ID: <20250808062910.1613453-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9b83c6-1f99-41d1-616f-08ddd644ee38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O9O1AHGBQM4SZarFCqVncBkfyrCh1RHQCpWX9grub4bOoUjTUJMaj9j6jMDt?=
 =?us-ascii?Q?+DcKF2+GS9APXaqWiiSKUR1FhzXIZbBE8P8X4nFp1Qu+ow4Mdde0NA7jcCGs?=
 =?us-ascii?Q?A89um1yAaYuWlX9YIJmOd5vIKsevi/oI4OB9IPJk7RH3llgPFuxGxeAfBS6o?=
 =?us-ascii?Q?AJ168pZTNeSz+b2M/PdnRUTvASUv5N1bEz1QPYp45dv/er7ivs8DH4H6gR1e?=
 =?us-ascii?Q?/xpXqKNrYEWa8JmzYRCfmXx+YkBCKEhiFHEVIR7Mm//2plZKUmfTOH6Vj2MP?=
 =?us-ascii?Q?4YxrBGVilXKftHTtSfLR07NXsYcCeRIpjWUwjCLOFRwVrDQRQl8NUJvMmpTa?=
 =?us-ascii?Q?3VFqXVb1NrZHf4yi3clLwCljAOK4AkTJX6KEdHKEGXaY26rrgMpCswHp0rKH?=
 =?us-ascii?Q?eONkp8Yp+bI6roeaSmSQFrFr5/oRNkfpLgpugCwsR5qrghW+OLhl1cm7n4Af?=
 =?us-ascii?Q?tFUhCVhxn4tmlO2PsTKDu+dWCEGPs4coODI3XYeEtmv9gccmAldVOE22CAvQ?=
 =?us-ascii?Q?I24YVEGie8VYF2TPRRlLw8kVj0fWr0rKwW/2DNehKMHiVk27lUUOw3QkSL5R?=
 =?us-ascii?Q?UCGpiPYFtiWqq1FIuA8ChgznnQE6IiZLECIYu5lYXUMSMdO2CuNWksxMkHFq?=
 =?us-ascii?Q?zh70WXHOLe9oW+MBkw+glCJd61phxzPxtL9+zF6NklPu4MwEsu/YJmhb8+Fn?=
 =?us-ascii?Q?tcxIEGVykw7xfa8z4tEoBI8vUn18j3f2PuTAw5R7XKBWR63xckFM5pgK3kiN?=
 =?us-ascii?Q?NKYLo4CXk34XNgNPIO5KUVS/EYvtaslJnCRagOZOwAVBzdhTKoX98bfWyINw?=
 =?us-ascii?Q?1ggqgEsKbCIerOR8SqLsW+WTB4DVsTq2QO0ugTGaiJbkAIE8ztdKBumpatiu?=
 =?us-ascii?Q?djUPd6Rfo+eoXLz4m9Mp2ROf30RtmyX+eBYkKutdU2Dl2tIFEEKt0KbLUFbp?=
 =?us-ascii?Q?GcsDvC/vCTqZ9nDi+SHc5Po3uKDUTMfg38tTstQin0GB1G0xKq2uKRuhlIXC?=
 =?us-ascii?Q?P5R7pawCT+I9kRzMeBRaRKZXBlbaGBZbNke+Oyt+Cqyczk5y2dKAO66S9Do5?=
 =?us-ascii?Q?hUuN7wJKFmTX3XUo6UcJW4TK5Fp6szxSaNac4cdY1meXYt3RQBxw/XL+nTbI?=
 =?us-ascii?Q?zcFyAnSQJ/l+OAg6RPxTFqOl2wh8slbE2m+M3JNSzgAX/cWzCcqpL+Sht7nR?=
 =?us-ascii?Q?Sdd0w9kBIxLFUWCj/LcukOZe3JmqqJNCPbafFrE04HgD7SFHpQaLfxiWOC2H?=
 =?us-ascii?Q?ljhXjQQSg9OHY2fkrJZg4YU3sQNbfw8M9pchmv3Bf7dxJhcBx6+UKYFIa2Ay?=
 =?us-ascii?Q?0uU5A45tDNlq/CTaS5F3hUmJOURqQpjxM0kFvMuljaB9VVPTo6nvhj8rwRcd?=
 =?us-ascii?Q?gIBDJBDVeKO4CnEZmHbxtbNxCrQlHCce4w40+pfDAMyoLY8tzqGkIGz0x887?=
 =?us-ascii?Q?ImGy8p7OpgGhdGQEUFY4zxZ29JpW5znjoTQV5uSAcL1TYAOVuQrECchtFhON?=
 =?us-ascii?Q?4VHOwE126ncqPNg80Ztkrb79vI2H42Mz/7YZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:29.7929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9b83c6-1f99-41d1-616f-08ddd644ee38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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

This will help on validating the userq input args, and
rejecting for the invalid userq request at the IOCTLs
first place.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 81 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 --
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 295e7186e156..7f9dfeae4322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -359,27 +359,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
-	/* Usermode queues are only supported for GFX IP as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
-	    args->in.ip_type != AMDGPU_HW_IP_DMA &&
-	    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
-		drm_file_err(uq_mgr->file, "Usermode queue doesn't support IP type %u\n",
-			     args->in.ip_type);
-		return -EINVAL;
-	}
-
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
 
-	if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
-	    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
-	    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
-	    !amdgpu_is_tmz(adev)) {
-		drm_file_err(uq_mgr->file, "Secure only supported on GFX/Compute queues\n");
-		return -EINVAL;
-	}
-
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
@@ -485,22 +468,45 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
-int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
-		       struct drm_file *filp)
+static int amdgpu_userq_input_args_validate(struct drm_device *dev,
+					union drm_amdgpu_userq *args,
+					struct drm_file *filp)
 {
-	union drm_amdgpu_userq *args = data;
-	int r;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
 		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
 				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
 			return -EINVAL;
-		r = amdgpu_userq_create(filp, args);
-		if (r)
-			drm_file_err(filp, "Failed to create usermode queue\n");
-		break;
+		/* Usermode queues are only supported for GFX IP as of now */
+		if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
+		    args->in.ip_type != AMDGPU_HW_IP_DMA &&
+		    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
+			drm_file_err(filp, "Usermode queue doesn't support IP type %u\n",
+				     args->in.ip_type);
+			return -EINVAL;
+		}
+
+		if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
+		    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
+		    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
+		    !amdgpu_is_tmz(adev)) {
+			drm_file_err(filp, "Secure only supported on GFX/Compute queues\n");
+			return -EINVAL;
+		}
 
+		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
+		    args->in.queue_va == 0 ||
+		    args->in.queue_size == 0) {
+			drm_file_err(filp, "invalidate userq queue va or size\n");
+			return -EINVAL;
+		}
+		if (!args->in.wptr_va || !args->in.rptr_va) {
+			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
+			return -EINVAL;
+		}
+		break;
 	case AMDGPU_USERQ_OP_FREE:
 		if (args->in.ip_type ||
 		    args->in.doorbell_handle ||
@@ -514,6 +520,31 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		    args->in.mqd ||
 		    args->in.mqd_size)
 			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+	union drm_amdgpu_userq *args = data;
+	int r;
+
+	if (amdgpu_userq_input_args_validate(dev, args, filp) < 0)
+		return -EINVAL;
+
+	switch (args->in.op) {
+	case AMDGPU_USERQ_OP_CREATE:
+		r = amdgpu_userq_create(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to create usermode queue\n");
+		break;
+
+	case AMDGPU_USERQ_OP_FREE:
 		r = amdgpu_userq_destroy(filp, args->in.queue_id);
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..1457fb49a794 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -215,13 +215,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		return -ENOMEM;
 	}
 
-	if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
-	    !mqd_user->queue_va || mqd_user->queue_size == 0) {
-		DRM_ERROR("Invalid MQD parameters for userqueue\n");
-		r = -EINVAL;
-		goto free_props;
-	}
-
 	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
 	if (r) {
 		DRM_ERROR("Failed to create MQD object for userqueue\n");
-- 
2.34.1

