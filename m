Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D61FC83F21
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA89110EAFA;
	Fri, 11 Jul 2025 22:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VkO4dP6Q";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60FC710EAF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0A9Cgyf5IUhPBJB9//AlUVw6rHm9HWHTqKS5qfbldOtjKU+wHyTCMvAbeSDEAxHAX2xylk19SjSTPADLynRl5D4hvTZKJ1N2rLl9YNpD75/N/t07Z8TvFOXSqbuoACLV0aDeUt2IAJqIGp/UmFYQnbUwpE2gDnzzmYoItpFknF/t/A9XyS8GDTcRbk3CfuP9aTjJ/4fhcY/u5DVXA5jtaAIv+tnTAYrbMgsFO6F5LS/whhORK/z1om66UbfR17cbtRPF9pepK+nKXnBJqvPsTLW/H/DhMDFntHqD6X62OPpFpsXNmkezyBoyOei/07lR6vrU1xZMJ5/Er3gj/sedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWtF3Tv0+UqNiTG/mGIFc5VL6Ut9GaMNki/KC5lBAWg=;
 b=U/UhqMyKDTifJmAgBM5QpYji1OTC5wV3N8jOnmTFtWbCKzAgIzyVRawRYMaasLxYrMXht5B9KVU8xHemzArzCJA4hmhTJX48UsC1iFfSRJVQpgNkNG2sZDjwvjzyuktMZiFkSatXGYei1n6YtSHH2cq75aAw6xQNYT3HWPta4gu7b+mQBevlQcqR44sR2BOOqwWtYpHAW9GTkEC8Cy6lkjLueeJInNQMbgUEqjVzPatOvqU5qsjfcj1LKtS9aqTnRgtSRtIhYeXc0c0PN4Kq9TcR/rje0EKCtbt1hnEY2tAkBOz7WLMDkb9y13DSaaUyTE+4vxeQmhzVLYQfBvytWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWtF3Tv0+UqNiTG/mGIFc5VL6Ut9GaMNki/KC5lBAWg=;
 b=VkO4dP6Q/uNhbXLhBhWLhaeDRs5twDdeLOe/8Lu+J4q1uvLnkFmaDN0DtKZ7LBw/OHY/6QaNvJLy3jM6YHoA+iKxkzYxMb2kdTuRFXgdfnW6O4hd2HNMor6uXGK9QgRndlPey0NYicfdUqF94oGZlS9HY+aq/rnEYlyQ2lc97qg=
Received: from BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14) by
 SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Fri, 11 Jul
 2025 22:40:57 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::68) by BYAPR01CA0037.outlook.office365.com
 (2603:10b6:a03:94::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
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
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 28/33] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:19 -0400
Message-ID: <20250711224024.410506-29-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ad8419-28bd-420f-f672-08ddc0cc00eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dMIdX39apyQAzUZQGEaK/O/KmLwW/2cC2rXsIYWGVMF7aQn/fl/uqJHRqX2j?=
 =?us-ascii?Q?ea07JWMEGeiX2bPaS3/2bNh0o8VVqI8b5PpzSKYuGntPjMPOT9xzkfl/f9ct?=
 =?us-ascii?Q?LkXtFvT+M2imQzHcAz6ZerOA+up+eOXl3BFmiNJNlcYt0Jxk0Rn/HQaZOcrw?=
 =?us-ascii?Q?AABHorzgjyFqYV1eGA6ysUwzJz0aFsES/gVlGcWCsw0jKp+AcxptyqLj2b3Z?=
 =?us-ascii?Q?3dFSfOq+LTlANm3P9zg+Y7G0NMXUaqzA7jBTRHYtk7y+FVwXC4IaCGAUo5pf?=
 =?us-ascii?Q?ctoL65LYKh5STV7O9mmaWGxhAq1sYUTEsQPTL0Td+TmERqaFIQ6B+FDI5wIJ?=
 =?us-ascii?Q?IvGNbOKZTW67LhKT01JUXxn52sjIWRePkqkxm4H7DZy0e4J+Ux5W5qht8oAR?=
 =?us-ascii?Q?Z7eJlCkMTFrhEqAuTGAx/kq79jbK7GEsBeNIS6W6PL8y1L91RkdWv70NpAXE?=
 =?us-ascii?Q?3M71Q6ooiefsR8cSQGSW4AEeYWCQUuWdYF/n0mhsy8agVt7iO4IelFTYnvyU?=
 =?us-ascii?Q?ln9mQOUKl4X+DioNgczUtRm0mXrbGn2JrRERT50LXuqHrpDInsw16BHlKUso?=
 =?us-ascii?Q?fhX6bikiWefXUsyoxgQzjebCtG9mcrkJgZwQev4siLwUuoX7nBvFEZZk1SF1?=
 =?us-ascii?Q?unSAyQQjOakl5JhJnw/0OKlUAS0i+IBU3dKYclgbzG9950LL5ulQy6KseM9+?=
 =?us-ascii?Q?bbYZuIjOW9MXP+jykuH/e150p7h7AWMBUfpaZPcht1Md8rOVvEleKOm3auYL?=
 =?us-ascii?Q?boezg+FK0jdW3r30ebpz+VSRjYOosRdB8kgz+oVEOBxASw3nDDzPP6/D4H0B?=
 =?us-ascii?Q?cLC+rVp/6tQcPe3phcRXIydFJcNtzrZfNp+Q4DQ0p4TG9oE55GFNzsotFznm?=
 =?us-ascii?Q?GpnMeTzfVgF/X479B2+eHrkguD6wdRd65SYYEpcinYJrk3gYjBKt0KIprrXu?=
 =?us-ascii?Q?kZaHQS6fV3lH9erir+riwra28c9th4Tvi/iLKNrOdR4iVMn0jQjmHMnCNtGU?=
 =?us-ascii?Q?i3BcN9Bd2eOSOX1ID1kw7tTJWfcqIlC08fvA2Mb1wy+nBmqBAM7KFduqFGg7?=
 =?us-ascii?Q?/cAPBsB7E1FefAKwI6hAzC0iVvRbRAN3wrvUEkHrURLijbVSme0XIbiJMqpR?=
 =?us-ascii?Q?kepJsa+XKAvcpCbV2uahola3hlBfAjvKFBbUWgUtJ9nZ14G3JZCkeRjrg4zU?=
 =?us-ascii?Q?oV/SvCVJNCXD1wbS5CqyW/vxicItYEp0uK8gn6iZeH4/BORYZc9oPrxJ0a8N?=
 =?us-ascii?Q?c/Z9pDwns69u84JlwfhFc57+LGG+9MM53rah3tZnkMQzIipyII8jJ1WsVYJF?=
 =?us-ascii?Q?71SIKapOI/w1udaJuUaaKsllLlFSxxwzRm2NCYEPdKuwhW90DLHmcpUEsoSI?=
 =?us-ascii?Q?N73+Y/2hJertQZe0Vhq/64ItHAcXA9oXrAeV2umY9Klk0REuFXbTX+RbQcf8?=
 =?us-ascii?Q?lwEUplWtZabD49ziRhT1U/lb6iQi6bma8w9/IXFp5fW16R6yeNib6ytiHdce?=
 =?us-ascii?Q?i/79PcYdBPDcq4Qw6eDs217LSSQV0H/wX3oV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:57.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ad8419-28bd-420f-f672-08ddc0cc00eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 732e9a9293d26..039989ab452ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1477,20 +1477,14 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_5_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v4_0_5_start(vinst);
 	if (r)
 		return r;
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
2.50.0

