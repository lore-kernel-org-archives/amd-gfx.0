Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563B2CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9ED210E667;
	Thu, 18 Sep 2025 08:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y+yVCvPW";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B794310E666
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4574CKGJtYeGy7yTa311pF4Q6A/VheJVubYLE6StHLPr0bLrnQUzDY1+p+x2UsU2o9w0HYAoYWjSkJAm2+sGdTEbEDSXFfomEUTdN5lboIChXtufMJI0pNcQ3U8u6kWg4yChH4KwBfRMizXCis6ajz/hP3qYl58hCB538xeXNjtYusiNJpr42sBRzwOqOzk+wUG7Qo4ReBQMy8pm1yZN6+wDV9KrafnIX9arZbXDYoIYQtMo6VU0PBa2kt8pwdClMcFcBVteONSs4a0wrBqpiyBavPzXOFHIqONv0SSAt/bpxTmTZoJkoeVlrdY6+PAazSL6TsGg3TsHiF6uWTY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1AZhcxJVWxg3b8PXCaE1jlETkRj08fRNEREYAz+trY=;
 b=qaORxdddlM7PemLReLrrzJaxUzUm8YYmeS7c2lYIC+W9ANAkPNqICF7ge3KcsQAGbQmEp18+dz3Xkrxvk0gOaRHg9pu/u9fbeklA4JpaGzwiYZH/QACSUyz80NXZjf49TFx8WleUP3/IwZCQSVMHncXoAHX0wKSWlxSlr1TeDHRXE5nQ5iiJoVvedZGOw5wQOBz7r/hcQyx4sbOI9F5ffXgusYEsAXdX8hyZLHHteXzVOHTofh+V4JweL8YzvaIyWlKpJpIE1jWw8VlfVWbHe4HfrdMyM+dkJFnZz2y8DXJF6cUrszdoAsCficI3sFAWVEqV4oE8dCsxKiNAMcNBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1AZhcxJVWxg3b8PXCaE1jlETkRj08fRNEREYAz+trY=;
 b=y+yVCvPWSwiEqUOMRD3GBa/55igWeg1xU2gzeLRizwC1w5XUFygVKuYPNdhXCXmQd7x9t+yBnfRp9fse7/VXjPfwgU+eFGphRf7QKGNYRmKGOLOg7CmilsEBnhfEPjVqb36qpLvQNMlBWkekJ6HtVDvScp1/qb0CaoXZOVMru20=
Received: from MW4PR03CA0269.namprd03.prod.outlook.com (2603:10b6:303:b4::34)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:18:44 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::e6) by MW4PR03CA0269.outlook.office365.com
 (2603:10b6:303:b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 08:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:43 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:29 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 03/10] drm/amdgpu/userq: extend queue flags for user queue
 query status
