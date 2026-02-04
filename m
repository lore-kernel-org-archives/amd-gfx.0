Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED46EE8B364
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA8410E35E;
	Wed,  4 Feb 2026 03:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X+rAwK7C";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011036.outbound.protection.outlook.com
 [40.93.194.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E68E10E360
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OT858CYIJuHzxoKcIJ1i6M1PMxjh+0tN3LKogrrkcKkG7jhnOejKCyTUeCwS+9EnloGbRL97nxurP180nwRfy7mV7o8U1vsKCGPzNBY4BHHbAVLjHufQmeJwMnhNKpkWB8ItpsncDROkiyAcHRnzVj3s1aDs85REo3R9ZoY1t7jvpE62Z/qlAMPzHeKQM+tMxHsDFp/mgzs2zpVklqnIWw+uxYJ4wncLdhRYZeTG25BGnEp+noSLKVGW/bIv24mv9Kx68RlDaHZC5mc5k3nX40ubsp0Nl0BKDEmVOL6VBvru45/Bd4zpu2zTb9YnQzIOJDGO/0hOpTykQvvfIRPlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QMoG9kRVF2TkEJFL8FGWY+UNvL0xHbZD7JL/724+To=;
 b=tDWz49QuKopuTyXZGi8X9rFQ7GVtWrHI4U4eIhEPtaKIpTTviCYZbPpoYJ2L+bGJElzxrGPSiWoGSAft0a9E7fatqg6+CcCe86z+ky12hZA4uajPPDdC7neDkB/M1Zuv004+IBcqcpCU5pwYSs1U80ix30vWsHqLiOgWUDRykdfcdQettbKWI9MbbJMngcLbmxH068pQoDjUzXl4VskNQXHZ7K6I+xpJoUQzPkilWemWneSoM8EnpsONHgmiLcIMFTGfKaimGiKQzEkLWy7KE0XB/fChT1sFoon1kJY6aaVDDxIQPKBjjKpqwblmv/pFYtHMjr9MQIM1Ts8hagna4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QMoG9kRVF2TkEJFL8FGWY+UNvL0xHbZD7JL/724+To=;
 b=X+rAwK7CpQVmcMpHAFFv1j2PANo5j8cVkUo1ydEiNXdHN8qJu1d04ljq53nrA2OPlocv3hpi4FCfITE5H8VVNxv/HhESsrSa46Y9UvswwjWQWFwUtD5VCbGFBIukXKK6YEuOIydnrvkfmPWNdr/zSZrYZtUw8mHM21l7UMtqllo=
Received: from CH2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:610:4f::34)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:06:59 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::29) by CH2PR18CA0024.outlook.office365.com
 (2603:10b6:610:4f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:58 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:57 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 09/13] drm/amdgpu: Drop unsupported function
