Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9553C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6D010F614;
	Thu,  9 Dec 2021 16:55:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6752910E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 16:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1c+v0JoSXDS2HuiolxZ5tu45ZqzYVQjY3niEluUpM4i4qUlntM/tYP2mmgUVRFj2f0IhlIdwkJor1pi+rbNnm3NGjczJBULj1d//aaP6HzEYixfosYh18r0SgH1GVnAfrpEjyxOM3218664Io46xWzMMN1ssOlSkKNlvS5obDDI7DyB/7qzibtC8Lpb3y5wpOYAR9ZANz3Za+r3Q2HBzNMadzGsw6tNRgVxehBjUCHBUmLdUvmlf+IbaDI0iwbp1G9cPUDp2Xn29UXosXoU8LqWESzlEmtTOigJG1DbWayUHWUjqaRizHBXH+Rp9O0E/eMQVSQTNQOMmhUdsPovUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6gSnvuLoC2XaUuG0nUES4wG1K1MDhkA2oSDPCibeOo=;
 b=j5fRkIjhj1+/zt4CTulSyM6Yye9+D+4QM0bTwUkSGUSucgiww1dxrxbSZVB363Qbj+92iQ0PVHQiOciZjT2zxzxYMcb+R/e4hYbFgOV0O//b7dgvaN6k+3Ti4I9v+88oy4GX8pWRiqZUvRY02P8BKWUsP7I/pkaAXkXzDqwC7IBOmrFk/H//DFyDmBIpOwIK6sxKhID5V89kozjKgj/qcvtJIgmLBprv0aYNhBaRxhe7P8gYnLXNDhlr4oJ7++6NHJM4td+yxG4B+rjafVfe7qFbJ5mVkSwTfb+tGPjlmNn1XJERIMi9TPM01dY+L1Wrkw2ifzKJ8OoIfiAsu4y3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6gSnvuLoC2XaUuG0nUES4wG1K1MDhkA2oSDPCibeOo=;
 b=RHWNKPj/2t+3mJk6wj7bLU+cuIAidpApr3+NX2V+mB2ZSdAGVQuH33ixPjtOvx+NKXpP33iFOhFnj/ZsDOIJMvhSVV99m3i6aTblH+3iyH8/eQO2JzNWsScbFK2QoAzw7zxr0vczpj/TRWcYrhGUGGZUj4sE5YwYDyyGgb+lsaQ=
Received: from DM5PR06CA0041.namprd06.prod.outlook.com (2603:10b6:3:5d::27) by
 DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 9 Dec 2021 16:48:22 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::bf) by DM5PR06CA0041.outlook.office365.com
 (2603:10b6:3:5d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 16:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 16:48:22 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 10:48:22 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Reserve Bad pages early for SRIOV VF
Date: Thu, 9 Dec 2021 16:48:09 +0000
Message-ID: <20211209164809.504378-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209164809.504378-1-victor.skvortsov@amd.com>
References: <20211209164809.504378-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 023acd9e-5549-4290-6048-08d9bb33b67c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5182226B717C697D240D1FBD8B709@DM4PR12MB5182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7ixbOed8IXopZh/GLflqi+k6AMJ/bVH5MpsIEM6/2h6cdNc+kviII0lw3++hVxHmAgyWewynDtYchZm9rHnQm4mLLx4GBRu0kdVXesxBzbNZHg4Vpo2aOsobxWhnod1hqusxy2cCMI2KbKqU0ed9TyP7VXu4iEyzG7QIfIbTNQM/b6lcCUdcxdgF5wNAb7dJV+IhvMXwFFhcqVsWgOBCxTeXMeYl1cAlWkpU21OBJ7AM6Rm6W2NlM76C0Qu9fwre3E5KsZrlGncEMdaJ9lvXwqU03aRNUPPrGcK690JuveGN3PsLYe+P3/H/ATFtRAdJ5D/6wsld2pHyXiBh239EaYLNEeehAWPJSnGGnGlsUTgZp5y+AAFAMukjorr2c88mXEEBM7m72YqVufGhDFWudVkcXTrm6Qt6X5uDPgsjVAGtCU4mQQMP5p3e9DnsV+wqub82l2YlV6f/4An/etAVVBcJg/Qw0VFjvHIWKUmcGUxMqTLG0VYkojK95u4fX0uvV9R3VIY5SVyXeXdilArR99PhidVt4ME17hCf0phFjLJhsa7cIu7t6wyJym1kmXeIZA+it8lishxu2GMh+FLPj1phfLyHQ8e1fkiNwKFS1y5zoiDXdZmg/as7/3wP+Ge6nHhvZQpX2jqSy40A0HNXFbfHcDIxA/OuqJCgID3+L/v/zih7t2nfZuuq62SkoTF3MP/sTd5/WSm83eBsrBmm1v0aHa+e0r7E/O5NpQj8GSY4rBoRqABfXCF1txrXYiEFq/K84thTZq+WII1GauBAXBV1xwBDUE0VgO5u1uLnaQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(4326008)(8936002)(2906002)(8676002)(86362001)(4744005)(336012)(6666004)(81166007)(508600001)(6916009)(83380400001)(36756003)(47076005)(82310400004)(44832011)(26005)(70206006)(2616005)(426003)(36860700001)(40460700001)(356005)(70586007)(7696005)(316002)(5660300002)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:48:22.7893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023acd9e-5549-4290-6048-08d9bb33b67c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a pf-vf exchange right after GMC sw init in
order to reserve bad pages as early as possible

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3992c4086d26..a146a55c9864 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2315,6 +2315,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 		/* need to do gmc hw init early so we can allocate gpu mem */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_virt_exchange_data(adev);
+
 			r = amdgpu_device_vram_scratch_init(adev);
 			if (r) {
 				DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
-- 
2.25.1

