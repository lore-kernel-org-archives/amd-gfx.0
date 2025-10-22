Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D08CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6300710E6D3;
	Wed, 22 Oct 2025 07:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n1Rw4xYE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C2010E6D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC5C/s5TP4hoCWWqIOHNsWw6sD5z3miPr47AoZNqDgO2Z9EOdbwkkGD1oDp3mBQmZ3zGZh71MDs2GOQeMjtoyLibJnCashE35YdXYwau6HuglQWN8D3fRotcnWmpTj3nvRbARkUTQAUzwfGa15uhXA+yOeJkha1zqgzd0AkjQptJJZSHU/ZWqb8AzIk6IuY7jdmo4A7DupndSTR0FyHavg5FOG7DD1rxi1xspnpMNJl8I0429GUQqGtZYub+1wbZD4l09iiziMojjAMgqW+9ZKZPJyZrub7eh0LRTkOTxtYy1Kzy4V0R9SAZibU5HGLSol2e3YKDa48kObv/1K0ZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf9T5hOTFnhyKs6InUPA/mvF5yHIkb0BiNPpKT53Zmc=;
 b=uRuVKPDJx1XurDg3qxB7o3yRhS+fDM3Qjxm2rpnJPZFJQ/dUWeUYr7yAMxjBtBAllPzQ4UQPo1Xfqz16FBQ/YSEUeC9r5P+E4dBrQR9SVqvL7Rhu69naXZSzAXwWF9UxyFigvAW+vyfh76LxjRprXPN2iicdHI6YQflVaqvsafms+zfpzAyb7QqrJoZv0UOchBFotaV5Os6fTqh2btFSWy2/BLRj17I2toWQxfP4uQ2gcY+IlvBL85A9xz5TMddElttEJPRMzz8c3eBO16ezMaH1zBFnmdAtLLWc6XQbq3Zo5qilaZoAB/7iaG5bYQZ+874lCWY4/K9XpV9DYPIl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf9T5hOTFnhyKs6InUPA/mvF5yHIkb0BiNPpKT53Zmc=;
 b=n1Rw4xYE+gvjErluF84RK4iiSQL3p0upX+eXCaCPXcfXdWHIQIhoqBvSRFUtCjtQjVLPUDl30aFGGSATQ/PO/31lSVqn4lXbQAHa02/qMJ2v/j0M+Ckuj3Rh7AnnV1soboDlBzdOWD8Ias3kRKMCzLfzbZOWw0c1BNltNWZ7P6E=
Received: from BYAPR07CA0072.namprd07.prod.outlook.com (2603:10b6:a03:60::49)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:31:10 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::55) by BYAPR07CA0072.outlook.office365.com
 (2603:10b6:a03:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:09 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:08 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 01/18] amdkfd: enlarge the hashtable of kfd_process
