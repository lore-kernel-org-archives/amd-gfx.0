Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A71BCFA76E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 11:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519B10E0A0;
	Fri, 21 Nov 2025 11:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G2ldv9TM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5E010E0A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 11:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRrwMUb+KErHPrO/aqas+enpa0iMEty10+l68Bam6kJr+7VQIU0mbxHEA724sV0Mc48PzksA1uwzi0Fh1XCpOiNqXNDWIbsyYz1sQFV5ZrsLYfXyvoBjm37t3Ox+I+sF7HYdD9UnqL4/G/SjqriDxD9hmcNrwy1fvooplFagI2oXicdRaFSP6jwKMQTgu4KUP3GlRluAdv15wARZMVmc5F/AdLUNsSaV+QDFdj8gAN1nsgnalhcVhxLFsgVEmFABFhUCzHRd42+//kh1S+nTWOq3UFrERCqo7fDPsZDiBBovJsOKmZhsEUV294RbffY/uEj8EQjsIBL1svk9z06qIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEeomHNrDxVWZpD9YHS90xqp9n65+9eRm6BFqefTJj8=;
 b=inXW8RYZSTZ1eKqif9MZy0se+Zcekl+JDO7MVCViifqEuLjbssAkBpHZ4mJNwv3rL+PY7AOURfeCyRijHDoodLttjrjBFozYxlefgUwZk6kUoeGh7Lt88lVbRdRx3Q94LJuDLqC4HIHzd+Baomwq552fKnEXvfUgwPwYIFWGzoicHZV+eD/Nt66DkKUXq3GVG5iYSFtPNP52iCzxpSCsUAuTWZpYYzmru9N98Yo2RUzpIyrTkdvzBijkc2qwWIPXXtKXaw3z6NSMDt6pjnl/uPR2dzMX5+SrSPKQFpvFZyjJdnNq0BPvPLlPz9N9pvm4vio2Vg4pC7EmXtP3mnQxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEeomHNrDxVWZpD9YHS90xqp9n65+9eRm6BFqefTJj8=;
 b=G2ldv9TMprvCEvlTkU5L7B/BYhxYu/EtWlO1tKtifnwPSzjTnPsqqcq7E6FT/JwCePTvAODGELvNugZZGjRdFcO4Y5xSfJifp+aXQ2am2yr2yp3/VfzcNaAvxbAL5iZFPbalcA7QacptYUFaDDktY3G3U6Efucx1IznwPAnYTwM=
