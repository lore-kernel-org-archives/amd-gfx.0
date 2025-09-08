Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D505CA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F300610E498;
	Mon,  8 Sep 2025 08:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5iMkeUpw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9512610E498
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNFzJzP4qf3mvvcOEVyCjw/WpuyLgkOuOHsQznfmyEilDZhXpK1OjAGaWr2ceSqVKcLRKhdiDCot7uAJpmELlmIr3VKS0W6Lm4T3z3i2S7/+qJyUqU/POmyG7jE2zz+ppSAJybVVB+5S3M9d3OqBoEkzCwul0SqKp6slHy7sovt/FLRv6MiyeUJTo7GlT/QK7/dqUJK61iD0CO9aCBKPHAVe+RHs9L342fyP6ZB88kEoW4z4Y3aYQATiTZyLCf7MMKFxQKzEuUV2WfF3ivLi6kC5zv/AqP63wzPAt0/POCfHgX8ZZk51fXsovzBsVK/vZumHOKB9dLkjjMe/RJJ/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU93bXAQ6gZ7mkUX3YMHZeSQL3BUPdDmCM0VkSckmOo=;
 b=ms9BF8mnc5TQIUrdZgVsmYQ7MpclwG5JGZFqG2Hv2OQVPrb5fMYMAmc/swj0LUy69M7dSFGTyqbVZ3nZYrKKWWLNc7nUqHdscixt107G0du/s8wZw5jMMFaQmQh9WhNVjfwnCn7Q0F2PlKuxP6j2bAlLfr3MN/HhebZXlmZLHy5j6fw2csUdnRBvmIF39LlV/QALvvJrb+cfwqVLtd08lj5JAxonI9WZ7V9kO09enC2EzGz/4UXexRzD7WSsfVYuuS2/LfSNQ3rfwCvJDotr2f5sjPluZuHdGX5sIQMUwH3tOqLz9PkYg5E73wGOwcOjGK3VfK4rhjVKlCTVx/PySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU93bXAQ6gZ7mkUX3YMHZeSQL3BUPdDmCM0VkSckmOo=;
 b=5iMkeUpwbiFwtRHgmezLaORyWFfHCRp2tHWOTKiuB7wfTOfoPm5qfm/j+EezhYRcBT518pqW5JxR05FOvTk9JnLSYBa5QfrvU+9WPg+bHDR8xyl6zMI+EI4zQ5kKjzb2T9Ww3OpzItpVk6i1w8BbLkDaD9Hp4Fyb59mc5TR/FYc=
Received: from CY5PR19CA0066.namprd19.prod.outlook.com (2603:10b6:930:69::12)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Mon, 8 Sep
 2025 08:49:29 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::8) by CY5PR19CA0066.outlook.office365.com
 (2603:10b6:930:69::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:29 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:19 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 13/14] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Mon, 8 Sep 2025 16:48:45 +0800
