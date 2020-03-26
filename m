Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56053C2D0E5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FD2206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sJL3+epB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FD2206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D526A6E923;
	Thu, 26 Mar 2020 20:03:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D16D6E923
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 20:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjW92dtwL5yzW+SD8jT71iZwH8jX6psZoGs2/Wz88/l+vc7bMr6wi5C2s5vq15/ol2F2PV6EDfMEDjFW4UpV3zQ8jGmSan2rvt+4bF0nkCRVEdbqwx6e98xh2ERF0clvj9JMovShaR6cH7me/jnPwE2jeDhSouiy35WNtyWbQ4eqX+c7Wi3aqVNdMuaK7tkuWsITqog3EomvG2kdeNpaiBG1S4NA8tgHAPM+BpDt3JMoOp2uLEHgAqt413AcJ0QnzEMiTXbdP7bERpVbYH/QId5Euvz2vq2tm/yhMhKWSXF9J9l+CnUQGLf97TGI1x2SGok6JTB06r/iTXAYvPJuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOBrutiNFrGDFbjZOTtdiUShAyqTAooE2HS7Sudwh20=;
 b=JAOkXtHvjDPwv2RoPbaV3GW9r2LDZrgjTP8TudhWxGpp3L+Xvp811ZZl7rMvTySFNswGesCGF47GTzHx3f0RbGRCKPqNiS7SSh1tT/mbnU8eoqmYAgAfEjZMxCt+U6okWrBnZLoJK9t+m00l0gB0shw1pHshp8Pa4D5o8joCAyZpsPdApByeh8m+op08nTsREd30Jz7K5tH6oG2FzglKIo71eyUK1bOLYUEF4ktgKcopO5Rvp/w5Po+LviKdEgP5H7sOH+eEHwpxXGn4weg/pNwOCJH6Kf+PvdqwCI3+EtjkD0H3hvOHDtUivwtTIUyz7M3lU8Cr+lpx3z4bda8EKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOBrutiNFrGDFbjZOTtdiUShAyqTAooE2HS7Sudwh20=;
 b=sJL3+epBbPMpCgiqnYR5bVcbXOy6aDoEWg/DWaLlahrn9fvkQmG77W5poCWpqBkWrexdXoY2D3Xzoc6Y9dQMOtYVMw9KkPnajh8vrntDsRKtfvkswrMgqif6LctRNIf/tWNT+wGBxVePhziukN2pRvVEINnv6cg8pcDoXexdtdE=
Received: from MWHPR15CA0046.namprd15.prod.outlook.com (2603:10b6:300:ad::32)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 20:03:12 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::cc) by MWHPR15CA0046.outlook.office365.com
 (2603:10b6:300:ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 20:03:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 20:03:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 26 Mar
 2020 15:03:03 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 15:03:02 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/4] drm/amdgpu: Add a UAPI flag for user to call mem_sync
Date: Thu, 26 Mar 2020 16:02:48 -0400
Message-ID: <1585252968-1218-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(428003)(46966005)(8936002)(7696005)(47076004)(5660300002)(54906003)(26005)(336012)(316002)(2616005)(186003)(44832011)(426003)(81166006)(2906002)(81156014)(4326008)(478600001)(356004)(8676002)(86362001)(6666004)(36756003)(70586007)(6916009)(70206006)(82740400003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4086; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52df8b6-ed5e-40a9-dbe8-08d7d1c0b650
X-MS-TrafficTypeDiagnostic: CH2PR12MB4086:
X-Microsoft-Antispam-PRVS: <CH2PR12MB408667ECAAB58CBC6E163177EACF0@CH2PR12MB4086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0354B4BED2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNCX6FhNjUdbIfpxfPFbHFBoy6YKiPXOnJRAK4iwrRjGv+JrWaObd6dpdkPfG1w748u8Jk//HnFSghqiqWp2ggCpMAq+1bJfc/Jf0swCcvc6yJHsb4PdO772RhZABFuRKbtLNGsREygPS4IaSxWVVO18P/XPEaDoDDYpOKT2vBxQkDsRx7qcpk267visLuUfox3S0U/rUgoM62OrswyrTxHnO1cYNwRS5YCJ6wG+38ANLt2QZWu1kNi9L0tXqlw4S6et03IkigpqXCL079uvP5hzwt9tDvnol2hV/RP16bPJt/CoPS+x0tnlmiCNEnYr80iBzpcanTgpi3cv0MkICa7hYceff/ZbN7HD0Jl2cqUBsJcjzoDJkpGwkxajLe45F+CC2L21c2WWnfMEgNtgCAC9n/9LxBB4hsoQrr7EAyl0GAFY2/oH9crQPFJeQAaOtxVa/KZo9Q3Pz/+erStzZPlWWzfHX9E1lj2DS3n98QZBCftG+BVNyZwDF8pwYCqfkcLO2DmobKJMZJGBJAszrQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 20:03:11.7173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52df8b6-ed5e-40a9-dbe8-08d7d1c0b650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 ckoenig.leichtzumerken@gmail.com, Marek.Olsak@amd.com, Ken.Qiao@amd.com,
 luben.tuikov@amd.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This flag used to avoid calling mem_sync without need.

v2:
Move new flag to drm_amdgpu_cs_chunk_ib.flags
Bump up UAPI version
Remove condition on job != null to emit mem_sync

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 3 +++
 include/uapi/drm/amdgpu_drm.h           | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 28bb840..f18d974 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -85,9 +85,10 @@
  * - 3.34.0 - Non-DC can flip correctly between buffers with different pitches
  * - 3.35.0 - Add drm_amdgpu_info_device::tcc_disabled_mask
  * - 3.36.0 - Allow reading more status registers on si/cik
+ * - 3.37.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	36
+#define KMS_DRIVER_MINOR	37
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bece01f..a8aa787 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -182,6 +182,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		dma_fence_put(tmp);
 	}
 
+	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
+		ring->funcs->emit_mem_sync(ring);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cfbec27..5f7a4f5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -601,6 +601,10 @@ union drm_amdgpu_cs {
  */
 #define AMDGPU_IB_FLAGS_SECURE  (1 << 5)
 
+/* Tell KMD to flush and invalidate caches
+ */
+#define AMDGPU_IB_FLAG_EMIT_MEM_SYNC  (1 << 6)
+
 struct drm_amdgpu_cs_chunk_ib {
 	__u32 _pad;
 	/** AMDGPU_IB_FLAG_* */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
