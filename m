Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE73FCD6E5D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 02:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937D810F77F;
	Wed,  3 Jun 2026 02:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WlAw6qV5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B10C10F77E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 02:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW1ZG1ev6M5h6aO3AbWawdDtAsHfU/UmxDlxMXJHTrisqpobhQAwQRJNDmtT/h7ZS9KSFsgHSG9j2OYuSjCOBX9xm9PAFSwDKLshM74vQ5xE1EeAM0Abxo/wUuBe+h2rBpZegh/0vi65VVd6M3l8ntH1hP0FKhIpNL2osMB6ZUm0HAcRQwFDUO/7ZK7BFFPH9qlTJnmR9lGRjNYC9Zjo6swgW3R8XbBI354XQp78zG6lwmocsmPDvEp44wwUQv72f5l5zncSVBCJekdBjUpiyUZZ3RfH14ZJ2Z69/2JCP1k0upQuA67xHExB/eBkfK+rAFFhps9slfFNvi/51wxVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz/EA6E+jzz/V+w9NVdpBAa1i2mp9kyjjGQZrT7mfd4=;
 b=XSV++75Ykt16y1JfWIprUb+zywjcByjTKFgBsycvGIRmnt3kj8AGLIKJrSdZyQ+AEH1DWvQorNkb5VkQQgyCnoNWm5C36wRrw9UmQTdph+HhmWN17+DH/zCVB+qN8JxZz34EKfS22AJM8w7g0z1yMDK1hQvUCZpDC/KibTy1Kuw112ux6nt1Fz1p34tCIuhI1/Mm7EUrRhmSEw1P8JCFForBCAAq2dY+xFrzvqeu8RDfJ9Y3xs/AflV8ekfkhaOCj0BOOvUmHgWQzg7BC2zAbgp+NDIXA8aOz9uOADei908OJetVOSEIn42+zpC37fDIS4tNwZTTWODIvOHDhT6QYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz/EA6E+jzz/V+w9NVdpBAa1i2mp9kyjjGQZrT7mfd4=;
 b=WlAw6qV57dH7quTzoZEvcRkG5CvE2sZc03a8WWtHbGQ3fmbmntAccuOg+UhuhRNTKH6iMk2iCg3MmO4CR2qDdDgLmVItoVS21iEnrlg+wH1rr+xCJkmHCQIqKIovY3rFQSxbSWB0tvDUcMaUfpaJZRB6DJdyJvg0XziAyxHcZac=
Received: from CY5P221CA0151.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::24)
 by EAYPR12MB999132.namprd12.prod.outlook.com (2603:10b6:303:2c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 3 Jun 2026
 02:06:32 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:930:6a:cafe::94) by CY5P221CA0151.outlook.office365.com
 (2603:10b6:930:6a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 02:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 02:06:32 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 21:06:30 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Patrick Xie <gangliang.xie@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: sleep on PMFW EEPROM busy in bad page count
 query
Date: Wed, 3 Jun 2026 10:05:59 +0800
Message-ID: <20260603020559.1273844-2-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260603020559.1273844-1-candice.li@amd.com>
References: <20260603020559.1273844-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|EAYPR12MB999132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5457504b-f571-488a-6cf5-08dec114bb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: b9Fe/qQPEmQ4nt3ulBZBpolRPc09ruVkY2sz8Mrw1UNPfDzzQCala44e0Ln+vmhGo1f4mVUGWRvBVnMdeglWbCToOsdwWx+dv8yFigtKavZbWyFXjEC5SpgAi31cpZItd3fbNXqZAxGJaATZo8Dga2Nmy4IkvfDhHq1TZHqOLCF+B7p1ojO7ZQw4U/hGs0ZlIovXg6QHD8Bnav2qGRi0hnntxzElT6sDKwGAamXNyFSE964UAWk178ZQ1D1aY+13VFGP7K6N4/pE0kBJ9JSIM1k/i6Qk9ZyRmn691TJ/wFu3cKLyVE7dQKiGLdU6In6pk8G0sA2HlVseFgGTa08tYyuH5JS0Tp6DHKO46CUszWxvXWd3EngsxQpDAYUdouBFw9uVrxWoUvnD5N/oGV4WNvUDUk4cJgImCmkwubTuIgFyk9GyuuEWiCNPRDsaVQdleGvL+MAPGxwXJ6tfArZZHXmFyMVNuK0CgEbReYxHMxcbAL0lfqY2oddzdOkd8HcanFw+yLMc2xUwoaTb9Zr0K3+ltIiiiN+LPnEnb+Z3Wkby+zQcPVQg1IlMhmsd8J2v2nr/HwS3tQhIAgQOoa57e0TIH1cIGpSPBz3y1hYU4MABuBUhiezLSe+xzZpIMy0I9fqgvQ3ogvIe4QOty1JbV6DBhFptLniDcfQUhGgaqRndKLGBlxa3veP1Od5KtwTu1NxVbFHDI8I/WMV3grdl/+mve4GiWPZ4ZzG47jV/aeg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VcFf0IHbEBuOVSQdMgfFYlZ3HIuhJXHKIZeJ3fKpjjT4tzb4TKg7vCRj9Y6/GaHNFHMoSeBoK5dydJSqdq90ygzUyayOLC4wS/o6il/y7pG5hm+j87SewM1uuq0BllnOJuHvCwHs7lAodpPluBxKLUxPohpuHGxFdUy/+HqffJrDA19sSjWFg0VQXimQyH+BcWTEGNk/wAGYV8qqOlabtzSZgA3KGVPJMSG1EWbd8PJprZ0BoyabEK6icirII34inAMLaJKY52pzGI0t/KrshDJD3o/rpBLXzqp4Kui82lS8NiIRU02dWd+JdDzS33t4VvTvBoUmaWekYmFBaWBKZVWJhpesz68av5ndH1n6ix592dvX6e2IiastMUaxCGIQO+62/eQrf1JmyAiUxKi8rkCYygjgS1NpjVZww4SP+ATK9n2hlEfFT/tubY2K3805
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 02:06:32.4105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5457504b-f571-488a-6cf5-08dec114bb9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999132
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

Use usleep_range() instead of mdelay() to matche the behavior
of ras_fw_get_badpage_count() in rascore path.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 7193e3e4946ac6..12b57a0f4fc48f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -1042,7 +1042,7 @@ static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *
 		/* eeprom is not ready */
 		if (ret != -EBUSY)
 			return ret;
-		mdelay(10);
+		usleep_range(10000, 15000);
 		now = (uint64_t)ktime_to_ms(ktime_get());
 	} while (now < end);
 
-- 
2.25.1

