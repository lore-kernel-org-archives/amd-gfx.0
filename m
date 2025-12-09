Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9677ED1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 09:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E29C10E4C5;
	Tue,  9 Dec 2025 09:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="poUONDfq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A3B10E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 09:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4aPx/SN9cN4taSgmTnQhyoIOkAwgfO4yF6fGbzIUmiMtQ9i+WsEF0GGyj+Kdu83P6KgmVBVHqrnTfr4wrFVDrFmtdobXe1RIi29W/OudaY91L3GfpYUrFvkW5uPp/GDeAnkDxwKdYgLpAuSTlFnQv3AQHVqdYvlkIvVBfFmVGgRNCTwvFUDluBQj2TDT1ipbarKrf+hEnCHNMiVigl5NS+ze3EV0cG3NVSfyJses9/1+cHWhD1NOojCVsDl7ubD2Bphfcien/jTnDjDUqjB4C1P9/TbK+DL5Syow5eUdEBLDBuwLFdO3B7FO5C3kMeF9OnxqRNjcdZWs/mT77lwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2dx0t9IomfzzmY65xZ93Fs8aZ1OI8RiZ8vU7KblV5Q=;
 b=ReH1NRcJWW22xLEHeQxHG7cRRPO46+ot6q43JBhb7//yxoubmlVsKUAMRTBVst4ijpz+XilLt8f1RzJo6mAmZNQy+G39FqZHEk3lzYlceWI5rEXdfRaD3ov8XCklEN8vOxh3oof3NCuoNg2QC3fF2WBskQClQH6spwDdfAHKs/CkTva/nfuf4FoE5X1lMDo1UPXMZSctPVMFHIP+5hNL/eHxxnkpqM4H1j+dDtkDZP+kAML8JkwVHloHDbD5PtOz/YcQUIMUD4GkFXQmi9Vt9gjN8K3wzDNnHEmjDjoPAZPlsNgdJEepKDCQBslHJ75IiYavklb9dhppbQuJbDSKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2dx0t9IomfzzmY65xZ93Fs8aZ1OI8RiZ8vU7KblV5Q=;
 b=poUONDfqtZ30SI2bQpZQ3NYd18Nq/avQ5KqZHWMre8+PMYy36psXSw9xWW/f9c/4Pt1FyPv4BBDhcUlnalJXCOsrbuwHKHjfVEQOF61T0xRD/+22ebqBaIwIb9dIqc5EuWy7il35qsJMxPkmFNVs9Q+fvY+THqdARyao4IbQPh4=
Received: from BL6PEPF00013E0A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:12) by CY5PR12MB6345.namprd12.prod.outlook.com
 (2603:10b6:930:22::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 09:24:12 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2a01:111:f403:f90b::1) by BL6PEPF00013E0A.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 09:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Tue, 9 Dec 2025 09:24:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 03:24:11 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 9 Dec 2025 01:24:10 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling resume
 work
