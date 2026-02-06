Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825BAEE2091
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE5510E74D;
	Fri,  6 Feb 2026 11:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37tsLDUM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B301410E74B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJc3ze8ACD6hIrBlgLjGm2dixs+RyJyvnlUknehfBuPYRVy/5lf/qjd2TqPCOoxIHPMFIYas3EPPLRcNFlLotzd65GD/tdAUWEuVmOkMqnh/7GHY8k9uLLbQZAzY3aqxx98l1THGKnNpN+ShuMN4JZhDATviKI0sWwDrsu0i1LnZ0C61CoY0yqXTTbtg2S+MkagGpjwuaNvrRw9sC1pUu3hq/8hazhZxNoiut3kXxZEL5UtfD6DrdLG6wrV13DjAUNqQy9V3J5hVrBMXzfU895SW+vt2OHnQ5uAh17MIDTuZv24GqkpEhreqNjLTD8svdujsyXk1FYqw/1BkAZ/qXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yNIceDIejOZXxCfTxdRtTCSa5pXsNT3lqU3V/m5YYM=;
 b=zHph0fldivrQFBZjW32XZnA66R/xHusCHIuhvZEtDzyGS/+cKRRq0NkpWrdObPMXWQhGg8JfUSd8WEr0KtAL1VZLkYfJ7veGmV5hEDZIpKtP5kc71aD9AKBAwp6fGE5N5isCb+ba3vW6EFcHFZa4g9tLBEdapgroZ1uflVmfhBNvN0Hw1JGItuGXCapKngSjUk421wpk8PuvAKAKr+JGZdv3lXIfdKAVTTUVmytRfz4UwTaL1fnRGlfoG0An+mlsyq6/mXUt44rZEUnh5FQJxyvX49w6U0EgpyN8ybsSX6j7nsenUSnOdCgLj6E299qsrUq12GyOjhTjlvwRTLDKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yNIceDIejOZXxCfTxdRtTCSa5pXsNT3lqU3V/m5YYM=;
 b=37tsLDUM8X9Oy+3F5F0QarU1zY9zoCtawLZvnDQFUZ952mIGUOih1jXbQniKNUw11qrysCzKmGLtaBFEch4O7Ffu1Qs6w6P7yjqF8/IBu+A5liMD1kuZKWKHYbcBdOz3Xi2HOVT4mo5mWYndy/amjYN7keS60ps7Mq/dYsuAj3c=
Received: from MN2PR06CA0012.namprd06.prod.outlook.com (2603:10b6:208:23d::17)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 11:25:26 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::e9) by MN2PR06CA0012.outlook.office365.com
 (2603:10b6:208:23d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:26 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:24 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 11/11] drm/amd/smu: Fix User mode stable P-states SMU15
