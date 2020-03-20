Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2492AC4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 09:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF8E20722
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 09:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q4hcW7YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF8E20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CF06EAFB;
	Fri, 20 Mar 2020 09:46:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F8D6EAFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 09:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWlWg9AmhSopWLmk+6ZDRQvklWjX2QOj1BxypUfXTmbEQXfVye9ldEZF0h484PZ7iHj2c6tYPscHmJLj1DM8Rru4+x8MglnLciizHN24XLnQpqq/TzD/d/8a3uTszuOGSPnA24VRfi/y01Z9IonaKNQzrcANtqnVYrzguMnYiYto/GLa2HAn615muE3TyCFuNz/t3/Hoxr1JIBYNaFS1L9g1f1SAVnq50/beMf1bHlNmQVRxmivAT74ea7gKIuITvxPX5lvYNvZBXKGU5YXPceT/urLmnv8y2y5l+w0plx70zu56lL4d5TicXJZiQVGIECcQ406QbiZ7g6uVnMMHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Minvd/ErT3JQnaBcrXTeGpJbN1QxcDSAAEzyXOHtYg=;
 b=mDt7x2xS6LE2WfEIBeFvrxefU6c4RZlsJtpxb4rO3Cr3PcOO2PhXK707NPL6wLkv9zlrxpcUsyv7Jo6l0hnkK4b7Uf94911uUWTE79DU1KHxUcqjuDG0SL5dme5zXn5JKglVUvh25OSF2AG1eM/IBfkqHg81N7JozfAbivY2WCd5KgajANg+WPZiVvkWsHjGC+GPH6jWSmefzIUS5jMDmwjVDzh1CUCE/2c0pr5ErZ2kV96nhkz19eNpxd+2MwampfjxzUDyCUSjTm+C8qGEoqZf1ENMzMn4eaNSIQz6OFSCFy5RukkjsTxtTmkpHnNHPkKYonYXF32w+2nk54PiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Minvd/ErT3JQnaBcrXTeGpJbN1QxcDSAAEzyXOHtYg=;
 b=q4hcW7YHgUuMF+MWqT5GruAKLA2k/3dcnFZNoayje/lUwq/9Iwvgvh1Aolm2GiIGImOMwCvlm0PhERNLPTGHWhV70dhno8wO5mBb9cCiNCd/0IoZY/xyXY7CRIYdn/v/CfE6wccbymZQdKMfaWMbirK73i74UTjAsRpQwb+GqAE=
Received: from MWHPR1601CA0021.namprd16.prod.outlook.com
 (2603:10b6:300:da::31) by MN2PR12MB3760.namprd12.prod.outlook.com
 (2603:10b6:208:158::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 09:46:36 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::de) by MWHPR1601CA0021.outlook.office365.com
 (2603:10b6:300:da::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Fri, 20 Mar 2020 09:46:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Fri, 20 Mar 2020 09:46:35 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 20 Mar
 2020 04:46:20 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 20 Mar 2020 04:46:18 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix size validation failure in large buffer
 creation
Date: Fri, 20 Mar 2020 17:46:15 +0800
Message-ID: <20200320094615.5524-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(428003)(199004)(46966005)(54906003)(478600001)(8936002)(8676002)(7696005)(336012)(4326008)(186003)(44832011)(426003)(26005)(81166006)(2616005)(81156014)(36756003)(1076003)(316002)(2906002)(86362001)(6666004)(356004)(70206006)(70586007)(47076004)(5660300002)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3760; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c75b79-0b88-44cb-5133-08d7ccb39477
X-MS-TrafficTypeDiagnostic: MN2PR12MB3760:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3760A72E3B2D2100A5D6F91895F50@MN2PR12MB3760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03484C0ABF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZBQ68BUQbNSgG9TIPDP0Kjt/Qb8OMrjS2wtBlpF0qDrjwRwpe/3bndRBWxrJIx9H5NFvNYkKNgzyRku1z7C683iljKXy70nteIoduMlsf9jdfDm1HZBLvuERX2Mmb4dcCbk4P9QB+SLV+PGeHypS7d6wrbclfrCATzDuRZ11B/PsrHTDfLLfCZRTTOn+xLoddMHolYinE3Spu7y4Z/el/6fKCfwA7wLNbwyxSa4qdczXyalmb0Rubn0Mn3K2lpJTUyULEFfV6lDo3UAPmKrTCTsS86oQoMSnIjPW89lMyAJJiQGkWOkQ22eX1FcIisI5Zq31275EJ6sAHrtOOYNoVaQWKkruBW1zEe1CpM8HMwzOndujMKODbyc0TzhNJyipMQ7oT1ZSrHQd+PuwznYz9MzhoPiHWe5UbEBECoCaAvctGfMRrgWa6wdU9YOGVaizIbddI3QRvtucYtym+Mld2oQhvzWokI9OELlAgprZ80qJytj80rNGOcv+muentKcdFhjsNYNmvL2h+DorDXQZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 09:46:35.6695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c75b79-0b88-44cb-5133-08d7ccb39477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3760
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Pauline Li <pauline.li@amd.com>,
 Long Gang <Gang.Long@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
When GTT domain size is smaller than VRAM, if APP apply a very large
buffer whose size is larger than GTT but smaller than VRAM, the size
validation will fail.

[how]
Validate VRAM domain size at first place, then GTT domain.

Change-Id: Ic1d31b9b0a4939e6bba0241ff79ae9aa2225ee05
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 84745f9e7408..bab134b6369f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -464,21 +464,21 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 {
 	struct ttm_mem_type_manager *man = NULL;
 
-	/*
-	 * If GTT is part of requested domains the check must succeed to
-	 * allow fall back to GTT
-	 */
-	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
-		man = &adev->mman.bdev.man[TTM_PL_TT];
+	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
+		man = &adev->mman.bdev.man[TTM_PL_VRAM];
 
 		if (size < (man->size << PAGE_SHIFT))
 			return true;
-		else
+		else if (!(domain & AMDGPU_GEM_DOMAIN_GTT))
 			goto fail;
 	}
 
-	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
-		man = &adev->mman.bdev.man[TTM_PL_VRAM];
+	/*
+	 * If GTT is part of requested domains the check must succeed to
+	 * allow fall back to GTT
+	 */
+	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
+		man = &adev->mman.bdev.man[TTM_PL_TT];
 
 		if (size < (man->size << PAGE_SHIFT))
 			return true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
