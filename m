Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACFDC10F15
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 19:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBCB112D29;
	Mon, 22 Apr 2024 19:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxNa4nTN";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952CA1120E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 19:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX9PAXyW6hmA5WYPyWWmkGthyYG6/peaR7qoqBCafK7QufRBY5K4/E6W21IQYrua5haQlkYgZeBcn2MYvh4T5PBGd1ZKcJUAg/OScHd7PhrZx7Ndxi/6wQcr6ZJht0ZCEbOGnK/GySZbedTFyfx/3ySQ83V21H92tL6YzlZbZ9CRefiYLUGh8/rpiDVsCxIlTJjGLp2UYq5sqgh0aa6j/xDuRcFwTRSF7zcirGftInANfFh32F588K35psZk7e28My/KeY0xu3I8kzp/A0v1KwCt7BiDhFzu8BOXQUHtJtMIJmCTHc6upnzhnHwgGLY/e4TQNpYk066IuKPY7VrgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixyKV6MkgcCrd51WRgyQGpKuCS872kBZxn1Y10S4q68=;
 b=P4xvLPpFLoavgHVtWzsm0R/ozG9iD/jzm61Mvv9Me1HfigXNhSgmcyysuwtdTRJ0JOcCMOF63uRA0imuG+hNXuTlTR2YILwdX6LNtL7TStjAl7O4eBk7wSGTR6ApGVHyEgiFM4LtB3lt0H58+O8V+MLpvdHI1qov+dFKKWEEjWk+grRX055v2A3utGvvyrax3YypJry5/iLbq2otB6EdQGikhockN4Z5oUpacpBNtRewDaFAFo5Xpt54Oy0GETDfENg7wWW0c342zqQ6ia0Zy9A1kYjTjvON0UA6RoFGFo4noBBGsFyp4BKYW14T5GiqQ4mQm3cdK7LiRrwORgBFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixyKV6MkgcCrd51WRgyQGpKuCS872kBZxn1Y10S4q68=;
 b=lxNa4nTNxiUSIDf26wlSWp/7zOrMKJdrdVZlNfus2kv6Zr+UEsPqWrlnyCFOZzmT7Dw/J/xNH8pRqopFdMamxgZJXXHvT7mZM/LAchTJj1Yo066G4f+CQOI+qm6Du4Kkch3LslEZWwwssUE9ONycU+l9DG+/NhT/APkRDpCQbMQ=
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:59:47 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::9d) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 19:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 22 Apr 2024 19:59:46 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 14:59:46 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH v2] drm/amdgpu: IB test encode test package change for VCN5
Date: Mon, 22 Apr 2024 15:59:30 -0400
Message-ID: <20240422195930.2429417-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e69437f-7754-4d62-c773-08dc6306c2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kR+K6Vvkf6Iq0ew7uiPrjndV84S20tp6bxPuh9ihHYIyWfoWgq3kfG5OtlCY?=
 =?us-ascii?Q?GHDZo+DEbHJpoXovgOzqKa/xnFTWVG3B/91rH3jaAbtf+XboP0DK/+l8RqzN?=
 =?us-ascii?Q?Fh0rYCqzFW71UpqpZs7Nv8VyLTPq1rZSQ0mlVJn1rFRZKmnasne9zwFzxthl?=
 =?us-ascii?Q?akx/Qw6eU/D+h9RduNmaiFS/J/PHRlPuMw4IsMcwnBRiOHZfbl6W8OkZg7YD?=
 =?us-ascii?Q?az71YsKCRiFACEpH1kMY0NAPz0LBpdxyy+srLX0nw7fOKmn6AP9SbP3EJqSM?=
 =?us-ascii?Q?xLgMtJ+jlLDTdBKOQGcXLtViz5V5++vi1Anthp/NPSmipyEHGrCuu/VhuXHH?=
 =?us-ascii?Q?VNESN1+qg5rVH1CggZksRQC3Kq0QPSnrm8vz4gih1zErAulgeB53cKAGKD7y?=
 =?us-ascii?Q?vlYUuN83pfwx0BKndasn/6sFl98A2rITz8i1jqtViIxhKq/WhAyMcg1tDACb?=
 =?us-ascii?Q?f3yigvIQh9DbOnOJE7cepI8fzhbrhDMah7C4TVRScZxnVORsKmgn7ynoXiYO?=
 =?us-ascii?Q?upjEgtcqVtAaYG84MciaxpkMmqX2JA8L/AIbmQ7Ze/DQTlooalM9GiRdQOaq?=
 =?us-ascii?Q?pmOy1aN8dojeYWwhx9gi+NdOeNXUA+nGhRIxfTqHpeyxYCh7Ato7sQxLMYV2?=
 =?us-ascii?Q?6AMXMc9ORKW6G/8/CIw4Bxn3hgzY4LMEMVs+P35hZbn7cY7d+2Z1JWHq1FeD?=
 =?us-ascii?Q?pVa3565m9a5sx3vkw+j5dhZAEKsuVYUvecOljQB6kb7DOg1Z1RudkgHLaElt?=
 =?us-ascii?Q?qtrMoKWEHxyrX1/PA1HxUlLkzm1gJXFG5b6Sdsdz81dRbvYY1mcjR+cfRTcv?=
 =?us-ascii?Q?F6T8Mg5+az/WJmPjqfiG5xH0O//11tqHuATjSHtNn6gAFKXXbZDCAZfKYqlA?=
 =?us-ascii?Q?rArutjpvN7Q11NC7prQTqYxoVPu7bUAUwB2kM8FLZv1FlaMGJM1YSINBQuXr?=
 =?us-ascii?Q?MdM/AvqyNB4XIERRE/hWCg011WChmDNp6IAAabbt2oBbsbdAp0UEiGwVZr/6?=
 =?us-ascii?Q?GfMxevgltGRO7rQgh51zB5OGyIcT5vhiS3HqOQsfJox59Lac2jZh07GlRmKu?=
 =?us-ascii?Q?Vk9SaEno6RziLPpRq1hmNZv+ARFjam3BVgw+eoo1otbBNNUPDc8CrQ3uCvhy?=
 =?us-ascii?Q?Cmjm8n3wajYCxBoMdOZTZZiLGSe2rKBno7py6oLXGpapvpj0BZR9HH4olJ2g?=
 =?us-ascii?Q?EL9HcC3bUOmr/MU+CqpK/mS1lT78VSb+TnNR3o/dV6T18FN8W770WHf/5xQP?=
 =?us-ascii?Q?F9CXmVW/hg2OmoaiO/Crv1G5Koco2PiDAJtTGUClNKflzByPlTGzlNPfueiI?=
 =?us-ascii?Q?pWZ80AMxbRkldEHUSEtWXK0g9O2jYhMDlmkeUi0sv5rM0oK8Q+IfHbJdm9cE?=
 =?us-ascii?Q?4IMSbsF0Ye442ffbwZLrUKp0oSRW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:59:46.8968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e69437f-7754-4d62-c773-08dc6306c2db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
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

