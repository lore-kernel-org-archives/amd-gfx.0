Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA60D12D60
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 02:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB8810E413;
	Mon, 11 Nov 2024 02:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDtposB5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D4910E413
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 02:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUaZ234Bpovy4uXWbRYh/EyOlWTizN+TNyDr2D8QqWOwjYLB1xHhn0XxJWzDiLnuymnW21m+NoNNRcJeFpFCTxHzm8Dja1sLMgDYmdvBcrWi1l1bi/U1KAiliBedSdJ9TbV9Dlc/mhpSnq5fhMF+egmYjZX6t2Hy/bSlM3HhupvD1AKFbkjs1/2Z7oCV87YrAGDpL+aOpFv4FkNamhM569lFKgH5jn7AYdTTH6jiqXKW/gEFZoxvWDW6jjYXFWNYB2vZ6k7Ll23AObWjFgHKjo2Uz4ShUXR5RbdmrsDWR7euJUoSmNzYCPDgaVoN3PPnKuq7AhwtGVszwga/pSU4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/nYyhzQiwK3FB26auso9bD+qn3rqjsEOmzmeT/jUSQ=;
 b=KmqVVoPrf4lK3AKsQrd1v9IqBEXXBc5EiA/buCafHfVawcDG3bOSU8s5nPxH41CbrsTmj4a+bEcOJCObu+wsQ2SRNAcpvDUImddltOK+mulQnauafDgUXzCZz4psNTBr145h2GHsML3dFVy6KfPJdFgHsCPFIo9+5SKOTGva7S83+vzJAwmDBRRR/xtaczOX29kIC+NOLk93fkKf+xlHJhRVzbpVQEuc04HYVBac9Dq7p1lkzeSqsUm87MTVORpl5wbQdh/bFOv7VqMVSxI/0If957Sxv3LXFpa+FPQRui+vHmjoGf6f7HN+sYTn1P5niI76v0erE+hbpZbJLsoA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/nYyhzQiwK3FB26auso9bD+qn3rqjsEOmzmeT/jUSQ=;
 b=kDtposB520oJRHUQxya1irFbSaLX50MMuUkt5jZhZ9eML0WrRXD2GxLY6Dz15PjB9cBp4cDoskMZ0Bd6jVqqMI6qdFCsj1+XP43xG4q6FrgMwisYZjxaG74UPVuIsuyPzZhn5ovwHbFpGizOpunB63XsQ686z9IV+C+dqcydnk4=
