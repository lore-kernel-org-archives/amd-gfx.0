Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE10FE6BF39
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 21:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0FE10E322;
	Fri, 30 Jan 2026 21:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMqlyvC+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586C510E322
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 21:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQ3eiaUYXfdC6KU8puiLTBsGRFrnfBUktk42dpX552+aN7rLP3dIdzPhY+yXQDl7LxdeJ1TCNYx40yD6D5DDNGlgTrlxtHnOYz+S8S0+ZYDbtX4u555TaWvyp2r0ZTdAxTWAVXvDyNG4NWjuXtArxQbFNOeR7nz24XhY1QkVErsXpWnmuwaKtwgZpVMlVmcOO15pDfK6Ytb6/EE0XNdT2OPyOKVhyQRX5IQh0uJnvt7CP2nXAaLd5KjGVwlF8zNtbV6h1tjtpNUQGzhEOrDNRnsxAnqAo7aPWBFNCcUCgHJ6yCS7ofBEBrfE3eMZdI++apzQXU4LOS7sTkdTyTzSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71gnIltDkr1Gtz5QPWEb1Z6/FmEe8iCJMhafEykXb+g=;
 b=G5TbRA/30QoDcolOCxApnqNJnzv/oyEx6RTc3AohMX/um3GsG2/2+ypliZNOXjtnwMgTWnzIMjd1saQYtnjjx1RpnTCDM3arDW164qdGDRBkcZ06lYBY0iG0yJPo9t7GoxOMp90707BpL57SyJgLsErB0ERZQULzdOhcbhZMi8nvtT+1C1ZWmOFN2kfDLNKSxbb7svrz1pChOlNR3qx6VTvaTJprlKGBOriavR99UUpu4ldgPEB93y/wG52n23iOaMUt65i95BrFnS1WfRXhvNsOqUaFaampRaIut5/KeqrSSPrKh6QMyBzmBrFacDy0dsCGTyNGfs0x7pBgdC36Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71gnIltDkr1Gtz5QPWEb1Z6/FmEe8iCJMhafEykXb+g=;
 b=TMqlyvC+ZU+w1mjW+RTxpy/fl7O/w8vhL36iuEwE3rHARBC5I/6cgWJYRLcrFuaJq8Z0cgYL8aTwoLZyIRExVR/iazTm3iIOGgo3odNNQa7TICVY49aQledRdxwIUfgkZfaswWlo88iILjXvYae+7zWqdStRa3iAM/OhyKcIlEI=
