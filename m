Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF46C4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 06:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB5A112160;
	Mon,  6 May 2024 06:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gWEvOFva";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC30112160
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 06:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU3MnokSPlQ2CXYDCpeI9//eEvURd+6e4+aT8ifeh7Q2gUqR1thYO9YN5k+mpMy8/8LVk3X6hwOzA12XSG4c1IJwR1Nx7aI2M+1GQGKE2+XkhVHRblhqHGEtz6kZTTX3aZuaXof57wZCtu2IxQPsAGvqkrdJQd/iRRMnOxxHVOACbuH0HDF2tRzXd2E80BmqM6VZXLs4wYt/JH/naI8N2sk2VChTgJomlWPgYsMSOhbguir9UUo0XUkLYp5GL63ZHxG8/fh/fFF5L+b/fGUmHMacT9S3kQUnfuW74j75bDqvZBQmvdsb8vgaE4cg7yp8p1sdNJ0wzyjHwCLYsntokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKD+czpUlt08KAoYMG+ENJ059GCrQ4STVZaBP0Ijo6I=;
 b=n8RSSjzXxu7d5cdNuHOKMSpDECN9jdthttVP42RdP9tD/CK6pnfU7VKKZEvDWVwx/RzFzE84DOGH2nbS5KIPN/g+fMcJ4bwXdqFJD/xoxrr+4BUTQC/2PJUhVm0Z0O/FMwlmL+8hOyy4cx/lGsUcjGFFOTZ5vMtULkr0G9h8YhwzyOsSkXpJiIX+KGBOL3WNnsMIw6ywnyl5ZxBgsoZ+IZ+oUDhZBXNfp8mZoQrr7/VO8IUSYfbLwLY3OIWb7PEXehgW61VemtF7gUe+QIQilEZ00NoeA4PqU089BX6EI0vtQ1L5WnK91sqrhkypbZYHZ+Ne/rnuwFB1Lbpzr8ekmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKD+czpUlt08KAoYMG+ENJ059GCrQ4STVZaBP0Ijo6I=;
 b=gWEvOFvas8ejlEpDKu9UZL+JUWo2mrjZgvu1TNuiUY/HEgvnPz5KiCPYgZhKbC1O/F8giUUeGxNgtH7f4aUsOJMCVeOGy0ogrXNSWpJmelz9/+0Ezxd9SuAMqXFovpGA312uh7fGA+vrVN7MONPXWzOpFrYk9EhP2lved3E7I5c=
Received: from CY5PR14CA0011.namprd14.prod.outlook.com (2603:10b6:930:2::20)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 06:13:01 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::b9) by CY5PR14CA0011.outlook.office365.com
 (2603:10b6:930:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 06:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 06:13:00 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 01:12:57 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix uninitialized variable warning for jpeg_v4
Date: Mon, 6 May 2024 14:12:07 +0800
Message-ID: <20240506061207.2017901-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506061207.2017901-1-Tim.Huang@amd.com>
References: <20240506061207.2017901-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bea0a94-67ff-4c57-9d82-08dc6d939516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aOdFJZalxuiHfhD7Vu5bwzhtNaf0/rVjlgkDDF7H5dSc3l7w+u8HdZYB4N2f?=
 =?us-ascii?Q?Mm+qZoUbdMuCywPiUYXkHV2aFpTS6SJ0fYlb0tJq7GxJ4YwXqFf6JRa0P28h?=
 =?us-ascii?Q?4R+22IIwC+ZeoUSSNij6IHUNH9WXhPPJF0vz9QSGLDgon79VY/uga7iLxO5T?=
 =?us-ascii?Q?oSjMfdHAeVg9mtqYxntNPY9mJJbl1yrDkPkql2zzxKbz3oEpDi8EaSAtL9QG?=
 =?us-ascii?Q?i81hv2UjYvXAuLZb1qExnyqFpoZQBuR32RAXOytdGGP5MdXPQqmbUJeUPqG2?=
 =?us-ascii?Q?yKareOS8hQejnbPpLto4elW4NBhg/QEAc2tCqFgy/zP/wUNJK1Q+d4fdj3rs?=
 =?us-ascii?Q?+LnNJm5i6033A3w9tpum7S04TSoJVHca2lUSHPCIkRYYUAtD2Aa+SlZE8/hD?=
 =?us-ascii?Q?wP/rWvQmVCzjEe/zFYLhzpNbvfwc4bTi/MlYeMwjcB38VFJAsftM3gDWf8EO?=
 =?us-ascii?Q?yC8MVYTkQqwtE7ivgLbvK8m9phBTYhFTr+21XMrcV0+/c7ZbIgD5CUJD4sxH?=
 =?us-ascii?Q?s/C5l1jtbKhWNvdSepRKhmMJvkICn56BNGgw1IvUgu5l2OyGJB7/2ToHbojh?=
 =?us-ascii?Q?pX5pDwqimrlNroxZuPtGncp17H2n651wLumMmCnSbtZ9Uoh7FBZTEdz0+vON?=
 =?us-ascii?Q?OB/qMQ0qZJVuL7MWPUYjFOmpp+DbC7PCks1cecjJF+cCoPdDXXqpznFWPP/K?=
 =?us-ascii?Q?maZTR0MG9dNldArTaIAKhMn5gImJ63KD0upt0qj5KTp1OI39W28vNYMz32zx?=
 =?us-ascii?Q?//mzbKr7oLkCJljb+wMxhDTgFPtciHXFfmLEF9rS/8d/IdNt+3f/6RbMcoAU?=
 =?us-ascii?Q?PfAYLjIECPlL5A6M7Rq6B6dB/2CTmuTkzkYSyT+ZjcliNLA+sqFJ1reNSvnj?=
 =?us-ascii?Q?VDvwkvTPm0ya7KWGNhyL6eaMOkLCkI8wq6ugzDkgir9YsH/oubJZWhqhguWZ?=
 =?us-ascii?Q?45eL7qU22LgrjtUVXm6VDSilb/mmo06Rz9HuAupVfggdHAb4nzOY6MOmtJMm?=
 =?us-ascii?Q?Uvz70Hq2GTOQK3C2avOBg3lrAnSeUsfBKGeI56TYHsm7CSfdBOVIciosrYCk?=
 =?us-ascii?Q?3NOEl++22xDCbVoeR9IworTcBEkM5Sqm4dtf5fWYwOkSdvKb6mXPp+mYVE8H?=
 =?us-ascii?Q?qepDQdHxmfGMPOXg5V0LobOKiEOtRy6nuzeHxKjBhUdRC/1ntsGw2tyrqN/Q?=
 =?us-ascii?Q?GVsAguZqdn9R3ntZGiICC5Efu0XnJGAW/v44TsuEUGWolRaKVF+NVsygu1Ea?=
 =?us-ascii?Q?RTjVy9f52daa6ZhKULO93UbALcCEUEYM3B2tZf4isuXOLsQcPVaHXgYypClB?=
 =?us-ascii?Q?0/qHFjVJLDvpbzYvSVf0YM4TGHIKmcpBBXgTO6SPA3Ww+x+Q35T6DAf6ih0P?=
 =?us-ascii?Q?tslZx3778YHZN2nZh/v64pgS3atu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 06:13:00.7112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bea0a94-67ff-4c57-9d82-08dc6d939516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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

Clear warning that using uninitialized variable r.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index da6bb9022b80..4c8f9772437b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -187,7 +187,7 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int r, i;
+	int i, r = 0;
 
 	// TODO: Enable ring test with DPG support
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
-- 
2.39.2

