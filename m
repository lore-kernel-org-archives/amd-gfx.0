Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54AEFEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4779F10E7A9;
	Wed, 25 Mar 2026 07:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRH24FAr";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3656F10E7A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM/0cHlC5bRejOOy2mPXU9dhEna+g/suQY/59iu8VB0QRqoirplyJKYrZtpWWsXkGzrYi7PazljtdkS8JcTUZsApOu6FFQ2r56YEelwO8ZakQefdbKZBUCNB4WLXjmnfx9oAOdemjD/juoLxCnIFDMx5uVei/iHGx48DfoJlzSv6EmdDkFDmq3BGj5kXSWmTid5AudcOQlwwUsCCOFlvlB6fjgg0buHbFAZ1lbQ9cNB2/WGMFlAd23W9b9mVroZEqraKdLyxlcDCgYkldqpWdlqHQZJ91u95SGL+0VN6p0KGYTCSGwXDrZgO6CSGeGstX3qcxRtqS708HQozVdi4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erbs7EWD5cTf6c2V9bL8qPRN2FbUI14yWr4iq+uT9LE=;
 b=KsZOUA+/OCejoU/nKc3VMEX5UDKhgc6E53bXuykQCEqicQFhsdPxHVEdVXsjK90I1BYBhqchsz7TX3RZI2zq4VESPMUMQ6E+jKcBOJKQO9Jgbw1362xzy64KrixNtJyNnlrI9d317xofZ98oNakeQGsBQXZyjBZJoJ1w7iKpRBxA4xcL5evK6Fb9iJf0ebXNcU4q3ZA+r8FZna/MPdN8PU/TTxbXWBPUChHjqhOxwYHCpF0zpbN4exDHPsVT29sNjryw5nC5Lz8pG+9a+ZNT0fDGuM/+qRIMHSNvlDcY3IIkQXcgBk57SVF/xn6yK6FUjlPTAoK8A3mKcGQMNJvVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erbs7EWD5cTf6c2V9bL8qPRN2FbUI14yWr4iq+uT9LE=;
 b=mRH24FArO6VY0CvJZx07fv2hB4ZqICiuix8Ze07HFHkD+WSlrQixrSK73shMu9vB4FEe06OSQkgSHSAtWsRfPKbRuiSMxkVXWfM5GeQHz+9mUa1nW9LjfrnI0RiOI27/BIHqJnmjQq24bUxWH4NPUlKryTgJ7UEO+nIhWymjQ8Y=
Received: from BL1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::31)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Wed, 25 Mar
 2026 07:09:43 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a5) by BL1P222CA0026.outlook.office365.com
 (2603:10b6:208:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:43 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:39 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 18/29] drm/amd/display: Remove invalid DPSTREAMCLK mask usage
