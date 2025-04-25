Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF0C369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96C410E342;
	Fri, 25 Apr 2025 18:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OqhnQctk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64EB910E342
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGi87+u3dkEciCBmvkIAQ10YXTAzXTWMaq53XTFhcfqVkVRJypNdWVJu03cGoym/8LCdDqsf9pCxooal1bpper5PIfhq+XzvGB2RNd1h4vFXrju7MN3YkXNqTBA6NoeJ1O2z9Eu1VG9ipYWvQ+xzcUowqNk6L/NoILRoIt8Gy4bru9L4UNjxempoBfuyL+mFuSCtOv3Pc6vyESEDu/u09qRYb5gW4JlTAFekZNk5HgstfaNutCn2M+gozLPtQTFJgGs0yYqr7kRhGho07Y99ROoYdfjxCaK7tDBf+OcXoDOHJVLqAcWFhpkv9c4ANTk5YE2cfNoK6vKnHSqQcVf66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y55V9D8Ho+V/0tpmlqvY9BV7qb+rB6AeCKCsJdIcmk=;
 b=Jj8GaXboyK59KAplWT5vH/YgzelyOjs/+eO0UDcFAnbYExG5CLNzHLRgMeqx247tP2JVJxe/nk8UXyj4yQfPwJWrDJoc5mJke4ePOAY06e8o6ywV/efjcxRHOjLXPkUn3gkXX+Ez3b1g/sbD/chXhVdmC9S5nFa5EH3i2iwYWIgGWs6sUTOYxSXaI5BdsR6+LPh3/QXQltd4zTY6bsJDl7uiOm9q1ap6bv2SLCaQrUlcDPvWXuVGlQ3qZAMKl6DEymlBQQyoxaLtdbHY8rOPH3wJd5gaplLAUzkHGgLu7VH4H5XPBeo0UXLrup98EJwnM6fEEqVHp/PktLDbEpcEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y55V9D8Ho+V/0tpmlqvY9BV7qb+rB6AeCKCsJdIcmk=;
 b=OqhnQctkS4mtsfgY+bR/ZJ178jt7sA5IpAhBEb+Qun/bUmeafiAXOeGTHsCSMkGw3HN8bY6mQBbk1+b4F2EoZNp9MgpMciICW5KozMT+BUEVPOs1AkSSlos8i3bQiNGmSMOw28w1i/kPXtOckrEGDQyeZ0NWulW1FuxBF5pH8a0=
