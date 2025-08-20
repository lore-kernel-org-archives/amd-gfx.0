Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE09CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FCC10E6FE;
	Wed, 20 Aug 2025 11:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0pNv+6V8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4504310E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM7ioOiCu33yafT9C9e/Yfy//hZGp7ePBiTMUzUex9J0MVmNLn0WzZq/A/oQ71akK9dQWR9eZ367nGxDsqs3qpHtKKVoP78LXeSI48FAAgOid7MGRrs8Rits148kcdw0ObyXMCiHNQKXYxQIAjQxaE/aVY2TwUDYLN5EeGqFgVDUmNCPasiZUHGQ8gfCMrsnfFJVQ1FW748irgWF4PDP4L5wItLqkXrsnKBTuK9NVEW+F38ER7QW0/y5inyf8muenerpBe0mKXQ7by5V0/Gbvs3RSUPZj1qaE0YJD78WCXSGu1nN2Kl10YKLO81lQjFYhC+diqvW9FfrXXcwcDLkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyCWNSlamP4s04LTCnPwX3eHQG/WdHZaYuaQJx2mh/w=;
 b=t1FURe+RNuZ4o0kbKp26CHPCAgn+TOA4In6PLqsnEXjW9gn5Zwi92MzWV1uAVjteAZER2SXeWS1nfJtTZ6/A1UxDs272E1AiSJh78AC/4ApFiQ8+x/R52dPQt1nfN0zo+1BbKipBjFpLx0ZGCxC6s0whOf2MzXe6KkMvAtM51Q+IsvJ6oQrSqJssHk4b9qibVXX38buCTRfZZ04ybbELvVYayxuWdhwqFqI5Uxpc7NUxN9qCrXJziwqgsxVTUffqwqqiywzDmwJyzL8vpOH9O7TOeoE3c20pz1kOYuFFpio7nxt/O1fH7+Prgx71Y6NiD/1H17o7SBO83Qdi+ad4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyCWNSlamP4s04LTCnPwX3eHQG/WdHZaYuaQJx2mh/w=;
 b=0pNv+6V8u2wspya7MOgcRWuy7oubJDn9YGxe2pdq9zZq15w4xiaGj0OCFL3wF4C1WfFtjvYP+nHCo+lgTx9fOuCxoOs24kiq/iJPEZUyHi6/vU50s3y5DSXUG6W6dPlspYIohojXuH/+QS1xFdWT2sxu1jYlBKmJb6aMs5A1vXU=
