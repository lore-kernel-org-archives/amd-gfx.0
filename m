Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB26D374B0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FC310EBC7;
	Fri,  5 Dec 2025 21:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QP20V28e";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010051.outbound.protection.outlook.com
 [40.93.198.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DC310EBBF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbXEvIlYZ0Pbb+FDi0HAXRPOn9JwfknuSwumDghpeVTLPi1HY25JgJVROiR8M0SnaIUQatAspM+aQ1ABLcCOFnsVe8zM8/ocjS5gkvg0j1BpX75Kwo/IaVUIhpAjle4aeko6lJ8+ewPohkduYO0y46wRxwTUHUYhrr9X1TBf9BSqf2LgXE/CG/Tim9v2GUzoXQXNApCv94Uz4UY+zH4NTBdLHZXT9E6hdIfaXl3q5bCzB0WoXAQ/g/RioJNJIUbIGEDn9uxVq7/BM4Dzpl5PHfDMtJXlU8xrXqzntqmVcqYPjAwTxw2Nlk1YUg0B4iyzN3fyHAIasSLayhSdrS2KVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MOMsfnzdyltAcL5qp6m4/r3O0URE8JNUo37zrXVi/g=;
 b=F453VB1Dguz4rabeptIKdTqpOpkjMX70KXAZ8orpX4RYyz/TwqM2d6kGNRbHn+HnpP0GMh8Q1LHSUH/moUGuoJ1JDJz7n1QlPxyW/rgIay4DnKTfwBwn6PsKOzAQYeZtPE9k0YD6zHSYpiFjWIo3iyM8SjFNJhhZPp/PHuH4yugC42DZQdgad8VtKnqJQ/eoi1izYsV63MhhAk/AeYzlakeqUfIRW9fIAfa0qvQa2RVEw81Y3jdoFZCjOIARlKc6D/MznlHH4L7GDVuCKvQYqQdU8Hhsau45cSQFMq22Gf3ML6wkYQM26NSDRfPJO42PmBoKIcpcdE1wieQlW0X78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MOMsfnzdyltAcL5qp6m4/r3O0URE8JNUo37zrXVi/g=;
 b=QP20V28eYEBEQ13s/MndiikKhJJVXefzqr9N3KegEVc/k25nHh6Z5jC7n08imLcXmkIWtMYzrzJW6uzkqnO1igq4nEcvkqb632fOkEdCAHiEUDMHSdnaOv7FqhxrKvhjT+eLyJjLi6Z5aYoc8RBt5V1i5ke8UgjwwDG4E6fpbp4=
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Fri, 5 Dec 2025 21:49:46 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::a9) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:45 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant check for async_gfx_ring
Date: Fri, 5 Dec 2025 16:49:19 -0500
Message-ID: <20251205214926.146844-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 043c7e76-bc56-4469-a748-08de34483478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBX3zJVyYXgASgCgpDm2nYxGW9AxPWOM5oRBCQ6Kn2qk5Tv2STjbAxOKxEqB?=
 =?us-ascii?Q?lY5YzTzkmGPQ1U47UhdVBNc5zvT71olHrKlM5iIQiyzN5Ii9gPFuvvKaVPru?=
 =?us-ascii?Q?bn+BJVaoGKXo87kXAZQwM9POr2b0xMWFEipCYKugduzwfxBCtUT6XlesDo5Y?=
 =?us-ascii?Q?XZT9+lhYQjKmuKAdCfPirtNPpLWpjNEZp53LlZJ4l39NXR67pwtifgBJWkij?=
 =?us-ascii?Q?OV12Mf1mXh0VHvPXsAt4Qaq3qscrjfrY8B7fk1G56x899kk63Po/aN6vQrNH?=
 =?us-ascii?Q?wCwOW5/i+uG8DoSVqz2GXFcdQ7M7wPWLzMBjp/+VWYd5cBmgz5DmYeCZkD+5?=
 =?us-ascii?Q?Z0fX9sykB8iHCC4r1H1hg365+/B9wn4cvyZleCB5rVa3N8vOPn5AZp7UUCLp?=
 =?us-ascii?Q?/p13J52d5rWEm6W7G9jfPndMMrWLbwnoU9hYFDwJtTennfQShNglPxfEq8u7?=
 =?us-ascii?Q?2cFknMn+FTyPWyOCtwTOq9xA9F0+2QcWCO5gh4TxtNkyZ0Txq2D32DG+JFKK?=
 =?us-ascii?Q?dIE+RbTLOt4mOEMlySdfepSX/6pVSMAFe5WvZZlr9wFrBFN10PNhyp9gPiRe?=
 =?us-ascii?Q?84asR8yg52IzuCOySfQfrtvcMjMx+H2ygaY2g8T8MGH3dqaPkzbbWVeGBGmB?=
 =?us-ascii?Q?S5VMK7iV+OkLdxdS7qNeZXXSuZNAlg2cV8OR4L817V4Spa8hUiTGWhjXSh4o?=
 =?us-ascii?Q?Edvtx/5ALmRGWN5FlDCKYUyJD+81p91yM3hc43sh5B1Yo/hyA8SQhC2SpM+f?=
 =?us-ascii?Q?FsxrJLPqsTyzx/+4SfHBvwfkvJZGP+F4KHzXvcQ2pO7Ucp9D7XYYxvua0DB0?=
 =?us-ascii?Q?Dgxty4uA3XeLLGmwyDr0+rmXPN4aRrCj2W6yWvolFRAs9Wmew/zBHbGJTPiH?=
 =?us-ascii?Q?iDUCMRxHEiZFh5oh609MiwmuQnUldP1lLFL/znWlnZhFPsrCfQVkaEmAIYRk?=
 =?us-ascii?Q?g0Ohu/jLRenGQ3DOYXdbMEkk+THihTls8cyRmk2FDsoLpKkM9u2glF15dDig?=
 =?us-ascii?Q?W7s8YTiU8vtusciPuL7M+l4MXbh1mATq1EH6rkxPGcFKsaj1gOeZw3Oqil/T?=
 =?us-ascii?Q?yL51bTH2FroqRB1xs+m9JTsTzsaq/4g1GUp07nu8K6ppZw2TgoXE0vtnuHtw?=
 =?us-ascii?Q?ne7XolxYi/dqVv/mkKAVh4tmtt488K6L5ilSde1V4oaDY+jM+B+tTfzfxJcw?=
 =?us-ascii?Q?GONmwwx2LHJ3cfk1+ZZwXULtcBwUSJjnnsb+qCLu79srjDWUVjHvDIzgTYKT?=
 =?us-ascii?Q?uFkbatmLWtvDEtBN13Oe1MEQh8g0SgNuFfMWZ6SbcXYU8c0DArO1yJ6qd2KL?=
 =?us-ascii?Q?mQTRUqTXYiS1O08Zo8LNG2zhYuRTYEDZI15KxGuy2UHLPeLo6cjPiw7NsM8I?=
 =?us-ascii?Q?Typh7FLXRLJAwhSPiJ8GAu6vbTnErplqoiAUsd4TFsm2AQ09nn9UnJSijGRb?=
 =?us-ascii?Q?LQujlxFz0fVJXdcK5q9aoBoBecC0i+d9PY/K8KcmGskv3M/1sG/9t5F/pudf?=
 =?us-ascii?Q?ixmCGAYgEUMPD3Xsypa4AURXXNcCRPf/qHKVLz9tvyhI2+NpAr84r1XnEj5m?=
 =?us-ascii?Q?NSWWuvBYgH+mpVEEx5s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:45.5007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043c7e76-bc56-4469-a748-08de34483478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Remove the redundant check for async_gfx_ring,
as it is not required for gfx v12_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 876cd9be19149..453520d374a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2390,9 +2390,7 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev,
 
 	gfx_v12_1_xcc_cp_set_doorbell_range(adev, xcc_id);
 
-	if (amdgpu_async_gfx_ring) {
-		gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
-	}
+	gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
 
 	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
 		r = amdgpu_mes_kiq_hw_init(adev, xcc_id);
-- 
2.51.1

