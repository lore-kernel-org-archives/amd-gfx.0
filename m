Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5490BCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A1210E81B;
	Wed, 29 Oct 2025 17:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uH53ubQA";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1D710E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkdH3BJJuE3baYBnaBX4UhkMTNiVwhZQWqFrdjZf+/+OKX/nGmRjhVwY1DcCr5S0nVyn+qwjjFwz2vbri1Jm2PdbVWQOQLv3/cRHBBljEZNjV+liOpKhvMbY4vxkd5kN/BTqIFnUiRbjR8w00SnATD3F8k4W+PdGyDAH5hQFKfawriyntJbES5WLmyLGqqzqSD7dJgUPXJlZuW0DB7Lnr4B96ZoN1juilwqj5lJGgkXTBC/1nKzlSmzdPhDV6YWolVB3Q7I5qZSxaIytk+H2xx+XIuXwAJSBbeThaMj8O/LZdEDccpZ+P9F2OddvttXZ8iGOsFKRRHPvTc7c+2yTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSX9hEQMSQQo3A+t6agg6xz9w5tkUVNFkW8dBAiFdYw=;
 b=dPxQAqPrnMqKVIDit606elRf84aa9cc8N84ZPXABDBoeitT+0ZLEzwuDLR86KrmvBB+VexI7UO4lfkWUFI03/nO4anfUeO1uirLIX+oN9BUPCPJM33GMcUCJsP33LzQE2WujugMlhs24xe3xm7qnWylle4KSoteY2IDehwZcPCqP4SlaDynwCbCnY2xjnaNqX3TfrWPnAdJfyx6XKeVlZ0QFExEoqe2AQmBG+5jNOnxGNhxdJs0apCfrT61aNDJDBNia9FJAYU4RA1yQ7q1glCNqywdZ9frqrxQvkpX7ix/FgqzA8AiW01DpusQstbBSxl9gvoDYXczJn+rl9e0kvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSX9hEQMSQQo3A+t6agg6xz9w5tkUVNFkW8dBAiFdYw=;
 b=uH53ubQANTVjeCjoJIAOv62DCarmD1k+y6CsMACoK/2JeNLcueWaohnP38siO/161nFh93Il2RpaeqEvU6wqDh8N3Zs9WvPNlpvzDHjyPJthD8L+c9H/bDgyhF6I6YNPlINNQBhqm0sA3Mp1xH8WRfl6vydNW9vihqPGkb+pQF8=
