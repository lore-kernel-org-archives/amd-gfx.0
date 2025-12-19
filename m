Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F9EE66882
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 18:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C176910E033;
	Fri, 19 Dec 2025 18:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdKclLDf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905F110E033
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 18:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIUs2mNPbqQWhtrnqlR73N/lofpRUJwbMKN8FjNOviQVy70bneYon42iAEZlpoY8IY+doQ0FwwagkkhBL1hKgNE4NzA1rxo28u9DJsBn7uagS9Q8PvuWH2pw7pxbBVGxDetuX3W+DjAWXHBzFP9KHT0oxsXkD0Z6JaW8W4dEL6ufkrLy9WGbb2KW+Q1aWBoEtP+4/sIcXLaOlayW7C5jEbX16HZGc6D9eOGIz73nLrULYoufyN6cDwGHaxIOPr+TlOqYg59QLip7tzXp4mOhWoVpU4EAj9zIHR4xvarlGTXfvYwvc7cugSf/nQ6kzURI3bKQHMiuBTZtoh4/oV4SAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J7lq4md2CaPLyGOcBIt6YiXmlctRLrE98g0jnM0Poo=;
 b=e16ctKg/wUD1VqS/jIRYF4y1EfVtw1Lcrt8o40e9r34vPVKIJPNAi7Aaw0c938lF76lXzM7jGiWr/9WAK8dcsTljqmI0cb2wM/B7IbaccWPTShQdYcPg4aS4/LdMwNr76YtSuHgHHAQH+hUEKpielHi3Xm4NmoJkKdGTepDgsP39x9dEVNnZWw/Cfen2qAP2sNQUh5v5ZL7XzphXcJkLvR+d/7diqiYQ4TPb/LuEDY5hjYW7kD3SdVfJyfsg/1zhPKjVUkn9IrCkPZzRPdftARuXxKwFBJPLxCMkFyMo5LUt1kzZnpVKmkAUbdXRVSyYvdOsp7rBdVI+gxJQIzje+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J7lq4md2CaPLyGOcBIt6YiXmlctRLrE98g0jnM0Poo=;
 b=WdKclLDfksj3wqNsyFKrKgAe//Th++C50cOithhLo9+8xo55DSKytXzIm2d4b3kcN3dprbplQkODev/Oj9046AeQu3/H8Mr5jupFKCJow2/0XoTmZUch1iB+4T018ibD0B7UcfK/vTlwWSnRn7/mCJ4w2tZLUlKhA8yLQE4vw34=
