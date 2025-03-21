Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79222C36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 12:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C85C10E7C0;
	Fri, 21 Mar 2025 12:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NgVc7FtS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834C910E7C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 12:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihT5ACJ14CG+/3c7geQ0SxoBkNWJW8YxL/D4lZMoOyhFN2gmZ4qaCRk7dbOBrbNHN5rhTbCp0mmK4MSZ90wzKiDodzyGUh4qikGNFUL9NLqQCwQRWmGxxl55T1ftCtRZ3FM5vZejkeBZ9ie1QlFtgvb9u8efLiG36z3XOOmq3C2zKDb2t11/w48flaYdB6XoBiK0WOaZQfL5oL9zah4z5Rq1YZ6dFLI4v7/KexLUgq6HT/fSz7brE4uimV54vzxJYYMeEs3dI9Ig1j0vM7gtjS64KLHwG8bH+kwmgzQOV1o6+N/25lvV2KkXnL9Ytiw85qjPJzLyfALhF4PsM3gquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKurjJKCm664qwOtLAE76Y1nkMvunY2SBIlWksWwIKU=;
 b=wpOVkJimAznJ1gHfbzzCWdWiV7KBg6Upk3pEy3xMul5xFe62mFS6gHG9STyeAbDi+TOVevl2vEHk3NTfZQtYxM2HSlCAJYRdZrisdlW8YN9wsRaCJ8+MWyCWN8vjJirKuShPjjJF2vP1CuyCa52uYm7IfaxAhFa/uyDW5IqZuvNWo+MjoPwUdKudU07v4SfjHz2eAt0gtUqUR0WANzjb2HqRfrhqp2LzFn8J47jpTtfgg1SxnCWlIkAYds23Q3OHXt2pW4AJt0BOytAq+RzxokFVrbduB68a26iXXNFNXmEACaFj9hs34oAIKuZdLaxAAr3bWeZ3VsYhOJlH9wiBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKurjJKCm664qwOtLAE76Y1nkMvunY2SBIlWksWwIKU=;
 b=NgVc7FtSP0plOHpwBUpF/FMzQmQdSiCbGFbCUsJenb6PDTyj/a4XCA+vfSiif0ZNivvjHnLHRHK83Z5W7ZlDsELajs0F5WH9Ryokd+rdhNADKZ5eYEYUxTMl1inSyws/cjyio4uMJkMadG/3+FdMWJxffVK1aupMS3WjcQQa6f0=
