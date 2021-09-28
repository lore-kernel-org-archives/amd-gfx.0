Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE8BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03076101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B03076101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A42B6E8E8;
	Tue, 28 Sep 2021 16:46:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5A56E8E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRChbjm/DRMf793OuYC41SreMrfGUuDR8x+WNGJFSWLZCruF1zmspR39lLjczgmypnCx87KXoRhC2jbMEh8HmjMdP3SclDUcUapHZLioYE7qsV8B/bJeFNjjkf9YTqZUvBZwJIKu+V36Tjh8Zh1VLxHqHjD1Bzm3kl+TTz4xxr9ZrSgit24hV9XyYL1FS7bCos2zNK69609vv45YpO5s3Owriym+6p51opT+V3fom3gw69OG8PuWbaubAQdbk28JIbiUxkGRjXS9sLK4PnbbHCb3D4HNOYQq8R/wWtGCVG+QJwUR7VTd+smORPFd7iguwKYxAcoruehljjVZeLvVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=W+ZKfWQg0IwlB8DURI3dJ7Dg3DrXmwIf5H6uTTk7aRg=;
 b=LYD4qdiP1hFbg0DvewBVv8rgw4y0s8Cb7ojfUM3OyRowukScl9K/mEs0SuceV0elvbOvVjucxPKACwDa5Oe3MkjV0w0tfILoIj14XdAUtIn0nXI7nGZZlUca4zaScdK2LeSHPxEsreqpTWP1SWRFvbYzDLgNUVcWVv0K7kkYRmgphQ3Fzhr2vd3UH6lrGWEVBHr22tgeSxLfwDMnUVF9Jgu6jhV5YJos2QlUcIQsz1j6tuAADpVO7R7VqzqAKhCcOGk9cI01/38+fy+vxa/Irip8tOYzPXchOzwWi/kCtt89fV7DNQjhW9ExLwi67C+DH0ZgMfuxnTjLAJrTXqQFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+ZKfWQg0IwlB8DURI3dJ7Dg3DrXmwIf5H6uTTk7aRg=;
 b=NB1aF3aA0+q7NUzvpokZUa2CBLahbGVwjM/LhO+84OuZXDDdftFIZfdArTgMCQGfZnuhc3nl/o/r4nI+9BJpjiWxnCfhgdq3eB9vtlvqDAL2lPa4ZLaoOJgcp5F2/SdW+irjkPaTpTBH3/pURa6v7ucKenICd2nS7h35zaNye6E=
Received: from DM6PR11CA0017.namprd11.prod.outlook.com (2603:10b6:5:190::30)
 by MWHPR1201MB0048.namprd12.prod.outlook.com (2603:10b6:301:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 16:46:15 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::f3) by DM6PR11CA0017.outlook.office365.com
 (2603:10b6:5:190::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 54/64] drm/amdgpu/vcn: remove manual instance setting
Date: Tue, 28 Sep 2021 12:42:27 -0400
Message-ID: <20210928164237.833132-55-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db14fc61-50d8-43db-b19e-08d9829f7c4a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0048:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB004811CFD49B6C19CCEE45BFF7A89@MWHPR1201MB0048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yvis2VClgzFxR8o8mCUa1WB1She7eA0bEtNSPNy9aT4uTR/8P8du7ByWEL2R0dWqSgXnGm/vbnlVU/kQiOAD8xQ1eknSyFAtvRc8b1dJDLnIujgyhLFr+A8OR74XLfhG8O0xKaJ873tKnTJxRW7XSHsOceUTyUs+iUv8JVuFubUITPmtxT07Gz1M3OHhsUGyUg7W8dTc2TEsMOjAs9wuQ6gdAkJm3xyJeo5tn6Sg/eDrpZkj+t61wCgXjVQLAbWLFESbrxZM2EjQ4kmsdYnGEnWBts8fqnVrAx7SbWVFvCGl3WxqGoVH8TLLvCgVbVZTYtkKLkezHBKnBdEF/sYhC6RejrVy5s47Em18257ThMv2Mb5wlHLghSQpyj2UxrHihOgKnPhkOMk9pi0kkAVLsbioNeEjVc5cZTA9STc2Y0Hx37OodxKmdbr65xiJjg+Nu0RXPcwCx2Hp/XaRx4wATGm5ZNx1LQiogER3tVN8J5YAUOLIQfvnSxigfJIG3qEnHes3iii3eTZBQcOd0VVG55mAnpa3OpQXbTX5Gauf6AzVWxMV6VCu+JS+4ifBDebSyqOEjGNQmpxzUCpjqEkTHsaPaDZfeCJDLTE76vYEKv9UgY0UcWJSMnzVNXC6RivYIedxnyawjVOMTBZl2sJIaCKnlQGRQk5CI/hbBR8dWPLWh4klWtcerry+zbvlQOWs8pNq/m5L7tXvz/faF3oJV1+ZPXe0zXy0draSI41+f4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(54906003)(36756003)(426003)(70206006)(36860700001)(1076003)(336012)(6666004)(83380400001)(316002)(508600001)(70586007)(356005)(82310400003)(7696005)(47076005)(5660300002)(2616005)(26005)(8676002)(186003)(2906002)(4326008)(81166007)(6916009)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:14.5517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db14fc61-50d8-43db-b19e-08d9829f7c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0048
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

Handled by IP discovery now.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 +---
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6c11739270c1..ad0d2564087c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -66,7 +66,6 @@ static int vcn_v1_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->vcn.num_vcn_inst = 1;
 	adev->vcn.num_enc_rings = 2;
 
 	vcn_v1_0_set_dec_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index a03c0fc8338f..43f46ab07dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -69,7 +69,6 @@ static int vcn_v2_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->vcn.num_vcn_inst = 1;
 	if (amdgpu_sriov_vf(adev))
 		adev->vcn.num_enc_rings = 1;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b76d96559029..e9758969fbe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -83,7 +83,7 @@ static int vcn_v2_5_early_init(void *handle)
 	} else {
 		u32 harvest;
 		int i;
-		adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
+
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
 			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ef36ee0f3a5e..a81d834ea0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -98,7 +98,6 @@ static int vcn_v3_0_early_init(void *handle)
 		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 0)) {
 			u32 harvest;
 
-			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
 				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
@@ -109,8 +108,7 @@ static int vcn_v3_0_early_init(void *handle)
 						AMDGPU_VCN_HARVEST_VCN1))
 				/* both instances are harvested, disable the block */
 				return -ENOENT;
-		} else
-			adev->vcn.num_vcn_inst = 1;
+		}
 
 		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 33))
 			adev->vcn.num_enc_rings = 0;
-- 
2.31.1