Date: Fri, 6 Feb 2026 11:24:49 +0000
Message-ID: <20260206112449.45381-11-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b850b4-9466-4922-00ea-08de65726d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yCbt6YgS9hxrIfWnZ01YCmGnm/S1+rGX45C2eox8BILbmjkBRV98oAeuHbOo?=
 =?us-ascii?Q?C9ibqUT71NS3ELOINupQZZoCCHw1vKKVvBnYqxpY7k4lQjhwzmWwHJM6l1XS?=
 =?us-ascii?Q?Ym2ow4OlLk9wWwzgGGzg23/x0/jK+o1pcdrbnm+BKl6HAj/OUvVm4ljEzp83?=
 =?us-ascii?Q?Zq7jKwxDG0HJEFDgX3+iEO9AZXS9aE/30W3bOKVEZ8lYxfa2BzzMTidGARMQ?=
 =?us-ascii?Q?YcXpMfdNjk81E3Sn4vYG/QUj8qJSirbwyXpsB7V/Ipd2LulokV0/5JBnm8fg?=
 =?us-ascii?Q?w9aZTIFIue5RnD124pRpNiJPhCOKN3rHdYBwIGDQNRt4VVeDHlp3QYrvi74g?=
 =?us-ascii?Q?v+YLiZ43mVwdsr2tz9lHA62VGF9oXBYuKXsskju5roBo+IEV1w4r85qGSEEi?=
 =?us-ascii?Q?LtzV9s7JdqA+3PH9VRxT6gCv69E+GU6XFn9NVwGGU9RUsJu9LX49AF7ZgM2v?=
 =?us-ascii?Q?5m49k2N+YCVZfCRe1fISLjGk3ETIf2/O7HFDQkTegBhNKdYIgPa1TQrI29wW?=
 =?us-ascii?Q?MAyRfUEk+X3ROQNIG+Sw00WhWBnRpQ3aPZrV3yi9ihDK1gYude07IUtAVmRu?=
 =?us-ascii?Q?TNFtJN1tjmQdZdE7Y6IL4zKmhOFAI22C1RoGadpznpTISR8fviGt9rVl2HwF?=
 =?us-ascii?Q?YebriJ5Cu17PM9pkPprxm3bC6AlEERwJYXd56DTiXEFFbgNcOYDb4LsntPeO?=
 =?us-ascii?Q?0cPmu/IT9rFiyo3D55HdZBWYVxGn+1xHa8jeM3Rv9OF43RYzsDH7CLcshmR2?=
 =?us-ascii?Q?dpoWL4R9u9KBm4SgyO3nU0OpyP217lq11LJLPD6UuIuCtjl7/o77XLAs1c14?=
 =?us-ascii?Q?1Di6MmLecZN78xsuR2bFrLKeyEADSS6aPMHmMt0gvuVdn809jvjihs/xWk5+?=
 =?us-ascii?Q?XlgITWo2MruPy7qEWQws+niIrmSJk7t7gNydHtxSoCbt4601/lJlzQlNvLTn?=
 =?us-ascii?Q?JNEtEeYtX0vrOVLIoiwIyl6WGNBeQ9lMtyyG3psNgFkXHxeoIEf/FMHX7zdx?=
 =?us-ascii?Q?cZzAqqUuEsWeTGAsJY4br7jNxCfyifsdblPZ48u3mx38Po2n/dihAxXFCLEl?=
 =?us-ascii?Q?zttpxUj462fEniD41b/+tJBYLhk/TaoIrT0AzXuQIMZF/M1S7SZQQJffQOBo?=
 =?us-ascii?Q?C2+91vfvb800WZlYTf2xXBADp3WdzMziQIeDdQnrTo+5c+8UX+yxyO3tuGJD?=
 =?us-ascii?Q?JBIVmk85Wipg8QB8Bd6TULGM/FVEI8TqoSo1DyH2HU9HKvGqHDR/QroiR9JM?=
 =?us-ascii?Q?Qo6pupwkyNSGtYr932SiKofwyPjN2O+aSCcQrTVCCtvhyY87EgO20KC8Uz61?=
 =?us-ascii?Q?b/v14Gl+91Z3P6pubUuW1pKNa0JH3pEyMHHKGo1GdqmsE90/egh/HEjYM4Si?=
 =?us-ascii?Q?Kd9l4pldX6dpHQGThcf8L8IRwnoGu8O/+96QtF/ozHYDlmYOz1ooe1AufVo/?=
 =?us-ascii?Q?VU2vWA/WxGrUBv8ZwiuGMB/MtjXhelT1wjBXFKBBwBovb17g+8Y89zjzKhrz?=
 =?us-ascii?Q?h0rftkpM0AAtqkljxACu0uUIt5VUfiBt/SUeR1q0sAlNfrziR3IxPbJ0j2Vz?=
 =?us-ascii?Q?KkuhRqTZGOBLuLEYnza1vzrUtsTlCS1zZAbPK+HiPiVkVFEVXg9h97VY0r59?=
 =?us-ascii?Q?Elz9nVHOsC6fZVOQiXWDhhhVcF1DhsqTbFF3N8afDxaivd+wHZ1TIK83OIoh?=
 =?us-ascii?Q?n7iGuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F+1Yzky9GGVxFdOiKIcx0Ub4dlHJcwitTieZF+9gx/Pe/aVdGltiFnMjz/aEqbYOBvrlP/BCyenceazsR/gXCCQcST9SrD5IyWCTIctF54FIIbQaDqoXhnKNRqeQPIiT3/jGdJ2DATOIvbA74wUJ3XF16j/6fEpKI4KFcYYvitjhs/nWv/+7mOBVCoN0p/AGQQCNSacMHgc4XPxqjqpDjhszHMKEywxLAf+3yVJqoiP4o59MZV+/M3MgE6J2FbRdalJtFROLjAGeTmYT6djYF4wxC4xKNd9gdCcwaiWSr6uiMSgXHj2HxVrby1/xXPy73l0YFvVQauwCVKSLw7bkbyjrzvHPR+EV8tQNwAsbLLoaTHDA89Pivz6lDBdA5imGsPqW9P8YdD2AQblSXCbUwLDnn7gAVhAwHCwbaVRHe73zpzyhVmT05r05qCQ4uwqU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:26.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b850b4-9466-4922-00ea-08de65726d1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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

SMU 15_0_0 exports only soft limits for CLKs
Use correct messages

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 140e5b8c0489..8e6b7574d159 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1033,26 +1033,21 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinFclk;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
 	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinSocclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn0;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
-		break;
-	case SMU_VCLK1:
-	case SMU_DCLK1:
-		msg_set_min = SMU_MSG_SetHardMinVcn1;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		msg_set_min = SMU_MSG_SetSoftMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0

