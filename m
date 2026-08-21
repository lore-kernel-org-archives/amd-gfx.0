Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14952C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132F510F4D2;
	Fri, 21 Aug 2026 19:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbA7WNhN";
	dkim-atps=neutral
X-Greylist: delayed 525 seconds by postgrey-1.36 at gabe;
 Fri, 21 Aug 2026 19:46:27 UTC
Received: from PH0PR06CU001.outbound.protection.outlook.com (unknown
 [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B5610F4D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl8SV0zLqRmG4bajQNqMAfjt6EwlyDTKofdEUpziYtfjUp+Ko5wRc5n1y09hUp4Nxb2QG1oOW+kTb21Z+1ZubvXaH97t9nlVxJtEl8RHbjtMTwjR9B/OC34ARGYkaKl309u+z0lIaf2G3BLnOrVpBfsiJlA8bdQnXlOlEXyxsA20Q3BrR7a8wotlAGEQcmYmcY7vx/+IYEmsjoBelIXBHg3NyiBSTSWKDsr0mLVZ7JtVWHyG7SC5lM7exsLUZcbeNkwl6FKekXoRgeDU1DaaO5rrRW/ELnblUxMXLAi7Q3ll7mWmtY1QwCqFps6D+asQwN/znaiYIxcx7rulUKhflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyqNz8/qxrUM0zLnvodM/uY31EduDtKkB1l23VDmPTA=;
 b=DNrL2shjrnoP8KDIgD0+Wg0KBYrxZIS0EhE9l+vvWUKAgNcNSwPEYORyoF/y9UXOjbdWLXOmDkO1QE5CCc7cH9akgkDhTfQ4JOBbNDvblRPX6+XBAkhAIcdZINJ55DpSW4cmV4RhlMTmjm/k+2KY8S2QO++KSr0l5oNheZBXHmJ60HSb0j0/0f9BRnWivgLgCW8naC8PhhtjFSniRLIaWJCiHvgOnkaB1Y+6ZbuC8rP0oVsdDZggaFOv2osT4h4l7YMlMIi3RHixih6t+e41hsqAhHD6YjdYOCDksMoyWDin07Mxw3jCFgPLZv/GNyzh5Onbt+h2pnQGjTVK4MkLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyqNz8/qxrUM0zLnvodM/uY31EduDtKkB1l23VDmPTA=;
 b=bbA7WNhNLnxH+uldWQFLt8J/53I01bVLWMcVA73kSSpu9KFHA/PJdCWE5rv+/z2yCAri2QdjXgug5c9kykV7EmhBrSSbGTxhPHLN0AAQ4cRDFZS3nGf9ZBpDZbJZlYvmDFVuz+OZeINFurGHxgU0YGMYvrTjV2hyhUu9F0KCXPE=
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:35:45 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::18) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 43/95] drm/amdgpu: UALink use LSDMA to send remote interrupt
 command
