Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1E3CCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71FC910EB6B;
	Fri, 17 Oct 2025 08:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nlAKLCYe";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011036.outbound.protection.outlook.com
 [40.93.194.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E9C10EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnDqWVH5jCpr0D9vipGkuo1rjgRiLjBAIuwxbBAbrFSjiaMO7YCIgM+GXAOzbwhNMX62Noh1sUTrzgcD0edrGyDSpzSNiBbRQ+EPjMzINCaMQPVKMn/jdUeF5N2BL+R37rV6XN67E2YPWVTI7PvwVHXhGAdYRDLKoXEeqgndIqMKmaI8eetzJuOwDLMk+1XKt+CJRmYR28zoTeFUbKActpT+T+qx9lHiSno0XKfdyzLYxzU2YMADg8SgPmqA3UkioGzRHBatUDTxWtte9loXZIx3AfzQmFbben+CXQGwsVbUOos0I5lw567nD8/6Ssf29aUCneneGKQ24z+c9rD4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugjr48C4lYdK5G2xnVTp4IKnjB+cjpY7U3Pd6nLUX0w=;
 b=pC6JWHp7XCBlZUg8nRSvRsIMf4arQsAopvA+U/h5RD5WnQ3c5r0nXhM5FwYsbC/dQaLDLKuHnV+rQVm40z5Eq0V7Nqinz1mDUVxgLbsWqEQUUB0sWoyyT8ML4Ct3hRxKvQrhu9mjDaDvDlAnzVmgNyNX2MOPCzDJh5VMo2eYTDyjrsLYhPMh3DA6eMvmUf0wBJt4Ahbg43pvOXgD07E4KgK5KRrNGq7qoyWOaFUi6DId/9gHvdh+2eqwdhMcu9Qx6q+xPaVlJdsQ6LYfjPuEAz4dhS3F7pIztWRJM1XFC/0kp6Qf1X+mFnZj2MIQpWo1Agh/d+PvO7l4qbiFfTMQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugjr48C4lYdK5G2xnVTp4IKnjB+cjpY7U3Pd6nLUX0w=;
 b=nlAKLCYeJXzqmrnQbQ5OSnVzwGkLc0Soe5cOpa74GNygjEW6Lq5GYHKpWJxbWaoecZ8AOLqUNyrUR4Fakzj21C654HZS/JhOrNiSxoYs1P7BI5coJap+hrp8bHXfFc01GY2uCKGnB5MqmcqmJSyNQJ9scjclmy/l0Fhapo3133A=
Received: from DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31) by
 DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 08:43:25 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::b) by DM6PR01CA0026.outlook.office365.com
 (2603:10b6:5:296::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:24 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:21 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 09/18] amdkfd: find kfd_process by filep->private_data in
 kfd_mmap
