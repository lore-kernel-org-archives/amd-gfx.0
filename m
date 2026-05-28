Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F55ACD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFED010ECAD;
	Thu, 28 May 2026 06:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dnMELQDK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1265310ECAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtBtNX3/XmscLxZMDvbsm8W1nRcWR+9M519fTvdhCJGnYMFi/YH7TPMsJdr85EfS7C47qwAf5wFVG2/QvBBykKSZoHUlt/4dG3jOO/e0roEvLIq2WEGCcjPmGIIk7N0xU6Y7xeyd0gwe8EGsZr1mzRSUCI2tuoHCjZPs+sdCEsPqV0ysUnBvTQW6DnFVjwKupe4PR7Z9zK9nu6ZzZEvmy3TiTpZgkCvXU5keh22igLtA/2Idqdi99+010JY8GyKKaSdihx87Bep5VA9pkYXNASpPYt+IDpRkuBYVQhCvYKUdZJMWoawsVWZ54vOQTaiiYGtNR667dDfslk8U3X4wtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ys+N0bIVvyXmBUpkZnU7U6tP1QDJne06E0DUzPp1Fc=;
 b=edJIEffsC2VQlUmFMKgrL4qdQRE13TWvdJkbq/x7xPLFbCfgr9gvEDAo9wljR7z+BubZtAFtnVNSZjXp+RBVamjoWZJxJSJcBNjuObJ7AwvnPvP/apJVcMH/jJp2V82B1qpd6+kpqIhYYlKVc8KtB9H54+KFucN/VTW3OTtLnb+EJMiEWTrNNKIpY4qEaYoV8jauMSuOuxcepkwADLeyu44DZF/ADWiPNEzSBwmCdspmqbfsjJTleGvbs+ZRXmfxQv3RWVrDhzYfxtJSskoF+E4s4/oN6KvkbSV+rEHRWnrirKAnRM/yYZbBX4HX1mqsvOIHI5p5iCqMABPk7s30IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ys+N0bIVvyXmBUpkZnU7U6tP1QDJne06E0DUzPp1Fc=;
 b=dnMELQDKDgHy4Uf8vVsID1dsXaUl4XD58k25uk1niSYmyilJy5mX2aPhFeCu8EjYqTWsl+iunEveo0D6MOQimgWuteCMlPjOkl3yoQdXUVGFY19o5vl/wHEpJWgy4vHaajK8TdMNMmrMvjwUqTAgEsZziwGHdOJvmr3+RAFN2LY=
Received: from BLAPR03CA0163.namprd03.prod.outlook.com (2603:10b6:208:32f::7)
 by IA0PPFFEC453979.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::beb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:42:33 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::8) by BLAPR03CA0163.outlook.office365.com
 (2603:10b6:208:32f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 06:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:32 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:31 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: add support for IH IP version 6.4.0
Date: Thu, 28 May 2026 06:42:02 +0000
Message-ID: <20260528064206.12358-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: e483ad28-7a5e-488d-3d0b-08debc844bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5/h5nAvksIrB2MvK88tgYgMur6qoTPGV7YYt09ZYOx9f20b5Fii9OIQzL2vlw7QfXD9BsKFNc5T/NVS4Gp/GD0UqkDyuqSZH69+gOuHCKPqMZ6VJeXZe7rR4HtaNS6ZOhggfSI6pIk/VXdRs3+F9qQJkusPnKNRk5PlUkaWpXSsuxENsJleMd3jQAhqKYQ9D+23ow3gT2Mqj0jUmp81dpqigX7jjQPr2gD+XNT/KYsCd0IIxdyOz8NHgRl8qCyLLLb787X7sGVCms8Xtii2JdmoJYONS5EZV5iuRPppYcYtPRD0wqkrV0nO6vUM5d3ZtTZT6r/Khx4DnASz+RILubrYE0XxUhMED7E/6UC34Kk/COBb2qFRg0SY9IuwplepW76CIPy+Is6UbQ7iSajVVjKsQqnW6ph71xsU5DrLeElhUpGdtaJHxoaXSL98weE7xj5AF2Ih8todMLI4AfAoNVnm33LGzfKpm96T6VULSHf5rA8fb6qWRsztTnR363Id+ykityVDwLCb9GR6dAw9gOWwctBb/jjjaqHDHkOeCHaRrP30a2aA6UFty26DQkHKhvpkCXLTmmglfN7ftOudwx1Jbz/95i5Z7c3JPmDuoajLVn9fMkeVT7ZAXoQI4p7oCXKXFXLicDanH4eaW1FFKPRsela0StF/x5UVk1ory6bk/W6AkaHDmAur1rIH2QhRDOVzgqtReXixacXKu0FDVZIihC7HOtuO3N7tTBOEFF6g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oAj4dbnKG6JqKYMIEOU60ZSJhZHIz1Tevjc2p6kteJbmLInAmkpQAafYnF1fcxyFlg38FkiGkEPqtYabBw79Y3Q9UDCq3E+x7QQJHgYoKNvLWYDa5nXngS0NLr4iB77CsTGrIDTP3Pz4U6cUXlE6jtNaX1Fo8c/S+1yJhCM7TaRQk/P08tEIug92VgdfRA6qv0+GJRjWjbGVeKo9UA4f+eHdoZ4LQhH9YYnmnHxF8M3QMdfejwLmwe+eiKGAwWad/iFpuy2gr2gi5nBB9J7vBmKdq+IJi28BJ8Tw3/VoAMedBKpVDAXBPZ5rygnzR2H6cWKBh24UmgiCUirQwilA6PpDS2PtpwfqxLDv75eZTVju7JVGRDPbMswCzVaYGlGGC7Wez3czAEh6/dslmX1Va1ff465BN+qWFeBq58I55diQe1AvdQoU0YN+MwkfyXXU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:32.5878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e483ad28-7a5e-488d-3d0b-08debc844bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979
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

This initializes IH IP version 6.4.0.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 32ceab25ad29..968cac5bcd5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2206,6 +2206,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
+	case IP_VERSION(6, 4, 0):
 		amdgpu_device_ip_block_add(adev, &ih_v6_1_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
-- 
2.43.0