Received: from PH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:5::7) by
 SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 12:59:22 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::52) by PH0PR07CA0002.outlook.office365.com
 (2603:10b6:510:5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Fri,
 21 Mar 2025 12:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 12:59:21 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 07:59:19 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <KevinYang.Wang@amd.com>, <Tao.Zhou1@amd.com>,
 <YiPeng.Chai@amd.com>, <Stanley.Yang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Use correct gfx deferred error count
Date: Fri, 21 Mar 2025 20:58:59 +0800
Message-ID: <20250321125859.611759-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e10671-b84d-419b-7665-08dd687832dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aJT3YJW2zkVyuOWZpHT2or+18PRLYGLocwS9XspT0G1x9szoV6kblNciF8Si?=
 =?us-ascii?Q?LtI7j/MBfqk16R3x9m6KIYy+7cX6oqVMS56OewXik6LU998Qqb+Xo7cKJY2s?=
 =?us-ascii?Q?VkE0X4vGu3yC2nu7yP2DTT+Z/V1b/EJsk2TfTPv7V2XVamN87QAfGL0eHMdL?=
 =?us-ascii?Q?NOrQHxipk0CuLi/GcSvKTpURZH2Tz4TLFdbzq1mg+90nb34MlK/psxztj/9B?=
 =?us-ascii?Q?Hfp343QOClgK6/X5AtVNCU5JYn9c/Vu/X9URiIQscjqHjyUraIRam0jtTVlN?=
 =?us-ascii?Q?fsoxWtlCjJEgzpaa+b210sOX5XoGg5Z7Z52CCAUBCuK8NzarpuL01aNfaWLs?=
 =?us-ascii?Q?PDhxLgSCuLVKrbE81/Iz1CEUY334LCfLXPxLEKVeKbP5S1f4jV5UAYFTxwmc?=
 =?us-ascii?Q?51jeprg9lafYLe6qRCbp/3vf1ZEOZ6B2BfJNGi+ecdEprg+E5pxiEVFLpvIC?=
 =?us-ascii?Q?V5VNWekESwICUZKGKIqiYelugn/Eru+5SN/cDrkX2vtGXXQlpGhAO8XVL3ux?=
 =?us-ascii?Q?EQq/V3gi3yphjnQf6S4he1T/jCua/k6eZ9PAZ6T8ddr9yT3+ewVIv5cXY6+2?=
 =?us-ascii?Q?UYBLiCZHREQL5b9sY44i6rs8LVVM9vPSQ6FlLrEivs+xLDASG3B4tWzpi+cn?=
 =?us-ascii?Q?1qss2w8eyaOecQq88Dt5DO5kPucqYxvwi1J/y5wBcj9rUYILR926/j8LGAha?=
 =?us-ascii?Q?vliRpUdEYftmuf52/qe2Du6Js8Xuqpm/hWpabkv39Ayd+cQxVY4RRwXuNZv7?=
 =?us-ascii?Q?MtrzDMkwvbfhnB/Xne0PvwQu4RCGRPilHOPH26scLWg7u+ZQucIO7bSFjR/R?=
 =?us-ascii?Q?DHLbeCCVYisyb09Vsq+jhHfQKK75tK7Cq7BUDHMqdPNurLsKdTij9Z30fTQw?=
 =?us-ascii?Q?gL4uD8EO1+iKMdiNTg2ELmEXpVWOOgXWok2c7c1w2Viex+jvGaLg72nRHrlX?=
 =?us-ascii?Q?YOW6rvz/WWj3sSLU8LyOMBuDV4GCM3ylrFgIlobB04kVp76mYj56hf5VsXlN?=
 =?us-ascii?Q?XmAS/Td4rJajf7PvJskOUxYIrD3XMb6i8iD/ZSbINH751PRR8HAdUmtqktl8?=
 =?us-ascii?Q?US9b+XJvSzExyKZSml7FsCF44lGFRgRyqdAbrZkwe339SS2aN9KoZP334RsG?=
 =?us-ascii?Q?pYKssw+nUm2/cIuntQCZUuY7GL6+2oKXnlV3879G1L3qj4zzBQ5EEjSPqfGD?=
 =?us-ascii?Q?povKIp3O1dRUk8sxgRWePaO9Od2un7jL0Q87PwvzKEB799L5GspjkKai9vA/?=
 =?us-ascii?Q?uImTfQuVsZlRWq0Sv/qmFOoJCIyC7PDCOQ1kqqGtsTr4XQ0cqrBIJe0M2wzY?=
 =?us-ascii?Q?8bMsFxPqihQrPXBDHWtXME7hanJJPk7XYAJ6Cr1B2sDL0jtVXSQ6GsrW4bDd?=
 =?us-ascii?Q?zXzvL24/GqXR7DoW6nBkhqk6cqSD+scDaMGihlYXgHVYzrFgxkgxIqbyHE2W?=
 =?us-ascii?Q?FulC3lDHVN9CPR+dIwNcbeAgK8ZRDM+JuAaD2zvofjkKIjPFo3wGr33TgTo8?=
 =?us-ascii?Q?bBiwrYIOVyegv+U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 12:59:21.4592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e10671-b84d-419b-7665-08dd687832dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
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

In the case of parsing GFX deferred error from SMU corrected error
channel, the error count should be set to 1 instead of parsing from
MISC0 register, which is 0.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a58e2ce4deb5..e84238336fb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -898,9 +898,10 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 		break;
 	case ACA_SMU_TYPE_CE:
 		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
-		ret = aca_error_cache_log_bank_error(handle, &info,
-						     bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
+			(bank->aca_err_type == ACA_ERROR_TYPE_CE) ?
+				ACA_REG__MISC0__ERRCNT(misc0) :
+				1);
 		break;
 	default:
 		return -EINVAL;
-- 
2.34.1