Date: Thu, 18 Sep 2025 16:18:08 +0800
Message-ID: <20250918081815.2755437-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea33e28-919d-497b-5e5a-08ddf68bfbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AdS8Mw0KHCKJKiD2CvqkYcAEmI9HX4ls3ZKedhoHUyHfJ11T/UyaFtgPm+/M?=
 =?us-ascii?Q?J4y6o4nVorAR/30OY0N2PxvG1wED0oSeFWS8SEMHghTPae9nXF9nV87Hzj3y?=
 =?us-ascii?Q?DProVu72/agem73gzpE3AKkZWPVJuol+WnlE4XIVKWBKUhkO07cIBghPReOb?=
 =?us-ascii?Q?gHrkHYOeWAbXiVSdxcV2Vnvr4P3PZEHVDS7phsX+JbFdiB3LmV3+BcW1XalK?=
 =?us-ascii?Q?SxO46FnrEJTz1j03EX3eoHDH6dTeHcN4ha1RQjNl3esrDcelq0JLuFURD92P?=
 =?us-ascii?Q?Qv/lpLe5YseA6vW6BX0RJBOdBKqXkDHjeyjmtyBdQDAOkYH83hfJPolzvfzl?=
 =?us-ascii?Q?mu4QeZzIg2NvrmYxqBg7p75W8Vix4sO8vD6JyaVClulRMo6n93b0Zx4IkATI?=
 =?us-ascii?Q?MVtZ2JGUJjCfM91tk/6eZ+qY/RFuW5pMs/tymDPBUyCKwqFEo0lHZEJ7OWh+?=
 =?us-ascii?Q?ejAVLxmwWwb5rJDFaAEiJAXSTYlRa4V+ktuXuy65rs/9BxL+xsThRGe53k3r?=
 =?us-ascii?Q?T3dv0gHe6NCIithjo1NjsIfQ61fwHJtUqnlX0tNE8QGTYVa+1IvgBMDdlSEm?=
 =?us-ascii?Q?dWMlg9vZMqd3/Rjx5w+h5ul4bN5Qp3UUL3baJRr6ig5P+caYcrx/u9BVjFLE?=
 =?us-ascii?Q?0u48lWcrh9lZbP/Y7UrneiEK43KjyOeVLKVRRXg5ZRHiVaetG+Km/YwR+q7i?=
 =?us-ascii?Q?6pLpbfwLNepcOjEp2MzCUzH43FG1lS1S3IKFoSiciOSqnxsMNSOo4HeKoaDU?=
 =?us-ascii?Q?8GBNjgUsy0B7F6iK1a8DcPcrRdx36J+uk68QcKvJiNAWtjbbG14CqpPduz8l?=
 =?us-ascii?Q?EGaSL11Q3cZGdYFiBXDVnxxXWwoOUXKFExECmofy1xuqDXbxC9F9uTUxW19e?=
 =?us-ascii?Q?8spPLoCCXpHmmxsBlzKOv4bgLnAP5yQyO3f/Mmyxce9Nnu9r1m/C4YFuRaoj?=
 =?us-ascii?Q?/eoIwZBHFwaYHeEi+5YYjDsRmeUUELLLz0S5KSwVjk472JmkMzanrf5ustL5?=
 =?us-ascii?Q?yfys2VQyXyFZVCLITDHiox0Y6ja9E4v7pQlINCz5KW4AhFuzsf5UmckIDrC4?=
 =?us-ascii?Q?evHEBM1bhuW53tW4DRMYD8W1HNZceRB+hd9joYMgZ1tDMHyQopcq9BgIXRSr?=
 =?us-ascii?Q?vDyxYY+2kBlH+VcGC+TVrqkV0W9geiKTGOGKMDlYeaGWoBxwZQRw5kPq+zUo?=
 =?us-ascii?Q?F89NDRY5VPpyt7WvX+MGpZQZAD5fSVggKfJ4HiDggfel3VxHCbipxnfcY7r6?=
 =?us-ascii?Q?JyFTdd8yyjFAN3nSIab9F5gEz5IaHmjHkq8nYdWkGroxUC2l36LEGhAqaPlI?=
 =?us-ascii?Q?7NQrDnvp76Mpc1HQMgBk1QCNai7Nar0L7nFIDCNscvvCKQTlYJubDowGG7ca?=
 =?us-ascii?Q?UaYnao1x6oDUmTKEHSWr6z5eunRIYFRvlxRNPeFCiW3iC1tnFb+D3xZvcstQ?=
 =?us-ascii?Q?gN0bsLU+Rek8myyOjbEi7+mfF0KhZctkE17+5eFVe+/q5B1k8Vzub1FAbkJQ?=
 =?us-ascii?Q?Ev+IFBpPeVwqUWhb6Z1/s/A8Qs/kLwE9hMCx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:43.8871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea33e28-919d-497b-5e5a-08ddf68bfbb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

Add the userq flag to identify the invalid userq cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7292f7bfcd13..62520c4e4b19 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -352,6 +352,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

