Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E1C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 05:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9111E113188;
	Wed, 17 Apr 2024 05:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2um9+grF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD74C113187
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 05:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDsTzMistexSiG6XdbWXl6+a+lpYNF8+qNRkahlSM+sAQXzXcDhrc6WyDUplS38yRgzy+SsmHGVmekjvQR7eAd70kcfgWhfxq5tuA2ZRoH1JPUp+Oy71BpWno8k3+uZKRNWv9PNRuzbwByK8UyN+aB+xWTNI9PHdQOK6hWfs635/48hu1PTBxjdgcVc3/eJpe72QzLittqJIR4iyTETMnOjNPyHXOhVqioBUH5ETHQnX8w9tejamK5mZONWZodEdHCJo6vr0RFF5Tq3M8ZkJi2GgBQGpEXmb5H4EQJPm5IeCy4XtG53sWiYDRikbd87Nes635AUUhT//q7l6NAaimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ/W0dM8rRp/k8V78ApZ0wBhhNX3IeXuAPjiaPAl6mA=;
 b=kUa3Ph2oX04GySE/jwxFr+adS1A2YqnD+J/VqPG4f465cPZdlXGyvdBlYHVXOXrE0aaicnTVu8aJ/nNdYuYLWEKZCQVOL3jyFcj/d6FImavbspR5+cJGEq18qXchi6mQ+7poZtOzyBUiDSnIwRmS/tMT9/iMhR6wiZm6j26M5wN9QSF44RRH/BQb1v7XYcXOtIXDWbVrgFavWdY6fYWK+js3O4UuOloXv2+NFhPUNm5OUVH8xD9WhCsbUr0MX45bnpEU5bjGHUcNdpf/TGJQW1uSKxtM2fcVTWN9XvkvYr3/pZBi7dXJ4/9C4nDxZwsTWajG3zCymDw2GVYtsmtrEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ/W0dM8rRp/k8V78ApZ0wBhhNX3IeXuAPjiaPAl6mA=;
 b=2um9+grFUe7nzo/3/F/eJZtq5MakAPwI8juTVgGTfXMf06pywg8k39DKetORB5lpBkADHtztfI1t8msIPFozVaT1GGV8YXArFS/2MqBrbOhzyGvo92Aofhc0c6zpjP8ZfDnjMRPKNeTynaX5nSPPkdgDsrB2m16+/0kojEloZfg=
Received: from PH3PEPF000040A5.namprd05.prod.outlook.com (2603:10b6:518:1::54)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 05:54:18 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2a01:111:f403:f913::1) by PH3PEPF000040A5.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.19 via Frontend
 Transport; Wed, 17 Apr 2024 05:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 05:54:17 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 00:54:14 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Remove gpu_od if it's an empty directory
Date: Wed, 17 Apr 2024 13:53:35 +0800
Message-ID: <20240417055335.118441-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfaa87e-862f-4e05-fd8f-08dc5ea2d1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h//PSJs4T/jKSSTFAil2k78Wj/TA3eVdDqDVgJF6GGv33A4mfM464oyHkgBhr+pitKpcMtx2GQwYVow+DRM2pZ4idmnberrmh4V8LYwQpdSFIn7yVT4ZtEnt0vEPGrUk+sB5y2mW/GkHJ1nvsDEjwFEdDRohyxJTuidPgunE6B5Z+nTGGcqPo2XPcNuaNqXXJa+GUcyvetKQ6pbauvxaFe24mlcD7qLr1nAaHj1bGW3G3XIDHSVG4Nd6Oh4s/b+BR0dkYQp8g8rj/txGvdmeJB2IWrbqKgTHws1uQ6sZa4ERuJzvK4fSe13gcLxpN1rl2PULOBXdYV32UOW1ojceK7pxveS6IJLyAltWENVG9bYPMyEDfSIDgup0D2PK1tg0aBHxnrbj7iTve8yZINXjzw5YaNYabV14/RU4gqUOV0Hy8dSQ50ur5RaJ0ETjuI1YUWQeah4eCSARSSu5LvLUM5YVC41YhPbU/bVanVKd/Cmzu90e+8l0oENdgq6f5GB9PRNhprRqY4uSF3qADI8Ep6E3h5EB60yrEiwKp+r4vBGM3Zp+qE9z6SU332mDVjazMCfiHqQd2yd7ex+yyW8H+CekLInjVe3LuDzlhBbB4lfwptj/JfF6sxjqsit4u+3xZ/MN8mTkSqPIPaWJ+zIhdkVCvBXQ3p+Y0FioknealIVGXW8npSgd6tPYLvtuzEFyYjDrxJQk5atUUc5Cm3Y1CHeVeEq6wxcg9J63E6bXZ/96we5GU+oiKVpEt+XVQ9g7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 05:54:17.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfaa87e-862f-4e05-fd8f-08dc5ea2d1b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
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

gpu_od should be removed if it's an empty directory

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a20e03e69d38..0c13e5520e77 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4338,6 +4338,13 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
 		}
 	}
 
+	/*
+	 * If gpu_od is the first member in the list, that means gpu_od is an
+	 * empty directory, so remove it.
+	 */
+	if (list_is_first(&top_set->entry, &adev->pm.od_kobj_list))
+		goto err_out;
+
 	return 0;
 
 err_out:
-- 
2.34.1

