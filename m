Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A918C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 00:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592276101C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 00:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592276101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C256E0D2;
	Tue,  1 Jun 2021 00:06:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E2D6E0D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 00:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCOWDBgu8Zq0heAkXNB8UjU8DisOmHt17JeMkr153DcVwoSDCtGr4b1r2acyygZ3LtQ89y6bOsM5i/Cutz/fTOMcRREAQAcdBMc/Tn2Bns2QtVSFXifB5txkRIxMGJo4jtuiiXFlkJ4iVYF7/QKfxJgRVZnJPI421WvyoU8+VLgUn/SYWehVRjiT5lJEjwTAY9B8lBFbsWXmGQ90+tefHjwXnBtmbTpz7r9fEXZs5R4XTQWluomci40rCL3mLgexvOOnlduDrgwPrYCArvTym2blnUmg3j7B01GR7C1v65aod8TkwA+rgEpJuRuAXjkO5VwdhFqnIjeFaHTxClFctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t4bRT9STTDRZxveX4oIPNM/a5JX55dxGmIK6NG5DFk=;
 b=Ahh/C0EWsLCP6giMmV2Vqr0ZyjJb8FpnxvQFN75Nurn+9buU5EwI/1w0rlpCee9lvtlOOJXNW9PKYoGkLOGurhpRj5SidIctnmfm9rg+g+qkccZqg9DHOqn7dWBRvSXCZPceFJB9vv/G2b/EFSCO6R67Rlnq29gtF9epcDSBloKICka3Gh2rHHoxqL5mgCceXkwlS3FTVLjYzt8bPKNqFgz3ZFpsEtdaiNotCsOZNe5Q3IehxNnJ5VRtNPR3S3cVNJVlb2Z8hrgL56DDUdb2j08bJXhIt1CSA6gBPVTmd+LjOgJzJ+/nh9lSdSYeleBhdRUICY5GtS3Gexlpd/8N+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t4bRT9STTDRZxveX4oIPNM/a5JX55dxGmIK6NG5DFk=;
 b=vKukPEQgj335P9/wsid8YR+O+Adi6V5trX642BMnSpqhYOdN2cJ9tcS+L3GMXey3cOM94vkzPkQ7nvj3yg9ygc0ieSAzGGFYOPhWiAFuJECUb2nyXcD6zwBiZ0qL0MwdM2DsA4/F24prbnu45ZujwwARcXfrjl+9UyFKI0whQWc=
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by BN8PR12MB3634.namprd12.prod.outlook.com (2603:10b6:408:47::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 00:06:40 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::75) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 00:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 00:06:39 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 31 May 2021 19:06:39 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: Don't flush HDP on A+A
Date: Mon, 31 May 2021 20:06:25 -0400
Message-ID: <20210601000625.551445-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601000625.551445-1-jinhuieric.huang@amd.com>
References: <20210601000625.551445-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd8b0df1-99be-4438-4805-08d92491217a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3634:
X-Microsoft-Antispam-PRVS: <BN8PR12MB36341DF9CE1AA0C0A5873A87823E9@BN8PR12MB3634.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79V3JnVn4nE6j3RFzTmFeaw5bBDzJCr8VkNwpqEccpd6MDCv1z4Q4vp4PeibbqDtoh4Q8QYE2meVBzH6Wqt6uKXxXOlKojt2WusWita+25rQ2V1h6jzWhz2gqJgh6be72gxQ9FxbJPz2lU9X28Rj7u1N07VJ0lsrybGeJXnbiSzJdEuIMsxpT+FEDY4cTH4JJFuDbyn3ozCvWAsBRZJL2R+p3VtXgs4/DdL80GNFx1Vy20lCSp5WaolSjs0C+5AS3YhSN2Ft+Mjsq3G4uAGwljF1P5g2kkyDb4R49ktQKbMe0Me++vIDODpmJ6vqApBPtprXzLdba849wLDvhufkPQr2m1ApPJKS207Azb2e43RSgpZX6RXGIH4epYORntzMMp05U49MFgZvFUUolVKJEcfaLusYZLtVA2SbluMfUbYoZkv7ivHFjec5CeUnWesgJBno9vGSYsR0S+h+67SsY604fA9mqt/7LZ6DZkxwcq4C4MG5BG0OCRN5JxLPAfDU/LQxWWyz4e6AlegX+sXhRVb3WAha9tqONPPGnrviod/jEe9sCLhjuOmMRHflGyRvrRruV8qedFCj8LGy6Hwsq4GV4+RqhzrAJded2NQVcE441ZzXk4dBeOsLjn6HUS9KZK9E6ZPrMRKtVGDxnLCuJDE/ucZze16+3bFGdOnXEK4LR2+AO63yAcsRbraa0eKc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(36860700001)(4326008)(6666004)(83380400001)(82310400003)(426003)(7696005)(316002)(8936002)(8676002)(82740400003)(2906002)(36756003)(81166007)(6916009)(356005)(5660300002)(70206006)(70586007)(186003)(16526019)(86362001)(1076003)(336012)(26005)(47076005)(478600001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 00:06:39.9726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8b0df1-99be-4438-4805-08d92491217a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3634
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With XGMI connection flushing HDP on PCIe is unnecessary,
it is also to optimize memory allocation latency.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7ec99d591584..1ca23f2f51d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,6 +44,7 @@ struct amdgpu_hdp {
 	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
 	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
+	bool	no_flush;
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index aaa2574ce9bc..f31eae2931f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -226,7 +226,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (!(adev->flags & AMD_IS_APU))
 #endif
 	{
-		if (ring->funcs->emit_hdp_flush)
+		if (ring->funcs->emit_hdp_flush &&
+			!adev->hdp.no_flush)
 			amdgpu_ring_emit_hdp_flush(ring);
 		else
 			amdgpu_asic_flush_hdp(adev, ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2749621d5f63..6e1eab615914 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1223,6 +1223,7 @@ static int gmc_v9_0_early_init(void *handle)
 		adev->gmc.xgmi.supported = true;
 		adev->gmc.xgmi.connected_to_cpu =
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
+		adev->hdp.no_flush = adev->gmc.xgmi.connected_to_cpu;
 	}
 
 	gmc_v9_0_set_gmc_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 74b90cc2bf48..e1b2face8656 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -40,6 +40,9 @@
 static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
+	if (adev->hdp.no_flush)
+		return;
+
 	if (!ring || !ring->funcs->emit_wreg)
 		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
