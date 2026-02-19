Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCD5E9A04D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A9010E706;
	Thu, 19 Feb 2026 16:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MZ6HSm0z";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C56110E700
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNx3yiYcqhmpWFDqZ+jqBXAEN+JrZlwv3O++ttj9wlSOC5fObL+NTBYra4ZY5DhJePo74pJcmeQG6tDY8NCqrvag4ZR90AO4c2ia3rVPjeWdNkx+WjaUsYEz1ZcAK4H8iN0IpXdBBg5wrXB0uhbox7F7FWySz9/hS68fuhCQ1ziaf0x6fpDmXMGptxd+gLJrptnZUwoci3ZaGASl5JorBgzBuJKGO2qs8Uhucled86i3BscQKkQ7wZ/3cZO4q0saBrh8upKc0/uLMYwzaCbH5WOVQE/2C0YyHvMU/SIC2OgufkjHv/2WJ9LGraUKE4ZwkFpts9FCO9jARbXJALMoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NHYsELs6vQlExOqD0wI/q/2cpv+jcSN3bZY2BCBh9o=;
 b=Ac9iutmbGfw2Y3hFOGGNEhsReOJwb+ddtnAszMmiELvqCLW7YUoaoIG7vC5nloWwZ/H8rCasQD5UsoNzs9nS4zAAhjQtugQH+ITTQtAuLeN6Irh/H/xnJfHclE5PgoDuievcJ1ZsIR4WMPCL+UiKLPib8o73DCIMnF7QYN8szaHGShyU1A/Z9vsEXf9Mp3Dq5yfvVh628SAJD+NZWLFhpIYUvAWBRO5C4GWwuOsBAwnQBKAuScDhz33fwCOv4Ix5V4txbx41Xo6SG2yE5n2Ht1HXPs27n+QbvS1n0kinUL34AZ4OuffX0AaOA64BSzvhwzjqpTu7sScO3tumC6VTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NHYsELs6vQlExOqD0wI/q/2cpv+jcSN3bZY2BCBh9o=;
 b=MZ6HSm0z6ttAqPDKdq7ySNxPJAbRCu2fpiX5siBREz0zn9O7odHdSDrdovVPph9jaIHGFcmjaLpE/SxmM9teXc7w+IEjam6+bB2ixMIhf7pSt7UQqNGP56OzC0Dw9hWFEpqwpcGUoxWRzjNEyDQ+9NjYvSriup/e7YXWv9HuObE=
Received: from BL1PR13CA0237.namprd13.prod.outlook.com (2603:10b6:208:2bf::32)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 16:02:41 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::ff) by BL1PR13CA0237.outlook.office365.com
 (2603:10b6:208:2bf::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 16:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 16:02:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:39 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 10:02:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 5/7] drm/amdgpu/sdma6.0: adjust SDMA limits
