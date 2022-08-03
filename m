Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8092AC19F28
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 09:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CA311AEE5;
	Wed,  3 Aug 2022 09:02:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C415112B53
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 09:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNBOHkfrOBOK50iC605fJNxfU4mfIshwa91dN/6D5KuY6uqw2TeiT7ftAvJH70k6qBk1A63pz4JXC/KoIdhVBD6eimGwVOmTOuIROxrxug8u/GwbPwnoKaeJPbMGg7g8N857Qrv+JdS5rtnFe6Bsy4q6R5lYOuNUl2hXSUyHwWw4jogPB6IBJGL4NRsY9rFzBTdHIU8PvH8GlKuDSvwxK8fU6RJTgasMpNrBcDMX3Io8NVd4+P9sm8oVSO6ydrPutoxo8+3jeoz402HubBngq6gaMWyjTdfnGgwZqeYOqAbFykUF8LPywBKwTKjamaq2ko+4SZ8Y6AbUINuNcU2MBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgzviBpcSdV19rA/1b6nY/BZKLxg/AAN/C4iBtKzrSc=;
 b=Vk9TSVYXTwpBGCWki7w2Q2SqMMXXPpt298etPuhzza+gG9CTXGdCu4DcIbgfeOSnrLMK+I1Pa2R3dYBQv8kOo0gTStkizfGVjt1RJMkVhQWaS9qZfbobRY05AajSUxDJqNGdvh2g84mF1y/xeHLnGps/U8KyLx5Byl7i7pzdXlzG6yUaAwKd6mAwCpeAPndOwR9ipc+DgoLfMO8RctCsf+vXrcLlUIrOBsgjdXAXeQd6N++TUhMuGGprMnDLt14bHCT1zWuLddBYUShtc2ioF0woaZiucuewrcA89iYXfhlZLf//7YMyHfbzpx4aYZSinORARFDb7CyJ+hDEfyDEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgzviBpcSdV19rA/1b6nY/BZKLxg/AAN/C4iBtKzrSc=;
 b=cEHHuNJj0WGw8oPgNR4JZc50cwmHVD1FpahUt4FAtFHLVNIdvCqRc/VG6DKopA89XbvpZDPrRY9KKLW1egP69kWQFQquPHjEzdzKbqvXDviOXLC/nMRvohKHsqLqbbRmoqLpw2amiQKT0CSq8DzbW2JoAnT2IGaJrCmr8eUsP1E=
Received: from DM6PR14CA0051.namprd14.prod.outlook.com (2603:10b6:5:18f::28)
 by BN8PR12MB2852.namprd12.prod.outlook.com (2603:10b6:408:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 09:02:19 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::e7) by DM6PR14CA0051.outlook.office365.com
 (2603:10b6:5:18f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Wed, 3 Aug 2022 09:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 09:02:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 04:02:18 -0500
Received: from sriov-SERVER4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 3 Aug 2022 04:02:18 -0500
From: Dusica Milinkovic <dusica.milinkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Increase tlb flush timeout for sriov
Date: Wed, 3 Aug 2022 11:01:34 +0200
Message-ID: <20220803090134.529299-1-dusica.milinkovic@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 458771a5-e19c-4689-641e-08da752eded6
X-MS-TrafficTypeDiagnostic: BN8PR12MB2852:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACmPPQY2Q2M6RkyqAOXyBCJb6m+oJp+Kipv2u0Vu5IfbIGOoB8J5Wk2B5mAE2LDa03UWztX5SgMkoiVFdtcdBu8wxPiAyXMbX+1b8TKavTNLqEBjAAlBxxPcdvtShs+NARBHFTlcGPInN57rwOFJI1DYMuj0aE532Psm355D/99W6Ma6uPvlNDtGiYWChxE+ctdY5Awa1PtwthlUqzGzkvsDadtiV7p/5laEIHYLBRv6Pe7WOhkw0oUb9aY19VnUvj4lxBkW4zHUJY+ex3GaIXYHOJ3lc0psoPnkGGuFJz4DbB4X/rdEcqJJlWMszMy/qWly59q+1JlVJWf3O6/0aTfowNFgjN5TL+bUd2jaZFfEc3HqglZptsDa2JqzLv5U01asAiToQhDhii/F1XmAvE74Ew2XkZU1N/cftHduTW4uE9UopFwwDPCYOwI7h/rdnaiJ2ZdChhmrtONSGVs4ilWdG3YVg++2AR0s97JN1+/F1T8oiVNMgDlM5HOjdQeym2JSPW+kV5gJ2eGU3JqED3mQX4q1Ed4YZroRCTxpBJ3ePtfugeW72znkEP3+4Te/epXQlbnWTCpBnhgNEXAp/nUsLFpij5XnD+N7L+w4FW4tqRDsMyIZV9ifzuggAGzzQxSbuQfHzfZ36pc5f0017ESXWe5Qohxeapt01QwYr/MFaXRWRBKHvleh/5N5rlS9trwBXzgJzmuNINOwUSciQBXtuudhkNsQfwRebI05NBeuEqjEj+6JwVnmw4aYngfbT44E/S7DO0MMJWqOR86vYqxVgzKG3AI3+3sw3ohjnvTvSvAJR9SrmhlM0oQTus1x1JwJwPR8q+/99RFd83PaqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(40470700004)(36840700001)(82310400005)(40460700003)(356005)(5660300002)(44832011)(2906002)(86362001)(8936002)(82740400003)(41300700001)(81166007)(478600001)(36860700001)(40480700001)(70586007)(70206006)(83380400001)(4326008)(8676002)(7696005)(6666004)(6916009)(316002)(26005)(47076005)(336012)(426003)(186003)(36756003)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 09:02:19.2946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458771a5-e19c-4689-641e-08da752eded6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2852
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
Cc: Dusica Milinkovic <dusica.milinkovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Dusica Milinkovic <dusica.milinkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9ae8cdaa033e..6ab7d329916f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 22761a3bb818..941a6b52fa72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			up_read(&adev->reset_domain->sem);
-- 
2.25.1

