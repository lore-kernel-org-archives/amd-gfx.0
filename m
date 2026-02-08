Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED6DEF06EA
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6860510E30A;
	Sun,  8 Feb 2026 16:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WnzvE6L8";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB5410E2FE
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zjzbn6tmA1bVWo7dfJzICpvXrQdYP2zoli1L/XjqrIGWo12NoToWfendJuFHwJduEG+2YX83wJP5h9k7bs5yWckd9vF5txAqiTgmalpEwLyumxGyhl0HlkWib4greu4/2ReMGGuFCo49j6ZMMW9CPAKFLdnRtHba0L0La3NI5yRWuGbVk+LZcRvCvZUyVEYOMS7Ga+Dh4VGtyHLv99vXObHc/EGeR4WmQeDfWyucTHQUvKmbzEt7E+xSw9UuilQPCzRk3sE+cmzij7GeNbiggqkVi3y8t0FvQ1Ep3wmTw5s04ZYUZ1QmMYFQYyrbaqLRho9dHMW3YgVkfY1kcmlhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crPqFUEKmSyfmvJOhyNEUzn+2HDUym27+F/Wz7lTO6A=;
 b=dvsoZlqa7xS7OvO6lEiqSiYEL3ylDhiANKZFcqZRiaINSiM0Ot1lX8qWr0lvaq8u421j7vtKpU55vYP+rwNU2pdP5lpjCKc4XUBOHfGAJGkfHzZUYAMwFBMRuYCG/5hTC3ezMKgWtSBALDMGKgbtEUlgo8R9Pujhwcj/VO3YjmLvDnN9TlXmr7TsAUM+JX9e/S0OBHbunRQ845zWza3HUfb9EfiZbcOBai+Pv5UesaZFDD3xCBVlzu/HTRRAWP1jGemJrbqlAmxwWSBiaxtZiLFrkLo6qhzWVMcs6Y3IQP5C6anLthCMl/eoP0HeX7Ag5AARt3Pza614KmEzI+WTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crPqFUEKmSyfmvJOhyNEUzn+2HDUym27+F/Wz7lTO6A=;
 b=WnzvE6L8SMPixNCj4spOz9QDhILR5PCzfuA+i9PMYQaZamSS/n/o+uh1VQFbD0qSVIgwxIU1tcYwY7AUPSxPLskxIQZS9BBOmwfg3b+L3TG9yqc/MjhyLDogGlKAhBj4PXnDPeAfN+xwKEJOjIYDjLCVQbML2pHP/t2wcCBY43M=
Received: from SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Sun, 8 Feb
 2026 16:43:51 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::96) by SJ0PR03CA0240.outlook.office365.com
 (2603:10b6:a03:39f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 16:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:50 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:48 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 12/13] drm/amdgpu: add new data types F8 and Vector for PTL
