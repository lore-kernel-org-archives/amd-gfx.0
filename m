Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA28C4332B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9AE20786
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 10:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EPCt/Nwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9AE20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF3489133;
	Tue, 24 Mar 2020 10:59:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A05489133
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 10:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHRY3SiVMvcvvBzqRtLnijIdhFM2yKLvlyMG1UFTJ1v021SXXHExU9i8jmtv8dV3TULnJgrSujrs6chEVZudaaoQhCGamEVTBu62kykLRkuvnFwSEIqQl3iFHcY3uyYp9jfGX7UBohSfsHlftYL35Ytom6lS3Klc35U8Ob/AKHYdnJk0dlEw+LIfUizLr2mNNdQpsqCKqRhodHQIQHTadB9WkZfW3rdN5KWWACZI2+Gi+jmj6+BAGKzqSHw+dI1kb6zCwK7r/Ei0LplUIWA5qnyThJRQ2c0cL2iukHsAq7QdSxzGiKTRtBiPJZQdL6mfcH8jV5PZl+izQ77dCTyN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFkSNbMX23JZrSSFJBV/3kQWzp6QxUZ7lMN1F5dCc4Y=;
 b=Lq+v6QhiSJElSKk1L1SdUko3lgdxXFitME3KyYrr8csKpBGLoHVEU5xOGrpm+Peb61pQDIZ6jt5qwK70fdz/013hGOlxqkkR80slFM9I624C6BDLWJrYo8YaNqPBKliiqUT8TKaXpAV8vkcsobLrRGo8zas7kLE8QMXOBIRdEjM+7oP0F6SO4G9QAxE+zTDhn/p9QpZfndrHWtC7FwhbIDHJoiOQgwY9d5gDEmqRke6l0QKHAOk8tr9UpATNURq7JDeZDymL9J9RigZ3I/OLa9i/TmcImTZ+LlgP4O7b/x19l0871RG9kqlkPYlu7aTLsZv0H4pebu/Rivr/tJYKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFkSNbMX23JZrSSFJBV/3kQWzp6QxUZ7lMN1F5dCc4Y=;
 b=EPCt/Nwy8/B7Oahkkl3AATJBaz8nNlL2ymsbmm5hhiM7d3R/9vYkXRnR8wMMWzKTUrkGmIcxunzF5IUON2EYmu3D/AWL7P29VPxq378BgVPQ/YFUPiupt+0yc+tV1QgbyAYOHmtifybEJCtVdXhhv6ryZxc2F+LHOrHl7FQ7ybo=
Received: from MWHPR11CA0043.namprd11.prod.outlook.com (2603:10b6:300:115::29)
 by DM6PR12MB3564.namprd12.prod.outlook.com (2603:10b6:5:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 10:58:59 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::f8) by MWHPR11CA0043.outlook.office365.com
 (2603:10b6:300:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Tue, 24 Mar 2020 10:58:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Tue, 24 Mar 2020 10:58:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 05:58:57 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 05:58:57 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 05:58:56 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: purge ip_discovery headers
Date: Tue, 24 Mar 2020 18:58:51 +0800
Message-ID: <1585047533-10966-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
References: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(428003)(46966005)(5660300002)(7696005)(2906002)(26005)(316002)(4744005)(36756003)(81166006)(2616005)(478600001)(8676002)(81156014)(6916009)(6666004)(8936002)(356004)(70206006)(426003)(4326008)(47076004)(186003)(86362001)(336012)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3564; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78cf162-ede4-424b-0489-08d7cfe25a85
X-MS-TrafficTypeDiagnostic: DM6PR12MB3564:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35645A08984F3855DB583F2984F10@DM6PR12MB3564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 03524FBD26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8l0F71xIPQqX0FBmBy3bm9iqAFI9uyNRUq7VfLayQ4VLt2rupvij1+h5XyJ2c8cAl6r/5rs7sdo1t5qpWTQgjRnzVWMSRi7VT+0WeIXCP/4niBtvpzNlB0B/3KNM54Si5AvJcVtTBaaEQsqOgblCM8fevQ9VHoZLG3AyFOV2IFy6tKsfNSctLw/Z0Uz3kn8wbcDaOXDDYX+h/ROoD4PY5Rvv1W8TRWBZx+Afsvx/1cEhaieF9aaOtr3GjlAGhsa9sInqJ677L9M5wKhTzKpFTT2NVsmhUGlC7R0Ae948EilnbgROKZyV0FIx6MJCr2TZ+PJxi52BiBqpZY6WwKoZNFGV1iiyoSUPpfaJgLxGqnr9WOHLOA6ZHkbyKM4a6Xm5hCPM/7juD+1+nF3+aCRAM79kasMIbi9ORbymwAWTCJpTFzsDZlJesCnZdQAsCBhtiSVPoA9Yqh7Wa7XyB9/t5NCQOCq5iJ1R3vuGx5yE8sfuv4atwQ61LZl5usokDH9qKKklHuZHOOiMKxwx5leaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 10:58:58.2840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78cf162-ede4-424b-0489-08d7cfe25a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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

those two headers are not needed for ip discovery

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 27d8ae1..37e1fcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -23,9 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_discovery.h"
-#include "soc15_common.h"
 #include "soc15_hw_ip.h"
-#include "nbio/nbio_2_3_offset.h"
 #include "discovery.h"
 
 #define mmRCC_CONFIG_MEMSIZE	0xde3
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
