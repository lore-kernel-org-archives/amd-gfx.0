Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D681AC7EE2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB71D10E40B;
	Tue,  9 May 2023 22:11:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAAA10E40B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Zcwybuhb8/t0Gent6nmYXNT8ArFvTaLruxQ4Uo35QoAB8XijcL7BqJqN271JIlfzZF6ae2Y1FfIachb7dLLQK0khQCEcm5ZAuO/UeJ9oydTl/CM8HUVg2ZaieuWtbxrOWc8dpASdRGFO7AIOm7oLnBgfZk6NhNU+HHhgXNCJjq1keTKx+Q24cqtzgBLwPK5pSUCXf7Ap829RY4zzLAWbVzJRQ5jTa6RaZdsJKwV6VItCd1SULghNTEBkSP+tLcL1d9ZvkKMZCkTRLkM95HLmTP5gCqyin0d3ugaxE/xqhQWdB4zLkAQ+VcoE2QI3MNohBddaCB/VxGLO947D5DMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XFNknH0ouRuutLEzOk/Xmd9MwDm53LymKhGazf8O3I=;
 b=oacVCfZK8Gnhy8AJUU7a7Qsi2WdG0l/v3owi+dX825zUo1jXZ4w6fnfec4W/guG/TVog9yVvQ0Ag8lf3drk4sb3WjCcPTXpXn3JWaYCkzscLyR7vPnWVNgNYhcX6G50vCDDvG/fWSo4UsQojsshI5IgIvkkN0RjtyxRWqoUFD9B4jcgxnsF573hbbf+Pm9mr15oJJAxXyw3EnN8yMQhVBEYCb3iH2Y8l575FB7aec9ovlZMGRDXdqPwaqptf8u7GhQooNj5iZYg66NwTPm6nNJMPXV2c43kWyDaJPFPKQJzSnrGylkep8ZtoDK+xFBdvtXgmNoikNZxOmlJ9mbuU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XFNknH0ouRuutLEzOk/Xmd9MwDm53LymKhGazf8O3I=;
 b=4wUHCynxZGfED1gqFdnRoCihMM4sxymUSwARgTxGuuBLNEnSjfbZlVW0oMAqhECJ6ou5kgnwdQdqXUd5Br1O6ABrSSBn+NNF1RCXQeEw2RGroML0tGr4rJZwIm+M7fWWLZ0CN44VgqcvXAbVZPqiqyd6irs4RO/lJr0qR17uKj4=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:11:47 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::ad) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amdgpu: use physical AID index for ring name
Date: Tue, 9 May 2023 18:11:23 -0400
Message-ID: <20230509221128.476220-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed69639-daa8-466a-2eb1-08db50da61d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/gjw1grZQZzLEU+8Y4k9/MIva77/HdOG++RhwpDMz7zDg6lPDWf2W00MPuOel+uJ7SlqKI3Ce3ERopEtB+eewazIBzFxQf5o+QolO6FZhhjFBe6avfn5jf/17L7mOc+JPTnI5rhvjeh6oiu4niyuzgdnqojE55esXqa8meHp8Fxctdo5lVEubtc3nVn1APq4uNb40ionvLSZYOevGCGACJjqRcH5NESG9llI5du1RWQipbYibzu4rmBeQrX+hw9yoa6sbzq0pg/9sQtMnWCJgbqZPU2zU6vM4bGKpPq8DKMseT7HvsqM/EZl7sREBQBzIkKuhx01HLZ88bpV5fc2mKHAo2mD+CSI03r86C4hoDX2KU3qdzFZcyFvyilpJn0YbDdh9Am3aqavJJijxLlFtxGdJP28an5ENheMVC2NfiK3yLQHbO6koe3bYKuLjZ2OSjSfJcjlmS5yaI42oDe+zJSZqLIt7MkrfA/BD4wKd9EZmxrIVXlg7O4sdw9PIxYLhpMayZrBhcRTgrY0gW9nHgvfyrPwhlSFcRHIs0Gm30+eYJtaqqlIgALHJYRq02EbVayTDTD6KMraQmTmelIeZZlTgnbn7XpCmTZiGV8uEt7Txbfa8vWKfANR5TMrW0otizKSkjW4ZjHPEegV2HTuD92W1wNuRJj2nFj2bGYVebvQB0bJTsgvgoUQqviCDBfvXZOGwp1xCkICKJl7P/CWNbcu/99BaCzrCKXtE5Favawora8MsWXZVqyNZ41KZrveVmozT6Qui0Zu+9ivIXXeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(86362001)(47076005)(40460700003)(36860700001)(186003)(16526019)(336012)(426003)(2616005)(26005)(40480700001)(1076003)(81166007)(356005)(82740400003)(8676002)(8936002)(316002)(36756003)(41300700001)(5660300002)(7696005)(6666004)(70586007)(4326008)(6916009)(70206006)(478600001)(54906003)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:47.6845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed69639-daa8-466a-2eb1-08db50da61d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Use physical AID index for VCN/JPEG ring name instead of
logical AID index.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c0e90e27f24b..ea9cb098a144 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -110,7 +110,7 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 			ring->doorbell_index =
 				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 				1 + j + 9 * jpeg_inst;
-			sprintf(ring->name, "jpeg_dec_%d.%d", i, j);
+			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 						AMDGPU_RING_PRIO_DEFAULT, NULL);
 			if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 759f64a4acf4..b0e28d611f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -112,7 +112,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 			9 * vcn_inst;
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
-		sprintf(ring->name, "vcn_unified_%d", i);
+		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
 				     AMDGPU_RING_PRIO_DEFAULT,
 				     &adev->vcn.inst[i].sched_score);
-- 
2.40.1

