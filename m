Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80911C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 04:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1E810E067;
	Wed,  4 Jun 2025 04:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y+D044pi";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4971A10E067
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 04:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMN4W8XsdoIYQDKA0Koaxg9/czFaw2H36ZK42VRcYgWAGPsg+UFLJJsxa0bqrZ6ulI5Q8WX92u06fi7N1B8s2aoHcsp4P9xk/F6Z7KEAqYKMb2VLnsgo4FNCgLRnIJUQgM26FVh5Ol+0s9FC+Q/qQAQsNCAtgvyp94JnulHCBseRd9tJPmU9dTDn/cIg0MwKA08BYYyVpYVFbA74m83sQwtEDGdoq4/knotHDfvbD1UvSj7W8GkqB37Tcj2GjrGJdP/3sx5MjtmkvsqNqILY9flMaHyqfaR0gDx0Mwg6mXtFnF3/amIboumijA9Cfesd1ug1d9fg9APu5XWeiPSngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gTD3Hhi2IU06P/FbuLfsifoyfu3l2dAbetq2jjQpcE=;
 b=im60SJGrnXPsk5qjXButEPide7qDPMu1jP4jk7+5P5L7OiXliB2saXnPxe4jW+KEPieqviLPG1JhhmwWTImYyO9CYAzPuWwu4LRo74B5NHVcKVr/Krs/kteIM9phzeTZVXHGwx+oI5XbadA8c5TyrB5gVOPFVzZ5E7bd55oozsZz1ktjhMhUCR7fIKDO+PW8rzMCDTuj6SqhCzu4E6w8m35Huy7EUKx7/y9/gkFN/cx3tM+lLTQjPYBGQvG6vOvPlmpVkH1b7gKhmrYySzDBdlb6svj67KtS1ZEBZFaRU5UcwoFEoYm0Ael4j6cVa+SGrolivmL/SAbKMnjTqXnnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gTD3Hhi2IU06P/FbuLfsifoyfu3l2dAbetq2jjQpcE=;
 b=y+D044pi2KRvuE3hrqYvYejUo+MBFUiS//pHwLzuOwDqygqP6hFmgSc5n/WtcGyW55SeqIzsyXNjR9LwppHe80QBu5+RdTbdtVRbdBsnE9fq572UfwTBG83OlDY4zo1msuDKIAV5DfDAVxFttSZBaIb6ROev8kKBWrBJYchK8k4=
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 4 Jun
 2025 04:10:47 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::4c) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 4 Jun 2025 04:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 04:10:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 23:10:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Clear reset flags from ras context
