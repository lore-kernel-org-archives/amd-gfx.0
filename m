Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3D7C27C44
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 21:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EC4112E30;
	Thu, 30 May 2024 21:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wANeNnfn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12E2112DFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/RvK11xk3MIG+nrSAeAsgYNDN1xaG797bJiG1EFJSNkxRu2p0GXilz6Tnv9Fi2LOaq0zggurWaFCZE+Sb9pnTyjwrr6CI3bxdupPoJRZQMS9YsgAJavEcZcVO1hWY2f6/kv9COG8f4SlUJ2AhRtTmrtP1xm//RP55uWiqPferHQUChhtnnl5N9LnMFLB+AbW7+iVJ7g7KLnQj/jN3XJCvn19wyIbcQICA5PY4H+qW+5tUu9IDf4tj28UhX22dwUGIgu5zuDGQIDIkPpnvnHzIxh+jjWUxsO1kBWW2vCZZSNoKPUBC3bXEpx45av1sQlYjsZPsmoOqTI7NPeD3oMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlgqjIdJ0+IjyKWEH01MTHoYWJgZTd9CVlHOC0BD1ng=;
 b=etOfDczc8Ar1Lyn4yapXU/obMgE/+P2IQLU9FLGZluCrAS4SxBMl2wFrfAY4HF1fFEyv5fWs6ES4uWOTZ5cMpSdC4dgc2kfrLFvq0vhiOQibZDHcs4DiBPdL5p7I03EK2us65icsAftP9RMpOMgWioR1kKEce1//3suM9XWR3+IsI+1i1vUMcV9WcMdjjJJoSyf4rvIDnQuNU2//6BV1H1WYyYNCLhCFHvNjz3KcKC0z7HCi7W6O29dFQ4G7b/+ovQdFxKpnYsHr3FZw+eJSGM5e6rvTqlHP3AhIuy9g+JX9eheYR3TNxNRxlcFvNeakq6hCj/7JjkvHM9adECOrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlgqjIdJ0+IjyKWEH01MTHoYWJgZTd9CVlHOC0BD1ng=;
 b=wANeNnfnhBShLeqGVqHw3qfziJDGpGEoabTXaHFogVxsBDwx/e/6xekP2aURn2/WmhD6SLzewETnmpncuqqcJIJOxSdtRKDyA5eCgSPfwn855sqVyfbkIi8+1pZJjQRpUTvhgc/FqI15K8SrJVf8X2WJRxbd88ZqGxYSCgB+0yg=
Received: from SA0PR11CA0146.namprd11.prod.outlook.com (2603:10b6:806:131::31)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 21:48:31 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::fc) by SA0PR11CA0146.outlook.office365.com
 (2603:10b6:806:131::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 21:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:48:31 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 16:48:27 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v3 5/8] drm/amdgpu: remove tlb flush in amdgpu_gtt_mgr_recover
