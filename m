Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9884BC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DD210E414;
	Tue,  9 May 2023 22:11:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7533710E40D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhRX9J/J0dwrIvVTpTdToAoIfR+9L3P7Q6AipCdX6OPRLm5vwA92ZZZPzV6Aewt5LG0MVmNny8aPo3aLOLd9XokUSRofXr/NlsXp2tbyci8uQhO9RSxCfi1FnmVqsJaoyQaWLydFq3ltaVgLot4/IvDxYSfPXbzBp2yG8AHESVThXalVhJ5lJC+SRsXhjjsOGD3qohK+WcqzCgY4Iy+2pk8Q6EffweZYkeIH7IUZCdltJ6npYSAfNX7YQASyjNSFSSmvoMosrdjnsV4yuov8mE4QkbdbUn7AmZtgpC+poC4afnaupHKo1cH3m496szFp5ncVQlthJ0jDyyasUl/Dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw5JOcGVUEV3Ltsbd/vODku3i1JXfjuCwzl4fCrEWG4=;
 b=hnOQLg51F8Lbf8WURs8osx+P8s9YOuGCAKgClYgZJHMdzOdwWcM0zPVqyPwPDVs7qvDHFbkEGiOVty6iQkCHi8o2iimS0PYXa1rmDf0rTul+GNtTMUQ2TGGtIFrE/OlO1M667G2/5U3vCfLqZuPty9xtMx5aPsqU+yellalOAwf7nwpx3Zn0Qne82OqseXqOV0J58nUhb5B/nfah6Ah4uXzuq9YV9bGumfS3mQsDn4sM+PQvfHLErfNsn0l8nY7c6ddRRWkYztzal9A2tIeY25ZuPNemN/GTWnkHbe7NUH6OTonkyjHQsUcWcw99Msp7poKH3c4KdXfieXZMILveAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw5JOcGVUEV3Ltsbd/vODku3i1JXfjuCwzl4fCrEWG4=;
 b=WAJHfh77urgvB4eWHH/MuLV1vxrsLe2DnIWF+fNL/hdG7Tz2EEtiAv1ifDTn8r4OPo/3nrlDzEm5Q1+q01FOJj36gf5829OKGcAZZmY9kR3wLPaY/OAVfq9Htn3pvbf95Pl5VDkcEX5pQS7jaYWvltHGPwPzL0U7BcI5okIErL4=
Received: from BN1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:408:e2::15)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:11:48 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::fd) by BN1PR13CA0010.outlook.office365.com
 (2603:10b6:408:e2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amdgpu: A workaround for JPEG_v4_0_3 ring test fail
Date: Tue, 9 May 2023 18:11:24 -0400
Message-ID: <20230509221128.476220-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: ead8661a-0e56-422b-2a8c-08db50da6210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmZYNzwGVO3XMJtqw40F1A6mhvoMoQVT3ORvjy0GLjtUT43fe2JVuP15xixAzwvYSPC6m1YC+j+NBgQbj+VYfJ6e1ZrHDFZX11K97/bzkMsVi33X+7A+3xPwFc4sY6BOirrl9udcSgmPESQhtVmwWbwFzKaMXlWN+TcZMly0hLeQIStC+i8pOPeIBYT68h2B48ahFb2L26XtX0pMyggQA53lEcwR0y1ivGMV9dN2jTbRAjVUeO4qW2VkP+UImV+jLf/EBaTFltJJ2zdtiXll55yncjnyZltHETCWCINogiUHEjiczd7MIDFp+GkA+1M9tENMkECvbdJ9MUsrV5NJwWQWIz+9SiUOY+gR6dNupuWUpyXUEhZfC1qKeNcRM7ir68G/rAE4A0EHcLQvP3JeDfT4GcNNCTH8mwYKLMfKf4zi4paUQRJblQ19g1tLrErC23iaS89q4XqpfY3O2pOiTS8A/R8kRG9IfDAzJZr++lYqRFFEkLxkcyEQ02BGDdQR6LyS2xEhJ65mxnH70mH9lO7tmiXgwGDth0EAGyxMBhXcaO0meN7DBUeKnKywknICeHL133t+WU8fNY/rg+mQzxP0r8Z//q8r7zQcs0CfBfhpuFsc4Blx0Dd0hSa66VCkRWDEUSjWISRWiltAl5dC9QpEJcS1FC1RGjIS1QnftneKiDct2/bgjzU2uX9MyaL0qqSuWQemhb4aL3VSqPR5d2dvl5YGfT9N4uudcNYXBJ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(8676002)(6916009)(54906003)(16526019)(5660300002)(8936002)(478600001)(70206006)(2906002)(70586007)(316002)(41300700001)(6666004)(7696005)(1076003)(26005)(186003)(83380400001)(82740400003)(47076005)(40460700003)(36756003)(2616005)(336012)(426003)(40480700001)(36860700001)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:48.0907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead8661a-0e56-422b-2a8c-08db50da6210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonny.jiang@amd.com>

The jpeg_v4_0_3 jpeg_pitch register uses UVD_JRBC_SCRATCH0. It needs to
move WREG() to after jpeg_start.
Switch to a posted register write when doing the ring test to make sure
the register write lands before we test the result.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 388466a5f730..9a1db2bd03e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -124,11 +124,14 @@ int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	WREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe], 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
 		return r;
 
+	WREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe], 0xCAFEDEAD);
+	/* Add a read register to make sure the write register is executed. */
+	RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
+
 	amdgpu_ring_write(ring, PACKET0(adev->jpeg.internal.jpeg_pitch[ring->pipe], 0));
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
-- 
2.40.1

