Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A189C47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 17:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04AD10E215;
	Tue,  2 Jan 2024 17:30:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6CC10E22F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 17:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fizw5RG1DO2hsjk73r93VcBJEmsaw3vfOx1y2PH27Yf06PGLl3x3p2cLOUX3Tdm4BgROQaL84Py4YzvxeCX8LiXB4P9eNHt2uB38mNgdpil5Jk9W4t+Ecw7I358wGJiph3pRu9olkMp4S5ujj7dtVWLzPjytbBdNDH5nR1fMSixedSS1SUjOncrJNvJqZ4fdmbI1742XknDY7nLwNi7Z/feLR9KIV7SJH2WNVhod7L2LHcSRa8YaHJ16fJ3gXL6rWCsuB+zJXQ3jVq1vPwI+zA222/dIbY1XAHdMG9+XjkGokAqRQjXpze0/vR6wVDUaaqitQ8LRaMSx+KwHjVb00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB6ikBxHuY/eNFX9rN1BkaRtUgdGZT/6EplqBtBPPmM=;
 b=lA1eCrmY0gBwrGZtCRtpLDfJZaAasPiBm1Zwpi1DuyFz6h9KVV0cCYHdoU50R90o3oYTC4hSZq10p+3ik+NnYeju7v7uXFQtaFCC2FHquw2HyLyfPYxZES9DTvURZd+41NuqSwvOv1GT+Ep6H+QyhGM3qU5XftdfYFXJk61NvK+corttPe6qsuqx2BeJoUFDuIuynNJRR2DDlbwFGF2VzGOfNdiw3R81JDFDlg8WZexpc0FA2PT0C8QUMoZq+DUlGzog06KgaoUOtDCyv6RQc+pXtxabSdXtMWAhl35k6dWhUJb7D+Y8KYsvr8DluQSIFs6c8fs4HWpFdxdM1Ynunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB6ikBxHuY/eNFX9rN1BkaRtUgdGZT/6EplqBtBPPmM=;
 b=yjvbC9kR17tF20pfeT9jANn2n4QfGFHV77BTW7tN0qLyG6CSWiKVV6ipIMg4C7VgDE5u0Fj8te2TTIfnb6sP4ylqCOBeixmafOsVq7K/id+x3f1DGcBvvYlzU+Bwk1VpPLat1COtOWlCRSJnkQzHLOgyMyj8TJv0RRdbrk9Ds2E=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:30:37 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::c4) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Tue, 2 Jan 2024 17:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 17:30:37 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 11:30:35 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Do not program VM_L2_CNTL under SRIOV
Date: Tue, 2 Jan 2024 12:30:13 -0500
Message-ID: <20240102173013.5543-4-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102173013.5543-1-victorchengchi.lu@amd.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a7e0aa-35bc-46bc-43a8-08dc0bb888b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5R/JNxZ9i9k+tpH44Ewj3Dr9/D1g3t0YXAemyV6ezfXSFxaZlvcgkgDL/xz2klo2xiweFxVCKZXHYdJzNWXz1vbqG4EG8Tx3rQZ1XnWFWw0hEFxbJApoyolKfXLsIf6VmPVjSZtw/as9b72DtaXO/PRgTMse0lxncgibraFgHeRnfsEf4pTTUzv3FA2FiDrvR4iJ0RmJo4bNY7GeSvqpZ67Xo7jzPDdNCkFaiUqYnKxLVDydDk0UgU41l18HlB9FFVijsHJ0Dj+Prx6bfCN0/BYJUVhAy1v2ecm2ko3wrKgLWsXpm5B4FigdFxFpjermMObnN37INg2Q8YLYr5cYhR39/3Ov/4rcm4pYcZXYLkY5cHmP6tqSgnKyRPyR4Ilb/2zc/A7PEARN5Y5R+mA+kleKWl5Gj8zzLkLbhGI+3trF9UCPpNw5aNC3KMxH3nHLxiv25RUnM2S/6VAm4NMyl+kDDh7zScta6xyPfBNm5whvXCWxHKo7Qf1Cb86/+nB0kQgEulvJhwl65xxA54jkKh5ljmaP6eQSs3K9eDneQT55BQjgrlwyy4L5fbWbFK41t+rDGIZOV7z9hbkZkx0NQ1r1u4PzV4sin7A/YD82qfyskvdG+KQ1PYMdvguD/sU1SEKtip5LxKm8RoZleZYkqLSP8XEg1A9rE4wkWRttJP4VmXwyPUTJDtXImNLXJ5MUOq3Zc2cuMfujimgaUvyQrrtgf8dwoDRSAbFsLMw6Ybg4jfOPIaT+LSCn8gio7wM4faWYJMKsHi31fjp1pZkcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(356005)(82740400003)(81166007)(36756003)(40480700001)(86362001)(40460700003)(426003)(336012)(1076003)(26005)(2616005)(16526019)(7696005)(6666004)(70586007)(478600001)(316002)(8676002)(54906003)(8936002)(70206006)(4326008)(6916009)(83380400001)(36860700001)(47076005)(2906002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:30:37.4127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a7e0aa-35bc-46bc-43a8-08dc0bb888b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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
Cc: Vignesh.Chander@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VM_L2_CNTL* should not be programmed on driver unload under SRIOV.
These regs are skipped during SRIOV driver init.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 55423ff1bb49..20e800bc0b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -454,10 +454,12 @@ static void gfxhub_v1_2_xcc_gart_disable(struct amdgpu_device *adev,
 		WREG32_SOC15_RLC(GC, GET_INST(GC, j), regMC_VM_MX_L1_TLB_CNTL, tmp);
 
 		/* Setup L2 cache */
-		tmp = RREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL);
-		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
-		WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL, tmp);
-		WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL3, 0);
+		if (!amdgpu_sriov_vf(adev)) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL);
+			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
+			WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL, tmp);
+			WREG32_SOC15(GC, GET_INST(GC, j), regVM_L2_CNTL3, 0);
+		}
 	}
 }
 
-- 
2.34.1

