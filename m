Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F82CD54BE
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E4110E324;
	Mon, 25 Sep 2023 19:52:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4ABD10E31B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emx30FAqzgIONJNMPI7zS/y0BxEF4pAWtlbrppPbq1j6lCvwSnMCOqDf0Rfsnh/xEKqCRocHUa52b/gcc7tgc0vZoZDb+zARvX16r21poLZjPWRqwY4rMoATfIz47QK5CtwRL6Wk5iNb4codyi9bGrudVds5L+GiHC838DypCXhYHoPTLX+J4XRiMHIeTxKRMcsRMuwnQFhfQL0Ijln7XoS0pGbMXfYbDOHtqROMyCVa3e4L+31TrRgo/9zW+G66nV24vc6G4IJpYwQG6R9Cr2fj0JtxI7x+WqQqwKcyONT7DfN6hCWB5WD6eADx/LWVxntqQ400e8rablZSCPpdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTc5JIVbFkEebk2Yr/XNWqhNvUASBV1PRg7iR494/OM=;
 b=A6AZQnapC0qFFVjDRFhD1KBTgsnoFrO/9/qugejc0nlILdCAPuCfd597nhVO7VLZZc4+DZXJmo+UQTHhydmoInQU3g24WOzwoYBfpRB4BF5+DB7uicRb2oYMr55yoO5XcV0DU2zyisR0y8mCbnhF+4I+ICX7gj1973VZlilyWBVA1z5ky6890F7Y9an5+La1P5ZdutoYqEOWedEF2Lcujw/dAAwEG+K9XbXojFce0M5FHKuCd9qUWYawcAPgDMLerrJc1/anzPmYGHOnB/i66IDUxSNh4hfVtYxEtZ6B7D/lkiYICKWQwcV4Fozzs0LdACW9yHemGLTXUhy1UoK0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTc5JIVbFkEebk2Yr/XNWqhNvUASBV1PRg7iR494/OM=;
 b=FX3Ejgi8dK5eOUE7j2BOZO1rj5M+J3NevgQtx2nManXjh2UqvjNpQJPBZ7uLG9Nxm0BSr/e7HGFfE4fVmOLm6PCmzMP2Nk+8uMQzhKjw5SLwlRqeKMVbeXkV+8OXwanFZOqrxdZPY059a8IUbBMyziXT6NUgw39aSjxKrWR4zIk=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 19:52:50 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::4) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 19:52:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amd: Move microcode init from sw_init to early_init
 for SDMA v5.0
Date: Mon, 25 Sep 2023 14:52:02 -0500
Message-ID: <20230925195207.124850-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 797c0afc-b084-432d-835a-08dbbe00fec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akN2MkvqzkxC8JSiYDLsyQIju64NcPBsYTsx4ZkyrgVod3mcycsFb6UTgcI2qvbtGSsY9AC6KsY0VvCamp7JJCOm/n6/RWzcp0/fkbGvoIlKi1PCYq3Gp2j2KguMIy/K6UH5IjZU4TTp9vXGkp8YES/IH0VWw8XmqLTvZIgIS4rY45dWfuuLd16NOLm6Uj4ymbGS4n+gJUlmyHD4VZLdgm8WbwQV9wdzAENExLz8WMOE2abHJCKya8sNWr3IK06Whq30mN4+xniI9Al3tTqAMNj5wCYtmhfn3/oH1FQgMjAgxVkGiIqxPyvXoGOR/y3vXrJgK9wm1ifGvcRZEWwX7094wkhJjy/4smNwqWfFmet8ipG5lYJIfx5+AhSMjsYMKo0xup0J7t0kAP6M5SUy/CrsY6kBKn6AoH0clkAx6g/Olw59vxH1nZhAcEcW9AeEVGXgPh11LIOa5VyPLPDre2gRxwZKGbmU3CQba5MffVM4Spe3PCvqahZkEFxfdkrASPXlzHoEclNw+r5esCzQhQcrloIFKE+t5kBsc1GV2DjGMimMNKEGCV64da0hR75nlwLSouQM79mj3IjBEal9Gn3exzVCargIq7kFqr+j2ce8qYGf8el3udmQrHA22IsbWmMv+BRJ2aXwFvnsXpJj88bkgZTtWFqUQs6hSPPgWS4+OPrr7TaVMcaEk3gVXTK3QQCrfItft7QqUEl0+sR8CsH2K7SzVK5EaABTpCeDCgJXxRBC07f9p71Sv5M/ZVhR6qV172pbtoCGBryvaB32jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(6666004)(36756003)(7696005)(478600001)(83380400001)(36860700001)(356005)(40460700003)(40480700001)(82740400003)(81166007)(86362001)(47076005)(70206006)(70586007)(26005)(2906002)(44832011)(8936002)(4326008)(5660300002)(8676002)(2616005)(426003)(336012)(16526019)(6916009)(1076003)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:48.5285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 797c0afc-b084-432d-835a-08dbbe00fec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of IP discovery early_init is run for all HW IP blocks.
During this phase all firmware is supposed to be identified that may
be missing so that the driver can avoid releasing resources used by
the EFI framebuffer or simpledrm until the last possible moment.

Move microcode loading from sw_init to early_init.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 7e837acffa6e..c1ff5eda8961 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1336,6 +1336,11 @@ static void sdma_v5_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 static int sdma_v5_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = sdma_v5_0_init_microcode(adev);
+	if (r)
+		return r;
 
 	sdma_v5_0_set_ring_funcs(adev);
 	sdma_v5_0_set_buffer_funcs(adev);
@@ -1367,10 +1372,6 @@ static int sdma_v5_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = sdma_v5_0_init_microcode(adev);
-	if (r)
-		return r;
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
-- 
2.34.1

