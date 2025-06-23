Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B60C7EE33
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698E610E42B;
	Mon, 23 Jun 2025 16:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhU9K4Iw";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D2B10E422
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMwKiAUGJZ4DEpHWJAWB/t9NfNqVY1i5Bp6I7Ey7Yahy4SHTEAYjwD/2xQoBXLs9riczjW2mYGKWfW4w3A2B5cudvROMVc+xf42ztWtUtzjFAFtnJ6tkWAgGu47l4bQDtVS6WLz2KZUXm7ByLwJsR20pB2uoiR8A+F9b7uSp/ncaRWCCRHEggkjXOUn+17CwO/EJiGWy9Gs1Kh+82T9r7UQ3YJ1v6ngweYWxYWEFLFufh0i8/4pcd+0CpxnjcYDq+2/ZLDz+AE/cGgbVadPiTxv2NdIjIT3zew9DMkRNq/Q7K3N7/YgJmnjEE9Nr65BEVW4lyiJdibx33ShvxcciQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDzsKMApziipJtxVghgd7s8qdJvfNBIwQZWSP2bgViY=;
 b=w6zcO+7P7iRLLW2y8Tr0m7gGWIl4VxTJWU8I98fMSZd+gRw9xDQlK1lK7ZYW0VyO4skP8lcIEL1smn/PcdCeVXmzAckkFQ1zdpwHIoLWRZAltyCgouUrGAA8waDysRIFPIDTAE8b6o0uvxFYTqIBJi0XwHahUqZJAMvQp5b3Go4NrUs8I+V8/frCE3PGV1LweWvvlYgu9CwX/qgt3K83vWZzDd/tXc36on65ojwRgB0ISQQHmk2UO9zXs+nsrteGB8uIh3D6EJSPx5JJq2BB0HAzkrBKbZCvGI+5PZCfDmqsRZb4OJGk/5nXa6QRsirtZNESWRx+LwwBoXYGueTZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDzsKMApziipJtxVghgd7s8qdJvfNBIwQZWSP2bgViY=;
 b=QhU9K4IwFqJo2kZPmeokv8/T5A0345D69VBl4SOjm5rdCvCciFzN/pSt5VYRn19QrkK6/Pb2jLvbQQEyXDGmNLd7cP2FddLNCMOwroguivDDBDFEomWXxrZTeMUwDSh74fSamyxfUXdutIsbRXq1HtLKoixHCDwZanvvMp5aj8w=
Received: from BN9PR03CA0354.namprd03.prod.outlook.com (2603:10b6:408:f6::29)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:15:13 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::cb) by BN9PR03CA0354.outlook.office365.com
 (2603:10b6:408:f6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 23 Jun 2025 16:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 26/31] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:32 -0400
Message-ID: <20250623161438.124020-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: d11dec59-1745-4425-61b6-08ddb271225a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?68lFDzucwrUamGUAAr34CwiBi2ZUDNzd4xnZNaz2XakgrCyAPoayfwk5gfjC?=
 =?us-ascii?Q?homIecoNYX2MjuS1tWKCV3Iqv63bs1SMjgb1IyjYoEBCcdx9Hm3fv/xZYBml?=
 =?us-ascii?Q?RXmbmQKYqGpvhboDHBDHRDH2GJKi+nswVLkd+GgxSiR0MI6G0VdjQk8FLYPX?=
 =?us-ascii?Q?pRVT75kvVHXY3273EBGnr5BmOkCUgbPTfHqlUsML1g96EALuC8BblGX5uBpn?=
 =?us-ascii?Q?hlgNtltBZsbbeFkl3jE2DhJNcdvGriRJZjCB9BUSvDcGjxBCt5mhqaJo6XM3?=
 =?us-ascii?Q?Urlt31PBWoncfHaAfLSxLsaTTfv5qTWIHb+lVHPYLVf5n/9XdEE0fUtdkD6i?=
 =?us-ascii?Q?0LooMQe1LyrOPnecYzUv7nzDXaOhcTtZj5Dv4HR2JC9WyHMHaCZenYTElPZX?=
 =?us-ascii?Q?bXJIWIhk5xDpJKOtw0+/sanzUQhz7Qf3AcUXQJyx9Sx5A1DpIw54zcxzW3gE?=
 =?us-ascii?Q?KjLsx8jeir5z7gup5ojkPK47069LK1dhr7blpO3UrwBfHgK4B1kUWDGLZCrk?=
 =?us-ascii?Q?dxInuIzRL4B51w+buVAEFTeqi93xF7zE8XBRgSDy6q0pt0dz1YN1U/vmhLXd?=
 =?us-ascii?Q?BtU1sIEpUC72ZvinoYBzfsZhoqGKgUuOY4RMuS7ZW4TR2i43EjKXSSkLjIX/?=
 =?us-ascii?Q?a8dUHZ/FFbMRBrZoPH40eT1uuiPFZfTI5arCALvvPqjFMf7N5C4lqKCXwu77?=
 =?us-ascii?Q?yobkIuvYWALmvsEi9HciLPfri0X5+Gi4xSUibIuyQ6Fkz9sMhWDxfeR3Ua6H?=
 =?us-ascii?Q?8oR8kIVmMJ2O2IelcR3bR+aajIhe1kq8Hcoh08IOChymkI8TjD+lYU3MGLGz?=
 =?us-ascii?Q?qzPkjlYtXuqHj42cCMYg8Vn0ueHiFiERRrcwyZTINft+HjCxFCDdVjo4pyQ2?=
 =?us-ascii?Q?IS28uhOvYhnXBzsqOgmRw+V2cYbVPXksPbtI0GmoGvw1s7jEFD0ujqzUODaf?=
 =?us-ascii?Q?Nx8nHt8YQOJ3dLjevj8LZEaBH2nFvPUuVXyog66ZxMni9NXx6lbe4TlmjF2h?=
 =?us-ascii?Q?dOBo7wQ4gGotLWmVfFg/4v4yiv2zfmkHU+mcLZw4Wk/+mt6Abs8XH1qX2zn7?=
 =?us-ascii?Q?tWXCZm0FJ+1atc2FD9wUC87UwqKUPYppsrLxLDKUTG+VVxZhl3ykBdTfEcZe?=
 =?us-ascii?Q?WaSFdzZBM0W+mXyfhNxw4SK9hqnV+8eXpcw3DwLLmUXp61AoHf9uOCwxymOK?=
 =?us-ascii?Q?ujkhKm5MbiSlKmwQh7QaNluWaE51iTrieJXBcO3TK3ch7KyOW1VEbMnajCiv?=
 =?us-ascii?Q?jPF7e+Hz06T7oK9iwKz1M/o9YZ/JZsqbOf+LlQUNQW9t+fKIeHqM3MgI4VrV?=
 =?us-ascii?Q?YBsyuN4GkeGiXugZl0E0IsJSvEhzxdQSlueYU0BkTM6Xi0gsSTEuPVvXeBbZ?=
 =?us-ascii?Q?qcd5JfHY/QV37DetOYsrKt6/7KohrAq2tjs6YN9kBB6FdcVxU+EXh5WXkP7p?=
 =?us-ascii?Q?2lVVD6L1sgZK9WLP5An1TwoS4uCZaJniK4u/ya7xF3e9OOupAZsM58HR6nM5?=
 =?us-ascii?Q?ug53Mxy/LHp0WKAtnmjtfcl5AFyre3ebDPUj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:13.3450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11dec59-1745-4425-61b6-08ddb271225a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 7e37ddea63550..faf2df7ed3fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1471,21 +1471,14 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.49.0

