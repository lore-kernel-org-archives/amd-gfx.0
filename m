Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E0ED5D687
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 19:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAAD10E1F5;
	Thu,  7 Nov 2024 19:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZiqGVORQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C227610E1F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 19:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMjP/JaJwlhg7uR8sgxSfkBrb/XC3ov4/wunZZ/sc2CJPcaAj1B8fXkbCSW9sZQg0BwumNKgAUZQT30AJz7IpUfRjqFH5uxHc6coPlDNYnfApZdBUIE1GF222YLzS6fKcrHsOamt/SybwtQUrvHaBeqJEz3cYNaOc+YVRWAB7n3gfaIFQY3cUQ/xL1LcFgZ4DgReauY+7JBkkLa4pjlaBYPlT6V71hFMIZeEQHW12kSTQoOXITMsuQIlXJNbW/Hchq+ow5Q11vB42MF5OMtrhO7QyhOhIVdi35OgAGXs+EAajYBM8s21e6/17grfgW9aPfXo8tvFo/g1jKZlZDzLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj3ymCx0tPmTuDr3q2VUSMxQVELu/DiEWgFSypGSJOQ=;
 b=M9pGtlbeSWWoyCALFnCHAfdRGuzc+QC86MqxVKWJZVX+YfUnVkFErsPrVuKdHCKSxFx2aCJBa+w2ZavaqzoW5odWNKHNIQAC8NYNjsDCqI2l/wB8MZl5AIU+AWAEnAwkmnZUfx1wBhGbpU5Ff3co5e3ZoUzZ++Z/UFC0a07l6DVHMZAH7ERyPkVsXqRjdpU/Dgf+sP3lNdzYWL3PAdqqz/7HqR+uxouV3iph6roEQbcKRmY6Ou65yA0ZOz10S2xGnv8DTcSglMNpxzBRur6fmHsfKZr/ZeazIHPXIgXlUPR0Uls+mxD7R4WSw9VtFDSqvA+13c5P83jcrLa+ld++2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj3ymCx0tPmTuDr3q2VUSMxQVELu/DiEWgFSypGSJOQ=;
 b=ZiqGVORQ6UfaxXuZ0Hx9Oy6BCXU+ZCi3g7ykOHbkDyeXl4PhErokGeX7ZOrw+JWA/pIM6wy9zFf7SmbdBX5HZRs112jfTgkh3mHN8zZKDEwi60lLBszpQY4p8mMQZDGT2TtrcRg/IS89h5YQJjc3aJmt7vM1cTja1khKgnN1N00=
