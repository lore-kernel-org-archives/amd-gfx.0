Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD63D3C529
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EB710E685;
	Wed, 10 Dec 2025 07:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UMxFxMrF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8CE10E682
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuUC37iPETFMG3fnDH3cvIRu2vv8E/P3kKn24b8xuu+X7LVs2gMyNrK8szPxQVCcdgXaO5+SauRTLLad30aDAEx88vjoPPW9X/czye10yRFKMq8sBdR3bvlt4XCvUqiP6SMp/W+ETYLIjTsNlBrPKY8FxyooKnEnMr+cvV2suNSisZx3IT2K7+uAvzTjh37voFuK3ZVw+hTrYYOf0AExxVWMPNMO6MKVb8qlF5ALw/nONVQ7jzS34/XxDnqDSWCit3GjIjWUHK11cr00KZMAMTLs/7WvtNl8wRcJyny8iJ1EdaZ1HatfMxxFU+ep38DtgPqMlMMB0gNngrV5VGVZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9qNnMC4dPPt73stkPMatlGpGj76ela7LryCwSE8piE=;
 b=HUewQB/9uFJB4/MGwoD8mUMXYdDRhz2NNBjl7gVkxf7OpdUqiVRDbUVtPgaFol9YdyF5JzslxZhFEP++psxMgKtf/nBgYbBc0eEQY/YPt5z1PjAWUcHKk7g1uGwsuvb9TGtfl4o1ZPZJLHQgj+fBYe2DM1k1gav1hai8Csv9LXFmR43xHl/Q+sG0E5UmaOposSAh0qS+RsTsEwRmCk9LEslQketwzsQ28ytetogBOokBZ8mgzkNmARWLgfhvSbtaTf8JNEXTCv5TZb9QktbJ6LpEJOpm/C3+X7VCsbpBX5bxkyM6O26VKwZN/EYLEdT0HHxTgts9K5LJSvxSwZK7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9qNnMC4dPPt73stkPMatlGpGj76ela7LryCwSE8piE=;
 b=UMxFxMrF4/B9AWQdz99rp64HlIQJRwzIa7k3oclfR6wiBAIbVsNI1UKz+mpuY4Piz9IKTd8tc3xER8Ad/fynWlJyO8dETgalkx6EJCvrUoQlt22AOnq8bZCEGXqgqjPu8CmE8ed71ZGmeb5cBSz31bo7eQU6err5qEb6lYJPMMw=
