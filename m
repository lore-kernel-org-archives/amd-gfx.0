Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874DAC27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380E910E050;
	Sun, 30 Jun 2024 14:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W9z+XhWE";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B348D10E050
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw9O6dSDtVS4FQw0KJVnC2jjiX7QWcSgUQOnA57Ynk7LHxmn/WDol3wAhqUsoWeIG3aD5k2D66ThWfe6k16s/lPQjKh+ZIKwJnIrjcp29bjv2F5FWGTXOdYby1OIfxoWLOQZ2aPAto1Zj8TdyoOZXv9zEuQReHH+ozJRKzyFxEgtpWBzVq5xQQgx+UXnbU1y661r+KCN/VPgfWYyMj5zJPFeQwkqM0u+LXI3KaYKH4UPd1160QpSV9wHii79ka5ZH6O8/uTAtw87cthy+nK/uux+g/PiD2SfG22xe+VbvN/hCNuOVzDeorpj8gYOsBjoP8Ex8vM/6yOqvAazS9Z76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unKywrRX3II0/QBHOVX/8JkFqKn6iQvY6G/HMlXEUR4=;
 b=bbJ782du7i6OnPHV089F/ObANjI5FU8/3cumbdjhclErp4uWxNKAXePhYHHYO9BtP4ufk1N15zC5LPIO5gDUPXNI00zqQJsPDCTlIhuF7Td3Fx0knLdRNeA9ggq5Dysk6Baq1wzRxr4HRN9qUDsBbIXctUXmCS9UBM1H4OJtb5JVztOYFNeASGYyVqhvYGwy6Oa2Y5CaFxUXKmlplt65G76KOOFzgNOo3fUdW8p56J/tLlg/G8JtKZsWQ2X7QNVQuyrILqVTBWDn9dO6tMZQqAcRdqcws/Z1Q7vnNcjk1BOL+kJBQgUupgLjkA+/ytrFI/ojj1c2FPPgwUpyAf3n6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unKywrRX3II0/QBHOVX/8JkFqKn6iQvY6G/HMlXEUR4=;
 b=W9z+XhWErpFVWnc78pVA9zNgQmqLv+zIdWHWqn7E+W+vE+Y6HlMRsPWbpd9aMB9VZSS6hozEym1u3LPY1oMtve8D5gDUC5n4IfzboTaUioHTTflq0Ue3fcAja8Jh702WHV3KAVFhVMtJLM0Ik57WlG431ncVzHMonjunp8JS078=
