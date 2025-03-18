Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AE5C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 14:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518A010E4A5;
	Tue, 18 Mar 2025 14:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJG2qVPw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC53810E4A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 14:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8BoSxQOe0Fnh+mCb0B6LPqmq/bX9IJYcFGaj82bPex8t9AYCu7mD/YJaBXh+/1H1+plzRdJuEUAPJlxfUlTZkpSjbkQJ1LDITxs5ENMaZFtn5RVDEZ8dpvasdiX82NQfwW8MXUtfv+5Wq0svd5goX/tSVAGY8eCF/mNXqdYyIHVfPrO53kTjjff7VMfT5aU/WDfs+/jMcmffy9sOzBrCFWFsBSKvNAacoc8WzkSvNlDhHbnP6B9uwGV3965MaOQTG6kVv6YuIekjxMyz3BPCYQncw5x+ZIdA/TF3Bgzxivk/9j9Bc4g59dgJleq2QzNyGrI9lFtxz1lkmL3aqA4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/F4TP0SE2FX3oqkFnkBjqzNnt/oNZTSSOQAmMmaOYM=;
 b=yrXzmN7khzBxnUA2ha9HmH4VZATlcgnucLzsJXJ6nFy+EyJi6plrmKt/B9sgin0nqztLDiBP1vAzvNQbMam6lfodRJACeP6mdA99P4kYGz6Ddlar56psIiIbwu+mERB1lubg7AMMs44eOXatTqMhp1bbDxfRe9d/lpDT/Ycw+8MfO9CCL6Ii1ii7Fuobyg6Fgg0zVzbdv49j0IjkcIemisBBu3a7Hp4eiPt57IKG+WDb/LwKIcdzqGQ07GPkH/eQnMyZUxhk3NLkAtdNPbr20B+S9pPns5KBjWGjGlfAMWtNCozS4Ft+jEMrvsGVRBuKVBfggjQiRC+WUGz+XCDcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/F4TP0SE2FX3oqkFnkBjqzNnt/oNZTSSOQAmMmaOYM=;
 b=JJG2qVPwANnzuZwoRZYCatbGwNaJsZheuoIykf9jyb5/U6GxvFSzzTP2ZTHKPPTyGcrDx3DrMILllNMdwXQi2brMSVe3t0+rNz8K8h64IURb6MH+V0nM5ThjmDAwdURMMZ0IHgFGL7Ac73C6EfZuoShnUIIrLKOe/nAHT7z4MRw=
