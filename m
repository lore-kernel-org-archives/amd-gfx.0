Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E69C3F2D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 06:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BA92468E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 06:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MP9rXMvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BA92468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1E46EDF7;
	Fri, 28 Feb 2020 06:31:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4B46EDF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 06:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdSMF+Cjq7ZiQHBwEIlPeVA71OV/biiqQlyqFXtb/5OdeRfmi7p9OoSCBCfFAZy/KnZjDAciI0hF8n2E5ma6/ESUw4woFGfPicASpDJRop9SpYYP0yZF6v8NyJZ+mPu3xRNNCM28Qp0a+Jmk7aqJF2Npc9xHLKVrPExMoG1mE/ztXsb3kRcvA+RIn2wFnYzFhtoScDSnEf2/PnmmTDGuaQ/6hC1t7U2nqfG+U5Mpw9qR6/vcPpC5l2y4GGtGyu40g0k5BvG3kl1RH/scE+P22Vb9laXCHT57l+TIrMShjyAr4YxeiAsL8MGgR2lLjEjE/mdsRexCbZNz9mWS6gsoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfq7z+z1CYDcILhun77GHBvUgOUFKIpURWR1amOvcVs=;
 b=SLnbP8gF1be4i6W0VVwrY40l1jHtrcEsXUem6cmnk7QIxDnLUV6XQ2FuLLvD0DwnwQIbLFxZ1elKyqj3t4VM05W1+APvUsCxDsPbCn6jSrRn+cBrr1hm+kqRj15Hkd/jQu1I6x7v0p3cyqZwhZNGhcZ1sSLZkFUBtYnSvyKcnpU+ZxErjb/QJgl276EzCa/9mtg3T9mUU2iuzXQGKndT/WYVDjecCtY9V322Xgk/HWEtm5NqgEunvPwdSP5ZLW2Yx3A4aKNGgSbrkcihL/ljJuRNIdlFDWiCdEuzklT3G6Ibiho4v7lO9klTsYixE++rwW5UzkYdr7l1uppLpt82bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfq7z+z1CYDcILhun77GHBvUgOUFKIpURWR1amOvcVs=;
 b=MP9rXMvD3AQ7rVTm49yBPzFDomBJ5n0jv6+pAocD4JqVUCc1RhjdqHu3RoZZyg1UNC/NgJvJjs6qPRCxMy+LSeZ+WVFXqvYTjKF4636DEgDJ5BcIih3tCGoSuEepQ90IRDR0fxIljqtM971wliSxgoek1rzRZILmm5SxCR62MmA=
Received: from MWHPR22CA0021.namprd22.prod.outlook.com (2603:10b6:300:ef::31)
 by BN8PR12MB3444.namprd12.prod.outlook.com (2603:10b6:408:47::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 06:31:37 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::22) by MWHPR22CA0021.outlook.office365.com
 (2603:10b6:300:ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Fri, 28 Feb 2020 06:31:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 06:31:36 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 00:31:34 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 28 Feb 2020 00:31:33 -0600
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: clean wptr on wb when gpu recovery
Date: Fri, 28 Feb 2020 14:31:31 +0800
Message-ID: <20200228063131.2630-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(428003)(199004)(189003)(8936002)(36756003)(110136005)(5660300002)(8676002)(54906003)(81156014)(81166006)(2906002)(478600001)(316002)(7696005)(336012)(4326008)(6636002)(426003)(70206006)(2616005)(26005)(356004)(70586007)(186003)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3444; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c66a561-8554-4f72-5513-08d7bc17dc73
X-MS-TrafficTypeDiagnostic: BN8PR12MB3444:
X-Microsoft-Antispam-PRVS: <BN8PR12MB344477DD52BEB3EDDB8455C3E5E80@BN8PR12MB3444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-Forefront-PRVS: 0327618309
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCcM4dtLY1qpdVGEat8AsePQFT2L94W8bzJlu2zj+DLIZ697ctbbzebS3S87ILLOHKf4fcWp5mZfK5b+nUbKI6hV/4YmGVwaBtqYoUVBWA3MgD/MEXF/nEOo4sgmQ1WXJp2hMZj6J9VGKRvT/OrMYDEmoZJfw7+IyJJVwAsLS+UCAYkW90/DAA7M6lT+EVwUxeojx32vsdTDP1RnV+7MaUAOae3qXQihW0y+n2DqithEK7lXpYZc0pVynsLGNe74CC01gwfPPUHWZZqo+ZDqd2L49V8fVMXnaTH+WFErcgUHwqNmv1+cbvUHqOveEOoFFSMaqk/YMdlwZgbMvMatqS5NJBZDbpgbl8OuwLoUjnlYrZqD7gEpL/2HYhEtm6FGnPL+CtMiBkbn/6V4FzVrRW1IMyu0RL/Z11eLdPTUJOkAh42m5w25cEPGeAkme7xJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 06:31:36.0860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c66a561-8554-4f72-5513-08d7bc17dc73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3444
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The TDR will be randomly failed due to compute ring
test failure. If the compute ring wptr & 0x7ff(ring_buf_mask)
is 0x100 then after map mqd the compute ring rptr will be
synced with 0x100. And the ring test packet size is also 0x100.
Then after invocation of amdgpu_ring_commit, the cp will not
really handle the packet on the ring buffer because rptr is equal to wptr.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 44f00ecea322..5df1a6d45457 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3508,6 +3508,7 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
+		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4135e4126e82..ac22490e8656 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3664,6 +3664,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		/* reset ring buffer */
 		ring->wptr = 0;
+		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
 	} else {
 		amdgpu_ring_clear_ring(ring);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