Date: Wed, 4 Feb 2026 03:06:16 +0000
Message-ID: <20260204030621.33369-9-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: e622bc43-e851-4e96-a852-08de639a75eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QoSuiVshTqYuA3CeBWNNRZeKfDqFJvH1PJNTeNa8mEclsdJSSskgdhJUOA2Q?=
 =?us-ascii?Q?1tb90kQCnO+wjAiLsKInt2q4Y6gBeL6PNewVhRsqHWmpnd74TtejZHgLLxRV?=
 =?us-ascii?Q?1E6LUjdLxL/0Mqhra6snkkt9+8MJDK0WmM6x2IJ58bvJ9XP8Be0ah+4zHmlM?=
 =?us-ascii?Q?dJdl/n4IbUCY3G7JOhy9EKX2w/y8lGj9m8GbHlu2pTMfscB4YXXIuISXo3JK?=
 =?us-ascii?Q?Elfdd6PYtkg8bRcd+3cVfQhZKVvbd86s03SE+43+9m4/RavwhwJBmDXCkuwx?=
 =?us-ascii?Q?tfVuHEWGk7GRSrOXxjlRV7HxHXfoo0Kl5LcUuVesE3N8SAMKbermQuSi5km2?=
 =?us-ascii?Q?KawKgWDGunv4a5ltxdwmUYNMstwT/pEDhwDLSefIRDSI3IEFRgY2FXOHD5/9?=
 =?us-ascii?Q?3R81pV5eZGNQfTFCW/bDaGnDCQOjU9B11OTrwLa3o1BLL9AFkLmNQEsPzThz?=
 =?us-ascii?Q?zq/szDPu5riMs1ikT9dru1fhXcXl+tDTBQOVSJ4oNhbep9p0tY+4hCKRZK+D?=
 =?us-ascii?Q?4qcX1rIThp/UkhVxR0s3XdEycJkc5hFIipKZnBKw959dGKzJSvexCVCmIkIw?=
 =?us-ascii?Q?cz9Cn/qQ5Mi9OyxJdFS+2m+os4wtbzNVQyx06c2ZvBIcUJ9vznS6Sh4J7Xza?=
 =?us-ascii?Q?4xw9l5x1A+W5WfNEQ9Dh4NsXj64uqwkULH/O0dFBKwLdAfSB7KTIQsC601me?=
 =?us-ascii?Q?LEMPVb5xSvOsE9bTZmgpT48gsVxK2e2IhvUr2LJcDz4HbD0XpmkmTdD0bbM0?=
 =?us-ascii?Q?NJSZaCLsFOJOD+BUzi50l6/Go9nSWxuguGo28iPlnSjPqYGv2lyv2VXRFIyB?=
 =?us-ascii?Q?szEMAljHGHD3yZA6u5hpxqDv+CE/A1/dmSS+4gK2OMGsXuq7gFdKHWgXxv3e?=
 =?us-ascii?Q?2Vh0ig9Y3jJITaj+6cOcks11+LcB2NYG+mkAZ9bBssjGBKhDmf8fwKbSbcvH?=
 =?us-ascii?Q?prkeYF/aTROa5jPo7E4I72/Y6ai8+8srm7CjyiB4fNP7L9jGvp+i8fF8s+3r?=
 =?us-ascii?Q?NpMY4yZtdTr+Q8un72g0KqzA7Vk7yRcNAB3LnyV5Toqtoo6XyZNCdJA1ZRce?=
 =?us-ascii?Q?G9ZIRQie3zfyO48cFoVDGZnEaOJWkNUurMDzTK1v6dh7E+Re7l0n6Fc/ah3R?=
 =?us-ascii?Q?GZnIF4nMWn5CxFgmCu7p6AX8BVYAv3iLvpGC157XI+qfX9inrc6nlSO1G0Jt?=
 =?us-ascii?Q?8918WVn5hZICssYUD4vvloJw8OY6+ewyIUSxl8VWA4ZEOpVl6bUh7nm//Rr6?=
 =?us-ascii?Q?Sj+Nxgr553OVgroek/OuCCgypgjdxnG/RvcWSzeoqS1WGyJXfmmU8ldd/NDY?=
 =?us-ascii?Q?DZmOXg3FSfNwHtnrJMgwtDnlxn4pu2ghGCOudKpMHGpCN4mxFg3O8+kj9rJl?=
 =?us-ascii?Q?3y0ijtAxS4uIwXkjSYv8zbvZOJg1txTXjrwdmUDAAkl4v9IGhPPu5w+1iwbA?=
 =?us-ascii?Q?h07MLwxYVwN5nGEOFmq2tfV9w/l8cemXLAp0fbsdXn9WGz20aOO/BLVwZsOi?=
 =?us-ascii?Q?nDFN+ADOpdxbrzWMltLgu26DZskWRSVPKY2CyFKdvm7XlJiKCcK5ZAtT09EV?=
 =?us-ascii?Q?57ZUuDzU7gQkE3/SpS6Wooh3MXiaFPbgHwthsxFJ7fa6PjzYompa9cjyA3N/?=
 =?us-ascii?Q?SEpywxA1RaYGT1CM1KJA1gxo0ZxFvVYPjbVaZHY54wdl/8NOYK9KSD5BzCTV?=
 =?us-ascii?Q?dmGaVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e/cy9p5d9oVREYJvzA+0yGl0BMSWk+grQL5TIiFJ0owppN3fXO4bDpzmZFnFh4z8y1Gm5Dsb9v/7fkuHvt7sEOpua1xsOOEpntPqn783Wf50s14iKEbRhSuAYyr9nL/nju9KVvz2Ql2ZaN1SNiBZmvKqC2TSS4u0mjIMyBmShbb1Wbs1XEYZExqtGqkjzVge6+RxpoFM21cxiVqE4yobFAGEN2A/VNzt+2xTCUZF0VldrTKKqBoxbTLm4ey3oqrkORRXS5GGb7b9Owugan5mYuThMkkwBbvBXbEEpHTQnHdqGC9zjBXF7NBuQrPTQO6pIX7DuFAr7TtXFjq0xdi6SiLGSD3Uj+5IhIZgEmYRM00pqXLdYtgSbVaVMOCSFQg4dPwg+WIItOQJ/ziXr/1txXQfwM80CJYJxOFfE1n/RwcN7Lbdf41OtmK6aChtGSGe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:58.7364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e622bc43-e851-4e96-a852-08de639a75eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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

drop set_driver_table_location

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 53c96b80f782..2fa55f22bb94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1384,7 +1384,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
 	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
 	.mode2_reset = smu_v15_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
-- 
2.43.0

