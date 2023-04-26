Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7071C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C4610EA3E;
	Wed, 26 Apr 2023 21:22:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD2010EA35
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOt9Qt2zNR8d6/vBRWl2RjYYO1l7bhM+plGTcidu/Qn/C9saJLvQ6Q3S6DuX4P6/QEljmW8KZVpmoPjH57vO2p0Unf1YRflv04rz2eSFZhy/TSRVt5XZ5wo9xNL33M62dbaFiSYPdJVsY1Zgb4g9cj/x2K/xHVMTTtbMRuv+c+oSkQSI8CSUwTP/0EJJQXe72MPUIUoLNFEJdPeR7AmNTnFkx+XV27Sl4uLIenm8Klw8g3dYbtZuI9Ke5/OpfjMahS4GDll2UN4oDRqcRzA3XLDuNZUhWfs4aIqrkOADVuFnmZIDFlv0VH8Qfxljx8bP6n7I1pOtSdLURFWL3u1gzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgzLqm8soNC9U3tS3Eze0X7GRYqtfobQtqG84mxxano=;
 b=iV1R96gi0zDqKJrJ+wsxiCksJTP01T474llcR51Bxnndm5eZTZw00D7q0T/mVjAMpJMIdNmrnuZpO+0n/PF7Ta8sZ+OBFu80lqknuUwfqySnIjRkp3VnO6X4HITzP8c180MCNVN1KBgK9EeecfnKWqdnpQzXqWMwLIthdHA//DxYfkzbAxGvUmtrLDbSgYzRyIZEykuoVjkltzdNIIHEOYehCDVrGT1exdkzUB4mRz71Cwe59IL+BDod2dZxk5iDfoTvjGY+JdzY/+j7HVYddPgFCpDWCNWZv6gKUozjs2/2vK/pdXdJfRjT47/bsyFxnuaaJ64lo6IzSXMAdn64OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgzLqm8soNC9U3tS3Eze0X7GRYqtfobQtqG84mxxano=;
 b=cGujQ3xC0ND00mLNloblEY6aq4u7cbayBMyHy0Uwh5ijfG1EaoKlGr8XjRX7hp+wS9zfpyJRMYPM2QqMbbpqagGk2wc66B7hQC9HYuCIuW/daFboBOiFrjeZpLxnfrG/kTnO1bXXUGc3z4F8T1N0oweQkRo7AhGp1Ps5djxqqig=
Received: from DS7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::10) by
 BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 21:22:04 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::40) by DS7P222CA0030.outlook.office365.com
 (2603:10b6:8:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amdgpu/gfx9: always restore kcq MQDs
Date: Wed, 26 Apr 2023 17:21:40 -0400
Message-ID: <20230426212143.7696-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|BN9PR12MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dc2a6d-74c3-41d8-31c7-08db469c4856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1W6ZoGvM6UUn1Ybdfv7/s+9e7X3FdiDf2QPzWrpt3M3oRzpu0q1l3D2CF2Al+2JQBdxh+RNWbjrbZ4PqGamB1uo/oIDTgEZVe5LGFmxXhOTOkEhq4rWJLAL4XtSEgkw2TUj3PLDh5AnkebJHrR5LPtUsCaYlHGxmii8qNA4LKBLo0P7zpG+4znamyC2eK9r3mqkA5kcgVbOADUm1HhHrUGjMDWF3UE5DQjFv35yalM52JvZaNNH2EUhhIt85W52D3IUc1CNB08DrY/x1929+vrK2Vd57NSySlHPqftVY9N1BHjYadLApuwhs1spvGPnvMdymOobZFtE5OGCWukjxPYJygFbpoFYzK5nJT21mr5JRw5R8PfULjv7avd2ymXs2LCxTUwiGQxkKjoLEe+W+JHq7guU1lCJZ6lrexB+qZ/CzA5m2Gf7c/Wx4MW2oG4Uav4EbpUBFGvssuilsN6PKw6GLJN4hRKB4PFVElwKEbcmgT/zmrV++EM8msycrmi93tFrw/8dyeqncSzBZp01kEBySpS06O3XlzW5H7XndqdiQYTTPbPEaoFWUs0UXyCH3CrBUmIDmQBziQRFvTFThKWCLu1BvRQn35GZvAK1Qrab+cMS5aRjDLL1iroz6dlP1x6vpxzpZ/YTs8/4hEmVhBWnBxcfrhpe6jASIoTkYgzEotr1ufaE6TnBbEPRxxDd3JL7TpCtdtoW/6SkJ42xAOT+KezdElchi1GKxidxmHSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(81166007)(186003)(16526019)(8936002)(1076003)(40480700001)(86362001)(82310400005)(36756003)(26005)(356005)(47076005)(36860700001)(83380400001)(426003)(2906002)(40460700003)(82740400003)(2616005)(6666004)(41300700001)(8676002)(336012)(5660300002)(7696005)(478600001)(316002)(70586007)(4326008)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:04.4726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dc2a6d-74c3-41d8-31c7-08db469c4856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4ef3e7d9b108..ebba95fc6911 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3591,16 +3591,16 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 
-		/* reset ring buffer */
-		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
-		amdgpu_ring_clear_ring(ring);
-	} else {
+		if (amdgpu_in_reset(adev)) {
+			/* reset ring buffer */
+			ring->wptr = 0;
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		}
 		amdgpu_ring_clear_ring(ring);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 56a415e151d4..fd5649e45486 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1799,16 +1799,16 @@ static int gfx_v9_4_3_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 
-		/* reset ring buffer */
-		ring->wptr = 0;
-		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
-		amdgpu_ring_clear_ring(ring);
-	} else {
+		if (amdgpu_in_reset(adev)) {
+			/* reset ring buffer */
+			ring->wptr = 0;
+			atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
+		}
 		amdgpu_ring_clear_ring(ring);
 	}
 
-- 
2.40.0