Date: Tue, 9 Dec 2025 17:23:26 +0800
Message-ID: <20251209092409.1257671-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6decb331-7f1e-45f2-cd41-08de3704b6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bi6AvmLoXw2aQnYxzMXf9RVAApRpi9StYfpX/VkK7ySV997JUveRlozsFM8p?=
 =?us-ascii?Q?2DB0+PKWRs7WG5KkZdcUCNp9yJ9v7lXlx9BWraW/ymrJ6O3cafolEOrLxh6u?=
 =?us-ascii?Q?SnckR7LjCVvTiSPExRr1uKV9kMPUXHSLPs9fbBYP3zZxRNSF66TZhLz+U4Lv?=
 =?us-ascii?Q?qG+Gyuwy43j0jqUTEBct/h51EpIXRUbNx8uG0mVQd/kx5U1I5H21Ubdzaq50?=
 =?us-ascii?Q?Q2hmU2oTJhf99n2Hh8SptN7qKChnlxYh1GCjpdjzPy+4qxGqvBsMtch319Et?=
 =?us-ascii?Q?XGi1wMDjEmxa2ALBC7PF6FcHRsypTm6exkOs6C1nmo4E6tSh7eh5rWXI6q+4?=
 =?us-ascii?Q?NIS6hsCpqo6LKgNTCYBxsr5Jrix2NMGXzQ+FXpO6T+WJW//PayvoehqrtoNq?=
 =?us-ascii?Q?8/3DOR9IOoDI+cbwVc8QX00jmoMzLW5H5o+rvkfENGRw8CTvFD/4ZSlrntY8?=
 =?us-ascii?Q?lrA9uQ7bPOhZGiXQpX3AhxV+OA2Xi3KWAXGdQH1K2x8UYp1TqjknwZd06T9T?=
 =?us-ascii?Q?WYKxFk4YGTOhfXNYXv+TQtdCeH2CWLDdDlss3LlZQTLWJv3Prk7Fb6zqQE2k?=
 =?us-ascii?Q?tO95w1K/BvtH+9yvCQOwx9W/1lhtuFXVjO/Zh4R2z07WLS85zHl2lITA5TZv?=
 =?us-ascii?Q?2bRWYipV9PmnN0wlf/k0Dc9y+3b1UFwTa6q3ieA7KKOfOm+l9ltkt6MXOHHA?=
 =?us-ascii?Q?QUqM4WRGZ357jVTtpnoBnK43pcRdjf5hKIy6isriECyWVvi1fw6vss6SHuty?=
 =?us-ascii?Q?UDL10OqWTlzB8DNvZFZLyPQ88TAXlw+ZObbpDCv6bHzQK7dt8XjEiXsSxmwc?=
 =?us-ascii?Q?gdcJoHugy/z4TOjSrUM3ovReGn6ZlVnrYP/fD+QAl6/iotClReTIlkYnxIUv?=
 =?us-ascii?Q?7cMXJv9C5yhXt5SsQrTSJYjociO9x1iXl1DjMbk5G5pdzIHBSohAEvyFModi?=
 =?us-ascii?Q?p7FBV3jOHwkXCNXtMGKs7alydnFj/dT9W4xVqqZpAW5iVzbyeT1VK/OkYDYH?=
 =?us-ascii?Q?P8PO0JtDNQS5UvIQcbOJzp+vIfb/25hF9uzraVEkv6ueQMaId18FqDN9MICl?=
 =?us-ascii?Q?ecVd5xpV6gGESdyBPBfMyCKWAhuPDMF0MG4F0oh0Rmq2XkUIBaxzETwDpSih?=
 =?us-ascii?Q?9SdroAbcvQVqK6r6DwQXQ6OIlCuMsm9oWteC0gA8xOGVQDBVBfy4+K9X/hy+?=
 =?us-ascii?Q?QNvytMzbHWimy0gha40NNpJrqUiQH02tKFLUixLznyFd5TwLMR42qYOSsVxc?=
 =?us-ascii?Q?gxkU/vMIhbtbRMDpV9eLLZqAKeE6XYzoOfiwR2LAcm9LIxR3h+YkHEVhM4JI?=
 =?us-ascii?Q?5JS6yzh8/2VPP4G3GFuIM08VJwWWQNP9nOzVgO530od4F0+k4+M7hnhkbzQn?=
 =?us-ascii?Q?Zo+lT5wiljMynwfh83xig47XqTRYZ2aIpfQeLgD5339v+aT+uMl28jQxivUU?=
 =?us-ascii?Q?mvyMwqtPGZ9Fj6gryPuV/xLq6kpJ5BIkVSEZiGBm3YlW6gZUov+Tu2izb4h9?=
 =?us-ascii?Q?noPkaIMJStzu0DGqwzbYfBsx4cOCOtiJ2NjPYIDVhCiJN9uV2jCo+hEer0hU?=
 =?us-ascii?Q?qgwlMLO8WwUC4wmrigs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:24:12.2296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6decb331-7f1e-45f2-cd41-08de3704b6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

In the amdgpu_userq_evict function, after signaling the eviction fence, we
need to ensure it's processed before scheduling the resume work. This
prevents potential race conditions where the resume work might start
before the eviction fence has been fully handled, leading to inconsistent
state in user queues.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2f97f35e0af5..ed744b2edc61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1238,6 +1238,10 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 		return;
 	}
 
+       /* Wait for eviction fence to be processed before schedule a resume work */
+	if (dma_fence_wait_timeout(&ev_fence->base, false, msecs_to_jiffies(100)) <= 0) {
+		dev_warn(adev->dev, "Eviction fence wait timed out\n");
+	}
 	/* Schedule a resume work */
 	schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
-- 
2.49.0