Date: Thu, 19 Feb 2026 11:02:22 -0500
Message-ID: <20260219160224.1976043-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219160224.1976043-1-alexander.deucher@amd.com>
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2974fde4-1a6e-483c-baa6-08de6fd04ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XVfpNKUdUOgrlGqhpQfD7DGYmqb8S2m1dmIoW+4FS9S6IKHa/2rUOuho+BH1?=
 =?us-ascii?Q?ByP961zeMKtVY9nkKIGd6hHyz0/zLsmPYr5HqKeC3A4GZXlolrpoSJD7r4MD?=
 =?us-ascii?Q?Fj8e6Q8sIYFhQA+NGVoMY2XTdPws7GIn5/luXGlomybyuEsnep151pD+F6/4?=
 =?us-ascii?Q?RDq1SbkyQKS8wvs1nEn1F2SllSptyZEkGG3BmnOHK1iPe/ZzhGbpdq1DcRut?=
 =?us-ascii?Q?QzrX7jCDD6fcM15v2W6zQzKJ6HS2XpiSCO/N2KXhQyY5UBL11uSqsMiQs3Lb?=
 =?us-ascii?Q?P3lS+e5b6MoxQB+lww1Tp22Cfo8TyZHaAJeBuiXqDPLX7huhBLdsRvm8Y/JA?=
 =?us-ascii?Q?XLwqsa0xWk8Dgp9KtDS2rL5gxPNd2XvhvDhOfCq/azedlpmKBsoBuOzbTur7?=
 =?us-ascii?Q?1uIUtycCw2IYBcyHhTPPPU/2clah8w788u0OcOTr7jbwoXbCni+4FaKJKne8?=
 =?us-ascii?Q?A2HwZsI/F8TrGSlw0XZEx6h/QklXvLXEHMgFI/s6TeQWgEckyGGUPbIg2CRV?=
 =?us-ascii?Q?TiV3yxH9GBw6FiASl12aMdA+J2QVxRWajKTZMZ8FfkvBn6kdypaAGssFzxMN?=
 =?us-ascii?Q?xWz3qbhzEOSCMVj3LzKUyzehuEDhwEOtwD7CLowl0DFZ8I+DIfaqsXXO3v5t?=
 =?us-ascii?Q?+U0LUcTS7xQjBABDwno9dIbsdoR0uHXBghqaLR3lk2IieEw8gfQOW6zFECjw?=
 =?us-ascii?Q?AKjRbotINJbcZGBD2hajIJxMRrapoxoDPGXXvSBBkfiNzndYX4t8TmqwT5P9?=
 =?us-ascii?Q?IR2pqiwkaRjhNB+036r7GTeSeBLq9uV6lZd5IkpSgDWT/AoP28NeOp33K4sd?=
 =?us-ascii?Q?ki50+GsYr/w/D3XjoRh1RFv84CjLkADAuIWGUvEya7vbLtDCwuHw3+mY+F6U?=
 =?us-ascii?Q?I4jtKiwfFAv/vRolHqfZlcNEhFRz5j8mnw03Idq5grZ5sIv09gWsrerMtET2?=
 =?us-ascii?Q?sZGSSQaZnEVSrXAGB1tW5tIgez7Vx3CEXKC9q4M12KFMNiq0PZ5S9R1Rp44H?=
 =?us-ascii?Q?ksWgyeFYwrAiGkehhr/mElOBxsaFrdqto4+bpYN3KL2U/eD84k+DQVny2jfa?=
 =?us-ascii?Q?AoUXZPArhHEK7p4UODDnI6VJYkAerz3hCuxwZcH01CQCGthm1lj3cq7c7CLB?=
 =?us-ascii?Q?b+III9bi6lLJnnBc+WRBwSoqE5mpOl9gkaOAEqFVk2xzhpm8nf0WFTiIRkF2?=
 =?us-ascii?Q?eKVE4ces6/5vTdlrhcCZkvO1qkxgadz4yqjhnQO4Z4vl5WtjrdtlD38m7Xcm?=
 =?us-ascii?Q?gBQjIUJj2NlV3QWI4ta3It9QDnOssv+VyQ+A97bU+cD7S7j8jpZBsjcZdhad?=
 =?us-ascii?Q?1bKEZOy1FmGsuCn8Z1T4E8wGqJowIk+9akLkhK8Oe9gs8IIVuVT30k1CeGJ3?=
 =?us-ascii?Q?ZAKUBecbqn+2bTwtlVST4A8JqWPOOP7cet3245W06PCMM1ifqjW4b6wZOZiA?=
 =?us-ascii?Q?PCf4iJN4PESxaS4gPn7Egyafs5ZttKnu5lcrpTR5by0kowW0kKOADOYVx9a8?=
 =?us-ascii?Q?75jK/3d4iFoC9wqbi4KbLISNx7XsZ4ueUIwMkEoEJ/csDMFiQEFZ6tojnZb5?=
 =?us-ascii?Q?E24m5rIkwzTG/LPSDEmbg5hQlRnIJZ5Ra9uyK1GbPL+GtTMTxsYzYSD5st5E?=
 =?us-ascii?Q?3iQ2NJYIu/UEAGboTyiXw9gtSZmt3mdz6yahLxTlYIk83+PepFI/joa8bNHK?=
 =?us-ascii?Q?ILVa9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kUa8QKASXclBUurp0yCdfMwJXk4DvSVHCMysBn3+7JLxcSlhoWUinDh2xHaK5LcXLuL2QvkOq4B3j3/b+nEIEEoiPgtFsClSwSjhOoDqKFzPDlOkSC74kc65ZPSRqf6FPgHC+Xx/9Ru9q8ktFCH0cOuAV9zZV1ZwEplM49WXWT4J5YzTbKn0SxCWXmRHtkNCLtwfDh+jHfwXboZ2cG+4W8b1V0E9nY4T8v4YZx45QsDyFRtvQX0jHbQ5+5nQMOBJzyZEmlLht8/JyWYXfZNVK3Uo9dbvTjcZf+/bQXtwYi5sBQJKWr8cqGXUCSutzZzmnzBxby9T1bhondXR5Tgx/Glr7YtaPVUqRJoh3IYBleWlX7Tt5YXR3/KRipzItVhY70cBLSYjRf5tSFa7lvo7U5r76kWHdD+fIcwxQzDAiBXEN1yw8hYzkBhkmJ57BUxX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:02:40.1597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2974fde4-1a6e-483c-baa6-08de6fd04ef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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

SDMA 6.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2643364328498..b005672f2f96b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1884,11 +1884,11 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v6_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v6_0_emit_fill_buffer,
 };
-- 
2.53.0