Date: Mon, 9 Feb 2026 00:42:11 +0800
Message-ID: <28d77eb19f83dc92d75f0adc6117062841401e18.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 085f5524-e941-44f8-26ac-08de67313d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oPTpvjkEmoTv6hl9reu0EMNEzJjcWFX4v2pON/PkCGRc9u0AiDDYMSJ1LBkT?=
 =?us-ascii?Q?qJPVvrEvQauUAccv/Mxk21Y6GUij1MMasG364xFylAuyjSRXItOI/jZH02Cm?=
 =?us-ascii?Q?DlzJCtgEf9kFx/NL9pEKTYxHBLXZ8sisTSOi+lPNcnstTqTUBj/xNAlvGmZ4?=
 =?us-ascii?Q?Ur50hMkHp04NwoGeTOupgmn+D7uMpDzNNsRCBVveNs3vB1TeEq0IufsgKrBO?=
 =?us-ascii?Q?fUFefkFowok1IeNO/ahuFgv+RPqLaqSh8A7SdlwyfxkILsU7MmLjoTJlguXL?=
 =?us-ascii?Q?XIJHnfu1rlhLf+zobD/g23Li0WIwo+DJ/+rPI58oucJdvfSJHze5KCOEmZVo?=
 =?us-ascii?Q?ImTB0OLKp0dgmcaEa2pKjBIBYaPHaCOiHZ/sySrrAaooAFFm/NC8e6+A4vkk?=
 =?us-ascii?Q?70Eeqp5KqpQaMagB6zPFoKoyOQ4RngJZbdHYujsSWLE/LDFRdkZYLh30A3jP?=
 =?us-ascii?Q?iRTf+gDc+uDXIY3J0ndpBXPV3tINAYdrZO+xGQVAq0hqsSo27jR0Wb+35Z9z?=
 =?us-ascii?Q?lx7ix6wIBAIsIHsT09jHL6t7lXv/TX7y+OCozpQ/oOMmMpnGUqJa781tPrBI?=
 =?us-ascii?Q?pzaWwYkIHCzectcbAY5Kz3j8/6ZXWICDzCebLnqIAlOd9JIT2VBNvrJxupZn?=
 =?us-ascii?Q?GtJYaLjL2kgBd4GtB10qKEbmzlM6YZX36WtnjgKoEX5uPWE9F+/VOEn3hkCD?=
 =?us-ascii?Q?wdEKWfZ8ihq7FMuvoRWRnvgtCr2fb02ZfPEwCaRE0wDb/EoErzocGUNFsjxE?=
 =?us-ascii?Q?Cywu2m+eGgi418DT+XcawOlW8mjy/cpMSDRLRtn7JJuC7NPedgBjoO3HrUhw?=
 =?us-ascii?Q?0FynJsuSBvK6wQ8Ki2YwPQot6t/1pB7DeTQ9/yZeNDMSRiCN/X/TKWM97Do1?=
 =?us-ascii?Q?hjkigYz2DYZ5YKKfqanX7RrrWrKuTO5C4tmzNhvk+yAkHJbbKYbKh2mBDd1K?=
 =?us-ascii?Q?WYas7f3azgquxPJ2YstF+Xa4R3V++hRUrRbSyW43zT6YY+vhEY09V6lSXHAO?=
 =?us-ascii?Q?oyPIku85d4DjVEw238KE1hVALxnODF86n+H0V9hNoye+pjmYXsq+nKJhayGA?=
 =?us-ascii?Q?VX80IMoTXBE6u+AUlI6G25Q/cQs1KXimgIyJ7mGIJGqH2lYbSJr3mhzDvY8N?=
 =?us-ascii?Q?muXarQMhmgjn5+YBnPbGCySYlgnVwWmNZj4tezsXeMQyj273deRSzi6v4osQ?=
 =?us-ascii?Q?WtQ5x7oJyGFx+iYZM8EGDcYbTcmB1wtEcaysvDKf6mYtu888l/WPD2YG6/Wz?=
 =?us-ascii?Q?14DIiyKpyWrRuEES0kW9VYqVE0qRZYsV/WXh5mN7m5iXfTz1MxQ6AjBpNebW?=
 =?us-ascii?Q?HzXBDdG4ocNVrvHlSMEDtspuKa2Q/sgVffvtdbG5L4NgXRX744Qizvqu6YKb?=
 =?us-ascii?Q?FmFsjEnfTnVDVPwKcTO0+Py80GdEHkPq/3iBH/WUYXdjdgxWSX5PZvYy8Mpv?=
 =?us-ascii?Q?zmihUWm+9Uteu1fcrMH4cSBW/MSvwBuwTayQW+QYX4tRknT/R51sIYP+qsQP?=
 =?us-ascii?Q?DjnrLctQ2yA46MEt0FW5LIE+hpePYO1IDYUztowcajz/Y2yoZGcHvYXCb6u5?=
 =?us-ascii?Q?a+I3pMgJYA8Fhll/M/aBp82x56uJPrG0y2orQsGmSPlp4MiF9fM1t/up8Xcw?=
 =?us-ascii?Q?hqxGlBVA9N4Ngvxc0Z5gQk3hyWzPq5BpNVJzeNl9LwKcwwGBG0P6d2+4aCSg?=
 =?us-ascii?Q?+kc8ag=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t750U4uxx3yhWzMjfge/D+z9FErEBZcgBPjkew3UYWEiIGpLUu/y+fZSb3T1+rpwjMBZ5egtWbxznE7G2eBayl36lfKMY9c+fPR5usdoDB9UwG3N2XMutryVSFM3RW+Qp1XzDSnVOEWqPFJbY8uLBpExvnwpIL9496VNH0C35bcK8nvQYA4GGxRC1cbxNSRT8sKGCQOEM87ytEGMzY6T4U1El/DcERXye71vKBFRzGAn1MnZNpdGUryr1vsPYnpc5uWRdhgcf9BXKX9kwLBcZvOdyS9ugUsbJl66ZQd6D0SKwF0zfFLZEV/8mGKEXoN5Hhp64yd6RHpSJBSmIV1ucXAY2N+hjc+m3Rl+sog0PoYtGUA6vkXwaXbpGa3Z1WBK0nKwJ4d3qgZhGDPLG1pI844SrKgk2DytYrwbcP/XicrD7R3SADBA/AojO9S+sFLP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:50.9683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085f5524-e941-44f8-26ac-08de67313d33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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

Add F8 and VECTOR to amdgpu_ptl_fmt and PSP format mapping.
Update PTL format strings and GFX format enum to keep PSP/KFD in sync.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dfda694aefe4..d033b4227f3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -58,6 +58,8 @@ static const char * const amdgpu_ptl_fmt_str[] = {
 	[AMDGPU_PTL_FMT_BF16]    = "BF16",
 	[AMDGPU_PTL_FMT_F32]     = "F32",
 	[AMDGPU_PTL_FMT_F64]     = "F64",
+	[AMDGPU_PTL_FMT_F8]      = "F8",
+	[AMDGPU_PTL_FMT_VECTOR]  = "VECTOR",
 	[AMDGPU_PTL_FMT_INVALID] = "INVALID",
 };
 
@@ -1232,6 +1234,12 @@ static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_fmt fmt,
 	case AMDGPU_PTL_FMT_F64:
 		*ptl_fmt = GFX_FTYPE_F64;
 		break;
+	case AMDGPU_PTL_FMT_F8:
+		*ptl_fmt = GFX_FTYPE_F8;
+		break;
+	case AMDGPU_PTL_FMT_VECTOR:
+		*ptl_fmt = GFX_FTYPE_VECTOR;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 11fafe332bff..4909e0ef328d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -372,6 +372,8 @@ enum psp_ptl_format_type {
 	GFX_FTYPE_BF16        = 0x00000002,
 	GFX_FTYPE_F32         = 0x00000003,
 	GFX_FTYPE_F64         = 0x00000004,
+	GFX_FTYPE_F8          = 0x00000005,
+	GFX_FTYPE_VECTOR      = 0x00000006,
 	GFX_FTYPE_INVALID     = 0xFFFFFFFF,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 93bd2e06fa14..003c166b54f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2381,8 +2381,8 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool ena
 		return -EOPNOTSUPP;
 
 	if (!ptl->hw_supported) {
-		fmt1 = GFX_FTYPE_I8;
-		fmt2 = GFX_FTYPE_BF16;
+		fmt1 = GFX_FTYPE_VECTOR;
+		fmt2 = GFX_FTYPE_F8;
 	} else {
 		fmt1 = ptl->fmt1;
 		fmt2 = ptl->fmt2;
-- 
2.34.1

