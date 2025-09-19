Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CE0CAC5A5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103D510E960;
	Fri, 19 Sep 2025 08:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DXpYZ7kJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011060.outbound.protection.outlook.com
 [40.93.194.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5259010E960
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yva1JxjQA7LcL3updPOiMBFsnUjMtH3SSb6yaScdRQN4kvWZohb9fGngdxm5DxXOsCe0SbhVkCx3RLnjs2VVfmNBPgUzMA31G37/E/R+c5s7nJkXhikIioMii84t/1/LY/7micj8zKe0iFRm5wZwOGiXzJNVzlW+DNT6h5/e5c68xNd7ZyATpL/sbYceG3yJosk1vbrj2kReKyJeh1xjsjPr9GkpGenD+dUuVcD3mpGzu97P+JxZFy/UvBwjssvIsWJXv5MjNiF2f26eGwp+Nr9g1szqwo/7P8CTkLGsC+H8LdBZ6fxCcsczw/x6JiJETegjCgasMmMkEpdHMYxOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+CozsLId/nGJMFo1b7fmX4z/5d1JfTBTYHlnenlDiA=;
 b=TigUeh/sUh7SgBbQHYO/217cq8OdDq67PEl5hnOa6BJE147kgV8DnlXb1rAB4/zijM9rSd6H+xSiwbnTTYDfmtJvlofCwoC89d7o5JLzy/b85cHAXQJme8dZMEss9WnTpBpUO+d9+n4zcktoHRw3qD2/k6IZBuqnXkQnXoNIM9Yb/Zks4lKx0ai1Vbfnd98KDKCeQrNXn9YOP6hf/fMLyXfc7tQ13QPi9UA8hqBjpDlDJ+bPOAJvqm0ey61Y9mQdb/SwRP7DMtsu29+u8LOXsIPqJv118j9vw/87DlHCs3VC3d4I9veHIVja84Bt/WS+QnmRyJN4o4Aode42SrRqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+CozsLId/nGJMFo1b7fmX4z/5d1JfTBTYHlnenlDiA=;
 b=DXpYZ7kJDFG9xQxCtymJHOdrGf7cA3pqDkZdbv1K+VmRIe10cLmmQc9Xl23Lt80C4BmE3mxm8p9mb0wfxOUWaMu0FVd3VG2dyxH6NdRCcQxMA6B2Qy+R7ik/ayUXjEKYZIH28KQnT6vdvUDAdw65O0wvvtORw8O7mUfOcehet7Y=
Received: from SA0PR11CA0079.namprd11.prod.outlook.com (2603:10b6:806:d2::24)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:11:31 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::f2) by SA0PR11CA0079.outlook.office365.com
 (2603:10b6:806:d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 08:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:31 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:29 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 05/10] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Fri, 19 Sep 2025 16:11:08 +0800
