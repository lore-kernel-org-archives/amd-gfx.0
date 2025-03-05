Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51783C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 06:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB77410E039;
	Wed,  5 Mar 2025 06:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Go2Loff";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DD410E039
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 06:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvaWU/kkTBfB37vVh8hUiiMDrDvNcQz76CP9vLVyL4N4Oh00XFqBwwTo+B2hdWnDymhiJkRpolZ/0Q7FmDV/96yw1aBkzHYjy/KUprsAI5QBtJH5eR0SuHCdAlIjirzp/5JffoiuIVoJaFO1Y4R1B/L+JLyM7M8PJAAITGoFsmaYm8JzobAvH/hn3CvwSbPHrqzVJGJOqLTFa3BEArE/wNcJD4MK+L24vkyKF2FxcnXKutLpPq4rH8S+ksXLvLbnqppZAKFCWwgGmHTEVJ0//JETCeXgJp0qHVuKkupgwQ3erDTHmOCNv98A+1Rtizvq8lG3xay6SvAY4/oLELDjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYBGu28+HNnJcdiwVHkO9cxZSpn+1aq9eaEiqI55gGw=;
 b=qy6mAgC1zGvLkDtg0Gz9377oC5fP+f+mnWDtQ64eNuKiLGzrAjquQN6+pH/Eg7bs8AUAQlOYFDb6+I3zD6YnVIR/YN2AvfJ4NKH96iJ/sn9RtPujjWfhC0LqlBBJU/UB3WSN387i0mNPZzhDJ+qJpt90hMjZ/3YBKhgrKn1UkEyj9UAa8YZYuJ8Idmaq5Of+GS75bQC7PMHKLmYbiaL2Hiiwp3NnTf1vT7SO/+Sovp9fIPIJq3/rBLuXiE5jghEk2m9zCc7iJtihPoswZ4z5rwCwfocCvjsvQrmgf0aQP6KgAbuyIrrAhcSqZb2vIhYntps34d+9xm9qZkXgyQXTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYBGu28+HNnJcdiwVHkO9cxZSpn+1aq9eaEiqI55gGw=;
 b=5Go2LoffRKDqIAwcYdQzqPjAQIwSOSc6+zo96zGcSoqj5d3COzJ67/NJnN7aM4eAN36ZJqgGUhfjtcCst1Z7mj+Wg70tIheC2TR298+bdJKNZy+S7RbBvuhJmPYirsyVihPJKIlITltufQr5i0MEnfQrIyNIUPUQzoLoSd0JYf4=
