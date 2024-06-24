Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A5C2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 06:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EDF10E356;
	Mon, 24 Jun 2024 06:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T3/vmZUY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0055C10E356
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 06:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VduPP7FzBC0rG0nUg4/zYvm4mF0RBArv1J+b8eMOKLpehSAa9acaLcK5k5I3rpQUMuIRKPIanskgmuUFEZiD88cZ12gqv8VEvINhAVA/KGYZ6iKyIt4YieIfohe8gPkYXdxy1BQj4jL/iQcFAanboCRu1k7ZVZvV4YuaLcX/2MUbpNUYUFGYbwNtnLYeLH25jyV7l+1lEi8pLc14RXzbnFu30t0XIpc7uPFS/TPtWSUyAu1dkBY9Y5NiRG/ELjS/KzaWWZjWA+PXWf4bdLrZjQUR1615JNGkFO8DIXjRi80qjpzAv9g0kCtKxphSyR3dsKj70Rnt7pSkAE69T84HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td7IcWey1gQLrVlBcdAQkPeFk4NBVHOlc/ekswrGKGU=;
 b=KDAGlix7mX+8EnUx+elRxPgwJjZNJeFZM5mGTXkGJukP1nAWl5IPXaDEBc7/kSxt5Pul/rYDHzxcdNcA9ZWbGVvtYHFL41T0CI/zNQvv7FeeMhKSFzZcwXBuSHt9WpK+sMHPLFhxR0IKY5VAdQZ6vXNEnja8on/HGmoennwEe0OAFi6wNsWN4yLUsl659Mqs4z6Qesf9ZUwnuIPpckPaFdgPIc4EVJcVnSTkm9kzNzfpD/vz1vGHqOV+I6Nyu/ONxAKm4pQnrmzrfybn9328O4J4mEIEbDB2vf2mthhJr8dxjYVlUvfYEDw8isjAlLwIvqu//RfHg1/GjY2mWupczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td7IcWey1gQLrVlBcdAQkPeFk4NBVHOlc/ekswrGKGU=;
 b=T3/vmZUYvsHO4/omItV9m6WnU4lU5I8/Eo7ybLXLSFAIPUtM50AIqmvGyvWQEN3jWBaK2+Djk5M2oMmtrRSs+OV3sp5zHFlYPQIPDoqNmYpOXgi/ksnS7RWf9uH7WhFWSh5/4xJVtUvudh3EKEHzSiw497Izych7sBf4+MP5vuo=