Received: from PH7P220CA0129.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::23)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:46:30 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::e1) by PH7P220CA0129.outlook.office365.com
 (2603:10b6:510:327::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 02:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 02:46:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 20:46:27 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Add missing 'inst' parameter to VCN v2.5
 clock gating functions
Date: Mon, 11 Nov 2024 08:16:11 +0530
Message-ID: <20241111024612.1881727-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b84ec3-f1a0-44b9-87d1-08dd01fb0b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk1TV3dWUks0MEhKWjJxQmVFQ3M1emlEMktZZWhaYlFNOEtnazJGVzNvaHg0?=
 =?utf-8?B?OUtCVENXTGhIMUlaV1lDSU5XQXA4MDhWUVk1bUVtUURrNjQvd00zTExoZkJM?=
 =?utf-8?B?S0VFWWJQcXcyRlgwOTJhbGpRbjMwbTV6dno5TGNvUEVLQyt1ZFNXWEk3WXM1?=
 =?utf-8?B?TlRCOWNxamE5enhmblIwY3FVdStSNWYxZEpZcCtDdnkxY3RCYXljNzBqSGU1?=
 =?utf-8?B?aCtRNHhyTkJSdlFuRlJ0WExKcXRKSzlBZnQ3eDJuektOcml4bmJCcDFjNEI2?=
 =?utf-8?B?aklqT296bWJzc2tTNzAvdmhFS1U2RGQ2UGQrOG8vaytYVHhMdWF3YmJwMTZq?=
 =?utf-8?B?bk4zcjVlY1Npdi95d3paTTBud1kzWUsyeU4yUlUwa1E3S3l6NTRDcmRFZ0d6?=
 =?utf-8?B?bDhpZVZ6SVNpWEZDOThxUzNtaUsvSkJwY1BDR1ZvOStWUDExeGhTaWxnVmxH?=
 =?utf-8?B?bEFmaytKd1FOc3JkbEk3b3diWTQvTm5IVDB3Unhneks0cENsZy9YV3R5M2ND?=
 =?utf-8?B?Nm5RSWV6MWhUQnR1T2YyMThvL3o2ZTlnWTU3WDdPYzBOeC9zUkdiOVB2MGFG?=
 =?utf-8?B?eEluK2FMZlZxN3RYY2psb0NMMVhSQU5XMGFleEVTaFFBUnE4R3VlallTWHFK?=
 =?utf-8?B?M3J0QmgrQ1ZseU92RUtQbzRpME9HR2wvOFdNYnFTSjdWdHpLU3JMZWVTdUJ0?=
 =?utf-8?B?WTkvWHNGUU1HZ2R2dDcyd0Q3NHozZ1laMkFuamtHelRabWMxTW9EY2FJY0xj?=
 =?utf-8?B?cUJOMWxOQW5XZlZhdUFybDNTLzBZYmVZZ3E1ZVBKcUtFemoxV0czNDhNay94?=
 =?utf-8?B?STdGVVNOdysvQnRmUWVyV0tlb3JzOE5lTi9SRFdBSWRKQ0QzYnd0T1lMU0s5?=
 =?utf-8?B?V3BlWEsrdDFGbE5VMit6RTg2SThLUU5QRGxIREd2VFRNV3Uwd2hONXp1cVBL?=
 =?utf-8?B?YTZ0amp0RnZPSURnYy9MVzNRVlRjZFp0MkhBTyttOE9qMmR5UEZKenNMZHpR?=
 =?utf-8?B?RXNXRHFQRjlnR2NkcTFOd01WWkoxb3l5TTRramhRa3FiV2hDQytNOEoyMmVB?=
 =?utf-8?B?blpRNkxmdWdNZlJZYThiU3c4NzI2ZW0zRER0NGVhYUkxNGhJakZNSnhsTWxr?=
 =?utf-8?B?Uk0vdnROaGxHZmV6bkVhK0xGY0hpOVpKcitLMStlczU1NWRIazBQa3ArSkR6?=
 =?utf-8?B?akNMZC9xOU5QdzNoWmhjb1JqZ0IxWmE4bDlhRFZoeGVTWjdyM2x1OE5wdmh5?=
 =?utf-8?B?YUtoVHJZSkZWL0E3K0NETjQ4dEFaeFliL3U2MEcwd0JpMHVGZXFiWmd3cXpy?=
 =?utf-8?B?ZEdGRnp5UU80MytNbGo2eVpWV0VhaE0wRld2eEgxdXlMMmJBNHdGM1pQWEJn?=
 =?utf-8?B?a1VlR1VQQzBydWlXcXZrVGlvS2U5SFY2alFQeiszOEc2ejlrVDQ5czMyQTZD?=
 =?utf-8?B?QW51dy9ubVdoYjIrcG1Bc21sSUhpcmJqWkRCS0FLeXNGZ3pFayt4dy9QMTVi?=
 =?utf-8?B?cTRNNXRlWlZhRVZkeW02TERJeXVZSHAxSVFHUWp3MExndys5dVlCbTIvdHVu?=
 =?utf-8?B?RHJORkQycm0za2RwMldLYkd2YWlyeW80ZlZPTU10UDloSkxwV1YzWTZWVzBn?=
 =?utf-8?B?Z1FIV3BOcExDUWdDQk5reDY2SGhEckF2S1dWcG1vQnBjMnYzZXFhOEpBN1Yz?=
 =?utf-8?B?T2RoV0h2M2xVMStlTGZGcmZBYkw0dkV6R3VYM1ZhT0xVdW4wVXNLcVB0UVV1?=
 =?utf-8?B?akJjRjYvN1RmcWVmM01FS3RVS0VVVm8vdVIzNFVNVk0vT3RHMmErc3NCMjFJ?=
 =?utf-8?B?N1ZEOFhkbXJVUmJWUzRFSHQ2dlF6bm1FNmJ0K05xdXd0a1Zkc3lNVzlCTEZX?=
 =?utf-8?B?amthdENsYkpRZGVVUE1rend1dTJYYVhCeXZmNmxOTXNseWc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:46:29.8203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b84ec3-f1a0-44b9-87d1-08dd01fb0b91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
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

This patch adds the missing parameter descriptors to the functions
vcn_v2_5_ disable_clock_gating, _enable_clock_gating.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:616: warning: Function parameter or struct member 'inst' not described in 'vcn_v2_5_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:778: warning: Function parameter or struct member 'inst' not described in 'vcn_v2_5_enable_clock_gating'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index da3d55cc3ac1..deec881f0687 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -609,6 +609,7 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index for which to disable clock gating
  *
  * Disable clock gating for VCN block
  */
@@ -771,6 +772,7 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
  * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index for which to enable clock gating
  *
  * Enable clock gating for VCN block
  */
-- 
2.34.1

