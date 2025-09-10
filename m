Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ACECA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D43010E8F1;
	Wed, 10 Sep 2025 11:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtmJCRqk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA55E10E8EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNi3dOfhp3G/FKYeygYlsBr8BJB1yqQFdqfLTu/PCK03NHsgv3UM9FwVgm3I9dZY3aH7ZkT6H6m+5lg2j1GdXAY6dAc85fh6B4Y9R9LXzJZDAN1ms8uS6MLngL1jY5f9f7QLS7kg7c16Bxse/TXUXE7LOcd13Jm4EzlEijR+oGC/Dvlgcg1W88aB6h1RdepFzjScCZC1f95y5/BeGFPkLE0U09HnS4vjkxV94vrfRPfxDOJLoqozK7YMQC9D0xskZ8+5KWlovGBir1RYcDoKlNL+ryNKtFrgS7ejjMb22BkqFbsxd4OMH2RCtLACwtyy2fe61hWLJv5VLpb0FbVWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mII1A0tRanhDbI1ZjERp4ah9hgCT5ItzR3FekJD+bSg=;
 b=XXJsIFEQps7cuKf3KF0s6Vp+gr7V1GvBd4jgrtXXgkRXRMpxbc70H3HKB/ux7LOUiyC+CMcpR+tvLOB1bX3MCi5XmvznIXIJ1Z/5qf+TSoEfexhlOggSIctpteUG/fP0DJNg+VKoGGEUC9eyefQ2IRb03MAM4zjCOGMN1L2pd0mtBxDzO7YnIf7KHOsCf+IKP6LPi0b7y4+VK9LfwacJV8kuVK94pLVHbdGqxUXL2nE3q3gPZX4QdOcVTCugvVeMsFUTflWEQVr1cIBpRFZjD/GtuArwtizitzhRYK+hjKUFoK/VPhpurCb3ntmNE655FUMpShq5gswx1qOEvv1HRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mII1A0tRanhDbI1ZjERp4ah9hgCT5ItzR3FekJD+bSg=;
 b=PtmJCRqkhBUtUCimZpOTjGJ9wJsqECT3b1FQso0vKMigL2KvQvQBzboFD5GKdGHApunh1twvRQEj6yK58dOcJeI/7pQPS1Tfv0JCQxRijCHPr4DpbpW9vz5692erDIP7UcuRHRR1pRwl5XjCQgY09gZcD9anvPe97ph/Mqu4iWE=
Received: from CH0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::6) by
 BN7PPF49208036B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cf)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:48 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::ba) by CH0P220CA0008.outlook.office365.com
 (2603:10b6:610:ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:46 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/userq: extend userq state
Date: Wed, 10 Sep 2025 19:37:26 +0800
Message-ID: <20250910113731.2688320-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a43eb6b-89e7-4832-7f73-08ddf05e7781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DDnRmaR6+UVm/wZc8zxcfFKJVlLMkpFdqWnX/pNnmplx20oRhqIp8o5U1iOV?=
 =?us-ascii?Q?Oxt/Aw81+NcAClhI/amMihsVNskzrp5rlL+hvMX2xNIBoU+pnBW4KKhpFjm8?=
 =?us-ascii?Q?nqRIM1g92+5gAaRzGOZy+ccNWrZ8eUXKaPB4xUFHH8IkE0E1Dk81WOA7DUwF?=
 =?us-ascii?Q?HE3MhUg2xegyuePp5U/cAPY/bN7pDs7eczPUX5uyn15sm1mRBqOb85RudfgD?=
 =?us-ascii?Q?I9KJsQY1kZU4zDW5iybo+JuLcLvq/IWyqQhUVI41nwFuicopY5v9a17/xE+E?=
 =?us-ascii?Q?oDO3PgmQuthJpJj2s1EbzewcdSbya64BSia5L5M+1G4pllMU0yKduWm6uAna?=
 =?us-ascii?Q?Tmrm7chvE0xikGZQvbShGeY3HtkjgILKjQUI4Bu4wuIIbU+LWYtbFzms+e2L?=
 =?us-ascii?Q?ITMSzqw4cWA6dqxDSFAIFRIgCGXEgspC6wckcqkL8Nyu3kibUXaIYeNEFHXD?=
 =?us-ascii?Q?pTvVc6VepJdc0tQUpLwpIqVfO4xH9KlJyEJVlM3P/12P9VzJu0IJeLK+WWMe?=
 =?us-ascii?Q?I7QI6qTGPrNHhPFSLyblZ1po9VB8yb5U8EIGbPCSHpPXVNoXiBcdmf6Xgrrv?=
 =?us-ascii?Q?vdbyihxmzaLIn+I0oOcBnFj4Z8i4ySLY7If0OrJ0iNJosXXTqa4AJOhwEkmD?=
 =?us-ascii?Q?DiTsBWBDu6h+zHkC8vjsYMSmxwz7JE3BDaOSU1bjePP1Zx+uDtKbGpEEoZ9w?=
 =?us-ascii?Q?TAZNvaxbQK15TKikQXw1DIIOakmpLDQH+/ODKOf967le4/SYQqQSDtsBd5iN?=
 =?us-ascii?Q?P4p1g3snPz4BtfXrb/mIPLphgsMW4oEBXG9YvtBoMFPVGymqSPyY5sjl5bDx?=
 =?us-ascii?Q?Fu0PO4iZEmyzuEof5J75ebZItfT2qCdLz6Sy/86z9+3WoLUjwuAx1oZn6nnf?=
 =?us-ascii?Q?IshZ3v7peFbNRfQmURVecsG6UetzCo2oculfHT3gYyDqfDOXpePYNYO5j75j?=
 =?us-ascii?Q?mbq0D9QXM13l0B778x/kxucxSvK68UogbBPgrl8S898iDvaBtZEcxVMk1+9O?=
 =?us-ascii?Q?R1e9ZMnC9dBrgBv2kRK2axiWTngD7BC/fEIq1jCAAae3V2gIJQsmPR6ims+n?=
 =?us-ascii?Q?8b4/5diBczjiskB8ZFZpra5tVAsCIcn4kW9nqZZmpEvvNW5hPcuYlvKKxH++?=
 =?us-ascii?Q?S/bYwdsBP+oczJLpAsQ8mVVdN7+1XAV0WFNiHztjW3h7sJ85OkhqSoHlvgCn?=
 =?us-ascii?Q?kFE4BbYAGhTVvOP12HFNnTJgv2nMUMEMwu4nD7XeSM9ov32SWcn9NowPjP73?=
 =?us-ascii?Q?jPm+PWgvt8/UiyaqSIFk+JPT1bYz4OkccINTV876TSgEuK1t/vo5bxdM0/OR?=
 =?us-ascii?Q?LOGZCpxGO8W574rYMIQTYoq8h4xhKyFS+rDpFIf7icsCU2zPUTL3b3+hkHcB?=
 =?us-ascii?Q?q+YYJB/oeTNw46xTWI5TGIMiqnIsE02rW4oBepzeUppv29iDGZG2u+oMNwsH?=
 =?us-ascii?Q?iR4ltI+rf9Y4aQoWNZB2ERZc2adD33RYVYB7fqsit9qUStETfENykT+D8M7R?=
 =?us-ascii?Q?9rBFx9Lc4fv1DYYh0WogUPBY2gI/kUkzY9eV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:47.8505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a43eb6b-89e7-4832-7f73-08ddf05e7781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B
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

Extend the userq state for identifying the
userq invalid cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 83f0ecdaa0b7..ba7be4db5a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -576,6 +576,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 2260b1fb8a22..33a582200dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,7 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