Received: from DM6PR07CA0088.namprd07.prod.outlook.com (2603:10b6:5:337::21)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:31:26 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::65) by DM6PR07CA0088.outlook.office365.com
 (2603:10b6:5:337::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 06:31:25 +0000
Received: from H-4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:31:25 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>, <lijo.lazar@amd.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>
Subject: [PATCH] drm/amdgpu: drop kiq access while in reset
Date: Mon, 24 Jun 2024 01:31:09 -0500
Message-ID: <20240624063109.655690-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cf37ec-ff92-49d5-ac3f-08dc9417460e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|82310400023|36860700010|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kjBLVnyVz7EJnJrodOiDPMSwUDYsbou5ofDXoo7DcfQtED31R/tUWs2Hnh74?=
 =?us-ascii?Q?dk/muBqhX6utEqex8KN1EO1yIkI6h/RkIzzABP2lCtPAa41bM953gI/xuiFT?=
 =?us-ascii?Q?mt7tyQBEB0B93avG+E9j4ffVo3esg5oeF/GiV3qqzO6yNqXlNCzEamWVbyQ/?=
 =?us-ascii?Q?VxrfL+24+v82byfuJUCG+KJnm4nf8vqUXmXmxUuT1sOpanLyDIvZr7J+dRpP?=
 =?us-ascii?Q?UZNSoa4bVBaz1MIHxGkcACVMs9JixU2qjoTjOZL6fZhhtdI+TSDXuLpcL/Yw?=
 =?us-ascii?Q?R1J+Fpg36GU+pmCWo2lFR+Go1zYLrZgTB8HUXbghrS/je9hA1yR0E7Qcu9XM?=
 =?us-ascii?Q?kUm2bEnLJXZqFoMXxNinFufsVletQNjV0RgWXEIVzeW48a19GU0hDi9MZEPM?=
 =?us-ascii?Q?eZuNkNGlQIY9vCf1l4FauNwItFb9VlR4GE0jSXXQvK8d93H8ukUaccla0Tsi?=
 =?us-ascii?Q?1pcInh9S9vRlyiJiL9KBZZflu+oDoWr+ltmoRKAqPpRaV3rLkDUnBCQHSbY9?=
 =?us-ascii?Q?yVgpHJhi9XmgKtJLe3hx+sFXlcGaXTDrn8wZ1y/KD6+Iv9dOjXWx+1kDTuUg?=
 =?us-ascii?Q?BOVz7HtAJD1Ubtds2CeKVPcqo07wjsAn0H1y1OpzN4GWZRLO2jCProODe4jo?=
 =?us-ascii?Q?glk7I2KmoxeuekULDdWOQ3pK0IWkiKN5lZ4TeRtN/ccdQ2zCsaXojiWPKlbl?=
 =?us-ascii?Q?ER20rrl6W60AW9MCKwGXEF90RuRYAWfJp6lHfs9owrtCRbWWguiDxyJKGETL?=
 =?us-ascii?Q?cSGrRkJ33T8++pgQErU3zD5sbhaQtenli+fE40d4j+8gnT1YnGGYxX677ABy?=
 =?us-ascii?Q?3GRsjhd7sm9+gTFusHoVv/r/Ap+2HApYdUyRpXOUYDWK0pY9ZKckzJza5DQm?=
 =?us-ascii?Q?fmyhbHKFeokGaE3GlTtZvv4Z+8RDr61gMMolxyzQdVQlHcn+CbrmayHrbqre?=
 =?us-ascii?Q?wcszX0fLvYWeT1A5Pak6TCRu6eTqmljo+E4uLhKkTCayTb15b+mi0dfeA7Vi?=
 =?us-ascii?Q?doNrPTILmTE6Qj3n+E7qKv0ZGrVZO3yR+5zoNwKbIs4sinYU/dbauwc3U1Xn?=
 =?us-ascii?Q?FtnIOtSnD5tLvHV4p/ktYAiZOo9Rljvypjb5Dh9KoOVhN8KpYy9rdVEf/3T4?=
 =?us-ascii?Q?pBEvsp/NzArQBqV4INnilSYWxG+AXnPCQo3Ee2gVrgervDf20J+pUKvXHili?=
 =?us-ascii?Q?bgrxXChkYqqE8zdrtmpb8iJM/rDDOgdyOY7lPETTpywgRyfxyytFZBLWrfi1?=
 =?us-ascii?Q?2TsBmzkf2LvnOJwHbZeL9l0WNzuEq28IqQipGHiyfTY5cwxQfJYjRLH/8ZQX?=
 =?us-ascii?Q?YomsK8S0j1Q7rptJB13r0LYP6cLLFdKXXNCToZ5VWNCh1yKg3BuFNdnjhB1B?=
 =?us-ascii?Q?7Q9MLeRWf3agGVDUommxof+PW+o7pGHD2Zi1JmYSXQ5qAYBLmw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:31:25.9355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cf37ec-ff92-49d5-ac3f-08dc9417460e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
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

correctly handle the case when trylock fails when gpu is
about to be reset by dropping the request instead of using mmio

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++----------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a7ce8280b17ce7..3cfd24699d691d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 
 	if ((reg * 4) < adev->rmmio_size) {
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg, 0);
-			up_read(&adev->reset_domain->sem);
+		    amdgpu_sriov_runtime(adev) {
+			if (down_read_trylock(&adev->reset_domain->sem)) {
+				ret = amdgpu_kiq_rreg(adev, reg, 0);
+				up_read(&adev->reset_domain->sem);
+			}
 		} else {
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
 		}
@@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
 							 &rlcg_flag)) {
 			ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, GET_INST(GC, xcc_id));
 		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
-			up_read(&adev->reset_domain->sem);
+		    amdgpu_sriov_runtime(adev) {
+			if (down_read_trylock(&adev->reset_domain->sem)) {
+				ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
+				up_read(&adev->reset_domain->sem);
+			}
 		} else {
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
 		}
@@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 
 	if ((reg * 4) < adev->rmmio_size) {
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v, 0);
-			up_read(&adev->reset_domain->sem);
+		    amdgpu_sriov_runtime(adev) {
+			if (down_read_trylock(&adev->reset_domain->sem)) {
+				amdgpu_kiq_wreg(adev, reg, v, 0);
+				up_read(&adev->reset_domain->sem);
+			}
 		} else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 		}
@@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
 							 &rlcg_flag)) {
 			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, GET_INST(GC, xcc_id));
 		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
-			up_read(&adev->reset_domain->sem);
-		} else {
+		    amdgpu_sriov_runtime(adev) {
+			if (down_read_trylock(&adev->reset_domain->sem)) {
+				amdgpu_kiq_wreg(adev, reg, v, xcc_id);
+				up_read(&adev->reset_domain->sem);
+			}
+		    } else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 		}
 	} else {
-- 
2.25.1