Received: from SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23) by
 MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 06:44:55 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::52) by SN6PR01CA0010.outlook.office365.com
 (2603:10b6:805:b6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 06:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 06:44:55 +0000
Received: from codemachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 00:44:53 -0600
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <le.ma@amd.com>, <Hawking.Zhang@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: retire ip init code specific for A0 rev
Date: Wed, 5 Mar 2025 14:44:34 +0800
Message-ID: <20250305064435.3658987-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 57386588-78c4-4b1d-4e6e-08dd5bb13d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A3dkVLh2mURXZbgGtu7eA6O0Vq9XHokkk18dF3bbhbIWPMdL4Vtkfkl8Rec1?=
 =?us-ascii?Q?3Hht7jvPGGJBV1KwhN14W7czZsDWSm4Y+it3/rNAiHf3pZqrJ7KFCNwZpTH+?=
 =?us-ascii?Q?PZufE4D7B3QIN/VfgEyUAiOjJmgEzBNLynJyNfxT9SzixXwY2w5xYTctBGJ3?=
 =?us-ascii?Q?2oTMFVa9ASwFi8EHGBZN91Lw6VHNbNGoHil64JTns+2sDXxkM5nWqeWbHh8a?=
 =?us-ascii?Q?GnfHrUTdA9+N68ps1JBK7HavbTIiGvLvuVlveK9a+d9k0GWyl3Xy/u1i5tY2?=
 =?us-ascii?Q?jU15FdlIPPxVL2YkFMprnnhoN4hgT8mKZqvhAuld84E+q0TRmoc9iKHJuRns?=
 =?us-ascii?Q?GOWafLg7NgNR4naJzQa09PuVJKvWeOPOsmizryycuHb2di7irmh2sS8sG20k?=
 =?us-ascii?Q?BDCiLdQS3Mc7LCN8Yx1VaFtclaxsoTimXLom+6KZXm2koT+1pqZkluDw5z9g?=
 =?us-ascii?Q?ewCwxlexg2ria67vDeida31o7oJaquxB38FZM6XLSZxAC6uZyzlzrQbWnOnS?=
 =?us-ascii?Q?OpwaKkzToMFwmVYePCCFOJTJskiQW4fIL5bXfCL/YYnhSMaY+n62xrDZnC7M?=
 =?us-ascii?Q?F4akzjmnCwbc5x7d2INsQTj3w0OXFxdLimQxB2b1ALsoIzUXPYGekQ5ZmjOk?=
 =?us-ascii?Q?AkJIqFuzuz0oBlx6VjKk0TseTEyrRY8xmMk7qIRgrvGCNsjpUAR7IN6MCw9t?=
 =?us-ascii?Q?kVpz9iXXUoJz3wIUxcqnJB6bUr3ppZvmfbgzZk6MF0g4OaYFZY3sKFsawavu?=
 =?us-ascii?Q?SgcP5HQAYTzCZmc2C/jpdVf3cRvKLz+GzOrLbddG13Z4xkHAE5NQ4nl1Lk4E?=
 =?us-ascii?Q?LwADXYNaWFP7ZvopnkB29IsJcAf/uwZF8XEqjRWoiLeOX8XJ2K15euMlurqH?=
 =?us-ascii?Q?rJkYBd+L6IOp+Y4I7lpgC/n7e747sitRdtsKq90hPNTSnURqtn3SLD4+DUNi?=
 =?us-ascii?Q?PrM774S7OUA+Is1wZxN0x4eMXonufsHk5/bIxAhrE+voerl9qffm+mWhybAg?=
 =?us-ascii?Q?VyY6xF5KCUiDGX6GKEwx0kgUBkFFW95xpepuFeZAGYxfexO6bQl84SvZN2zQ?=
 =?us-ascii?Q?8dlqJHJhEpPi4juDLXgNi5ePTcWHoScIYDt2UZSgLh8X/4Joo3+Ku62vUtlq?=
 =?us-ascii?Q?haGTpYgX8yAqvSGX0H8CKAbq320knofkyXx8JN/HU3cZiG7dZ8veT1rDCMGt?=
 =?us-ascii?Q?yhEOzjVRcuZopwzB0p8dJdoLTiySRVGMsGZJPBP7U5dcnYBx4sU89Kp6Lk4/?=
 =?us-ascii?Q?nsMcfNON8tJ/Dl8u3wE+abJPhmMhSLtWuvu5DWb4XIeP6ndboqMov/V3Sds3?=
 =?us-ascii?Q?wtI5ez8b2H4gJE4Z/sjdm8Xs5h74qkMAfd28K6mPWSMQysOvGsqe2AIdR9Cf?=
 =?us-ascii?Q?vCjFKNdSEWnJcu8qV3XuF9LXlY9ysbb1AzUqlZZacRuKbhZMowuKCSL9xTgB?=
 =?us-ascii?Q?dM/2xc7Y8X3KDX5ToY47RUhJDbJO5n4I4xwTgYBiOwDfRhhE8VB9Nzc9eALu?=
 =?us-ascii?Q?uGJwRLZ5Xs7duGU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 06:44:55.1185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57386588-78c4-4b1d-4e6e-08dd5bb13d48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

For aqua_vanjaram, A0 HW is retired so remove the code
specific for it in gfx ip init.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 36505d56ab86..2705f0cdd6da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -351,18 +351,7 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 
 		WREG32_SOC15(GC, dev_inst, regGB_ADDR_CONFIG,
 			     GOLDEN_GB_ADDR_CONFIG);
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
-			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2, SPARE, 0x1);
-		} else {
-			/* Golden settings applied by driver for ASIC with rev_id 0 */
-			if (adev->rev_id == 0) {
-				WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1,
-						      REDUCE_FIFO_DEPTH_BY_2, 2);
-			} else {
-				WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2,
-						      SPARE, 0x1);
-			}
-		}
+		WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2, SPARE, 0x1);
 	}
 }
 
-- 
2.34.1