Message-ID: <20250908084846.1873894-13-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: f21ea69c-3013-45de-ee2f-08ddeeb49fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1hybTNqTHkzbEhPUUdVdTVVV0VOSTFJTnB6Rk9Vb0oxN2hFR2VZay91dmoz?=
 =?utf-8?B?TEJCTjM4QVVqaWhsRnQ5eHdGb3Q1eWpBSkNITlh5Y1A5ZmNnSzdqTS8wV0dq?=
 =?utf-8?B?NEhsNVRXNXBUN28zUXlWWTdxQllMeVV1WG8zWDNiUEkvendjV2htbnhLM1Vj?=
 =?utf-8?B?YkRyS00rYk9jK1QzVDJQOFMybEk2MmtLTXhjRHJxNlpSSnhMbmFBbzNoVSs5?=
 =?utf-8?B?aDA4dDZZcEdvZEc3UGUwcUtyNlFhdHNuTCt6aWhieHBRcEVVVVE4YUxFRDhn?=
 =?utf-8?B?eDhkblZoTUlYeUIrWDFkNFRqMDZpeWhQODVjUlZlWlF4Y01BRERJUnZBWDRE?=
 =?utf-8?B?dUNmVzVFVERRanBsR3hXWGFCb092ejVXK1dPakMvQitDYnV5Yy82VGFPWHFw?=
 =?utf-8?B?RnhhaElvWHdSRmtaYzE1TTYvd0ptWlRwSlhqNDhxM1BVbVQ5dXR1aCtObElG?=
 =?utf-8?B?OURTdDc1Z3pkVThWSlV2VVJaN3ZRaU9RZThvaWsrMFY5bFh6R0sxUEEvYkJV?=
 =?utf-8?B?cVd5b2tOaUkvNHFSSTExcmNYVVcyR1VSTVl0VU5OalAvNC9JNXczOWpKSGJ4?=
 =?utf-8?B?b2xEVG1rNmpmVzk2SlhTR1Fyb29FcDZFQWMyT1hkNWtmemw3UEJvcTU4ZzNy?=
 =?utf-8?B?LzA2bTc2YVhLVXBRKzBQcFFBUnk4TDU3VVNHdUdXSEdPNEUwU1oyQ0liZm9v?=
 =?utf-8?B?MDRZUjFUUjdrdkdnUDQ0QUViOHdWQW96NHZEQlZVY1UrdlRmVEVrQkE0dGM4?=
 =?utf-8?B?SytyYWJENGx4ZXVoaGs3ME9vc00zVHJqN2dQcHhGR240bkVRVjBFTWlGQWdn?=
 =?utf-8?B?V0laUjcvemhkdlJnQzdQRFU3R1NJVDV6RFZ3ZnBJV0grR2FFampmZUNOOEs1?=
 =?utf-8?B?UGdCMnBzRlRpTHl5TTJpZ3JiOE4vbGlHc1p5cGs0akhabmo5Q1dHd1g3eU5N?=
 =?utf-8?B?Wk9Gc1J4RWQ4Z3g5NFdLcXF3b2dUbmU5ckk2anQ4aE5aZys5RExZRERLU00z?=
 =?utf-8?B?SmNaTnk4eGlKK1BlRFIwYmoxaGRwV1Vpek5oVno3cVVTRXVoQzIrZUhtZFFQ?=
 =?utf-8?B?Vk11US9IRGhDMXVIVmttUTFzMFVhQnZwaWwwYTBCajdJMWVXODBYdkxlVitt?=
 =?utf-8?B?VXFnOEJYMGRONDJlYWpsSjBGSkhPSHNsM3gzU24zKzgyZE1ETmxZdFVhM01w?=
 =?utf-8?B?UkgvV3Y0TWxhN3lscnNwQTFoMlF5WlBhTmQzZEd0VjV3WXQrdGxWL0RwbUZm?=
 =?utf-8?B?T1RVZ3Btc2NuQlUwNk53VXViRTh0eVNJZUFuNmdRekVXWkhnSFhQbUhLdFM4?=
 =?utf-8?B?R3A1Y2ZBalM2SktuZHZRS3FVWEJHZWxtUEVabkZOeFRVMnhzSVJaeXoycGFU?=
 =?utf-8?B?cGVOWkFxbnNLaUpsMEFjaE9PSUxtRGM2ME1sd2c2cFpka2VjZVN2Y09RZjc0?=
 =?utf-8?B?U2YxN2hyVDlkWVVGQmZxUWlyQ241WWFEdE9ZZVBwbXBWdmVWYWRia3dWWEhF?=
 =?utf-8?B?S1M3YmZBTHZaVk1mc1hsQW5mSkdOUitTdkJBaEh2QmVYUkxaZXFUeDdacHlk?=
 =?utf-8?B?SHp6WXVWd1YzVDV3ODFHWGhSZVFPek91UXJpSWVSTW80bTkzTlV4Tys1Qkg4?=
 =?utf-8?B?VTZxYnJHcXkxSEtwNWdNVmNpWTdxbEtSclFvTmdtd3hnSk1nYTNqRVpFMytW?=
 =?utf-8?B?dFd2dzVXWURUK2xJTlEyWGQxcTFubEwxZ0FPdURDcGx5UjNNVHdQUVFyWEVE?=
 =?utf-8?B?dmIvUGFsVVBGZG9FcDFUb01iQzdqM2hpMmpQMjFKSDJiK0ttOTVjY0VTMTBt?=
 =?utf-8?B?RXNoMVVnRGNXNHVwVWdwOUM3YmkyZC9kY0UwckYycHVtOXE2NCs1Mkp5NlZT?=
 =?utf-8?B?VDU5YUNUY1NvR2tIOGVxeUhwZ3FObDRmc3ZxL0lFU3BTUTFnc3cwRW5NVjBp?=
 =?utf-8?B?cSt5dXp6WTlOKzlTY0pZUk9oNnloeFU0OGZlbFoweU9kY3JvU3daNUE5TjB0?=
 =?utf-8?B?cVlUK3FoM1hPclNtb2VXeEp5UnptaVZmdmxLaU5CZ1hNSElUcU1CMmVTWU5J?=
 =?utf-8?Q?mRdxQJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:29.6162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ea69c-3013-45de-ee2f-08ddeeb49fae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ed4067df12cd..f90f384d55b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -813,11 +813,19 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	int queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+
+		if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+			drm_file_err(uq_mgr->file, "trying restore queue without va mappping\n");
+			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			continue;
+		}
+
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
-- 
2.34.1