Date: Fri, 21 Aug 2026 15:34:06 -0400
Message-ID: <20260821193458.808626-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a74cc8-1e8f-4307-86b7-08deffbb6544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VolHwCy+Gdbz6ucrIbowLs3r7DB7q8xPMyicPPBJg/AfSZUm5pkvTzmCAidnOguFsVNvGYS+oTAEXz0OqEPwzD9Vgk14or9toLOyiToMtwZV8Cx0dRRaYtPaBLuOykK3SvukDi1B7kYtmEqHARh4zQCmMKx0QKB2wcN81qVrdz1mU8zYzSwPpfHSO7NKhO61gUVBcwu558Uo/Qyb8bAgQ8GKR7XhVZFH7M1h2HGSOfZYIJJxwei9n74CmCIHfgLcqb3dkQBXONqWGS0hbLhmw5ZjJvR4zzh/ESb9vIaGymHcXxvpu07M/qdsXtYNDeY1nTth1O5k24t8K/qaCLJuk1jy6X77eFlaavvcShTsK3NOCyVYvXAj9OTIQTKWI678j2UzadNt5e7nJC4B846eexab9DrSasp9NGdOfQUd4/Rlf88jkF9GpVc19myLAz36pFR9ZLTzfSVt1eowskeXHK7nly/8PEFluUm6hMb+aOa0tdzpm85ai6fQejalQe1GbVcwHEWBH3ntIB6CNgZG8wxPSf/6FhRjt6Ve4uSftapVxafuqT3gjXK3M0IVM9/Hxh1xh1XsxtyViV1uOTfDUuQ8FSm5UtgnggRYipWbRQeDo8xC8A34yAHoON5Sv/jzIpY3yAC9ZPqrSUtMNHUPvMZIthwJeqqfCNWFDjNTgNEh4zVumOW4pJDfBA8SrffK39Lxu+pHi+1n6J8HyJBsqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9JiFyIe+/9q+/uTqazNj37fiQ6M7hpz6eJ/lpfVFdCOF+Dt+z8mAmVRjPo1FhYQshQZ/+n8DLSLCSqeddXnih4Ow9Gi1WqFUxNqJJlzVSg407w2zp5LrgLM26YVDNszzUqGsH6xqMX/pCGmSGiF8d79Iw1oq3eI4UBaSEjhBNE+1XssEEuqwYFw8Ddtkh/GcM5R7WnzvWjDQNqS3DDilTAazQaS2idZQbgx4G/ecDMUONDQIqLreu2W43OSBYld6nUhIYw17HPSKJ3rhvY5yGyXUZk8mxyG2W1wrQwyh+AjWqkmZcUOTJIbHPG2NoS122+rzcC9d5esIYeHt/w+g+Nmh5pFp7jdcsB0JOikAF0OOzNKFDsv1qFUGVSMOxGQmtk6TS8UkKRxL3hTqQ4YsglcOZvLykG0jIlsv0IwIK07HhBQXTAixKP1ZiRy33GCz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:45.5595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a74cc8-1e8f-4307-86b7-08deffbb6544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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

From: Philip Yang <Philip.Yang@amd.com>

Add a use_lsdma flag to amdgpu_ualink_remote and set it during SDMA
entity initialization. When use_lsdma is set, use amdgpu_lsdma_copy_mem()
instead of SDMA IBs to write the remote command ring data, wptr and
doorbell to their respective NPA GART addresses.

This provides an alternative low-latency path for sending UALink remote
interrupt commands via LSDMA, avoiding SDMA ring/IB overhead for these
small NPA writes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8ea34411f4227..5cb80f01871e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1354,6 +1354,9 @@ struct amdgpu_ualink_remote {
 
 	/* remote GPUs ring buffer, read, write pointer local copy and gart mapping */
 	struct amdgpu_ualink_peer	peer[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* use lsdma write to NPA address for remote interrupt */
+	bool			       use_lsdma;
 };
 
 static inline struct amdgpu_ualink_remote *to_remote(struct amdgpu_device *adev)
@@ -2027,6 +2030,8 @@ static int amdgpu_ualink_sdma_entities_init(struct amdgpu_device *adev)
 		i++;
 	}
 
+	remote->use_lsdma = true;
+
 	dev_dbg(adev->dev, "exit\n");
 	return 0;
 
@@ -2609,6 +2614,19 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	dev_dbg(adev->dev, "dxs_port 0x%x, doorbell_npa_gart 0x%llx -> 0x%llx\n",
 		peer->dxs_port, ring->doorbell_npa_gart, doorbell_npa_gart);
 
+	dev_dbg(adev->dev, "use %s\n", remote->use_lsdma ? "lsdma" : "sdma");
+
+	if (remote->use_lsdma) {
+		r = amdgpu_lsdma_copy_mem(adev, src,
+					  ring->rb_npa_gart + (ring->wptr % ring->rb_size) * 64,
+					  64);
+		r = amdgpu_lsdma_copy_mem(adev, src + 64, ring->wptr_npa_gart, 8);
+
+		r = amdgpu_lsdma_copy_mem(adev, src + 72, doorbell_npa_gart, 4);
+		amdgpu_job_free(job);
+		goto out_wait_complete;
+        }
+
 	sdma_ring = &adev->sdma.instance[0].ring;
 
 	/*
@@ -2645,6 +2663,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 		return r;
 	}
 
+out_wait_complete:
 	/*
 	 * poll remote completion writeback data
 	 */
-- 
2.55.0

