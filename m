Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E96DC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C3120774
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WpEWFgeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C3120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82E06E0F2;
	Wed,  8 Jul 2020 05:24:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90D56E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 05:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3Q6I9RfiW0doCnp1uQRCJ3j4zntj+7TrbzeLI7FDIQDgKeJoa4VF8Ll+E/u8G85/b5nCzNhr7Y17Ayq2rEK0sJy77W8Uj4KmB00AoGWbAGBbo+vJh18lGFicT+UzP9VwIPk4jSGU1/9bDcLZ9BOvJHqPymORfBXOyiXrgFnaPl8IhpTz2aVoii8hWqmWqyx+KVdNwy/CLaMEVe7+hJ1vjRVAfbM90CX5eITpVXftmBn+3Di+YnO2XV/wtHeVy+C+087lDGxTuJkNG/SYaBrjXQAdYp6kYXgmp2UHq4gnd1SoF0cMIoTk2m56cU5MtZjVKHIEVnQD+/RrIIbfvS75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p5RluIfm6nSM0tDNKtD8x9oplXyZ1p9tM353lo5ZRE=;
 b=B1awXFon+4C2wPjVU7S1EaaPTSTQv2EoDBaOCuzvj1ararxEY7gegpSXXp53hYCV3A9+WrPO+bqXn2iJrkJZFAzHq1Od24Svvyl5vhQwm+mm3ON7PCmNLkOK5sFJNYFfMcQaZbx1AzBroj1TejtPwfUboyaTdgDTwW++M6r+n1oCAUwQopUzMYomZE3QeXqG3zZFKJYkLFjiwtW2zee6uBPIgr/ZRMrAfogy7JKvdKg7U0Jp/0SL70NhtmPJegY/eXZdYpk85kNoisfuhtm8chafaBPgJxAC8Kmef8jCVytPJnuJwtVjjiorFferYWvX+N5hBydAr5rac8PMD8qC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p5RluIfm6nSM0tDNKtD8x9oplXyZ1p9tM353lo5ZRE=;
 b=WpEWFgeBWj5qozyVar2+Pgu1Pw8qNFX9C7VCPJT1rJl3H+zM4srnTP+SQbyPosPpOY71vAdTHR86YPcJ2YNRRqqFTg2EIe2Nd7GRYEap3rQEXIpehXoGfRcRigLELk4o73XklZxuVnL2cmNbMbFnKiwVbNrCAVf//Hkt0G1KnpQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1843.namprd12.prod.outlook.com (2603:10b6:404:101::21)
 by BN8PR12MB3379.namprd12.prod.outlook.com (2603:10b6:408:42::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 05:24:17 +0000
Received: from BN6PR12MB1843.namprd12.prod.outlook.com
 ([fe80::4572:70c:85c9:c8a3]) by BN6PR12MB1843.namprd12.prod.outlook.com
 ([fe80::4572:70c:85c9:c8a3%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 05:24:17 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove unnecessary logic of ASIC check
Date: Wed,  8 Jul 2020 13:23:54 +0800
Message-Id: <20200708052354.3007296-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To BN6PR12MB1843.namprd12.prod.outlook.com
 (2603:10b6:404:101::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 05:24:14 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6b5c1be-995c-4eea-bb3e-08d822ff2837
X-MS-TrafficTypeDiagnostic: BN8PR12MB3379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB337988D87E489C64C608385FEF670@BN8PR12MB3379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FEkbC4Dv5E2Znx2/l+xEJU1GBbHvMJ/X8chO+UdXztnuYIqn4zuDhJ/E9d8y6bDhVt84ne9ytTWtjNzDyCCgEOP4A2WusdEP3yXOtaJkopwp27tkwIPrAEKx2D3+8kFOOxGGqxaWtnCjY4ACZABq29w7cpLbGb9ZobZEBh1w11EWTK8xBySWdjuyefw792SgShkXLoU0NyLvoWcFyNwOn5FbJg5+xRDF0PJKitiutsOIRjjgyclfkbqLkNMqfaBb20eF3t0XoNLdzsze7WJY25WyRccsKcEM5HFMAWtChcyqTIwkdiURPsmGjikN4fJqsDmfvo9uAo9S7H6FGc7gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1843.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(956004)(478600001)(8676002)(8936002)(26005)(4326008)(316002)(7696005)(52116002)(54906003)(86362001)(6916009)(36756003)(16526019)(186003)(6486002)(83380400001)(1076003)(44832011)(2906002)(2616005)(66946007)(5660300002)(66556008)(66476007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HC05ZRnP9obKHn9/LrvVhh+ykNk6aeowwLfkpSi9cgTmTAOOXZH84UN57zLcjLv3LCLu1H+k+TQVuLGYEMpxCA26IWgIp3sBM5ShifdyIXchNT+Jh2DYooT0YqaU1d9+4yVioa0AZvcJz2ifoTdJcb3pwQczgyRsv9mUozLocZHCTQqj/qPklIiWpISRdOjVfkzK1laGKsV/EH8aVCnGfgqUieQJGYC+TiVzoIzP9jSSfkjF/OzXL728wVNhxlST+rdiI4cwdJa/VojZWo1WCXLXdNlgCnZP3wjPt1ql/SfqVLCCqchJv2eEEJBO7N3eap/ufPdhiIggThCf5/T/JIiguJ9WldscRkiPJ8vNfSIOiuMKkn/IgofbgxQj/2Cav2IAVwUcLXQIrHKwTzH2SYGoaEgtjaFFihJFNRHupiqgiybVVynINfIHYCDkZ0dpISc0rD/od7Wu+iZkSMuFTMfOfutG2Hq60gowI2CHe24aPX2oIfhSzKi5fQDSic6P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b5c1be-995c-4eea-bb3e-08d822ff2837
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 05:24:16.9446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzXE6xyiSeNAQwK46ejT6KCj4W9KQzRegVtC4Q7GEoIG7l9kZWBMniuPNewgVGCl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3379
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Remove some unused ASIC check logic.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ief8bcb77392294b180473754e669b9e460a04826
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 +--
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b8b4cff20013..58221bea377a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7687,10 +7687,6 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if (adev->pdev->device == 0x50)
-		int_sel = false;
-
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1baeddf2f1e6..203a0e9c5999 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -508,8 +508,7 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
@@ -887,10 +886,6 @@ static int sdma_v5_0_start(struct amdgpu_device *adev)
 		r = sdma_v5_0_load_microcode(adev);
 		if (r)
 			return r;
-
-		/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
-		if (amdgpu_emu_mode == 1 && adev->pdev->device == 0x4d)
-			msleep(1000);
 	}
 
 	/* unhalt the MEs */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4dbc11907bc6..8142fc07f5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -440,8 +440,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