Date: Wed, 4 Jun 2025 09:40:28 +0530
Message-ID: <20250604041028.643571-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 891ab92f-74b5-4074-6464-08dda31dc84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qQh9ZVKMlCWbc4YEEoflDOgvvifl52lSd4xVDPtLaIKC9sJD6grm5DzniIkc?=
 =?us-ascii?Q?P08AcO2/waa8Qr/GUrqnmgaEM/HlCGX2nz3f5CmKT4mu+z9geMaEK8kie4qK?=
 =?us-ascii?Q?gPOQw3BpN0cRUcBIn9TL8iDWCeZLSfBfr5ktuDGf0zfTS/+gWdzB1cJTOymM?=
 =?us-ascii?Q?lyTouT7uy+yV9qkhdQEilWGJu+7ODIA32Q2KVXv272A881zV26a8TPsS8i7S?=
 =?us-ascii?Q?UMKiBJH6mxNTJ7yMo1kJu48ZowoArgFEDMUor2POpQ0+wjr9PlAWPiFoiLb1?=
 =?us-ascii?Q?2/4YPHygIVlWKozVZ64A/xDLXVGMTgRG2Q8JimDTeMmVeGQ/B8CuG1IilTEA?=
 =?us-ascii?Q?YeDc2RvnwCEj22TPlCGHVgRNTKMyYNC+MkKncxn6RZDuqs8VZfr0KV01BN5G?=
 =?us-ascii?Q?EMZ5Efsbd4Wk4eFDNTqp2nl8DvsgKGnkiM+onXD+BXdqnR2dO+05bl2e1XG0?=
 =?us-ascii?Q?pyRipy8QOx95bqf1mmW5wbWKkfoa11G3DwfHnr0v2HYGTN75MBGO+WFyRp66?=
 =?us-ascii?Q?TOUcPFE/zjpSTxqipk4RCmVkcLILRrJEbwOy0Fw4tScooKoBm7+eq+ecIfZv?=
 =?us-ascii?Q?ewjQQEQcpEs2Nm3Pe3X/prf3e4Ueb7ClTkMYmqHiqmMgVM+45o2M7YA5JrLO?=
 =?us-ascii?Q?mzqtPofe3aR9Ap61VfkUi/v2GqOtA1oKSSx467AIyIj5MtEdjxuRZKfc5J5b?=
 =?us-ascii?Q?jZQKxzY0W9VywW+GjfUAYHaEIssnA56ASFT8wJDClvu4o5k+LrK+WbwmyIpn?=
 =?us-ascii?Q?Sm7yP0hVnZkgEfwEGho0n9sMYCROXsSDwCrSzkSWXXEjKfxeOmxPmIEhDug4?=
 =?us-ascii?Q?mUKKqeNsjcuSX16VSh2gEb1vF0/el5Ws9ACmdNfG1a+18HX3rZICxhsFrNct?=
 =?us-ascii?Q?/yVUy2sgBkZRRiwYrFXINgo342TZA8pXPyvp0ScVOtEXqoQGd/TgCLKuzXEj?=
 =?us-ascii?Q?iM8JuX3U1q6GZz4F33OaJ4vzbfjDI+RVFfzPjrhacFIDw4WejBqB1v+Zvcfk?=
 =?us-ascii?Q?AizN9d+2yfShq2EozRgBgn7Kfvx5hxnuPDoLa+sPobbOQCuwGM/4yOIjWcME?=
 =?us-ascii?Q?Tj+ErCpmbj/yMmztzrjxr8fz6nA/p3di45QM0nFGXhnXU8t7/cNGBNDRuQcv?=
 =?us-ascii?Q?aZfjmJcmDy67c0oCh1NZOpC6p44bXSz4qvJ9v45y5XI3LjBmaVvFbq0skewJ?=
 =?us-ascii?Q?swAnWkvW5bpRKjHiXZPOM1k+pJ2GM/YooRTvCRIdncIhs9OoImh1/9//ozxR?=
 =?us-ascii?Q?U9Zn7tKTSc/1h6dsEb8ccTpTBZz3DZjlpSaBRXrso9B5atd2r55ro/GmDuGB?=
 =?us-ascii?Q?aaZ4g6HKU3CnPYd5IQu59AwQQ0xOwaTpBH1QagVhFo965WSC23IflIF+a3Yx?=
 =?us-ascii?Q?GEARGsSSKx1LKLMuTiSOL4pS/Ln4dZDITA6PEW24GkhnBz578DOXA0Vm7c0x?=
 =?us-ascii?Q?/uQGZ+VFioqcL/krqv3Ey/UAi9W/Qw7lmc1cn74VaQXibII7m9soB8AyyP/3?=
 =?us-ascii?Q?/R6VWrv7yyjvijdIpLh6M956xvwOexPinZCO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 04:10:46.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891ab92f-74b5-4074-6464-08dda31dc84c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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

Once RAS errors are cleared with appropriate recovery mechanism, clear
reset flags also from RAS context. Otherwise, stale flag values could
affect the subsequent RAS reset handling on the device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b275e464ae4f..b14d08f8feba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4415,8 +4415,10 @@ void amdgpu_ras_clear_err_state(struct amdgpu_device *adev)
 	struct amdgpu_ras *ras;
 
 	ras = amdgpu_ras_get_context(adev);
-	if (ras)
+	if (ras) {
 		ras->ras_err_state = 0;
+		ras->gpu_reset_flags = 0;
+	}
 }
 
 void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
-- 
2.25.1

