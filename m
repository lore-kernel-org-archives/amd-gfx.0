Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB5C34022
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 02:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C246F20801
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 02:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BBxNBx9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C246F20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6DD6E11F;
	Tue, 18 Feb 2020 02:54:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5231A6E11F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 02:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBoewYaMf5Ex+ti8ifCBzzgcfWKrKNKlmh4bpt1Iow4GubR5lsJJjclAG4gCM4dYRZwdkQ+kCANtOgOlPpD9a79vbr5hlUU2jcDwZHcFtMytz32jjIv8Kt/nuEk/oqSnUZ+ayLER0N9eXFQz3/Tu6jLBlONcTIJ1RPSboWsJpl3ZWjWPdbxOSl2IucZyysssZ7L+pk1Rqj2rUpIhm/rGl28ODjnnwTJJku8TbuK1EVfqc1qMiLcgK1moYyaEku32U1lZnIZY8Xe/jxzYYNi/XkFXY+EFzxH6rWaMTXbNDMutNY6Rj3+rFqM3A2shdbZZtGfExRfaZhpScR1SCosl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x321OKry/+SDrWoO31MY5PhApNLC5pbrxyKELFof1BY=;
 b=c/BObwlycSrckX8hHBV4u9Jfn3zZJgmudusUNyL7C7dXRK/z2EUa/I2z9dZGK7eEu0GVHVZZ3JiIGM3zDXpjMrqsz9W+Gw0Y9FYR7KKVHT08FglQvyGNMJr9cQijDbMYgOzno2nOOUxcdpkZt9YNxwNghFREh0HMZrXBYEypKz1uPLoPnR11kMYHU7F838oxrcviwtM80ylYQndcutf/iEzjdZt8vD/M/bNHZ6dhYae8krFUR2yC0E2kYe2G5h55hf3bIo/wW4JU/BF8elsP1QylK+fJuvS47SzfJKLVYY/GCA4X8Jodr2XWK5xrb0jqmpWrTibgWXMJggttr3JvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x321OKry/+SDrWoO31MY5PhApNLC5pbrxyKELFof1BY=;
 b=BBxNBx9cqPosE12ZRyaLNUv8UuUDh2VEb82kTLgdxJm9ERo6VjOBQiPNQAZU/C3ebIrPd4PcjJtS1L2rSVsvkNvx0kZ1FPhi6UBRume1rhUN/WOH4ZWKU5cvJBF7g7fytE3BUuG0s13jsLgt+bPlBMaPTD+F/kBgdj06SwYn8bE=
Received: from CY4PR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:910:16::25) by CY4PR1201MB0120.namprd12.prod.outlook.com
 (2603:10b6:910:1c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Tue, 18 Feb
 2020 02:54:21 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by CY4PR1201CA0015.outlook.office365.com
 (2603:10b6:910:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Tue, 18 Feb 2020 02:54:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 02:54:21 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 17 Feb
 2020 20:54:20 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 17 Feb 2020 20:54:19 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: fix colliding of preemption
Date: Tue, 18 Feb 2020 10:54:13 +0800
Message-ID: <1581994453-5498-3-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
References: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(428003)(199004)(189003)(8676002)(8936002)(356004)(6666004)(70206006)(4326008)(26005)(81156014)(2616005)(316002)(5660300002)(426003)(336012)(70586007)(81166006)(186003)(36756003)(7696005)(2906002)(478600001)(86362001)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0120; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb1dd42b-7309-4a53-bab3-08d7b41ddac5
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0120D87EDE06ACC962EB69B284110@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 031763BCAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6njoddXsMfy06I/bvvRtwUTFCbiQGR+f9pCYAX+c4qipvUrMJ64rbaA7CRxFcmtH8AIwb4HLcKujyjFKvE00ejbOP2yasaGdxe/N3P/DxQ1YrxWLOBQAXrIYTJsxtxZFf/dpUUmofF5OSc2mr0pGNle2rhYVstB+UVWk0IT1LPsYf6SOTspT2HB69w9/WvoYrZMqWIQfYwg0f6vcgiYlMbLmmifrZCcneVF09wqBFWEuY0JfgHtz1K/pOcqHNovIOq4HymgK6HiF1MIoufCsNN6/Dn+DmO3Eyn8bHHgPrYUpC40xVMkFaRuSkeVdy28D/Z49afGRajVCDsyS/SDyO0+rCXCf37W2OekWV8M0KSDaKDOhSkGwL9Ta09OD79sBecrMjAazFazSmC4xCicBghKTDLXGfrfgD1icW/ZIus2EiPu7J96GEQmV9orlpGe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 02:54:21.2090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1dd42b-7309-4a53-bab3-08d7b41ddac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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

what:
some os preemption path is messed up with world switch preemption

fix:
cleanup those logics so os preemption not mixed with world switch

this patch is a general fix for issues comes from SRIOV MCBP, but
there is still UMD side issues not resovlved yet, so this patch
cannot fix all world switch bug.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index a2ee30b..7854c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -70,7 +70,8 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 	uint32_t index = 0;
 	int r;
 
-	if (vmid == 0 || !amdgpu_mcbp)
+	/* don't enable OS preemption on SDMA under SRIOV */
+	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
 		return 0;
 
 	r = amdgpu_sdma_get_index_from_ring(ring, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5e9fb09..7b61583 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4413,7 +4413,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
@@ -4421,7 +4421,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 		if (!(ib->flags & AMDGPU_IB_FLAG_CE))
 			gfx_v10_0_ring_emit_de_meta(ring,
-				    flags & AMDGPU_IB_PREEMPTED ? true : false);
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 	}
 
 	amdgpu_ring_write(ring, header);
@@ -4569,9 +4569,9 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_mcbp)
+	if (amdgpu_mcbp || amdgpu_sriov_vf(ring->adev))
 		gfx_v10_0_ring_emit_ce_meta(ring,
-				    flags & AMDGPU_IB_PREEMPTED ? true : false);
+				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 
 	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
