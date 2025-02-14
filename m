Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDBCC021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 00:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF60A10EBAB;
	Fri, 14 Feb 2025 00:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vqf7aSCA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20FD10EBAA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 00:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdq3GmCp5Qj6NvXh/NcuUktcwsp+Cmocg10nHZEHzjtH4rGHyZB+0VVX22RvMAhRqtVENEIx9jo4Bl3KIQ7uOjEhJXNVyFvzw+eDDzLIoml2rxxGLDV2AHC8v+LZ3N8ufBGeOEWsLveohzI5+/E37HB4FaXHnDwedL78U3bwWhX1nP95qkeKZlVNWNwxeBAw4jMvs72fhad+Xpyb0nJe93UqpDlY1TKx5wnDJfTN+zT8XaExuXPVUIX68YZHKm5xkP7eELkKR4uLHNh8R6c/i9HcxCgXhr5l/oXun3NXet3pCkTAmF1zjMopK4PdhtdZ9WWdqgPpnXBHUWctXNZvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKjzIKtEiG9dwY4izZ3nix3IIsU8QEPZm4+YyKxEkqw=;
 b=fwf36J8BqDVUuqr85vo/3iXfDR7euJH0RkEAEZFAFx6lv84o57vN3EVxNjmjnFfs6nvGN0rwecWVKwts9wH08GfD14rDDUa+tlPxwRMa0rhlzPohGeQ9C4p5foRNq4szQM6anb9sLWzYaljK9SDZ/KcagnR5CZu0U1UNyrLz3A0DvNIDYo/THEkLvqfIMiYlkILC84aMRjcGvYmJHMvO4O3UUpXLzR+0tOESW4RXVV+TldZlrfh8G/LBE+Qr+3krJxBqZfXvwYNNC19+AJHopif1qk0i1dbi1wYDLeHDI+raQjyhKexxI7rq2BuETXDRzTPPSDbTxzjUyGSkwe6WKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKjzIKtEiG9dwY4izZ3nix3IIsU8QEPZm4+YyKxEkqw=;
 b=Vqf7aSCAi8z4HmyzMekR1brSTyin4ShLpVh1Tmp7VAUfEQzL2MGnei8KqxRzTV3Merg6+Ac00UVSEwLfF4wvJ0htXpOQoKGrkPQeH5+t4+YIM+IDBRxM8N8eTvBV/JD1j+RCVQmAZ4xNloTfQNhnK5bR5L/tT7eisVVz1CsRGxU=