From: Sonny Jiang <sonjiang@amd.com>

VCN5 session info package interface changed

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index bb85772b1374..2bebdaaff533 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -851,6 +851,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 					 struct amdgpu_ib *ib_msg,
 					 struct dma_fence **fence)
 {
+	struct amdgpu_device *adev = ring->adev;
 	unsigned int ib_size_dw = 16;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
@@ -882,7 +883,10 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	ib->ptr[ib->length_dw++] = handle;
 	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
 	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x0000000b;
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) < IP_VERSION(5, 0, 0))
+		ib->ptr[ib->length_dw++] = 0x0000000b;
+	else
+		ib->ptr[ib->length_dw++] = 0x00000000;
 
 	ib->ptr[ib->length_dw++] = 0x00000014;
 	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
@@ -918,6 +922,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 					  struct amdgpu_ib *ib_msg,
 					  struct dma_fence **fence)
 {
+	struct amdgpu_device *adev = ring->adev;
 	unsigned int ib_size_dw = 16;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
@@ -949,7 +954,10 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	ib->ptr[ib->length_dw++] = handle;
 	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
 	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x0000000b;
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) < IP_VERSION(5, 0, 0))
+		ib->ptr[ib->length_dw++] = 0x0000000b;
+	else
+		ib->ptr[ib->length_dw++] = 0x00000000;
 
 	ib->ptr[ib->length_dw++] = 0x00000014;
 	ib->ptr[ib->length_dw++] = 0x00000002;
-- 
2.43.2