Received: from SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30)
 by SA5PPFE91247D15.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 21:10:41 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::ad) by SN6PR05CA0017.outlook.office365.com
 (2603:10b6:805:de::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Fri,
 30 Jan 2026 21:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 21:10:40 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 15:10:40 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Move CPER init before bad page load
Date: Fri, 30 Jan 2026 16:10:29 -0500
Message-ID: <20260130211031.446011-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: 4766b9c7-f4e3-49e5-0069-08de60440615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p9IkjhnDGBoP2OB4j4WDOGpdAInKtZYpYJ3BuqIoepaHM6YpqWzUqCtfW5h4?=
 =?us-ascii?Q?bbCZZEwBucWjtyjvwfpA95bR4C85JK0aE1t0yEohjefx0k3U8RwAdGS/agKC?=
 =?us-ascii?Q?GMhc8TYiNa1kEBEPxDq+97kyGQUMJRi4aFcFWzCxZ3vRMOeqgF3k+2ei3da7?=
 =?us-ascii?Q?finH3jJvkMArFFad2l0LLeFkpQM0aRnm0ZgAiffDT0x+/r6V0spxMJTOHRJm?=
 =?us-ascii?Q?zuIoQILcXOqlcf6t/H4ujgOtQ8EekCQbjPua/usO2Z/j1Oi/XohUboUUS3as?=
 =?us-ascii?Q?WsSMEt1NFh1GSEhZ+4OvT6jqLN/XPXiYO5N0T1AWe9jdJ4XVw2LY1aTh/yKU?=
 =?us-ascii?Q?KxWgtNF235ULzRRhHWIE7dON7tsOX1R3yyB4/W0qJ1DzOX+WhoNpu4XmP47u?=
 =?us-ascii?Q?wpyMOj7gh+FzkcxTgxggDsekB5cyzlU2QL7yxpmw/266p/iQSkrELonF3D0J?=
 =?us-ascii?Q?RXuveKSaPZVOKjdwkMqXMIknnIq/4K3MgOf1FK6JgzI/hnP29yv53MJzYGM6?=
 =?us-ascii?Q?NSIkKR8ahLEw3nLXNskrxdcVdroxuTkzIvzpquAj1z0llQ2TwuVVIL2LNdME?=
 =?us-ascii?Q?yR8YoJ8505/0Za0Qtz0Ubs/74FYgWaoSbE21Jk0AifNMLcPP4N0xrESvjbSR?=
 =?us-ascii?Q?TWaWdX7WGuI2z2h7b+hj1eGV4hpcOs+OmOLEOvseDN08hnyAuzauEa3Ae2LR?=
 =?us-ascii?Q?XB76hmmRhZPZOp4R+b+oCEkE5k9Nsxe3IHmv/tHrk02yU1lgGO/QKZ91rR1C?=
 =?us-ascii?Q?l/nVOQkSDp3/YX2rVxaDe5C04iAgLhNNvSSPnWHVdhmQHlGPnAp0ggTUksze?=
 =?us-ascii?Q?upHXjUkflS2smXAl6SrzaZYgYVgRxNnPQodAg+gqZ0r6CdAMDGexjL2tWiaO?=
 =?us-ascii?Q?+Ff/Dg0P9s62TAr4c4C9zBXOjdf6PL4oZMqbqfTbX9xcbae3cpEeWGC0ha6v?=
 =?us-ascii?Q?3XC1pcHWpyZwaNPjSeWjyfeVoay+dMM9633926PTPzKhknFM50vkFWDdEbUF?=
 =?us-ascii?Q?3Hz6oin1nMgyMAXGD6H/J9PiDHAQla3ZLmZWDeLBH4oue3aTT2vE6/sWqFiW?=
 =?us-ascii?Q?EcithmnffI8MRY9e7jgP2jsax7gwaNXRRepq7r0+oYY7PYt3wC1HQiOc7pXr?=
 =?us-ascii?Q?fFPwu5g+0WRCfvC7WmotnGIBU5qSjNbJ0Lk4pXeWe1W0JDOY+Jy7FdbAs/sG?=
 =?us-ascii?Q?cP8OVvxJ+j7StNd8vAnXf/+P+gvafAq0wagPnHa60xySQEslSAjOgY9wJRFI?=
 =?us-ascii?Q?bCKRSqztOKNBKh/W1/PtEFsWo+xOpG+eTmxAivYuP02jlmIAgq9tpqVY/wIe?=
 =?us-ascii?Q?7SNnujd9rDjLAi6DcYZtHlRAreuoPoQwTBwHlmXX7yv0SzEEtPSk6gBbgjD8?=
 =?us-ascii?Q?Qb5rxhqUgeT8nDrE4DgmybjHekNYvB94EvYaJMzOllRTcrew1shhnad3VPkE?=
 =?us-ascii?Q?AIaRehrj5typwXmKDUTcmmq5bEibYtYzuMEXE1l8JzjzNYBLOqK3g2dju/Lj?=
 =?us-ascii?Q?D384q7m23bpzLdjq25rnxX7zai4j2/7RitE00LvWXSMyeNsVjiCPWym0Y3u8?=
 =?us-ascii?Q?lc8QOLpyGpd3hxw8ek9erhrXonpJUvc/ky/TaINEwtjXVCKHTjZR6gKBhjVQ?=
 =?us-ascii?Q?JIITomE4XerkqDX4g9JVU3M5+kLeImyDSxcSTEuHxCqwvjfE6hdL/yLT3vIZ?=
 =?us-ascii?Q?7/s9Fw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SjAET5YVJXM8eVkF/21yd38a3lehRbDo9QurUrrfYu0YPIo0ZHUVnbntdB3hsQYSMSLJuc0IUL35+92DjfqvSZWCTI78DARKpIeDEDDQ5jvb33Lg96s2+An1S6ipzWzl0pj3ZbOBW+Z7aWndBXA2Jgxcl7Gt1PxrNzWoGFKSLDNy1IBRS8ZCWDJXWiowsxQ91XnBR3G2UmnugMqrOLYikXkgtuU0FetCyXY2YDpUUYKorSyhlHxJJsO4pTJScS2s75iocr9PovP00halWiRGHkvTBma937Lx/ggVSCjfuTovOIuSDZu8Zzxm4152nS+Y3RNgGj0fh41k9V0tNLt/yRTEf1gZMX7vBrmYS/5hDlAS0DbVIPdxbzeXRJtv1nXADjVNZnPKcU1XeQOuoQdLpS/8kWeVjgvmInw10CQLqey3e9xTHZyCjbdnYr0xEEGk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 21:10:40.8890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4766b9c7-f4e3-49e5-0069-08de60440615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
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

We want to send CPERs if the GPU has met or exceeded the threshold for
bad pages, but we need the CPER infrastructure to be enabled first.
Initialize it just before we load the bad pages

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e69ab8a923e3..5459a67529a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3106,6 +3106,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_cper_init(adev);
+	if (r)
+		goto init_failed;
+
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
@@ -3169,8 +3173,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	amdgpu_fru_get_product_info(adev);
 
-	r = amdgpu_cper_init(adev);
-
 init_failed:
 
 	return r;
-- 
2.43.0