Received: from PH7P220CA0057.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::20)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:40:48 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::61) by PH7P220CA0057.outlook.office365.com
 (2603:10b6:510:32b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:40:48 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:40:46 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: add GFXHUB IP v11.5.2 support
Date: Sun, 30 Jun 2024 22:38:31 +0800
Message-ID: <20240630143836.2015991-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630143836.2015991-1-Tim.Huang@amd.com>
References: <20240630143836.2015991-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa0bdca-4034-4a36-f9da-08dc9912a1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q0dVH/dKZ//zXZ6/QDswb5Ri0DsdxWRw6yZlU8DVyfCINfi68qbeFMB/e8tk?=
 =?us-ascii?Q?iYWubogyQ5hDQ4E6ydBCumXlmLQu5QER3qgICC8vvUN9w1CzRw6FWJ3s0lpM?=
 =?us-ascii?Q?2FDzkf8ESJYhhWp7YvczWC6kcnbJ1/aI8Y/f3vtWQ2GpbCji2gDBjj9ASeIL?=
 =?us-ascii?Q?84LNlj7tbwdmPLZArGVBZNvIagFldvDVYS6VaFiwGlLhiBkokcRG8kjzC+U2?=
 =?us-ascii?Q?hM3GNWppmzOe/suqVDXhnR+bi3idtp1nnKcvRvUji6Wgf7UhssoLEu/6HKDg?=
 =?us-ascii?Q?3SftzjOOET9IWqMhpp29oHgFSSdXAd17o66Pzinz2k4Xm4/JYmvLcNaRQGBI?=
 =?us-ascii?Q?CEj7vT+ZUZ8Ec9y6/HBRd4ZaRCY0JYBBrlPM7Y0L5fKKpt+2jONX/4et+mMi?=
 =?us-ascii?Q?Jqg4fhlMWQiQ3DpehfOWkiVOp1d0cyG93u+/eg9k3ypBPLNeGYDUN+dDjK3w?=
 =?us-ascii?Q?QMZ0gPChcG0GaqYDQDKsDVNU0SeQLZ/0CgN+1V4gPZHF5CRlI0vdkMa0qGWp?=
 =?us-ascii?Q?bbA3icdlyd6H0aD3TAwlE+2vlEYV8Yq7CinFAIhAWMCH1hWcn21VD5j6z7EN?=
 =?us-ascii?Q?5XZQEc79oGDDrh9ACzaLtiubu5uTxKBTXZGtd3C2GdKl1wccfYdO4vB5V99E?=
 =?us-ascii?Q?FsNrE5dbQIxS+Sz+k8MRbisJBiLOPl2+aZnmu9e6QK9l2/O8xFb2ddUUMpWS?=
 =?us-ascii?Q?079c/Rjt/ITlbHoDNimf3U0kP91oCfgMPz3W3ANuvBuOHQQ//5xwYpTRbuuV?=
 =?us-ascii?Q?K2PomenkipT4H8UKN4Aw2MX1P1Ylb+o+CzobFo3fSy7rwtbYCfcYS+pN5j5M?=
 =?us-ascii?Q?+euLOpI2bc2acP/dbJHGsgML5SUM4FcZ6IlytrocnAbE6wQRHyCgUh3cVgFR?=
 =?us-ascii?Q?URiD6zbnoNZaGYixRvV3+41nyat94zn6uvtXMv14sWIP2G8+nwHTI2QXQEDq?=
 =?us-ascii?Q?vjbwr7bHS1jfloupu6uEiaRN84SYPQLgDAbS5qDowxHOl5PmNFrlEawlcDnn?=
 =?us-ascii?Q?v2C/gWpLYtxEK+ha0LwsErJ6ICQBFLg/ofINhmuPA9FANWv03o49qrWmNIhR?=
 =?us-ascii?Q?0Qt5LnKAvQG4k526ymLvhkHWfj7rSDQ4AFLgyttbZosCSj8B/zlAlojjYK5h?=
 =?us-ascii?Q?2TOEOeXK5fFX5k4LIy21ysCnvolsg87rxs14AYQjuaQYQvVEKLqottAyuvBI?=
 =?us-ascii?Q?U4qD2ohdN2RFXs9YRHvmmx74ATQEzRA4Qzi5GTtZHhrcFUFYj86B8hVsKe08?=
 =?us-ascii?Q?DhrWeJxuJhutOLqZNeX8u2k10XZqm/KyRkNq+DzjZx9BeonOQPQ3/WH1w2gz?=
 =?us-ascii?Q?1KXnllYmv69gsmzd9LtZCV9CB9SUXXYYYjqcioWEVTbAVa6/bGX5IhBgV1E2?=
 =?us-ascii?Q?xyiQuDRequOMRHfGi83XgrRcP4CmLXoAc8mIVvVIpoOXLG/IjWyxgTH63ko0?=
 =?us-ascii?Q?T7+mIIEiQU2esUruEZDmMJsb/Xy6UONI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:40:48.2405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0bdca-4034-4a36-f9da-08dc9912a1d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
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

This patch is to add GFXHUB 11.5.2 support.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index cad883783834..b88a6fa173b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -592,6 +592,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
 		break;
 	default:
@@ -754,6 +755,7 @@ static int gmc_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
-- 
2.43.0