Received: from PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::7)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 18:22:27 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::9f) by PH8P221CA0058.outlook.office365.com
 (2603:10b6:510:349::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 18:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 18:22:26 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 12:22:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amdgpu: avoid a warning in timedout job handler
Date: Fri, 19 Dec 2025 13:21:57 -0500
Message-ID: <20251219182201.5722-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219182201.5722-1-alexander.deucher@amd.com>
References: <20251219182201.5722-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 205c730f-7c1a-494d-e981-08de3f2b9037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmF6enJkYWtEdTVWVlZRb3Zia0N2eEMxVmdOakVaVjQ5Wkt1NE5WY2dydHpI?=
 =?utf-8?B?SUhLMzNMaVVKUG5UVklXWnJBZnpRYUg4NG5MZUgxaGpRL2Q0Ull4RDJzQzhK?=
 =?utf-8?B?d1lsSncweTY3bFhKcmd6cTUrcE9TSTJ5UkFkNTBnMTBvK1hZOTRhVEN4d01X?=
 =?utf-8?B?cW1IVElSYmxCcVo4ZW1kdXgwTWl2V2FWNXNXZjhhK1hGaGgrOUV6S0lzQVdC?=
 =?utf-8?B?OUYrdkxuZG1lUFZjNmlWemNnVkpIRStUTEp3YkpWMGNQcUJJZnFaK2Qycldu?=
 =?utf-8?B?UDVwdmF1UDVWSG0vSURFVnIrN0xKcnFoSEZLMlVVeVVYTjdZS0dJMXlQRkR6?=
 =?utf-8?B?YjEyczg2TXdqbGZPR1JxMDV3dVRWYUVJT1gwazZscGJ0VFNxVHd6YmIxMWRj?=
 =?utf-8?B?UWpKRDBtdWFDNFYrWUlDRkRCTDVxWHZWM0VwODZFTlhXbTljWDI5NWhJRGNz?=
 =?utf-8?B?Ni96OHludlNTKzBHcUFOUlJ6bXE2amd5Tml3clpzNkVnN1ZkMkxMSTFvYXRC?=
 =?utf-8?B?REN4cmJEWE9BQU1XRWUwZnJIRE42aDJkQytoU3dEV0M3Q1NnVmo5VHUzVWFZ?=
 =?utf-8?B?VU9ZNUJiKzU3akdOT3YvbWcyaDVMbmY0R2F5RVIyL1FmdEkwMnZaVkVtbytU?=
 =?utf-8?B?SnZKM0FORU5LWjMrcm1WTnhkK1JUcXNGdHRCZnZycnYvYUp6N3Z6OTZXSDNC?=
 =?utf-8?B?N00yem9DRE5jWDZvci9QVDlZWFZRSTQvVlI2b09naHErZEh0bjluN3dlYnYv?=
 =?utf-8?B?YmxJYkY1RTNtRWJldi82THdjSjNSWGNNK3dLY1ZyVjBIZ2NBZG5zWDJoQkxH?=
 =?utf-8?B?MjkyTmVCc3M2NEM0QXJTMzRhKy85alRQVEJpcU1FRytUK2VuQkhMWlpZcDg2?=
 =?utf-8?B?dXNucDE4YkUxLytOQzdDT0pPQVBsMHBmQnJ2dUpjT3k3QkVXemdFclZKaGZh?=
 =?utf-8?B?M0hjZFdiVjF3dnZLLzRFSi9ablJkZUdiNUZSSldCeW1rT01iOHhVTnA1UWhu?=
 =?utf-8?B?RnJQSTRheHZDeTVnR3lOTVFLL0tWVlFwZUlOR1hMRVdnaFk2M1d4dmwzcFRJ?=
 =?utf-8?B?WmRBS24wT3VMUVkzdlRMNkZuWHJEVDhPbXlXTTJ5dHZaSXhGblVudW4reEFl?=
 =?utf-8?B?b3JmUVlvTFJWQmZ4MWRzazFnYldQaTNlNHExcGM3N2dVZ3gzODcxUEZkSUhq?=
 =?utf-8?B?bDF6eGQvblNEUW5ZSEYxWEwydEM1WFJPZllrakI5UnRKS0FRSE9STGc1YzlH?=
 =?utf-8?B?bVVON2Z6V05NenVtcXhlcW1JUzdBcDlSazhLZnFZbDJIN3A5NFgva0dVNFZ5?=
 =?utf-8?B?Rld3UmlIQWVSRDBxaGg5T0dSUlhXWDgrL3pyY0R2Y1RkVnpYMEJpVHh4TUJF?=
 =?utf-8?B?QkFzNHJhZWxkdURMTXdTZW5oVWNPS0tQaFhQTWZoRlpKUVJoQkxWOVpiUU8r?=
 =?utf-8?B?bStMMW14YnU2K2FtRDVFT3ZaZisvZlQ2d3B3YXZITld0Yks2Q0k1dkVxUEFJ?=
 =?utf-8?B?MFM0d2FCb1JWdlpGcnNwTnpSMi9JQ3lEUXpWRnNzclZ1VmtpTGVGdU0zQ212?=
 =?utf-8?B?SW1MTmIrTksxV1QweHBYTGdDYUJqU28xbDhqK3NVdXI3dFZwRldCbG9pWnNC?=
 =?utf-8?B?akcyZnRBbGVhNXNKR09BTmRTZjhaRkN5T0ZPTTJNUFQ3Vkluak5sYzE2WW8z?=
 =?utf-8?B?WjhDT1dwa2c0cXQ3QnVjQkNQNDlFdkxnaThvckwyVmdSdjVOdUlPaUhsZFo3?=
 =?utf-8?B?MGhJNWFuNndNWXVod08zZ0FxQ1NWS213ckJkK0hucEM2U21odlhMK01hWExX?=
 =?utf-8?B?WERibHRNUC9uU0t4SGsxN0xrUG1jM09yK1hOOFc5VTdBL0w3eHpWZTRvVm8y?=
 =?utf-8?B?aWZYMmFRVzhqTm1ySmlianVJaktsVU9hS1ZMY0JvYjVLdWNScHRoUFZNZmpG?=
 =?utf-8?B?cDhmcFBTWFpuUTJ0ekhjc0pXQkVqWEF4YUpHM2FxRVpXNjBRRnhIMnFkYzlo?=
 =?utf-8?B?bGNrSDZiSjlMWFlSMTc4Y2FrcnRsaUM0OWVOdUpXV1VUZk1xaVNtdGpKajB2?=
 =?utf-8?B?UGptMmhDQ21Ua3doaHZ0V1c5QmpyemJ3c2xyZlE0K3c3cXlBSFVHTi92MFBl?=
 =?utf-8?Q?ypR4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:22:26.8045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205c730f-7c1a-494d-e981-08de3f2b9037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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

Only set an error on the fence if the fence is not
signalled.  We can end up with a warning if the
per queue reset path signals the fence and sets an error
as part of the reset, but fails to recover.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 67fde99724bad..7f5d01164897f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -147,7 +147,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
-	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+	if (dma_fence_get_status(&s_job->s_fence->finished) == 0)
+		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	amdgpu_vm_put_task_info(ti);
 
-- 
2.52.0

