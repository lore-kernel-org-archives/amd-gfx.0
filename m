Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CA0C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDB210EAF3;
	Fri, 11 Feb 2022 18:59:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C6C10EAF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3UTEdHk3z6gnJ4v0RnAsU+o2AFeUHjeEFB825yswdTIowRkWctTZktEPxTTBfXzMMgeqaItVTbcrkVNPJwZCEMFb9rc67S9y9F4Zu27/vskIdBoxi1H/0KGhViVw9e/Nvast3Vgp3d36tvWyirlmv9grCE8gDDIeOGaxwAyvoAnO6aLaa+wU21AiLVONwXWDHvZqF6115/aPuKZ2ZjS2nQaPohIrTP4XY9/ZP8/n9z/0Zfd+eHK081rJxWNB0EUVCNHmH94SUJPJjOj6yS41ysmsUjo7Xpf/ch1xlVwygN2HceaYMUFKPN6wNhXDnCYLu20UpKk0HEspCvYSaXqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsuOKdDyyyKaa15luj7FrWMy9pFxggz5I/jm0zyY4TQ=;
 b=jlaDKzyfhSY55ooUihepUf3ZyNbArz/X3dI9GoD6YgZNiwJcK0v0SjDKn7NlflXnMPTl/2yCGKoqW/v8jJY2rtX7bsNxcNCbzjrYsO4hCMigXJzaZG4qDMg6U1HtSYOgEWdrytOb01hxMdU438WW3jSfh/JBhi61k+9Grn1mqc25pL5qey2yykneTozQAIs2Bqe4+Ga1wtenSEUP6XXFV0HOM/KP2B7TZrUG/Gwol7CeVZ4JSJU+P2b340U9zN6YkW6UODsnZP6LCR6nZyAFXcdudq23ybNQLE0Z6pStoYroTEnISd+fPPd96Z5cO5tsxduK2ImUV4rn7JCo2e5rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsuOKdDyyyKaa15luj7FrWMy9pFxggz5I/jm0zyY4TQ=;
 b=lHP9pLZR12Y9Mjb03ekiczxPzKA5f9IlWIlC4Iuzom3044V/nQlgW2bFR+ZEwq5wknlGVw6xZ0YvrCdJY79yGX4GLVjLK/cQqEuQF8ksLkNg+9jaB86ig9n0WVM9O6NF218O3UP0ND5CNXOHSTy4BM6T4QteNfbt2fKbJJLVzwk=
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by DM5PR12MB1609.namprd12.prod.outlook.com (2603:10b6:4:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 11 Feb
 2022 18:59:38 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::c6) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 18:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 18:59:38 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 12:59:37 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Fix some kerneldoc warnings
Date: Fri, 11 Feb 2022 13:59:22 -0500
Message-ID: <20220211185925.4178-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
References: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc82fb5-290a-44e2-9a2e-08d9ed90a750
X-MS-TrafficTypeDiagnostic: DM5PR12MB1609:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1609166A33E3AF48EA793AFEFE309@DM5PR12MB1609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uin3fUewEe+A58pfXzA5d3d0nq/demuTUxYlHWss/xBY3K/M8TbuLuhKzVzqhVV5PExQEfCaPBqsKDSVzKWX+AHSQmCjgILwigSpYH08Vn2Jmt5F8XbRtVBg6Yy7zLokFE3RTsGzZiVRG7ipm1LbOUwWY1Zx4tlkUZioyYNH/Dj7Xp/md96fvHO2AOjUdIZBVL6XoMOoNqVcvlEH85ABZQZo2pjZKlReiWYDvvE7AM2yH3VR2wgd9KfiVpSrAau3el7vFxXfQpnjrw/ssw9z7kGJiBQnOVOjBlfra4FMmHAn0NDLR269DujQIovJw8lra+LL/++JcbSzNgt6KWBhkC4f3bWtBeO8DT9dq7ijXIeo9W2nZlvuf7i9uko/PoVDabgKQYQcCGlIJfY+/qNNU4w127xRe9xZtO3slKPd/NJME5k4ejqbLmpsb1uquRf+pMslsBqH5nVmjHus3rSkBe6Adi+WUiU79c5bAYkYHj7Ji1n3iq0GdAklI1xN20vgIPtFNlyC7dBCI6yFEAfoJntL9+xkBAt/qbtkHEUOdhqGNopEiGK0lp6TKIX9VdlVfSJD1gUu3szzedpwjAF5wRnmNIvy/aWf4yExJB50zGh4UM4V9tXIxs3Phz1yjPUPSlPWzCCZQcWChVECpR6w1/rYKfB8C20zyQv1o9y+U1Vu6STyuKZBbGjlXUTqEqY4lyYQ+nw2Xg6WOEdoRhCNrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(6916009)(316002)(54906003)(8936002)(336012)(83380400001)(426003)(7696005)(4326008)(70206006)(70586007)(356005)(8676002)(26005)(2616005)(186003)(16526019)(86362001)(6666004)(40460700003)(508600001)(1076003)(2906002)(47076005)(36756003)(5660300002)(81166007)(44832011)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:59:38.5911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc82fb5-290a-44e2-9a2e-08d9ed90a750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1609
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
Cc: felix.kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix few kerneldoc warnings and one typo.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 53895a41932e..81e3b528bbc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -715,7 +715,7 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  * process whose pasid is provided as a parameter. The process could have ZERO
  * or more queues running and submitting waves to compute units.
  *
- * @kgd: Handle of device from which to get number of waves in flight
+ * @adev: Handle of device from which to get number of waves in flight
  * @pasid: Identifies the process for which this query call is invoked
  * @pasid_wave_cnt: Output parameter updated with number of waves in flight that
  * belong to process with given pasid
@@ -724,7 +724,7 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  *
  * Note: It's possible that the device has too many queues (oversubscription)
  * in which case a VMID could be remapped to a different PASID. This could lead
- * to an iaccurate wave count. Following is a high-level sequence:
+ * to an inaccurate wave count. Following is a high-level sequence:
  *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
  *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
  * In the sequence above wave count obtained from time T1 will be incorrectly
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2e00c3fb4bd3..cd89d2e46852 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -121,7 +121,7 @@ static size_t amdgpu_amdkfd_acc_size(uint64_t size)
 }
 
 /**
- * @amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
+ * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
  * of buffer including any reserved for control structures
  *
  * @adev: Device to which allocated BO belongs to
-- 
2.17.1

