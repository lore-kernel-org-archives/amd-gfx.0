Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD2E9A04D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 19:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C046C10E30F;
	Wed, 18 Feb 2026 19:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UZ6D0QL+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6DF10E30C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 19:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAzlBmTzzbDVEgwO/HroIKiRnYK14Tcw5kIklRzRR2lttlwC7Dsh4duaXRqFIOd6royo9jkVGdR90Ih/UQ1AgIC91Vd5buJWLNe8bk5fEFDOIEdmKZxJCnvy2gxR/IisrIA1qUgyP1qWUk9VJUlAYt9S9gdQRFD2qgZ+jADwQ9RrwCdvf/sHsP4mrbtNNlvL2BZK47eXHVC9QOUoU4+5WtOY5/5i13WnYW8e0KpOwy1foLxnWyYplPMm/WeWKOaPpvTkTKPf/feGWnV41R1XnmhdqV/7Pj6ZmZp2wXSIPkkdeP4mrWWgjid6ZHc4WwUg73S0TRJuAtjuP4YXupZ2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjIucoPVY3INfZMmE4cb1ApWRdCoR0efXkGwWHBdErA=;
 b=BAi0vFUEEzCc9jCq84d1/8zvM8clV+VrCSoU7dbLJcGqUUg3X8KA0kwz5618FGGCpkWLlsLdscWzCHB2QPsIRrQ2HwX0WpVTcd9lqZA3j+KF+lZpPiGhc2NI9xldgOxsjennl5y2O2x9KjzIwybLSsIoUIeeAV0BBx5wVETJeDfeZZ23k1zuJA82C7El9+INw7Hfxg4vKfUAjyV5greb61drh/yiQgd3HslXJL6z7Uwf4LYsev+2xPl8gJy25CP8O8Z0LC+YXlHCku5bJ66A0V29gejTv5srgkt0EFBjHem3zUpPmtup2VOYKprQr27o90OCu91eeLYRVYqlbgIILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjIucoPVY3INfZMmE4cb1ApWRdCoR0efXkGwWHBdErA=;
 b=UZ6D0QL+xV8xDSpxR4bRJUYbdBX4EpkQMBHFQc4TPy9dVRBTVsOaY4jEtdensiZ07NSBVppLIk+yB1r/6xPEHC/mj0Spnm3Y778/2/nIfavKNI/mMQl3JXRLr9On+GcCPCPb0+Ii4/SHoiu0lEBRNtRqjGipFX05OiNoIqqjIEw=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 19:34:25 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::cd) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 19:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 19:34:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 13:34:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 11:34:24 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 13:34:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx11: align mqd settings with KFD