Received: from SA9PR13CA0050.namprd13.prod.outlook.com (2603:10b6:806:22::25)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:14:34 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::bb) by SA9PR13CA0050.outlook.office365.com
 (2603:10b6:806:22::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:33 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Support 57bit fault address for GFX 12.1.0
Date: Wed, 10 Dec 2025 02:14:03 -0500
Message-ID: <20251210071415.19983-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: efe62e2d-b985-4752-23ba-08de37bbc520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GSJtb21GV4eeTzRQRDfjGcpqwA6PZsk1sdY4ysnBu2qa8p9AXZjWigJLCGsn?=
 =?us-ascii?Q?LdeJ5jkUE423HTMnzV3WZJTig+IyixRYPUi+toGQJIr45E95sxAxP5IHArKz?=
 =?us-ascii?Q?0uzcs579cP5MgNfi+s8pEW2u5wjo45wGqK4zGB7HY+LVjdP1giIYJxTeOhuQ?=
 =?us-ascii?Q?A8kGHwa1Lbad5l3Wu6arndL2JijHZ3Y9ZTTvNE3yTxr/LExcUkLw0DB1KNFM?=
 =?us-ascii?Q?V1xokCbtwsLbM4etmqfG4dVB/9x56t4yO7tD1n3dmYSE6QXPndhpieUX6czp?=
 =?us-ascii?Q?9GySkfQTs+Xp684/9htDJe8YP72e23L+I2Ncb4xnTGATIcsdeRcy77rr7WWZ?=
 =?us-ascii?Q?jjmFYcwYhus/lWO1YVyW2bkJASbMZGggz8fyRxk1xvxHS68orTEdMDAseCjX?=
 =?us-ascii?Q?sCzGREvfVHISC4AD605ovzn3iqzI+U2io88EbwF+skPaQIWFdEOpXqrSp/LP?=
 =?us-ascii?Q?79ajM0Hvc8Uh3KtsMsT0hJGKHy5+bCWmtBxVNN1ZmQ+klc7RiR1X+bY+sAqy?=
 =?us-ascii?Q?htdsQVnzYarxKXD6rc08sRwOghir3k2FqHyeqlfIyVzRWk2/PiWw1/RtjiYp?=
 =?us-ascii?Q?FE24q3xbhZJeGfuWh319wQRbnGOOdmFZjopCIgxwvsYH2DIIKPP7etU7/Xq/?=
 =?us-ascii?Q?sm9uVw6y2zJSvNgncVXrBRibefqK0uuhr5vqqJ7AYp6n+hxuUdQcJ+HRswP+?=
 =?us-ascii?Q?ZaT+5nG3mncEFgJVx2lMmzF26ugoSXeHirV6P9uclvZ38v71M5idf70PMHsS?=
 =?us-ascii?Q?rHDwr1iRuNvZ6XEvGCcFXIVNCQPpE6O0MkYtBYso0V+nUUNJm859LnKA4u4U?=
 =?us-ascii?Q?xmhkT4o0UHSH/E/lbxnKuawzyqtdKF8QXzirY8IgMznq7mC7yrdEKeWB5sHm?=
 =?us-ascii?Q?kuv8bxrA7XPv8TaJ6fT4awmoSLZZyOxrkbByjxnEbFEAYBGXFcQLfhHMC7xX?=
 =?us-ascii?Q?mo1whYLlBLwp2RGTtC5uBiEwoDLnoE48bBUZjDb3SGwdu78v2Mb+gezthlWQ?=
 =?us-ascii?Q?Th1XAx02lgepCsDVlt5tpO+5xHu/BtApSifHJ5jeoqdfouehTsSsMeLyqbJx?=
 =?us-ascii?Q?kW8T9MMGDunRVK/XkZhpjDB31ZVRkVkiAvbRJ0A58G0gp6zNA13UCuDVOLwO?=
 =?us-ascii?Q?ivL/Qht88qQEMUW6Orwl+Rcs4DsIRgzZOcFfXYTgRs6I2nw7Pm5RftO1nTQM?=
 =?us-ascii?Q?UCZ/ux2Rx2eG+8CPKtKYuzGGJdumMgF+Vb9OXSu4NM2eMJhlTwiLixQ6Hm1P?=
 =?us-ascii?Q?WBgynnWFSg8A7N6mvzDa9r4iyVNxg16pz9bcyxjp3MORIXdSABJTSA1YjYFB?=
 =?us-ascii?Q?hddvbomT7/YDrKNPOv7ZzqCgHQR6dPox/FR+Gfe4y2UFsDlzLGo+FaWeEece?=
 =?us-ascii?Q?lkK33Tm8y0hYL2Zgoc4oUnAU8n/Spdy8FyzCNXvZO1Qe3mUi6YOd+0NmzzK8?=
 =?us-ascii?Q?50aPBdIEwA+yAq2a7f9dt/1rZzVNPH0aF0nvJcngYnrk4MLMXbAPccRmC+pl?=
 =?us-ascii?Q?uAGEr+WKqWbhl3uC1IpRDoYbfuwdBuVgwoPEjn2Hrq/FifKmJIwRD4N4ZL3z?=
 =?us-ascii?Q?Gvok4GJCvYC/SWMAiho=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:33.8184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe62e2d-b985-4752-23ba-08de37bbc520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

From: Philip Yang <Philip.Yang@amd.com>

The gmc fault virtual address is up to 57bit for 5 level page table,
this also works with 48bit virtual address for 4 level page table.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 19cd38ce57c94..28b3732df016a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -117,7 +117,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 	node_id = entry->node_id;
 
 	addr = (u64)entry->src_data[0] << 12;
-	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
+	addr |= ((u64)entry->src_data[1] & 0x1fff) << 44;
 
 	if (entry->src_id == UTCL2_1_0__SRCID__RETRY) {
 		retry_fault = true;
-- 
2.52.0

