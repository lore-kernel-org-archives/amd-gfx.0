Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEFBD374AF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECB610EBC1;
	Fri,  5 Dec 2025 21:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HwbliA0W";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246E110EBBF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3vx1RIc8dKOTpNYXnMcUQxfpypsbUVfGjK7a1vdwDIEP1PI4jaJ8Qfr5bgjaQ30W9au6q73Qfr/nr4ClttSAezsZAwW7aNLxCCJQLcThEKR3Iz44mLsop170KrqkeKpltmpILYSWR7ff9n+5smtnUbOQ5uQnEQU0dQLfuNEhBA0ZfaSp9ZPqcvo8YflxOykHOPlbbci0O98K12wsvsJXJzFw2MrgM4iWVHa4KNpDSolYggnTyL6pAJO02/PhrKBzjw2FDXtBQXZjfURHfMGja0nIaEHXAtfGAMlAF6e2L1y6sCWSV9s39xAuLXnzs2frP8MzBXIAzdZRQ2KXvcTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2Efk0OVbEX47W0g84Ead+Ua48AbjnPAvefm9JNptIQ=;
 b=dugTlWh8I7JaDfIfGq/ucwyya5g9pBV5u8TfqXavh+SEiFX6vpx37o3NFwntg+Oy9EKxm3nGVu8Vbk9KOR6M7rlr89JbQU2W15BLo5YlS1TWbQ/yYvYTBXCtbRDM7gDOO3g6/ob+6cHTHR/suu1ycmbojwmAFXHBoo70fd6cR46QsiJ+GvXGsUXEen7HkLzXgblTfpn4fckvN7K4ri7DcE3bN5JHgqRFN0KOczK++6SiirbonR2ZDWiZpke8UHD8j0v/+t4FkTHW/cQLPmDwR/8XvwmdBLR/8jpiz4ZHUhz5PM8hKuQRy+6k8bDSo2z8BOBO0pAFRuMDUlV1DBVwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Efk0OVbEX47W0g84Ead+Ua48AbjnPAvefm9JNptIQ=;
 b=HwbliA0Wvo2f07jv/qfQHkfm9wOjgo2zpwx4k52fG0xEDkiGjIboKm/Na9077F7rH5U9hWYqfptrbFIMhq8GNZAQpDd7UugS2K+z12fihQUBi4XnBHCV1Df+VXCn4hb/S1HhRa5Y5rmwCk3GKDBmMX7lucIq05pUO6D5MaGFr5M=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.12; Fri, 5 Dec 2025 21:49:44 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::ce) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:44 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable unmap doorbell handle for gfx v12_1