Received: from DM5PR08CA0036.namprd08.prod.outlook.com (2603:10b6:4:60::25) by
 SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Wed, 20 Aug 2025 11:33:30 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::25) by DM5PR08CA0036.outlook.office365.com
 (2603:10b6:4:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to amdgpu_device
Date: Wed, 20 Aug 2025 17:02:51 +0530
Message-ID: <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a7ed05-096a-4303-1b9a-08dddfdd62d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elYrKytEODVvdUQ3TEZBV3FVQnUzQVJWVzBLUi8vZUJuTkxmclFtd2pKV2Fr?=
 =?utf-8?B?VFdRRHBacytMajYyUWVnYlVpdER6Nmhia0VPcDJwMEFTdjFYaUJWRWErK0Yz?=
 =?utf-8?B?eGJVVlFmTDFBbWx3bXYyZnlXYWRybi9mblBjWTcxTUxRdVdEdjZlVkNuN200?=
 =?utf-8?B?QnhZNzRkWFJUVjFFeHBVUEFzeCszSExTMWJveURNdjlxTmJ2MGsrZlI5QVI0?=
 =?utf-8?B?TXlubGZtREZDZ1JwdVpqSHZjd3NRbUxhVkxsckt1MjhGcXM0bExWQmhrM2Iw?=
 =?utf-8?B?U3NuYjdqWnlJWTVqVzhrRmwzaTV5eFMvaWpwUmpaZGhnWmxiQTBxbHFqbk5G?=
 =?utf-8?B?b21tRTIyc1p4S1pDMjFHWDZrcEFZWkpvUEhqNUhzaVFWdENwUi81R0VtUlZa?=
 =?utf-8?B?Sk5WM01LUGJQTjhJTy80aWJwbHlOWk8vKzYzbVl2TEpIK3ZNTGRJUG1ZbnRs?=
 =?utf-8?B?QlJPWUVQMXFrTUo3RFRoR292NkhjSnptNW5ZOU1UK3ZSZER4MnhESUNqTnZo?=
 =?utf-8?B?M2poQkFhV0ZDSFI2MkIrNFRPcWI4b1lJK3JjTVJuMjRkN2VHVksydTZYSlRt?=
 =?utf-8?B?REdNQlU5b1BoZkZaTUNXYlF5UWMyK1p1Z2YvcUpCdnFvS3FnaFN4QmtSODVV?=
 =?utf-8?B?Q3dPUUZGWVJ1Q2VXR25UZ3kzcmMwbWVrZTJBRVhYV2o1dndGUFQ5SmQvU3JI?=
 =?utf-8?B?M1l0dVE1R2VjcWFUYTBlQWY3b2RFNFNwWG1EK3QzczVoNzV1RkdSYlhyb1ly?=
 =?utf-8?B?Tk9HWFFraGFVN1p2ZW5MSnhGa2phRVlLenRuaGRXTTVSQzdhZWZJR2c0UGRT?=
 =?utf-8?B?T1UrMzJPR3gwa1ZjNExDSnFmQW11MjEySi9MVXQ0dEpuRm1TMm1HQXVNQXAx?=
 =?utf-8?B?SWFhZ0VPQ3dJcG10dGtJOFZLcGVrSkJ6dy8wREJYNVlkdUJnUk5SQURVVENY?=
 =?utf-8?B?ZCtXZjB2U05FL3BvajBIWVhOVTgyYVJyUC9DbkZLaXRCVWprNmwxcVQ3enJV?=
 =?utf-8?B?UGNtZjRxcjFSSDhXd0oyYW5UbmZVWFhJbzF4NTJhR1JJVUdXOWZQWEZaWjlP?=
 =?utf-8?B?Vm4zODdHdjNxbFM3N2kzMVk1ME5VS2pIZS8rZE9XdmMvZ25ZMnRueEN0aTlS?=
 =?utf-8?B?akNJelhHUFFReURTQUQ0M1NBbVQyMmxsUStjcXdZbU45cUFvcGhRekUvYTI0?=
 =?utf-8?B?YTBzbE1DbExLNU1OU1hxV1o0V0JnK2xkRjJ5TTVNYXBkbllKU0dEMTZFdVBu?=
 =?utf-8?B?dnh5SHE1WGNwK1d4ZEN3OUxJd3dPSEo4eVU1NmNxN01mZjhJTDA4S3dHZFFO?=
 =?utf-8?B?bjFWNVZib0N5WDdMQ1AyWTNnb2ZRTUU0Ty9HOTg2VDIrWFJrZHhWZi9iYnRI?=
 =?utf-8?B?cy9hRldhcWV1Q0oyck8vWDVEZFlWSHlKUlhjMFlvMTRWNWN2N08vV05kbWxI?=
 =?utf-8?B?WlA1N1NYdXRtemdVSFVUZzJHUUx1Lyt5ejF0SW94VVdLMFdvNVlDU3BWVTda?=
 =?utf-8?B?NEJwMk1oNnJuVmxqVWZpZEV5MHFic2RTRlZCTVN2YkV4Sk9maGx1bTBrcHZP?=
 =?utf-8?B?MDArcWJFRFlJUktDdFRFNkJHcVg0UmhaclF3NHgzMGRqUHFTWTFSSlpVejBq?=
 =?utf-8?B?ZVBWYkhvWWlpbzlCVm4zUS8rc0Z3bWFWSVY1SWo4SW1kTkhEaHRLcFZUZDFt?=
 =?utf-8?B?cWpMUXo0SDkxRUVxdHk3QUhINnVpQkkrNXF6UVZlRWwxVHcwT3dNalEremxm?=
 =?utf-8?B?SHF1cTNwSWpPVVdaM2Q5dThIei9lanhvUk1SVGZCWEJxNDU0UUZ6Y205Z0RQ?=
 =?utf-8?B?ckVNU3ZabWIrTlgrOXRvOWdSOEpoMVpXVlQ3TzJORkRFOTd3U1N2S3lOTnlz?=
 =?utf-8?B?cTYzWjR1cE9ncWFFSHIwakdRMVlqMWNJbTJqNE9XR1FHTHluSkFCQUU0UWZZ?=
 =?utf-8?B?bU9xd1Mxc3E1Nmw2M3l6VlpwcWR3Zi9OZUs0YWtmNzBSRkFkdEJYM0lpdHRx?=
 =?utf-8?B?WWlXQjFKQzBzZk1BWlRZN1dGcTAvNFF3M0lEVVlnY2VLTVVOSHRnWW9ybUZE?=
 =?utf-8?Q?+iSIds?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:29.4692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a7ed05-096a-4303-1b9a-08dddfdd62d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

Add bookkeeping for the remap page to struct amdgpu_device:

* mmio_remap_bo (singleton BO)
* mmio_remap_base, mmio_remap_barsz (register BAR base/size)
* mmio_remap_offset (BAR-relative offset of the remap page)
* mmio_remap_size (PAGE_SIZE)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..6c477596617b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1038,6 +1038,13 @@ struct amdgpu_device {
 	amdgpu_block_wreg_t		audio_endpt_wreg;
 	struct amdgpu_doorbell		doorbell;
 
+	/* ===== MMIO remap (HDP flush) bookkeeping ===== */
+	struct amdgpu_bo		*mmio_remap_bo;   /* singleton BO */
+	resource_size_t 		 mmio_remap_base;  /* REG BAR bus base */
+	resource_size_t 		 mmio_remap_barsz; /* REG BAR size */
+	resource_size_t 		 mmio_remap_offset;/* BAR-relative offset of remap page */
+	resource_size_t 		 mmio_remap_size;  /* always PAGE_SIZE */
+
 	/* clock/pll info */
 	struct amdgpu_clock            clock;
 
-- 
2.34.1

