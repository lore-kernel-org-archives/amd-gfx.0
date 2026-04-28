Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BEAFF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C524410EAEC;
	Tue, 28 Apr 2026 10:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nPxiiHlW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E9310EAEC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkvqpYYx4QhRPPvqn4fvmsGDRxS9KpjQYTTLR4kgIcResDzrZ2PACVC/lPWYhVBOzyrpSrcioU1tqsuC+MH9iaT7xML9gqXQPNcxNeg2KNIV7cpHkQGMBWTlXRi1UgpGANlqMcIahLU238F6+/lJKmibj6ia/Fo3AL73Dkuvop+xl5HKjmyaza8LHJkENNq6LxwpjmvrQXrxWRxEe5NTxBrdkcxoEshbc/p1NHNiuV18hNhwsKYfpsUeNG888KuI1KIfX71fCH1EYQiTqDIrNk/eT+X9DZ/5TBt/q6xYeJ5ZH78Qp7+qJaCnJcc7+cqcNDbUhmpPhAPZ2IScAKQDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTt4jMlzvvrmlfQ7BVaC4MAwgDpVCUKe+DHWLFszhYE=;
 b=L7inCP9yuxlWR6YZHnFPNodyJhRqSIoAUPUVbnk+djcQPrmdZiQTr1a+QInR5rlDfAYulvEuZ9g4W6BZdaeVgQ+Dt2a7ZQRajt00gnIjD/zeJ8kgN+lBtY7PucbfTeKidk5Hu0LSB+UbFlkvOK5fYMk2mwiUxqXLKokWhCWMDr3pVhaluCJSDUdVzjeR7QQyPqd0WB/Q6B14ZdjFw83Y33c7TnMM7NytRniE/WpRR6DcbqIRrYzvFnCc8s8AteRcreU0ukux1TQW9UDbnJyETX3bYTyr3gvxZoOYNWjU4Sf3ZbVRBxhwXUVTmZR9+Cjh1He2pP58VYFXlA4zqTvr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTt4jMlzvvrmlfQ7BVaC4MAwgDpVCUKe+DHWLFszhYE=;
 b=nPxiiHlW8tfbk4RY3DiomWvpM0HQtNjyi4K5y+c/2EPr4od78eHy2no4gihYhdi1MBsx3WHLtcNFrNuTcxKR+UEd9GgX1sxBysHecwPS63uLwDfA9BnvK74ZdPSZ2iudPdBGK9e5734aJxVBneNuoBexSN5K76zIHmA7LtBMSOU=
Received: from CH0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:610:11a::16)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 10:02:57 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::31) by CH0PR03CA0342.outlook.office365.com
 (2603:10b6:610:11a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:02:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:02:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 03:02:55 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:02:48 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 03/11] drm/amdgpu/sdma7: register SDMA UMQ doorbell pool
Date: Tue, 28 Apr 2026 17:58:44 +0800
Message-ID: <20260428100239.1609179-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea0c7d6-9fd7-4686-f22e-08dea50d51aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pfm93BsNeKwWSAkXcW2AL1I7FC36vJKdIfCcA+Jul8KZ59qKgs4PiFfxXyerkwIdJuNG6z9R7snNQf9onUuLM+pXr4PupFwDf3iMAXB8fkRIabwPxcUl53qKMfFQrZDAMLzFnYbm1VksV6CSf8N1/oxE2qvRuXndSK13LyJoUQgPt3HDGbUYvishqyyqgRD7N6L5WHd02WURQUkbhdBQ/mLiDNxlAHU8WZWS3QL2EmqQsF1uW27ucNltHv3GROKynPR6+CWexxuzDcl5nMFl6+n6bNOqVkdao0OwfOmXpSLpoRVXn+nhoPmdksvyDfVEROzhENWdZaUn6xRQA5RiIXIphLlZP6pUfjafU0JTDDN70SODdcQPTAaSNtJZ5AGu3bZqz9aRqycx24bzwCY44xKKJSaoZSbg294K7ONx1K8wkx30QztvjKAPyNiCRB17pvvfyyR+76bP1TsUlFMj+7r0uvIBzeZ6qqUVI2dZPZy437/x6MX3VHkOX0vk3CfnDyIvPucDmk9y0rBW63Ng/1/Mi6eINrmCPD5YThRDq3gs2kN/DHc57p81dS+STLjlGXP56DyhKjTzzu/VkV/wLp3AUzawllMv7tWMvWljTbaKbxSA0wgnKR3aVGHyFjEWM6W2skMGwQMzOje5Tqm20gxQGy4tMTgyVSoU9Lr/4pl2Kg49DvyIdkqVGxwqXjsxY8YRRHwbxgnO9Vi2CgEnrTnZhbYlPitP4cpQhfpveyleHUx6UJu/aQYF0ebe7iPdYERzaCw5W1lS3r3wZGArcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R8NXzN1SKiSHVhGnOVBCD4ynGJze60ln3nDL/Quuw2/eH8b2ZXDxE0ETGQxUFsUDH+ZsQn7DbgULRBXj6ekd62v8afQoHReRYxaAMBiDw1gV2V4c+9aEzrxsOiTWiuMX9cjuXt3ocLhYHw2JDaptozLGlB4mJa4AO7KlNjVyiHZRy5ELlqTU2+sIK/1HSxjL9F7MByyzXMxsjl9Ho5jRu1k7KgZeWKtnREcE7MevIK+Qww2pMLfHVxjQFW+x+XN0XPfJCqVlAP/K+LZ0dfya5jJshuHtYTxn3AxZzC9+Hs8Uobw76i1EuJFFdW8T4LlrL+EeinnWKkNIqd6tuZJbWWOKXGC9qBEjumANia6kA+nTgUfh1FYmasOPqDIVj2O1bOdxiPuoYWLNQxfVb0I+ViDg9Y0wmRc1HYnT+EeyFWRZRMuUAxHgfU84TRKpQL2U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:02:55.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea0c7d6-9fd7-4686-f22e-08dea50d51aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Call amdgpu_sdma_userq_doorbell_init() at sw_init time (gated on
userq_funcs[AMDGPU_HW_IP_DMA] being set so we only run on chips that
actually expose SDMA UMQs) and amdgpu_sdma_userq_doorbell_fini() at
sw_fini, so SDMA usermode queues get doorbells from the
firmware-managed NBIO routable window.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 85d98a0e1bff..5f6c51ba7ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1378,6 +1378,14 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	/*
+	 * Init the SDMA usermode-queue doorbell pool inside the firmware-
+	 * managed NBIO S2A SDMA decode window so user SDMA UMQs get
+	 * doorbells that are actually routable to the SDMA back-end.
+	 */
+	if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
+		amdgpu_sdma_userq_doorbell_init(adev);
+
 	return r;
 }
 
@@ -1389,6 +1397,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_userq_doorbell_fini(adev);
 	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
-- 
2.49.0

