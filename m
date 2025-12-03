Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8236AD12D5C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26ED310E129;
	Wed,  3 Dec 2025 13:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H4dmXmIw";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9B010E129
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfhNM/S7z7ImnpF1m6395ewnghPRgQ8MnKJPIJV5w0N0LBYJ1ebZq8f9ajs02v2AJu4Fxt94NO5Z2GY21DktTGDB5j+fWyga7MmBASKocknxKR1u53HQhhC1+3PxOPUpEOOXEzAYjnGtW6UMVWj+q6PKRRJVymtQ3jVmGNkbmti+5g0gcqSxnD1ykACw7fj6+9vmXMZ5wZRj39t7OEVnYTAeG5ab/drYRYmHIOBoGHPWldi9QYgkCeChNg5JqqJ3sNga3FrSjmzZGi3cqUCh+VojGODqJNqewtbyxzxVNDFNbQK5TtndoPLC4l3MLyYBa8u+NVu0Jzt0Q4RoEpcr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM9wV1SwOJ1Ts2BuiVz4Gx9JYZYGGgo3d6m+mvv3sU4=;
 b=wZ7MkpA5Mbmn8sTRlWtD7Oanzw1F46EiHdTBZJzkuWFE/hZX3nOVChgfu/hCUCZdeSd4ZnY1KUsvQgRqtX35D5f998RR4v2Yf1AbLPVxbLcE+eXJf32yzvPDr4u4O7TF7eMsV/ZUhyn/m9qgPTUGN2gVjVibNQ24Q/+r3y+JJjhZnmsCMcFVnq6pxcYAtsMUvxpCGN8xuTI+MH7QQpOXTVYHyxbtZhmo/GZq1MuO53EALHpKK6U7SDZlaWR8B3ZfErF8eTjYr3yW4/W6/iCGTcvps2sNSZzANrAfO87DWh8ClLoX9NwSvTLb0FfhPLQqs6cipcMifskkWR+lztADbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM9wV1SwOJ1Ts2BuiVz4Gx9JYZYGGgo3d6m+mvv3sU4=;
 b=H4dmXmIw5C3NepYJ8DO/A6HynkOk8lXhvxMU8KiuyUFSao58YD+6ZErwlxNHQVNhwgLK34wyeHuYe+Bzllic7woTxaFD1EPvQrDoHAhhfZ9z06g2dpOH8c7o2t4KAS7f9Fe7RTasUU4gu8uwMq+LGcX7PPzyGyG1pDk+ok2lae4=
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:05:17 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6a) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 13:05:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:16 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:14 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 09/10] drm/amdgpu: Add ioctl support for cwsr params
Date: Wed, 3 Dec 2025 18:25:00 +0530
Message-ID: <20251203130436.745633-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc79f0a-dd7c-4f28-07a7-08de326c9ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?++/EHvXyr3GY1OBlSaboufY9tMN09u2A8HgkBHwVv51EOELHYo2Ht50rPZFk?=
 =?us-ascii?Q?8IyVZWgF6U+Wua7Ve6frKx96hDcL5WorT9qKTSlxJOKLTVtdfF2Q9lggUfYZ?=
 =?us-ascii?Q?aPDwU6QNRFkjUHb8/1bm8wDxI05aTdNCcC9xPt862WMe8eOLB4aLPY642yzx?=
 =?us-ascii?Q?pSEMagJol/Vl2MiK6jEJ45Oj7XBAQRUrxm95KZtk98eewK4yPuJSXfquk7oZ?=
 =?us-ascii?Q?VT/ltQEm19ILXU1skuwJPxdwHPUA4rWksyReFvjQMsG4TB58h28yZcur7QjH?=
 =?us-ascii?Q?altbmGgOLqG0paOgs3XkLs+M0LbzyC+yKvcScOIs/o5ONmPK4E2Om7IQOlFa?=
 =?us-ascii?Q?Mn81VYJVZpFB37REGGYiWuEGHIkUh6hn7YV5i+YOlSF0ijs04ogWr446Kh4d?=
 =?us-ascii?Q?O/9BqYRPhSeiw5ZNdlF2e1j09HYNzI21xGDs7AlrB+QLPECK4uYGU4458wXt?=
 =?us-ascii?Q?S9l8rxqicJixTy32eLBbVddpKyn4U/JUKdYgRaEIeTqqOICaWjf079st0fZY?=
 =?us-ascii?Q?0zb50bzoehjQ0KL9Mhs93eX70K6XEXSWqC7SyvGjFs5KeTEDnL6/MnksyQTI?=
 =?us-ascii?Q?LsQ70yLYWG0hFUJEbW1HT6Qd6aGytboJSQddacE7441WOD4/OZvAumcY+1/J?=
 =?us-ascii?Q?cueVqFXxgG8P/CWHhUjBdAAvZZS+9Brmo+sXW8L5PpHGZVDEbGuS6WYv7tDc?=
 =?us-ascii?Q?wrOnmEZIngKan3E/O5RSkr59f9KHxDECNmbU1On4DMH9UNdhKGo7Jz/sLzCd?=
 =?us-ascii?Q?GJscZE912iVo10hpauJAzN2XjztcRpApPEi04MTzjIjrT/DWka3ncY8QPh3b?=
 =?us-ascii?Q?UboWSTFjmpcnPciY2MoZIr8OdwtPYyRClVjq4ZY9GpFnKCi+gEmp/U3eNpRw?=
 =?us-ascii?Q?e34+X+fAvamnOUKZNenKlXsqDKGUuD+zK982jqpBA8sHO0AtjFaksFqJ9dXL?=
 =?us-ascii?Q?xet9l+tXur6ZfuKvaebu0Oy7VpaIW5baJNK8oU/Blbi1nLiu11d9oj6GNFao?=
 =?us-ascii?Q?DVMcPyu6lC8M3zUIJhM35FnlyiifnMeu7Y3p+q7Ium8o+dTRqpVgHJVlLB9/?=
 =?us-ascii?Q?KgemMVAg+o6MH3Fq9WdRQ7r0ES21mJGBr/613RhTXd+p1GQJyIwbUMZK9GTD?=
 =?us-ascii?Q?oPhPB/Qw3dSkq9VH5rI9y2AbBF4W8hEKKOUUCt96cWfYxF2TrZGqa+cz9vNl?=
 =?us-ascii?Q?/VOaB6EqjkFZgkw5LJC8O4alaSrTvffr98mf1+qK31C5l3rHxk7TwXUngU0e?=
 =?us-ascii?Q?rx57WpWZ/KC5DqN5sA4e2z7Fha7Imx84vmpONbqi+gtPVx+ZN5kEr8XeDLXN?=
 =?us-ascii?Q?dC0vyOgNSaLLAWqgGlBYxXfCMPYalq6W4vg0PoL50Ij7Q3S7Z0tClRH2184p?=
 =?us-ascii?Q?BEwihU0E0GpiL8JBjUwrleXtX3J8gQDtFb+ZHMQw32QNCQ7+ofQcYwz6vyhG?=
 =?us-ascii?Q?YKFh6UrPLYCKSscNxvTS+CAg1OCegYaWMkPyRgos/+pd5rxvF6Pz7N5CI0Bh?=
 =?us-ascii?Q?4pl4DOMqEoAWETaZ+Vor0o3A//66/IgtpUopMlR7clAuxgdiIa7vplLJM7ro?=
 =?us-ascii?Q?hJrCb73vpCTeBZ8sQXw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:16.6381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc79f0a-dd7c-4f28-07a7-08de326c9ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
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

Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
address for save/restore buffer, and size allocated. They are supported
only for user compute queues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
 include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 0ac87618a86a..8865a266d25a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -322,16 +322,21 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		if (amdgpu_cwsr_is_enabled(adev)) {
 			cwsr_params.ctx_save_area_address =
-				userq_props->ctx_save_area_addr;
-			cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
-			cwsr_params.ctl_stack_sz = userq_props->ctl_stack_size;
-
+				compute_mqd->ctx_save_area_addr;
+			cwsr_params.cwsr_sz = compute_mqd->ctx_save_area_size;
+			cwsr_params.ctl_stack_sz = compute_mqd->ctl_stack_size;
 			r = amdgpu_userq_input_cwsr_params_validate(
 				queue, &cwsr_params);
 			if (r) {
 				kfree(compute_mqd);
 				goto free_mqd;
 			}
+			userq_props->ctx_save_area_addr =
+				compute_mqd->ctx_save_area_addr;
+			userq_props->ctx_save_area_size =
+				compute_mqd->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				compute_mqd->ctl_stack_size;
 		}
 
 		kfree(compute_mqd);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2bb9daafb560..1a27e218d4ea 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -464,6 +464,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
 	 * to get the size.
 	 */
 	__u64   eop_va;
+	/**
+	 * @ctx_save_area_addr: Virtual address of the GPU memory for save/restore buffer.
+	 * This must be a from a separate GPU object, and use AMDGPU_INFO IOCTL
+	 * to get the size.
+	 */
+	__u64 ctx_save_area_addr;
+	/**
+	 * @ctx_save_area_size:  Total size allocated for save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctx_save_area_size;
+	/**
+	 * @ctl_stack_size: Size of control stack region in the save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctl_stack_size;
 };
 
 /* userq signal/wait ioctl */
-- 
2.49.0