Date: Wed, 18 Feb 2026 14:34:15 -0500
Message-ID: <20260218193416.1474441-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218193416.1474441-1-alexander.deucher@amd.com>
References: <20260218193416.1474441-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d908bb4-7184-45e6-552b-08de6f24b96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5N0SYpxmFlbycGq749VItlM/QjR6178PkSZYgd7OlSwSxa7IIvsK75ziyzVH?=
 =?us-ascii?Q?dIRnQqnLTeQUazibx2NNL+lVFcsjh0iSqBEj8C64TjRD0BjfWGbDtwx7t/zA?=
 =?us-ascii?Q?Vfc+nRbQ7ERZXbAh+yee8j4ORjfmXMFhsdG8vs8EnMT/POkYSRnINIDq59LB?=
 =?us-ascii?Q?okoDzrANVglzUL0ASLceMaOmYNJGxp0VB/7Ub7dwodEX9pbZBOHHqaMXazX2?=
 =?us-ascii?Q?mQmi4T6S3OO2xM+u6rerUuVnLlOwHPt/MTvunyC/vv99qv0z4h22uCBerdHU?=
 =?us-ascii?Q?J3s6kzGyl09siKQPHuZyhnuo3JlL2yOJmOuQMoNFSCMqMCgU7vnqnYUiuSO2?=
 =?us-ascii?Q?1+pGJG3ussvJRGsSPnAI0csdDomaAVZmr7uOYibwAUnhT4+ZXpq0wabQqfTj?=
 =?us-ascii?Q?ZWvglcHOLFfChgplvEn/C1aRaB577loAXKGbFfcY1eBrrr58J54x408gvBv/?=
 =?us-ascii?Q?r5DBiunDUI27WdVpNyrjIRw+TKwwGsLIUIXjIohgCD1twoAQCoJf0gZ0Ws03?=
 =?us-ascii?Q?WMJ8OZjRRWuokThmd3GdOSjCBbxTicmx+5sHF8yxye/yzxM40o7kpESIfqKy?=
 =?us-ascii?Q?8ZtBOtcxdBAGU5JHozea4Gs69O73yGFbVq5w+tI/Q/BJB6RjZTDtl3AXZXZS?=
 =?us-ascii?Q?UYjdwxfcXhNA/Lcq6Q7xSpF1BXW0thsK411Wa4wCQQYKVCF4CSYXmpfva2nA?=
 =?us-ascii?Q?032YMmOBYDpoc9FhNohjHmNlrfQLHkfbU5H5FLDxsMw0t7RH5qK5iJeiGQF9?=
 =?us-ascii?Q?wxL64nuLsbC8eYWyYz9nyluvrFMnAVD6gsHg1+/5XjPisOx2g8qHZSO0bnH6?=
 =?us-ascii?Q?6VwDIuVAQ+ocBx6iofyNmDRExYcxgfsTCDVN+AwPp+q7zJzrEpV6Gh0UGv99?=
 =?us-ascii?Q?JzKu17T+mTQxXrQ7Fdb2Ne8uZySOkaBR6ghn0ghpydwIEjeH7oOtizJyxJUa?=
 =?us-ascii?Q?QkNxvXu5E14FIltEdNaYwv9fjtcEecOWkwMRcvDDHYjbByUuPP2FMPoCRfUg?=
 =?us-ascii?Q?S91zh8mIUVI4Xwau67++BqDIzZ2jCPuH6UPG9PHRwsA1xup2xrWIn2WWev+w?=
 =?us-ascii?Q?wkmvvcjhPGeoXHX7aBLwcg6v5ylJGwean10llrmZOOLdd7eTdvPjaJP/IRXc?=
 =?us-ascii?Q?bvVdK/XeNNN0EY+z6DU68BSz92f5tMb7ZsMsC/DglCpIV4XUayTum1iaQvTg?=
 =?us-ascii?Q?kbZG4SVFMKwQSYfCa9Yr3SZT15MyJpzHXFdcRO53UPAF4o/x8+gTFzWcl4xH?=
 =?us-ascii?Q?nZSJFboQna6tA+M8g0Kpt5Ps5ZaCFCqKcGiL+srzmYW/cAWtBOF7fjpA2WJq?=
 =?us-ascii?Q?YbsH0ejB4GHAGmSIgobLjtgvF+HmwV6UNX43aCA8yKWXOIJ6dpj5R0zu9S7v?=
 =?us-ascii?Q?PWh8RJqHMrLf54ak8uMOX+6OBWvrB+7dYfLl5uSeWiX7FTRNkor0DWHLEuYT?=
 =?us-ascii?Q?jIRXCBSUUGVVlBhGpJCxJ8Tl+ouaH8cUE8xWyOros0hojBEXpVnFgnpRHMlR?=
 =?us-ascii?Q?UlppXN2ctSlyTRcuIviC3AIulU/i1Rz9y+b1ns6tTch5SE9pmUpTbDUour4s?=
 =?us-ascii?Q?3eNpBZSwYE8xlGJHrwE9//lcjk0CdBiGXq3HIpyoWuo/bZUj/5oABDYgOW6j?=
 =?us-ascii?Q?O7r9OyZC7itQACX2xk8fEmvtNUwbvvFtCgzPM7ujO+sg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zesT3oLhCDSpX4fdpkZ6plUQF5oI1/ihuHtY1s2EkC0dYB38ErRy541u6TVFbeSXVcZvpySXNj3gDlLSj/q+uLPPGuPxT2EGdbZfaVVj6yjsSggClMur1TH/zfgnOBSJVmL9S8bcVchqreWUwIKGNv3ehfzu2WIFuVTktZ62eodC/hlu2BpMgKeVxa6C7hz9Z8im/zJJ4dxaNkDpqyhaTfmEQme1r/9RZYQmeE2HsUyaKLeBn+AuOIXF+RzPWGVn+AY+GLe66KhSnd1fIKVvE1vLCQZg/4xcvspgoteEvpciPVofXs5GZRVfMMJ9lJBOUL5kl45qZOGJjHwYmECpjRsluA+NVUnCvv5US1psn9qCbwZDo8RnUiKVFGqmrQjFWWEkrlT0dldu1MOYuRaPHUBeRT9DY3RNM8KIEmotRDsSFCTN+dbHxtH4I8++2FLQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:34:25.3140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d908bb4-7184-45e6-552b-08de6f24b96c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e7ee112330ad0..61be7996775e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4408,6 +4408,11 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
+	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
+
 	mqd->cp_hqd_active = prop->hqd_active;
 
 	/* set UQ fenceaddress */
-- 
2.53.0

