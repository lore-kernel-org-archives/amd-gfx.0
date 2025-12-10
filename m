Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47934D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85CA10E68B;
	Wed, 10 Dec 2025 07:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zHak/cg3";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012012.outbound.protection.outlook.com
 [40.107.200.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DB310E68B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QorriRl0QFlkZu7NeGrILN/wSk6D21MSR9tuAhTBfZh/IVYcvK5VsRuSuK+lGvuqT3u1f4fCRas4rPRtGc3BmmiQdUxRWhSp6RMGmDimsNyg/76oie71VjqhpWUWiunzb8rW8hjKD3yF9Qohm9HF/P3oAGsajSXMnu4w/aJt4/nb33XeaWBWFsyfCp6lovGQS/4zyRDfEhOChWrTyfJ1xd/6kj89fKkdNxkHHfIycveLwNXtLqcKhuZQcsz2APFEvLpXPJvU5yWMjbX9pAv0GLt/IIopQ/DjYyA8CYBz4zw08OrTDE7qeHf/IE55zfOjqC4mfdQKsckQFAKGf8Ud0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svckNmxejQcZv0TJb0ha/fRJn9NgZYfhwkywpxfaTQw=;
 b=jcynnWyDgtTuFeBSdS135UQjRf95Y2/uIcZJV+nFhgURXlT8DM5BE/s9rooAvz3D3MdYo3/H1zDqE39PizVYZL1IOE9TlwCV2DRMEQh61MN8NdJaKVlGLG5a228frfkNY0+rlpYTMqC5hxNmZRDPiT2t2iFQJYyj17epD3uMDs2RZ+Iq9xpPC15wLkru0S1YTadv62hSE80Nx2Jrv7I58OxpSghE06fC8LqpAV7WLqxXbTjBpO/AsxOxRJSej50WgS+dV2n4+N04XQ3d3Jfh8ZzAlmLrKZb+ITyCK5LXnNiIGmgziVUJNaj8ZCuXrkKufUMQwEsgxmnLV9E/it7oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svckNmxejQcZv0TJb0ha/fRJn9NgZYfhwkywpxfaTQw=;
 b=zHak/cg3dAqD6dk24bjSGS/cSSyMm2BbejwsJlYyXsXdJiMRmzjB3uIqDwOEh5odHrOanhJJingq+MPxtcpqZFqCQWztux1InObgXRlLwB7pkElAMeaqPCcq6Z7J5XRK0Qd/njF+bMIbBzc3cYA26Iil5rfYg/kBRKa2ASEBlYo=
Received: from SA9PR13CA0041.namprd13.prod.outlook.com (2603:10b6:806:22::16)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Wed, 10 Dec
 2025 07:14:40 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::51) by SA9PR13CA0041.outlook.office365.com
 (2603:10b6:806:22::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 07:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add gfx sysfs support for gfx_v12_1
Date: Wed, 10 Dec 2025 02:14:11 -0500
Message-ID: <20251210071415.19983-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 998a0e92-fd14-4027-b5bf-08de37bbc8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pKGVlxuaXPKLJK3JolPnWGJE/ICMH/IFlNGYoiPrs2XdS17nMDLZHH14fWMq?=
 =?us-ascii?Q?leRjfbRWncjK2UUm3gonpEvBhntk/RTwxgDmZ5xDNjI/EiTpuYS3q6/PRcYk?=
 =?us-ascii?Q?OPhzLmrd9lj0g+FpfSEetJErcmPd+Jbnm1OvB7pbfMMaCkMTrres+wPpbjpL?=
 =?us-ascii?Q?QK8jLmQoVDSdE3MAlM3/Hfxe1Psna/D1N9kOR7pSU+JZxfzcw7lvNMo/gY34?=
 =?us-ascii?Q?lCkEsS8vfPKqjkb47w/MRR9vx4nI3TJQlvhkPZTojN6cRTnEptkK/+ztuntS?=
 =?us-ascii?Q?rxZ9ITZQCV3upAY271m3MziTnkyc/hyCmQ6bPn5EPFGKUXFz1Qm8j9odfn33?=
 =?us-ascii?Q?K/NsucVL9Y2FSa5qLS+CVctSoVSc8FBeJUy3OUnh9cJPVjknpJ//+ORVhTNQ?=
 =?us-ascii?Q?c14IMPzJ7yyyisa4oLY/wZN4tMs4Op9dSdQlbm8r6hQT8Pys4U5tiOGKpy6E?=
 =?us-ascii?Q?1xDBkI5BpTRZdKTDP7WI2oNYhvrQ9ldhHueiwBOiTUp1dOQ1/fcP8fLLI4ak?=
 =?us-ascii?Q?pe+VJUqjUiEkReLcVlHStLfRaSNSoZmE/yOXAKvrMSsSvpGwYFUkesQtU9KZ?=
 =?us-ascii?Q?RsmFHJblTTNhbWC0iEkp85SYSk7sF0HK03i0CLnoavpqVqfnICuW7il+C95q?=
 =?us-ascii?Q?kqUAIuqBIcl19Ch8c21bdMYi5rSQBBNVIgr+LPgFacvv76fr1a5tiqb/cilA?=
 =?us-ascii?Q?4v3awKPq2sKZLnn5vlFc0VWZEzPVOgMQS2PsNrT4toStwJhtR4NaonMDhXEU?=
 =?us-ascii?Q?C8/kLsIeZlEMOa72LpLuU6jOw2MLO6fYmiQqmgT+mK32CHj+PgrMsezC52zI?=
 =?us-ascii?Q?4k78H/me8VMOf7rI1LAIJHER6DbRVlXcSLJLSbSTJhezSB6l2PA4EmCAk0Hv?=
 =?us-ascii?Q?N7sESVLwOXoZzKb+2VeedbTkbPl3g8ZPXCkxiJhj5ua3f2ChFIrdWZPQvbA1?=
 =?us-ascii?Q?60rlEKijtfbrcd+24CUcwEexGYbgK/a3vFW5/dJTjXs+8m4zCQ/YWobcgreM?=
 =?us-ascii?Q?NtRDMKZqMKafb/OS5W2n0uNopSq97bHPMuxPhBhqgq0IGIZ61RU6Hj5Os6xX?=
 =?us-ascii?Q?stwD6gEKRt9B7JQJGp5uvjX+IhGyBdpOET33qbtr7PKPNNCChNuiHojZG3ig?=
 =?us-ascii?Q?Cl6xEu73LiGFNhF35x12mjCZcvHHK5cB0OpUwFvKxP3PCXDoOxCd3C8Z5nHk?=
 =?us-ascii?Q?Y77axnE7o1OJI6V0l6Ue8Bf3rjwWVOrGX5uxFKqK1qXjp8+ZJFzfArlToXMw?=
 =?us-ascii?Q?DVQ/c0DEeqp8FzDIPb8I6NCVD6m1zSH5KpOxVWbmDumqpq8FkwjQEQ93Sj3g?=
 =?us-ascii?Q?9Ns4uUctb0FVCTd3M954fFk5bJag+mS7b1JXIdvRmjjNa/fuGqA3W5iznUax?=
 =?us-ascii?Q?D0fELjr4FjL0FFRRl1t0KnmtZ5SEw3U13nlNiB9IkS+ri9O+god/quUnwIMY?=
 =?us-ascii?Q?E5p7rbrqaTiNMd85wQpjxKDEV0l+F8vdwzhbNc4w3YGgYN6U/eioCGGXX80z?=
 =?us-ascii?Q?zfYFgonnPd0ux8wTIEWKUfotyr8zriSwzzJlErLzRFq8YOdBxG5mAUfc93aa?=
 =?us-ascii?Q?dGg9mFbNuQc2Ywv6VQY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:40.2376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998a0e92-fd14-4027-b5bf-08de37bbc8f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

Add gfx sysfs support for gfx_v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index f4b31752c6530..3a641d223ad68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1250,6 +1250,10 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
-- 
2.52.0