Received: from SN6PR04CA0101.namprd04.prod.outlook.com (2603:10b6:805:f2::42)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:53:59 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::c5) by SN6PR04CA0101.outlook.office365.com
 (2603:10b6:805:f2::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Thu, 7 Nov 2024 19:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:53:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 13:53:56 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: Enable cleaner shader for GFX11.0.0/11.0.2
 GPUs
Date: Fri, 8 Nov 2024 01:23:43 +0530
Message-ID: <20241107195343.600259-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c00d30-1869-4873-f089-08dcff65ebc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alpCbUpYUE82L0lJK3VkYS84VUplTERMTm9VUWdwbmZMdUtkQ1lUOThDbWdy?=
 =?utf-8?B?NEZKa2pzdGdYSzBSUlgxUWFSWE04M01QNTdaNEFYamxmTVJ3Vzg3VzEybHQ2?=
 =?utf-8?B?dGEwdjcxd3J2RjRVQkhiaVdWQ01kQXp2OFNrN1prQ1QyajhwdlU2MC8vZ1Uv?=
 =?utf-8?B?Z3hCMURkMFM4YTFUeHBDaFd1S05oSkdqZHh1ZUhHQzJhU20vQmd1VWJhL0RG?=
 =?utf-8?B?MFZIdFR3b3dkSFlYQ0Y0QmNwd2JLdjRxUWNmRzVhL04zb1JVM25ndzF6c2hq?=
 =?utf-8?B?MVFPMnpZZE5PbkdHeXpJZkhsSW9wYXNIM2pzK1Jxc1U1ZzZjTFlCV3JhQ3FB?=
 =?utf-8?B?b1ZTTGNOSVdjZmp6YUNpSjl2WlZXOWRHYUdWVStSSjZPQ2FENTEzSVBxT3J6?=
 =?utf-8?B?STBIUnhRTGFOK2FiRnVvaWJ4M3ZWQnNEdVp1akNRTndLcWtXREczRXpQUyti?=
 =?utf-8?B?WklGNmhOeGJLYVVJcXZ3N3BHS20rTC9iVTRFbEVlRWdzNDVhZThtbXNmUWdH?=
 =?utf-8?B?aUpIamJoOFhlOENGTVE4Zmk0QjVoUG5kRjYzL3R6aG9ZS2pxcThKZFg5ZW9w?=
 =?utf-8?B?THppVXVsdWlkSmVEa2xvMDBRdy8vQlpseHE1ZklNa1doMUlZdWhleG9leXcr?=
 =?utf-8?B?MWZ5MTZpUTViVjdsbVlYUnNCTkpzME5YMDM5eUlOT0JyYjJ3Y0NoSDNPVHJC?=
 =?utf-8?B?eDM0RWFVUSt2R1RKaC9zYXgrbEpoMTZ5WlVmZXZ4RFVKNy91Ny8rUExGZUxX?=
 =?utf-8?B?T0t3YWU0WkhEU09SdEZSK0dYV1FMbDNGMFBPamRPd1poWmNvbVBFN25Qb3ND?=
 =?utf-8?B?aXhZQnhFQWlLeXFDQnAyL3U2ajg3ZythNWpVUDZkWHNvYXgvZkt5cE1UelJQ?=
 =?utf-8?B?d1BVa29DWDVheGVSTzhDYWVHOUZWK0xGYmQ0Q3dDZWd2cC9GNFF1alRYaTVv?=
 =?utf-8?B?YmpZSXZXQ2llajZUTHBDYjhrL2dXQ3RjZjRtNlN1TjU4bEQ3VGkrUUhkSFQ2?=
 =?utf-8?B?NXpMeEJZTlhmbEZNOXFtdUFSR3E4K1JyUE54MHZNazhkTE8zNXA3QVRDSk9k?=
 =?utf-8?B?Sm8zSS9xdXlrQ1JmWFltZFF3UkU1dnNlMlJRWnNiL1VYSVNZYnRscGRDdWEv?=
 =?utf-8?B?WkdINm5Ta1J6bjNBM3lmVWVPNHZGRG5XcEZtRStuRmpDZGM0czNBdktJTzJS?=
 =?utf-8?B?WFlwSC9maU9sNHRlN2t1bGljbldrTWtYZ3YrUFcyeHJvK1dhdy9mWHpMTXM1?=
 =?utf-8?B?Z25TL0kxaDg1NlRIbmZQRjhuS1RqMDFucjk3bjhDRGVBUVlFOWxHdlRTdXNW?=
 =?utf-8?B?TUhLNHMwakMrK0J4aFNtaGtnOXZsRlc2UEZzSE84cS94Y1UzSml1Ny9wRlZ1?=
 =?utf-8?B?NzQ4c0dJL0FLNVFFMmhBZlU4SUROY1djQTQxNG9nMGhtbEVCZXNCK2N5WVBG?=
 =?utf-8?B?K1FtbFpZeFpjQWFtUW9mYTF1NHBncXhsTDkxUjdiOElLYlRickRtTGVrQUdJ?=
 =?utf-8?B?RWtQWTI0dG5yNHMxMGNrMitKYTJUdm1qaUY2WUE5WFFZK2RNYjgxekwvT0Z1?=
 =?utf-8?B?S1RnMEFrczZROGpvNUREZk9IMnRwTjN4UWU0L1g4aW0xekRjZDNyS1FCb3VO?=
 =?utf-8?B?dE8ySC91UU83dzZZbU1kWmdTT1JhVjFndWh2QnJTRVlkYWVwcjJSOEpEU0tt?=
 =?utf-8?B?VGo1MlV3R0ZGTjcwME5mMmNtbm1HaGpJQzJWcDBFanVZanRvOTVoQkUvRk1D?=
 =?utf-8?B?cll6eitEcjB5dTlhd0syMlF6eUhOVHU3T0FTQW94QmpINkl5dUpDekhQcEkv?=
 =?utf-8?B?QjJPNHJwTG5maHArRDI0K1BFejNlNHc0R3pjZWpZOW9JL2E5QndWblE5TDVG?=
 =?utf-8?B?VTVTMjA2aGlpdFdWYTFWUlM4Zk50c3dqUjh5SFZ6TTJhMGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:53:58.8365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c00d30-1869-4873-f089-08dcff65ebc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
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

Enable the cleaner shader for GFX11.0.0/11.0.2 GPUs to provide data
isolation between GPU workloads. The cleaner shader is responsible for
clearing the Local Data Store (LDS), Vector General Purpose Registers
(VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
prevent data leakage and ensures accurate computation results.

This update extends cleaner shader support to GFX11.0.0/11.0.2 GPUs,
previously available for GFX11.0.3. It enhances security by clearing GPU
memory between processes and maintains a consistent GPU state across KGD
and KFD workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4945e9bf0154..9635f091edc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1589,6 +1589,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
-- 
2.34.1