Message-ID: <20250919081113.2797985-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c7f4c1-11bc-432e-0f51-08ddf7542474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3hrK1pzelVXaUdNSTRRMjNjYXJtUHREYkcrZk5ZSDVxemNORVhnWGZiR29i?=
 =?utf-8?B?RGdCdzBsWGUxKzN0KzRxYTd2cDBHc0Z3L05uM09XdHhPbWF2R0hpd3k5MkVu?=
 =?utf-8?B?TW5kcVJVUnRzRFNVcnliaWpuZG91bFFjeE1qeGxEeUZWSVRta0lzNGtKdGZR?=
 =?utf-8?B?ZUxTWHRMU1VCY1Vacy9ua2hXeGFPci96dStyR2hUbDQyS1U4ejRtTk9CbTVx?=
 =?utf-8?B?Tml3TkhieHhVcDlucnBEK1BVQ1ZEb0NOeUJyOHhJZkdtYllqZi81eCtKRTRS?=
 =?utf-8?B?aDZMcFZSOE9XNlU1Sk1xcnRHZFdHeVYwZUFNN1dJS2dlblZPRXpYUExUclBM?=
 =?utf-8?B?QW1TcG1jVnJBdmNNTGQ1aEpSYjBiTjRIbXY5QXpqNUFpeDVkdTRqMExuNk8y?=
 =?utf-8?B?bmJVb0c4QWNJZVJ4UlpmV2hvVnVwaFkvTHBUNWluNzA1ZCtxTExjcmVqaTNu?=
 =?utf-8?B?QkpBbVNjQjRVK3Yvai80WVBPZXQ5dDBuekRyTWQyYnloUkZIelMzdGZ6d3Zw?=
 =?utf-8?B?N2NqZk1aT0pBV0ZHR3NzZjhzNkUzSjgxSTdGdEhnc1BnUG5XRHNldnFtLzVD?=
 =?utf-8?B?VzQrTjg2UXp5RFB4RUx5b3RvcEMvZHhRZ0RNUy8vdk1MSXVKd2haMERoNzZs?=
 =?utf-8?B?OTljaDlSQXBxVVJDb3Y0WEtvY0Q2VVJzRHhJeXZRQWF3bzRrQW50UzE5THJD?=
 =?utf-8?B?OVF1Y3l0TSt5VEZUbHZvNDBNS1E3M3YzejU5akFYdnFFK1NxU09zOVdMbCsx?=
 =?utf-8?B?ZnFZc2wwa2ZXWjFTdVZSRlBISE9Nam1Fa3hlYW1BbVVuc1h5WnlrSjQrMDFZ?=
 =?utf-8?B?Qy9Jd3I4VE1leEduVi83L0d5cmlhNmpYTTc3eUpaUmxsK252emlIWFltL1NI?=
 =?utf-8?B?N2VFb04zQVE3K1B0N3VTVGVuUTV0eUtyeHM1TDlrZ0JuTmpxUXVUMXhsaFo1?=
 =?utf-8?B?WUFuNTJLVjhXbmFEOVAvekcxQjIyT3FaSHBGWmh4b2FoREVlcDBtTmdpTXBB?=
 =?utf-8?B?b1hJNDk2ZzFma2RNS09xSkc5bUZOTkg5VllnbXNiMUdWTDFqV0JjSXIrQUtp?=
 =?utf-8?B?TzIyZGh0OWRZTlNqaGtPb1ZxZjF0U09LcTVZQUFaMDBRdisxMWpiS3QrRlFU?=
 =?utf-8?B?S3oxZjFxcVZBRjhQQzZnbldRTW42ZFRoS2paY1UyTVB5eDMzUnJ0eE16Qi9C?=
 =?utf-8?B?aU1UaWUzNVpiaDc3S1VxUHBsSEVZVGZBTmliNUIyd1BVYVBXaGFhUUZhZE5O?=
 =?utf-8?B?anFjZ2swS2ZkVWcxVDlaanFqUDlsSVFFUElTaWdPbk94akVDZ2VCVXgrV3VB?=
 =?utf-8?B?a1hFTjhIT2xwNldjTXlxVXFBQTQrb1l0SWh6ZHVqa0pZZC9zWDdFUS93N2s2?=
 =?utf-8?B?VkJuUmJ0UlZRbmhZeDFSMmVnSU9laitFeEx1eWU0UFBNWEdKT2xlNW8wZmdH?=
 =?utf-8?B?eWlRaHZvR2ZyOHBIU2ZJNVNVUnhScXBDb3FuY3ZpQWNidWN0dWdkaTc5aHdG?=
 =?utf-8?B?VmNtVnlXWmFTdVFkdlpjSjNPNGRqNUlDcW01UXhwSk51SG5DUU1OK2ZZRlZP?=
 =?utf-8?B?d01Zb1lobjdqTEdiSGFYS2puYWROeURaK3hPY3dONHR0aEtXZXFKakpJQXA4?=
 =?utf-8?B?Smk4MVQ1YlFSQ2xENHpyb1NEdExSeWlSS01sbVhuYWVvTUtjRXc4clJYalA3?=
 =?utf-8?B?dHRLSmM0OExLR2pTa240SGhHUHRrcEx4S3dGRnk1RXljRGtWTCsrYTI1Qjh6?=
 =?utf-8?B?cmdpdmlMbjZIUGdLa0x2TGZDTkl2cHIxbVFQU2pPVGF6RlFxSXRZbWlqcm0x?=
 =?utf-8?B?QzUrN2hrOGFTRjBJeEhXQ084Q3BmaFdZcHNDNFp6b3p3OWY5MnZFMVZDTUpP?=
 =?utf-8?B?RjRrdmdiZGdwMkQ0TFM5eUhUN2xLSUVYaFAvOHVrcmxzQjhQZ0k0K3kwWVVt?=
 =?utf-8?B?QkVNaXZIeWFpQi96NjJncFVNbWk5cTI2MVE0eEJLQ3VqOTRFQ01kME9oSFFO?=
 =?utf-8?B?YUY5bGhWVWZaV2FESG5VNnFCK2drUjR5Tkh1YWo0eTZ0TXVTOVd4UlUvNlJk?=
 =?utf-8?Q?3Qxt70?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:31.6757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c7f4c1-11bc-432e-0f51-08ddf7542474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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

It requires validating the userq VA whether is mapped before
trying to resume the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 29 ++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9cdb82c13a34..402145d64714 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -116,8 +116,27 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 	return r;
 }
 
+static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	int r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
+		dev_dbg(queue->userq_mgr->adev->dev,
+			"validate the userq mapping:%p va:%llx r:%d\n",
+			queue, va_cursor->gpu_addr, r);
+	}
+
+	if (r != 0)
+		return true;
+
+	return false;
+}
+
 static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
 					   struct amdgpu_userq_va_cursor *va_cursor)
+
 {
 	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
 	list_del(&va_cursor->list);
@@ -778,7 +797,15 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_restore_helper(uq_mgr, queue);
+
+		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
+			drm_file_err(uq_mgr->file,
+				     "trying restore queue without va mapping\n");
+			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			continue;
+		}
+
+		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.34.1

