Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E27BD3B996
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 20:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFE610E036;
	Tue,  9 Dec 2025 20:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ClFXA8WM";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5363310E036
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 20:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn2gG5rByiVOXPP5zwalnCSqEJRyZ3kT0+F8rVb7PM1+xuTymMA3mmuIR0lPCA9E01gV+tU//2SsnaJqr2s0Hfw/0628AWX90U/P8XrGgKq80NKCBifRo17sktqsJd+TDcHNUbxq5bZN6ASHvfqjXJEhn9kJM//zq+xoyqCCvdlZzvZxVwZgzd8v4JMhJZ3G3A30vy0ZtOGtIO8GPxs32TwuurtcIvF8sIMgWY234nisjO5wstIvBSbbE+8CyK0Z1bOwno/q+zyLnqZhGc2smUrlkXt3DBOw1ULhJK2lLWbDqvikCcfx06WGb+6IW1FHk484oxFxRSBM8r8LmNrKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty2BG1DGv0IeRWvLQCcOQc/V/9LNgRdFGfsX3SKr+Qg=;
 b=chEmvTA95Nsvd3kR16ZuhGv21vmJnPyWCSMcJEcUQfM6+nr7nIK7wUvb78iGATIyfdBSS99QkqbKFLfAgT+EU9pT+pzBMbYHqU7RU79jRdpOoPDfo8gUQnqBUs/adNnRqnJfV182W2Gdo9QyMRfgAdqlnzvpxH5Z9Oet6Mt2gHOUzdhWRe3obDv7HQCXW0DvwIPkT7DcimWqT8Hbs2WUBx3L+41f7O9Yxc9Zb764yeiNpxRBOmX94MdvsxKRlhJ3XYkff/5f5Rc9YPxw6eV62DeA0CVbrO0Zdk9+JclEDJOD6Dck7NcTk6rsmYxbyd/DnwMvZLRtW0wD3PK94BjQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty2BG1DGv0IeRWvLQCcOQc/V/9LNgRdFGfsX3SKr+Qg=;
 b=ClFXA8WMkOmvRfC1RtK5/BSr0qNilzwsAw4xgoq/H/TJcAhVCb1uPuEjdHh92+0mrP9A0KlEHUJTmXCWhsLPYYOMdRjKgwd/qukEplZYaL2qvdXGc5KBJblpTgBykZb3BkwIvSOWaD0tVigWptp5yK9/BygdIj5TBfAWDckzmNg=
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 20:37:19 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::44) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 20:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 20:37:18 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 14:37:17 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.sierra@amd.com>, <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
Date: Tue, 9 Dec 2025 15:36:57 -0500
Message-ID: <20251209203657.440714-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 6112dff0-b71f-412a-fe06-08de3762bf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PTaVBoRK6fFewDoVzHWI8JR/FTFxHTKFQvVCqHdO8JGp9MzJratWDPuksvPj?=
 =?us-ascii?Q?AZ+yGX62m0Po2MI/zRqVTYykqlfo0UquT5G50GAZjKHRNpN+VLRA0oZQ3eDK?=
 =?us-ascii?Q?p7IqQqPekiisBjc/bF4t+pKfzjj6N6GPOyh41HWNUtaoeW3CrOdu9LiV6Iwt?=
 =?us-ascii?Q?r/2tqOio2FSBBkYQJQe2PJOzyfOqL6q3H/4Uzle007/4XBVV+55kJJJSYRAn?=
 =?us-ascii?Q?htnLaaYYkdotu7IIIGNPU3ZF0ntsIGu1UvKM7zSzcyLpNGn9QKbwigcpUnWz?=
 =?us-ascii?Q?4xy0r4/QIJO9YRW7otpaNoWKjZv/a+mXgqGCLHJ0IjbdFt36iDAAUh8hlHcA?=
 =?us-ascii?Q?+CKhTEkuixU/qabVLQPXQjeOvoFZQ8w9RrgbcMi69NdV44RHL8vW2sJiPjr+?=
 =?us-ascii?Q?9QBwy/wXMDuJy2GvktxzNA2q1yMPI0LUPn6NpC3GdymceWFmqkPp3LboZrWT?=
 =?us-ascii?Q?BXAY5SM59o/Pd6Zt8pRduZZNhsCLh/KbAC41zZaJIyZLhNoGUpt7Z5CoWixg?=
 =?us-ascii?Q?1ivMwe+f3Fbg6hs8fZD68+N6AySMZYz3XaNSIEnFCIvUnJoA6w5izBDoaDvq?=
 =?us-ascii?Q?+ED89MKXVv91aKqmPYHdGybtT+mCBLvGBMVMDZokjwgkyt11xeGWiWFeYq0H?=
 =?us-ascii?Q?xHnJae890dYgYGn6fp3LB1omZNhJubJPfp8EWXgpsJ4l2h++EioGDIKMhnhi?=
 =?us-ascii?Q?RDSxXDtuSaK9fQ+19ZRVCm3BtRS8eZMqIgK2sfeYAYP3GwP+jqyUQci7NPgC?=
 =?us-ascii?Q?6tNg6xXXAp8TC2KJUHyilO7t1xSmvO6joULOYAg988T+WQhPdRN921j5eaZe?=
 =?us-ascii?Q?taTolIwLU7kAEFah//p5NziOmRX/w0S3orekbhzTVJrn4vZqJ7BGsGLJbDKk?=
 =?us-ascii?Q?ke1LWx9AR2ysx49dAYddrsODUt9mIqp32vvPIwnqec6quqzs8exSKlHO8omw?=
 =?us-ascii?Q?1btuOCSJjegLcUik5LxaktXwQTfORwzHQeRbVhNIPP9lrJiEADa/kTrW+INN?=
 =?us-ascii?Q?crBsZyy7J/nF1Ht2Ayb3CAWS/655Xp2dQW4Zv7ZvWi5BX7k9YCvs3KCkIoql?=
 =?us-ascii?Q?huzqnWeON4RkmjC9S0fQnqXwowneS3U5ns/favhGFHDadBtHAPlOA2JLpUBX?=
 =?us-ascii?Q?eX9Xy/Wqu8yF3zMQfb5yUC0dfdOWP4f3eKbafAZCMVYGBlOmSFPtk3k6M5M0?=
 =?us-ascii?Q?JhAXblB6awQPB6WRO6WlA36cVIbYDPK2dMTbSrfR3xsiMMC77eCZj1eL0zWB?=
 =?us-ascii?Q?0xE1kVijSOmqHF9lYgGrLVfS4NkmKIUmmsJsZgLTw+xknCdmfVupemC+iEmD?=
 =?us-ascii?Q?JL9aXV+CU6/Q8spxkIDRntFLp5p0tjmPvTqIowR6kHz8nfnRNNf2HCq9OTgz?=
 =?us-ascii?Q?/EybFpQA//5PWjMG3SVW/HnbXvxo8aa2l1qrlCfuhfy8ROQ5PkN4JyiFyMdq?=
 =?us-ascii?Q?m96TIYTHn6XfrZEfziTAUvBUYpgySsHK+cfGD6tcQSb8xckRsrfH/QzOLKD2?=
 =?us-ascii?Q?3TBcDCvedhVjjFC+Kig+QctTkyNFB5qc/NwZVt4CilfzRi4eF6JXo18w3x3+?=
 =?us-ascii?Q?1i4sdLa53gb7Tv4G16s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 20:37:18.5768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6112dff0-b71f-412a-fe06-08de3762bf2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

Error handling path should unreserve bo then return failed.

Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 232103742712..6babdf025359 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -592,6 +592,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 					 p->queue_size)) {
 			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
 				 p->queue_address, p->queue_size);
+			amdgpu_bo_unreserve(vm->root.bo);
 			return -EFAULT;
 		}
 
-- 
2.50.1

