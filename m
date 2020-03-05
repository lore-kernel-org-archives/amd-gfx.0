Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC1C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424EF20848
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="buWBMrDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424EF20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9139B6E32B;
	Thu,  5 Mar 2020 13:33:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD506E32F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci/TmqcsNV4WSSj8tkeBWCSVftszmYkmzOuJ+S2glDoTvPivxlM0m/byNMy1ukWu4DiT60dyfVFMZinYdboaWGnmIxHziWpYrgwwT1tYjrh/6RpV3iFhiecR8aYpxJzXE/kS1Sa5U9EiydRBdmYkkjeLSddrDUTHlfUNBnnMKciBJmfqD6GLZxjvH8CXHENl/GRrYDxALwDNxvoVIo5+Ken775Qt86AkN9SrMEdD5J5ZPshnaFc9tOCIZFTsO0EwCvDVyMY1y7F1hOQDJXGLEHnxHjrMAwiU/7OIXFMQr5FAX3cscUwS8y5v3oX4yCxFpk8DZUqSiUNcwy7mpWvfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAB88+gZoxejbaTuZft++lx/tzroo8mlH1gFzlq6w4Y=;
 b=aLY1cyQAaO19CsqgFtrV7ph/jnsickv2gIx2KMAabDsivQkQWJIEsNfJkIcXtZbJ0ubaxz7fZHpkSqZYmax3II7cz6f883FXVAd1DaowVGdvcEnNrvdDE3XHE4jDCl3bCiqGZ/NcAiroiJSp7FHWmGRH845muAxCRJYtjOJFngP2/vLne9OXJNHjpKCuVlEdW2YwDRzeRbn2Sh1ZfE3mVLVNovRG33VzkVQbWacdBupKX0dy7Bw2ApVacz2AWxBqeVwhH0U1CJZWt4kGT7EoOQ80IWsE2/AfNPywoj7KGT11Sq14rXMAu9bucTKlw3O1Bdu3s5Vr4aq0LCNyGzX8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAB88+gZoxejbaTuZft++lx/tzroo8mlH1gFzlq6w4Y=;
 b=buWBMrDvDfZFNh/jkpDFAYvglSnh1y+sOBLsHLe1W+RERQD737ST03YSv+Nec/3Hnsd1Pqzd8RRolxCQfuh7WnJNu2+PcAjX9/u4+Kig/ga2VpKvJbsgLjTtvNWbN5YXhCLACRRulBeV2zqPN6cyQrpr+VDGiJA7wtM3wDR9AFQ=
Received: from BN6PR16CA0011.namprd16.prod.outlook.com (2603:10b6:404:f5::21)
 by MWHPR12MB1293.namprd12.prod.outlook.com (2603:10b6:300:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Thu, 5 Mar
 2020 13:33:28 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::7c) by BN6PR16CA0011.outlook.office365.com
 (2603:10b6:404:f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 13:33:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 13:33:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:26 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:26 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Mar 2020 07:33:25 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on
 unused var
Date: Thu, 5 Mar 2020 21:33:07 +0800
Message-ID: <1583415187-16594-6-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(428003)(199004)(189003)(478600001)(86362001)(2906002)(8676002)(7696005)(5660300002)(81166006)(4744005)(81156014)(2616005)(6916009)(4326008)(36756003)(426003)(26005)(336012)(8936002)(316002)(70206006)(6666004)(70586007)(186003)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1293; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51caacc0-7dfa-4e44-8389-08d7c109ca02
X-MS-TrafficTypeDiagnostic: MWHPR12MB1293:
X-Microsoft-Antispam-PRVS: <MWHPR12MB129381892DE0078BED920F1B84E20@MWHPR12MB1293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:25;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHf7s+ibWPGi6vGULlZe5rVCzsiJIUceiX5TR2+eHIi+yelFQytdxHVKGQDlLz1HY+FgcMR46by4ZLtjtLftoHEwnuxPbvAcuJI8h/s+vg5fFL2f+Fc4D9aXQC0iYJdjBoTGQH4KlubvLU4ZIpqdbb3/xYknSfdeb18dJXZp71gtxQzr1kDijuhveijPH3uEkwnLiRVfIk2+8mbipaCm+VNeeCKU5Cu+OsqhfwHxh5I2ALS2JUDLV2ZPltxQK+NDi5Chx2yOmG1Kwd751turAUolsAdOH8QCvFEOEoQNrD0whT2uo8Y1Vq5Lzkd8kph9eaSjynPh8PQOCeUGKRJAR+8rtzcW0CIuUqYifo+z/fiDXhMM1Ptdwx5ZJcxhiO08XWxNkudciMpOUf/+o/VnHjXP9llqxKycsxiyucYpedWVNKt0jMqf+4AB4Wy8fhAU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 13:33:28.3803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51caacc0-7dfa-4e44-8389-08d7c109ca02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1293
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index ae9754f..a41272f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -493,7 +493,6 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
-	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
 	long r;
 
@@ -655,7 +654,6 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
-	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence = NULL;
 	struct amdgpu_bo *bo = NULL;
 	long r;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