Date: Wed, 22 Oct 2025 15:30:26 +0800
Message-ID: <20251022073043.13009-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9643be-69e7-417b-8425-08de113cf8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wUzC09uTq2HdHKhBpKuA2ZB/4lx5JXK6fN4uoI7jUxNItCchIRJ9CH6i+xwi?=
 =?us-ascii?Q?b6eEyQ5ydwu7X5MkWAcSYBuRQ54Bnx3Ci4uho0cvRNWMkOp1X+Na6d5kxn3+?=
 =?us-ascii?Q?8xNLnb7DYYiNb0tDIp9xsrKPSV7YG/5sI8Iu74CjRtN2GM+QrQbqUpC0VHCq?=
 =?us-ascii?Q?aPYAfHUDQz8fKdjEhaIUNYG8bKZMfg3pTTyGvWbUNP9fjNYNCVbVQsHxnWm4?=
 =?us-ascii?Q?8CXhZohopFWVrvIdN0s1RZBvBD7FFSZ3dQpHfZ3aE4EClxb/WXT9YtSdnPCe?=
 =?us-ascii?Q?jXLXvkXcvYFAI/cooTdnpCewtycyqc9Ukp6Yv7yz+FmacvMM2GlD/D8eBPpX?=
 =?us-ascii?Q?dPtixdGhZJZFg3xwTG1HS2/7RnOaflnCtOGG3gxviWHYD8AUhwwWV+k37nxr?=
 =?us-ascii?Q?bRJegWDtmzKfjCChqLdkx32kpPVAHsJDX65/iuKmPUK/udwPUmI4M16qagwB?=
 =?us-ascii?Q?9eJIN9oTPq72SgwZ9J/GECp86Vazt7vXbUZVKO6pIBeAXrgmdF/UuOjg57gQ?=
 =?us-ascii?Q?EquG9S/ZKw6cXfBb6h24a15Yg0fApfMeSg37ZneKk34wqaxxtxvK2Gm6Yz+v?=
 =?us-ascii?Q?XqcfpugzUhPDKHVaLQLc1a2qo9S/v33s1sIUQHZOqxrCIILkiOliP9GnEN9p?=
 =?us-ascii?Q?vi3+TUZtBAsK987xf6OpE3Zu8jvN+S+/8ZpxzsCzstsOzpsDb1DoCOZz4FqZ?=
 =?us-ascii?Q?09mFnbrcM7jjT/TDR02duGFAnl6258J+LU64ikN6hbszui9HHO5D8AXTpRCF?=
 =?us-ascii?Q?FE17EB9KFK4i8zj8PTPljm9e+ioLjVQAz9ore0EJjQeRZ4MPlJOT6E4xiFCK?=
 =?us-ascii?Q?r3L6LxqA5i99REWsb2EnVSgk52hCQ5Ty+BmHePVHdHNql63p/XqniR5kiHPD?=
 =?us-ascii?Q?Kp0UuLooFWBJSDVuATuXuNFrfMzf79C22Nu2GEC5uUvg+cU921Dw9mw4wmdZ?=
 =?us-ascii?Q?fb9STL3/2cpJPXXGD53qCrWwMSHlh+45the/Lh8x7LxIrsPfeNFE1aSnQb0W?=
 =?us-ascii?Q?dXCJd02XRUSKIQ5nYMnXPXy1VeYpD2bdAxV0mx4Y52yqS86zhs6b7qSmHMzg?=
 =?us-ascii?Q?vOPZy5fdyBkID/wTpGe8hZ66lVjWiaqiGjdfC3oxN8VEzBwazpy96Zkedh+P?=
 =?us-ascii?Q?YZKbbiwhEkrDuoHHVZIFK0RT/JR+JHbR1dYT5FQuSLGV6jtPfjWBvxnqLWAw?=
 =?us-ascii?Q?b0+wnu9C5kLspgpFAHQeTwsxv2b96SW70BB+rDivN/UJn9v3+X0HIzStsW/c?=
 =?us-ascii?Q?SkQmDMZEiv5hSkS/nzs3g4eD9LDy1X5JEjzaAi1LjX0+EyVlDSygg78kvMvv?=
 =?us-ascii?Q?QlGh6m+VzavvIoLPqMy+VRqVb6yTsGVJ57nhV4daCBvzyjcQw/o43+tlDeYR?=
 =?us-ascii?Q?n7bKZrFILxLCxm/pbY8dueJzFM73PToVElXxM6ScOyEUS7dggkQWDAscIY1L?=
 =?us-ascii?Q?3IFBUIhyD73jgGBHrgLfRJvdJgVALX7d6NjW53CxxtExyU7db5SdEPjmWafr?=
 =?us-ascii?Q?TEkRnccAYLxV5mUBFDRYxWmTvgCous99c60vEm1kzaMyIaE+PmxCU379pxX8?=
 =?us-ascii?Q?/t86D+e2mof7737eJA0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:09.8893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9643be-69e7-417b-8425-08de113cf8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

This commit enlarges the hashtable size of
kfd_process to 256, because of the multiple
contexts feature allowing each application
create multiple kfd_processes

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb..d943ecf62a3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1020,7 +1020,7 @@ struct kfd_process {
 	bool gpu_page_fault;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.51.0

