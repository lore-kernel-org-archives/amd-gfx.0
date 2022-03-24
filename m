Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F17EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 10:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0866710E86A;
	Thu, 24 Mar 2022 10:16:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0514D10E86A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 10:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSUJ7dvQteIlQRvW7XFmQxQrSA9fsqQNTuFkCRmabYjRldvxWNRrg7tdrwZn9BFz2zyzox7HNWYUywLqyX1G4tSajzjVzGrjIt6jIBn/D3Hc+9rMsk3K4yCN+Wy0vhLXvIhH4znr1ZGb96HI3ADjQzr2yycsMODX3nLQF9TJ11ZRB2nNfnY3vdEns6cb+cy3t2XkHp35bhYo9hwDO2NAi7ufDNNZD4je+1Kq3VfaiNR/6djKT1Yc/KScWP0E5Uhrjxh4Nnjhup+vHFIobjB70prBYpAPFrWQmMFRFdPDnmYX81Ag48+FvDdcOV26Ce2qmL2Q/DrCjv5lP/C+Gk0mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTUa2/UU7U9XR11nCEEnfbX60AlxwJmk45ANg99LbsU=;
 b=e9sSYtnrOGX+21pJ2st0+QGMSGJjrs7HKawukyc3B/a9Gj6ImTItWbMy30r+XOF2dJxxJ6l7j5MfvNytFYJ7iX3hXeK/hCN0vb0IR5DZLfN3+oA/VGd934F0rp+Jgi47M0LjwXDO1QC9PJ58ycAv1JKACy49emoX0zpU9pO3b0gHxuXo0WFzSkcqzIEXJ62WIew1INMMslVH9v841m0TypSitiZNJnnApxLaeFi7bATd16NmuXT1JCI749XnekFRh8N4CoyKqztlMNPiNYQoUxwCEgvijl2rq9009GnYBw+VZf+TZUDtc0wxl18yDEsuBmmnAxNlAAGjS3XRf/MSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTUa2/UU7U9XR11nCEEnfbX60AlxwJmk45ANg99LbsU=;
 b=YdWLXFHGUO54ZyhzRSDI7RuljbcT1/P4SjJxuq0eM2OM0kqOAUBkIMTMTuB2deszI9zRuzSakkMFZXL/lGzIcSab+u6OSFzmBnyD81Ba9B1oWP0LmTcF2CPYGwlE2uEAXLu7tJoa9uRbpccGIzYjS4/OzlQmS+t4NoF9eUiiPO0=
Received: from MWHPR19CA0024.namprd19.prod.outlook.com (2603:10b6:300:d4::34)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 10:16:29 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::38) by MWHPR19CA0024.outlook.office365.com
 (2603:10b6:300:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 10:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 10:16:28 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 24 Mar
 2022 05:16:26 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: enable gfx1037 clock counter retrieval
 function
Date: Thu, 24 Mar 2022 18:13:29 +0800
Message-ID: <1648116809-30771-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3577ded-4ec9-4d9b-a67b-08da0d7f5c71
X-MS-TrafficTypeDiagnostic: BY5PR12MB4081:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4081B2E84E4E9F87C1931AC5FB199@BY5PR12MB4081.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzg1hhBz5jRXD2ljjB2/uMaQhog7eAvKObMptChsjpeKLw9dnTqTaibKzZFDZlx1lnhqLZ0+EwyjhXzCETf7Vz7Bg8tXHoQJbCla7zQXlgFiLAk56zdk/+36hGFwvPk5b5d8CgACQkcrNYS502wH4XaLNl5EduCsRiuGTsH3jpqr32010yNK/a1tqyYDmlZtV8fD0xtImGS84y7rH8nO0o3KPME9F0rSYXvfBlu2B/VwRpwasi9AC4cdOpgw0cSBPnptDgIw7Im19ddy28O8BM7v19EDho0WbTp8pU2nzDpaWT9w2/xBLAykUKZZZqmdlw7f/e3wgzcHgnxb43cCjY4YrjFm82qETVrGfjS5g6Sxr03SU7cF6IsH3gohl+EPBuNqMIOC51kj6tSDsmeX7suUDL+5I4Bg7s9vvO/Y59Ba6jQm8SL0QbrMezh+pYuDwbSpNMZ2PlRAUjeMnjjPG/P4EqzsoDWkzUBgYPZV4FgCvzGFIIEqeMhnFYR1rWU6ueq8NeD9oMcuuje4awO0OE35uduVoFOFZgQgOlD2BLOgkSVhru/jrypT0F3zozMBLzXuMnc2BYffFV83vmYVgOEk4OxMLXtGJlMZNVKPFwrq2/XRmp5z+GPJh3XlQM97yufziDOXFTQXxsVQh5fRmGdMvgok9LTqpGuC4nHZiB6wPKesLVt6PK8QBkAloRBc4O4ACCVykMKE29x0NRuxvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(36860700001)(86362001)(83380400001)(47076005)(82310400004)(8936002)(4744005)(8676002)(4326008)(7696005)(70206006)(70586007)(16526019)(26005)(426003)(336012)(186003)(81166007)(5660300002)(2616005)(356005)(36756003)(54906003)(6916009)(508600001)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 10:16:28.7275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3577ded-4ec9-4d9b-a67b-08da0d7f5c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx1037 clock counter retrieval function for KFDPerfCountersTest.ClockCountersBasicTest.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f4c6accd3226..a98b78e0b507 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7689,6 +7689,7 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		preempt_disable();
 		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh);
 		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh);
-- 
2.25.1

