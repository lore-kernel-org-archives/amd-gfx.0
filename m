Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC785C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB4F6109E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AB4F6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FC86ED0B;
	Fri, 22 Oct 2021 11:03:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7DB6ED0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 11:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggyuZ5EY3ZK3jrz+VpKdxExmUq586Zupl6J7Po12PKKiQXOl0EEC01rjxCcYWoFEVvzdZS1YtxmR+NeoY2mHmcn3v2Rn4hocT/aSoQGz2YMLW7IYVP/wbRfZo2LOITeNczI1Bpbq1p/UHXa3M9Dut5Tx7y5XZ0JwLH8jkIvqEDii1C+jT2sW+fn9TrRr6KIQTTAx2cXKUkBF4H2dLXwrN+OHuRFKgVYu04W1cfHj3c0qhhFevZCBYUZ/uC4V0exHyziDzF7Ite0zbXF+pyKcA70DVyNcBzqktWtQ8aoF+MelNbqTQ5LYf69kN9hYIdn+LPyCsMS4UzRgZONTSXHbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEKabfUQuZtaSp7mI5HNdG/Qv/6sQzhMkpDpoq9hyg0=;
 b=VoGE7sofFwgxf5NUJjh58cHSPcfTvWU8NZKZgiM++uT/YkOg0+z1JKHfMqcuRzqXVvWpTGoeYl4gNmh2Fw2PdYzW9LeQYNOK8gzWU+92kwoYJBYnN9C34oyDUJ7lkrdTV/ckcSjaLtkFZw2yh/phg6xhBnp1TEM7VUqAmpkHTSjiLV2F0zO3RStMuv/HYUccFaiSdQYexR0qtY0+2LUQ7NbGLaCQVEaJHmQhJZuBhUrQwEAD40GVsTs+uDrmDHgj3HWp1fSS6UindCSTdtYnXCFh7UOHklbz9AUAdUi/h6CWmseG9Xob6vuwoYvjPww/UODFGKxngY0HgR2AeFUekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEKabfUQuZtaSp7mI5HNdG/Qv/6sQzhMkpDpoq9hyg0=;
 b=GI0m3E2uUs1LxHRtju4+HiOJV2pvLrHfOQgbOKo3peW6eToN0w3XVJmuLuDPee6l9ZewHl6fCE4ISqVOlIN6Do2SughOZ4/uXf2hOIHW+JPdFJ97VCjt+/p5YkzwagmsgV3WtqJiMdde0yTTe6MMb1CYcutYGoEulAHiq9EFKrk=
Received: from DS7PR03CA0300.namprd03.prod.outlook.com (2603:10b6:5:3ad::35)
 by MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 22 Oct
 2021 11:03:20 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::fc) by DS7PR03CA0300.outlook.office365.com
 (2603:10b6:5:3ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 11:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 11:03:20 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 06:03:19 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: remove unnecessary checks
Date: Fri, 22 Oct 2021 13:03:11 +0200
Message-ID: <20211022110311.128971-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41005446-f969-4c85-9e82-08d9954b8ef6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3198E6CB0FFCF5BDBBC979348B809@MN2PR12MB3198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxr57GHFLgiyXeZYHGC4dNpK6+QHI6ffcKwAcqHTU27T889iNRhXqrwV2AUrN4HOGLfhwfnlotyPrTw3yei8NzDqYLQ+DxNrpd0SGlgYDz+i2idzGQbh8RU+AwnGu8YvidSODUB1HvDk/357ezs2I6MaJ3sJ/9sVBmZjJtA0GAMg9ZOGzsryEDp9xUfSwrK9tke18i59MlRP4Bu2Rk3vx9Ad5TBNIqS3vL/4j7jlT78cgPhe5pa1FclBDgPTNfw7xKrgX+02XyyOMSVpnWw2FVt5wkIhMQLO5fRGAAw0uS8SFfkVrFc+CPw50e9K2Y3NrI4KCRt39KZSmAyvTEfsR3d41QZayLElEi5rFpJBv4A5j08ZyS9JxKJn3/waMkK1XrlxFdisg+V3Hg0KMGwJhAarUU/qH86+qvSrYJO1GSst49Tvf8XVO4U62l36EO9XWztCI52KTcZv/vsJVLYIAPyeUQ6//M0F7pgeKOE24goMfu1S3UmGPCUvRW6jgWR7JQ1x1D4u4XQbncUVHxS8Z7mXIFnGObGc9bMDhQ1tSEfG90U1lcM7H9efT4LTUjLP8VuFAwa6QTy/aiK9HowvteN6X5PHuCWmaupzAeO8f0lEACwwKfQU4Q1MmOJCr6KJ0PAE3aR4GMq+04YsQQ10ZO0TObHBAlsPEsc8VwcBR2v1XgPsmFBfWC2uHfLgL3bl4RYAlsHe3QTsZfit4OFO5M7Kfpv78OLxK3ELQHC3WA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(426003)(336012)(70206006)(6916009)(186003)(5660300002)(47076005)(36860700001)(508600001)(356005)(82310400003)(86362001)(1076003)(81166007)(316002)(26005)(7696005)(36756003)(8676002)(83380400001)(4326008)(6666004)(2906002)(8936002)(44832011)(4744005)(54906003)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 11:03:20.2259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41005446-f969-4c85-9e82-08d9954b8ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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

amdgpu_ttm_backend_bind() only needed for TTM_PL_TT
and AMDGPU_PL_PREEMPT.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d784f8d3a834..eb872fc4ad92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -914,11 +914,6 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
 		     ttm->num_pages, bo_mem, ttm);
 	}
 
-	if (bo_mem->mem_type == AMDGPU_PL_GDS ||
-	    bo_mem->mem_type == AMDGPU_PL_GWS ||
-	    bo_mem->mem_type == AMDGPU_PL_OA)
-		return -EINVAL;
-
 	if (bo_mem->mem_type != TTM_PL_TT ||
 	    !amdgpu_gtt_mgr_has_gart_addr(bo_mem)) {
 		gtt->offset = AMDGPU_BO_INVALID_OFFSET;
-- 
2.32.0