Received: from BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.13; Fri, 21 Nov
 2025 11:00:24 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::ee) by BY3PR04CA0005.outlook.office365.com
 (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 11:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 11:00:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 21 Nov 2025 03:00:19 -0800
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Xiang Liu <xiang.liu@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix CPER ring debugfs read buffer overflow risk
Date: Fri, 21 Nov 2025 16:30:05 +0530
Message-ID: <20251121110005.167947-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: a9dae954-493d-4874-2e06-08de28ed2b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEJQUHF2T0RPR1Q3KzFFY0pLcVJZWW9TRm5oeG5jV1VGY1JmWHJoMFpwdC9s?=
 =?utf-8?B?dlZieThjWmRyWklYb3ZBTmpoK0lZNWxwYTlRTjNpTlZtSk1lR3Mxc0Z0K3lF?=
 =?utf-8?B?cmRneDhUaVBCUXZvMlJYSGUxM0o3TkhuREEwRm1QWG9Kc1NXbDhNOUtlSFdJ?=
 =?utf-8?B?VHNQU2x6cFpoZUdrTlg4SFcyQTFDTVpHMWN5aDFjOUJodUtLOGFhQmpBRjhw?=
 =?utf-8?B?STBLa2s0MHVZMHpuOGhFN04veWo5bkx0QWl3YW4wTWU0Mk9YTEkrQ0dndjdk?=
 =?utf-8?B?aGFkN0laSEorTkxCckpxaFlwclJkbU5ZZnJvT1hET3dlN1BNRGlDRHZUZVln?=
 =?utf-8?B?WFpVdWJ1L05qdlhIdnNyejZrOURZNDNWb3lBMUNrcXpuaXRaQTlybitMNWw3?=
 =?utf-8?B?VHVmZUg4VVFiK3RERjdjK3dYdnUza0dXSlMvckNrc1VPKzE5VzlPaEhrYkVQ?=
 =?utf-8?B?Y0F4Ymh3VWxnVE5ISlY5SHNud0JjZHMySHBTYTE0LzJaWU1FbzIvWmVCZkcw?=
 =?utf-8?B?TEw4UUt3MGw0YTBKMVBOL2pTSHV2eEg4RW9YSi9LK2dGbUFXcno0L3lKWWRs?=
 =?utf-8?B?ZUFQNU5vaGVKMEg4R0IrK0N3U2RTc3lNclNoZCswYXVxWDRBYmgzTFV2ci9v?=
 =?utf-8?B?T25kaVpvbDJmempmUjM1QWZlTUF5L2xISld4aTFRQW1CLzUrQVB3eHYrWkJt?=
 =?utf-8?B?R3MzTTVSeXJvQ2FIRXR2dGhwUE9GMkRhNlFSSEVaYVFNTzdlMFIyaXBERmpJ?=
 =?utf-8?B?M3J5UW9CeFNaZTVETFkwMFB6YVh1SWhpZWlHbGhyTW5HTHFxSUx5RDh4Z0VH?=
 =?utf-8?B?TW82cDJOYnhqWXpBOHFyd2sxTGhEUEtMSnUwWjRlQnR1WUJoWVQyM05Pay9W?=
 =?utf-8?B?ZDlYcmJWYzlUSnI0Q25BZ0dTYjdZQllyYnlBNGxXYzNGTlpGMWhZMi85b0V2?=
 =?utf-8?B?Q1N3VjJSYnl4Y2Rhd3lGZU0yRGhJWG1tSGVrbHBaWGEwY3MvTVNPL0FiU1BN?=
 =?utf-8?B?Q05zaUpRUXBremR3RDdqUHJ4U3kvVktHNEpHSU5CWGdWU1pmdW9SeHNhMkpo?=
 =?utf-8?B?eTdIc3lxb0YzU2I3V2M5RFUzMHlYR3UrMzhOLzV6eVpPOFJEVk1aWVhJenI4?=
 =?utf-8?B?SFMyTjd2T01pVnVxK2krS1lLSWswZHZ1TElqeGVUWnJZSm9kWUJ0L1IxRWdi?=
 =?utf-8?B?dkgrZGNpa1JmOWpJL0JrWTFocWZQK1U2U2pBZzJwa0hYM1dQZUhQNTJZVWR2?=
 =?utf-8?B?WXZPZTJ0TjdudG9TU0ZKVmhnUzhqZTRqYUwvUGhPN1dUMWYrdXJ3S1pUTzRQ?=
 =?utf-8?B?TFAzWC96cjh6VXVFbkhoMDRnaFRydzZMWGJkY1d0TFl5bm9tNHBOMFhHcjNq?=
 =?utf-8?B?c1BJSDhYMG5saVM0dm9XWTZYQy95Vk94WUNuVGpXc09YN1JOSm1FWDRyMmtx?=
 =?utf-8?B?L0poekRBT1NVWmQ3d1ozV2VwMTBGZ3IzQlB5bjhNR3BZT3ZaTFIxaGJIdmds?=
 =?utf-8?B?cEd2bGpMNXdFR2p1OFpmT0l5cllZQ0F5NXN6bDBFczhvWkhrQ2crOXBOZUIw?=
 =?utf-8?B?eDE0TURaTDFBQ2FKTnZqdkNVUTljNTZsVXdFSEJuMDhGVG5wdHJvZlRwSkdP?=
 =?utf-8?B?eTVpNlNxWVFPWnFpYUswaXIwRHVETFM4T0lmQ1pHaTFKaEJCYzJrN2E3RjR5?=
 =?utf-8?B?b3hlTzU0ZklsK0sza0tPZUdiOWhnZlpXZ3ZkeDZCU3lqOHB0dVRYUitDZExl?=
 =?utf-8?B?RHErd0FxZS9admZ5R3BwZXlMSWhMZnQvQmVKQ3EwRTFzOEFMWDFXU2R4M2JZ?=
 =?utf-8?B?VFZrOGpUazVodStWblNnWFBkbnZLSTh4SWpkckhCN1FuRlNiK01DUVNKZDgz?=
 =?utf-8?B?MWFmdWtWdGhaclBXYktIWUw0WDloTjJtOEFQZzdTQ0hXMy8xMktWTjZGMHRx?=
 =?utf-8?B?Z3lxclh0TlRhdnhJR3BIUUtuYUZnTTc1UWZQeTBhOWhEcm11c2VhajR4VmJL?=
 =?utf-8?B?VS9yRjFZK3JodWxKcWdlRTJYZ1VnWXZ5NjY5T0hjZHVFR1J2b1VuKzRQd2Ji?=
 =?utf-8?B?TFIzTXJpZ3VlU2JiT3pDRWJZSDRTMTV5Tk9rNC9jNkhObnQ2ZUtqTUtQejc3?=
 =?utf-8?Q?6Mwg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 11:00:23.3638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dae954-493d-4874-2e06-08de28ed2b72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

The CPER ring debugfs read code always writes a 12-byte header when the
file is read for the first time (*offset == 0):

    copy_to_user(buf, ring_header, 12);

But the code never checks whether the user buffer (@size) is at least
12 bytes long. After writing the 12-byte header, the code then gives the
   full original @size to the CPER payload handler:

    record_req->buf_size = size;

This means the function can write:

    12 bytes (header) + payload bytes (up to @size)

into a buffer that is only @size bytes big. In other words, the kernel
may write more data than the user asked for. This can overflow the user
buffer.

The fix is:

  - If the user buffer is smaller than 12 bytes on the first read,
    return -EINVAL instead of copying the header.
  - After writing the 12-byte header, subtract 12 from @size and pass
    the reduced size to record_req->buf_size. This ensures the CPER
payload only uses the remaining free space in the buffer.

Reads after the first one (*offset != 0) do not write the header, so
their behavior stays exactly the same. The only user-visible change is
that tiny buffers now fail safely instead of risking an overflow.

Fixes:
    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:523
    amdgpu_ras_cper_debugfs_read()
        warn: userbuf overflow? is 'ring_header_size' <= 'size'

Fixes: 5b8bf21d1d14 ("drm/amd/ras: Add CPER ring read for uniras")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xiang Liu <xiang.liu@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 4336862c9d71..1aee207b1352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -525,9 +525,14 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	if (!(*offset)) {
+		/* Need at least 12 bytes for the header on the first read */
+		if (size < ring_header_size)
+			return -EINVAL;
+
 		if (copy_to_user(buf, ring_header, ring_header_size))
 			return -EFAULT;
 		buf += ring_header_size;
+		size -= ring_header_size;
 	}
 
 	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
-- 
2.34.1