Date: Fri, 5 Dec 2025 16:49:17 -0500
Message-ID: <20251205214926.146844-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: af551fe8-ff57-491a-8739-08de344833e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+lElISIAnskXvXzUW0K3BetI7N+MA71hr9dM0utsLP2bvltXaxaSsySj9lvw?=
 =?us-ascii?Q?AvK0AaqjooRnIP+hSCKXI8/1o1D+y/iEu+BMXrL2MzINfzP6InmObsCewTwX?=
 =?us-ascii?Q?wbrnQ/pOb453JtX4NtZYyq1/QNmJPcWiZ7Vhsv6a/QnUYy2nDFabJNVbCGGo?=
 =?us-ascii?Q?sAmClf16zDp4qhmwgTp683cHXp8Iw1AygIc+pG6onvgkLqHLh68F2vThmT8f?=
 =?us-ascii?Q?g0PJ1D1uY91/dvs7jzbZTx/nXS4hv0ZQmihYPPFEdfQ5E7u4krjKnt/+bu7g?=
 =?us-ascii?Q?LF/NvWkk4vqI1eXOYE5lP3OU2FpyFK2tUHMPLH3GCvR9js7JT0jOFe4vFFj5?=
 =?us-ascii?Q?XVtLknYm68zw8oZ/J3yR/5TO/okeN/KWz0ysexrHFtnNAnQxy1kHCD6NcEB0?=
 =?us-ascii?Q?sw0hSs+CjJegxd0Zz/Sk+7gPmQFbTly0kWLTkkT7DHMKY3c0+8mWCQFOiN/X?=
 =?us-ascii?Q?N1VZ52fLiN4nPfcwTOWKoBil71zr6rfqm/jyJdpQAyg/KIZElc2DWj4u1v8w?=
 =?us-ascii?Q?ceNGJbQ0AkZSk0MHc7KiBKp9ccAE2cDS40Ymv5cyLHSKQdwUFQ3aBsxv32y6?=
 =?us-ascii?Q?GfBsQAJwGTap5Qu3JGec0GNcuBgJziCO4SJ8Wv6Nl4uPJGQZFQWO5LrgRInh?=
 =?us-ascii?Q?Cc6d2i2lhkOHhvnBGZAh1msJWC/Oa1KM7m+zUyDgEjkDij3Hqxo+FUDers3f?=
 =?us-ascii?Q?EgQ/+d536yGzO0ef/9UyKKccusJLE+uFZ/fl2JGgc+Oi0NiLjwpU/sWAsEmG?=
 =?us-ascii?Q?j+sJ8iY6aMWTJFe6i8iZ918bSDK1X/Zie0u1v1Bx1kyUPO//lS3EYQaxhBp4?=
 =?us-ascii?Q?6bgfvPzOLiD70eaI73avaO7ojyWTVBNXwyKk64cFeqPTqjHCLsiTlkx1iiNI?=
 =?us-ascii?Q?nXtpjQOuQ6O/bqcNx5vBJCz/1UdEm8K1qbOmOnRmq7FtilimdqTWAw93Tct8?=
 =?us-ascii?Q?YpvHGn6I6iTwQ2+4Satjpaz99sDymGCdDcrn55zK5M1jE62Epz/oP17Ij2O4?=
 =?us-ascii?Q?4Job+5QowmKc3dMA9SoYoAXaKsqljaYssMasJZB4qby5R+ZiGryXo4OgGjN0?=
 =?us-ascii?Q?fMR7F3MtK6e0Xm8U7pB6MP0SPvHq3VtCnQbUpIGPg3VGgNAjIDvkNMzzGzuO?=
 =?us-ascii?Q?VbOaTxJhw9ubxRpwqdbIlMNV4XKo4yoztSmk5+kPPCPsLXN+nYyJuU2PFufv?=
 =?us-ascii?Q?fFTC05hQJQ21hcQZW1fIrrIpv3Mb5yuYieEj6tgi2ZDKJTIeoXnSmjSDG7mf?=
 =?us-ascii?Q?JeyOxEH7DxfMCPvTYmi1fOzvtHQ/5Gy41neSf7Acbc/K209bUZkjNe80IIwA?=
 =?us-ascii?Q?yGllvdGnQH7R0h1jpvqXEcOH10JmUix84uXR+zx9ld/FVOGUgusntkmCl2w1?=
 =?us-ascii?Q?pSNdDl8N0gfK9tin3C19cfz1alnNrkfrl+WLkqEdeduL2j+SyEsFBTVsuwpI?=
 =?us-ascii?Q?NlC0kdd25tXDYvX9ilmzsHhVxcd/39FqDNSL1ShLJzsLVk/MJ17BsCZQEJxZ?=
 =?us-ascii?Q?cLk9ocYxOC59VYaTFxBJH6ZVs5MMur9BEAZP+KIaq/thqYK3VLsM3uXoVNsm?=
 =?us-ascii?Q?5U+KOpX0T+IeWDAhGJQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:44.5631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af551fe8-ff57-491a-8739-08de344833e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

From: Likun Gao <Likun.Gao@amd.com>

Enable unmapped doorbell handling for gfx v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 02200747446f1..cc2a715f373fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1228,7 +1228,7 @@ static int mes_v12_1_mqd_init(struct amdgpu_ring *ring)
 	 * doorbell handling. This is a reserved CP internal register can
 	 * not be accesss by others
 	 */
-	//mqd->cp_hqd_gfx_control = BIT(15);
+	mqd->cp_hqd_gfx_control = BIT(15);
 
 	return 0;
 }
-- 
2.51.1