Received: from BN9PR03CA0648.namprd03.prod.outlook.com (2603:10b6:408:13b::23)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:56:23 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::c) by BN9PR03CA0648.outlook.office365.com
 (2603:10b6:408:13b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 17:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:56:22 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:56:16 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: set psp ip block and funcs for MP0 14.0.7
Date: Wed, 29 Oct 2025 13:55:57 -0400
Message-ID: <20251029175557.2862156-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175557.2862156-1-alexander.deucher@amd.com>
References: <20251029175557.2862156-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9969921c-d270-4085-c307-08de171478e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R0li4IuKJT2Z4tSkDIToubu10K5QlTSqJTtPysXp+tu0bVLogjNL8mtRMnUh?=
 =?us-ascii?Q?qUy1sFO7E9UhDVTVN4hadOvsaiVB+SRH3SZarbzCp6JaQXKoHIp7yzCFo74J?=
 =?us-ascii?Q?K8OT47FpyzF9gHm9abTy5KPI22UYTYqXOQhWESkTJsFiqB+tl05x+t461wyP?=
 =?us-ascii?Q?Qe0xq7R9Z3r1FYweGxvU8ePH8SKoaLaNWt/1Oj2csfcYmG3WYzktdKvghzFS?=
 =?us-ascii?Q?SCZbSWtYTZQt4J/sRf5gIW6qqeQaMLNqU3Ha3pXyQOY93+M0uKtykEga+9EY?=
 =?us-ascii?Q?YDtGMc+pf0SVhxbJvGqQfj83nvI8DvTCpnU2lhfwfBB2jaJ9xHYeiCiTCy6Y?=
 =?us-ascii?Q?YvAoehP0u3BQprtM8w3bD7z8kIL35My2FyNmK1opMr3urZ+V7JV/NEkT0ZbU?=
 =?us-ascii?Q?7Z74iDDq5vCv+RR1QKJ+oepf2dWayZ4Z96R+veMkOHwzMvppxCuPq6KDzKXO?=
 =?us-ascii?Q?vpVVcw8oJUCSSLb9pvsSKxSFMXbDkcvS4dgW5WlfcJ1W/fYAmjmMYnSztceb?=
 =?us-ascii?Q?Z5gdq4GNltHtdvEPdY9te//T5AEyUCDWv8jCTaK4ZV5pR+pGKtwIHUEUY9Ww?=
 =?us-ascii?Q?aOc3cAA53A0ZvkXp22DzdAy75bU8d5NuQgXCxWVygo1BEIbHdQdeV5jqm+Rr?=
 =?us-ascii?Q?aLoSmQMEQg0LPgSjF/n521FIjfBUQYBx2XXNUCs8gyftejc12qAgrg4DZbll?=
 =?us-ascii?Q?u80rpbhWe8JpzlkM1w2GPVULbceWdoMmI99ddv6UFoON6P5MISLwo+18o/oU?=
 =?us-ascii?Q?T+YeK1fQJIdDKCmj3UZ1s4ZXX8pCJxuWdL3Rx5R6cjmUtK3GVM2j8RS7udQ3?=
 =?us-ascii?Q?GwxG0rve7fAL8bcBL4lZPFln/9iBZdXMGKncT/EJvNvz/dQtQKMqteYIO/dD?=
 =?us-ascii?Q?WkutzDATJI5ncpXUKNx9gfyGLfKAnwHmIwqSOGjJBtASSGDgToib0gvcvLds?=
 =?us-ascii?Q?yYNRsYAs1hN70xESeDMlhvq/FwuIhUedHHuSkeweiBFYPbviil8oiMemGMwM?=
 =?us-ascii?Q?UIzB759tbbgitdVFB6g+YbFyzzpF3Z6z+yy5iHPh8J5kkNBNWOT7AiAImPGG?=
 =?us-ascii?Q?YZE/fsq6PUvKrotCsfnSbkLGArd4lni5Hxo1GSw/TtQoGkJjzpjdQr3wDX+A?=
 =?us-ascii?Q?k2CcJybXSMJsp4enlqQB92Ci+vvVtJE3IA3HoyjtnMwVDMvHERapqI9xotBn?=
 =?us-ascii?Q?WPJ3PDZYSF/9IznrYFu80Mjph9xH25P/I5+5WGDxijopVRyZQs3UTRgbOPuY?=
 =?us-ascii?Q?lACIEpodgIwPEgck/XQKgSsjXbZXhPS4EHmlE06fXaWk81lRPKr0//XZMMDh?=
 =?us-ascii?Q?M/k/j6474ZvvyrU4j5U7hN0yLJ9yewmJc0qSvzBfp0nWuv6sVnOGKPxieMXM?=
 =?us-ascii?Q?Trd1Jai+0G40CBhVIaugVsI5qaF6v0DiYj/s1ZrcfbS+yWoiz0WyxDlsBum9?=
 =?us-ascii?Q?iJJqwA1jL+wHY7Pc0rsLHyf/YhkkI+cRN8WMIc7TlVpA1KJacG/gftSTyAqd?=
 =?us-ascii?Q?QiJ/ox/tbPDMZ8zYSpD0PfT1FlE1+fJnXBqgobMQQZXLpXkY43ZpbskhepoS?=
 =?us-ascii?Q?MGydXVBrhmmK0jGV8ZQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:56:22.7736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9969921c-d270-4085-c307-08de171478e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

From: Le Ma <le.ma@amd.com>

Set psp ip block and funcs for MP0 14.0.7

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b569e574f310d..439815d6dfe14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2154,6 +2154,9 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 5):
 		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
 		break;
+	case IP_VERSION(14, 0, 7):
+		amdgpu_device_ip_block_add(adev, &psp_v14_0_7_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2d4bd4f2f9b93..475c9434105f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -39,6 +39,7 @@
 #include "psp_v13_0.h"
 #include "psp_v13_0_4.h"
 #include "psp_v14_0.h"
+#include "psp_v14_0_7.h"
 
 #include "amdgpu_ras.h"
 #include "amdgpu_securedisplay.h"
@@ -259,6 +260,9 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp_v14_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
+	case IP_VERSION(14, 0, 7):
+		psp_v14_0_7_set_psp_funcs(psp);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.51.0

