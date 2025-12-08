Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFD9D3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8A210E4B1;
	Mon,  8 Dec 2025 17:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wMpLsiK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A47C10E4B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTVKUk9Q5CDAVdRJnUqjVAkuQThMX2ZRqOHHD9CmXaB1p0kOymV74hnIdfqsoVLz3BSMS0ObPwRkWXBgwcbUYcOr4NF9sUyNcOPPe+7SXswm6FDeS2FYpPTEI2UrIJcWAJmzzZhcgH60VT0Psm6fSZ5vtFdcDBfNfCTGXK1x995p0/HLAKV6cr3u6DvEh0aWSJicLQWgfAfBr9JFKXaReFZxAGU6OFTUg+1rrRF9n30b/EO9MzTnQh31fdWCWsbLmyYnO2DfvgIYp1CyEJSKAwXvs4yl56N3f3xpqXKU4kbzmrKeJSln+4lKKTEkpU/cWctG1uv70NioMAZpvmXiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6SpILBGfLtKsty1KRdv5qzUErCuxByrcv6cy/a1lhw=;
 b=jaBigZ7bAH0KZyyWbEquYiF04utzHWMRwpC7MVxqPX8s/qZT0qBkoRI/ILw50qDCns8OWEl9BxZyuV+VIuaYsatNtR88lPwlzwTpOueLmRcCUs7kk2J2ziEQXUldrQb7w5DYfN25A2+6Azxg1QPTDV/rofl6tz9gMsp1CEYvQ/tXKUmGhyW1Bw0JV0fCgcKPVFgffX0rDLhrCRGnh9ZK79CgluWpnZiQCywTYMDClm+0uIdhC9sDWcOAcjWqULurqJ2Ku0pjC9KuQsyQ+4LPQ87i6rbEew0gaaKwQJY49Na/b+lJp4u0nVG9nVMO9iFVFVRxx2LiECtnZRIxaZyrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6SpILBGfLtKsty1KRdv5qzUErCuxByrcv6cy/a1lhw=;
 b=1wMpLsiKrL07j2RTxVniypq5REiSQ8lo2xAICCPQco7hYrWR0+t++S8r4ulfa3y+rGwPT7xd/oA9/5L9wpAFv1PHnjEsVpX9hJIFnhH2v2ZyggDkdGd4bDMDQHED7spGtaKVOx4BlZSTcLBw8xocqyU1AI7OcG5diCyWQj4DwEY=
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:18:03 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e0) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:18:02 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable gpu tlb flush for gfxhub
Date: Mon, 8 Dec 2025 12:17:19 -0500
Message-ID: <20251208171720.153355-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d54420-1508-423d-6251-08de367dbe72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4NuwxD0/RkfvDZSZ8lBPt0oz1niH0FnuE2em2eG6xeRbAcg9KqElJQ/KCC5r?=
 =?us-ascii?Q?NIUBEDsIDtt6OVp524YUrtsycnT2z/X2rvktfITV3ZA2q2q/H2Ch706kXKpV?=
 =?us-ascii?Q?SYAx0L5sZbd/6Guyk1onUS89lZBwtlK/kPS8gWSH1SClgxox6IiOMiHvWlAS?=
 =?us-ascii?Q?+CUvSZK61RrIJh1gG+uZDUX0H1/yLJ7i5UPuhEHOa74Y0BEgrSdEncRfgUBv?=
 =?us-ascii?Q?XLd0nhvSmFYSS7nPNoCLzdHmFO5aEjmAM7LWwkGphyYoAXugsiqdavIgQ8aP?=
 =?us-ascii?Q?Mi6Xdkr8uLvhOZBfBc7XziLF23mvXKVfS8wqOPsGtGAnzzsNUOz/jIiKPOuT?=
 =?us-ascii?Q?8hGSX0OfQ6XsqbJeLQUh7Tx9Py8pOuiba2CZ3a/PJPowEBoZuvSWgcHbD3EY?=
 =?us-ascii?Q?66kww9ttrdYrG6qDKHyRgT3v/QPHghpXIhG5pK7y1l8CEbPMnB7C96xVJ71R?=
 =?us-ascii?Q?AoDeQwJq/GMIn3XZGC+ATjlcACjz4jP5rvh7wUQoYRjD16a9jD0IeWnO6Gqq?=
 =?us-ascii?Q?gZUunm4AgddZfS8OKk0/6Fhzv33JRwOGiv6oVkPwU27HfKW9XImUjj5Mh3Pc?=
 =?us-ascii?Q?rGI0JEigr29GNAPERezesCKdHne0JQBA7pwLJOZ2qugWnAgiCYBydoZrDAVP?=
 =?us-ascii?Q?cTGjCnRppP7x86ISPpQ0i76yc4YeHcQiYKz5rKY5yj7f1TTBBe0agueZHwqC?=
 =?us-ascii?Q?F+1jActXmqFUJzFhjde0kUjWrG+Pznh9z1rw4h6FFfbg9SZ3S/LSbvjFs2zp?=
 =?us-ascii?Q?6j3HUuvUt8hEH7T5MfHoU9ClChD5bj9KiSMluSVAHEkIEbKj1VcbcZV/KSAQ?=
 =?us-ascii?Q?c1ZtJiVF1Gbb5eCqFCfFGVPhwe5iTp5tsP9ep+dJ2yVPJ0LGZoyqdovqVgkg?=
 =?us-ascii?Q?8fFEfEGTjYTkzaz4V8R8DJvIO0Cm4FMHZWFiMsvUqOJNsdlUTh9xKEnnnwl6?=
 =?us-ascii?Q?USAIsNztMB17j8Us3ru8BF6nPoCIoXQ4H0SUv1EzO5BS21g+ZDxC5cffRxMj?=
 =?us-ascii?Q?BVrHAHu2H4WvBMZoiYT2kQbFO0ycYQXXRF1gb4kPFeg8Qlsv47h9F4y+Uq4Z?=
 =?us-ascii?Q?OU899xLuSqa1eNa4o85pPQ7f5QTPSWRDxr3Pxtow0yxrnUJOCpST6KhwINs/?=
 =?us-ascii?Q?BUIb8jEKVyYk0+/mmorCPRanTK89aUBx+SUZXtw8Swzra2D7WNRcsLQt6dwJ?=
 =?us-ascii?Q?XbvgTzXODEMAtJLu07jrSm5tmlrFPa7+Clb7xroChSPejsr8zIge1PmDQfr+?=
 =?us-ascii?Q?y95/YYpZT0/2xnY0wKBQth7ithZF/0Ij5NYg4ZfQKQzDVwXUeTX4C12NPEyE?=
 =?us-ascii?Q?j4SuMz/Da4Mz2P8WYie+eW2F0505UJRTyLXG1XLiDWteP8QN9fKPTXmzPE1Z?=
 =?us-ascii?Q?DMUKP7RLzThn2Zfze+h4SlnnpRcQtotCVG7bkfbsLNkYHMgXNH9CgZd2p9sK?=
 =?us-ascii?Q?t0RuSKbpAEOEga8NQA6J7FaCVBjXY9daVtgvxCUDRo59OZPwvC+ACtxq+Ekn?=
 =?us-ascii?Q?2I1NDXaS3VuxuC3No+qyjxXu09VCQ4SbQYpe1WaeR/cwLpI4GwlQAvfRv0Ty?=
 =?us-ascii?Q?cyYLeutbw/JO0bTJIsQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:18:02.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d54420-1508-423d-6251-08de367dbe72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
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

From: Likun Gao <Likun.Gao@amd.com>

Enable gpu tlb flush for gfxhub without check gfx.is_poweron
as gfx is power on by default for gfx v12_1 ASIC.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index e4b12b15bc943..77746dd9faa15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -307,9 +307,6 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 				    uint32_t vmhub, uint32_t flush_type)
 {
-	if (AMDGPU_IS_GFXHUB(vmhub) && !adev->gfx.is_poweron)
-		return;
-
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
-- 
2.51.1