Date: Thu, 30 May 2024 17:48:02 -0400
Message-ID: <20240530214805.40970-6-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530214805.40970-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef9ba78-5064-4449-961e-08dc80f23f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXRQTmQzMzFRRk8vVElNM045STVpQlA4M2pLZWt4T2czMnZsSHMvMEdRcHEw?=
 =?utf-8?B?eEptU2tQSTRFWlFoTUJVMTBQU3hKeUozL2hzUnhVekxaQStzakZPYnFLQ2JW?=
 =?utf-8?B?R2hSeXVTdWZxZmNFUWpuN21QbXdDclV2QTZlR29la3NUSjluOGlSYTY1NFpa?=
 =?utf-8?B?ZEkyNytSb3ZUaStzVmJKVGU3ejN5WXY0QVJ2S2owb3U2d3ZmelgvTGExUzZ1?=
 =?utf-8?B?Q0pWdDEzUnl5SEdpYWx3TGZjNHhOUzdvdDhjdlhmS2JEay9adDZ4M284ekc3?=
 =?utf-8?B?blFZZXBoNFcxcDE5NnhWSm1LRVZRdWcrN0pVTk1HOGZ0L0I0RW1xbTlvSlE1?=
 =?utf-8?B?T2tvMnR1WHJBNHV6RkVvUlRxMGRIMC9RWVZXZVlQMFpEOEpHNVRyblVVSjVy?=
 =?utf-8?B?b1p5YTU3bmJCVzVleFV6ZWV5dmlsYkZQK2Q1UHk0Q1RLYmZqVE9vOXhwUW9j?=
 =?utf-8?B?b2M4dGhJQlZ6Um5hVHhjMmZnUW9PN0d5SjRXVmUyczhQbUtOU3dvanRDOGpD?=
 =?utf-8?B?U21WeWRYeSs5YVNrOEVqRVpGeGQxaDJKaXI4alBCWFp2Wmg3NlgyZDBCdEcv?=
 =?utf-8?B?REgzRmUyRThTYkRHZnlHLzlNN21FMkV4Nlp1TTQ1R2pPdXR5Nnl5RU1OWmhl?=
 =?utf-8?B?R3RUZTYzOURNRllSRVhjMk96RlZUQWNTc3liN3pYZWxzVjBnZkRuYVZwcEhY?=
 =?utf-8?B?dENKcGFvTnM0cnc3U1lFL2lieTBDZWRMWTNKcityWHRrOHJXN09QUWx3Zk1m?=
 =?utf-8?B?Q1ZVbHhNSjl4N0MyU2xieGRRWFBoZWc4UTduajRIT3hWRUZpMlowQnpremFE?=
 =?utf-8?B?R1VJYlpseUhGSXN3V0hERnlvQ2xQQWh1N3AyUnNzenZseGFNS3JXS1BET09U?=
 =?utf-8?B?eDlpUlR3TjFjc0FJQmhQMEZyWCsxWFlQSk9PVEZrdkNuYmdveFpjS1BWMVBD?=
 =?utf-8?B?WGhnSG9lREVmVWd5SVNHb05aTWlYQ0lYY3hnQ2lsMGhabFZGUlBkUDJEd0lB?=
 =?utf-8?B?L3hIeVNkOXEwVXp0b2M3UkRINTd5akxBNXl0NG9ETjVhUzBrMnRWTnBLSWJo?=
 =?utf-8?B?Vjc3L3ZqRDRsbGZSZW9zWDNqUTlvTEhxR0F3bXN6ckNBNHh3cm80ZzVVbXRj?=
 =?utf-8?B?MkNlUTVqMFRqdEJvNGhLc0lsMndVanRkdkVGK0JWUmg0TjkvY09KNm1qdnVa?=
 =?utf-8?B?SzU2WjFaSHdnekc0UThJa3hkN1FhNGtLckFUNlU4LytMSkpUVEw2OXArMVlw?=
 =?utf-8?B?TTE4cEltV25WWGxqSGI1R3VaQmJCOXhGTm5YMXkwYURua1VnUkRKeGhCOHdv?=
 =?utf-8?B?S1dkZ28yN0V4UUN5VVJRNUExUDduVlV6R2FrYXVLb2VyYmtHUmpodjRaNlJz?=
 =?utf-8?B?eHArN2dHM2lOc1ZMSjdva0poTW9UM2w4Um9xcVRYdTdDSFpEaVJ0UnJpQ3Q2?=
 =?utf-8?B?NGNlbG9JaXVjamZITUJMMXBWQW1UTWdlY25vWlc5WkRuS3paQWF5TVZHazFl?=
 =?utf-8?B?bllvWmJkOEVqdlZ3eXlabEN0czdBWjk2VWZhRm5EODZ2a1ArcE90N3BTRmJQ?=
 =?utf-8?B?TmtBTXZVWHlGa0FQNUNCUkgvcVRxakhRa214Qkl4ZDFHSzQvanNWdllWNmdW?=
 =?utf-8?B?TCtsaC9WUWZ1eGNJZUplYUx5U1NhOENIUFI0V2lhVGtYZ3ZXU0E5QXY2bDBW?=
 =?utf-8?B?VFlWTEE5bGZlakpEdVdvRml5am4zVFRTMmxCR0EzMGxocXlSdFNteGlQOVBE?=
 =?utf-8?B?L2tHTTdJNXpNYmhmNFJFUVZGQUt4REFFVlBWKzlobDZjVEpnSFlKVWs2WUNQ?=
 =?utf-8?B?cW00Zld5RHZJUm1GaDBBWUxwY2gwQUxFRkZtQlVNVFBPZTA3NUYzYVJiSHl1?=
 =?utf-8?Q?Z5t+lSfa4lX8w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:48:31.0912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef9ba78-5064-4449-961e-08dc80f23f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

At this point the gart is not set up, there's no point to invalidate tlb
here and it could even be harmful.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 44367f03316f..0760e70402ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -200,8 +200,6 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 		amdgpu_ttm_recover_gart(node->base.bo);
 	}
 	spin_unlock(&mgr->lock);
-
-	amdgpu_gart_invalidate_tlb(adev);
 }
 
 /**
-- 
2.34.1