Received: from LV3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::8)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:34:45 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::96) by LV3P220CA0029.outlook.office365.com
 (2603:10b6:408:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Fri,
 25 Apr 2025 18:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:34:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:34:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: take the userq_mgr lock in enforce
 isolation
Date: Fri, 25 Apr 2025 14:34:28 -0400
Message-ID: <20250425183428.162862-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183428.162862-1-alexander.deucher@amd.com>
References: <20250425183428.162862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b49157-661a-4ad8-a3ca-08dd8427da07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FJ3FM3xrJAGBHv1fQz5dNKepjVOXwzoiwPScx0GA5EDmm725bP14TgHVQ0Qo?=
 =?us-ascii?Q?W/bdzfsk6mwq6putrF8KZHd1IJMQPyrp4+93N6pVE/haCne2coPYt6H2pWcZ?=
 =?us-ascii?Q?/n3vz27o1GIsImnSvGI6jSiivH17sSTL7B65vZ/7IU23CeRz4w+Gfw3uwLkH?=
 =?us-ascii?Q?M7eyRXA1DK8k7A91BfxOXxjE36ZKJnskBFegsbWYUmA/IK4L9bXwgIgdx4tV?=
 =?us-ascii?Q?O0yO5tg/1oC9Kt+xQjD4xhKWK1aVE7+VOC8ipypFMv/9ZGaeAf6T8N0V71vu?=
 =?us-ascii?Q?QSToV7F+9+Uaw+mjJUUB2Pyh082Rkq8+KNkjjs3jK4nOKVhev5s5A+mPJ4W+?=
 =?us-ascii?Q?dmdE33OAlW8fMoingNwwORXUoRkrFcLSCYibHpmdUNrMNuEIpyKZAeL5GC7G?=
 =?us-ascii?Q?518jlGZk1SklhEcG/w6u9Id62NrNVxYvp3k04Qtliys4oaUtVy8ebnWu+9LS?=
 =?us-ascii?Q?9NyMyG56MNfWrNDXR3mJdMlBpnhTzwFXqnEiFOP/nNmcxOsC5tQ//zoYLVE3?=
 =?us-ascii?Q?fCy3u56h5dFzW4u5gt9aA7rFlJFytcWH8uH08EVEQx+Y8LIuHpK/sSe5t0Mq?=
 =?us-ascii?Q?jaKvodHozY0W2BkESj5rnaXImK7oCvFGjO3aPzY4mDW/D52XfGTnv07/pPTP?=
 =?us-ascii?Q?83zrDL3y7Yyvcj/ecDBJ6Xw169NnniZbvzD//cLZoEdTC0xVkBE31dOCSDv/?=
 =?us-ascii?Q?IgRiuNzvtxV6h+z497nqIxupG7oIHjvWs4/yAooMjBjRfvqxYifX1A0m3+RN?=
 =?us-ascii?Q?2wIpfsFe/znYySw0+hUWCSsGdIuBSIIwCCRhPxdZhP4c/NfRJh8FYw77586N?=
 =?us-ascii?Q?dbWVzCsPx9leBkc0N36oN3wuC71IIM8ldwl8NkzyuB0el2V+mhESlTwtJxnB?=
 =?us-ascii?Q?UkXKOHlh5DlK3Ox+TeD8YLq8OxDJIKyVjQY1WT0xCnyLJ0A0fgysGv1jhhTb?=
 =?us-ascii?Q?eKHvJ6ogRUksZpUm5ggBNAWL7CXtKv9zEW1SbS/P/jrR5kIyBs+Ibskt007b?=
 =?us-ascii?Q?g3zLrA5hycdR2dtqugYkG1o7AMXOh/2fvq5g6p/9ppkd69mFse8OS3iRUZLV?=
 =?us-ascii?Q?oM2ueDbyQ7EIAUOrod2oxVuWg4/NpaGxrkOscPOr679qNhRWH57AT5ZTZqfJ?=
 =?us-ascii?Q?wpSX+IROEkPsmQP0C46r9fAyPNZLlighKSYrgKh8RXkjjf57ttyKW9ljCxIp?=
 =?us-ascii?Q?sbtDS9BRemR5TY37TBqwEk2oZLn7VqQ3njCJAjVwZl2zcxAAPcukiYAvc/6I?=
 =?us-ascii?Q?ZWm7yq+wT9bgXgIOZHVgYaruzQwVu3KzL0jpOcK2+ium6AUuR99uRBfAxXf1?=
 =?us-ascii?Q?HSZzkQ1mO2+IiLxcDlDNYOVibnPOAhQQ8kW0Q1MwlEH8vNFm2BdaM51AfGAW?=
 =?us-ascii?Q?2k1ZDcv3lJCwFI45G/fIS0IrVim0wRGJuwcLWLyXCnxa93U4anQtQVgyZNFE?=
 =?us-ascii?Q?VHVRNIsbb6F0Zc6bLdCU4hBkBsJFlEvwWSCbS2AxWzSWjmwkkbqRa0APYGlB?=
 =?us-ascii?Q?oJGjXpzyOWoS1bE633hIn5IplCKRNqrtZoKd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:34:45.2690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b49157-661a-4ad8-a3ca-08dd8427da07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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

Add the missing locking.

Fixes: 94976e7e5ede ("drm/amdgpu/userq: add helpers to start/stop scheduling")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1fa9d2be87f39..afbe01149ed3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -865,6 +865,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	adev->userq_halt_for_enforce_isolation = true;
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
+		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
@@ -874,6 +875,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 					ret = r;
 			}
 		}
+		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
@@ -897,6 +899,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 		dev_warn(adev->dev, "userq scheduling already started!\n");
 	adev->userq_halt_for_enforce_isolation = false;
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
@@ -906,6 +909,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 					ret = r;
 			}
 		}
+		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
-- 
2.49.0

