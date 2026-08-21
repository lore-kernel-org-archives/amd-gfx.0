Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD90C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE6210F374;
	Fri, 21 Aug 2026 16:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mawTrAIv";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DF810F373
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vkqqy2gnn77MbVInEnKWfNsBPAdF8owvsAom6f4DlusJLPMTrhGYDQuBvBaNhvwUbYQZ2ACwUesm26IDmjkPmE2CxIXonfRejc0GXHxIhYZCyGAVUK/NXJv6S+Qt7fqqYlm9pWBV/ljfU5bkqM+YNijvQ7/Evwr86Rier38HaDBbQjo8vvqm9tt1n7F1qPw9/Jvpr0EQby6Eg1H47ezBxRSTkj4TAofjnZX+YI5TMWGv6NeCuCTiS3qVpbuTQnE7uFCEAj+25s23DtIWvvU9ImW+NTbpSnSgzsgV5eMhmcqxVbRKpEeQMh1xzFMVDVs0ZVIWbvlp+qiHhmbNtamyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5fB3I5C/41kwWNRvYNWzWOGmFBkqSr4l7aWdLng31M=;
 b=vNY3tkIx9aXf8Y5ZYy/0uEW22QBn3dMTlNHfRQUGdB1pptAmielnvyHmv3kQxq9S6Pcu7G355Kjoa3NCbtoxhGqvT48k02i6YCXD/e6xrnU265G/FEUMBKGpTxpfP8wYjY6NjM8qrNFnoayqzSa8jIF8jf7ynsQ2wyg/95rARo6VYVyQmCgnFCXHMtsERKBfcLBQ8rlSr9S33k2t2VKQy2lwLjnOOUkWavLX1Ft7HXxF3tr9RhEMiyhewMY96UHWfKr4w69IbV0Pzm7EwdpIEnpmKgfq5wf1PcfYUqYtGhQa0XIQO/U8slOw8sR+i5D7ECw2+tmx7LvOx9Af7Lm4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5fB3I5C/41kwWNRvYNWzWOGmFBkqSr4l7aWdLng31M=;
 b=mawTrAIvsxqgSdPIdwB7RHs2Ud12vOLxlz20v3vafHZ927f/JqGWevJRbTorQxgals5LIbnEDZKNp8ak+FioMDvmRELcrjMKMySqT6BePHPL6tGTEtXfhzZKRwbBeqLsE6fqXL0YfTKb8MWhi0QkLrRK2C8wzcIyaq4dKn5TUEA=
Received: from SA1P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::23)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:12:58 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::86) by SA1P222CA0014.outlook.office365.com
 (2603:10b6:806:22c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:12:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:12:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:12:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: enable RAS on psp v15_0_8
Date: Fri, 21 Aug 2026 12:12:32 -0400
Message-ID: <20260821161232.753638-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161232.753638-1-alexander.deucher@amd.com>
References: <20260821161232.753638-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c73f853-f92a-42e5-3acf-08deff9f112a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: KRd+dMfI05bmFMYUAjvqJBk13/q0KSkm/PINSnnsUOSf8Jmig5s9odZ4El+/7k9OBwA4NeB/fGysiNe+jZdOX85ynd0OX4oc4axznwZmZVhyN7D3ogitSU7wDGcHQASCzNJk2HJrodlmwpvDFBfa71s9TNFnKFIdL5zxn7wEMvz65kZwsESDKy5hea4yXsm5fxRFHRxFw701dgYx9RS+0cL+9XqVJhbSSik89bhg0599Puh8djduDDCUbXnGB0tKIYwRLoDqTmpZZ+tclJL7FWoPxAMSUeLTVovW0Ky2HjDPNznkCsAldlDiAo3uatvLYjLQbtI1bhsLoLrx8Nb/rIaq6fzG5icubVQMG/4WOsLL79KmYxab4DK5GHUPFhX1BXwONjh85OKEIpkaY3eXpLgrgbNd/0DKdeSXxHVT4KGU9Lw/EHCyLKgj2s/OhLmmgoAE5kM7WrS4asdfJ9yamEqlg5M50GhmXcPrr1NV5c1PawMJdEL78nkYBvzTasiSFNvgHU6M8Nm+PH41fqnCcgNcmGU1Si2w9Q2twvyYHdiedvCgtja53TjAP9WiyDVFGqyKOTrrUnrDotNKYs4Z+JMtZIMazRHZdoKJaQ5QrtYCUbtdm88v0hTCAFM5rgD6xJ5+eJHxpD4bdr50LSc73LvOP4fEY95jPA2hmG5El11slTHdrdsWvIkhQZ1TpfUyid/iEweL5Cfn/K/v/inoEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /u4SGxEf+YFsqablMSfn3Wu7UYJHGITK2nj/tnsiRimZkcJc2PzqWyXW9HdIgE6Djh0kjnJGFDr7Bb86NvU8EAC4gob92pQrfOwAS1F/BQpwbxGD3U3x/4+zK6IvXxEmUu3SeP4B4Bv1VxWQ6hSf8L80O8uzlbrol6XF1k7isF4LGQT2Vt/lzwpf4uX9jD2vUVEZeRz43fGUKB+RBvPz7hFuWOwHwc8feGvuLchoMlKy7Yel8fIGw3A/YO/c+/DQVsJ0RopNU849UNNHWqTLYsI+GbWcNH5We4IRKeC5nBuRSmu3YKlIWmTFAGackgMuAMkO17XcEyHyBpDrsMAgVkptoEs+jKGNhTKx1Aj6bh5ROgT+RZUA+vFYLj9YUG7j0RL6UJcYNPlT+uVuwtVOJaALmxXmWKYYQqJ7fifLepnemX3k6f12lBwSmqd611qj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:12:57.3543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c73f853-f92a-42e5-3acf-08deff9f112a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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

From: Candice Li <candice.li@amd.com>

Enable psp v15_0_8 RAS support.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4b19db024a049..3f3aa44921ab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3329,6 +3329,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 14):
 		case IP_VERSION(13, 0, 15):
 		case IP_VERSION(14, 0, 3):
+		case IP_VERSION(15, 0, 8):
 			return true;
 		default:
 			return false;
-- 
2.55.0