Received: from DM6PR01CA0028.prod.exchangelabs.com (2603:10b6:5:296::33) by
 DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 14:54:51 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::15) by DM6PR01CA0028.outlook.office365.com
 (2603:10b6:5:296::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 14:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 14:54:51 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Mar 2025 09:54:48 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <shashank.sharma@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: Fix display freezing issue when resizing apps
Date: Tue, 18 Mar 2025 20:24:31 +0530
Message-ID: <20250318145431.28944-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbe6d24-ecd8-4822-7a13-08dd662cd618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QktKVXFWd1ZOOGovSWtmRXd6N3ZhV216NHVNdDZ6YlRCVXZlTTB5dHdFdjFi?=
 =?utf-8?B?SEZlLytYSW5JSWRTUjdPeDl6bS9hTThYelg1dE9YNVQ3eEM4Vmo1czVpT2R0?=
 =?utf-8?B?NHJSeDhZeldSS3RWUHl4RHZ1OTFaZHhYdHFwMjdGTnpDd0RzSUZCZTFBVDlS?=
 =?utf-8?B?U0FGWUFKdE52QTBxQ1pwSzVhS2lVRkh1aGt0T2lreHNhbytSZ0l5a09mcTly?=
 =?utf-8?B?ZEYzOSt3RHFSUDQ0SjlkVnpMTXR4anFlSkRjZFh3ZU15ZzNsdXpjZTJFUlQv?=
 =?utf-8?B?UWphOUM2eGV0L2owMGVYVkJpQTg1K1piRkVRc3N1SStlNVRHMkNVaytEbWVY?=
 =?utf-8?B?bTVIeTRRWTJFNEJJZ0Rxb21WcGtGVE5CZkV0Qlh2RlZkQ2tyRURrcXY3SkVR?=
 =?utf-8?B?ME40STY4Y0Q5eFh1R0g2ZGF4aFJkYWhKZjlZbmhEQU1yZVZyY1Jtek9aWlpD?=
 =?utf-8?B?TmNSdnBRdnlBVUN1d3ZHWktkSFAwV0VHaUVOQVkrR2QyRjg5cFFwSUY0OUF2?=
 =?utf-8?B?MDJ0NW80UUhnTHJGcGY0UTduZ1l0Sm8rMVNTcnkxcnlQTnEwVUlkdjVOZEg0?=
 =?utf-8?B?bkMxTEV4OGh2MmZxVURvUnpQbXhyM1NzOGEzbnhEdWpDSEVSNkV0SlJ0RzIw?=
 =?utf-8?B?M0NJSlI2WHhDWVVnTGYrcG5VZmFoTnovN2xvaWJIZnRMUEkzVTR2TTV0UzVV?=
 =?utf-8?B?STJINEw0RnZCTUlwVER3NGxxaTRZckpYd1RtRXhlYlZObWdmT2NpdlZzeURq?=
 =?utf-8?B?a1JnS0NJbXJzSjhRcDlGRkNqUXBIY29RV2M5bUpMY2xzZzdkUVJzMGV0T0xz?=
 =?utf-8?B?WE53SFc5eVVmNlU4SXJmK1A4dmxQS2xGNUJWay9GalhuMGVraGFLb2NxbWVU?=
 =?utf-8?B?eUp1UnEzTXF3Ky9BaVNFU25nc1BSQW1aWURyRHF0Sm1GaFdrTlVYTmpZWDZx?=
 =?utf-8?B?Wk5TZ0hEVmJzSUFhZk5EOURSKzR4Q1hxaVd3dldyRDFpdU9FRXd6M1R2Znht?=
 =?utf-8?B?bHBuc0JlUFJPS0JHRVBIc1JMRnQ3WG5EUStWeEU5RXRPQWtDYVhzWnlNanhU?=
 =?utf-8?B?RTYzYnRvRlAwWkJ1RlZzeVIyZ29hQXF6c3Z2T0R6QXkwRGJRblZWd0dpS0lZ?=
 =?utf-8?B?bW9OL1NCSVpEcE0vZENJeExCdk44ZkNzckdCTnlDZTFISWFsL3pTQU9aamxk?=
 =?utf-8?B?U3p3Um1qaU5OWVNQc3lTMWxiQzl5ektYT0NRUFBQWDc3c0xZQUZXbGwyM2hY?=
 =?utf-8?B?dEVlNUFILzJtSDFvQ2FGTm01S3o0aTdPZFR0Rlp0MXp2My81ZEJ0bGFROUw4?=
 =?utf-8?B?Mko4ZWhySFFQZ205QUJDMTVnVWUrL1d3bkdrQlhyc2IwTkEvVktoTktYN2s5?=
 =?utf-8?B?VmRPRU9mRUNocFZ4VDQwS1UxSnJGaFkzOTZnR2xDRDdXUEZWY25nQk01WHR0?=
 =?utf-8?B?QmFOWjg5Rkc1aTVqMGk1UzBCbnRaZXRLVURCNmtrMEltK0Y5VjEzRmJremdn?=
 =?utf-8?B?M1VWVXZxeS9LZ2ZndVI1d0N3OHhNb1ZhNUZ0bG0vV2lpYXliaHlUblU2UE5H?=
 =?utf-8?B?VTE3ZXdOM3E3TXFGVGI2ZmNrZDlxNmIxRmdodElWVEhCN0VvMlZOZVNzSmY2?=
 =?utf-8?B?eXdwMVZCZXI2Y3YxajM0dFg0Q1JuZUJWbFNhaTBwRkVsWDVCQ2hoT0EwRzJy?=
 =?utf-8?B?U1l1dS9MenRBSHEyNjdjVUNTdkFQMHFXS093K3NRR1o0cDM5TkZldXV0V0pp?=
 =?utf-8?B?cENvNVkyK2p4T3N3aEl5TnNkK3JzVVdER0RsbFFRNnZmckdXTi84TUFlVUEw?=
 =?utf-8?B?SjJtT1VTbFZQTDY5cjdpNTRHVU5YMTFUa2xRL1MvWTZtQ0xydjJVc2ZEeEtj?=
 =?utf-8?B?M3RPL1NLRXUvaEluZnJzcGx5aFRqRzE5TVFVdHp2QktNUndWTk1uUnBHMm00?=
 =?utf-8?B?cFo2MHVnNy9zZENpenlWdSs3dHNLaGVyTmdYVUcyQmtqMjNrN0s3TXZVcnVP?=
 =?utf-8?Q?yoXp6R6ybXktJ+az94MhMihWwsRkkw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:54:51.2063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbe6d24-ecd8-4822-7a13-08dd662cd618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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

The display is freezing because the amdgpu_userq_wait_ioctl()
is waiting for a non-user queue fence(specifically, the PT update fence).

RootCause:
The resume_work is initiated by both amdgpu_userq_suspend and
amdgpu_userqueue_ensure_ev_fence at same time. The amdgpu_userq_suspend
signals a dma-fence and subsequently triggers the resume_work, which is
intended to replace the existing fence by creating new dma-fence. However,
following this, the amdgpu_userqueue_ensure_ev_fence schedules another
resume_work that generates a new dma-fence, thereby replacing the one
created by amdgpu_userq_suspend. Consequently, the original fence will
never be signaled.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 167951aee502..0075469550b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -52,6 +52,9 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	unsigned long index;
 	int ret;
 
+	if (evf_mgr->ev_fence &&
+	    !dma_fence_is_signaled(&evf_mgr->ev_fence->base))
+		return 0;
 	/*
 	 * Steps to replace eviction fence:
 	 * * lock all objects in exec (caller)
-- 
2.34.1