Date: Wed, 25 Mar 2026 15:06:24 +0800
Message-ID: <20260325071003.4022594-19-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 162dbf95-d8a4-469c-e079-08de8a3d7d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Fl9k1F44l1F0IgtMFnMvqd6df60LKiU8FcrbnVMLrdp5EDZfXc+OoAZUOeACL7BPNykR1KbDmxW8W56GEOUiCyhsJNgz2fVKd/LcSFygm5UTLULO6w1KOj8yUzfKHHDKNkWyoIXNvne0nh6fAs2debcDYfORgsiaq3fVJVC0c2/A3a+95Vm5l6LoH8A/ycoAAngY4HJ/D9jfGFyWKPhW2Z7It645e5btXF3TF+zXkGDbSFsCQ6jXKhMyGWWJlFgHf8aj8dMNzuVV2GcHlH9KwQ8r7Fgqxd2Nzpsw4ktqZKRf759GIlQ68HRyMwPX00MbCUDZh2Lhyg2R5et+kXkx0sF4/if61xq1nVpuQOaqLEtw/KbDf2LZpkRJBHe86uUAgBqVpuBNEgxIOvxbSSpxvmRO+fQ5daEjzqsqEia9ajN+4MBP/RcChCWbESLdMY3q4FSeJVSvEGkoEcHaLSU6xrlKt7jHiKlkkleIEDiAYIq3Pqf+5RCoSNTXQW4od2EpJT24SYcudV/TASbVnXCFIh+yuC0b9ZMDzBeOglHbUmtVsMhA0NyaE6r2+5CckvggpspsLOAK7VJp1Lw6KtDQNkYfLIcIHbNqJpQqQFvZT13AQbnGHrj6CClHw71bCpp1sa7npUhvfrezvZC0aL8Vpw4iEfShcr/z4NWd1FJOYyjWvdYDZFQA8vxKlrA1SYoa8Vefld+LNWgUYqTuAmNmC8/1qUOssSrupZoTSneUjyDCeLCHReFQpD2OF5UBHUemNtTMw3ZAIHkTIEtackRoxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5FcbYrqSah6Z7BAsE3qy/HajsDQURZHeoqxO2zNTpWuqPMplmp5KvxEqfpsFVzoKJAw8i7uurTgnOnpjF1ZnjIoj06ToekmNpfgAaEOOvtPza4a2FEZqMBPAM6VHNcF6YOKNufoJ0iqFCFSFrL8LRaUbTsVvoGoMWJw138wse2ZX6iHUH/Mj6OOAChKciX7T2g3lvh1U5Ju5nuANU7LpHCtl5CawA0w8R7GT5hTv6fE/3UIUUer5L9mUD31vue6xAvdmPnqUSsrF8FUWAvRWp1L0IMudkyKp7O5xR8mBDHXpHaEWL+waIrnoCatJRCRhdRY//VPQWXvoopfQ2estbKcHSrmHEAImOfhx4sOoQkEBXTevGd+shMBaMCFBSWbHIWNxTfBm4kb2yXBhfBMNoGeNdZYJKbG1QNVdymwRkO8cof+bHh8aFS3Lj0y+ekl/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:43.1279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162dbf95-d8a4-469c-e079-08de8a3d7d37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
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

From: Roman Li <Roman.Li@amd.com>

[Why]
The invalid register field access causes ASSERT(mask != 0) to fire
in set_reg_field_values() during display enable.

WARNING: at drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:100
set_reg_field_values.isra.0+0xcf/0xf0 [amdgpu]
Call Trace:
 <TASK>
generic_reg_update_ex+0x66/0x1d0 [amdgpu]
dccg401_set_dpstreamclk+0xed/0x350 [amdgpu]
dcn401_enable_stream+0x165/0x370 [amdgpu]
link_set_dpms_on+0x6e9/0xe90 [amdgpu]
dce110_apply_single_controller_ctx_to_hw+0x343/0x530 [amdgpu]
dce110_apply_ctx_to_hw+0x1f6/0x2d0 [amdgpu]
dc_commit_state_no_check+0x49a/0xe20 [amdgpu]
dc_commit_streams+0x354/0x570 [amdgpu]
amdgpu_dm_atomic_commit_tail+0x6f8/0x3fc0 [amdgpu]

DCN4.x hardware does not have DPSTREAMCLK_GATE_DISABLE and
DPSTREAMCLK_ROOT_GATE_DISABLE fields in DCCG_GATE_DISABLE_CNTL3.
These global fields only exist in DCN3.1.x hardware.

[How]
Remove the call that tries to update non-existent fields in CNTL3.
DCN4.x uses per-instance fields in CNTL5 instead,
which are already correctly programmed in the switch cases above.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 0cdf93c614b7..f4ead86c9a96 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -526,10 +526,6 @@ static void dccg401_enable_dpstreamclk(struct dccg *dccg, int otg_inst, int dp_h
 		BREAK_TO_DEBUGGER();
 		return;
 	}
-	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
-		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
-			DPSTREAMCLK_GATE_DISABLE, 1,
-			DPSTREAMCLK_ROOT_GATE_DISABLE, 1);
 }
 
 void dccg401_disable_dpstreamclk(struct dccg *dccg, int dp_hpo_inst)
-- 
2.43.0

