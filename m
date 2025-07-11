Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C797DC83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640EE10EAF8;
	Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zi8n8rFV";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECF310EAED
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY7tZU2jaGSQa35/WFT+gvDftVQzSieU6Tker6Dkp5x2uZnTOYZ68+y6Y/Skj3NNc7NUw+K/ZuDKa0fIGYV8u4c6M53x+gLrMucEY63m06n6Vkfp5NrSm0Y86Kl/qj8PIZTSg16nNMPAWLS5Ql3vtsSmDiQPQq/YSh3NtwhkH8cxXr/8281yJ7szqyCWLB16IAdD6Muq1dsjUGh+RPwj88Vv3OSaLaDaso44MJNbUaKbgHLqiN5cmj11iz/PiM/8oEA3gh0/JlaXMUEVt9Q+67wZVGBo+GjEkKZhHUAl7u6csGrM/PcIpE5AAEggAz2w4ncXZ5GNMGBHmbVgNF56yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THGjfnSP+K39+fAGWCf05SgL4R/S4j+rseMdP+Y3lH8=;
 b=HXZ9Lmsr6bAMTLDcPmIUUAT38zVQX06uPQsVnXOrIX7CE//p/6FORn9/3VSNY0rJ9828fJc8kQ+BbxsovgesQohXTJL3OykYH51gVwJ8PAmHeN53nFzqmHM+MzJeyMyWyXtAslQoR6Xd1fGBJDUdiv8frghIcdfUrOL/OYUsHP+XEh7B5VSUTUWmjvEnNpbnU+zZCxX3gZS2/7OXzbnloCYwsoJsBfB9x8o+XfQ++u34CRyhxQOur/nRP0IE739MlqIGFeNCmDWjEAhHlSVGr0X2+eMMbWjN9fMip4XDJ5+8Sc0jlzBBl7i0bFd1PgDZGpVWG2lZRdUEL3f7/66fLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THGjfnSP+K39+fAGWCf05SgL4R/S4j+rseMdP+Y3lH8=;
 b=Zi8n8rFVYZD8DJ+117Sw8Dt615VawdXRfPZvLMnw3wemXdOMXZ6iS7KVo5Ktqcvk3LFl2386WRTB700Ka4ZIvaAib56yA8fxvqzgM1wPVCy0ROgq2BR6BLHUcrH648bkTAQIRu/mqRVRMh+puQbucIa7eUqL7Zh8E/rE0V1aoFU=
Received: from BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 11 Jul
 2025 22:40:51 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::9) by BYAPR01CA0045.outlook.office365.com
 (2603:10b6:a03:94::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 19/33] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:10 -0400
Message-ID: <20250711224024.410506-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1069df5c-f016-4025-36f7-08ddc0cbfce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vkSF8wnQiJZ2yO7lMTA7gC8AoaFwAOUq7CZzmqZD+LJGRJdsxKKLxpVWTY6c?=
 =?us-ascii?Q?KrO6q6ZbKH8cndanA8PrMT4ZUFixvq3HFtVi+hJR3mMVriuL6j67E4Mo2Ied?=
 =?us-ascii?Q?1WsDaoGsUuLXPcV+4X4qPm5501Sd5GaGvdWhC0zVahNWx7fiW5bLbdyabYmy?=
 =?us-ascii?Q?oig3XEXwDSXo2bHuVBf8u3winrXUsMQPun+uEfvX0Kf2y5buD9Jma4+Rjdq1?=
 =?us-ascii?Q?Q5TAOaWIlNCKPTRylHwZIUf1R+ToMv87L1CodRBxGzRwTWn/F8cDN+Pta4ND?=
 =?us-ascii?Q?L+tO8mAtHxTmWqyiaOzYWD823V+H6JyRu2zpheezgREmfNJ1ruT9rGK+Qws/?=
 =?us-ascii?Q?isda5bTc3aIgJknCoXhkn5eTOHJezdfQRLQsh4OrSSOCJk9lTYwhFlXHvk5S?=
 =?us-ascii?Q?2Hg6M5VJyAK30eW+LWUguMp5uCeChynCgiqivX8rFUjm8lI9/D6cuFBJVu7+?=
 =?us-ascii?Q?qIsdFzNgbBICcbbhaDvDpyqqlN8nS17JfKM56HlYLQEYDN1qNN/K60ZI5SkK?=
 =?us-ascii?Q?c5f9JRV+xU4cjmSSZhbf/dCNq3LabO7JRfyTFz6OcHLuap7GrU2kT3lIThnD?=
 =?us-ascii?Q?1+PdHEFVZyEqtVnxnzPQ+wv9T+cyNE8LhfSLmo9QcjBxv10YSzcw61zW1oR5?=
 =?us-ascii?Q?SGTHC4+sb6jNsjNU7Y3s7tKNRvoV7JLphQvf3zVlDGNP7PLu30vb4/W7LZmb?=
 =?us-ascii?Q?DxzYKh85IWrSZRvsXWpxlNNcogk5+EJf5xrYT2593ubXIhlPJZ76vNrwjJ/C?=
 =?us-ascii?Q?yIdMSZ48+dZcRkg6IF6emiQrTlw6tNAnyOALE1CM01xm4NRgM0WtMtelK+f8?=
 =?us-ascii?Q?+mlT6xPvQ65hgKSdPXHcHgYukdap5BmxFfUl9udV+IYr8hEgKr9Z7igMFF+r?=
 =?us-ascii?Q?Tc1l2S8lx5lDR2ZvG+w8bbhfDX+lS5KUYoiRyFLR96dXWcXheKyETov7SBEp?=
 =?us-ascii?Q?M34dbTrZjaOz99WcIJncR4ZMQTmW9LgSCZWkfjzh4P/5sowzZiFtCiLL+Dci?=
 =?us-ascii?Q?P3xK9aUkTUVhDVoH+8rKQ6Nl62jRFa+kyEGBNQAPLNoxwjij+5jm9IgDgZSM?=
 =?us-ascii?Q?/i4TYRKsX5I0xsJ06M5+5PM7R0e5Y9l3uHYOWTQ0wjDh9YyZ1XOFZAYdUTOs?=
 =?us-ascii?Q?1/eENioulo9rLkgxEn2G/s5ym3cGTV10+hijUHnTpoh9tFUxlLt8bBodQl+b?=
 =?us-ascii?Q?BB3RRpISsQVNw/dyzDgoVkk2sTFu/CwQjKG3HYhlkBDZn7Mr/0trpfgc/161?=
 =?us-ascii?Q?gONrAgS7zFBHO+yZYNDh2DJArxgJ60453R+kh7bB9e8RNCtCdEvV1bTnThPW?=
 =?us-ascii?Q?tWgJStFzn0pC24Kxy+42Neoo8pHVDv2pK6qpl28rKvYbGGXPFFJN/oJ3z6B+?=
 =?us-ascii?Q?83R9v3YGX6dJUPWTCfLsv6v4pWZq0g8P7pLSSQ2r0O2qFcKQDYrFWTxwd3cX?=
 =?us-ascii?Q?CEiH3y8yeoYEeUex7ul+8vpiPtdJJwpdniA/Uc33F2H17H4ME/Tdohpny5v0?=
 =?us-ascii?Q?3iQrk//y9TvVa4Wdhh/fX0VuNMJ++yOR33ha?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:50.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1069df5c-f016-4025-36f7-08ddc0cbfce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 3d0e61f9f2854..4e489a7e21157 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -648,20 +648,13 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
-- 
2.50.0

