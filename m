Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA1C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 18:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D4F10E3E1;
	Thu, 23 Jul 2026 18:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I68KQrcE";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C7510E3E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 18:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0ZsArjne9L1gLfZi+HuLXBxRqECq4GWoge3ff2eFs+3ju+fxP9X2zi1q/DqFGkAEq5xyZwqJh/mXg5uKRJep14cEXSlS6GURNtfz7EmZFxfq3I28ldB5o9SVo0womwE1HYKknzD/qYXDcprhPpIT2Jbzbzy3mQkMBXsoYd3QKPKLQiDtT63p7+vHqSjCyf0ph3VWoCDA9qRTRYT/LWsvkJhXcy5nFdhoH/xdRnKEhQmnmXG9zMzCqT3uq/JhNAoga2a8fdpZN0wxWdeqNuY0o23/uQwJOzk3BssLo67S3nthNzUfM2KEvPkXSdL1tR9zm7HKl75P6scu+RJw9S1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bv1DwR3bIixCocOkQ0Bw14WQsNua7U4JXTL0QDUhcE=;
 b=Q83Q5TqFcXfT14Cl6Bu0r9bUsEmLdENJbZtHy9TyzdIWox9qEk2zmdoawOTHSqc/ptiC0V5C4J/FcPZ5ErxETupHhjRtjON3/6fI8pTg9zInELsf1bScHGUSG/C3exC9l/KlGcVCk24Bi+H+L5G24O4RR5sYuPi9EwkH23gpX4NZhUhUpDuBPkpAryykJSdP16jAN5QE5tHrOlHHYXXTIPJ2Kutfz74YWP/R6x5aWt0KDDaeN1n0kj1lM3tCY0D2JzKRh2Dv1UO+VqkJURTmWD2rncPTbWVmJRe990CWkqduRAc7afMZXfXKh8VL2Al3UUblmsyh34VWUfVe+zyNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bv1DwR3bIixCocOkQ0Bw14WQsNua7U4JXTL0QDUhcE=;
 b=I68KQrcE+YX+kVPvKx1lZ1xgAHBSJWm4v+HDqwrzzY7n7k6U1OFlPD6PFpEYhSE+zMssblPE4rGpnasMxOsGsxO9W8QL5qXdUulbeKjIT8+PE9q9eMQV/X0UEhpZAHWNzhtb4celgWyP9AalLpOCJaTtl3qydExtmZj4PJVxHps=
Received: from SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 18:51:04 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::a0) by SJ0PR05CA0131.outlook.office365.com
 (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 18:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 18:51:04 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 13:51:02 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Protect userq create and free fully with mutex
Date: Thu, 23 Jul 2026 14:50:44 -0400
Message-ID: <20260723185046.1239011-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723185046.1239011-1-David.Francis@amd.com>
References: <20260723185046.1239011-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: fecdade8-38d3-41d9-f5e2-08dee8eb5934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ynbS9T09U7WMkraknjyhixzgBOX8ARnWXxChmYTGrU25gwqrTXakwKQ98BqCwuQQ4Dmfyhy3V3IT5SEPnm+juQKTqt09Ah8XsLbGDLkIkYDabY9A/3HS7ki7AJTBC0+wbF9Vp9iJVrgIlBWVlfFcDiY+7fjcBoeoSICQhNtu1AkhUiD10gle29e7yXbX+yfaTTSrCLSM26IvpgpG2SpyBm+2ahrFmq9cFyfdcQh85fzbKUzCJQvjlbVdFc3QASWsIgU74K9h9bcPwHykGoeD3RNolNgUp2UbfqbwvF2tqqmt+i+LluTgJgRwoZYPa/y3Xg0FAVBCQr0eOH3qYCnNs68CGRRqEsGOsGZaUg1BASQ46y8Zqk+dYsIrx/LsVWfHXjvWBkyGwaW5lpo+V7dyPK7KkvjVmsKReC0+3h4c3WjAf7xlbyza40q0rfXlGGLINy0dWSO1e5X5dXAf1/wAGEDbz2nEztIF0Nj2uMC8CX7kFfQFfIL6PzGqOLNnhl8Bt3Z9s5FjG07XGzEQzOQkVrFepjXqKVMPn2cn+vSzoavt+cRgTG60LSOKdw+qh9cjmnNE+6mEsHzMCDceDcnT4m/8vqJkqs1x/vIIzlXqMAXr/E3xPG3wG7SFl6GwFdOf9DvJ0AGVDH7PWOg8LFIYTk7Rrq3w3/TiQpDUaWm4mvej1iFg4r3afNCnXPEuhruZ/OupqHt6byTIlNHhAPSaNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nChTOrzuPO18OsRPuNTsNMkCQJM5OcmHi2YG1geIVBUU04izs+Qb2qjWqakl9tnjLRc67J1EgEtiEJ6EHuPMQLMmCkBDVHiLSA/aaJdY9N0yntoKeyXutNO1WNaaxUyDYv2lfALK8BordJBvvAniYCEu+07UQ9F0tC4tIKeeoJa2lOPyYqD4bZER2x8mqydXW5RcZNzMlejsdW7FkaMhjJKCWroLHDtZkZ6vjAsbM3/S+VD7p+CSHIrqynxUymAqyUkymx/UjjInuaJtYggg1M89wzU5Y67tdUXh7ZzBmVu8HY5pwDCkc5gDVYFUIrH35gzmuadvvmS0BPF3KNmzVmrfCbEZ0GQA1dJUhgsOL2MeHhcsk3qb9a/j1H5uqXB2ixSx0UCWeTB/YmVO8yFL1hImibAUlB5yMwJhwmyRtCvjbu3EuZoxXepyrLdg1YR9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:51:04.4113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fecdade8-38d3-41d9-f5e2-08dee8eb5934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
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

amdgpu userq has a userq_mutex meant to protect the list of userqs
and their state.

The CREATE option of the USERQ ioctl released the lock before
performing a last xa_alloc, relying on the xa lock to avoid
races.

The FREE option of the same ioctl didn't use the lock at all.

Acquire and hold the lock in both these cases, to ensure
correct serialization of these ioctl options against each other
and against future ioctl options.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3fe10d6af757..cfee7466ef44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -748,11 +748,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
-	mutex_unlock(&uq_mgr->userq_mutex);
-
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
 		     GFP_KERNEL);
+
+	mutex_unlock(&uq_mgr->userq_mutex);
 	if (r) {
 		/*
 		 * This drops the last reference which should take care of
@@ -890,18 +890,17 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
-
-	case AMDGPU_USERQ_OP_FREE: {
+	case AMDGPU_USERQ_OP_FREE:
+		mutex_lock(&fpriv->userq_mgr.userq_mutex);
 		xa_lock(&fpriv->userq_mgr.userq_xa);
 		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
 		xa_unlock(&fpriv->userq_mgr.userq_xa);
+		mutex_unlock(&fpriv->userq_mgr.userq_mutex);
 		if (!queue)
 			return -ENOENT;
 
 		amdgpu_userq_put(queue);
 		break;
-	}
-
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
-- 
2.34.1

