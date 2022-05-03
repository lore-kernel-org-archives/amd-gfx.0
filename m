Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8842AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE6010F396;
	Tue,  3 May 2022 20:29:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE5D10F384
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncdbMHUzrS+0klWEci/Qo9B+YmkhRIx5E8RtTYRWWaae81Tbx1Am1e1Cf+Eycupa1o21K4TiyWOrpc+VcYC+yjwOCT54JmXik/VJigZ2E9NS5hNo70sBS/nCnkWhRoNMXMuAbQpxFbw9cVqEiO0j07s245dBsdAzBMLSpGmyklOE58oeA4OrcAkpoWTOp3T9dtt/6p6ho5+T5jLtR5vopSxBFvMXEJgmf3Bip3FQk0jrJFKxyPEcEmav26letN+9rK2hbcRWso7y2DrqkUCjYpe0KvQfvtT0q9NwxYfh/pJLugM1YyGSQRMQWQn6uM/yG1GSX9W4pDw57lQQA2E+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzI7ULb1MijiCsOXS1RthoqHMzUAyyiEQVezpV7Z4cs=;
 b=cS/XBwmz3LHNfhqwxptmdHK30Qt+1gAzB8l7SiHWEKTTZyuCRyYoq8lbg3AxBssvLBfSPGt1x2fNHrzNq0ixja7Wt9OVXT1qVjMgKXrH+wiHY3V2rtRcDhErjOeUKqs/A8xPCD5RDyf06EP+xXlgziMep9JYKBZ4OBRLyW5NtUcZoCBI5QnqVIV1J1hqUf6CkOWNdmUGcUZGWupfcNE9ew1SZZDIAJnrWeKeaQEo1eYLASiIUmJnIMgHg5Cy9GQqUAiCw+WjXZ8PhJ6k0E05jescWc10/8AhmusFrgRnq7f/2j86/F3joH05hRQv3PTLVe+c/pspDNYh3DRXAonp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzI7ULb1MijiCsOXS1RthoqHMzUAyyiEQVezpV7Z4cs=;
 b=n2NrPDecHYLni+qyJ4XsNoq1irfUmr4dzwo2M/Evkmqpbuw/lkAYg/tGzHmTMFNHNOHilut6ojtH1bOsFYI4xIIjd5nEFvzfams774yANiPlkuECJVUtzpvDlNCXdeO5a8A7TJ716Wbc37VW08xwqoiDb9SXzpG5SmyJbHuSFR4=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:29:35 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::24) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.25 via Frontend
 Transport; Tue, 3 May 2022 20:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:29:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add gc v11_0_2 imu firmware
Date: Tue, 3 May 2022 16:29:06 -0400
Message-ID: <20220503202912.1211009-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23544e46-2bfb-477c-e38a-08da2d43a356
X-MS-TrafficTypeDiagnostic: MN2PR12MB3344:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3344148EC3492ADE43B9051AF7C09@MN2PR12MB3344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0ki/VTutbAmoUNGeCJd7GqI6Op1Fz9Da4D6ikTafNoSRYKuUX9arelps27sy2T+SUO8x+n30C98Bupgx8CuFE40Ea8pBoxeeiVUwOnvFxPcOf8eTylsWKvPPyFZ+qlgEvJhWOtomjQBak0FD12lQIr8f2peBAoS6c3yqIe1lT5P+x0y6IHhOib1xXN2vRXQ57gBpABAvkKzvyag1a/gObgxTPGA6C3THj66rR9O18Kc+k0tMHP4YGZK3Nyy0S1QHb8vH9gx1f8obkIqNpDbFFEpOwi1gbQ0MmsnnjCMJpoBqwJOQZLOQujTxMDyGlxmFoKr1KdpW1GxttJLY/Hn+3BsKcfoDX/a0h6gycTESFtulFOST68OzlrclH0LtcxaKN8Xlw8QLpOxL+e0whJInDVrpaRHsu6L9T7bh46PPN+w1NhjBlqCsVMxn/A/SAO/8uKLM7FMoCvb7RSVJ/mF3vsQKDksmngrxlEkUXTKe138XlbbICapeW8HanAqwJtNznGF1o/6/FkEMzdfILjfl7N+B2y82qhS0nbSVcRS6jNJsnjCv/6MI5zZ5hKUbx6EHyRRmDjBCN05Tm1TcTLWBtfV+saNWlgt1fCxGZQENdai7d4waaU1ErcIgQWmWQ6+AU/kqOI5/sEHCY68tBCjfas+EgteXgHPziSNvRvFu9W22OwxGU0OunFCrc1GG+GLl3YcsKH/DjuEky+aGIZsPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(186003)(26005)(2906002)(47076005)(1076003)(2616005)(426003)(16526019)(82310400005)(356005)(81166007)(40460700003)(86362001)(7696005)(36860700001)(508600001)(36756003)(4744005)(5660300002)(8936002)(316002)(4326008)(54906003)(8676002)(6916009)(70206006)(70586007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:35.1848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23544e46-2bfb-477c-e38a-08da2d43a356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3344
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

add gc v11_0_2 imu firmware

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 81952a6767d0..d73d271ef81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -29,6 +29,7 @@
 #include "gc/gc_11_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-- 
2.35.1