Received: from MN2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:208:1b4::21)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 00:14:08 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::92) by MN2PR15CA0008.outlook.office365.com
 (2603:10b6:208:1b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 00:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 00:14:08 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 18:14:04 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victorchengchi.lu@amd.com>, <hoarce.chen@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Do not write to GRBM_CNTL if Aldebaran SRIOV
Date: Thu, 13 Feb 2025 19:13:47 -0500
Message-ID: <20250214001348.4767-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214001348.4767-1-victorchengchi.lu@amd.com>
References: <20250214001348.4767-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f183403-15fa-4d1c-fcbe-08dd4c8c801c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L+5+LdwcRIZbX2ko/0R/4f/EFltU1V4JcXCAH2Xv0B4+yX1cN9FmW75kBcfa?=
 =?us-ascii?Q?ptndAe2uMTnWXwuK5QeBAEjsZb3KWWj7prB2TaTxcC6phGtuFToVqMrFHFZs?=
 =?us-ascii?Q?M/voo2Cfmx/OH8qJcnx0S8vCaF2vu/DKxP3HKm1SsZc3TvjnwKFKE5V5KXPU?=
 =?us-ascii?Q?ur7f2C25EqpAmvimpFTMh6dvpbjH9Ld0GfE8i04sj3wb/Re2XwzcsV6Mh38W?=
 =?us-ascii?Q?vJeNwoOhVW8UL2UwME/TOOOJS8U3+8e67v6EcjdAvR3aAoxe43Y2s+47PsxT?=
 =?us-ascii?Q?vcE8MgE11SodJ22rPGQFnIjJupGkPG1iWnKfL/0oXQTtGNZiNEe9cH/K98fN?=
 =?us-ascii?Q?q25LfA3x2p5WqG655Im3k6lwWtUXd71wKbSG7VHgLI0CexSZ8WrnLlhYzmCX?=
 =?us-ascii?Q?h/SABYReBKZJ0xqHnWl6rJvooOBXhUrDgg1rErfOIHOvpZtrgn4MKzi9sQ0J?=
 =?us-ascii?Q?7xa427vi5haicVv4gYWNCrRUuNXrc8MATRmRPvhbbnM9NxbONaDkNBUbebb/?=
 =?us-ascii?Q?uy0zsrPDLQ74saq6POYGqn+9DfwKNW3KtBIGVA9VYa3i5miuYYF/uiqbb1/f?=
 =?us-ascii?Q?CTsoUHZ/WIX3Fi7N6YULVcNFWjiZpCIUEm9mSDDvzJ5T192on2Xr6to2WqJd?=
 =?us-ascii?Q?QVzACHUbx1t9Y8jHkO9LoTYxb2HPCl77BFeEUjUkTZPy6rZwH5nfudRwBPHU?=
 =?us-ascii?Q?rLnRInve9ZofWVMiQbO8rF69F2+d8uz7KGZrEAhe8Bz6bZKsCjXk5CIdKvda?=
 =?us-ascii?Q?6lk44+N4jyHES/4MLm/vZdsZZVqXx8+ddjUqOL/rAy/O5gDM2ZrWcrnF3QUX?=
 =?us-ascii?Q?e0NAXrR7zCfZ4CYKoLSf/AIu93axEquek9WivtCWCJEZCjnVjohXpDs1jZKr?=
 =?us-ascii?Q?uA0T+X03uk6wcnWxIeGJdAOIvSDMFavTTCVtC6LbTxJl9EsfXhDkUDIliGRT?=
 =?us-ascii?Q?Y5obGii/n0ZjlU/lQte/kG08TioLmRr535fKz+URXPVnoBAe3Gmdw2bOnYxG?=
 =?us-ascii?Q?0kuL8SWMDheJ7LDS8tAMNTwQaRX/00MPimyl6jTnLI7TyeHn9K2T++aHL8Ft?=
 =?us-ascii?Q?101Rhv2Cm6X01iu0KlWBQruF0BB7DP2yHIPQvewZQdTYq0TB5yJY+mmpxZfh?=
 =?us-ascii?Q?yUoxXNjJFQQMWw5hHW8t7/nVVgdD1zL4HROd7d+IREHDDci+sGn2OOX83hva?=
 =?us-ascii?Q?yi7kNbzEcYWp6opcBoLBtdNHL67gxFN3b+h1bBNTpRt3DuYo9YfPsDvi06M1?=
 =?us-ascii?Q?/qakvnHpN0PMBh51DVluvnALBdYYvH0DlMzSFYqxIThsdc2GMg1CRmloeS7N?=
 =?us-ascii?Q?Jr/emgY0oKZgaA6TMZAV0xTJe4dNh0D9QE3dtBrP+o97PeWHZVjjEtWYc3+q?=
 =?us-ascii?Q?oTBTzNZeXekJf2oOAt/pLI5C+0fmkdkyuFNR05QLbr/pHEf9z7QpV8z7Ok+p?=
 =?us-ascii?Q?FMmCWdG0kw9qRC0+x7pwXCkBZZ7+jtyKC2IFwJI/YXTW4l2drxWwrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:14:08.4369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f183403-15fa-4d1c-fcbe-08dd4c8c801c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
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

Aldebaran SRIOV VF does not have write permissions to GRBM_CTNL.
This access can be skipped to avoid a dmesg warning.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ccdfe7c37517..569a76835918 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2637,7 +2637,9 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int i;
 
-	WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_ALDEBARAN)) {
+		WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	}
 
 	gfx_v9_0_tiling_mode_table_init(adev);
 
-- 
2.34.1