Date: Fri, 17 Oct 2025 16:42:13 +0800
Message-ID: <20251017084222.54721-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 544e5966-46ff-48ee-2033-08de0d593c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kac30pV8LgEv5TXT64ZxJAaMKxB4h5fKxfIBPXnG4g1riIQPjYwdcDNeTf0q?=
 =?us-ascii?Q?lbNZL+0NUNCZzua+AaVDL6kNJjWfdxqvrbqRIdulsQ+iDK3mj8n3ncrFE8x+?=
 =?us-ascii?Q?3XFaXSu0lf+5EGoFOyEND19LqS8A/gYEoJW8I80B1fkKwoXiPvBMcZl0Eqei?=
 =?us-ascii?Q?hqaxjsfjDWseXaf0ehW8FJW8ZpUH0OLuO6HgtWOA3j9Y60Qo4xRYekVwMc8Z?=
 =?us-ascii?Q?xz0XFA1LF1jkxDWgzzBSkyDKpgnM1jh8mj/n0syPgNOKSEPCMuz9QZVvkous?=
 =?us-ascii?Q?5pJ13Z1twMFdhncvqK0s2Uihc+pNbclmVQiQK5OuWEoJcTnSTjCdbdgW+BJ4?=
 =?us-ascii?Q?N38qncLc90CwglnWnaEprq6pbQQPsSN5f7VoabkyRLS2KfYVW3xgGZr3v6Id?=
 =?us-ascii?Q?FU7Zuh2zZVc5RbOhcvuJ7JQ2NTw+7sorTZmvTXtgv4mDKIWEceNuiLAxT1bz?=
 =?us-ascii?Q?MKSOIhuwUcmKzFtmk2wh0TaQ3cNvdB5w91ULgvsplQoEbTu9jcss8QHTRiwG?=
 =?us-ascii?Q?o+7IeP8b22exP+WoeURT+RtOYjE2SdPb6Rgj/Yh3KjteG1CsWu4Afm7dHusl?=
 =?us-ascii?Q?NVb6fCj6PZBPhsjpvAOXnjwdkpM/XPBvCz04SXEQznNa5Nm7DAdl1B0/db9z?=
 =?us-ascii?Q?vhZQyy+43n52FN24f87O2Cjxj2ZUFgHguN7vRetGl2cfQFFu7pUXrbS+PHK3?=
 =?us-ascii?Q?b0f3xeezFKIeNuP4OAZIBMVDPmARMFqQ2Ys3cRFHz4Og0X07fJCVO9buoOeJ?=
 =?us-ascii?Q?joLjhKcg+pzSg9r+GX6UKUjmdZ/XN/Y4sGz0tBjp3eLlS+oZGRlzr5tJjCDW?=
 =?us-ascii?Q?yVAOSm4awkrPoanG5052IKhQn6/pAdfTdGL+OeEsqHeN4yAmlv8vjDXne+Kh?=
 =?us-ascii?Q?zuFn8hAX+9wKKhlM2ee4lyHWQ+ZYEZpgZCnNyvq8w22YxBhdUXl84t958ViA?=
 =?us-ascii?Q?T9R+umWIS9tKT6OSPWICHclTu46Ta2dqJ3VXSk1TfSXDr7A7w+P0xw3gN6TV?=
 =?us-ascii?Q?h9H2vtuaq7g98x6HXCQRs0OAI+fkr4Hkz5RPB8yO1X66p534p2dLkYPT0KGy?=
 =?us-ascii?Q?lM18htpZ2wUIT9T3eVK+ysENF6GZjK0aU+qGRuUuDSRcAkUKudkXqwo+YcgP?=
 =?us-ascii?Q?JJQXqRZewNpYcOY8ttirtEG3GfcwrlCwh5P9hCssZOJ3SyGG6HHzcnxKLnac?=
 =?us-ascii?Q?1xZ8gtA9N74+cZ7JpUyiljWiO6+EyZLq4dOQ0J+woBEby8Uwx+Q+oQ4X2Sbx?=
 =?us-ascii?Q?TSS7lTa+6j4O3zVQbe5vqdp2KFMOGsqGU5UV95kqut/jeApAv+lS6DvAC4E2?=
 =?us-ascii?Q?kWp6fTsSXqHvFm6ZhApKdyTLtcWbbXtFwPoutpK1EpCMqVgnhvMg+hiUuGpB?=
 =?us-ascii?Q?V1SkGFRUk3FsDVCbgGM5EWReUEu2OHXis6fOomc18mtBZG2YTO2ZwY/GKHiE?=
 =?us-ascii?Q?WCBtgl3XBLgztMopkIfZm9xUtbj7RZ8Do0MHjjAn4DpvohFUm2OBwSpIiIE1?=
 =?us-ascii?Q?KFtSsiD4lsUIKCYD/fi1lAEJYdJQ+30CwArC+TL21c5Xf8a7edenKXbaYYws?=
 =?us-ascii?Q?Z3tAA9XvA8AMDO4ePxI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:24.9749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544e5966-46ff-48ee-2033-08de0d593c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

This commit finds the proper kfd_process by
filep->private_data in kfd_mmap,
because the function kfd_get_process()
can not locate a specific kfd process among
multiple contexts.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d1cb22f48b00..73de2de8be0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3410,16 +3410,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 }
 
 
-static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
+static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct kfd_process *process;
 	struct kfd_node *dev = NULL;
 	unsigned long mmap_offset;
 	unsigned int gpu_id;
 
-	process = kfd_get_process(current);
-	if (IS_ERR(process))
-		return PTR_ERR(process);
+	process = filep->private_data;
+	if (!process)
+		return -ESRCH;
+
+	if (process->lead_thread != current->group_leader)
+		return -EBADF;
 
 	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
 	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
-- 
2.51.0

